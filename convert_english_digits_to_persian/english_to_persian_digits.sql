CREATE OR REPLACE FUNCTION fn_english_to_persian_digit (inputstr text)
    RETURNS character
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE
    AS $BODY$
DECLARE
    i int;
    c text;
    result_str text;
BEGIN
    IF inputstr IS NULL THEN
        result_str = NULL;
        RETURN result_str;
    ELSE
        result_str := '';
        i := 0;
        LOOP
            exit
            WHEN i > length(inputstr);
            i := i + 1;
            c := substr(inputstr, i, 1);
            IF ascii(c) BETWEEN 48 AND 57 THEN
                -- ENGlISH Digits c := chr(ascii(c) + 1728);
                -- PERSIAN Digits
            END IF;
            result_str := result_str || c;
        END LOOP;
        RETURN result_str;
    END IF;
END;
$BODY$;
