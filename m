Return-Path: <SRS0=60sM=IA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6352AC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 09:27:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD62964F0A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 09:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD62964F0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WbayboezDVIYrq4eJiV8UoIdV7EgpWxaO8X9buNva2o=; b=tuemFPxJ/Rbuykn+I/pwChj8YW
	Vne1kJGW91wS5aPHm+k+SbvONwPNSbDZY2P70/LSNwqciiZHjMNpuEYIvdKkSZdmc5uK9mx0qzpFF
	+8oRPRWIE+uhrMKElt6hH4xkm/0hywW/pohTppfmwLC9Rwd4Z2G7GGfaKyw9ltlt+TQ7z3vtH0WJU
	xLFZEDkJv9+3PvmkJ7JWHZBGiCP+HZN7vYLlBofzvAoL2S5h9VORx/I6V05RMlzf+jcCpxfV4XsWO
	ivWzA4MbkJTm1aKVGSzT59ThrA+Ma/vXp8HvXpGNWrflsLjWnxhx0eqvTPU8GVKeZSEked9LvucAN
	KDvu2JVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lH1Ir-000242-St; Tue, 02 Mar 2021 09:26:53 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lH1Il-000224-0z
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 09:26:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 031E3AFCF;
 Tue,  2 Mar 2021 09:26:46 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 0/3] nvme: sanitize KATO handling
Date: Tue,  2 Mar 2021 10:26:41 +0100
Message-Id: <20210302092644.80701-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_042647_288337_8A2BC1BC 
X-CRM114-Status: GOOD (  16.74  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
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
And to aid userspace detecting persistent controllers we should be
displaying the KATO value in sysfs, too.

As usual, comments and reviews are welcome.

Changes to v1:
- Include reviews from Christoph
- Include reviews from Chao Leng
- Add new patch to display KATO value in sysfs

Hannes Reinecke (3):
  nvme: fixup kato deadlock
  nvme: sanitize KATO setting
  nvme: add 'kato' sysfs attribute

 drivers/nvme/host/core.c    | 21 ++++++++++++++++-----
 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/nvme.h    | 10 +++++++++-
 3 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
