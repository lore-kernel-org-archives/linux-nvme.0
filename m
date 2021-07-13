Return-Path: <SRS0=tkdf=MF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4D1C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 09:21:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F93600D1
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 09:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F93600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TZUNr4ev/v5wpCXiFCQfKvIjYnBX4IishgtMWw4Sk2w=; b=kxswEyPcCQmpfp
	FDO37Td81ORhAOPaajJIEEGoWTLlgi3A1WscCbsgC8vH8vx4SlRPugKBe77OkACYkEe0uagh3OWFZ
	EMK51Kn3o4zY/nlgYepFvrGkNsWDJO11CWiZvliTrUcNyMCNU3WAujxxjo4BnTFDTYfn+MFqbR71T
	Fp6o9fl+hyi3/awn6gTiJD6ZAgJbWHkPsYstOMPMFqfTu8qKLHd0SMgfhulmc4V1/jk3MpSavjeVJ
	nyJ4+ZKxbZ37WehHCy0DrPjwk5sm6amK/DKvQyQY0jJKloKZlx5iIeAbmaiqc/bD6S9yWEi6659KH
	DZpyzRtwYTz6aHnTudBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m3Ebb-009bsz-MK; Tue, 13 Jul 2021 09:21:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3EbY-009brG-53
 for linux-nvme@lists.infradead.org; Tue, 13 Jul 2021 09:21:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4F15167373; Tue, 13 Jul 2021 11:21:25 +0200 (CEST)
Date: Tue, 13 Jul 2021 11:21:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>,
 linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 0/3] nvmetcli: remote configuation
Message-ID: <20210713092125.GB25039@lst.de>
References: <20210212155229.98816-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210212155229.98816-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210713_022128_377321_D3700CAA 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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

So this doesn't look horrible to me, but do you plan to actually
have users for this?  Test cases would also be really helpful.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
