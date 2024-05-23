Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74E0C25B79
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bd3P8z++z4Py5GCTKSGvg+YlbvFP4LG0VPCbj8gvCMM=; b=3Cgyrzl12FbpEj2uo/vGIJFUA3
	VEtMLUnSN7fWIC/RIGIUxFZHS62R7RFTW1Xqm12hKMUNP/t5CfMV6wcbW0IDFkKcyQy6XvMLqLZ5H
	wsGxsIqWoJDTqPVGxmn2mgzACIdFzxHRLfOr37Oh+dInv7ptxQ+Zf08Qk2pAC4fG0unskbGf0ELaE
	p9zS/Kwc4w2ZcmaC6AxH14FqTKC6a0W6SwMkRAjYQPlHi0xawY5+oEygmMEwVEwkWz2oHepduyNEO
	ilc5gSmzSSmbeUX2DPKK35PmFLCjg7KmK4zdqVJrGd1fbMV5xYVL/9tPpyJVwV3Kp4JQLUWt4GmIY
	/URJxddg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA5J6-00000005nez-1OFf;
	Thu, 23 May 2024 10:04:20 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA5J3-00000005nbf-0F0e
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 10:04:18 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354ccdfb014so423097f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 03:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458654; x=1717063454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd3P8z++z4Py5GCTKSGvg+YlbvFP4LG0VPCbj8gvCMM=;
        b=OzzAuNhzVJYFgCyY4xTbHATP/VBiv24rxAqxh5ZhmPs3A62OsCZCCMEcW3dwhUyQmg
         2cvoLbQU+QzDvHVrPUf9DA/ViddKe3mOD+SwjU9YdISf2Mto+olJNOPhTdXOEAm7ywMi
         AVLEcgj+J9pBNtCXIdRtZoNzqMIMj37w8HKHVtcq1H+CogGzIv9OEtgiYPHTzGGvDcyJ
         sjG6zktbN/dQwec8bczPb4kM35ppPMBN0EOYb1pOFH0cZqGHSACRK+x3y97RRBRtWeBf
         wd37jfTUW1sk0ZezVaQc9rRoLRoikcXTgQNfu3hGrjT0XeuJPOsv49dvA+d7CjYHgxl0
         wI9g==
X-Forwarded-Encrypted: i=1; AJvYcCXz4b4fDjbaWbGb4XVUJLefFNoi04aUJOYYtBxrFtdZPHqXKfOGkZLtnnbN8pj6zK4T4I/VzL1CRmLBiC8A9iUUvxyMDMIvUkJCz19rwLw=
X-Gm-Message-State: AOJu0YxQznzuEnDzUl/kx4SqRt5KBgarhUwN6ps3Uwb07OdA4WbzBip5
	f9KfBE4EKErmUNrfSfJhH8Nt9FCZ0Jr6dgw7rrclFmQOjVg8iRfm
X-Google-Smtp-Source: AGHT+IFyIO2XPgzZYHEK66p09ErSPkdKfqImAAYUI1Lz/+MFYKRSTu+LjjjoPFs7Q3kR9V0Jjm44aQ==
X-Received: by 2002:adf:fc4d:0:b0:355:1e7:a792 with SMTP id ffacd0b85a97d-35501e7aa06mr227451f8f.3.1716458654373;
        Thu, 23 May 2024 03:04:14 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354bae5ef22sm13653796f8f.67.2024.05.23.03.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 03:04:14 -0700 (PDT)
Message-ID: <a643075c-a51a-413a-a0a0-7954049ad918@grimberg.me>
Date: Thu, 23 May 2024 13:04:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240522091534.472449-1-sagi@grimberg.me>
 <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm>
 <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
 <20240522162845.GA16783@lst.de>
 <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me>
 <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
 <20240523065412.GA29137@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240523065412.GA29137@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_030417_196118_5CEE8C40 
X-CRM114-Status: GOOD (  11.64  )
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



On 23/05/2024 9:54, Christoph Hellwig wrote:
> On Wed, May 22, 2024 at 03:36:19PM -0600, Keith Busch wrote:
>> The below patch is what I'm messing with. I have a CMIC PCI NVMe and
>> nvme native multipathing enabled, and that can recreate the lockdep
>> splat 100% of the time. It goes away with this patch. Non-multipath
>> devices are harder to hit the lockdep splat for a different reason.
> I much prefer the srcu locking as it has real benefits as well over
> a global-ish rwsem.  I'll try to get to a real review in a bit.
>

Can you explain what are these benefits?

