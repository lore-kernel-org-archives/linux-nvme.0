Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98DDCDB46E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1yLyFPGUVtgh+v8Zo9UVXQeElyTLx5pPyC4oQYNiC8Q=; b=Hkcs7+H5OoEYDif/q1Alaq0RDy
	s7k+dafBjP+Xjj4bfxZw4oovXjI0cF3+5oyTrkdfhUMiQgZ8a51mBOQYVrZryto36KRrEgQhxhYsx
	Tly6MN/gz9hYXBQu6wPwSXKEGDUVyLQ4jXCnfKBoMuk/YeJ4PlUd81oBHuCO+x2ncpAEtvkK3Dsxj
	6aCw2PXfQmy9MkZMsOukEmVGlmdMu9MKBBGTj1YaH+o+JjlOxHsZGG5zZobRKV9FXuJjLlKtAjLwf
	9cf6sZ/jB8+xJaA56mZE5f1iJOu/b+9S4mUUjFeGQ+g5enDTa/gdZKbQxy60kgf05JPudgmuTImRE
	Wm6/HYng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxJr-001Fop-18;
	Thu, 12 Oct 2023 15:09:47 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxJn-001Fnp-1H
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 15:09:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 712ADB8243E;
	Thu, 12 Oct 2023 15:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C39EC433C9;
	Thu, 12 Oct 2023 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697123380;
	bh=Rs8LElwAuvrTfQCZitXNskOQ0hGGNl1dod8VKC/cgJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8brhgkFFRNJjWzbekYGgwnXleWEq/2xzPqxndmEQHe77ivWKunuSqcUFU4Nthmmx
	 MKhC/fXbeSyS2woPxHxBxFDkM53Bac8w3pwkDvSqXMUujWUfZxjA0uZ8mg4R2ehMgw
	 ObmfFwyNvR1ozxW75FK6R6qgiyeZUpjFi4YAUIkco7FWVK+J6ZjTEn1GnEXYMDMCv2
	 hRnhJ+rJEoKm6ROyV68xg8vrPLRRcKUfAp566USj2TVnS2J0QLD5qKM8KYPyRaZqk6
	 eK+VtonHuXKsJECFiFXLNiFgEfe7k8oJ+i5WFqKbg0NMcK+acCDSr6uxg1JTylbye2
	 zCt3MY319tydQ==
Date: Thu, 12 Oct 2023 09:09:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvme: rework NVME_AUTH Kconfig selection
Message-ID: <ZSgMMstTesnlVvT7@kbusch-mbp.dhcp.thefacebook.com>
References: <20231012122248.44813-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012122248.44813-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_080943_691001_64ECAAFC 
X-CRM114-Status: UNSURE (   9.22  )
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

On Thu, Oct 12, 2023 at 02:22:48PM +0200, Hannes Reinecke wrote:
> Having a single Kconfig symbol NVME_AUTH conflates the selection
> of the authentication functions from nvme/common and nvme/host,
> causing kbuild robot to complain when building the nvme target
> only. So introduce a Kconfig symbol NVME_HOST_AUTH for the nvme
> host bits and use NVME_AUTH for the common functions only.
> And move the CRYPTO selection into nvme/common to make it
> easier to read.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310120733.TlPOVeJm-lkp@intel.com/
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Applie on nvme-6.7, thanks!

