Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE474EE20B3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iSo1qgeSHP1BJjd7ErD4V+/DslkaBdZHxJuaDbmgFaQ=; b=nwaNKmO9moHT4gW5clAIyOJrF1
	beBtE4o/PmUZLRwfKmAPq3DyelRMDujZ1TeU8RwLT/V9MVAOblhxC/k4VP/mpuf54Dox3RDsxPZlZ
	1I2zPSMs1b4vN5aHKZER+WE5nQbSJIov/VqY0XkPQlPlfZAHD4DRnkkyoXIfEkRqkJ7cJtByKsIC8
	qfiCMyrbgem5af4VCbE6vrJZq5O2bgO3eAxfVcORhywkCtNryWJnxJSmH94XwCCfuTpzP8Pej3e8l
	05wVp/klaAOIoV31IXfGRgoXP0lhoSwIw8uJLdzTt7tAlw5WogRgZbl7sYpm7VspPgTBhk2gBt97T
	HH5py/Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voOFF-0000000BWq1-0kiw;
	Fri, 06 Feb 2026 15:59:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voOFE-0000000BWpv-2ldO
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 15:59:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 943F860010;
	Fri,  6 Feb 2026 15:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FCCC116C6;
	Fri,  6 Feb 2026 15:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770393583;
	bh=iSo1qgeSHP1BJjd7ErD4V+/DslkaBdZHxJuaDbmgFaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ir2gA2nHdC0rOk8Odbxc2TsL4W5sg87n2logK3HYKUq1cCUxQOX5DrFJ7N0qSWVcP
	 849MBN7EpFgl35CsETFQY+oz+SZ/as1qQxZHm92qhftCuNiS9pGi8sxBnzTsiIzu0v
	 pKgJhuaQ/grVbvDb9QyZj8mzCo9HYOCcTZ8+UfyeoPs7HK61apa/vclZaMITbp5hjy
	 GqgBIr703Bh4GBY9SJ0CC8QStxlrh4xvBzJio4Ijc6WjwdasWVEu2fjI/yUNwuGEXZ
	 IciVMQ5HpOJo2e8IoOGHlkYZBcdzfYTjHSgPplYU1QAdWXCqxctsw55DavpIrSEW+R
	 xnh0Rv4N+M+FA==
Date: Fri, 6 Feb 2026 08:59:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvme: a couple of small fixes
Message-ID: <aYYP7RDAprW35cb8@kbusch-mbp>
References: <20260205171115.2610321-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205171115.2610321-1-john.g.garry@oracle.com>
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

On Thu, Feb 05, 2026 at 05:11:13PM +0000, John Garry wrote:
> This is just a couple of small fixes, based on nvme 7.0 queue.

Thanks, applied to nvme-7.0.

