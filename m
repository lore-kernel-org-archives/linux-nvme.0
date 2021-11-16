Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08BDC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 17:59:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2053613A2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 17:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2053613A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HMNPM/fgk1MNRXov4s8Yb+E4mhC1XJHGgm4p3VUdnQM=; b=XUO41mQoVUQ4yOD1gxag2YE0L1
	8lK0XkGK816kss9Zvy+tw4pPoroyw4iTeDlwlhmhNBVhwpYZjQyAJ/m+AvoYHeA46ruFgIB85XQdD
	7liEyxjX+3Vwup1naS6AnvxRK8JS22xvRyH1198jKKxcAtndFaTvSrANJZlEvk7OGV+dJcACboUEu
	MFt5gpU8MEGQJ9FDCdnO7u7fLAxmRTuAgTomIyWj5ILqfjpVAVE+99yvH0pDT7nBw8Jl7U3SDmsno
	O6+kj8iR7+B782Vhx4oiACaxQ8AHskGkHzJnKUDIyanAQE4mUk+nwlRhfuGC2eGv3hxSvhPXQzxld
	m8zNwSIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn2kC-002Vtc-Ho; Tue, 16 Nov 2021 17:59:44 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn2k9-002Vsr-BT
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 17:59:42 +0000
Received: by mail-pg1-f169.google.com with SMTP id 136so13676656pgc.0
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 09:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HMNPM/fgk1MNRXov4s8Yb+E4mhC1XJHGgm4p3VUdnQM=;
 b=kpM1YIo7fkM+xbuVCQn251/5yqT/etJbbLyJL0ePXiYE8PqwbPPoY2QQ7N2Uvp8IO+
 /39Ud97M5GKvbElW2/Rm9ngk3OLI7lF+ZHB7JrnzBuTTM+vfISSZrvB9QzaWSGQS/qa1
 Im268zltdf/vJRKMlmnzbSV7rgg9zvUkiZYz/C6q8rkPzU9UBMHwbQ1Z7W3QhfnN/ogG
 VgiMvH+16CxAv6My2fNO4pEdx/HKpLH2brGBOVQgZSEXsps9dACEA19CUa4cGl2Df8Vz
 l4Nv152asno52N2UT45OtUSUTXJKKUBHi4Wka64Gk86A1Rq9TSlOa53aE5kt8ObmTDzP
 SSLg==
X-Gm-Message-State: AOAM530H51qEKclgRf0LO/PVZ4d44qU0NGW5AyD1AMsrwhNBQse6KCdl
 p9Lv4MrspVV1W9fnZiiZ7UI=
X-Google-Smtp-Source: ABdhPJzQD9bdY0VMmDxiCswmvq2I7y2fm9Zu6J87Vg5yOKJcwCnM9HD6kc+dZh6uUa9ezmqsxHqBag==
X-Received: by 2002:a63:b241:: with SMTP id t1mr604217pgo.154.1637085580607;
 Tue, 16 Nov 2021 09:59:40 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id v16sm15096386pgo.71.2021.11.16.09.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 09:59:39 -0800 (PST)
Message-ID: <ab4ec640-9a89-ea25-fe68-85bae2ae5d8d@acm.org>
Date: Tue, 16 Nov 2021 09:59:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211116134324.hbs3tp5proxootd7@ArmHalley.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_095941_417649_3B8FD441 
X-CRM114-Status: UNSURE (   9.43  )
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

On 11/16/21 05:43, Javier González wrote:
>              - Here, we need copy emulation to support encryption 
> without dealing with HW issues and garbage

Hi Javier,

Thanks very much for having taken notes and also for having shared 
these. Regarding the above comment, after the meeting I learned that the 
above is not correct. Encryption in Android is LBA independent and hence 
it should be possible to offload F2FS garbage collection in Android once 
the (UFS) storage controller supports this.

For the general case, I propose to let the dm-crypt driver decide 
whether or not to offload data copying since that driver knows whether 
or not data copying can be offloaded.

Thanks,

Bart.

