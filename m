Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553CAE748E9
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Oct 2023 13:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xVJSYZtpL0YLa+wcSpHtc+qG+rdtMGRB99f0WwrMd40=; b=C3BVL9QYhTkyRTOXErEFhx8K/m
	is+15u4i6YbVuqPDWUQq1pVHaapgbhrLUBu0ePVjMV2OIeJ09OqmWqR3/EL87T6B8ieAgJdtiKJAU
	gFDRrC2c9ROvbl4qeQjuISz1scg+s5PFv1Kz7kAryaeHDulqhV3IdcR6BB/VnWir18v9RZWVfvJ3Y
	dx8GyOe/9OSiL5s4+E0VJNBECRcSyvitzCTmHSFuma3ghMQ+c7rsZgp9OaudVP66818LvSEg6i4pJ
	x02CCTe6Zdt/zSuZR3kU4HC8TMPQGz7p5OpANLhoj2BuMAVuXVEk3THfLK4N3XqzcUkU/PRtdEkw5
	ECA1wVcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmwQB-00BE4N-2M;
	Sun, 01 Oct 2023 13:23:43 +0000
Received: from mail-oi1-f169.google.com ([209.85.167.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmwQ8-00BE3Q-2f
	for linux-nvme@lists.infradead.org;
	Sun, 01 Oct 2023 13:23:42 +0000
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ae35773a04so7647362b6e.0
        for <linux-nvme@lists.infradead.org>; Sun, 01 Oct 2023 06:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696166615; x=1696771415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVJSYZtpL0YLa+wcSpHtc+qG+rdtMGRB99f0WwrMd40=;
        b=KyXX0hK+JVVc+QGUuSVSN9NpcYukx16OlI4LjyscsHNSIH2kjYTI9aRDOFM4mJk+Ck
         +q/pygjZbG+5SvD3IZ4fGmNdjuWBch06iJhtB6qdWZnnw96TE/TGJ95XMcjqg7XWW+e3
         Y78IJNMbv2Lw+UpwH1KhUxI40cbKlFx+6OKpUDkb38ZjS0V5y9Nco8XsF7/rVAsoGyZj
         RPvzhHJKJ/DtlR62zkAZsVHwTfoUw8O5DJo1N85DjGYWq1BhZm8O7YZxm+yNdQc1CbMM
         DeTo1F2h1irR0skGF/+xsvyADYEIi34is53pZzEofQD4EQ+kKL9SKXvmZaGdY/lRHwD8
         sr6Q==
X-Gm-Message-State: AOJu0YxCb4QecFoWPOGjd14RkDFFhif6oDlb5glvpnK240eiINK2HK/n
	aUqH1jMEq3Umz+rPYdtt/Zw=
X-Google-Smtp-Source: AGHT+IG5r59Stw18eP45GGvts3KKKs7AnR8jZu7o46ucmeUjXt+CrOjIYIY866yaw9ZKQjAGZmJ61Q==
X-Received: by 2002:aca:220e:0:b0:3a1:bfda:c6d2 with SMTP id b14-20020aca220e000000b003a1bfdac6d2mr9142795oic.11.1696166615513;
        Sun, 01 Oct 2023 06:23:35 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001c20c608373sm20148814plh.296.2023.10.01.06.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 06:23:34 -0700 (PDT)
Message-ID: <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
Date: Sun, 1 Oct 2023 06:23:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
 dchinner@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 jbongio@google.com, linux-api@vger.kernel.org,
 Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929224922.GB11839@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231001_062340_864686_6702307C 
X-CRM114-Status: GOOD (  15.38  )
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

On 9/29/23 15:49, Eric Biggers wrote:
> On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>> index 7cab2c65d3d7..c99d7cac2aa6 100644
>> --- a/include/uapi/linux/stat.h
>> +++ b/include/uapi/linux/stat.h
>> @@ -127,7 +127,10 @@ struct statx {
>>   	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>>   	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>>   	/* 0xa0 */
>> -	__u64	__spare3[12];	/* Spare space for future expansion */
>> +	__u32	stx_atomic_write_unit_max;
>> +	__u32	stx_atomic_write_unit_min;
> 
> Maybe min first and then max?  That seems a bit more natural, and a lot of the
> code you've written handle them in that order.
> 
>> +#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
> 
> How would this differ from stx_atomic_write_unit_min != 0?

Is it even possible that stx_atomic_write_unit_min == 0? My understanding
is that all Linux filesystems rely on the assumption that writing a single
logical block either succeeds or does not happen, even if a power failure
occurs between writing and reading a logical block.

Thanks,

Bart.

