--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Homebrew)
-- Dumped by pg_dump version 16.4

-- Started on 2025-06-24 15:09:38 CEST

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17419)
-- Name: movie_summary; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.movie_summary (
    tconst text NOT NULL,
    title text,
    year integer,
    length integer,
    genres text,
    titletype text,
    isadult boolean,
    averagerating double precision,
    numvotes integer,
    directors text,
    writers text,
    main_cast text
);


ALTER TABLE public.movie_summary OWNER TO debojyotimishra;

--
-- TOC entry 215 (class 1259 OID 17215)
-- Name: name_basics; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.name_basics (
    nconst character varying(10) NOT NULL,
    primaryname text,
    birthyear integer,
    deathyear integer,
    primaryprofession text,
    knownfortitles text
);


ALTER TABLE public.name_basics OWNER TO debojyotimishra;

--
-- TOC entry 223 (class 1259 OID 17428)
-- Name: series_summary; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.series_summary (
    tconst text NOT NULL,
    title text,
    startyear integer,
    endyear integer,
    runtimeminutes integer,
    genres text,
    titletype text,
    isadult boolean,
    averagerating double precision,
    numvotes integer,
    totalseasons integer,
    main_cast text
);


ALTER TABLE public.series_summary OWNER TO debojyotimishra;

--
-- TOC entry 216 (class 1259 OID 17220)
-- Name: title_akas; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.title_akas (
    titleid character varying(10) NOT NULL,
    ordering integer NOT NULL,
    title text NOT NULL,
    region text,
    language text,
    types text,
    attributes text,
    isoriginaltitle boolean
);


ALTER TABLE public.title_akas OWNER TO debojyotimishra;

--
-- TOC entry 217 (class 1259 OID 17225)
-- Name: title_basics; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.title_basics (
    tconst character varying(10) NOT NULL,
    titletype text NOT NULL,
    primarytitle text NOT NULL,
    originaltitle text NOT NULL,
    isadult boolean NOT NULL,
    startyear integer,
    endyear integer,
    runtimeminutes integer,
    genres text
);


ALTER TABLE public.title_basics OWNER TO debojyotimishra;

--
-- TOC entry 218 (class 1259 OID 17230)
-- Name: title_crew; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.title_crew (
    tconst character varying(10) NOT NULL,
    directors text,
    writers text
);


ALTER TABLE public.title_crew OWNER TO debojyotimishra;

--
-- TOC entry 219 (class 1259 OID 17235)
-- Name: title_episode; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.title_episode (
    tconst character varying(10) NOT NULL,
    parenttconst character varying(10),
    seasonnumber integer,
    episodenumber integer
);


ALTER TABLE public.title_episode OWNER TO debojyotimishra;

--
-- TOC entry 220 (class 1259 OID 17238)
-- Name: title_principals; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.title_principals (
    tconst character varying(10) NOT NULL,
    ordering integer NOT NULL,
    nconst character varying(10),
    category text,
    job text,
    characters text
);


ALTER TABLE public.title_principals OWNER TO debojyotimishra;

--
-- TOC entry 221 (class 1259 OID 17243)
-- Name: title_ratings; Type: TABLE; Schema: public; Owner: debojyotimishra
--

CREATE TABLE public.title_ratings (
    tconst character varying(10) NOT NULL,
    averagerating numeric(3,1),
    numvotes integer
);


ALTER TABLE public.title_ratings OWNER TO debojyotimishra;

--
-- TOC entry 3564 (class 2606 OID 17425)
-- Name: movie_summary movie_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.movie_summary
    ADD CONSTRAINT movie_summary_pkey PRIMARY KEY (tconst);


--
-- TOC entry 3544 (class 2606 OID 17341)
-- Name: name_basics name_basics_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.name_basics
    ADD CONSTRAINT name_basics_pkey PRIMARY KEY (nconst);


--
-- TOC entry 3566 (class 2606 OID 17434)
-- Name: series_summary series_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.series_summary
    ADD CONSTRAINT series_summary_pkey PRIMARY KEY (tconst);


--
-- TOC entry 3546 (class 2606 OID 17343)
-- Name: title_akas title_akas_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_akas
    ADD CONSTRAINT title_akas_pkey PRIMARY KEY (titleid, ordering);


--
-- TOC entry 3549 (class 2606 OID 17345)
-- Name: title_basics title_basics_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_basics
    ADD CONSTRAINT title_basics_pkey PRIMARY KEY (tconst);


--
-- TOC entry 3552 (class 2606 OID 17347)
-- Name: title_crew title_crew_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_crew
    ADD CONSTRAINT title_crew_pkey PRIMARY KEY (tconst);


