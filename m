Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F210606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=epL9Cr0P;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=RTAFZ2x+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6Fr2y94eB7vF/SQa85O6565KP4ExGO7wSrwqxd2tRoE=; b=epL9Cr0P7abomJdJQdk6kKBxyT
	c6zKI351tplKyfmVNMw17fzx6QAy6P360dKuXyVeiMgFQYORoRArfcW+SxWGKCTJiJoy3bfnyafhy
	cmzdJf4cII7bGUDF1ExMxFtNP7CpL6BUJPmdZBfP6okH2+8wTWUCtr2+6G5PXLDiTcbM9hIp2z9FK
	FpjkUZc79LEYgBDpHbI1YilLhTg+7XLYGcm3VXGsUH/jfHV2n5Imyr91YnRTrJJxanaoz1UZDCy1O
	rBwBkaM4QzQtq0MG4Qv7JBb1fMuXD8XWCxBOZvqrZmRWFrz2lnP7SD5AkcoAHz1/d8GkZ35U2k0hm
	eKadBwiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6rv-00000004EnF-0toF;
	Tue, 17 Nov 2026 00:16:15 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6rn-00000004EmA-1mIB
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 00:16:14 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-38133db970bso509863eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 16:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794874566; x=1795479366; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Fr2y94eB7vF/SQa85O6565KP4ExGO7wSrwqxd2tRoE=;
        b=RTAFZ2x+9wzIXduKaytsfKDL5ThilUUwnhwwgiza3GBK+E6MWFS1tDtH6JTvQkpObe
         VK1SHIkroEwbR/xrGYIwTlp+Ni0Opf9OK9FlZWt6tyBwGEkXNY5X5vIzPqxXwyGgCZad
         vV2iwH7lsn1ZmgMiioVVxIZBylka+jrEAzV5L07JA0MAQMEiYBoMAeccHLRiJs7qDfw4
         nY2cA++VYYCygqzdGqYyKNkgEs71HQjQCp9gs1BSVSOzxzex5q6qTVGWXBMniQDfk7ru
         ojFTQUUMIzmtEF7aG884Jn6Ztehgrb6zshTBAJUOiENkQdg4ot7WmqkGka/PkychdpV1
         CYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794874566; x=1795479366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Fr2y94eB7vF/SQa85O6565KP4ExGO7wSrwqxd2tRoE=;
        b=Y7K/Q/utCcvgwPTK1Px7yJCChkrm2ImQDrahCIbPjgSus3OOTYjmr+wThVM65U7ZXC
         pLBrlxdz6h0KxvJuWWsOpifzMRxK0M+jIseRmj0VS5Z+rfKe5AYDlEzvEgvEfBIRcPEz
         KvPwZlxuohHqJJ0bmZJArYc1RmSsPKB81XzNKmJkN+V7kfTwvwnO0G9g0KCk1tQGufJP
         +1guhaz1fOmF0PjGp9NR3tNpwj2bb0g+1CgnW2SbW1ULKze697a9E5prN1uTT298De3s
         XG9Loue0DFOZD22REqiOot1P4fzraHCH5t3TiAWhq+HEo6vsbd2FJAcSfNXzEv/f4vZF
         68Gg==
X-Gm-Message-State: APuU4Z+srcUv25JbRmYXovNsq4/b8WOoo/Tinli+8ZDsnsptuzvyM7c1
	nNFh0ISxsm8a7bXWUW9/FD98xJhMMxKwV0anSDa4TIi4P4vC2Lq1GdVy4n+gXTBjbAa3VaZp27d
	n9ofk
X-Gm-Gg: AZFdTZdjT9nMrP+j7Xsi4638aDAuUYf2PpDY3YawgQ/wmZzUx/sGhM2mM59FpzWLe9m
	cVI00z6rfYEt/BXmBeHB5kDoe4sSKGXaw2Tx4ypS3UEaB2XOMTwq9X3OunYmfr+tg/AAdf5hoHL
	v306XIp/U2+j45nxXvHAjZB4JzZ/Aow0hGQP4jB/HPwaFsKEMxiawPMJqSo+rcwuEUsvSFOZEL2
	8c6RdNV6Fs9s8tvomR5iUEwdLrVKJQbfb6BBjP1OMZ3Ig5gTj/5Gfl81KLl0dTvN2rjXKAcXWzx
	LaY2mXrhBJGZ1vb7xOH1hclufQHttZCgjsigNyUWuTGxN1J9znX+6E5mwyr5PBwqXktbpBD9ULT
	eG1o91Etfm0BC2FB+hL7YSm7VnS4qM8sRl9VTP0Ql4jov4diMBrOV3lnNlxS/6MEYbWVprW+29e
	BSdju/vdwJZR8UEJeyHqBmwqCjc07pA+6gYw6Joozb5OnLRA133saTd+1ad1mVLzZvb0mGxW9XD
	chgMzJnhUZrws7cWMKlFsMwAhmCGAbbCTl2SpgPXHlMO2CZx60USAvDtlmmrWpcJtt49NZ278fm
	EVrazYTvNT3/Iv0yELQC+gXXWTvAsOwmbCSrol2l3ZEcODHk0g==
