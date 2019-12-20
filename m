Return-Path: <SRS0=LlAf=2K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEABC2D0C1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 03:31:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D9124682
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 03:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+JyKrt9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxtK94C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D9124682
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WIVCDuTng/n/RprPFnFxvPqThLhXbtoI/3hB41EIldA=; b=H+JyKrt989pa7D
	0of3Xv8dkHnlXrsKk5BQ8BHe/ENoYrWAbtHidy8lEDiGILX5mGghSCle5PjxFeGn8yuEu/PMpns5Q
	ZXyZvceSCxuv4US1vQcjY39K6TdMBAxxPac112CPZI9J8lcon8eSS72HlPJILq532JrGasDuzDitG
	zc6EHXBfXVFmO4l5RFijY/gGOqVm6exf0JfKvIAxPZ5hd3k14/RyRN6mVe9CE/Y/nQjFbDp/p2tBa
	8ehGedWt3NGEm8T0NPOJHrpy6AkIebNu6CHiHD3Fu9AF6q0IRiTfv3ck2R1zaedAERdHo5cMQxI96
	KixoOvmof8vCGyOKkqsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ii90Z-0006QZ-GR; Fri, 20 Dec 2019 03:31:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ii90T-0006F0-VL
 for linux-nvme@lists.infradead.org; Fri, 20 Dec 2019 03:31:15 +0000
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1C9624680;
 Fri, 20 Dec 2019 03:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576812672;
 bh=7ooy/GLZ2C0fwuT0ifccnwCVOOvKpGvdYciGjSUO8wQ=;
 h=From:To:Cc:Subject:Date:From;
 b=PxtK94C9/HqjMKLJGdQ97w4dn/v6X8YG7pOlu4mERkqrrz7f63HRYAVbWYclZdBI1
 pnxxmN16T1HdCZV+TYK3ewa9PEHTaodW09CphS1NGz1KnvPSa0qJGF1jQaZdw/L058
 nGBWT8iEJU4JUM3UfdSBt8uFpI/xwx8xEa6uIUx8=
From: Andy Lutomirski <luto@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/4] systemd ID improvements
Date: Thu, 19 Dec 2019 19:31:01 -0800
Message-Id: <cover.1576726427.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191219_193114_038517_E50C922F 
X-CRM114-Status: UNSURE (   9.45  )
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
Cc: Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all-

This was github PR #594, but Keith asked me to email it.

Please review this carefully. Also, if you merge this, please
consider changing the 'luto.us' bit to something a bit more
sensible. Maybe com.github.linux-nvme?

I'm still dubious about the way that newlines in the ids are
handled, but my patches don't change that per se.

Andy Lutomirski (4):
  hostnqn: Fix the systemd-based NQN namespace to comply with the spec
  fabrics: Rename nvmf_hostnqn_file() to nvmf_hostnqn_load()
  Use systemd-generated hostid if no hostid is configured
  Do not install /etc/nvme/hostid or /etc/nvme/hostnqn by default

 Documentation/nvme-show-hostid.txt | 29 +++++++++++++
 Makefile                           |  4 +-
 fabrics.c                          | 68 +++++++++++++++++++++++++-----
 fabrics.h                          |  1 +
 nvme-builtin.h                     |  1 +
 nvme.c                             | 15 +++++++
 6 files changed, 105 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/nvme-show-hostid.txt

-- 
2.23.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
