Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B35E6895E
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02iLbC3iTtITjuPbkEliDJUg4GBHOjEBLS/N9zjh8aM=; b=ub3rLpIszXZ50rGHH9p7mSahPD
	jZfIKY0K5IIjrw5BeDnV+tlh2y4YI/JFm+oPNERqMQwxW7KByP4SO+QTVWu1MZTh51FKj2Z4jq1y1
	sv8RdpsRG4Tc2iQ6S/MXz0yFcYqnhmXLcX2B+YH0uJPvi23YUARkZueW17mchgSLRX4Je34u4QSlE
	KHp/V8vrHSp5MRpjjg3fVLXcB4AYQc9bksXZtLqjUt1ymToY+lcckTCuGN3hJCAyc8SWiD9xrZBCR
	UtpOAgDYvTEtJnnkpvbteM+w9O5D+mor3+ZAm3XMhdwKLHA8mq8smyIYGtrGjnMSgugjfedeA7QyV
	BUC/5Z1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Qos-00000002ysF-2QLV;
	Thu, 31 Oct 2024 08:46:18 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6QlI-00000002yON-1sAZ
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 08:42:38 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-53c779ef19cso730220e87.3
        for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2024 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730364154; x=1730968954; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=02iLbC3iTtITjuPbkEliDJUg4GBHOjEBLS/N9zjh8aM=;
        b=He9WUqYXUG4hdj8jX5QCJ4hddxyApTpuRzMRY9lcjXnWt7279Q/68+9mIji/wPBqU1
         21ph2DdZfCawweAeYr57HVgosn+DNEpSU7LSkdp3WUBLidIKwuXe0ADU8x5YSe//kwoH
         41MUK5nluhMHqw/8405OlIqpPteqiQRzx/l7us3XpM5PGUsik6LWechJRTmtT5rEkVQA
         eRr+JKTbkb2mIerBIrMI1CcfIAFSW1XiZuRMCpZTGp71Ros5XQ1NL5dgUVPWSo3LdLfh
         oE9akivgybMyyZ3w4MThF7JFt/Zibq2KFdMnN/K81Afimb4sf+BUgHx2Az9MjgHwzWZA
         MNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364154; x=1730968954;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02iLbC3iTtITjuPbkEliDJUg4GBHOjEBLS/N9zjh8aM=;
        b=bPeqNsMiYKOgRp9TQLUS51WOrPpJSTf0xXw+C9drhk7/cZvXef8xXEZ5bRUMkMe2XG
         APzkMRotoL6iwMLLGNVugzNcUzjq2JvOtDZ9hUGXRi3EYsdSFRMKwhV1/nwqnusKi+H7
         K9A9rZX9+VKbL94HSmxmwfUsEZOx3KQ9o1GdBQ0fgviJ6mpvzeRMcZJFF7kFxIvz3g57
         X7tMgxg1PkvRb3pXFYrUVxrwpglF/UFhyPtOL9xgyX8h7wWdVyTdxCr3W60GicrCqhB8
         R0WYFJCjtbduVAoE9JnBUHCw0zhKBIDjEBetY0DUlXuY4NgrOfBg/6JcX6ny+B99tbjE
         f97A==
X-Forwarded-Encrypted: i=1; AJvYcCUYUcrsmsEhgq699Y9pT3Gcffcc9Hvv3XdQ6KgtKc15gCvsdGa3MLyQkprKHngeQl0Yb7X6EuWVw1m+@lists.infradead.org
X-Gm-Message-State: AOJu0Ywz7HsC6w0PcNlk4DDZlNfGkVHzFZO6lQEnhjDZc3EnEho3N2SE
	pOP5IRjtKc3FaqlnNt10I1g1bd9sa7Lhj9CxsZl6Kysg2+iiu8pR
X-Google-Smtp-Source: AGHT+IGTEi0bPagxhD4bKTKhGYFpyxTC+4bMEYfcQEEu07zU6SWeFBn8aZ9dYYKZZHFHqUP01OEXEQ==
X-Received: by 2002:a05:6512:15a0:b0:539:9720:99d4 with SMTP id 2adb3069b0e04-53c79e4c3f5mr1086583e87.28.1730364154211;
        Thu, 31 Oct 2024 01:42:34 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c04esm131041e87.107.2024.10.31.01.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 01:42:33 -0700 (PDT)
Message-ID: <2fd45655-9847-44a3-adf3-14ced29abd33@gmail.com>
Date: Thu, 31 Oct 2024 09:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
 akpm@linux-foundation.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, klara@kasm.eu
