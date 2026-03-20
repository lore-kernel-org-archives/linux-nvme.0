Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224B11093182
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MI4/ON5xVks1iyUGvdfk6tQXrv
	zNpY/kDWFkAaLC5+8VW5GDYdrNVdjqfZdVb7J9p8DVZBkeI6aoTzvBmFWey15z99WfUmNXb+t9VHF
	wJdzA/rACLds7h/4gmOThMeoggUhmsNZSRb2Uo36x9iocsh+/uYpfhk33oIULBh7G76S8we0LvP6L
	70KIOZ3Ub6EMf1aU0SUnojVPgdxTuls8D7OBzMr9HuQzstdXbRxQTAy20mmQ/3BCEyGf010PbHs0l
	WwoZTbOV7E2Osuvg8outziqReF53tA2rdPgNmWvvKmLLQTU4gyg0auWRPlHQ9CuG+TsS0WoqzN0QV
	cHqCQtkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UWn-0000000CHFT-1FfZ;
	Fri, 20 Mar 2026 07:44:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UWi-0000000CHF9-1dlm
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:44:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 906596732A; Fri, 20 Mar 2026 08:44:01 +0100 (CET)
Date: Fri, 20 Mar 2026 08:44:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, yjshin0438@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 1/2] nvme: Add the DHCHAP maximum HD IDs
Message-ID: <20260320074400.GA14434@lst.de>
References: <20260320002045.1927526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320002045.1927526-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_004412_602709_C4A32BD2 
X-CRM114-Status: UNSURE (   9.20  )
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

