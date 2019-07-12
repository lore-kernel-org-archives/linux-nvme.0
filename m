From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 11 Jul 2019 17:47:03 -0700
Subject: [PATCH rfc v2 05/10] nvme-cli: extend ctrl_list_item for connect
 attributes
In-Reply-To: <20190712003140.16221-6-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-6-jsmart2021@gmail.com>
Message-ID: <6647e40b-cfc9-46e3-cd11-aeaaec8eeff6@grimberg.me>


> +char *__parse_connect_arg(char *conargs, const char delim, const char *fieldnm)
> +{
> +	char *s, *e;
> +	size_t cnt;
> +
> +	/*
> +	 * There are field name overlaps: traddr and host_traddr.
> +	 * By chance, both connect arg strings are set up to
> +	 * have traddr field followed by host_traddr field. Thus field
> +	 * name matching doesn't overlap in the searches. Technically,
> +	 * as is, the loop and delimiter checking isn't necessary.
> +	 * However, better to be prepared.
> +	 */
> +	do {
> +		s = strstr(conargs, fieldnm);

Any reason not to use the normal strsep for loop?
