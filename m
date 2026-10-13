Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBA4CC6B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ZNsfZXp4CQQbwltlWHd32f6wSX
	zf1hnfvtLT6LhJN4v3cmhJHKlf0d92E651XSEK93j/BmUqr9eh/fsdq/JkMC2H+sDNsulvSfBokxd
	Q3UTpBNAoGmAJdWWE2BWLF0AAYVkHFB8UvqhMIo1XthBMmc5gJujljHGXRVopxsFY5Y7DYilw4dZY
	ippJDu6YB7CjzFd1lrNzqOZZ8xZmtn1rGhxSHumxZA3vXaHcIFDyZIuATackP2FOnYMIDqpMNDlh4
	yrCbNCU6RuYObCOLTVNt/VyMjBIA7e6jQyjfo5Nt03UhSxjtiPaB7sWJWZ5W5Txmx+b70j2CejRb6
	0oas/CIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdcg-0000000D8B3-2CTq;
	Tue, 13 Oct 2026 14:36:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdcc-0000000D89b-3cnX
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:36:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 978FE68AFE; Tue, 13 Oct 2026 16:36:51 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:36:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com
Subject: Re: [PATCH v2 2/2] nvmet: fix use-after-free in passthru I/O
 hotpath
Message-ID: <20261013143651.GC15717@lst.de>
References: <20260929112751.2985483-1-nilay@linux.ibm.com> <20260929112751.2985483-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929112751.2985483-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073656_205499_25897115 
X-CRM114-Status: UNSURE (   8.29  )
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


