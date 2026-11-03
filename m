Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BA606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vBvKM8uO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/na1ygk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=98Gn3SOXcBgcz2fGP/37f0Z9Rxhy4Kh56gat06c22LU=; b=vBvKM8uOFG+IEX
	6Ck99oQApgzd9zhu8WS39/TpDtvJjIkT7Rvj9zJLijA3fXbQscW/wPQHydfC18ZqB11jJEB6UQPLv
	Vkxjwg13wHEG4rjK0GhdvwzIFUPwyxsgBWtG8l3bSOlobXUDkrD7SO6CzS7l7yk+2kNF1Yqgla/Ua
	IUt4wmnlp7vZ3NEK+PRsz6+cvcF6fsqmOxLI7YXwJ3NIVxIkxwoN2fRJlxF1riyPO8JyDkzIuFQXL
	xTmiqFo94WwGPbP192++YPyiRFB+tCmYzovHgJPDJ6+3GybSx2nPQhpW5E9r7jZzccRiczQmVfSTe
	WwIiNOc0evyjzEO/vlaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO6p1-000000017JK-2Ehh;
	Tue, 03 Nov 2026 05:12:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO6oz-000000017J1-3R7q
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 05:12:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 42A5A415B5;
	Tue,  3 Nov 2026 05:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569451F000C1;
	Tue,  3 Nov 2026 05:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793682753;
	bh=98Gn3SOXcBgcz2fGP/37f0Z9Rxhy4Kh56gat06c22LU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l/na1ygkNoU3dryiSarBu8D1eMt5hrSheOr1R0kOFy2OXTqYXYRj0zA8MvEaXuaH7
	 C4NXye6IK8bKku3wX45Rmwb6WXRf/a9jT3mYEJHBSEz27ArCzR925MPLH2IliNTOv9
	 kUkBwtIyLCMT5lKLyZIJndgKbwI0Awkh3E85DtlZ3iCwrqlHMXI7uagRZU+g/cjDGS
	 wlZ42MMvVy4aiAt4Yc9x+KIBEbk2X33CC8DHOxj31gHhc/YAxySUm39SNuFOcp62uw
	 WkGBm5tURPyBAzzeTuWb+me3OVjXNzj1lpq/bg0YAk2o3EmF5cnWCjRct/f45us6ku
	 NvduJ2zUXMDBw==
Message-ID: <fe0036f2-4513-43c9-8821-0d4b094cd4eb@kernel.org>
Date: Tue, 3 Nov 2026 14:12:31 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix arbitration burst field mask
To: James Fantin-Hardesty <james.fantin-hardesty@seagate.com>,
 linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org
References: <20261030191853.1777683-1-james.fantin-hardesty@seagate.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261030191853.1777683-1-james.fantin-hardesty@seagate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/31/26 04:18, James Fantin-Hardesty wrote:
> The Arbitration Burst (AB) field of the Arbitration feature is
> CDW11 bits 2:0 (NVMe Base Specification 2.1, Feature 01h), but
> nvmet incorrectly masks it with 0x3. Use 0x7 for both set and get.
> 
> Fixes: a0ed77d4c9a7 ("nvmet: Implement arbitration feature support")
> Signed-off-by: James Fantin-Hardesty <james.fantin-hardesty@seagate.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

