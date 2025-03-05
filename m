Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE7CC19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XIwiIj98skyy07bH2eLQbYMiaQkekGbv6xFJBSSdfSQ=; b=iRTQz0C+QkUcCN/jnzZUrpF9XB
	qQFDaI0cWfGWPYcK7XzjAhITzKDl8G9/mk8I33uXuWU47dg/pBrFUsg1eGUz6ncIWLS36OlIa9XkS
	6RWPhILq+Y1jqDzAjfItpUccrf0rdql4Przo1SSI29BBUlswf3O7jImMTp9MgmKXN+Bye/sa2Ex+X
	vuhAjrRzsL+ypaT5TPDxgAeAVdD2OK2SIcinenlwPhwBwhGSd00NI57uo1HOlEv+PO+Vh0xX3WuRD
	SeWBt1BWFPgFzYyPhwHrVVyoaU1oXX3UpIuNOfa/U3Ao++isHp7W8bpKRa+ur+y92NgbUxtbACChC
	L9Y1Hy4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpwEw-00000009L88-03EU;
	Wed, 05 Mar 2025 21:25:18 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpvti-00000009IFY-11V7
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 21:03:24 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3d2f5a932f5so23877895ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 05 Mar 2025 13:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741208601; x=1741813401; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XIwiIj98skyy07bH2eLQbYMiaQkekGbv6xFJBSSdfSQ=;
        b=GOK/eSQREmUDHctrZJ5y5oKIZ2D3szHKUnw1eBKAWp27bk7rptgIUlVYGinO+zf/c0
         zus7frRlnLNX4sYxPdhUwDyhxPkMv7D5YJNP1YAeLGSOW1IUPle5gtY5Nb7VcHSqqH2d
         3EKJ9gazibFZweXfORa5XkQuMwZCeY52gundIMfmzvzkl7WV79Jgqre943/eqKVBV5R0
         JJLXrwsN4sVa7z1b5qUv6JPc5mTdjiWVRoXlOJEUflZSJ8cF6NI5Ju9pc15tKIGteC/H
         sB3vk/E1HMDzsUnMguqyBj3WULMpk+HuGwjock6753zlT8tIoFY4SSRgAInkjnZTmxLA
         y+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741208601; x=1741813401;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIwiIj98skyy07bH2eLQbYMiaQkekGbv6xFJBSSdfSQ=;
        b=Gl0IJ08uSrBsK7npOUfAHakZomZLzg7bEkz1tQSc2pa7BCl0W3D11B1WxvRsBGE0MW
         9sRQoLvpbZ7/mcFDp1LvLLl6KIO+lCWFdpfI/+MHAfLgbIaGPUFg3VbvGQe5zUD/d8aZ
         zzN7+QG7YT8VsDn/iAKKR+c3xjVQX7e0VuQ5vflS17UPSDMUNpoFcdkunY9+M0CqrlYs
         Eh0fpk24IzRiPv5sHBpOeOROBB9uAFV2neOFWYytmIgNAcFqQ7nm+z4BPbcoRRSDbLNW
         BFnzpTv9fWlIpheaNg7HC1QIw6Q9z+NIybwxz2hXbYzRJdpFtMdbzu9arvZ2rXbIbsWG
         DySw==
X-Forwarded-Encrypted: i=1; AJvYcCWNLb0Ixe8vXgzFO3aXHlWkCONZ4Z/N9qEKhI2PVHj0TF5R7CNXQMdSBbAqxqBfOM9Pv6ZLxdmQ6mzS@lists.infradead.org
X-Gm-Message-State: AOJu0YxhQc3Aq0w+wo/B0puvCqm4oxrQCFdxmujNz367Yyc6kBVGVRVM
	bwfgSq2NuWnG+ar9zr89dwFA/y6CCFd94G/E4WPQFHNqOzG42/4Fwy1qLSsmus8=
