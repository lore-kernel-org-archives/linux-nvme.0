Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E20606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h+v9WMyd;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.a=rsa-sha256 header.s=mta-02 header.b=CO+MOJQe;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.a=rsa-sha256 header.s=mta-03 header.b=gb059MYL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RqLYSNANlPC6yUjwGdt+TugyKeEWBo8NGXBnS5NA17M=; b=h+v9WMyddFKVLDtmPq4bL+Klcg
	ZTedBMUJ3JzijUtUm9C8RGe7KqFYOd4xmppo7vOzyoAxwXXOZKp89OHrM2TbgqFnqrgGJIlPi9F2C
	i7+fdrh+shObSNPGZ/M3jg3tWZakjsG8ntjg0CtlRx0Q/pSXju7eF30cwIZsi2BmMnAd4urHfKC2W
	Z/dKEphkVPnh90i63DJRmVS2lF5WMWMaAcmuxUwGo/7dEdOJhT64EfxAkLL+pLk3yEQa1oeWm3yj/
	GKMTGCeyPU/NkfIpgnjvOyjRm9BGAXUbvxnbfVMIDXf/TSnG6Lw23VUpgy77MknOr4nWkQhZkdobn
	leiplZFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFeI-000000057e8-0JjW;
	Tue, 17 Nov 2026 09:38:46 +0000
Received: from mta-01.yadro.com ([195.3.219.148])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFe1-0000000577U-2vdM;
	Tue, 17 Nov 2026 09:38:43 +0000
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 0114B2001B;
	Tue, 17 Nov 2026 12:38:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com 0114B2001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1794908301; bh=RqLYSNANlPC6yUjwGdt+TugyKeEWBo8NGXBnS5NA17M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=CO+MOJQe+gEQYxnZPR+ahaEZyfNNshysPD6S/sN7tFA5BPc1KA2O4oVLZN0J+xAF9
	 jOqikCw6FrH0ubil3CtUfR0l/9EovzDvkvTCfSo2wQOqi2TI1T88czeNIOTCTtENI0
	 tz7TuC7KUaDz9MKHdeUtV/2yCrB5D7bgBgD7SkNCVgODI3oDV/hnFrTkPMGv851+HM
	 BXwX/ulbQNTL3QxwmfgEg/cg9VmgC7gBKkCRQ7KV/pnbKqHycPmOmYT0RqrUd8fs9x
	 SM0AwykxJkSziYmSDENyBqy2k3J6di/cFdWgF6THVrHb0qK0mTLsnpfqQr9RwDN1nJ
	 WvrFbze8VkXjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1794908301; bh=RqLYSNANlPC6yUjwGdt+TugyKeEWBo8NGXBnS5NA17M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=gb059MYLEeg15Nof/ZH9WWjUKpo1E+QdzXPwwf69AQ1qzApDkl3oU9/r7h/GcUqIJ
	 rnWN1NfdydncSka5ZJkQkFYgrBO4rL0dkl57/HpITLTifshL3cebmKx2JTIxtegeRX
	 qoaAsx5Xmr+tBI+URNH1qW7DbvGG0d8SrUXhpzroaBZlTsr0n7BQeAQS5Miw73R8I9
	 xUg6JMixndDSKkmhElbW2VvqTBLUzyXC+AhPZIZYUCl/PlDUkHVrvOcVzFP4ONbDaK
	 QQ8N9e2pi/votUDVE0PlyIgZahft4AyjBUsA8EvVQ0UvFrsMJnaxCPD2IsT9RblPpU
	 tLlc0vbWO7tIw==
