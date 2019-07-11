From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Jul 2019 02:11:52 +0900
Subject: [PATCH rfc 3/6] nvme-cli: allow discover to address discovery
 controller by persistent name
In-Reply-To: <39f7417d-dd5c-8c81-a4d5-7b8a313deaab@gmail.com>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
 <20190710232740.26734-4-jsmart2021@gmail.com>
 <20190711124116.GC8398@minwoo-desktop>
 <39f7417d-dd5c-8c81-a4d5-7b8a313deaab@gmail.com>
Message-ID: <20190711171152.GB17328@minwoo-desktop>

On 19-07-11 09:16:37, James Smart wrote:
> On 7/11/2019 5:41 AM, Minwoo Im wrote:
> > On 19-07-10 16:27:37, James Smart wrote:
> > > To support discovery (connect/connect-all) to operate against a
> > > persistent discovery controller, let the discovery controller to
> > > be specified by its device node name rather than new connection
> > > attributes.
> > > 
> > > Example:
> > >    nvme connect-all ... --device=nvme5
> > > 
> > > Also centralize extraction of controller instance from the controller
> > > name to a common helper.
> > > 
> > > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> > > Signed-off-by: James Smart <jsmart2021 at gmail.com>
> > > Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> > 
> > Hi Sagi and James,
> > 
> > I think it might be too late review on this, but please have a look my
> > comments below :)
> 
> well,  it was posted as an RFC, so....

Yup, Thanks :)

> > 
> > > +static int ctrl_instance(char *device)
> > > +{
> > > +	int ret, instance;
> > > +
> > > +	device = basename(device);
> > > +	ret = sscanf(device, "nvme%d", &instance);
> > > +	if (ret < 0)
> > > +		return ret;
> > 
> > It's just nitpick, but could we just do like:
> > 
> > 	ret = sscanf(device, "nvme%d", &instance);
> > 	if (ret < 0)
> > 		return -errno;
> 
> I would think that what sscanf might report as a problem may not be
> something understandable for someone using the cli. I'd like to replace
> this with something like -EINVAL for an invalid argument rather than
> ret/-errorno.

-EINVAL would be fine to me also.

> > 
> > > +	if (!ret)
> > > +		return -1;
> > 
> > Same here.  Can we please do:
> > 
> > 	if (!ret)
> > 		return -EINVAL;
> 
> yep
> 
> 
> > 
> > 
> > These two things are not from this commit, but if you don't like it to
> > be involved in this scope of the commit, I think I can make it later, if
> > you don't mind.
> > 
> > > +	return instance;
> > > +}
> > 
> > I have a doubt here.  In case of multipath, if this function is given an
> > argument like "nvme0n1", Is "0" really an instance of that controller?
> > I think it could be an instance of the subsystem.  If so, can we just
> > prevent the argstr as a namespace node?
> > 
> > Please correct me if I'm wrong here.
> 
> it should never be given an argument with the n? suffix. We're dealing with
> controllers only. And multipath won't confuse that.  Perhaps we should
> verify it ends at the controller name.

Yeah.. It should not be given like that.  But I think it would be great
if we can verify the given argument indicates a controller, not a
namespace node in somewhere because people are sometimes get confused
and may give some ns node here ;(
