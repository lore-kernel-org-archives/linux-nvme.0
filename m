Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D55CA9ECB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:29:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CCD20862
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RuJeXsds";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILRPGrHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CCD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=a9OQRC519cey5uKQeu16yR0TJTgrPLXpCQ5mpXPtRmE=; b=RuJeXsds4Z3Yor
	aMKLY66XTZ6kgrOq+U15I8CDUQMTtTdLrUNeCnTds2+wS8RHOGU6dZ1s0YVjnPZHdw/QwkqUbTo/a
	O6S7kPv6x0WKEe18xKtOhLDpJ5KyJTDys6ddMrJXZBPCB8dRcoIUDnjw6BKqa9lTw6MHHxDfbNTwX
	PwQU6nsVsAn84eRr3bnMbEE9bGPFpQ3w4pvPT6szt9GPoSck2dkwHHa/CUcL+QECja6l0T7N4/ArP
	EdEDI4CDyvqmLvs1nB/agVKa8zpLLMazBt+zfF+38HG0zeL6Qhn/pYhTWy/svx4vlJfk9HYdzBym+
	tkK7f+1Mmbra47oi+BUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQAVW-0008RP-As; Thu, 31 Oct 2019 13:28:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQAVT-0008Qa-Qc
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 13:28:57 +0000
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D376220862;
 Thu, 31 Oct 2019 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572528535;
 bh=Vdsn3ouGQqdKJxg6rBIxYfacsyFRzG6/XTHAj2EWdFA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=ILRPGrHpRJTaD8MzLwhSMUGNfpsMQmgiCICKFXUcL7Sd7Y5UVPjrrH3NZlV8bvuIs
 4NzTRlP4QCsShkbDl9wwBIFjR5aYDWNeqxPDqu0Z2T+yw5DWrXrMWCC16L/XgrHEB1
 fKK/7X0bJ72f05QxiEgJhnqTCJclx+tHO8r9dgQ8=
Date: Thu, 31 Oct 2019 08:28:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH v2] Revert "nvme: Add quirk for Kingston NVME SSD running
 FW E8FK11.T"
Message-ID: <20191031132853.GA46011@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031093408.9322-1-jian-hong@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_062855_882225_F70E6440 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, stable@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux@endlessm.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 31, 2019 at 05:34:09PM +0800, Jian-Hong Pan wrote:
> Since commit 253eaf4faaaa ("PCI/MSI: Fix incorrect MSI-X masking on
> resume") is merged, we can revert the previous quirk now.

253eaf4faaaa is pending on my pci/msi branch, planned to be merged
during the v5.5 merge window.

This revert patch must not be merged before 253eaf4faaaa.  The easiest
way to do that would be for me to merge this one as well; otherwise
we have to try to make things happen in the right order during the
merge window.

If the NVMe folks ack this idea and the patch, I'd be happy to merge
it.

> This reverts commit 19ea025e1d28c629b369c3532a85b3df478cc5c6.
> 
> Fixes: 19ea025e1d28 ("nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T")
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204887
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Cc: stable@vger.kernel.org
> ---
> v2:
>   Re-send for mailing failure
> 
>  drivers/nvme/host/core.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7ba09dca77..94bfbee1e5f7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2404,16 +2404,6 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
>  		.vid = 0x14a4,
>  		.fr = "22301111",
>  		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> -	},
> -	{
> -		/*
> -		 * This Kingston E8FK11.T firmware version has no interrupt
> -		 * after resume with actions related to suspend to idle
> -		 * https://bugzilla.kernel.org/show_bug.cgi?id=204887
> -		 */
> -		.vid = 0x2646,
> -		.fr = "E8FK11.T",
> -		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
>  	}
>  };
>  
> -- 
> 2.23.0
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
