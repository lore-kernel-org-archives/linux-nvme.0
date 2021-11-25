Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D43C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Nov 2021 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EJRrCwz7cn27w+55ufaAfco/0pylwDPRkMyQmLpx0pM=; b=TqD1stJFXo18EVu551kMnMP+2/
	817ujNfsShCG+s45Ff4RP/uUWEJV1NHU3Vn5MLXL/hulc3DOnfuO+w1E0WX+r+aWYYiSkPykhzT3r
	XK++bFjnfs3tcoooLmIBFC6CzgtipNUce/adc4Ma4fvrNRGvnQrGpO/i2bqbnpHJ2BpscD0VTtZ6j
	KIdjOaNRjBgmKy5STVLVhJpp6ry2CFGErOhP9lJ7G4R4/ffvm0jifY8wrVRLg8KLRKfQtgZSF4FY7
	Xx5i14N2wfD97d4MA+8A7p4eVSe0fsI7Y4p7imHvM0t2PaBJCZca99K1j4GqRhPflNRsFlA0t3Pv0
	CioO6anw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqLvt-008dus-44; Thu, 25 Nov 2021 21:05:29 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqLvm-008du8-RA
 for linux-nvme@lists.infradead.org; Thu, 25 Nov 2021 21:05:24 +0000
Received: from [192.168.126.80] (ip98-184-250-31.oc.oc.cox.net [98.184.250.31])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4J0Vl1638fz2sJY;
 Thu, 25 Nov 2021 16:05:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1637874318; bh=/phpLN81VHGxqAiAfyH0Geo3FSMKK9AauWc37cUnhQE=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=eGCNwMmEWIkD/rVJtOna7ZeyO9BUB8nxnWHdUeU1wb8TDU9rJphJ2/XTvCX+Xo76w
 BYhE2efhCHKaIpq7XwKimblUSrkrVGVxnfzyUGPAeJZsbwHXZetcZWVFWYNWILFK7p
 ub0IKxBXH+WxWHmc8eBrEbYQKVHigme0nXEvLnNw=
Date: Thu, 25 Nov 2021 13:05:16 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org, 
 "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
Message-ID: <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211125_130523_063636_16020AA7 
X-CRM114-Status: UNSURE (   6.59  )
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


On Tue, 23 Nov 2021, Jens Axboe wrote:

> It looks like some missed accounting. You can just disable wbt for now, would
> be a useful data point to see if that fixes it. Just do:

> echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec

> and that will disable writeback throttling on that device.

It's been about 48 hours and haven't seen the issue since doing this.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

