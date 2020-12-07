Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NAME_EMAIL_DIFF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E82EC4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 08:16:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB73F229C6
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 08:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB73F229C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h0i8wCRMPj40mvuIsnl31ZUYVTsqhGx3kgdgXsx19c8=; b=dA+c+Oh1hWJcd4wzxZhthWFWW
	fjyEMDsurs1Gvxks/upvkQqhCPR/8EtYE/rUt6ZAO9W8gilG+eu1eVa4X19Ck83m+MiHdtTbOmUWe
	ncbypdYrQfvgOpPz+A07eIeVDfwu9nbyysahy4SKcx4+SeJejn75iajCkJ8qp74BYCyCWrAPdDoGW
	EYMJ1NuAJvgs5HqQw05lIUvrtJ+D64iwCLYl9zl3pdsYGgVcVr0HKpbPP3RbmC9sCui5FEwuItfSg
	vWoSzb3MnhIeX1tSVAHbvm2azVF4gRS6erGAXan78Y7loAdBbroGKFJQyQWoEQX5oAHNd0aRSS/2g
	2KhY4AXTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmBhE-0000h8-1C; Mon, 07 Dec 2020 08:16:36 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmBhC-0000gb-7g
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 08:16:35 +0000
Received: by mail-ej1-x62c.google.com with SMTP id ce23so14432268ejb.8
 for <linux-nvme@lists.infradead.org>; Mon, 07 Dec 2020 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iYj4pUoj9o5PR+qG7Qn3L1SJKXMPS3+hvYYnqb4yHOw=;
 b=c8bMSHij6AKZgKH+1ByBckieZlo8OFHunwfNP3RwYtvl8jJLycmvKIxOaM4lp7R6Tq
 J77atErU5l67mJKevaaZa/t/IxL7KDMZ+oVGF4ByZgjcBMPGpSjhDufp+mafUCxYHQHC
 sPFSwK8FE75EGl7MdmqRDUtu8wNc6RyyOpGI2Z9EfTCLOX4DkcF1TlrPkfPThRdJkHpF
 LADyRXTKZkRbxnRbIZtZAqhqgPW2NOSTwBqEm5j+vMd8zla2AkVtqu16osBQn2ebKEtE
 hRS17c3Ls9p+CI9OZUI8M11tO35e98qpS75Ye1i3M7TuoWiQt9eYbbooJbgkXQq/0YEy
 42Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iYj4pUoj9o5PR+qG7Qn3L1SJKXMPS3+hvYYnqb4yHOw=;
 b=fezgxMOqhbU1Ehxq9GdNAb9sqCeeghEba4rjIYkijVXc5bRo8aGYqAA6KdMyeorDhp
 lfQkw0orJ10Zqv82UtKuj6BQMD6JKR3sgvGalaCNSgd5MEihmW2zWLpRLTMX8Gewcn8H
 qNuokybDvBi699IOl+tCe1N0nbfaZg4GcA6IHNjM9pgxeDLztXbyeTrN56+H0dVAPXMg
 F1DbP+APXqywQavsPv78wQf+NrZQtjBgWJhlSjRJQaUedNlAWGZdKecC6mC+8zDeTwll
 8e65vBeEaCbXsN+vlLUeIhrzWzIZ9CihWLw4zb8fXrikVeQgEPQ4ngBy6OEGJdXY22op
 mQgw==
X-Gm-Message-State: AOAM530qDG0WlPe4HPrk6gV478lA4ikCh4M4UzGgkawPy6hzCA2GTSTW
 4rMzVs4WN3z9vg8SXY/DjXG0Sg==
X-Google-Smtp-Source: ABdhPJwb4jRV2xylIOGlV+IbqS3THEEk1xv/TWj/PDOLR2zfUPpGUmwka3CjMKimmTAV6Dyou0TXtA==
X-Received: by 2002:a17:906:7b8d:: with SMTP id
 s13mr1630369ejo.479.1607328992695; 
 Mon, 07 Dec 2020 00:16:32 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id n22sm12100137edr.11.2020.12.07.00.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 00:16:32 -0800 (PST)
