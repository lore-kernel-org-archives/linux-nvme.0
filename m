Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E081C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:54:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D473A6008E
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D473A6008E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PJ0+uME2o2yU8sNGxiFfxkMBa+rkAvgAdbFd6s+npAw=; b=N9D4eb3PoJF0dEh2p/ETucI6US
	buHXsxQRSop5/sk2QPYNuEcEKAqUNKQyZQj6653DBL8aNRJHVIxSuwMgogZX5BNpNz354SdqFBzIn
	eUrw0uXwqrddFSOSauYKGNI6YEN932Tex/6CxKncR1GKqP4roHqlvh1phdMLBb+FWbROda5qqrb+v
	AVTUFgHGhsgXBPh+Q1lSMJlum0bOxGijUBrJZwIaamoEZ/WkIHLMvdqMY8Kys8v5pr8yq7NLZt9KL
	BHZHC8tx6OgBGRcDIr+8XGKhMXGUAJ9jprlNpSZgr/rVYcG2V0lGjK8BJy1InsSeofx/Dna4MpKSa
	DciZErzw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRcEI-006q2a-LQ; Wed, 31 Mar 2021 14:53:58 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRcED-006q0v-Mc
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 14:53:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2716EB30A;
 Wed, 31 Mar 2021 14:53:53 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] nvme: delete disk after last connection
Date: Wed, 31 Mar 2021 16:53:49 +0200
Message-Id: <20210331145351.35926-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_155354_299827_0B2EB353 
X-CRM114-Status: GOOD (  11.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

as there now is a consensus that we should destroy 'struct nshead'
when the last reference is dropped (and not once the last opener is released)
here now is the updated patchset to make it happen.
The first is the original patch from Keith, for correctly dropping the
disk reference.
The second one is for not removing struct nshead from the subsystem
lists once the last path is gone, but rather defer it until the struct
itself is freed.

As usual, comments and reviews are welcome.

Hannes Reinecke (1):
  nvme: do not detach nshead when a namespace is removed

Keith Busch (1):
  nvme-mpath: delete disk after last connection

 drivers/nvme/host/core.c      | 13 ++++++++-----
 drivers/nvme/host/multipath.c |  1 -
 drivers/nvme/host/nvme.h      |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
