From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 9 Aug 2016 09:58:11 +0300
Subject: [PATCH v2 nvme-cli 3/4] fabrics: Allow discover params to come
 from a conf file
In-Reply-To: <1470693074.4368.44.camel@linux.intel.com>
References: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
 <1470657480-5868-4-git-send-email-sagi@grimberg.me>
 <1470693074.4368.44.camel@linux.intel.com>
Message-ID: <a6846d8f-1100-3519-40a2-94968bc4e132@grimberg.me>



On 09/08/16 00:51, J Freyensee wrote:
> I missed some things on this patch.
>
>>
>>  #define BUF_SIZE		4096
>>  #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
>> +#define PATH_NVMF_DISC		"/etc/nvme/nvmf_disc"
>> +#define MAX_DISC_ARGS		10
>>
>>  enum {
>>  	OPT_INSTANCE,
>> @@ -575,6 +577,62 @@ static int do_discover(char *argstr, bool
>> connect)
>>  	return ret;
>>  }
>>
>> +static int discover_from_conf_file(const char *desc, char *argstr,
>> +	const struct argconfig_commandline_options *opts, bool
>> connect)
>> +{
>> +	FILE *f;
>> +	char line[255], *ptr, *args, **argv;
>
> Why is line 255 and not 256?  Maybe want it a #define?

I can change to 256. Not sure if we need a define...

>
>> +	int argc, err, ret = 0;
>> +
>> +	f = fopen(PATH_NVMF_DISC, "r");
>> +	if (f == NULL) {
>> +		fprintf(stderr, "No discover params given and no %s
>> conf\n", PATH_NVMF_DISC);
>> +		return -EINVAL;
>> +	}
>> +
>> +	while (fgets(line, sizeof(line), f) != NULL) {
>> +		if (line[0] == '#' || line[0] == '\n')
>> +			continue;
>> +
>> +		args = strdup(line);
>> +		if (!args) {
>> +			fprintf(stderr, "failed to strdup args\n");
>
> Be useful to print out the line so you know where you failed.

Its pretty explicit to know where this failed.

>
>> +			return -ENOMEM;
>> +		}
>> +
>> +		argv = calloc(MAX_DISC_ARGS, BUF_SIZE);
>> +		if (!argv) {
>> +			fprintf(stderr, "failed to allocate args
>> vector\n");
>
> memory leak from not free'ing args in this case?

Right, fixed.

>
> Also fprintf() says 'args' not 'argv'.  And again may be useful to
> print out the line of where you failed.

changed to argv.

>
>
>> +			return -ENOMEM;
>> +		}
>> +
>> +		argc = 0;
>> +		argv[argc++] = "discover";
>> +		while ((ptr = strsep(&args, " =\n")) != NULL)
>> +			argv[argc++] = ptr;
>> +
>> +		argconfig_parse(argc, argv, desc, opts, &cfg,
>> sizeof(cfg));
>> +
>> +		err = build_options(argstr, BUF_SIZE);
>> +		if (err) {
>> +			ret = err;
>
> Again mentioned by Christoph, probably need some diagnostics on why err
> didn't get set to 0.

build_options will print out the failure reason.
