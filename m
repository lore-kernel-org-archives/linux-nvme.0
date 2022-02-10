Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D39C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 05:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JU18tfsvbDrRI0FvAgG69HuDEl7Yion08wCqeicqQk4=; b=mpbE+Xac0FUJK8tsXWDOuS8V4P
	k52sCneSNgv1E/3L4QboPRZ9kY5lxHe5v7/9ZKP+bKuwKOQxSTSEJYsYOUgzf6UC7al3SC4NmyzR7
	WpYwu9K8jAJNYg0RohEXb41hh2Et5qggINNQPKpZkLWjHuXzWl0pBp0J/I8aPeMex0BQBkZiS9ZVX
	1LzlpHuJw+Hx5M4BwM2jM+d4q6r3TNcPGwN0isbz2bxGzXRfQnGO9cpr5alM91a7rOjvOKLM2xHT1
	aXwmJjd+9jO0NgOZCVidMluC0IB+4d+E5EFNCIyd0evd94L+fW1jWw6laUDXZ1e6i0657ydwsMrqJ
	XEAVjhDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nI2Ex-002e9H-0S; Thu, 10 Feb 2022 05:43:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI2Et-002e6s-Kb
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 05:43:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 51EED67373; Thu, 10 Feb 2022 06:43:23 +0100 (CET)
Date: Thu, 10 Feb 2022 06:43:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
Message-ID: <20220210054323.GA3293@lst.de>
References: <20220207100005.34404-1-hare@suse.de>
 <20220209080747.GA9851@lst.de>
 <56fb153a-ba0e-605b-e774-885c259965a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56fb153a-ba0e-605b-e774-885c259965a6@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_214331_863167_9DD02E4F 
X-CRM114-Status: GOOD (  19.58  )
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

On Wed, Feb 09, 2022 at 09:52:45PM -0500, John Meneghini wrote:
> I agree with Christoph.  I don't see the point in supporting 65536 
> namespaces across 49 ana groups or controllers. The problem here is: the 
> vendor is trying to turn NVMe into SCSI.

I'm not saying we should not support it.  We can trivially do that by
using a vmalloc buffer.  I don't think we should optimize for it, and
we certainly should not break behaviour which I think this does.

>
> Moreover, I don't understand how implementing this as a MODULE_PARM is 
> supposed to work.  If you configure this module parameter on it assumes all 
> NVMe-oF arrays connected to the host support RGO. What's really needed here 
> is some kind of protocol mechanism that will allow the host to dynamically 
> discovery if RGO is supported on a controller by controller basis.

RGO support is mandatory and has been there since the first released
ANA TP.

