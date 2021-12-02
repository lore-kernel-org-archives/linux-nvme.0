Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD07DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Dec 2021 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOUM2c8oIE9WqQF/Nyc4uF4G/OlouLbYQyoBkYPVrq4=; b=dAmTgdHengS4eydDVdTmJKZWK7
	APQatgQ4QpKazL3YJTIksRcfTJbvORzn2owOSppVRxUiYb72cBIqWIxOvaulLkDYiB5kuPHE28ymy
	3MXK5nG1O4m16dRTUCq5/+llka6BGxZEKsr6Cv2q1EzDwrE7ljyk/aAN5HEeMChbw0nXMVUfWjJH0
	+7/6eO+G/8TiSuKzHTuvfNmk6lYrM15RJ0xEtAZTVgpvj2U8Oxy1kQENed/Sxi6ey0QXbhA+yqRNG
	7pZSjkrT1OKNfmXGhef1aF/z5w5yHmt2bJUYlE5tIEsB316RLA0/8fd9mykI2KJ/zS7ELzYmHLDtz
	bqOrI/Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1msnlw-00CiMi-F1; Thu, 02 Dec 2021 15:13:20 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msnlt-00CiLQ-LO
 for linux-nvme@lists.infradead.org; Thu, 02 Dec 2021 15:13:19 +0000
Received: from xps-7390.lan (50-233-66-25-static.hfc.comcastbusiness.net
 [50.233.66.25])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4J4fbX4wgSzRyK;
 Thu,  2 Dec 2021 10:13:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1638457993; bh=toNejAxkj+yP8ltzlp9a3STqZnD7jU0oVwaijQEJlZU=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=iQWI9zs4cbEE27OPkZUNGunlqbBji7LPHblAro+/jkZcNX24HasiX5UC30tsS+Ese
 pPZ502MW72NrVzRpV70RpLot5KWFaFQS5/mSzJ3Rv12dJPF/NtSLrrtAyySPvjJTJU
 HL0nQA00QggMvQiD4jwuQqwy6YAByTPWSR92+T7c=
Date: Thu, 2 Dec 2021 07:13:11 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org, 
 "Kenneth R. Crudup" <kenny@panix.com>, shinichiro.kawasaki@wdc.com
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
Message-ID: <4429eed8-b9b9-6943-f76-6ea38d695248@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211202_071317_813552_5D234810 
X-CRM114-Status: GOOD (  13.75  )
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


On Thu, 25 Nov 2021, Kenneth R. Crudup wrote:

> > echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec
> > and that will disable writeback throttling on that device.

> It's been about 48 hours and haven't seen the issue since doing this.

I'm now back to running Linus' master (which includes your fix for this, and
I'm not disabling WBT any longer).

We may still have issues, it appears. Everything was going OK until yesterday,
when I had an SD-Card with an image of an SSD with a dm volume group on it,
that I'd had mounted as a loopback image and activated (... was that clear)?

While I'm not seeing any kernel messages related to my NVMe (root) device, I'm
also seeing the same UI issues as before- the KDE toolbar is unresponsive, and
I don't have full interaction with my desktop UI (i.e., can't click on the
bottom button bar to switch to the active window). I'm pretty sure this is a
symptom of another I/O problem, however.

I tried to unfreeze it by:

  $ echo 0 | sudo tee -a /sys/block/mmcblk0/queue/wbt_lat_usec /sys/block/loop?/queue/wbt_lat_usec

... and a couple of seconds after that, it looked as if some queued-up toolbar
actions spit out (but was then unresponsive), so I'd tried this to see if it
would tell me if I had any throttled/stalled IOs:

  $ egrep -r . $(sudo find /sys/block/*/ -name inflight )

... but they were all zeros.

Does this make sense? Your patch seemed to be block-device-agnostic, but is there
a chance there's a similar path in the "dm" that also needs to be fixed?

Thanks,

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

