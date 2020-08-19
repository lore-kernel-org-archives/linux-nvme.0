Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA71C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:49:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47073207DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dxu/sUvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47073207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xQkhIfcFbfQu1qgp5QRTllGHrUNRDrNq9Q0dDmRvRxE=; b=Dxu/sUvUh+60FFUja2NATpFwA
	jBbQBH4tD8F9TiL8Uv4+BlevEzka/o3ijatOAlJMQzbQ53kX1kGDB95cStmextNL826nKJc7W2Ezc
	WFAopHcxFc3s/RnbpGKHn/TgP+F9FrpqfAAbYKcrBL3FveP340BiZkhc5ItFKE/eCPuKxKedMyxIk
	GUVfrh7O2PtHAoRrG8Nx85gePSy8Zgo/KxHGJKgziPhfsKp5HMGzXSPnqDZnIzeiZKUiZlQ4feqW0
	xVKcSUvNiN1Ht54It4L4iQetsntLEagywb1kdUkROKMQ8sbs+GHSeJ2RecNn83ZxS0pg9hWsSygIL
	oBkmv3ZaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Lem-0003Tf-Ct; Wed, 19 Aug 2020 10:49:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Leh-0003RL-1E
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 10:49:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2F14E68BEB; Wed, 19 Aug 2020 12:49:16 +0200 (CEST)
Date: Wed, 19 Aug 2020 12:49:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier@javigon.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819104915.GA3153@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
 <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
 <20200819074035.GA21991@lst.de>
 <20200819083353.rwblagiesocfcq7i@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200819083353.rwblagiesocfcq7i@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_064919_297123_49B16CB7 
X-CRM114-Status: GOOD (  10.77  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 10:33:53AM +0200, Javier Gonzalez wrote:
> I would ask you to reconsider this position. I have a hard time
> understanding how zone append emulation is a good idea in SCSI and not
> in NVMe, when there is no performance penalty.

Per the numbers on btrfs and zonefs numbers zone append emulation is
faster than using serialized writes, but also way slower than native
zone append.  Zone append emulation for SCSI is the way to bring
support for pre-existing standards into the brave new world.  Not
requiring Zone Append in a standard designed around it because of
bowing down to last minute political interventions in the standards
committee is shooting ourselves in the foot.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
