From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 13 Feb 2017 17:07:13 +0000
Subject: [PATCH V5 3/4] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
In-Reply-To: <CAK8P3a3-4UOkGjLWQpt9Rh=+QJNnJxJSHyha3R_-rGrqQ_LmFw@mail.gmail.com>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-4-git-send-email-scott.bauer@intel.com>
 <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
 <20170213162941.GB18913@sbauer-Z170X-UD5>
 <CAK8P3a3-4UOkGjLWQpt9Rh=+QJNnJxJSHyha3R_-rGrqQ_LmFw@mail.gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02851D7@AcuExch.aculab.com>

From: Arnd Bergmann
> Sent: 13 February 2017 17:02
...
> >> > +   ioctl_ptr = memdup_user(arg,  _IOC_SIZE(cmd));
> >> > +   if (IS_ERR_OR_NULL(ioctl_ptr)) {
> >> > +           ret = PTR_ERR(ioctl_ptr);
> >> > +           goto out;
> >> ...
> >> > + out:
> >> > +   kfree(ioctl_ptr);
> >> > +   return ret;
...
> >> That error path doesn't look quite right to me.
...
> > good god, this is a mess this morning. Thanks for the catch, I'll review these
> > more aggressively before sending out.
> 
> memdup_user() never returns NULL, and generally speaking any use of
> IS_ERR_OR_NULL() indicates that there is something wrong with the
> interface, so aside from passing the right pointer (or NULL) into kfree()
> I think using IS_ERR() is the correct solution.

You missed the problem entirely.
Code needs to be:
	if (IS_ERR(ioctl_ptr))
		return PTR_ERR(ioctl_ptr);

	David
