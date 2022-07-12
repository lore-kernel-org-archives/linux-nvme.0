Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA54C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=PaRwmQ3Q22uz8576s9bh6pvH2c
	6JRjRNK1f3xKMzxCl/w0WN+Zj3MPNxMwTJIwqglDh0YE02gK0EBvijV/nv6hOKkFBy2VTcQqtdiEU
	CMeVwl3wVYWpdSEepJlW4juLK+4iPLGQZQEaK9NszcfbMbT2JJeHM1m4UgFHHU9Up0GByPOY1YXH+
	Wy+X7YsynFSwG/p/6pPHDagX1NhRMQ8DxQ67UHTbacJ1QLpzmjZ1XnSS2j26WuFoeooYOqYXQtAHc
	lm+V6TwjpLoIqYr13/EsxE4fS0BXa+N5FrK4rafAHYduZ4IMuZHtLoaFBY9Hx4RDf6ExnkFFntJSD
	+aXPshbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBHxf-00CD9P-SN; Tue, 12 Jul 2022 15:38:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBHxc-00CD6A-VI
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 15:38:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A60D68AFE; Tue, 12 Jul 2022 17:38:02 +0200 (CEST)
Date: Tue, 12 Jul 2022 17:38:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, joshi.k@samsung.com,
	k.jensen@samsung.com, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] nvme-multipath: refactor nvme_mpath_add_disk
Message-ID: <20220712153801.GA28038@lst.de>
References: <20220628191016.291935-1-j.granados@samsung.com> <CGME20220628191256eucas1p2c667b40cac36183c45e45fdb6cfe5b03@eucas1p2.samsung.com> <20220628191016.291935-2-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628191016.291935-2-j.granados@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_083805_172668_8366250C 
X-CRM114-Status: UNSURE (   7.79  )
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

Thanks,

applied to nvme-5.20.

