Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B170BC47092
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 13:53:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E86261376
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 13:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E86261376
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/vY5bcig64HGaKvfyeHZk/OBTglJEGmBGSjgBfLdFNo=; b=EdtGWHRicDwtH1
	dJnaGDIoo613wZNM+XOCZllKrTJPTlFfbWFWaKacEZVzopz7ZoPb3aWDQiU8d1p+GDxoReHq7Vlfv
	aUg6YRo9nif8pglT6qtgTCmbrjIXGF+myPUmDiAPtWoga7HDgVc3ow8Mcxl4AzZulLnQyUdxPcS5b
	Lkl53FeaL8XBwuNhHtJv1e1tuNNcwgihORUq0BYretn5q86adsMB99JiCnZVkQ1zQj8q0N20kzXiu
	r7Y+RJZzFJ+xfw+NagO5IPiPOAQp+4uNns8rV2g0a3tugKVZ02NmyMZ/plZ9KzihjF6x8wBM5kG9q
	CkR6qK4Ztb/Zc+xE9aJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo4pc-00GtRM-Fc; Tue, 01 Jun 2021 13:53:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo4pV-00GtQt-6z
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 13:53:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25AF6613AD;
 Tue,  1 Jun 2021 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622555592;
 bh=jKW1wMitSm0f0CvpD2SZ0mcDfz/fTWYkKq5HYcnNFxw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jPzVGrhVihJViyasKqa9fEYoFaOURNTuHF1AphWoDl3DZ+xfkIgiUaB7PtuWmAHWZ
 aw8kdte+nKHKR8v2S9BAwZdxMYobWQ156duJAS4LAhbuZniIUbkAtA64CuwOXlN7ox
 54WG5hwlbGGntaeSaFQrHBb3AsW5vjUgUDFhxL34Ais2KBJ3CFVtKD4IRTKhPE0MFs
 URv/Jk73oprDB6fW+5x6rhqTUSeQ26gGRLkqaRYYFMObVQtVzVNLQP038dZKg4pTem
 sjNAUBonZNXGrSu3BUMCQEDxbYbJb/vUQQSjF5HmspfzANP6XxGLw/2rmRvftoiIMk
 8LGGCtAMURDgQ==
Date: Tue, 1 Jun 2021 06:53:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVME_IOCTL_SUBMIT_IO access control
Message-ID: <20210601135310.GA4197@dhcp-10-100-145-180.wdc.com>
References: <YLTD7gcSIiNRJvGX@x1-carbon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLTD7gcSIiNRJvGX@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_065313_295154_5A7D9199 
X-CRM114-Status: GOOD (  11.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 31, 2021 at 11:09:35AM +0000, Niklas Cassel wrote:
> Hello there,
> 
> How is the NVME_IOCTL_SUBMIT_IO access control supposed to work?
> 
> $ echo "hello" | nvme write /dev/nvme0n1 -s 0 -c 1 -z 512
> /dev/nvme0n1: Permission denied
> 
> $ sudo chmod o+r /dev/nvme0n1
> 
> $ echo "hello" | nvme write /dev/nvme0n1 -s 0 -c 1 -z 512
> Rounding data size to fit block count (8192 bytes)
> write: Success
> 
> 
> Am I supposed to be able to do a write if I only have read permission?
> 
> $ ls -al /dev/nvme0n1
> brw-rw-r-- 1 root disk 259, 0 May 31 10:59 /dev/nvme0n1

I'm not sure, we've always allowed any user passthrough command if
CAP_SYS_ADMIN capable. It should be pretty easy to check permissions for
any data-out opcode against FMODE_WRITE. We'll probably break something
if we do, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
