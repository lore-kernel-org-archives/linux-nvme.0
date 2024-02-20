Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4B3C54764
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fxpNT4AuJ4PiXexOMh7ayv0NSQzPgYIaWheuh7geFzs=; b=SADhpaQOY6w8uyJKI/hHkwlVXd
	Rl1Q0SGZHCpYtZRTAQ6rgfBXFP/2XOthJgltPf1Jy2rY7PaUedU5Ib8NFESuWyaFnLf8LzUZFYV80
	15I48zZ0utbc1CH4x17E8VYMWIOz4iS41N7IcLsUIWKIcVcvulo++cVYrJHS/hc7Ne26lHqM2R6Ck
	4I5iABEN3KSC1xr9mgpWgpixD3EPVDK8qZz1dZWLET0RX9ynkBT/xKk0cYGBsXHImIwprYlOVknb4
	GBwbL2brJFIEisxx+PvOLM0hR47UFwj9hX5V/43DCw6e9KlBLBIEu8l3LhkdqJ6ynoSoLkvsv+6ww
	+ys/7MVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLXF-0000000DiyZ-1WIg;
	Tue, 20 Feb 2024 08:31:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLXD-0000000Diwd-08l9
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 08:31:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0CFB68D05; Tue, 20 Feb 2024 09:31:20 +0100 (CET)
Date: Tue, 20 Feb 2024 09:31:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v4 10/11] nvme: Atomic write support
Message-ID: <20240220083119.GD13785@lst.de>
References: <20240219130109.341523-1-john.g.garry@oracle.com> <20240219130109.341523-11-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-11-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_003127_233066_CF7BAA8B 
X-CRM114-Status: GOOD (  11.35  )
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

Thanks for writing a good commit message!

> NVMe namespaces may define an atomic boundary, whereby no atomic guarantees
> are provided for a write which straddles this per-lba space boundary. The
> block layer merging policy is such that no merges may occur in which the
> resultant request would straddle such a boundary.
> 
> Unlike SCSI, NVMe specifies no granularity or alignment rules.

Well, the boundary really is sort of a granularity and alignment,
isn't it?

