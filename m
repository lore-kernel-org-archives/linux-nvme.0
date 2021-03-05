Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F7BC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 16:12:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24AD65016
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24AD65016
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vWVDRKM4LSsdsaKpJGLh9OTIG2nYvwUq5SFm2F8EEWU=; b=I6mBJqci/rPp4OnCvNqD4deUg6
	+oSSpKMsK+gm68hvUp8RTzYXNBaYfpAs34Nt1OxC+SD4aQgZGisDgWCHYx3/cBPc3W2tyWFqaR7T2
	6riEDvdJ84xQbzQSR3CDRimMME3JE2i8wMPd4mWUnTuO5PerEWcZNyahSZmGwd9FEI2D4u0CS4Hss
	KkVqC79y+UAOBm/tXvtX97v70Z5RCejC26AxONEiB5KI5AY+ggIM8lSMd/3jNrwlBmIwv4mhoPJHP
	vhmU1xb0m1I9GcwPetES4lEYchQa393rXfdOqPWBPlPKsd893abLET7ZgpflM4D9VycgB1rB9xRc/
	l/uFZ6YQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lID3F-00FZjf-ER; Fri, 05 Mar 2021 16:11:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lID30-00FZia-Rt
 for linux-nvme@desiato.infradead.org; Fri, 05 Mar 2021 16:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Wb3hp7rUaFmiEPgk5Zlai5Ac7+Fj0yvLC8OgsUfflBA=; b=LEA54gjUsFK8PPNV+ub+eqnmBr
 tGXA6FqS9M0DclxcjoxC7jDMfoW8dBjxGQyZze5ruTh7Rg7n+o6nU89Fy+wp/XpoZSTMHYVjRsPc6
 dflvkEgZTfPYEWEjiEbCsGR6zlXfbDaONtKKKWZiP+t6RTB2cv+wE3RZAlHzR+vjjW6M3nRcn5h3d
 nYi4v/ujF8ybQC4TEwEw9mk8N3AD0bIYuX4tLejx0bj0vXclojX2HUW207t5SvsyCtzva6RMX6ZWe
 ez4Z/63Jh5VrhZ4bYrIJdHc8zO9eaAFJCotQwJmkchJLQx8SrlPAfPBx38M0LUMi1wARNa56bSxze
 2sQuOsAw==;
Received: from 089144194051.atnat0003.highway.a1.net ([89.144.194.51]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lID2e-00Bxob-9w; Fri, 05 Mar 2021 16:11:13 +0000
Date: Fri, 5 Mar 2021 17:11:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.12
Message-ID: <YEJYFTnbec9jteOc@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 77516d25f54912a7baedeeac1b1b828b6f285152:

  rsxx: Return -EFAULT if copy_to_user() fails (2021-03-03 06:48:44 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-05

for you to fetch changes up to d9f273b7585c380d7a10d4b3187ddc2d37f2740b:

  nvmet: model_number must be immutable once set (2021-03-05 13:41:03 +0100)

----------------------------------------------------------------
nvme fixes for 5.12:

 - more device quirks (Julian Einwag, Zolt=E1n B=F6sz=F6rm=E9nyi, Pascal Te=
rjan)
 - fix a hwmon error return (Daniel Wagner)
 - fix the keep alive timeout initialization (Martin George)
 - ensure the model_number can't be changed on a used subsystem
   (Max Gurtovoy)

----------------------------------------------------------------
Daniel Wagner (1):
      nvme-hwmon: Return error code when registration fails

Julian Einwag (1):
      nvme-pci: mark Seagate Nytro XM1440 as QUIRK_NO_NS_DESC_LIST.

Martin George (1):
      nvme-fabrics: fix kato initialization

Max Gurtovoy (1):
      nvmet: model_number must be immutable once set

Pascal Terjan (1):
      nvme-pci: add quirks for Lexar 256GB SSD

Zolt=E1n B=F6sz=F6rm=E9nyi (1):
      nvme-pci: mark Kingston SKC2000 as not supporting the deepest power s=
tate

 drivers/nvme/host/fabrics.c     |  5 ++++-
 drivers/nvme/host/hwmon.c       |  1 +
 drivers/nvme/host/pci.c         |  8 ++++++-
 drivers/nvme/target/admin-cmd.c | 36 ++++++++++++++++++++---------
 drivers/nvme/target/configfs.c  | 50 +++++++++++++++++++------------------=
----
 drivers/nvme/target/core.c      |  2 +-
 drivers/nvme/target/nvmet.h     |  7 +-----
 7 files changed, 62 insertions(+), 47 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
