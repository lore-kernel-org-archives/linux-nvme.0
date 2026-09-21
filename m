Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24394C982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tgZ2p2qXFtBOs8Ho6ttt5yjzkO
	veuoPgPizeDhMA3C+oRSQAZ0JKprzZkiANMqSVXPbkLD7nn4u3oTSCxVNXL835NobXubaT67poiXe
	Uy708EsvEtHj/IrbYO2+T4Xy315LE3mub3H4JFurCaHPb56ViF9KtT5KcOdbJplIBwFYgXb6T4y7X
	QDpxbW2wodHflME4gMNkco1OqH5TUld9JbsjZqkXdhpf2iRFYVTyH9m5BjLk0pN7pql2svIzY0mWz
	0TJOSUu8tyc6Rkow0Z9r0O7fgNo/Kf/4Ht909h1KVYfmMat7Azu6qh11JhDKMuTZnQArV3vo+St30
	mUgxB/fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Y04-000000018rB-2CwC;
	Mon, 21 Sep 2026 06:59:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Y02-000000018qT-0N8x
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 06:59:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C70896732A; Mon, 21 Sep 2026 08:59:34 +0200 (CEST)
Date: Mon, 21 Sep 2026 08:59:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH v2 2/2] nvmet: don't allow I/O admission after percpu
 ns reference is killed
Message-ID: <20260921065934.GB14070@lst.de>
References: <20260918162736.802665-1-nilay@linux.ibm.com> <20260918162736.802665-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918162736.802665-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_235938_270321_FFB61A4D 
X-CRM114-Status: UNSURE (   9.41  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


