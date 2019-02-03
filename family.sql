--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: members; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.members AS (
	ifkmembercode bigint,
	firstname text,
	surname text
);


ALTER TYPE public.members OWNER TO postgres;

--
-- Name: t_familymember; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.t_familymember AS (
	ipkmemberid integer,
	firstname character varying(200),
	surname character varying(100),
	middlename character varying(200),
	gender character varying(100),
	dateofbirth timestamp with time zone,
	nationalid bigint,
	pictureid bigint
);


ALTER TYPE public.t_familymember OWNER TO postgres;

--
-- Name: getgrandparents(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getgrandparents(memberid integer) RETURNS TABLE(grandparent_ifkmember_code integer, grandparent_first_name character varying, grandparent_sur_name character varying, grandparent_middle_name character varying, grandparent_gender character varying, member_code bigint)
    LANGUAGE plpgsql
    AS $$
  declare    _memberid integer;  
  begin
 
     for  _memberid
	 in select parent_ifkmember_code from  GetParents(memberid)	 
	 loop
	 return query
	 select * from GetParents(_memberid);
	 end loop;
		 
 end;
 $$;


ALTER FUNCTION public.getgrandparents(memberid integer) OWNER TO postgres;

--
-- Name: getparents(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getparents(memberid integer) RETURNS TABLE(parent_ifkmember_code integer, parent_first_name character varying, parent_sur_name character varying, parent_middle_name character varying, parent_gender character varying, member_code bigint)
    LANGUAGE plpgsql
    AS $$
  begin
 return query 
 select  ipkmembercode,firstname,surname,middlename,gender,relation.ifkmemberid  from tblfamilyrelations relation 
 inner join tblfamilymembers members on relation.ifkfatherid = members.ipkmembercode or relation.ifkmotherid
 = members.ipkmembercode
 where  ifkmemberid = memberid;
 
 end;
 $$;


ALTER FUNCTION public.getparents(memberid integer) OWNER TO postgres;

--
-- Name: getsiblings(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getsiblings(memberid integer) RETURNS TABLE(ipkchildcode integer, child_first_name character varying, child_sur_name character varying, child_middle_name character varying, child_gender character varying)
    LANGUAGE plpgsql
    AS $$
  begin
 return query   
     select  distinct ipkmembercode,firstname,surname,middlename,gender   from GetParents(memberid) parents
	 left join  tblfamilyrelations relations on relations.ifkfatherid = parents.parent_ifkmember_code or 
	 relations.ifkmotherid =  parents.parent_ifkmember_code
	 left join  tblfamilymembers members on  members.ipkmembercode = relations.ifkmemberid
	 where ipkmembercode != memberid;
 end;
 $$;


ALTER FUNCTION public.getsiblings(memberid integer) OWNER TO postgres;

--
-- Name: getunclesandaunties(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getunclesandaunties(memberid integer) RETURNS TABLE(uncaunt_ifkmember_code integer, uncaunt_first_name character varying, uncaunt_sur_name character varying, uncaunt_middle_name character varying, uncaunt_gender character varying, member_code integer)
    LANGUAGE plpgsql
    AS $$
  declare    _memberid int;  
  begin
 
     for  _memberid
	 in select parent_ifkmember_code from  GetParents(memberid)	 
	 loop
	 return query
	 select *,_memberid from GetSiblings(_memberid); 
	 end loop;
		 
 end;
 $$;


ALTER FUNCTION public.getunclesandaunties(memberid integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: tblfamilymembers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tblfamilymembers (
    ipkmembercode integer NOT NULL,
    firstname character varying(200),
    surname character varying(100),
    middlename character varying(200),
    gender character varying(100),
    dateofbirth timestamp with time zone,
    nationalid bigint,
    pictureid bigint,
    username character varying(200),
    password character varying(200)
);


ALTER TABLE public.tblfamilymembers OWNER TO postgres;

--
-- Name: sp_getparents(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_getparents(membercode integer) RETURNS SETOF public.tblfamilymembers
    LANGUAGE plpgsql
    AS $$
    BEGIN
       select * from tblfamilymembers;
    END;
    $$;


ALTER FUNCTION public.sp_getparents(membercode integer) OWNER TO postgres;

--
-- Name: tblfamilymembers_ipkmembercode_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tblfamilymembers_ipkmembercode_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tblfamilymembers_ipkmembercode_seq OWNER TO postgres;

--
-- Name: tblfamilymembers_ipkmembercode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tblfamilymembers_ipkmembercode_seq OWNED BY public.tblfamilymembers.ipkmembercode;


--
-- Name: tblfamilyrelations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tblfamilyrelations (
    ipkrelationid integer NOT NULL,
    ifkmemberid bigint,
    ifkfatherid bigint,
    ifkmotherid bigint
);


ALTER TABLE public.tblfamilyrelations OWNER TO postgres;

--
-- Name: tblfamilyrelations_ipkrelationid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tblfamilyrelations_ipkrelationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tblfamilyrelations_ipkrelationid_seq OWNER TO postgres;

--
-- Name: tblfamilyrelations_ipkrelationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tblfamilyrelations_ipkrelationid_seq OWNED BY public.tblfamilyrelations.ipkrelationid;


--
-- Name: tblfamilymembers ipkmembercode; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tblfamilymembers ALTER COLUMN ipkmembercode SET DEFAULT nextval('public.tblfamilymembers_ipkmembercode_seq'::regclass);


--
-- Name: tblfamilyrelations ipkrelationid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tblfamilyrelations ALTER COLUMN ipkrelationid SET DEFAULT nextval('public.tblfamilyrelations_ipkrelationid_seq'::regclass);


--
-- Data for Name: tblfamilymembers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tblfamilymembers (ipkmembercode, firstname, surname, middlename, gender, dateofbirth, nationalid, pictureid, username, password) FROM stdin;
1	Wilson	Mutai	Kiprono	MALE	1965-12-12 10:00:00+03	434343	1	wilson	9222
2	Happiness	Mutai	Elinansha	FEMALE	1970-12-12 10:10:00+03	1212121	\N	mom	mom
3	Elijah	Cheruyot		MALE	1950-12-12 10:10:00+02:45	34343	\N	elijah	elijah
4	Welsly	Cheruyot		MALE	1945-12-12 10:10:00+02:45	343	\N	Welsly	Welsly
5	Samuel	Cheruyot		MALE	1955-12-12 10:10:00+02:45	343	\N	Samuel	Samuel
6	Annah	Cheruyot		FEMALE	1955-12-12 10:10:00+02:45	334343	\N	Annah	Annah
7	Elizabeth	Cheruyot		FEMALE	1959-12-12 10:10:00+02:45	334343	\N	Elizabeth	Elizabeth
8	Sarah	Cheruyot		FEMALE	1965-12-12 10:10:00+03	344433	\N	Sarah	Sarah
9	Raymond	Mutai		MALE	1970-12-12 10:10:00+03	3463433	\N	Raymond	Raymond
10	David	Mutai		MALE	1960-12-12 10:10:00+03	3463433	\N	David	Raymond
11	Robert	Mutai		MALE	1975-12-12 10:10:00+03	3463121	\N	Robert	Robert
12	Elizabeth	Rono		FEMALE	1965-12-12 10:10:00+03	343652	\N	Elizabeth	Elizabeth
13	Beatrice	Mutai		FEMALE	1975-12-12 10:10:00+03	343652	\N	Beatrice	Beatrice
14	Vincent	Mutai		MALE	1985-12-12 10:10:00+03	3432	\N	Vincent	Vincent
15	Joyce	Mutai		FEMALE	1988-12-12 10:10:00+03	3432	\N	Joyce	Joyce
16	Collins	n/a	n/a	MALE	1994-12-12 10:10:00+03	56	\N	Collins	Collins
18	N/A	n/a	Kiprop	MALE	2000-12-12 10:10:00+03	56	\N	kiprop	kiprop
19	Emmanuel	Rono	Mutai	MALE	1997-12-12 10:10:00+03	56565	\N	Emmanuel	Emmanuel
20	Faith	Rono	Mutai	FEMALE	2004-12-12 10:10:00+03	56565	\N	Faith	Faith
21	Anthony	Rono	Kiprotich	MALE	1992-12-14 18:10:00+03	56565	\N	Anthony	Anthony
22	Bwana Ephrahim	nkya	Lema	MALE	1950-12-12 10:00:00+02:45	23254	\N	NKYA	NKYA
23	bibi nyanya	nkya	n/a	FEMALE	1960-12-12 10:00:00+03	232564	\N	NYANYA	NYANYA
24	Tiksaeli  fofo	nkya	n/a	FEMALE	1980-12-12 10:00:00+03	2323	\N	Tiksaeli	Tiksaeli
25	Tasi  fofo	nkya	n/a	FEMALE	1975-12-12 10:00:00+03	2323	\N	Tasi	Tasi
17	Faith	n/a	n/a	FEMALE	2000-12-12 10:10:00+03	56	\N	Faith2	Faith2
\.


--
-- Data for Name: tblfamilyrelations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tblfamilyrelations (ipkrelationid, ifkmemberid, ifkfatherid, ifkmotherid) FROM stdin;
1	21	1	2
2	19	1	2
3	20	1	2
4	1	4	6
5	12	4	6
6	13	4	6
7	14	4	6
8	15	4	6
9	2	22	23
10	24	22	23
11	25	22	23
\.


--
-- Name: tblfamilymembers_ipkmembercode_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tblfamilymembers_ipkmembercode_seq', 25, true);


--
-- Name: tblfamilyrelations_ipkrelationid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tblfamilyrelations_ipkrelationid_seq', 11, true);


--
-- Name: tblfamilymembers tblfamilymembers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tblfamilymembers
    ADD CONSTRAINT tblfamilymembers_pkey PRIMARY KEY (ipkmembercode);


--
-- PostgreSQL database dump complete
--

