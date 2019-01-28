From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Jan 2019 08:36:07 -0700
Subject: [PATCH] nvme: Block ns inventory changes during admin
In-Reply-To: <BYAPR04MB45021C05936FF7EF982D579686940@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190125194819.11476-1-keith.busch@intel.com>
 <OF5147C249.BC64CC03-ON0025838D.007F28EE-8625838D.007F6785@notes.na.collabserv.com>
 <20190125233742.GA11722@localhost.localdomain>
 <BYAPR04MB45021C05936FF7EF982D579686940@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20190128153607.GB15271@localhost.localdomain>

On Sat, Jan 26, 2019@09:55:52AM -0800, Chaitanya Kulkarni wrote:
> Looks good to me. Just thinking out loud we can only unfreeze the namespace if
> that is frozen in nvme_unfreeze(ctrl)? We can mark it freeze in the
> nvme_wait_freeze(). 

Adding a freeze state to namespaces may work too if there are no callers
making use of a layer freeze depth.
 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> 
> ???????????????????????????????????????????????????????????????????????????????
> From: Linux-nvme <linux-nvme-bounces at lists.infradead.org> on behalf of Keith
> Busch <keith.busch at intel.com>
> Sent: Friday, January 25, 2019 3:37:43 PM
> To: Wen Xiong
> Cc: Christoph Hellwig; linux-nvme at lists.infradead.org; Sagi Grimberg
> Subject: Re: [PATCH] nvme: Block ns inventory changes during admin
>  
> [replying in plain-text for mailing list posterity]
> On Fri, Jan 25, 2019@05:11:35PM -0600, Wen Xiong wrote:
> > Hi Keith,
> >
> > I have tested the patch and fixed the two hung issues on our system.
> >
> > >>Reported-by: Wen Xiong <wenxiong at us.ibm.com>
> > >>Signed-off-by: Keith Busch <keith.busch at intel.com>
> >
> > Tested-by: Wen Xiong<wenxiong at us.ibm.com>
> >
> > Thanks,
> > Wendy
> 
> Thank you for confirming this fixes your issue.
