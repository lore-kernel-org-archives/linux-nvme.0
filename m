Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4237CA0EF5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8gRCDZLPphZFM4k+3+pD0d1vjDzp4B5L1eSffpGNlt4=; b=C9pe864OjM1IUNFbaWkfukQbxL
	0cdn6JHdO6Zp96qooaJLPuHFExUuMUf2LaG/Px1eI3cq1He9yPef/tsCnBoRWGZhXfaTzTOb3Gocr
	pmHoy9VPEefMjbFt1ZAq2olRumi+QsT+Pmq0DarBXgA43voarL7dR/RZ6uZRgv5H7FZFWZQfg19Dg
	IkeQ2jyeiNhCusOg7gvDHjmymyHqcmsw68icb0VT5ambVg2OgsbXvdr5DvKVVymR0ABYq9BeSt4oT
	md10A+H1gU+cBtdSMY/9efoZpv4IFxp0LEIV9ENU/bVgVCt49OpvsbMaVkDVasoAl6YTt6MUHjDKm
	muXhH+kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIOx-00000009uRr-41Zf;
	Tue, 19 Aug 2025 09:13:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoHk7-00000009oUO-3Coh;
	Tue, 19 Aug 2025 08:30:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7DA59227A88; Tue, 19 Aug 2025 10:30:39 +0200 (CEST)
Date: Tue, 19 Aug 2025 10:30:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250819083038.GA1901@lst.de>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com> <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_013055_960973_CD19EE9F 
X-CRM114-Status: GOOD (  15.22  )
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

On Mon, Aug 18, 2025 at 04:43:00PM +0800, Nick Chan wrote:
>  };
>  
> +struct apple_nvme_hw {
> +	bool has_lsq_nvmmu;
> +	u32 max_queue_depth;
> +	void (*submit_cmd)(struct apple_nvme_queue *q, struct nvme_command *cmd);

Please stick to 80 character lines for the NVMe code.

Also I don't think an indirect call here is a good idea.  This is right
in the command submission fast path.  A simple branch will be a lot
faster.

> +
> +	if (q->is_adminq)
> +		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
> +	else
> +		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));

This could use a helper and / or comment to make the calculation
more obvious.

> +	anv->hw = (const struct apple_nvme_hw *)of_device_get_match_data(&pdev->dev);

Do we even need this cast?

