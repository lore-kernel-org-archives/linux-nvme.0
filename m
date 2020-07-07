Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C03AC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 08:47:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB6A2064B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 08:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JvaKsgw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB6A2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cpBB/v2FwC0dBseLzQx7ETL54K2Ke8Maad781Wlz8rc=; b=JvaKsgw3Wgl8CiTkiilcn/ZW/
	MlekVdSgnz+6bKi2I3Zh0t2flL+31QLNWL7rrxc9iRhhtqG9iqBQBBrIYvZ86W3hWaxuiw2XY82PN
	grv6QiUThZmIHy9XyIP7SPHeMuKjiKDnqKtMXQFcCXlG0ceq80NulIQY9nJAoA03I5iFQ9p/UL0q3
	dxTgfoULiqRp5xuiXmd6CjM+5NZSNmfkiodiK5vMbfUxEZ3KGYb7PqcnZuHHmAQ/5VsiYeFcwGq5B
	JELlDXeXmqeLl/7gwqvGo24eNSwpBgIHdZvH6N3KHKo/r3RY8Bt5z0dmguN7vC4LzntKYFZ70taEE
	QlYvtV6Sg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsjFo-0003es-St; Tue, 07 Jul 2020 08:47:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsjFm-0003eE-PF
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 08:47:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2A4D568AFE; Tue,  7 Jul 2020 10:47:00 +0200 (CEST)
Date: Tue, 7 Jul 2020 10:46:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH RFC] nvme-pci: remove the unsed code in alloc_size
Message-ID: <20200707084659.GA26962@lst.de>
References: <20200706225305.14892-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706225305.14892-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_044702_954072_AD7A600B 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 06, 2020 at 03:53:05PM -0700, Chaitanya Kulkarni wrote:
> >From the initial implementation of NVMe SGL kernel support
> commit a7a7cbe353a5 ("nvme-pci: add SGL support") with addition of the
> commit 943e942e6266 ("nvme-pci: limit max IO size and segments to avoid
> high order allocations") now there is only caller left for
> nvme_pci_iod_alloc_size() which statically passes true for last
> parameter that calculates allocation size based on SGL since we need
> size of biggest command supported for mempool allocation.
> 
> This patch removes the helper functions nvme_pci_iod_alloc_size() and
> nvme_npages() used for allocation size calculation and open codes it
> into nvme_probe().

This is an obviously correct transformation, but I think the existing
code is a land mine.  I think we should change it to use the maximum
of either the PRP or SGL case to gurantee that we are on the safe
side.  Can you do that instead?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
