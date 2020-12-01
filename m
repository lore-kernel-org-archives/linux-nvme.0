Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NAME_EMAIL_DIFF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F34C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:20:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BA620663
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="miCGQZ8H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ZarehDfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BA620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=46eKyyF3EId+IKUGvoSsu51jW2tJB46k7ebSignDG4k=; b=miCGQZ8HWSzmouJzZFZady8Q8
	l+tu1P+wq0IOe7+SFUHfHM6e5PrIxpq2JyG6at1EEchQbCPmWLJWHuiy3glnKd3nDT/ttJFAE03R0
	tqm2zX0PBQsUqr86Dgjcu0CgXd1UxgKeQLPCT5VFGxG2ZeB8HIRhXiNxkj6Myl3VuYu8IiLfGuQOp
	a8p8JnhgCyzfC9Q08fuLQ/NPp4ig9jeWzsylJz4mw4ko71fGurVXgtegxGJ89qMsYXgg6KD4aetns
	bWuxH/gM38tFI6tEET6My7IPVjsRp/Gm/wFF5ErwkgKqs+SQz72JBYQPBytvNI9phw28YuCQSfP9e
	RRJipEThg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk4eI-0008LV-Pa; Tue, 01 Dec 2020 12:20:50 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk4eF-0008KP-BF
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 12:20:49 +0000
Received: by mail-ej1-x644.google.com with SMTP id 7so3731885ejm.0
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Fylyeg8K1HpI44gu+W/L892Ds6J+IK7AhpMNFOVv+J4=;
 b=ZarehDfLGLuZIgZ9KVRUc8zhWI+nVIaXbdHqpn+5I5NYAxT6Y9Fx3RG+PF5/sJKVHQ
 SXLIiN8zMhVi/mTH4sk08wMbADvUUj8Bs0Cwk88y7NH3bofWHvMh/qYT94Cfg1HbJbwG
 dI69UONK53SWeHXM9AkmrdGVASkP32SdJuq5R4U9xv0KDxjolW3G8xZMkUMbKnYb6aQe
 uLDickDX31cWCyYHdfGziOYdT3qKhuDcr7u2b+Pzc2qI394qvCnJqQDPWlEEfsOSmSEt
 L/4X9+ow3z00vG8RwWqoiAk24MipdSh/VntaxXj7b/1Y66bCnb6rA1bukhYkVOpOPV7d
 P2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Fylyeg8K1HpI44gu+W/L892Ds6J+IK7AhpMNFOVv+J4=;
 b=Ws70AdT6Eh8wLTYaw2mmszQ8tuKzptM54zBDa0I/iME+D6eiQ5QF+WPCt8AcWGl6HI
 /TI6pCOV1OJZ7fpPKWUaR2LUWbbVSxUW85xgZwZHXUZ7fd8akVYXYjKSKPM1JjJpl1yU
 2GrSKRkEjjYEal+DgMoGhxsxqV9f/WwwWj/bQ9xRcX1Oymm47fuzS1MYtlPpHeeQ4bE8
 zbUfJQ7k0/BmhbC2o9rQh2VCBXJ0XgyrGlIi+fmXQdg9Pf0RVKX63hc1AK0C5jVJ0mfl
 CG+mZOta95WdHBo/Rih31hMsGj/dRYu5K4xD8aNaZg2t7MnD+Q9nzbJTMXav+VNoAmak
 CpTA==
X-Gm-Message-State: AOAM533I/LNU1IMBJrqC1k0BnfEDomgsXD9snzw7W4Qt/AwCTTVy+dt4
 hXDdOS6ea8s4eOL3ubhko2lI0g==
X-Google-Smtp-Source: ABdhPJyA6bpW98mfTIiD5151P4PptIAHrybHgwuhzzmuU72gxHomFLdeJrIMEsjvEi8IuWtDJ6C0aA==
X-Received: by 2002:a17:907:d1f:: with SMTP id
 gn31mr2862738ejc.192.1606825244314; 
 Tue, 01 Dec 2020 04:20:44 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id d6sm746777ejy.114.2020.12.01.04.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 04:20:43 -0800 (PST)
From: "javier.gonz@samsung.com" <javier@javigon.com>
X-Google-Original-From: "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Date: Tue, 1 Dec 2020 13:20:42 +0100
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH 0/2] add simple copy support
Message-ID: <20201201122042.xvkdtyjuhb76nntp@MacBook-Pro.localdomain>
References: <CGME20201201054049epcas5p2e0118abda14aaf8d8bdcfb543bc330fc@epcas5p2.samsung.com>
 <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CH2PR04MB652240A4A23F89B26118FD66E7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CH2PR04MB652240A4A23F89B26118FD66E7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_072047_488553_98345E9B 
X-CRM114-Status: GOOD (  21.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>, Mike Snitzer <snitzer@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 01.12.2020 11:22, Damien Le Moal wrote:
>+ Mike and DM list
>
>On 2020/12/01 16:12, SelvaKumar S wrote:
>> This patchset tries to add support for TP4065a ("Simple Copy Command"),
>> v2020.05.04 ("Ratified")
>>
>> The Specification can be found in following link.
>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>
>> This is an RFC. Looking forward for any feedbacks or other alternate
>> designs for plumbing simple copy to IO stack.
>>
>> Simple copy command is a copy offloading operation and is  used to copy
>> multiple contiguous ranges (source_ranges) of LBA's to a single destination
>> LBA within the device reducing traffic between host and device.
>>
>> This implementation accepts destination, no of sources and arrays of
>> source ranges from application and attach it as payload to the bio and
>> submits to the device.
>>
>> Following limits are added to queue limits and are exposed in sysfs
>> to userspace
>> 	- *max_copy_sectors* limits the sum of all source_range length
>> 	- *max_copy_nr_ranges* limits the number of source ranges
>> 	- *max_copy_range_sectors* limit the maximum number of sectors
>> 		that can constitute a single source range.
>
>This is interesting. I think there are several possible use in the kernel in
>various components: FS (btrfs rebalance, f2fs GC, liklely others) and DM at the
>very least.

Totally agree. We have more patches for simple copy, among others work
on F2FS that leverages for GC. We wanted to start with a simple patchset
enabling IOCTL to be an easy to review start. The rest of the patches
will come.


>However, your patches add support only for NVMe devices that have native support
>for simple copy, leaving all other block devices out. That seriously limits the
>use cases and also does not make this solution attractive since any use of it
>would need to be conditional on the underlying drive capabilities. That means
>more code for the file systems or device mapper developers and maintainers, not
>less.

Makes sense.

>
>To avoid this, I would suggest that this code be extended to add emulation for
>drives that do not implement simple copy natively. This would allow this
>interface to work on any block device, including SAS & SATA HDDs and RAID arrays.
>
>The emulation part of this copy service could I think be based on dm-kcopyd. See
>include/linux/dm-kcopyd.h for the interface. The current dm-kcopyd interface
>takes one source and multiple destination, the reverse of simple copy. But it
>would be fairly straightforward to also allow multiple sources and one
>destination. Simple copy native support would accelerate this case, everything
>else using the regular BIO read+write interface. Moving dm-kcopyd from DM
>infrastructure into the block layer as a set a generic block device sector copy
>service would allow its use in more places. And SCSI XCOPY could also be
>integrated in there as a different drive native support command.

Let us look into this. It makes sense.

It seems fair to start support bottom up from NVMe and then extend to
block layer and F2FS (potentially others). At this stage, we were
assuming that all the work that people like Martin, Bart and other have
been doing through the years on XCOPY could be integrated. Emulation can
be a part of this.

How can we move forward to do this in stages?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
