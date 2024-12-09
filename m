Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A2CE7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N7UlONbAlkAeoKonw6FJchFmKhI6bEOh39fA8QXlrJ4=; b=a3U35wxiPsI41qcC9K/jdPpxBt
	zjTsvSQwgv+9mO4sPmV9aVRWTGf8x77Wq6kwnRgPf5v9J9By6ts5xUNCIIw0n+EcXtT6Wlq5FHH5f
	nts8Pe+o9gah/dTO/fgieBa6uai5dyPXBEE3fUndQH5Ax7fa7t1tMXJ55JgbZMW+nC4P5OuPnn0U+
	xGAl0S1IQE3VqUT3VVwA57rYw99rqcfCANrHWw0YPJrGnglpksu2NTUTR/BJWABM7kLlwN/NdIYZk
	0Yt3vP/fvniXFmsAP+M9dIQMvWJGBlaQ1Zb4M86ijhIi/RNXNwQYcPLMio5zZPDtdjm5KU0HlII6Y
	VMfq6ZJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKgIz-00000008Usd-0gd3;
	Mon, 09 Dec 2024 16:08:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKgIN-00000008UnB-1k3N
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 16:07:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 316555C5DA9;
	Mon,  9 Dec 2024 16:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DDEC4CEDE;
	Mon,  9 Dec 2024 16:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733760458;
	bh=OnU+8GBt5pKp2SZ7nwC0/d71cQLLpJdR1aRrsY3v1GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6gHRaGTrCmeg3ha+s2ZhK6C2A8Z8dvwEMmkvjx/LHbPlbhWuo7FQtV1RoJR8Ttdv
	 3hWMOOdVMDoe5cBnpC/S0ZqtVTZrlV5+AnDyO9Tn/WCBQ0EOGyos5ENuZ5K0rk6gJ2
	 6HzSnE5hSyLhZVCiHqBuJ+aExCMULICr8WtwDwkGsg77EtIY5RzwrOa1+5GUo7L0zp
	 2MEht1epHewFktReXkDKyPKO/3lQNcZV/t0B4ZjhiJcpL8Jmbri0Gke6P8g78A6Th5
	 kqM2BQ7mqI0B5OX6yKKFrcW2z6wEsACS/rQqml8GsYg2X8tS2gB9EROPKUnjaAbv6n
	 E9YvQSCAwngMg==
Date: Mon, 9 Dec 2024 09:07:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
	joshi.k@samsung.com
Subject: Re: [PATCHv12 00/12] block write streams with nvme fdp
Message-ID: <Z1cVx-EmaTgdFgVN@kbusch-mbp.dhcp.thefacebook.com>
References: <20241206221801.790690-1-kbusch@meta.com>
 <20241209125511.GB14316@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209125511.GB14316@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_080739_493558_EA3F801E 
X-CRM114-Status: GOOD (  16.67  )
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

On Mon, Dec 09, 2024 at 01:55:11PM +0100, Christoph Hellwig wrote:
> I just compared this to a crude rebase of what I last sent out, and
> AFAICS the differences are:
> 
>  1) basically all new io_uring handling due to the integrity stuff that
>    went in
>  2) fixes for the NVMe FDP log page parsing
>  3) drop the support for the remapping of per-partition streams

Yep, pretty much. I will revisit the partition mapping. I just haven't
heard any use cases for divvying the streams up this way, so it's not
clear to me what the interface needs to provide.

> One thing that came I was pondering for a new version is if statx
> really is the right vehicle for this as it is a very common fast-path
> information.  If we had a separate streaminfo ioctl or fcntl it might
> be easier to leave a bit spare space for extensibility.  I can try to
> prototype that or we can leave it as-is because everyone is tired of
> the series.

Oh sure. I can live without the statx parts from this series if you
prefer we take additional time to consider other approaches. We have the
sysfs block attributes reporting the same information, and that is okay
for now.

