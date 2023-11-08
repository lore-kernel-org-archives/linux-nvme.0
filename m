Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409C2C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=smIiU16QelV8h/Ig5mrNcMBDqLB5zzDI/xGpylOJXTo=; b=0a9hXgA+U8bUAaXxoyhLYxHzM/
	98gRT3KGc748WWpcPj+n5Ed8OyvkWNSM7mEJSCmD8QPGiAve6QB/2tLsB15vYWGakfu8Lp5DQTHld
	hTg8ufl+Q+I+5mKhdUyXpq5+cudPJhsjtl0JuJd3WRujZmjbW8cqMo+kcsXw/0+6vh7LcD6UI4CBO
	J4ASfwej2HJdt8qoqJuYZyB9e2M8eJU1JZflcBYjO11KQ/0BzsitO6CeuiPI4lLx4yUiZ1dfSF1ag
	LEHD4kKUHGDd5Ga16b7e6hsE0zljytBmoWmPH/CC/s+UQXbzrSnd+FbvbB8+MqGCTr94o5LNVIlzr
	2438AOcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0ciU-0039e5-0X;
	Wed, 08 Nov 2023 07:11:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0ciR-0039ct-17
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 07:11:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB4F86732D; Wed,  8 Nov 2023 08:11:04 +0100 (CET)
Date: Wed, 8 Nov 2023 08:11:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de, rnd@arndb.de,
	Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/2] nvme: keyring: fix conditional compilation
Message-ID: <20231108071104.GC4684@lst.de>
References: <20231107181421.593353-1-kbusch@meta.com> <20231107181421.593353-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107181421.593353-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_231107_525035_282D8B21 
X-CRM114-Status: GOOD (  18.52  )
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

On Tue, Nov 07, 2023 at 10:14:21AM -0800, Keith Busch wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> The keyring and auth functions can be called from both the host and
> the target side and are controlled by Kconfig options for each of the
> combinations, but the declarations are controlled by #ifdef checks
> on the shared Kconfig symbols.
> 
> This leads to link failures in combinations where one of the frontends
> is built-in and the other one is a module, and the keyring code
> ends up in a module that is not reachable from the builtin code:
> 
> ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
> core.c:(.exit.text+0x4): undefined reference to `nvme_keyring_exit'
> ld: drivers/nvme/host/core.o: in function `nvme_core_init':
> core.c:(.init.text+0x94): undefined reference to `nvme_keyring_init
> 
> ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
> tcp.c:(.text+0x4c18): undefined reference to `nvme_tls_psk_default'
> 
> Address this by moving nvme_keyring_init()/nvme_keyring_exit() into
> module init/exit functions for the keyring module.
> 
> Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

If we go with my suggestion on the previous patch this should
still work at least for now.  If the auth side would ever grow
initialization helpers we'd then need to move the main
module_init/exit to the common file and call out to auth and
keyring.


