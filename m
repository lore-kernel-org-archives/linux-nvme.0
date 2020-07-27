Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE6C433F2
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 16:08:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04E32073E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QUJSmvZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04E32073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=00N2qc9DvLfWtc6RZniDem3EaSUcnic6gyf8gf2GZwM=; b=QUJSmvZHC1o3iDFSS29CtLYlti
	7ghtyYzO1hwLDRUOi/GaccXvxf1y1FoUff9+JQJwqJlZI670aPB7nihHrf8a19eJ/443C6A4+OE/D
	2dkQ2NBjY+FfLkGPQbAQ6xuI9d7zDm9g6IguTTYO4K2QXZZyQfexuJdnT4pLoI7bmpAWEN+L1fM/i
	kH6lFFA6AkH4FTi9yZjzjWIc0qEabhITl53KjUvpo06qHdgyumZadwIiUCoi8Fwo92wn7Atuxpn8x
	R9kfLEpSZvsypxBpnTDtzpHAF7HdWzCQUd5uAiBZlIJezdoC0OCK+YYtrouplxaSsTVaoYaHZXo13
	/vVj5l5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k05fk-0004dF-EF; Mon, 27 Jul 2020 16:08:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k05fh-0004c3-F3
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 16:08:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 880FEADF5;
 Mon, 27 Jul 2020 16:08:21 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] nvme-multipath: fixes for non-optimized paths
Date: Mon, 27 Jul 2020 18:08:01 +0200
Message-Id: <20200727160803.55683-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_120813_607505_A931E9F1 
X-CRM114-Status: GOOD (  12.57  )
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
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Martin Wilck <mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

one of our partners informed us that the round-robin path selector
didn't do the right thing when only one optimized path (or, indeed,
none at all) are present.
These patches will fixup nvme_round_robin() to handle the case when
less than two optimized (but several non-optimized) paths are present.

These pathes are a rework of the earlier patches send by Martin Wilck.

As usual, comments and reviews are welcome.

Hannes Reinecke (1):
  nvme-multipath: do not fall back to __nvme_find_path() for
    non-optimized paths

Martin Wilck (1):
  nvme-multipath: fix logic for non-optimized paths

 drivers/nvme/host/multipath.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
