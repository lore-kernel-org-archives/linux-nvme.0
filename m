Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19612C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 05:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZmUVXw2TXT+1fnZzaILAqv/PirCzLaVEwhdxHx/wtD0=; b=k5NxEgZuhjTKvIgioIcYFHdbaW
	A0KaC7DdSQdvQ40M7VeVrIi30ws564v/gUB6iV1PuZBbjxWEwWXJU/8gu0kqX8SvsFAG1ot2OTyaP
	WYdecd7zsi92C/HXVLkOyfqxXGkQhWRUL9GGq1fuQLVYdRzkwbhG3JVYo+Lk9PbzpryD2ztNiNdQw
	32cooeA3sZX/6GPV0yTqlw2FgWkmuRPwA4hmwG6nuhkN/I0JwMy8ClpB6pGSd8kctFIe9zWnFHEW5
	7ZpKXGsVk+xr26kOpNMcG7HX07EaVhF3QGJEvMIUlnGNOns19ik0BITXw08inH0xRlk0CLyBMgaOz
	AZBvz69g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqTjn-00660a-G3; Mon, 16 May 2022 05:57:47 +0000
Received: from 213-225-11-122.nat.highway.a1.net ([213.225.11.122]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqTjl-0065zY-NO; Mon, 16 May 2022 05:57:46 +0000
Date: Mon, 16 May 2022 07:57:42 +0200
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Muneendra <muneendra.kumar@broadcom.com>
Subject: Re: [PATCH 1/4] nvme-fc: Add new routine nvme_fc_io_getuuid
Message-ID: <YoHn1hcszJIAHN/j@infradead.org>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
 <20220510200028.37399-2-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510200028.37399-2-jsmart2021@gmail.com>
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

On Tue, May 10, 2022 at 01:00:25PM -0700, James Smart wrote:
> From: Muneendra <muneendra.kumar@broadcom.com>
> 
> Add nvme_fc_io_getuuid() to the nvme-fc transport.
> The routine is invoked by the fc LLDD on a per-io request basis.
> The routine translates from the fc-specific request structure to
> the bio and the cgroup structure in order to obtain the fc appid
> stored in the cgroup structure. If a value is not set or a bio
> is not found, a NULL appid (aka uuid) will be returned to the LLDD.
> 
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>

I'm fine with picking this up through the scsi tree:

Acked-by: Christoph Hellwig <hch@lst.de>

