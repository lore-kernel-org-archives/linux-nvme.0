Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B57CD3427
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2026 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/8EmIfUXkK4i6WQDdd5nq5pu0xAfgin2bGfz4H6FIo=; b=HLvtp/0y+KozT/QVc23JnSg0YP
	9JwAybsdduqUriKLddPmfaQ/+WoTlaEpK2as4P8UO6sg69TADE7evdAJNTPQD4N+FtNI19+OfyvVq
	idMurFBG3G4949KQUrk2YMQrmcOSHK8ur3k88bg6qQm08gN2HoHVIDpCpxp9eNPr0HBewEJILzcBX
	2Sl45a/p+OfTTXd3qabLGbF2XXx7vGW9zOHDNacZwNzzaufBXUfEHV0AfqOllE0CfXZX+rKJKrBVJ
	rP5kZlAsaWgMawcWgHQUNDRyEgJ267zyr5MOYQk+o5bZFa/7Zp+OEG7sQmeGEk5tB7zEURGoIKLjS
	vOVTOgJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK0nZ-0000000EO6g-0gMC;
	Mon, 04 May 2026 21:25:53 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK0nW-0000000EO5c-2wdf
	for linux-nvme@lists.infradead.org;
	Mon, 04 May 2026 21:25:51 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2b46da8c48eso13025ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 May 2026 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929948; x=1778534748; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/8EmIfUXkK4i6WQDdd5nq5pu0xAfgin2bGfz4H6FIo=;
        b=cV33h/9xVSu6xwgBcpqClp9NSGVgSdC7epJn5fL2NNQja+tQmY/9uyZ4n81j0bym3f
         YgoJVcw4TvM+sa2gycTX+uy9BUeU6CT44QRc3/PeoW0D0IJhGBqd/KPrXrhidm6SPQli
         3C50od2EiSV2ynpKtaRaihkaC4Qez4Hh8HetrB5v3v/l+tQ4aWFzOiPf02Comu1am1tm
         IGorGPTvktNGGRFnqWFb97CJjf6MWbA/rXFCNJWVGECngyGSQOOosnXNNbT/SssbVXba
         cufXfzs/26wXrTNY6kH3nA6d/bgm3DrTcT4Mr254Y6BxxCobNp0TFBURtpuzQWLuZaty
         nsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929948; x=1778534748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/8EmIfUXkK4i6WQDdd5nq5pu0xAfgin2bGfz4H6FIo=;
        b=p0u44ni6+OokrOw9twRHopIlxZQ3Dwf/egcRma4+UzKKPA4GZTra/FxIaj9l+NTAMX
         eLUrp6katnxK2UX12aj81pp4Gey53lzgduPitNIeD5lDzSeWsZhkUOAddFVWcGGxgSNA
         ibxGFNzwtOKGZrsS9nKvo7H7Mfyubt376Y7k/WEF9gOMGXTQmtAZI58hQiMh/MrzcMht
         MpE7quudCGSrZpGbsBvAxpkd3Fna30nRvRXC7OzDjsIiRCqvjIh/3VQrxIZ4OrBE7Vyq
         6dXqcwYiQtzkuRYLaXnfqArOQZSl9PVjmK1pg5WDDkblDViqrNnMLRQVL80JKLtwcGPz
         62lQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IJTE1Ktqz8Zg+nwPiWtkcTO6KDMAMjFHW1mozPdVBclvXEjuZmsL70qJqRvL4KX8N+dJGI8BNIqkG@lists.infradead.org
X-Gm-Message-State: AOJu0YznpjcAqiiKpHWkRBFhvKFpmEGVpG2CQuM5/e8J+xqtz+coaGUf
	DeQWTtnsBfFAXyTdpcTSy2KEAXZGg/0O/MTowNsKlX9ZBH2rrzol4vs8hc6vej2kCw==
