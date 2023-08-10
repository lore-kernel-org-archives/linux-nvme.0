Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBFBC04FE1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rED1+lo1CKJ5LFxieE+v2KK5zpNWwJpOZuEn3HSuHHA=; b=bB5l5U0YS2zKDxSZsxSmB/pYa9
	2wcELpOLONPlwhI9ihdczu+5cYE8/n26d1H2o/HBtACVPFC0HjGDoUvNYgjrewGsI47IgQ4r7eRSR
	3hk6k/bShaZ74n8NWQ5UJwPpjZiUN0GWm8sziHyvtj/km70kD5PPUGdWygOO9cyFjIsjQhyuUfkuY
	yiuKjt3XYROEmPZgaKEkP/0zRwdQ6fPkmdZRr8rzym+aaTk91lGjLGOx0pirniksJavTDaQE8MwYK
	6JJiZqYWupPdh847NKV34wIOIHLHw3YHGKGfq0oKPO8kBoFkrm4I+bvb74AnPL0UxmfU98/+d4ytx
	cWTprLAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bj-007MHF-2J;
	Thu, 10 Aug 2023 11:13:35 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bc-007M7V-0B
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 11:13:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD1821865;
	Thu, 10 Aug 2023 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691666002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rED1+lo1CKJ5LFxieE+v2KK5zpNWwJpOZuEn3HSuHHA=;
	b=Ppgj6l/IFCnycH8s5StteFd7ASPa6UPdtyp+8Kj4VbYnbYn+xrTpaqOdVRWrIlGxK5PML4
	Y+WAIxtfvCtgpnMjblpm5WjWV/v5UwpVfzTrXe+x5rx0dca5GAiuU41ZfQZYAH4H4zE4ha
	zHsHJnxhHiNayZDezAbEu92sfEy+eME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691666002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rED1+lo1CKJ5LFxieE+v2KK5zpNWwJpOZuEn3HSuHHA=;
	b=WDjrFZViFgdsr/hPTQWCHPVpz7OZLNCnp4bl1uvzXTzWJ6rWt1+X0hCj4sFAVayMxAMcN8
	+LaES6HkAuO1tXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40F2D138E2;
	Thu, 10 Aug 2023 11:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UzPDD1LG1GQwLwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 11:13:22 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart2021@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 00/12] Switch to allowed_host 
Date: Thu, 10 Aug 2023 13:13:05 +0200
Message-ID: <20230810111317.25273-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_041328_236940_E0F320E4 
X-CRM114-Status: GOOD (  19.71  )
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

I've updated the series accoring the feedback. Also added the mentioned
_nvmet_target_{setup|cleanup} helpers which reduced a lot of code.
Roughly 350 lines code less after the refactoring.

Maybe it's possible to refactor even more, e.g. this snippet


	local nvmedev
	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
	cat "/sys/block/${nvmedev}n1/uuid"
	cat "/sys/block/${nvmedev}n1/wwid"

could be moved into _nvme_connect_subsys(). Though there are quiet a few tests
which want the nvmedev later on for something like

	_run_fio_verify_io --size="${nvme_img_size}" \
		--filename="/dev/${nvmedev}n1"

So we could return the nvmedev from _nvme_connect_subsys() but I don't know if
this a good idea. FWIW, it would also fix the current problem we face with
nvme/047 which seems to lack the second _find_nvme_dev() call.


original cover letter:

Max asked me to replace replace the 'nvme/rc: Avoid triggering host nvme-cli
autoconnect' feature with using allowed_host on the target side [1]

So while looking into this new feature, I first started to refactor existing
code so that it looks a bit more consistent. I think there is even more
potential to make it smaller, by introducing something similiar to
_nvmet_passthru_target_setup() and _nvmet_passthru_target_cleanup() for non
passthru tests. A lot of duplicated setup/cleanup code in many tests.

Except the last two patches are just refactoring patches. So if we decide to use
common target setup/cleanup helpers, I think we could add them before the last
two patches, which would make the last patch way smaller.

Daniel

[1] https://lore.kernel.org/all/4b17be94-d068-f026-756f-59208075e254@nvidia.com/

changes:
v2:
 - updated commit messages
 - moved the removal of subsys_name to the right patch
 - added _nvmet_target_{setup|cleanup} helpers
   this addresses also the 'appears unused' warning by ShellCheck

v1:
 - initial version
   https://lore.kernel.org/linux-nvme/20230726124644.12619-1-dwagner@suse.de/

Daniel Wagner (12):
  nvme/{003,004,005,013,046,049}: Group all variables declarations
  nvme: Reorganize test preamble code section
  nvme/rc: Add common subsystem nqn define
  nvme: Use def_subsysnqn variable instead local variable
  nvme/{041,042,043,044,045,048}: Remove local variable hostnqn and
    hostid
  nvme/rc: Add common file_path name define
  nvme: Use def_file_path variable instead local variable
  nvme/rc: Add common def_subsys_uuid define
  nvme: Use def_subsys_uuid variable
  nvme/rc: Add helper for adding/removing to allow list
  nvme: Add explicitly host to allow_host list
  nvme: Introduce nvmet_target_{setup/cleanup} common code

 tests/nvme/003 | 12 ++-----
 tests/nvme/004 | 23 ++++---------
 tests/nvme/005 | 22 +++---------
 tests/nvme/006 | 21 ++----------
 tests/nvme/007 | 19 ++---------
 tests/nvme/008 | 26 +++------------
 tests/nvme/009 | 21 +++---------
 tests/nvme/010 | 26 +++------------
 tests/nvme/011 | 22 +++---------
 tests/nvme/012 | 26 +++------------
 tests/nvme/013 | 22 +++---------
 tests/nvme/014 | 26 +++------------
 tests/nvme/015 | 21 +++---------
 tests/nvme/016 | 17 +++++-----
 tests/nvme/017 | 26 ++++++---------
 tests/nvme/018 | 21 +++---------
 tests/nvme/019 | 26 +++------------
 tests/nvme/020 | 21 +++---------
 tests/nvme/021 | 21 +++---------
 tests/nvme/022 | 21 +++---------
 tests/nvme/023 | 26 +++------------
 tests/nvme/024 | 21 +++---------
 tests/nvme/025 | 21 +++---------
 tests/nvme/026 | 21 +++---------
 tests/nvme/027 | 20 +++--------
 tests/nvme/028 | 20 +++--------
 tests/nvme/029 | 26 +++------------
 tests/nvme/030 | 19 ++++++-----
 tests/nvme/031 | 14 ++++----
 tests/nvme/033 |  9 ++---
 tests/nvme/034 |  9 ++---
 tests/nvme/035 |  9 ++---
 tests/nvme/036 |  9 ++---
 tests/nvme/037 |  8 ++---
 tests/nvme/038 |  6 ++--
 tests/nvme/039 |  4 +--
 tests/nvme/040 | 28 +++++-----------
 tests/nvme/041 | 49 +++++++++------------------
 tests/nvme/042 | 55 ++++++++++--------------------
 tests/nvme/043 | 52 ++++++++++-------------------
 tests/nvme/044 | 71 +++++++++++++++------------------------
 tests/nvme/045 | 62 ++++++++++++----------------------
 tests/nvme/046 |  1 +
 tests/nvme/047 | 30 ++++-------------
 tests/nvme/048 | 42 +++++++----------------
 tests/nvme/049 |  1 +
 tests/nvme/rc  | 90 +++++++++++++++++++++++++++++++++++++++++++++++---
 47 files changed, 398 insertions(+), 765 deletions(-)

-- 
2.41.0


