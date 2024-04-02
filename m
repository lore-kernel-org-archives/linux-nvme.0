Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98785C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BtH0JQusNt/m2acAX0Gmxhgcf2jNVxYa++5QTX/0eY0=; b=eTXykk1PdI4NDDOUoIlfY1Kseo
	gC2QIdzktGaDR95h7qOAg/Wrd7NJf4Dkn2lI6bruOQzE1qbp7hEFCAqL8jU++twGaI2/UkU8OmN7W
	3qxJF5Td/SFLvbexmvUGIUFE++N+qaDxwhj2C3QV+T/nf0g0R8inA7Li+MALdJMRuAIXvYrCrK78I
	hdgjCrOcbyP6C6069fdBeUxUk4EfzYa0oMhUQRiJ2lpt8Ij3C2rawuG1rP3RJSyhSvOUEqjIqj7eJ
	gV9sJImen697TIt/zPY1QnSLsXYJ76fRLNVc0cwy+DvV5Jrm6JXgzMOidg0g6ai2a5OHfeI7kIikT
	d3/wzvIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrazM-0000000AYZx-2l3R;
	Tue, 02 Apr 2024 10:03:32 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrazG-0000000AYY9-3nBb
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 10:03:30 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CFFE20F22;
	Tue,  2 Apr 2024 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712052204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BtH0JQusNt/m2acAX0Gmxhgcf2jNVxYa++5QTX/0eY0=;
	b=Yzqcq4l8FeaP1xYTTN7LN7cOm0GMP9WoewrI3fuBvpTA+1vE8Vg2pA149fDxwDgXvNeWoY
	erdXzXbskOM+woJanEM2rlkWToJI2djT07NzMUOdpLl3/KnzgAS0NJbPME0jzjVe2VqQ/J
	SLQc2l1HKXlGRULUCc52zSobPqjX0tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712052204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BtH0JQusNt/m2acAX0Gmxhgcf2jNVxYa++5QTX/0eY0=;
	b=/NHW3jlWEQmvr2zmdJAg4F68KciB6ozBaL3xqK5UVFV6XWoBmqCR0O3UNjaOZ1oGIVXhWk
	N5yRKxhbOVrJslDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AB5413A90;
	Tue,  2 Apr 2024 10:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gT2zFOzXC2bxCQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 02 Apr 2024 10:03:24 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/3] add blkdev type environment variable
Date: Tue,  2 Apr 2024 12:03:19 +0200
Message-ID: <20240402100322.17673-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CFFE20F22
X-Spamd-Result: default: False [-1.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_030327_118184_05B9F12D 
X-CRM114-Status: GOOD (  11.79  )
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

During the last batch of refactoring I noticed that we could reduce the number
of tests a bit. There are tests which are almost identically except how the
target is configured, file vs block device backend.

By introducing a configure knob, we can drop the duplicates and even make some
of the tests a bit more versatile. Not all tests exists in file and block device
backend version. Thus we increase the test coverage with this series. And not
really surprising, there is a fallout. The nvme/028 test with file backend is
failing in my setup but I was not able to figure out where things go wrong yet.
I'll provide some logs later.

Daniel Wagner (3):
  nvme/rc: add blkdev type environment variable
  nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type
    tests
  nvme/{021,022,025,026,027,028}: do not hard code target blkdev type

 Documentation/running-tests.md |  2 ++
 tests/nvme/006                 |  5 ++--
 tests/nvme/007                 | 28 --------------------
 tests/nvme/007.out             |  2 --
 tests/nvme/008                 |  4 +--
 tests/nvme/009                 | 36 -------------------------
 tests/nvme/009.out             |  3 ---
 tests/nvme/010                 |  4 +--
 tests/nvme/011                 | 39 ---------------------------
 tests/nvme/011.out             |  3 ---
 tests/nvme/012                 |  4 +--
 tests/nvme/013                 | 43 ------------------------------
 tests/nvme/013.out             |  3 ---
 tests/nvme/014                 |  4 +--
 tests/nvme/015                 | 48 ----------------------------------
 tests/nvme/015.out             |  4 ---
 tests/nvme/019                 |  4 +--
 tests/nvme/020                 | 40 ----------------------------
 tests/nvme/020.out             |  4 ---
 tests/nvme/021                 |  6 ++---
 tests/nvme/022                 |  6 ++---
 tests/nvme/023                 |  4 +--
 tests/nvme/024                 | 40 ----------------------------
 tests/nvme/024.out             |  2 --
 tests/nvme/025                 |  6 ++---
 tests/nvme/026                 |  6 ++---
 tests/nvme/027                 |  6 ++---
 tests/nvme/028                 |  6 ++---
 tests/nvme/rc                  |  3 ++-
 29 files changed, 36 insertions(+), 329 deletions(-)
 delete mode 100755 tests/nvme/007
 delete mode 100644 tests/nvme/007.out
 delete mode 100755 tests/nvme/009
 delete mode 100644 tests/nvme/009.out
 delete mode 100755 tests/nvme/011
 delete mode 100644 tests/nvme/011.out
 delete mode 100755 tests/nvme/013
 delete mode 100644 tests/nvme/013.out
 delete mode 100755 tests/nvme/015
 delete mode 100644 tests/nvme/015.out
 delete mode 100755 tests/nvme/020
 delete mode 100644 tests/nvme/020.out
 delete mode 100755 tests/nvme/024
 delete mode 100644 tests/nvme/024.out

-- 
2.44.0


