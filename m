Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9343D59D91
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 20:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gsVed5WgXtZPXSfJ2PXjLRbNCmFwRAyF31OH8siBSJw=; b=LR4dCToVxMjdl9+8Sd1CUqUKSt
	x5YYVQm0HNLiBfeHKL6DpHMBcJikcbfJ0m8JDBmqskalkfnl8c5shGLRS8TTUv0BVcdHv4M4Ixrzn
	KXYn94OZNitN1g05N20fvqtWcp6oUH9lmWF/j1n9qyyrcaE2Ll41ItnQNUjmpD9thSDumqRL9Go5C
	sQTmNOxUiBaDxGZ4+CTSRRuxYvQJxBEX4AW4i9pZxOPzLPsObhIu6ZrsNzn+RWx7Gttydt2ddR31s
	6LQbUvLwWmtNok5rhJ1Oyj5+KCF5gTX3vb1gFN8H8/fizoEKBb3ACIdv5Wrl/zK2lyYWkXqkY5naH
	4tuTzmpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU9Tf-0000000128i-0ZSk;
	Fri, 12 Dec 2025 20:10:59 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU9Tc-0000000128E-01dX
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 20:10:57 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-29f30233d8aso9016745ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765570255; x=1766175055; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsVed5WgXtZPXSfJ2PXjLRbNCmFwRAyF31OH8siBSJw=;
        b=XO+NoVXXii5bkK1/oT1fHGQMP4qF0aYLw7EMtbTkAtKCDAyEhQof26lAylv+0Ri5h4
         QZkN9+sXecRpgrxhy2bLueLzkKPD4826sZ0MIR3llLcGn82TUZOmwjT4s8hntPFE8Jjm
         kqUt7CEw4VmiVfO6x/g5rmEr9p0GCIeC59Hqi5DBSL3m4GJe230zxOz3HTv91K07k/Pb
         KQcOi96xF/JpnJYITuSYQEe8ef52DcOAujj/o0vWLWKuEf0uVjni9MsI/aerqzeGjhMb
         3SgCSwQrsGo1KdbiXsbvogaU+9R1qVre8dtjcLnDe65M6pwNX89hig1O4cnFhv8v1IH2
         t1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765570255; x=1766175055;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsVed5WgXtZPXSfJ2PXjLRbNCmFwRAyF31OH8siBSJw=;
        b=GLPTZ6Y8Px0bymdCZswd2uO2sFcHUsWjWNr72q+rbSYkiERbj+qcaLZotfUsIyntvh
         pBk35riZY/LQqpV+jZqb5mbl9TvF0VYid7ybHGMYBb98mMJ5itE3LpAlISYnBzc5y7Z3
         lyWTDBNxE5YL+an7xE+5AsvdY7SC4HhQHtNIL8xiVHQmANKAln9Ey3g+DIoM1jZCHr9p
         t9e7LwOFk3vRZc/AhMbdk+9ynOJOwKMm5NjA9+rAX5o0WR2onJB4F17PP1dpPM7Un9kI
         YK3ay0vm3KnBjWHCc5OmX1we/lgveyOMYD0ADmv3u2nwcBhbjyDpmVlWmt2TQiZjQI0l
         8w4w==
X-Forwarded-Encrypted: i=1; AJvYcCVN+owqWWyygDcnQBCGSxF22R6Sg38xAO35eMsmBA+kPyZZHNcb1nqd0GVAG68df4kV4IvY7IU6hl3F@lists.infradead.org
X-Gm-Message-State: AOJu0YzMWO5KRalXUPFE90E2FWKYaFiuNxmglZfDh/iLswjXT18L9AbW
	POjUcUTElfWxd7qlJJ4xQFy1njDs3y7NdF++tDjYjnesUbtFd5LScSeYylK2UfZ5h4o=
X-Gm-Gg: AY/fxX5yXAFa0VVWKjWbk72wujCxr84SLgrIjgU9/saipf/YQKAtS5Pj/tEAvb3AXxH
	Iep2yWQ9T2u1YMjzWpmVcqBW2c22PHrOwb+ufVg7tcWmQ3cxs9g0bUfEK/uJZ7cPKdSOmGb8hm1
	bvhNsHg3fRfBk+QCSqy20VqK4lxkHHoUPy9t53Hy73tgosTBV2nHYAZRhXzLthvcfhcjxUT0Ujf
	wTr3G9Rj+KT9J17pAt98LSbQWaqxb0NZ7AQmGLOEIBnHxUbUoeyFOj5yWHHWjQqpt7/n0kwRBPO
	qiNY2hmLW44tAoKv9JOJdhfzm0cSCjn/e1kUq3CmXQm6MP3LsX4fVvSxMXT+juIStSb8cP1xki+
	wA4ZE0Y1AdRm4u/cD1WuiEHMEe7HP5iSWXnkzw7WJuib6rqjGHQNijuHkxeQZ6DVSEmJUatWUpz
	lK92MBtv1cn2QAbkXMPAo1FlWYogCzS+qxOVHIhI029rvWksqofg==
X-Google-Smtp-Source: AGHT+IH4YKlBbDeLqTy95z05gm75S6dqOblA2F2FrB859WtV1ZEekn7/gpBPyoL8TMFo+3JpfAzaQQ==
X-Received: by 2002:a17:902:f688:b0:29f:29a8:608b with SMTP id d9443c01a7336-29f29a861cemr19807075ad.13.1765570255065;
        Fri, 12 Dec 2025 12:10:55 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38c7fsm62825655ad.39.2025.12.12.12.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 12:10:54 -0800 (PST)
Message-ID: <2729b31b-ba58-4f32-b71a-75bd07524ac8@kernel.dk>
Date: Fri, 12 Dec 2025 13:10:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/11] block: move around bio flagging helpers
To: Pavel Begunkov <asml.silence@gmail.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 tushar.gohad@intel.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
 <aTFl290ou0_RIT6-@infradead.org>
 <4ed581b6-af0f-49e6-8782-63f85e02503c@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <4ed581b6-af0f-49e6-8782-63f85e02503c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_121056_054683_F8881E67 
X-CRM114-Status: GOOD (  13.70  )
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

On 12/11/25 6:08 PM, Pavel Begunkov wrote:
> On 12/4/25 10:43, Christoph Hellwig wrote:
>> On Sun, Nov 23, 2025 at 10:51:23PM +0000, Pavel Begunkov wrote:
>>> We'll need bio_flagged() earlier in bio.h in the next patch, move it
>>> together with all related helpers, and mark the bio_flagged()'s bio
>>> argument as const.
>>>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Maybe ask Jens to queue it up ASAP to get it out of the way?
> 
> I was away, so a bit late for that. I definitely wouldn't
> mind if Jens pulls it in, but for a separate patch I'd need
> to justify it, and I don't think it brings anything
> meaningful in itself.

I like getting prep stuff like that out of the way, and honestly the
patch makes sense on its own anyway as it's always nicer to have related
code closer together.

-- 
Jens Axboe

