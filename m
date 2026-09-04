Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A81BC624D3
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 23:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GqfexXcPB0MjW1WCKBzg0IktuOs6wgXBjjXnxHW8muU=; b=lgZ4Jh7lHLazRUv+9qdyX+JUGH
	rVkms/9v/5+cmndLnEg/Sf9xXrhSrsCi4R3IpuzPmVqzDeVonIkjXlhNrDAEODKk+epyxEktNkhvJ
	oJ7TNsGvflGxxhCcX53g+KRzqcci3zGH2t3J8rhsR1bWibyfV6aBXX+s4VvjKzHKrhZ1lb8IX8308
	TYR6cFc0qQ3rejdiZ9WYKTo3C5WfUbWBx0f5kSPEJThkDKq7UC4LVDmX4C9cJaZ+63vIPrTkDuNon
	b4YFeFgPnESpWXHs0yahGnDuQs0QvaOyvM9yPn32tNn3bm+MihYFeucSpkO1rzFBeYkU14Lw9pnYp
	I2SzJI1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cxr-00000003SDq-1D4m;
	Fri, 04 Sep 2026 23:04:55 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cxo-00000003SDT-1rZj
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 23:04:53 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso1667592a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788563091; x=1789167891; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqfexXcPB0MjW1WCKBzg0IktuOs6wgXBjjXnxHW8muU=;
        b=YD7tLNDufRByrz/BuVzLyjQVKDCTnZ6qWRfPxTgGN3+cBV7v0DgKIm6QEFi6G0I1mS
         3Xw09yijD7WarYJlbv3J/Od4ehxj/ZRDz1r8IsoJ1JJ890rmYgXBpPszw0EPMg6Olpox
         pD/DULFjo9ZzmTE4kto/hExFMtZ06FYqvCFbAHdUodLbp6iERX72xhiNvITl99v8ac3b
         cza+TawNCyAg2HA7wkMa1chEW7/nUxyA14DGa/0OISWate7pdUgDCX0XhSCx3LjJJSJQ
         63B1YumnUNcneYq8CJyEGl40F2oqxO4GjdYp4HfGXtFsm0Qd7UslE/BUC36mCbR9l4Oo
         9ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788563091; x=1789167891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GqfexXcPB0MjW1WCKBzg0IktuOs6wgXBjjXnxHW8muU=;
        b=BS8rYcCFuTi7IkCsY/V6bLpd1OfWI6mtlWTVS3ZU9lPBPbdgMeYTncKEP07JyzV59n
         tW25gPgCUxdUaWwWUlaGF3KJmuDf9r3n6w0ynqV16gNcrgXt38fqZ+XL95LqCak+USzI
         gRd25P9neLFXQsGr61IaBPzMvLsfKs0rJQ3FvZeo5O79Qk1N7caTOJNai0x9sPvmS5f+
         WjiLhz5pUWmJEEj+OD9+mH4Qw0EDvPgwRKDKH6GUnn0KS75wxihKaZojiHy+5tmcPYWx
         na7G82ZvNr4xt1DlQDw+gTUz3mfCfJBQYwk9sxFqKetDlZPMjOCs17l7Ah9990hNaIZ1
         zK2w==
X-Forwarded-Encrypted: i=1; AKwUvBy2YKhBM83BrINxYvq43VbTt4d2ejiP0erJG2orOwcX1GuWUDsSko2l4zthkkxA4aTy9ZP6142cwDfC@lists.infradead.org
X-Gm-Message-State: AFuF++ltuDM2jcSBYeCcEdTHCrcoK3x0UtvCJ5CJUhDR4q0ZRf9JS/Ks
	Ff/B/COLND/DfsiC0IElDulZAx+wOnd1zwBPM7xVzseP1/YduPCH22vMSLyb8nzIuwg=
X-Gm-Gg: AYBFou1fShV3Mf9H7EughqFhe3TAIkXflWMIPG/PjK6TyuPZLSALn8d7tgH6XNimNtH
	meS7/+7J0nYJj2y71ePnloxlqPrRbYAzX0P8uJNM44HGwrpNWyeg2JrA09NdR54d0FhgrzXyG2h
	SsZ7sHeRGiGuGgzdX6h6089vUY+BzKP4FUrf4UVS+TD40NuZXJulKNvhDWslV5aP4aU3LXAeO9N
	FaIzbkiSrbf5OjpV6J1TLNgM+SFtu2sfvq9GuuqQQJ+KY7tZLkRY4h7eAErPoINB+/GWZM8L2Ny
	XP/AP8ySb7wTDa43KmmnmfHLJSqFerrAbN2JKksG1s8bhpezJEsSpVZtXSZZWrtHYp/3FuawYo7
	8WMgWnBCRdZQXFl96Gzn/Yk+y6RexjxrEEBBuuS3FlX9hCk5visidsJaQRy5HRUJZCr/jLwnTO6
	zNzDCl+mTtU8nzx+O810JUhRpUoimqaxfEnxbDzI+9X9vFAnDdRBiIcK0VJCz2q7+oyoE=
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39b260d2977mr12813287a91.4.1788563091144;
        Fri, 04 Sep 2026 16:04:51 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm5699767eec.4.2026.09.04.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:04:50 -0700 (PDT)
