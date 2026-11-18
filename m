Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE19606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 01:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C59O7CHc;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=UHu4X9x2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NOTwfWT5exRktPS0QbPxTgTynJXt707bQrx96P7lNoM=; b=C59O7CHcckAtdCZFW+hSDQS+wu
	Evs43jzrwFVPRIbEdDN6ItHUB305u7CkxoVGaSteKbegtsg4gZDKqyCmMRwIJKV/0goXtNxk7eAIk
	MDMmw16R3sYVP6/eeFmFYRqe84peMffOsbJOX30Jbm7JTa/h+kxD7dkU5qCQ94E6ACw1TYeQkW/GQ
	IazTtqiplv+G3BpROgnT0u24MnwOsY2vTwt8jyxaVmdT7zgsBviUzLFVRNUi2+Q3SijfwfyvZGvy+
	rbr6oHpI0d8moD+x16wnE/LdhQPhr59tNXNjUfLNE687nhsXIjSsvRIzT3yAZs7UagTE0uUNHtXrm
	WbxzWG/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTU9K-00000007QVK-1bjO;
	Wed, 18 Nov 2026 01:07:46 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTU9H-00000007QUq-3Awu
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 01:07:45 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-37198ed3727so1839815eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 17:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794964063; x=1795568863; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOTwfWT5exRktPS0QbPxTgTynJXt707bQrx96P7lNoM=;
        b=UHu4X9x2oQoTpGcoCr4D9TiJYd9656KD1/d62J4+BUjogZVXLyeK7b8fSTJeB1rqcb
         9okl3qiEcxKBMZbF3XiElUxsoeJUonmHWlWj1VWvq6uf5Mk4qcC+eGZjy3qU9AiVooli
         HCrDRlY2XiwRx0Oj0ixUbTMB7SrAaUfYOYW4qr5weA+398KfgmsmkMk153atTfWfzVlR
         zWVfLo1sv331TX1IH8L5tdXORjpC2AmztMe8LTUGzAxQixp2HqDtNZUuz/mpre3hGlc7
         sF7rIvUvoOc/mJtWddY425aCdYpk/Gxtx7PGN6ykrOsCnQikkVw0VnR0H08BEYv7GiZp
         U2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794964063; x=1795568863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NOTwfWT5exRktPS0QbPxTgTynJXt707bQrx96P7lNoM=;
        b=D28jPJnc01UmElAG9HndbuSCsQiA743K+jISEECLN8tzqw0TD67geCagMrnnQpSk5j
         f7Wfv+lKR0Nkk1AcJR7Nw57XvP+ArysoKb+vSIC5QijQP8wxfrIXLiMw2pkpAEpVMWXI
         Hy0AEswNxoho2yShFAYW02Mkns95j9w1Is0KARabYIF3bsaKyJVBjyBbKDcbRDAU+sWj
         QvroRwvPzi1q65rxFyE075SvjnM+vOFYywlHSudQbnQam3wjqSzFM1X6TZ1+dxq5RneR
         +mxZb1sFOCjbxRh1fDB+hSNOu86TBT/JQbxAX42F3aR/GfteKWDnhGWuwAa1v77ZkMPv
         7MZw==
X-Gm-Message-State: APuU4Z/tAJpAilhE6JKjcQuTmbvGsJX4PPbqpPWllz7lCwURZ9nxVVEJ
	+mFURlUUSIX9i9ar0McL16oq7yQLZC8QmvoCIOB31tLFXMnLNU7Sl1E3zxgj3OzqFaK9C4JxWn7
	YI7TlcoE=
X-Gm-Gg: AZFdTZfpE5I9P8otME1CeTr7NPo9W2FugXX4SDdpCX2J5K+YO4VQ/+jaJV+9gS44W0u
	HsTYF+/2i1QFc5HzbcIXub2NoEuymXcS6Bmi3Zqexp4kOnm237x50xIWZXYo/6CZWKmgqFZiSlJ
	qKvE1HtToT4gdOwmXrzWK00AYiJFTBvT6Sa6uph6G7U8m6BmjfhNs1HR2bjOuxGzMgZn8fRuXVB
	CkGIMLshTGq0QYU6URNnBrB4zkEcghEMFH6nDKUMm74lTO4b5LnqC24c1qJpS4zo4aYrqErMMTf
	LW+dypdpxaWJUTnPH9/JuSurqhEtgejVtX+wnLZX1kFdxwKQ7Jx5cFvdOT2oRJ1qqhCG/tTnqPI
	oQdlAIyNf4ab6xEj3kB1zOm8jB3GT9JDtrIt5BNkUL/ShpOiIWz5DJ29jk7FAxlnDgnmabxMrKr
	YgK45ymrz3HsGRgH9pEIXA9JvfNi4Vu0yMn0dPZCXdVWPGFCTGQ/Fsl9RmNCG5ZLkPJwBQwE1gM
	SoVtfY8T6u9jGxx3vPY+/Je8XWRkUL9obsEZ5pSWHlQwXcEZpZmEOSHwsZ+VAvChZN/6ftG1gXL
	HkO8TtW1bKEB3NfpN5kg+uUBHVxW/MS3EYNrmNFhG3y+9WT2fA==
X-Received: by 2002:a05:7300:8283:b0:36d:be15:2dd6 with SMTP id 5a478bee46e88-3828161e0bfmr957325eec.11.1794964062301;
        Tue, 17 Nov 2026 17:07:42 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm2942951eec.3.2026.11.17.17.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 17:07:41 -0800 (PST)
Date: Tue, 17 Nov 2026 17:07:40 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 08/17] nvme: Implement cross-controller reset recovery
Message-ID: <20261118010740.GG1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-9-mkhalfella@purestorage.com>
 <sashiko-outbox-214105@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-214105@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_170743_803074_FBF37A6B 
X-CRM114-Status: GOOD (  30.12  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat 2026-11-14 03:26:40 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] nvme: nvme_find_ctrl_ccr() skips valid controllers on
>   unsorted list
> --
> 
> commit 5d2164548bbd55a6b77ef7780332ce46368dbeb8
> Author: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> nvme: Implement cross-controller reset recovery
> 
> This commit adds core cross-controller reset (CCR) recovery logic in
> nvme_fence_ctrl() and nvme_fence_timeout_ms() to terminate in-flight I/Os
> on a failed controller using a healthy controller in the same subsystem.
> 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 4be3ce2e72a78..27c33dc49175e 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -576,6 +576,157 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
> >  }
> >  EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
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
> 
> [ ... ]
> 
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
> 
> [Severity: Medium]
> Can nvme_find_ctrl_ccr() skip valid candidate controllers in subsys->ctrls
> when retrying after a failed CCR attempt?
> 
> nvme_init_subsystem() appends controllers to subsys->ctrls with
> list_add_tail(), while nvmf_connect_admin_queue() assigns a new dynamic
> ctrl->cntlid on every connect or reconnect without reordering the list.
> Because nvme_find_ctrl_ccr() stops at the first live controller with
> ctrl->cntlid >= min_cntlid rather than picking the one with the smallest
> matching cntlid, failing on an earlier list entry with a higher cntlid and
> advancing min_cntlid to sctrl->cntlid + 1 skips any later entries in
> subsys->ctrls that have smaller cntlid values, causing nvme_fence_ctrl()
> to give up on CCR early and fall back to time-based recovery.
> 

Yes, I see the issue. subsys->ctrls is not guaranteed to be orderded by
cntlid so it is possible that we miss usable controllers just because we
we already used higher cntlid. I will take a note of this issue and
address it later on.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261114030454.2836543-1-mkhalfella@purestorage.com?part=8

