Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD4C76188
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=icT/mqr4pMZQJFZc1I7CnseD2mZL4uOS9LIN9x1wVVg=; b=z82wCrNxcHK+/IlvwUuPYICjKC
	iwtmCN8CGubW3Po+IXKKBOptRzTRqKWJ8dyKwO1ef+0PPtP9qzO24weftAfIKkNhWD004WP/mkVRT
	lDJrOztrA6GKiPycUdxsg+tWls0sZy0fvXpH7hFdSFKEHqKeRH3o8WUcHxreCBGWj+WJY3+5somHL
	r069EoYn9BR9fKgsQ8TVpu/yCwn/8lWOJwmGVwtQtQjnp5BkfvrEaWqpf7jNobGm+LnxfAJ1DtlAD
	w4WzHBN6kjK+73tptw73P1PM8mJI/Uso1GGBYEDcP335JVHzcyjyONbo1YDn5nwqhpDrl5jqpdkSA
	l37UaOmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk6HE-0059dO-0K;
	Wed, 05 Apr 2023 16:46:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pk6HC-0059cy-2Q
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Apr 2023 16:46:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=icT/mqr4pMZQJFZc1I7CnseD2mZL4uOS9LIN9x1wVVg=; b=KhTd4CoeaoVkpDJMMTL75J0G6S
	efVcIa+HBLRG4l8/5M7sF2IbGy941gzjomi6WKfwr7pTAHgb78QZW8dOGTKuvZJ9ZL5Pc0ui/+2VP
	4qYnYq9YeoTomy0XVplwbWhxuzr3FvAOV8BnGZ58kRNAmr6ieu9j48/W4z2hSaArM9V31gmovOwMU
	f4HL/LOPrbLhLQ7/rFpNRf/jok327D8uMR6nmWvAtbqfq1+bc6bI8HNJtEDMmm9d+UbzAuqB0oqKz
	RcyoaGj3tRm/NaL5PzplhDTBsdUctG3ktQUxjHRYEADQ9b+BALCcHq6FlLkaPUVTJxRJgPb6eBWxK
	66sLrKOg==;
Received: from smtp-out1.suse.de ([195.135.220.28])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pk5LK-009zh6-1v
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 15:46:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E89A22314;
	Wed,  5 Apr 2023 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680709595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=icT/mqr4pMZQJFZc1I7CnseD2mZL4uOS9LIN9x1wVVg=;
	b=WYiSiLOelii2EKxYp+E8jBPI6OOFrs8/pWG0zAHMpo+mD4K1mCOhYaG4x5EybJ556xz5cL
	M6NEpY3IrWtdS7re65XCu6gAVDzOLh9Co3K+rgsoaMt7vZd1JanjTZrgHcKc1ifOMJMrb6
	TER+3p/h8J5QUIHFa6RR4Ko1BDnooQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680709595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=icT/mqr4pMZQJFZc1I7CnseD2mZL4uOS9LIN9x1wVVg=;
	b=ZUaaFqCYUULstj9anNQ9j7381Jqao9SCxDRznlYfKCjJHoyTauCr5BfyPw5vEI9lDA4KJ5
	Mecgv6rwQ2QtEKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3CBC13A10;
	Wed,  5 Apr 2023 15:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id O7aAO9qXLWTTNgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 05 Apr 2023 15:46:34 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v5 0/4] test queue count changes on reconnect
Date: Wed,  5 Apr 2023 17:46:26 +0200
Message-Id: <20230405154630.16298-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_164638_828259_27D6AEF5 
X-CRM114-Status: GOOD (  12.02  )
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

The target is allowed to change the number of i/o queues. test if the
host is able to reconnect in this scenario.

I was able to test this successfully with tcp and rdma. fc still fails due to
the race condition in the target code.

Next attempt to get this series upstream :)

This version is based on my previous posted nvme/047 patches [1]

[1] https://lore.kernel.org/linux-nvme/20230329090202.8351-1-dwagner@suse.de/

v5:
 - moved generic parts to nvme/rc
 - renamed test to 048
 - rebased ontop of nvme/047
v4:
 - do not remove ports instead depend on host removing
   controllers, see
   https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/
 - https://lore.kernel.org/linux-nvme/20220927143719.4214-1-dwagner@suse.de/
v3:
 - Added comment why at least 2 CPUs are needed for the test
 - Fixed shell quoting in _set_nvmet_attr_qid_max
 - https://lore.kernel.org/linux-nvme/20220913065758.134668-1-dwagner@suse.de/
v2:
 - detect if attr_qid_max is available
 - https://lore.kernel.org/linux-block/20220831153506.28234-1-dwagner@suse.de/
v1:
 - https://lore.kernel.org/linux-block/20220831120900.13129-1-dwagner@suse.de/


Daniel Wagner (4):
  nvme/rc: Add setter for attr_qid_max
  nvme/rc: Add nvmet attribute feature detection function
  nvme/rc: Add helper to wait for nvme ctrl state
  nvme/048: test queue count changes on reconnect

 tests/nvme/048     | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/048.out |  3 ++
 tests/nvme/rc      | 58 +++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100755 tests/nvme/048
 create mode 100644 tests/nvme/048.out

-- 
2.40.0


