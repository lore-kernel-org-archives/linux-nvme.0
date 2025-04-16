Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0504EC369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 05:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aiSSfTARXLXB+2b6Ug2v7LTxgYSipXgqDvEptgUSWk=; b=DFreRLOFYtxxFy2X264/Izp8Bc
	P6oHnb55kELtIIRf6UQZIBs7pQ9gDdsU0cKbHXurf4NIO/zoK0ITgW71QFxNzBWmiFzY9GAuuImRy
	AeliVnLomdWrt9wmVH4LYYChqrYE3CHXPhBjPvuoGgD2QEaq3zbELM/vtnXiH2BS0AqLKw1kyiszV
	UzW154Twsgt88nYgxlvrK9k3g+RlX4TKzHdB9N3Z0e+Oi/jVn1lXQ83q5knWj5WbS1YKFjcoSd4vg
	7hOKN2qXl8nnNhLCvbk2hCb+Pts4DZEoAoUw6/lD5kJWTXh8eV/GgUp3cL5vPSKA64Q/y94OVqRJL
	aDnsPuSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vTn-00000008Iml-0ENo;
	Wed, 16 Apr 2025 05:38:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vTk-00000008ImD-418V
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 05:38:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFACA68BFE; Wed, 16 Apr 2025 07:38:25 +0200 (CEST)
Date: Wed, 16 Apr 2025 07:38:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCHv2] nvme-multipath: sysfs links may not be created for
 devices
Message-ID: <20250416053825.GA25042@lst.de>
References: <20250415064737.80953-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415064737.80953-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_223833_139034_C8C68E9F 
X-CRM114-Status: UNSURE (   7.84  )
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

applied to nvme-6.15.


