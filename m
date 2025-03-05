Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CE9C19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ye8jYdlNGDHRbJBuQVYikUVt9cJikB2/kGvMNNsxwb0=; b=fpjqu1knBB6LlxkJxYlsF5K7Vq
	0QUk2pm7B24vyLDwCdg0nB+AxXcjY+ruCxcY6TgoAaml1jOUHBmnPtmxoXQQNU1iM6olNPX39tJKu
	aq9UTa8NWS/5x8UIq9fRPQl/r68K6+0YKGWnxQScK7tuYI/bG13fiQUyAzXDWBNPsfr8yTqqGa/0f
	Jza5VW/78CvEKODjySxCvWQuK7z6Pfx6XIZtXEHJtdMqA8Iy3sAdEip+ADBs5HGRZT0X115P+m91R
	uAxe5DvvCpnfSQA3vRSKBVYFdZuP36sYTvKvtmFs87+TiLjFb/sYRUlsgcDrLehK+6EJUlYsX8i3n
	f0xZUMSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tptKQ-00000008uRw-21EV;
	Wed, 05 Mar 2025 18:18:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tps9q-00000008knN-1HKa
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Mar 2025 17:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Ye8jYdlNGDHRbJBuQVYikUVt9cJikB2/kGvMNNsxwb0=; b=MK4dkFUjJkZKw4jzl+bOlKqOdv
	2m/NIcfB7/mjNfpjFsMoOBQkgRmzALzHnRuPzX/1N2hSB7ms2qPjVatl50bJBXZ11ssgRFhpoOVDu
	Uyp7KMSIBhiDP8yWeoAOa6V7kyEYi6pAw104wxqtk48V01OqUXeUqXCXBrsFczMLYirPFtaR1T1fP
	7UVjAKi0BrqDUIhXorTlVOKagQ+q3kRYIWrbjlHM61bkMic/AePyRhUeRp8v5HppvM94GvykCR4/X
	JiqJ2fr1jZMBm06tAdSoLzMxlXAnokJiS93v6S02CNyeXqFmApHbzHnRCu5rjSRl7OQYddbmRMye2
	txos0lyg==;
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tps9n-00000000eGt-1MTJ
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 17:03:45 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-85ae33109f6so231801739f.2
        for <linux-nvme@lists.infradead.org>; Wed, 05 Mar 2025 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741194220; x=1741799020; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ye8jYdlNGDHRbJBuQVYikUVt9cJikB2/kGvMNNsxwb0=;
        b=EzXileyigYxQRuWrlTM4EFG9DELMBNJT24XqJutPbKeOHfheiheM+pnct42eK0x/Lg
         t84QSivpgnC2XHr/Qeemik7vJtSdsBdCJZru91N3R+5hV/ny4pq0tNvOm/p1tOFOHOug
         Crov3TlD9bbqLldWVD6bDQdea2AWKtODg5uyUHCJBT+dOb4qbCSCMTCOZNx52htfp43A
         V/FunRYU3p3aIEumeIF+X6wxf6nJA0SFCP+CEbjZrKrLXhAposm7oOr33s7BOq+w+eVP
         0MV4GXKW3AbF1bpkhs72ZbHnKBaQmsBIKBeujMP/oHsYx+CAlROQL1wQSbYKXUOesotY
         2s9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741194220; x=1741799020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye8jYdlNGDHRbJBuQVYikUVt9cJikB2/kGvMNNsxwb0=;
        b=kq0CUMazfdWvi/1Pr6RFrj884VjYteZ1do+k96ujtxGreduYVSag3nJVVovVFIAQvR
         HYcbp6McE95JNsivze93bEsAdh2KjVk58G+GV0YOxjk2B/bf/WLUF1WN6LvXMYa7jB08
         YymA401xEk0BsEdXqQbL5HTJCXumebrb3iHrVIxmq5f0wh9rHTy7msKYf5QLfJB+lCPr
         /bxJlXZj3xU5Vamw6QjWBBqoU1TysvMibd3ZVvuVltzfhv4y8M/9MX+eAHaf3k8hCb0G
         TP/glAgDQl0GgV99d8RehfI+TlUCjSVTbfieLthqCw04Jls379++ExcIMyQnGY77UhvP
         F+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU5+62eS3P8wI/RcXnIHd0UE+QxeG5b9avYhA8HSrgjOUzMtNPZRNn/a24QchmdtjDWDXZf3wOetaRo@lists.infradead.org
