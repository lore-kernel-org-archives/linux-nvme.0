Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367DDC433E3
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 13:20:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD4C20748
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AWrdgm5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD4C20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=De2323j/4ZvBOsFgWz6OvKQzg06/yPcNzJRQt6p+Llc=; b=AWrdgm5BpzNFF48mBO9jwp0MKy
	QsSoJ1k9FDPwiteLm5MdjU7vCPLHI+crbOrbFH2enh/uRtBgJg1U1dmEM7UfxLm98Rr9DiIxZIXN0
	L9CwN3KfKcrfyCbpH2qircAKp4bGk5u0bPULqKrLEqUJG+lune8T4uSPSoeA+MzmBkJIo6+tH+qnO
	7eRbgq3M+219fC6qMTuD6beEd8kQ6WBDCY14JYKCCpcQPPhDyI27YCSNd0Ovdbm/Gr+rvSJaNFHeA
	P3xtNNvMU11W1kfNwYpS3EfSfx2PQMKnGysbD+PAO8wIUM9epHOCcqnF442WNbJVkGeo+/1c5am7l
	8Pj0FGpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3fof-00034l-Om; Thu, 06 Aug 2020 13:20:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3fob-00032u-67
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 13:20:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A5D16B6CB;
 Thu,  6 Aug 2020 13:20:27 +0000 (UTC)
From: mwilck@suse.com
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/2] nvme: multipath: round-robin fixes
Date: Thu,  6 Aug 2020 15:19:30 +0200
Message-Id: <20200806131932.20017-1-mwilck@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_092013_332133_543698F5 
X-CRM114-Status: GOOD (  11.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

Hello Christoph, Sagi, Hannes,

The version of the patch set "nvme-multipath: fixes for non-optimized paths"
that was eventually merged fails for the case where just a single,
non-optimized path is available.
This mini-series fixes it, and simplifies the code somewhat.

Regards,
Martin

Martin Wilck (2):
  nvme: multipath: round-robin: fix single non-optimized path case
  nvme: multipath: round-robin: eliminate "fallback" variable

 drivers/nvme/host/multipath.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
