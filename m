Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CA7C4727F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CBB21531
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GLVF4LaK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YJ4ax2yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CBB21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E03p8KjgzBPn32CtEsedbpnwe9EZQBaE6znDHR0KI88=; b=GLVF4LaK+wl8dNaKsp925HqXS4
	YlMavD9I/gk9chdmAjinSSswecx63Ynhgs5njgQeOfWC6TaTA5Wi+D8GBERRPYuWEiXS23LLTBFO+
	m2vMF92/dnGCPpJ3V8Gu5qEU6n9igPX+DxYTzwcaxZSbZhhgR+27CYJwh383Hu9vWzfpyFNyeo93p
	AhM3yb2PpAtb7tSGNoKf8C18CYURLwp7CdKiKiuRqYTGH4uwE1wShqEMer63DpNI8MpPSOGahrpF6
	aouI1fumxF9RVY7nKMK3b3sTvs94uz3deY+h6t6BGzEul6A77vrCgIFB1jRZyvodw7dYmNxeHukSm
	OEtenBQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsN2-0002K5-HV; Mon, 28 Sep 2020 12:35:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN0-0002JZ-Rk
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=dGE+edmUc8tHNExrX53r8FBG4bBHsq45M4oIARIViks=; b=YJ4ax2ynSt8zbV272gV/XkgCA3
 YYT96do6LSJwLBcEbh6BHLvHoeKJtA+t3UlJARKR8PkafYqHLEUXhMTHRdsqaz9vI99P0t8U3a0Wp
 Jxba8TMcYHa2cZo1WZtXd6DgQeAC3rP9AZmFdkcLcNKqYGx5WYU/nMDOLb8xGV2y6EtzWSVkBWnrx
 p/N1D7HwHYvKprxcQ1Z3TSmEl+hxr8Ff5wFldQiVBZ4iMoXlOKET+hUlBwgIcw/MV+mCb/KvMpfq0
 fMkdQ6xfQYiLRB1NEhhOFwveEMsu9Z4HbJ8fdBWMIXpr4sEZmIBGgAs375tQhL2hVqF9GypEJKfWP
 307t2HPg==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsMy-0004gq-9g; Mon, 28 Sep 2020 12:35:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: refactor the nvme scanning and validation code
Date: Mon, 28 Sep 2020 14:34:42 +0200
Message-Id: <20200928123502.435373-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

this series reworks how we can for and revalidate NVMe namespaces.
The primary motive is to:

 a) not update information like the block size without having the
    queue frozen
 b) better structure the code for supporting multiple command sets

but it has all kinds of other minor fixes and cleanups as well.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
