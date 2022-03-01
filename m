Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9B7C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HRcRFvy++Q3Piv5ZfPltHWqWAbRAyHKwh36CLVMrb1I=; b=YCEZS6/dEKGNI7NrPRb4qdK5x4
	zk4qX1xMljoetG8l98ZSouzD+x+xMHPpK3DG3sMyPhe7c8UZH8ueH2NxlJxAoJvt7ZzN48Zir+AGJ
	6fVzO9DfJc0nl04u/9Hd8++Dm39yKHl3PPKszsgNOP3AzBDYa/ydoZCEoBkUAFaYza1/L9+3kT3M7
	nEsN8oan1UvbkyAJk1GcDX6jO+ymwQBcBL5jYpHPhymHXMZVNU8bqrfN5XerxNNU/hoaGPz4w6pFb
	+vQMpp6D/paQdnzN19QoiZJ+y82pNvs3s3oHnmv0osnC9rQNLFfdC9FizmPWRMus7Tx1opdrZ+3hN
	vz1dZoWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nP6O5-0004iG-49; Tue, 01 Mar 2022 17:34:13 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nP6O1-0004hQ-Nl
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 17:34:12 +0000
Received: by mail-wr1-x429.google.com with SMTP id n14so21640330wrq.7
 for <linux-nvme@lists.infradead.org>; Tue, 01 Mar 2022 09:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrikto-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:cc:in-reply-to:content-transfer-encoding;
 bh=HRcRFvy++Q3Piv5ZfPltHWqWAbRAyHKwh36CLVMrb1I=;
 b=HL2I3v37Av+6sAAhm/KydOCOeccWwSHARXzsBuC8BvBy9ppJyE+Om3QO8sfAXF8o6X
 Vyu1gTQzSWQ/Qk2Wb73+iZUbGTeikXFPB0ydHYKlHZ8iCMmElRsvnqiK5UxxLcr+mFE1
 mBfJrK98OAqqAPwXWYAR+p9uByZluzlHuqCPEZKqd+oIocC77Q68/VSdchXbTSSLw6Um
 DKlWYDjuoO9glGjBf/gSLCZ2OJlb6I4OyT591FXiLxPP9TVSHHcqqjpIrzp+2WFLSSpM
 lPkxOjLCBQOwfTZfprgSKJxRLzmY3Z45gWR4656p2gz6oB9ECQoc9JYoqmxlWOEmpC0/
 2oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:cc:in-reply-to
 :content-transfer-encoding;
 bh=HRcRFvy++Q3Piv5ZfPltHWqWAbRAyHKwh36CLVMrb1I=;
 b=U8M0LQl9aq4tPj5MKFx0ktLoLob8eKb8X6bZd9aqnJgXuvsPxnUG7etJke+Xs5KJxm
 EV1tboYfthGsLaRxjNhZFQAnBn/jie2zYtWmpgypLJEUygKXPmx6iUjOwWBMPBNlWcN8
 EbQyGyQTGnogF41zBzTWLGWJWpeq3Vz/hTpfpXgS5udO2am1cg7m9eS5ucB9C7ZdTCI5
 vgTHcVhqglyTvGdl+J9qs1REScrjoTOtnaQhvGbkEgL5CW1M0mVTbxMs66UpruWqXzHx
 kYRawgGcAkWwNDvpzhNhk4HVC5aEolcCVEJcObxBpENTot2t8p+iTtjTlRafkJOG9opn
 I2Tg==
X-Gm-Message-State: AOAM530znnIPgltbz1kcjZnXMGD2SX8LFI4hKA6GCaXcrBCV4p7irBbo
 fXRNe/HvjMzGKs6EWvLE308A3Q==
X-Google-Smtp-Source: ABdhPJz1KWOXWra6qqnrHTp/mlPHD+rOsVc+YUyeNDnkKNREvDPGkc0KCPIzIBLmoNUkcLneybWLcQ==
X-Received: by 2002:a5d:544d:0:b0:1ee:880d:3391 with SMTP id
 w13-20020a5d544d000000b001ee880d3391mr19032471wrv.72.1646156045618; 
 Tue, 01 Mar 2022 09:34:05 -0800 (PST)
Received: from [172.16.10.50] (193.92.178.96.dsl.dyn.forthnet.gr.
 [193.92.178.96]) by smtp.gmail.com with ESMTPSA id
 c15-20020a5d4ccf000000b001ed9e66781fsm14522344wrt.13.2022.03.01.09.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 09:34:04 -0800 (PST)
Message-ID: <012723a9-2e9c-c638-4944-fa560e1b0df0@arrikto.com>
Date: Tue, 1 Mar 2022 19:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
From: Nikos Tsironis <ntsironis@arrikto.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, "roland@purestorage.com"
 <roland@purestorage.com>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
 Hannes Reinecke <hare@suse.de>, "kbus >> Keith Busch" <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
 "dsterba@suse.com" <dsterba@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
 "jack@suse.com" <jack@suse.com>
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220301_093409_864721_3DE9BB95 
X-CRM114-Status: GOOD (  33.22  )
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

