Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B13EC52D6F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vs7divW60kguKgDMWWHovgfstUgnqjKRitONyQjoVng=; b=B6XqELBuOagtUdpw6/MVZCp9gE
	3VyUVUFfqKzM4k836Iug/GhL0jtFA1Hgs4lm9kZ+lBIJRdybST/T1vqcKVwUoe6VMlrIHeRWKP/rq
	gQrFacmNmKTu4LCI+oVArZo+011w/GxgX9h3pmgRr6bWosKOfbVdeBhYPZYn0scUMdzi5uyBekhyb
	GXtBeDt8UzqB6xLgMy/SIzZYtzuTJkvBWfH8XR0tZ4AFYb1Cc/q+Q9VjmK0hLu9S99SCZ+fmRFSdT
	soGNqBklPjoCT3AgJlOFk+h3rcifzDs76ZSKPF+wimTzy8Ja37s4V37Uos1rJkcHUygx0PdQ//YnO
	6BV/MNjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgl95-000000094Wn-32v9;
	Wed, 21 Aug 2024 13:13:03 +0000
Received: from relay5-d.mail.gandi.net ([2001:4b98:dc4:8::225])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgl8z-000000094Tk-3Lke;
	Wed, 21 Aug 2024 13:13:01 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id C24C61C0003;
	Wed, 21 Aug 2024 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724245972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs7divW60kguKgDMWWHovgfstUgnqjKRitONyQjoVng=;
	b=YkbjEK4R82sHBIvsdW/oWF2IuNoZgjx5jHlgkzzHPJd9bsH0QqJDzjARZg5eJ5QkdGWfwD
	9JDpbpJbXvM5P2Qwyni0G5qt1moiqFbRqgAn1YUNt+T6vspiSd35YcKzwKJHWccsuaBFwn
	l3zfDYdK1q7AnCDoI8qUYr2yjeOBbgsA7F95lKWmDBj2M1MPB0jNN3qU/lgLU2BfxL9xL2
	q1A/zo4JUmj1lxpB06dFwHWfbQU7cAVItFkKyIjYlAEJNl3u1PyfUyfXOL01Z8F6z8OU8J
	wvGqeTQu3Yzm5cn1YjRNBYseglMsRRlTYm/22I8Ly3wBv8Q/P5U8yunZ5JXH8g==
Date: Wed, 21 Aug 2024 15:12:49 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Joern Engel <joern@lazybastard.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Saravana Kannan
 <saravanak@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions
 node in mmc-card node
Message-ID: <20240821151249.294590ec@xps-13>
In-Reply-To: <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
	<20240809172106.25892-4-ansuelsmth@gmail.com>
	<20240813200734.GA1659224-robh@kernel.org>
	<66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_061259_010031_938E3D76 
X-CRM114-Status: GOOD (  39.30  )
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

Hi Christian,

ansuelsmth@gmail.com wrote on Tue, 20 Aug 2024 22:20:59 +0200:

> On Tue, Aug 13, 2024 at 02:07:34PM -0600, Rob Herring wrote:
> > On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote: =20
> > > Add property for defining partitions node in mmc-card node to define
> > > partitions in DT by the use of the block2mtd module to use block
> > > devices as MTD. =20
> >=20
> > You justified patch 1 saying eMMC already supported this, but then here=
=20
> > you add support.
> >=20
> > Both are a NAK for me as both already have a way to describe partitions=
=20
> > with GPT.
> > =20
>=20
> I think this got a bit confused and hope we can find a way to add
> support for this.
>=20
> What is "already supported" is assigning an OF node so driver can
> reference it. This patch was just adding the nodes in the schema to say
> that partitions can be defined.
>=20
> I think what is not clear is that block devices might be used as raw
> devices without a partition table defined in the device. In such case
> it's the kernel that define a fixed partition table.
>=20
> One example is [1] where the partition table is provided by cmdline.
> Similar to cmdlinepart MTD parser.
>=20
> The use of block2mtd is just to make use of the MTD parser system.
>=20
> Considering
> - eMMC is soldered to the device (no dynamic scan)
> - cmdline might be not tunable and hardcoding it might also be
>   problematic (as some cmdline needs to be used)
> - concept of fixed partition for block device is already a thing and
>   used a lot (android AFAIK)
>=20
> I think it should be acceptable to introduce in DT support for defining
> fixed partition for block devices and some kind of parser system similar
> to MTD. What do you think? Would this be more acceptable? Idea is to
> just have a DT schema that makes use of the values that can be set in
> [1].
>=20
> Hope we can find a solution to this, I'm totally OK for dropping NVMe as
> I understand it's PCIe stuff and very dynamic but OEM are making lots of
> use of eMMC and are starting to use these strange way (block2mtd) as we
> currently don't give a proper and easy solution for the task.

Thanks for the summary. I believe I now have a better understanding of
what you want to do, but I am still convinced you should not abuse the
mtd layer for that. If blocks can be partitioned based on the cmdline
(or from the DT) then the partitioning logic should be specific to
the block layer. However, the parsing logic is probably very similar
and could be extracted into a lib/, provided that the mtd bits are
moved away cleverly. You only need the fixed parser anyway, and you
probably don't want all the weird corner cases we keep supporting for
backward compatibility reasons.

> [1] https://github.com/torvalds/linux/blob/master/Documentation/block/cmd=
line-partition.rst
>=20
> > >=20
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++=
++
> > >  1 file changed, 40 insertions(+) =20
>=20

Thanks,
Miqu=C3=A8l

