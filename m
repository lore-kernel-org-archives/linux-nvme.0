Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A6606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fWbC5kgK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zAexHz8E5bpDPAsaNW7aRPuUlLOJ5C/B47iIBOhDko0=; b=fWbC5kgKJdBRbFCNKf5kNPfms1
	zGQK1VjcuJ1f7JgjUbTBIopRnwExIxEwuEDPsbOh2RAB5YzXljmk+sLLrzLPnXMsG/iGLY9lGiRFp
	nNWO5DP5DNHraZwif2gZqpnif9o35xnGw4vHkkJILGKfnbodkwNluYVqfusarkjswHCg8UKHINr8Q
	IUN3ZaqfIvUzrfmavFHZa8l76FLLymX8AQVCLR6UF0/9Xk8TG2eWp75awCfkdbPXP34FZiUBrSQyc
	U6DyzuOobcHj9htW+XioTTVrPn7/gXBRWOpmJnzpnQoYxS5TN21UHNgxhnrE/8kcakTHlYb7Rwdrk
	kuiaVGyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5FJ-00000007InE-22WG;
	Wed, 28 Oct 2026 15:07:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5FG-00000007Imn-0JjP
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:07:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 718E768AFE; Wed, 28 Oct 2026 16:07:12 +0100 (CET)
Date: Wed, 28 Oct 2026 16:07:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Fengnan <changfengnan@bytedance.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, linux-pci@vger.kernel.org, tglx@kernel.org,
	namjain@linux.microsoft.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
Message-ID: <20261028150712.GA16374@lst.de>
References: <20261013223543.395054-1-kbusch@meta.com> <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_080718_269629_5C8B644D 
X-CRM114-Status: GOOD (  14.33  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 05:43:54PM +0800, Fengnan wrote:
> Hi Keith:
> 
> I made some modifications to DIM and then implemented a solution
> using the DIM framework. 
> Based on current testing, the results are now comparable to those of
> the previous patch.
> Here are the preliminary test results:
> https://docs.google.com/spreadsheets/d/1e8LQPnaDhmv50XlAM3XxI0TMQkhbk0bTZwlJP1Hzzdk/edit?gid=188992110#gid=188992110
> 
> If you agree with this approach, I’ll continue testing and optimizing.

І can't speak for Keith, but I'd really love to see this going forward!


