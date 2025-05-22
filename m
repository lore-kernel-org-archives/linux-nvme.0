Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEB9C54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=I43E9Used7ZzOVDhq/ufhep8eOi1ZE1QL/P9g55nGak=; b=0oHawB4hPp7zGU
	PoaNBVIgYPBa3msc9doO2tXBcgPVuO/dVM6UBO66LM1c7hXxim+neVAVScJDg+QnNPzugZNpH+fXR
	Dry0AFCNLQ8UKVAZOiZab8YJEkw70av9O8msq/G7ln8P8Zm+ZTaVw70VHa8QCRtN/dSu0YajykdGD
	u3sBOmCJtW2z4tPgko+35bNaUrfIyAEeQQ9bGIykZU8JNCj0yMlNC2WlxvIHPWI6o5vv5Yh5ObIj+
	uXYnYq32fWAOZv8M8sQZs4c2s3Xyj1xSkER1sAyz8a1QDV1gAqyyPGr41ytYexkp5SR+Q21uRDhRg
	UAts1L30Xl3PWGlGDLQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI1Tf-00000000Jfa-16H2;
	Thu, 22 May 2025 08:40:35 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI1A9-00000000GNr-209k
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 08:20:27 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-ad52dfe06ceso684559566b.3
        for <linux-nvme@lists.infradead.org>; Thu, 22 May 2025 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1747902023; x=1748506823; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I43E9Used7ZzOVDhq/ufhep8eOi1ZE1QL/P9g55nGak=;
        b=EtfydumDC5lcWE/kXQADBcejxr0aRzqLAh9ogDKk/vLRE9xhhsH2dKOM/KoDBgi7Va
         P+PTwkVEvlW9o1AqO28V6pnJ4r/dZimZcpOE2jk8WiTAm/hyF5slAki1li2aekYwN3+S
         RQY9JJT3bCDrZLw5iofZNoqQRHEwm3p4ADs2bJoqbm4YlXflVQAG7ihqxWDW0w/yR5D9
         Wb3a76zVDt05iIxp/CLWqkeyzwfeoqp72zCajc7cCwxqS1P2Ft6O+Z/Cl5Hbu/Gak/DZ
         1OkAZlCS1+B79RK59WQovlk7Lf76YbbRyQ18sHgp1e+BV8RL0nUs8J19+VHVigkoC4NY
         Ueyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747902023; x=1748506823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I43E9Used7ZzOVDhq/ufhep8eOi1ZE1QL/P9g55nGak=;
        b=VFUijTpcGShuhXIFrUu6zNMP+3y91hTmeb8v6NFT90oZ6GYrAVV9L1dcnvSqu5DDaO
         Ur71zma/x/FpDsU2unqiBpU0i/PyalO1D2Xely6Bb8D65PvApU9ACi8Msozmmxw6s4c1
         NV2TpENVjx7m7Es2BjcN+5CjCaTBLzmw8NGHj2ebcIbAhYUXCMKWcYC5fQ3pqY2toBKd
         KoYbrr8/gmnJNFjZiDOXxK1iqLK8aldZgTGbRZelsPdjrQn2fUgb4RhVCM3G9UgN0dDc
         9ahdEm2a1cxjAzlpS0JDdXrzTMmuck12v20UZeVeks6f8c7OkkaEcD9taLT2DPwMaxWv
         xQyg==
X-Forwarded-Encrypted: i=1; AJvYcCWJbovxR2uc1KCOAxPk+boIzu+kjdA2NdWmRll0X76wyhk6QEHo481r/dDDyqGM3L2G36y90k9b41Fc@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9aPIghEXrv7lFcSB+pKBKtV0YOdkg+0cmzU2BCidIFTcFqToz
	dTKjRviXcbEwQbHwlUdOF2COglh5vQ2I0WOX5L/nwlG5wpGfpeeXFA2OuQ69SejagFk=
X-Gm-Gg: ASbGncumNukFIykI8h4uHLf/9ni9GrElRNQ/9yxX9m4ZJm3nPSO8xUPET7X4gM/oTBq
	6swph9t3R4q67Aa8daSUYTDgAiFFsL6X1nU+15JIowfuZ/8noCGwg+Zvg8I/yYjwVM8xjrq6yJL
	Lrp7Gu4i/Hf+JjeHsRQIFxZBcFNVPb0aKOkJGZczGpty1lIIHvl/9SjbXm2BC9aJzp0zmgKpy85
	5MIw/t6x0yWgyWi8MX0uagi+kqwX0wwiiHtA20iGQGH+wKNLtvnSJnRKWYPPKXyfSWibKo/1/AF
	I7F97bOuhCSi5tuaSAaVzu5Io4oR23CdsNhhaDom5vyomVDjS6hAqZs4ZB5KTQgp/WGYWAmHzgv
	rIMlEMn3xlWpJ4bxtdUqYtNEw
X-Google-Smtp-Source: AGHT+IHd/c+RlpU9wZSwKb6MHnIxte3dN22uhcNe9UW8PMtyUqFZZ0KzS+tArvGbttCUDJzPrSUFTg==
X-Received: by 2002:a17:907:3f08:b0:ad5:68b7:b0df with SMTP id a640c23a62f3a-ad568b7b232mr1504511566b.46.1747902022820;
        Thu, 22 May 2025 01:20:22 -0700 (PDT)
Received: from somecomputer (ip-046-005-029-055.um12.pools.vodafone-ip.de. [46.5.29.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad53603a399sm998546366b.40.2025.05.22.01.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:20:22 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Alpine Linux Persistence and Storage Summit 2025
Date: Thu, 22 May 2025 10:20:20 +0200
Message-ID: <1826170.yIU609i1g2@pliers>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_012025_804169_287EB1A3 
X-CRM114-Status: UNSURE (   7.96  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We proudly announce the 8th Alpine Linux Persistence and Storage Summit
(ALPSS), which will be held September 29th to October 2nd at the
Lizumerhuette (https://www.lizumer-huette.at/) in Austria.

The goal of this conference is to discuss the hot topics in Linux storage
and file systems, such as persistent memory, NVMe, zoned storage, and I/O
scheduling in a cool and relaxed setting with spectacular views in the
Austrian alps.

We plan to have a small selection of short and to the point talks with
lots of room for discussion in small groups, as well as ample downtime
to enjoy the surroundings

Attendance is free except for the accommodation and food at the lodge
but the number of seats is strictly limited.  Cost for accommodation and
half board is between 55 and 84 EUR depending on the room category,
with additional discounts for members of an alpine society.

If you are interested in attending please reserve a seat by mailing your
favorite topic(s) to:

        alpss-pc@penguingang.at

If you are interested in giving a short and crisp talk please also send
an abstract to the same address.

The Lizumerhuette is an Alpine Society lodge in a high alpine environment.
A hike of approximately 2 hours is required to the lodge, and no other
accommodations are available within walking distance.

Please note: reservations for the lodge are not handled through the
reservation system, but as part of the ALPSS registration.

Check our website at https://www.alpss.at/ for more details.

Thank you on behalf of the program committee:

    Christoph Hellwig
    Johannes Thumshirn
    Richard Weinberger



