
CREATE SCHEMA IF NOT EXISTS ecommerce;
GRANT ALL PRIVILEGES ON SCHEMA ecommerce TO admin;

DO $$
BEGIN
    -- Crear tabla user_information
    EXECUTE '
    CREATE TABLE IF NOT EXISTS ecommerce."user_information"
    (
        "pkid_user_information" int NOT NULL,
        PRIMARY KEY (pkid_user_information),
		creation_date timestamp with time zone,
        "expiration_date" timestamp with time zone,
        "first_name" varchar(30),
        "last_name" varchar(30),
        "indicative" varchar(5),
        "phone" numeric,
        "email" varchar(50),
        "addres" varchar(50)
    )';
    RAISE NOTICE 'Tabla ecommerce.user_information creada correctamente';

    -- Crear tabla user
    EXECUTE '
    CREATE TABLE IF NOT EXISTS ecommerce."user"
    (
        "pkid_user" int NOT NULL,
        PRIMARY KEY (pkid_user),
		creation_date timestamp with time zone,
        "expiration_date" timestamp with time zone,
        "user" varchar(30),
        "password" varchar(32),
        "fk_pkid_user_information" int,
        CONSTRAINT fk_pkid_user_information
            FOREIGN KEY(fk_pkid_user_information) 
            REFERENCES ecommerce."user_information"(pkid_user_information),
        "number_attempts" int
    )';
    RAISE NOTICE 'Tabla ecommerce.user creada correctamente';

    -- Crear tabla user_rol
    EXECUTE '
    CREATE TABLE IF NOT EXISTS ecommerce."user_rol"
    (
        "pkid_user_rol" int NOT NULL,
        PRIMARY KEY (pkid_user_rol),
		creation_date timestamp with time zone,
        "expiration_date" timestamp with time zone,
        "rol_name" varchar(20),
        "description" varchar(30)
    )';
    RAISE NOTICE 'Tabla ecommerce.user_rol creada correctamente';

    -- Crear tabla role_relationship
    EXECUTE '
    CREATE TABLE IF NOT EXISTS ecommerce."role_relationship"
    (
        "pkid_role_relationship" int NOT NULL,
        PRIMARY KEY (pkid_role_relationship),
		creation_date timestamp with time zone,
        "expiration_date" timestamp with time zone,
        "fk_pkid_login_user" int,
        "fk_pkid_user_rol" int,
        CONSTRAINT fk_pkid_login_user FOREIGN KEY (fk_pkid_login_user) REFERENCES ecommerce."user"(pkid_user),
        CONSTRAINT fk_pkid_user_rol FOREIGN KEY (fk_pkid_user_rol) REFERENCES ecommerce."user_rol"(pkid_user_rol)
    )';
    RAISE NOTICE 'Tabla ecommerce.role_relationship creada correctamente';


	-- Crear tabla capabilitie
    EXECUTE '
    CREATE TABLE IF NOT EXISTS ecommerce."capabilitie"
	(
	    "pkid_capabilitie" int NOT NULL,
	    PRIMARY KEY (pkid_capabilitie),
		creation_date timestamp with time zone,
	    "expiration_date" timestamp with time zone,
	    "name" varchar(30),
	    "description" varchar(30),
	    "fk_pkid_capabilitie" int,
	    CONSTRAINT fk_pkid_capabilitie FOREIGN KEY (fk_pkid_capabilitie) REFERENCES ecommerce."capabilitie"(pkid_capabilitie)
	)';

    RAISE NOTICE 'Tabla ecommerce."capabilitie" creada correctamente';
	-- Crear tabla role_capabilities
    EXECUTE '
    CREATE TABLE IF NOT EXISTS ecommerce."role_capabilities"
    (
        "pkid_role_capabilities" int NOT NULL,
        PRIMARY KEY (pkid_role_capabilities),
		creation_date timestamp with time zone,
        "expiration_date" timestamp with time zone,
        "fk_pkid_user_rol" int,
		"fk_pkid_capabilitie" int,
        CONSTRAINT fk_pkid_user_rol FOREIGN KEY (fk_pkid_user_rol) REFERENCES ecommerce."user_rol"(pkid_user_rol),
		CONSTRAINT fk_pkid_capabilitie FOREIGN KEY (fk_pkid_capabilitie) REFERENCES ecommerce."capabilitie"(pkid_capabilitie)
    )';
    RAISE NOTICE 'Tabla ecommerce.role_capabilities creada correctamente';

		EXECUTE '
		
		CREATE TABLE IF NOT EXISTS ecommerce.product
		(
		    pkid_product integer NOT NULL,
		    creation_date timestamp with time zone,
		    expiration_date timestamp with time zone,
		    name character varying(50) COLLATE pg_catalog."default",
		    description character varying(50) COLLATE pg_catalog."default",
			image character varying(250),
			price numeric(10,4),
		    CONSTRAINT product_pkey PRIMARY KEY (pkid_product)	
		)';

    EXECUTE '
		CREATE TABLE IF NOT EXISTS ecommerce.category
		(
		    pkid_category integer NOT NULL,
		    creation_date timestamp with time zone,
		    expiration_date timestamp with time zone,
		    name character varying(50) COLLATE pg_catalog."default",
		    description character varying(50) COLLATE pg_catalog."default",
		    CONSTRAINT category_pkey PRIMARY KEY (pkid_category)
		)';
	EXECUTE '

		CREATE TABLE IF NOT EXISTS ecommerce.product_category
		(
		    pkid_product_category integer NOT NULL,
		    creation_date timestamp with time zone,
		    expiration_date timestamp with time zone,
		    fk_pkid_product integer,
		    fk_pkid_category integer,
		    price numeric(10,4),
		    stock integer,
		    CONSTRAINT product_category_pkey PRIMARY KEY (pkid_product_category),
		    CONSTRAINT fk_pkid_category FOREIGN KEY (fk_pkid_category)
		        REFERENCES ecommerce.category (pkid_category) MATCH SIMPLE
		        ON UPDATE NO ACTION
		        ON DELETE NO ACTION,
		    CONSTRAINT fk_pkid_product FOREIGN KEY (fk_pkid_product)
		        REFERENCES ecommerce.product (pkid_product) MATCH SIMPLE
		        ON UPDATE NO ACTION
		        ON DELETE NO ACTION
		)';
