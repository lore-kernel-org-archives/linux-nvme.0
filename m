Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64944C83F16
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jby3RLt4Cl7pfimcnYIo/yv1eOMTGSq77VEFESvTCik=; b=tEqmfdBmwPHU8UFpDsZctrnZEY
	qB1z0Ti2zFxv0oIdNR8iz/0DtOCMfe7gu2myxEUTSI73zq1wkt0aNY3pIZr94ZIxXEWL7MsESZyO4
	7c/l5opmVYVtnOau+CMBbgaMArhCbYeQ6cwzrztw1EMvfoDfvjdaqLR99hPXbOGkHnOY1B2+DRUln
	Q0n3uVAHZoo/W++SM1YZzo1bGgyDUfyADUfiKA3bGOBD92D5uPP7rAQ8vKQo2bmJCgUbhqEsNsrqV
	qXSgvQa8cqRuMbxFjdBbL87VuUWey19/rDBx232jM8XW2uI+iCea/kYJYghHmnD6pTLXcFDtsUImy
	yoatT03w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaunC-00B67x-2y;
	Tue, 29 Aug 2023 09:13:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaun8-00B65q-2F
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 09:13:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F2EB21863;
	Tue, 29 Aug 2023 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693300417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jby3RLt4Cl7pfimcnYIo/yv1eOMTGSq77VEFESvTCik=;
	b=ElbfAXA4M7q/Wsy/ajvXromF6qw1Mm4xKNn2Tap2eCFTDjDWCPl/QiIwgTWq42Z+j1SjSI
	xwt10BPB62zJtdVeF89kb2S1i7IEVQfMB6NZt80pgN+M8B3v5WmaGX47Phwi1senTk+6c/
	qLoN5WwlwDvdrZmrzjanaknL+XIXak8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693300417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jby3RLt4Cl7pfimcnYIo/yv1eOMTGSq77VEFESvTCik=;
	b=luU0R0AnLAGQz8VB8ufnb9kSEtoN8VPLEI0163BUUwlcuVubjyOyRcCUhXBIujJoTMetWC
	kv8GzLa4YUTWjzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4149013301;
	Tue, 29 Aug 2023 09:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aHTpD8G27WSnUwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 29 Aug 2023 09:13:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 0/4] nvmet-fc blktests & autoconnect fixes
Date: Tue, 29 Aug 2023 11:13:45 +0200
Message-ID: <20230829091350.16156-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_021342_903489_A74A0C0A 
X-CRM114-Status: GOOD (  17.72  )
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

Currently, blktests will pass with the patches [1] and the revert of
[2]. This is possible because blktests is still disables the
nvmf-autoconnect auto connect service [3].

As I previously reported, blktests is able to trigger various kernel
panics with the system auto-connect running in the background. Let's try
to fix these problems.

The first two patches are fixing nvmet ftrace infrastructure. I think
they could go in right now.

The third patch changes the way the refcounting for association and
queues is done. There is a cycling dependency between these two objects
and this makes the shutdown path very complex and error prone. As the
life time of the queues is coupled to the association, I decided to drop
the refcounting of the queues and only rely on the refcounts of the
association. This made the code a bit simpler to follow and also allowed
to cleanup path to split into two halfs. The first one is to remove the
association from the association RCU list and wait for an grace period
so we know that now new I/Os will enter any queues. Then we drop the
refcounts and then actually remove any resources when the refcount drops
to 0 (all in-flight I/O has been processed). nvme/003 is particular good
in triggering crashes in this path.

nvme/005 is triggering crashes in get discovery log page. The req->port
pointer was never assign a valid pointer. This looks like there is way
to have no port entry binding (remember we have the external autoconnect
running in background).

Unfortunately, there are still some more fallouts, but I though I post
these patches now when my memory is fresh if there are any questions.

[1] https://lore.kernel.org/linux-nvme/sgoyzwj6ckrdrpq22u6fhtcemul5rqj6de4l5gw73vz77o3ils@vmv3jue4rom7/
[2] linux: ee6fdc5055e9 ("nvme-fc: fix race between error recovery and creating association")
[3] blktests: 0478dce70696 ("nvme/rc: Avoid triggering host nvme-cli autoconnect")

Daniel Wagner (4):
  nvmet-trace: avoid dereferencing pointer too early
  nvmet-trace: null terminate device name string correctly
  nvmet-fc: untangle cross refcounting objects
  nvmet-discovery: do not use invalid port

 drivers/nvme/target/discovery.c |  9 +++++
 drivers/nvme/target/fc.c        | 67 ++++++++++++++++-----------------
 drivers/nvme/target/trace.c     |  6 +--
 drivers/nvme/target/trace.h     | 28 +++++++-------
 4 files changed, 60 insertions(+), 50 deletions(-)

-- 
2.41.0


