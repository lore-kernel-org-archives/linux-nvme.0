Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17904C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 08:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=rFv7G16haSw9YJVEjp8i7iL4Tw
	p/YOs5GDdbJgomof/YQ3lmnPHmxK7JdPqu2Lhg83JTO6zNMXgyt9CWGitcEGB+4oMk1t9378bFs79
	gBrkESiG6rbAP/MlafbiKecX/uSuC2XuiUn6wqa475gReJow5QElOQWPh973vzV4rrqF+4K9R2iR8
	Gi6hQ9OVbc4maHwlcEzGXMUlA+iJvPBwQsAECRXjLuySc+iWSTSCPVpImfe5EsXM2rqf4oXECgq9j
	rcJa8hKBZW7r9NcRZAxmu/vBCgozlRj7CrUoZ2be+ko7kKoDD4QmR7xNkywB/a3Gfpzp9Gp1KAcjI
	fwMMPQjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u798b-00000006M5f-1liJ;
	Tue, 22 Apr 2025 08:37:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78TZ-00000006C5p-031B
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:55:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A2CD68AA6; Tue, 22 Apr 2025 09:55:25 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:55:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
Message-ID: <20250422075525.GA32418@lst.de>
References: <20250226062841.60688-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226062841.60688-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_005529_188886_A5145155 
X-CRM114-Status: UNSURE (   8.50  )
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

Thanks,

applied to nvme-6.16.

