From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 30 Mar 2018 12:13:28 -0600
Subject: [RFC PATCH 8/8] nvmet: add configfs interface for target passthru
In-Reply-To: <20180330065747.20962-9-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-9-chaitanya.kulkarni@wdc.com>
Message-ID: <be832a05-3906-7087-30ed-f20784128272@deltatee.com>



On 30/03/18 12:57 AM, Chaitanya Kulkarni wrote:
> This patch adds configfs interface for target passthru
> ctrl management.
> 
> The new directory "pt" under nvmet configfs is added to
> configure passthru ctrl (pt-ctrl). Once all the fields
> for the pt-ctrl are set user can enable the pt-ctrl through
> configfs.
> 
> The new directory pt is parallel to the subsystem and has similar
> attributes as default subsystem, each passthru ctrl is represented
> as one subsystem. Since we allow ctrl passthru we don't export or
> allow user to access the passthru namespace(s) in the configfs.

I *really* dislike this interface. Not only is the "pt" directory
confusing to the user, it's nearly identical to what a subsystem is. So
as developers, if we want to add a config option to a subsystem we also
have to add it to the equivalent pt. I've already seen one patch set
that would be mutually exclusive to this only because of the
configuration mess.

I'd much rather see either a couple new attributes in the existing
subsystem or some mechanism such that if you create a namespace that
points to a controller (eg /dev/nvme1) it takes it as though you're
trying to pass through the whole NVMe device. (The code would need to
ensure that a passthrough subsystem configured this way could only have
exactly one namespace.) I think that would be a lot more intuitive than
a directory label "pt" and prevents all the duplication of what a
subsystem is.

Logan
