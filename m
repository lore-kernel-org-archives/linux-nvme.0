Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FF9C3F2CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FB220848
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q2N1kjiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FB220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=rvpSvLkUt89BJJAk0SedJaZJB73OO0XPxarHGTHb4iY=; b=q2N
	1kjiuGCQIfYa+ZXKBYahdzBrpGKjZTviCOeOezS/5pPAtgX7UKFkDWCWqcjXqBJ8LiSwdHW3BZMrm
	Nssf2/wFUofnosEvfr7RCAsN2HMzPVOQOed7rkmbLkTuMbDH2qYqQfSagBHG4su5F0OZ9d7KQVlWB
	jL2/9yQj9xLWLkxrvkWVtGe3rOy4hzQqzYrF4991RaioV3q0pgvUjHOptWFuPwmBM2hGoq/bIB7ZE
	diKq041owXNXXlSiNAwCt0MeRYthZ/bqr0c4oVL5ok2c8dv2Q6LEn+uJoZTb648GkumnCUBSWJHmW
	LH0j+LgobAK37tWR8PuzMS30tTUFspg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9p3r-0005Hh-9O; Thu, 05 Mar 2020 11:53:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9p3o-0005FY-Ur
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 11:53:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4FA8EAD5F;
 Thu,  5 Mar 2020 11:52:59 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH blktests 0/3] ANA and fcloop tests
Date: Thu,  5 Mar 2020 12:52:36 +0100
Message-Id: <20200305115239.29794-1-hare@suse.de>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_035305_182991_76587618 
X-CRM114-Status: GOOD (  11.74  )
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
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Omar,

here are two small tests which have been lingering in my repository
for far too long, so I figured it's time to finally post them.
The first is a rather trivial one for testing ANA states, the second
finally adds a test case for the FC Loop driver.
It also serves as a template on how to actually _use_ the FC Loop
driver itself :-)

However, that one uncovered a use-after-free issue in the NVMe-FC
stack; check the 'Fixme' line in the test. As it _might_ be a generic
issue and not something specific to fcloop I'm posting it now to
allow other people (Hi James!) to reproduce and possibly fix it.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: enable ANA support
  nvme/033: add test for ANA state transition
  tests/nvme/034: Add a test for the fcloop driver

 common/fcloop      |  58 ++++++++++++++++++++++
 tests/nvme/033     | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  18 +++++++
 tests/nvme/034     | 122 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |   3 ++
 tests/nvme/rc      |  88 +++++++++++++++++++++++++++++++--
 6 files changed, 425 insertions(+), 3 deletions(-)
 create mode 100644 common/fcloop
 create mode 100644 tests/nvme/033
 create mode 100644 tests/nvme/033.out
 create mode 100644 tests/nvme/034
 create mode 100644 tests/nvme/034.out

-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