Date: Mon, 7 Dec 2020 09:16:31 +0100
From: "javier.gonz@samsung.com" <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201207081631.usapwn5jj35c5633@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
 <20201207074616.mocdy6m5qgsn6yqg@mpHalley>
 <CH2PR04MB6522623991D84D67B13DDF66E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CH2PR04MB6522623991D84D67B13DDF66E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_031634_294193_3E0E4FFA 
X-CRM114-Status: GOOD (  23.52  )
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
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 07.12.2020 08:06, Damien Le Moal wrote:
>On 2020/12/07 16:46, javier.gonz@samsung.com wrote:
>> On 04.12.2020 23:40, Keith Busch wrote:
>>> On Fri, Dec 04, 2020 at 11:25:12AM +0000, Damien Le Moal wrote:
>>>> On 2020/12/04 20:02, SelvaKumar S wrote:
>>>>> This patchset tries to add support for TP4065a ("Simple Copy Command"),
>>>>> v2020.05.04 ("Ratified")
>>>>>
>>>>> The Specification can be found in following link.
>>>>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>>>>
>>>>> This is an RFC. Looking forward for any feedbacks or other alternate
>>>>> designs for plumbing simple copy to IO stack.
>>>>>
>>>>> Simple copy command is a copy offloading operation and is  used to copy
>>>>> multiple contiguous ranges (source_ranges) of LBA's to a single destination
>>>>> LBA within the device reducing traffic between host and device.
>>>>>
>>>>> This implementation accepts destination, no of sources and arrays of
>>>>> source ranges from application and attach it as payload to the bio and
>>>>> submits to the device.
>>>>>
>>>>> Following limits are added to queue limits and are exposed in sysfs
>>>>> to userspace
>>>>> 	- *max_copy_sectors* limits the sum of all source_range length
>>>>> 	- *max_copy_nr_ranges* limits the number of source ranges
>>>>> 	- *max_copy_range_sectors* limit the maximum number of sectors
>>>>> 		that can constitute a single source range.
>>>>
>>>> Same comment as before. I think this is a good start, but for this to be really
>>>> useful to users and kernel components alike, this really needs copy emulation
>>>> for drives that do not have a native copy feature, similarly to what write zeros
>>>> handling for instance: if the drive does not have a copy command (simple copy
>>>> for NVMe or XCOPY for scsi), then the block layer should issue read/write
>>>> commands to seamlessly execute the copy. Otherwise, this will only serve a small
>>>> niche for users and will not be optimal for FS and DM drivers that could be
>>>> simplified with a generic block layer copy functionality.
>>>>
>>>> This is my 10 cents though, others may differ about this.
>>>
>>> Yes, I agree that copy emulation support should be included with the
>>> hardware enabled solution.
>>
>> Keith, Damien,
>>
>> Can we do the block layer emulation with this patchset and then work in
>> follow-up patchses on (i) the FS interface with F2FS as a first user and
>> (ii) other HW accelerations such as XCOPY?
>
>The initial patchset supporting NVMe simple copy and emulation copy, all under
>an API that probably will be similar that of dm-kcopyd will cover all block
>devices. Other hardware native support for copy functions such as scsi extended
>copy can be added later under the hood without any API changes (or minimal changes).

Sounds good. That we can do. We will add a new patch for this.

>
>I am not sure what you mean by "FS interface for F2FS": the block layer API for
>this copy functionality will be what F2FS (and other FSes) will call. That is
>the interface, no ?

Essentially yes.. I mean adding the F2FS logic and potentially some
helpers to the block layer to aid GC.

>
>> For XCOPY, I believe we need to have a separate discussion as much works
>> is already done that we should align to.
>
>I think Martin (added to this thread) and others have looked into it but I do
>not think that anything made it into the kernel yet.

Exactly. Looking at some of the code posted through time and recalling
the discussions at LSF/MM, seems like there are a number of things we
are not addressing here that could be incorporated down the road, such
as dedicated syscalls / extensions, multi namespace / device support,
etc.
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
