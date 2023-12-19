Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453FAC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 04:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJpAyNawpMEOL2Dmg2TTPQ1FCNE1PS1wVJfJY5izCXk=; b=B2XnKsPhIypCL5Hltz668Jh6Gz
	7C3E+ByUYCCaoOxEaCuiHR52wUlvouOt9Eujt/pF6qP9P+JpT2uVI0rDmYQhx8PPQsnC5U7HbiRrT
	fyX6WvkAwKHcHVpuT7D5aYns1fvKcRYKmYA9DEWE2blmJUrpdDVvVyrBgLfPP/vIx3dzpunNoI+q0
	NnpzFQ5AXKLONHjURaaCRCPdVDm6kjijADd+mRp8TZ8noajoecXE1E8fiPF04Bm7JSf7dq0sjsW4c
	IXirJSSlM2gdvJCriXaYCPBz5rMvoBdsHlNTYJs9RJJVBP7EIhvuZnLEm0ntnIQnnLcle/qv29cmm
	5oSw07TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRjt-00CnLG-2a;
	Tue, 19 Dec 2023 04:29:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRjr-00CnKe-1M
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 04:29:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA5FB68AFE; Tue, 19 Dec 2023 05:29:48 +0100 (CET)
Date: Tue, 19 Dec 2023 05:29:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 04/16] nvmet-trace: null terminate device name
 string correctly
Message-ID: <20231219042948.GE30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_202951_597466_3F936C9E 
X-CRM114-Status: GOOD (  13.04  )
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

On Mon, Dec 18, 2023 at 04:30:52PM +0100, Daniel Wagner wrote:
> strlen returns the string length excluding the null byte ('\0'), thus we
> cut the last chars from the device name. While at it, switch snprintf to
> ensure we always have properly terminated string.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

