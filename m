Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2DCE8784C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vdwhwWiiYehKcYHjHdqrWTOu+VB4ebHGcBbsRbHUcE=; b=T1xHdFCFKkqx/cWv46gALAwx0A
	P2BIRzvnw0qf1s0Wi2HyC2YllApcSkaCEplJZ/qwklULVAzUL7Az0dn49QQ4dptO0osy54qZ/6xjV
	ztyKnW5qGo6GIaAoJz5CEScbDn+GBQzix84V8v30K0NkytHC3c5CBMuvg/MUBYpnOlfgJd1KTd+5k
	kXSWYvIiiqYbMeEDjne7RVkQfBnEKWiKX9OjsCHKZ7je1R1QsmgrK5tJ6m/z9RROZd/nuGHb5dwQG
	juWp8UIHvr7+Jr8/yeV2qCbtvlU4aO25GLu+gOZJFEUnh1nkfKhzIFS8nO3fzdSY76Yua9Tjf1XAa
	5xlmwI1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnKvX-00000007736-2qCV;
	Tue, 03 Feb 2026 18:15:03 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnKvU-0000000772C-0gIn
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 18:15:01 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-2b704f08e73so65820eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 10:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770142499; x=1770747299; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vdwhwWiiYehKcYHjHdqrWTOu+VB4ebHGcBbsRbHUcE=;
        b=Y5lY7zEDNw/A5ZnZw28Vv8ZMaUlm1eQV4faNpqBC/0HB5VaWNt8A3mLmtJzBJdTztj
         P+wWOoLEI8xf/ehuH5FZI1GAkQS88UmHAqLdoNUOl4916MI3eNj98xqO5859EKTrv131
         n/hZvWntGCD1INZFe2L61fTX93MW7s3VmOWBsGhikD4WNwHC0BVKu6MnygRzCZ04iCes
         UN5elmHD+UNisxKjNLoI1UCnqDnFzJpoGitUNnAg+K2xbzJ+Fa6SEtcQ6RiBa7zp7y/H
         l++2F89xHhRh7PKF8KWDCfQJwrmnu5sNPmD/7YSUaOtkJHQ/t2suetTDm0BnqufaMUPb
         jYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142499; x=1770747299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vdwhwWiiYehKcYHjHdqrWTOu+VB4ebHGcBbsRbHUcE=;
        b=exWR/WkXg8lUnYIobMcYLjxOMBAjlIjbfUz/tBckipWoKD87Q2ojQAoBluCzItskyu
         gRwgrcRc4+q5hhz7zz2OfYmsw6VaK6hPFa5Tq1KgazPo86UjE17xKhKYyMGuCOKyG4Mz
         HFVzJT58Zjkp6fh0y0ld7rP/KFwnmlUG7kX0GgVBeD8roVwn7GAarcDVzbPrguwg6U8+
         gey+zGaewufzA6U9DQRX1AofRnt+H0kxKN3qyfsGlLWlpuFQdfbVVBkmUe43xgSi7jBc
         6cdtxOCfSDuy1n/XDdTG27K4WsZ4RcVrBu+5jXf1bsIuZGs2NHpodKCqDz9kJ7M4aH3U
         McnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVT+Ft+PpLVBzi3m7uMo2ebfsZrymJTKRTSZt93bYtjs/7gffzDEru6GlGqqrUl73tBUACV7pGZG/5@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3Gotjy5zI/Pg6L3B5YjZ78YK2zbWopPUt3Ncrx+KkBd7Wtjbq
	shCYmh4mIfDgQdF2bOf3pg39HYczBCbwHTNzu7MrBEGzC1bYRF9o4pyvdT+Ko5tSkvg=
