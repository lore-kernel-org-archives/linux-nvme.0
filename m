Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CB2C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmzqUtuLFgT2c7u/W65oS618sUsNHDHfq220kvzNU6c=; b=R4XNPG2Ud/MaM0phBYYVhzvgTa
	COciAlSLJoXpxA7wjRKVEuZUBFhxbDrrdJdvXY6ebzv9UWyQpxr85A2skEPSSW8e06C0bNeppTSRr
	eYAWPtY8Tlqjul4Bl+AEHvgy0ONUODVoVMt26kgadYMBp6DbMqmutAMoWnAPm3zGc8j1pWhB1opH5
	+AhGXbxNK2cxlARdoTMspu0dHXCrErca6IZOX7guvHAjlG5Mh3L8LjydA9cPrqDqZ/kPyTEQCPFgj
	aDZOFZkGdp03fIMO6M+Gu52Y4TDEqNvYL+N8PMDKohJDc7wejx1ycHgojpy1nYASMETVBvznAg4RS
	IuVkcscA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnO8h-00000005MWg-48Fu;
	Wed, 26 Feb 2025 20:36:19 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnO8f-00000005MVu-0rTZ
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 20:36:18 +0000
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3d2b3c0b3fbso1743705ab.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740602176; x=1741206976; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmzqUtuLFgT2c7u/W65oS618sUsNHDHfq220kvzNU6c=;
        b=TRDObNhHiz3aK5RN+wndEy/fNO8lkXnYeVpllum6QCpHPEtNWjiFbvj+r6x2ZARylO
         eyo83YRRt9H8DH5jinhpTo6+YpzU2x6sxG17YhEWyI59di4E+DTinKmQDH/gvb68t6cB
         wn49+MsvmTRFzPHcXGrY40mK2t/obY7trUAuDPcMqtHWhYDjWDb78uIrfT72GYunQg1e
         DLHIwk7pWyn8j9Ibw1R3y2HGeQMWirWCODwcTJLNQXcIQaaeJJlPGZ9voX8KH37G1cGH
         GvmLjY49enB/3i7rYkFGZw2rrRQc39ssmGxVSMIUG5OLec9IGlPBqD56EpmfsK4HkGQ/
         heUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740602176; x=1741206976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmzqUtuLFgT2c7u/W65oS618sUsNHDHfq220kvzNU6c=;
        b=WwZn46PhBmoTCcMNpH+WUItkQUM6wx8qBMf+vaUYejvnT1aN+LaU4y+lkrNaJnhLHd
         vt82wIJW8Aluifb2ZJZJWl1zssQ7a4Dy16GaSDlDQwJsfP9fc9PQZ9WcmC/oCjl/FzDX
         zTI5FYQcg46WWdc3PGWVL1E988UU0K2Mn3BvYOFtWv37EetoqCX3JE0di87JYyk51jkw
         NFY4bvMvVsmj5d0BiBM30eeiB6n2oq3/9EtNsqXAJXtj78VvCzUkoN2Y0oNJAd3JPLIe
         ZrbDcP1x0gVX2+8r96LEwHjOoBuWEuEPZzLKDGmnpaK9jtJh9VEwSndFHbhE2Ulct2kG
         /JfA==
X-Forwarded-Encrypted: i=1; AJvYcCW99rPCP567C+WGQqDB5grG1hZKoMCex3Yxj0fHjz2LQOsLpdHHIKb4ekz7kbTONHRvkKDpJYrDN8BL@lists.infradead.org
X-Gm-Message-State: AOJu0Ywb+4uJzJpQ1lMVLI+Z86Bts2ypNI8AValYiRbbGkdCzbMWDB3b
	ACiFacj3nMzJ31ULcMfp5x0/K31EltUWAClgDUpYCDuruD/w8gYpLVRHPmTbmFM=
X-Gm-Gg: ASbGncu693mCUmnOX8H7kWgxP+QacM6rhfuJfOkXBa0Zc19gxbGlXR2Dhr3YPgyJeOc
	CG8JLy60/7KJiglvjJQgu1pDmyrkDpJA0fXSRSf13THedfwKq/gjpspNTE5/D6Iwh2iCUOn1iWH
	B962yuiRrRZDKKqLG20KBtWakKGjK3TMuic1maVozooe9CJMiRrLq2RiyHEZwqns3I1cSK9zAPd
	Qj+0vqEnLobK/ZZJGFs/sthrrbe1XDgJ4fKmt3PIBOvL1vrdINxJC9GRFvtPvg5sQsJ69xn2s+5
	PermYXiYArowtJkBUB7viw==
X-Google-Smtp-Source: AGHT+IFZhUDa0aBEcOlvPZddOMoMuQxC93b3SQFzlP0FnLZWxjGnGimX11rNVAbPFw+yMxcl4BKkvQ==
X-Received: by 2002:a05:6e02:1906:b0:3d3:d4a2:94a0 with SMTP id e9e14a558f8ab-3d3d4a29640mr41989075ab.8.1740602175816;
        Wed, 26 Feb 2025 12:36:15 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061fa8750sm12443173.136.2025.02.26.12.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 12:36:15 -0800 (PST)
Message-ID: <e7e3d82d-d983-4073-8cfa-91f2a3f2ea62@kernel.dk>
Date: Wed, 26 Feb 2025 13:36:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/6] io_uring: add support for kernel registered bvecs
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-3-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_123617_250104_67773EC1 
X-CRM114-Status: GOOD (  12.50  )
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

On 2/26/25 11:20 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide an interface for the kernel to leverage the existing
> pre-registered buffers that io_uring provides. User space can reference
> these later to achieve zero-copy IO.
> 
> User space must register an empty fixed buffer table with io_uring in
> order for the kernel to make use of it.

Just a suggestion, but might make sense to not use ->release() as
a gating whether this is a kernel buffer or not, there's room in the
struct anyway with the 'u8 perm' having holes anyway. And if we did
that, then we could just have a default release that does the unpin
and put rather than needing to check and have branches for the two
types of release. Yes the indirect function call isn't free either,
like the branches aren't, but I don't think it matters on the release
side. At least not enough to care, and it'd help streamline the code
a bit and not overload ->release() with meaning "oh this is a kernel
buffer".

-- 
Jens Axboe


