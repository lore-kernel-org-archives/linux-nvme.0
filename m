Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73927606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fpcAnhAo;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L2LdUDY/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aMXzMChEGdcJMKKjeeeyUhIhhKoRWxvP81BBpiRyepA=; b=fpcAnhAoJRvLSK
	Yi6eij/ahASOxdppQgK746pYOHgTx9MOtsmuJbvrQw53Y1PxsR7ngM5i0VdA+S11FJXn6ZR8c4DLl
	+M9m8NHn5brsJ0qC2Dj4H+ca6qu8ouWRABfpIrkQMwQo4WhSZoVljW+bK8MPB7qzbAceWiUoES7lq
	cTQ0ui+3gigeU1ybsJg7pZlehqZ22W2jF2vvcrnrdzIisUG+WzTMuJie0KUdxgczK1OoDqt8aCcJ+
	tEdhJxboLvU/aim4B0yY8f9qZTmI616p1ts5DySthDHMDcvsrylQtrUbsh0sCZAtoNG8HDsAScV57
	pl8/UzT2irAhUIBE4EUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLhO3-00000004u9J-3EJp;
	Tue, 27 Oct 2026 13:38:47 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLhO0-00000004u8E-2Hei
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 13:38:45 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c315869241fso544402166b.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793108322; x=1793713122; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMXzMChEGdcJMKKjeeeyUhIhhKoRWxvP81BBpiRyepA=;
        b=L2LdUDY/zmB9pJ2v9GCivsKq8xfTS1Tb6lgtnIGMlgXJh/WzRDYpZDrGUC0zqGTEkv
         AlFxAZ2d9h9FwPwoqTKwEuXwpbWhlPddo2SXifVnX8X2TcwGil/037iacYfJ+uAhBmQu
         8smmNKhPqI4lvttf1PhglZii8q82vnkCfifyol8Jv74C9be5qpKcDqjbJVXEp4Bhr0yS
         z89SZEmYcelyo2d7BiM5h5bc3Cn03M3MdjapQYlIZOWv8XaM9xXMbT5bWLa/wHdWIsd+
         BjA1ksJul9h5es0vkV5Yz9i8h0dLoXj6D1vLtC39vwWRUNTkH+qPLRPtKruSdNwrTka7
         TDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108322; x=1793713122;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMXzMChEGdcJMKKjeeeyUhIhhKoRWxvP81BBpiRyepA=;
        b=WV83u4P32WBHXzteMJHSHH7L2QO3I+nWBboHCnhEO3p5WUCafhLUdBQ7Dms3IKQNUN
         /Z5lUIrMIy3P3iHmdjiAnJwb4NqisEDQiqtwaADW1b9k/0SVE8gWgI1j7CGbEWLZ0yAb
         s84orlVM+AdhU/na2GUjNyLoRwUz442sk8ag1poj56WJjqtyycFPHR+ZAHg1EN7BuDTt
         B/QYVaHuC2m1ln1N4JwhOhkY/23plpTjC9htm9vihxIUz8IENw/NA0slD0lN1Q0ysNpt
         KcPkVuIYAZnVd6tG8LRKb4DHlVvxh7H1PCB2w2RCgAqmwwTxM2KBZzYUVCAUEKBOV1Hg
         Z2jw==
X-Forwarded-Encrypted: i=1; AKwUvBweRXbteotylEF8JzwG9ktTlWbtn0s5E6QtXZ1JFyLPcsKqCnGRlY/SajtXXzkfKiuFpn9eGmRKl4gZ@lists.infradead.org
X-Gm-Message-State: AFq9FYIoSRNnr7Q1sGT3FiSO6rltAVPUYIEkGn3za8bq7DoFVjkdWl+S
	ilSv5nw4q1gonqR8+zte19fs7hhExmCP4YmFJHQYYzcIZKJn+yJsfqep
X-Gm-Gg: AYBFou27sbn+ip2UvfaAV9+VzeHdR/gX84iK7jqDbgvqEcpLUjQQszJOw8Hrw/Umvgj
	WTGTvcJK7rE8YiS1EHuqGNHDHXcllrl0ApxAjhptsKK39Wjdyf5VVXAq1BTuK9Loi+OaJkrgmjG
	z0H8oNX1NZTltDu7mrw0CC8l0/4kAXPjGh2iff5MFIN03+RfZd3tgkwyyYilm41OZAA14rKBFPO
	1gy8vZ1Uf0Xb+8k+JoNkEk03kswwtSXsagvK7VQ7NPZJi9DhQxdxVN/luwK01hriRoYOkqUF38R
	83SCqTaKRP04g/8z5DMIIdiBGDI0QrYSuOiZKl7veBNCF0UbSYGowq+pulIHAJGMSiR48tYd22H
	CZiglguXF6KlklTJ78JLiDtv7hoSUoQF4A7V3PBb7poeGM2MdIOc5p7X6ao1LWrZmy4dg5jyMOm
	IE4ZJendQkGEeZnx1exA0VTpKXSjZ2n2BhgnOD/L7U5iUDoi/UIn37bQK4Gh7UFR0KBSvniQxyI
	ZSqcf1VzywTuW7b+2AV3gJ24aK5UGGvLcdSYy4M7f7wbx3VtoLQEfJ+mTUGN6XlSMfPHVevnbcE
	k+7Sm/vy2YE94Npg2vlSGdCw2NnIJAxL9T8aRD72fLi+x5WIJCUBFgvaNX30M6VfhPutOKjtP3+
	EQ98qdKk=
X-Received: by 2002:a17:907:3f86:b0:c46:7645:874 with SMTP id a640c23a62f3a-c46bded79a3mr1114595166b.48.1793108322016;
        Tue, 27 Oct 2026 06:38:42 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649f69sm453325666b.43.2026.10.27.06.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 06:38:41 -0700 (PDT)
Message-ID: <dc128acb-d033-43e0-adb0-f866c638c7ae@gmail.com>
Date: Tue, 27 Oct 2026 13:38:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: reject dma-bufs larger than 4GiB
From: Pavel Begunkov <asml.silence@gmail.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20261021184658.644645-1-kbusch@meta.com>
 <20261021184658.644645-2-kbusch@meta.com>
 <7c1599a8-31df-4797-a794-bf5ba3d75286@gmail.com>
Content-Language: en-US
In-Reply-To: <7c1599a8-31df-4797-a794-bf5ba3d75286@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_063844_600530_0C3A0C58 
X-CRM114-Status: GOOD (  12.73  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 18:52, Pavel Begunkov wrote:
> On 10/21/26 19:46, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> The dma-buf offset is set in the 32-bit bvec_iter bi_offset. Reject
>> buffers that can carry an offset that would wrap.
>>
>> Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>> ---
>>   block/fops.c | 3 ++++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/block/fops.c b/block/fops.c
>> index 46cb86dd36d23..a974b423869eb 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/iomap.h>
>>   #include <linux/module.h>
>>   #include <linux/io_uring/cmd.h>
>> +#include <linux/dma-buf-io.h>
>>   #include "blk.h"
>>   static inline struct inode *bdev_file_inode(struct file *file)
>> @@ -1009,6 +1010,9 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>>       if (!(file->f_flags & O_DIRECT))
>>           return -EINVAL;
>> +    if (ctx->dmabuf->size > UINT_MAX)
>> +        return -EINVAL;
> 
> Sounds good, should be reasonable for now. It'd also be good to
> move it to dma-buf-io* as it's not a block problem.

fwiw, I was wrong here assuming that iov_iter's offset is also u32.

-- 
Pavel Begunkov


