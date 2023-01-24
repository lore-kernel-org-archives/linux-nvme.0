Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34DCC38142
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 06:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z0W2/JAzb1IAIKuAK3hlzI/DlWTpjKsI63H6ChFs9aw=; b=qfk/qyb01S2XqsUkCnjEJcLL+J
	zWVB1/ygDD+ZWLmxjMMUAl/wuxFFWd+jtAqOIPDNuSRCDwzeQXXQQuQNvn3VzYf5wFPWREXn+BRrD
	DW6RTGtjzFjZSFPCRvJfq2ixRjK2+hoRfBFwPVvoC/bUmXFfJU0FiBXW7zXA9cQjd05xJK3y4wHjz
	fNqrMYXHu2oI03XZxoEFV7UVdlegJ5IVFvWzobVAheou/G0kYY6AY9bGNPxfT/1HTEmddNoGhy8jO
	vAukaGpQpk30s8wp4R/wHh5gGF/Ft2VuoBlVyZzYC4/pK7CelsZ+aVZcBqrc04uiBJasBiSjxYqOv
	u2dIEwjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKCgo-002VEd-4a; Tue, 24 Jan 2023 06:21:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKCgk-002VDo-H2
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 06:21:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 758C868CFE; Tue, 24 Jan 2023 07:21:40 +0100 (CET)
Date: Tue, 24 Jan 2023 07:21:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs
 mount regression
Message-ID: <20230124062140.GA29175@lst.de>
References: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_222146_724821_90D24838 
X-CRM114-Status: UNSURE (   9.91  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Err, no.  We're not going to randomly revert things.  If you want
to be productive check the one liner Keith reported in reply to the
last report.

