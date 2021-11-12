Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:03:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D5C60EE2
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53D5C60EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FJtF8wumRmIzpav9YuoOMXNjxLfr9tCKm9q2Zeqqg8M=; b=LnVY6hl0Oa82aVCgDMeOeGz5Ju
	iYbg75GxccWkOYq282QPkZx/a3tc/TVerXWjQMgY4gKgmBALV+icpd7WphiIzrKrZznh4hn4woptf
	UpgDe2f1I7NuecnidUqwb/arlxBcSw+2h7XmUDMrAubVjD32DR/tIZY33mxGyLJNrweZeCf2fkIJd
	EgnEoL686KjoAurDQTHgNl8l3W/sxavVZ8LOG9a5lmMcCNv4wgKYq+RAVJlCxVLC/PYtM/XxKcMLI
	yswAWASYcMOdSdIDUt7G3Qo409AqoIMRsan0+XHzyN63IFXmkyMIiD8UQk6eSLLJsfULQ0pGtYLVs
	uLVKtfNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlY57-00Ay0r-5K; Fri, 12 Nov 2021 15:03:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlXns-00AsN2-Gh
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 14:45:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9B9451FD65;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636728318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FJtF8wumRmIzpav9YuoOMXNjxLfr9tCKm9q2Zeqqg8M=;
 b=oLiXveAofw07yVRQ3wyPgBmLaLEidZZo0ubFKrs4W1U82AUat7A/h3swegFeWi8r04ND9i
 qhpPE4+Fbli281rhpN48fV+2ubE1moss1QV4bYy01JxyoVe2fjQWvt7XTPPwHrFjY0iv3k
 S3jPDnro42LMJOLTuiG7CA6vL5lMkrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636728318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FJtF8wumRmIzpav9YuoOMXNjxLfr9tCKm9q2Zeqqg8M=;
 b=bBTy4uVfIyWuuTGgWAeSD/UU38bY6VC51oNUmvHS7acseQx+gpSDuTDpmddpi5RoMff63P
 Fdm5BPkxwr+75BDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 58913A3B8C;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 4BA5C519127F; Fri, 12 Nov 2021 15:45:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH blktests 0/6] Testsuite for nvme in-band authentication
Date: Fri, 12 Nov 2021 15:45:04 +0100
Message-Id: <20211112144510.98523-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_064520_879029_4DA3A8FD 
X-CRM114-Status: GOOD (  11.02  )
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

some people (Hi Sagi!) have complained that nvme in-band authentication
provide far too many configuration options to test it with some easy
commands. So here's a test suite for testing (most of) the various
configuration options and features.

As usual, comments and reviews are welcome.

Hannes Reinecke (6):
  nvmeof-tcp/001: simple test for nvmeof-tcp connection
  nvmeof-tcp/002: create an authenticated nvmeof-tcp connection
  nvmeof-tcp/003: test different key types
  nvmeof-tcp/004: test hash and dhgroup variations
  nvmeof-tcp/005: test bi-directional authentication
  nvmeof-tcp/006: test re-authentication

 tests/nvmeof-tcp/001     |  55 +++++++
 tests/nvmeof-tcp/001.out |   6 +
 tests/nvmeof-tcp/002     |  62 +++++++
 tests/nvmeof-tcp/002.out |   6 +
 tests/nvmeof-tcp/003     | 100 +++++++++++
 tests/nvmeof-tcp/003.out |  36 ++++
 tests/nvmeof-tcp/004     |  86 ++++++++++
 tests/nvmeof-tcp/004.out |  37 +++++
 tests/nvmeof-tcp/005     |  74 +++++++++
 tests/nvmeof-tcp/005.out |   6 +
 tests/nvmeof-tcp/006     | 113 +++++++++++++
 tests/nvmeof-tcp/006.out |  23 +++
 tests/nvmeof-tcp/rc      | 347 +++++++++++++++++++++++++++++++++++++++
 13 files changed, 951 insertions(+)
 create mode 100644 tests/nvmeof-tcp/001
 create mode 100644 tests/nvmeof-tcp/001.out
 create mode 100644 tests/nvmeof-tcp/002
 create mode 100644 tests/nvmeof-tcp/002.out
 create mode 100644 tests/nvmeof-tcp/003
 create mode 100644 tests/nvmeof-tcp/003.out
 create mode 100644 tests/nvmeof-tcp/004
 create mode 100644 tests/nvmeof-tcp/004.out
 create mode 100644 tests/nvmeof-tcp/005
 create mode 100644 tests/nvmeof-tcp/005.out
 create mode 100644 tests/nvmeof-tcp/006
 create mode 100644 tests/nvmeof-tcp/006.out
 create mode 100644 tests/nvmeof-tcp/rc

-- 
2.26.2


