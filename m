Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0B3E7AD62
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6hgD7o3iJ2HUveiHrqiwWb4S5cgYHnaYDUDf9EQETEc=; b=4Cm6aete0mc93QMU23xLAYUw5E
	xnjzlw3VWz/mMjv91qzdCZ8Bb/KtQWRQ0NFcZHRQ1KHGXoCr1Ee9dahs7r09CSthn5rOFuWhovULT
	ihiEKVfeSD/ft8YhggSGVZRtsCZ6SCu6to/xErXve4ofTukL/hbdhkEneied4LVdV5vjmTDTcU0US
	zx13UhvqoYNaLgETXaRgCZy7Hqpj+fCgxA+hIXC5gxjDp6Ha35ymhwEFH/Kuid1vpYrzPV/yEufVw
	RbOJvd0MHkYpbmX99rhMvxKFlOyfeh7xJncJZ3K9N5GCzNtyEHHpl0lfQNrIPnqvfP/fk+KozXx6l
	ob8E0/fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYppv-00000000bCd-0BSR;
	Thu, 25 Dec 2025 18:13:19 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYpps-00000000bCE-2swT
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 18:13:18 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so1544258a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 10:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766686396; x=1767291196; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hgD7o3iJ2HUveiHrqiwWb4S5cgYHnaYDUDf9EQETEc=;
        b=Xb0NaWKlX5Gl/u7ARtccHHc97LB0yte8tzUKx6QEWG0/3wk3D+2f6USLgqQIQMY2Xi
         nj3DNtO8qA3lMknNT5x1RGMTARQ0o8FbscbuV7BhndPxR378RGBgsnbJ25xoSJnlX8s6
         I3AMXyB3nTwhBrmvt7vPO/uY/k/Uez+8RB0wKs10iMPEI4qAkBb9G5+wzb7o+kiiUPnw
         fXZT9yRJqjfQeGslmA+Ct7n6bg55cns+qtZa7gugdR/FAbpElzsDvjVDsvTmxm45XDbG
         eJ2FdN6oIOsuQ1GX3BBm2NUfFnlEkDwBTtxD4Bk7wptbLurrZYA15B/YgAcwxbVyZfh0
         zW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766686396; x=1767291196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hgD7o3iJ2HUveiHrqiwWb4S5cgYHnaYDUDf9EQETEc=;
        b=rWxlzeqWBrBe1TbmfHlYwW96dq606kSaE2scbg+gkQEOw5fTb9dE8FUotrKl0F45Ge
         91A84CloVRJO3P+QK8TjXfSQgqelsdhbXDCU9LIfwTvlloENm1qFWjbu6RyFgI7TAQ5A
         pyNPQbxE5nPkyWtXopjw/YrGFR9aGWkGn/dbLbrV5ObUfJkKiJcQ2BWcLpLbIJKFtvKg
         TAddppmpiNnzZ6QggtXoZHzI7ZEppJiDwSL/mwGra+f42XqiTL6+7gEUN6ZAFcUSDIow
         6WzYnuFvBV2TkU0CTfja7LYD7R2MfFKoVf4zQugH0X8Rag6QDnZ7VcVxqKCLlLUPYbUh
         KG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8hG5HbijMLw+o24ZCFszeIi/QNSqc48/XtB4tKEoHWDO2RpmA5QSXw7n5+s8JSuw+3+eZqSm4PCLR@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3fD+jNWxy1FoVx3/c3NxkfwScB01j9ByxyBiR9IPUbOr3IbTf
	sISrqIbgSPtQ03oA7gY8Vl0w/JJKd0HDmHqbNpXAYAEZhiPyNE2+tTx8EFmJZVT+Qho=
X-Gm-Gg: AY/fxX7KPD2gHP7RlmdZElwp69UZ81XD3NmsG8CglvAYSAefJcJgrauLXIaqDSQrPiV
	X9VuDZ0gB1HtDpYhJP/kttcodaiFqvUbdgBzWGX7vaGaX9l79T6xOg2vSvS18MIIiLR7dt0/ZHp
	AoDfYYjkEoY77SIElvOvXGiPRTalfW+bXThrrnN6WXdUsl3aSAmoIiF42K+yyxTf3db94JEDUAs
	AQ1mG1MHGcHCwdbVzHAyfudcgFfA561V/IIqGXR/PUi2yMW+IsWJz158e/Zw+SCmm+8hauTHX4q
	I/9+Up8WvFxuc1jfu7hsz5pL8tZUwX8H3nr8YfmVBH5djv+GlY4xLIa6MlAForWE6jaF9ddVzho
	zQV0hKB/gtfck/vDOKU9iJjub4e5pOq6pHvHaSKASHZEFkWhD8hnEKICtb4tSBRrc2WYcqaM/HT
	lqQoTfUikzxLoeCLQ=
