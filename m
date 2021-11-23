Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B78AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TskxV+gfX1I0KDohvL0GoM7sjT8I9jis0izOHoBgxFE=; b=mMlKjFFU6KSf1+O4A5Sgs2xjSA
	fdfQXolvAGqIkJjgJeNIvp4mP+j7SQHsEulxe73FIdEfUI/oCvZoWkAhn4qDupGd+l8cBCiEMmZAP
	P+85o2K2l0C73EgWqg8df+XUHN4B0ZU60xD46rDzGq2suHXUaPXqpiz2Eq6lmpAsMxdY9Ur9MVjHl
	muJy1EtBQ1COBoIPwdhWjETm2cTBgpaJgRtT+P8aR/k9cQiAfHm9C2JgR5I443q31Uw4F8CF6cGDv
	KaBeLqSaVqAf0X5sy8n+8x5bBGiMFrqh+m75Hoo/7G0Z93LjleVgQWzq9LxaGANO3+HCN6S6BW6EO
	sM3zLObQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQbP-0017U7-Sl; Tue, 23 Nov 2021 07:52:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYq-0016hE-5x
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:57 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1FC731FD5D;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TskxV+gfX1I0KDohvL0GoM7sjT8I9jis0izOHoBgxFE=;
 b=l3J1gs3pIusb5e9OrazqN+bd6XbOGpOirSU6BD91NSBlAaDx8nPDhFiDv4P36u1IlPacF2
 L//6GQI+o2PYhaeQ0J+CZAQ2gy+p2kEC6BBzTveBJ+IFzfC/cWnolIRoz/03aTpZT8ITiE
 dbRkbnwljOA0Uiq9OfjNdOlk2GTESDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TskxV+gfX1I0KDohvL0GoM7sjT8I9jis0izOHoBgxFE=;
 b=6TRLeyW1xRYkO25S/Wyxvlk/hz49lR+83JJfo0e5rJQt15voZFQeO0aP6IG1PvEOB4JphB
 oHCCKBcLdkT9NwAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1FA2DA3B85;
 Tue, 23 Nov 2021 07:49:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 0F94B5191881; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 blktests 00/10] Testsuite for nvme in-band authentication
Date: Tue, 23 Nov 2021 08:49:30 +0100
Message-Id: <20211123074940.113390-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234952_503253_5A659E25 
X-CRM114-Status: GOOD (  13.67  )
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

Changes to v2:
   - Merge first two tests
   - Add optional arguments to _nvme_connect_subsys()
   - Convert to use _nvme_connect_subsys()

Changes to v1:
  - Move tests to the 'nvme' directory
  - Check for authentication failure on invalid keys

Hannes Reinecke (10):
  nvme/rc: do not print error message when no nvme device is found
  nvme/rc: clear allowed_hosts subdirectory
  nvme/rc: clear hosts directory in _cleanup_nvmet()
  nvme/rc: add functions for in-band authentication
  nvme/rc: add more arguments to _nvme_connect_subsys()
  nvme/039: create authenticated connections
  nvme/040: test dhchap key types for authenticated connections
  nvme/041: test hash and dh group variations for authenticated
    connections
  nvme/042: test bi-directional authentication
  nvme/043: test re-authentication

 tests/nvme/039     |  83 +++++++++++++++++++++++++++
 tests/nvme/039.out |   7 +++
 tests/nvme/040     |  95 +++++++++++++++++++++++++++++++
 tests/nvme/040.out |  16 ++++++
 tests/nvme/041     |  89 +++++++++++++++++++++++++++++
 tests/nvme/041.out |  18 ++++++
 tests/nvme/042     | 107 +++++++++++++++++++++++++++++++++++
 tests/nvme/042.out |   8 +++
 tests/nvme/043     | 136 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/043.out |  12 ++++
 tests/nvme/rc      |  97 ++++++++++++++++++++++++++++++++
 11 files changed, 668 insertions(+)
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

-- 
2.29.2


