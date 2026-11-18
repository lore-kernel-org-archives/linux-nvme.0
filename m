Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF30606A32F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GqM0tP54;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=bbkK8IQt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7o1VbKJ1iahQrivXLihSnEzKkzZJ4LgIfigLzGHVz1Q=; b=GqM0tP54WEPdoXoFB/hIUHnDIc
	VHD0GM5q3g1onk7/eSMzSWfc5WzGxQeY62rRJ7qMoSpwu+EDvueAtuCobOXVJoo/8NJe3v7kpA4LR
	qXcZ7BzKjErGor6Tv8cHGjW8fRAZ1KU60Wet3jrqHTXyZm186JzS5b5UQBYbRulft9xayfbnwIgXf
	qswc6iU28DDsNCM9SX5B0GfADppQEzVuVWLElSrJAIsLHUuGUGjZwKds6u34JvTdNfJswiuxUHf6V
	ajK3h2tGmNflyjyMkDlDJm+2+L0Jydm5BBug99lvrYn6DJ2sqHybyURZ+XVr5OjxbKF/g4XGwhMjl
	3o+FjsPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUOY-00000007RL2-22X7;
	Wed, 18 Nov 2026 01:23:30 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUOV-00000007RKD-3wkG
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 01:23:29 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1b244fb7fffso548117c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 17:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794965007; x=1795569807; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7o1VbKJ1iahQrivXLihSnEzKkzZJ4LgIfigLzGHVz1Q=;
        b=bbkK8IQtVUo7e0UXrJ8KtDcoev0Yj9GRwYRWja0UnD3QEN0U3UM5l54Sqzr9t7sbdB
         dOOByMfDVD6dt7CPZ6YLtAaNHw8iYh3Y4gY2hp+4TrCZH+tBt8g4aDRs0veBU0PldDxa
         Y8frjnIgq56MBu/ltke7eZW0Z2yH+OZ7yuDUMU7jhFOiErY1g6h9vDMRd+hovJr77Q4N
         FU4GiaNRy7sZY6GXbMrUQheSoVU8FjLTrSgFVYHPv3IbHk/bYiHBOcmyzDs78KGjcne7
         ayOs8yCTzqQoEfvr6F+MStdn2uxONwKzltb1FBWH91Klx23NE6uL9DH0PgZs00vcAkWa
         KZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965007; x=1795569807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7o1VbKJ1iahQrivXLihSnEzKkzZJ4LgIfigLzGHVz1Q=;
        b=iTE1IH8msFGZ0/t3pN0rF+FhC3Kmc0VZuhFxcqZnxzfF/KP3iVWWgzBVGtpcGzzwOS
         aRl0RXZUZQGllmmkqLNO9NVrr5HmOVxejuI56LIGbyOdf2s6CMPDjyyf5s2uKxoZi/j0
         D9UTZSs2c8aZ5t3CicnyJ8R8cNdJxjx7XpmNCFpFbBssfjaLG4xQlPEyJcnEdfkB68ED
         EOU9KsoVQiht0nYFpMFqzLxNHobeowDHUK3uzIhc10o3vwVXdyT+ipaERtSxPVJH+PoK
         MYcHZ1VYBpe/KuG+uJDyzcJsrchwE/jewEniMucq6psLyQFrIi4rw+JbAXDq+KEXHtbc
         WbeA==
X-Gm-Message-State: APuU4Z91xz9NYVCfvXEKEEBR6XDPzdLyNJ9eK0Mc0lEU3b6Mz0dDB7sg
	Y2XBcyr5lj0O9onsvz/3ZrX1Q1OfY20OfYkJjfqr5aW/k5PMPJ+JgygMFRLdKq3D6wp7NKhmltT
	YIM9hmqs=
X-Gm-Gg: AYBFou3WfyGu5mAQzkesD6FjzEnyj+EZzTXMYjdCUg5/XoM2IGyu0f15THI/+4IPHgY
	c1Sw5d6FCS1JfKnW87yg4Os6cMsGVMmHhhPmz2kRdWPLiVkZCnpHIe17vpR3L+nslDLZaYNU3ss
	ZBdpEzJ4/+PvEFolvDPVJBocQfAXRPsp7Xr2UVO/YaospJPBRmlC7qtPEQ41QX81ueljQQRrunc
	C3LzvV+ZXQP7+XIMKFbQSdggPJ1LVMRqH4hW2IZfL1H47eUGPPbpyh8HYZ3KRFvwLi0r90Ds3f5
	K7EeHv7gX3g3nAhyX4C4ieQibQ6+QORRE5H5Uf0mSZMzUpKlS3KzEeCOtBBtpk7z0HVKboTJD7a
	A9y1hE/WOknabdb6ccnLsSZaES6zH1L2zTzkLJdzpr2v8zNMPNF9bH26s4RoQDYRo9cuIgDfjsf
	8sCYAdMUudq1M3gv4tThjnE9LHJVp5b/eAOJ+JOtA+ddfdBgcwlXhQat98yb8TV5YxXDvzLFafm
	PP0exu7mhLe+NPbGell8PbmdX13G16W5EAACTV2dLvmcDcy+wgDYH5SMxuHR1oLY9UqYbKNG4PF
	Vmhs3TPeXqxHQLBKI1HvIGfXKbudcB6sDUgqteGfj1+AQjLmXpM=
