Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4FDCCA470
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 07:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DJTWqwKnUJ3kxbw2OuBlBaMvNBubFwOYTm+goJAzlEw=; b=40NqH7eCKDoghoj+gdjhL+qL1P
	IUOU4shr4D4p1ESZwHcsJD+pZmu9Xlv+O3SCkOgcWmMX6WGjMQKhMtW3YIxxxnqTjItBjD27AoyK5
	hPU0sYZeC/dTMa+FetS7kQ9yvIt+tcwf9HVF+O77u9RU52NctAKD9UsNCQJUyMjnRR9A2xuOh6K7F
	ngvPU2Xg8rXickqGOX6LeXYDQHOJLaqUGBl0NAvt4B3JejA51O6QzmS5Zw38Ixmypu2JENWiSRPxT
	EZBh/VeXsviEusqgAJu0CHELjFpIkVSsUQNMNbCKrzg/56HiItnOPY8e5KtZ0NZRjHmgOic14neAC
	3yf8CQ0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aKj-0000000BpLE-2PFv;
	Fri, 03 Oct 2025 07:36:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aKg-0000000BpKJ-2RCC
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 07:36:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC94F227AAC; Fri,  3 Oct 2025 09:35:57 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:35:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] nvme-auth: move declaration of
 nvme_auth_extract_key()
Message-ID: <20251003073557.GC12862@lst.de>
References: <20251001142200.61696-1-hare@kernel.org> <20251001142200.61696-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001142200.61696-4-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_003602_766799_6470C749 
X-CRM114-Status: GOOD (  11.75  )
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

On Wed, Oct 01, 2025 at 04:22:00PM +0200, Hannes Reinecke wrote:
>  void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl);
> +struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
> +				  size_t secret_len, bool *generated);

Please use one-tab indent for declarations.

> +static inline struct key *nvme_auth_extract_key(struct key *keyring,
> +						const u8 *secret,
> +						size_t secret_len,
> +						bool *generated)
> +{

And two-tab for definitions.


