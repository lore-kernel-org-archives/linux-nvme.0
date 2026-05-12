Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D01CD343F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8muQlQAlVf5BGRqzxW2gYpYvZNW9VotK8fLXFUnhAzg=; b=KpUB3qgIpmXQySDxSv56cA1Yua
	kOsjMwXJ6lVsWq2r84yFEk1vFvRnEozhsfcivdU3DIV8Z/VNNw9cML9I8iFma2q7AMt5qs7PuYnEw
	tkkwSbjL1CJtYnB8bsDVuGbmYCkc6yXQ4ebA7REmJxCr7t9bR8rp4J74mW0EN9HcD+wz0Z0IEeJgA
	dOo3zYac0EdweoyoD5nmXFSx0Tqm4EhDy+4Jf3Ca56Mi8ghzB/5ClRt4eZ7uYBjA8p+l3drjpSwxW
	dchga6s+/XLZtVLpnwZCiz1ziKJyLWJwWZeIjHG+i1LepuqQq55IhP12ZyJ20uSFHehNi/tgDlsSH
	jv9Fv9aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMuqN-00000000Vh7-26a0;
	Tue, 12 May 2026 21:40:47 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMuqK-00000000VgZ-2McA
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 21:40:46 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-2b4520f6b32so10507018eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 May 2026 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778622043; x=1779226843; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8muQlQAlVf5BGRqzxW2gYpYvZNW9VotK8fLXFUnhAzg=;
        b=UGLq7HumFLodtOVD02YSEXHru8Wc7Kii/ZdEq0oHQ48f8ICEZz+ACc+I39sIiX7Icd
         4FdsaMbjoEXm4Ub7secaA4q3SzyeEP/PkJtaqLP78IL5Zrn8C/frFfoQrN1ZUckHXWpr
         LENQDguWNMFAZSZD0b2fwEJIHmKpdztAv0+v7+FrXZgXi4cvEpDmiSkX+ZjjE5nRtfp4
         I8E9O0g/MSK23b2kGOGXPYAO4GBPPqvDA/B+NC2lJH06puyTElJr6EDe0syEHjUyOlCd
         dmxKZykLVnfHzfK7oaUcAYnb+iw9ZBfmdfIUCvRESuzIylhH06VI6bX7z6tbnmrg+9KP
         7Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622043; x=1779226843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8muQlQAlVf5BGRqzxW2gYpYvZNW9VotK8fLXFUnhAzg=;
        b=gAtaOwipa/0/xyCHek59fxILuhYaefgArDsoBbbCLf5nqOW5SgKIJHlHAz4TFhUPJu
         aBg8JNcxG+JOONzf3d+tGdk368S3WYu6PlP9pTLdbwl677Tgn0S3FviidStzq3+u573m
         H0SD6HsIswoIrIHHEts3RGsyozU8/FRr5fQiKtWBhiI4mGtDfvnOCOpLwI8gzm5sTv88
         SKOQ5ehorH9JJd7+lekly7qtPrDtixLBGqKvBnkM38E6ltuKuv01ykFsVs7HUucZVtzp
         mfAHBlTXtkZds5gpZI79data/xHtKO3tXUYHXNBmlxRza1soGo49MwnR55auACU+vpgV
         PoMw==
X-Forwarded-Encrypted: i=1; AFNElJ+gZnDElMxvEBtmIfTTwikT0sQauVKtx6/zG84SWoX/ZQBKkPPpf7Bjx4em7wYTMRqftd/DmEG2rVkR@lists.infradead.org
X-Gm-Message-State: AOJu0YwpZx9VjuEj3GnRIcHopSQVhE7T46tmcgLYXjNmUFLX6+85iBNQ
	qbJUNSIOHQETayTlLwFOISrxJvsBzemhNRYEZpwPfG9ZKpGtZbizuxCmt23qZjZbWMw=