Date: Fri, 4 Sep 2026 16:04:48 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/16] nvme: Implement cross-controller reset recovery
Message-ID: <20260904230448.GD5552-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-9-mkhalfella@purestorage.com>
 <30475d09-bba2-460b-bf05-869f355ef106@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30475d09-bba2-460b-bf05-869f355ef106@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_160452_521378_AB57483E 
X-CRM114-Status: GOOD (  40.68  )
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

On Mon 2026-07-13 09:04:14 +0200, Hannes Reinecke wrote:
> On 7/12/26 4:23 AM, Mohamed Khalfella wrote:
> > A host that has more than one path connecting to an nvme subsystem
> > typically has an nvme controller associated with every path. This is
> > mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> > path should not be retried immediately on another path because this
> > could lead to data corruption as described in TP4129. TP8028 defines
> > cross-controller reset mechanism that can be used by host to terminate
> > IOs on the failed path using one of the remaining healthy paths. Only
> > after IOs are terminated, or long enough time passes as defined by
> > TP4129, inflight IOs should be retried on another path. Implement core
> > cross-controller reset shared logic to be used by the transports.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/constants.c |   1 +
> >   drivers/nvme/host/core.c      | 152 ++++++++++++++++++++++++++++++++++
> >   drivers/nvme/host/nvme.h      |  10 +++
> >   3 files changed, 163 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> > index dc90df9e13a2..f679efd5110e 100644
> > --- a/drivers/nvme/host/constants.c
> > +++ b/drivers/nvme/host/constants.c
> > @@ -46,6 +46,7 @@ static const char * const nvme_admin_ops[] = {
> >   	[nvme_admin_virtual_mgmt] = "Virtual Management",
> >   	[nvme_admin_nvme_mi_send] = "NVMe Send MI",
> >   	[nvme_admin_nvme_mi_recv] = "NVMe Receive MI",
> > +	[nvme_admin_cross_ctrl_reset] = "Cross Controller Reset",
> >   	[nvme_admin_dbbuf] = "Doorbell Buffer Config",
> >   	[nvme_admin_format_nvm] = "Format NVM",
> >   	[nvme_admin_security_send] = "Security Send",
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 1ef4dc38f755..a1deffc3cc00 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -571,6 +571,157 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
> >   
> > +static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
> > +					    u32 min_cntlid)
> > +{
> > +	struct nvme_subsystem *subsys = ictrl->subsys;
> > +	struct nvme_ctrl *ctrl, *sctrl = NULL;
> > +	unsigned long flags;
> > +	int ccr_used;
> > +
> > +	mutex_lock(&nvme_subsystems_lock);
> > +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > +		if (ctrl->cntlid < min_cntlid)
> > +			continue;
> > +
> > +		spin_lock_irqsave(&ctrl->lock, flags);
> > +		if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> > +			spin_unlock_irqrestore(&ctrl->lock, flags);
> > +			continue;
> > +		}
> > +
> > +		ccr_used = atomic_inc_return(&ctrl->ccr_used);
> > +		if (ccr_used > ctrl->ccrl) {
> > +			atomic_dec(&ctrl->ccr_used);
> > +			spin_unlock_irqrestore(&ctrl->lock, flags);
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * We got a good candidate source controller that is locked and
> > +		 * LIVE. However, no guarantee ctrl will not be deleted after
> > +		 * ctrl->lock is released. Get a ref of both ctrl and admin_q
> > +		 * so they do not disappear until we are done with them.
> > +		 */
> > +		WARN_ON_ONCE(!blk_get_queue(ctrl->admin_q));
> > +		nvme_get_ctrl(ctrl);
> > +		spin_unlock_irqrestore(&ctrl->lock, flags);
> > +		sctrl = ctrl;
> > +		break;
> > +	}
> > +	mutex_unlock(&nvme_subsystems_lock);
> > +	return sctrl;
> > +}
> > +
> > +static void nvme_put_ctrl_ccr(struct nvme_ctrl *sctrl)
> > +{
> > +	atomic_dec(&sctrl->ccr_used);
> > +	blk_put_queue(sctrl->admin_q);
> > +	nvme_put_ctrl(sctrl);
> > +}
> > +
> > +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl,
> > +			       unsigned long deadline)
> > +{
> > +	struct nvme_ccr_entry ccr = { };
> > +	union nvme_result res = { 0 };
> > +	struct nvme_command c = { };
> > +	unsigned long flags, now, tmo = 0;
> > +	bool completed = false;
> > +	int ret = 0;
> > +	u32 result;
> > +
> > +	init_completion(&ccr.complete);
> > +	ccr.ictrl = ictrl;
> > +
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_add_tail(&ccr.list, &sctrl->ccr_list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +
> > +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
> > +	c.ccr.ciu = ictrl->ciu;
> > +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
> > +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
> > +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
> > +				     NULL, 0, NVME_QID_ANY, 0);
> > +	if (ret) {
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	result = le32_to_cpu(res.u32);
> > +	if (result & 0x01) /* Immediate Reset Successful */
> > +		goto out;
> > +
> Do we care about any other values of 'result' ?

No we do not. It just makes the code easier to read IMO.

> 
> > +	now = jiffies;
> > +	if (time_before(now, deadline))
> > +		tmo = min_t(unsigned long,
> > +			    secs_to_jiffies(ictrl->kato), deadline - now);
> > +
> 
> Ideally we would check the request timeout for the CCR to not
> exceed 'deadline'.
> But as __nvme_submit_sync_cmd() doesn't allow to specify the timeout
> I guess it'll be good enough for now.
> (And if all goes to plan the CCR command should've been aborted in that
> case anyway).

Right, as a follow up work I would like to extend
__nvme_submit_sync_cmd() to take timeout, not in this patchset.

> 
> > +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> > +		ret = -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +
> > +	completed = true;
> > +
> > +out:
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_del(&ccr.list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +	if (completed) {
> > +		if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
> > +			return 0;
> > +		return -EREMOTEIO;
> > +	}
> > +	return ret;
> > +}
> > +
> > +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> > +{
> > +	unsigned long now, deadline, timeout;
> > +	struct nvme_ctrl *sctrl;
> > +	u32 min_cntlid = 0;
> > +	int ret;
> > +
> > +	timeout = nvme_fence_timeout_ms(ictrl);
> > +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> > +
> > +	now = jiffies;
> > +	deadline = jiffies + msecs_to_jiffies(timeout);
> > +	while (time_before(now, deadline)) {
> > +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
> > +		if (!sctrl) {
> > +			dev_dbg(ictrl->device,
> > +				"failed to find source controller\n");
> > +			return deadline - now;
> > +		}
> > +
> > +		ret = nvme_issue_wait_ccr(sctrl, ictrl, deadline);
> > +		if (!ret) {
> > +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> > +				 dev_name(sctrl->device));
> > +			nvme_put_ctrl_ccr(sctrl);
> > +			return 0;
> > +		}
> > +
> > +		/*
> > +		 * CCR command or CCR operation failed on this path.
> > +		 * Try another path as long as we have time.
> > +		 */
> > +		dev_err(ictrl->device, "CCR failed using %s, ret = %d\n",
> > +			dev_name(sctrl->device), ret);
> > +		min_cntlid = sctrl->cntlid + 1;
> > +		nvme_put_ctrl_ccr(sctrl);
> > +		now = jiffies;
> > +	}
> > +
> > +	/* Fencing timed out call it done */
> > +	dev_info(ictrl->device, "fencing timeout\n");
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_fence_ctrl);
> > +
> >   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >   		enum nvme_ctrl_state new_state)
> >   {
> > @@ -5205,6 +5356,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   
> >   	mutex_init(&ctrl->scan_lock);
> >   	INIT_LIST_HEAD(&ctrl->namespaces);
> > +	INIT_LIST_HEAD(&ctrl->ccr_list);
> >   	xa_init(&ctrl->cels);
> >   	ctrl->dev = dev;
> >   	ctrl->ops = ops;
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index e558a19781bd..90b989302e21 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -333,6 +333,13 @@ enum nvme_ctrl_flags {
> >   	NVME_CTRL_FROZEN		= 6,
> >   };
> >   
> > +struct nvme_ccr_entry {
> > +	struct list_head list;
> > +	struct completion complete;
> > +	struct nvme_ctrl *ictrl;
> > +	u8 ccrs;
> > +};
> > +
> >   struct nvme_ctrl {
> >   	bool comp_seen;
> >   	bool identified;
> > @@ -350,6 +357,7 @@ struct nvme_ctrl {
> >   	struct blk_mq_tag_set *tagset;
> >   	struct blk_mq_tag_set *admin_tagset;
> >   	struct list_head namespaces;
> > +	struct list_head ccr_list;
> >   	struct mutex namespaces_lock;
> >   	struct srcu_struct srcu;
> >   	struct device ctrl_device;
> > @@ -393,6 +401,7 @@ struct nvme_ctrl {
> >   	u16 sqsize;
> >   	u32 max_namespaces;
> >   	atomic_t abort_limit;
> > +	atomic_t ccr_used;
> >   	u8 ccrl;
> >   	u8 vwc;
> >   	u32 vs;
> > @@ -887,6 +896,7 @@ blk_status_t nvme_host_path_error(struct request *req);
> >   bool nvme_cancel_request(struct request *req, void *data);
> >   void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
> >   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
> > +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
> >   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >   		enum nvme_ctrl_state new_state);
> >   int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
> 
> Otherwise looks good.
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

