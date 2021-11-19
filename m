Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F1C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 16:21:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8476124B
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 16:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C8476124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYLRPwJpMIma+7I/gXS8Fe5+Xg8Jtu68cLUUk/7i+NA=; b=mIakekOB0CH1D989sYpgzG+x1Z
	ikvsWmW/yQk9b6Q/SwIAgAFxYFo+mRrREri3A+2I0I9mdrt6MALmW42fQawGt/mGTwtgQuHg5W2Tt
	yBHDi6Niv0ubXlEUrHW5cklyT9sCbImBfj0Mih0prbgoV0vdQ4vSsjTPGhMs4J6a7brBRsx/qXEgU
	ZX6/oL8w62XxGVP430kTkvHRs7U7Mwx46LACDacp1ksq/swPeOydszAd4gRIJV8Jo/eB5Nkv2CUeP
	Lg4XGVg07DHiX9134zlQ59Eo8+1PhbS/9q6QTK8gJ+tLY3ajFkwtkpelAZA93b+o8/rrIIFNJtF0j
	qjxxQm9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mo6dl-00AzqC-9A; Fri, 19 Nov 2021 16:21:29 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mo6dj-00AzpG-0y
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 16:21:28 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 j6-20020a17090a588600b001a78a5ce46aso11412215pji.0
 for <linux-nvme@lists.infradead.org>; Fri, 19 Nov 2021 08:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dYLRPwJpMIma+7I/gXS8Fe5+Xg8Jtu68cLUUk/7i+NA=;
 b=cpw+GzLaOe1liaCWrq8QWpkoLx8zxqyFdJnSixdUwlRpR21OE8vZi6Ogc3IBsW/TKf
 2Gls3LMIZArnCSkXaCXowcMcQCJ6yvxezXBFdIsS2cd/hVGx5SXgoUvzcl40PP15vPVf
 aFJcNHJEQFVl/eWlMAB0KRuQ9K5LCTKojbq/hXz0iLqkWm7TrED7NjfU7+Gzt8VdvFBG
 SjZxig9zuW0BP81QMmVjFhq2yYSuvbeIPf6OxQjlAXKFtHwW9iFFftSyJOyq7Cs4tGNl
 HUNR2b/G2fGSksHqZvYD2imkMPMaPNV8vgUzbBOfV2f86vRBljRSLHWPB4mFHK4TrVTn
 SIEw==
X-Gm-Message-State: AOAM532/3kHHUUxISM2S8CCnd8E20mWcLiPAtZHNb299M76KNmkquySl
 SarqqCnTThD1yywPpoQePdg=
X-Google-Smtp-Source: ABdhPJw16jjqfIprCHt2mG+Ksck30kqntK4sVEg0T0pyn+4kYe1d4XjIzZ1UNiSmcyxOlOBtUI890Q==
X-Received: by 2002:a17:90a:f00e:: with SMTP id
 bt14mr927761pjb.219.1637338884999; 
 Fri, 19 Nov 2021 08:21:24 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id j1sm172775pfu.47.2021.11.19.08.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Nov 2021 08:21:24 -0800 (PST)
Message-ID: <bbe942b4-3239-6c54-2e16-431ac8056afa@acm.org>
Date: Fri, 19 Nov 2021 08:21:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Vincent Fu <vincent.fu@samsung.com>
References: <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
 <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
 <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
 <20211029081447.ativv64dofpqq22m@ArmHalley.local>
 <20211103192700.clqzvvillfnml2nu@mpHalley-2>
 <20211116134324.hbs3tp5proxootd7@ArmHalley.localdomain>
 <CA+1E3rJRT+89OCyqRtb5BFbez0BfkKvCGijd=nObMEB3_v6MyA@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CA+1E3rJRT+89OCyqRtb5BFbez0BfkKvCGijd=nObMEB3_v6MyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_082127_109855_EA77A801 
X-CRM114-Status: GOOD (  18.21  )
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

On 11/19/21 02:47, Kanchan Joshi wrote:
> Given the multitude of things accumulated on this topic, Martin
> suggested to have a table/matrix.
> Some of those should go in the initial patchset, and the remaining are
> to be staged for subsequent work.
> Here is the attempt to split the stuff into two buckets. Please change
> if something needs to be changed below.
> 
> 1. Driver
> *********
> Initial: NVMe Copy command (single NS)
> Subsequent: Multi NS copy, XCopy/Token-based Copy
> 
> 2. Block layer
> **************
> Initial:
> - Block-generic copy (REQ_OP_COPY), with interface accommodating two block-devs
> - Emulation, when offload is natively absent
> - DM support (at least dm-linear)
> 
> 3. User-interface
> *****************
> Initial: new ioctl or io_uring opcode
> 
> 4. In-kernel user
> ******************
> Initial: at least one user
> - dm-kcopyd user (e.g. dm-clone), or FS requiring GC (F2FS/Btrfs)
> 
> Subsequent:
> - copy_file_range

Integrity support and inline encryption support are missing from the above
overview. Both are supported by the block layer. See also block/blk-integrity.c
and include/linux/blk-crypto.h. I'm not claiming that these should be supported
in the first version but I think it would be good to add these to the above
overview.

Thanks,

Bart.

