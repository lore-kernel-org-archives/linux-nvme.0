Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3B3C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7kAS6XSyxZsthX2H+Kg37NrYjlXNLfvRThRTmSdNEEw=; b=lt8ox+4zpT92M6SxqFv9oAALJL
	KPx8RH2GBIQfaFpz4mfzSMMGuC0ABiNabV/MJYqJ4+Cg2WjR5Ck2eLZ41yAfxanil+0nDMIYIJorl
	CNOw/HbY1FG5r78SC5c8O7zjWHz6m3QHJraPqiePgjO+KyVRdpmO4eS6WfsHWNPGPY/drYc3CJ6xe
	hSEY9+grdBLlRA5t5Nv8AqPT2RRK3tumNczuLrwIPkNu7PBe6zLZjZy0sLQoB/7r/wbhEbzI+nSQZ
	pdgPBH6iyvAHk3vuaAepCt2mb3+jXI80zz+tajTdIe/gcFRorJlDRh4tGUapLibOEBYFNF9Tz0ohy
	qelJFQfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndnHW-006sk3-J3; Mon, 11 Apr 2022 06:12:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndnHS-006sic-4u
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 06:12:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D3C1068AFE; Mon, 11 Apr 2022 08:12:02 +0200 (CEST)
Date: Mon, 11 Apr 2022 08:12:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Message-ID: <20220411061202.GA14797@lst.de>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411031249.5158-4-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_231206_374755_2E6F26A4 
X-CRM114-Status: GOOD (  11.42  )
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

On Sun, Apr 10, 2022 at 08:12:49PM -0700, Chaitanya Kulkarni wrote:
> Mark internal passthru requests quiet in the submission path with
> RQF_QUIET flag added in the __nvme_submit_sync_cmd(). In the completion
> path, if nvme request is resulted in the error and request is marked
> RQF_QUIET then don't log the error with nvme_error_log().

This misses out on a few other internal submissions like the PCIe
queue deletion or keep alive.  Probably not much of an issue, but I'll
ammend the commit log when applying it.  I'll wait a bit for more
feedback but plan to send this out later this week.

