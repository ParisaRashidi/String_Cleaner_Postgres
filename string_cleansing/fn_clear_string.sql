create or replace function fn_clear_string(inputstr text)
  returns character
language plpgsql
as $$
DECLARE
  i          int;
  c          text;
  result_str text;
BEGIN
  result_str := '';
  i := 0;
  if inputstr is null then result_str = null; return result_str;
  else
      LOOP
        exit when i > length(inputstr);
        i := i + 1;
        c := substr(inputstr, i, 1);
        if c in (
          chr(x'060C' :: int), -- Arabic Comma
          chr(x'061B' :: int), -- Arabic Semicolon
          chr(x'061F' :: int), -- Arabic Question Mark
          chr(x'0621' :: int), -- Arabic Hamza 
          chr(x'0640' :: int), -- Arabic Tatweel 
          chr(x'064B' :: int), -- Arabic FATHATAN
          chr(x'064C' :: int), -- Arabic DAMMATAN
          chr(x'064D' :: int), -- Arabic KASRATAN
          chr(x'064E' :: int), -- Arabic FATHA
          chr(x'064F' :: int), -- Arabic DAMMA
          chr(x'0650' :: int), -- Arabic KASRA
          chr(x'0651' :: int), -- Arabic SHADDA
          chr(x'0652' :: int), -- Arabic SUKUN
          chr(x'0653' :: int), -- Persian Mad
          chr(x'0654' :: int), -- Persian Hamza Bala
          chr(x'0655' :: int), -- Persian Hamza Paein
          chr(x'066A' :: int), -- Persian Percent
          chr(x'066B' :: int), -- Persian Momayez
          chr(x'066C' :: int), -- Persian 1000 Separator
          chr(x'0670' :: int), -- Alef Maghsooreh
          chr(x'06C0' :: int)   -- Ordoo Hamza Heh
        )
        then continue;
        end if;

        if ascii(c) between x'06F0' :: int and x'06F9' :: int
        then -- Arabic Digits
          c := chr(ascii(c) - 1728); -- English Digits
        end if;

        if ascii(c) between x'0660' :: int and x'669' :: int
        then -- Persian Digits
          c := chr(ascii(c) - 1584); -- English Digits
        end if;

        if c in (chr(x'0622' :: int), chr(x'0623' :: int), chr(x'0625' :: int), chr(x'0671' :: int))
        then
          c := chr(x'0627' :: int); --(Alef)
        end if;

        if c in (chr(x'0626' :: int), chr(x'0649' :: int), chr(x'064A' :: int), chr(x'06D2' :: int))
        then
          c := chr(x'06CC' :: int); 
        end if;

        if c = chr(x'0643' :: int)
        then
          c := chr(x'06A9' :: int); 
        end if;

        if c in (chr(x'06BE' :: int), chr(x'06C1' :: int), chr(x'0629' :: int))
        then
          c := chr(x'0647' :: int); 
        end if;

        if c = chr(x'0624' :: int)
        then
          c := chr(x'0648' :: int); 
        end if;

        if (ascii(c) not between x'0622' :: int and x'06F9' :: int)
           and c not between  'A' and  'Z'  -- English Capital Letters
           and c not between  'a' and  'z'  -- English Non-Capital Letters
           and c not between  '0' and  '9'  -- English Digits

        then continue;
        end if;

        result_str := result_str || c;

        END LOOP;
        RETURN result_str;
        End if;
END;

$$;

