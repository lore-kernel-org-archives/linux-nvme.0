Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68379C52D6F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Subject:Cc:To:
	From:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TOD5WjK75PEA5fwbhiWZMV4CDw+nr+tptFdJXihO9UE=; b=tLM0k3rh5MBPzqODe20ItTcRav
	umSNsWs4KEUufwGwD+qvXyzI9NfeFkRtQSFrtN1/0ECHal0mPvIL+tBS9fFDAsvxhdzHXEpthrHOD
	e/nBUuuY5wMnlE0sU1bKOOK33BJMQ1Zh6IHBl247BOCPkGGi63gQbiBq0SPPw7neZA+g3xH85nR8l
	QB4NJow+XkEKiRg6eefdWY+gJAeo6SuaK1ZYyZCkDBN9zlFqZr1iBvKMkvwjypMjOb8wqVFoNBKjz
	LzfcGMkvx7ipzjVoMdyKj1HBTzuoU2N3wngx0U8FBZg8ekvrInF54G/eVv+XUqTaSt8wKuNwF/Ld2
	J1vvxFFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgpc6-00000009zdm-2iSc;
	Wed, 21 Aug 2024 17:59:18 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgpbq-00000009zXm-3yM0;
	Wed, 21 Aug 2024 17:59:04 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-428119da952so56667515e9.0;
        Wed, 21 Aug 2024 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724263141; x=1724867941; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TOD5WjK75PEA5fwbhiWZMV4CDw+nr+tptFdJXihO9UE=;
        b=KlOCN3TEb5FwRunR2n9zyOcJeK3Odd6EGV+ZBV2FYaknSYpyXsgQs9XW0RYOgtJ0pG
         cih0/jNm1nbRiNoEU0FXVehMPCXrm92RrxSgxSoqiZ7BqnEXhQYJOyY0w4Se7o+ufdd9
         ZT2eX6JSiOM+bKa6zorpaercGUBBTMuit+XyG0paUYWZHVoW5s289fR2hUdYsTUn6Lmq
         igrzSvVKkvw/qHTrQGKYR7tnr/GY/qWTVluJ3U6ynQinTXAaJt8mSoxC2H1sLAIBlI4P
         L2SyDnzZYKPTXFyEF2DSFSBYaKCaq3/k2uiDfKbjzn2vcGQGYFjaaObTUQApyp3oCnIw
         hTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263141; x=1724867941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOD5WjK75PEA5fwbhiWZMV4CDw+nr+tptFdJXihO9UE=;
        b=JivXxq4hGztlcFP/0w4lEcYV2106hqySR2pxYfXt9TdKpGJCB/teZ+9cLED4cp659I
         YyETp1+AM5LU60FrLruZELzT1xIE78sNSUKAL7SVU7lpHb8dqW6YQYCUJTJucDIpZTqT
         hmQg9jN+qIZUuFlDw9G2MjdRt2A/oOpRIO/IimyDTeLZdAKU4aN2HJe69vdZGwHjW3+p
         onRsRVdWsr/bRJQvDy67VfiFYaE5G5/dGX7UDeQTrRhrVbGip5QBWta3Wp1gDet90POI
         sv2fb5NuzY+NpG8L3Si564WsycawykwNkqxIBMJUrsKOxxGyF6py9SiSHDkTKrrBUcS8
         tysQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbS/lsnOrXwxfXM/0V1gm8lfGPzQj+Chg2oPBo4HXce6pbc8FYXmh/b8n7YLQ/4voUItY+I5HdN+NMmA==@lists.infradead.org, AJvYcCVfkQCfZuv59Uxy4CD4sF55A0a8DyvblDSpd6VoI+KeOQ/U5BM/HkSBjhmEwwkSLAtPUZGI6aCOqpk=@lists.infradead.org
X-Gm-Message-State: AOJu0YyvYGwahV1Kyf64uMoNIv52zRMWAowiJr7t3anr+TnwoeF+E7DP
	YkxKs5IXE0cBMckgXvk03dlUhCV+rn9DX/6MAvYpOXiPl7OGiziYy9m9VA==
