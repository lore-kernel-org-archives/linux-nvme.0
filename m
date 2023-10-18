Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EFECDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6JLUn6Yh+ruDzICD7gX152TY6ByEjafBSpzN7RqS0IQ=; b=p3QM2cZ3/VZDhc8NIdtNXq8h/z
	pZz3dfE/g5bysKOcEPzxKc+5flJl4V2mSKy/f25IsUAHoYe0e1o9Xgy6lhLJsUhAt02x+/PoZf4Da
	FR4x5umSmBMasK6kQsqFXwrzvRClW6xmHBgV+AwtN2kimf+CntQ7y0NeUfGmy5en7oRcyVsMGUTMB
	3hE1CS0xMcPWkiB9FT0poLxub5baUOZyj/qe5dDxGk5ak2kaJgNnnerYSNhunbzKNIsEvkegQwWYN
	FjQ8P1/bdxQ6gJR/65QWRXYuH8myM5ns3YD+GoNfQ0/bP3DnOvyIbly/QGZNIFPg2n9vHro2IYA2N
	Z4fMSejQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCMC-00FYRR-22;
	Wed, 18 Oct 2023 19:37:28 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCM8-00FYQs-2u
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 19:37:27 +0000
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79fc0068cb5so17958239f.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697657842; x=1698262642; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JLUn6Yh+ruDzICD7gX152TY6ByEjafBSpzN7RqS0IQ=;
        b=sOyIeoXeUVVAc9h4F94wyGeBuaz3431oYnxSq11pYgRU3OUHM26p7YfHlYFA3X/4Nj
         zmOBkAbJHwm+0KKC5F6ciYkS7LaFbI7/zrdx+MweTs8UcTZQN85HaOVMUBVHnxPv3+Ls
         BLH1CEK7Ix65rpKlXWbMXHW3bZ86bauYuTXowFhoP6wYEq5IHZmGH62SNrsqWkXgRfqP
         4aZHL7YiiY1qH/28KgwIEg0T++tRVZnmX37f/R6Z8gldPLZObkKnkORX9VVxiWP8LXMq
         EmvFLsAhKpRBFEbpYhULyfsdb02t2Bco0uaCIzTyxxdWdHJ+fmlnkqH54ZvYrp0FSNYN
         WfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657842; x=1698262642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JLUn6Yh+ruDzICD7gX152TY6ByEjafBSpzN7RqS0IQ=;
        b=KsHcjy0uPIRtXomwgMskv3FN7AGTqY1p9c5Z4DwBWn4cBtfISKzLsMo8VzhPw3klTK
         i9QDvfD3IoU9fwaxWvW8dhr5Jzo6S+EWgDMgcE2z8E2Tr+XPloiqU9WtJ877G/sjqyBk
         VWmwsyBex991tIvu45Dte115evC42jNklLGK61AJx35SkPM7RnFe/VZK723GnnOJm6ob
         Zv42VQMH9+8Vp54An+Z0tUw4Ogwut0vQuGtPPo3rUSjbRKFt9+4gJeuqnDhR6bW746TH
         3qMY1O/n2buOFxJRHwMHPfimhndaUcKqkj5HNeFgmlYyGuoC50CIxMtI9k2SCBhIy7ty
         jqkg==
X-Gm-Message-State: AOJu0Yxzuo1Jbj/gdSp5whn1IBunYy3VYcAb1WhsU9HFbFsrcsDF3J+d
	Mof6lmOIKh6S9pAy+ASelvdup83qRZntjwF/VeOclQ==
X-Google-Smtp-Source: AGHT+IEmzgHlQg62Hvus9d/8UzDsf4ZwmnGZbDVlUuOq7IHQT9Gh/zZ1sJDuxuzjvFH0S57u6UBb0Q==
X-Received: by 2002:a92:d686:0:b0:351:54db:c1bb with SMTP id p6-20020a92d686000000b0035154dbc1bbmr399615iln.0.1697657842571;
        Wed, 18 Oct 2023 12:37:22 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g5-20020a925205000000b003576ff2d8b1sm1312285ilb.26.2023.10.18.12.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:37:22 -0700 (PDT)
Message-ID: <abac8b80-2416-4d4c-981c-9f9b378436b9@kernel.dk>
Date: Wed, 18 Oct 2023 13:37:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com>
 <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
 <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_123724_938745_35046973 
X-CRM114-Status: GOOD (  15.20  )
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

On 10/18/23 1:35 PM, Keith Busch wrote:
> On Wed, Oct 18, 2023 at 12:40:35PM -0600, Jens Axboe wrote:
>> On 10/18/23 12:30 PM, Kanchan Joshi wrote:
>>> Patch 1: Prep. Adds the meta-transfer ability in nvme-pci
>>> Patch 2: Enables fine-granular passthrough with the change that i/o
>>> commands can transfer the data only via SGL.
>>>
>>> Requirement:
>>> - Prepared against block 6.6 tree.
>>> - The patch in uring-passthrough failure handling is required to see the
>>>   submission failure (if any)
>>>   https://lore.kernel.org/linux-nvme/20231018135718.28820-1-joshi.k@samsung.com/
>>
>> I didn't have time to follow the previous discussion, but what's the
>> reasoning behind allowing it for SGL only? IIRC, we do have an inline
>> vec for a small number of vecs, so presumably this would not hit
>> alloc+free for each IO? But even so, I would imagine that SGL is slower
>> than PRP? Do we know how much?
> 
> SGL for metadata is definitely slower, but it's the only nvme protocol
> way to directly specify how much memory is actually available for the
> command's transfer. PRP/MPTR vs SGL is like strcpy() vs strncpy().

So... is this a metadata only issue? Or does it apply to any read/write,
metadata or not?

> Similiar to Kanchan's earlier experience though, I haven't found real
> nvme devices that support the SGL mode for metadata. The scenarios this
> enables might be pretty limited. :(

Well that certainly makes it way less useful.

> The other hardware "solution" is turn on your IOMMU (eww).

Yep, certainly also a way to pay IO taxes.

-- 
Jens Axboe


