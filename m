From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 6 Nov 2018 08:30:10 +0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <20181105162814.GA3443@localhost.localdomain>
References: <20181105115734.15515-1-ming.lei@redhat.com>
 <20181105162814.GA3443@localhost.localdomain>
Message-ID: <20181106003009.GA20193@ming.t460p>

On Mon, Nov 05, 2018@09:28:15AM -0700, Keith Busch wrote:
> On Mon, Nov 05, 2018@07:57:34PM +0800, Ming Lei wrote:
> > -void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> > +void nvme_stop_ctrl(struct nvme_ctrl *ctrl, bool flush_scan)
> >  {
> >  	nvme_mpath_stop(ctrl);
> >  	nvme_stop_keep_alive(ctrl);
> 
> Newly added parameter 'flush_scan' is unsused. ?

oops, it should have been applied as:

	if (flush_scan)
		flush_work(&ctrl->scan_work);

Thanks,
Ming
