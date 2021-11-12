Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37191C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 13:14:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025E86103A
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 13:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 025E86103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=74OMB+go3hRX+MvyLa6wQutI3Jh9uRftdi+yfxj8DyY=; b=0E2l0WmIq2LMzGYqeImFCnzE/D
	RXaCO0u/5oGO8YfOR5tCTI5FIu3phbOKgJeufnjqsCWJE/SdJ2+FhMRt+nIKYDifUQ0eUqnBU/48h
	fQ2+joJE5TV1Y5tZsn3sPWuBKc2X+FO0kFd3ufuUh9mEn9ssN8RRTafW3GgWrmSfSyiE19YYvZgPD
	xyinXgm1dRmRa0o2cRYmbqKxOru51pl3OuKUsYKSpymUzwZMkWaynXUohg233qtwQmLYF4c3XF7dS
	yCrdnrAY9bvRm6pPZR0aS/rX866FXQjEHcH93EO6xSZtyN5E0UBck+KwQphk1NHNmFOrWf8BjXk59
	1GO074fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlWOK-00AUyu-Cm; Fri, 12 Nov 2021 13:14:52 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlWKu-00AUCu-83
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 13:11:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CD7EF21990;
 Fri, 12 Nov 2021 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636722678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=74OMB+go3hRX+MvyLa6wQutI3Jh9uRftdi+yfxj8DyY=;
 b=Xej6ltcGhMdZRB5qvuLZkL7Y3yHFcSdMNaehWCPN1cAwwf1AOWK99/NeXqGFVZeOMDUped
 hiJeP3eHcoH2cokW1kfIkG9FT+5uWP/zmDQpxJYvHzeJVKth5Xu4KxNMIsIWZ08psYVTXG
 sqeC5nw6ZBrCZrqJkIANDif5ew6Mr+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636722678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=74OMB+go3hRX+MvyLa6wQutI3Jh9uRftdi+yfxj8DyY=;
 b=ksoltha4KwZg+90LqK86CYBp3sv9hEN0Q7d1F+ddOjsTx5CI0QoJxzn6/ufN2kH5xfWp/9
 GorHZsdhv5NVtKBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 96E97A3B83;
 Fri, 12 Nov 2021 13:11:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 8A6CE5191270; Fri, 12 Nov 2021 14:11:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv5 nvme-cli 0/3] nvme-cli authentication support
Date: Fri, 12 Nov 2021 14:11:08 +0100
Message-Id: <20211112131111.97599-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_051120_498575_4CA0C82E 
X-CRM114-Status: GOOD (  11.42  )
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

this patchset implements support for nvme in-band authentication.
It is cut against the current nvme-cli master branch, and requires a
libnvme patch 'Implement dhchap_key host and controller attributes'.

The implementation corresponds to the v5 version of the kernel patches
for implementing nvme in-band authentication.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  Add 'gen-dhchap-key' command
  Add 'check-dhchap-key' function
  nvme-connect: Add 'dhchap-secret' and 'dhchap-ctrl-secret' arguments

 Documentation/nvme-check-dhchap-key.txt |  31 +++
 Documentation/nvme-connect.txt          |  17 ++
 Documentation/nvme-gen-dhchap-key.txt   |  52 +++++
 Makefile                                |  17 +-
 fabrics.c                               |  17 +-
 nvme-builtin.h                          |   2 +
 nvme.c                                  | 276 ++++++++++++++++++++++++
 util/argconfig.h                        |   1 +
 util/base64.c                           | 105 +++++++++
 util/base64.h                           |   7 +
 10 files changed, 521 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/nvme-check-dhchap-key.txt
 create mode 100644 Documentation/nvme-gen-dhchap-key.txt
 create mode 100644 util/base64.c
 create mode 100644 util/base64.h

-- 
2.31.1


