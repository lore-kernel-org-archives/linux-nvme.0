Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B4FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 12:54:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5230160F41
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 12:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5230160F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hss0my1U543SYA62Ffactpc9+//eg0/Fsm4KpfOP4TA=; b=LSLyLXdvrtnYYx30WBDmL9MSyu
	6BO0qbZ5FM+L8GlMnRJi/zWwOSgIBzp1N0b30ADt1X8WSF0Ly2hyWGrwjKeU5EhUWIsmQfQLbo86H
	7WUAs2BoEgDsXcfZa77zGw3ftLahJpdzgM0tx7SkjIXmWcO0IPGZKUUVGr65/kYJ3V/Qu1lW+PPLM
	vHTAhFKtorNlURtHkP/TF3KuDPLAeIk+e4PPjP8bjSrZBXukpn+XCcmt/ycHtJIaJKz/tJ2xx+TpG
	gflFTKC27ZkviMLlqT0NYv7vmW0TzM+kEZYeReursvKN9sOJd7MID8nFkAbw/OLNsNz4IzQzqAnNE
	Owuha+Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnKRy-004lJh-Nu; Wed, 17 Nov 2021 12:54:06 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnKRs-004lGU-VE
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 12:54:02 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 133so2148130wme.0
 for <linux-nvme@lists.infradead.org>; Wed, 17 Nov 2021 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=hss0my1U543SYA62Ffactpc9+//eg0/Fsm4KpfOP4TA=;
 b=cNSGVCgXy2Jr0DDROORE8h8J8ohDTgYgTeZwzXZy1XX72D7vMjy8+FDF8OElAFsPlt
 YU9hPx/B9RhVz9/JaIqmgAPMZsUtogLmKaV2ijNZ05+Z/4iFpO3J8Umt6jEbcvAWAcZK
 mcrAEBQkoqFKbQKvlwGe8/9d/35yaUQoHDbiLSEQR+TrKeunKkyCyKnQZJWWVlKj1RBP
 AZ1vSLkAoORo7sWj9raNWButcAjsPxq5x4irMkgt8Vh/lC9uY2RebAWWlyQfk7rpPU8I
 H96skOZMMuajYOxCQGi9C76/4onuRGkYVs1n7zwvLjpY4xg/f+XVlxq+ev/f9uqThiNu
 wsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hss0my1U543SYA62Ffactpc9+//eg0/Fsm4KpfOP4TA=;
 b=nlFeJdigubTKpkaUej9bqGl1T4+Y4mX20BCdf0AU19LZ3r7jLFjHmp6588aw5lirqe
 WAzlKFUjxOXb/Ua3YLU2wRec6Ms0KeOVjhTHwmCvm3JuKDGcGV32KECxOKdtaAHvgSuT
 TCJNupY5cpRmtzl3xb+6olsoreHMaUqRW8EZoGaxW6z94XzDdfwCfcMy103O8KUB3Sj7
 vgZ07aqz7wfP8mdix1LxHDEI8vXDr3wW80zKgda8kTgzWnAsN/j0Nxdlawk8haMo61ps
 h/LPaDxAEG9nLLsGb8rCnp5DkzKypblSk9GnSkjBWZnrsbGOVBhFPNDU4BN5N2ZAF02z
 94pg==
X-Gm-Message-State: AOAM530v9QiaX/7CKHpuOPpByGW2rmbrBiv/4s39vzin2zvpIFarqqqi
 0LX6t/3pLiwdhmtQb1bG88o5sw==
X-Google-Smtp-Source: ABdhPJxOXnHxfcN/nA4AKyAuhHjB0XGlYF1ByvmNcUHfw88xbXLPy+hq3hyfltHTbv+vqGO7YiaBXA==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr77977369wma.30.1637153631243; 
 Wed, 17 Nov 2021 04:53:51 -0800 (PST)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id w4sm8368899wrs.88.2021.11.17.04.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Nov 2021 04:53:50 -0800 (PST)
Date: Wed, 17 Nov 2021 13:53:49 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Bart Van Assche <bvanassche@acm.org>
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
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20211117125224.z36hp2crpj4fwngc@ArmHalley.local>
References: <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
 <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
 <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
 <20211029081447.ativv64dofpqq22m@ArmHalley.local>
 <20211103192700.clqzvvillfnml2nu@mpHalley-2>
 <20211116134324.hbs3tp5proxootd7@ArmHalley.localdomain>
 <ab4ec640-9a89-ea25-fe68-85bae2ae5d8d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab4ec640-9a89-ea25-fe68-85bae2ae5d8d@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_045401_037272_2B8EA44B 
X-CRM114-Status: GOOD (  11.76  )
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

On 16.11.2021 09:59, Bart Van Assche wrote:
>On 11/16/21 05:43, Javier González wrote:
>>             - Here, we need copy emulation to support encryption 
>>without dealing with HW issues and garbage
>
>Hi Javier,
>
>Thanks very much for having taken notes and also for having shared 
>these.

My pleasure. Thanks for attending. Happy to see this moving.

>Regarding the above comment, after the meeting I learned that 
>the above is not correct. Encryption in Android is LBA independent and 
>hence it should be possible to offload F2FS garbage collection in 
>Android once the (UFS) storage controller supports this.
>
>For the general case, I propose to let the dm-crypt driver decide 
>whether or not to offload data copying since that driver knows whether 
>or not data copying can be offloaded.

Thanks for sharing this. We will make sure that DM / MD are supported
and then we can cover examples. Hopefully, you guys can help with the
bits for dm-crypt to make the decision to offload when it make sense.

I will update the notes to keep them alive. Maybe we can have them open
in your github page?

>
>Thanks,
>
>Bart.