X-Received: by 2002:a05:701b:231a:b0:169:9f67:a91b with SMTP id a92af1059eb24-1b543cb5347mr981657c88.12.1794965006461;
        Tue, 17 Nov 2026 17:23:26 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-382a63059e3sm2630107eec.5.2026.11.17.17.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 17:23:25 -0800 (PST)
Date: Tue, 17 Nov 2026 17:23:24 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 09/17] nvme: Implement cross-controller reset
 completion
Message-ID: <20261118012324.GH1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-10-mkhalfella@purestorage.com>
 <sashiko-outbox-214111@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-214111@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_172327_990629_EFB683AD 
X-CRM114-Status: GOOD (  25.03  )
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

On Sat 2026-11-14 03:29:37 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] nvme: UAF and deadlock in nvme_ccr_work() when controller is
>   not LIVE
> --
> 
> commit ccb451fbdaf89eaa6e4be835d2b43da8b0854559
> Author: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> nvme: Implement cross-controller reset completion
> 
> This commit adds ctrl->ccr_work and handles NVME_AER_NOTICE_CCR_COMPLETED
> events by reading the NVME_LOG_CCR log page and completing matching entries on
> ctrl->ccr_list.
> 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 27c33dc49175e..54b83092a9e8f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> [ ... ]
> > @@ -5060,6 +5061,48 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
> >  	kfree(log);
> >  }
> >  
> > +static void nvme_ccr_work(struct work_struct *work)
> > +{
> > +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
> > +	struct nvme_ccr_entry *ccr;
> > +	struct nvme_ccr_log_entry *entry;
> > +	struct nvme_ccr_log *log;
> > +	int num_entries, ret, i;
> > +	unsigned long flags;
> > +
> > +	log = kmalloc_obj(*log);
> > +	if (!log)
> > +		return;
> > +
> > +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> > +			   0x00, log, sizeof(*log), 0);
> 
> [Severity: High]
> Can nvme_ccr_work() submit a Get Log Page command to a destroyed or quiesced
> ctrl->admin_q when the controller is no longer live?
> 
> During controller deletion, nvme_do_delete_ctrl() calls nvme_stop_ctrl()
> before ctrl->ops->delete_ctrl() stops the admin queue, and
> nvme_uninit_ctrl() runs only after nvme_remove_admin_tag_set() has already
> destroyed ctrl->admin_q and freed ctrl->admin_tagset.  If an in-flight AEN
> completes with NVME_AER_NOTICE_CCR_COMPLETED after nvme_stop_ctrl() cancels
> ctrl->ccr_work, nvme_ccr_work() is re-queued and can access ctrl->admin_q
> while or after it is destroyed:
> 
> CPU0                                  CPU1
> nvme_do_delete_ctrl()
>   nvme_stop_ctrl()
>     cancel_work_sync(&ctrl->ccr_work)
>                                       nvme_complete_async_event()
>                                         nvme_handle_aen_notice()
>                                           queue_work(nvme_wq, &ctrl->ccr_work)
>   ctrl->ops->delete_ctrl()
>     ...
>     nvme_remove_admin_tag_set()
>       blk_mq_destroy_queue(ctrl->admin_q)
>       blk_mq_free_tag_set(ctrl->admin_tagset)
>                                       nvme_ccr_work()
>                                         nvme_get_log(ctrl, ...)
>                                           <-- use-after-free on admin_q
>   nvme_uninit_ctrl()
>     cancel_work_sync(&ctrl->ccr_work)
> 
> Because nvme_ccr_work() does not check nvme_ctrl_state(ctrl) ==
> NVME_CTRL_LIVE, it can also run while ctrl->admin_q is quiesced during reset
> or transport error recovery; nvme_get_log() then blocks in blk_execute_rq()
> waiting for the queue to be unquiesced, and the next nvme_stop_ctrl() ->
> cancel_work_sync(&ctrl->ccr_work) deadlocks before teardown can unquiesce
> ctrl->admin_q.
> 
> Checking nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE at the start of
> nvme_ccr_work() (like nvme_ana_work() and nvme_scan_work()) and cancelling
> ctrl->ccr_work in nvme_remove_admin_tag_set() before destroying
> ctrl->admin_q would avoid both issues.

Good point. Adding nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE should be
enough to close this race window becauwe we cancel the work twice.
I will update the code to do that.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261114030454.2836543-1-mkhalfella@purestorage.com?part=9

