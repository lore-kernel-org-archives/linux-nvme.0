Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E9C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 01:57:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391562082E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 01:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b41t1pfe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YAza08MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391562082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PreJmagkVjYcJDZhF9No8PwZ3D9qqTri7x7TygjPBrY=; b=b41t1pfevEjjvq
	WD3XLdl7Ci3Jzlf2sLKd4/jZtnfc2ehxk+/ZpwBq8tW3znXtUs87+17dwxD7mv0FU9QkueJ3OOPMW
	Au2rAiTe1+mgjvjmU1GUYslZDe+g1tsOM5pm7ULKICcvMP2ZUqE6VAuMk4H9QvjOI5EDl657J97ph
	CpmRu6gl7eMYylE26h3hC+8pE2zNNJkt7hpkrfi5/z4VatEHtNV1XkT5PTVfiqpBzNShs2kAa53Hu
	g7e2m1didjfi2NyNX6vu4iszUT3npgjkJSGfAngJmSXklkHbt2XWvXj6Ujd0SDVDPjW8ZfTEhEwRH
	O1OzjXIAgpL+FTroX3Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iz9wc-0000GV-Mu; Wed, 05 Feb 2020 01:57:34 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz9wI-0008TD-LX
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 01:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580867834; x=1612403834;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wYb2S2L8yaC7M1Lu5Zgxitm/3T7jX3UQfyM+Fb3SEUs=;
 b=YAza08MDO8COtu5mqQHVF63M/KOoaNRWgyAAZOiCD1YdXQyVXcTCgArt
 IRNfg1Pa+L/xkPqLjgLOjfs3tDXl60B9Mw0dShQ+q4XvTDfxAUunamk9z
 BYzAK2kVUtDdUqf7RCnTnWpIfV64NuMQQwRyef/eKCvqxnRyrfX6M3tU3
 xFjs8YA53cK/xHtYmW8eHVMc/17nIAWqJjRhnxshMvTwCb84qBylFssvb
 seTCQ1WrgnAY/IYO38G5OyPZmIZcbJ9gNxvYtvya1LMZ1HbG03Av8iMLB
 T5lw5GtwN9Wx/v0UZNegIKThcgTnT+pxZOBV4cLSWLHbiEzaJxtaxBuvy Q==;
IronPort-SDR: SfhTNuOBfGaDcN8kTlwyu1tu8zrmbWuLr14m7RQNK2U7G2bFq8x69ptHpdIdWfJYR6hH3V0GhR
 kVggvkbJuSX9KMpgJrGp76KqrRQbPBxiMhB6xQjEwL/BUngU/cpX8DGooEXErp3F98FUL7QNZh
 VTedAArgibznZ6/uGEyxMZgKVi2iYUfPhWZYNOHfCNxbf0jknW6wduAapPfm/d3C8Laa8VL61s
 Vah+DDrgjtpPj9MMrp2gwjLnyP4n1yahtDZEe5wpVl1wt0BDkwTXtyRR+XKISQ307uTXMXMJGl
 XP4=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; d="scan'208";a="129112163"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 09:57:07 +0800
IronPort-SDR: SRTZydaybiOA3PwXQpV4y9b1o9e3GC1lpyrW8D20UNeU4jEO/bTtG3qtWu8yMt0XW/OcZc7a0L
 0CF/Fx5IN42FJAfruIIaWWquZUxMq4w5chjgZXW2HiqmpLk4VYLQH44CKc2FWGIU/hLxaHXI59
 TZUcfa5u6/ilM72CP9lpb3vnTZMoY40BbZkSrg20Z84cSeMOfE7+2Bo+C3BV2giOthAWFIkTUy
 SCarz9BL15qPfBkcNki0XALnbV1ObsODFaouY1T4XuMV4RoN6mlNC+5Vgh2Q5r+5GPRnsTZViM
 5IWA7yZdsZCsNnGxV5hma4Ln
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 17:50:10 -0800
IronPort-SDR: J+8vQBdaw4Cv4xELKsTh8rcPLprcMl7OUlIrdrkjO4Algtjb5v+92EweavRmqCfAZqEZhuWZOz
 AvwCXBHlNrS9qd8XAGb1mCWfuADTvMwhj6MgmaJE5NuxFoWJ898dJVkMT9Nq5aL6784plte/wJ
 JbzIkw3hOokKqvxiFvoRnN8G1MBrpeRGCAye+BEG/PO57fkUc2Vr5jBxMb9VXLRereNP400CKJ
 RmtLeawpXGtw+SUpgXmWXSbnuSmmBTy4XhYnZydARxu2qYduoccI6BaQ6Jwlma6Pnr2k/s1/cA
 JBY=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Feb 2020 17:57:07 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvmet: bdev-ns buffered-io and file-ns write-through
Date: Tue,  4 Feb 2020 17:56:51 -0800
Message-Id: <20200205015653.21866-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
References: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_175714_777699_1190C9F5 
X-CRM114-Status: UNSURE (   8.05  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: MRuijter@onestopsystems.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

These are last two patches which are based on the discussion with Mark
(CCd here) along with cntlid and mode.

This patch series adds a support for block device namespace to use
cache and file-backed namespace to use cache in write-through.

Please have a look at the respective commit logs for more details.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvmet: allow block device to use buffered I/O
  nvmet: add file-backed ns write-through support

 drivers/nvme/target/configfs.c    | 72 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  7 ++-
 drivers/nvme/target/io-cmd-bdev.c |  3 ++
 drivers/nvme/target/io-cmd-file.c | 39 ++++++++++++-----
 drivers/nvme/target/nvmet.h       | 15 +++++++
 5 files changed, 125 insertions(+), 11 deletions(-)

-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
