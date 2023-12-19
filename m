Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9E3C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ScQPifo7q9/vfi8x7QYS73D5/YD/km8NhQHWa6/kHbk=; b=EtKr3rg2vfLq51uEDd3sPIsrP4
	umvPAuu8XvS7MzqP5D6u89bzjlWpOi2cU80hG15was0Jx0WEBOuAph2BZr3ecX1i+HFarhRYpSXte
	Hg1O6lYsdgXfoCTWIhFE8v5KTFRcmBicHRKO4G0ZPhzsn0rp+P9JGHYfat7YIp780Z2K/hB12nkVi
	iagad6Q5qP51lygU9CSSSRDtR+wgd6zyzd32gHMEjqV9iLebmGyRy+r/GfdFXIFuh27wHGxSexxG6
	ssYn8vPVPU7m8KNPbiJNii6bK6lkg6TO48NRcyiipjjDxkFCgMuJfGedrhmycLR8jFl64DCQcCHMg
	vbOmb/Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSjP-00CuFs-0R;
	Tue, 19 Dec 2023 05:33:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSjM-00CuFI-2U
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 05:33:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9342968AFE; Tue, 19 Dec 2023 06:33:18 +0100 (CET)
Date: Tue, 19 Dec 2023 06:33:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <20231219053318.GA559@lst.de>
References: <20231215000358.1203338-1-jallison@ciq.com> <20231215000358.1203338-2-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215000358.1203338-2-jallison@ciq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_213324_981192_910E0EA4 
X-CRM114-Status: GOOD (  14.83  )
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

On Thu, Dec 14, 2023 at 04:03:56PM -0800, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> This changes the bus driver interface with additional entry points
> to enable devices to implement asynchronous shutdown. The existing
> synchronous interface to shutdown is unmodified and retained for
> backward compatibility. shutdown_pre is only called if a matching
> shutdown_post function is also registered, otherwise the synchronous
> synchronous interface is used.
> 
> This changes the common device shutdown code to enable devices to
> participate in asynchronous shutdown implementation.

Is there any reason to have a separate shutdown_pre method?
Especially with all the method wrapping in the driver core, yet
another method just keeps confusing everyone.

And on the post side, might shutdown_wait be a better name to
describe the operation, but I'm open to opinions.