X-Gm-Gg: Acq92OFZmLlPdPpDnOqdym+laQjDAA29wz6reqKJjf/+/XS0R/s0e90xrwmdAvaiTCk
	OCUNRWenqnapeQJraiLtIY5mbr/95CEvRFY+muwsQq9svufIEPDsaxnBoE9R9ykO8oisS68AyM9
	vzg5fYBxctvxruM9cRj2sFfY9vLJao1Jw60dnSLH/rHFJuRRo94/IxU+gjn/sCNpy3rZKzHNVFv
	UScgVT6sT29TrKaMrRh7bOpqv+OLeVJ69kFAlktlUp1xIV5/EESqk/Xai7m3TPBvAdcBhDDvG6z
	nPujCn7WdKY+IpLq1yO3AT7AgI8ArtJLRwcBNm0rwFOAvzi0iPcL7wyd6fNv60nBUrh1t9WNWBK
	WImQ+ov41//YQDvYCct9aV1vsVBr9gejf2/IzeBcm3BWcMXS429FnmszUAF4DO6ahVBBBf854+0
	y0T87bs3J1hh2IjG77VirshXUGpVxZZol39B2BlG4vZ3E1
X-Received: by 2002:a05:7301:4592:b0:2f5:3fb3:4a76 with SMTP id 5a478bee46e88-3015468f678mr14314eec.10.1778622042772;
        Tue, 12 May 2026 14:40:42 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm24678850eec.4.2026.05.12.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:40:42 -0700 (PDT)
Date: Tue, 12 May 2026 14:40:40 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/15] TP8028 Rapid Path Failure Recovery
Message-ID: <20260512214040.GI10532-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_144044_653348_4D7635E0 
X-CRM114-Status: GOOD (  40.91  )
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

On Fri 2026-03-27 17:43:31 -0700, Mohamed Khalfella wrote:
> This patchset adds support for TP8028 Rapid Path Failure Recovery for
> both nvme target and initiator. Rapid Path Failure Recovery brings
> Cross-Controller Reset (CCR) functionality to nvme. This allows nvme
> host to send an nvme command to a source nvme controller to reset
> the impacted nvme controller, provided that both source and impacted
> controllers are in the same nvme subsystem.
> 
> The main use of CCR is when one path to the nvme subsystem fails.
> Inflight IOs on impacted nvme controller need to be terminated first
> before they can be retried on another path. Otherwise data corruption
> may happen. CCR provides a quick way to terminate these IOs on the
> unreachable nvme controller allowing recovery to move quickly avoiding
> unnecessary delays. In case of CCR is not possible, inflight requests
> are held for duration defined by TP4129 KATO Corrections and
> Clarifications before they are allowed to be retried.
> 
> 
> On the target side:
> 
> * New struct members have been added to support CCR. struct nvme_id_ctrl
>   has been updated with CIU (Controller Instance Uniquifier), CIRN
>   (Controller Instance Random Number), and CQT (Command Quiesce Time).
>   The combination of CIU, CNTLID, and CIRN is used to identify impacted
>   controller in CCR command.
> 
> * CCR nvme command implemented on the target causes impacted controller
>   to fail and drop connections to host.
> 
> * CCR logpage contains the status of pending CCR requests. An entry is
>   added to the logpage after CCR request is validated. Completed CCR
>   requests are removed from the logpage when controller becomes ready or
>   when requested in get logpage command.
> 
> * An AEN is sent when CCR completes to let the host know that it is safe
>   to retry inflight requests.
> 
> 
> On the host side:
> 
> * CIU, CIRN, and CQT have been added to struct nvme_ctrl. CIU and CIRN
>   have been added to sysfs to make the values visible to the user.
>   CIU and CIRN can be used to construct and manually send admin-passthru
>   CCR commands.
> 
> * New controller states FENCING and FENCED have been added to make sure
>   that inflight request do not get canceled if they timeout during
>   fencing process. FENCED exists so that controller state machine does
>   not have a transition from FENCING to RESETTING. Instead FENCING ->
>   FENCED -> RESETTING. This prevents a controller being fenced from
>   getting reset. Only after fencing finishes the impacted controller is
>   reset.
> 
> * Controller recovery in nvme_fence_ctrl() is invoked when LIVE
>   controller hits an error or when a request times out. CCR is attempted
>   first to reset impacted controller. If it fails then inflight requests
>   are held until it is safe to retry them.
> 
> * Updated nvme fabric transports nvme-tcp, nvme-rdma, and nvme-fc to
>   use CCR recovery.
> 
> 
> Ideally all inflight requests should be held during controller recovery
> and only retried after recovery is done. However, there are known
> situations where that is not the case in this implementation. These gaps
> will be addressed in future patches:
> 
> * Manual controller reset from sysfs will result in controller going to
>   RESETTING state and all inflight requests to be canceled immediately
>   and may be retried on another path.
> 
> * Manual controller delete from sysfs will also result in all inflight
>   requests to be canceled immediately and may be retried on another path.
> 
> * In nvme-fc, nvme controller will be deleted if remote port disappears
>   with no timeout specified. This results in immediate cancellation of
>   requests that may be retried on another path.
> 
> * In nvme-rdma if HCA is removed all nvme controllers will be deleted.
>   This results in canceling inflight IOs and may be they will be retried
>   on another path.
> 
> 
> Changes from v3:
> - nvmet: Implement CCR nvme command
>   - Fixed a bug in the order of members of struct nvme_cross_ctrl_reset_cmd
>   - Use kmalloc_obj() instead of kmalloc()
> 
> - nvme: Implement cross-controller reset recovery
>   - Now CQT has been removed updated nvme_fence_ctrl() to return
>     success or failure instead of remaining time.
>   - Updated nvme_issue_wait_ccr() to respect deadline set in
>     nvme_fence_ctrl().