--
-- TOC entry 3555 (class 2606 OID 17349)
-- Name: title_episode title_episode_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_episode
    ADD CONSTRAINT title_episode_pkey PRIMARY KEY (tconst);


--
-- TOC entry 3559 (class 2606 OID 17351)
-- Name: title_principals title_principals_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_principals
    ADD CONSTRAINT title_principals_pkey PRIMARY KEY (tconst, ordering);


--
-- TOC entry 3562 (class 2606 OID 17356)
-- Name: title_ratings title_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_ratings
    ADD CONSTRAINT title_ratings_pkey PRIMARY KEY (tconst);


--
-- TOC entry 3542 (class 1259 OID 17405)
-- Name: idx_name_basics_nconst; Type: INDEX; Schema: public; Owner: debojyotimishra
--

CREATE INDEX idx_name_basics_nconst ON public.name_basics USING btree (nconst);


--
-- TOC entry 3547 (class 1259 OID 17400)
-- Name: idx_title_basics_tconst; Type: INDEX; Schema: public; Owner: debojyotimishra
--

CREATE INDEX idx_title_basics_tconst ON public.title_basics USING btree (tconst);


--
-- TOC entry 3550 (class 1259 OID 17402)
-- Name: idx_title_crew_tconst; Type: INDEX; Schema: public; Owner: debojyotimishra
--

CREATE INDEX idx_title_crew_tconst ON public.title_crew USING btree (tconst);


--
-- TOC entry 3553 (class 1259 OID 17444)
-- Name: idx_title_episode_parent; Type: INDEX; Schema: public; Owner: debojyotimishra
--

CREATE INDEX idx_title_episode_parent ON public.title_episode USING btree (parenttconst);


--
-- TOC entry 3556 (class 1259 OID 17404)
-- Name: idx_title_principals_nconst; Type: INDEX; Schema: public; Owner: debojyotimishra
--

CREATE INDEX idx_title_principals_nconst ON public.title_principals USING btree (nconst);


--
-- TOC entry 3557 (class 1259 OID 17403)
-- Name: idx_title_principals_tconst; Type: INDEX; Schema: public; Owner: debojyotimishra
--

CREATE INDEX idx_title_principals_tconst ON public.title_principals USING btree (tconst);


--
-- TOC entry 3560 (class 1259 OID 17401)
-- Name: idx_title_ratings_tconst; Type: INDEX; Schema: public; Owner: debojyotimishra
--

CREATE INDEX idx_title_ratings_tconst ON public.title_ratings USING btree (tconst);


--
-- TOC entry 3567 (class 2606 OID 17357)
-- Name: title_akas title_akas_titleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_akas
    ADD CONSTRAINT title_akas_titleid_fkey FOREIGN KEY (titleid) REFERENCES public.title_basics(tconst);


--
-- TOC entry 3568 (class 2606 OID 17362)
-- Name: title_crew title_crew_tconst_fkey; Type: FK CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_crew
    ADD CONSTRAINT title_crew_tconst_fkey FOREIGN KEY (tconst) REFERENCES public.title_basics(tconst);


--
-- TOC entry 3569 (class 2606 OID 17367)
-- Name: title_episode title_episode_parenttconst_fkey; Type: FK CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_episode
    ADD CONSTRAINT title_episode_parenttconst_fkey FOREIGN KEY (parenttconst) REFERENCES public.title_basics(tconst);


--
-- TOC entry 3570 (class 2606 OID 17372)
-- Name: title_episode title_episode_tconst_fkey; Type: FK CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_episode
    ADD CONSTRAINT title_episode_tconst_fkey FOREIGN KEY (tconst) REFERENCES public.title_basics(tconst);


--
-- TOC entry 3571 (class 2606 OID 17377)
-- Name: title_principals title_principals_nconst_fkey; Type: FK CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_principals
    ADD CONSTRAINT title_principals_nconst_fkey FOREIGN KEY (nconst) REFERENCES public.name_basics(nconst);


--
-- TOC entry 3572 (class 2606 OID 17382)
-- Name: title_principals title_principals_tconst_fkey; Type: FK CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_principals
    ADD CONSTRAINT title_principals_tconst_fkey FOREIGN KEY (tconst) REFERENCES public.title_basics(tconst);


--
-- TOC entry 3573 (class 2606 OID 17387)
-- Name: title_ratings title_ratings_tconst_fkey; Type: FK CONSTRAINT; Schema: public; Owner: debojyotimishra
--

ALTER TABLE ONLY public.title_ratings
    ADD CONSTRAINT title_ratings_tconst_fkey FOREIGN KEY (tconst) REFERENCES public.title_basics(tconst);


-- Completed on 2025-06-24 15:09:39 CEST

--
-- PostgreSQL database dump complete
--