References: <20241024050021.627350-1-hch@lst.de>
 <fa2f2722-fab2-4108-8d3a-f7da87bb9efa@gmail.com> <ZyLL-eXIntwBY5q2@fedora>
 <ZyLNqtmxsEt-VYIE@fedora>
Content-Language: en-US, sv-SE
In-Reply-To: <ZyLNqtmxsEt-VYIE@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_014236_527152_58C5B483 
X-CRM114-Status: GOOD (  26.40  )
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

On 2024-10-31 01:22, Ming Lei wrote:
> On Thu, Oct 31, 2024 at 08:14:49AM +0800, Ming Lei wrote:
>> On Wed, Oct 30, 2024 at 06:56:48PM +0100, Klara Modin wrote:
>>> Hi,
>>>
>>> On 2024-10-24 07:00, Christoph Hellwig wrote:
>>>> From: Ming Lei <ming.lei@redhat.com>
>>>>
>>>> The iov_iter_extract_pages interface allows to return physically
>>>> discontiguous pages, as long as all but the first and last page
>>>> in the array are page aligned and page size.  Rewrite
>>>> iov_iter_extract_bvec_pages to take advantage of that instead of only
>>>> returning ranges of physically contiguous pages.
>>>>
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>> [hch: minor cleanups, new commit log]
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>
>>> With this patch (e4e535bff2bc82bb49a633775f9834beeaa527db in next-20241030),
>>> I'm unable to connect via nvme-tcp with this in the log:
>>>
>>> nvme nvme1: failed to send request -5
>>> nvme nvme1: Connect command failed: host path error
>>> nvme nvme1: failed to connect queue: 0 ret=880
>>>
>>> With the patch reverted it works as expected:
>>>
>>> nvme nvme1: creating 24 I/O queues.
>>> nvme nvme1: mapped 24/0/0 default/read/poll queues.
>>> nvme nvme1: new ctrl: NQN
>>> "nqn.2018-06.eu.kasm.int:freenas:backup:parmesan.int.kasm.eu", addr
>>> [2001:0678:0a5c:1204:6245:cbff:fe9c:4f59]:4420, hostnqn:
>>> nqn.2018-06.eu.kasm.int:parmesan
>>
>> I can't reproduce it by running blktest 'nvme_trtype=tcp ./check nvme/'
>> on both next tree & for-6.13/block.
>>
>> Can you collect the following bpftrace log by running the script before
>> connecting to nvme-tcp?

I didn't seem to get any output from the bpftrace script (I confirmed 
that I had the config as you requested, but I'm not very familiar with 
bpftrace so I could have done something wrong). I could, however, 
reproduce the issue in qemu and added breakpoints on 
nvmf_connect_io_queue and iov_iter_extract_pages. The breakpoint on 
iov_iter_extract_pages got hit once when running nvme connect:

(gdb) break nvmf_connect_io_queue
Breakpoint 1 at 0xffffffff81a5d960: file 
/home/klara/git/linux/drivers/nvme/host/fabrics.c, line 525.
(gdb) break iov_iter_extract_pages
Breakpoint 2 at 0xffffffff817633b0: file 
/home/klara/git/linux/lib/iov_iter.c, line 1900.
(gdb) c
Continuing.
[Switching to Thread 1.1]

Thread 1 hit Breakpoint 2, iov_iter_extract_pages 
(i=i@entry=0xffffc900001ebd68,
     pages=pages@entry=0xffffc900001ebb08, maxsize=maxsize@entry=72, 
maxpages=8,
     extraction_flags=extraction_flags@entry=0, 
offset0=offset0@entry=0xffffc900001ebb10)
     at /home/klara/git/linux/lib/iov_iter.c:1900
1900	{
(gdb) print i->count
$5 = 72
(gdb) print i->iov_offset
$6 = 0
(gdb) print i->bvec->bv_offset
$7 = 3952
(gdb) print i->bvec->bv_len
$8 = 72
(gdb) c
Continuing.

I didn't hit the breakpoint in nvmf_connect_io_queue, but I instead hit 
it if I add it to nvmf_connect_admin_queue. I added this function to the 
bpftrace script but that didn't produce any output either.

> 
> And please try the following patch:
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 9fc06f5fb748..c761f6db3cb4 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1699,6 +1699,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>                  i->bvec++;
>                  skip = 0;
>          }
> +       bi.bi_idx = 0;
>          bi.bi_size = maxsize + skip;
>          bi.bi_bvec_done = skip;
> 
> 

Applying this seems to fix the problem.

Thanks,
Klara Modin

> 
> Thanks,
> Ming
> 

