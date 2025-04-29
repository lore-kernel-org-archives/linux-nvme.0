Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E271DC3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oy9o2rIX4i09EViyQN9eLw3vgtgrV2Y6NXSLqJYZNLE=; b=etnivb2TuTlevMCz7SelqSR/2G
	9dM2HBUtjJlob1nL3pAGfJWPcVpQu1fEKZOJaBVzD0YjSb2PRJ2QlfJxLojx6mpWA9LJ/95Jtfdpt
	H0n91xkew8AJmbDUZaxBK7Zc+qUalFUV5gSzPEHJZP4hPpAsEtlN95OHOOkQdjA5570hTxbYozNmO
	GZp1rT+QN3AuGzt/kxCzAnoprpfV4+XcQbB0dyOKMKs4DfDhP7/GE59WW3SiLXfV8UWUr/74oy0WA
	yeVdPeqYNmVdJ4LzB3U/LHEt6pHyeHCiyvTIf9rhXSYdStwQneIYDjA57OI1lJusAgaVXwthABx4G
	bF8Dz13w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9liC-00000009sUI-1lz8;
	Tue, 29 Apr 2025 14:13:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9kUR-00000009hFj-0JKA
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 12:55:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE04C68AA6; Tue, 29 Apr 2025 14:55:05 +0200 (CEST)
Date: Tue, 29 Apr 2025 14:55:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
Message-ID: <20250429125505.GA13574@lst.de>
References: <20250424101333.2908504-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424101333.2908504-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_055511_255384_3B5C47DE 
X-CRM114-Status: GOOD (  10.89  )
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

On Thu, Apr 24, 2025 at 08:13:33PM +1000, Alistair Francis wrote:
> Ensure that TLS support is enabled in the kernel when
> NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
> used out of the box.

How did the code even build before this?


