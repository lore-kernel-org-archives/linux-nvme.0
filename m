Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E67C43334
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jul 2022 01:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dJmLFq0emmjxsfsOyOhSe3jEldblv8z8mkscqEbCkkE=; b=dPYiO8JHhKGGH7NuTkslyaQu78
	cpazGv86QfXpCrt0+UVXDqjOTCtKwF9TM4nutHHBgY+90i5wy94QfTOnmEwXYYIgSXfeA8AHMDFQH
	JHHRxQQ+KimmCdF7nGX9IObBXZ7Kt9mpIdxxP6zmc9NOmux61x95QhzVI4rHaLfTQgHjWQnDz5aTB
	eaI7XdHhaq6nxIb2D6+dDuZ6/kZ6ud/aliGRUSH7a/QwGaopmOCB9p9efHto8petTTVMMtknffguE
	RuQKbN5uf78eUEKZbObSQ0c4Gkr8bGqJYqlJxP1BzQNkmWgo4h+lYqHFKknU9xxk+alrvwk5oLkk8
	W94+G2gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCWdy-00BgMz-1F; Sat, 16 Jul 2022 01:30:54 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCWdu-00BgLC-Nm
	for linux-nvme@lists.infradead.org; Sat, 16 Jul 2022 01:30:52 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3F82F5C00F8;
	Fri, 15 Jul 2022 21:30:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 15 Jul 2022 21:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jbernard.io; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1657935041; x=1658021441; bh=dJmLFq0emmjxsfsOyOhSe3jEl
	dblv8z8mkscqEbCkkE=; b=o5naZ/9NYf/vs+/nYoPR+XBPBBlOVN1vpz7Hj/WFn
	8+K6oplQvTP4ADVfgmSENi1ysfcFAebQE5/oisbb25JOMKf2QixdrAl4pC7sIZwz
	UWcobLU9Tn6i52tRQHpEE9n2fLoeiqTm80oW7UuNWckWWGQu8zS4ZAZx3kE0vMFh
	fku7iiQ8g2oj6+Xs6dTXOWvJ1wKNLowRYOeLxns2Kah3wkCilHFfIHNTDkTsG6kR
	YXi3BlEArHY6/N88Pmaxsz8HDn2dVZ23Ub3mPbVyGeb//V9DXUqQlDPkifm4cFKW
	D85iAnmWyRaxud31YVq3sv6mNUZSGa4Q/D6dCme+i6DFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1657935041; x=1658021441; bh=dJmLFq0emmjxsfsOyOhSe3jEldblv8z8mks
	cqEbCkkE=; b=SJzWOc76MXUZnhi3VRG0Om/AGVLs6w7NXdv4Rz6dQ16/usGePNM
	BYruxfQQ01OOH9F+UT09r5IDbMx1J3gHvsboBKoa2PrHgBmRbevFH7zvIuZ5C6DG
	lIaMQkg12cbR7TijneuhMgTn3JX4S8zw6fRdCU6CSBxSJhUbgMJ1hn6Oa81tUM3H
	HL5dlO+w7ZUN/5wszs6GYV5Xc1D7lJFSpaE/3pBZx4FTDGeYBxFiePRl3RCqulCy
	176/k7INE/TcWo7ruzid+umUcLi1MxhFtPVlt7lOzI6ygahE5BS1mr0qW7dmF8TG
	ofk6Z5OoswMdZ1EIbdZbLc37DipMZ+3htxw==
X-ME-Sender: <xms:wBTSYg-R7xVQ0tyDh65dMkDzH9svJ_j6X3TzsH_5eWLGY-mIExAFTg>
    <xme:wBTSYotZHpfJMNc6XdU0aT693EiRrPLIjALZBVNZTaY0K0TwaeLQy23skjnlfD9cQ
    ao7bgRBXEVFqol3>
X-ME-Received: <xmr:wBTSYmBa46n__jgiK5G30mIiBU6MrEDptP8m8-WYFwuDNSuhdVzCj7kxaKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekvddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflohhnuceuvghrnhgrrhguuceojhgsvghrnhgrrhgusehjsggv
    rhhnrghrugdrihhoqeenucggtffrrghtthgvrhhnpeetlefhleelleffleekgefftdduhe
    efveeiffdugfetfeeuffelveeuteffleevffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehjsggvrhhnrghrugesjhgsvghrnhgrrhgurdhioh
X-ME-Proxy: <xmx:wBTSYgcnY27rxbFdd8BtdWOsGQ8GlAIgRX-D9neS1FBH5Dm-fSjQ4Q>
    <xmx:wBTSYlOs_13GoIeIFvqimzvy40765bcfOmKttXw1Kz2slS0cip7CeA>
    <xmx:wBTSYqmNGRIGoK93EOuuMqA1tMuhCjqK9U-BgcCAQTRxH6jg0Thjng>
    <xmx:wRTSYnVjnfOaQmYjSpsPM1G8IEOTvDkmSkl75OdF6pezwZyx98krsg>
Feedback-ID: ib85842f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 21:30:40 -0400 (EDT)
From: Jon Bernard <jbernard@jbernard.io>
To: linux-nvme@lists.infradead.org
Cc: Jon Bernard <jbernard@jbernard.io>
Subject: [PATCH] Add configshell-fb to install requirements
Date: Fri, 15 Jul 2022 21:30:31 -0400
Message-Id: <20220716013031.64959-1-jbernard@jbernard.io>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_183051_243945_60CE06F0 
X-CRM114-Status: UNSURE (   9.32  )
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

The 'install_requires' keyword is used to specify what is minimally
needed to run correctly.  This patch adds configshell-fb as a
requirement so that nvmetcli runs correctly without additional
dependency installation.  This will not effect distribution packages,
only users that install using pip.

Also remove a reference to the 'pyparsing' package in README as it's no
longer in use.

Signed-off-by: Jon Bernard <jbernard@jbernard.io>
---
 README   | 3 ---
 setup.py | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 6ebe666..ae95fcf 100644
--- a/README
+++ b/README
@@ -17,9 +17,6 @@ Common Package Dependencies and Problems
 Both python2 and python3 are supported via use of the 'python-six'
 package.
 
-nvmetcli uses the 'pyparsing' package -- running nvmetcli without this
-package may produce hard-to-decipher errors.
-
 Usage
 -----
 Look at Documentation/nvmetcli.txt for details.
diff --git a/setup.py b/setup.py
index 1956d95..71c7cd2 100755
--- a/setup.py
+++ b/setup.py
@@ -27,5 +27,6 @@ setup(
     maintainer_email = 'hch@lst.de',
     test_suite='nose2.collector.collector',
     packages = ['nvmet'],
-    scripts=['nvmetcli']
+    scripts=['nvmetcli'],
+    install_requires=["configshell-fb"]
     )
-- 
2.37.1


