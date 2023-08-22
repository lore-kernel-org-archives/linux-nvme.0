Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE6FEE4993
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Aug 2023 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c0QBHDdpxUVvzXDXhQjofZECGQHaEuLHUH/mzET1lU8=; b=huZC2mNeOmvLEnr5oa7jA9afN3
	J+fFoOA0tz1TaeYNclbcfd9nWh/tkONWJDHaQUuZX9tvFWLtphLUACb533DHoifgEt3++hdWluigo
	HbkuS+G+vPa+WzjYp/8XvAKbNW8UeBymIeNG3qRfFA/VL9j3pBEClCENRl4XVAWe+xcpaXj+5U2r+
	y9oH5oZr9Z5oWLPtTsIxZp1BRLr2DWYh9wY+LUzxvCTy9yfcxk9D8ytBcMg4WjLL+qB/P5pRQCsBa
	4nxi/qeyUWoKVSo8zYFFZdm81c9qhzEHlkvyxchOSMKPikNhrz6Vvul5FaNe8hlZCR8k8RYrR+F2v
	GiCaVzOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYMtr-00FT3m-1M;
	Tue, 22 Aug 2023 08:38:07 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYMto-00FT2b-0g
	for linux-nvme@lists.infradead.org;
	Tue, 22 Aug 2023 08:38:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6989D228D1;
	Tue, 22 Aug 2023 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692693480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c0QBHDdpxUVvzXDXhQjofZECGQHaEuLHUH/mzET1lU8=;
	b=WKDtQ0i5LGH7K4mitqBjyrV5oy7w1fkDCl0ngxo43/CcglKCHd1Sm3geH44JzAadf9Ym0N
	zMoG5IiN+KrY5gf3FZsh4zYavcbgdBBNn7Bi4PAw+mCrCoUeY7GlMDb6B2gY7p5vRFywqT
	nmlVvBt03uvFUZFh4s68cvwJ2IxHE7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692693480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c0QBHDdpxUVvzXDXhQjofZECGQHaEuLHUH/mzET1lU8=;
	b=mVh5ks7F1jYAi9+gi17sDQwqfqfytXBJPBtkK6cEMs/YhVBXLav1uJNfSef1ngraTlglGF
	YiF7Y8XzNmRnEsAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56BDB132B9;
	Tue, 22 Aug 2023 08:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RZDJFOhz5GQZcAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 22 Aug 2023 08:38:00 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 0/3] Introduce nvmet target setup/cleanup helpers
Date: Tue, 22 Aug 2023 10:38:09 +0200
Message-ID: <20230822083812.24612-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230822_013804_395213_1622FEEF 
X-CRM114-Status: GOOD (  13.41  )
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

Addressed Sagi's feedback and dropped the explicit --blkdev=device argument from
the _nvmet_target_setup calls, as it is the default.



original cover letter:

Introduce helpers to setup nvmet targets. This is spin off from the refactoring
patches and the allowed_host patches [1].

Sagi suggested to record all resources allocated by nvmet_target_setup and then
later clean them up in nvmet_target_cleanup. I opted to figure out in
nvmet_target_cleanup what was allocated via the newly introdcuded _get_nvmet_ports
helper. The reason being, Hannes told me offline that he would like to add ANA
tests which will add some more ports to the subsystem. I hope with this
the code is more future proof.

BTW, while looking at this I saw that the passthru code is using the awkward
return value port when calling nvmet_passthru_target_setup. It seems some
more refactoring is in order...

[1] https://lore.kernel.org/linux-nvme/5h333eqhtw252sjw6axjewlb5bbb5ze7awekczxe3kie2lnhw6@manyer42khct/


changes

v3:
 - rebased/retested
 - use the default with _nvmet_target_setup 

v2:
 - drop local subsys variable in passthru tests
 - do not use port as handle in passthru tests
 - free port after unregistering from subsys
 - https://lore.kernel.org/linux-nvme/20230818141537.22332-1-dwagner@suse.de/

v1:
 - https://lore.kernel.org/linux-nvme/20230818095744.24619-1-dwagner@suse.de/

Daniel Wagner (3):
  nvme/{033,034,035,036}: use default subsysnqn variable directly
  nvme/{033,034,035,036,37}: drop port handle between passthru target
    setup and cleanup
  nvme: introduce nvmet_target_{setup/cleanup} common code

 tests/nvme/003 | 14 ++-----
 tests/nvme/004 | 21 ++---------
 tests/nvme/005 | 20 +---------
 tests/nvme/006 | 19 +---------
 tests/nvme/007 | 14 +------
 tests/nvme/008 | 21 +----------
 tests/nvme/009 | 16 +-------
 tests/nvme/010 | 21 +----------
 tests/nvme/011 | 16 +-------
 tests/nvme/012 | 21 +----------
 tests/nvme/013 | 16 +-------
 tests/nvme/014 | 21 +----------
 tests/nvme/015 | 16 +-------
 tests/nvme/018 | 16 +-------
 tests/nvme/019 | 21 +----------
 tests/nvme/020 | 16 +-------
 tests/nvme/021 | 16 +-------
 tests/nvme/022 | 16 +-------
 tests/nvme/023 | 21 +----------
 tests/nvme/024 | 16 +-------
 tests/nvme/025 | 16 +-------
 tests/nvme/026 | 16 +-------
 tests/nvme/027 | 17 ++-------
 tests/nvme/028 | 17 ++-------
 tests/nvme/029 | 21 +----------
 tests/nvme/033 | 10 ++---
 tests/nvme/034 | 10 ++---
 tests/nvme/035 | 10 ++---
 tests/nvme/036 | 12 +++---
 tests/nvme/037 |  5 +--
 tests/nvme/040 | 19 +---------
 tests/nvme/041 | 18 +--------
 tests/nvme/042 | 17 +--------
 tests/nvme/043 | 17 +--------
 tests/nvme/044 | 19 ++--------
 tests/nvme/045 | 18 ++-------
 tests/nvme/047 | 21 +----------
 tests/nvme/048 | 17 +--------
 tests/nvme/rc  | 99 +++++++++++++++++++++++++++++++++++++++++++++++---
 39 files changed, 184 insertions(+), 553 deletions(-)

-- 
2.41.0


