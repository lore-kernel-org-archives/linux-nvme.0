Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F00C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ad7Wi61cdhI81QBZ5+3P4bJPPYWD5DrY92FM55lMwjY=; b=RtdoB80GEN34ulnCvXC5P9zcP+
	kJsFCJOptM7fLyHOY6Q4zFQzxpeaxxlJkIQttmWIVMQgDVz3ozB846FDewaI6LrOWPcUlyIB50/Go
	Ivolqp9hE+XpIVGP4HSaa6lUja8ryPu1ikb5WE1Ux0+ANhxHnb0Y3OcPHFcwnmmhHZCESl1xJtH+O
	07n/7FJUgxr0zHLgRkBOhg/lCPRJwdt3/edii9CwrvlkC/SlqXJBCRBeEm6edvKBDqZvAUkC3PxhJ
	CoGbag8/1vGHKoYDWs1f2Y3evG1ziQpqeyoIDmBZIIZVVSAwrZelsYZiPXvA/DStn2XrH0p4yyeHa
	rKhe5Fxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cet-004r4s-8S; Fri, 23 Dec 2022 07:39:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8ceo-004r1Q-Qf; Fri, 23 Dec 2022 07:39:54 +0000
Date: Thu, 22 Dec 2022 23:39:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joel Granados <j.granados@samsung.com>
Cc: k.jensen@samsung.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	linux-nvme@lists.infradead.org, kbusch@kernel.org
Subject: Re: [PATCH v2 0/3] Add OCP extended log to nvme QEMU
Message-ID: <Y6VbSjV3l+/3CWmb@infradead.org>
References: <CGME20221114135426eucas1p271a54e44af5a53a45a7393ed34585ee0@eucas1p2.samsung.com>
 <20221114135043.2958100-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114135043.2958100-1-j.granados@samsung.com>
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

Please don't do this.  OCP is acting as a counter standard to the
proper NVMe standard here and should in absolutely no way be supported
by open source projects that needs to stick to the actual standards.

Please work with the NVMe technical working group to add this (very
useful) functionality to NVMe proper first.

On Mon, Nov 14, 2022 at 02:50:40PM +0100, Joel Granados wrote:
> The motivation and description are contained in the last patch in this set.
> Will copy paste it here for convenience:
> 
>     In order to evaluate write amplification factor (WAF) within the storage
>     stack it is important to know the number of bytes written to the
>     controller. The existing SMART log value of Data Units Written is too
>     coarse (given in units of 500 Kb) and so we add the SMART health
>     information extended from the OCP specification (given in units of bytes).
> 
>     To accommodate different vendor specific specifications like OCP, we add a
>     multiplexing function (nvme_vendor_specific_log) which will route to the
>     different log functions based on arguments and log ids. We only return the
>     OCP extended smart log when the command is 0xC0 and ocp has been turned on
>     in the args.
> 
>     Though we add the whole nvme smart log extended structure, we only populate
>     the physical_media_units_{read,written}, log_page_version and
>     log_page_uuid.
> 
> V1 changes:
> 1. I moved the ocp parameter from the namespace to the subsystem as it is
>    defined there in the OCP specification
> 2. I now accumulate statistics from all namespaces and report them back on
>    the extended log as per the spec.
> 3. I removed the default case in the switch in nvme_vendor_specific_log as
>    it does not have any special function.
> 
> Joel Granados (3):
>   nvme: Move adjustment of data_units{read,written}
>   nvme: Add ocp to the subsys
>   nvme: Add physical writes/reads from OCP log
> 
>  hw/nvme/ctrl.c       | 70 ++++++++++++++++++++++++++++++++++++++++----
>  hw/nvme/nvme.h       |  1 +
>  hw/nvme/subsys.c     |  4 +--
>  include/block/nvme.h | 36 +++++++++++++++++++++++
>  4 files changed, 103 insertions(+), 8 deletions(-)
> 
> -- 
> 2.30.2
> 
> 
---end quoted text---

