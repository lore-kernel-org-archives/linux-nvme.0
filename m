Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1917ECF34CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 22:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UARFeoyZ3rHdhvutpLeLbLmTRofuJ6iiIPq0QcY6Mv0=; b=eWfpwTpcUb0JGaOG8YMbeUgZ1N
	rlfSU8w9W9Au6Fzn14FLH0QZPqoOMdJrvaFMSf/q7IxKvODFCE1mjPNIfH3tl8POUoY9qwMaW0z2l
	z/TeNcGW5SP3VUSCu/j4lFnWXlRaR6DtjQRLJpm1Sj8tK+6/Id6p6CUfm7m7zbCU+4T65pVYeL5ze
	piqVL/WZKAT2Nk47l4Li7gHlskr1jp0/4G4uJzbO6vbRS8bpAlL4jI9evZozBUVT8fdfCUn2rnycI
	vSV8QdGhYSNXCHXTTNHCPdwGIa+5lU6VOJHSL+yWsPNeSfZ1HZVqj71SWRyD2AdwNg0cBpxhAd3h9
	WlA0IQfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swU4c-0000000AUOt-2wMC;
	Thu, 03 Oct 2024 22:13:26 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swU3Z-0000000AUGU-3slb
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 22:12:23 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2e192a2fe6cso1159564a91.3
        for <linux-nvme@lists.infradead.org>; Thu, 03 Oct 2024 15:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727993540; x=1728598340; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UARFeoyZ3rHdhvutpLeLbLmTRofuJ6iiIPq0QcY6Mv0=;
        b=uH93NWMObANi7kT6UlO2AB2V1kdguFAZLvArYN2cb3MZHB3y9rD/p1iGDUYjpPdgHq
         3q3HxTle9zKNIuppy1ybc1l/WSrglLDvDeG2nWVc0nFqgbMmRUKuvyQ2yXEZ8UBn3CVu
         uwGIjKY/91KooSnO7e3YszWmH5NW3/oWUMILS92ZWB6brdXY6MQ/NGMKe70Vpp5L14mM
         MLnBQdwCYiuSD7Kyvg36ag3ZqoZi9I4EzsitDnHnbwWJpHk782dCnqziBJHOyZpAyzp9
         e+hksubydteotCkU/DGSQgy+ZHMOgJFSCP0P5LuIkc3a4x3bgpucZn2IxntPimwKoA8e
         kWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993540; x=1728598340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UARFeoyZ3rHdhvutpLeLbLmTRofuJ6iiIPq0QcY6Mv0=;
        b=pNDWSKdpaBhv7vZ4GUiaeClE3+FOdbT8xaRDldLX9RnPVl+sHyh0ZEHQvTka6nHOAj
         SE+ewBPqzlM3MR5hYUa4rT068dHLlT0+Tn/lZifwySb5pJWC7R/UMMa7k4wCnIyLAQqW
         P6Xa6srDyKwKixB43yajeJJeAlIVXAGxlH6c5OzL5AX3IPunl3t0Yev5QIps2mjeH9H+
         ZAZYEaxyqrfb/vNpLUZ2ZlO6PxV8ADH+Trf+1DuS0mzhZyPsdf11bbH3jQqSfH7SqnzK
         zr+L73X1MXViu5K+gghJcZlNXLQyzqwrGnBn8G/bbliluhjylB+LsJtpijICWstRrw1k
         UiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrlbuyEMXpI077+yZuwgC0SU45e67LPAVy5OFSLquCHWN07V56c3bbWRRdtinxE2nYGG3YvD4VCy4S@lists.infradead.org
X-Gm-Message-State: AOJu0YzFev8VxmDJidoOrFgfle9jj95tttpde/BtIzWZHPmAnJ2xrhAO
	T9ytzsMiwaucrzdPZiBZFpXLSe+2FzapkS9HkMpFfGkz+g4UXU5JxitH7yOvgvY=
X-Google-Smtp-Source: AGHT+IHM56HG+I+buxx/PP0Ki+OL0sze0gS4TyHVsLh+P56KL+AQukx5RNv5DEf6lEpdxcaFxOgK0g==
X-Received: by 2002:a17:90b:3796:b0:2e0:8bf4:f298 with SMTP id 98e67ed59e1d1-2e1e5dcf9b1mr686996a91.0.1727993540193;
        Thu, 03 Oct 2024 15:12:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86abbc6sm4335a91.50.2024.10.03.15.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:12:19 -0700 (PDT)
Message-ID: <09db3e2a-8f39-4ac3-ab7b-a2c8addabc77@kernel.dk>
Date: Thu, 3 Oct 2024 16:12:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
 <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
 <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
 <20241003125516.GC17031@lst.de> <Zv8RQLES1LJtDsKC@kbusch-mbp>
 <abd54d3a-3a5e-4ddc-9716-f6899512a3a4@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <abd54d3a-3a5e-4ddc-9716-f6899512a3a4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_151222_025592_9285E240 
X-CRM114-Status: GOOD (  21.98  )
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

On 10/3/24 4:00 PM, Bart Van Assche wrote:
> On 10/3/24 2:48 PM, Keith Busch wrote:
>> The only "bonus" I have is not repeatedly explaining why people can't
>> use h/w features the way they want.
> 
> Hi Keith,
> 
> Although that's a fair argument, what are the use cases for this patch
> series? Filesystems in the kernel? Filesystems implemented in user
> space? Perhaps something else?
> 
> This patch series adds new a new user space interface for passing hints
> to storage devices (in io_uring). As we all know such interfaces are
> hard to remove once these have been added.

It's a _hint_, I'm not sure how many times that has to be stated. The
kernel is free to ignore it, and in the future, it may very well do
that. We already had fcntl interfaces for streams, in the same vein, and
we yanked those in the sense that they ended up doing _nothing_. Did
things break because of that? Of course not. This is no different.

> We don't need new user space interfaces to support FDP for filesystems
> in the kernel.
> 
> For filesystems implemented in user space, would using NVMe pass-through
> be a viable approach? With this approach, no new user space interfaces
> have to be added.
> 
> I'm wondering how to unblock FDP users without adding a new
> controversial mechanism in the kernel.

pass-through already works, obviously - this is more about adding a
viable real interface for it. If it's a feature that is in devices AND
customers want to use, then pointing them at pass-through is a cop-out.

-- 
Jens Axboe

