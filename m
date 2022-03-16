Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201B0C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ivduCWllgAhkl431+NElDaj0MPOUaZZX1zUUbSYMRvM=; b=qiGGYmKYyNzWKfxJSDazeeZQNN
	kPyp8C6eqANjkggxT7tAOTgMKt8DW2sbV+85FgpxEjEqIfCEztJY1MPhtbz3rCtruPhv2wNT76QHN
	q6UheZWOG6x0Ui2Svr/GTJt7aj4Xnsm3X11MMWYYJJ7t9r1AttSw+HkCMkkhO7HCsvo/PM9Ue6691
	IF+D6AGwTdvmujmgMjFsCONIrT0Ob8P+Z1lt5gXlu6CRiU+kMEyVWybaTsaptUA6LEJzICVSWzeJE
	Im99xF/S6XV8SRuvvtsZaA79sPbddLUM9QUguS9YJXZjvNAKcNAtVbjxIXg16dqgyz37RUTvFCnWG
	Ss97tYpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUPH0-00CByg-1A; Wed, 16 Mar 2022 08:44:50 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUPGx-00CBx2-07
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 08:44:48 +0000
Received: by mail-ed1-x52b.google.com with SMTP id z92so842637ede.13
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ivduCWllgAhkl431+NElDaj0MPOUaZZX1zUUbSYMRvM=;
 b=hAr/5zQTdbSkj5pHiBKvwAoDyObBsYXqHQrsoqDAhF2IBePz9UgYH6EwCehd4SRgUC
 9KM3Q/lVOGnmauhyuMrDhUYsmWS6ceBt6Hls2NPvjGNbeJxGIj7lFzX9shCGNMseH0cU
 u/kVgebRD1YDguODVWXwHX+iMbdRdDCtWcV6Bbl31+daHp3YMip0lwCaoYQfDt/6mOyM
 ffi5OCHT0taXV0DepiqI4ZcgsCdOgvItn0PCyFZJ/LUMpDsoNXWGWFyOAUOrCci3Ompc
 dUOsutm6lf23O45R0T3trR+rWlegzSUHNrGp4hhGfjeWf/lFruo5iPN/BFbmDEt1ROA7
 O58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ivduCWllgAhkl431+NElDaj0MPOUaZZX1zUUbSYMRvM=;
 b=3Y2Q2Q4Xixl9XVIMpjunWGSKRn72uPBRdcsH3tK3LzCszezZr8jew9PgJXfv3BU/HA
 IvTz6/coNc3PKxZBpcxklil9yJaAwo7JqnunM+eoJrElb77FcCVHtJO+k+7+z+jDmIzf
 lsxiqDyuYgJxRH9cuV3LHSVvA0d2wdOEURpGmaRkV3K2M9LiUmIZoWRVKBKB99ffMxSs
 3TNvmR/zthdD0bKBX/kMG8/+SDe90Yu6TDUY2FV2F2svRU9FFyvE0WvfwSfDIEU8x+L7
 ac1V5fsX0YxUi0k5SWOmkWBS+CI9YLhsu9qK91chOmsHKbMf54PsDWRPA0XQfJyS1fIV
 Ic2A==
X-Gm-Message-State: AOAM530wzhC8b2UPy6/CEJBP7Vi51DMyAud9fmAvvFfhM0LAkZzhL8XQ
 fv62wJZ1CsVJiMrrFWaaIOFRog==
X-Google-Smtp-Source: ABdhPJyFtg89DVgaQqT6qtznmpTTA+nOpZ/sK0VzW/VVMlB9pc+PIJEWUWmWmfjyxhPsR9USMyikQA==
X-Received: by 2002:a05:6402:5243:b0:418:e5f7:7b1 with SMTP id
 t3-20020a056402524300b00418e5f707b1mr2717202edd.153.1647420285107; 
 Wed, 16 Mar 2022 01:44:45 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a1709063a0500b006da8fa9526esm582395eje.178.2022.03.16.01.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 01:44:44 -0700 (PDT)
Date: Wed, 16 Mar 2022 09:44:44 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220316084444.gn27fxoh7xd3soly@ArmHalley.localdomain>
References: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_014447_162174_45D73991 
X-CRM114-Status: GOOD (  16.63  )
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

On 15.03.2022 22:27, Martin K. Petersen wrote:
>
>Luis,
>
>> Applications which want to support ZNS have to take into consideration
>> that NPO2 is posisble and there existing users of that world today.
>
>Every time a new technology comes along vendors inevitably introduce
>first gen devices that are implemented with little consideration for the
>OS stacks they need to work with. This has happened for pretty much
>every technology I have been involved with over the years. So the fact
>that NPO2 devices exist is no argument. There are tons of devices out
>there that Linux does not support and never will.
>
>In early engagements SSD drive vendors proposed all sorts of weird NPO2
>block sizes and alignments that it was argued were *incontestable*
>requirements for building NAND devices. And yet a generation or two
>later every SSD transparently handled 512-byte or 4096-byte logical
>blocks just fine. Imagine if we had re-engineered the entire I/O stack
>to accommodate these awful designs?
>
>Similarly, many proponents suggested oddball NPO2 sizes for SMR
>zones. And yet the market very quickly settled on PO2 once things
>started shipping in volume.
>
>Simplicity and long term maintainability of the kernel should always
>take precedence as far as I'm concerned.

Martin, you are absolutely right.

The argument is not that there is available HW. The argument is that as
we tried to retrofit ZNS into the zoned block device, the gap between
zone size and capacity has brought adoption issues for some customers.

I would still like to wait and give some time to get some feedback on
the plan I proposed yesterday before we post patches. At this point, I
would very much like to hear your opinion on how the changes will incur
a maintainability problem. Nobody wants that.


