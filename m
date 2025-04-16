Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261E2C369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 05:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+KgC2jJH/6Jo/NQ+qRB4Um+A/HbSoN2qQkFubW8hFU=; b=yVEa2DcsFP5yxjbPW9ajOkWO2t
	Pmre37c2fgWBVTkXzlSdAnP2T/Y47Q7seyYRX0qum2Kp8GnCG0Yj3i2UO1YJTs999XVt2j/hUcbQV
	TUgpoS0E64+1FmY8jQ7y/XEHnceE7WwBLTcn/vc15cp74TDnHtQR/sN5+0HsG9rOZnW3jsUVmoEHT
	H992OERQ0oR3OFqVSkTMVrq/jUaMNs+PPiC4e5cUo+TYtuHmKFX0m+JQdm68CpG1ih4FQzajPIh6F
	1Wfr18XImmwviDdzxjvJcPNvCJJjO1PAR/mTHGhFvhBNBQzllfko34W0WuSLpDzv++4ZuNuE0KhSy
	QOYIBhbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vZ1-00000008Jie-2boS;
	Wed, 16 Apr 2025 05:43:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vYz-00000008Ji4-1DLa
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 05:43:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BE4168BFE; Wed, 16 Apr 2025 07:43:52 +0200 (CEST)
Date: Wed, 16 Apr 2025 07:43:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20250416054352.GA25107@lst.de>
References: <Z-axRObjXYjIHGQC@kspp> <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_224357_465960_D6EA0325 
X-CRM114-Status: UNSURE (   9.70  )
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

On Tue, Apr 15, 2025 at 06:20:03PM -0600, Gustavo A. R. Silva wrote:
> Hi all,
>
> Friendly ping: who can take this patch, please? :)

This will go into the 6.16 nvme branch as soon as it opens.


