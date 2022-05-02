Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82924C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWLh0z6KqZeTYvB813th6xGMGi8VpMVzB8UY4c474cs=; b=nphlIda83cctCk2tk+VAHxQYJn
	TyxCN/7eQLeyR9KGlDTuJ11uYU62d8Bgbg6Nf+sIlwfyxiOe9rC59Cp9MAHjs8FsPCeBmOBKXvF+B
	rrNRjHPq6MyZ0dQ3fKXjqoBxi/zFLMloABaKZFWoLo9gF2WBdkoxsCzddZoEXaHYOFz6vncSPqzMV
	8HHyt/yUJEyKgQC993lLW77fqk+F9BrDU6p6eK29937DzL5dvqhWxBPl4VFQsvjst7YyxV2h76Gxn
	nyiH/f6aDef/qAeT7Ei2D7lwr0udpk79cIcA1ziv83MCUWJF8WJB7Rrel+hcng1jUZhT1Kz4iKyRp
	EuWJ5img==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlcK5-002Sgd-V8; Mon, 02 May 2022 20:07:09 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlcK3-002Seb-Nh
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 20:07:09 +0000
Received: by mail-pl1-x636.google.com with SMTP id j8so13292384pll.11
 for <linux-nvme@lists.infradead.org>; Mon, 02 May 2022 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=UWLh0z6KqZeTYvB813th6xGMGi8VpMVzB8UY4c474cs=;
 b=uFZ3m09V2DNjuMRFG0vaMhvPIGbKSBxYWCK1xThA+zj5tr+aLVC8vCvly0DTtR5St1
 P6mO4YRDRHeFcacZxt2xmBTap3+S0637Xy4WMH8O0xVLo4RObXNYTQV9soDCLx+cOkDh
 Qnco/KqauwoftX9giN3bRxTm8KgnH/zr9/YA8PapStmToEnJG13xnF2Fyqs9DKcb13PD
 f76cgtag8rdE5Hj+vLRlndoSLcDitA45oR6Xzl7MOvagtyrL+Ur2J5ILVrAhSNEfRr5s
 IUnL/phQfbZMIO9BvYJeW+brbpC9A9Wpu7IdLnkQF+PlsEcRHgRMHDT2mNuVgLncn3cX
 5x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=UWLh0z6KqZeTYvB813th6xGMGi8VpMVzB8UY4c474cs=;
 b=4TpShMGCHZsQfk44cifnX8ts1+/ruRECRYCGVS4Kl3zSTFAl0SK7VXO/SdyTPF5vQg
 0hIIN8DtAhlncQJeW9GIDbyqgYeaqmFV4HTfb4DU2Pq+VhV6crv5La/7INJtIYTrXGaR
 RkFoibbcEWTkYXb86OvqMzKcKcFoEpkocKTFbm23wgrrn7HOev6NT8cpxWx+WJs7CDCW
 KJ975faxD8INl7/A30N5coE2ZMDjEfhecJINV+t0U0N/BLZtOMRXUE8A1vVl+jZZ0YH2
 T9kK5VUGQi5pR/5Ks1euxRml1GHBToz9s6jkPYuHMnvuEZYzNfPfOm0Xblc+GbgOVNs7
 whPA==
X-Gm-Message-State: AOAM532a2S2QjCH6OodZ3scNGQ18njMYbqx8ZesIB6V248ubAhSII9NM
 mAi49JZrgNZKeP9vhf2PjpG7yA==
X-Google-Smtp-Source: ABdhPJxNiO9Mi7wpl2iVkR3DmL1JNtpLX/f3/IzWB9+f3y904bkgPvPT6e6Ut3ClaexVwIwAZ1jiAA==
X-Received: by 2002:a17:902:a583:b0:15d:197b:9259 with SMTP id
 az3-20020a170902a58300b0015d197b9259mr13625813plb.51.1651522018557; 
 Mon, 02 May 2022 13:06:58 -0700 (PDT)
