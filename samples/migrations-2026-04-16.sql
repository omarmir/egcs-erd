--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: Entity_Type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Entity_Type" AS ENUM (
    'fundingopportunity',
    'fundingcaseintake',
    'fundingcaseagreement',
    'applicantrecipient',
    'transferpaymentstream',
    'commonreview',
    'commonrecommendation',
    'fundingcaseamendment',
    'fundingcasemonitor',
    'fundingclaimreconcile',
    'fundingcaseforecast',
    'fundingcasepayment',
    'fundingcaserecommendation'
);


ALTER TYPE public."Entity_Type" OWNER TO postgres;

--
-- Name: Language_Preference; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Language_Preference" AS ENUM (
    'eng',
    'fra'
);


ALTER TYPE public."Language_Preference" OWNER TO postgres;

--
-- Name: Monitor_Action_Type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Monitor_Action_Type" AS ENUM (
    'amendment',
    'mandatoryaction',
    'suggestedaction',
    'none'
);


ALTER TYPE public."Monitor_Action_Type" OWNER TO postgres;

--
-- Name: Monitor_Responsible_Party; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Monitor_Responsible_Party" AS ENUM (
    'applicantrecipient',
    'organization',
    'joint'
);


ALTER TYPE public."Monitor_Responsible_Party" OWNER TO postgres;

--
-- Name: Review_Type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Review_Type" AS ENUM (
    'checklist',
    'assessment'
);


ALTER TYPE public."Review_Type" OWNER TO postgres;

--
-- Name: agreement_applicant_recipient_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.agreement_applicant_recipient_type AS ENUM (
    'guarantor',
    'obligant',
    'consultant',
    'partner'
);


ALTER TYPE public.agreement_applicant_recipient_type OWNER TO postgres;

--
-- Name: agreement_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.agreement_type AS ENUM (
    'grant',
    'nonrepayable',
    'repayable',
    'partiallyrepayable',
    'other'
);


ALTER TYPE public.agreement_type OWNER TO postgres;

--
-- Name: amended_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.amended_type AS ENUM (
    'articles',
    'activities',
    'budget',
    'duration',
    'other'
);


ALTER TYPE public.amended_type OWNER TO postgres;

--
-- Name: applicant_recipient_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.applicant_recipient_type AS ENUM (
    'aboriginalrecipients',
    'forprofitorganizations',
    'government',
    'internationalnongov',
    'notforprofitorganizationsandcharities',
    'other',
    'individualorsoleproprietorships',
    'academia'
);


ALTER TYPE public.applicant_recipient_type OWNER TO postgres;

--
-- Name: approval_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.approval_status AS ENUM (
    'draft',
    'pendingapproval',
    'approved',
    'denied'
);


ALTER TYPE public.approval_status OWNER TO postgres;

--
-- Name: base_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.base_status AS ENUM (
    'draft',
    'active',
    'inactive'
);


ALTER TYPE public.base_status OWNER TO postgres;

--
-- Name: commitment_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.commitment_type AS ENUM (
    'commitment',
    'paye',
    'paye2',
    'pyp'
);


ALTER TYPE public.commitment_type OWNER TO postgres;

--
-- Name: countries; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.countries AS ENUM (
    'ad',
    'ae',
    'af',
    'ag',
    'ai',
    'al',
    'am',
    'ao',
    'aq',
    'ar',
    'as',
    'at',
    'au',
    'aw',
    'ax',
    'az',
    'ba',
    'bb',
    'bd',
    'be',
    'bf',
    'bg',
    'bh',
    'bi',
    'bj',
    'bl',
    'bm',
    'bn',
    'bo',
    'bq',
    'br',
    'bs',
    'bt',
    'bv',
    'bw',
    'by',
    'bz',
    'ca',
    'cc',
    'cd',
    'cf',
    'cg',
    'ch',
    'ci',
    'ck',
    'cl',
    'cm',
    'cn',
    'co',
    'cr',
    'cu',
    'cv',
    'cw',
    'cx',
    'cy',
    'cz',
    'de',
    'dj',
    'dk',
    'dm',
    'do',
    'dz',
    'ec',
    'ee',
    'eg',
    'eh',
    'er',
    'es',
    'et',
    'fi',
    'fj',
    'fk',
    'fm',
    'fo',
    'fr',
    'ga',
    'gb',
    'gd',
    'ge',
    'gf',
    'gg',
    'gh',
    'gi',
    'gl',
    'gm',
    'gn',
    'gp',
    'gq',
    'gr',
    'gs',
    'gt',
    'gu',
    'gw',
    'gy',
    'hk',
    'hm',
    'hn',
    'hr',
    'ht',
    'hu',
    'id',
    'ie',
    'il',
    'im',
    'in',
    'io',
    'iq',
    'ir',
    'is',
    'it',
    'je',
    'jm',
    'jo',
    'jp',
    'ke',
    'kg',
    'kh',
    'ki',
    'km',
    'kn',
    'kp',
    'kr',
    'kw',
    'ky',
    'kz',
    'la',
    'lb',
    'lc',
    'li',
    'lk',
    'lr',
    'ls',
    'lt',
    'lu',
    'lv',
    'ly',
    'ma',
    'mc',
    'md',
    'me',
    'mf',
    'mg',
    'mh',
    'mk',
    'ml',
    'mm',
    'mn',
    'mo',
    'mp',
    'mq',
    'mr',
    'ms',
    'mt',
    'mu',
    'mv',
    'mw',
    'mx',
    'my',
    'mz',
    'na',
    'nc',
    'ne',
    'nf',
    'ng',
    'ni',
    'nl',
    'no',
    'np',
    'nr',
    'nu',
    'nz',
    'om',
    'pa',
    'pe',
    'pf',
    'pg',
    'ph',
    'pk',
    'pl',
    'pm',
    'pn',
    'pr',
    'ps',
    'pt',
    'pw',
    'py',
    'qa',
    're',
    'ro',
    'rs',
    'ru',
    'rw',
    'sa',
    'sb',
    'sc',
    'sd',
    'se',
    'sg',
    'sh',
    'si',
    'sj',
    'sk',
    'sl',
    'sm',
    'sn',
    'so',
    'sr',
    'ss',
    'st',
    'sv',
    'sx',
    'sy',
    'sz',
    'tc',
    'td',
    'tf',
    'tg',
    'th',
    'tj',
    'tk',
    'tl',
    'tm',
    'tn',
    'to',
    'tr',
    'tt',
    'tv',
    'tw',
    'tz',
    'ua',
    'ug',
    'um',
    'us',
    'uy',
    'uz',
    'va',
    'vc',
    've',
    'vg',
    'vi',
    'vn',
    'vu',
    'wf',
    'ws',
    'ye',
    'yt',
    'za',
    'zm',
    'zw'
);


ALTER TYPE public.countries OWNER TO postgres;

--
-- Name: currency_codes; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.currency_codes AS ENUM (
    'all',
    'amd',
    'ang',
    'aoa',
    'ars',
    'aud',
    'awg',
    'azn',
    'bam',
    'bbd',
    'bdt',
    'bgn',
    'bhd',
    'bif',
    'bnd',
    'bob',
    'bov',
    'brl',
    'bsd',
    'btn',
    'bwp',
    'byr',
    'bzd',
    'cad',
    'cdf',
    'chf',
    'clf',
    'clp',
    'cny',
    'cop',
    'crc',
    'cuc',
    'cve',
    'czk',
    'djf',
    'dkk',
    'dop',
    'dzd',
    'egp',
    'ern',
    'etb',
    'eur',
    'fjd',
    'gbp',
    'gel',
    'gip',
    'gmd',
    'gnf',
    'gtq',
    'gyd',
    'hkd',
    'hnl',
    'hrk',
    'htg',
    'huf',
    'idr',
    'ils',
    'inr',
    'iqd',
    'irr',
    'isk',
    'jmd',
    'jod',
    'jpy',
    'kes',
    'kgs',
    'khr',
    'kmf',
    'krw',
    'kwd',
    'kyd',
    'kzt',
    'lak',
    'lbp',
    'lrd',
    'lsl',
    'lyd',
    'mga',
    'mkd',
    'mop',
    'mur',
    'mvr',
    'mwk',
    'myr',
    'nok',
    'nzd',
    'svc',
    'usd',
    'xaf',
    'xcd',
    'xdr',
    'xof',
    'xpf',
    'zar'
);


ALTER TYPE public.currency_codes OWNER TO postgres;

--
-- Name: decision_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.decision_type AS ENUM (
    'fundingcaseintakeassessment'
);


ALTER TYPE public.decision_type OWNER TO postgres;

--
-- Name: follow_up_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.follow_up_status AS ENUM (
    'open',
    'onhold',
    'completed',
    'cancelled',
    'unabletocomplete'
);


ALTER TYPE public.follow_up_status OWNER TO postgres;

--
-- Name: jurisdiction; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.jurisdiction AS ENUM (
    'ab',
    'bc',
    'mb',
    'nb',
    'nl',
    'ns',
    'nt',
    'nu',
    'on',
    'pe',
    'qc',
    'sk',
    'yt'
);


ALTER TYPE public.jurisdiction OWNER TO postgres;

--
-- Name: language_preference; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.language_preference AS ENUM (
    'eng',
    'fra'
);


ALTER TYPE public.language_preference OWNER TO postgres;

--
-- Name: payment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status AS ENUM (
    'draft',
    'pendingsignature',
    'signed',
    'inprocess',
    'pay',
    'wait',
    'denied',
    'processed',
    'paid'
);


ALTER TYPE public.payment_status OWNER TO postgres;

--
-- Name: payment_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_type AS ENUM (
    'reimbursement',
    'advance'
);


ALTER TYPE public.payment_type OWNER TO postgres;

--
-- Name: statuses; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.statuses AS ENUM (
    'draft',
    'inprogress',
    'submitted',
    'reviewed',
    'pendingapproval',
    'approved',
    'active',
    'denied',
    'withdrawn',
    'inreview',
    'cancelled',
    'inactive',
    'complete'
);


ALTER TYPE public.statuses OWNER TO postgres;

--
-- Name: register_entity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.register_entity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      allocated_id bigint;
    BEGIN
      INSERT INTO "Common_Entity" (egcs_cn_entitytype)
      VALUES (TG_ARGV[0]::"Entity_Type")
      RETURNING id INTO allocated_id;

      NEW.id := allocated_id;
      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.register_entity() OWNER TO postgres;

