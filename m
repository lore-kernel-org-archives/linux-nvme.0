Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313CBE8785A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 19:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZfpGUUC7DLfW3R45GND4ah/dTJAdyEs2bYq8haj1B1E=; b=aqNkzeY86n02jTgafFZRbUOy16
	1BChZAZxrCMpfc+PRZ7uuqgti4xDF3H/lPIcD1fuXasT33JivUcL3bGrakUjad7GHwVTAlrR0ZO0M
	1/Ok+SZwyi/MmC9JjoyCGYm1i31S1Wz96rN4GBWsZbzhM/ckk0AoQk53LnsHea0vwdt5EAsQhz+8y
	j7/861GQo+M0Vuh8fuLHR5g8946wk/g+0ZWhMCv+fnLlf/gKbbAKAGt4E3j/DmApWmTE6F8iPrsvK
	bMR/7MCdEY6HCcV2XwjL0DKixGx/TgKZP5GpEIkYNtXVajDLo7mC5Qy99nt4H32w92CZxF5/MtEZF
	AIFkdZWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLqC-00000007Dfy-0t2y;
	Tue, 03 Feb 2026 19:13:36 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLq9-00000007Dfb-2r2W
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 19:13:35 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-124566b6693so4247020c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 11:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770146013; x=1770750813; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfpGUUC7DLfW3R45GND4ah/dTJAdyEs2bYq8haj1B1E=;
        b=NLS3dVcihAHVYFAnLPH76SFHGD4zmFELZyh4OSWX2VwbRRizOnSQNCnCEesQbLJ6Tr
         /Zyd3wgx1DgcIaeK7StlKSKVnbGx9rNmjAtpb2WDn63iRY0cBLpt5cG1m3VKHqQtDVeP
         HmExR9kzS0Weh1X5Vw5Ce4aQOQW68e5NmyRK3iwTit/QXr1dznE7i8uSBX3ac5gPKWyd
         EXyFAz8iMAub88H8Ivj+cbwqCGpF56XFKvN7Si8X7Nr5+cvx98nbpjG+AE775Jm8adiz
         HXcO3FhEWcDiOTx7GhTMUpkuKvTTSN6HeF+3FpmGOmmtPCHBniuRdMEHRUryvjmEkmE6
         N1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146013; x=1770750813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfpGUUC7DLfW3R45GND4ah/dTJAdyEs2bYq8haj1B1E=;
        b=jF1GrM4E3yu3SpFK3dFURKMVSbtc7d68IeSBSi+fbJumXhiPTONnK66cXPshFoCG2B
         so6UTw2BZl8pK1wkNirWX3bLVyjK36z91Hngj6hfsVDtfuZeC7Fy3toLrT+3/t4pZHmL
         61UtLlPqG9FXMYJTQSIdHZ9qmtVZaurec3ZK3S8x6M0kuyQwgzGSpNtBJv9UrEL43gno
         12AgG+zU8uSJ+t72jUNwfG9w3OQfu9kVGrdSAQqudBtpYhgmjI/B3Y82ro0HNSguPLOT
         ZfD5Wev944f8DdLWebdkHKV0VflB+tzA94QUJSgurnNT4umr5eAuU63VLme6hhGnLgxb
         WMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTbvFozIiFXDEpYRWeyOP/v+FDfeqd99HF0GiMog6I5iQH89z+HdNs4D42SifQpzegM+JZ9gOXSIym@lists.infradead.org
X-Gm-Message-State: AOJu0YzZtcnHXIPS4ugW2xzOKQ/9IIBNyGao1AwjNG18QMeqVUVFjbKa
	OTbWgF30tjg+wLdhL+Tl/F17LFj+gwidP2KUf9jo7so+DS+qH04XH/rW9ce9E2V5MMA=
X-Gm-Gg: AZuq6aKlSuuHqVfRSbt0kGlFLGeFNZr+fUy2q9QzNI4O0CRihoJGU8grVG8vUjNz2yj
	JgS3QZiEHPuJ2LqIhvS5mco2/C/KnYNh87DXbX6bmrNA21/P80VACyo+tQF96LV72dig2CE3Vph
	p7fXDg6KReCiuIH+o0qtj5ooKFQy/2mQMgDPrGJ/PIEW50kAnGRpjf9M63yZ4oR8xUoomwyNu7y
	OH1Y2i6HujjjAgI9QY/iSIpWCLyCST+feSqEjWLjuRf9HpG7adkRLBQ/HqjMS0oAhMv+y+XM8o7
	SveswXgphn702QnS3GukddnkbgkNA/3BffbGQD6cCYbe/pzp09iC9NZUUbvHuINScM4iBD6wJrm
	QflU/hOQZSfxaDbrurgrmUOh9SS3AvTJE7VmA7vhM8MBpyUV+Tm6CB4nrgcIt/lY3VItTgS5FPG
	LbrKBUHJfItHOtPuA53ICL13e3f3c+tjc=
X-Received: by 2002:a05:7022:6b83:b0:11a:4016:44a5 with SMTP id a92af1059eb24-126f47c4507mr220685c88.24.1770146012358;
        Tue, 03 Feb 2026 11:13:32 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f4e042bfsm178554c88.4.2026.02.03.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 11:13:32 -0800 (PST)
