--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: student; Type: TABLE; Schema: public; Owner: maram; Tablespace: 
--

CREATE TABLE student (
    student_id integer NOT NULL,
    student_branch character varying(255),
    student_email character varying(255),
    student_name character varying(255)
);


ALTER TABLE public.student OWNER TO maram;

--
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: public; Owner: maram
--

CREATE SEQUENCE student_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_student_id_seq OWNER TO maram;

--
-- Name: student_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maram
--

ALTER SEQUENCE student_student_id_seq OWNED BY student.student_id;


--
-- Name: student_id; Type: DEFAULT; Schema: public; Owner: maram
--

ALTER TABLE ONLY student ALTER COLUMN student_id SET DEFAULT nextval('student_student_id_seq'::regclass);


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: maram
--

COPY student (student_id, student_branch, student_email, student_name) FROM stdin;
1	B-Tech	krishnamaram4@gmail.com	krishna
\.


--
-- Name: student_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maram
--

SELECT pg_catalog.setval('student_student_id_seq', 5, true);


--
-- Name: student_pkey; Type: CONSTRAINT; Schema: public; Owner: maram; Tablespace: 
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

