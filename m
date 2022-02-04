Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC84BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+AJzw4pLVP6piQQ8DJ6FcW2rv83/BHBjZGX/F+I/5C4=; b=bQI4wHIh69pUKRA/1x2aF4uOqG
	hMmCbyCKcci0iApHOg4TaxtsWGtbN+y6eEU88ZJ5NlCrAFYkdnwuzZi5n5v3ExwVkVDPXDdNpI4Gh
	tUfOobf+keHykmVUiUO/NkNYCaVENZzBFOwgJx26fkPGttFEYkSDqLFHPvFlHyF0sgKFjqYr59dDV
	nqRHDPV+Bo0TMidM9PqPhjSLrkO94W0quO4+biKsHCLk13PxJ7S+gbCKdlVI85PewXkFS+/Ke61j4
	TLwGd4lVZvaqFMMIlYRcS3mOLvi207vr6619stHB3g7XBxTs5VNjwSNmcyOmVChp+N4SYxGDvwnvm
	+p0r2+Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFttn-003ltq-Qm; Fri, 04 Feb 2022 08:24:55 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFtth-003lnI-DC
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 08:24:51 +0000
Received: by mail-ej1-x62c.google.com with SMTP id m4so17051501ejb.9
 for <linux-nvme@lists.infradead.org>; Fri, 04 Feb 2022 00:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+AJzw4pLVP6piQQ8DJ6FcW2rv83/BHBjZGX/F+I/5C4=;
 b=Be5ov5gRTokjg21xyNf+ohGtnsQqDmD5CpogVJAXrnVz7pcHBReU3EKuZVtKt4Tw/w
 RDcn4+ueTA4m3ociZUooQ/VSUz3b9a58vjo7nJ/Hli8DSbbZtEPUvDVwZH40LA/ByK1h
 mkWQHDVpTChQTI+dNdwTriPMcFCGtP4xz0vuE6s8JoGHah/8CmMO+m7uOrLICrWvo7I0
 G0FCSCS1JRJJr87Ow3i8npF6I4zG3xBdyz0bittGNIKmc8CnFGCEP83qtpr4iUUrGgFK
 skH8Hp0XEyEDf/nOhXwfNesNPqOB1Pp2msfiVJJq4EnftBMldbpnYneRb8cxXlSx8a/P
 UWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+AJzw4pLVP6piQQ8DJ6FcW2rv83/BHBjZGX/F+I/5C4=;
 b=QaTaXy0IlQ+ngtcXIQkDdxiYVs6Nxnd+aVd1X6lZK1iGt6phF6bLo1Vp28BgRG9sju
 wuPJRr02wXIrJ84m6bdOMHcraJvkSeCdYbsFBhgWKe7IGhHxGAXu6FeaDHFQQf7h4/Fn
 +JeSfHtCxMuYrJk6os0yrl2fDyjNxJ1Eafbb/fpD1odaRVEPEUoMRHDYr6goAijYHuLG
 DrM4jBf+g2bKLEajTWntxGA7r2k2VKuRKMArBD44iAz3d0D9yNY65Wf2tZ3Lg0By2+Fq
 bKBMtP9cD62v8o57QIN/OcxJm8uMI/t52aIDOCrnG9tpeVlzooE1yQHciERqgz6bpSBL
 3bKg==
X-Gm-Message-State: AOAM533s8OlAIQIjn4hZrQYNLDRJ8xbajsULVjs2wSUdbDTc3TUedBLn
 hm9fnngiyVTPLUNmcfW1sSt6wQ==
X-Google-Smtp-Source: ABdhPJyAfQjC4kR5eZYldFqWF50m/eUAUll5gwN5OdXOAvaJGO24XxVigDE5qacG6WGLefG1r9JSCg==
X-Received: by 2002:a17:906:9b8e:: with SMTP id
 dd14mr1449134ejc.6.1643963086917; 
 Fri, 04 Feb 2022 00:24:46 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
 by smtp.gmail.com with ESMTPSA id u3sm409447ejz.99.2022.02.04.00.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Feb 2022 00:24:46 -0800 (PST)
Date: Fri, 4 Feb 2022 09:24:45 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <20220204082445.hczdiy2uhxfi3x2g@ArmHalley.local>
References: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
 <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
 <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
 <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220204_002449_669851_F0BDE2DB 
X-CRM114-Status: GOOD (  25.04  )
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

On 04.02.2022 07:58, Chaitanya Kulkarni wrote:
>On 2/3/22 22:28, Damien Le Moal wrote:
>> On 2/4/22 12:12, Chaitanya Kulkarni wrote:
>>>
>>>>>> One can instantiate scsi devices with qemu by using fake scsi devices,
>>>>>> but one can also just use scsi_debug to do the same. I see both efforts
>>>>>> as desirable, so long as someone mantains this.
>>>>>>
>>>
>>> Why do you think both efforts are desirable ?
>>
>> When testing code using the functionality, it is far easier to get said
>> functionality doing a simple "modprobe" rather than having to setup a
>> VM. C.f. running blktests or fstests.
>>
>
>agree on simplicity but then why do we have QEMU implementations for
>the NVMe features (e.g. ZNS, NVMe Simple Copy) ? we can just build
>memoery backed NVMeOF test target for NVMe controller features.
>
>Also, recognizing the simplicity I proposed initially NVMe ZNS
>fabrics based emulation over QEMU (I think I still have initial state
>machine implementation code for ZNS somewhere), those were "nacked" for
>the right reason, since we've decided go with QEMU and use that as a
>primary platform for testing, so I failed to understand what has
>changed.. since given that QEMU already supports NVMe simple copy ...

I was not part of this conversation, but as I see it each approach give
a benefit. QEMU is fantastic for compliance testing and I am not sure
you get the same level of command analysis anywhere else; at least not
without writing dedicated code for this in a target.

This said, when we want to test for race conditions, QEMU is very slow.
For a software-only solution, we have experimented with something
similar to the nvme-debug code tha Mikulas is proposing. Adam pointed to
the nvme-loop target as an alternative and this seems to work pretty
nicely. I do not believe there should be many changes to support copy
offload using this.

So in my view having both is not replication and it gives more
flexibility for validation, which I believe it is always good.

>
>> So personally, I also think it would be great to have a kernel-based
>> emulation of copy offload. And that should be very easy to implement
>> with the fabric code. Then loopback onto a nullblk device and you get a
>> quick and easy to setup copy-offload device that can even be of the ZNS
>> variant if you want since nullblk supports zones.
>>
>
>One can do that with creating null_blk based NVMeOF target namespace,
>no need to emulate simple copy memory backed code in the fabrics
>with nvme-loop.. it is as simple as inserting module and configuring
>ns with nvmetcli once we have finalized the solution for copy offload.
>If you remember, I already have patches for that...
>
>>>
>>> NVMe ZNS QEMU implementation proved to be perfect and works just
>>> fine for testing, copy offload is not an exception.
>>>
>>>>>> For instance, blktests uses scsi_debug for simplicity.
>>>>>>
>>>>>> In the end you decide what you want to use.
>>>>>
>>>>> Can we use the nvme-loop target instead?
>>>>
>>>> I am advocating for this approach as well. It presentas a virtual nvme
>>>> controller already.
>>>>
>>>
>>> It does that assuming underlying block device such as null_blk or
>>> QEMU implementation supports required features not to bloat the the
>>> NVMeOF target.
>>>
>>> -ck
>>>
>
>-ck
>

