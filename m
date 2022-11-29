Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51113C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmj7WT4P/odJqQzyTFU//Oon0uWazSTZm/rllaoKN8w=; b=CFpBKS+aJOQCbH0Pw18jeI2ntt
	DliYlD1jQYsyi02zcdXIsQ5TP6eTO5eBPz5KCfTfAh8O6S8WQFnShNDhLNIm+b734ab3S2qf17y/v
	e0l60w/r6n+/XEaUxMg9tMra1qGDkdI3pAFlNRsaH+yMmp3dEhftyKAnsSSkWxUzr489WQ9qfU/r5
	BiHkGhogL5rbbJBf6bp5wEY2RO3arFCffnoD/W1E1nO8DHGrv2mJayjUXQCnVPwzGbud/AKpsPkWg
	VA7jDquMIeUQ5rZ/POdz3aMtxEfMcMnVrax8wEe15lejEw982UA6HiRG0E7sR5DQpbKnyHfCo5nTX
	nZBGtBrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00pF-008sjh-SQ; Tue, 29 Nov 2022 13:39:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00pC-008si5-Ne
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 13:39:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C6C86732D; Tue, 29 Nov 2022 14:38:57 +0100 (CET)
Date: Tue, 29 Nov 2022 14:38:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lei Rao <lei.rao@intel.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hang.yuan@intel.com
Subject: Re: [PATCH] nvme: clear the prp2 field of the nvme command.
Message-ID: <20221129133856.GA13668@lst.de>
References: <20221129094811.893586-1-lei.rao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129094811.893586-1-lei.rao@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_053902_933502_EAD9A7DC 
X-CRM114-Status: GOOD (  10.16  )
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

Thanks,

I've applied the patch with a slightly update commit message to the
nvme-6.1 tree.

