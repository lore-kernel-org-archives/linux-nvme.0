Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5710C2D0CE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y1abM88BFe0lQRCbOZswUBP4pTWhgX2789Hxz6HQAYw=; b=kCpki4oO8DINa38mOZaN1qzTL7
	/Iu/36m/70XNht10hRzqTTf9A87fARWv4m423BE1PaiOdKSrxXbnJ3cDbf13iqHt2bm6W4AHy/Utg
	Hgj8WElT/9KODMBKYVtQYukc7gp4zdF4RSMWzDQAmcfbW2tEQ8yMUFtUKsena+x2sD8Ng7VmM4NvM
	Dqi7s4+ggwb9eh5y7Flz5z3lcDDhYXLoDKxtdBPTHw0E1zNbIMKI7kBMCtQPwxG7k4wkwmrdJzLK8
	o3jxQJhyRuD9qftukg2NmTVYTqSU/m88wIuH0tc4gjm4+6Z1InYMkFHyKHNsOcPQd3JdzveYF1guJ
	t5h2l4Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKfjW-00000009cz7-1EiV;
	Fri, 21 Jun 2024 14:59:22 +0000
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKfGA-00000009VYJ-0TD2
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 14:29:04 +0000
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5bad4e45863so126718eaf.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Jun 2024 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718980141; x=1719584941; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1abM88BFe0lQRCbOZswUBP4pTWhgX2789Hxz6HQAYw=;
        b=cDEtfp7B1SMBdcqIJOKWc93+kU5pviym5DcoEpZf/ggSpBKgdWeGSzeHc+qsHXP9qP
         KOfY81207FRFSnDjQvaI4T7FWJVQm201adAU1srtqHoLNz9gAfFpwLlopODuhaT/AQUb
         AlpPeVJe444KmZXyFPrGd+nqriejM960nspRJ9Gcd++rtvdR1IlB57F8nWFGTokw0KZX
         hdxhjVBc3dN9jBVN7dWdaLevZW2KHymCVyZCY4a2y83pWGrHLfnEiAELqGcYBn93Fuz2
         5DPWvWuyhuFgThSmRmwWXLlfBIr4u5T1fJcgFk/FyrpGiFMJT4UdLgxAbWkzx1DgFqE8
         pRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980141; x=1719584941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1abM88BFe0lQRCbOZswUBP4pTWhgX2789Hxz6HQAYw=;
        b=IB3pl1ns7XftO2J0p7FvPdGXVbCJ+3+1/uX4R1Qx4SEjdg4YTgfS0j4XhDjgBrwPFn
         rNqWA7y3kh7e7mNOd1gWeRlul2P3xiosDxqvKMKy3ndgKw2w1X0u2ou2R0v0vYNoWmvU
         LFfs5q8LGFOVOgJ9KA4+b3OLm6zeAdr7Sp7SJNso286MdcACLCkvUcmcSmeJErGCYrk0
         FVff90A3qCmVAgj41/dBsqIkUUig+aNuikgvXlLi0NIuQRjEEtFBAtUepWChFWHWUoPy
         SNbswgLoHtHDWibsiWP9cdAGpjsYxMasFZv20ISk97haSlLFTA4P0AgNyWXbHaYJQ2y5
         hNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+7gIh5OuS0U4BkzCTRBucM9dYnOr7aMSgug1LB7mWK0LsOIQWbkaEL27lCKKQCx/ugWl21FBZaJUydPZWioFWnkGc77dhZZpNeDcv92A=
X-Gm-Message-State: AOJu0Yyvr87/1mzb7sbuaUJ1F288hIgxlENIC7pmixcJE1XauSiWv3YM
	DtBJ/J2wLY/K7fF7yYjecfIr7U1p0JOG01IOGHTTU4J3zpkACBDYAjLct4ofPzg=
X-Google-Smtp-Source: AGHT+IEkuinnMEokNvg2WVwEkTmhWFZmN7sgYIOaiINLiCcfmqVoMGTXiCo/a5mwW2DIZdGNohN5Wg==
X-Received: by 2002:a4a:c60f:0:b0:5bd:af39:c9d9 with SMTP id 006d021491bc7-5c1ad9093ebmr9612314eaf.0.1718980140889;
        Fri, 21 Jun 2024 07:29:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d58f236fsm276528eaf.37.2024.06.21.07.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 07:29:00 -0700 (PDT)
Message-ID: <2159f1ad-98c0-4a71-acb9-5e0360e28bfc@kernel.dk>
Date: Fri, 21 Jun 2024 08:28:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 00/10] block atomic writes
To: John Garry <john.g.garry@oracle.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
 jack@suse.cz
Cc: djwong@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org,
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com,
 ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
 hare@suse.de
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <171891858790.154563.14863944476258774433.b4-ty@kernel.dk>
 <674559cc-4ecf-43f0-9b76-94fa24a2cf72@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <674559cc-4ecf-43f0-9b76-94fa24a2cf72@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_072902_336337_276F0653 
X-CRM114-Status: GOOD (  13.01  )
X-Mailman-Approved-At: Fri, 21 Jun 2024 07:59:16 -0700
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

On 6/21/24 1:59 AM, John Garry wrote:
> On 20/06/2024 22:23, Jens Axboe wrote:
>> On Thu, 20 Jun 2024 12:53:49 +0000, John Garry wrote:
>>> This series introduces a proposal to implementing atomic writes in the
>>> kernel for torn-write protection.
>>>
>>> This series takes the approach of adding a new "atomic" flag to each of
>>> pwritev2() and iocb->ki_flags - RWF_ATOMIC and IOCB_ATOMIC, respectively.
>>> When set, these indicate that we want the write issued "atomically".
>>>
>>> [...]
>> Applied, thanks!
> 
> Thanks Jens.
> 
> JFYI, we will probably notice a trivial conflict in
> include/uapi/linux/stat.h when merging, as I fixed a comment there
> which went into v6.10-rc4 . To resolve, the version in this series can
> be used, as it also fixes that comment.

I did notice and resolved it when I merged it into my for-next branch.
And then was kind of annoyed when I noticed it was caused by a patch
from yourself as well, surely that should either have been part of the
series, just ignored for -git, or done after the fact. Kind of pointless
to cause conflicts with your own series right when it needs ready to go
into the for-next tree.

-- 
Jens Axboe


