From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 9 Aug 2016 09:52:05 +0300
Subject: [PATCH v2 nvme-cli 3/4] fabrics: Allow discover params to come
 from a conf file
In-Reply-To: <20160808133502.GB19826@lst.de>
References: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
 <1470657480-5868-4-git-send-email-sagi@grimberg.me>
 <20160808133502.GB19826@lst.de>
Message-ID: <6f741e63-3967-ab4f-29e6-9ee6dfd6c6f6@grimberg.me>



On 08/08/16 16:35, Christoph Hellwig wrote:
> On Mon, Aug 08, 2016@02:57:59PM +0300, Sagi Grimberg wrote:
>> Allow the user to just run "nvme discover" or "nvme connect-all"
>> in case it finds a default /etc/nvme/nvmf_disc conf file.
>
> Hmm, can just call this /etc/nvme/discovery.conf or something else
> that rolls easier off the hand?

ok

>
>> +static int discover_from_conf_file(const char *desc, char *argstr,
>> +	const struct argconfig_commandline_options *opts, bool connect)
>
> Second tab for the argument indent please.

done

>
>> +		err = build_options(argstr, BUF_SIZE);
>> +		if (err) {
>> +			ret = err;
>> +			continue;
>> +		}
>> +
>> +		err = do_discover(argstr, connect);
>> +		if (err) {
>> +			ret = err;
>> +			continue;
>> +		}
>
> How will diagnostics look like here if the file has incorrect
> syntax?

the same way that discovery from user args, it'll just happen for
each incorrect line. Would you prefer that we print the args line
we're using?

>> +	if (!cfg.transport && !cfg.traddr) {
>> +		return discover_from_conf_file(desc, argstr,
>> +				command_line_options, connect);
>
> Maybe we want a separate options that says the option needs to be
> read from a config file, e.g. --file with an optional argument
> for the file name?

I kinda like the fact that you can just run discover/connect-all without
providing any arguments. We could add the conf file argument if it's
located in a non-default path maybe? what do others think?
