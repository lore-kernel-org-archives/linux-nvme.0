Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E74D637BD
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 20:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FU0Uq6tZfqhLW7zTHB3UvLVsIx1+QgdH15vw3E3v+9I=; b=tJO9T0xsu5My68abTM5ztUGZQU
	YXvTetOXgHRQwQAEzlx1hqKmukkJTZkA+txLyRBhVSWCeBWLZ5SzXsMpuqzPOXl2vVQKSD0cJTU/2
	m/pNjLEm0HWRKVpiYM8+ZY8bPbGPMurkxu2p6VfqaomjMvr7ePLK4D8F6PUkW42nLPMUSWKXPGEvS
	HdVNwh4a1mRBOKdkYbQg61GqNHOtK1msQ9nC4HW3DT/1GZUC7AEs8v6nSgn25f7InPW1d1RmC1VbO
	aesxf8lJbxj/OM5Y9wfeh+1kSZf88D3IENAeiA/ZcgVOuBZ02NInC0q01r1GDMk/rTtHARaWpfq7/
	Tz/Xjvog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBKLF-000000080Iv-19zc;
	Wed, 13 Nov 2024 20:51:57 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBKLA-000000080HP-1LMz
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 20:51:55 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-295cee3a962so1455007fac.3
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 12:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731531111; x=1732135911; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FU0Uq6tZfqhLW7zTHB3UvLVsIx1+QgdH15vw3E3v+9I=;
        b=Fx3i5VS8tygMLAl/5Ud5GBB8D16+KyIEfkdGGFj17PPdqvO06k5jhiSYKY4RKCEFJW
         vk2acOnb60VyoJMjahcpEpvV6a2z+Hrdxt2fgOzJMRdX7lJW6OY+mr0lKsG8kiTQpXWt
         xfuLefu0ClvHhQIA6qHWN/QeZ6rfG/thIWAgZce228YWxnZh0I0fTLZjreNTOjaesOyZ
         uf0nz/tzcsJpC0ssNIhizwbmeC14+6zVY84m+bC37kX72//DtnRpj5NUyRatALmoLmtI
         cR+3O+gKR+bqWHTwlTsI7AC5zHdiRHcqzb+NIfpEQy7bwkBHhD1OYhu5eMnv8Yoj83wg
         NNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531111; x=1732135911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FU0Uq6tZfqhLW7zTHB3UvLVsIx1+QgdH15vw3E3v+9I=;
        b=gRPXjsWrn5U3N7gx+AEcu4tk1FsBxTxLNi7200ENNbmvc6pUEH7jELtTJNGEf0pphk
         XrQgRxt3qaBO5AOORTM1FuW2yZs3Iph3pUdu2TdKvZV32J3WHLm2ChrxK9Zu2TqrBLs+
         HhiyhQvrc8pL1KiTM8InBuSUuLtbEP4XGkAEskfEX7WsRA472nswDvInNfqCisNXMcu9
         pgX8pS0yfx+6c6nZnBYRn4/lu0N8dEXIHFjwAW7FNLxR+KCDIo886wKKX0NiQr4VdHdq
         tQka7xIZJ7mAwLi3+Tl3q86H4dAIKNYdnI74K8VbDtcOnSvANbdjLh/iXnPFENSvOHHJ
         auJw==
X-Forwarded-Encrypted: i=1; AJvYcCVcx/cFYT7qpWma2jaHZQxvnT3rVfUnJaUKQMZ0XofXfy7OpZfTLMHqxN/jscogM9hP2TZQ4+8KEQTI@lists.infradead.org
X-Gm-Message-State: AOJu0Yya2p3VimTzoBGsKXyWw2mTZ0obtJCscdEi988uf9Wxu21LXuHX
	AauL0JhVmRVM+ndWVjDETjAChvJfKjoAWVng5+pEOPy1ejvg2e2liIGSfNY1sKg=
X-Google-Smtp-Source: AGHT+IGezMqio38lqokF3/YlzSrsEv2nuKdbrSqS8PqApuQDKwmdb/YnN439LHoKX0bRZy3D+8M0gQ==
X-Received: by 2002:a05:6871:209:b0:288:67c0:1bbf with SMTP id 586e51a60fabf-295600f0491mr20870572fac.22.1731531111227;
        Wed, 13 Nov 2024 12:51:51 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e9337321sm1169214fac.46.2024.11.13.12.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 12:51:50 -0800 (PST)
Message-ID: <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk>
Date: Wed, 13 Nov 2024 13:51:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <20241113152050.157179-1-hch@lst.de>
 <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_125153_483136_FD748FC1 
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

On 11/13/24 1:36 PM, Chaitanya Kulkarni wrote:
> On 11/13/24 07:20, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> currently blk-mq reorders requests when adding them to the plug because
>> the request list can't do efficient tail appends.  When the plug is
>> directly issued using ->queue_rqs that means reordered requests are
>> passed to the driver, which can lead to very bad I/O patterns when
>> not corrected, especially on rotational devices (e.g. NVMe HDD) or
>> when using zone append.
>>
>> This series first adds two easily backportable workarounds to reverse
>> the reording in the virtio_blk and nvme-pci ->queue_rq implementations
>> similar to what the non-queue_rqs path does, and then adds a rq_list
>> type that allows for efficient tail insertions and uses that to fix
>> the reordering for real and then does the same for I/O completions as
>> well.
> 
> Looks good to me. I ran the quick performance numbers [1].
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 
> fio randread iouring workload :-
> 
> IOPS :-
> -------
> nvme-orig:           Average IOPS: 72,690
> nvme-new-no-reorder: Average IOPS: 72,580
> 
> BW :-
> -------
> nvme-orig:           Average BW: 283.9 MiB/s
> nvme-new-no-reorder: Average BW: 283.4 MiB/s

Thanks for testing, but you can't verify any kind of perf change with
that kind of setup. I'll be willing to bet that it'll be 1-2% drop at
higher rates, which is substantial. But the reordering is a problem, not
just for zoned devices, which is why I chose to merge this.

-- 
Jens Axboe

