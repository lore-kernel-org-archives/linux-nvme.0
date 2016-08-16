From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 16 Aug 2016 09:22:36 -0700
Subject: [PATCH v2 4/5] nvme-loop: set sqsize to 0-based value, per spec
In-Reply-To: <4d7c4c72-2f05-dbc8-402d-74593da74814@grimberg.me>
References: <1471279659-25951-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1471279659-25951-5-git-send-email-james_p_freyensee@linux.intel.com>
 <4d7c4c72-2f05-dbc8-402d-74593da74814@grimberg.me>
Message-ID: <1471364556.21107.8.camel@linux.intel.com>

On Tue, 2016-08-16@11:59 +0300, Sagi Grimberg wrote:
> 
> On 15/08/16 19:47, Jay Freyensee wrote:
> > 
> > Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> > ---
> > ?drivers/nvme/target/loop.c | 4 ++--
> > ?1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/loop.c
> > b/drivers/nvme/target/loop.c
> > index 94e7829..ce22d4b0 100644
> > --- a/drivers/nvme/target/loop.c
> > +++ b/drivers/nvme/target/loop.c
> > @@ -558,7 +558,7 @@ static int nvme_loop_create_io_queues(struct
> > nvme_loop_ctrl *ctrl)
> > 
> > ?	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
> > ?	ctrl->tag_set.ops = &nvme_loop_mq_ops;
> > -	ctrl->tag_set.queue_depth = ctrl->ctrl.sqsize;
> > +	ctrl->tag_set.queue_depth = ctrl->ctrl.sqsize + 1;
> 
> Just use opts->queue_size.

OK, will do.

Thanks,
J
