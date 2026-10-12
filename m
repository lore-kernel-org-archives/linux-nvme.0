Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196B1CA9ED2
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 20:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=; b=nJAhWufOqe3URtikHtmZfrr27i
	SZ/F6a6HjY456scNAYIU6+NoLTcRWDD94tCDCrSbEEeejPj4XQraC5B7bNTucAtbOOT4z4ltTtb8i
	ZFRlj2zY4xbfvm6EOvrA3UaNUZuX88CxZQ+cIBmzK/w2ZkQuljKFgSCN6IjtnDoma7IOMIl8/qUa/
	1A/u1euW8wvdtzv9vCWy7RUcVju366E+74Fhq1hx7wcZIMqar84LdAGZxqcxqhRTpW0TZeyrvxXr9
	XxcUBbjsCawnqREYG5vowsMB4BTrdCdstqtDUbNe8eTFTQT4/O6xsEK4bogSS8BZDp3JG/dlmt7X3
	m0vY+bxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGMRn-0000000BSIK-0Nt9;
	Mon, 12 Oct 2026 20:16:35 +0000
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGMRf-0000000BSHd-20RK
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 20:16:30 +0000
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-81c5aac8478so1580762a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836186; x=1792440986; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=;
        b=t8aSvI8HjuRJbmyJnHF/DMqpTm4HJkH4UuK78ShbfqiGxaa+1nES9DvJVBB3bSqJ5h
         D5DElGitQcfXgmqiiR4egAVGNppbuHQVN8u9ZJflitc2XXQZCKzmCCMZjcM6/l/GB2Oo
         Vy2GOJszEmglNM0eh1KtGsMYHoFTClp1ri3fdQYCqLTYYjbuTp1h8ht5Txef4E0S036S
         htMpKC3oubWvSKbYlGentvoVf+ABj/ygxYKM8+IoKvsN/2no6TWIMD9zfyUsgm+Cu+JH
         cZSjD+nLybYWEaOflHyOZ6oTxcywUYeZxecIAFTC6BchB/bVBo6qXIkNVT4rK/1R3CwL
         0NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836186; x=1792440986;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=;
        b=rDRePBi4Xara+vYq4Voe9GvKRxjBvPCq00+tNmoxhb/bEwtgt19v+VO407AtakBqrg
         y1mW0uoLbjWhXHBlCjn0uSccISdEtyrxfDVPyrCxdNjnA7XWSkathalt+59Og0A+AKlm
         VZVbIbXKeOByhmT0nRw5fW+sHrqOtdMBUXD9/ARtmMDDALuioQTVYrAUfazpbstdUpe0
         mKTG5CTrmai7WqgF223mYsNF2YkuCTdbscHXKKdX+MwZxJb0wJT4aJ2x5NpFEmlW4e2Q
         /VLgVRhFkLimIsx5WmMse8UkxbE9HCIXvfwsxMnepJU8KxW1NmnFM12xH9VKMKGN1USK
         n4tA==
X-Forwarded-Encrypted: i=1; AKwUvByNzzunGIH5ycaFxP4N1mVHtwJJYLN19u3ilGZc9DeQm56uM8rTyQhTvcNKyb5d0UlbvWRxIHen3FT/@lists.infradead.org
X-Gm-Message-State: AFq9FYIWficHzThwcOjVOqijg/Lw4LtiR0WOrZXxpRyGWtZmAmqS5Hfz
	3B+pdw3Io2MRASNfCDGuKtACned4ueyWWWq83NA2p4i/CKNXyTiypbIAhb0ORnc6vRI=
X-Gm-Gg: AYBFou31ipvtz4ARzHUw2Wk6wE+MfS4L6YdfKbRpaiZMGXD0/Gv4/NjPJQEkFPiwiLV
	kufIpx36bKFnPEx0i5eEHr3tuFyA+PNaAdM5+cAM7naGZm1bUbnRr2Q4cr3b/wkPlUaOqfgRmw1
	D9Hn4u45FXfpOqnjcYoFXCCLZvsDmlHLv4uKCpVgoW2ehhvrvZe/H+dVzVGlOB7Wl0f6XysiKZ0
	dDY3DHZzY8kWAev8rGZVThlUSuGxHUN/amlMsx0XOrZGHVlw3OW3vGWCTeQEkL/FVy/6Ropnj7r
	Z7AZeAgV1G2hCDWd0kn5ZZxLNn+VGhxWZEyRTNIB5M+qd5A48P/WGBfcP3dU5jn21s71LyhrS1f
	1Kz/Qsptw0rYnNcRYLXqdylWcZrS9+9ePO3lgtjufijh2jmvW/PjC9jYoha1gbapisTl/yJ9vrg
	wSzY/tg0vGZuUaYx5yVq2J40KTiDV6xA+GyYxCOfpczUycRmQR0Wd0ax+MmSkAHITwRbyvq2+I9
	bWn6746FTcb8lIIPliSS4by28CF1Ju5WEUSrjWG2dNh15XBvHlugKLlgfjRXN+aLoKI
X-Received: by 2002:a05:6830:4104:b0:81f:92c9:1f80 with SMTP id 46e09a7af769-83095b2dcfdmr13038337a34.16.1791836185941;
        Mon, 12 Oct 2026 13:16:25 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039076d72sm10441653a34.12.2026.10.12.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:16:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
Message-Id: <179183618332.250226.7412463798702866633.b4-ty@b4>
Date: Mon, 12 Oct 2026 14:16:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_131627_705060_2A64E051 
X-CRM114-Status: GOOD (  13.67  )
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


On Wed, 07 Oct 2026 02:42:43 +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.
> 
> [...]

Applied, thanks!

[01/13] dma-buf: introduce initial file I/O infrastructure
        commit: b899f5d8a9594f3e5be7c481e4631521f0a6e42d
[02/13] iov_iter: add iterator type for dmabuf maps
        commit: f41f84796a1129838524d2aa542598c22822a2ec
[03/13] block: always adjust bi_offset on bio_advance_iter
        commit: dda48c57e1484f967727d827923d3fb47d6b8aa3
[04/13] block: introduce dma map backed bio type
        commit: dfc9cc23122deeffcbf562a0989c695e8505d54e
[05/13] block: add dma-buf support for raw bdev
        commit: 738881239a914b2d92cafdf1030c382f1614a293
[06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        commit: db93ee31780323044eb5d6279d89f6ae49493f39
[07/13] nvme-pci: implement dma-buf backed requests
        commit: bb3e58f540e95ad55bc7ba6a6f713f79b4e79e7e
[08/13] nvme-pci: add SGL support for the dmabuf path
        commit: 3676bad01d84421fbf8567edafac63bef9f648cc
[09/13] io_uring/rsrc: introduce buf registration structure
        commit: fa1925e901c00b00695edd29d053564a6de63d9c
[10/13] io_uring/rsrc: extend buffer update
        commit: b497df80ba7536cffb2c5364e725c0812135886c
[11/13] io_uring/rsrc: add uncloneable regbuf flag
        commit: 10b6521fae14c5941b3fd77d1a48eb7a424ee487
[12/13] io_uring/rsrc: add regbuf import flags
        commit: b5a1e426d22fa059eaac1106292ad60c8da52d17
[13/13] io_uring/rsrc: add dmabuf backed registered buffers
        commit: 4bb797852328975051b001189f3e3840cfaad2d7

Best regards,
-- 
Jens Axboe




