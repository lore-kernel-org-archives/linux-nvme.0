Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A5AC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:37:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E09564FC3
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E09564FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2JtgKyuxdexay9651/znBOhTNJwm56Zg/o6xqIICsBA=; b=bc+rdaoD9M1gb8OcyIdan8onQC
	GxZMDhn0wnzLTr/AwROkyH0YXpDgY8EJyj6S8J2K7xqO4+wrKHmvpPQ09n0tmloh6uspmQisPaKDh
	vR7S8ZCcHVBLPcVlYZ6qxLMUBn63GxxOYWLxpnMJ6bzF6MZmdB5DO2mlHKGuvdVo3Gnk7FijljKnz
	UBxom9WNDVItFb8D60Hlb1bj+9MDLpT67bzXyJhRb2p5GrqonpG3idgY7cMbuWUnnB5ngEB8hFxid
	Irv4eT6itujkHAzTszkhIn8+/ULSS1mVZfJHeZjEw23WAoMkBmtC2kSJwufwar5nBWzrN65nPX1Wf
	humy0z/w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKIhC-008qNu-TH; Thu, 11 Mar 2021 10:37:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKIh8-008qMv-TS
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 10:37:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AF9E1AC17;
 Thu, 11 Mar 2021 10:37:29 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/2] nvme: sanitize KATO setting
Date: Thu, 11 Mar 2021 11:37:25 +0100
Message-Id: <20210311103727.47381-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_103731_051255_E9561962 
X-CRM114-Status: UNSURE (   8.01  )
X-CRM114-Notice: Please train this message.
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

as reserved tag allocation issues are solved with a different patchset,
here are just the bits to sanitize and expose the KATO value to sysfs.
Exposing it to sysfs will allow userspace to identify persistent discovery
controllers (which will have a non-zero KATO value); a patch for that
has been sent to the nvme-cli github repository.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme: sanitize KATO setting
  nvme: add 'kato' sysfs attribute

 drivers/nvme/host/core.c    |  8 +++++---
 drivers/nvme/host/fabrics.c |  4 +---
 drivers/nvme/host/nvme.h    | 16 +++++++++++++++-
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
