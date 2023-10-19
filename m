Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B31AC41513
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxO2inX6Yohut/Nx0hBZQFlRvXPVm06iyz4j5mEpIbo=; b=uPgdipIHBv/tNzJTt2essShW1g
	zXW0zHmlG8Wc2/1eeft/AIl7EnRiPPkWoXMhWpm9J1WAF9ma4jFno/2gq07rFA1fhYcURsizOVFif
	wWXFJ9IFEpbpwEFzpFEYtMVjYUu4286B/8J7dTM/wZIfIjdhZX3Go6FMUmRShFOEQmQ01iIP8pZaI
	VeiS4cPpSf/8ti0omfz/NVIeUrQB8nt40CwH8CG8rfRqB18gCz2MxT8kl7JCnusy3xoR+GcwB4ZVd
	ELjrf4RwAmBQGcYEr9QjPXy9PJgrw34E2yzVoBjHcetFaqvF91xxG/p0/TTzPXrhCYuqoBGmN4AIp
	VtJtoHCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLfr-00GLsX-0b;
	Thu, 19 Oct 2023 05:34:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLfp-00GLrn-07
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:34:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBA6667373; Thu, 19 Oct 2023 07:34:17 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:34:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/4] block integrity: direclty map user space addresses
Message-ID: <20231019053417.GB14346@lst.de>
References: <20231018151843.3542335-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018151843.3542335-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_223421_243324_3767A95C 
X-CRM114-Status: UNSURE (   7.48  )
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

s/direclty/directly/

in the subject.


