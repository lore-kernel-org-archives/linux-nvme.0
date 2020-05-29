Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E5EC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 22:40:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A007F20721
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 22:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LE0kvDlx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nH1QiA+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A007F20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2V5XtCvHJg+gAt5m6d6qavyIQ7IZw7sTOtpeLKXpxnc=; b=LE0kvDlx9XdPj6
	epeOMZwAHaJEzWmOB0hqxv+AaLGPtz4PGIQLdx8TFG/LkHjD9b5Tx1Z5t/XIFKQI/F5B6ci14ZfFQ
	Kf8ADolT6joYlgH3axGdNJis0FBYfXUenZd46sGRGlGBxt0BGF/6IW8KYJW6z203/7EkJVYsAdQ6n
	2zpoxnHxXM6JZfEPIjWBOsGiDPgZit/1XAdQpainYsg/xrGEMDteBxCP5tUbvpLjEtKwx13ZNsK2d
	t2gwsmsMDPxkJO9TzlneCR6WbYzuiwoHxA/mSf+5N+xDuss32mIg0ILNbmzRddghZ002NGFbKt8Vb
	YKos9xtCxHhEldhMJGeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jenfR-0007qr-Qo; Fri, 29 May 2020 22:39:57 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jenf1-0007oG-4d
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 22:39:32 +0000
Received: by mail-pj1-x1041.google.com with SMTP id 5so2054949pjd.0
 for <linux-nvme@lists.infradead.org>; Fri, 29 May 2020 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3SvGI6+FW1/OhXjcYh+qu+PkvAZr4CU1sl+aHPi5BkI=;
 b=nH1QiA+IRSDYm41wzzYncwFaM+lrDNn8Ti2XFcAi4YlaUw9LztwixK0pLNSdeHIyB7
 8bS61hIRSiOulx1iuyKF9nP4gpzLATvREps1+Y8sUHCTsMZ0rY+c1fgY5DukBD+Uegin
 1lLKtDr7RDXHpyWblpi+B9d4Ujuc4xdGVonklbCjbzvYQPtHToJufcxLYyR+p+Kh98lg
 7xb/aOq4xXK0qPSUlE/HFQp1mG3daOYUEb9TuOa7ktkFpy+7p82qFHo7IYkgx6GUZGuH
 8zk1bdAi4lwNOoqsXYgm3MyTYkenX/Q/gJXp2zUQOgLiLCvj9OzabgNt4M4CpTJUiGsP
 5U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3SvGI6+FW1/OhXjcYh+qu+PkvAZr4CU1sl+aHPi5BkI=;
 b=ltVxUoFS6K3S+c1sseVcPzLkZosS/oG/yYDlYeHWMOJgjlkZ07OD/Yp3w2sTYk9pxK
 qML3qN7DMKGqARg+O8hF/EoesOdLUX6UaFGF1bgiTzrT9fNrDbzHEXndEPmEg7Eyw4gr
 f+nS38XIDpcnn/0MZxaDqUCUk7MzoJcxHkNdfJwDFBfpPP3Mzt6MYOAUKTjS8NL4bFnn
 moBgBKzDnSM+T6hjKx+ymakjfJg9En9HQiRR9sjx8Gvn/FUg0wT7PFObAl4x5aoD81FK
 dSAeOVe9HycnA8/qpFYsgl09EwmTSmWjuOduggkPlwed9fmoE9HRWpklBHxr5GHxUvvN
 8fRw==
X-Gm-Message-State: AOAM533Gj0HrmAhu+1Okwzd0jpuvK9OsKMPaSSQO7Cva2iQa43wcU2Xs
 N5YNikArPc+MqGpR6EFMufL2zg==
X-Google-Smtp-Source: ABdhPJx+EbTbp9drKjVT1SBrBX1rRMhZ6tJHpQZ+IXg2BZcRTR0vnvD5aHP3y5FWcW+eFbCDEyco7w==
X-Received: by 2002:a17:90a:68cd:: with SMTP id
 q13mr11465889pjj.177.1590791970211; 
 Fri, 29 May 2020 15:39:30 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id m22sm374695pjv.30.2020.05.29.15.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 15:39:29 -0700 (PDT)
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
To: Bart Van Assche <bvanassche@acm.org>, Matthew Wilcox
 <willy@infradead.org>, Kaitao Cheng <pilgrimtao@gmail.com>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <20200529202713.GC19604@bombadil.infradead.org>
 <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0fc36e-fa67-a6b9-cc7a-d86d3f21cf2c@kernel.dk>
Date: Fri, 29 May 2020 16:39:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_153931_181947_C0BA4210 
X-CRM114-Status: GOOD (  14.42  )
X-Mailman-Approved-At: Fri, 29 May 2020 15:39:57 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, dhowells@redhat.com, clm@fb.com,
 deepa.kernel@gmail.com, houtao1@huawei.com, hch@lst.de,
 linux-s390@vger.kernel.org, chaitanya.kulkarni@wdc.com,
 darrick.wong@oracle.com, mark@fasheh.com, satyat@google.com, hch@infradead.org,
 borntraeger@de.ibm.com, ajay.joshi@wdc.com, gor@linux.ibm.com, chao@kernel.org,
 josef@toxicpanda.com, ming.lei@redhat.com, viro@zeniv.linux.org.uk,
 songmuchun@bytedance.com, dsterba@suse.com, jaegeuk@kernel.org,
 jlbec@evilplan.org, sagi@grimberg.me, balbi@kernel.org, damien.lemoal@wdc.com,
 martin.petersen@oracle.com, joseph.qi@linux.alibaba.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, asml.silence@gmail.com,
 linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/29/20 4:27 PM, Bart Van Assche wrote:
> On 2020-05-29 13:27, Matthew Wilcox wrote:
>> On Fri, May 29, 2020 at 10:11:00PM +0800, Kaitao Cheng wrote:
>>> There is a function named ilog2() exist which can replace blksize.
>>> The generated code will be shorter and more efficient on some
>>> architecture, such as arm64. And ilog2() can be optimized according
>>> to different architecture.
>>
>> We'd get the same benefit from a smaller patch with just:
>>
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1502,15 +1502,9 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>>  	return !(addr & alignment) && !(len & alignment);
>>  }
>>  
>> -/* assumes size > 256 */
>>  static inline unsigned int blksize_bits(unsigned int size)
>>  {
>> -	unsigned int bits = 8;
>> -	do {
>> -		bits++;
>> -		size >>= 1;
>> -	} while (size > 256);
>> -	return bits;
>> +	return ilog2(size);
>>  }
>>  
>>  static inline unsigned int block_size(struct block_device *bdev)
> 
> Hi Matthew,
> 
> I had suggested to change all blksize_bits() calls into ilog2() calls
> because I think that a single function to calculate the logarithm base 2
> is sufficient.

I think this should be a two-parter:

1) Use the inode blkbits where appropriate
2) Then do this change

I'm leaning towards just doing it in blksize_bits() instead of updating
every caller, unless there aren't that many left once we've gone
through patch 1.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
