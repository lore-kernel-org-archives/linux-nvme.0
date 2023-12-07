Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAB2C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ay/zK+NuPG4ZRYPzyDdCycWg8Yh5s/F6BCq3upcEZ4U=; b=q0eqggLszS+zhpg5moZ3PPV4ln
	AeMLujfpJDbpx4pZv948hRhZG9Q5EX7iugRPQuS/2Uj5AWYt5nrrZsXB1NkHwa5jgTHVML8JFkLTx
	ZmBBjYh+LVu9WEgtBxEot9Lb9OmLfp/S1pgSeZkkNfhLOaska2zI+JkmcGuKIO4/5hAF1kxVAdvcz
	IOF5rLBogpg1wwYNAXjk0s0Judf/z6KM+Md+LgwwR+nKIJzkhIJnxAI9afwkZ3BGFpSVkmdheRQl4
	gB1uG1Hkr+Ah9NJMzkYMR2QgeHMDjmWfiRpn9tOmTxb6olsKHr26F3hRx1NMa2DH9rhGen6INrbXo
	KIZEpAQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBHHY-00DPQI-33;
	Thu, 07 Dec 2023 16:31:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBHHV-00DPPF-3C
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 16:31:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 61CB961E3C;
	Thu,  7 Dec 2023 16:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCB0C433C7;
	Thu,  7 Dec 2023 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701966679;
	bh=IrVhkRIlzQL6MWkn22aaJtQC7k1uTCUev4gRx7OjJno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cx2IFLhX+un9669VMBlyXxDLw8nn4RuA47dRz9UwBAkGQQmY4+2Q++xkvNajfKqnD
	 u1i/gkoY8wT5Lg4CKA1uVN36ykeV1MoRdU9XNmoMUZZyaiDww3f9ID3gHf8Lq0ihmF
	 DI/4ra2H6MlJVElYU9IkapNq0co45hVT5tBcJejp+4doCk99opvgge8ViW9PCspTX+
	 ZVw0IC5GhQ8C3dzsE1XIYWuDxito9RQzngCV8qBea0S0e/5RvQ+rwAmBMlDCDDAdxH
	 QggEAjradx/yx0g4nAiw1AEw528VYIrAd1cbFpxjeF7LJIcrqAKXaG6LWFDHIcRacH
	 OMCRcR0UdTNKg==
Date: Thu, 7 Dec 2023 09:31:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <ZXHzVN3jmIIsGyeq@kbusch-mbp>
References: <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123624.29959-2-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_083122_069360_9EC46468 
X-CRM114-Status: GOOD (  12.31  )
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

On Thu, Dec 07, 2023 at 01:36:21PM +0100, Daniel Wagner wrote:
> @@ -1906,7 +1908,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	 * or smaller than a sector size yet, so catch this early and don't
>  	 * allow block I/O.
>  	 */
> -	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
> +	if (ns->head->lba_shift > PAGE_SHIFT ||
> +	    ns->head->lba_shift < SECTOR_SHIFT) {
>  		capacity = 0;
>  		bs = (1 << 9);
>  	}

A minor conflict here: this series would target nvme-6.8, but the block
tree we're based on doesn't have this code. I'll patch it up for the
current 6.8 tree and make a note of the conflict for the next merge
window.

