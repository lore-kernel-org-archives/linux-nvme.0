Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ijzirGkRTL+7UKet2zRis8iD7wx/rH+Sxw4eYrFcGk=; b=wJZJPbkK7Pm/wgMH2ZgqIWh05t
	Yo4dZuWFUCT7rrUpu/KPDGpcl5eMKszc5K+8fH6F7LoG2r/Qh2YKAV/iojiCAyYd3L+aCsUS6vrR4
	dKA9jdxyBGl6wR8v9YTYOJh1mD7gZFb6JP4Zcr9pHLbR3ZjJNEkjK8l67aMJ9XCnwPquegV8+UYkQ
	Ct6p5ik74BnbOm9PRP8yXPOmgzz3YIvRTT+VnY/5CIT4UmTyc9XwsVhWlv1jXa5bh069a5HqFO5H+
	YcsJeIBFvu8DYPPrIlwn3HBnK8U4uaKGsW9rXGKVwZzepDqQWWJlXWYKVsMi1knTwI0fzYQQ4yg85
	LOLqHF/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntEsQ-005pHy-TI; Mon, 23 May 2022 20:42:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntEsO-005pHC-1f
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 20:42:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EAA94614DA;
 Mon, 23 May 2022 20:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BB71C36AE7;
 Mon, 23 May 2022 20:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653338522;
 bh=JYoATB/ve1NQy/envTJY1JYre41R+XhDAt9dolOQe9Y=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=mlJfkzwPxEbA9xE1flTWye5oKxYeaGnv0P0uJ0iNf20DjY6m5kssg48+uY9N92yG9
 b8VaZYRJYNs6tORZhcHzF66WM4kgWELB7j5JMiPygtRy3A5DitmgBxg8/cQY/PRAhO
 zrmnpTUR8g63FQly5QeC2U1Sov29ygUOGHi8M2+IAsNzjhCuFsda+oPeG0CsNs7lRV
 2PMZo8v53jUg1hLZepEpmt2wujpx3Sf+VjIveLUSkuqBg2zjO+I3usm1dsF9UNy3fM
 HQPdF+aZGIGK3sKhO84WsqSVDfGSd/ZY+0IYCTATo+DvmKEVYM+rYznBPoUXzrOg45
 pMZq73AdcDB2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 489FCF03935; Mon, 23 May 2022 20:42:02 +0000 (UTC)
Subject: Re: [GIT PULL] io_uring passthrough support
From: pr-tracker-bot@kernel.org
In-Reply-To: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
References: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.19/io_uring-passthrough-2022-05-22
X-PR-Tracked-Commit-Id: 3fe07bcd800d6e5e4e4263ca2564d69095c157bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9836e93c0a7e031ac6a71c56171c229de1eea7cf
Message-Id: <165333852229.17690.10519267879279637393.pr-tracker-bot@kernel.org>
Date: Mon, 23 May 2022 20:42:02 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_134204_163024_44A5B04D 
X-CRM114-Status: UNSURE (   5.53  )
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

The pull request you sent on Sun, 22 May 2022 15:26:23 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.19/io_uring-passthrough-2022-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9836e93c0a7e031ac6a71c56171c229de1eea7cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