--
-- Name: trg_fn_autopopulate_self_approval(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_autopopulate_self_approval() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      user_position_title text;
    BEGIN
      IF NEW.egcs_cn_approvalvalue IS NULL OR OLD.egcs_cn_approvalvalue IS NOT NULL THEN
        RETURN NEW;
      END IF;

      IF NEW.egcs_cn_defaultuser <> NEW.egcs_cn_assigneduser THEN
        RETURN NEW;
      END IF;

      SELECT egcs_cn_position_title INTO user_position_title
      FROM "Common_User"
      WHERE id = NEW.egcs_cn_assigneduser;

      NEW.egcs_cn_approvaldate := NOW();
      NEW.egcs_cn_approvalpositiontitle := user_position_title;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_autopopulate_self_approval() OWNER TO postgres;

--
-- Name: trg_fn_cascade_routingslip_status(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_cascade_routingslip_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      total_steps integer;
      approved_steps integer;
      denied_steps integer;
    BEGIN
      SELECT
        COUNT(*),
        COUNT(*) FILTER (WHERE egcs_cn_approvalvalue = true),
        COUNT(*) FILTER (WHERE egcs_cn_approvalvalue = false)
      INTO total_steps, approved_steps, denied_steps
      FROM "Common_Approval"
      WHERE egcs_cn_routingslip = NEW.egcs_cn_routingslip;

      IF denied_steps > 0 THEN
        UPDATE "Common_Routing_Slip"
        SET egcs_cn_status = 'denied'
        WHERE id = NEW.egcs_cn_routingslip;
      ELSIF total_steps > 0 AND approved_steps = total_steps THEN
        UPDATE "Common_Routing_Slip"
        SET egcs_cn_status = 'approved'
        WHERE id = NEW.egcs_cn_routingslip;
      ELSIF approved_steps > 0 THEN
        UPDATE "Common_Routing_Slip"
        SET egcs_cn_status = 'pendingapproval'
        WHERE id = NEW.egcs_cn_routingslip
          AND egcs_cn_status = 'draft';
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_cascade_routingslip_status() OWNER TO postgres;

--
-- Name: trg_fn_enforce_approval_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_enforce_approval_sequence() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      incomplete_prior integer;
    BEGIN
      IF NEW.egcs_cn_approvalvalue IS NULL OR OLD.egcs_cn_approvalvalue IS NOT NULL THEN
        RETURN NEW;
      END IF;

      SELECT COUNT(*) INTO incomplete_prior
      FROM "Common_Approval"
      WHERE egcs_cn_routingslip = NEW.egcs_cn_routingslip
        AND egcs_cn_sequence < NEW.egcs_cn_sequence
        AND egcs_cn_approvalvalue IS DISTINCT FROM true;

      IF incomplete_prior > 0 THEN
        RAISE EXCEPTION 'Cannot action approval %: % prior step(s) are incomplete or denied',
          NEW.id, incomplete_prior;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_enforce_approval_sequence() OWNER TO postgres;

--
-- Name: trg_fn_enforce_assigned_user_actions(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_enforce_assigned_user_actions() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      session_user_id bigint;
    BEGIN
      IF NEW.egcs_cn_approvalvalue IS NOT DISTINCT FROM OLD.egcs_cn_approvalvalue THEN
        RETURN NEW;
      END IF;

      session_user_id := NULLIF(current_setting('app.current_user_id', true), '')::bigint;
      IF session_user_id IS NULL OR session_user_id <> NEW.egcs_cn_assigneduser THEN
        RAISE EXCEPTION 'Only the assigned user may action approval %', NEW.id;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_enforce_assigned_user_actions() OWNER TO postgres;

--
-- Name: trg_fn_enforce_completion_audit_fields(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_enforce_completion_audit_fields() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      IF NEW.egcs_cn_value IS DISTINCT FROM true THEN
        RAISE EXCEPTION 'Completion rows must store egcs_cn_value = true';
      END IF;

      IF TG_OP = 'UPDATE' THEN
        IF OLD.egcs_cn_value = true THEN
          IF NEW.egcs_cn_user IS DISTINCT FROM OLD.egcs_cn_user THEN
            RAISE EXCEPTION 'Completion user cannot be changed after completion';
          END IF;

          IF NEW.egcs_cn_value IS DISTINCT FROM OLD.egcs_cn_value THEN
            RAISE EXCEPTION 'Completion value cannot be changed after completion';
          END IF;

          IF NEW.egcs_cn_completedat IS DISTINCT FROM OLD.egcs_cn_completedat THEN
            RAISE EXCEPTION 'Completion timestamp cannot be changed after completion';
          END IF;
        END IF;
      END IF;

      IF TG_OP = 'INSERT' THEN
        IF NEW.egcs_cn_value = true THEN
          NEW.egcs_cn_completedat := NOW();
        END IF;
      ELSIF TG_OP = 'UPDATE' THEN
        IF OLD.egcs_cn_value IS DISTINCT FROM true AND NEW.egcs_cn_value IS DISTINCT FROM OLD.egcs_cn_value THEN
          NEW.egcs_cn_completedat := NOW();
        END IF;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_enforce_completion_audit_fields() OWNER TO postgres;

--
-- Name: trg_fn_lock_actioned_approval(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_lock_actioned_approval() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      IF OLD.egcs_cn_approvalvalue IS NOT NULL THEN
        RAISE EXCEPTION 'Cannot modify approval %: already actioned with value %',
          OLD.id, OLD.egcs_cn_approvalvalue;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_lock_actioned_approval() OWNER TO postgres;

--
-- Name: trg_fn_lock_approval_on_terminal_slip(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_lock_approval_on_terminal_slip() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      slip_status Approval_Status;
    BEGIN
      SELECT egcs_cn_status INTO slip_status
      FROM "Common_Routing_Slip"
      WHERE id = NEW.egcs_cn_routingslip;

      IF slip_status IN ('approved', 'denied') THEN
        RAISE EXCEPTION 'Cannot modify approval %: routing slip % is in terminal state %',
          OLD.id, NEW.egcs_cn_routingslip, slip_status;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_lock_approval_on_terminal_slip() OWNER TO postgres;

--
-- Name: trg_fn_require_actual_delegation_detail(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_require_actual_delegation_detail() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      requires_actual boolean;
    BEGIN
      IF NEW.egcs_cn_approvalvalue IS NULL OR OLD.egcs_cn_approvalvalue IS NOT NULL THEN
        RETURN NEW;
      END IF;

      IF NEW.egcs_cn_onbehalf IS NULL THEN
        RETURN NEW;
      END IF;

      SELECT egcs_ay_require_actual INTO requires_actual
      FROM "Agency_Approval_Behalf_Type"
      WHERE id = NEW.egcs_cn_onbehalf;

      IF requires_actual = true AND (
        NEW.egcs_cn_approvalpositiontitle IS NULL
        OR NEW.egcs_cn_approvaldate IS NULL
      ) THEN
        RAISE EXCEPTION 'Approval % requires full delegation detail (position title, date)',
          NEW.id;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_require_actual_delegation_detail() OWNER TO postgres;

--
-- Name: trg_fn_require_certifications(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_require_certifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      uncertified_count integer;
    BEGIN
      IF NEW.egcs_cn_approvalvalue IS DISTINCT FROM true THEN
        RETURN NEW;
      END IF;

      SELECT COUNT(*) INTO uncertified_count
      FROM "Common_Approval_Certification"
      WHERE egcs_cn_approval = NEW.id
        AND egcs_cn_optional = false
        AND egcs_cn_value IS DISTINCT FROM true;

      IF uncertified_count > 0 THEN
        RAISE EXCEPTION 'Cannot approve %: % non-optional certification(s) not yet attested',
          NEW.id, uncertified_count;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_require_certifications() OWNER TO postgres;

--
-- Name: trg_fn_reset_additional_reviewer_completion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_reset_additional_reviewer_completion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      IF TG_OP = 'UPDATE' AND NEW.egcs_cn_user IS DISTINCT FROM OLD.egcs_cn_user THEN
        NEW.egcs_cn_completedat := NULL;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_reset_additional_reviewer_completion() OWNER TO postgres;

--
-- Name: trg_fn_routingslip_forward_status(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_routingslip_forward_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      status_order integer;
      old_order integer;
    BEGIN
      old_order := CASE OLD.egcs_cn_status::text
        WHEN 'draft' THEN 1
        WHEN 'pendingapproval' THEN 2
        WHEN 'approved' THEN 3
        WHEN 'denied' THEN 4
      END;

      status_order := CASE NEW.egcs_cn_status::text
        WHEN 'draft' THEN 1
        WHEN 'pendingapproval' THEN 2
        WHEN 'approved' THEN 3
        WHEN 'denied' THEN 4
      END;

      IF status_order < old_order THEN
        RAISE EXCEPTION 'Invalid status transition on routing slip %: cannot move from % to %',
          OLD.id, OLD.egcs_cn_status, NEW.egcs_cn_status;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_routingslip_forward_status() OWNER TO postgres;

--
-- Name: trg_fn_validate_added_step_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_fn_validate_added_step_sequence() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      max_actioned_sequence decimal;
    BEGIN
      IF NEW.egcs_cn_isadded = false THEN
        RETURN NEW;
      END IF;

      SELECT MAX(egcs_cn_sequence) INTO max_actioned_sequence
      FROM "Common_Approval"
      WHERE egcs_cn_routingslip = NEW.egcs_cn_routingslip
        AND egcs_cn_approvalvalue IS NOT NULL
      ;

      IF max_actioned_sequence IS NOT NULL AND NEW.egcs_cn_sequence <= max_actioned_sequence THEN
        RAISE EXCEPTION 'Added approval step sequence % must be greater than last actioned sequence %',
          NEW.egcs_cn_sequence, max_actioned_sequence;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION public.trg_fn_validate_added_step_sequence() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Agency_Address_Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agency_Address_Type" (
    id bigint NOT NULL,
    egcs_ay_organizationagency bigint NOT NULL,
    egcs_ay_typename_en character varying(255) NOT NULL,
    egcs_ay_typename_fr character varying(255) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Agency_Address_Type" OWNER TO postgres;

--
-- Name: Agency_Address_Type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agency_Address_Type_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agency_Address_Type_id_seq" OWNER TO postgres;

--
-- Name: Agency_Address_Type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agency_Address_Type_id_seq" OWNED BY public."Agency_Address_Type".id;


--
-- Name: Agency_Agreement_Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agency_Agreement_Type" (
    id bigint NOT NULL,
    egcs_ay_organizationagency bigint NOT NULL,
    egcs_ay_agreementtype public.agreement_type NOT NULL,
    egcs_ay_name_en character varying(255) NOT NULL,
    egcs_ay_name_fr character varying(255) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Agency_Agreement_Type" OWNER TO postgres;

--
-- Name: Agency_Agreement_Type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agency_Agreement_Type_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agency_Agreement_Type_id_seq" OWNER TO postgres;

--
-- Name: Agency_Agreement_Type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agency_Agreement_Type_id_seq" OWNED BY public."Agency_Agreement_Type".id;


--
-- Name: Agency_Applicant_Recipient_Subtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agency_Applicant_Recipient_Subtype" (
    id bigint NOT NULL,
    egcs_ay_applicantrecipienttype public.applicant_recipient_type NOT NULL,
    egcs_ay_organizationagency bigint NOT NULL,
    egcs_ay_description_en text NOT NULL,
    egcs_ay_description_fr text NOT NULL,
    egcs_ay_name_en character varying(255) NOT NULL,
    egcs_ay_name_fr character varying(255) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Agency_Applicant_Recipient_Subtype" OWNER TO postgres;

--
-- Name: Agency_Applicant_Recipient_Subtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agency_Applicant_Recipient_Subtype_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agency_Applicant_Recipient_Subtype_id_seq" OWNER TO postgres;

--
-- Name: Agency_Applicant_Recipient_Subtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agency_Applicant_Recipient_Subtype_id_seq" OWNED BY public."Agency_Applicant_Recipient_Subtype".id;


--
-- Name: Agency_Approval_Behalf_Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agency_Approval_Behalf_Type" (
    id bigint NOT NULL,
    egcs_ay_organizationagency bigint NOT NULL,
    egcs_ay_name_en character varying(255) NOT NULL,
    egcs_ay_name_fr character varying(255) NOT NULL,
    egcs_ay_require_actual boolean NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Agency_Approval_Behalf_Type" OWNER TO postgres;

--
-- Name: Agency_Approval_Behalf_Type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agency_Approval_Behalf_Type_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agency_Approval_Behalf_Type_id_seq" OWNER TO postgres;

--
-- Name: Agency_Approval_Behalf_Type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agency_Approval_Behalf_Type_id_seq" OWNED BY public."Agency_Approval_Behalf_Type".id;


--
-- Name: Agency_Cost_Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agency_Cost_Category" (
    id bigint NOT NULL,
    egcs_ay_organizationagency bigint NOT NULL,
    egcs_ay_name_en character varying(255) NOT NULL,
    egcs_ay_name_fr character varying(255) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Agency_Cost_Category" OWNER TO postgres;

--
-- Name: Agency_Cost_Category_Line_Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agency_Cost_Category_Line_Item" (
    id bigint NOT NULL,
    egcs_ay_name_en character varying(255) NOT NULL,
    egcs_ay_name_fr character varying(255) NOT NULL,
    egcs_ay_organizationcostcategory bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Agency_Cost_Category_Line_Item" OWNER TO postgres;

--
-- Name: Agency_Cost_Category_Line_Item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agency_Cost_Category_Line_Item_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agency_Cost_Category_Line_Item_id_seq" OWNER TO postgres;

--
-- Name: Agency_Cost_Category_Line_Item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agency_Cost_Category_Line_Item_id_seq" OWNED BY public."Agency_Cost_Category_Line_Item".id;


--
-- Name: Agency_Cost_Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agency_Cost_Category_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agency_Cost_Category_id_seq" OWNER TO postgres;

--
-- Name: Agency_Cost_Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agency_Cost_Category_id_seq" OWNED BY public."Agency_Cost_Category".id;


--
-- Name: Agency_Fiscal_Year; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agency_Fiscal_Year" (
    id bigint NOT NULL,
    egcs_ay_organizationagency bigint NOT NULL,
    egcs_ay_fiscalyeardisplay character varying(9) NOT NULL,
    egcs_ay_fiscalyear smallint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Agency_Fiscal_Year" OWNER TO postgres;

--
-- Name: Agency_Fiscal_Year_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agency_Fiscal_Year_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agency_Fiscal_Year_id_seq" OWNER TO postgres;

--
-- Name: Agency_Fiscal_Year_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agency_Fiscal_Year_id_seq" OWNED BY public."Agency_Fiscal_Year".id;


--
-- Name: Agency_Profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Agency_Profile" (
    id bigint NOT NULL,
    egcs_ay_agencyfinancialsystemid bigint NOT NULL,
    egcs_ay_name_en character varying(255) NOT NULL,
    egcs_ay_name_fr character varying(255) NOT NULL,
    egcs_ay_abbreviation_en character varying(255) NOT NULL,
    egcs_ay_abbreviation_fr character varying(255) NOT NULL,
    egcs_ay_status public.base_status NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    egcs_ay_gwcoa_number bigint NOT NULL
);


ALTER TABLE public."Agency_Profile" OWNER TO postgres;

--
-- Name: Agency_Profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Agency_Profile_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Agency_Profile_id_seq" OWNER TO postgres;

--
-- Name: Agency_Profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Agency_Profile_id_seq" OWNED BY public."Agency_Profile".id;


--
-- Name: Applicant_Recipient_Address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Applicant_Recipient_Address" (
    id bigint NOT NULL,
    egcs_ar_applicantrecipient bigint NOT NULL,
    egcs_ar_address bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Applicant_Recipient_Address" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Applicant_Recipient_Address_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Applicant_Recipient_Address_id_seq" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Applicant_Recipient_Address_id_seq" OWNED BY public."Applicant_Recipient_Address".id;


--
-- Name: Applicant_Recipient_Agency_Financial_Id; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Applicant_Recipient_Agency_Financial_Id" (
    id bigint NOT NULL,
    egcs_ar_applicantrecipient bigint NOT NULL,
    egcs_ar_agency bigint,
    egcs_ar_financialsystemid bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Applicant_Recipient_Agency_Financial_Id" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Agency_Financial_Id_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Applicant_Recipient_Agency_Financial_Id_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Applicant_Recipient_Agency_Financial_Id_id_seq" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Agency_Financial_Id_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Applicant_Recipient_Agency_Financial_Id_id_seq" OWNED BY public."Applicant_Recipient_Agency_Financial_Id".id;


--
-- Name: Applicant_Recipient_Contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Applicant_Recipient_Contact" (
    id bigint NOT NULL,
    egcs_ar_applicantrecipient bigint NOT NULL,
    egcs_ar_contact bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Applicant_Recipient_Contact" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Applicant_Recipient_Contact_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Applicant_Recipient_Contact_id_seq" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Applicant_Recipient_Contact_id_seq" OWNED BY public."Applicant_Recipient_Contact".id;


--
-- Name: Applicant_Recipient_Other_Name; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Applicant_Recipient_Other_Name" (
    id bigint NOT NULL,
    egcs_ar_othername character varying(255) NOT NULL,
    egcs_ar_applicantrecipient bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Applicant_Recipient_Other_Name" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Other_Name_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Applicant_Recipient_Other_Name_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Applicant_Recipient_Other_Name_id_seq" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Other_Name_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Applicant_Recipient_Other_Name_id_seq" OWNED BY public."Applicant_Recipient_Other_Name".id;


--
-- Name: Applicant_Recipient_Profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Applicant_Recipient_Profile" (
    id bigint NOT NULL,
    egcs_ar_provincialbusinessnumber integer,
    egcs_ar_businessnumber bigint,
    egcs_ar_charitynumber bigint,
    egcs_ar_naics integer NOT NULL,
    egcs_ar_description_en text,
    egcs_ar_description_fr text,
    egcs_ar_operatingname_en character varying(255),
    egcs_ar_operatingname_fr character varying(255),
    egcs_ar_applicantrecipientsubtypes bigint NOT NULL,
    egcs_ar_leadagency bigint,
    egcs_ar_legalname_en character varying(255),
    egcs_ar_legalname_fr character varying(255),
    egcs_ar_researchorganization_en character varying(255),
    egcs_ar_researchorganization_fr character varying(255),
    egcs_ar_status public.base_status NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Applicant_Recipient_Profile" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Applicant_Recipient_Team" (
    id bigint NOT NULL,
    egcs_ar_applicantrecipient bigint NOT NULL,
    egcs_ar_teammember bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Applicant_Recipient_Team" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Applicant_Recipient_Team_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Applicant_Recipient_Team_id_seq" OWNER TO postgres;

--
-- Name: Applicant_Recipient_Team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Applicant_Recipient_Team_id_seq" OWNED BY public."Applicant_Recipient_Team".id;


--
-- Name: Common_Additional_Reviewers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Additional_Reviewers" (
    id bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_entityid bigint NOT NULL,
    egcs_cn_comments text,
    egcs_cn_user bigint NOT NULL,
    egcs_cn_completedat timestamp with time zone,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT cn_chk_additionalreviewersentitytype CHECK ((egcs_cn_entitytype <> ALL (ARRAY['fundingopportunity'::public."Entity_Type", 'fundingcaseintake'::public."Entity_Type", 'fundingcaseagreement'::public."Entity_Type", 'applicantrecipient'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type"])))
);


ALTER TABLE public."Common_Additional_Reviewers" OWNER TO postgres;

--
-- Name: Common_Additional_Reviewers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Additional_Reviewers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Additional_Reviewers_id_seq" OWNER TO postgres;

--
-- Name: Common_Additional_Reviewers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Additional_Reviewers_id_seq" OWNED BY public."Common_Additional_Reviewers".id;


--
-- Name: Common_Address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Address" (
    id bigint NOT NULL,
    egcs_cn_federalridingid integer NOT NULL,
    egcs_cn_addresscity character varying(255) NOT NULL,
    egcs_cn_addresscountry public.countries NOT NULL,
    egcs_cn_addresssubdivision character varying(255) NOT NULL,
    egcs_cn_gc_addressid bigint NOT NULL,
    egcs_cn_latitude numeric(10,7),
    egcs_cn_longitude numeric(10,7),
    egcs_cn_mainphone bigint NOT NULL,
    egcs_cn_mainphoneextension smallint,
    egcs_cn_postalcodezipcode character varying(255) NOT NULL,
    egcs_cn_street1 character varying(255) NOT NULL,
    egcs_cn_street2 character varying(255),
    egcs_cn_street3 character varying(255),
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT cn_chk_addressaddresscountryaddresssubdivision CHECK ((((egcs_cn_addresscountry = 'ca'::public.countries) AND ((egcs_cn_addresssubdivision)::text = ANY ((enum_range(NULL::public.jurisdiction))::text[]))) OR (egcs_cn_addresscountry <> 'ca'::public.countries)))
);


ALTER TABLE public."Common_Address" OWNER TO postgres;

--
-- Name: Common_Address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Address_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Address_id_seq" OWNER TO postgres;

--
-- Name: Common_Address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Address_id_seq" OWNED BY public."Common_Address".id;


--
-- Name: Common_Approval; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Approval" (
    id bigint NOT NULL,
    egcs_cn_sequence numeric NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_routingslip bigint NOT NULL,
    egcs_cn_defaultuser bigint NOT NULL,
    egcs_cn_assigneduser bigint,
    egcs_cn_onbehalf bigint,
    egcs_cn_approvalpositiontitle text,
    egcs_cn_isadded boolean NOT NULL,
    egcs_cn_approvalvalue boolean,
    egcs_cn_approvaldate timestamp with time zone,
    egcs_cn_attachment bigint,
    egcs_cn_comment text,
    CONSTRAINT cn_chk_approvalapprovalvalueapprovalpositiontitlenull CHECK ((NOT ((egcs_cn_approvalpositiontitle IS NULL) AND (egcs_cn_approvalvalue IS NOT NULL)))),
    CONSTRAINT cn_chk_approvalassigneduseronbehalfapprovalpositiontitlenotnull CHECK ((NOT ((egcs_cn_defaultuser = egcs_cn_assigneduser) AND (egcs_cn_onbehalf IS NOT NULL)))),
    CONSTRAINT cn_chk_approvaldefaultuserassigneduseronbehalfnull CHECK ((NOT ((egcs_cn_defaultuser <> egcs_cn_assigneduser) AND (egcs_cn_onbehalf IS NULL))))
);


ALTER TABLE public."Common_Approval" OWNER TO postgres;

--
-- Name: Common_Approval_Certification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Approval_Certification" (
    id bigint NOT NULL,
    egcs_cn_optional boolean NOT NULL,
    egcs_cn_certification_en text NOT NULL,
    egcs_cn_certification_fr text NOT NULL,
    egcs_cn_value boolean,
    egcs_cn_approval bigint NOT NULL
);


ALTER TABLE public."Common_Approval_Certification" OWNER TO postgres;

--
-- Name: Common_Approval_Certification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Approval_Certification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Approval_Certification_id_seq" OWNER TO postgres;

--
-- Name: Common_Approval_Certification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Approval_Certification_id_seq" OWNED BY public."Common_Approval_Certification".id;


--
-- Name: Common_Approval_Step; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Approval_Step" (
    id bigint NOT NULL,
    egcs_cn_sequence integer NOT NULL,
    egcs_cn_description_en text NOT NULL,
    egcs_cn_description_fr text NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_approvaltemplate bigint NOT NULL,
    egcs_cn_defaultuser bigint NOT NULL,
    egcs_cn_approvertitle character varying(255) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Approval_Step" OWNER TO postgres;

--
-- Name: Common_Approval_Step_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Approval_Step_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Approval_Step_id_seq" OWNER TO postgres;

--
-- Name: Common_Approval_Step_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Approval_Step_id_seq" OWNED BY public."Common_Approval_Step".id;


--
-- Name: Common_Approval_Template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Approval_Template" (
    id bigint NOT NULL,
    egcs_cn_description_en text NOT NULL,
    egcs_cn_description_fr text NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    egcs_cn_scopetype public."Entity_Type" NOT NULL,
    egcs_cn_scopeid bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    CONSTRAINT cn_chk_approvaltemplateentitytype CHECK ((egcs_cn_entitytype <> ALL (ARRAY['fundingopportunity'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type"]))),
    CONSTRAINT cn_chk_approvaltemplatescopetype CHECK ((egcs_cn_scopetype = ANY (ARRAY['fundingopportunity'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type"])))
);


ALTER TABLE public."Common_Approval_Template" OWNER TO postgres;

--
-- Name: Common_Approval_Template_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Approval_Template_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Approval_Template_id_seq" OWNER TO postgres;

--
-- Name: Common_Approval_Template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Approval_Template_id_seq" OWNED BY public."Common_Approval_Template".id;


--
-- Name: Common_Approval_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Approval_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Approval_id_seq" OWNER TO postgres;

--
-- Name: Common_Approval_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Approval_id_seq" OWNED BY public."Common_Approval".id;


--
-- Name: Common_Assessment_Custom_Outcome; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Assessment_Custom_Outcome" (
    id bigint NOT NULL,
    egcs_cn_name character varying(255) NOT NULL,
    egcs_cn_outcome text NOT NULL,
    egcs_cn_review bigint NOT NULL
);


ALTER TABLE public."Common_Assessment_Custom_Outcome" OWNER TO postgres;

--
-- Name: Common_Assessment_Custom_Outcome_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Assessment_Custom_Outcome_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Assessment_Custom_Outcome_id_seq" OWNER TO postgres;

--
-- Name: Common_Assessment_Custom_Outcome_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Assessment_Custom_Outcome_id_seq" OWNED BY public."Common_Assessment_Custom_Outcome".id;


--
-- Name: Common_Assessment_Outcome; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Assessment_Outcome" (
    id bigint NOT NULL,
    egcs_cn_review bigint NOT NULL,
    egcs_cn_section character varying(255) NOT NULL,
    egcs_cn_subsection character varying(255) NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_recommendedstrategy text NOT NULL,
    egcs_cn_accepted boolean NOT NULL,
    egcs_cn_selectedstrategy character varying(255) NOT NULL,
    egcs_cn_justification text,
    egcs_cn_comment text NOT NULL
);


ALTER TABLE public."Common_Assessment_Outcome" OWNER TO postgres;

--
-- Name: Common_Assessment_Outcome_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Assessment_Outcome_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Assessment_Outcome_id_seq" OWNER TO postgres;

--
-- Name: Common_Assessment_Outcome_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Assessment_Outcome_id_seq" OWNED BY public."Common_Assessment_Outcome".id;


--
-- Name: Common_Attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Attachment" (
    id bigint NOT NULL,
    egcs_cn_attachmenttype bigint NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_description_en text NOT NULL,
    egcs_cn_description_fr text NOT NULL,
    egcs_cn_bucketorcontainer character varying NOT NULL,
    egcs_cn_objectkey character varying NOT NULL,
    egcs_cn_region character varying,
    egcs_cn_mimetype text NOT NULL,
    egcs_cn_createdat timestamp with time zone NOT NULL,
    egcs_cn_filesize bigint NOT NULL,
    egcs_cn_provider character varying(15) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Attachment" OWNER TO postgres;

--
-- Name: Common_Attachment_Types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Attachment_Types" (
    id bigint NOT NULL,
    egcs_cn_agency bigint NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_description_en text NOT NULL,
    egcs_cn_description_fr text NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Attachment_Types" OWNER TO postgres;

--
-- Name: Common_Attachment_Types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Attachment_Types_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Attachment_Types_id_seq" OWNER TO postgres;

--
-- Name: Common_Attachment_Types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Attachment_Types_id_seq" OWNED BY public."Common_Attachment_Types".id;


--
-- Name: Common_Attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Attachment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Attachment_id_seq" OWNER TO postgres;

--
-- Name: Common_Attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Attachment_id_seq" OWNED BY public."Common_Attachment".id;


--
-- Name: Common_Certification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Certification" (
    id bigint NOT NULL,
    egcs_cn_order smallint NOT NULL,
    egcs_cn_description_en text NOT NULL,
    egcs_cn_description_fr text NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_optional boolean,
    egcs_cn_certification_en text NOT NULL,
    egcs_cn_certification_fr text NOT NULL,
    egcs_cn_approvalstep bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Certification" OWNER TO postgres;

--
-- Name: Common_Certification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Certification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Certification_id_seq" OWNER TO postgres;

--
-- Name: Common_Certification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Certification_id_seq" OWNED BY public."Common_Certification".id;


--
-- Name: Common_Completion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Completion" (
    id bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_entityid bigint NOT NULL,
    egcs_cn_value boolean NOT NULL,
    egcs_cn_comments text,
    egcs_cn_user bigint NOT NULL,
    egcs_cn_completedat timestamp with time zone NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT cn_chk_completionentitytype CHECK ((egcs_cn_entitytype <> ALL (ARRAY['fundingopportunity'::public."Entity_Type", 'fundingcaseintake'::public."Entity_Type", 'fundingcaseagreement'::public."Entity_Type", 'applicantrecipient'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type"])))
);


ALTER TABLE public."Common_Completion" OWNER TO postgres;

--
-- Name: Common_Completion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Completion_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Completion_id_seq" OWNER TO postgres;

--
-- Name: Common_Completion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Completion_id_seq" OWNED BY public."Common_Completion".id;


--
-- Name: Common_Contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Contact" (
    id bigint NOT NULL,
    egcs_cn_title character varying(255),
    egcs_cn_name character varying(255) NOT NULL,
    egcs_cn_businessphone bigint,
    egcs_cn_businessphoneextension bigint,
    egcs_cn_generallanguagepreference public.language_preference NOT NULL,
    egcs_cn_jobtitle_en character varying(255) NOT NULL,
    egcs_cn_jobtitle_fr character varying(255) NOT NULL,
    egcs_cn_primaryaccount boolean NOT NULL,
    egcs_cn_email public.citext NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Contact" OWNER TO postgres;

--
-- Name: Common_Contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Contact_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Contact_id_seq" OWNER TO postgres;

--
-- Name: Common_Contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Contact_id_seq" OWNED BY public."Common_Contact".id;


--
-- Name: Common_Entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Entity" (
    id bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Entity" OWNER TO postgres;

--
-- Name: Common_Entity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Entity_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Entity_id_seq" OWNER TO postgres;

--
-- Name: Common_Entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Entity_id_seq" OWNED BY public."Common_Entity".id;


--
-- Name: Common_Form_Schema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Form_Schema" (
    id bigint NOT NULL,
    egcs_cn_agency bigint NOT NULL,
    egcs_cn_status public.base_status NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_version numeric(10,2) NOT NULL,
    egcs_cn_schema jsonb NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Form_Schema" OWNER TO postgres;

--
-- Name: Common_Form_Schema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Form_Schema_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Form_Schema_id_seq" OWNER TO postgres;

--
-- Name: Common_Form_Schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Form_Schema_id_seq" OWNED BY public."Common_Form_Schema".id;


--
-- Name: Common_GWCOA; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_GWCOA" (
    id bigint NOT NULL,
    egcs_cn_number smallint NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_GWCOA" OWNER TO postgres;

--
-- Name: Common_GWCOA_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_GWCOA_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_GWCOA_id_seq" OWNER TO postgres;

--
-- Name: Common_GWCOA_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_GWCOA_id_seq" OWNED BY public."Common_GWCOA".id;


--
-- Name: Common_Recommendation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Recommendation" (
    id bigint NOT NULL,
    egcs_cn_recommendationsetup bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_entityid bigint NOT NULL,
    egcs_cn_recommendation smallint,
    egcs_cn_response jsonb NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Recommendation" OWNER TO postgres;

--
-- Name: Common_Recommendation_Schema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Recommendation_Schema" (
    id bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_agency bigint NOT NULL,
    egcs_cn_status public.base_status NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_version numeric(10,2) NOT NULL,
    egcs_cn_result jsonb NOT NULL,
    egcs_cn_recommendationschema jsonb NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT cn_chk_recommendationschemaentitytype CHECK ((egcs_cn_entitytype <> 'commonrecommendation'::public."Entity_Type"))
);


ALTER TABLE public."Common_Recommendation_Schema" OWNER TO postgres;

--
-- Name: Common_Recommendation_Schema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Recommendation_Schema_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Recommendation_Schema_id_seq" OWNER TO postgres;

--
-- Name: Common_Recommendation_Schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Recommendation_Schema_id_seq" OWNED BY public."Common_Recommendation_Schema".id;


--
-- Name: Common_Recommendation_Setup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Recommendation_Setup" (
    id bigint NOT NULL,
    egcs_cn_scopetype public."Entity_Type" NOT NULL,
    egcs_cn_scopeid bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_description_en text NOT NULL,
    egcs_cn_description_fr text NOT NULL,
    egcs_cn_schema bigint NOT NULL,
    egcs_cn_approvaltemplate bigint,
    egcs_cn_active boolean NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT cn_chk_recommendationsetupentitytype CHECK ((egcs_cn_entitytype <> ALL (ARRAY['fundingopportunity'::public."Entity_Type", 'fundingcaseintake'::public."Entity_Type", 'fundingcaseagreement'::public."Entity_Type", 'applicantrecipient'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type", 'commonrecommendation'::public."Entity_Type"]))),
    CONSTRAINT cn_chk_recommendationsetupscopetype CHECK ((egcs_cn_scopetype = ANY (ARRAY['fundingopportunity'::public."Entity_Type", 'fundingcaseintake'::public."Entity_Type", 'fundingcaseagreement'::public."Entity_Type", 'applicantrecipient'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type"])))
);


ALTER TABLE public."Common_Recommendation_Setup" OWNER TO postgres;

--
-- Name: Common_Recommendation_Setup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Recommendation_Setup_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Recommendation_Setup_id_seq" OWNER TO postgres;

--
-- Name: Common_Recommendation_Setup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Recommendation_Setup_id_seq" OWNED BY public."Common_Recommendation_Setup".id;


--
-- Name: Common_Recommendation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Recommendation_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Recommendation_id_seq" OWNER TO postgres;

--
-- Name: Common_Recommendation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Recommendation_id_seq" OWNED BY public."Common_Recommendation".id;


--
-- Name: Common_Review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Review" (
    id bigint NOT NULL,
    egcs_cn_helpers jsonb,
    egcs_cn_status public.statuses NOT NULL,
    egcs_cn_reviewresult numeric(10,2) NOT NULL,
    egcs_cn_reviewset bigint NOT NULL,
    egcs_cn_reviewschema bigint NOT NULL,
    egcs_cn_approvaltemplate bigint,
    egcs_cn_disablecustomoutcomes boolean DEFAULT false NOT NULL,
    egcs_cn_disablealignment boolean DEFAULT false NOT NULL,
    egcs_cn_disablereviewers boolean DEFAULT false NOT NULL,
    egcs_cn_reviewalignment boolean,
    egcs_cn_reviewalignresult numeric(10,2),
    egcs_cn_reviewalignmentnarrative text,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT cn_chk_reviewreviewresult CHECK ((NOT ((egcs_cn_reviewalignment = true) AND ((egcs_cn_reviewalignmentnarrative IS NULL) OR (egcs_cn_reviewalignresult IS NULL)))))
);


ALTER TABLE public."Common_Review" OWNER TO postgres;

--
-- Name: Common_Review_Response; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Review_Response" (
    id bigint NOT NULL,
    egcs_cn_section character varying(255) NOT NULL,
    egcs_cn_subsection character varying(255) NOT NULL,
    egcs_cn_question character varying(255) NOT NULL,
    egcs_cn_value numeric(10,2),
    egcs_cn_comment text NOT NULL,
    egcs_cn_calculated boolean DEFAULT false NOT NULL,
    egcs_cn_assessment bigint NOT NULL
);


ALTER TABLE public."Common_Review_Response" OWNER TO postgres;

--
-- Name: Common_Review_Response_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Review_Response_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Review_Response_id_seq" OWNER TO postgres;

--
-- Name: Common_Review_Response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Review_Response_id_seq" OWNED BY public."Common_Review_Response".id;


--
-- Name: Common_Review_Schema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Review_Schema" (
    id bigint NOT NULL,
    egcs_cn_reviewtype public."Review_Type" NOT NULL,
    egcs_cn_agency bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" DEFAULT 'applicantrecipient'::public."Entity_Type" NOT NULL,
    egcs_cn_status public.statuses NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_outcomename_en character varying(255) NOT NULL,
    egcs_cn_outcomename_fr character varying(255) NOT NULL,
    egcs_cn_disablecustomoutcomes boolean DEFAULT false NOT NULL,
    egcs_cn_disablealignment boolean DEFAULT false NOT NULL,
    egcs_cn_disablereviewers boolean DEFAULT false NOT NULL,
    egcs_cn_version numeric(10,2) NOT NULL,
    egcs_cn_scoringmatrix jsonb,
    egcs_cn_assessmentschema jsonb,
    egcs_cn_publishedscoringmatrix jsonb,
    egcs_cn_publishedassessmentschema jsonb,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT cn_chk_reviewschemaentitytype CHECK ((egcs_cn_entitytype <> ALL (ARRAY['fundingopportunity'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type", 'commonreview'::public."Entity_Type", 'commonrecommendation'::public."Entity_Type"])))
);


ALTER TABLE public."Common_Review_Schema" OWNER TO postgres;

--
-- Name: Common_Review_Schema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Review_Schema_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Review_Schema_id_seq" OWNER TO postgres;

--
-- Name: Common_Review_Schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Review_Schema_id_seq" OWNED BY public."Common_Review_Schema".id;


--
-- Name: Common_Review_Set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Review_Set" (
    id bigint NOT NULL,
    egcs_cn_status public.statuses NOT NULL,
    egcs_cn_reviewsetsetup bigint NOT NULL,
    egcs_cn_approvaltemplate bigint,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_entityid bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Review_Set" OWNER TO postgres;

--
-- Name: Common_Review_Set_Setup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Review_Set_Setup" (
    id bigint NOT NULL,
    egcs_cn_scopetype public."Entity_Type" NOT NULL,
    egcs_cn_scopeid bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_oncompletion boolean NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_order smallint NOT NULL,
    egcs_cn_sequential boolean NOT NULL,
    egcs_cn_approvaltemplate bigint,
    egcs_cn_active boolean NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT cn_chk_reviewsetsetupentitytype CHECK ((egcs_cn_entitytype <> ALL (ARRAY['fundingopportunity'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type", 'commonreview'::public."Entity_Type", 'commonrecommendation'::public."Entity_Type"]))),
    CONSTRAINT cn_chk_reviewsetsetupscopetype CHECK ((egcs_cn_scopetype = ANY (ARRAY['fundingopportunity'::public."Entity_Type", 'fundingcaseintake'::public."Entity_Type", 'fundingcaseagreement'::public."Entity_Type", 'applicantrecipient'::public."Entity_Type", 'transferpaymentstream'::public."Entity_Type"])))
);


ALTER TABLE public."Common_Review_Set_Setup" OWNER TO postgres;

--
-- Name: Common_Review_Set_Setup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Review_Set_Setup_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Review_Set_Setup_id_seq" OWNER TO postgres;

--
-- Name: Common_Review_Set_Setup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Review_Set_Setup_id_seq" OWNED BY public."Common_Review_Set_Setup".id;


--
-- Name: Common_Review_Set_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Review_Set_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Review_Set_id_seq" OWNER TO postgres;

--
-- Name: Common_Review_Set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Review_Set_id_seq" OWNED BY public."Common_Review_Set".id;


--
-- Name: Common_Review_Setup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Review_Setup" (
    id bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_order smallint NOT NULL,
    egcs_cn_reviewset bigint NOT NULL,
    egcs_cn_approvaltemplate bigint,
    egcs_cn_reviewschema bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Review_Setup" OWNER TO postgres;

--
-- Name: Common_Review_Setup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Review_Setup_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Review_Setup_id_seq" OWNER TO postgres;

--
-- Name: Common_Review_Setup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Review_Setup_id_seq" OWNED BY public."Common_Review_Setup".id;


--
-- Name: Common_Routing_Slip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_Routing_Slip" (
    id bigint NOT NULL,
    egcs_cn_entitytype public."Entity_Type" NOT NULL,
    egcs_cn_entityid bigint NOT NULL,
    egcs_cn_name_en character varying(255) NOT NULL,
    egcs_cn_name_fr character varying(255) NOT NULL,
    egcs_cn_approvaltemplate bigint NOT NULL,
    egcs_cn_status public.approval_status NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_Routing_Slip" OWNER TO postgres;

--
-- Name: Common_Routing_Slip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_Routing_Slip_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_Routing_Slip_id_seq" OWNER TO postgres;

--
-- Name: Common_Routing_Slip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_Routing_Slip_id_seq" OWNED BY public."Common_Routing_Slip".id;


--
-- Name: Common_User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Common_User" (
    id bigint NOT NULL,
    egcs_cn_name text NOT NULL,
    egcs_cn_position_title text NOT NULL,
    egcs_cn_email public.citext NOT NULL,
    egcs_cn_email_verified boolean NOT NULL,
    egcs_cn_image text,
    egcs_cn_created_at timestamp with time zone NOT NULL,
    egcs_cn_updated_at timestamp with time zone NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Common_User" OWNER TO postgres;

--
-- Name: Common_User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Common_User_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Common_User_id_seq" OWNER TO postgres;

--
-- Name: Common_User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Common_User_id_seq" OWNED BY public."Common_User".id;


--
-- Name: Transfer_Payment_Agreement_Subtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Agreement_Subtype" (
    id bigint NOT NULL,
    egcs_tp_agreementtype bigint NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Agreement_Subtype" OWNER TO postgres;

--
-- Name: Transfer_Payment_Agreement_Subtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Agreement_Subtype_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Agreement_Subtype_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Agreement_Subtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Agreement_Subtype_id_seq" OWNED BY public."Transfer_Payment_Agreement_Subtype".id;


--
-- Name: Transfer_Payment_Amendment_Subtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Amendment_Subtype" (
    id bigint NOT NULL,
    egcs_tp_amendedtype bigint NOT NULL,
    egcs_tp_name_en character varying(255) NOT NULL,
    egcs_tp_name_fr character varying(255) NOT NULL,
    egcs_tp_description_en text NOT NULL,
    egcs_tp_description_fr text NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Amendment_Subtype" OWNER TO postgres;

--
-- Name: Transfer_Payment_Amendment_Subtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Amendment_Subtype_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Amendment_Subtype_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Amendment_Subtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Amendment_Subtype_id_seq" OWNED BY public."Transfer_Payment_Amendment_Subtype".id;


--
-- Name: Transfer_Payment_Amendment_Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Amendment_Type" (
    id bigint NOT NULL,
    egcs_tp_amended public.amended_type NOT NULL,
    egcs_tp_name_en character varying(255) NOT NULL,
    egcs_tp_name_fr character varying(255) NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Amendment_Type" OWNER TO postgres;

--
-- Name: Transfer_Payment_Amendment_Type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Amendment_Type_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Amendment_Type_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Amendment_Type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Amendment_Type_id_seq" OWNED BY public."Transfer_Payment_Amendment_Type".id;


--
-- Name: Transfer_Payment_Financial_Limits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Financial_Limits" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    egcs_tp_maxallowableperrecipient numeric(19,2) NOT NULL,
    egcs_tp_maxpercentofsupportavailableperrecipient numeric(5,2) NOT NULL,
    egcs_tp_maxpercentofretroactivecostsallowable numeric(5,2) NOT NULL,
    egcs_tp_stackinglimit numeric(5,2) NOT NULL,
    egcs_tp_status public.base_status NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Financial_Limits" OWNER TO postgres;

--
-- Name: Transfer_Payment_Financial_Limits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Financial_Limits_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Financial_Limits_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Financial_Limits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Financial_Limits_id_seq" OWNED BY public."Transfer_Payment_Financial_Limits".id;


--
-- Name: Transfer_Payment_Fiscal_Year_Budget; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Fiscal_Year_Budget" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentprofile bigint NOT NULL,
    egcs_tp_fiscalyear bigint NOT NULL,
    egcs_tp_totalbudget numeric(19,2) NOT NULL,
    egcs_tp_overcommitthreshold numeric(5,2) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Fiscal_Year_Budget" OWNER TO postgres;

--
-- Name: Transfer_Payment_Fiscal_Year_Budget_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Fiscal_Year_Budget_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Fiscal_Year_Budget_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Fiscal_Year_Budget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Fiscal_Year_Budget_id_seq" OWNED BY public."Transfer_Payment_Fiscal_Year_Budget".id;


--
-- Name: Transfer_Payment_Monitor_Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Monitor_Type" (
    id bigint NOT NULL,
    egcs_tp_name_en character varying(255) NOT NULL,
    egcs_tp_name_fr character varying(255) NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Monitor_Type" OWNER TO postgres;

--
-- Name: Transfer_Payment_Monitor_Type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Monitor_Type_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Monitor_Type_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Monitor_Type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Monitor_Type_id_seq" OWNED BY public."Transfer_Payment_Monitor_Type".id;


--
-- Name: Transfer_Payment_Objective; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Objective" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentprofile bigint NOT NULL,
    egcs_tp_objective_en text NOT NULL,
    egcs_tp_objective_fr text NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Objective" OWNER TO postgres;

--
-- Name: Transfer_Payment_Objective_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Objective_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Objective_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Objective_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Objective_id_seq" OWNED BY public."Transfer_Payment_Objective".id;


--
-- Name: Transfer_Payment_Outcome; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Outcome" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentprofile bigint NOT NULL,
    egcs_tp_name_en character varying(255) NOT NULL,
    egcs_tp_name_fr character varying(255) NOT NULL,
    egcs_tp_description_en text NOT NULL,
    egcs_tp_description_fr text NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Outcome" OWNER TO postgres;

--
-- Name: Transfer_Payment_Outcome_Performance_Indicator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Outcome_Performance_Indicator" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentoutcome bigint NOT NULL,
    egcs_tp_name_en character varying(255) NOT NULL,
    egcs_tp_name_fr character varying(255) NOT NULL,
    egcs_tp_description_en text NOT NULL,
    egcs_tp_description_fr text NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Outcome_Performance_Indicator" OWNER TO postgres;

--
-- Name: Transfer_Payment_Outcome_Performance_Indicator_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Outcome_Performance_Indicator_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Outcome_Performance_Indicator_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Outcome_Performance_Indicator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Outcome_Performance_Indicator_id_seq" OWNED BY public."Transfer_Payment_Outcome_Performance_Indicator".id;


--
-- Name: Transfer_Payment_Outcome_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Outcome_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Outcome_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Outcome_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Outcome_id_seq" OWNED BY public."Transfer_Payment_Outcome".id;


--
-- Name: Transfer_Payment_Profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Profile" (
    id bigint NOT NULL,
    egcs_tp_agency bigint NOT NULL,
    egcs_tp_datestart date NOT NULL,
    egcs_tp_dateend date NOT NULL,
    egcs_tp_name_en character varying(255) NOT NULL,
    egcs_tp_name_fr character varying(255) NOT NULL,
    egcs_tp_abbreviation_en character varying(255) NOT NULL,
    egcs_tp_abbreviation_fr character varying(255) NOT NULL,
    egcs_tp_description_en text NOT NULL,
    egcs_tp_description_fr text NOT NULL,
    egcs_tp_purpose_en text NOT NULL,
    egcs_tp_purpose_fr text NOT NULL,
    egcs_tp_tclink character varying(2000) NOT NULL,
    egcs_tp_status public.base_status NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT tp_chk_profiledatestartdateend CHECK ((egcs_tp_dateend >= egcs_tp_datestart))
);


ALTER TABLE public."Transfer_Payment_Profile" OWNER TO postgres;

--
-- Name: Transfer_Payment_Profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Profile_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Profile_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Profile_id_seq" OWNED BY public."Transfer_Payment_Profile".id;


--
-- Name: Transfer_Payment_Stream; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Stream" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentprofile bigint NOT NULL,
    egcs_tp_parentstream bigint,
    egcs_tp_name_en character varying(255) NOT NULL,
    egcs_tp_name_fr character varying(255) NOT NULL,
    egcs_tp_description_en text NOT NULL,
    egcs_tp_description_fr text NOT NULL,
    egcs_tp_abbreviation_en character varying(255) NOT NULL,
    egcs_tp_abbreviation_fr character varying(255) NOT NULL,
    egcs_tp_objective_en text NOT NULL,
    egcs_tp_objective_fr text NOT NULL,
    egcs_tp_allowsfurtherdistribution boolean DEFAULT false NOT NULL,
    egcs_tp_status public.base_status NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Stream" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Area_of_Expertise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Stream_Area_of_Expertise" (
    id bigint NOT NULL,
    egcs_tp_name_en character varying(255) NOT NULL,
    egcs_tp_name_fr character varying(255) NOT NULL,
    egcs_tp_description_en text NOT NULL,
    egcs_tp_description_fr text NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Stream_Area_of_Expertise" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Area_of_Expertise_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Stream_Area_of_Expertise_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Stream_Area_of_Expertise_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Area_of_Expertise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Stream_Area_of_Expertise_id_seq" OWNED BY public."Transfer_Payment_Stream_Area_of_Expertise".id;


--
-- Name: Transfer_Payment_Stream_Budget; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Stream_Budget" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    egcs_tp_totalbudget numeric(19,2) NOT NULL,
    egcs_tp_transferpaymentbudget bigint NOT NULL,
    egcs_tp_overcommitthreshold numeric(5,2) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Stream_Budget" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Budget_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Stream_Budget_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Stream_Budget_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Budget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Stream_Budget_id_seq" OWNED BY public."Transfer_Payment_Stream_Budget".id;


--
-- Name: Transfer_Payment_Stream_Commitment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Stream_Commitment" (
    id bigint NOT NULL,
    egcs_tp_streambudget bigint NOT NULL,
    egcs_tp_fund integer NOT NULL,
    egcs_tp_gl integer NOT NULL,
    egcs_tp_gldescription text NOT NULL,
    egcs_tp_fundcentre integer NOT NULL,
    egcs_tp_internalorder integer NOT NULL,
    egcs_tp_functionalarea integer NOT NULL,
    egcs_tp_costcentre integer NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Stream_Commitment" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Commitment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Stream_Commitment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Stream_Commitment_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Commitment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Stream_Commitment_id_seq" OWNED BY public."Transfer_Payment_Stream_Commitment".id;


--
-- Name: Transfer_Payment_Stream_Cost_Category_Line_Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Stream_Cost_Category_Line_Item" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    egcs_tp_organizationcostcategory bigint NOT NULL,
    egcs_tp_costsharingratio numeric(5,2) NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Stream_Cost_Category_Line_Item" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Cost_Category_Line_Item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Stream_Cost_Category_Line_Item_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Stream_Cost_Category_Line_Item_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Cost_Category_Line_Item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Stream_Cost_Category_Line_Item_id_seq" OWNED BY public."Transfer_Payment_Stream_Cost_Category_Line_Item".id;


--
-- Name: Transfer_Payment_Stream_Eligible_Recipient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Stream_Eligible_Recipient" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    egcs_tp_applicantrecipientsubtype bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Stream_Eligible_Recipient" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Eligible_Recipient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Stream_Eligible_Recipient_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Stream_Eligible_Recipient_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Eligible_Recipient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Stream_Eligible_Recipient_id_seq" OWNED BY public."Transfer_Payment_Stream_Eligible_Recipient".id;


--
-- Name: Transfer_Payment_Stream_Outcome; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transfer_Payment_Stream_Outcome" (
    id bigint NOT NULL,
    egcs_tp_transferpaymentstream bigint NOT NULL,
    egcs_tp_transferpaymentoutcome bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Transfer_Payment_Stream_Outcome" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Outcome_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transfer_Payment_Stream_Outcome_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transfer_Payment_Stream_Outcome_id_seq" OWNER TO postgres;

--
-- Name: Transfer_Payment_Stream_Outcome_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transfer_Payment_Stream_Outcome_id_seq" OWNED BY public."Transfer_Payment_Stream_Outcome".id;


--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id text NOT NULL,
    "accountId" text NOT NULL,
    "providerId" text NOT NULL,
    "userId" bigint NOT NULL,
    "accessToken" text,
    "refreshToken" text,
    "idToken" text,
    "accessTokenExpiresAt" timestamp without time zone,
    "refreshTokenExpiresAt" timestamp without time zone,
    scope text,
    password text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


ALTER TABLE public.account OWNER TO postgres;

--
-- Name: entity_user_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_user_assignment (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    agency_id bigint NOT NULL,
    transfer_payment_id bigint NOT NULL,
    entity_type text NOT NULL,
    entity_id text NOT NULL,
    can_create boolean DEFAULT false NOT NULL,
    can_read boolean DEFAULT false NOT NULL,
    can_update boolean DEFAULT false NOT NULL,
    can_delete boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.entity_user_assignment OWNER TO postgres;

--
-- Name: entity_user_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entity_user_assignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entity_user_assignment_id_seq OWNER TO postgres;

--
-- Name: entity_user_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entity_user_assignment_id_seq OWNED BY public.entity_user_assignment.id;


--
-- Name: kysely_migration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kysely_migration (
    name character varying(255) NOT NULL,
    "timestamp" character varying(255) NOT NULL
);


ALTER TABLE public.kysely_migration OWNER TO postgres;

--
-- Name: kysely_migration_lock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kysely_migration_lock (
    id character varying(255) NOT NULL,
    is_locked integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.kysely_migration_lock OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id bigint NOT NULL,
    scope_type text NOT NULL,
    agency_id bigint,
    name_en character varying NOT NULL,
    name_fr character varying NOT NULL,
    description_en text,
    description_fr text,
    _deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT role_scope_type_check CHECK ((scope_type = ANY (ARRAY['global'::text, 'agency'::text, 'program'::text])))
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: role_ability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_ability (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    action character varying NOT NULL,
    subject character varying NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.role_ability OWNER TO postgres;

--
-- Name: role_ability_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_ability_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_ability_id_seq OWNER TO postgres;

--
-- Name: role_ability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_ability_id_seq OWNED BY public.role_ability.id;


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_seq OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: role_transfer_payment_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_transfer_payment_scope (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    transfer_payment_profile_id bigint NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.role_transfer_payment_scope OWNER TO postgres;

--
-- Name: role_transfer_payment_scope_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_transfer_payment_scope_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_transfer_payment_scope_id_seq OWNER TO postgres;

--
-- Name: role_transfer_payment_scope_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_transfer_payment_scope_id_seq OWNED BY public.role_transfer_payment_scope.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    id text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    token text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "userId" bigint NOT NULL,
    "ipAddress" text,
    "userAgent" text
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "emailVerified" boolean NOT NULL,
    image text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user_role_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_assignment (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    _deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.user_role_assignment OWNER TO postgres;

--
-- Name: user_role_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_role_assignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_assignment_id_seq OWNER TO postgres;

--
-- Name: user_role_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_role_assignment_id_seq OWNED BY public.user_role_assignment.id;


--
-- Name: verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification (
    id text NOT NULL,
    identifier text NOT NULL,
    value text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);


ALTER TABLE public.verification OWNER TO postgres;

--
-- Name: Agency_Address_Type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Address_Type" ALTER COLUMN id SET DEFAULT nextval('public."Agency_Address_Type_id_seq"'::regclass);


--
-- Name: Agency_Agreement_Type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Agreement_Type" ALTER COLUMN id SET DEFAULT nextval('public."Agency_Agreement_Type_id_seq"'::regclass);


--
-- Name: Agency_Applicant_Recipient_Subtype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Applicant_Recipient_Subtype" ALTER COLUMN id SET DEFAULT nextval('public."Agency_Applicant_Recipient_Subtype_id_seq"'::regclass);


--
-- Name: Agency_Approval_Behalf_Type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Approval_Behalf_Type" ALTER COLUMN id SET DEFAULT nextval('public."Agency_Approval_Behalf_Type_id_seq"'::regclass);


--
-- Name: Agency_Cost_Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Cost_Category" ALTER COLUMN id SET DEFAULT nextval('public."Agency_Cost_Category_id_seq"'::regclass);


--
-- Name: Agency_Cost_Category_Line_Item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Cost_Category_Line_Item" ALTER COLUMN id SET DEFAULT nextval('public."Agency_Cost_Category_Line_Item_id_seq"'::regclass);


--
-- Name: Agency_Fiscal_Year id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Fiscal_Year" ALTER COLUMN id SET DEFAULT nextval('public."Agency_Fiscal_Year_id_seq"'::regclass);


--
-- Name: Agency_Profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Profile" ALTER COLUMN id SET DEFAULT nextval('public."Agency_Profile_id_seq"'::regclass);


--
-- Name: Applicant_Recipient_Address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Address" ALTER COLUMN id SET DEFAULT nextval('public."Applicant_Recipient_Address_id_seq"'::regclass);


--
-- Name: Applicant_Recipient_Agency_Financial_Id id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Agency_Financial_Id" ALTER COLUMN id SET DEFAULT nextval('public."Applicant_Recipient_Agency_Financial_Id_id_seq"'::regclass);


--
-- Name: Applicant_Recipient_Contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Contact" ALTER COLUMN id SET DEFAULT nextval('public."Applicant_Recipient_Contact_id_seq"'::regclass);


--
-- Name: Applicant_Recipient_Other_Name id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Other_Name" ALTER COLUMN id SET DEFAULT nextval('public."Applicant_Recipient_Other_Name_id_seq"'::regclass);


--
-- Name: Applicant_Recipient_Team id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Team" ALTER COLUMN id SET DEFAULT nextval('public."Applicant_Recipient_Team_id_seq"'::regclass);


--
-- Name: Common_Additional_Reviewers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Additional_Reviewers" ALTER COLUMN id SET DEFAULT nextval('public."Common_Additional_Reviewers_id_seq"'::regclass);


--
-- Name: Common_Address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Address" ALTER COLUMN id SET DEFAULT nextval('public."Common_Address_id_seq"'::regclass);


--
-- Name: Common_Approval id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval" ALTER COLUMN id SET DEFAULT nextval('public."Common_Approval_id_seq"'::regclass);


--
-- Name: Common_Approval_Certification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Certification" ALTER COLUMN id SET DEFAULT nextval('public."Common_Approval_Certification_id_seq"'::regclass);


--
-- Name: Common_Approval_Step id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Step" ALTER COLUMN id SET DEFAULT nextval('public."Common_Approval_Step_id_seq"'::regclass);


--
-- Name: Common_Approval_Template id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Template" ALTER COLUMN id SET DEFAULT nextval('public."Common_Approval_Template_id_seq"'::regclass);


--
-- Name: Common_Assessment_Custom_Outcome id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Assessment_Custom_Outcome" ALTER COLUMN id SET DEFAULT nextval('public."Common_Assessment_Custom_Outcome_id_seq"'::regclass);


--
-- Name: Common_Assessment_Outcome id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Assessment_Outcome" ALTER COLUMN id SET DEFAULT nextval('public."Common_Assessment_Outcome_id_seq"'::regclass);


--
-- Name: Common_Attachment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Attachment" ALTER COLUMN id SET DEFAULT nextval('public."Common_Attachment_id_seq"'::regclass);


--
-- Name: Common_Attachment_Types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Attachment_Types" ALTER COLUMN id SET DEFAULT nextval('public."Common_Attachment_Types_id_seq"'::regclass);


--
-- Name: Common_Certification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Certification" ALTER COLUMN id SET DEFAULT nextval('public."Common_Certification_id_seq"'::regclass);


--
-- Name: Common_Completion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Completion" ALTER COLUMN id SET DEFAULT nextval('public."Common_Completion_id_seq"'::regclass);


--
-- Name: Common_Contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Contact" ALTER COLUMN id SET DEFAULT nextval('public."Common_Contact_id_seq"'::regclass);


--
-- Name: Common_Entity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Entity" ALTER COLUMN id SET DEFAULT nextval('public."Common_Entity_id_seq"'::regclass);


--
-- Name: Common_Form_Schema id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Form_Schema" ALTER COLUMN id SET DEFAULT nextval('public."Common_Form_Schema_id_seq"'::regclass);


--
-- Name: Common_GWCOA id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_GWCOA" ALTER COLUMN id SET DEFAULT nextval('public."Common_GWCOA_id_seq"'::regclass);


--
-- Name: Common_Recommendation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation" ALTER COLUMN id SET DEFAULT nextval('public."Common_Recommendation_id_seq"'::regclass);


--
-- Name: Common_Recommendation_Schema id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation_Schema" ALTER COLUMN id SET DEFAULT nextval('public."Common_Recommendation_Schema_id_seq"'::regclass);


--
-- Name: Common_Recommendation_Setup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation_Setup" ALTER COLUMN id SET DEFAULT nextval('public."Common_Recommendation_Setup_id_seq"'::regclass);


--
-- Name: Common_Review_Response id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Response" ALTER COLUMN id SET DEFAULT nextval('public."Common_Review_Response_id_seq"'::regclass);


--
-- Name: Common_Review_Schema id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Schema" ALTER COLUMN id SET DEFAULT nextval('public."Common_Review_Schema_id_seq"'::regclass);


--
-- Name: Common_Review_Set id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set" ALTER COLUMN id SET DEFAULT nextval('public."Common_Review_Set_id_seq"'::regclass);


--
-- Name: Common_Review_Set_Setup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set_Setup" ALTER COLUMN id SET DEFAULT nextval('public."Common_Review_Set_Setup_id_seq"'::regclass);


--
-- Name: Common_Review_Setup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Setup" ALTER COLUMN id SET DEFAULT nextval('public."Common_Review_Setup_id_seq"'::regclass);


--
-- Name: Common_Routing_Slip id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Routing_Slip" ALTER COLUMN id SET DEFAULT nextval('public."Common_Routing_Slip_id_seq"'::regclass);


--
-- Name: Common_User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_User" ALTER COLUMN id SET DEFAULT nextval('public."Common_User_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Agreement_Subtype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Agreement_Subtype" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Agreement_Subtype_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Amendment_Subtype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Amendment_Subtype" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Amendment_Subtype_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Amendment_Type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Amendment_Type" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Amendment_Type_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Financial_Limits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Financial_Limits" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Financial_Limits_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Fiscal_Year_Budget id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Fiscal_Year_Budget" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Fiscal_Year_Budget_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Monitor_Type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Monitor_Type" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Monitor_Type_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Objective id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Objective" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Objective_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Outcome id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Outcome" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Outcome_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Outcome_Performance_Indicator id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Outcome_Performance_Indicator" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Outcome_Performance_Indicator_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Profile" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Profile_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Stream_Area_of_Expertise id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Area_of_Expertise" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Stream_Area_of_Expertise_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Stream_Budget id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Budget" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Stream_Budget_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Stream_Commitment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Commitment" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Stream_Commitment_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Stream_Cost_Category_Line_Item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Cost_Category_Line_Item" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Stream_Cost_Category_Line_Item_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Stream_Eligible_Recipient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Eligible_Recipient" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Stream_Eligible_Recipient_id_seq"'::regclass);


--
-- Name: Transfer_Payment_Stream_Outcome id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Outcome" ALTER COLUMN id SET DEFAULT nextval('public."Transfer_Payment_Stream_Outcome_id_seq"'::regclass);


--
-- Name: entity_user_assignment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_user_assignment ALTER COLUMN id SET DEFAULT nextval('public.entity_user_assignment_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: role_ability id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_ability ALTER COLUMN id SET DEFAULT nextval('public.role_ability_id_seq'::regclass);


--
-- Name: role_transfer_payment_scope id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_transfer_payment_scope ALTER COLUMN id SET DEFAULT nextval('public.role_transfer_payment_scope_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_role_assignment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_assignment ALTER COLUMN id SET DEFAULT nextval('public.user_role_assignment_id_seq'::regclass);


--
-- Data for Name: Agency_Address_Type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Agency_Agreement_Type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Agency_Applicant_Recipient_Subtype; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Agency_Approval_Behalf_Type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Agency_Cost_Category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Agency_Cost_Category_Line_Item; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Agency_Fiscal_Year; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Agency_Profile; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Applicant_Recipient_Address; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Applicant_Recipient_Agency_Financial_Id; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Applicant_Recipient_Contact; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Applicant_Recipient_Other_Name; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Applicant_Recipient_Profile; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Applicant_Recipient_Team; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Additional_Reviewers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Address; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Approval; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Approval_Certification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Approval_Step; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Approval_Template; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Assessment_Custom_Outcome; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Assessment_Outcome; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Attachment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Attachment_Types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Certification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Completion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Contact; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Entity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Form_Schema; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_GWCOA; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Recommendation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Recommendation_Schema; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Recommendation_Setup; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Review; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Review_Response; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Review_Schema; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Review_Set; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Review_Set_Setup; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Review_Setup; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_Routing_Slip; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Common_User; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Agreement_Subtype; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Amendment_Subtype; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Amendment_Type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Financial_Limits; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Fiscal_Year_Budget; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Monitor_Type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Objective; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Outcome; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Outcome_Performance_Indicator; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Profile; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Stream; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Stream_Area_of_Expertise; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Stream_Budget; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Stream_Commitment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Stream_Cost_Category_Line_Item; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Stream_Eligible_Recipient; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Transfer_Payment_Stream_Outcome; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: entity_user_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: kysely_migration; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kysely_migration VALUES ('0001_common', '2026-04-16T14:34:48.160Z');
INSERT INTO public.kysely_migration VALUES ('0002_users', '2026-04-16T14:34:48.165Z');
INSERT INTO public.kysely_migration VALUES ('0003_rbac', '2026-04-16T14:34:48.171Z');
INSERT INTO public.kysely_migration VALUES ('0004_agency', '2026-04-16T14:34:48.192Z');
INSERT INTO public.kysely_migration VALUES ('0005_common_agency', '2026-04-16T14:34:48.194Z');
INSERT INTO public.kysely_migration VALUES ('0006_transfer_payment', '2026-04-16T14:34:48.226Z');
INSERT INTO public.kysely_migration VALUES ('0007_polymorphic_common_tp', '2026-04-16T14:34:48.297Z');
INSERT INTO public.kysely_migration VALUES ('0008_applicant_recipient', '2026-04-16T14:34:48.306Z');


--
-- Data for Name: kysely_migration_lock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kysely_migration_lock VALUES ('migration_lock', 0);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: role_ability; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: role_transfer_payment_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user_role_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: verification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Agency_Address_Type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agency_Address_Type_id_seq"', 1, false);


--
-- Name: Agency_Agreement_Type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agency_Agreement_Type_id_seq"', 1, false);


--
-- Name: Agency_Applicant_Recipient_Subtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agency_Applicant_Recipient_Subtype_id_seq"', 1, false);


--
-- Name: Agency_Approval_Behalf_Type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agency_Approval_Behalf_Type_id_seq"', 1, false);


--
-- Name: Agency_Cost_Category_Line_Item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agency_Cost_Category_Line_Item_id_seq"', 1, false);


--
-- Name: Agency_Cost_Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agency_Cost_Category_id_seq"', 1, false);


--
-- Name: Agency_Fiscal_Year_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agency_Fiscal_Year_id_seq"', 1, false);


--
-- Name: Agency_Profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Agency_Profile_id_seq"', 1, false);


--
-- Name: Applicant_Recipient_Address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Applicant_Recipient_Address_id_seq"', 1, false);


--
-- Name: Applicant_Recipient_Agency_Financial_Id_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Applicant_Recipient_Agency_Financial_Id_id_seq"', 1, false);


--
-- Name: Applicant_Recipient_Contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Applicant_Recipient_Contact_id_seq"', 1, false);


--
-- Name: Applicant_Recipient_Other_Name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Applicant_Recipient_Other_Name_id_seq"', 1, false);


--
-- Name: Applicant_Recipient_Team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Applicant_Recipient_Team_id_seq"', 1, false);


--
-- Name: Common_Additional_Reviewers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Additional_Reviewers_id_seq"', 1, false);


--
-- Name: Common_Address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Address_id_seq"', 1, false);


--
-- Name: Common_Approval_Certification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Approval_Certification_id_seq"', 1, false);


--
-- Name: Common_Approval_Step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Approval_Step_id_seq"', 1, false);


--
-- Name: Common_Approval_Template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Approval_Template_id_seq"', 1, false);


--
-- Name: Common_Approval_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Approval_id_seq"', 1, false);


--
-- Name: Common_Assessment_Custom_Outcome_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Assessment_Custom_Outcome_id_seq"', 1, false);


--
-- Name: Common_Assessment_Outcome_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Assessment_Outcome_id_seq"', 1, false);


--
-- Name: Common_Attachment_Types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Attachment_Types_id_seq"', 1, false);


--
-- Name: Common_Attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Attachment_id_seq"', 1, false);


--
-- Name: Common_Certification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Certification_id_seq"', 1, false);


--
-- Name: Common_Completion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Completion_id_seq"', 1, false);


--
-- Name: Common_Contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Contact_id_seq"', 1, false);


--
-- Name: Common_Entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Entity_id_seq"', 1, false);


--
-- Name: Common_Form_Schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Form_Schema_id_seq"', 1, false);


--
-- Name: Common_GWCOA_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_GWCOA_id_seq"', 1, false);


--
-- Name: Common_Recommendation_Schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Recommendation_Schema_id_seq"', 1, false);


--
-- Name: Common_Recommendation_Setup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Recommendation_Setup_id_seq"', 1, false);


--
-- Name: Common_Recommendation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Recommendation_id_seq"', 1, false);


--
-- Name: Common_Review_Response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Review_Response_id_seq"', 1, false);


--
-- Name: Common_Review_Schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Review_Schema_id_seq"', 1, false);


--
-- Name: Common_Review_Set_Setup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Review_Set_Setup_id_seq"', 1, false);


--
-- Name: Common_Review_Set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Review_Set_id_seq"', 1, false);


--
-- Name: Common_Review_Setup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Review_Setup_id_seq"', 1, false);


--
-- Name: Common_Routing_Slip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_Routing_Slip_id_seq"', 1, false);


--
-- Name: Common_User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Common_User_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Agreement_Subtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Agreement_Subtype_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Amendment_Subtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Amendment_Subtype_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Amendment_Type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Amendment_Type_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Financial_Limits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Financial_Limits_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Fiscal_Year_Budget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Fiscal_Year_Budget_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Monitor_Type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Monitor_Type_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Objective_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Objective_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Outcome_Performance_Indicator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Outcome_Performance_Indicator_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Outcome_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Outcome_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Profile_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Stream_Area_of_Expertise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Stream_Area_of_Expertise_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Stream_Budget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Stream_Budget_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Stream_Commitment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Stream_Commitment_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Stream_Cost_Category_Line_Item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Stream_Cost_Category_Line_Item_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Stream_Eligible_Recipient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Stream_Eligible_Recipient_id_seq"', 1, false);


--
-- Name: Transfer_Payment_Stream_Outcome_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transfer_Payment_Stream_Outcome_id_seq"', 1, false);


--
-- Name: entity_user_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entity_user_assignment_id_seq', 1, false);


--
-- Name: role_ability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_ability_id_seq', 1, false);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 1, false);


--
-- Name: role_transfer_payment_scope_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_transfer_payment_scope_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


--
-- Name: user_role_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_assignment_id_seq', 1, false);


--
-- Name: Agency_Address_Type Agency_Address_Type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Address_Type"
    ADD CONSTRAINT "Agency_Address_Type_pkey" PRIMARY KEY (id);


--
-- Name: Agency_Agreement_Type Agency_Agreement_Type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Agreement_Type"
    ADD CONSTRAINT "Agency_Agreement_Type_pkey" PRIMARY KEY (id);


--
-- Name: Agency_Applicant_Recipient_Subtype Agency_Applicant_Recipient_Subtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Applicant_Recipient_Subtype"
    ADD CONSTRAINT "Agency_Applicant_Recipient_Subtype_pkey" PRIMARY KEY (id);


--
-- Name: Agency_Approval_Behalf_Type Agency_Approval_Behalf_Type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Approval_Behalf_Type"
    ADD CONSTRAINT "Agency_Approval_Behalf_Type_pkey" PRIMARY KEY (id);


--
-- Name: Agency_Cost_Category_Line_Item Agency_Cost_Category_Line_Item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Cost_Category_Line_Item"
    ADD CONSTRAINT "Agency_Cost_Category_Line_Item_pkey" PRIMARY KEY (id);


--
-- Name: Agency_Cost_Category Agency_Cost_Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Cost_Category"
    ADD CONSTRAINT "Agency_Cost_Category_pkey" PRIMARY KEY (id);


--
-- Name: Agency_Fiscal_Year Agency_Fiscal_Year_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Fiscal_Year"
    ADD CONSTRAINT "Agency_Fiscal_Year_pkey" PRIMARY KEY (id);


--
-- Name: Agency_Profile Agency_Profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Profile"
    ADD CONSTRAINT "Agency_Profile_pkey" PRIMARY KEY (id);


--
-- Name: Applicant_Recipient_Address Applicant_Recipient_Address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Address"
    ADD CONSTRAINT "Applicant_Recipient_Address_pkey" PRIMARY KEY (id);


--
-- Name: Applicant_Recipient_Agency_Financial_Id Applicant_Recipient_Agency_Financial_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Agency_Financial_Id"
    ADD CONSTRAINT "Applicant_Recipient_Agency_Financial_Id_pkey" PRIMARY KEY (id);


--
-- Name: Applicant_Recipient_Contact Applicant_Recipient_Contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Contact"
    ADD CONSTRAINT "Applicant_Recipient_Contact_pkey" PRIMARY KEY (id);


--
-- Name: Applicant_Recipient_Other_Name Applicant_Recipient_Other_Name_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Other_Name"
    ADD CONSTRAINT "Applicant_Recipient_Other_Name_pkey" PRIMARY KEY (id);


--
-- Name: Applicant_Recipient_Profile Applicant_Recipient_Profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Profile"
    ADD CONSTRAINT "Applicant_Recipient_Profile_pkey" PRIMARY KEY (id);


--
-- Name: Applicant_Recipient_Team Applicant_Recipient_Team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Team"
    ADD CONSTRAINT "Applicant_Recipient_Team_pkey" PRIMARY KEY (id);


--
-- Name: Common_Additional_Reviewers Common_Additional_Reviewers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Additional_Reviewers"
    ADD CONSTRAINT "Common_Additional_Reviewers_pkey" PRIMARY KEY (id);


--
-- Name: Common_Address Common_Address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Address"
    ADD CONSTRAINT "Common_Address_pkey" PRIMARY KEY (id);


--
-- Name: Common_Approval_Certification Common_Approval_Certification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Certification"
    ADD CONSTRAINT "Common_Approval_Certification_pkey" PRIMARY KEY (id);


--
-- Name: Common_Approval_Step Common_Approval_Step_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Step"
    ADD CONSTRAINT "Common_Approval_Step_pkey" PRIMARY KEY (id);


--
-- Name: Common_Approval_Template Common_Approval_Template_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Template"
    ADD CONSTRAINT "Common_Approval_Template_pkey" PRIMARY KEY (id);


--
-- Name: Common_Approval Common_Approval_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval"
    ADD CONSTRAINT "Common_Approval_pkey" PRIMARY KEY (id);


--
-- Name: Common_Assessment_Custom_Outcome Common_Assessment_Custom_Outcome_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Assessment_Custom_Outcome"
    ADD CONSTRAINT "Common_Assessment_Custom_Outcome_pkey" PRIMARY KEY (id);


--
-- Name: Common_Assessment_Outcome Common_Assessment_Outcome_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Assessment_Outcome"
    ADD CONSTRAINT "Common_Assessment_Outcome_pkey" PRIMARY KEY (id);


--
-- Name: Common_Attachment_Types Common_Attachment_Types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Attachment_Types"
    ADD CONSTRAINT "Common_Attachment_Types_pkey" PRIMARY KEY (id);


--
-- Name: Common_Attachment Common_Attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Attachment"
    ADD CONSTRAINT "Common_Attachment_pkey" PRIMARY KEY (id);


--
-- Name: Common_Certification Common_Certification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Certification"
    ADD CONSTRAINT "Common_Certification_pkey" PRIMARY KEY (id);


--
-- Name: Common_Completion Common_Completion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Completion"
    ADD CONSTRAINT "Common_Completion_pkey" PRIMARY KEY (id);


--
-- Name: Common_Contact Common_Contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Contact"
    ADD CONSTRAINT "Common_Contact_pkey" PRIMARY KEY (id);


--
-- Name: Common_Entity Common_Entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Entity"
    ADD CONSTRAINT "Common_Entity_pkey" PRIMARY KEY (id);


--
-- Name: Common_Form_Schema Common_Form_Schema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Form_Schema"
    ADD CONSTRAINT "Common_Form_Schema_pkey" PRIMARY KEY (id);


--
-- Name: Common_GWCOA Common_GWCOA_egcs_cn_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_GWCOA"
    ADD CONSTRAINT "Common_GWCOA_egcs_cn_number_key" UNIQUE (egcs_cn_number);


--
-- Name: Common_GWCOA Common_GWCOA_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_GWCOA"
    ADD CONSTRAINT "Common_GWCOA_pkey" PRIMARY KEY (id);


--
-- Name: Common_Recommendation_Schema Common_Recommendation_Schema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation_Schema"
    ADD CONSTRAINT "Common_Recommendation_Schema_pkey" PRIMARY KEY (id);


--
-- Name: Common_Recommendation_Setup Common_Recommendation_Setup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation_Setup"
    ADD CONSTRAINT "Common_Recommendation_Setup_pkey" PRIMARY KEY (id);


--
-- Name: Common_Recommendation Common_Recommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation"
    ADD CONSTRAINT "Common_Recommendation_pkey" PRIMARY KEY (id);


--
-- Name: Common_Review_Response Common_Review_Response_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Response"
    ADD CONSTRAINT "Common_Review_Response_pkey" PRIMARY KEY (id);


--
-- Name: Common_Review_Schema Common_Review_Schema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Schema"
    ADD CONSTRAINT "Common_Review_Schema_pkey" PRIMARY KEY (id);


--
-- Name: Common_Review_Set_Setup Common_Review_Set_Setup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set_Setup"
    ADD CONSTRAINT "Common_Review_Set_Setup_pkey" PRIMARY KEY (id);


--
-- Name: Common_Review_Set Common_Review_Set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set"
    ADD CONSTRAINT "Common_Review_Set_pkey" PRIMARY KEY (id);


--
-- Name: Common_Review_Setup Common_Review_Setup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Setup"
    ADD CONSTRAINT "Common_Review_Setup_pkey" PRIMARY KEY (id);


--
-- Name: Common_Review Common_Review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review"
    ADD CONSTRAINT "Common_Review_pkey" PRIMARY KEY (id);


--
-- Name: Common_Routing_Slip Common_Routing_Slip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Routing_Slip"
    ADD CONSTRAINT "Common_Routing_Slip_pkey" PRIMARY KEY (id);


--
-- Name: Common_User Common_User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_User"
    ADD CONSTRAINT "Common_User_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Agreement_Subtype Transfer_Payment_Agreement_Subtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Agreement_Subtype"
    ADD CONSTRAINT "Transfer_Payment_Agreement_Subtype_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Amendment_Subtype Transfer_Payment_Amendment_Subtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Amendment_Subtype"
    ADD CONSTRAINT "Transfer_Payment_Amendment_Subtype_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Amendment_Type Transfer_Payment_Amendment_Type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Amendment_Type"
    ADD CONSTRAINT "Transfer_Payment_Amendment_Type_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Financial_Limits Transfer_Payment_Financial_Limits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Financial_Limits"
    ADD CONSTRAINT "Transfer_Payment_Financial_Limits_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Fiscal_Year_Budget Transfer_Payment_Fiscal_Year_Budget_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Fiscal_Year_Budget"
    ADD CONSTRAINT "Transfer_Payment_Fiscal_Year_Budget_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Monitor_Type Transfer_Payment_Monitor_Type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Monitor_Type"
    ADD CONSTRAINT "Transfer_Payment_Monitor_Type_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Objective Transfer_Payment_Objective_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Objective"
    ADD CONSTRAINT "Transfer_Payment_Objective_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Outcome_Performance_Indicator Transfer_Payment_Outcome_Performance_Indicator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Outcome_Performance_Indicator"
    ADD CONSTRAINT "Transfer_Payment_Outcome_Performance_Indicator_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Outcome Transfer_Payment_Outcome_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Outcome"
    ADD CONSTRAINT "Transfer_Payment_Outcome_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Profile Transfer_Payment_Profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Profile"
    ADD CONSTRAINT "Transfer_Payment_Profile_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Stream_Area_of_Expertise Transfer_Payment_Stream_Area_of_Expertise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Area_of_Expertise"
    ADD CONSTRAINT "Transfer_Payment_Stream_Area_of_Expertise_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Stream_Budget Transfer_Payment_Stream_Budget_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Budget"
    ADD CONSTRAINT "Transfer_Payment_Stream_Budget_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Stream_Commitment Transfer_Payment_Stream_Commitment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Commitment"
    ADD CONSTRAINT "Transfer_Payment_Stream_Commitment_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Stream_Cost_Category_Line_Item Transfer_Payment_Stream_Cost_Category_Line_Item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Cost_Category_Line_Item"
    ADD CONSTRAINT "Transfer_Payment_Stream_Cost_Category_Line_Item_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Stream_Eligible_Recipient Transfer_Payment_Stream_Eligible_Recipient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Eligible_Recipient"
    ADD CONSTRAINT "Transfer_Payment_Stream_Eligible_Recipient_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Stream_Outcome Transfer_Payment_Stream_Outcome_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Outcome"
    ADD CONSTRAINT "Transfer_Payment_Stream_Outcome_pkey" PRIMARY KEY (id);


--
-- Name: Transfer_Payment_Stream Transfer_Payment_Stream_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream"
    ADD CONSTRAINT "Transfer_Payment_Stream_pkey" PRIMARY KEY (id);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: entity_user_assignment entity_user_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_user_assignment
    ADD CONSTRAINT entity_user_assignment_pkey PRIMARY KEY (id);


--
-- Name: kysely_migration_lock kysely_migration_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kysely_migration_lock
    ADD CONSTRAINT kysely_migration_lock_pkey PRIMARY KEY (id);


--
-- Name: kysely_migration kysely_migration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kysely_migration
    ADD CONSTRAINT kysely_migration_pkey PRIMARY KEY (name);


--
-- Name: role_ability role_ability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_ability
    ADD CONSTRAINT role_ability_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: role_transfer_payment_scope role_transfer_payment_scope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_transfer_payment_scope
    ADD CONSTRAINT role_transfer_payment_scope_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: session session_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_token_key UNIQUE (token);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_role_assignment user_role_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_assignment
    ADD CONSTRAINT user_role_assignment_pkey PRIMARY KEY (id);


--
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (id);


--
-- Name: ar_idx_addressaddress; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ar_idx_addressaddress ON public."Applicant_Recipient_Address" USING btree (egcs_ar_applicantrecipient, egcs_ar_address) WHERE (_deleted = false);


--
-- Name: ar_idx_agencyfinancialidagencyfinancialsystemid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ar_idx_agencyfinancialidagencyfinancialsystemid ON public."Applicant_Recipient_Agency_Financial_Id" USING btree (egcs_ar_agency, egcs_ar_applicantrecipient, egcs_ar_financialsystemid) WHERE (_deleted = false);


--
-- Name: ar_idx_contactcontact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ar_idx_contactcontact ON public."Applicant_Recipient_Contact" USING btree (egcs_ar_applicantrecipient, egcs_ar_contact) WHERE (_deleted = false);


--
-- Name: ar_idx_othernameothername; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ar_idx_othernameothername ON public."Applicant_Recipient_Other_Name" USING btree (egcs_ar_applicantrecipient, egcs_ar_othername) WHERE (_deleted = false);


--
-- Name: ar_idx_profilebusinessnumber; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ar_idx_profilebusinessnumber ON public."Applicant_Recipient_Profile" USING btree (egcs_ar_businessnumber) WHERE ((_deleted = false) AND (egcs_ar_businessnumber IS NOT NULL));


--
-- Name: ar_idx_teamteammember; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ar_idx_teamteammember ON public."Applicant_Recipient_Team" USING btree (egcs_ar_applicantrecipient, egcs_ar_teammember) WHERE (_deleted = false);


--
-- Name: ay_idx_addresstypeorganizationagencytypenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_addresstypeorganizationagencytypenameen ON public."Agency_Address_Type" USING btree (egcs_ay_organizationagency, egcs_ay_typename_en) WHERE (_deleted = false);


--
-- Name: ay_idx_addresstypeorganizationagencytypenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_addresstypeorganizationagencytypenamefr ON public."Agency_Address_Type" USING btree (egcs_ay_organizationagency, egcs_ay_typename_fr) WHERE (_deleted = false);


--
-- Name: ay_idx_agreementtypeorganizationagencyagreementtypenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_agreementtypeorganizationagencyagreementtypenameen ON public."Agency_Agreement_Type" USING btree (egcs_ay_organizationagency, egcs_ay_agreementtype, egcs_ay_name_en) WHERE (_deleted = false);


--
-- Name: ay_idx_agreementtypeorganizationagencyagreementtypenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_agreementtypeorganizationagencyagreementtypenamefr ON public."Agency_Agreement_Type" USING btree (egcs_ay_organizationagency, egcs_ay_agreementtype, egcs_ay_name_fr) WHERE (_deleted = false);


--
-- Name: ay_idx_approvalbehalftypeorganizationagencynameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_approvalbehalftypeorganizationagencynameen ON public."Agency_Approval_Behalf_Type" USING btree (egcs_ay_organizationagency, egcs_ay_name_en) WHERE (_deleted = false);


--
-- Name: ay_idx_approvalbehalftypeorganizationagencynamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_approvalbehalftypeorganizationagencynamefr ON public."Agency_Approval_Behalf_Type" USING btree (egcs_ay_organizationagency, egcs_ay_name_fr) WHERE (_deleted = false);


--
-- Name: ay_idx_costcategorylineitemorganizationcostcategorynameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_costcategorylineitemorganizationcostcategorynameen ON public."Agency_Cost_Category_Line_Item" USING btree (egcs_ay_organizationcostcategory, egcs_ay_name_en) WHERE (_deleted = false);


--
-- Name: ay_idx_costcategorylineitemorganizationcostcategorynamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_costcategorylineitemorganizationcostcategorynamefr ON public."Agency_Cost_Category_Line_Item" USING btree (egcs_ay_organizationcostcategory, egcs_ay_name_fr) WHERE (_deleted = false);


--
-- Name: ay_idx_costcategoryorganizationagencynameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_costcategoryorganizationagencynameen ON public."Agency_Cost_Category" USING btree (egcs_ay_organizationagency, egcs_ay_name_en) WHERE (_deleted = false);


--
-- Name: ay_idx_costcategoryorganizationagencynamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_costcategoryorganizationagencynamefr ON public."Agency_Cost_Category" USING btree (egcs_ay_organizationagency, egcs_ay_name_fr) WHERE (_deleted = false);


--
-- Name: ay_idx_fiscalyearorganizationagencyfiscalyear; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_fiscalyearorganizationagencyfiscalyear ON public."Agency_Fiscal_Year" USING btree (egcs_ay_organizationagency, egcs_ay_fiscalyear) WHERE (_deleted = false);


--
-- Name: ay_idx_fiscalyearorganizationagencyfiscalyeardisplay; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_fiscalyearorganizationagencyfiscalyeardisplay ON public."Agency_Fiscal_Year" USING btree (egcs_ay_organizationagency, egcs_ay_fiscalyeardisplay) WHERE (_deleted = false);


--
-- Name: ay_idx_profileagencyfinancialsystemidnameennamefrstatus; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_profileagencyfinancialsystemidnameennamefrstatus ON public."Agency_Profile" USING btree (egcs_ay_agencyfinancialsystemid, egcs_ay_name_en, egcs_ay_name_fr, egcs_ay_status) WHERE (_deleted = false);


--
-- Name: ay_idx_profilenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ay_idx_profilenameen ON public."Agency_Profile" USING btree (egcs_ay_name_en) WHERE (_deleted = false);


--
-- Name: ay_idx_profilenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ay_idx_profilenamefr ON public."Agency_Profile" USING btree (egcs_ay_name_fr) WHERE (_deleted = false);


--
-- Name: ay_idx_uniqueartypeen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_uniqueartypeen ON public."Agency_Applicant_Recipient_Subtype" USING btree (egcs_ay_organizationagency, egcs_ay_applicantrecipienttype, egcs_ay_name_en) WHERE (_deleted = false);


--
-- Name: ay_idx_uniqueartypefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ay_idx_uniqueartypefr ON public."Agency_Applicant_Recipient_Subtype" USING btree (egcs_ay_organizationagency, egcs_ay_applicantrecipienttype, egcs_ay_name_fr) WHERE (_deleted = false);


--
-- Name: cn_idx_additionalreviewersentitytypeentityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cn_idx_additionalreviewersentitytypeentityid ON public."Common_Additional_Reviewers" USING btree (egcs_cn_entitytype, egcs_cn_entityid) WHERE (_deleted = false);


--
-- Name: cn_idx_approvalroutingslipsequence; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_approvalroutingslipsequence ON public."Common_Approval" USING btree (egcs_cn_routingslip, egcs_cn_sequence);


--
-- Name: cn_idx_approvalstepapprovaltemplatenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_approvalstepapprovaltemplatenameen ON public."Common_Approval_Step" USING btree (egcs_cn_approvaltemplate, egcs_cn_name_en) WHERE (_deleted = false);


--
-- Name: cn_idx_approvalstepapprovaltemplatenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_approvalstepapprovaltemplatenamefr ON public."Common_Approval_Step" USING btree (egcs_cn_approvaltemplate, egcs_cn_name_fr) WHERE (_deleted = false);


--
-- Name: cn_idx_approvaltemplatescopeidentitytype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_approvaltemplatescopeidentitytype ON public."Common_Approval_Template" USING btree (egcs_cn_scopeid, egcs_cn_scopetype, egcs_cn_entitytype) WHERE ((_deleted = false) AND (egcs_cn_entitytype <> ALL (ARRAY['commonreview'::public."Entity_Type", 'commonrecommendation'::public."Entity_Type"])));


--
-- Name: cn_idx_approvaltemplatescopenametypeen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_approvaltemplatescopenametypeen ON public."Common_Approval_Template" USING btree (egcs_cn_scopeid, egcs_cn_scopetype, egcs_cn_name_en) WHERE (_deleted = false);


--
-- Name: cn_idx_approvaltemplatescopenametypefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_approvaltemplatescopenametypefr ON public."Common_Approval_Template" USING btree (egcs_cn_scopeid, egcs_cn_scopetype, egcs_cn_name_fr) WHERE (_deleted = false);


--
-- Name: cn_idx_assessmentcustomoutcomenamereview; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_assessmentcustomoutcomenamereview ON public."Common_Assessment_Custom_Outcome" USING btree (egcs_cn_name, egcs_cn_review);


--
-- Name: cn_idx_assessmentcustomoutcomereview; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cn_idx_assessmentcustomoutcomereview ON public."Common_Assessment_Custom_Outcome" USING btree (egcs_cn_review);


--
-- Name: cn_idx_assessmentoutcomereviewnameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_assessmentoutcomereviewnameen ON public."Common_Assessment_Outcome" USING btree (egcs_cn_review, egcs_cn_name_en);


--
-- Name: cn_idx_assessmentoutcomereviewnamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_assessmentoutcomereviewnamefr ON public."Common_Assessment_Outcome" USING btree (egcs_cn_review, egcs_cn_name_fr);


--
-- Name: cn_idx_attachmentbucketorcontainerobjectkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_attachmentbucketorcontainerobjectkey ON public."Common_Attachment" USING btree (egcs_cn_bucketorcontainer, egcs_cn_objectkey) WHERE (_deleted = false);


--
-- Name: cn_idx_attachmenttypesagencynameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_attachmenttypesagencynameen ON public."Common_Attachment_Types" USING btree (egcs_cn_agency, egcs_cn_name_en) WHERE (_deleted = false);


--
-- Name: cn_idx_attachmenttypesagencynamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_attachmenttypesagencynamefr ON public."Common_Attachment_Types" USING btree (egcs_cn_agency, egcs_cn_name_fr) WHERE (_deleted = false);


--
-- Name: cn_idx_certificationapprovalstepnameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_certificationapprovalstepnameen ON public."Common_Certification" USING btree (egcs_cn_approvalstep, egcs_cn_name_en) WHERE (_deleted = false);


--
-- Name: cn_idx_certificationapprovalstepnamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_certificationapprovalstepnamefr ON public."Common_Certification" USING btree (egcs_cn_approvalstep, egcs_cn_name_fr) WHERE (_deleted = false);


--
-- Name: cn_idx_certificationapprovalsteporder; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_certificationapprovalsteporder ON public."Common_Certification" USING btree (egcs_cn_approvalstep, egcs_cn_order) WHERE (_deleted = false);


--
-- Name: cn_idx_completionentitytypeentityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_completionentitytypeentityid ON public."Common_Completion" USING btree (egcs_cn_entitytype, egcs_cn_entityid) WHERE (_deleted = false);


--
-- Name: cn_idx_contactemail; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_contactemail ON public."Common_Contact" USING btree (egcs_cn_email) WHERE (_deleted = false);


--
-- Name: cn_idx_entityidentitytype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_entityidentitytype ON public."Common_Entity" USING btree (id, egcs_cn_entitytype);


--
-- Name: cn_idx_formschemaagencynameenversion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_formschemaagencynameenversion ON public."Common_Form_Schema" USING btree (egcs_cn_agency, egcs_cn_name_en, egcs_cn_version) WHERE (_deleted = false);


--
-- Name: cn_idx_formschemaagencynamefrversion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_formschemaagencynamefrversion ON public."Common_Form_Schema" USING btree (egcs_cn_agency, egcs_cn_name_fr, egcs_cn_version) WHERE (_deleted = false);


--
-- Name: cn_idx_gwcoanumbernameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_gwcoanumbernameen ON public."Common_GWCOA" USING btree (egcs_cn_number, egcs_cn_name_en) WHERE (_deleted = false);


--
-- Name: cn_idx_gwcoanumbernamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_gwcoanumbernamefr ON public."Common_GWCOA" USING btree (egcs_cn_number, egcs_cn_name_fr) WHERE (_deleted = false);


--
-- Name: cn_idx_recommendationentitytypeentityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_recommendationentitytypeentityid ON public."Common_Recommendation" USING btree (egcs_cn_entitytype, egcs_cn_entityid) WHERE (_deleted = false);


--
-- Name: cn_idx_recommendationschemaagencyentitytype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_recommendationschemaagencyentitytype ON public."Common_Recommendation_Schema" USING btree (egcs_cn_agency, egcs_cn_entitytype) WHERE (_deleted = false);


--
-- Name: cn_idx_recommendationschemaagencyentitytypenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_recommendationschemaagencyentitytypenameen ON public."Common_Recommendation_Schema" USING btree (egcs_cn_agency, egcs_cn_entitytype, egcs_cn_name_en) WHERE (_deleted = false);


--
-- Name: cn_idx_recommendationschemaagencyentitytypenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_recommendationschemaagencyentitytypenamefr ON public."Common_Recommendation_Schema" USING btree (egcs_cn_agency, egcs_cn_entitytype, egcs_cn_name_fr) WHERE (_deleted = false);


--
-- Name: cn_idx_recommendationsetupidentitytype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_recommendationsetupidentitytype ON public."Common_Recommendation_Setup" USING btree (id, egcs_cn_entitytype);


--
-- Name: cn_idx_recommendationsetupscopeidentitytype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_recommendationsetupscopeidentitytype ON public."Common_Recommendation_Setup" USING btree (egcs_cn_scopeid, egcs_cn_entitytype) WHERE ((_deleted = false) AND (egcs_cn_active = true));


--
-- Name: cn_idx_reviewresponseassessmentsectionsubsectionquestion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewresponseassessmentsectionsubsectionquestion ON public."Common_Review_Response" USING btree (egcs_cn_assessment, egcs_cn_section, egcs_cn_subsection, egcs_cn_question);


--
-- Name: cn_idx_reviewreviewset; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cn_idx_reviewreviewset ON public."Common_Review" USING btree (egcs_cn_reviewset);


--
-- Name: cn_idx_reviewschemaagencynameenversion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewschemaagencynameenversion ON public."Common_Review_Schema" USING btree (egcs_cn_agency, egcs_cn_name_en, egcs_cn_version) WHERE (_deleted = false);


--
-- Name: cn_idx_reviewschemaagencynamefrversion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewschemaagencynamefrversion ON public."Common_Review_Schema" USING btree (egcs_cn_agency, egcs_cn_name_fr, egcs_cn_version) WHERE (_deleted = false);


--
-- Name: cn_idx_reviewschemaidentitytype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewschemaidentitytype ON public."Common_Review_Schema" USING btree (id, egcs_cn_entitytype);


--
-- Name: cn_idx_reviewset_active_entity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewset_active_entity ON public."Common_Review_Set" USING btree (egcs_cn_reviewsetsetup, egcs_cn_entitytype, egcs_cn_entityid) WHERE ((_deleted = false) AND (egcs_cn_status <> ALL (ARRAY['complete'::public.statuses, 'approved'::public.statuses, 'denied'::public.statuses, 'withdrawn'::public.statuses, 'cancelled'::public.statuses])));


--
-- Name: cn_idx_reviewsetsetupidentitytype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewsetsetupidentitytype ON public."Common_Review_Set_Setup" USING btree (id, egcs_cn_entitytype);


--
-- Name: cn_idx_reviewsetsetupscopeidentitytypenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewsetsetupscopeidentitytypenameen ON public."Common_Review_Set_Setup" USING btree (egcs_cn_scopeid, egcs_cn_entitytype, egcs_cn_name_en) WHERE ((_deleted = false) AND (egcs_cn_active = true));


--
-- Name: cn_idx_reviewsetsetupscopeidentitytypenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewsetsetupscopeidentitytypenamefr ON public."Common_Review_Set_Setup" USING btree (egcs_cn_scopeid, egcs_cn_entitytype, egcs_cn_name_fr) WHERE ((_deleted = false) AND (egcs_cn_active = true));


--
-- Name: cn_idx_reviewsetsetupscopeidentitytypeorder; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewsetsetupscopeidentitytypeorder ON public."Common_Review_Set_Setup" USING btree (egcs_cn_scopeid, egcs_cn_entitytype, egcs_cn_order) WHERE ((_deleted = false) AND (egcs_cn_active = true));


--
-- Name: cn_idx_reviewsetupreviewsetorder; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_reviewsetupreviewsetorder ON public."Common_Review_Setup" USING btree (egcs_cn_reviewset, egcs_cn_order) WHERE (_deleted = false);


--
-- Name: cn_idx_routingslipentitytypeentityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_routingslipentitytypeentityid ON public."Common_Routing_Slip" USING btree (egcs_cn_entitytype, egcs_cn_entityid) WHERE ((_deleted = false) AND (egcs_cn_status = ANY (ARRAY['draft'::public.approval_status, 'pendingapproval'::public.approval_status, 'approved'::public.approval_status])));


--
-- Name: cn_idx_useremail; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cn_idx_useremail ON public."Common_User" USING btree (egcs_cn_email) WHERE (_deleted = false);


--
-- Name: role_transfer_payment_scope_unique_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX role_transfer_payment_scope_unique_active ON public.role_transfer_payment_scope USING btree (role_id, transfer_payment_profile_id) WHERE (_deleted = false);


--
-- Name: tp_idx_agreementsubtypeidtransferpaymentstream; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_agreementsubtypeidtransferpaymentstream ON public."Transfer_Payment_Agreement_Subtype" USING btree (id, egcs_tp_transferpaymentstream);


--
-- Name: tp_idx_agreementsubtypetransferpaymentstreamagreementtype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_agreementsubtypetransferpaymentstreamagreementtype ON public."Transfer_Payment_Agreement_Subtype" USING btree (egcs_tp_transferpaymentstream, egcs_tp_agreementtype) WHERE (_deleted = false);


--
-- Name: tp_idx_amendmentsubtypetransferpaymentstreamnameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_amendmentsubtypetransferpaymentstreamnameen ON public."Transfer_Payment_Amendment_Subtype" USING btree (egcs_tp_transferpaymentstream, egcs_tp_name_en) WHERE (_deleted = false);


--
-- Name: tp_idx_amendmentsubtypetransferpaymentstreamnamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_amendmentsubtypetransferpaymentstreamnamefr ON public."Transfer_Payment_Amendment_Subtype" USING btree (egcs_tp_transferpaymentstream, egcs_tp_name_fr) WHERE (_deleted = false);


--
-- Name: tp_idx_amendmenttypetransferpaymentstreamnameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_amendmenttypetransferpaymentstreamnameen ON public."Transfer_Payment_Amendment_Type" USING btree (egcs_tp_transferpaymentstream, egcs_tp_name_en) WHERE (_deleted = false);


--
-- Name: tp_idx_amendmenttypetransferpaymentstreamnamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_amendmenttypetransferpaymentstreamnamefr ON public."Transfer_Payment_Amendment_Type" USING btree (egcs_tp_transferpaymentstream, egcs_tp_name_fr) WHERE (_deleted = false);


--
-- Name: tp_idx_financiallimitstransferpaymentstreamstatus; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_financiallimitstransferpaymentstreamstatus ON public."Transfer_Payment_Financial_Limits" USING btree (egcs_tp_transferpaymentstream, egcs_tp_status) WHERE (_deleted = false);


--
-- Name: tp_idx_fiscalyearbudgettransferpaymentprofilefiscalyear; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_fiscalyearbudgettransferpaymentprofilefiscalyear ON public."Transfer_Payment_Fiscal_Year_Budget" USING btree (egcs_tp_transferpaymentprofile, egcs_tp_fiscalyear) WHERE (_deleted = false);


--
-- Name: tp_idx_monitortypetransferpaymentstreamnameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_monitortypetransferpaymentstreamnameen ON public."Transfer_Payment_Monitor_Type" USING btree (egcs_tp_transferpaymentstream, egcs_tp_name_en) WHERE (_deleted = false);


--
-- Name: tp_idx_monitortypetransferpaymentstreamnamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_monitortypetransferpaymentstreamnamefr ON public."Transfer_Payment_Monitor_Type" USING btree (egcs_tp_transferpaymentstream, egcs_tp_name_fr) WHERE (_deleted = false);


--
-- Name: tp_idx_objectivetransferpaymentprofileobjectiveen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_objectivetransferpaymentprofileobjectiveen ON public."Transfer_Payment_Objective" USING btree (egcs_tp_transferpaymentprofile, md5(lower(egcs_tp_objective_en))) WHERE (_deleted = false);


--
-- Name: tp_idx_objectivetransferpaymentprofileobjectivefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_objectivetransferpaymentprofileobjectivefr ON public."Transfer_Payment_Objective" USING btree (egcs_tp_transferpaymentprofile, md5(lower(egcs_tp_objective_fr))) WHERE (_deleted = false);


--
-- Name: tp_idx_outcomeperformanceindicatortransferpaymentoutcomenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_outcomeperformanceindicatortransferpaymentoutcomenameen ON public."Transfer_Payment_Outcome_Performance_Indicator" USING btree (egcs_tp_transferpaymentoutcome, egcs_tp_name_en) WHERE (_deleted = false);


--
-- Name: tp_idx_outcomeperformanceindicatortransferpaymentoutcomenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_outcomeperformanceindicatortransferpaymentoutcomenamefr ON public."Transfer_Payment_Outcome_Performance_Indicator" USING btree (egcs_tp_transferpaymentoutcome, egcs_tp_name_fr) WHERE (_deleted = false);


--
-- Name: tp_idx_outcometransferpaymentprofilenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_outcometransferpaymentprofilenameen ON public."Transfer_Payment_Outcome" USING btree (egcs_tp_transferpaymentprofile, egcs_tp_name_en) WHERE (_deleted = false);


--
-- Name: tp_idx_outcometransferpaymentprofilenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_outcometransferpaymentprofilenamefr ON public."Transfer_Payment_Outcome" USING btree (egcs_tp_transferpaymentprofile, egcs_tp_name_fr) WHERE (_deleted = false);


--
-- Name: tp_idx_profileagencynameennamefrstatus; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_profileagencynameennamefrstatus ON public."Transfer_Payment_Profile" USING btree (egcs_tp_agency, egcs_tp_name_en, egcs_tp_name_fr, egcs_tp_status) WHERE ((_deleted = false) AND (egcs_tp_status = 'active'::public.base_status));


--
-- Name: tp_idx_profilenameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tp_idx_profilenameen ON public."Transfer_Payment_Profile" USING btree (egcs_tp_name_en) WHERE ((_deleted = false) AND (egcs_tp_status = 'active'::public.base_status));


--
-- Name: tp_idx_profilenamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tp_idx_profilenamefr ON public."Transfer_Payment_Profile" USING btree (egcs_tp_name_fr) WHERE ((_deleted = false) AND (egcs_tp_status = 'active'::public.base_status));


--
-- Name: tp_idx_streamareaofexpertisetransferpaymentstreamnameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_streamareaofexpertisetransferpaymentstreamnameen ON public."Transfer_Payment_Stream_Area_of_Expertise" USING btree (egcs_tp_transferpaymentstream, egcs_tp_name_en) WHERE (_deleted = false);


--
-- Name: tp_idx_streamareaofexpertisetransferpaymentstreamnamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_streamareaofexpertisetransferpaymentstreamnamefr ON public."Transfer_Payment_Stream_Area_of_Expertise" USING btree (egcs_tp_transferpaymentstream, egcs_tp_name_fr) WHERE (_deleted = false);


--
-- Name: tp_idx_streambudgettransferpaymentstreamtransferpaymentbudget; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_streambudgettransferpaymentstreamtransferpaymentbudget ON public."Transfer_Payment_Stream_Budget" USING btree (egcs_tp_transferpaymentstream, egcs_tp_transferpaymentbudget) WHERE (_deleted = false);


--
-- Name: tp_idx_streamnameen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tp_idx_streamnameen ON public."Transfer_Payment_Stream" USING btree (egcs_tp_name_en) WHERE ((_deleted = false) AND (egcs_tp_status = 'active'::public.base_status));


--
-- Name: tp_idx_streamnamefr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tp_idx_streamnamefr ON public."Transfer_Payment_Stream" USING btree (egcs_tp_name_fr) WHERE ((_deleted = false) AND (egcs_tp_status = 'active'::public.base_status));


--
-- Name: tp_idx_streamoutcometransferpaymentstreamtransferpaymentoutcome; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_streamoutcometransferpaymentstreamtransferpaymentoutcome ON public."Transfer_Payment_Stream_Outcome" USING btree (egcs_tp_transferpaymentstream, egcs_tp_transferpaymentoutcome) WHERE (_deleted = false);


--
-- Name: tp_idx_streamtransferpaymentprofilenameennamefrstatus; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_streamtransferpaymentprofilenameennamefrstatus ON public."Transfer_Payment_Stream" USING btree (egcs_tp_transferpaymentprofile, egcs_tp_name_en, egcs_tp_name_fr, egcs_tp_status) WHERE ((_deleted = false) AND (egcs_tp_status = 'active'::public.base_status));


--
-- Name: tp_idx_uniqueastreamcostcatline; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_uniqueastreamcostcatline ON public."Transfer_Payment_Stream_Cost_Category_Line_Item" USING btree (egcs_tp_transferpaymentstream, egcs_tp_organizationcostcategory) WHERE (_deleted = false);


--
-- Name: tp_idx_uniquecommitment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_uniquecommitment ON public."Transfer_Payment_Stream_Commitment" USING btree (egcs_tp_transferpaymentstream, egcs_tp_streambudget, egcs_tp_fund, egcs_tp_gl, egcs_tp_gldescription, egcs_tp_fundcentre, egcs_tp_internalorder, egcs_tp_functionalarea, egcs_tp_costcentre) WHERE (_deleted = false);


--
-- Name: tp_idx_uniquestreameligiblerecipient; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tp_idx_uniquestreameligiblerecipient ON public."Transfer_Payment_Stream_Eligible_Recipient" USING btree (egcs_tp_transferpaymentstream, egcs_tp_applicantrecipientsubtype) WHERE (_deleted = false);


--
-- Name: user_role_assignment_unique_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_role_assignment_unique_active ON public.user_role_assignment USING btree (user_id, role_id) WHERE (_deleted = false);


--
-- Name: Common_Approval trg_autopopulate_self_approval; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_autopopulate_self_approval BEFORE UPDATE OF egcs_cn_approvalvalue ON public."Common_Approval" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_autopopulate_self_approval();


--
-- Name: Common_Approval trg_cascade_routingslip_status; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_cascade_routingslip_status AFTER UPDATE OF egcs_cn_approvalvalue ON public."Common_Approval" FOR EACH ROW WHEN ((old.egcs_cn_approvalvalue IS DISTINCT FROM new.egcs_cn_approvalvalue)) EXECUTE FUNCTION public.trg_fn_cascade_routingslip_status();


--
-- Name: Common_Approval trg_enforce_approval_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_enforce_approval_sequence BEFORE UPDATE OF egcs_cn_approvalvalue ON public."Common_Approval" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_enforce_approval_sequence();


--
-- Name: Common_Approval trg_enforce_assigned_user_actions; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_enforce_assigned_user_actions BEFORE UPDATE OF egcs_cn_approvalvalue ON public."Common_Approval" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_enforce_assigned_user_actions();


--
-- Name: Common_Completion trg_enforce_completion_audit_fields; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_enforce_completion_audit_fields BEFORE INSERT OR UPDATE ON public."Common_Completion" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_enforce_completion_audit_fields();


--
-- Name: Common_Approval trg_lock_actioned_approval; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_lock_actioned_approval BEFORE UPDATE ON public."Common_Approval" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_lock_actioned_approval();


--
-- Name: Common_Approval trg_lock_approval_on_terminal_slip; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_lock_approval_on_terminal_slip BEFORE UPDATE ON public."Common_Approval" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_lock_approval_on_terminal_slip();


--
-- Name: Applicant_Recipient_Profile trg_register_applicantrecipient; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_register_applicantrecipient BEFORE INSERT ON public."Applicant_Recipient_Profile" FOR EACH ROW EXECUTE FUNCTION public.register_entity('applicantrecipient');


--
-- Name: Common_Review trg_register_commonreview; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_register_commonreview BEFORE INSERT ON public."Common_Review" FOR EACH ROW EXECUTE FUNCTION public.register_entity('commonreview');


--
-- Name: Transfer_Payment_Stream trg_register_transferpaymentstream; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_register_transferpaymentstream BEFORE INSERT ON public."Transfer_Payment_Stream" FOR EACH ROW EXECUTE FUNCTION public.register_entity('transferpaymentstream');


--
-- Name: Common_Approval trg_require_actual_delegation_detail; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_require_actual_delegation_detail BEFORE UPDATE OF egcs_cn_approvalvalue ON public."Common_Approval" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_require_actual_delegation_detail();


--
-- Name: Common_Approval trg_require_certifications; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_require_certifications BEFORE UPDATE OF egcs_cn_approvalvalue ON public."Common_Approval" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_require_certifications();


--
-- Name: Common_Additional_Reviewers trg_reset_additional_reviewer_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_reset_additional_reviewer_completion BEFORE INSERT OR UPDATE ON public."Common_Additional_Reviewers" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_reset_additional_reviewer_completion();


--
-- Name: Common_Routing_Slip trg_routingslip_forward_status; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_routingslip_forward_status BEFORE UPDATE ON public."Common_Routing_Slip" FOR EACH ROW WHEN ((old.egcs_cn_status IS DISTINCT FROM new.egcs_cn_status)) EXECUTE FUNCTION public.trg_fn_routingslip_forward_status();


--
-- Name: Common_Approval trg_validate_added_step_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_validate_added_step_sequence BEFORE INSERT ON public."Common_Approval" FOR EACH ROW EXECUTE FUNCTION public.trg_fn_validate_added_step_sequence();


--
-- Name: Agency_Address_Type Agency_Address_Type_egcs_ay_organizationagency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Address_Type"
    ADD CONSTRAINT "Agency_Address_Type_egcs_ay_organizationagency_fkey" FOREIGN KEY (egcs_ay_organizationagency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Agency_Agreement_Type Agency_Agreement_Type_egcs_ay_organizationagency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Agreement_Type"
    ADD CONSTRAINT "Agency_Agreement_Type_egcs_ay_organizationagency_fkey" FOREIGN KEY (egcs_ay_organizationagency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Agency_Applicant_Recipient_Subtype Agency_Applicant_Recipient_Subt_egcs_ay_organizationagency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Applicant_Recipient_Subtype"
    ADD CONSTRAINT "Agency_Applicant_Recipient_Subt_egcs_ay_organizationagency_fkey" FOREIGN KEY (egcs_ay_organizationagency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Agency_Approval_Behalf_Type Agency_Approval_Behalf_Type_egcs_ay_organizationagency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Approval_Behalf_Type"
    ADD CONSTRAINT "Agency_Approval_Behalf_Type_egcs_ay_organizationagency_fkey" FOREIGN KEY (egcs_ay_organizationagency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Agency_Cost_Category_Line_Item Agency_Cost_Category_Line_Ite_egcs_ay_organizationcostcate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Cost_Category_Line_Item"
    ADD CONSTRAINT "Agency_Cost_Category_Line_Ite_egcs_ay_organizationcostcate_fkey" FOREIGN KEY (egcs_ay_organizationcostcategory) REFERENCES public."Agency_Cost_Category"(id) ON DELETE RESTRICT;


--
-- Name: Agency_Cost_Category Agency_Cost_Category_egcs_ay_organizationagency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Cost_Category"
    ADD CONSTRAINT "Agency_Cost_Category_egcs_ay_organizationagency_fkey" FOREIGN KEY (egcs_ay_organizationagency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Agency_Fiscal_Year Agency_Fiscal_Year_egcs_ay_organizationagency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Fiscal_Year"
    ADD CONSTRAINT "Agency_Fiscal_Year_egcs_ay_organizationagency_fkey" FOREIGN KEY (egcs_ay_organizationagency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Address Applicant_Recipient_Address_egcs_ar_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Address"
    ADD CONSTRAINT "Applicant_Recipient_Address_egcs_ar_address_fkey" FOREIGN KEY (egcs_ar_address) REFERENCES public."Common_Address"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Address Applicant_Recipient_Address_egcs_ar_applicantrecipient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Address"
    ADD CONSTRAINT "Applicant_Recipient_Address_egcs_ar_applicantrecipient_fkey" FOREIGN KEY (egcs_ar_applicantrecipient) REFERENCES public."Applicant_Recipient_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Agency_Financial_Id Applicant_Recipient_Agency_Fina_egcs_ar_applicantrecipient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Agency_Financial_Id"
    ADD CONSTRAINT "Applicant_Recipient_Agency_Fina_egcs_ar_applicantrecipient_fkey" FOREIGN KEY (egcs_ar_applicantrecipient) REFERENCES public."Applicant_Recipient_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Agency_Financial_Id Applicant_Recipient_Agency_Financial_Id_egcs_ar_agency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Agency_Financial_Id"
    ADD CONSTRAINT "Applicant_Recipient_Agency_Financial_Id_egcs_ar_agency_fkey" FOREIGN KEY (egcs_ar_agency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Contact Applicant_Recipient_Contact_egcs_ar_applicantrecipient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Contact"
    ADD CONSTRAINT "Applicant_Recipient_Contact_egcs_ar_applicantrecipient_fkey" FOREIGN KEY (egcs_ar_applicantrecipient) REFERENCES public."Applicant_Recipient_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Contact Applicant_Recipient_Contact_egcs_ar_contact_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Contact"
    ADD CONSTRAINT "Applicant_Recipient_Contact_egcs_ar_contact_fkey" FOREIGN KEY (egcs_ar_contact) REFERENCES public."Common_Contact"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Other_Name Applicant_Recipient_Other_Name_egcs_ar_applicantrecipient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Other_Name"
    ADD CONSTRAINT "Applicant_Recipient_Other_Name_egcs_ar_applicantrecipient_fkey" FOREIGN KEY (egcs_ar_applicantrecipient) REFERENCES public."Applicant_Recipient_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Profile Applicant_Recipient_Profile_egcs_ar_applicantrecipientsubt_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Profile"
    ADD CONSTRAINT "Applicant_Recipient_Profile_egcs_ar_applicantrecipientsubt_fkey" FOREIGN KEY (egcs_ar_applicantrecipientsubtypes) REFERENCES public."Agency_Applicant_Recipient_Subtype"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Profile Applicant_Recipient_Profile_egcs_ar_leadagency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Profile"
    ADD CONSTRAINT "Applicant_Recipient_Profile_egcs_ar_leadagency_fkey" FOREIGN KEY (egcs_ar_leadagency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Team Applicant_Recipient_Team_egcs_ar_applicantrecipient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Team"
    ADD CONSTRAINT "Applicant_Recipient_Team_egcs_ar_applicantrecipient_fkey" FOREIGN KEY (egcs_ar_applicantrecipient) REFERENCES public."Applicant_Recipient_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Applicant_Recipient_Team Applicant_Recipient_Team_egcs_ar_teammember_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Team"
    ADD CONSTRAINT "Applicant_Recipient_Team_egcs_ar_teammember_fkey" FOREIGN KEY (egcs_ar_teammember) REFERENCES public."user"(id) ON DELETE RESTRICT;


--
-- Name: Common_Additional_Reviewers Common_Additional_Reviewers_egcs_cn_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Additional_Reviewers"
    ADD CONSTRAINT "Common_Additional_Reviewers_egcs_cn_user_fkey" FOREIGN KEY (egcs_cn_user) REFERENCES public."Common_User"(id) ON DELETE RESTRICT;


--
-- Name: Common_Approval_Certification Common_Approval_Certification_egcs_cn_approval_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Certification"
    ADD CONSTRAINT "Common_Approval_Certification_egcs_cn_approval_fkey" FOREIGN KEY (egcs_cn_approval) REFERENCES public."Common_Approval"(id) ON DELETE RESTRICT;


--
-- Name: Common_Approval_Step Common_Approval_Step_egcs_cn_approvaltemplate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Step"
    ADD CONSTRAINT "Common_Approval_Step_egcs_cn_approvaltemplate_fkey" FOREIGN KEY (egcs_cn_approvaltemplate) REFERENCES public."Common_Approval_Template"(id) ON DELETE RESTRICT;


--
-- Name: Common_Approval_Step Common_Approval_Step_egcs_cn_defaultuser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Step"
    ADD CONSTRAINT "Common_Approval_Step_egcs_cn_defaultuser_fkey" FOREIGN KEY (egcs_cn_defaultuser) REFERENCES public."Common_User"(id) ON DELETE RESTRICT;


--
-- Name: Common_Approval Common_Approval_egcs_cn_assigneduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval"
    ADD CONSTRAINT "Common_Approval_egcs_cn_assigneduser_fkey" FOREIGN KEY (egcs_cn_assigneduser) REFERENCES public."Common_User"(id) ON DELETE RESTRICT;


--
-- Name: Common_Approval Common_Approval_egcs_cn_attachment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval"
    ADD CONSTRAINT "Common_Approval_egcs_cn_attachment_fkey" FOREIGN KEY (egcs_cn_attachment) REFERENCES public."Common_Attachment"(id) ON DELETE RESTRICT;


--
-- Name: Common_Approval Common_Approval_egcs_cn_defaultuser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval"
    ADD CONSTRAINT "Common_Approval_egcs_cn_defaultuser_fkey" FOREIGN KEY (egcs_cn_defaultuser) REFERENCES public."Common_User"(id) ON DELETE RESTRICT;


--
-- Name: Common_Approval Common_Approval_egcs_cn_onbehalf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval"
    ADD CONSTRAINT "Common_Approval_egcs_cn_onbehalf_fkey" FOREIGN KEY (egcs_cn_onbehalf) REFERENCES public."Agency_Approval_Behalf_Type"(id) ON DELETE RESTRICT;


--
-- Name: Common_Approval Common_Approval_egcs_cn_routingslip_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval"
    ADD CONSTRAINT "Common_Approval_egcs_cn_routingslip_fkey" FOREIGN KEY (egcs_cn_routingslip) REFERENCES public."Common_Routing_Slip"(id) ON DELETE RESTRICT;


--
-- Name: Common_Assessment_Custom_Outcome Common_Assessment_Custom_Outcome_egcs_cn_review_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Assessment_Custom_Outcome"
    ADD CONSTRAINT "Common_Assessment_Custom_Outcome_egcs_cn_review_fkey" FOREIGN KEY (egcs_cn_review) REFERENCES public."Common_Review"(id) ON DELETE RESTRICT;


--
-- Name: Common_Assessment_Outcome Common_Assessment_Outcome_egcs_cn_review_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Assessment_Outcome"
    ADD CONSTRAINT "Common_Assessment_Outcome_egcs_cn_review_fkey" FOREIGN KEY (egcs_cn_review) REFERENCES public."Common_Review"(id) ON DELETE RESTRICT;


--
-- Name: Common_Attachment_Types Common_Attachment_Types_egcs_cn_agency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Attachment_Types"
    ADD CONSTRAINT "Common_Attachment_Types_egcs_cn_agency_fkey" FOREIGN KEY (egcs_cn_agency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Common_Attachment Common_Attachment_egcs_cn_attachmenttype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Attachment"
    ADD CONSTRAINT "Common_Attachment_egcs_cn_attachmenttype_fkey" FOREIGN KEY (egcs_cn_attachmenttype) REFERENCES public."Common_Attachment_Types"(id) ON DELETE RESTRICT;


--
-- Name: Common_Certification Common_Certification_egcs_cn_approvalstep_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Certification"
    ADD CONSTRAINT "Common_Certification_egcs_cn_approvalstep_fkey" FOREIGN KEY (egcs_cn_approvalstep) REFERENCES public."Common_Approval_Step"(id) ON DELETE RESTRICT;


--
-- Name: Common_Completion Common_Completion_egcs_cn_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Completion"
    ADD CONSTRAINT "Common_Completion_egcs_cn_user_fkey" FOREIGN KEY (egcs_cn_user) REFERENCES public."Common_User"(id) ON DELETE RESTRICT;


--
-- Name: Common_Form_Schema Common_Form_Schema_egcs_cn_agency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Form_Schema"
    ADD CONSTRAINT "Common_Form_Schema_egcs_cn_agency_fkey" FOREIGN KEY (egcs_cn_agency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Common_Recommendation_Schema Common_Recommendation_Schema_egcs_cn_agency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation_Schema"
    ADD CONSTRAINT "Common_Recommendation_Schema_egcs_cn_agency_fkey" FOREIGN KEY (egcs_cn_agency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Common_Recommendation_Setup Common_Recommendation_Setup_egcs_cn_approvaltemplate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation_Setup"
    ADD CONSTRAINT "Common_Recommendation_Setup_egcs_cn_approvaltemplate_fkey" FOREIGN KEY (egcs_cn_approvaltemplate) REFERENCES public."Common_Approval_Template"(id) ON DELETE RESTRICT;


--
-- Name: Common_Recommendation_Setup Common_Recommendation_Setup_egcs_cn_schema_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation_Setup"
    ADD CONSTRAINT "Common_Recommendation_Setup_egcs_cn_schema_fkey" FOREIGN KEY (egcs_cn_schema) REFERENCES public."Common_Recommendation_Schema"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review_Response Common_Review_Response_egcs_cn_assessment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Response"
    ADD CONSTRAINT "Common_Review_Response_egcs_cn_assessment_fkey" FOREIGN KEY (egcs_cn_assessment) REFERENCES public."Common_Review"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review_Schema Common_Review_Schema_egcs_cn_agency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Schema"
    ADD CONSTRAINT "Common_Review_Schema_egcs_cn_agency_fkey" FOREIGN KEY (egcs_cn_agency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review_Set_Setup Common_Review_Set_Setup_egcs_cn_approvaltemplate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set_Setup"
    ADD CONSTRAINT "Common_Review_Set_Setup_egcs_cn_approvaltemplate_fkey" FOREIGN KEY (egcs_cn_approvaltemplate) REFERENCES public."Common_Approval_Template"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review_Set Common_Review_Set_egcs_cn_approvaltemplate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set"
    ADD CONSTRAINT "Common_Review_Set_egcs_cn_approvaltemplate_fkey" FOREIGN KEY (egcs_cn_approvaltemplate) REFERENCES public."Common_Approval_Template"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review_Setup Common_Review_Setup_egcs_cn_approvaltemplate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Setup"
    ADD CONSTRAINT "Common_Review_Setup_egcs_cn_approvaltemplate_fkey" FOREIGN KEY (egcs_cn_approvaltemplate) REFERENCES public."Common_Approval_Template"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review Common_Review_egcs_cn_approvaltemplate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review"
    ADD CONSTRAINT "Common_Review_egcs_cn_approvaltemplate_fkey" FOREIGN KEY (egcs_cn_approvaltemplate) REFERENCES public."Common_Approval_Template"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review Common_Review_egcs_cn_reviewschema_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review"
    ADD CONSTRAINT "Common_Review_egcs_cn_reviewschema_fkey" FOREIGN KEY (egcs_cn_reviewschema) REFERENCES public."Common_Review_Schema"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review Common_Review_egcs_cn_reviewset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review"
    ADD CONSTRAINT "Common_Review_egcs_cn_reviewset_fkey" FOREIGN KEY (egcs_cn_reviewset) REFERENCES public."Common_Review_Set"(id) ON DELETE RESTRICT;


--
-- Name: Common_Routing_Slip Common_Routing_Slip_egcs_cn_approvaltemplate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Routing_Slip"
    ADD CONSTRAINT "Common_Routing_Slip_egcs_cn_approvaltemplate_fkey" FOREIGN KEY (egcs_cn_approvaltemplate) REFERENCES public."Common_Approval_Template"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Agreement_Subtype Transfer_Payment_Agreement_Su_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Agreement_Subtype"
    ADD CONSTRAINT "Transfer_Payment_Agreement_Su_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Agreement_Subtype Transfer_Payment_Agreement_Subtype_egcs_tp_agreementtype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Agreement_Subtype"
    ADD CONSTRAINT "Transfer_Payment_Agreement_Subtype_egcs_tp_agreementtype_fkey" FOREIGN KEY (egcs_tp_agreementtype) REFERENCES public."Agency_Agreement_Type"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Amendment_Subtype Transfer_Payment_Amendment_Su_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Amendment_Subtype"
    ADD CONSTRAINT "Transfer_Payment_Amendment_Su_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Amendment_Subtype Transfer_Payment_Amendment_Subtype_egcs_tp_amendedtype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Amendment_Subtype"
    ADD CONSTRAINT "Transfer_Payment_Amendment_Subtype_egcs_tp_amendedtype_fkey" FOREIGN KEY (egcs_tp_amendedtype) REFERENCES public."Transfer_Payment_Amendment_Type"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Amendment_Type Transfer_Payment_Amendment_Ty_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Amendment_Type"
    ADD CONSTRAINT "Transfer_Payment_Amendment_Ty_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Financial_Limits Transfer_Payment_Financial_Li_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Financial_Limits"
    ADD CONSTRAINT "Transfer_Payment_Financial_Li_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Fiscal_Year_Budget Transfer_Payment_Fiscal_Year_Budget_egcs_tp_fiscalyear_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Fiscal_Year_Budget"
    ADD CONSTRAINT "Transfer_Payment_Fiscal_Year_Budget_egcs_tp_fiscalyear_fkey" FOREIGN KEY (egcs_tp_fiscalyear) REFERENCES public."Agency_Fiscal_Year"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Fiscal_Year_Budget Transfer_Payment_Fiscal_Year__egcs_tp_transferpaymentprofi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Fiscal_Year_Budget"
    ADD CONSTRAINT "Transfer_Payment_Fiscal_Year__egcs_tp_transferpaymentprofi_fkey" FOREIGN KEY (egcs_tp_transferpaymentprofile) REFERENCES public."Transfer_Payment_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Monitor_Type Transfer_Payment_Monitor_Type_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Monitor_Type"
    ADD CONSTRAINT "Transfer_Payment_Monitor_Type_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Objective Transfer_Payment_Objective_egcs_tp_transferpaymentprofile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Objective"
    ADD CONSTRAINT "Transfer_Payment_Objective_egcs_tp_transferpaymentprofile_fkey" FOREIGN KEY (egcs_tp_transferpaymentprofile) REFERENCES public."Transfer_Payment_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Outcome_Performance_Indicator Transfer_Payment_Outcome_Perf_egcs_tp_transferpaymentoutco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Outcome_Performance_Indicator"
    ADD CONSTRAINT "Transfer_Payment_Outcome_Perf_egcs_tp_transferpaymentoutco_fkey" FOREIGN KEY (egcs_tp_transferpaymentoutcome) REFERENCES public."Transfer_Payment_Outcome"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Outcome Transfer_Payment_Outcome_egcs_tp_transferpaymentprofile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Outcome"
    ADD CONSTRAINT "Transfer_Payment_Outcome_egcs_tp_transferpaymentprofile_fkey" FOREIGN KEY (egcs_tp_transferpaymentprofile) REFERENCES public."Transfer_Payment_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Profile Transfer_Payment_Profile_egcs_tp_agency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Profile"
    ADD CONSTRAINT "Transfer_Payment_Profile_egcs_tp_agency_fkey" FOREIGN KEY (egcs_tp_agency) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Area_of_Expertise Transfer_Payment_Stream_Area__egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Area_of_Expertise"
    ADD CONSTRAINT "Transfer_Payment_Stream_Area__egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Budget Transfer_Payment_Stream_Budge_egcs_tp_transferpaymentbudge_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Budget"
    ADD CONSTRAINT "Transfer_Payment_Stream_Budge_egcs_tp_transferpaymentbudge_fkey" FOREIGN KEY (egcs_tp_transferpaymentbudget) REFERENCES public."Transfer_Payment_Fiscal_Year_Budget"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Budget Transfer_Payment_Stream_Budge_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Budget"
    ADD CONSTRAINT "Transfer_Payment_Stream_Budge_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Commitment Transfer_Payment_Stream_Commi_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Commitment"
    ADD CONSTRAINT "Transfer_Payment_Stream_Commi_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Commitment Transfer_Payment_Stream_Commitment_egcs_tp_streambudget_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Commitment"
    ADD CONSTRAINT "Transfer_Payment_Stream_Commitment_egcs_tp_streambudget_fkey" FOREIGN KEY (egcs_tp_streambudget) REFERENCES public."Transfer_Payment_Stream_Budget"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Cost_Category_Line_Item Transfer_Payment_Stream_Cost__egcs_tp_organizationcostcate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Cost_Category_Line_Item"
    ADD CONSTRAINT "Transfer_Payment_Stream_Cost__egcs_tp_organizationcostcate_fkey" FOREIGN KEY (egcs_tp_organizationcostcategory) REFERENCES public."Agency_Cost_Category_Line_Item"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Cost_Category_Line_Item Transfer_Payment_Stream_Cost__egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Cost_Category_Line_Item"
    ADD CONSTRAINT "Transfer_Payment_Stream_Cost__egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Eligible_Recipient Transfer_Payment_Stream_Eligi_egcs_tp_applicantrecipientsu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Eligible_Recipient"
    ADD CONSTRAINT "Transfer_Payment_Stream_Eligi_egcs_tp_applicantrecipientsu_fkey" FOREIGN KEY (egcs_tp_applicantrecipientsubtype) REFERENCES public."Agency_Applicant_Recipient_Subtype"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Eligible_Recipient Transfer_Payment_Stream_Eligi_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Eligible_Recipient"
    ADD CONSTRAINT "Transfer_Payment_Stream_Eligi_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Outcome Transfer_Payment_Stream_Outco_egcs_tp_transferpaymentoutco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Outcome"
    ADD CONSTRAINT "Transfer_Payment_Stream_Outco_egcs_tp_transferpaymentoutco_fkey" FOREIGN KEY (egcs_tp_transferpaymentoutcome) REFERENCES public."Transfer_Payment_Outcome"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream_Outcome Transfer_Payment_Stream_Outco_egcs_tp_transferpaymentstrea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream_Outcome"
    ADD CONSTRAINT "Transfer_Payment_Stream_Outco_egcs_tp_transferpaymentstrea_fkey" FOREIGN KEY (egcs_tp_transferpaymentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream Transfer_Payment_Stream_egcs_tp_parentstream_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream"
    ADD CONSTRAINT "Transfer_Payment_Stream_egcs_tp_parentstream_fkey" FOREIGN KEY (egcs_tp_parentstream) REFERENCES public."Transfer_Payment_Stream"(id) ON DELETE RESTRICT;


--
-- Name: Transfer_Payment_Stream Transfer_Payment_Stream_egcs_tp_transferpaymentprofile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream"
    ADD CONSTRAINT "Transfer_Payment_Stream_egcs_tp_transferpaymentprofile_fkey" FOREIGN KEY (egcs_tp_transferpaymentprofile) REFERENCES public."Transfer_Payment_Profile"(id) ON DELETE RESTRICT;


--
-- Name: account account_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: Applicant_Recipient_Profile ar_ref_profileid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Applicant_Recipient_Profile"
    ADD CONSTRAINT ar_ref_profileid FOREIGN KEY (id) REFERENCES public."Common_Entity"(id) ON DELETE RESTRICT;


--
-- Name: Agency_Profile ay_ref_profilegwcoanumber; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Agency_Profile"
    ADD CONSTRAINT ay_ref_profilegwcoanumber FOREIGN KEY (egcs_ay_gwcoa_number) REFERENCES public."Common_GWCOA"(egcs_cn_number) ON DELETE RESTRICT;


--
-- Name: Common_Review_Set cn_fk_reviewset_setup; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set"
    ADD CONSTRAINT cn_fk_reviewset_setup FOREIGN KEY (egcs_cn_reviewsetsetup, egcs_cn_entitytype) REFERENCES public."Common_Review_Set_Setup"(id, egcs_cn_entitytype) ON DELETE RESTRICT;


--
-- Name: Common_Additional_Reviewers cn_ref_additionalreviewersentityidentitytype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Additional_Reviewers"
    ADD CONSTRAINT cn_ref_additionalreviewersentityidentitytype FOREIGN KEY (egcs_cn_entityid, egcs_cn_entitytype) REFERENCES public."Common_Entity"(id, egcs_cn_entitytype);


--
-- Name: Common_Approval_Template cn_ref_approvaltemplatescopeidscopetype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Approval_Template"
    ADD CONSTRAINT cn_ref_approvaltemplatescopeidscopetype FOREIGN KEY (egcs_cn_scopeid, egcs_cn_scopetype) REFERENCES public."Common_Entity"(id, egcs_cn_entitytype);


--
-- Name: Common_Completion cn_ref_completionentityidentitytype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Completion"
    ADD CONSTRAINT cn_ref_completionentityidentitytype FOREIGN KEY (egcs_cn_entityid, egcs_cn_entitytype) REFERENCES public."Common_Entity"(id, egcs_cn_entitytype);


--
-- Name: Common_Recommendation cn_ref_recommendationentityidentitytype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation"
    ADD CONSTRAINT cn_ref_recommendationentityidentitytype FOREIGN KEY (egcs_cn_entityid, egcs_cn_entitytype) REFERENCES public."Common_Entity"(id, egcs_cn_entitytype);


--
-- Name: Common_Recommendation cn_ref_recommendationrecommendationsetupentitytype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation"
    ADD CONSTRAINT cn_ref_recommendationrecommendationsetupentitytype FOREIGN KEY (egcs_cn_recommendationsetup, egcs_cn_entitytype) REFERENCES public."Common_Recommendation_Setup"(id, egcs_cn_entitytype);


--
-- Name: Common_Recommendation_Setup cn_ref_recommendationsetupscopeidscopetype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Recommendation_Setup"
    ADD CONSTRAINT cn_ref_recommendationsetupscopeidscopetype FOREIGN KEY (egcs_cn_scopeid, egcs_cn_scopetype) REFERENCES public."Common_Entity"(id, egcs_cn_entitytype);


--
-- Name: Common_Review cn_ref_reviewid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review"
    ADD CONSTRAINT cn_ref_reviewid FOREIGN KEY (id) REFERENCES public."Common_Entity"(id) ON DELETE RESTRICT;


--
-- Name: Common_Review_Set cn_ref_reviewsetentityidentitytype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set"
    ADD CONSTRAINT cn_ref_reviewsetentityidentitytype FOREIGN KEY (egcs_cn_entityid, egcs_cn_entitytype) REFERENCES public."Common_Entity"(id, egcs_cn_entitytype);


--
-- Name: Common_Review_Set_Setup cn_ref_reviewsetsetupscopeidscopetype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Set_Setup"
    ADD CONSTRAINT cn_ref_reviewsetsetupscopeidscopetype FOREIGN KEY (egcs_cn_scopeid, egcs_cn_scopetype) REFERENCES public."Common_Entity"(id, egcs_cn_entitytype);


--
-- Name: Common_Review_Setup cn_ref_reviewsetupreviewschemaentitytype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Setup"
    ADD CONSTRAINT cn_ref_reviewsetupreviewschemaentitytype FOREIGN KEY (egcs_cn_reviewschema, egcs_cn_entitytype) REFERENCES public."Common_Review_Schema"(id, egcs_cn_entitytype);


--
-- Name: Common_Review_Setup cn_ref_reviewsetupreviewsetentitytype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Review_Setup"
    ADD CONSTRAINT cn_ref_reviewsetupreviewsetentitytype FOREIGN KEY (egcs_cn_reviewset, egcs_cn_entitytype) REFERENCES public."Common_Review_Set_Setup"(id, egcs_cn_entitytype);


--
-- Name: Common_Routing_Slip cn_ref_routingslipentityidentitytype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Common_Routing_Slip"
    ADD CONSTRAINT cn_ref_routingslipentityidentitytype FOREIGN KEY (egcs_cn_entityid, egcs_cn_entitytype) REFERENCES public."Common_Entity"(id, egcs_cn_entitytype);


--
-- Name: entity_user_assignment entity_user_assignment_agency_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_user_assignment
    ADD CONSTRAINT entity_user_assignment_agency_fk FOREIGN KEY (agency_id) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: entity_user_assignment entity_user_assignment_transfer_payment_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_user_assignment
    ADD CONSTRAINT entity_user_assignment_transfer_payment_fk FOREIGN KEY (transfer_payment_id) REFERENCES public."Transfer_Payment_Profile"(id) ON DELETE RESTRICT;


--
-- Name: entity_user_assignment entity_user_assignment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_user_assignment
    ADD CONSTRAINT entity_user_assignment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: role_ability role_ability_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_ability
    ADD CONSTRAINT role_ability_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id) ON DELETE CASCADE;


--
-- Name: role role_agency_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_agency_fk FOREIGN KEY (agency_id) REFERENCES public."Agency_Profile"(id) ON DELETE RESTRICT;


--
-- Name: role_transfer_payment_scope role_transfer_payment_scope_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_transfer_payment_scope
    ADD CONSTRAINT role_transfer_payment_scope_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id) ON DELETE CASCADE;


--
-- Name: role_transfer_payment_scope role_transfer_payment_scope_transfer_payment_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_transfer_payment_scope
    ADD CONSTRAINT role_transfer_payment_scope_transfer_payment_profile_id_fkey FOREIGN KEY (transfer_payment_profile_id) REFERENCES public."Transfer_Payment_Profile"(id) ON DELETE RESTRICT;


--
-- Name: session session_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: Transfer_Payment_Stream tp_ref_streamid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transfer_Payment_Stream"
    ADD CONSTRAINT tp_ref_streamid FOREIGN KEY (id) REFERENCES public."Common_Entity"(id) ON DELETE RESTRICT;


--
-- Name: user_role_assignment user_role_assignment_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_assignment
    ADD CONSTRAINT user_role_assignment_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id) ON DELETE CASCADE;


--
-- Name: user_role_assignment user_role_assignment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_assignment
    ADD CONSTRAINT user_role_assignment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

