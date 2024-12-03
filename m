Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19711E64A83
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wrpw/gEIImhg5C05XMjsYpabyaleC2cQZtMyShGtK8A=; b=Q+6HUfuHnj1qtD2JJ1JMBSCAOs
	vt220trCAlAzuuO+9Y9KAO0+QPQSLTyC9BMmtXD3115l3KAcfO81wNC6a6QsClL+utrKy5mN5NDY5
	iz+O0iG+6e5DUIXnodJ5A+QAcGk7xCjPPCF1n7B29Nz5qVrOTqY3A13SP+9Eid5e7GQo9xhKacGBN
	a8PcXvp8FEZZ+TIzSPu0x1E9HUiYsk4y95ur8BFFjZQCBrutQm/c+0mgkO8IEQKhzceMUSLJ89+Lj
	O3seDLgr+lPuof/z7J74uB/iQ5m7khc3Fb0iVLQbtqogn3pYA4DdqIrLHXd/r/7n14mrqVb5BtrB6
	J38PRHqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIRaM-00000009MD5-1wgU;
	Tue, 03 Dec 2024 12:00:58 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIRZE-00000009M0M-0JAo
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 11:59:49 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-aa5500f7a75so850678866b.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Dec 2024 03:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733227186; x=1733831986; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wrpw/gEIImhg5C05XMjsYpabyaleC2cQZtMyShGtK8A=;
        b=hNF1lZtoSvaAt/yubOCWEwd1wumDlPNC+nHOahNFjY9Lvj+upo4VemJULJ8qE7r+j3
         oSMcUlTQR3FMkpHR0l3PqRzknvLigIMcYDhaUBr1/NM/9oo5p7Hj2jSLKzUzlW3M4GBK
         12+n90Vyr7yuLXArXUndLLlqJTLqz0nBrIFHmJ7cKP8x1XNXDOC+dar9mzys557nw/IH
         4xlT4g9LuKl/F+A3FJ4LmhC5W64BmxqIk1blKOqEGeKpx30J4CsmA8u6+SMCS6uNawFu
         zkn33ctT6EhO6I2rhnJtZlF+2YaPbG5wiQcT7riyxX0NKxRvI7XvqmmpM3E3HvG4bUc9
         tylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227186; x=1733831986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrpw/gEIImhg5C05XMjsYpabyaleC2cQZtMyShGtK8A=;
        b=qFBOZNbEpbcpokEitkA7c1R8qpgdaNVSvMWjXIls7CI7sccO9LcnvMHqKxA5FzrSDG
         taVOQm2mnq+peLt1Of8g2rJSqI7mirn6XtrdNkDa/PXkeqbgHS+1dyHqTOhwWZGXotzG
         X5VkpMEdoPJhVG53GcLAFFLSG1DFMLCS3mKJNKV9DwomuvPDzWjAzuiicU2PmY7VTbii
         qVJBS7tECLrC/g2aT3hPRvqWbqFtAVXzSrvb3giZV0xyJwyXBwiak2AF24M8TXk0Ihs8
         RzLeJFFJKyYPaFxJQveq2vGTkucEZjWGoV3bhqkB3N11RM6WyL1F4A7D+pK4YKrkssi3
         do2w==
X-Forwarded-Encrypted: i=1; AJvYcCWRLrjxxupN/7lpvJoyAhW3vURc/GElh8K3yRk/VrdOrEOIL9crTdcnRxlMEgaT3Rpnda82GS5lGWL9@lists.infradead.org
X-Gm-Message-State: AOJu0YwmF6fLFwsD4VcIDcErRqfqRqpf8XvKeB6nO14B0gvZ2I35uc61
	Yao8/YTJzmwjbiAz3qVCskxcoXnBTu0nAirI6kUDNWybx6h7Bgma
