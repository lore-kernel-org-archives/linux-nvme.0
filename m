Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BBBCD5BDE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0h1NtXTj4k0yISKL/IQBDSfi8r
	C419M6gQmVy4a4H1qghxvFxg1HHjdtdghd5X2ZcO7mDsL7EpErz33luMSJbg7FhfuS4Aw5HmllKVl
	ze6MVlcW9i7yj4l3Ed1x2Vx3n4uCoWcAdvPwc5JeffhOm7Ac2CgY9TnOsyqLnLSzrdvueh8xxPPwJ
	7L2SL/9ZNz+GWHdncVC2ANtB/It/zNi8e/VGMUKjhv06jRac6J5pIgS4ZAvl+hN7HT8EoGL6ThNAl
	prYiLLCgIGZR5M51AeFpkgwCBQPaH5K61hdgwdNuXRTO20wX77cZ6VIUpnU8g46HRUKJlJk/qePZk
	2uNv3gYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7wR-00000003Ppu-3vzY;
	Wed, 27 May 2026 06:40:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7wM-00000003PpW-0hWI
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 06:40:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B2A368BEB; Wed, 27 May 2026 08:40:25 +0200 (CEST)
Date: Wed, 27 May 2026 08:40:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	axboe@fb.com, sagi@grimberg.me, gjoyce@linux.ibm.com,
	mkchauras@linux.ibm.com
Subject: Re: [PATCH] nvme-multipath: fix flex array size in struct
 nvme_ns_head
Message-ID: <20260527064025.GC17042@lst.de>
References: <20260527062010.4036702-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527062010.4036702-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_234030_345494_0E3908D5 
X-CRM114-Status: UNSURE (   8.71  )
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