X-Gm-Message-State: AOJu0YxpdJsnsgJLgQpoog/v8I552/5oA0pFeWV8Dkm2nm8xXErDiPE0
	YNTviMV8WBBmUkP4aFWRdv4ii9vmS4gbWkp7ESpq3MIHR0NoFBLBfnsbFzbNbFA=
X-Gm-Gg: ASbGncvPNP9nW5lwSP5yFaUe4sI5IANjs8IWU2mCgvLrlXUrugO5WJFrYkMsO2yF/Ek
	Bf+wHyCx4I68KpTzoufoeCuCXMOdxs0tOwaRTKdYRJtnG7rWikHfuha2M8k8fXpVMKiTDCZ4FM3
	2Cxe392W8oXGjV3BHOqFlt+99vK28v0siplR/u4/L05iR3UkMA5wRqEgdlHrOp6YkRSLGWqa9tu
	r5iuEp6BSGygzCzKJkNdfcGWzaVvvrulzOsdg7RNnDMHTDuUwVgK8FbAD8NAxER0bDtQOEdnn/I
	XYV7ayue295iXXmhsjToiih5PSSvb4CzxhUVGLwq
X-Google-Smtp-Source: AGHT+IE0j+KmAvI0GONGGBRb0yBcq84nelhQkWdG5WvM7FpdyUDmfmueemR8L5YM73nIkMZVBa983w==
X-Received: by 2002:a05:6602:368c:b0:855:c259:70e8 with SMTP id ca18e2360f4ac-85aff729c93mr545166439f.0.1741194219973;
        Wed, 05 Mar 2025 09:03:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85aed8bc2e3sm115220339f.10.2025.03.05.09.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 09:03:39 -0800 (PST)
Message-ID: <c5e6b923-69b1-47d8-b313-ba339eac9501@kernel.dk>
Date: Wed, 5 Mar 2025 10:03:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] io_uring/rw: handle -EAGAIN retry at IO completion
 time
To: John Garry <john.g.garry@oracle.com>, io-uring@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250109181940.552635-1-axboe@kernel.dk>
 <20250109181940.552635-3-axboe@kernel.dk>
 <2b43ccfa-644d-4a09-8f8f-39ad71810f41@oracle.com>
 <c64a86d1-36cd-46b1-82fa-4ac4a4cf9cd2@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c64a86d1-36cd-46b1-82fa-4ac4a4cf9cd2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_170343_493625_67E6A35F 
X-CRM114-Status: GOOD (  10.95  )
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

On 3/5/25 9:57 AM, John Garry wrote:
> On 04/03/2025 18:10, John Garry wrote:
> 
> +
> 
>> On 09/01/2025 18:15, Jens Axboe wrote:
>>> Rather than try and have io_read/io_write turn REQ_F_REISSUE into
>>> -EAGAIN, catch the REQ_F_REISSUE when the request is otherwise
>>> considered as done. This is saner as we know this isn't happening
>>> during an actual submission, and it removes the need to randomly
>>> check REQ_F_REISSUE after read/write submission.
>>>
>>> If REQ_F_REISSUE is set, __io_submit_flush_completions() will skip over
>>> this request in terms of posting a CQE, and the regular request
>>> cleaning will ensure that it gets reissued via io-wq.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
> 
> Further info, I can easily recreate this on latest block/io_uring-6.14 on real NVMe HW:

Thanks, I'll take a look!

-- 
Jens Axboe


