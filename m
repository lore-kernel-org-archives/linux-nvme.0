Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CD6D1A639
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gNIO54RGbPeotGEsrWiJTw++jIChZ5XaznjrCz6CtGI=; b=mnlWCNZy5wBBy3Fr/w+A5OPpqq
	L5Ui0CriRNUR+phmVJ4NLa/BK1ysXE7Cpz8ylWEF/Rx6tRQV0kv+bccA4R+rL4F2aRSqQ3TSnfArI
	pNxUTIkEBl4tAz/8MWnGxhDBVfY2T2Htp77J2Qqf2JSX4ls/xJnMAJMYRQN7m8BeIRyNmjEgwznkf
	rwsoeiEf45k7a9jjOX7bIJGY1XE6k4Z1eY5k+L88IbwIau3ZAC3dtvwW0bKlLc4JZLKuXwsFc3gUW
	dnE8ZeSn1G/YdRsAtvCGn4/5PAoCb/AWtRPQTGgtDiQNnosAovX2w5dWAa/4IKUtb62nM+hJFuJeb
	FsSE/G/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veDsq-00000002R0N-2J7y;
	Fri, 09 Jan 2026 14:54:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veDsn-00000002QzO-1e29;
	Fri, 09 Jan 2026 14:54:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0635343DC2;
	Fri,  9 Jan 2026 14:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466EFC4CEF1;
	Fri,  9 Jan 2026 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767970472;
	bh=rNKz89ursx0gV3ChF3se4ynmcQUZoXNuL8DKwVafaEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K156FxdMn32TdyO3PuIBVoIwwSUemqZanc+7u39d508EgPBMCm8P6qkM3mB9jz4E7
	 oIAWv2i+oNWWRkDfPu3FaUIC9n7nDIb3pg3KOQUKNsn/h7OPbFp+t/pvercPT+L3qy
	 ePbRY9APDHSanFlb4Yvz7jlTFA8yFomVAmwsBoU6DjoSjJXNzc5Azu8/r8qX3IOsdi
	 jViC7yaZQt4OeI2w8zgYJHkR3GueLGt5FEtk8jlxTBASN/Uv8OL3MC+jRwvWzDcVGS
	 Xwh8qO/gTeaDSqKT7zMwvI9xDLV/ykuXWgHMDfpC41jHxc33+2Wc09O4HI2Sno+8x1
	 fyyH7pG/3tUKQ==
Date: Fri, 9 Jan 2026 07:54:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Arnd Bergmann <arnd@arndb.de>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-apple: Add "apple,t8103-nvme-ans2" as compatible
Message-ID: <aWEWph1LT5Cd_HAV@kbusch-mbp>
References: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_065433_471420_C7974031 
X-CRM114-Status: GOOD (  10.12  )
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

On Wed, Dec 31, 2025 at 11:10:57AM +0100, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
> "apple,t8103-nvme-ans2" as fallback compatible as it is the SoC the
> driver and bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Thanks, applied.