X-Google-Smtp-Source: AGHT+IEwkWw5dB6NoT1uzj+jGodXrd2ZHv9kY+EwOC9MkKKnONqtqhgL6b91WJgkEX4JHEbGx1Tg9g==
X-Received: by 2002:a5d:4ac7:0:b0:367:4dbb:ed51 with SMTP id ffacd0b85a97d-372fd4cab05mr2238221f8f.0.1724263140422;
        Wed, 21 Aug 2024 10:59:00 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-209-141.retail.telecomitalia.it. [87.1.209.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeba89a5sm34619255e9.0.2024.08.21.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:58:59 -0700 (PDT)
Message-ID: <66c62ae3.050a0220.2344f.a560@mx.google.com>
X-Google-Original-Message-ID: <ZsUQwPuprky6nVl1@Ansuel-XPS.>
Date: Tue, 20 Aug 2024 23:55:12 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions
 node in mmc-card node
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-4-ansuelsmth@gmail.com>
 <20240813200734.GA1659224-robh@kernel.org>
 <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
 <20240821151249.294590ec@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821151249.294590ec@xps-13>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_105903_010992_02C2552B 
X-CRM114-Status: GOOD (  49.66  )
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

On Wed, Aug 21, 2024 at 03:12:49PM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Tue, 20 Aug 2024 22:20:59 +0200:
> 
> > On Tue, Aug 13, 2024 at 02:07:34PM -0600, Rob Herring wrote:
> > > On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:  
> > > > Add property for defining partitions node in mmc-card node to define
> > > > partitions in DT by the use of the block2mtd module to use block
> > > > devices as MTD.  
> > > 
> > > You justified patch 1 saying eMMC already supported this, but then here 
> > > you add support.
> > > 
> > > Both are a NAK for me as both already have a way to describe partitions 
> > > with GPT.
> > >  
> > 
> > I think this got a bit confused and hope we can find a way to add
> > support for this.
> > 
> > What is "already supported" is assigning an OF node so driver can
> > reference it. This patch was just adding the nodes in the schema to say
> > that partitions can be defined.
> > 
> > I think what is not clear is that block devices might be used as raw
> > devices without a partition table defined in the device. In such case
> > it's the kernel that define a fixed partition table.
> > 
> > One example is [1] where the partition table is provided by cmdline.
> > Similar to cmdlinepart MTD parser.
> > 
> > The use of block2mtd is just to make use of the MTD parser system.
> > 
> > Considering
> > - eMMC is soldered to the device (no dynamic scan)
> > - cmdline might be not tunable and hardcoding it might also be
> >   problematic (as some cmdline needs to be used)
> > - concept of fixed partition for block device is already a thing and
> >   used a lot (android AFAIK)
> > 
> > I think it should be acceptable to introduce in DT support for defining
> > fixed partition for block devices and some kind of parser system similar
> > to MTD. What do you think? Would this be more acceptable? Idea is to
> > just have a DT schema that makes use of the values that can be set in
> > [1].
> > 
> > Hope we can find a solution to this, I'm totally OK for dropping NVMe as
> > I understand it's PCIe stuff and very dynamic but OEM are making lots of
> > use of eMMC and are starting to use these strange way (block2mtd) as we
> > currently don't give a proper and easy solution for the task.
> 
> Thanks for the summary. I believe I now have a better understanding of
> what you want to do, but I am still convinced you should not abuse the
> mtd layer for that. If blocks can be partitioned based on the cmdline
> (or from the DT) then the partitioning logic should be specific to
> the block layer. However, the parsing logic is probably very similar
> and could be extracted into a lib/, provided that the mtd bits are
> moved away cleverly. You only need the fixed parser anyway, and you
> probably don't want all the weird corner cases we keep supporting for
> backward compatibility reasons.
>

Yes I also agree abusing MTD layer for this is wrong and I also love
introducing and actually "stabilize" support for fixed-partitions for
block devices. So what it needs to be done is creating support in DT.
(interesting that cmdline is supported but nobody cared of adding
support in DT as that opens to lots of possibilities and is generally
better)

Yes I will check how the current fixed-partition parser for MTD can be
generalized and moved to MTD. In theory the DT schema should be the
same. (it's just offset, label and size after all)

> > [1] https://github.com/torvalds/linux/blob/master/Documentation/block/cmdline-partition.rst
> > 
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++++
> > > >  1 file changed, 40 insertions(+)  
> > 
> 
> Thanks,
> Miquèl

-- 
	Ansuel

