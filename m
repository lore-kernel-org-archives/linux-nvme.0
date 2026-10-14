Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA7ECC6B1D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/UfknVFgwY+ADn2+7Gfp8pJoPMV5PqQ31vPcFrLztQY=; b=2hBvy7OpRVvk+yA3kwOW9FJzxH
	rXKphYXIhl/4wFihkdbSrpWg0VHCRL/tUeoUe3H0h1nggf5gpt32RGEFSXwNi0S2ZnSV9GP4NTBzu
	9xri8viOSy507pyBJlL4nSWp/HG2yrUQr6MXJWoCj5r0oiSZNfjTYAHRhddD6QgPL9F2jkpsYTqEN
	xpIPrhOaE8vj1M0VUCFlRtXMA0wT36RN+V6F/ctOKbn7WVOEEz7uO7oJoXYZy7o2OdNg4t3kiQcDb
	pDwILWtOwEmSjUP4VOz5HRRcFA+6hj9bvN1AU6J98z/XA5JOPH/EWMqvj38a6CwHfrZE30FBCMmgy
	l+Tdy6vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGzGW-0000000FdAr-3cir;
	Wed, 14 Oct 2026 13:43:32 +0000
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGzGL-0000000Fd9y-29MW
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 13:43:27 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-6de08b2e447so1751320eaf.3
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791985400; x=1792590200; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/UfknVFgwY+ADn2+7Gfp8pJoPMV5PqQ31vPcFrLztQY=;
        b=IKhG/oFqFCqTXtrszBg7FSqlA08/dGZJhlaZJjPbuUgTyWG2EFFmnxon9mqPE/5sHP
         d8eOCiy+l034TRqy2HhY+f6OgmfovRRqijoh4fdul/z/5DGA5d59OSMBdA1iXp+BCZ3i
         hgNo/Vm2oPwXlOqa3kdwBPlzFjIE8GNmfed+Lvc9HIcad7AABO+CldpSg80sjaRRYgU0
         8ETFUbaj/4XhgZKaedvahnQ1FzbrUhXIlwXr4uyJCq0hJxh1UZD7XyrwuFOK2bA4gZqA
         +iKiRK6+nNs7OcRtYIs9w7kzqU7z7uYcAPRFC8HyDbkrg2etKSS3g8YWsdelTRQUKv5O
         N4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985400; x=1792590200;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/UfknVFgwY+ADn2+7Gfp8pJoPMV5PqQ31vPcFrLztQY=;
        b=BFirAF0rGsDba5yS/RqRiOLdt58KnWB01LYSu7lBXqQOJes0JrP3U99p2DOQnMwxYe
         lBPi96kf9hw2yFjeLDaDaZYavSJRQCUg/8kJAZq39Xv/qpr85K3pRWp4ft3gjXvX/VHU
         mUX79lPDLLWiK3oojL8b/Q88+z8y3QPAkFNjhDWGLS1vhnizNlRVEtzqXW0gbAMgjCUi
         RformlU3NZQyOueuhWoqUlCI2QpRaxrFtW7nG2weTmAEw+/qd0DZFINXYoDosE3AmyMh
         ps0w2rQB3VJ+1TtWMRE1Ub3FCILVYN/9NwPwWt2mSqI3IyHeBqC3nlj0fQOEVa4Kce94
         jWvg==
X-Forwarded-Encrypted: i=1; AKwUvBydDLkUTxEWDAQLD92NNcUctwudBsnEAvIltfIcnvxKkeOz1fDzoVbijwAkOWCOJqM9OiCy7dFhUwx5@lists.infradead.org
X-Gm-Message-State: AFq9FYJTbKFEl90EKzmGQ1mv6J9a9X1kq11D1/WanJEv3XKYNghSTRUx
	MJRZ2P3OXBFMSvom+5rAE1Q7P4J30Yx4n1+yLemLHnqFGdpIL8MM/pjvQRaU6xZSaOw=
