Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25700C4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Apr 2024 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XAhi9BNStgEg7LkMDm1N71kaczVYNq+7ikltwriJNiY=; b=yszPSZOW2qR957Kihe7Yw/Us0f
	wwJIvW3qJB78oLcoTO9DYSMAxC/aEysQTXrS3YDHAc6QQlgg1EdM4olIDKvmsjUdKaRjLESJWMK0a
	LLpcOgDwc7bc61N+tmnGK2IqkLpUyqIsmOYfEqN3c4a3nPKy+jPbwqlP0g1PLHX+zGTLvN5tiFov2
	oWfzh5w/P4QaSu+Q5ckDpmSo+lX8vF71+ckYD9iq5d53VwPdxdzD6gRT18aGoU0F1yYv6VfY3IdOE
	bEnwQBt/VQ1FdoSPhA3gGckHTqLqTICt3H6WUsyPYQonH1cIRtRHmAjDCL2p0zlQTfYRYG5x3sh3y
	nMiNoQGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0cKz-0000000F2tr-3OWH;
	Sat, 27 Apr 2024 07:19:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0cKw-0000000F2t0-435a
	for linux-nvme@lists.infradead.org;
	Sat, 27 Apr 2024 07:19:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44AAF68AFE; Sat, 27 Apr 2024 09:19:04 +0200 (CEST)
Date: Sat, 27 Apr 2024 09:19:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 06/10] block: modify bio_integrity_map_user argument
Message-ID: <20240427071903.GF3873@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184702epcas5p1ccb0df41b07845bc252d69007558e3fa@epcas5p1.samsung.com> <20240425183943.6319-7-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-7-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_001907_361853_C80004DC 
X-CRM114-Status: UNSURE (   9.48  )
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

On Fri, Apr 26, 2024 at 12:09:39AM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> This patch refactors bio_integrity_map_user to accept iov_iter as
> argument. This is a prep patch.

Please put the fact that you pass the iov_iter into the subject, and
use the main commit message to explain why.


