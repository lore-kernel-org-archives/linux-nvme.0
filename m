Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5772DECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yn5Vmq3Cm4oAwDOSbjug0BlKKs7PR3kgHGrjqPwqg4o=; b=sKLI8fv7e7o+glQFYMaXsFw08g
	0+OIRabUSrrG7ivLLDPCnubtWPCF3fWm6d/oMeBTNmt7zbiC20VggmoFR+NbnUeq7Nvc/SIr8QO89
	Hnze1TSQG7dg9Ol7BJahoJR7NGcy6eLWgq2A9rDkHfRriA4Wflz0XKTULCcd+fezrUelN3jqiuKJ2
	V/FBYgrYbPNXHJ1IJiueXphY4WEQlEGajPprHDzjD3CGcJ/EC9Fw3+FOlQCOa2VGgQQvb82qjk30i
	tml0lPll9/hJr5tsFDsdBpA8cnmvF+6KPwOuTfPsB0CyHU8qGnoXpirKepE9op4NgNgttHx+4ZzXG
	sG1V450Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0gZ-00Gx6f-5o; Tue, 30 Aug 2022 12:49:43 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0gO-00Gww0-50
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 12:49:33 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 17F031FA7C;
	Tue, 30 Aug 2022 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661863767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Yn5Vmq3Cm4oAwDOSbjug0BlKKs7PR3kgHGrjqPwqg4o=;
	b=jBprTZS3PXFeHpkRoyV7lFwU5z0N1XNyl2hEMCVoZe4jYhpog56XCi6sUR1IV2523LshMH
	MpqvBoEsEQqWIy7UWYMxTwGs0gy2KSKeCT6IrvFGa2aFKSzu7ZJoEH0Ai5QJJ1SiIYIeFB
	GWaupklDpxg+8ZWrE70w6ahSmBFN5bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661863767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Yn5Vmq3Cm4oAwDOSbjug0BlKKs7PR3kgHGrjqPwqg4o=;
	b=2+0tnrTN46OUlQ9Bsd5FH+omP6pMs8n6qWMbJIiV56B47IqmPYfqFNnCnmB2jmqI78zyju
	KF/Ckm8qTy+fzTAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 0ABAD2C142;
	Tue, 30 Aug 2022 12:49:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id EB5F951AA5B8; Tue, 30 Aug 2022 14:49:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/2] nvme: honor DNR status for authentication
Date: Tue, 30 Aug 2022 14:49:23 +0200
Message-Id: <20220830124925.40711-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_054932_362165_5BCD443E 
X-CRM114-Status: GOOD (  12.24  )
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

when sending authentication commands we should be checking the DNR bit
in the cqe status to figure out if a command should be retried.
So the first patch will evaluate the DNR bit during _nvme_submit_sync_cmd()
and initiate a retry, and the second patch will set the DNR bit in
the nvme authentication code such that we don't attempt to retry the
'connect' operation.
I have opened pull request #100 for blktests to validate this behaviour.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme-auth: retry command if DNR bit is not set
  nvme-auth: set the DNR bit if authentication failed

 drivers/nvme/host/auth.c    | 22 +++++++++++-----------
 drivers/nvme/host/core.c    | 20 ++++++++++++++++++--
 drivers/nvme/host/fabrics.c |  4 ++--
 include/linux/blk-mq.h      |  2 ++
 4 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.35.3


