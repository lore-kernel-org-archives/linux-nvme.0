Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1563FC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 04:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YDbzzslTU/+/UtrCNTbymsSfWvcmR2u7CBPDzUfuzsI=; b=QDodFgzZY3anyGL4h7b8RPhniT
	Dhd6GTW6FH1JNgbXleaWeEAEXL2VssBqJ8h/kj0Nq9rLRGR4KRX6fknbc/uYvVg3IQrevD14thimj
	d4urhZLGGsg7uoY8pJ82vKNzqFjNXDmCJx+MBm3lb+zAnyI9gcZePRK1BO26NYeSKaocwuf12qDum
	rpQWTVro3Seo5ZIdnmlcnkL+NQ9zG/B8MBy3rObOLGNc9GjzzmjOHXMEuwsFSArO3UW80SZ8GCkZn
	F7htT3Zdv3Taw+sigo6VDF7YfdfsCXJZP6FnasJmgV5AQFSfZej9TVMwt87HQsI/89aLaOIWJ2M/2
	hlky8rHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Mfp-000000063t1-2GIZ;
	Wed, 09 Apr 2025 04:04:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Mfi-000000063sE-333w
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 04:04:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 70FF75C49D5;
	Wed,  9 Apr 2025 04:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BE7C4CEE3;
	Wed,  9 Apr 2025 04:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744171457;
	bh=ofr4ghqn1KYuF0Jz/nGiXbID7SqxRuuYSm3RylC7oCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0LgcqVu7DokmWrRbcut1kdqTyGqH/VNB0WEwnzw34SDEshC0zGcObra7HjIiyy/M
	 vXtR/grxocQVcGnwodXpWutgLK/kWM0VhOEJv6m4mXTLcqzJ8DALTDphQlk86I3+hj
	 WkBPRUAsFLU4TeElSciuWcryCQNdITFCThk6QM43b5HOtngIswAJ1yNIrb63gX3coR
	 jiHT0RKdgZnlIHY7V4Z4xaMbq2aQxLvZi0AEWQchP76X8XeSVg8/1YjKQ5PK/WdzIb
	 6C1FjmbvOf47Nii/+nL3rCqnigwb/KzN4VOC2vusjRGU2jr26NuHOzqfXwenHMh5tq
	 //JnVBPoJktzg==
Date: Tue, 8 Apr 2025 21:04:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
Message-ID: <20250409040415.GB4424@sol.localdomain>
References: <20250226062841.60688-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226062841.60688-1-ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_210418_824327_2E122959 
X-CRM114-Status: GOOD (  12.83  )
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

Hi,

On Tue, Feb 25, 2025 at 10:28:40PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32c().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/nvme/target/tcp.c | 92 +++++++++++----------------------------
>  1 file changed, 26 insertions(+), 66 deletions(-)

This patch never got applied.

- Eric