X-Gm-Gg: ASbGncviNx45bT8Xju9a98F2wGRBC2ng3WehcLiuDupVCbx2vJ/5ukoICC+dB1/FZGo
	4kyq7fAowJerOQR++vT0EVRHLG616SI/62tR0zYlQ7T9T7nl0dcypsTJ9bD1UDZpD7bqeyTGEGo
	Y0CDgBk3RmKDJyD0pmsIHA+y41gbXVpVj8qJUeRreXUMoNEnQBao7jBLfAnVg3ntxaQzBnG6pYY
	Rcstf7nPiAg2K1zlHVJyaMp6sB3X2IUwdx8ZVEhVpDQxysPRiznSTZJuppkrmMYPVejCzC4nSCr
	9KMQ1LwqYyGVLv91lyVMUzpzlCJIM3+p3Jo2wjbR
X-Google-Smtp-Source: AGHT+IG/v2u21EGDnLSGquubBj9oAAhnw+TsxY8TSdXfeyiOJ+baorjX3aSDbwR9HZPEfWd9sSNDig==
X-Received: by 2002:a05:6e02:170c:b0:3d4:2306:6d0 with SMTP id e9e14a558f8ab-3d42b97ba4dmr51865365ab.14.1741208600910;
        Wed, 05 Mar 2025 13:03:20 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3dee7101dsm37071395ab.39.2025.03.05.13.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 13:03:20 -0800 (PST)
Message-ID: <b972fe33-c671-4ec2-8123-d8d9410b8c3a@kernel.dk>
Date: Wed, 5 Mar 2025 14:03:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] io_uring/rw: handle -EAGAIN retry at IO completion
 time
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>, io-uring@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250109181940.552635-1-axboe@kernel.dk>
 <20250109181940.552635-3-axboe@kernel.dk>
 <2b43ccfa-644d-4a09-8f8f-39ad71810f41@oracle.com>
 <c64a86d1-36cd-46b1-82fa-4ac4a4cf9cd2@oracle.com>
 <c5e6b923-69b1-47d8-b313-ba339eac9501@kernel.dk>
Content-Language: en-US
In-Reply-To: <c5e6b923-69b1-47d8-b313-ba339eac9501@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_130322_484107_0B2BF279 
X-CRM114-Status: GOOD (  14.27  )
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

On 3/5/25 10:03 AM, Jens Axboe wrote:
> On 3/5/25 9:57 AM, John Garry wrote:
>> On 04/03/2025 18:10, John Garry wrote:
>>
>> +
>>
>>> On 09/01/2025 18:15, Jens Axboe wrote:
>>>> Rather than try and have io_read/io_write turn REQ_F_REISSUE into
>>>> -EAGAIN, catch the REQ_F_REISSUE when the request is otherwise
>>>> considered as done. This is saner as we know this isn't happening
>>>> during an actual submission, and it removes the need to randomly
>>>> check REQ_F_REISSUE after read/write submission.
>>>>
>>>> If REQ_F_REISSUE is set, __io_submit_flush_completions() will skip over
>>>> this request in terms of posting a CQE, and the regular request
>>>> cleaning will ensure that it gets reissued via io-wq.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>
>> Further info, I can easily recreate this on latest block/io_uring-6.14 on real NVMe HW:
> 
> Thanks, I'll take a look!

Can you give this a spin?


diff --git a/io_uring/rw.c b/io_uring/rw.c
index 9edc6baebd01..e5528cebcd06 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -560,11 +560,10 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	if (kiocb->ki_flags & IOCB_WRITE)
 		io_req_end_write(req);
 	if (unlikely(res != req->cqe.res)) {
-		if (res == -EAGAIN && io_rw_should_reissue(req)) {
+		if (res == -EAGAIN && io_rw_should_reissue(req))
 			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
-			return;
-		}
-		req->cqe.res = res;
+		else
+			req->cqe.res = res;
 	}
 
 	/* order with io_iopoll_complete() checking ->iopoll_completed */

-- 
Jens Axboe

