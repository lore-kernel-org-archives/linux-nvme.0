Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF9BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=REFDAdH8sr7J9iN9pw5pUINbr5h+nmjAF3mf9wY09S4=; b=yLsj1MN+OXoURIbeHkTQ9RZNE+
	BRHJli98l6G2fXYpnK92oYnOcGeKmNwtenzBo5hbf13dXHQxpiAR1y6sgPaZJbBqtegR7xnM0fIAF
	Fp/yAs0M52C+eknDiwPWN8J2eDK+mtvQQlCjCLHP82zJDnVb1LdHc7QVS+4mUexQllboY6e2JOUl6
	wB9ubaOfmYzJYqhrnVhcMOQvLxGjoubL+qKcN20XhaqxJ8Herl9GprMYdDjOdzF/suk6zB7ix3i9P
	0Z/oAJTIA94lTSf9NY1RKapG7c6WKic7uVcr5bUeflx2c0eS3UF4C3rsNKyvQ4flvA3koffZKN0cP
	/u/5ybCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTiKZ-00533K-6D; Mon, 14 Mar 2022 10:53:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTiKX-00531d-18
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 10:53:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 538C11F391;
 Mon, 14 Mar 2022 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647255215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=REFDAdH8sr7J9iN9pw5pUINbr5h+nmjAF3mf9wY09S4=;
 b=Vx7VOlO2ENMKnup7v2fIXnH+IN2ru/dpmGSdI9+q9BfKIDyKo2tJ+hp8BNEtyGBbAvQC9S
 gxhiCDLaTRjTs1+2PYCP08CKa8+79qoqMNTNyFbf9Ul+D7gFmghhDnYgUn0HFAzZ6hbCi7
 B3LN56Y34jne0v0DqD7yQP0Ttnfj5Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647255215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=REFDAdH8sr7J9iN9pw5pUINbr5h+nmjAF3mf9wY09S4=;
 b=QJfaUXPDafS0lNgvocIeN/TjPrSsAxwuMNOVfOuRoJjw141Go8llzgPJTzFtAwSPYjIheB
 Mi6mYWnZeSCU50Bw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 204ADA3B87;
 Mon, 14 Mar 2022 10:53:34 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 4D19B51936AB; Mon, 14 Mar 2022 11:53:34 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH 0/3] nvmet: export discovery subsystem
Date: Mon, 14 Mar 2022 11:53:30 +0100
Message-Id: <20220314105333.56714-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_035337_238015_F5194256 
X-CRM114-Status: GOOD (  13.23  )
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

Hi all,

here's a patchset to expose the discovery subsystem in configfs.
The current implementation is has a rather 'odd' discovery subsystem
implementation; there is one discovery subsystem structure, but the
details of this subsystem will be modified depending from which port
(and, consequently, port->subsystem link) is has been called.
This makes is really awkward to assign unique properties to it
(like the unique discovery NQN).

With this patchset the discovery subsystem is elevated to a 'real'
subsystem, with a normal subsystem entry in sysfs and with activation
of it by linking this subsystem to ports.
This gives full control to the user which subsystem should be visible
on this discovery controller, and also allows to have a discovery
controller with no I/O subsystems at all.

Drawback is that it's a change in operation, as the user _has_ to
link the subsystem to individual ports.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvmet: expose discovery subsystem in sysfs
  nvmet: restrict setting of discovery_nqn to discovery subsystem
  nvmet: do not allow to create a subsystem with the discovery NQN

 drivers/nvme/target/configfs.c  | 46 +++++++++++++++++++++++++++++----
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/discovery.c |  7 +----
 3 files changed, 43 insertions(+), 11 deletions(-)

-- 
2.29.2


