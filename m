Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7EBC52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqYcq999gsKKejZxZSj4pJ4zXAJ4qw8TpEhYqcXSNdM=; b=wG4ofgPz1Sa9LEvXxIhhrO2Ibf
	J39AVpY5FhILdydTatlBSjtzNR9NUwlTo3H+U/q0BBxXdkLp+fIkOSMmufmJP6O6uq6fwII66ekZP
	GCh5UQVNxKO0+4hU2tklllW0kETUIWt4ZhEaXgKMba+wKQ6Tzeo8CALfUVgW67C4hQ8z3FbOkgNc8
	atitqW8jU2YYU73CeDenG5k/hFCTnUWXrMQPTFAyo/mUQ3bZarxf8iBeLe/e4c6iK5R0mfBFssopU
	Dj2wDMq0ENwowOj52QhIMGUaFsr7x7KlzM3OxoBFx64hwjxF7HqVF/J/W7MXrLC0RgGNzDDCjvHef
	7E72AVBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdTtX-00000000E2U-3P6t;
	Mon, 12 Aug 2024 12:11:27 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdTsc-00000000Dnv-36Kw;
	Mon, 12 Aug 2024 12:10:32 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-36fe10ec0d1so576647f8f.0;
        Mon, 12 Aug 2024 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723464629; x=1724069429; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iqYcq999gsKKejZxZSj4pJ4zXAJ4qw8TpEhYqcXSNdM=;
        b=M7DhHh8uGS+r1KmIrqdM/ScISQUnflAphHQ+AKsDUtHMUMTqh+NkpeRbekmO/q+V+i
         bF/puw7Qr+6lh6SNdwFA7OkutRrh4ZOUIzp/ggMQbPVJeiiWDyfr6YmWJCn5QNen1dWm
         wcjLIUGPkUApozm1jVmNZ2OJA9Dpmcl+jaR8n+/rCg8/C2iWMs/J85BOti560jGn4lcD
         yGQ1dsDfGIeUgUq76033/a/aUEu3JSVb/wpbc2dZObOXbk9DRoX/0mW4D0TuL1E1ZHT6
         hRAEduwgYADjNpe9Kq+UJWreLRv5FNoRYHjuZTVOzuTK0acFJ2YwUF6SZ5aRE+5VqPkt
         bs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723464629; x=1724069429;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqYcq999gsKKejZxZSj4pJ4zXAJ4qw8TpEhYqcXSNdM=;
        b=BaSCOTxiX4hgJHErg69xpKtxBRE74zfiyYInKhEV7z6iO+W2eMg5jxx4TDL9zbBgEi
         itz3HvCHall6H6QNTTaKmVFhOkf6+Yqe7e9Ac+wY+hGxiiwSnbVXisWj2KXGXnKDcn8+
         Hr7SfCa6Qf99ebAscjGswSstAk7WLqDDzo0vhXW2xkpt/AeQsHiLM+RPRAGqJ5Wu7VdD
         dGpimMCr/jTPrUNFuAavxys5qKJu5FOcV5ZXdsEOA7ENMXklY1QHQU+FVVz03KBsDT6d
         vABnGdnILg/56C3/qnxtG8lkTNKaBV9FiIkpoE9nNJmBO+lsChaEYA/ZVvPw3cTHDvJC
         NjIg==
X-Forwarded-Encrypted: i=1; AJvYcCVDt1XlGeoisFiUfYIyIq/beLwyT1CnEtlguVHeDd4fIMoalPftJlRb2hq0AZh5VRkuXHXwWbs7Oe28UA==@lists.infradead.org, AJvYcCXdMIz7YqOjl+FPsU8dT0NnsLt0VYLttEdh2md2ZkTrrDqhqKM6WZJh99TE3a0U1M5ZRZJfFAmnrEc=@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6LPlLdx2VBvPFZsf+1cIccj7ptFxI8u9wC2P7iFsNDMlLHtWn
	QavWE/b9eEDuy48SVPLpCDpjAK2ahq6sd+GwrGF2cDjK6ddDqJo7wR6DZQ==
X-Google-Smtp-Source: AGHT+IFSR5C1hi+8j8Ydkfy62l96VSbCD6ttYmxsw3lESIi7Z9k7B2B1FgWmEng6FK8xhpk8Hz2Qyg==
X-Received: by 2002:adf:f902:0:b0:367:91d8:a1d2 with SMTP id ffacd0b85a97d-3716ccfc64dmr97552f8f.30.1723464628820;
        Mon, 12 Aug 2024 05:10:28 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ea82sm7362857f8f.72.2024.08.12.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:10:28 -0700 (PDT)
Message-ID: <66b9fbb4.df0a0220.3bee6e.1e99@mx.google.com>
X-Google-Original-Message-ID: <Zrn7tHHev-ydxq8n@Ansuel-XPS.>
Date: Mon, 12 Aug 2024 14:10:28 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
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
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-3-ansuelsmth@gmail.com>
 <20240812111205.GC14300@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812111205.GC14300@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_051030_853512_50EF07D1 
X-CRM114-Status: GOOD (  25.86  )
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

On Mon, Aug 12, 2024 at 01:12:05PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 09, 2024 at 07:21:00PM +0200, Christian Marangi wrote:
> > Introduce support for a dedicated node for a nvme card. This will be a
> > subnode of the nvme controller node that will have the "nvme-card"
> > compatible.
> 
> FYI, there really is no such thing as an NVMe card.  There is an
> NVMe Namespace, which is the entity that contains the block data,
> the Controller which corresponds to the pci_dev for NVMe-PCIe, and
> the NVMe Subsystem, which contains Controllers and Namespaces.
>

The chosen name was arbritrary just to follow eMMC ones. Can totally
change if problematic.

> > This follow a similar implementation done for mmc where the specific mmc
> > card have a dedicated of_node.
> 
> That's not a good explanation to be honest.  Most eMMC host controllers
> are OF probed devices, so of course they'll have an of_node.
> 
> Binding PCIe functions to of_nodes seems completely weird to me, and
> you'll need to explain what this totally non-obvious thing makes sense.
> Maybe it does, but it needs to be backed up with a very good rationale
> that is very clearly documented.
> 

But support of OF for PCIe is already a thing for a long time. (it all
works by setting the compatible of the PCIe ID card) and used in wifi
card at assign MAC address, calibration data, disable frequency.

In this context we would do a similar thing with declaring the NVMe with
the PCIe ID card (already supported) and we add support for defining an
additional subnode for usage of block2mtd.

The subnode is needed to keep consistency in how the disk struct are
defined with all the parenting levels.

Just to stress it more... This is really for consistency as PCIe OF node
are already a thing and on block2mtd (for example) the same thing can be
done with something like

disk->parent->parent.of_node (as it would point, if present, to the OF node
of the PCIe card (the NVMe))

With eMMC with the mmc-card subnode we would have to use

disk->parent.of_node

Not having this well organized and consistent schema in DT will result
in additional condition in the drivers...

Also consider that if the card is not detected, nothing is probed so
those additional node won't cause any harm.

If these 2 patch are problematic I can totally drop from the series but
it was really to add consistency in NVMe and eMMC. The real important
part is eMMC that is becoming the de-facto replacement for NAND/NOR on
high tier devices (mostly wifi6/7 consumer router)

-- 
	Ansuel