X-Received: by 2002:a05:693c:68ca:b0:369:f05d:6c5c with SMTP id 5a478bee46e88-37967410b8cmr11537513eec.28.1794874565874;
        Mon, 16 Nov 2026 16:16:05 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-379565d269asm41244285eec.23.2026.11.16.16.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:16:05 -0800 (PST)
Date: Mon, 16 Nov 2026 16:16:04 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 04/17] nvmet: Implement CCR logpage
Message-ID: <20261117001604.GE1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-5-mkhalfella@purestorage.com>
 <sashiko-outbox-214097@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-214097@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_161607_466690_0FC6A0F5 
X-CRM114-Status: GOOD (  24.22  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat 2026-11-14 03:20:48 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] nvmet: uninitialized SGL tail leak in
>   nvmet_execute_get_log_page_ccr()
> - [Medium] nvmet: premature CCR cleanup before SGL copy in
>   nvmet_execute_get_log_page_ccr()
> --
> 
> commit bd4c242dbfa9b91e0bb3eb6e57be8d11c6a19d19
> Author: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> nvmet: Implement CCR logpage
> 
> This commit implements the Cross-Controller Reset (CCR) log page (LID 0x1e)
> for the NVMe target and advertises it in the Supported Log Pages log.
> 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index 3df9db454db9c..25c320752d2a7 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> 
> [ ... ]
> 
> > @@ -617,6 +618,46 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
> >  	nvmet_req_complete(req, status);
> >  }
> >  
> > +static void nvmet_execute_get_log_page_ccr(struct nvmet_req *req)
> > +{
> > +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> > +	struct nvmet_ccr *ccr;
> > +	struct nvme_ccr_log *log;
> > +	int index = 0;
> > +	u16 status;
> > +
> > +	log = kzalloc_obj(*log);
> > +	if (!log) {
> > +		status = NVME_SC_INTERNAL;
> > +		goto out;
> > +	}
> > +
> > +	mutex_lock(&ctrl->lock);
> > +	list_for_each_entry(ccr, &ctrl->ccr_list, entry) {
> > +		u8 flags = NVME_CCR_FLAGS_VALIDATED | NVME_CCR_FLAGS_INITIATED;
> > +		u8 ccr_status = ccr->ctrl ? NVME_CCR_STATUS_IN_PROGRESS :
> > +					NVME_CCR_STATUS_SUCCESS;
> > +
> > +		log->entries[index].icid = cpu_to_le16(ccr->icid);
> > +		log->entries[index].ciu = ccr->ciu;
> > +		log->entries[index].acid = cpu_to_le16(0xffff);
> > +		log->entries[index].ccrs = ccr_status;
> > +		log->entries[index].ccrf = flags;
> > +		index++;
> > +	}
> > +
> > +	/* Cleanup completed CCRs if requested */
> > +	if (req->cmd->get_log_page.lsp & 0x1)
> > +		nvmet_ctrl_cleanup_ccrs(ctrl, false);
> > +	mutex_unlock(&ctrl->lock);
> 
> [Severity: Medium]
> Can nvmet_ctrl_cleanup_ccrs() discard completed CCR entries when the log
> page fails to copy to the host?
> 
> nvmet_execute_get_log_page() only checks that req->transfer_len matches the
> command's NUMDL/NUMDU length.  If a host requests fewer than sizeof(*log)
> bytes (for example, reading the 8-byte header) with LSP bit 0 set,
> nvmet_ctrl_cleanup_ccrs() frees all completed entries from ctrl->ccr_list
> before nvmet_copy_to_sgl() fails with NVME_SC_SGL_INVALID_DATA, so the host
> permanently loses those completion records.
> 
> > +
> > +	log->ne = cpu_to_le16(index);
> > +	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
> 
> [Severity: High]
> Does this leak uninitialized target kernel memory when the host requests
> more than sizeof(*log) bytes?
> 
> Transports allocate req->sg for req->transfer_len bytes via sgl_alloc()
> with GFP_KERNEL (without __GFP_ZERO).  Because nvmet_execute_get_log_page()
> only checks that req->transfer_len matches NUMDL/NUMDU and
> nvmet_execute_get_log_page_ccr() neither rejects req->transfer_len !=
> sizeof(*log) (like nvmet_execute_get_log_page_rmi() and
> nvmet_execute_get_log_page_smart()) nor zeroes trailing SGL bytes,
> requesting more than 4096 bytes copies sizeof(*log) at offset 0 and returns
> the remaining uninitialized scatterlist pages to the host.

@@ -626,6 +626,11 @@ static void nvmet_execute_get_log_page_ccr(struct nvmet_req *req)
        int index = 0;
        u16 status;

+       if (req->transfer_len != sizeof(*log)) {
+               status = NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
+               goto out;
+       }
+
        log = kzalloc_obj(*log);
        if (!log) {
                status = NVME_SC_INTERNAL;

Fair point. I will add the check above to fail get logpage command if
the buffer does not equal the expect size. This should address the two
issues above.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261114030454.2836543-1-mkhalfella@purestorage.com?part=4

