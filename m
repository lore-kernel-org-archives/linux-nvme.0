Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1221C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:07:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A868364E3F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A868364E3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e30PvcwVUEOQMEhFCLqW4a1WygKNhm7PqVgwoiK0Lq4=; b=16EOZeSjqAYQxfeUOV2NtBzO47
	RCSEuacBLKMw8QGXTemSsPy4cyALCbM8LIocjWqGQ+5BIC8/o/6rhYX1PLl5aJ5NEFMxJ1iKUs1rY
	VBhGkFOTG+66lcN+CqLNrl9e4rtGX9hyeSWs8avDy+fFqU6jOV9NDbTiOetzynwLSyeeZp0wm6KN+
	Drf05nMY508s6nuHmw72JzHvRTMlN1yFqnuWrAXKaD09qdO6tyJF0KmVD2bYbwfWRcfRQ/J1Zorvf
	AfjmeCdc5esW71dp2fkGfGkzEoyuqpVINFKyONkmwQ/RVeq4qFr0H9XHiz5xapS2I0bZ44ZM9oQe7
	83KZiUNQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEWTY-00006X-Ni; Tue, 23 Feb 2021 12:07:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEWTT-0008Vv-Dd
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 12:07:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 69F4EACF6;
 Tue, 23 Feb 2021 12:07:30 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] nvme: sanitize KATO handling
Date: Tue, 23 Feb 2021 13:07:26 +0100
Message-Id: <20210223120728.104699-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_070731_731805_A4769B80 
X-CRM114-Status: GOOD (  15.64  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

one of our customer had been running into a deadlock trying to terminate
outstanding KATO commands during reset.
Looking closer at it, I found that we never actually _track_ if a KATO
command is submitted, so we might happily be sending several KATO commands
to the same controller simultaneously.
Also, I found it slightly odd that we signal a different KATO value to the
controller than what we're using internally; I would have thought that both
sides should agree on the same KATO value. And even that wouldn't be so
bad, but we really should be using the KATO value we annouonced to the
controller when setting the request timeout.

With these patches I attempt to resolve the situation; the first patch
ensures that only one KATO command to a given controller is outstanding.
With that the delay between sending KATO commands and the KATO timeout
are decoupled, and we can follow the recommendation from the base spec
to send the KATO commands at half the KATO timeout intervals.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme: fixup kato deadlock
  nvme: sanitize KATO setting

 drivers/nvme/host/core.c    | 22 +++++++++++++++++-----
 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
