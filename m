Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ECEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5rlK2RuHANQ8a6sFoV6dkBfG6ifJeiKVL5b0lfCEAJo=; b=afGyUzzL2Yi7XxlQPClvbn4MPJ
	7wBhhFmjqbt0kvN6YrpXJMHESHEzfrn2r51Bk6sUShwRTEW7R1HGHN4wZec3ysYMyEkHz9rtPoCcA
	lw/X50D55hiZzazApYTM/8sb4TGKkki5dWTJyYM5P/AAlRggY6yJEduroF9Rx6hvuaZGKiH5vnzjh
	hyR+4e28vLjG25WAdQMqUkMlF3Zk75UdTnJPD6VvyFZR1aLrXRMvxi/+py/XHUE8fLE6MBWFNGAn9
	AUYkjR3S26hJazG+/GcpPU1fz/KjI7pIuPrfcroPVyM2WAiMdYWsx7fT4b0wvujBNNekK/mrmiEKt
	ruH6mbng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrEnI-000SDc-Gx; Wed, 18 May 2022 08:12:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrEbe-000KKZ-3i
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 08:00:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C8B2D68C7B; Wed, 18 May 2022 10:00:22 +0200 (CEST)
Date: Wed, 18 May 2022 10:00:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 pankydev8@gmail.com, dsterba@suse.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220518080020.GA3697@lst.de>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de>
 <20220517091834.dvkrab5l63v3b2zn@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517091834.dvkrab5l63v3b2zn@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_010030_383470_50980823 
X-CRM114-Status: GOOD (  10.32  )
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

On Tue, May 17, 2022 at 11:18:34AM +0200, Javier González wrote:
> Does the above help you reconsidering your interest in supporting this
> in NVMe?

Very little.  It just seems like a really bad idea.

