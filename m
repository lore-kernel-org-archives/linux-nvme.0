Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAD9C636CD
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NdCTtVT7iG5p5H84tYjy3S1sevVxAk8Du9pNDiyc/K0=; b=owLMZR9CwbQGtoeQdxt0b8iAQr
	XUJcxJzbCjTyA0MxXE+fyOX9/8fmvb8p9x9ObjJiRHbC0m4wtODaJrN1unLhYK4eUVK+PuGo0tLTT
	9jEDCjVHZQDuTmMugisjy0kpWJtvYUkDPdMIjipo0IIsXBgPJoteROgvBF1XcfJwZ6Olb0dElN2ls
	lxBPNqXSm85Anob8LRYKHdtzPl/PCMGHvFe5z4KCqAs5z2+STdgto3XKZlUu/8am2Eg9JIblykedQ
	JSUNPL0RKuhJA/B6xLFKhXTahClZ0sYaxF6Zp1XsjAnf2HM2LA6z7ok3MeU/mnKJemIyxdloS+Bk8
	AcXwTMSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNCrr-00ByMe-Ck; Wed, 01 Feb 2023 13:09:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNCrl-00ByFi-6l
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 13:09:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B79F68AA6; Wed,  1 Feb 2023 14:09:20 +0100 (CET)
Date: Wed, 1 Feb 2023 14:09:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: retry commands if DNR bit is not set
Message-ID: <20230201130920.GA30589@lst.de>
References: <20230201115001.57321-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201115001.57321-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_050933_443742_EC5878FF 
X-CRM114-Status: GOOD (  15.64  )
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

On Wed, Feb 01, 2023 at 12:50:01PM +0100, Hannes Reinecke wrote:
> Add a 'retry' argument to __nvme_submit_sync_cmd() to instruct
> the function to not set the FAILFAST_DRIVER bit for the command,
> causing it to be retried in nvme_decide_disposition() if the DNR
> bit is not set in the command result.
> And modify the authentication code to allow for retries.

This is missing the why.  And maybe we can find a better interace than
a magic bool flag.

