Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B2ECC6B38
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 22:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXZP4XbxnB3Xr4hwB5aAnPFNOVfAFTaXEMu2fhfAi7k=; b=1dos54CoJdyZ4vb7UcOWlR4vd6
	mGJURiW66ZaXLie0zgNbucN/1VzGcl9T3/l982kL6Clps6AsNgvMYbZTaNIioAdez8uGCBhDnMpgR
	kPOgWp71oKnIiiOgIzZ2VSOvLntEGbSl4kVug+7U0aBI9EilGW3XDdM0a/NdstGCdZdTKbkdsUy+V
	k1atWpdmeCWhL91y65m5WAyHn43xdHkRjmBj6V3oJRgnvUXFy3wUiMt9ihx+b8K9/g+EA1+Qym1Pt
	Oy0BgheAwRZMNi8A+nnp9dl06dXaHMb5G2sRAQVPsm+or4MgjG+EcY0WN9Vr9CcB9ems1j2b5c9TF
	oo5nFNoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHU2z-00000001UyF-2hhv;
	Thu, 15 Oct 2026 22:35:37 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHU2s-00000001Uxk-1Dt9
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 22:35:32 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso2939614b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 15 Oct 2026 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792103729; x=1792708529; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXZP4XbxnB3Xr4hwB5aAnPFNOVfAFTaXEMu2fhfAi7k=;
        b=PVGd2C4uewz9BcSf+aa8o91npWZ6dgPM+AQWN7lYPJepbh6jjiaMrAlNf05P2XBwBj
         ilbuxREOVOKkJc41Sx4g7bUI2dUsBIRkZ3iVYBx8C1s4k36+L1DfHwWj4UPDDZKXOH7r
         BgExizyppEm9seh5rKGGw6eY9cz1/gxE9ZivzTE4ZJReagitpvTUx3x6Kry/2Cdh/LQ7
         v72F6DTcMkLHqkLqoj96muz6/AGseyGdUo479aFv0j9iE19cy1pm+vgiiRrCTIyRpOLc
         uktwzPP1aGfaIjs4SSqPEd25gNts7HfYPxDlhyzvqmMDV7n3AInTNd6ETgOnAUDkciDJ
         AlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103729; x=1792708529;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXZP4XbxnB3Xr4hwB5aAnPFNOVfAFTaXEMu2fhfAi7k=;
        b=QnMbfm6X6KkinoLVoEEvtI7CgJS3VfVnaPI0yQng/lTv3WIvw1TIX8r0hSzvRRbw1J
         vy1ZpJms4yvrUUd2uudImwgl0KToNpcfKTUoXvw0Lvr5vW1Mynk0RxVu5jksS/FW85S+
         ajS50OqUKr0Ki2ICd6/TYt90AvwDRbYJ4CEDFdRPnDCKpHKlU6lWcqELep2m133HNMgc
         ux1Y3DpDqbtapVJ7GB7naPNViWLQhO27eLJonEGR4a3CJxs4CtfFSEO5XAbZHCUqixpy
         C02DygDvMoJzku1xDdZxVGehFVHb5QXj9Fx4a5P/E17NaJ9omgv7pfpn+bSPhYa2QR5d
         8o1w==
X-Gm-Message-State: AFq9FYJJb1rFY7RuvUXHGCjttjX4NEgxGjTFGFHEbhE/l2I6tm81i8xt
	E9/FS4PvvBvJSXypijrqs1vOcGiI9NrqGOiTsomdMB+2dVLYPhKHWW3cqFtP15xF8UY=
X-Gm-Gg: AYBFou2V8ft7Is5/9HSNjYbFDpogeA62gI/NKXj6HOQMuDfU3p5nwBrYA8dAtBlt53f
	NID3SGVw4HKvtM4m53PFkwZCPKCwGv6uqUwSKCTTYd9720SIHBCh+kw8NCfv44unHEA1+VVWEDs
	TY61plTVunZL3je9FIK1rjojGa3xesuikjDxx7sVtDxY4ioGLDMHDXjQRUXedIpXC0YJZmB2GHv
	PFjxHrbtWL0WoR/TgWiSUPxTKUySaXbJ5ZVcK0E+4elw5yOBONdUQ5SGyBpM765YEyJwGO8Jbj1
	tq2GqLuUaFDHUtbe68ZR8tAlcikvmSLUzQYx3uDlaqsCzLMjydFWHlNX3+yhZK74k129Rn5rwV4
	M5tJ82PkIXvOYfP+jzEA9TgYz7hMEd/qsx/wJV6W7dkRF22SMUeIyDjmwGmvQKHwRpKhnWW2ocL
	P/6R5ZBXln0tdq7QLDPx6ht5KlFnjcCoz63mdTLFHnDgQa08X+hVRjHmagYbos1V4GZB7WWlK6b
	cHliDQA78Kf8e6FvBVheFhDoM9+rcCPgxuaIaKzqP7ZugRhxbTnF8Cmbg==
X-Received: by 2002:a05:6a21:b91:b0:3e1:f2b7:55c4 with SMTP id adf61e73a8af0-3e1f2b75903mr3101519637.32.1792103728884;
        Thu, 15 Oct 2026 15:35:28 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549fb561sm163231a12.23.2026.10.15.15.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 15:35:26 -0700 (PDT)
Message-ID: <498c0ca6-500d-46e0-bb7a-a42a8f578aaa@kernel.dk>
Date: Thu, 15 Oct 2026 16:35:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 7.4
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <atE8t_Gi-aJATAbh@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <atE8t_Gi-aJATAbh@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_153530_447986_3F2E05B1 
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

On 10/15/26 2:51 PM, Keith Busch wrote:
> The following changes since commit 85bffad4d2fea373a72d68bed8012e8cbccb8ee7:
> 
>   block: simplify disk_zone_set_cond() (2026-09-15 06:53:06 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.4-2026-10-15
> 
> for you to fetch changes up to 2e8e30b3cf9f165e1a1d079331543cb7f2ad0e0c:
> 
>   Revert "nvme-pci: clamp max_hw_sectors based on DMA optimized limitation" (2026-10-15 07:20:49 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 7.4
> 
>  - Parallelize nvme-tcp I/O queue setup and use the caller's network
>    namespace
>  - New multipath sysfs attributes for path state, available
>    iopolicies, and fail on controller loss
>  - Multipath fixes for failfast/ANA path evaluation and discovery
>    subsystem iopolicy reporting
>  - Apple M4 ANS2 NVMe support
>  - Traffic based keep alive support for the target
>  - DH-HMAC-CHAP hardening for host and target: enforce bidirectional
>    auth, require auth before property set, fix state UAF, reject short
>    payloads, restrict secret visibility
>  - Target reservation preempt fixes
>  - Target passthru I/O use-after-free fix
>  - Fix out-of-bounds reads and memory leaks from device and host
>    supplied data: FDP config log, ZNS zone reports, file namespace
>    range errors
>  - Enforce partition checks for unprivileged passthrough
>  - nvme-rdma fix for bogus remote invalidation
>  - nvmet-fc fix for recursive locking hang on port unlink
>  - Revert DMA opt max_hw_sectors clamp due to performance regressions
>  - Misc cleanups

Pulled, thanks.

-- 
Jens Axboe


