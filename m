From: mlin@kernel.org (Ming Lin)
Date: Thu, 19 Nov 2015 21:31:10 -0800
Subject: [RFC PATCH 4/9] nvmet: add a controller "start" hook
In-Reply-To: <20151120051355.GA19405@lst.de>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
 <1447978868-17138-5-git-send-email-mlin@kernel.org>
 <20151120051355.GA19405@lst.de>
Message-ID: <1447997470.3473.4.camel@hasee>

On Fri, 2015-11-20@06:13 +0100, Christoph Hellwig wrote:
> On Thu, Nov 19, 2015@04:21:03PM -0800, Ming Lin wrote:
> >  #define NVMET_SUBSYS_NAME_LEN		256
> >  	char			subsys_name[NVMET_SUBSYS_NAME_LEN];
> > +
> > +	void			*opaque;
> > +	void			(*start)(void *);
> >  };
> 
> Why can't vhost use container_of to get at the containing structure
> similar to what the loop driver does?

struct nvme_loop_ctrl {

        struct nvme_ctrl        ctrl;

        struct nvmet_ctrl       *target_ctrl;
};

static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)
{
        return container_of(ctrl, struct nvme_loop_ctrl, ctrl);
}

loop driver's container_of is used for "nvme_ctrl", not "nvmet_ctrl"

Possibly change:
struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_subsys *subsys,
                const char *subsys_name)
to 
int nvmet_init_ctrl(struct nvmet_ctrl *, ....)
?

So we can embed "struct nvmet_ctrl" to upper layer structure.

> 
> In addition I think we'll eventually need an ops structure here,
> but I can take care of that later.
