From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 08 Aug 2016 14:29:15 -0700
Subject: [PATCH v2 nvme-cli 3/4] fabrics: Allow discover params to come
 from a conf file
In-Reply-To: <20160808133502.GB19826@lst.de>
References: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
 <1470657480-5868-4-git-send-email-sagi@grimberg.me>
 <20160808133502.GB19826@lst.de>
Message-ID: <1470691755.4368.26.camel@linux.intel.com>

On Mon, 2016-08-08@15:35 +0200, Christoph Hellwig wrote:
> On Mon, Aug 08, 2016@02:57:59PM +0300, Sagi Grimberg wrote:
> > 
> > Allow the user to just run "nvme discover" or "nvme connect-all"
> > in case it finds a default /etc/nvme/nvmf_disc conf file.
> 
> Hmm, can just call this /etc/nvme/discovery.conf or something else
> that rolls easier off the hand?

Yah, similar to my last nitpick comment, I like this a tad better
because we don't even have to mention nvmf/nvmeof.

I'd still like to see example documentation in the header patch of what
the resulting .conf file contents could look like.

> 
> > 
> > +static int discover_from_conf_file(const char *desc, char *argstr,
> > +	const struct argconfig_commandline_options *opts, bool
> > connect)
> 
> Second tab for the argument indent please.
> 
> > 
> > +		err = build_options(argstr, BUF_SIZE);
> > +		if (err) {
> > +			ret = err;
> > +			continue;
> > +		}
> > +
> > +		err = do_discover(argstr, connect);
> > +		if (err) {
> > +			ret = err;
> > +			continue;
> > +		}
> 
> How will diagnostics look like here if the file has incorrect
> syntax?

Dido. ?Be nice to know what argstr/parameter broke.


> 
> > 
> > +	if (!cfg.transport && !cfg.traddr) {
> > +		return discover_from_conf_file(desc, argstr,
> > +				command_line_options, connect);
> 
> Maybe we want a separate options that says the option needs to be
> read from a config file, e.g. --file with an optional argument
> for the file name?

Are you thinking that there could be a single system that is acting
like multiple hosts, therefore each "host/hostnqn" could use a separate
.conf file for connection??

If that is the case, then it may be a little confusing if there was a
single /etc/nvme/hostnqn filename that existed.
