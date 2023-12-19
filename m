Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23E4C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 06:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MhUH3CP/5vSjMD7YbXBNKNjBBvaX1sxFmI61B1bXGkw=; b=zaiF9qBXgVWAKibRIfyvEOiZkF
	8kRbDIRcchjrRc7dLJpL1zvmznD3RDje81r+g5KprGJa/PpqpZdmr1ZVAUJYUfMcFzS9LqXOaiwOV
	gwK72cqtzABaWdRfmP4uHgnqSo02CmvJfDmVfR/NfZAXhOxNjrenPpeV981utggWT8zPzX0+YcFPG
	1FEJ6WZYouAeHP2UmZDk6JREc8JqsF+M/+2GKx/frAGUFoXxswS6Onraw/MMjCBuysmLwIGl24wQ1
	iMjZZv/k80QURL3VwrVkUieg0PckrLxUUPfrwZ3oJ9V+5sty1OoXHml4yklnta/doJPvCsk5UdDHl
	UINSxOdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFTTb-00CySe-35;
	Tue, 19 Dec 2023 06:21:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFTTW-00CySB-1T
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 06:21:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7562468AFE; Tue, 19 Dec 2023 07:21:02 +0100 (CET)
Date: Tue, 19 Dec 2023 07:21:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jra@samba.org>
Cc: Christoph Hellwig <hch@lst.de>, Jeremy Allison <jallison@ciq.com>,
	tansuresh@google.com, linux-nvme@lists.infradead.org,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <20231219062102.GA1702@lst.de>
References: <20231215000358.1203338-1-jallison@ciq.com> <20231215000358.1203338-2-jallison@ciq.com> <20231219053318.GA559@lst.de> <ZYE1/xighk0dqjIY@jeremy-HP-Z840-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYE1/xighk0dqjIY@jeremy-HP-Z840-Workstation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_222106_640333_63FFB310 
X-CRM114-Status: GOOD (  17.58  )
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

On Mon, Dec 18, 2023 at 10:19:43PM -0800, Jeremy Allison wrote:
>> Is there any reason to have a separate shutdown_pre method?
>> Especially with all the method wrapping in the driver core, yet
>> another method just keeps confusing everyone.
>
> Currently in the patch the existence of a shutdown_pre() method
> for a device causes it to be added to the async_shutdown_list
> which is walked to reap the completion status after all the
> calls to shutdown_pre().
>
> I could change this so that the existing shutdown() method
> is always called, and the device is only added to the async_shutdown_list
> if a shutdown_post() (or as requested below, shutdown_wait())
> method is defined for the device.

Yes, that's what I mean.


