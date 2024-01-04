Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7277FC47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNoKbwx6soJb2LbQ/9mst0LbdedTK46dv8rrbeeYR1k=; b=xlBeKMutko1IQHMDnndcS581TC
	smgAyYSa/qdZTcg/YxiC5Wh5whkO8E3Q7dExKSkeqPouMws4jwAOg0vhmMlTyjTeoBhx7DNqgyT39
	1OAWF50jq9X3C/aTqAkz+Bwh9KnQeHImTFZkdm1L3YEj1jOcAjUA/kmXa4m88d1iFBB3CxGnKqIRF
	MT2vT/nHiFZ/RZiJdtfuQ03TRGWMAnoU02gV+nGGzEEFnaF6dNW9rBUM6wmJ11GuauObZjS6i7+GX
	eP6dN/8LFmLEMAH76uquKMbPkbq92fRak27B/Sd5P17Iw/JpL747cCkQYu5bYqSXqcfhFh97NQT8n
	jCcaNfbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLRY5-00Eq6J-2d;
	Thu, 04 Jan 2024 17:30:29 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLRY3-00Eq4u-0q
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 17:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=jNoKbwx6soJb2LbQ/9mst0LbdedTK46dv8rrbeeYR1k=; b=KKdpJ8FcgK+zsiTUTA4UN33xkc
	HtImU9Bpm3bqTF82KUGqRSNgKTf7ZtVO2iL1VCywtRno+p7zq8Wwx6cnsqVK3umbMxDy6uHhJ2APY
	EpZNjXJw71FdQfqD3VsHyXDWlKZ4PJwTFv2MYWTETDY+50nE2gQeFuVeqDcmCXHWsAt5gvYlekQHg
	JJh+z65To0QOdKKAFhd1kwa+ulU/dVGukMELGI1UvnFirIihx1LOHLadwQUIXGM1XfKbowTpekFqF
	wqTKyociyQYQdms1jumPGG8D9Ud50xKmWYXpx2w8j3ead9vjzyRHuEG3jgd9dxse6eBzB83NQseND
	kEIUTfcb691387rhOfSiMNgLaq9HJ9NL+mXoVmEC5Rif+7Z71Scghg7wupxeS7Sxx7gYDyDyskO84
	tX0WGyytwfRy9gLbGEj+kS7arR7lkMU4l4e3tExCApn76x0sfQRl01KQSeEdGyjQLrwjaP1ddG2b6
	57JaaNbU152fGNiDwB+ncVXF;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rLRXz-006TIV-1b;
	Thu, 04 Jan 2024 17:30:24 +0000
Date: Thu, 4 Jan 2024 09:30:19 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 5/5] nvme: Add two-pass shutdown support.
Message-ID: <ZZbrKz5vK9WqMOBl@jeremy-HP-Z840-Workstation>
References: <20240103210405.3593499-1-jallison@ciq.com>
 <20240103210405.3593499-6-jallison@ciq.com>
 <f5451c8e-1ea4-41ee-9bb4-cf88f6fc3db7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f5451c8e-1ea4-41ee-9bb4-cf88f6fc3db7@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_093027_298225_DD4CC476 
X-CRM114-Status: GOOD (  11.59  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 04, 2024 at 03:14:16PM +0200, Sagi Grimberg wrote:
>
>On 1/3/24 23:04, Jeremy Allison wrote:
>>This works with the two-pass shutdown mechanism setup for the PCI
>>drivers and participates to provide the shutdown_wait
>>method at the pci_driver structure level.
>>
>>Adds the new NVME_DISABLE_SHUTDOWN_ASYNC to enum shutdown_type.
>>Changes the nvme shutdown() method to set the
>>NVME_CC_SHN_NORMAL bit and then return to the caller when
>>requested by NVME_DISABLE_SHUTDOWN_ASYNC.
>>
>>nvme_shutdown_wait() is added to synchronously wait for
>>the NVME_CSTS_SHST_CMPLT bit.
>>
>>This change speeds up the shutdown in a system which hosts
>>many controllers.
>
>I think that patch 4 can be folded in here.

OK, I thought it was cleaner to have the export as a
separate patch to make it easier to review, but as
you wish.

