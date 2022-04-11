Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F80DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 05:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8M5G33sE2M65hmq2Lkh/suUl2tDkBjUyyL9cwTqQXbw=; b=LyA1yej5m+AGkwYWhbEXoQaKW1
	RkYcszO0EcoyPdgxegs7+105szRD3Yh7u0VNfbWQBBhoGeqdtnBQXiveqy1eFzYliaCUq1bvSFPtr
	6IyJtCmcc45d6Pc3vJoRP2F6gueNFbt6zL4GAiSb+QesiKGII9sycZKBVL1dVxg2gorFm0MDra6XT
	7Ixnh61MDI6QlruQ13m/1sid9pXk4jPIxHUjTWXeL6oPSeCiwtZdL8XP8AsbxqNQCSgR0cXpSq9VO
	C0tjwjRfLfyaoXN3uKz02SyobjmKN+HriptYPoTbB8q044RaqnvyFg8YXJfccBXN48ce3F8Y7yPJy
	rOvXzqcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndmFG-006hSK-Ic; Mon, 11 Apr 2022 05:05:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndmFB-006hR5-Ch
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 05:05:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A158868AFE; Mon, 11 Apr 2022 07:05:33 +0200 (CEST)
Date: Mon, 11 Apr 2022 07:05:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220411050533.GB13927@lst.de>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_220541_617997_4C24C5AD 
X-CRM114-Status: GOOD (  15.88  )
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

On Fri, Apr 08, 2022 at 10:46:59AM -0700, Luis Chamberlain wrote:
> The above note from Klaus seems to indicate this is not yet fixed on
> qemu for eu64. Please correct me if I'm wring Klaus.
> 
> However, what I'm seeing seems to show that the uuid is same uuid as
> well when not using -device nvme-ns but just -device nvme (this is
> called legacy now it seems?) without the uuid set you end up in the
> situation I described. I just destroyed my guests and started from
> scratch a set up using qemu-system-x86_64 v6.2.0 on debian-testing,
> and end up in a different situation but it is still a bit perplexing.

With my usual qemu test setup (built from a git a few weeks ago), no
uuid shows up unless explicitly set.