X-Gm-Gg: AZuq6aJJO+hfb4OsGWpPESd0AWaSXNn3tlpquw3DKQBb/E95OJaUa0e249lonvJxLZ5
	QK7bDOiXmtfKz+eUedJIkHsdkv1PAHHVnAd8xRRziaEYsM8RvV5r12sYOPJ5V47F+TAjtHsa0+F
	UMNopqBIZFfx4Z0z6eE6lV06aMTCcMIhyCSAefIVcXjfJiasN98Rxq+RVzARJMBk/vYTNPq0Km7
	VtUCq/SH+yXBHg4UdkQecxCGvPg+44DTA5knug303IsuFhyCCSgmAd8Yul3rCQuKf93ChMpDXC+
	Yn63clALLVko9iL4p43yCkIb6Vi8if081PlrbL+ZgH0hp9E7WqFIJJHBtE0TXZ8GvLuI6uvOdxT
	ZbHTdLw1ZhFQBmB5P15AMF+Ij2qDTxEkY1uxaYJyBr6cK/ZNJhm27U3ABpATy9ADjhyGMFktvfk
	jmczmamVc96MqyoAbS8+on0hGX0kC5Ocw=
X-Received: by 2002:a05:7300:b54d:b0:2a4:646c:e096 with SMTP id 5a478bee46e88-2b820a61b70mr1176725eec.0.1770142498693;
        Tue, 03 Feb 2026 10:14:58 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b832e4d18fsm155355eec.13.2026.02.03.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:14:58 -0800 (PST)
Date: Tue, 3 Feb 2026 10:14:57 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] nvmet: Rapid Path Failure Recovery set
 controller identify fields
Message-ID: <20260203181457.GA3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-2-mkhalfella@purestorage.com>
 <59a8d510-d06d-4d35-b911-c758c184df52@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a8d510-d06d-4d35-b911-c758c184df52@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_101500_245004_C5EF4408 
X-CRM114-Status: GOOD (  41.15  )
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

