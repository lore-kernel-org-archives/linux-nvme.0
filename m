Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75FCC5AE59
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jun 2025 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pI8D5AUkm60Fo75qRERIbbgYVvFQrrXFj50MSrANZI4=; b=Vh8KzQXoy4PYJAs1+7rkVXJ+x7
	wPHop2XSat+DaJ5srmiPidMv3muyMx4Xb/Sb9kp654FRymQoIGkUANur8wEG8lXRhKpEXGXWAAe6d
	XuaK/XtQkTsHbudtAZB3VTuatPD+f7cEK8upqAQSajYqQYKSVP0TCDcoHH0mpIIjCiWDWo/2hNnlq
	RzY978DneKLRTtvn+IIWS+spdhbH0IK2oZSsH177/6HOvQxl1FMkktOGwJ7fD3Z70n4juqbVVPHcR
	ZoYXsJhRckTZ+c7f654p+pEcsE0uVmAm66G/ViqxhkpDMfkjMYc9+fxhletufwB3HK5xQjl/iPaH3
	Vyr1LQhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNBF4-0000000FjNn-31zO;
	Thu, 05 Jun 2025 14:06:50 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNArL-0000000FgDi-0tul
	for linux-nvme@lists.infradead.org;
	Thu, 05 Jun 2025 13:42:20 +0000
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-86cef0b4d96so24503839f.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Jun 2025 06:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749130938; x=1749735738; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pI8D5AUkm60Fo75qRERIbbgYVvFQrrXFj50MSrANZI4=;
        b=NPtqRpLKxN7oIQLX0hrdc1eUCY62QhyjyhVrRmov4jXMzmNvhnI488P+0nD0KTXZAB
         ahtgqifnGGzSi+r9XDArXlUvVK2a7PW5ICGSBq+V2uTpEKWgzVc2get1n1EY8Qn7MtYM
         WVQg0ce+rOIVAyKZCJ/JW3/j8mIB4+2+JsG0KdvueqZ71o4jFIfGHxwO/fpwD05JYGum
         xHaXNNulRSOU431nIKz54byDcDBQ5n73R0/pg0ckl2Yd3HLDYn3scE9m9apiN4SPiwW6
         RvvA0+Cf9JDmYdmFVsQb+B9x4SgxIQEDCZbtIlGV3zN5+Xrm9HsivkD+Dl4YaGoTDVIb
         NsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130938; x=1749735738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pI8D5AUkm60Fo75qRERIbbgYVvFQrrXFj50MSrANZI4=;
        b=ZM1zXI9nYofTULh51D6o4u5StxAyJdwZ9oSIY9VJl8EoQY2+z+5qTNYOWP4V9tOPZj
         JzlmAgG51bMe7rifWxhsrNtByflbp2sg+eib8QDPCcN4Q9SFBAvsE0P207Np8XauXP/o
         jGdaebHs3KNUn/OCv33I2CkPh1ueg/hUPCFexQamEKsLgBtatTb1PjZdny3uJn1Pq6lK
         jtHrVLDrXhqdNn6c/gfS0elg0C2r6ywJID1jcITbbZmVjPXAHj6AORr/X+7oOpgSlvxg
         4zyotI1M+5dp0nTd4V+ARDobH49oFqnfHDizJRQa950jaqqoK0ruxpOir2FnieNSYTPv
         RJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwQTqn77D+Oxcq+v1T1FM0DFxt+6FYBG4o8lD0EBAaLmrDqLIvOGZas3TOjlssPFElszqhoN6k/vdX@lists.infradead.org
X-Gm-Message-State: AOJu0YzeHUkQpDq/cQsnT5X5mtoc/HfzOz4DdS4N6DSaaB3um+ZNrFUC
	a7hSbp3jBzV4JhdDQGRlAURKQDmjBga3mLhY5u2TlHEXUOX4dPNnWAtpQPe1bqqThY4=
X-Gm-Gg: ASbGncsR8oa9V120OsEzGA4ekOuBzsAcZjiw8Qn5VN/r1IkQg++aUyN4JqDkXcIyTLJ
	CVrSLb82BbDSCSolPQqQMXd4ge2gktMqMZ5pf69fB70UhY5nJQY8PcL7zJjiWe7tWhVzZkMkMga
	QUbsKUh6gRRWeCIaFXw06yqIrWLH1/HfCQ5BhYMFBiqUXfEa02sRB+Sa42lelHYxv06u+rz2qnX
	M7kia716D7csQv63aiIaVpHGpIRxMn0dKMDuIgyO3PGNTnaKcxyZgR+SMjGGANKAgZEUN3n5Nob
	CNt+v9QECW21NLg3bNz57XRT+3Qb8cTzi/knPmpEJ/2tcG0=
X-Google-Smtp-Source: AGHT+IGNhE4Q/55V5nWoOcc9q6/ny7tf0HY4NW3rcwPvzDDBGap67w67idXKdSn7t3obEfaI1RhzlA==
X-Received: by 2002:a05:6602:7218:b0:873:f22:92fb with SMTP id ca18e2360f4ac-8731c502c2fmr826279339f.1.1749130937774;
        Thu, 05 Jun 2025 06:42:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7efce43sm3296048173.117.2025.06.05.06.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:42:17 -0700 (PDT)
Message-ID: <cd702850-63b3-423b-b883-7b3737ef5e83@kernel.dk>
Date: Thu, 5 Jun 2025 07:42:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aEFkj8jfrDVGuG4_@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aEFkj8jfrDVGuG4_@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_064219_500283_A607DB6F 
X-CRM114-Status: GOOD (  11.06  )
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

On 6/5/25 3:34 AM, Christoph Hellwig wrote:
> The following changes since commit a2f4c1ae163b815dc81e3cab97c3149fdc6639e3:
> 
>   selftests: ublk: kublk: improve behavior on init failure (2025-06-03 20:19:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-05
> 
> for you to fetch changes up to 44e479d7202070c3bc7f084a4951ee8689769f71:
> 
>   nvme: spelling fixes (2025-06-04 10:23:28 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.16
> 
>  - TCP error handling fix (Shin'ichiro Kawasaki)
>  - TCP I/O stall handling fixes (Hannes Reinecke)
>  - fix command limits status code (Keith Busch)
>  - support vectored buffers also for passthrough (Pavel Begunkov)
>  - spelling fixes (Yi Zhang)

Pulled, thanks.

-- 
Jens Axboe


