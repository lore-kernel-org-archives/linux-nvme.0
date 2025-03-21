Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E368C36002
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ulaGf9MEDtrRMzJbsiLum2mRDwlhlX8TSKnkfT/XEQ=; b=VNSYKC30xnWO4L4oDl7wDGK2de
	E62A2GfpMoM6EJ5KpLPVGMPTfONLhb0jNJbc2Q6VYfHoYbp8jOT9o044E/biOxBC9YkE4LP/G0Zr5
	Q+1ddiWZUzbTwcTBN64uUszxNEMzRVRyU8QWCQQed24Oz2+1+qFNv3yD33YCQAyOPZJZztsWq03ip
	j7b6rr7WTkNFSYlcRWPEM0UTgpkxq35M+3Dg/vHy7kEukZ4vhp6Er32MJVr18VlVXe1Wcyx5I6CDY
	+oDTLyimTfAhj4pFZ+lb8U+BuNNoWci5eR9qkgPRuS7o0TqELAoda31tPPYgz2eKfHZVml/aYh7ov
	REf+SlwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj4e-0000000GCDJ-2wDP;
	Fri, 21 Mar 2025 20:34:36 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj4b-0000000GCCm-2q32
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:34:34 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso122360666b.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742589272; x=1743194072; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ulaGf9MEDtrRMzJbsiLum2mRDwlhlX8TSKnkfT/XEQ=;
        b=VlTbaxtiYXGYK2ECoqGtPMr/R0cT/np3DBgZn/dKt0zcmc7A2UqzfvoCAz968v+QgW
         tzuGE4SRB//2SknORtDSV6PUhvQXkfAEb+xTDAUAqW3FbVkpLHB8aTzBZH+ep9UG/cVD
         tH45wrCvHRqviFalzZ1dGGMJ63voBBuOvR/lK4Xanw+5qdvaXwHpyr3hf5hIUjAvkEzK
         q8LA+gs7aNOwobVsAgaExAlaDbQ7Tp727/t57vFTDudyIcFvmDiLJiKWqEeO2zl4xBbs
         9z8ZbJ5z0+FL05lYNbPHJQiVn3woe8dAm7EJoTllcS8sL64KWyxXL1cfCLsVeSIOsnIb
         Pi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589272; x=1743194072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ulaGf9MEDtrRMzJbsiLum2mRDwlhlX8TSKnkfT/XEQ=;
        b=dUmgw/7snyhBbU7gWOtS1m+A6ijrwsDq6q6oCisjEC60qrzVTBpMxljvWw4U7fchLl
         DvWDrgoNj3MN8SvkdXKSqnQck+OveCwzCHVjARBDU1vFXEld2eEUSyGLVixQYxVor4w8
         zB38SZqUDzi46DuZT2J5Ospdjo2MmOElqu8eww+3RSHDBGPA9Son0pkogGyjEn/4lFXq
         Mk7+rg91tmTAg5eEmyGOm0VB8AUdd3KkPWNUSl67MBGpjDMiUmPb9wZYLymaMwRgi0ZC
         7HsdiKIEQ7menOt0X8lAeXEwjCubFzOCiZSFUXUaSqoLo2nROW0n6eApqY2M3I7sfj/I
         16aw==
X-Forwarded-Encrypted: i=1; AJvYcCVjevqqXAHjR/OATb3gomgWX/6otZv5BuMga3yaXcuy0BJo6G4zJS0LyPuUeGJ9/hFp4c1WvqYmOAeF@lists.infradead.org
X-Gm-Message-State: AOJu0YzZmLRxtHbdqyo006sBqTl+YvDWaXnxOe46lN2sn9D40huV23fi
	uTsQ1DpfMvxaRO/YzK9KZpY/+42VUmSrtN0f0kPmanedVIfmmih4
