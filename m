Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6B1D5D67A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCnx04qdk6zMZ0LIRHX3e1wxnrAQ1/h0DrPbQAd66Xs=; b=Sed/d4+BjJCAsQ7T8sYEjVoUpz
	zJq5JRUHUUZ4oZDKrNyVYLfmNayShiGeyDY+YDdfDivE6zNTHb/ovIXpeJUAbn1le9zZGbtvbwGHE
	pxu84ZE1pmfntRDLgkzX7U5kBF1g5lduA62E5JpYkWR0Ey+iEelHEvfvXAnnAGeUlKvzsZUbx4F5j
	FSPcFJ2X2x96TPqd15MxfmNQ/QV5u0y7/7FwZcxValolnzHdRC40IVmpAdsbeEzP0VtnLx1zlbolg
	v5ezi4okV+IeO2d87zHljTBvuStKRrOJZCq1FtkZxzKp7EPymCtYb5stqm07K4wgR+81zkGsIpACl
	wcuBQmrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t96LB-00000007oeP-34D5;
	Thu, 07 Nov 2024 17:30:41 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t96L9-00000007odF-0FM6
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 17:30:40 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso177146466b.3
        for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731000637; x=1731605437; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCnx04qdk6zMZ0LIRHX3e1wxnrAQ1/h0DrPbQAd66Xs=;
        b=HsEEoNL39k9yQMSbb0sQ/mGjxaL6IVaj5PvDUcDo620Ql7GQgVvyCBEq8+4mqyL36l
         gIhoPhBWJBV0xhLVvFaLfMrZPFm2kK4JSyrNmqv7wCQGnOgcfWV0/MBR9qxGSrjZCsfh
         ayLC87SJX3G1+Wvt7i44Y0CnDCxGRMW8YTAvfqgwJufgnRvt+3Ugv1jPJK4aPxO5y/4D
         3DUTDC6Tap6qPI1sH6sD7TGk84jk4SoVA8OexjISmJjH/8iiAgkeNYzbob7V3pQUD8Ft
         cQ6OA4SgNr0hf7tqkwe1haW9H3s/jmWvh7gXljq4+vhgar28i5KZyITpxtLIG3gKpKam
         /nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731000637; x=1731605437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCnx04qdk6zMZ0LIRHX3e1wxnrAQ1/h0DrPbQAd66Xs=;
        b=orK62plY+P+9pTaWNnXLU1q7XqMXAZ8zKJ1FzwCw8gDnyjFO6klpI8bnMfY/9mCS9F
         6aPiPVnUyDe0yarY70FJTOp2IDZbm17z1Q6SY098m9EbN0jTcjgN/KNRh/NZaGM8ObPX
         EuujkKgEBPqK41hPAgVtOeg76a5df8H1L7Gh3ftD4/ljuWlGbVFLOHAGO1epABJOj8Hy
         EtzBeHMq2wB49LdHlXJzKek5K7p3xCL98I7U63eKDPFrnoZIs94z6N1Slgl99vqE0DiF
         otZqUq0sRs+5hm/5orQ22lr2H9coC8Ii3bnUvRD1Ub+qq2Upd8s9EHiLd9aeSmur8vUf
         TWAw==
X-Forwarded-Encrypted: i=1; AJvYcCVQmwkqZO4tZYvNG3axMjimBJIyFsl+InySry7tLcBRa3A2Wj+t7pnmrQI9Z2BKLpdqM1t2xtvlfQNk@lists.infradead.org
X-Gm-Message-State: AOJu0YytGB6/Uqe8txxPkfXV03biRa6X8GVbu/lxGrPZQgXbAuIsKWSH
	tZkbB+q5ZIMlAZKSqmugEhp7Uv59dx76YuFiEKqsA900zy+vs2yC
X-Google-Smtp-Source: AGHT+IESnbWGzA/22VokA2ZRCeQrgxKGn28bGagAmMqOxAFoTUKzdME8cEC2XEg/ojV+oORHekXoPw==
X-Received: by 2002:a17:907:1c05:b0:a9a:19c8:740c with SMTP id a640c23a62f3a-a9e6587e0bbmr2393468966b.47.1731000636974;
        Thu, 07 Nov 2024 09:30:36 -0800 (PST)
Received: from [192.168.42.191] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc56fcsm124607466b.125.2024.11.07.09.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 09:30:36 -0800 (PST)
Message-ID: <7995ffbd-7ec0-4f99-86a2-011bc3375228@gmail.com>
Date: Thu, 7 Nov 2024 17:30:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] io_uring/rw: add support to send metadata along
 with read/write
To: Keith Busch <kbusch@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241029162402.21400-1-anuj20.g@samsung.com>
 <CGME20241029163225epcas5p24ec51c7a9b6b115757ed99cadcc3690c@epcas5p2.samsung.com>
 <20241029162402.21400-7-anuj20.g@samsung.com>
 <ZyFuxfiRqH8YB-46@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZyFuxfiRqH8YB-46@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_093039_146185_D4E5B5ED 
X-CRM114-Status: GOOD (  19.12  )
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

On 10/29/24 23:24, Keith Busch wrote:
> On Tue, Oct 29, 2024 at 09:53:58PM +0530, Anuj Gupta wrote:
>> This patch adds the capability of sending metadata along with read/write.
>> A new meta_type field is introduced in SQE which indicates the type of
>> metadata being passed. This meta is represented by a newly introduced
>> 'struct io_uring_meta_pi' which specifies information such as flags,buffer
>> length,seed and apptag. Application sets up a SQE128 ring, prepares
>> io_uring_meta_pi within the second SQE.
>> The patch processes the user-passed information to prepare uio_meta
>> descriptor and passes it down using kiocb->private.
>>
>> Meta exchange is supported only for direct IO.
>> Also vectored read/write operations with meta are not supported
>> currently.
> 
> It looks like it is reasonable to add support for fixed buffers too.
> There would be implications for subsequent patches, mostly patch 10, but
> it looks like we can do that.
> 
> Anyway, this patch mostly looks okay to me. I don't know about the whole
> "meta_type" thing. My understanding from Pavel was wanting a way to
> chain command specific extra options. For example, userspace metadata
> and write hints, and this doesn't look like it can be extended to do
> that.

It makes sense to implement write hints as a meta/attribute type,
but depends on whether it's supposed to be widely supported by
different file types vs it being a block specific feature, and if
SQEs have space for it.

-- 
Pavel Begunkov

