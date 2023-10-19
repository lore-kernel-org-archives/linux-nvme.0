Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49262CDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BQRr7eNUOzEmaXg/K3q/kZrHtH
	BvfBmcXYnClMNWGBk9qU50LGmUoeFiCfXIzqhiLAX21G6d+M9pmPCACFrH5US8Ud9kkV/caBguGzs
	MgMUq1U1Qji80yx/neVCBV7xkLbzED86eDwwn1P34xKqocp2U1zkaOfQVmcIeOzrkCpWEiUSFGkI9
	2aq58oc5bRaCGfw+Ab5mbnyTE2lZEJEzDTatC71G5w3PQHmb7kfSdKMWe5lkea2rdv/CIYyr56mVM
	TDSadJ7+TB8fCbHUzMetA5Qjxika1//MdWWXoqpcZqPoe8waA0LrNotiO2AfzO4jJNpLKwUbMZ7FN
	eFKkB+UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLfS-00GLoG-33;
	Thu, 19 Oct 2023 05:33:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLfP-00GLnD-3C
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:33:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E68EE67373; Thu, 19 Oct 2023 07:33:49 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:33:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, Niklas.Cassel@wdc.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v2] nvme: fix error-handling for io_uring
 nvme-passthrough
Message-ID: <20231019053349.GA14346@lst.de>
References: <CGME20231018193056epcas5p404b1fb38d3e9037862703690336d2d10@epcas5p4.samsung.com> <20231018192430.43606-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018192430.43606-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_223356_215157_31CAAD3C 
X-CRM114-Status: UNSURE (   8.34  )
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