v4 dropped CQT patches in order to focus on CCR. However, I came to the
understanding that we need to bring CQT patches back. The plan for v5 is
to be similar to v3 plus minor fixes came in v4.

Sagi - Does this sound good to you?

> 
> - nvme-tcp: Use CCR to recover controller that hits an error
> - nvme-rdma: Use CCR to recover controller that hits an error
>   - Updated log nvme_fence_ctrl() return value
> 
> - nvme-fc: Refactor IO error recovery
>   - Updated the commit message
>   - Updated nvme_fc_start_ioerr_recovery() to handle
>     CONNECTING case first.
> 
> - nvme-fc: Use CCR to recover controller that hits an error
>   - Updated log nvme_fence_ctrl() return value
> 
> - nvmet: Add support for CQT to nvme target
> - nvme: Add support for CQT to nvme host
> - nvme: Update CCR completion wait timeout to consider CQT
> - nvme-tcp: Extend FENCING state per TP4129 on CCR failure
> - nvme-rdma: Extend FENCING state per TP4129 on CCR failure
> - nvme-fc: Extend FENCING state per TP4129 on CCR failure
>   - Dropped CQT patches
> 
> 
> v3: https://lore.kernel.org/all/20260214042753.4073668-1-mkhalfella@purestorage.com/
> 
> *** BLURB HERE ***
> 
> 
> Mohamed Khalfella (15):
>   nvmet: Rapid Path Failure Recovery set controller identify fields
>   nvmet/debugfs: Export controller CIU and CIRN via debugfs
>   nvmet: Implement CCR nvme command
>   nvmet: Implement CCR logpage
>   nvmet: Send an AEN on CCR completion
>   nvme: Rapid Path Failure Recovery read controller identify fields
>   nvme: Introduce FENCING and FENCED controller states
>   nvme: Implement cross-controller reset recovery
>   nvme: Implement cross-controller reset completion
>   nvme-tcp: Use CCR to recover controller that hits an error
>   nvme-rdma: Use CCR to recover controller that hits an error
>   nvme-fc: Refactor IO error recovery
>   nvme-fc: Use CCR to recover controller that hits an error
>   nvme-fc: Hold inflight requests while in FENCING state
>   nvme-fc: Do not cancel requests in io taget before it is initialized
> 
>  drivers/nvme/host/constants.c   |   1 +
>  drivers/nvme/host/core.c        | 225 +++++++++++++++++++++++++++++++-
>  drivers/nvme/host/fc.c          | 215 +++++++++++++++++++++---------
>  drivers/nvme/host/nvme.h        |  24 ++++
>  drivers/nvme/host/rdma.c        |  30 ++++-
>  drivers/nvme/host/sysfs.c       |  25 ++++
>  drivers/nvme/host/tcp.c         |  30 ++++-
>  drivers/nvme/target/admin-cmd.c | 123 +++++++++++++++++
>  drivers/nvme/target/core.c      | 110 +++++++++++++++-
>  drivers/nvme/target/debugfs.c   |  21 +++
>  drivers/nvme/target/nvmet.h     |  18 ++-
>  include/linux/nvme.h            |  65 ++++++++-
>  12 files changed, 812 insertions(+), 75 deletions(-)
> 
> 
> base-commit: dd09eb443372f9390d36051d86ebe06e9919aeec
> -- 
> 2.52.0
> 