Received: from RTM-EXCH-06.corp.yadro.com (unknown [10.34.9.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Tue, 17 Nov 2026 12:38:18 +0300 (MSK)
Received: from yadro.com (10.34.9.247) by RTM-EXCH-06.corp.yadro.com
 (10.34.9.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 12:38:20 +0300
Date: Tue, 17 Nov 2026 12:38:19 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Mohamed Khalfella <linux-nvme-bounces@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Justin Tee
	<justin.tee@broadcom.com>, Naresh Gottumukkala
	<nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, Hannes
 Reinecke <hare@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, James Smart
	<jsmart833426@gmail.com>, Randy Jennings <randyj@purestorage.com>, Daniel
 Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v7 03/17] nvmet: Implement CCR nvme command
Message-ID: <20261117093819.GA15533@yadro.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-4-mkhalfella@purestorage.com>
 <20261116084540.GA3655@yadro.com>
 <20261117000348.GD1670230-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261117000348.GD1670230-mkhalfella@purestorage.com>
X-ClientProxiedBy: RTM-EXCH-02.corp.yadro.com (10.34.9.202) To
 RTM-EXCH-06.corp.yadro.com (10.34.9.206)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/11/17 07:23:00 #28902765
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_013833_734316_6AFEB030 
X-CRM114-Status: GOOD (  30.92  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 04:03:48PM -0800, Mohamed Khalfella wrote:
> On Mon 2026-11-16 11:45:40 +0300, Dmitry Bogdanov wrote:
> > On Fri, Nov 13, 2026 at 07:04:17PM -0800, Mohamed Khalfella wrote:
> > >
> > > Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> > > Reset) command is an nvme command issued to source controller by
> > > initiator to reset impacted controller. Implement CCR command for linux
> > > nvme target.
> > >
> > > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > ---
> > >  drivers/nvme/target/admin-cmd.c | 76 ++++++++++++++++++++++++++++++
> > >  drivers/nvme/target/core.c      | 83 +++++++++++++++++++++++++++++++++
> > >  drivers/nvme/target/nvmet.h     | 13 ++++++
> > >  include/linux/nvme.h            | 23 +++++++++
> > >  4 files changed, 195 insertions(+)
> > >
> > > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > > index 5710ae53eb83..3df9db454db9 100644
> > > --- a/drivers/nvme/target/admin-cmd.c
> > > +++ b/drivers/nvme/target/admin-cmd.c
> > > @@ -378,6 +378,7 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
> > >         log->acs[nvme_admin_get_features] =
> > >         log->acs[nvme_admin_async_event] =
> > >         log->acs[nvme_admin_keep_alive] =
> > > +       log->acs[nvme_admin_cross_ctrl_reset] =
> > >                 cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
> > >  }
> > >
> > > @@ -1629,6 +1630,78 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
> > >         nvmet_req_complete(req, status);
> > >  }
> > >
> > > +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> > > +{
> > > +       struct nvmet_ctrl *ictrl, *sctrl = req->sq->ctrl;
> > > +       struct nvme_command *cmd = req->cmd;
> > > +       struct nvmet_ccr *ccr, *new_ccr;
> > > +       int ccr_active, ccr_total;
> > > +       u16 cntlid, status = NVME_SC_SUCCESS;
> > > +
> > > +       if (!nvmet_check_transfer_len(req, 0))
> > > +               return;
> > > +
> > > +       cntlid = le16_to_cpu(cmd->ccr.icid);
> > > +       if (sctrl->cntlid == cntlid) {
> > > +               req->error_loc =
> > > +                       offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
> > > +               status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> > > +               goto out;
> > > +       }
> >
> > cntlid has to be validated against the configured range of the controller
> > ids (subsys->cntlid_min <= cntlid <= subsys->cntlid_max).
> > That will allow CCR to work correctly on a distributed target.
> >
> 
> Thanks for the review. nvmet_ctrl_find_get_ccr() below will verify
> ictrl->dntlid == cntlid before proceeding with the reset. Is this not
> enough?

No, I am talking about something completely different.
On a distributed subsystem the controller id is allocated within each
own range on its node. The controller on one node does not know about
controllers's state on other nodes, the host also does not know where which
controller, it just send CCR  on every live controller to get a positive
response. So the controller should fail CCR for the out of ranged impacted
controller id to make the host send other CCR to other controller which
probably know(knew) the impacted controller. Otherwise the host will
complete the outstanding IO too early.


> Adding this check here means if either cntlid_min or cntlid_max change
> after ictrl has been created, CCR will fail saying the controller was not
> found. Why do we want to CCR to fail in this case when ictrl might
> actually be there?

Makes sense to forbid changing cntlid_min and cntlid_max for already discovered
subsystem. It is a static configruation. Or is there a scenario when
they may be changed?

> > > +
> > > +       /* Find and get impacted controller */
> > > +       ictrl = nvmet_ctrl_find_get_ccr(sctrl->subsys, sctrl->hostnqn,
> > > +                                       cmd->ccr.ciu, cntlid,
> > > +                                       le64_to_cpu(cmd->ccr.cirn));
> > > +       if (!ictrl) {
> > > +               /* Immediate Reset Successful */
> > > +               nvmet_set_result(req, 1);
> > > +               status = NVME_SC_SUCCESS;
> > > +               goto out;
> > > +       }
> > > +
> 

