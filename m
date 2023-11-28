Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2B5C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYH5eKL0tivPFxD8D/NETiMqJGOT4JXYfJInei68LW4=; b=MSM8LKr/uw6SFIb0JCzErtQGju
	zZCH7SCUp3A3fp1S2dYVjlBQq0dreHgf9qHevYdx3Y5KFc9aNRdasO9mXrdHzI8awwPOs5lmFtl+v
	32n32hduCI7qb07+cZztBrxFoc1p3+/sjnSu9mc4zruMyo/vHEj9V3JVf2Xldh7oW1Bg9ZkpzIFDD
	SKzduv0snVAKQe4vvHZ8K3UdzaZv7MbZFpFgSQqri3QFLyWj9etoS9MhcfD098XhLjUBHMuhye+AJ
	EpYycjWErkIaJFMTCAR0R0f4nKxKKdf+NUJKi/HCRuPwfWAi18TzeHkxY3lxbJwBkaU2jsmaXSZvn
	fYom9LeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r81wa-005x9v-0d;
	Tue, 28 Nov 2023 17:32:20 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r81wX-005x8O-0C
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 17:32:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id BF642B83B6F;
	Tue, 28 Nov 2023 17:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEFBC433C7;
	Tue, 28 Nov 2023 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701192734;
	bh=lxfrUPljya5ih/vc8cBOPa/P21XoMYA0ttOKIfbs7eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvEDCGlyCjHJ1cUiS9A/SMQzdIQuJQhxF9o0TTmrV++MlvWS8ofWzzj8li57/nKOZ
	 hYps/AzpLGy3s437FOU8Cz84m5+xbLM+glkTSRhdBaShL9eMXgfSy3wQ6XKYckPAJS
	 XqtmztCIneM6Uth5Sj96Rxl8ktdtRpKLuVqjMB1P1MFhpEwXk2lCSAiseF/K/UWS3p
	 xpcMAYOwoNTtBOOcDVmh2132nMDsHimLnk50OZ3amOvXD3XA3YWO+RXCYRR2QD99TN
	 MPGtmZ7chZZFdqkGxjpbLEt4jaM0lUpat6hhOA0ZYF3TfMzqTzklSXYgoO/wSh4FNE
	 F5sZotuZlH4aQ==
Date: Tue, 28 Nov 2023 10:32:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: check for valid data from from
 nvme_identify_ns() before using it
Message-ID: <ZWYkG3qh3N-HT7hx@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127205657.25950-1-emilne@redhat.com>
 <ZWUSILjL_6fJXPgk@kbusch-mbp.dhcp.thefacebook.com>
 <CAGtn9r=KZOmxJLGNp1bu_2HRF_nuGUmJanubNVA=Je=v19Uh=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtn9r=KZOmxJLGNp1bu_2HRF_nuGUmJanubNVA=Je=v19Uh=Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_093217_271961_BF4A5916 
X-CRM114-Status: GOOD (  14.71  )
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

On Tue, Nov 28, 2023 at 11:10:29AM -0500, Ewan Milne wrote:
> > Interestingly enough, I think this is the same as what was recently
> > reported here:
> >
> >   https://bugzilla.kernel.org/show_bug.cgi?id=218186
> >
> 
> Yes, from the stack trace and BZ comments it looks like it.

Slightly related, there's nothing stopping a device from reporting a
bogus LBA shift value. We're only checking for "too big", but neglect to
check for too small, and may similiarly shift off to a division by 0. We
might need a check like this too:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a55c2a774b9c4..8bf78f876f7ac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1903,7 +1903,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * The block layer can't support LBA sizes larger than the page size
 	 * yet, so catch this early and don't allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
--

