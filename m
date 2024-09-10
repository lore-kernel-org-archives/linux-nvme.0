Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E0ECE564
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pASl59mPlsZ0ly5klmFQ3P8+oQJBqB+gpEEf7hPwZFM=; b=LMR/GHijj2s1y7L8COcBPKWGeB
	vW/YHBiN3PsWnBdtKrVhgWJbeiVcx/CmNpjeolr5YTWcXmASlADHsfRiHdFimSlxAipyUvKS1HZ4T
	HQHdl4KbLJNwvKiu/FJPGzCt+Nuyz7RHbGobzIVZcfdf6L0OMQJtFHCbmMhB6LoNHq1pSkW5XXdMr
	Q5ySxBOoifqYU48cI4crl3ieW/1536iHMN09XOq5Qj5xIEr+L+3BVr05bc+h4dYVpJn9QYWl9QTtm
	AydvsGgJJqtyDIdthp/DSov3aftQm866v7lYnLSvx57OtBwVs6IYPLVmJZLoq36ZO/Lk8t4ZC9hG4
	Qouul7Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so25J-00000005v3b-1499;
	Tue, 10 Sep 2024 14:43:13 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so25G-00000005v3E-1yKy
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 14:43:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0E72EA448A8;
	Tue, 10 Sep 2024 14:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8AEC4CEC3;
	Tue, 10 Sep 2024 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979389;
	bh=VlJEdr9QYYpPIyU5cbd/1O5G+ppN4AVPoZzjKFByU3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQFCrKwwilRlkyw/wFXCL4rvB78DwNqGTBkq7sGC0eGSi82I9KPF7UKbZS4hSbW5a
	 z2FdLX6AfjcOS24KTu5m/VRJkslQ1qAIX5jW3/w428JCnSuDxn9L7p81qiaOFbTLgS
	 mxufpKvUQo+jCzgfQ9FvAxpAbB1jvaMPE22VZQ7qTOAHdHcLOZwtcl/qQImWG1TuuT
	 WElkoTMNjp9l8LYWFWk2iSYBPQHM4c+fxWDDFBLit/voM9zPlOc+EmHpZ1SwUyZIKO
	 wpz9tHUQM6cElcdfn3X+0Haw51SWVkggwcaO/bHQ3VbHTTycKXLrBxKCAQ/LX77Aid
	 ACK4jZoR0IztQ==
Date: Tue, 10 Sep 2024 08:43:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix link failure for TCP auth
Message-ID: <ZuBa-nuGAPs7aHK_@kbusch-mbp>
References: <20240909202118.811697-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909202118.811697-1-arnd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_074310_591686_BF831842 
X-CRM114-Status: GOOD (  18.00  )
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

On Mon, Sep 09, 2024 at 08:21:09PM +0000, Arnd Bergmann wrote:
> The nvme fabric driver calls the nvme_tls_key_lookup() function from
> nvmf_parse_key() when the keyring is enabled, but this is broken in a
> configuration with CONFIG_NVME_FABRICS=y and CONFIG_NVME_TCP=m because
> this leads to the function definition being in a loadable module:
> 
> x86_64-linux-ld: vmlinux.o: in function `nvmf_parse_key':
> fabrics.c:(.text+0xb1bdec): undefined reference to `nvme_tls_key_lookup'
> 
> Move the 'select' up to CONFIG_NVME_FABRICS itself to force this
> part to be built-in as well if needed.

Thanks, applied to nvme-6.12.

I even try to test for these odd module vs built-in scenarios, but I
missed this one. :(
 
> It may alternatively be possible to rework the code so the
> keyring is only referenced when CONFIG_NVME_HOST_AUTH is also
> set, but this version is simpler and leaves the code unchanged.

That sounds like a cleaner solution longer term, but I agree your patch
is the simpler way to handle the breakage.

