Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086CDC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Dec 2021 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sed5bGIMCTL3LpI6X189AK7dXYzeAgUY3H56SGTGkAg=; b=G679E6EGAOLQJQA5P/VrERkL0b
	bZYI7yrRK5rVZX5OQJv0/9NAb0ZvfSzPEpJuz+R83ifIcFeIkuC7pM8Amg7nvZiMgiIYcxf8xBOzi
	dpaowCT1V3jegqVYXSlprk1qRvQyB3m1ogM3Ch9th2D4TGAFeofKUhgPp6G90J6LRxHF9/klU19yB
	l/h1HtzDS88ZE6SYB0zdaakjXeJmGTzmjkIoBGUTozuOa7LskSxvmKIdVqM+O44uP2nykTvJlNF/S
	ghPRnQ0Q+O3uvGMzjRfeWUlYC/iWWkD3j9G+vJLt2XBIb2ag/7xmQc2Z7+1roCIeygVBLq8MHPfBY
	XqXsQi+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1msoCY-00Co4U-Am; Thu, 02 Dec 2021 15:40:50 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mso9I-00CnAy-QC
 for linux-nvme@lists.infradead.org; Thu, 02 Dec 2021 15:37:30 +0000
Received: from xps-7390.lan (50-233-66-25-static.hfc.comcastbusiness.net
 [50.233.66.25])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4J4g7W0QqVz2jCv;
 Thu,  2 Dec 2021 10:37:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1638459447; bh=dbKm0N0V3+vmx7loDcn20Anbh9JDyOpiRkOKnYCaoPo=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=A7kKY5Je6s5F+dwDSFtlTMCWbUVWbq9JEsNVRFpg6ZFGq6fmQ1UUeLeXnMbRDBhsn
 BtdVL5OPgxJ0b3FT8zipfDsiS5pO5uhkVwXWUeevTkneiIemJaYBXpyzJ1kqRR0PI7
 /e7O8ej/mv7oXZUrp+gru9VOcZ3QJYW+ge2XFneY=
Date: Thu, 2 Dec 2021 07:37:26 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org, 
 shinichiro.kawasaki@wdc.com
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <4429eed8-b9b9-6943-f76-6ea38d695248@panix.com>
Message-ID: <a2eb227a-a4dc-e4e7-d3ea-567778bfc9c0@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <4429eed8-b9b9-6943-f76-6ea38d695248@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211202_073728_958473_2DAAC2CA 
X-CRM114-Status: UNSURE (   4.68  )
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
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On Thu, 2 Dec 2021, Kenneth R. Crudup wrote:

>   $ egrep -r . $(sudo find /sys/block/*/ -name inflight )
>
> ... but they were all zeros.

... and similarly:

----
$ sudo egrep -r . $(sudo find /sys/kernel/debug/block/ -name inflight)
/sys/kernel/debug/block/mmcblk0/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/mmcblk0/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/mmcblk0/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/sda/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/sda/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/sda/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/loop7/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/loop7/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/loop7/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/loop6/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/loop6/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/loop6/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/loop5/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/loop5/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/loop5/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/loop4/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/loop4/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/loop4/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/loop3/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/loop3/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/loop3/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/loop2/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/loop2/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/loop2/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/loop1/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/loop1/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/loop1/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/loop0/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/loop0/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/loop0/rqos/wbt/inflight:2: inflight 0
----

(... but just now, I got a delayed popup from my UI, which then went back to
being unresponsive again)

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