On Tue 2026-02-03 04:03:22 +0100, Hannes Reinecke wrote:
> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > TP8028 Rapid Path Failure Recovery defined new fields in controller
> > identify response. The newly defined fields are:
> > 
> > - CIU (Controller Instance UNIQUIFIER): is an 8bit non-zero value that
> > is assigned a random value when controller first created. The value is
> > expected to be incremented when RDY bit in CSTS register is asserted
> > - CIRN (Controller Instance Random Number): is 64bit random value that
> > gets generated when controller is crated. CIRN is regenerated everytime
> > RDY bit is CSTS register is asserted.
> > - CCRL (Cross-Controller Reset Limit) is an 8bit value that defines the
> > maximum number of in-progress controller reset operations. CCRL is
> > hardcoded to 4 as recommended by TP8028.
> > 
> > TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> > Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> > time limit for attempting Cross-Controller Recovery. For NVME subsystem
> > CQT is set to 0 by default to keep the current behavior. The value can
> > be set from configfs if needed.
> > 
> > Make the new fields available for IO controllers only since TP8028 is
> > not very useful for discovery controllers.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/target/admin-cmd.c |  6 ++++++
> >   drivers/nvme/target/configfs.c  | 31 +++++++++++++++++++++++++++++++
> >   drivers/nvme/target/core.c      | 12 ++++++++++++
> >   drivers/nvme/target/nvmet.h     |  4 ++++
> >   include/linux/nvme.h            | 15 ++++++++++++---
> >   5 files changed, 65 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index 3da31bb1183e..ade1145df72d 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -696,6 +696,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >   
> >   	id->cntlid = cpu_to_le16(ctrl->cntlid);
> >   	id->ver = cpu_to_le32(ctrl->subsys->ver);
> > +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> > +		id->cqt = cpu_to_le16(ctrl->cqt);
> > +		id->ciu = ctrl->ciu;
> > +		id->cirn = cpu_to_le64(ctrl->cirn);
> > +		id->ccrl = NVMF_CCR_LIMIT;
> > +	}
> >   
> >   	/* XXX: figure out what to do about RTD3R/RTD3 */
> >   	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
> > diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> > index e44ef69dffc2..035f6e75a818 100644
> > --- a/drivers/nvme/target/configfs.c
> > +++ b/drivers/nvme/target/configfs.c
> > @@ -1636,6 +1636,36 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
> >   CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
> >   #endif
> >   
> > +static ssize_t nvmet_subsys_attr_cqt_show(struct config_item *item,
> > +					  char *page)
> > +{
> > +	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cqt);
> > +}
> > +
> > +static ssize_t nvmet_subsys_attr_cqt_store(struct config_item *item,
> > +					   const char *page, size_t cnt)
> > +{
> > +	struct nvmet_subsys *subsys = to_subsys(item);
> > +	struct nvmet_ctrl *ctrl;
> > +	u16 cqt;
> > +
> > +	if (sscanf(page, "%hu\n", &cqt) != 1)
> > +		return -EINVAL;
> > +
> > +	down_write(&nvmet_config_sem);
> > +	if (subsys->cqt == cqt)
> > +		goto out;
> > +
> > +	subsys->cqt = cqt;
> > +	/* Force reconnect */
> > +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
> > +		ctrl->ops->delete_ctrl(ctrl);
> > +out:
> > +	up_write(&nvmet_config_sem);
> > +	return cnt;
> > +}
> > +CONFIGFS_ATTR(nvmet_subsys_, attr_cqt);
> > +
> >   static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
> >   					      char *page)
> >   {
> > @@ -1676,6 +1706,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
> >   	&nvmet_subsys_attr_attr_vendor_id,
> >   	&nvmet_subsys_attr_attr_subsys_vendor_id,
> >   	&nvmet_subsys_attr_attr_model,
> > +	&nvmet_subsys_attr_attr_cqt,
> >   	&nvmet_subsys_attr_attr_qid_max,
> >   	&nvmet_subsys_attr_attr_ieee_oui,
> >   	&nvmet_subsys_attr_attr_firmware,
> 
> I do think that TP8028 (ie the CQT defintions) are somewhat independent
> on CCR. So I'm not sure if they should be integrated in this patchset;
> personally I would prefer to have it moved to another patchset.

Agreed that CQT is not directly related to CCR from the target
perspective. But there is a relationship when it comes to how the
initiator uses CQT to calculate the time budget for CCR. As you know on
the host side if CCR fails and CQT is supported the requests needs to be
held for certain amount of time before they are retried. So CQT value is
needed and that I why I included it in this patchset.

> 
> > diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> > index cc88e5a28c8a..0d2a1206e08f 100644
> > --- a/drivers/nvme/target/core.c
> > +++ b/drivers/nvme/target/core.c
> > @@ -1393,6 +1393,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
> >   		return;
> >   	}
> >   
> > +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> > +		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
> > +		ctrl->cirn = get_random_u64();
> > +	}
> >   	ctrl->csts = NVME_CSTS_RDY;
> >   
> >   	/*
> > @@ -1661,6 +1665,12 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
> >   	}
> >   	ctrl->cntlid = ret;
> >   
> > +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> > +		ctrl->cqt = subsys->cqt;
> > +		ctrl->ciu = get_random_u8() ? : 1;
> > +		ctrl->cirn = get_random_u64();
> > +	}
> > +
> >   	/*
> >   	 * Discovery controllers may use some arbitrary high value
> >   	 * in order to cleanup stale discovery sessions
> > @@ -1853,10 +1863,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
> >   
> >   	switch (type) {
> >   	case NVME_NQN_NVME:
> > +		subsys->cqt = NVMF_CQT_MS;
> >   		subsys->max_qid = NVMET_NR_QUEUES;
> >   		break;
> 
> And I would not set the CQT default here.
> Thing is, implementing CQT to the letter would inflict a CQT delay
> during failover for _every_ installation, thereby resulting in a
> regression to previous implementations where we would fail over
> with _no_ delay.
> So again, we should make it a different patchset.

CQT defaults to 0 to avoid introducing surprise delay. The initiator will
skip holding requests if it sees CQT set to 0.

