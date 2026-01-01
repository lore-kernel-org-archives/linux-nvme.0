Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BE1EEB575
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jan 2026 00:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+XV0RGzFu+u1axynRnlMhTlJbAQRp8rS4UC5tB5jCvg=; b=rDT75wzTIC11lThffaxJU9/V5K
	Kx1xU9/+wqPdiUgp49b8MMVQg58v+nnEGHeuExDuhPWqpkBU9DPl4Os4TOUAKI/d2qMhYLzzb3oeB
	L9om7hLzsJZw+9tK5C8tiZvdyuEreoV3MZi2jRWY69+HXM9q3wYaTO6WIzpG7XkdiGRZxvhJtB6Vk
	PC29/CbVtJsfIBUYLKUFH8FLiuQbFz1G0Vmcm64/wRj40/lZacpqan+2L6oJwZ8iOBgyBJY2jyK/t
	b8PHeLi2PKI1Sz/EYHSV8LfnQjraV78n+5dkxhCQnjwsYhe5dzv7hR3BdRB7GOP78SXVLCtRP72Yc
	KQyTmWrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb6XJ-00000006Sfw-0M1h;
	Thu, 01 Jan 2026 00:27:29 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb6XF-00000006SfZ-3CvO
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jan 2026 00:27:27 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-121b251438eso4791958c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 16:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767227245; x=1767832045; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XV0RGzFu+u1axynRnlMhTlJbAQRp8rS4UC5tB5jCvg=;
        b=V8QX4qO7rr5KiG5TOGHoOBrVR9dtRddLzv2yQlZNLXUzQq3+dlqDxGIFDw6+SOJrWA
         iVR1Tqt4lIg7GSBOzOJYIIxA6p6/BZD7/mcfydRvgdC9+LLCDLbt6aUU3b/KW09ij8DS
         IJyT2ex3Ru0AJWIsMXqI4cvzdB8NWzW58cRPHOncSoMDAqZTdGbhfDlbxW+GgKkE9ggV
         2evtoUCoayAAeZ+d3bPutctiD5dy0AjfprfYS4+vsi0MulW5p5cwPOdSawOyglMN9faJ
         pHAKSJ6DXOx5R1d/4ROEmumONHaxy+JknI4ulESFvNoo3GqBxhHrLARLfxOj2KS19K6o
         IGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767227245; x=1767832045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XV0RGzFu+u1axynRnlMhTlJbAQRp8rS4UC5tB5jCvg=;
        b=VAotNlmT03zcHdNW4Wu7PT3an//KYBj2LVsVkv5ZPlGNoVbVQp2aXJKqkLKhyAFPWr
         KFn8e9Y8hv2Jhj79nrsGJ3q6Dlr7kGlY+i2wmRufV1bNSBUYkjfHQr2Ngl2vRKrIN6x/
         SsDSkV+X6hroFMqel5xWS/mvPHNJpty0Vnyff7EVJDx40Hgfmamu9Xph0Eo1glDC5HK2
         HUNlF4+/4uFtBqdGklsF1hPEnHMy1czVz7dfMhEpfVemkG1hwUNtPWAfBMjkXseU510y
         S465rn/4yr/dDSwWXVzM15xqOPBa1T72AcxzCdow7N8yRnF1YJZJpAGcm3iFE2THwdFg
         5U+g==
X-Forwarded-Encrypted: i=1; AJvYcCUspqcU37JPU8cVqsz1Z/2oVPeYvjdF8qx4uPnXSsA82z4bpQOHHR2JFFdJ5fXFtXc/yaEXKKgJh0pQ@lists.infradead.org
X-Gm-Message-State: AOJu0YwYozcn1xWVhSEwwD5YGOTsK4Pr9lD/+I6fGYGizj8Y790rFoCO
	mGccka8VHuU54vmugseZ9azrzvOhC9LgG35rsGIUPb01k5gIZuOxlu48K0ZODz9QuWk=
X-Gm-Gg: AY/fxX7VV/0M5G8+ifcndH/DZqK7c8fTe8BplsPUO6KFnlkCYdXPhBzSbIFEAAJW0Ua
	gE0ahYBgpKzRyt/ZKGwujukayEeoTh55hfFSK33BNHJHfbQSnsviIULugjMiX5gXbE89cBren1S
	o2lqFrpRGgB+elO5czPYeAhY6M4SBEqU+HI1Pmyn1UJYBG/Cv0Ttu/2JyBVD4cdWkZ/qduJj20X
	kw1vkQc+RtJrZYvsJu+tgRfRM4bRfk8sFaxJgvZwvE+UfUDp1czm2hSloFaIzMgVf3r6RZGwirm
	u0Lb9wu3wEUouIuTkGNby2AapiPqZX2zZrFryKQT3PCPSCEADLl/hhZYpmSHllSAeKC1x4tAbPe
	1e0KqhtrJvmZ6zZoBrFuowpamrfnPj8pJM0iQ4yjVI3bpH/1oRDWCbs9Otk+n5UBmz7YClMQVIf
	/6QmYbP44jQBKuIrdg4SZNVT9pk3cnLRI=
