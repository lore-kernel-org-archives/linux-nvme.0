Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 19:27:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A9E60041
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 19:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45A9E60041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n9eZm4ZLjJ18S7/RZOpREFC5R9Pnj2s1MfiRIP09vP4=; b=35TX/rFRUWdOrT7hsWcePDD7hZ
	f5+5gP4EA7D+qf8lKsUAcqam8KHqgLr+HAGhLAqmmU5VZ1Owms6NEfm6vY512BG7W21djBxzvLs8m
	/NH2S7G/lzxK0UevT9Go1haK0qgqtZxBm9BjECcQRjyjgutwq6Y79R3F+UBtBKEsDKt+J4KJRNIUk
	PyEGReYoY1Qn+ZoKg9DOa2KdLA+82V15RSk6D0E1l/Ho7EoEtdGFTEY8L3XFmKCCqeSZ70yfX0+fT
	UB3anzZ3vGuoyVDSdVuJO2/jmrxZ62Z52k+Fu70Qoy/15GPCPiaYDPK2Is87NKAv5tkVQ/WGA6m4K
	NyzPQLEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miLuh-006PGe-DA; Wed, 03 Nov 2021 19:27:11 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miLue-006PFN-H4
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 19:27:10 +0000
Received: by mail-wr1-x433.google.com with SMTP id c4so5140556wrd.9
 for <linux-nvme@lists.infradead.org>; Wed, 03 Nov 2021 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=n9eZm4ZLjJ18S7/RZOpREFC5R9Pnj2s1MfiRIP09vP4=;
 b=q2GIFhHVe5lThDSHIlbvG+djmqWJ8UVbfdOb6L8YSOQYNT2e+uPJr1W8EFCfyq4a6l
 J5suBfUP2J04f86osP7IsykSpLuHkRXY+9HLIK99h4lVxWMv+6f3bTadjKLStPPhILTM
 w5TNTki0SM8UzMsxyf/4KVQnDmem8qoz/n0g6RsSr7hMn/WnvmI+twqpsWQaWEaL15re
 H1k1+79yO5hsR4iag2207tH+XRlxr37rlofcKcWxtelSCp9KHNK9IDne4I2q8id5wGWm
 FFtIcx2UhgbG41e+6Sv31zAMpJMPyBRmWCon3LA0tK4d5QNM1ScfqoFmXflbYz8cgoXz
 nWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=n9eZm4ZLjJ18S7/RZOpREFC5R9Pnj2s1MfiRIP09vP4=;
 b=pPJGgwtQvXZNcFOxyI3nqNCW3Q+WQ2kPfGK3DnvS5rJ/t9c+qvcJB2gEsGK7247Oqm
 5zZKNIC8K6LFc/rz69juRXwcKeZA74Gjppe49kGGmDIbqw0O8QC/JKWDXEacKdd1psCx
 EB7gzhP1JZ1HVuohwX8x+q44ZWn6PK6QBbcfMxdB6z+sx9hrjA9J6Hd4D9b81YzhI1zZ
 j5nm7HHfLm97RNta+e777azWdy7LevwkFia+qIdLYxXqh/Idv0nA55LlQgHjfG0aHT5K
 vHWwFDSUv9fh2obQdWcIiR9KaVvSefvVIqk8b3Xj74f7WVWerVlottyXCsYuxhipFBut
 o3NQ==
X-Gm-Message-State: AOAM530mna36lETPfGbzNK4B6iTdoinGSq4I4EwZZYE1U4KBU5q2JEI3
 CElE4JggALzyQnKm3x8TS/ZN4FpiHgib1AgvpK4=
X-Google-Smtp-Source: ABdhPJwm0J2qtE+FE/PUvTFUO5lV8Xw5XsKj4sTwM2pR0jbx5CoUJ/9kjWwlg9/c73FShGDpL5/+Cg==
X-Received: by 2002:a05:6000:1841:: with SMTP id
 c1mr24598385wri.425.1635967621989; 
 Wed, 03 Nov 2021 12:27:01 -0700 (PDT)
Received: from localhost (5.186.126.13.cgn.fibianet.dk. [5.186.126.13])
 by smtp.gmail.com with ESMTPSA id 9sm3893755wry.0.2021.11.03.12.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Nov 2021 12:27:01 -0700 (PDT)
Date: Wed, 3 Nov 2021 20:27:00 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
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
 Vincent Fu <vincent.fu@samsung.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20211103192700.clqzvvillfnml2nu@mpHalley-2>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
 <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
 <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
 <20211029081447.ativv64dofpqq22m@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211029081447.ativv64dofpqq22m@ArmHalley.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_122708_597490_32AF89A5 
X-CRM114-Status: GOOD (  18.77  )
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

On 29.10.2021 10:14, Javier González wrote:
>On 29.10.2021 00:21, Chaitanya Kulkarni wrote:
>>On 10/7/21 11:49 PM, Javier González wrote:
>>>External email: Use caution opening links or attachments
>>>
>>>
>>>On 06.10.2021 10:33, Bart Van Assche wrote:
>>>>On 10/6/21 3:05 AM, Javier González wrote:
>>>>>I agree that the topic is complex. However, we have not been able to
>>>>>find a clear path forward in the mailing list.
>>>>
>>>>Hmm ... really? At least Martin Petersen and I consider device mapper
>>>>support essential. How about starting from Mikulas' patch series that
>>>>supports the device mapper? See also
>>>>https://lore.kernel.org/all/alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com/
>>>>
>>
>>When we add a new REQ_OP_XXX we need to make sure it will work with
>>device mapper, so I agree with Bart and Martin.
>>
>>Starting with Mikulas patches is a right direction as of now..
>>
>>>
>>>Thanks for the pointers. We are looking into Mikulas' patch - I agree
>>>that it is a good start.
>>>
>>>>>What do you think about joining the call to talk very specific next
>>>>>steps to get a patchset that we can start reviewing in detail.
>>>>
>>>>I can do that.
>>>
>>>Thanks. I will wait until Chaitanya's reply on his questions. We will
>>>start suggesting some dates then.
>>>
>>
>>I think at this point we need to at least decide on having a first call
>>focused on how to proceed forward with Mikulas approach  ...
>>
>>Javier, can you please organize a call with people you listed in this
>>thread earlier ?
>
>Here you have a Doogle for end of next week and the week after OCP.
>Please fill it out until Wednesday. I will set up a call with the
>selected slot:
>
>    https://doodle.com/poll/r2c8duy3r8g88v8q?utm_source=poll&utm_medium=link
>
>Thanks,
>Javier

I sent the invite for the people that signed up into the Doodle. The
call will take place on Monday November 15th, 17.00-19.00 CET. See the
list of current participants below. If anyone else wants to participate,
please send me a note and I will extend the invite.

   Johannes.Thumshirn@wdc.com
   Vincent.fu@samsung.com
   a.dawn@samsung.com
   a.manzanares@samsung.com
   bvanassche@acm.org
   himanshu.madhani@oracle.com
   joshi.k@samsung.com
   kch@nvidia.com
   martin.petersen@oracle.com
   nj.shetty@samsung.com
   selvakuma.s1@samsung

Javier

