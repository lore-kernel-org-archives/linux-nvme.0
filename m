Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF26CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 05:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xUvUzuTS8wNoQxNzpjKj2qOALZrdmBJOgll97dItGwM=; b=KCagIjA0fluqrr7YPxdGF8KDqy
	MVsAL3CjlymZFituIv5h6xKBzJR+sfZ7+H6bZHo1HQaB+UHb/U7XIzbsz7v5NJ7PRPE28BqhBOlgW
	JBQlkmsBdvHsGHevYCgPlD3/eMrDwnothXimBXDAA77higWRCbNumRhZs4vAwoBxBMgOs911Oi+VZ
	xGkN6wmcT75vbm+1aB7Bb0LYpgQK+i7bOaFtXI6ez6D0BKD2NQsZMEvs7jcwiSiqgNVoM62NobxPN
	COVW41Q6c5vCe3pK9ggHVpfjenOfDc9gX9nzdQAvw3sEdrRD184cY5j6ylFifDDfS6miMRHqNLLpt
	aH00LPKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGDq-008OiS-27;
	Mon, 16 Oct 2023 05:32:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGDm-008Ofa-2l
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 05:32:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C2C36732A; Mon, 16 Oct 2023 07:32:43 +0200 (CEST)
Date: Mon, 16 Oct 2023 07:32:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme: remove unprivileged passthrough support
Message-ID: <20231016053242.GA25813@lst.de>
References: <CGME20231014090724epcas5p443807b5d724c97645a8a85fc627bf1ad@epcas5p4.samsung.com> <20231014090108.128809-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014090108.128809-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231015_223255_105810_39148571 
X-CRM114-Status: UNSURE (   8.30  )
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

(with the Fixes tag fixes up as per the comment from Greg)

