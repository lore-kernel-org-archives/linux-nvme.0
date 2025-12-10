Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BED3C52B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dbN0X68nlefB3xcMuCNuqErFYMQLXoas1dJiWtK1NzU=; b=CujZ2X6yWiSzkVit9XkfxziYUA
	lyehfEyhZ+OGhW3YzP9V5X7i1MGUGhZGvr5bQNS8ZKg4hN7d3LKk5grTEc30VK5szGiKxutJPyn2q
	dzBYsW7z4dEU2dHF0XuXFX7QQG8FsuhGTVI7g3ebRBVWm5XRnMjJT/2PiXtHAZmCTrUYJh4R9DcmD
	7aieeTie8Btg9NrBHXNXqvehTKJ0+D27t4Iy0aZz0hsL1PgQ3YWm7uHEQv2KNYZDbH5mXQOR8Znx3
	Gu9wiYf9D50g7uu7fx84Bbstl1fygVxKvFVRZhKYL82HL1i06OENK0DnLvl4rfhSuoIJGF0BjNAbJ
	F+XIM93g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTI3q-0000000FMaq-3sMZ;
	Wed, 10 Dec 2025 11:08:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTI3n-0000000FMa4-37HY
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 11:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765364922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbN0X68nlefB3xcMuCNuqErFYMQLXoas1dJiWtK1NzU=;
	b=YKJngC5QFIgoytDTKJuO/7Z1x1+WCpSxOUnNAkgbegIwDb0vgdVsDOpWGepjpHN1McfnkF
	g2yJjDc3GzLu+uWvL1IvE1xR1wEYq/pq+J/F2bc2XiTcAqV2luWTWgoSDGzGFRIIm3C9Pm
	eaLb5jLcwoFuL3d9DygLbCCPy9dDRvM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-YBWMkxDlPU-SMr8LbzBVEQ-1; Wed, 10 Dec 2025 06:08:40 -0500
X-MC-Unique: YBWMkxDlPU-SMr8LbzBVEQ-1
X-Mimecast-MFC-AGG-ID: YBWMkxDlPU-SMr8LbzBVEQ_1765364919
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42e2e448d01so5131153f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Dec 2025 03:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765364919; x=1765969719;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbN0X68nlefB3xcMuCNuqErFYMQLXoas1dJiWtK1NzU=;
        b=pKnoWYuBBaxqw1tyfRn8oExJ/jg3ZT2KLosl3QoEwD6pkqM37ZZciZyLDLqW4cndqL
         MhurFKRYWVoxYHSA8aCrhyI784uwBGnd9zN4lXoTfq8D3uug248m6UesMRtyRYG+qJ2N
         XXwDbek1yCW/jE2LT3xaIpy7OQlFCamVUg3Pk0FsGJSM1VwE4z2NuUqFKNlg5xGWLbsa
         N/5qJ7XxYKRfcAJpK6Ts5lJDh0Z1C2Z+puWpPsF4Dp2UdGa5Be1XGTl1acS8CobO9JJY
         ry2/sYmGAflEH6sfbYPxpNMeiZzzqrHZnYu1waKnZMYaX3iPLe0TYL+yo9Hh6bcmgz2e
         nbDg==
X-Gm-Message-State: AOJu0YylgwJ6kxMmoG/UP9QDSqQaE5pupXvUXamsR65sJCYTx7LeFYFI
	hZ9uNlZ7D9ZaR11U2sRGyoJVg6aaqAM+OQqpDeswuZUSlPuorDtNcj4GIPmzXROk3HjGOihJy/8
	UW4lDH6/RausiLRRC/10pjYx0+bNMEKl/bcaVQAlv2ct9ddES1wCThjo+TM5Zwg28ufbD
X-Gm-Gg: AY/fxX51rYJZX2Ce1mu3LR4uOINGg080MDaq182RWBBxg+ShqkmVTrMZa7fCcs4QyRv
	105LrdwhQCLqTpanvDRp/W4BiUa2scIh4XlEV1qdtuxSMDACxLvXv/5aJSxwGB00SfGhQoAI85O
	un3V1Xlf5hEBeY44Kh+dWXqRJ29zSWvFY1g9bh2rkTz6jXBog9M2zQgkftPb9/9Trp18Z7sfLsL
	II+RC7+apP+du8bkRCLE1kObJuDHtOWTAYgvuUcCnS1kOpTFSepwRsdb/hDDbstJes/PWbmRiId
	ZXzB2tjqFMfCLQtaJJakr2DTGZug9WiI7Ghl7TO+qWScw8UEnqgqXIjKJhGpQu6bn7h/yorXF4w
	Q+fcNf12Xy5RGUowOI9YxqV5ug1KTRgn4Eg4r9SHO0mTjyoE2Pt/IdC1jH2Q=
X-Received: by 2002:a05:6000:268a:b0:42b:394a:9e3 with SMTP id ffacd0b85a97d-42fa3b00152mr2209762f8f.38.1765364919268;
        Wed, 10 Dec 2025 03:08:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0OaN9j3Rde1ToL7S2gPoe2gtnyWZiRtxW5eKFrQy2596pkXnfcwP8FxRZ0y1ST+KG1zmerA==
X-Received: by 2002:a05:6000:268a:b0:42b:394a:9e3 with SMTP id ffacd0b85a97d-42fa3b00152mr2209718f8f.38.1765364918819;
        Wed, 10 Dec 2025 03:08:38 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeae9sm37425520f8f.13.2025.12.10.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:08:38 -0800 (PST)
Date: Wed, 10 Dec 2025 12:08:36 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Keith Busch <kbusch@kernel.org>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Robin Murphy <robin.murphy@arm.com>, Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <aTj-8-_tHHY7q5C0@kbusch-mbp>
Message-ID: <acb053b0-fc08-91c6-c166-eebf26b5987e@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <aTj-8-_tHHY7q5C0@kbusch-mbp>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TUJTD0_cMDbDOhGjn64wjkZ4Q-cCd6EeBrAHBFTjJgo_1765364919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_030843_854683_A2D9AAB3 
X-CRM114-Status: GOOD (  14.19  )
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

On Wed, 10 Dec 2025, Keith Busch wrote:
> On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
>> got the following warning after a kernel update on Thurstday, leading to a
>> panic and fs corruption. I didn't capture the first warning but I'm pretty
>> sure it was the same. It's reproducible but I didn't bisect since it
>> borked my fs. The only hint I can give is that v6.18 worked. Is this a
>> known issue? Anything I should try?
>
> Could you check if your nvme device supports SGLs? There are some new
> features in 6.19 that would allow merging IO that wouldn't have happened
> before. You can check from command line:
>
>  # nvme id-ctrl /dev/nvme0 | grep sgl

# nvme id-ctrl /dev/nvme0n1 | grep sgl
sgls      : 0xf0002

Thanks,
Sebastian