Received: from [127.0.1.1] ([8.34.116.185]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa786c2000000b0050dc762815dsm5082564pfo.55.2022.05.02.13.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 13:06:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: cgroups@vger.kernel.org, james.smart@broadcom.com, tj@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 paolo.valente@linaro.org, dick.kennedy@broadcom.com, linux-mm@kvack.org
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
Subject: Re: make the blkcg and blkcg structures private
Message-Id: <165152201746.5015.15962088646546569198.b4-ty@kernel.dk>
Date: Mon, 02 May 2022 14:06:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220502_130707_795977_FA524AEC 
X-CRM114-Status: GOOD (  13.22  )
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

On Wed, 20 Apr 2022 06:27:08 +0200, Christoph Hellwig wrote:
> this series cleans up various lose end in the blk-cgroup code to make it
> easier to follow in preparation of reworking the blkcg assignment for
> bios.  The biggest change is that most of <linux/blk-cgroup.h> is now
> taken private into block/.
> 
> Diffstat:
>  block/Makefile                |    1
>  block/bfq-iosched.h           |    4
>  block/blk-cgroup-fc-appid.c   |   57 +++++++++
>  block/blk-cgroup.c            |  154 ++++++++++++++++++++-----
>  block/blk-cgroup.h            |  138 +++++++++++++++-------
>  block/blk-throttle.c          |    2
>  drivers/block/loop.c          |   12 +
>  drivers/nvme/host/fc.c        |   26 +---
>  drivers/scsi/lpfc/lpfc_scsi.c |    4
>  include/linux/backing-dev.h   |    6
>  include/linux/blk-cgroup.h    |  258 ++----------------------------------------
>  include/linux/blktrace_api.h  |   10 -
>  include/linux/kthread.h       |    4
>  kernel/kthread.c              |    1
>  kernel/trace/blktrace.c       |   26 ++--
>  mm/backing-dev.c              |   19 +--
>  mm/readahead.c                |    1
>  mm/swapfile.c                 |    1
>  18 files changed, 343 insertions(+), 381 deletions(-)
> 
> [...]

Applied, thanks!

[01/15] blk-cgroup: remove __bio_blkcg
        commit: 2524a5783e7d49e7cd936f582485a2bb4567edd1
[02/15] nvme-fc: don't support the appid attribute without CONFIG_BLK_CGROUP_FC_APPID
        commit: 55d7baa371ad90d297daf4250720af77449fdec0
[03/15] nvme-fc: fold t fc_update_appid into fc_appid_store
        commit: c814153c83a892dfd42026eaa661ae2c1f298792
[04/15] blk-cgroup: move blkcg_{get,set}_fc_appid out of line
        commit: db05628435aa761d30b4eae481a82befe7a8492a
[05/15] blk-cgroup: move blk_cgroup_congested out line
        commit: 216889aad362b5b7e998a5371348b5e95d485dd1
[06/15] blk-cgroup: move blkcg_{pin,unpin}_online out of line
        commit: 397c9f46ee4d99024c64954b007c1b5762d01cb4
[07/15] blk-cgroup: move struct blkcg to block/blk-cgroup.h
        commit: dec223c92a4688f6c9642d640cfe15a99d289dd4
[08/15] blktrace: cleanup the __trace_note_message interface
        commit: f4a6a61cb6d40d9ae63e47743d33200f3efe3fe7
[09/15] blk-cgroup: replace bio_blkcg with bio_blkcg_css
        commit: bbb1ebe7a909db4de49777fb7676d5bf293f34c9
[10/15] blk-cgroup: remove pointless CONFIG_BLOCK ifdefs
        commit: 7f20ba7c42fd899557cef7d001f48711c3066ba5
[11/15] blk-cgroup: remove unneeded includes from <linux/blk-cgroup.h>
        commit: c97ab271576dec2170e7b804cb05f7617b30fed9
[12/15] blk-cgroup: move blkcg_css to blk-cgroup.c
        commit: bc5fee91f26d8d1428fb744e5ad04b1417a85197
[13/15] blk-cgroup: cleanup blk_cgroup_congested
        commit: d200ca143ac6d0b4391b4e811e67e1a36461d501
[14/15] blk-cgroup: cleanup blkcg_maybe_throttle_current
        commit: 82778259eb201870d6d4f95ca4162de60a682343
[15/15] kthread: unexport kthread_blkcg
        commit: f624506f98b198e65b44da303f44974590fb16c0

Best regards,
-- 
Jens Axboe



