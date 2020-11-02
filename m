Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735A6C00A89
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 18:08:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199E12222B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 18:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9kHx0+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199E12222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zNVPvG6Ka7qRQ7ogqF5EcWi4lwEYtLh0Aux5Z/B9uW4=; b=Y9kHx0+WfZmoFaOfXFjP1WBBZ
	Ddu7nTrdB+WBhwNqs/+nr1vOXirvZCZUwlF1UPKuW5CM34+eb48pMtgUG9ulwTPCjKlRH6mp0/G3O
	ulmiIKt3u8IzIXONWdyfQTxAXc619ZeHRY/F+2knvTsqE8MUEJJc/iDPtxRQxeeIj+YWpV8+giITL
	Fwf6mfv6dRRsgm8aisbVmgCg/mt+/TH4/UMRw3Jjc2rhgivDuWS1WK30ZQQoipmvp381acKVLP4zD
	yJl/K4LCGhyn7Ftcwpy6RPWmKQZFL/a4dnENodKl3UTimoy6+gy1eBUwHzYdWn8Sn2EFg74yDpeeY
	oW6nPb1Qg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZeG1-0006zy-Rj; Mon, 02 Nov 2020 18:08:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZeG0-0006zR-2w
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 18:08:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7881868B05; Mon,  2 Nov 2020 19:08:37 +0100 (CET)
Date: Mon, 2 Nov 2020 19:08:37 +0100
From: "hch@lst.de" <hch@lst.de>
To: Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102180836.GC20182@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_130840_253352_EB5A330A 
X-CRM114-Status: GOOD (  11.20  )
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
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 02, 2020 at 04:15:01PM +0000, Javier Gonzalez wrote:
> That said, I don't mind the concept, though I recall Christoph had
> concerns about the existing 0-capacity namespace used for invalid
> formats, so I'd like to hear more on that if he has some spare time to
> comment.

Yes, I really don't think 0 sized block devices are the right interface
for namespaces we can't access.  I think the proper fix is to ensure that
we have a character device that allows submitting I/O commands for each
namespaces including those where we don't understand the I/O command set
or parts of it.  That should also really help to have a proper access
model for the KV command set.  Initially we only need NVME_IOCTL_IO64_CMD,
but eventually we'll need some support for async submissions, be
that through io_uring or other ways.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
