Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B7FC4167D
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 07:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JAIosTWYHkhiXVI6jW2cTu69uxKpKaQTyuO7fMB84hc=; b=x+99yJJ2idknbyPahXBBnqOmR3
	sh+hhEbwnN/C6h0Op8v3+g42MeF1/CySlMdiXg+QKSnmwrKCwCiFc6wUs+0rgCFHG9YssCvmqLu5u
	q1rMFWTDVQFC0nPLDhSet8w+rtXybpVn4y+L1epfiDkNGpTn5tgrurvlbraDUwMTI8UeAgQa5UvEj
	pgT2GTC8TN1pw70bd+v1wCLhDK/xGrkmSq2dmyD1nFKG9lu5ZJ6rAh9tIuMumggwQoZyIEY+dDNc3
	YaVMvnaiG4B3Gplaf6m68dXQZYIdnVsgWkpqxJ7tBZuhBnzLctJcvVOFUVC4U9GEw5CPZJYOOX1OA
	4dHslsuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0ch1-0039QA-1f;
	Wed, 08 Nov 2023 07:09:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0cgx-0039O0-36
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 07:09:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CF016732D; Wed,  8 Nov 2023 08:09:22 +0100 (CET)
Date: Wed, 8 Nov 2023 08:09:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de, rnd@arndb.de,
	Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/2] nvme: common: make keyring and auth separate
 modules
Message-ID: <20231108070922.GB4684@lst.de>
References: <20231107181421.593353-1-kbusch@meta.com> <20231107181421.593353-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107181421.593353-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_230936_165102_2C3790E4 
X-CRM114-Status: GOOD (  16.29  )
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

On Tue, Nov 07, 2023 at 10:14:20AM -0800, Keith Busch wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When only the keyring module is included but auth is not, modpost
> complains about the lack of a module license tag:
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-common.o
> 
> Address this by making both modules buildable standalone,
> removing the now unnecessary CONFIG_NVME_COMMON symbol
> in the process.
> 
> Also, now that NVME_KEYRING config symbol can be either a module or
> built-in, the stubs need to check for '#if IS_ENABLED' rather than a
> simple '#ifdef'.

I know I reviewed this before, but after the whole discussion this
splitting seems rather pointless.  All that we need for a minimal
fix would be to create a new file containing nothing but the
MODULE_LICENSE statement so that it is always built.  And these
two modules would be really tiny and wasteful.


