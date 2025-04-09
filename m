Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1777DC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=APb4kbTYmWNwwMpn3aJyqwVPVHnbqtlfF4Eo1Azdgrs=; b=pRv7+Zl7bgnkWQtONs9DXoP505
	/BLlYwgRuS2KTNYL8X/Ut8QDLHKPI0p1AEXGl0naCUfFPQGF4sHLhOiS6w1oVPYU71iunF7ERJE6l
	445HEZVcWLlKKSqIcRCSgHv2ym81gJDibtp/dDX7482BVIHXhJqHWEEX9JDgzZCQdfXoZbkfEqMkw
	No95yQoPyjMIe8WVXMPpZysD9L95POcs7aV/3DBeYlH4We4lL+y2MRlUdWmTUxii1CfwIwjY4ygX5
	0TfPl5GzzWhgwWNJJnnEXOg9CnP2OU9iylbqm1IKgXbZDcZUI5U0u4lLcYH88wNof420MOcIzbBYK
	jNVwPc/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2R3c-00000006ctm-2zet;
	Wed, 09 Apr 2025 08:45:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2R3a-00000006csZ-1RXN
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 08:45:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EA5F68AA6; Wed,  9 Apr 2025 10:45:10 +0200 (CEST)
Date: Wed, 9 Apr 2025 10:45:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
Message-ID: <20250409084509.GB2771@lst.de>
References: <20250226062841.60688-1-ebiggers@kernel.org> <20250409040415.GB4424@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409040415.GB4424@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_014514_522433_D9323A12 
X-CRM114-Status: UNSURE (   8.58  )
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

I'll pick it up once the 6.16 branch opens.


