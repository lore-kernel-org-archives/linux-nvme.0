Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9D7C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=D+06kXkk4UbzsAnHFOqAB2brEK
	3atD7vePSy4waQqv9wHNezQ2ZeVDUIBHfJqfTBLHL/UQEokjke/Vr08+s9gNdtPlEIw8EUpyqJCR8
	ByghLU5DP8Dv3Sme7kiO1wlieZiCzv6dADN73Rdu+JytNfiIsgRpmWuLESdY3saOETXvMrtxPkF72
	7roAEX+a66Xj2H1QuCArKAdr5XBuMGD2tJsNltTJmLaU1n3rk4JWGcrfZ30kxZ0wiP8+c3LGl0OtU
	M+4FQJA8CMxoKgHGYA4Dw1Qux11tyssR+n8E3xOPqnfbrN4VTTOq7Xo4mFNJKx4ledsj+am3SToNy
	oH+TTHnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u79BF-00000006Nwc-22gd;
	Tue, 22 Apr 2025 08:40:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78WU-00000006CxK-0Pua
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:58:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C31F868AA6; Tue, 22 Apr 2025 09:58:26 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:58:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kch@nvidia.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] nvmet: replace strncpy with strscpy
Message-ID: <20250422075826.GB32494@lst.de>
References: <20250403232432.25255-1-marcelomoreira1905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403232432.25255-1-marcelomoreira1905@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_005830_273322_FCCEAA1A 
X-CRM114-Status: UNSURE (   7.76  )
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

applied to nvme-6.16.