X-Gm-Gg: ASbGnctuLOZlfHQWi8+eZNEYDcJl+KIthpiwFNA/ljThh4xsLE82E3t7x4e5XjxIKOo
	YVjwCXvlv1lEqzt/zIVwEI2x/KCMistaSTrSVVdKKN2A/heo+K3r3gesVRjUXPS0ovyjwGg4jPo
	PrfI630q86bFxdc+m65fJ+ptk/n8T/OSd8T7ujry7ka1OeFBSx0lqZ+QfzAXiEM8QSwfZwcdWnh
	PJ2SiVxADASG/oyyWJByb6EBGTX7qCC9Hk2F54z2Tg6iCCiqAYPFSXM++5vdLP8GANjC37wBDrF
	a2RNLEzdFQC16Ea6yBFXLEA4+zBxjY1VPRLW2/BXSClwoKA4d029Pg==
X-Google-Smtp-Source: AGHT+IFQFUoFZr+OweqQjp9ANhksXIbIFtn48qnP/QqrNnrWbtvNBVSyJNR6P8eMfXTiAoQVCDhJIw==
X-Received: by 2002:a17:907:3f10:b0:ac1:fb60:2269 with SMTP id a640c23a62f3a-ac3f22a59a0mr480301566b.27.1742589271626;
        Fri, 21 Mar 2025 13:34:31 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.236.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb658b4sm208614166b.118.2025.03.21.13.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:34:30 -0700 (PDT)
Message-ID: <8338ac70-ed0b-4df5-a052-9ab1dfec9e26@gmail.com>
Date: Fri, 21 Mar 2025 20:35:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: import fixed buffer before going
 async
To: Caleb Sander Mateos <csander@purestorage.com>,
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250321184819.3847386-1-csander@purestorage.com>
 <20250321184819.3847386-4-csander@purestorage.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250321184819.3847386-4-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_133433_730724_F80D55AF 
X-CRM114-Status: GOOD (  22.89  )
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

On 3/21/25 18:48, Caleb Sander Mateos wrote:
> For uring_cmd operations with fixed buffers, the fixed buffer lookup
> happens in io_uring_cmd_import_fixed(), called from the ->uring_cmd()
> implementation. A ->uring_cmd() implementation could return -EAGAIN on
> the initial issue for any reason before io_uring_cmd_import_fixed().
> For example, nvme_uring_cmd_io() calls nvme_alloc_user_request() first,
> which can return -EAGAIN if all tags in the tag set are in use.

That's up to command when it resolves the buffer, you can just
move the call to io_import_reg_buf() earlier in nvme cmd code
and not working it around at the io_uring side.

In general, it's a step back, it just got cleaned up from the
mess where node resolution and buffer imports were separate
steps and duplicate by every single request type that used it.

> This ordering difference is observable when using
> UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the fixed buffer table.
> If the uring_cmd is followed by a UBLK_U_IO_UNREGISTER_IO_BUF operation
> that unregisters the fixed buffer, the uring_cmd going async will cause
> the fixed buffer lookup to fail because it happens after the unregister.
> 
> Move the fixed buffer lookup out of io_uring_cmd_import_fixed() and
> instead perform it in io_uring_cmd() before calling ->uring_cmd().
> io_uring_cmd_import_fixed() now only initializes an iov_iter from the
> existing fixed buffer node. This division of responsibilities makes
> sense as the fixed buffer lookup is an io_uring implementation detail
> and independent of the ->uring_cmd() implementation. It also cuts down
> on the need to pass around the io_uring issue_flags.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 27cb27b6d5ea ("io_uring: add support for kernel registered bvecs")
> ---
>   drivers/nvme/host/ioctl.c    | 10 ++++------
>   include/linux/io_uring/cmd.h |  6 ++----
>   io_uring/rsrc.c              |  6 ++++++
>   io_uring/rsrc.h              |  2 ++
>   io_uring/uring_cmd.c         | 10 +++++++---
>   5 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index fe9fb80c6a14..3fad74563b9e 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -112,12 +112,11 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
-- 
Pavel Begunkov


