Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB323C25B6B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 20:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wNTOQPV73Hy7MLtPhY+UIEup4Hnv+7LNNm+Nm3DMl9s=; b=2RdQy4fLUjPWhxy01CpBlSNiLD
	hz1O5XMRoeyTKX12hga2kNuUBZAgE3oMdsBwSy2JQUOH5m2pCHExP80TDURNTzI474/4MUvBMZziS
	zjeMKmzhf/8nRkavWyrS+5ZdDE1wB8PHaWJ+e5NGzqNSpGMo5n0Wnm58CqFvbK8fyaW3L61UNrBhe
	6Xu211aJfcNtbfWoQkQeW7CBdg2mhnJib4nXRUISl4MO312NGInfe0hCWLFt3G2sAKQ2B+MuhbUxK
	r8EWYcJBa/IWnjAvmpbagVtfEhV3kQYG+ffqCwnW+IqZkMXr7LnTvObM288tmvbwor3m6GwMT6K6J
	UUCoZvVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw6sM-00F7Oe-22;
	Thu, 26 Oct 2023 20:22:42 +0000
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qw6sK-00F7OL-16;
	Thu, 26 Oct 2023 20:22:40 +0000
Message-ID: <8edd2ee3-13a1-4873-bb59-46727c0914ea@infradead.org>
Date: Thu, 26 Oct 2023 13:22:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Oct 26 (drivers/nvme/host/core.c)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, sagi@grimberg.me
References: <20231026152213.13c2382f@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231026152213.13c2382f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 10/25/23 21:22, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231025:
> 

on S390, with:

#
# NVME Support
#
CONFIG_NVME_COMMON=m
CONFIG_NVME_KEYRING=y
CONFIG_NVME_AUTH=y
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TCP=m
CONFIG_NVME_TCP_TLS=y
# CONFIG_NVME_HOST_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support


s390-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
drivers/nvme/host/core.c:4760:(.exit.text+0x1e): undefined reference to `nvme_keyring_exit'
s390-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_init':
drivers/nvme/host/core.c:4727:(.init.text+0x122): undefined reference to `nvme_keyring_init'


-- 
~Randy

