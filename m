Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721F6C433E1
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:49:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB8D2075A
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XWQEXuot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB8D2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jce/5Dlu8vn54QRuBTtzobO8JtLuLcN9rDL+289c9kE=; b=XWQEXuotx1J72J443D3sFFMr45
	CodTN6GWe/YD15E5JM5TjzDEcdbDQWtncGuzF8X28vupttqUQkkkrDbco6dB1FscPKxFUi30bC9Ew
	IgWdv4sAteayUXiU2tiAyGGkjcvDYzhZ+bPEiBuThlO2irLxQtVDNIds8yr9V1QSdBjx4ox8+cwFX
	iF+3NYGdPpVdkSxq6LMKjCX4zT3rbMAamH/t24+rjFVMJ7QkW8eXzdUFeJEGoy3Rgtc1Xh25xDnx5
	GHtlL+Vcgto7k/IWWB6GV513tWuS4X0uV/t1nZpBP52u/tMBgPYMQRzTw04rJkMOVC8RE1HEMV6vG
	IxdV9SFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UHO-0002pb-RB; Mon, 03 Aug 2020 06:49:02 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UHJ-0002nA-Hi
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:48:58 +0000
Received: by mail-wr1-f45.google.com with SMTP id b6so33072012wrs.11
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6rPl/XQAx312kYBDl1D3OvoqQvb50hFc5fzpRw9mLU=;
 b=V0f6qm6x4SWnrjr755YQ3KOdy7Q9vBdJp97TCv07adYKDPd6vsyIxSdQom7DbzypE2
 +fg/DvXa6XBWcfsDPvz30CR96RftoYkccye77yDA08PMSlkWAmjEE5e92eE3o32GdjkD
 PjhiFyS279NXwsFBPKbHr+uOPB8Wg6xDUwmMt6JHdkxL33apGQqpibiGLeom3iFWAX0P
 ub6gvKfiM0g3R4IzHWT7XViSBxVM1JNw28bT5TnBnMhUEMGypdJSfnJNLkuC8IHTLZaA
 fA6uVqfCxQnve8xTDlOQxFFHggj1+qfCc5MjRAS6TRCoYK0QrBFJbiwP5V8jrajUEW/o
 dFEg==
X-Gm-Message-State: AOAM5322xH+ySxEELPWsfnNrR8xPaPtcmdoT58tRJ/ChZMI6ZVUDUG3D
 7IsKQdvfoRz305cnKbelEyUcl9SQ
X-Google-Smtp-Source: ABdhPJwhvMVB5aSMCJUgeujA4jYf9i+HuzyArtUjN3y4od2abhibpchkQsVNaR+XZ7OVLgV+O/ybog==
X-Received: by 2002:adf:e647:: with SMTP id b7mr14730428wrn.220.1596437336048; 
 Sun, 02 Aug 2020 23:48:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id z6sm23740647wrs.36.2020.08.02.23.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:48:55 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH rfc 5/6] nvme: support nvme-tcp when runinng tests
Date: Sun,  2 Aug 2020 23:48:34 -0700
Message-Id: <20200803064835.67927-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803064835.67927-1-sagi@grimberg.me>
References: <20200803064835.67927-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_024857_647403_15425D8E 
X-CRM114-Status: GOOD (  10.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

run with: nvme_trtype=tcp ./check test/nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a2cb0c0add93..69ab7d2f3964 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,10 @@ _nvme_requires() {
 	pci)
 		_have_modules nvme nvme-core
 		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
