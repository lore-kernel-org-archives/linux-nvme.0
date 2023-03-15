Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4B3C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5SXgci0NIPzcA+EStRsOpIQDFLWOuteDeIzGNio/z8=; b=oufm2XaVbrdDT9c/aOEPu8sjYu
	iVQTzQPhDlNTaHwSWh1+9Mk/oQRyOB5FyxK8PqhGvR7BhOab/At6rpJVwlD8Ync8FKVoqe59dyy0J
	sBO49gzkpla8XQ8pdqFBLtv7HqXEP3NL0HDB1E1oDSZtsYfmOC0cYM6YAUhQbo4fowOqER/fTijPx
	GAI6Uh4CMS5pl1mjOUiRCEN8WwviTFIUWKgRkdBgIOIeCIh45zjHKQWwByUjhjN+LoJk/RfdTd/m/
	VRy/v2jWg4qwdaKOwr405oKAaeE9MqYNNQ377pMmmrAFzB+OUeFajkiqCdLXG6GFt44vg7MI/+aH/
	jpGuGmhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRyM-00Dard-1B;
	Wed, 15 Mar 2023 14:19:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRyJ-00Dar3-2s
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 14:19:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 813B567373; Wed, 15 Mar 2023 15:19:15 +0100 (CET)
Date: Wed, 15 Mar 2023 15:19:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme-pci: drop redundant
 pci_enable_pcie_error_reporting()
Message-ID: <20230315141915.GA28429@lst.de>
References: <20230307203243.882202-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307203243.882202-1-helgaas@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_071920_075730_908B407C 
X-CRM114-Status: UNSURE (   8.73  )
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

applied to nvme-6.4.

