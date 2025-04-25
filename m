Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D08AC369D7
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eRXHF94Gxw2igepYLnZobF7wF3QfLUtoMAIPFNB3Zms=; b=ocEQqVpvCceZDLSRGCUGSr6dZI
	KfKxDys1POGwRx4wPblSbd7drmTcdleFYsARCLgTuurZGwRDQzHJI3HdO0hz/Lb6mELW7P7rjD1Kx
	81gn5BSyHJxFl9oOIvS18OR+fysg40oFK3ephwUOWLZ/8Rkrq/R+qPy2MQIlBvQFGD/WnPn+a1fWW
	thQMu25eL/8Ni//oQes/n++bBonpGUXniCRC+FBFLIM/tBUzYbpmytuDhiLaPB7KyH2jVxpAXtw9o
	/iJAOstSUc44svR7H6ZhLHcthqKgrlsrSXLQk+R+puToQ3rrffj9/x3lo/QxbcM/GREHWdERUV4AA
	E+iHjpcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8NAX-00000000Rw4-05Jy;
	Fri, 25 Apr 2025 17:48:57 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8M1Y-00000000Etg-3YlX
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 16:35:38 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-301e05b90caso2652609a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745598936; x=1746203736; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRXHF94Gxw2igepYLnZobF7wF3QfLUtoMAIPFNB3Zms=;
        b=JhxysRi9J88e2CGaLFcNRQW+wr1oh0maGt4DuyX2JNTCrohJfEDJTpPX68GslcLxOL
         F7oHVzjr/z4NVKxizbDKJbp4x8sy1yRm7iP6xjlGPNY6lgOC0FOpV/2e1TmCJRonJhHh
         RmjCt6JC7zwZFNRlYZcoCuk8dNJYzUe20ebvaaHPWJB89Cyt44GtqmfLk9dF3ykKC5GD
         Yw8cchp9LuyPGC7x/9/s9ZLQWT9rX75ltuC+dY+DSC2Wa+NHvc8YSvo2XLIMW6APfafm
         C6kyYXm3T5fCGy8m6NLXykM7GaaFCVl7Gvs/ZyeQNxJz7wWAZd3dMfzVda6ACvHN7ig4
         p/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745598936; x=1746203736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eRXHF94Gxw2igepYLnZobF7wF3QfLUtoMAIPFNB3Zms=;
        b=s/0n3V70FVFed0IIrwJTlmkdUgRSMHUGovNjjpLrbOls1tIWdEoZx0TJ2OH1wccrLp
         fOd2i3CnsQWE70SWqo3bGQIKcIG7flJvHNlE4/X53L1UKz0Tl3wI4tILPVkrJA4lcSes
         Db7oyqnG5NN2JFzgHFkHh0+DMgIm4KN2HcK02UkXCPsxXsR3f3z6lBjzfN5Q9XV7yfIh
         blHGCxGG9QhKavYyXxtmTbV3VaoK5X5Pn6ZObgalle9LhvGeh8qUxcAADSQgdUW44Afa
         jF74JML4eAAjHb8Dju9rag41tfS86O1uh1aO3IH6MX3b63Pj9n7IsysZpEX1+GoGU7rp
         cAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHzNtuXhXKRcGhmCeahUhu6VOti/2VYxx/LfLZB8sG0xTcRv/3YlFVvv6u7WvyqZAWUbD0YvTejfSp@lists.infradead.org
X-Gm-Message-State: AOJu0YwLQa1kzoYNoEShdO8PypZOPqQEGKqfyiM6EJGklFflAj4ffJ7O
	gYh4WQfr5VYynIbspdSKNV1vpG0UPnIeIbpo/gNqCMl8xjIVTDgA
X-Gm-Gg: ASbGncv+p0ySFfeF448o6MtP6wrQlny3pq/bowlB6OanJqs/uoxx+KuhAimp2aGHpRt
	G10wVcraKGBxxBTuRmnjYocs3lJjVsStq7qVaR+4s0TZ0H30HLl1VY+PwpZBnEOGiVfjViYjvcH
	mwSMKrLiDjgBqh8E9whqV0aKHWexNM8g3iZPkI8SaDbFuuk8rmROW6aI6CoAghhl2eiUNLvh9Tr
	0XCO/7yNqKkPeduDe3Nwr+VMhfm9d2MJhC3auXIGeUau0VDfbxYaHwSrj6rgplm2j+X1YEWqnFO
	p81ZilJjSwN/TwldEPEe7UAN58wEs/NiuA3a0S+aq55KZDhiwy6+VLDM+qtK3gfffe6bmaEq
X-Google-Smtp-Source: AGHT+IFPl7CUIexk7v4e/+SGM7Q6vaidXSFlz/auCXkWC48GIPzQYxqRbnCZ1b4ACCXot4UQtyF18w==
X-Received: by 2002:a17:90b:4e87:b0:2ee:9b2c:3253 with SMTP id 98e67ed59e1d1-30a013d9433mr273927a91.30.1745598935713;
        Fri, 25 Apr 2025 09:35:35 -0700 (PDT)
Received: from [192.168.8.155] ([103.127.219.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef124cffsm4043795a91.32.2025.04.25.09.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 09:35:35 -0700 (PDT)
Message-ID: <b6880ffc-4ce5-49cd-b08d-de2c82b21f4f@gmail.com>
Date: Sat, 26 Apr 2025 00:35:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: avoid missing db ring during reset
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <fa04f3d5-56ff-62bb-0afd-ad94e961ddee@gmail.com>
 <aAuu1RvgwyfXI3AL@kbusch-mbp.dhcp.thefacebook.com>
From: Linjun Bao <meljbao@gmail.com>
In-Reply-To: <aAuu1RvgwyfXI3AL@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_093536_894196_9E20C3DF 
X-CRM114-Status: GOOD (  13.08  )
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



On 4/25/2025 11:48 PM, Keith Busch wrote:
> On Fri, Apr 25, 2025 at 08:01:45PM +0800, Linjun Bao wrote:
>> During nvme reset, there is a rare case, when user admin cmd such
>> as smart-log and nvme_admin_create_sq from nvme_setup_io_queues
>> happen to in the same blk_mq dispatch list, and the user cmd is
>> the last one. nvme_admin_create_sq is dispatched first in
>> nvme_queue_rq(), nvme_write_sq_db() is called but immediately
>> returns without writing the doorbell because it's not masked
>> "last". The subsequent smart-log ioctl fails fast hitting
>> nvme_fail_nonready_cmd(), skipping both nvme_sq_copy_cmd() and
>> nvme_write_sq_db(), so no doorbell write ever occurs. The
>> nvme_admin_create_sq fails timeout finally.
> 
> The block layer is supposed to call the driver's commit_rqs() function
> if anything in the dispatch list wasn't successful, which should notify
> the controller of any pending SQEs. Is that not happening here?

Yes, in this case, the last user admin cmd will fail nvme_host_path_errror
finally, but ret BLK_STS_OK, which will let blk_mq_dispatch_rq_list skips 
the commit_rqs, thus missing updating the SQ doorbell.

