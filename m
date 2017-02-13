From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 13 Feb 2017 09:29:42 -0700
Subject: [PATCH V5 3/4] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-4-git-send-email-scott.bauer@intel.com>
 <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
Message-ID: <20170213162941.GB18913@sbauer-Z170X-UD5>

On Mon, Feb 13, 2017@04:30:36PM +0000, David Laight wrote:
> From: Scott Bauer Sent: 13 February 2017 16:11
> > When CONFIG_KASAN is enabled, compilation fails:
> > 
> > block/sed-opal.c: In function 'sed_ioctl':
> > block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-
> > larger-than=]
> > 
> > Moved all the ioctl structures off the stack and dynamically activate
> > using _IOC_SIZE()
> 
> Think I'd not that this simplifies the code considerably.
> AFAICT CONFIG_KASAN is a just brainf*ck.
> It at least needs annotation that copy_from_user() has properties
> similar to memset().
> So if the size matches that of the type then no guard space (etc)
> is required.
>

I don't really follow what you're saying. Do you want me to just include that
the patch cleans up the ioctl path a bit. I need to include the KASAN part since
there was build breakage and the series does fix it even if it simplifies the path
as well. As for the memset part, we never copy back to userland so there's no chance
of data leakage which is what it seems you're hinting at.

> ...
> > +	ioctl_ptr = memdup_user(arg,  _IOC_SIZE(cmd));
> > +	if (IS_ERR_OR_NULL(ioctl_ptr)) {
> > +		ret = PTR_ERR(ioctl_ptr);
> > +		goto out;
> ...
> > + out:
> > +	kfree(ioctl_ptr);
> > +	return ret;
> >  }


> 
> That error path doesn't look quite right to me.
> 
> 	David
> 

good god, this is a mess this morning. Thanks for the catch, I'll review these
more aggressively before sending out. 
