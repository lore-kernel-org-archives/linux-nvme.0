Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86BBC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=azp/TS1eCcz1XlsuHASBurkpcZDAHIUYFxBYWUzaywM=; b=tX+zPRS8ur8VQcaIuDsOWa7ocE
	91xpvreJwI2aDdUzUQ+VKhvEjMuz0LWw0etnEyDkNsyzSocV84WW8T3djR1ZaSAOKVJTXSMEV5qP5
	K/RSqgKCvYsoefLkD6Y1kPrqy+sZZCa2M5eRRIzCQ6E8D3X+xWqd8jYwLnJ/aMwe+ncII5y1XzeX6
	ljCmP7NZ3BhUqzY/39Je9Z8SHKaKDhXq0PmTcsxw1nExxeQyJMJUgBj6/QyubxTX4VRkRzGwZLkC1
	c82mWajCdPFiStFtp2YwFdwiz9SUrxGeNty7kDV/1jd4xqpA0pqmoULXQkMKWN4cmYJWMi4YRyC1T
	SNvFmkHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0s-00AOIa-BQ; Wed, 09 Nov 2022 03:44:30 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0m-00AOHx-B6
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:25 +0000
Received: by mail-pj1-f41.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so762182pji.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azp/TS1eCcz1XlsuHASBurkpcZDAHIUYFxBYWUzaywM=;
        b=gFgSwsrcMq2FWJRC3PP4ZkVDDVJa6DsfLIZfXuIZEYRY/6JF3Ymunb2xCB78mTpB+B
         RdnbhieygrYXt9ad96BjeEAL/058zLu/ztaqEsiwXbYdsbMquJdd6+pW4mPNZDLrvF9a
         iK2Rdl6oPdsoeWXewsrrLwyunZkY9cZxSXVX6BYvY2s0H1twiDXGkGOY2PbU9X8ZLNRV
         Cfncmkdq7imn2BiA6b8WoTb0/EpyveiCnCAMWM8lXQtVjxNx7ODoFKoTX04GREofwBGE
         fUFiDbV3pTDq1QxY/pduxR2DutX0A7+kWv6+isfWEvLkiSMZsZxV9zhyEMtO1UWNCP/U
         XzMQ==
X-Gm-Message-State: ACrzQf0UnOBy3/8Kpq1zRZqAqqp84rvTWQvKvnDvpctV7dnFsh8ZRHLh
	F6vvXc/uBhSneHEbh+Tc1af8Yfi79rQvx6BR
X-Google-Smtp-Source: AMsMyM7JPxH1DaURqvEb2YmQd8VGlRAkAT5Bk0G3pkiBSdCCRlxttGNAS7EeKzdK76kKjsBhocYIBA==
X-Received: by 2002:a17:903:22c7:b0:187:190d:da89 with SMTP id y7-20020a17090322c700b00187190dda89mr53376489plg.68.1667965462953;
        Tue, 08 Nov 2022 19:44:22 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:22 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 00/16] nvme: rework dhchap authentication host code
Date: Wed,  9 Nov 2022 05:44:03 +0200
Message-Id: <20221109034420.1000086-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194424_402453_A248E129 
X-CRM114-Status: GOOD (  11.25  )
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

Currently the authentication code is fairly fragile with respect to
mutual locking between secrets sysfs override, re-authentication, and
controller resets.

This patch set attempts to resolve these issues by:
1. freeing queue chap context as soon as authentication completes
2. allocates a simple vector for queue chap contexts so there is
no list/tree traversal to resolve queue chap context. queue chap
contexts are 1x1 mapped to queues, which are stored in a vector as
well.
3. flush chap auth_work from the ctrl dhchap work, this simplifies
how we flush inflight authentication sequence
4. use ctrl dhchap_auth_mutex to protect only the resources that are
accessed and modified via sysfs and the authentication flow (i.e. ctrl
host_key and ctrl_key)
5. move drivers (rdma/tcp) nvme_auth_stop later in the error recovery
flow to expedite failover and not block on I/O.


Feedback is welcome.

Sagi Grimberg (16):
  nvme-auth: rename __nvme_auth_[reset|free] to
    nvme_auth[reset|free]_dhchap
  nvme-auth: remove symbol export from nvme_auth_reset
  nvme-auth: don't re-authenticate if the controller is not LIVE
  nvme-auth: remove redundant buffer deallocations
  nvme-auth: don't ignore key generation failures when initializing ctrl
    keys
  nvme-auth: don't override ctrl keys before validation
  nvme-auth: remove redundant if statement
  nvme-auth: don't keep long lived 4k dhchap buffer
  nvme-auth: clear sensitive info right after authentication completes
  nvme-auth: remove redundant deallocations
  nvme-auth: no need to reset chap contexts on re-authentication
  nvme-auth: convert dhchap_auth_list to an array
  nvme-auth: remove redundant auth_work flush
  nvme-auth: have dhchap_auth_work wait for queues auth to complete
  nvme-tcp: stop auth work after tearing down queues in error recovery
  nvme-rdma: stop auth work after tearing down queues in error recovery

 drivers/nvme/host/auth.c | 209 ++++++++++++++++++---------------------
 drivers/nvme/host/core.c |  26 +++--
 drivers/nvme/host/nvme.h |   5 +-
 drivers/nvme/host/rdma.c |   2 +-
 drivers/nvme/host/tcp.c  |   2 +-
 5 files changed, 121 insertions(+), 123 deletions(-)

-- 
2.34.1


