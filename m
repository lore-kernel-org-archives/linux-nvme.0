Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3DAC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:52:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547B064E3B
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547B064E3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fZxR0nddcqOsUXCKCHgoFwcpKu0PSsqCgVcygNrMwgo=; b=aD4fWN5H7J2Z2aWvEpT4cV+8oD
	RpFnPC7jLh4po/bJvJ52/73Tr9Am7C3ewasK7TzhJUq6YT/rs5PWVY2ZsUjcRLy55HgPudXqy4phh
	jGvZLcEFFg5yDW6m2ZlfnRs7ASLQRXCZHXcy7Sx6U42QDkGeEHKnigrthePshJrODC+kdE2mHwcZd
	kUXkCpAT2FZ8wtRiLrQcR5hXyQLL2rxtUPeFUSWZE70whYVVJa/yiqtYRjR2kJ6i5ZJQfl08yElS1
	dijj4S4WouByPiDnGk6PCIRR/1DSH3N37eIq73c8OB8m2DlxrvTFq5eYATOiJl2DjvRXpuw6oXutL
	WyZp3UTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAakP-00071e-TA; Fri, 12 Feb 2021 15:52:45 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAakH-0006yR-Oa
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 15:52:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B9692B773;
 Fri, 12 Feb 2021 15:52:36 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH 0/3] nvmetcli: remote configuation
Date: Fri, 12 Feb 2021 16:52:26 +0100
Message-Id: <20210212155229.98816-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_105237_957978_781684BF 
X-CRM114-Status: GOOD (  13.52  )
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
Cc: Daniel Wagner <dwagner@suse.de>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Enzo Matsumiya <ematsumiya@suse.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

I've discovered that SPDK has an JSON RPC interface which allows for
remote configuration. And it turns out that the SPDK configuration
itself is pretty similar to the in-kernel NVMe-oF target (surprise,
surprise).
And to not let SPDK have an upper edge here's a simple JSON-RPC proxy
for nvmet, together with a JSON-RPC client 'nvmetadm'.
This allows a full remote configuration of an NVMe-oF target:

# nvmetadm nvmf_create_subsystem --nqn=nqn.nvmf-test1
# nvmetadm nvmf_subsystem_add_port --nqn=nqn.nvmf-test1 \
  --traddr=<target-ip> --trtrype=tcp --adrfam=ipv6
# nvmetadm bdev_create_file --file-name=Testfile1 --size=1G
# nvmetadm nvmf_subsystem_add_ns --nqn=nqn.nvmf-test1 \
  --bdev=Testfile1
# nvmetadm nvmf_subsystem_add_host --nqn=nqn.nvmf-test1 \
  --host=<hostnqn>
# nvme discover --transport=tcp --traddr=<target-ip> \
  --trsvcid=4420

With this it should be possible to convert blktests nvme suite to use
this interface, which will allow blktest to run across arbitrary
transports instead of just nvme-loop.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvmetcli: add 'merge' parameter to set_config()
  nvmetproxy: add a JSON-RPC proxy daemon
  nvmetadm: add JSON-RPC client for remote configuration

 Documentation/Makefile       |  24 +-
 Documentation/nvmetproxy.txt | 111 ++++++++
 nvmet/__init__.py            |   4 +-
 nvmet/bdev.py                |  72 +++++
 nvmet/nvme.py                |   8 +-
 nvmet/rpc.py                 | 495 +++++++++++++++++++++++++++++++++++
 nvmetadm                     | 259 ++++++++++++++++++
 nvmetcli                     |   4 +-
 nvmetproxy                   | 197 ++++++++++++++
 setup.py                     |   2 +-
 10 files changed, 1157 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/nvmetproxy.txt
 create mode 100644 nvmet/bdev.py
 create mode 100644 nvmet/rpc.py
 create mode 100755 nvmetadm
 create mode 100755 nvmetproxy

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
