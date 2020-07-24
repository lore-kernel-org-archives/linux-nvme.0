Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDCFC433E8
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 13:44:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14E4206D8
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 13:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x9g3UV30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14E4206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BYWF1HUG0vVNMNab6O6OLQGRiBV0jZqggIK398PIBhM=; b=x9g3UV30q4NfMyaIEv3hf5EXb
	RznU6IHc6vLve35QGjvadvH8UHFXKHy1+i7WhLGKbj6ZeJ5Q9umZfXZVr7drBLyZaZMCWV19xAiXR
	0THLLlt/AMdptr7Wq1yDjJ4P5VZ+ln34K6neKmy83ccmxho94scApXkvQ2V8cKSbCq+/8xRCQRGho
	A05s08I+F84h1u3V0V3WwfXCylWfFp7jALFRT+NBG6I9TOY7PPCaq+JWRRaqonT4YBauA5oNkuY7Z
	zijQ9AIqgYfNJsFDarvVgNG7vHPBt12t0CbH8vLAmYL/tPyUwny8QD45416anbsCa+W9DYjtjpgye
	WGwHCJ6SQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyy0A-00052g-U8; Fri, 24 Jul 2020 13:44:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyy07-00051s-VY
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 13:44:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9A94A68AFE; Fri, 24 Jul 2020 15:44:37 +0200 (CEST)
Date: Fri, 24 Jul 2020 15:44:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
Message-ID: <20200724134437.GB3152@lst.de>
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
 <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
 <CAPDyKFp3D8xZCSGNMm2ZOpa5f5wMwderCuAA5yLMXdjoKFoxQw@mail.gmail.com>
 <CAK8P3a3wLPv58uqTqyXk7+0Cxoe4vdfahzCxXOp2pdGZDkeFsw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3wLPv58uqTqyXk7+0Cxoe4vdfahzCxXOp2pdGZDkeFsw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_094440_447915_F217F371 
X-CRM114-Status: GOOD (  14.06  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rui Feng <rui_feng@realsil.com.cn>,
 linux-pci <linux-pci@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Adrian Hunter <adrian.hunter@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 24, 2020 at 03:35:47PM +0200, Arnd Bergmann wrote:
> Starting simple is generally a good idea, yes.
> 
> It would be good to have feedback from the nvme driver maintainers.
> 
> One way I can see the handshake working would be to have
> an sdexpress class_driver that provides interfaces for both mmc
> and nvme to link against. The mmc core can then create a
> class device when it finds an sd-express device and that
> class device contains a simple state machine that keeps track of
> what either side think is going on, possibly also providing
> a way to perform callbacks between the two sides.

None of this is in scope for the NVMe spec, so I don't really want
to deal with it in the NVMe driver in any way.  Given that a SD
express card just turns into a normal PCIe link if you really want
to check that something probed I think you'd want to track if any
PCIe driver is bound to the device.  Or just wait and see if we really
need anything after all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
