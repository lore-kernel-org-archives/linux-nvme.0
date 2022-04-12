Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED3DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 08:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o35o3apsd+bZAv9KqikJNi/MkQT3bP2c5W9tCgWGNPs=; b=niVl93SFI1bJ3BmHEn7U67cweq
	14tJbG3qOQfJNvg4OHQHg0uYtcHMknAaHPSsFqK4kpGfP5X+n4GB+aWSi68GBfnCrj5wuQ06UCev5
	WSxhX3nCF4rPoh8W9h9GPH42uiZ9LvIoXLTw9fhvB6g+41ITQv1Qk0ZVSr4wajpRvO5XwaDGBa6IW
	wgtWXR6Bxr5G1AfcXr74O0B9aKagrVsRjiN3F00mCRyaQff0mqm1C5DgbdcxspAnytj6/FVnanmBp
	/z2EaJ/pgUsmU9QyvNvZIOAOb87K34f2mAIR3zD3QJ2lflZDJvLOj4BlzUenZakdPBTfdN4cPR5dR
	AzvOxgXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neBVd-00CRWr-1q; Tue, 12 Apr 2022 08:04:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neBVY-00CRUI-Ck
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 08:04:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E0B2121605
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649750653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=o35o3apsd+bZAv9KqikJNi/MkQT3bP2c5W9tCgWGNPs=;
 b=fOS9xvHpB+J2vVY+U/B2zQ4BpYF2XysYDH1+hDCfTbkAsejda+Xv/hlYnwQGTHxdlx+erJ
 Pyp4m1S8cGQ0MZpYV3gjye5RbXAEW/JFZje3J+fI0BhqGkUw7hD56B98rCRGxLtXhQ+LGI
 e1Ui3xW2FbbDO5NYvteL+G7ZKBks8K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649750653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=o35o3apsd+bZAv9KqikJNi/MkQT3bP2c5W9tCgWGNPs=;
 b=azE6J4esjcLGMcgRh+ntkSYS9y91BAAHhcMgs6VDsq8yGc9UkgTcT2x9D0qnUryhoQpXDD
 HxzygWOkme7SjBDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4B8A13780
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 08:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x2ziM30yVWJuCgAAMHmgww
 (envelope-from <dwagner@suse.de>)
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 08:04:13 +0000
Date: Tue, 12 Apr 2022 10:04:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Subject: [ANNOUNCE] libnvme v1.0 and nvme-cli v2.0
Message-ID: <20220412080413.ey5ct76rnquxrz6j@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_010416_611941_B9F74DC4 
X-CRM114-Status: UNSURE (   9.90  )
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

A bit late but still: I'm pleased to announce the libnvme 1.0 and
nvme-cli 2.0 release.

nvme-cli 2 is using the newly introduced libnvme library which was
splited off from nvme-cli 1.x two years ago. There was a lot of
refactoring and rewriting to make the API between nvme-cli and libnvme a
bit more generic and also useful for other projects to consume libnvme
(e.g. nvme-stas).

nvme-cli 2 is supposed to have all the features nvme-cli 1 has but due
to branch being created two years ago we might miss a patch or two from
nvme-cli 2.

We added a few features to the libnvme/nvme-cli such as in-band
authentication support or TP8013/TP8014 support. But since we didn't
have a release on these two branches for ages, I lost a bit the overview
what is in. Hence, I am leaving out the detailed list of changes, as it
a big long and not that interesting.

A big thanks for everyone who was involved to get this release done!

Daniel

ps: as usual as soon the release is out bug reports are in...