X-Gm-Gg: ASbGncspXweXLUu9DJVfR4Wh5LsmR8Y+r2Bhhh2MkBrek7qu/8UmDEEtS7BLU/+bSCf
	vInp79FadHdjlYlUGuoJASjZINTKPBpcfNRVxdIFWBowcQaSx3Z9u6z6EXsnHOnaSbnfasmnhdp
	0s6bFgCyayp1/mvgsAP/ihDqSF8d1Ae8cuFKwwB5nQGCDDAWZlcSRFUXLcKzHmF/UwCmxM6tJ8w
	9scKRIV0x5uGkoSJ8P+txnoVpyDt/jSbDghW/oRMqEzZEMtQCrAU8beHvMMuw==
X-Google-Smtp-Source: AGHT+IG4y9LGZwq9NfK9cdHd+NVO7Xgo2sU20E7rmPmT2a1si682Vjey0TVrQO9Z6X+iYPB4Df14SQ==
X-Received: by 2002:a17:906:4c9:b0:aa5:44cf:3ea7 with SMTP id a640c23a62f3a-aa5f7f4773dmr171377066b.56.1733227185269;
        Tue, 03 Dec 2024 03:59:45 -0800 (PST)
Received: from [192.168.42.213] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599801591sm605350766b.91.2024.12.03.03.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:59:44 -0800 (PST)
Message-ID: <b8574010-e2fc-4566-9df8-80046fec2845@gmail.com>
Date: Tue, 3 Dec 2024 12:00:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] io_uring: introduce attributes for read/write
 and PI support
To: Anuj Gupta <anuj20.g@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, anuj1072538@gmail.com,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241128112240.8867-1-anuj20.g@samsung.com>
 <CGME20241128113109epcas5p46022c85174da65853c85a8848b32f164@epcas5p4.samsung.com>
 <20241128112240.8867-7-anuj20.g@samsung.com>
 <yq1r06psey3.fsf@ca-mkp.ca.oracle.com> <20241203065645.GA19359@green245>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241203065645.GA19359@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_035948_117829_1966F821 
X-CRM114-Status: GOOD (  18.54  )
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

On 12/3/24 06:56, Anuj Gupta wrote:
> On Mon, Dec 02, 2024 at 09:13:14PM -0500, Martin K. Petersen wrote:
>>
>> I have things running on my end on top of Jens' tree (without error
>> injection, that's to come).
>>
>> One question, though: How am I to determine that the kernel supports
>> attr_ptr and IORING_RW_ATTR_FLAG_PI? Now that we no longer have separate
>> IORING_OP_{READ,WRITE}_META commands I can't use IO_URING_OP_SUPPORTED
>> to find out whether the running kernel supports PI passthrough.
> 
> Martin, right currently there is no way to probe whether the kernel
> supports read/write attributes or not.
> 
> Jens, Pavel how about introducing a new IO_URING_OP_* flag (something
> like IO_URING_OP_RW_ATTR_SUPPORTED) to probe whether read/write attributes
> are supported or not. Something like this [*]

An IORING_FEAT_ flag might be simpler for now. Or is it in plans to
somehow support IORING_OP_READ_MULTISHOT as well?

I have to say Adding a good probing infra is long overdue. For example a
user might want to know which attributes are supported. And beyond
io_uring it might be interesting to probe whether a particular file
supports it.


> [*]
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 38f0d6b10eaf..787a2df8037f 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -723,6 +723,7 @@ struct io_uring_rsrc_update2 {
>   #define IORING_REGISTER_FILES_SKIP	(-2)
>   
>   #define IO_URING_OP_SUPPORTED	(1U << 0)
> +#define IO_URING_OP_RW_ATTR_SUPPORTED	(1U << 1)
>   
>   struct io_uring_probe_op {
>   	__u8 op;
> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> index 3de75eca1c92..64e1e5d48dec 100644
> --- a/io_uring/opdef.c
> +++ b/io_uring/opdef.c
> @@ -67,6 +67,7 @@ const struct io_issue_def io_issue_defs[] = {

io_cold_defs would be better

-- 
Pavel Begunkov


