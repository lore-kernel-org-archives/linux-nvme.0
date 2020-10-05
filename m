Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E96C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:48:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BB2206A1
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KoYwPl+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BB2206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VQ+zPTJX1ViUa0JLY6PqyfggwKX1R8ajcb9gsOF9zck=; b=KoYwPl+q3w6HTb3YoPBs9D2og
	vTPdJFlixSnRNM4Nap4mVQHLlzrPvg8CSfZlAeUaseQgJmq7l1uawqRc0733yTUGDRH2REEKesiss
	sU8TLftLWSHaAE9aggOrZEElJrnoa7hFgJNt2cQtqtP4q8cyGlTgx5W82hFXpgp8NpGVtt5I5p42K
	0KhJI8LFYuGle46PfPndoOH3u4RQGqWbKDwVo7frSGUCMFmNn6rgK2v/LZWJ/dMgqmeX1A2wYs7Am
	3jKDjJEdWjBNMuOuw7udZQesPQzZRonYaUwN1bTZzC7dOQq2k5BQrogCH0L3B1/F/IwSXXs1tm/Bg
	haExzCBRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPPuy-0004B0-Qf; Mon, 05 Oct 2020 12:48:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPPuv-0004A6-SO
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 12:48:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CB19267373; Mon,  5 Oct 2020 14:48:35 +0200 (CEST)
Date: Mon, 5 Oct 2020 14:48:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 2/2] nvme-loop: use xarray for loop port tracking
Message-ID: <20201005124835.GB518@lst.de>
References: <20200930045557.53669-1-chaitanya.kulkarni@wdc.com>
 <20200930045557.53669-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930045557.53669-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_084838_041630_98DD1A72 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +	unsigned long idx;
>  
> -	mutex_lock(&nvme_loop_ports_mutex);
> -	list_for_each_entry(p, &nvme_loop_ports, entry) {
> +	rcu_read_lock();
> +	xa_for_each(&nvme_loop_ports, idx, p) {

Why is the rcu_read_lock()?  We'd need a synchronize_rcu on the port
disable side.  But the manual mutex_locking seems more sensible here
anyway.

> +	xa_init(&nvme_loop_ports);

I don't think this is needed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
