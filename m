Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6836BC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 16:44:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD8A2073E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 16:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d+KWY8W3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD8A2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FLbOXEINQC1GH2q1qLoI/jyzgch+t70wTQUyApiQ36Q=; b=d+KWY8W3C+9kW0vHekudVgFQn
	W+8CrHxriuHXYkm2A1K5Xd52S7qjOIhngrVHPvg1+g0h5McgHL/6+khwmX5NeIgIy75jS2vRdyTKu
	3TlohfVP+AQLwEJWiAreeiO9c+BotoazqqhXo3w5CNu74EcHx+Bua+vQMRztKX6p4oTo0QGaSnYBl
	fThSTYnNV0QnyE4AtQZmbPt+W4ioZD4RSdKiIprLog53EGR19KQM4LggMnKsxJ4D2dvxusu4SNh5F
	43IPADzZc3/EYu4rSm4fb8Ayb+IrhQBA7W0UEWnuoguVTg0/DUhVSj5jBcP5rJesQ2VgZlc975UyU
	aK9+JZqhw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo8Vz-0007oT-KR; Wed, 24 Jun 2020 16:44:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo8Vw-0007mH-IK
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 16:44:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 729D968B02; Wed, 24 Jun 2020 18:44:41 +0200 (CEST)
Date: Wed, 24 Jun 2020 18:44:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed
 fields in initializers
Message-ID: <20200624164441.GA24816@lst.de>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618200235.1104587-1-niklas.cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This looks good to me, but I'd rather wait a few releases to
avoid too mush backporting pain.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
