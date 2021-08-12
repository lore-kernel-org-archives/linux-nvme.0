Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28DEC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 12:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B65D61038
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 12:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B65D61038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+NSbzXKUtY7vrqmnrKUUyD7DS5YJ+xV8rXWhZij4G5I=; b=Y/NdWGHwIvt3y0
	/A/5UFHFQo+9uHGHIG0M7ay1xsAbAMmF79MvkGRRpRtXa2SpLBQFq+xXPTj6Vm/jMkJRSVSLADVwq
	VXUe9jccgsWwlHDirfqH+5htOo6mLhTRbq6WUKVRcvNhvEUW75Ehle9LfKRW0uII+0E6d6yD6k4dp
	HUYcGC6mb9pEBvnkYexpypfCfItG/nbljbOF5IYXizCZyxs/Uuo60aB04IQVLlJT4eM93RNT6vWvG
	akSpdMRvCzMJ8c1+gih1mQIDajnH5d8qfzOLypBSBR69uF2TL3KOu8a2eCh2j8Tj/Ee+P01eC3NHg
	neNN0UdmrwwDsKYvYHzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mE9mO-009zsL-1I; Thu, 12 Aug 2021 12:25:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE9lw-009zru-Vr
 for linux-nvme@lists.infradead.org; Thu, 12 Aug 2021 12:25:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6B43868B05; Thu, 12 Aug 2021 14:25:18 +0200 (CEST)
Date: Thu, 12 Aug 2021 14:25:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 13/13] nvme: add non-standard ECDH and curve25517
 algorithms
Message-ID: <20210812122518.GA19050@lst.de>
References: <20210810124230.12161-1-hare@suse.de>
 <20210810124230.12161-14-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210810124230.12161-14-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210812_052521_222742_E8F03EEA 
X-CRM114-Status: GOOD (  13.51  )
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

On Tue, Aug 10, 2021 at 02:42:30PM +0200, Hannes Reinecke wrote:
> TLS 1.3 specifies ECDH and curve25517 in addition to the FFDHE
> groups, and these are already implemented in the kernel.
> So add support for these non-standard groups for NVMe in-band
> authentication to validate the augmented challenge implementation.

If you think these are useful please add them to the standard.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