X-Gm-Gg: AYBFou2UwNF8jLg2JtL+r/6zyK9WTCcQsmElakrz5460mKqK3bzOILcIIWDPami9Y7b
	Fg6fIrABOvFSqa6CuTuPpSrsdjaFtSQnhuwpvS82+d9OLSkHEoUguMA8wYU7v07L+PnaWoBzjCV
	bVBQgtsfZsHkrtJkS//UDZN6ApglQ0Pyo+3WRg542v2fpcBvPGFO3tGFNgGc+GI+2d+MqcAcfJE
	Pt9BsDXZkZMBjDeQrQtJM2C3Ts67RUdHd6Vq2ee2UrK0GTpPB4BzIsGKS/lAjpwrlSeXKgnj8vw
	50Esbh2+7mI6TzFHk1WTd6WIpuNgOd/i35qFP0I1ijRhS3NuXbYHOm6h9ZGvwDMbLpJWsub6yAE
	tjCBjUlgNbOWTioKAUhKuJACA1BTLQxIjxSacFGg+i1f20V18b3cgi5jUDXRtxh6FynuvrCVypP
	FlXnERtPOdTojuDiIMayL044jLH2tR5MoCQhwMioq842lVhBvqPhoPxCJW46Y7M0wIE+72a2F2T
	FaFVlIO2mdD5yDyVjnU//s/gSB9sHGC9IjOtP9LR98h5DeESINmbf8Oxw==
X-Received: by 2002:a05:6820:1c8d:b0:6fd:3c3e:3c66 with SMTP id 006d021491bc7-6fd3c3e3e7fmr1002063eaf.3.1791985400251;
        Wed, 14 Oct 2026 06:43:20 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb4e92asm2073695fac.6.2026.10.14.06.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:43:19 -0700 (PDT)
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
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
Subject: Re: [PATCH v11 00/13] Add dmabuf read/write via io_uring
Message-Id: <179198539824.583283.3195125120949504062.b4-ty@b4>
Date: Wed, 14 Oct 2026 07:43:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_064324_564738_4AD4C29E 
X-CRM114-Status: GOOD (  13.73  )
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


On Wed, 14 Oct 2026 12:01:58 +0100, Pavel Begunkov wrote:
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
        commit: 0d3120db2cbe0a8793650e19f0923968a406ca2e
[02/13] iov_iter: add iterator type for dmabuf maps
        commit: aeb3bb52052b3548b3acf0cc5606dbb5babb228b
[03/13] block: always adjust bi_offset on bio_advance_iter
        commit: 801503b9a66f7c2423b5e495d8e77e0f4447e5d4
[04/13] block: introduce dma map backed bio type
        commit: d88e44f43e939e6ac0ca8302c6f3c957b33aa5fe
[05/13] block: add dma-buf support for raw bdev
        commit: 839231d193932ca0d592c2859669066f7c43731c
[06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        commit: a03648e2efda070322cd4066abf4dff15be093c4
[07/13] nvme-pci: implement dma-buf backed requests
        commit: ce5e386c110815e3a29e3ba27d97575c28589c39
[08/13] nvme-pci: add SGL support for the dmabuf path
        commit: d5c8cfd41d2575c65c3f1d543017949e578a92d3
[09/13] io_uring/rsrc: introduce buf registration structure
        commit: 727a66ad21b013555eedfd84559cd4707717463c
[10/13] io_uring/rsrc: extend buffer update
        commit: a5819c456b716fa8bcb7792b942ab02b15e07fc5
[11/13] io_uring/rsrc: add uncloneable regbuf flag
        commit: 13b1690bb4767d3f1c847baf71a704c5f2da99e2
[12/13] io_uring/rsrc: add regbuf import flags
        commit: d218f3e381908da0e68429f3a4b764e666564c60
[13/13] io_uring/rsrc: add dmabuf backed registered buffers
        commit: 62e4bf5b25d4458cf8aa9dece9022359f39f2294

Best regards,
-- 
Jens Axboe




