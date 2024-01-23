Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593C0C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QX26UI1roOL1u8sKN5rUnu4it6knOiPmTE7CsH/IjVw=; b=gYi3FGF3nz2W0dfmFO/yuv+s/i
	T8WQA33raDD0JEg09o6SRL2F0cqkrEHOCPlv1HtSltHXa0GgqVVNthtlrzOwRNQTvXlsVS+4jHZBF
	y9uXJ0pSTLDavEvH/lf7pKppBf5Muw6YVzkAMFtlA8+rm+7m8WwYCnV7F4vaXMs+hgbptkSi3kVKD
	U9jvaAoV6IHw1CbKNRSLDsUrfXnss20SQGE+QAxNM/xHr/BEs2x1YmZ6gUiFcndjrp09QIq//pH6I
	aRufo727/Thsa+xfzq3jzW+cYxfzn3ZW/kru/NZlszYdprOVs73JxXz2lCn8WjYV5d1TFKFwtucfa
	HhMZekOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCg0-00FgNw-2w;
	Tue, 23 Jan 2024 09:02:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCfy-00FgNG-2Q
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:02:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EEE668BEB; Tue, 23 Jan 2024 10:02:32 +0100 (CET)
Date: Tue, 23 Jan 2024 10:02:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com,
	dwagner@suse.de, oevron@nvidia.com
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Message-ID: <20240123090231.GD30773@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-6-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122145659.5574-6-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_010234_930545_037A0458 
X-CRM114-Status: UNSURE (   9.84  )
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

On Mon, Jan 22, 2024 at 04:56:56PM +0200, Max Gurtovoy wrote:
> From: Ori Evron <oevron@nvidia.com>
> 
> The namespace identifiers may change during the re-connection flow.

How?


