Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAA8C00A89
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 18:59:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD21B2225E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 18:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z4Q00yr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD21B2225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oG5iL9C+A6Bu7HRO/T6T9COuCK18OczCp7QViPsQkwU=; b=Z4Q00yr49ipNfPF8Wl3E/OQ/d
	LLV0/h2FZC4eoMxrtntN6jcu60YwqkgSWABlxjgjtzik5VqZhFnyMkbQnoWeNJcxeKKc1oRQet4q8
	R/fDQzzf6RS7DFODYHYHsVpUnNjk07UCE8E7ig9d5Sqh2VpYjVfzB0OxjcIpcRn6W32vodlLR7JFr
	mBflWAJMZpGp7FcD3UDYzLHxQvaZsgnKlMizbWJCaQc3QkYy7lVDxIiW/HwmMo/3B2FVpdT4/VFS6
	AEGqGUBFdKTbjt0/pbGSC2eHlTXXP5Tt4Z+xx8CCQ+NWRMpzvsviR8+qcNboNCPhRuG7akfggEMxi
	CS2BjOg7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZf2e-0004oV-RX; Mon, 02 Nov 2020 18:58:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZf2c-0004nR-6w
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 18:58:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6CCF268B05; Mon,  2 Nov 2020 19:58:51 +0100 (CET)
Date: Mon, 2 Nov 2020 19:58:51 +0100
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102185851.GA21349@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_135854_384352_67AF6604 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 02, 2020 at 10:33:55AM -0800, Keith Busch wrote:
> I can see this going one of two ways:
> 
>  a) Set up the existing controller character device with a generic
>     disk-less request_queue to the IO queues accepting IO commands to
>     arbitrary NSIDs.
> 
>  b) Each namespace that can't be supported gets their own character
>     device.
> 
> I'm leaning toward option "a". While it doesn't create handles to unique
> namespaces, it has more resilience to potentially future changes. And I
> recall the target side had a potential use for that, too.

The problem with a) is that it can't be used to give users or groups
access to just one namespaces, so it causes a real access control
nightmare.  The problem with b) is that now applications will break
when we add support for new command sets or features.  I think

  c) Each namespace gets its own character device, period.

is the only sensible option.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