X-Gm-Gg: AeBDieuj/wOxHMOCmlL4HJijFucnIr40SrZ5D6m1kyKh9RePyN3wa1+CSlH685RW7GG
	nR11NpHOL+i2CE6npZdOwsdYRd3OKKGDeDx+3UyCqg72KxzRX1svT1/ESJY2otb4a9vL52Ynibv
	KuTJ//7YHNfEjdKWOymFYo/7qpTVi6/lkK24Ykk8PDkfmvlw826dLCR7TKNWi0tfwzwbCaU+ZC1
	NM6zPCefuaMZ96LB6buy9NqrRoWYPpheU6D69kwiipIQodcvwIF6UG3TVzcCn19nmyRJyzWNWs8
	xp64IH8NiqNuT0THbju+UcBTHXXtxcjcn9jMsgHH1RHFhupA53/Ot3GKu1cxfR63xZ97XrGJFrq
	d/XAjO+LlMjeAwj30CBG4y1epB+Byul5hKRovcBUj6y6iMqxSib/KbND5fL1RYOOgU65Mu4M5dl
	yk8d6UExnZgFzQWNJystOz4+Kc000CdcIFbzHvOqdUdY8LRgRJL+r4im7KGNXtuVau6svXJre54
	6JdBww=
X-Received: by 2002:a17:903:3d05:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2ba530f0db5mr549245ad.1.1777929948029;
        Mon, 04 May 2026 14:25:48 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa91671sm115257035ad.13.2026.05.04.14.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:25:47 -0700 (PDT)
Date: Mon, 4 May 2026 21:25:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	kmodukuri@nvidia.com
Subject: Re: [PATCH V3 0/2] md/nvme: Enable PCI P2PDMA support for RAID0 and
 NVMe Multipath
Message-ID: <afkO1WExGV9-jv8b@google.com>
References: <20260416212633.72650-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416212633.72650-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_142550_748188_D2978DBE 
X-CRM114-Status: GOOD (  23.85  )
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

On Thu, Apr 16, 2026 at 02:26:30PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch series extends PCI peer-to-peer DMA (P2PDMA) support to enable
> direct data transfers between PCIe devices through RAID and NVMe multipath
> block layers.
> 
> Current Linux kernel P2PDMA infrastructure supports direct peer-to-peer
> transfers, but this support is not propagated through certain storage
> stacks like MD RAID and NVMe multipath. This adds two patches for
> MD RAID 0/1/10 and NVMe to propogate P2PDMA support through the
> storage stack.
> 
> All four test scenarios demonstrate that P2PDMA capabilities are correctly
> propagated through both the MD RAID layer (patch 1/2) and NVMe multipath
> layer (patch 2/2). Direct peer-to-peer transfers complete successfully with
> full data integrity verification, confirming that:
> 
> 1. RAID devices properly inherit P2PDMA capability from member devices
> 2. NVMe multipath devices correctly expose P2PDMA support
> 3. P2P memory buffers can be used for transfers involving both types
> 4. Data integrity is maintained across all transfer combinations
> 
> I've added the patch specific tests and blktest log as well at the end.
> 
> Repo:-
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
> 
> Branch HEAD:-
> 
> commit 88a57e15861997dd6fa98154ad087f7831bbead1 (origin/for-next)
> Merge: 81a0a2e4e535 36446de0c30c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Apr 10 07:02:42 2026 -0600
> 
>     Merge branch 'for-7.1/block' into for-next
> 
>     * for-7.1/block:
>       ublk: fix tautological comparison warning in ublk_ctrl_reg_buf
> -ck
> 
> Changes from V2:-
> 
> 1. Unconditionally set the BLK_FEAT_PCI_P2PDMA for md and nvme multipath.
>    (Christoph)
> 2. Add a prep patch to diable BLK_FEAT_PCI_P2PDMA in the blk_stack_limit().
>    (christoph)
> 
> Changes from V1:-
> - Update patch 1 to explicitly support MD RAID 0/1/10.
> - Fix signoff chain order for patch 2.
> - Clear BLK_FEAT_PCI_P2PDMA in nvme_mpath_add_disk() when a newly
>   added path does not support it, to handle multipath across different
>   transports.
> - Add nvme multipath test log for mixed transport TCP and PCIe.
> 
> Chaitanya Kulkarni (1):
>   block: clear BLK_FEAT_PCI_P2PDMA in blk_stack_limits() for
>     non-supporting devices
> 
> Kiran Kumar Modukuri (2):
>   md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device
>   nvme-multipath: enable PCI P2PDMA for multipath devices
> 
>  block/blk-settings.c          | 2 ++
>  drivers/md/raid0.c            | 1 +
>  drivers/md/raid1.c            | 1 +
>  drivers/md/raid10.c           | 1 +
>  drivers/nvme/host/multipath.c | 2 +-
>  5 files changed, 6 insertions(+), 1 deletion(-)
> 

Tested with NVMe-oF (RDMA).

Tested=by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

