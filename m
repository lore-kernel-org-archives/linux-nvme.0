Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C226AC55184
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=lfAvdmxWrhaiNpQdHEXL1tWcn4
	i8N8v8RaVCfkFfT8jPc+PV3v0VwSibzmhsp3fFb1UFyuVma7HtvZPzerN3sn5inyuIa+zD2VCzq0O
	OOPGyKDcu01VJF9xaJhNM4O1iCC/T/p5KiLHUqJibQgEmvyqmc0/ZK2BtcyDYpdM4Jc7IXgHKKHke
	v0Sd4R+Kt1euZyzdURBzi0RVly6BuhgIuBNce2jRc2lqiRluDDwPRSITbzwwMOaMhizbRPxP+SKkp
	AnuT5cXhpbQ6NiOcV10X81eKCu5Dw14YfJu/86sxs1FOWUHMptziaYewF8bp/hR+Zz7LNqN+TZFx4
	POXM7T5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHpY-00000002I5G-2Juw;
	Tue, 04 Aug 2026 16:17:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHpV-00000002I4g-1r9U
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 16:17:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 333246732A; Tue,  4 Aug 2026 18:17:19 +0200 (CEST)
Date: Tue, 4 Aug 2026 18:17:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 5/5] nvme: raise FDP placement handle cap to U8_MAX
 and warn on overflow
Message-ID: <20260804161718.GA11977@lst.de>
References: <20260804021901.3777326-1-kanie@linux.alibaba.com> <20260804021901.3777326-6-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804021901.3777326-6-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_091725_624551_2D422DE4 
X-CRM114-Status: GOOD (  10.77  )
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