Date: Tue, 3 Feb 2026 11:13:31 -0800
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
Subject: Re: [PATCH v2 07/14] nvme: Introduce FENCING and FENCED controller
 states
Message-ID: <20260203191331.GD3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-8-mkhalfella@purestorage.com>
 <fe62af4b-718c-423d-918a-d05acdadb980@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe62af4b-718c-423d-918a-d05acdadb980@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_111333_747955_9049D078 
X-CRM114-Status: GOOD (  27.11  )
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

On Tue 2026-02-03 06:07:35 +0100, Hannes Reinecke wrote:
> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > FENCING is a new controller state that a LIVE controller enter when an
> > error is encountered. While in FENCING state inflight IOs that timeout
> > are not canceled because they should be held until either CCR succeeds
> > or time-based recovery completes. While the queues remain alive requests
> > are not allowed to be sent in this state and the controller can not be
> > reset of deleted. This is intentional because resetting or deleting the
> > controller results in canceling inflight IOs.
> > 
> > FENCED is a short-term state the controller enters before it is reset.
> > It exists only to prevent manual resets to happen while controller is
> > in FENCING state.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/core.c  | 25 +++++++++++++++++++++++--
> >   drivers/nvme/host/nvme.h  |  4 ++++
> >   drivers/nvme/host/sysfs.c |  2 ++
> >   3 files changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 8961d612ccb0..3e1e02822dd4 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -574,10 +574,29 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >   			break;
> >   		}
> >   		break;
> > +	case NVME_CTRL_FENCING:
> > +		switch (old_state) {
> > +		case NVME_CTRL_LIVE:
> > +			changed = true;
> > +			fallthrough;
> > +		default:
> > +			break;
> > +		}
> > +		break;
>  > +	case NVME_CTRL_FENCED:> +		switch (old_state) {
> > +		case NVME_CTRL_FENCING:
> > +			changed = true;
> > +			fallthrough;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> >   	case NVME_CTRL_RESETTING:
> >   		switch (old_state) {
> >   		case NVME_CTRL_NEW:
> >   		case NVME_CTRL_LIVE:
> > +		case NVME_CTRL_FENCED:
> >   			changed = true;
> >   			fallthrough;
> >   		default:
> > @@ -760,6 +779,7 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
> >   
> >   	if (state != NVME_CTRL_DELETING_NOIO &&
> >   	    state != NVME_CTRL_DELETING &&
> > +	    state != NVME_CTRL_FENCING &&
> 
> Shouldn't 'FENCED' be in here, too?

Agreed. Will add FENCED to the two places.

> 
> >   	    state != NVME_CTRL_DEAD &&
> >   	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
> >   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> > @@ -802,10 +822,11 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
> >   			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_receive))
> >   				return true;
> >   			break;
> > -		default:
> > -			break;
> > +		case NVME_CTRL_FENCING:
> 
> Similar here.
> 
> >   		case NVME_CTRL_DEAD:
> >   			return false;
> > +		default:
> > +			break;
> >   		}
> >   	}
> >   
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 9dd9f179ad88..00866bbc66f3 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -251,6 +251,8 @@ static inline u16 nvme_req_qid(struct request *req)
> >   enum nvme_ctrl_state {
> >   	NVME_CTRL_NEW,
> >   	NVME_CTRL_LIVE,
> > +	NVME_CTRL_FENCING,
> > +	NVME_CTRL_FENCED,
> >   	NVME_CTRL_RESETTING,
> >   	NVME_CTRL_CONNECTING,
> >   	NVME_CTRL_DELETING,
> > @@ -777,6 +779,8 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
> >   	switch (nvme_ctrl_state(ctrl)) {
> >   	case NVME_CTRL_NEW:
> >   	case NVME_CTRL_LIVE:
> > +	case NVME_CTRL_FENCING:
> > +	case NVME_CTRL_FENCED:
> >   	case NVME_CTRL_RESETTING:
> >   	case NVME_CTRL_CONNECTING:
> >   		return false;
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index f81bbb6ec768..4ec9dfeb736e 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -443,6 +443,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
> >   	static const char *const state_name[] = {
> >   		[NVME_CTRL_NEW]		= "new",
> >   		[NVME_CTRL_LIVE]	= "live",
> > +		[NVME_CTRL_FENCING]	= "fencing",
> > +		[NVME_CTRL_FENCED]	= "fenced",
> >   		[NVME_CTRL_RESETTING]	= "resetting",
> >   		[NVME_CTRL_CONNECTING]	= "connecting",
> >   		[NVME_CTRL_DELETING]	= "deleting",
> 
> You need to modify nvme-tcp.c:nvme_tcp_timeout() too, as this checks
> 'just' for 'LIVE' state and will abort/terminate commands when in
> FENCING. Similar argument for nvme-rdma.c. And nvme-fc.c also needs an
> audit to ensure it works correctly.

Exactly. The changes to nvme-tcp, nvme-rdma, and nvme-fc are in
transport specific patches. For tcp and rdma the timeout callback
handler has been modified to do what you mentioned.

For nvme-fc nvme_fc_start_ioerr_recovery() does nothing if the
controller is in FENCING state.


