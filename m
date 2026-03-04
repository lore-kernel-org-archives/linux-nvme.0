Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3576EF8FE1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEqqklHexgITSbG0g3d7xNwIzPqfawaNzgS/0G1kBJ4=; b=Z/2sdDTyg49CvNRV40QlefTuyj
	URuODc2CH+4h/RULg1/vsy7CPt56E6UXvDhC1g0+C2S2320saAQVLfIr9BCEb5k5qjwH/SINuASsG
	GZQVAs5KsBUIkBoHjQLrlyP7LYHE5ylLupPdqQ7m8NgbK/vTks4353mJxC9XCliLe4qle51SBkwcI
	XEz77YaZWZARkZDxKGgQTMxLG+VHkyfGFC4o4yDttQvZ/zgf2nivjiiV87GL3d4j21sPAbjO9CATN
	XGxIkEUP02fORutqHFEsdPgBF971PWdgpe+HDLC7bA6tJBzg99avCHSelf+qvZPEDBJ6hYjI6Vo1j
	+6/Mh35A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxmCQ-0000000HF30-0Kh9;
	Wed, 04 Mar 2026 13:23:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxmCN-0000000HF2c-2eBM
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 13:23:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0227A68D0D; Wed,  4 Mar 2026 14:23:28 +0100 (CET)
Date: Wed, 4 Mar 2026 14:23:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 00/21] nvme-auth: use crypto library for HMAC and
 hashing
Message-ID: <20260304132327.GA15515@lst.de>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_052335_839874_F4D26A90 
X-CRM114-Status: UNSURE (   8.62  )
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

Thanks, this looks really great:

Acked-by: Christoph Hellwig <hch@lst.de>


