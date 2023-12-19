Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066CEC46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P6+3AlFGOWl8fH/nF2EqWQM2yTf/tRs3QEva2pNuVKY=; b=imB4TfiB7r+sl/SZfV/RPmlzsv
	bAF66pvPguqBcfKShgyo9BA13Sg6+jpwn2Gq9nzpkPrmflVY764RCvWbkSHM8DcVBgpZ3VNHMEMTX
	gBTCBbt6xUnSU9CQ9hBSrvYDX/qonVenjwao85fV3joOa8O9mVLmWEQK7D8fyAX/1ISfapx5E1mJq
	YPydvI2T94hCJPqtP8p6S9effVVYVbGZCui/AJeXeVKLc+AP4nFzjBpmZ9qOSI61ZVqquP9OjuSH2
	5avddkVgWWPzlzTiRw6yzdlMuRmTFZh8x5bHoAFKxIqY7Jxz1Tb59Dn+nP4OTNzq9zCoE1/6bJc0l
	rYNEy6pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFaat-00EGL8-0L;
	Tue, 19 Dec 2023 13:57:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFaaq-00EGHf-16
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 13:57:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F133E68BFE; Tue, 19 Dec 2023 14:56:53 +0100 (CET)
Date: Tue, 19 Dec 2023 14:56:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jeremy Allison <jra@samba.org>,
	Jeremy Allison <jallison@ciq.com>, tansuresh@google.com,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <20231219135653.GA29757@lst.de>
References: <20231215000358.1203338-1-jallison@ciq.com> <20231215000358.1203338-2-jallison@ciq.com> <20231219053318.GA559@lst.de> <ZYE1/xighk0dqjIY@jeremy-HP-Z840-Workstation> <20231219062102.GA1702@lst.de> <4f3084d3-10ce-49b9-8219-70dbf504cd6a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3084d3-10ce-49b9-8219-70dbf504cd6a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_055708_518024_50A06B58 
X-CRM114-Status: GOOD (  15.79  )
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

On Tue, Dec 19, 2023 at 03:49:18PM +0200, Sagi Grimberg wrote:
>>> I could change this so that the existing shutdown() method
>>> is always called, and the device is only added to the async_shutdown_list
>>> if a shutdown_post() (or as requested below, shutdown_wait())
>>> method is defined for the device.
>>
>> Yes, that's what I mean.
>
> I think its usually better to separate sync vs async interfaces. However
> I assume that the suggested interface exists elsewhere in the kernel, so
> its not a big deal.

I don't think we have async shutdown anywhere else.

It's also not really an async interface is the classic sense, but more a
fire now and then wait for completion later interface, i.e. no notication
on completion but pure polling.

