Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B786C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j5CM5umXkPwrsLjCmQCFyBIkOwuykBSHtXmOKsEjRlI=; b=p1h5N5mTWHsgYj5QKpigZdiDsD
	Qa87HeciHhQ3fUYIcsVQDdtmde9IJQtuBa1Z7DGYOsMUFp6Uaa5mgPhp0WHvAG5M5uhKLGWHI4dWJ
	iSCiUNujpdOCDegZZmZK8Fij0+JXpd2M+BT79h4Uq4QY9o7WTtY4vlDPYmeTWZYoJHgEF6To0ixvq
	eXruWs59eQk54JN6RRwpzQTsQHCsfjfRqc92/0UjIyWNeyhW5xvf6ZADX5z4sUPg9y9RHsFOVketY
	i+EwrYbHxqgR7iM+pAdleLsIy0XaVfMvrWcwgh8EuxASG2C+EQVEde/rqeNGuyPLfkI0eFAJXJgit
	+GOdqsWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyyC8-00ECrg-18; Wed, 08 Jun 2022 16:06:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyyC1-00ECq8-QF
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 16:06:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB6FA68AA6; Wed,  8 Jun 2022 18:05:52 +0200 (CEST)
Date: Wed, 8 Jun 2022 18:05:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Michael Liang <mliang@purestorage.com>
Subject: Re: [PATCH] nvme: don't send unsupported NVME_ID_CNS_CS_CTRL
Message-ID: <20220608160552.GA18189@lst.de>
References: <20220608160305.1781896-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608160305.1781896-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_090602_040972_A549AC2E 
X-CRM114-Status: GOOD (  11.32  )
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

On Wed, Jun 08, 2022 at 10:03:05AM -0600, Caleb Sander wrote:
> Identify CNS values 0x05 to 0x0F are reserved in NVMe base spec 1.4.
> 0x06 was only added in spec 2.0. Our array implementing spec version 1.3
> correctly responds to this Identify with "Invalid Field in Command".
> The driver ignores an error status code here, but the reserved CNS value
> violates the spec and causes unnecessary traffic on the NVMe connection.

No, it does not "violate" the spec.  All NVMe TPs can be implement
for older spec versions as well, and regularly do.  So yes, your
array will return an error here and that is perfectly fine.

