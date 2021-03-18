Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2614C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:42:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD9A64F01
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD9A64F01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rAUv7wNf1rHBOuj5sZfcekOTtladZHWcQYDU/yr7A4c=; b=NZaN7S7mJJKakePq75G+3vHoU
	yZ/XEM75vRKgJf6rlnI6bDlvUNlOi7ttquh+2Lntr55bVkayipuBrv4COsEyPWXM54KgNFRAACmFY
	bt6KgHC8EfBIVMp2wL/K2ECTC7Omd7eWaqomn+krlRyM0MjDkDhKvwgwXwcxYYUquTLpqRmK2pQ7p
	tAV6raKm4FJAhNON8MwrJJrOQKWo9hXQegK3gXlgyc6dtoYZhONhxxnZnae8pyQaGDO8OwOCN9Na/
	PvVrUeXkbT5zBCT3J80pNttpL1++gpDxRHC7RaN7iToivx+/WPisWiJquP93U+jCD9MmJxjLXiHD6
	gWkePzPtg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMxak-005rkY-Dz; Thu, 18 Mar 2021 18:41:54 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMxaf-005rjY-NE
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 18:41:52 +0000
Received: by mail-il1-x12c.google.com with SMTP id t7so5811760ilq.5
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=11LYuxy/PVwLEMc1x946PQMZwvGVf/5B86ZwRj/GhCY=;
 b=xaUFsauEvSSW8OgPR0s0fId++ugaBghEP0bCL6TFHaGZBPFgkM8gcZEujLVA12G5DB
 te1WFS7AfLVHXuCim90sYe2mlnqPA0GUBlV/xQel2wQhR0pwibXfIePJmXuvT2wvdzW3
 VShC57HJ1iTyNVSOGEw6mllLXUfPk5r1iL7nK5ePbdmgIjGcRWXsnxQPw6ijYFupBhYL
 /EolzsfArUhWWyCDFUio0GcW2L4uD6dN0DPA4LXWV7+MkeoJ3ui6D/pQT69BG1pxS2ZF
 8/X7UxRQnSVm9idEwGpQd7QJzD01Szy5e0++dzNO0Y8YIFmx6UG72Ud8anoYw5v+vW/v
 gvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=11LYuxy/PVwLEMc1x946PQMZwvGVf/5B86ZwRj/GhCY=;
 b=UGA6NVFXChB6+QVnUwNbufnMP3CFZGA8sq6wvQK1VCddzJaKUfKorbLhKgjSnBXBfz
 lVrTL63OAAdWGgmeSbOD/eMcuxPuj5AlSRVZDMrSNU7+JBn65vMmFhoWRSPJhn5QaDAd
 tu9WvYhTGLE62Ayyg1KiZlXMv4wG0zeINxQ+jXCZ3Pz5L0jktWolfgchWaIGDvTYdMkx
 5xLKRjbODe20VA/nlkpQ8XwdAb6i0LkimmfgtSZEtXFsYcplqsgSaVCCgxR2Le/yYv0S
 SgZLD3+rv4ofdrRrY4hiXmARAOr2EQrnWDv8Ptlp4R6qb44/+N18ckNQ4DI3+6tO7aPk
 6ZQQ==
X-Gm-Message-State: AOAM532lkB7olatjvG9WdQUBelepJ4z4kQOZpZws/WnKTdlbqwuLDCaP
 8zQu/m3qRc4bZKKxSJdpAM/vfw==
X-Google-Smtp-Source: ABdhPJy22yz7dLdT3KAF1l7QWugeAL2zR48qA3rXLsugi+uSzhGsn6+zKttK/WCBcCeNKtCIdHy46g==
X-Received: by 2002:a92:ce02:: with SMTP id b2mr13245416ilo.182.1616092908408; 
 Thu, 18 Mar 2021 11:41:48 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id k10sm1306669iop.42.2021.03.18.11.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 11:41:48 -0700 (PDT)
Subject: Re: [PATCH 3/8] fs: add file_operations->uring_cmd()
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-4-axboe@kernel.dk> <20210318053832.GB28063@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6ef8634c-632c-2ddb-0e46-6469b659d27d@kernel.dk>
Date: Thu, 18 Mar 2021 12:41:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318053832.GB28063@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_184150_139699_A2DD449E 
X-CRM114-Status: GOOD (  21.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/17/21 11:38 PM, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 04:10:22PM -0600, Jens Axboe wrote:
>> This is a file private handler, similar to ioctls but hopefully a lot
>> more sane and useful.
> 
> I really hate defining the interface in terms of io_uring.  This really
> is nothing but an async ioctl.

Sure, it's generic, could potentially use any transport. But the way it's
currently setup is using an io_uring transport and embedded command.

>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index ec8f3ddf4a6a..009abc668987 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1884,6 +1884,15 @@ struct dir_context {
>>  #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
>>  
>>  struct iov_iter;
>> +struct io_uring_cmd;
>> +
>> +/*
>> + * f_op->uring_cmd() issue flags
>> + */
>> +enum io_uring_cmd_flags {
>> +	IO_URING_F_NONBLOCK		= 1,
>> +	IO_URING_F_COMPLETE_DEFER	= 2,
>> +};
> 
> I'm a little worried about exposing a complete io_uring specific
> concept like IO_URING_F_COMPLETE_DEFER to random drivers.  This
> needs to be better encapsulated.

Agree.

>>  struct file_operations {
>>  	struct module *owner;
>> @@ -1925,6 +1934,8 @@ struct file_operations {
>>  				   struct file *file_out, loff_t pos_out,
>>  				   loff_t len, unsigned int remap_flags);
>>  	int (*fadvise)(struct file *, loff_t, loff_t, int);
>> +
>> +	int (*uring_cmd)(struct io_uring_cmd *, enum io_uring_cmd_flags);
> 
> As of this patch io_uring_cmd is still a private structure.  In general
> I'm not sure this patch makes much sense on its own either.

Might indeed just fold it in or reshuffle, I'll take a look.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