X-Google-Smtp-Source: AGHT+IGg/8ZqY1GLplovc57sq7jXcZokEvESLzzFd8J3CScL0LLjIaQVQtIE5xKF/k84Sv74zPO3Gg==
X-Received: by 2002:a05:7022:6291:b0:119:e569:f61e with SMTP id a92af1059eb24-121722e12e7mr18317369c88.23.1766686395398;
        Thu, 25 Dec 2025 10:13:15 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::1305])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-121724ddc30sm80960225c88.6.2025.12.25.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 10:13:15 -0800 (PST)
Date: Thu, 25 Dec 2025 10:13:13 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/14] nvmet: Send an AEN on CCR completion
Message-ID: <20251225181313.GC8129-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-6-mkhalfella@purestorage.com>
 <13c2bf9c-6eac-4c48-b12c-f76e86c8ef32@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c2bf9c-6eac-4c48-b12c-f76e86c8ef32@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_101316_731836_AA53F77D 
X-CRM114-Status: GOOD (  25.50  )
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

On Thu 2025-12-25 15:23:51 +0200, Sagi Grimberg wrote:
> 
> 
> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> > Send an AEN to initiator when impacted controller exists. The
> > notification points to CCR log page that initiator can read to check
> > which CCR operation completed.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/target/core.c  | 27 +++++++++++++++++++++++----
> >   drivers/nvme/target/nvmet.h |  3 ++-
> >   include/linux/nvme.h        |  3 +++
> >   3 files changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> > index 7dbe9255ff42..60173833c3eb 100644
> > --- a/drivers/nvme/target/core.c
> > +++ b/drivers/nvme/target/core.c
> > @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
> >   	nvmet_async_events_process(ctrl);
> >   }
> >   
> > -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> > +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
> >   		u8 event_info, u8 log_page)
> >   {
> >   	struct nvmet_async_event *aen;
> > @@ -215,12 +215,17 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >   	aen->event_info = event_info;
> >   	aen->log_page = log_page;
> >   
> > -	mutex_lock(&ctrl->lock);
> >   	list_add_tail(&aen->entry, &ctrl->async_events);
> > -	mutex_unlock(&ctrl->lock);
> >   
> >   	queue_work(nvmet_wq, &ctrl->async_event_work);
> >   }
> > +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> > +		u8 event_info, u8 log_page)
> > +{
> > +	mutex_lock(&ctrl->lock);
> > +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
> > +	mutex_unlock(&ctrl->lock);
> > +}
> >   
> >   static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
> >   {
> > @@ -1788,6 +1793,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
> >   }
> >   EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
> >   
> > +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
> > +{
> > +	lockdep_assert_held(&ctrl->lock);
> > +
> > +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
> > +		return;
> > +
> > +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
> > +				     NVME_AER_NOTICE_CCR_COMPLETED,
> > +				     NVME_LOG_CCR);
> > +}
> > +
> >   static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> >   {
> >   	struct nvmet_subsys *subsys = ctrl->subsys;
> > @@ -1801,8 +1818,10 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> >   	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> >   		mutex_lock(&sctrl->lock);
> >   		list_for_each_entry(ccr, &sctrl->ccrs, entry) {
> > -			if (ccr->ctrl == ctrl)
> > +			if (ccr->ctrl == ctrl) {
> > +				nvmet_ctrl_notify_ccr(sctrl);
> >   				ccr->ctrl = NULL;
> > +			}
> 
> Is this double loop necessary? Would you have more than one controller 
> cross resetting the same

As it is implemented now CCRs are linked to sctrl. This decision can be
revisited if found suboptimal. At some point I had CCRs linked to
ctrl->subsys but that led to lock ordering issues. Double loop is
necessary to find all CCRs in all controllers and mark them done.
Yes, it is possible to have more than one sctrl resetting the same
ictrl.

> controller? Won't it be better to install a callback+opaque that the 
> controller removal will call?

Can you elaborate more on that? Better in what terms?

nvmet_ctrl_complete_pending_ccr() is called from nvmet_ctrl_free() when
we know that ctrl->ref is zero and no new CCRs will be added to this
controller because nvmet_ctrl_find_get_ccr() will not be able to get it.