X-Google-Smtp-Source: AGHT+IEqDlZJYx9J0/i4q9RqOm90pvAkTeEgM97ndXPv8ffVXmDmTbFT/1UjEiKhONdfDfozBq4Avw==
X-Received: by 2002:a05:7022:e992:b0:119:e569:f85b with SMTP id a92af1059eb24-120619872ffmr35643210c88.18.1767227244632;
        Wed, 31 Dec 2025 16:27:24 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1217253c0c6sm160469237c88.12.2025.12.31.16.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 16:27:24 -0800 (PST)
Date: Wed, 31 Dec 2025 16:27:23 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20260101002723.GS3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-11-mkhalfella@purestorage.com>
 <5befc95c-b66a-4dd8-bb72-7cc6839c7c4b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5befc95c-b66a-4dd8-bb72-7cc6839c7c4b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_162725_817150_7C969885 
X-CRM114-Status: GOOD (  37.92  )
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

On Sat 2025-12-27 12:35:23 +0200, Sagi Grimberg wrote:
> 
> 
> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> > An alive nvme controller that hits an error now will move to RECOVERING
> > state instead of RESETTING state. In RECOVERING state ctrl->err_work
> > will attempt to use cross-controller recovery to terminate inflight IOs
> > on the controller. If CCR succeeds, then switch to RESETTING state and
> > continue error recovery as usuall by tearing down controller and attempt
> > reconnecting to target. If CCR fails, then the behavior of recovery
> > depends on whether CQT is supported or not. If CQT is supported, switch
> > to time-based recovery by holding inflight IOs until it is safe for them
> > to be retried. If CQT is not supported proceed to retry requests
> > immediately, as the code currently does.
> >
> > To support implementing time-based recovery turn ctrl->err_work into
> > delayed work. Update nvme_tcp_timeout() to not complete inflight IOs
> > while controller in RECOVERING state.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/tcp.c | 52 +++++++++++++++++++++++++++++++++++------
> >   1 file changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 9a96df1a511c..ec9a713490a9 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -193,7 +193,7 @@ struct nvme_tcp_ctrl {
> >   	struct sockaddr_storage src_addr;
> >   	struct nvme_ctrl	ctrl;
> >   
> > -	struct work_struct	err_work;
> > +	struct delayed_work	err_work;
> >   	struct delayed_work	connect_work;
> >   	struct nvme_tcp_request async_req;
> >   	u32			io_queues[HCTX_MAX_TYPES];
> > @@ -611,11 +611,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
> >   
> >   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> >   {
> > -	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RECOVERING) &&
> > +	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> 
> This warrants an explanation. It is not clear at all why we should allow 
> two different
> transitions to allow error recovery to start...

The behavior of the ctrl->err_work depends on the controller state. We
go to RECOVERING only if the controller is LIVE. Otherwise, we attempt
to got to RESETTING.

> 
> >   		return;
> >   
> >   	dev_warn(ctrl->device, "starting error recovery\n");
> > -	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
> > +	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, 0);
> >   }
> >   
> >   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> > @@ -2470,12 +2471,48 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> >   	nvme_tcp_reconnect_or_remove(ctrl, ret);
> >   }
> >   
> > +static int nvme_tcp_recover_ctrl(struct nvme_ctrl *ctrl)
> > +{
> > +	unsigned long rem;
> > +
> > +	if (test_and_clear_bit(NVME_CTRL_RECOVERED, &ctrl->flags)) {
> > +		dev_info(ctrl->device, "completed time-based recovery\n");
> > +		goto done;
> > +	}
> 
> This is also not clear, why should we get here when NVME_CTRL_RECOVERED 
> is set?

NVME_CTRL_RECOVERED flag is set before scheduling ctrl->err_work as
delayed work. This is how how time-based recovery is implemented.
We get here when ctrl->err_work runs for the second time, and at this
point we know that it is safe to just reset the controller and cancel
inflight requests.

> > +
> > +	rem = nvme_recover_ctrl(ctrl);
> > +	if (!rem)
> > +		goto done;
> > +
> > +	if (!ctrl->cqt) {
> > +		dev_info(ctrl->device,
> > +			 "CCR failed, CQT not supported, skip time-based recovery\n");
> > +		goto done;
> > +	}
> > +
> > +	dev_info(ctrl->device,
> > +		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
> > +		 jiffies_to_msecs(rem));
> > +	set_bit(NVME_CTRL_RECOVERED, &ctrl->flags);
> > +	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, rem);
> > +	return -EAGAIN;
> 
> I don't think that reusing the same work to handle two completely 
> different things
> is the right approach here.
> 
> How about splitting to fence_work and err_work? That should eliminate 
> some of the
> ctrl state inspections and simplify error recovery.
> 
> > +
> > +done:
> > +	nvme_end_ctrl_recovery(ctrl);
> > +	return 0;
> > +}
> > +
> >   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   {
> > -	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> > +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
> >   				struct nvme_tcp_ctrl, err_work);
> >   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> >   
> > +	if (nvme_ctrl_state(ctrl) == NVME_CTRL_RECOVERING) {
> > +		if (nvme_tcp_recover_ctrl(ctrl))
> > +			return;
> > +	}
> > +
> 
> Yea, I think we want to rework the current design.

Good point. Splitting ctrl->fence_work simplifies things. The if
condition above will be moved to fence_work. However, we will still need
to reschedule ctrl->fence_work from within its self to implement
time-based recovery. Is this good option?

If not, and we prefer to drop NVME_CTRL_RECOVERED flag above and not
reschedule ctrl->fence_work from within its self, then we can add
another ctr->fenced_work. How about that?


