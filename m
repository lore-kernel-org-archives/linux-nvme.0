From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Fri, 14 Jul 2017 20:21:44 +0000
Subject: [dm-devel] [PATCH 1/4] libmultipath: get_udev_uid: make sure
 pp->wwid is 0-terminated
In-Reply-To: <1500060099.4808.21.camel@suse.de>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-2-mwilck@suse.com> <1500044188.2662.4.camel@wdc.com>
 <1500060099.4808.21.camel@suse.de>
Message-ID: <1500063703.2662.9.camel@wdc.com>

On Fri, 2017-07-14@21:21 +0200, Martin Wilck wrote:
> On Fri, 2017-07-14@14:56 +0000, Bart Van Assche wrote:
> > How about using the following (untested) alternative?
> > 
> > diff --git a/libmultipath/discovery.c b/libmultipath/discovery.c
> > index eca4ce97..80d962e6 100644
> > --- a/libmultipath/discovery.c
> > +++ b/libmultipath/discovery.c
> > @@ -1607,13 +1607,8 @@ get_udev_uid(struct path * pp, char
> > *uid_attribute, struct udev_device *udev)
> >  	if (!value || strlen(value) == 0)
> >  		value = getenv(uid_attribute);
> >  	if (value && strlen(value)) {
> > -		if (strlen(value) + 1 > WWID_SIZE) {
> > +		if (strlcpy(pp->wwid, value, sizeof(pp->wwid)) >=
> > WWID_SIZE)
> >  			condlog(0, "%s: wwid overflow", pp->dev);
> > -			len = WWID_SIZE;
> > -		} else {
> > -			len = strlen(value);
> > -		}
> > -		strncpy(pp->wwid, value, len);
> >  	} else {
> >  		condlog(3, "%s: no %s attribute", pp->dev,
> >  			uid_attribute);
> 
> Let's have a strncpy vs. strlcpy discussion :D !
>
> I can do this if you insist, but I don't see a big benefit. We've
> tested with the patch I submitted.

My comments were not intended as an invitation to open a strncpy() vs. strlcpy()
discussion. What I wanted to illustrate with the above patch is that when using
strlcpy() it is not necessary to explicitly zero-terminate a string because
strlcpy() guarantees zero-termination. Compact code that is as readable as more
verbose code is always better because compact code is easier to verify.

Bart.
