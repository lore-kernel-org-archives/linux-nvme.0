Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A53CC52D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iejlqWWt7TY6/YgEI0LNlL2zO8IVcxw6GuN6PpQ3fB8=; b=AOaertIO7CZozojHwYxIU3Ldoc
	0PlkfU+xKV5LS78eIcO5m+VWrXG8a0JBhVH49BuTnqn0xq088tFVOpVdveDdtfq0ASi3qKR/8rJAn
	0OJWih+6NwmIoHYiKRnVry//FM5LEd6/5FjeuHtBchV/uCU6ycSyEci6Q4a25zYyx8FIdueCPuTs+
	ZA/Pg01dN5LvU7UP+ins5yDNsEQvEdBXIJhAxkb2CgGbBqSF3W7xPw0+KOefLA4J7FtgqjwM8rnxT
	qE3j2Bn37vvTafsflwCOJuBGuloV53KAcy0fHFZiyxjMoP14kLm9q7WNtlN6Bps5+cefwNo0fZohr
	qopP2A3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxkb-00000004pPv-0ozg;
	Tue, 13 Aug 2024 20:04:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxkX-00000004pP8-36uC;
	Tue, 13 Aug 2024 20:04:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4389F61876;
	Tue, 13 Aug 2024 20:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEC0C32782;
	Tue, 13 Aug 2024 20:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723579449;
	bh=UFOl4J9OOLeA/avOTNcqCYZZ/CpgemOJRd4RI2dE8NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGcqusiRlC9deLr9QYPYiRhUvn4t2H3EU5OEktIDyF1qvFlcxrdD4vg+aoYIu76S/
	 WoBa1P6pMfqFoGhFbli9mxU63c/X2+p36akcstBb6nxeWI7r7sLDS+LzNV8FTQ24Z3
	 /6Yfge4f6Qd16eDjFHKPgzicqpetK8dh07WG4iAts8JSjiFtlZfWdI3eb420063oJJ
	 ZLjwylNw7SGP0cLllOjHDGGgEipimoFI/CYIYl1zkMfgsXeA8Pvf/iPLw1YG8FJ6m4
	 EAy6xNsGPcOVRfPaJPy58zCzt5RcBd9CeBc0HFYUGoligaYaP2NWAXcX/kvbSIdbak
	 +vzKfGqjh/+bA==
Date: Tue, 13 Aug 2024 14:04:07 -0600
From: Rob Herring <robh@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 2/7] nvme: assign of_node to nvme device
Message-ID: <20240813200407.GA1634759-robh@kernel.org>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-3-ansuelsmth@gmail.com>
 <20240812111205.GC14300@lst.de>
 <66b9fbb4.df0a0220.3bee6e.1e99@mx.google.com>
 <20240812133128.GA24058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812133128.GA24058@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_130409_894746_1EBF8E11 
X-CRM114-Status: GOOD (  30.44  )
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

On Mon, Aug 12, 2024 at 03:31:28PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 12, 2024 at 02:10:28PM +0200, Christian Marangi wrote:
> > The chosen name was arbritrary just to follow eMMC ones. Can totally
> > change if problematic.

The purpose of those eMMC nodes was to describe various non-standard 
stuff you get when discoverable devices get soldered on a board. Power 
rails, reset GPIOs, etc. It was not to put partition info there, but I 
suppose having the node opens it to such abuse.

> 
> NVMe namespaces are dynamic and can be created and deleted at will
> at runtime.  I just don't see how they would even fit into OF
> concepts.
> 
> There is a huge impedance mismatch here, to the point where I completely
> fail to understand what you are trying to do.
> 
> > But support of OF for PCIe is already a thing for a long time. (it all
> > works by setting the compatible of the PCIe ID card) and used in wifi
> > card at assign MAC address, calibration data, disable frequency.
> 
> Please point to a document describing how, but more importantly why
> this is done.  I've worked with and maintained Linux PCI(e) drivers for
> about 20 years and never seen it.  And the concept simply doesn't make
> sense in terms of a dynamically probed bus.

With OpenFirmware systems, the firmware will probe PCI and populate 
nodes with what it discovered and with how it configured things. IBM 
PSeries uses DT for PCI hotplug as well, AIUI.

For Flattened DT, PCI devices are typically only present if there are 
extra non-discoverable things (again, happens when devices are soldered 
down and not in standard slots). Another example is a NIC where they 
cheaped out and didn't put an EEPROM to store the MAC address, so you 
store it in the DT. Now we're starting to see non-discoverable things 
sitting behind PCI devices, so we need the PCI device in DT to describe 
those downstream devices.

> > Not having this well organized and consistent schema in DT will result
> > in additional condition in the drivers...
> 
> NVMe Controllers are PCI functions (or virtual entities over the network).
> Defining them in a static DT scheme does not make sense.  NVMe Namespaces
> which are what contains the block data are dynamically discoverred and
> can be created and deleted at runtime, so refering to them in DT is even
> more broken.  I really don't see how any of this could remotely work.
> 
> > If these 2 patch are problematic I can totally drop from the series but
> > it was really to add consistency in NVMe and eMMC. The real important
> > part is eMMC that is becoming the de-facto replacement for NAND/NOR on
> > high tier devices (mostly wifi6/7 consumer router)
> 
> If you aren't dealing with raw(ish) NAND don't use mtd.  MTD is designed
> to deal with the nitty gritty details of NOR and NAND flash.  If you
> already have an FTL running in the device there is absolutely no reason
> to use it.

Yes, agreed.

Rob

