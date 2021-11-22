Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDBDC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H5tAW5lIiIh46RGIWKJjYLmMHQxZuWlvQont5/GaFTo=; b=YGcRyZ5Wwl5XPlGfrNJZSODmYt
	7Qt2oqg8u+bRI+PdmY5aENpgaaJhvpAbqHtOHvjoU3KHeg3UGhXh01f7zbZ/Xq2Tm7tnjElFAVjWA
	Yu8pqtUBDr8CKbrUg9eG/GiNsl1T7Krs9nX7PjfFMUH80LvOc3BOT4sl8gd6jdAIzZZ6Qkh/5sx+Y
	y3qCF8tS4qyA7WbRmvdnE86gQu1ZykS1twa5sAPJWKat14VzFjG1WtQ4X8RwqKsujdU79teiydhaS
	m1O4sfgIFMzRzdpXPHsdjq8FAIwf+Gf4WPC4AdCdZrs7pPHjEqzrp2tel5m0dlVL4Evc8Ri9DJygK
	uSp7VFUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4Fb-00FCGD-A2; Mon, 22 Nov 2021 08:00:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4Ar-00FAuE-T0
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:39 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 764291FD58;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5tAW5lIiIh46RGIWKJjYLmMHQxZuWlvQont5/GaFTo=;
 b=irIfM35bivLmkhBjyFtBDaC2WLeXD13WEpQFPHJq/ReN3hUFik3l2a5+fQw9eKI/vaaIL1
 upU58sKqQio4GgwVKvi1ryPfxWjxuK20JKKRwPDFln7UybLe+YF7sJdXD1v+bvFdcL1ENN
 7I5rCzM7n3zUaXM18klmS7jmYoop77s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5tAW5lIiIh46RGIWKJjYLmMHQxZuWlvQont5/GaFTo=;
 b=8HUoGdOBjwKlXj2KPVRqSiEAuotwBXzcI87lcsqZ2Me0anMMcPAA5JvJ7bYMxMlU2KvTFh
 OuTgWiRqbYwWtbCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 45063A3B87;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 36EB751917ED; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 blktests 0/9] Testsuite for nvme in-band authentication
Date: Mon, 22 Nov 2021 08:55:15 +0100
Message-Id: <20211122075524.26207-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235538_182913_52CCBA7E 
X-CRM114-Status: GOOD (  12.67  )
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

Changes to v1:
  - Move tests to the 'nvme' directory
  - Check for authentication failure on invalid keys

Hannes Reinecke (9):
  nvme/rc: do not print error message when no nvme device is found
  nvme/rc: clear allowed_hosts subdirectory
  nvme/rc: add functions for in-band authentication
  nvme/039: simple test for nvmeof-tcp connection
  nvme/040: create an authenticated nvmeof-tcp connection
  nvme/041: test different key types
  nvme/042: test hash and dhgroup variations
  nvme/043: test bi-directional authentication
  nvme/044: test re-authentication

 tests/nvme/039     |  56 ++++++++++++++++++++++
 tests/nvme/039.out |   6 +++
 tests/nvme/040     |  64 +++++++++++++++++++++++++
 tests/nvme/040.out |   6 +++
 tests/nvme/041     | 102 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/041.out |  36 ++++++++++++++
 tests/nvme/042     |  88 ++++++++++++++++++++++++++++++++++
 tests/nvme/042.out |  37 +++++++++++++++
 tests/nvme/043     | 104 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/043.out |  14 ++++++
 tests/nvme/044     | 116 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/044.out |  22 +++++++++
 tests/nvme/rc      |  56 ++++++++++++++++++++++
 13 files changed, 707 insertions(+)
 create mode 100644 tests/nvme/039
 create mode 100644 tests/nvme/039.out
 create mode 100644 tests/nvme/040
 create mode 100644 tests/nvme/040.out
 create mode 100644 tests/nvme/041
 create mode 100644 tests/nvme/041.out
 create mode 100644 tests/nvme/042
 create mode 100644 tests/nvme/042.out
 create mode 100644 tests/nvme/043
 create mode 100644 tests/nvme/043.out
 create mode 100644 tests/nvme/044
 create mode 100644 tests/nvme/044.out

-- 
2.26.2


