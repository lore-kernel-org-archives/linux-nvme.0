Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73E9C04FDF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UDONgfwgA/FMspNb/GOALY2RYg7JltRc6Ev7K/UxWaw=; b=ja0I11Hpe3XXjFo/LJByyoy9F9
	N/selsoZ+Rd3/3sn07QLQW19UwoB/oRgNfmrFnf317OMgrL/9VjbfMU9lK4Aap8I+dsd5g75t8H6E
	HtLgCCSek0xp1m9w7cz7pgx1sPSG9xpDoAMYqmcPn4c7SkuTyT5beCs//3sLz3KaEXjCUUmsxLGhQ
	lu5nkVZtstG2uYTPC6QzOumxMKAyJoItxlkSxFOXk4h46iowkuqArQeACjQaCxUl6MnbFyHA46rQf
	RbaZUn0eMxAZe77m4HoxVtVo8sP113Pi3Y+AGkSCeK2SU6KfZaMfaFe1gTDd4XGX+Az9K+g6M4HZf
	w2nNW2TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUOZJ-00A06P-1Y;
	Fri, 11 Aug 2023 09:36:29 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUOZD-00A02v-0G
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 09:36:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDF0D1F74A;
	Fri, 11 Aug 2023 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691746578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UDONgfwgA/FMspNb/GOALY2RYg7JltRc6Ev7K/UxWaw=;
	b=x1MHdMx26Ax67mKKIsE3NEmwz4NRYvnm77MrBSgt6WC3voD8gdp6D7HD8qsaPePhmHH7Gi
	gHgDZPdWY1u8PBhNH10ACf4SihXbHGZOagyVhXiusPkzV89qTvotwa4SputhfuoutpWPn/
	5e5AgJyy3Da4ZkZ6SWDeblTkT18O0TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691746578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UDONgfwgA/FMspNb/GOALY2RYg7JltRc6Ev7K/UxWaw=;
	b=t8XJzg82wvsTCVOiJ9d4IqoZeOqHmLbYKaitH9wZDy6xbUl+3/egEKa9+o062aclW8kWym
	SHlN7BvnCQ+RGjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC013138E2;
	Fri, 11 Aug 2023 09:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YOsiFxEB1mSSHwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:17 +0000
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
Subject: [PATCH blktests v3 00/13] Switch to allowed_host 
Date: Fri, 11 Aug 2023 11:36:01 +0200
Message-ID: <20230811093614.28005-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_023623_258789_71BDD3EF 
X-CRM114-Status: GOOD (  13.11  )
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

Addressed the comments from v2. I also added cleanup code to _nvmet_cleanup() to
make sure we do not leak resources when something goes wrong. I run into this
while testing and all tests after the first failure failed then.

changes:
v3:
 - added new patch: "nvme/043: Use hostnqn to generate DHCAP key"
 - removed unused variable in "nvme/rc: Add helper for adding/removing to allow list"
 - added cleanup code to _nvmet_cleanup().

v2:
 - updated commit messages
 - moved the removal of subsys_name to the right patch
 - added _nvmet_target_{setup|cleanup} helpers
   this addresses also the 'appears unused' warning by ShellCheck
 - https://lore.kernel.org/linux-nvme/20230810111317.25273-1-dwagner@suse.de/

v1:
 - initial version
   https://lore.kernel.org/linux-nvme/20230726124644.12619-1-dwagner@suse.de/


*** BLURB HERE ***

Daniel Wagner (13):
  nvme/{003,004,005,013,046,049}: Group all variables declarations
  nvme: Reorganize test preamble code section
  nvme/043: Use hostnqn to generate DHCAP key
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
 tests/nvme/004 | 23 ++++--------
 tests/nvme/005 | 22 +++---------
 tests/nvme/006 | 21 ++---------
 tests/nvme/007 | 19 ++--------
 tests/nvme/008 | 26 +++-----------
 tests/nvme/009 | 21 +++--------
 tests/nvme/010 | 26 +++-----------
 tests/nvme/011 | 22 +++---------
 tests/nvme/012 | 26 +++-----------
 tests/nvme/013 | 22 +++---------
 tests/nvme/014 | 26 +++-----------
 tests/nvme/015 | 21 +++--------
 tests/nvme/016 | 17 +++++----
 tests/nvme/017 | 26 ++++++--------
 tests/nvme/018 | 21 +++--------
 tests/nvme/019 | 26 +++-----------
 tests/nvme/020 | 21 +++--------
 tests/nvme/021 | 21 +++--------
 tests/nvme/022 | 21 +++--------
 tests/nvme/023 | 26 +++-----------
 tests/nvme/024 | 21 +++--------
 tests/nvme/025 | 21 +++--------
 tests/nvme/026 | 21 +++--------
 tests/nvme/027 | 20 +++--------
 tests/nvme/028 | 20 +++--------
 tests/nvme/029 | 26 +++-----------
 tests/nvme/030 | 19 +++++-----
 tests/nvme/031 | 14 ++++----
 tests/nvme/033 |  9 ++---
 tests/nvme/034 |  9 ++---
 tests/nvme/035 |  9 ++---
 tests/nvme/036 |  9 ++---
 tests/nvme/037 |  8 ++---
 tests/nvme/038 |  6 ++--
 tests/nvme/039 |  4 +--
 tests/nvme/040 | 28 +++++----------
 tests/nvme/041 | 49 ++++++++-----------------
 tests/nvme/042 | 55 ++++++++++------------------
 tests/nvme/043 | 52 +++++++++------------------
 tests/nvme/044 | 71 ++++++++++++++----------------------
 tests/nvme/045 | 62 ++++++++++++--------------------
 tests/nvme/046 |  1 +
 tests/nvme/047 | 30 ++++------------
 tests/nvme/048 | 42 +++++++---------------
 tests/nvme/049 |  1 +
 tests/nvme/rc  | 97 +++++++++++++++++++++++++++++++++++++++++++++++---
 47 files changed, 404 insertions(+), 766 deletions(-)

-- 
2.41.0


