Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421D5C52D70
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tuJWybY/5l5UyBwF8mZPkMRRtpH0IYFVeNn3er57z18=; b=po8gE+XHmLWKaWTJMNjS7V24AQ
	x+puNftlpGmlpUO26vHc1AFouXhr5iLXVUmdSLMlcsat3NCIiaO8mIsFC6iQAePWOwwNvnTpruxNd
	i9z1GO2boXlpAgbeqCFPpbg2WBV3p7CUbQJzNToiCNwz4/vaol8IPbG7GNp+ul3ZQ//0SIBPMdAcZ
	1rqY0ciQY+EMccLbqBba8Nv05b67UFga2HBV/tjPWoj3MaSCUCgLK2RT/yyV+sGQDhkOPeb3le0q2
	jwswl15fdFdke3qa+ez3m9eGRL6K9BtWparj1La5YSL1z33DuCA5CagMW6/RZN+sOnSVP9r8n/D6d
	E76g9rEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJim-00000001Zto-1sgk;
	Tue, 06 Aug 2024 12:55:24 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJij-00000001Zr5-0biQ;
	Tue, 06 Aug 2024 12:55:22 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so4756815e9.1;
        Tue, 06 Aug 2024 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722948919; x=1723553719; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tuJWybY/5l5UyBwF8mZPkMRRtpH0IYFVeNn3er57z18=;
        b=TRRor09g+ILsXfWkHpOGQ5QI+QNAuMGGI7vwyKSkUgaCpi3MZfqfykYUKjnB8NI/lJ
         riKXfNDeueb2ldJ2fx4gf9EJL76hs/I4llXbjNJbb3gVJBV9TkB5n7KHdZPk0zFyd4tZ
         TCRl+fDmCuTy2kjj4ck2NlI6v4g3FYZgimpZJWzvRcszDUf66Vinl6AAKZ7U92Qf2+vU
         zMNomnfFSLfVKJEy+VttUEW6yDjX/skKN1gPBJX+drBoq1tnzU5x2KzurjyBVsAZdLVt
         d0BU1Rp2rUtLRPsUqyCtdJ94aLnv2eITPXL+AVoOQUyVTW8tAXd8G2+B1UcGWJ+wFfdR
         8bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948919; x=1723553719;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuJWybY/5l5UyBwF8mZPkMRRtpH0IYFVeNn3er57z18=;
        b=l1q0ShR/JWXUNDe2rdgu6TTCC7C/Q3abwbJnvjcG96vD/D7NOg0UUxYQPIKpWijXD5
         hKu18OUcJRHBzMyj6mU39eIhx+ce7mmbSt8C+Bcb/gE0MqX32RpNtXOCiefn27lBYU/7
         XaGLhB4qGsZ7aRohvai6sjPBExyMueo3GrcN9AEoOtODOYKcipwB0Ll5r5ofS9Z6DTic
         0wIooEmk5yYs/ttyPWAFi2q77WDDwpgop9kpxGOtKPtybEyxDJsxIw9vdFcwPnVbKqPT
         aEtNxJY7NujchA8SdcHxLEBFy/qDiP2oKRbpq90MeeISpGL397uZchchNabEpch/Me7E
         MUZg==
X-Forwarded-Encrypted: i=1; AJvYcCVjIC2Lwou28q3guhW2T+jw6QZjkInC9LIbktsidLt+ldK3AfDKn1ZdygSXGJZIYX2YgBqz4Vrnln257EvwNU6t3Kty6Iwm7ZSd0yXvCKqVDen5PrT4hFZB5LFIOGM3a18J9dcUVCVqd3LlhjoL
X-Gm-Message-State: AOJu0Yxgs8F/Q4xIcv+IiIzSn00kIvVxJ4OdBYQEvvpEBi7Gbam2ri+W
	EvvnCT3btSWLObaDfcr/Qt7yIuMtCOo7qsj64fKnW5M5MTdGHtyH7+31yA==
X-Google-Smtp-Source: AGHT+IE0Qd5FtIv9e0QXQW0IXNZyBBQjJDJFmTAC/0KBUSGyZsbzZmsYlkLeZQJGbpFymr4UoLEIog==
X-Received: by 2002:a05:600c:5489:b0:426:5983:ed0a with SMTP id 5b1f17b1804b1-428e6b78e24mr96453035e9.30.1722948918385;
        Tue, 06 Aug 2024 05:55:18 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64952sm243271985e9.37.2024.08.06.05.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:55:17 -0700 (PDT)
Message-ID: <66b21d35.050a0220.3799b3.7e8c@mx.google.com>
X-Google-Original-Message-ID: <ZrIdMc8CeHeJ3U6s@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 14:55:13 +0200
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
 <20240806114118.17198-2-ansuelsmth@gmail.com>
 <20240806124224.GA10156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806124224.GA10156@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_055521_246121_D04E40A5 
X-CRM114-Status: GOOD (  15.35  )
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

On Tue, Aug 06, 2024 at 02:42:24PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 06, 2024 at 01:41:11PM +0200, Christian Marangi wrote:
> > Document new nvme-card compatible to permit defining fixed-partition in
> > DT by the use of the block2mtd module to use block devices as MTD.
>  
> What does nvme card mean?  Is this about nvmem or nvme?  If this is nvme,
> are you talking about nvme-pci?  Why would that needs a device binding
> when it is a PCI device?
>

It's similar to how it's done with mmc and it's to keep the property
consistent with block devices.

emmc have something like

mmc {
	mmc-card {
		specific-property;

		partitions...
	};
};

The same will be with nvme with

nvme {
	compatible = "pci_id"

	nvme-card {
		quirks maybe in the future?
		partitions...
	};
};

The following implementation permits in block2mtd to not complicate the
implementation with all the add_disk functions works with parenting
struct and how they are initialized.

(alternative is to have in block2mtd all kind of extra logic with switch
case to check for major block ID that deviates from a common schema)

-- 
	Ansuel

