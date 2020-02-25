Return-Path: <SRS0=1WVC=4N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33418C35E04
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 15:55:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0132F2072D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 15:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hAsveXG2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ub4dLGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0132F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AvHH8IEhiHieB11lA52/lBo569ANp1a6ciQkhjqh5Qw=; b=hAsveXG25gI07v
	bOAU7cDnCoc6K/IMdkeY7iXm3ityvIaxav0MzE6X5uTGiXSswqUyRyJDbZQSeawjLCCuYrvssQ6Dz
	W/pNR51QqPpT+AeuD3ktBvLMXWE/+aiMvG4kdlrvooOR19+yrlRZOWMWLxxBscpeqvk3e0yhYQRmG
	XBhYudLWCyfYxfw00EhXo033F4kMVYGrPC6/nskp7GtenGJ3w/5esEf0wYJvcnG6TknVOP7mM9fX7
	rOdRGJzekobnJBh/nvdhQbhe/2LLLC3ayunGxOlBsEKQapVCK5XximsQfxUNVRyC5HLKjzX0xCSzE
	L8PwsW5o5Y3VzA4wf18A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6cYo-0007no-Pl; Tue, 25 Feb 2020 15:55:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6cYk-0007nQ-PT
 for linux-nvme@lists.infradead.org; Tue, 25 Feb 2020 15:55:47 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F2CA2072D;
 Tue, 25 Feb 2020 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582646144;
 bh=hllco0jH08DzO3nxB6DG4mlRc45IX998rsne5xm3Wno=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0ub4dLGGBHGk2aAb+7YrXblOTAHs4TcNjKrL/p9NtclAkYbhvd3cCec9KbFk4cNwn
 A9UpVa9ZaSxIPBgLWo10uEdfLGzf3yCWOMaHICNgbgfR/VRqg+KOrgSGxD1BOuk6Oe
 LVmRGo0nKtXdbmDwxcKL6wfgRXXzZbKJ9e5cH5yk=
Date: Wed, 26 Feb 2020 00:55:39 +0900
From: Keith Busch <kbusch@kernel.org>
To: Rupesh Girase <rgirase@redhat.com>
Subject: Re: [PATCH] nvme: log additional message for controller status
Message-ID: <20200225155539.GA22008@redsun51.ssa.fujisawa.hgst.com>
References: <1582561924-8017-1-git-send-email-rgirase@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1582561924-8017-1-git-send-email-rgirase@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200225_075546_851034_EBD11AE4 
X-CRM114-Status: UNSURE (   9.09  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 24, 2020 at 10:02:04PM +0530, Rupesh Girase wrote:
>  			dev_err(ctrl->device,
> -				"Device not ready; aborting %s\n", enabled ?
> -						"initialisation" : "reset");
> +				"Device not ready; aborting %s, RDY=0x%x, CFS=0x%x\n",
> +				enabled ? "initialisation" : "reset",
> +				csts & NVME_CSTS_RDY, csts & NVME_CSTS_CFS);

The RDY bit is a bit redundant. If "initialisation", we know it's not 1,
and if "reset", we know it's not 0. We also know it's not all 1's if we
reach here.

CFS may be useful, but the print will look a strange. If CFS is set,
you'll see "CFS=0x2", but the CFS field can only be either 0 or 1. I say
just print out the entire csts field in case SHST or NSSRO may provide
insights to the vendor.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
