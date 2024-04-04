Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A427CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=; b=AwGDmuO6pHFpGJyVXZWDc64A9i
	FAg1yHZO7tGjUuHhf1E3dTm9rtxACegBZ7jf0NBc6J0MCr7JpV/e+oPjcpt87QI9M12+KEW8wCVcN
	oakG1bZl+hRmR6D7655taC8tKvQysGPeqiC5zXB4y/AMpRo16tb1lgwF5pJXdfGzm6lOXnDF56SVH
	u8SuNf9mj6z7ct9jV5I3IlFdGt8/+B2YYk+dOgeGoZhVk/hHdA53W29/LUmO8LaL/xuUxbpEaEY7b
	bbc+A8ka0J7istqScDC3UtVIuUTofl5EqjWVcyit6ECONjV0Z7lcg92DFedZPqXy+307Mzc/tDKqb
	44ONjUWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPHJ-00000003IJO-2Eph;
	Thu, 04 Apr 2024 15:45:25 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPH4-00000003IAh-3a0M
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 15:45:18 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD0CB5F8A6;
	Thu,  4 Apr 2024 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=;
	b=YvCd9a4xXD4Vfov9r8Hq/a09gIv7ND3DZeVqCvuGHiOsvn45N6lVey2c1fq8fG1I2J1kWR
	9Yc8gBtLYhL0l9nkwrv7O/RytBxXmTWjZZZYIDWcCWX/KyHs07xeavNsbETSFUxYWsdscN
	8LmPpqOVVs7sGWYHYJAGdp09Qp18opw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=;
	b=3anlJ1K2pPehBf/PVAnF4VSmLBGHNd/155UW7lTBliD0LudBmZG0mNgcO+UlL7dQCHlmVU
	Roiwfy1k+VOWqrBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=;
	b=OXCfHVUqZHTTeGijXRik7Trbt3v7bD/tE9ZIEhZOfGTvs3w1qLOIOkQ2+7F74OoRd8+rzQ
	EWucDOogsycPxpoJ4RSbKKiBzVysvxCpRexJshj+ruYvEz4s/YQm87WUinAye+3dTBl2zU
	14HnvaMhlQv7faFlm9mpX6Qcy34Emv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uVo10kz89o1MerHSNdsoxdo91ntoYyDbukfjJjRlFvM=;
	b=a/3xHjsvgxYfRiqVMA2E3yjdTVbS9K5mrJsudmsDZG8g2yX8aL+2ODz90oA7xeC+r7tfyY
	6shryOt7sl9nuMDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B31A139E8;
	Thu,  4 Apr 2024 15:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id E9mSJALLDmYAIgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 15:45:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 0/5] nvme-fabrics: short-circuit connect retries
Date: Thu,  4 Apr 2024 17:44:55 +0200
Message-ID: <20240404154500.2101-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_084511_140156_39EB5DFB 
X-CRM114-Status: GOOD (  10.94  )
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

An rebase of Hannes two series which fix the TCP and RDMA transport to handle
the DNR bit on connect attempts.

For testing I extended the nvme/045 test case. I'll update the test case later
when the current batch of blktest changes are done. Also this change depends on
the extension of the debugfs interface of nvmet, which is also not yet merged.

	echo "Renew host key on the controller and force reconnect"

	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"

	_set_nvmet_hostkey "${def_hostnqn}" "${new_hostkey}"

	# Force a reconnect
	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
	cntlid="$(nvme id-ctrl "/dev/${nvmedev}" | grep cntlid | awk '{print $3}')"
	echo "fatal" > /sys/kernel/debug/nvmet/"${def_subsysnqn}/ctrl$((${cntlid}))"/state
	nvmf_wait_for_ctrl_delete "${nvmedev}"


baseline:

run 1 loop (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  2.690s  ...  2.777s
run 1 tcp (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [failed]
    runtime  2.777s  ...  8.030s
    --- tests/nvme/045.out      2024-04-04 16:14:22.547250311 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/045.out.bad 2024-04-04 17:29:03.427799336 +0200
    @@ -9,5 +9,6 @@
     Change hash to hmac(sha512)
     Re-authenticate with changed hash
     Renew host key on the controller and force reconnect
    -disconnected 0 controller(s)
    +controller "nvme2" not deleted within 5 seconds
    +disconnected 1 controller(s)
     Test complete
run 1 rdma (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [failed]
    runtime  8.030s  ...  9.632s
    --- tests/nvme/045.out      2024-04-04 16:14:22.547250311 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/045.out.bad 2024-04-04 17:29:15.017745115 +0200
    @@ -9,5 +9,6 @@
     Change hash to hmac(sha512)
     Re-authenticate with changed hash
     Renew host key on the controller and force reconnect
    -disconnected 0 controller(s)
    +controller "nvme2" not deleted within 5 seconds
    +disconnected 1 controller(s)
     Test complete
run 1 fc (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  9.632s  ...  3.588s


patched:

run 1 loop (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  6.816s  ...  2.492s
run 1 tcp (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  2.492s  ...  3.663s
run 1 rdma (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.663s  ...  3.795s
run 1 fc (nvmet_blkdev_type file)
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.795s  ...  2.690s



changes:
v4:
  - rebased
  - added 'nvme: fixes for authentication errors' series
    https://lore.kernel.org/linux-nvme/20240301112823.132570-1-hare@kernel.org/

v3:
  - added my SOB tag
  - fixed indention
  - https://lore.kernel.org/linux-nvme/20240305080005.3638-1-dwagner@suse.de/

v2:
  - refresh/rebase on current head
  - extended blktests (nvme/045) to cover this case
    (see separate post)
  - https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/
  
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20210623143250.82445-1-hare@suse.de/


*** BLURB HERE ***

Hannes Reinecke (5):
  nvme: authentication error are always non-retryable
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvmet: return DHCHAP status codes from nvmet_setup_auth()
  nvme-tcp: short-circuit reconnect retries
  nvme-rdma: short-circuit reconnect retries

 drivers/nvme/host/core.c               |  6 +++---
 drivers/nvme/host/fabrics.c            | 29 +++++++++++++++-----------
 drivers/nvme/host/nvme.h               | 19 ++++++++++++++++-
 drivers/nvme/host/rdma.c               | 22 ++++++++++++-------
 drivers/nvme/host/tcp.c                | 23 +++++++++++++-------
 drivers/nvme/target/auth.c             | 20 ++++++++----------
 drivers/nvme/target/configfs.c         | 22 ++++++++++++++-----
 drivers/nvme/target/fabrics-cmd-auth.c | 11 +++++-----
 8 files changed, 100 insertions(+), 52 deletions(-)

-- 
2.44.0


