--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: developers; Type: TABLE; Schema: public; Owner: maram
--

CREATE TABLE public.developers (
    developer_id integer NOT NULL,
    developer_name character varying(255),
    developer_specialist character varying(255)
);


ALTER TABLE public.developers OWNER TO maram;

--
-- Name: developers_developer_id_seq; Type: SEQUENCE; Schema: public; Owner: maram
--

CREATE SEQUENCE public.developers_developer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.developers_developer_id_seq OWNER TO maram;

--
-- Name: developers_developer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maram
--

ALTER SEQUENCE public.developers_developer_id_seq OWNED BY public.developers.developer_id;


--
-- Name: student; Type: TABLE; Schema: public; Owner: maram
--

CREATE TABLE public.student (
    student_id integer NOT NULL,
    student_branch character varying(255),
    student_email character varying(255),
    student_name character varying(255)
);


ALTER TABLE public.student OWNER TO maram;

--
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: public; Owner: maram
--

CREATE SEQUENCE public.student_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_student_id_seq OWNER TO maram;

--
-- Name: student_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maram
--

ALTER SEQUENCE public.student_student_id_seq OWNED BY public.student.student_id;


--
-- Name: developers developer_id; Type: DEFAULT; Schema: public; Owner: maram
--

ALTER TABLE ONLY public.developers ALTER COLUMN developer_id SET DEFAULT nextval('public.developers_developer_id_seq'::regclass);


--
-- Name: student student_id; Type: DEFAULT; Schema: public; Owner: maram
--

ALTER TABLE ONLY public.student ALTER COLUMN student_id SET DEFAULT nextval('public.student_student_id_seq'::regclass);


--
-- Data for Name: developers; Type: TABLE DATA; Schema: public; Owner: maram
--

COPY public.developers (developer_id, developer_name, developer_specialist) FROM stdin;
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: maram
--

COPY public.student (student_id, student_branch, student_email, student_name) FROM stdin;
1	btech	krish	krishna
3	BCA	sd	ddd
\.


--
-- Name: developers_developer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maram
--

SELECT pg_catalog.setval('public.developers_developer_id_seq', 1, false);


--
-- Name: student_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maram
--

SELECT pg_catalog.setval('public.student_student_id_seq', 3, true);


--
-- Name: developers developers_pkey; Type: CONSTRAINT; Schema: public; Owner: maram
--

ALTER TABLE ONLY public.developers
    ADD CONSTRAINT developers_pkey PRIMARY KEY (developer_id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: maram
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- PostgreSQL database dump complete
--

