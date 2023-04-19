Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F4C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YGRx0VhssWGJmCamZm968ZBOnZT7J4WEtWI7lTv5X2o=; b=4fPomgyP+fbhimnn9MndqDfY4D
	9You+46ha3wFz0io/LKFRCG4AnUT/ZwGm6JMG0RJDctQ53oLTWkmG1kr8WqrscJysTxTdEgrhci4I
	RYRVN2OryyFatkcIq6Pqx/Wc91GPW/x5ruc3UB0GEUnuBrhJktaNYMzlRe3yqZsehZHU06qgCWJQ2
	y4S3nnJ9S0sCjO3p67tXGV1I1BhAtJ/Dt5KaqjyRNQrzM0UYt4jvVJou0Vtv5nBnLf4pAm4466Jqf
	d6gpeIrlwnQ6po9YSo+ou/KP3k5CwaAIPrJBsKckmRbiMKJRon+GiT531tUoU/Qb+WS4oGh+1aYJu
	HRecgAFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3cR-004fWH-0Q;
	Wed, 19 Apr 2023 08:56:51 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3cN-004fUg-1c
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 08:56:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15235218E9;
	Wed, 19 Apr 2023 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681894606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YGRx0VhssWGJmCamZm968ZBOnZT7J4WEtWI7lTv5X2o=;
	b=Sd6IwJjckufw078HuJfh4vwPeCiCz8HEBBW2CY4kcso57ZbSSDNDo3AJn5clFge3dFtsnF
	LmWtilBZ/tH3odXDa7eAMliBIIp/0eICiWzSMcJm4IHC0yvPVCFnrES50xLjf6RTKhAj8B
	i0LQ8nDidW9Qfctui/ZS9khLuvA6J0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681894606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YGRx0VhssWGJmCamZm968ZBOnZT7J4WEtWI7lTv5X2o=;
	b=tql449MYMu4a1UAQD1IhwaezuR6G/wP+RyHqPgY6j0dkMDtmDVS26at+vRSowxFBsq91uG
	O5SumSHT+m6U8HCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 058DF1390E;
	Wed, 19 Apr 2023 08:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PHRKAc6sP2RiegAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 08:56:46 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 0/1] nvme testsuite runtime optimization
Date: Wed, 19 Apr 2023 10:56:42 +0200
Message-Id: <20230419085643.25714-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_015647_683590_B74189DF 
X-CRM114-Status: UNSURE (   8.25  )
X-CRM114-Notice: Please train this message.
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

While testing the fc transport I got a bit tired of wait for the I/O jobs to
finish. Thus here some runtime optimization.

With a small/slow VM I got following values:

with 'optimizations'
  loop:
    real    4m43.981s
    user    0m17.754s
    sys     2m6.249s

  rdma:
    real    2m35.160s
    user    0m6.264s
    sys     0m56.230s

  tcp:
    real    2m30.391s
    user    0m5.770s
    sys     0m46.007s

  fc:
    real    2m19.738s
    user    0m6.012s
    sys     0m42.201s

base:
  loop:
    real    7m35.061s
    user    0m23.493s
    sys     2m54.866s

  rdma:
    real    8m29.347s
    user    0m13.078s
    sys     1m53.158s

  tcp:
    real    8m11.357s
    user    0m13.033s
    sys     2m43.156s

  fc:
    real    5m46.615s
    user    0m12.819s
    sys     1m46.338s

Daniel Wagner (1):
  nvme: Limit runtime for verification and limit test image size

 common/xfs     |  3 ++-
 tests/nvme/004 |  2 +-
 tests/nvme/005 |  2 +-
 tests/nvme/006 |  2 +-
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  2 +-
 tests/nvme/009 |  2 +-
 tests/nvme/010 |  5 +++--
 tests/nvme/011 |  5 +++--
 tests/nvme/012 |  4 ++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 | 10 ++++++++--
 tests/nvme/015 | 10 ++++++++--
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  2 +-
 tests/nvme/019 |  2 +-
 tests/nvme/020 |  2 +-
 tests/nvme/021 |  2 +-
 tests/nvme/022 |  2 +-
 tests/nvme/023 |  2 +-
 tests/nvme/024 |  2 +-
 tests/nvme/025 |  2 +-
 tests/nvme/026 |  2 +-
 tests/nvme/027 |  2 +-
 tests/nvme/028 |  2 +-
 tests/nvme/029 |  2 +-
 tests/nvme/031 |  2 +-
 tests/nvme/032 |  4 ++--
 tests/nvme/034 |  3 ++-
 tests/nvme/035 |  4 ++--
 tests/nvme/040 |  4 ++--
 tests/nvme/041 |  2 +-
 tests/nvme/042 |  2 +-
 tests/nvme/043 |  2 +-
 tests/nvme/044 |  2 +-
 tests/nvme/045 |  2 +-
 tests/nvme/047 |  2 +-
 tests/nvme/048 |  2 +-
 38 files changed, 63 insertions(+), 47 deletions(-)

-- 
2.40.0


