Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F59C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 22:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8YPAo6DqbsMVg6Ri6bNiswwkF6xI2FBJTxOjuva0Qs=; b=Qd2lwd43NMZ9bYq0pn1kfZA43J
	ZNa9gBConqFPRCK2UD3Y1+HyE0OBBf+Xogb8PlJLyRkVQt/AnnKpetTTy0Q8nrxkeM2FKJk5dcsgY
	6ThFYAJq8dS133HCcV8nSMlDlcHYT++icnyYoAKCXrxmK6djKffzFLKU8o13a/XShmQ7iOZQDRXGd
	v3DCrB0RvHv9esRkbQSw5KAUnokcnP8WEUQVbluG7MEWge5Lb7rv7vdhJXN5+OCJHizkRjYXsldtA
	KIfDHBbSFYw6iKmMTaRHSRjI4ygEIyyrrXtjikz/yKKNyohVJDbyyPSKegaVdbaooa9mFAZpTex58
	u6329A0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7jhH-003YOA-2I;
	Mon, 27 Nov 2023 22:03:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7jhE-003YNm-32
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 22:03:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9061B614A2;
	Mon, 27 Nov 2023 22:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23FFC433C8;
	Mon, 27 Nov 2023 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701122595;
	bh=VchA1tgxwVTxQNQ9TuMtXiXeC00/0NV0We4Q9nNbaMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxRshwmtSSPOZWqff5lrBwmLYHZLn6hVMWTHiAjdt1JnZqWJ5gBZmhTvJwCDEFmmp
	 IgZ9kocxVYlmVtuNIqr7mpjM1lSffqEu3FbZyLlzu9YKcsibN/8Jg00ZhhmFRVjZuR
	 n1rTtiTPNJFvIg2COOs3WCeMOMLqL1ZVNNyaVtdkoPljXMofxryVk5xMK/aDZ9i0fQ
	 Rjdm4AKOH1QAgPsnfYlsEOoUsz47mNgo3+aQBKI01oT7CMDJJ4ReNBJrvS7GsPCMS7
	 nE9/Ix+dHNASzX3a3jjzeivT5AHwfAYYqqHA/0yuW80hOT648fGu8QjyfAB21WLQ7C
	 sTWZ+9bu7fAdA==
Date: Mon, 27 Nov 2023 15:03:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: check for valid data from from
 nvme_identify_ns() before using it
Message-ID: <ZWUSILjL_6fJXPgk@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127205657.25950-1-emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127205657.25950-1-emilne@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_140317_026539_820D83F6 
X-CRM114-Status: GOOD (  14.72  )
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

On Mon, Nov 27, 2023 at 03:56:57PM -0500, Ewan D. Milne wrote:
> When scanning namespaces, it is possible to get valid data from the first
> call to nvme_identify_ns() in nvme_alloc_ns(), but not from the second
> call in nvme_update_ns_info_block().  In particular, if the NSID becomes
> inactive between the two commands, a storage device may return a buffer
> filled with zero as per 4.1.5.1.  In this case, we can get a kernel crash
> due to a divide-by-zero in blk_stack_limits() because ns->lba_shift will
> be set to zero.
> 
> PID: 326      TASK: ffff95fec3cd8000  CPU: 29   COMMAND: "kworker/u98:10"
>  #0 [ffffad8f8702f9e0] machine_kexec at ffffffff91c76ec7
>  #1 [ffffad8f8702fa38] __crash_kexec at ffffffff91dea4fa
>  #2 [ffffad8f8702faf8] crash_kexec at ffffffff91deb788
>  #3 [ffffad8f8702fb00] oops_end at ffffffff91c2e4bb
>  #4 [ffffad8f8702fb20] do_trap at ffffffff91c2a4ce
>  #5 [ffffad8f8702fb70] do_error_trap at ffffffff91c2a595
>  #6 [ffffad8f8702fbb0] exc_divide_error at ffffffff928506e6
>  #7 [ffffad8f8702fbd0] asm_exc_divide_error at ffffffff92a00926
>     [exception RIP: blk_stack_limits+434]
>     RIP: ffffffff92191872  RSP: ffffad8f8702fc80  RFLAGS: 00010246
>     RAX: 0000000000000000  RBX: ffff95efa0c91800  RCX: 0000000000000001
>     RDX: 0000000000000000  RSI: 0000000000000001  RDI: 0000000000000001
>     RBP: 00000000ffffffff   R8: ffff95fec7df35a8   R9: 0000000000000000
>     R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
>     R13: 0000000000000000  R14: 0000000000000000  R15: ffff95fed33c09a8
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ffffad8f8702fce0] nvme_update_ns_info_block at ffffffffc06d3533 [nvme_core]
>  #9 [ffffad8f8702fd18] nvme_scan_ns at ffffffffc06d6fa7 [nvme_core]
> 
> This happened when the check for valid data was moved out of nvme_identify_ns()
> into one of the callers.  Fix this by checking in both callers.
> 
> v2: call kfree() on nvme_id_ns struct in error path
> 
> Fixes: 0dd6fff2aad4 ("nvme: bring back auto-removal of deleted namespaces during sequential scan")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>

Thanks, applied for nvme-6.7.

Interestingly enough, I think this is the same as what was recently
reported here:

  https://bugzilla.kernel.org/show_bug.cgi?id=218186

