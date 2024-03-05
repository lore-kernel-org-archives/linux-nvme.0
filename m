Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5B2C54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zbyBuPH7rwWudDBW1Y2OSxPts/ZpPphHYIN9AJqs06w=; b=fMu1Oa6xubEZdSnBWEdP68SCKe
	X3s3yL+pN6lBFHXq5NvClnISpiALAdkUgiwjyScOmeE3YIqIjQKB4F6QlSZBHpj2TPqdTLgqcvCaU
	ex6lvWQ/Sk8B7/tu0Wv29uHIbEgXxvFSTLLQU/ba9RJ60XX72tcM2uC0qOv49YmJkqzVLHgaztQ7M
	Z7RDp7ryI/q0A7JGiMk6Ve9xFuwqdlNNg1ez1GbGRD7r4h56OHMz8mOrQ93ghAIt6/LLYa6cqdozK
	8jZH+A/ntTTCzuse0mNRwpUxdXvh0j2ITTeZZvMs7LcITC6UPi4kBRly6F/Ug4F10muwGb7cTJ8hf
	6cPuqNsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVCG-0000000DtnS-1j3h;
	Tue, 05 Mar 2024 13:51:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVCC-0000000Dtme-3Tay
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 13:51:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4748368C7B; Tue,  5 Mar 2024 14:51:00 +0100 (CET)
Date: Tue, 5 Mar 2024 14:51:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Kropaczek <michael.kropaczek@solidigm.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 0/1] nvme: Fix problem when booting from NVMe drive
 was leading to a hang.
Message-ID: <20240305135100.GC2063@lst.de>
References: <20240304182507.2601387-1-michael.kropaczek@solidigm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304182507.2601387-1-michael.kropaczek@solidigm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_055105_351263_36F9D942 
X-CRM114-Status: GOOD (  17.88  )
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

On Mon, Mar 04, 2024 at 10:25:07AM -0800, Michael Kropaczek wrote:
> Description:
> 
> During endurance test, when a system was rebooted from NVMe drive, boot
> process hung occasionally. The number of reboot cycles was set to 1000,
> with interval of 120s. Hang occurred after ~300 reboot cycles.
> After investigating the cause, it was established that NVMe driver
> did not disable host memory during shutdown leaving NVMe controller
> in a state preventing proper initialization in BIOS pre-boot stage.
> Adding of the call to nvme_set_host_mem(dev, 0) when in shutdown
> fixed the issue.

Something odd is going on with your patch submissions, as you seem
to send a single mail with a cover letter and the actual patch.

That's why I missed the last one as I've been waiting for the actual
patch mail which never arrived.

> +	/*
> +	 * On certain host architectures/HW, DRAM was keeping memory contents over reboot-cycles.
> +	 * It was observed that certain controllers were accessing host memory after
> +	 * resetting which led to undefined state preventing proper initialization.
> +	 */

Block comments should never span 80 characters.  But more importantly
I don't even think we need this comment at all, this is a clear bug
fix and the code is self-describing.


