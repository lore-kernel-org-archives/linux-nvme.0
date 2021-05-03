Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B140C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:51:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48B261175
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48B261175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B8BDRejdPw/3rzze+SfUWRBJfP+rFY/dxzrCku/2jr8=; b=rIo5GKRViwX0qu8SkuqS422P3
	Qb8QoXLxaCkozlQAWIvOPTaoP20cMYqjH3Pz3IITx8O2KTNsmCROBsoRNquObwvg7DQGi37Ynskvu
	2TV3ILFW/1t8D0Zpzq2yzhwRFLZvKjD4ZWvQxTM55BbOTCPBrb5NFxclRBSuJC+nSRh+HUdbe6ssv
	DLC896G1w7nhNP0Y32vD29LA5T/OpuQo1j1cHau5Be4xrRYc1c0/X+6LeRkYswuBCa9SmEuwF7ApQ
	xqH+J49oDOCZ733x83ztyhigTOr2nQhvf6OSM8T8EpzIFeujaFo8tQehE0BjF7Zgm3eT/ERVorYVg
	t/PNZVZ9w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lddfE-00EeHS-Um; Mon, 03 May 2021 18:51:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddfC-00EeHE-PX
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 18:51:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3lIFsoQGMkBXuOjY3DYpHaPut8FMe+eCwisf+SjqdBo=; b=xZDeZ7nLlGtMdr1cVv/5nCtIwf
 WV2ZCsTFR7NHMKx8cWqpEP+WdvHJfVhLt3h5KdQFZKN122dG6F1/5bTL8+QMbNZgT9Ttttgwsyg4F
 Mp6EhAvZjf10VFY3ybYNJbPN56taF+S3ot8RH3huWAt76pk7S4MtOp1CFNMQ446wsDojmfAU/60Nv
 CGs/CwlYiBbeKzqnLrB1XbBf1xx6/yNB3nv5mzmEkvOE2TunUUh+udcYXnsWS+0hL2Q81ujEIZEGf
 UQHAdJ0kxUqfCqew6LNSDaT3iN+WBoPGijQEPWLH/UPi14u979XJw8KOSgUYAJMkxuv0gDlZht26Y
 hIQAfH/g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddfA-003PgH-5e
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 18:51:25 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D8E76135F;
 Mon,  3 May 2021 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620067883;
 bh=4Pey3SLZQVljSw1aL7tfZ60ndHkmIOiBrlIeDa5cLqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=laIz6u7dI4lknhxC1lo8MU4g5rpWvh8LXGC6G7pHli1PWflG0qe/QtCPonsqa+lCh
 0PbDF2t/71XlS/jSkVv4GctNZcenX/fQ5qMV6W49LA8OCArwUT33Y9BeHQj5vmHktO
 iPgjvU7zDg9XAMA2qPEYLiSt4t40UiszVZs4LfZDY0NUc0o6FU6A2QmBpFlHhc2M18
 ymZLglgjpGmM/EX3xcrbO6ZFpFTZ1C2UJeDYbU+4LrkLb6mr3bSMtNOniowi3m4MGm
 TrcyWh32ySW/hBBl8GFtO7bTiXL2BODKTAIQgexJUzgYzly57bGHEl4iM/RFY6CtLG
 MyxVfXFzr2KCA==
Date: Mon, 3 May 2021 11:51:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210503185121.GD910137@dhcp-10-100-145-180.wdc.com>
References: <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
 <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
 <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
 <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
 <500074cf-c0e8-807b-5b30-a3474d37700f@grimberg.me>
 <20210429033328.GC24074@redsun51.ssa.fujisawa.hgst.com>
 <bd3c39f9-3768-7494-e63b-7baf9ad9b615@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd3c39f9-3768-7494-e63b-7baf9ad9b615@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_115124_262898_426A3D13 
X-CRM114-Status: GOOD (  21.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 28, 2021 at 09:52:37PM -0700, Sagi Grimberg wrote:
> 
> > The driver tracepoints captured millions of IO's where everything
> > happened as expected, so I really think something got confused and
> > mucked with the wrong request. I've added more trace points to increase
> > visibility because I frankly didn't find how that could happen just from
> > code inspection. We will also incorporate your patch below for the next
> > recreate.
> 
> Keith, does the issue still happen with eliminating the network send
> from .queue_rq() ?

This patch is successful at resolving the observed r2t issues after the
weekend test run, which is much longer than it could have run
previously. I'm happy we're narrowing this down, but I'm not seeing how
this addresses the problem. It looks like the mutex single threads the
critical parts, but maybe I'm missing something. Any ideas?
 
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index eb1feaacd11a..b3fafa536345 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -288,7 +288,7 @@ static inline void nvme_tcp_queue_request(struct
> nvme_tcp_request *req,
>          * directly, otherwise queue io_work. Also, only do that if we
>          * are on the same cpu, so we don't introduce contention.
>          */
> -       if (queue->io_cpu == __smp_processor_id() &&
> +       if (0 && queue->io_cpu == __smp_processor_id() &&
>             sync && empty && mutex_trylock(&queue->send_mutex)) {
>                 queue->more_requests = !last;
>                 nvme_tcp_send_all(queue);
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
