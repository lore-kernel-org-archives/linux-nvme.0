Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E827ECFD368
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 06:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=kpeCK4v53GICjJPP00KM3xCs3X
	rWQLZaDDG8syWJlwuOd74ksLabpj6S3igoz1tMICSdkwJENoibDy7pC/lia7NSnWdR2hVcMX0cR4O
	At4aAuxUHRjwr+yniFKwS2a7WiZ7oSWitdktu7WQddatEo/B5FpibcaQSi/8kJaQwDSpiXAYh1AiT
	Z2pPV3AC5nJ9YifQ4u4pm20q2YGvt7j7pTkwnOgaffg3lZ0MtcGr+RIJeC1e2LT2hOt8U+rfDUY4v
	EoXxWApgeYVtDMAS/lexRpBby7R7yjRxIImzjVd2uOMEhMNKx3EK7FPR3H0wwDRUnnDIC+0Q3uWeN
	Z2dWi7kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNmba-0000000CpQC-26IK;
	Tue, 25 Nov 2025 06:32:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNmbX-0000000CpPd-15K9
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 06:32:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 415E568B05; Tue, 25 Nov 2025 07:32:39 +0100 (CET)
Date: Tue, 25 Nov 2025 07:32:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-tcp: use __fput_sync() to avoid use-after-free
 on reset
Message-ID: <20251125063239.GA14781@lst.de>
References: <20251125005950.41046-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125005950.41046-1-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_223247_456898_1A3EC611 
X-CRM114-Status: GOOD (  10.07  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


