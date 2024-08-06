Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A88C3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:References:In-Reply-To:Cc:Subject:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hcYMlLb35XLMz7POQuExQL0m7LMjrBYkD4TCGzO3coY=; b=kpvSvG6BuiTMXpUAggWYDXmd67
	4TZ6hF/84/CGXJCBrJ8QxmMq06J8fzLp+Os6fyRkZRRBbEZIVXBPZ37rta59Em6nE8qhaLPw8GTTH
	XR4n8HMZGMivXiftf4cdiEFn9rMtoM7/9wV/+q/s645nPqxnSCP5KfnrU2gL7oqxO8xju8XElqn8d
	mwHAC6MAGPgqEQEkrqjEsY5DgEFTJ1nD2w5WII331CiI1KER5mact+ihwuaticSQUUWYJm9Pec5gE
	Sijm4EmLG5rb86t1eNATGt6w8mhbCToUgaBSRKBIQOTdx+aLS7PfYEme22cIglLDinphLvYnR9GRz
	ln7aOyMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbGBV-000000013Mu-0T02;
	Tue, 06 Aug 2024 09:08:49 +0000
Received: from out28-62.mail.aliyun.com ([115.124.28.62])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbGBN-000000013ML-2oJL
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 09:08:44 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.8301688|0.08157015;CH=green;DM=|AD|false|;DS=CONTINUE|ham_regular_dialog|0.0020804-0.000321619-0.997598;FP=1574043381487715862|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033055230028;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Yje79tu_1722935314;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Yje79tu_1722935314)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 17:08:35 +0800
Date: Tue, 06 Aug 2024 17:08:36 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH RFC] nvmet: basic RMEDIA support for target
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <6ec0d9af-1972-4181-bd12-218f0e566cd1@grimberg.me>
References: <20240806004928.27605-1-wangyugui@e16-tech.com> <6ec0d9af-1972-4181-bd12-218f0e566cd1@grimberg.me>
Message-Id: <20240806170835.CF79.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.06 [en]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_020841_905511_26092243 
X-CRM114-Status: GOOD (  20.01  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

> 
> On 06/08/2024 3:49, Wang Yugui wrote:
> > Rotational media(RMEDIA) support is added to the NVMe 2.0 specification.
> > We add Rotational media(RMEDIA) basic support to nvme target.
> >
> > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> > ---
> >   drivers/nvme/target/admin-cmd.c   | 50 +++++++++++++++++++++++++++++++
> >   drivers/nvme/target/core.c        |  2 ++
> >   drivers/nvme/target/io-cmd-bdev.c |  1 +
> >   drivers/nvme/target/nvmet.h       |  1 +
> >   4 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index f7e1156ac7ec..20a28102f8a0 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -489,6 +489,53 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >   	nvmet_req_complete(req, status);
> >   }
> >  > +static void nvmet_execute_identify_indep(struct nvmet_req *req)
> > +{
> > +	struct nvme_id_ns_cs_indep  *id;
> > +	u16 status;
> > +
> > +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> > +	if (!id) {
> > +		status = NVME_SC_INTERNAL;
> > +		goto out;
> > +	}
> > +
> > +	/* return an all zeroed buffer if we can't find an active namespace */
> > +	status = nvmet_req_find_ns(req);
> > +	if (status) {
> > +		status = 0;
> > +		goto done;
> > +	}
> > +
> > +	if (nvmet_ns_revalidate(req->ns)) {
> > +		mutex_lock(&req->ns->subsys->lock);
> > +		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
> > +		mutex_unlock(&req->ns->subsys->lock);
> > +	}
> > +
> > +	/*
> > +	 * Our namespace might always be shared.  Not just with other
> > +	 * controllers, but also with any other user of the block device.
> > +	 */
> > +	id->nmic = NVME_NS_NMIC_SHARED;
> > +	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
> > +
> > +	if (req->ns->readonly)
> > +		id->nsattr |= NVME_NS_ATTR_RO;
> > +
> > +	id->nstat |= NVME_NSTAT_NRDY;
> > +
> > +	if(req->ns->rotational)
> > +		id->nsfeat |= NVME_INDEP_NS_FEAT_RMEDIA;
> > +
> > +done:
> > +	if (!status)
> > +		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> > +	kfree(id);
> > +out:
> > +	nvmet_req_complete(req, status);
> > +}
> > +
> >   static void nvmet_execute_identify_ns(struct nvmet_req *req)
> >   {
> >   	struct nvme_id_ns *id;
> > @@ -706,6 +724,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
> >   			break;
> >   		}
> >   		break;
> > +	case NVME_ID_CNS_NS_CS_INDEP:
> > +		nvmet_execute_identify_indep(req);
> > +		return;
> >   	case NVME_ID_CNS_CS_CTRL:
> >   		switch (req->cmd->identify.csi) {
> >   		case NVME_CSI_NVM:
> > diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> > index ed2424f8a396..2790fedb593b 100644
> > --- a/drivers/nvme/target/core.c
> > +++ b/drivers/nvme/target/core.c
> > @@ -1254,6 +1254,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
> >   	else
> >   		ctrl->cap |= ctrl->port->max_queue_size - 1;
> >  > +	ctrl->cap |= NVME_CAP_CRMS_CRIMS;
> > +
> >   	if (nvmet_is_passthru_subsys(ctrl->subsys))
> >   		nvmet_passthrough_override_cap(ctrl);
> >   }
> > diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> > index 0bda83d0fc3e..d15ad1a864bc 100644
> > --- a/drivers/nvme/target/io-cmd-bdev.c
> > +++ b/drivers/nvme/target/io-cmd-bdev.c
> > @@ -104,6 +104,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
> >  >   	ns->pi_type = 0;
> >   	ns->metadata_size = 0;
> > +	ns->rotational = bdev_nonrot(ns->bdev);
> 
> Shouldn't this be !bdev_nonrot(ns->bdev) ?

You are right. It will be fixed in next version.

Thanks a lot.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/08/06



