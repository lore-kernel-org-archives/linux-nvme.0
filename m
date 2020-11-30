Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A68AC63777
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 18:51:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F4020725
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 18:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DbK8qj3z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lA21FFs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F4020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L3SnTziNRPOH/ErA9Z60gVSWLu4O6cL210rcCA3zIUY=; b=DbK8qj3z37P9m+qTu/CNKy/mO
	wF2bei+hfsEYmcdJLWxgXO/QU0TO/UMqHLqIN0VpSOXVrvjlO7xlpdLRkh4oWduqZcJm2DaO5anEo
	MPFFiMwLu5dZEhl9Yq9N8vnTmCQncg/TG65npr5sSVWLzsc6jcyYSMSY3r7YPhKPDeaLaW/lbnL1H
	R9EzpZDUYFBcJG7aEv+WYxB58LMMpd8sUtMvot/Djtpv6ZJTAFDZn/Gu/6oBvXPe0Gqp0fd7O1Zma
	89uWoHEn83Vn5yIGpG37VoivSqs/149RF0avvn1W6Q7Kvb46DvPLSbGhFY15mLJY7lZZw0ujA+aPW
	yN8zzKlCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjoGG-0005q8-NB; Mon, 30 Nov 2020 18:50:56 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjoGE-0005pP-G1
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 18:50:55 +0000
Received: by mail-pg1-x543.google.com with SMTP id s63so10614248pgc.8
 for <linux-nvme@lists.infradead.org>; Mon, 30 Nov 2020 10:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HDV2ZTfnWFj2I1nMXs/QUKPdkXN+jw+xT8fcFlUSOVc=;
 b=lA21FFs7fsI60sDfvj2gxU+FgPkbHvr1U9a3ONx/671C/3d/nKlJpnVk7IAlanZc2m
 bwPmQnaTZX8tMGvHfKP1xSW0Nh1Er7MBelMPy9IB6NBnT4751YJQGutD4EqQmb4syZbd
 CDFMa9xO18awbJw3S9r4cJsdGc1cP1OYBhZbjYphsxKLZ2+jRa6Ljlf80LB+1c8cpYMY
 /tQxq/5EHr5/gGEX0FRYxIcVqbuvP1bp3ACYlmY5FiorxuFPC4xB8u37h/ZBxd/VJhkj
 g/mywk0m80gfxjHgQikUFr9IlQUXoR1Xz1hAghWecDLYfn2TB11eD5PA+U9vrdMV0XxK
 mdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HDV2ZTfnWFj2I1nMXs/QUKPdkXN+jw+xT8fcFlUSOVc=;
 b=drEIyDfKuW0FaBpVu/WYX1rZxa6iSbJdbFi9FYtiz0RWuLdiQVDrmjclmX+Mptcj5R
 FsHB3QFkw/hHpd8E7pOGILsBCKDHdTGBV6lpkdNfQ4l7d8jodXvc8dzdYMFNNWf0j/eX
 RNS066G8hktai627sWD94bL80jMl5HcLtIJJMQ/78BERRG1W6GOk6b+xM1ntvw6JFW0z
 iuD+DgMAk0ZVnmv7xHDvdoyabEQP82FPPd6dV7GZ7r8eMgoGc2i0lx7g5S6qcvPNfew5
 St2fN3ci6wLqjAvSer/J8T3/5P+FyzVkbcIe82mU1xYpbCgGQ6UmiB2BR8BZ8AdJBoP6
 YaMg==
X-Gm-Message-State: AOAM531xVJPvalLi/MSBa/y9WmEgmrv4vYGOUCcU+Q15utki60R35aaw
 95IP4KyAumHO3uaxtIqEkgCz6Q==
X-Google-Smtp-Source: ABdhPJwUbDjA9NQJXB5RYWAa+yeaMEvTqE2F9OISOPnqBFBf5Ppt4TbB/5X+E3Sfhk8mMDOYCPFfww==
X-Received: by 2002:a62:1c93:0:b029:198:1c0a:ea71 with SMTP id
 c141-20020a621c930000b02901981c0aea71mr20104155pfc.22.1606762250026; 
 Mon, 30 Nov 2020 10:50:50 -0800 (PST)
Received: from google.com ([2620:0:1008:11:7220:84ff:fe09:dc21])
 by smtp.gmail.com with ESMTPSA id a6sm9159555pfo.194.2020.11.30.10.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 10:50:49 -0800 (PST)
Date: Mon, 30 Nov 2020 10:50:45 -0800
From: Tom Roeder <tmroeder@google.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201130185045.GA744128@google.com>
References: <20201120012738.2953282-1-tmroeder@google.com>
 <20201120080243.GA20463@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120080243.GA20463@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_135054_620492_078DF321 
X-CRM114-Status: GOOD (  21.25  )
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
Cc: Thomas.Lendacky@amd.com, Sagi Grimberg <sagi@grimberg.me>,
 David.Kaplan@amd.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Marios Pomonis <pomonis@google.com>,
 Jens Axboe <axboe@fb.com>, Peter Gonda <pgonda@google.com>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
>On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
>> This patch changes the NVMe PCI implementation to cache host_mem_descs
>> in non-DMA memory instead of depending on descriptors stored in DMA
>> memory. This change is needed under the malicious-hypervisor threat
>> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
>> guest memory to make it unreadable. Some versions of these architectures
>> also make it cryptographically hard to modify guest memory without
>> detection.
>
>I don't think this is a useful threat model, and I've not seen a
>discussion on lkml where we had any discussion on this kind of threat
>model either.

Thanks for the feedback and apologies for the lack of context.

I was under the impression that support for AMD SEV SNP will start 
showing up in KVM soon, and my understanding of SNP is that it 
implies this threat model for the guest. See the patchset 
for SEV-ES, which is the generation before SNP: 
https://lkml.org/lkml/2020/9/14/1168. This doesn't get quite to the SNP 
threat model, but it starts to assume more maliciousness on the part of 
the hypervisor.

You can also see the talk from David Kaplan of AMD from the 2019 Linux 
Security Summit for info about SNP: 
https://www.youtube.com/watch?v=yr56SaJ_0QI.

>
>Before you start sending patches that regress optimizations in various
>drivers (and there will be lots with this model) we need to have a
>broader discussion first.

I've added Tom Lendacky and David Kaplan from AMD on the thread now, 
since I don't think I have enough context to say where this discussion 
should take place or the degree to which they think it has or hasn't.

Tom, David: can you please comment on this?

>
>And HMB support, which is for low-end consumer devices that are usually
>not directly assigned to VMs aren't a good starting point for this.

I'm glad to hear that this case doesn't apply directly to cases we would 
care about for assignment to guests. I'm not very familiar with this 
codebase, unfortunately. Do the same kinds of issues apply for the kinds 
of devices that would be assigned to guests?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