On 1/27/22 09:14, Chaitanya Kulkarni wrote:
> Hi,
> 
> * Background :-
> -----------------------------------------------------------------------
> 
> Copy offload is a feature that allows file-systems or storage devices
> to be instructed to copy files/logical blocks without requiring
> involvement of the local CPU.
> 
> With reference to the RISC-V summit keynote [1] single threaded
> performance is limiting due to Denard scaling and multi-threaded
> performance is slowing down due Moore's law limitations. With the rise
> of SNIA Computation Technical Storage Working Group (TWG) [2],
> offloading computations to the device or over the fabrics is becoming
> popular as there are several solutions available [2]. One of the common
> operation which is popular in the kernel and is not merged yet is Copy
> offload over the fabrics or on to the device.
> 
> * Problem :-
> -----------------------------------------------------------------------
> 
> The original work which is done by Martin is present here [3]. The
> latest work which is posted by Mikulas [4] is not merged yet. These two
> approaches are totally different from each other. Several storage
> vendors discourage mixing copy offload requests with regular READ/WRITE
> I/O. Also, the fact that the operation fails if a copy request ever
> needs to be split as it traverses the stack it has the unfortunate
> side-effect of preventing copy offload from working in pretty much
> every common deployment configuration out there.
> 
> * Current state of the work :-
> -----------------------------------------------------------------------
> 
> With [3] being hard to handle arbitrary DM/MD stacking without
> splitting the command in two, one for copying IN and one for copying
> OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> candidate. Also, with [4] there is an unresolved problem with the
> two-command approach about how to handle changes to the DM layout
> between an IN and OUT operations.
> 
> We have conducted a call with interested people late last year since
> lack of LSFMMM and we would like to share the details with broader
> community members.
> 
> * Why Linux Kernel Storage System needs Copy Offload support now ?
> -----------------------------------------------------------------------
> 
> With the rise of the SNIA Computational Storage TWG and solutions [2],
> existing SCSI XCopy support in the protocol, recent advancement in the
> Linux Kernel File System for Zoned devices (Zonefs [5]), Peer to Peer
> DMA support in the Linux Kernel mainly for NVMe devices [7] and
> eventually NVMe Devices and subsystem (NVMe PCIe/NVMeOF) will benefit
> from Copy offload operation.
> 
> With this background we have significant number of use-cases which are
> strong candidates waiting for outstanding Linux Kernel Block Layer Copy
> Offload support, so that Linux Kernel Storage subsystem can to address
> previously mentioned problems [1] and allow efficient offloading of the
> data related operations. (Such as move/copy etc.)
> 
> For reference following is the list of the use-cases/candidates waiting
> for Copy Offload support :-
> 
> 1. SCSI-attached storage arrays.
> 2. Stacking drivers supporting XCopy DM/MD.
> 3. Computational Storage solutions.
> 7. File systems :- Local, NFS and Zonefs.
> 4. Block devices :- Distributed, local, and Zoned devices.
> 5. Peer to Peer DMA support solutions.
> 6. Potentially NVMe subsystem both NVMe PCIe and NVMeOF.
> 
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
> 
> I'd like to propose a session to go over this topic to understand :-
> 
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?
> 
> * Required Participants :-
> -----------------------------------------------------------------------
> 
> I'd like to invite file system, block layer, and device drivers
> developers to:-
> 
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with [4].
> 3. Uncover additional details that are missing from this proposal.
> 
> Required attendees :-
> 
> Martin K. Petersen
> Jens Axboe
> Christoph Hellwig
> Bart Van Assche
> Zach Brown
> Roland Dreier
> Ric Wheeler
> Trond Myklebust
> Mike Snitzer
> Keith Busch
> Sagi Grimberg
> Hannes Reinecke
> Frederick Knight
> Mikulas Patocka
> Keith Busch
> 
> -ck
> 
> [1]https://content.riscv.org/wp-content/uploads/2018/12/A-New-Golden-Age-for-Computer-Architecture-History-Challenges-and-Opportunities-David-Patterson-.pdf
> [2] https://www.snia.org/computational
> https://www.napatech.com/support/resources/solution-descriptions/napatech-smartnic-solution-for-hardware-offload/
>         https://www.eideticom.com/products.html
> https://www.xilinx.com/applications/data-center/computational-storage.html
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git xcopy
> [4] https://www.spinics.net/lists/linux-block/msg00599.html
> [5] https://lwn.net/Articles/793585/
> [6] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
> namespaces-zns-as-go-to-industry-technology/
> [7] https://github.com/sbates130272/linux-p2pmem
> [8] https://kernel.dk/io_uring.pdf

I would like to participate in the discussion too.

The dm-clone target would also benefit from copy offload, as it heavily
employs dm-kcopyd. I have been exploring redesigning kcopyd in order to
achieve increased IOPS in dm-clone and dm-snapshot for small copies over
NVMe devices, but copy offload sounds even more promising, especially
for larger copies happening in the background (as is the case with
dm-clone's background hydration).

Thanks,
Nikos