EXECUTE '

		CREATE TABLE IF NOT EXISTS ecommerce.order_detail
		(
		    pkid_order_detail integer NOT NULL,
		    creation_date timestamp with time zone,
		    expiration_date timestamp with time zone,
		    fk_pkid_order integer NOT NULL,
			fk_pkid_product integer NOT NULL,
			amount integer,
			unit_price numeric(10,4),
			fk_pkid_taxes_detail integer NOT NULL,
			total_price numeric(10,4)
		)';
END $$;

	INSERT INTO ecommerce."user_information"(
		pkid_user_information,expiration_date,first_name,last_name,indicative,phone,email,addres
	)VALUES (
		1,now(),'Wilmer Giovanny','Torres Achury','+57',3016738627,'dv.wilmer.torres@gmail.com','calle 123 # 5- 6 Bogota'
	);

	INSERT INTO ecommerce."user" (
		pkid_user,expiration_date,"user","password",fk_pkid_user_information,number_attempts
	)VALUES (
		1,now(),'admin',md5('linktic'),1,0
	);


	INSERT INTO ecommerce."product" (
    pkid_product, creation_date, expiration_date, "name", description,image, price
	) VALUES 
(1, '2024-06-01 10:00:00', '2025-06-01 10:00:00', 'Product A', 'Product A','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(2, '2024-06-02 11:00:00', '2025-06-02 11:00:00', 'Product B', 'Product B','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','380.32'),
	(3, '2024-06-03 12:00:00', '2025-06-03 12:00:00', 'Product C', 'Product C','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','110.32'),
	(4, '2024-06-04 13:00:00', '2025-06-04 13:00:00', 'Product D', 'Product D','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(5, '2024-06-05 14:00:00', '2025-06-05 14:00:00', 'Product E', 'Product E','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','789.32'),
	(6, '2024-06-06 15:00:00', '2025-06-06 15:00:00', 'Product F', 'Product F','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(7, '2024-06-07 16:00:00', '2025-06-07 16:00:00', 'Product G', 'Product G','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(8, '2024-06-08 17:00:00', '2025-06-08 17:00:00', 'Product H', 'Product H','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','1354.32'),
	(9, '2024-06-09 18:00:00', '2025-06-09 18:00:00', 'Product I', 'Product I','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(10, '2024-06-10 19:00:00', '2025-06-10 19:00:00', 'Product J', 'Product J','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(11, '2024-06-11 10:00:00', '2025-06-11 10:00:00', 'Product K', 'Product K','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(12, '2024-06-12 11:00:00', '2025-06-12 11:00:00', 'Product L', 'Product L','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(13, '2024-06-13 12:00:00', '2025-06-13 12:00:00', 'Product M', 'Product M','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(14, '2024-06-14 13:00:00', '2025-06-14 13:00:00', 'Product N', 'Product N','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(15, '2024-06-15 14:00:00', '2025-06-15 14:00:00', 'Product O', 'Product O','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','2505.32'),
	(16, '2024-06-16 15:00:00', '2025-06-16 15:00:00', 'Product P', 'Product P','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(17, '2024-06-17 16:00:00', '2025-06-17 16:00:00', 'Product Q', 'Product Q','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(18, '2024-06-18 17:00:00', '2025-06-18 17:00:00', 'Product R', 'Product R','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(19, '2024-06-19 18:00:00', '2025-06-19 18:00:00', 'Product S', 'Product S','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(20, '2024-06-20 19:00:00', '2025-06-20 19:00:00', 'Product T', 'Product T','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(21, '2024-06-21 10:00:00', '2025-06-21 10:00:00', 'Product U', 'Product U','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(22, '2024-06-22 11:00:00', '2025-06-22 11:00:00', 'Product V', 'Product V','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(23, '2024-06-23 12:00:00', '2025-06-23 12:00:00', 'Product W', 'Product W','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(24, '2024-06-24 13:00:00', '2025-06-24 13:00:00', 'Product X', 'Product X','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(25, '2024-06-25 14:00:00', '2025-06-25 14:00:00', 'Product Y', 'Product Y','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32'),
	(26, '2024-06-26 15:00:00', '2025-06-26 15:00:00', 'Product Z', 'Product Z','https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg','250.32');

/*
	select * from ecommerce."user_information"
	select * from ecommerce."user";
	select * from ecommerce."user_rol";
	select * from ecommerce."role_relationship";
	select * from ecommerce."role_capabilities";
	SELECT * FROM ecommerce."category";
	select * from ecommerce."product_category";
	SELECT * FROM ecommerce."product";
	select * from ecommerce.order_detail
*/
/*
	drop table ecommerce."role_relationship";
	drop table ecommerce."user";
	drop table ecommerce."role_capabilities";
	drop table ecommerce."user_rol";
	drop table ecommerce."user_information";
	drop table ecommerce."capabilitie";
	drop table ecommerce."product_category";
	drop table ecommerce."product";
	drop table ecommerce."category";
	drop table ecommerce."order_detail";
*/

update ecommerce."product" set image= 'https://img.freepik.com/vector-premium/caja-regalo-estilo-plano-aislado-sobre-fondo-blanco-concepto-navidad-elementos-diseno-cumpleanos-estilo-dibujos-animados_201926-604.jpg'

