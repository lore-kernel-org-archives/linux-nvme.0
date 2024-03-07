Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1B6C54E58
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tyiMAJPv0CAsq8rPvI6k/C3VDRqzwnIG8uwHSh5N2LA=; b=o0EIb+he7GuMx9dB+sPjjfvGTD
	PBguZ7DWfsVchjI9s+FNB6toF4uxqAIacBqZ7GWniwWuqoMBbwLfMsTfYaRAXsuK5U+rc3r8PW0AS
	aqNOWzEvE68MjBXJ++wxubc4j0vd7ZiZWqeC2qtStPAAQySOVXutsrDkiwDpHuzXSIwKgnUU5UnmG
	MWNdORTKaGS5LBgv9D4Hdg6+PrM7r83hpheoomNh5mfD+Kl1VvG+stnkownguY3I2JSuFJOE45zoD
	sDS0+C5Q7AJ6Pt/Zp3i5tXsrziJuXLanmPrxr5g6F18PHdj5EmJFV6Ex3w3RsH4KwgkE1MThiGJSw
	nzG6ckeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riJm3-000000068tM-2wU6;
	Thu, 07 Mar 2024 19:51:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riJlz-000000068pi-2Kfc
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 19:51:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D3A5B61CD5;
	Thu,  7 Mar 2024 19:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACEBC43390;
	Thu,  7 Mar 2024 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841082;
	bh=97urD+vBImmdNRQsyW72trebuT9te7c4DAnEjaMVfSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kapLg7TBtniwoZ0MnEPUDezQYDL9b5LaIdoEn6UhIeM8/TaFTXRYAKl9AN1SBA3LU
	 etRw0xnEHXOJWqIU+ozysEaGbAHjg+VvQhv0POE/clZFMIjT+6ppNfneS//YL0t/th
	 LSJMkZvhiFxUb7rSCfJZIUftSWNhzrCBeU2oVK8Q75vfi7VQBG7R/XyhAcc7fxVg6S
	 fcDM6fp8UN+dKvsBi6/2vySAM8+MfzJBNGTkLu+TdrIpMbk6PyFsM7TuFEzx4YduVV
	 yhuo5Tkj6w9wPmW+YB4vdCrUCfBZlRJwIS+Rwb5AnajLjNMGg+BIzSobbPVEdKxnO+
	 IAoiAa4f5R3Nw==
Date: Thu, 7 Mar 2024 12:51:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Len Brown <lenb@kernel.org>
Cc: linux-nvme@lists.infradead.org, maxg@mellanox.com, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] nvme: Re-word D3 Entry Latency message
Message-ID: <Zeoat2z25BXxA7qA@kbusch-mbp>
References: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_115123_792553_387F2E90 
X-CRM114-Status: GOOD (  10.36  )
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

On Thu, Mar 07, 2024 at 02:17:34PM -0500, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Some words are alarming in routine kernel messages.
> "timeout" is one of them, so avoid using it.
> 
> Fixes: 1a3838d732ea ("nvme: modify the debug level for setting shutdown timeout")
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Len Brown <len.brown@intel.com>

Our messages must have crossed:

  https://lore.kernel.org/linux-nvme/20240307165933.3718589-1-kbusch@meta.com/T/#u

I haven't been receiving random messages from the list lately either. Or
maybe I cc'ed the wrong email.

Anyway, we just sent the nvme-6.9 pull request today, so I'll wait a few
more days before starting the next batch.

