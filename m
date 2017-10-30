From: keith.busch@intel.com (Keith Busch)
Date: Mon, 30 Oct 2017 09:18:01 -0600
Subject: [PATCHv2 5/5] nvme: Send uevent for unhandled AEN completions
In-Reply-To: <b05dcfac-0d50-4b90-544e-646bbfce57bb@huawei.com>
References: <20171020223746.31287-1-keith.busch@intel.com>
 <b05dcfac-0d50-4b90-544e-646bbfce57bb@huawei.com>
Message-ID: <20171030151800.GC17245@localhost.localdomain>

On Mon, Oct 30, 2017@06:14:30PM +0800, Guan Junxiong wrote:
> 
> On 2017/10/21 6:37, Keith Busch wrote:
> >  static void nvme_async_event_work(struct work_struct *work)
> >  {
> >  	struct nvme_ctrl *ctrl =
> >  		container_of(work, struct nvme_ctrl, async_event_work);
> >  
> > +	nvme_aen_uevent(ctrl);
> >  	ctrl->ops->submit_async_event(ctrl);
> >  }
> 
> Is this based on 4.15 or 4.14? I failed to apply it.
> 

This was based off this branch:

  http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-4.15

starting from commit 134aedc9c ("nvme-fc: correct io timeout behavior")
