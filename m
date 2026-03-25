Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45502109C059
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2026 19:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u4D9rC4+pGzjafwbxb1h5D8Unvhc7nlBkwxheY/yhKY=; b=CXYhiuVT5ZSfI8AVZ8BPoglAW1
	FztAWX7LRHAiMPeK6pPX9BpsaXYp1NMZfP7oADdUvgqM0s9COgy14cyhCovxVHU836JWl1MP+Zjda
	Kp0EH3PFHTIFDeQH+Gdi0oMZAY6e8GZDaZXnSDNYmOh92FQPV5U7xi8WHwDCdYihkowepigcH11r0
	GXRH2kZwUC5VHDNpWpf28dWS5lZbKTQn5xiVXErpbtXyxgYKC607gLFRIJYhutGeGCR/bhC/y+Xmo
	V7Xrd4aBYq+PxeYTM8TONT7T1ZxsF0dDuO/izfjkrzL9rCAmtuZkSEFWVP+qcg6IfVFLUQUc6kYyb
	eiEOc4+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5TW7-0000000482w-3JrN;
	Wed, 25 Mar 2026 19:03:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5TW5-0000000482P-19BU;
	Wed, 25 Mar 2026 19:03:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B4754410D;
	Wed, 25 Mar 2026 19:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E80C4CEF7;
	Wed, 25 Mar 2026 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774465424;
	bh=DgQ3qaC2Lz7JXjgQE5MdN4pJqP27wdH8+jfM7VtghJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFshch7zun/xteEkRaHuQ15A2RKwzQsU7TqxpJBs5M90rWZQZcaLJJVyI28Gk2hNZ
	 gH6rvoYJlLK+ceyM2pvvSlsxv4/kQzMWRL0SqdkLRbxGTQrYkTt4F4n4jK6reDeuqx
	 VYpoK6ZZNbD2Ts4JayS4UEQBD/mH4h7VFnYd4+aSI0NpIT3i793XrHRbf60jawrNDO
	 YdUslpWDAJ7NCczS+u8iPLc5tUmtU69RG8pbam3mw55apHbClnX+CgYtIvMXyM4TiM
	 Dz29XwzIH1TMSASf55aoQ58pOqkq4xR9vzHTqgRLYem6eVZyEgnS4sIYvhNS0KgcBB
	 +udo9tjMHmUUA==
Date: Wed, 25 Mar 2026 13:03:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Justin Tee <justintee8345@gmail.com>
Cc: hmi.jeon@samsung.com, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"neal@gompa.dev" <neal@gompa.dev>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nvme: Add nvme_setup_cmd to host_path_error
Message-ID: <acQxjZMOqj74yIJf@kbusch-mbp>
References: <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
 <CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p6>
 <945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com>
 <20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6>
 <CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_120345_328872_5B51A304 
X-CRM114-Status: GOOD (  14.96  )
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

On Wed, Mar 25, 2026 at 11:37:44AM -0700, Justin Tee wrote:
> > - After
> > nvme_setup_cmd: \
> > nvme0: qid=0, cmdid=32777, nsid=0, flags=0x0, meta=0x0, \
> > cmd=(nvme_admin_identify cns=1, ctrlid=0)
> > nvme_complete_rq: \
> > nvme0: qid=0, cmdid=32777, res=0x0, retries=0, flags=0x2, status=0x370
> 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 766e9cc4ffca..378d28b2c971 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -512,6 +512,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
> > blk_status_t nvme_host_path_error(struct request *req)
> > {
> >         nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
> > +       nvme_setup_cmd(req->q->queuedata, req);
> >         blk_mq_set_request_complete(req);
> >         nvme_complete_rq(req);
> >         return BLK_STS_OK;
> 
> Since trace_nvme_complete_rq is printing only cmdid to help identify
> the command, why not define a new TRACE_EVENT(nvme_host_path_error,
> ...) in trace.h instead?

Why are we even tracing the completion? I agree the completion without a
submission is confusing, but why don't we just skip tracing the
completion in this condition? The idea for these trace events was to
match up commands dispatched to hardware with the hardware's
posted response, so I'm not sure what value we get by synthesizing both
sides of the events.

