Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707A9CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 06:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9m3BVBhYEKhVovKzfwJt+gwF8WGTFRkR3IYQVKTD2Q8=; b=FzqvYNzLbDK2qr/JnoQZX1nmF/
	7KoIxUoC48CrvARW7JFt87VsvwNTXvRnZyEi0GcMkzoj9lv5LDzdrDROrWq3zerd/RxXNaBLf15iZ
	QMVuZ2HFynPdZABl0OqVa0g43xuNxEy2/1xoPXtxpZP3dVSvRzmPtGPLlq0qI/Ie59MucycoOWBXP
	zBjwMZHK38hZD2M8CfdNsirOPmWO68Ftod7fgkaQX8iuHZJVQMoOgXrffqwL5/sHLvMrAxGj4EqLj
	ACXTFBk1hMSw2jRYVYmwku30jGKamz4l2pQVifmfQP3iA7qBANpvtHySGDtiB0/rJgrXfSpqiiImT
	ONGAqS6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4mr-00000008Eru-1g22;
	Wed, 12 Nov 2025 06:57:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4mo-00000008ErH-159v
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 06:57:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F0FC227A88; Wed, 12 Nov 2025 07:56:53 +0100 (CET)
Date: Wed, 12 Nov 2025 07:56:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 4/4] nvme: Allow reauth from sysfs
Message-ID: <20251112065653.GE4873@lst.de>
References: <20251111234519.3467440-1-alistair.francis@wdc.com> <20251111234519.3467440-5-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111234519.3467440-5-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_225659_628780_6E83E646 
X-CRM114-Status: GOOD (  12.39  )
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

On Wed, Nov 12, 2025 at 09:45:18AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing to the sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key

This now takes absolutely any write, right?  I think we should at least
be strict to force some value, and document it.

Which reminds me that Documentation/ABI/testing/sysfs-* is missing a
lot of nvme attributes it seems :(


