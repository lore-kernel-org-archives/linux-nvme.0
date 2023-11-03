Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63D4C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Nov 2023 13:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qs2OFogT0ZPjl5g17RciDI2v1BWncmwt5aalvcD4s5o=; b=KDtdTgjGH76n/SGDlJ+8Vx7map
	PpZAAhTr1ydkJn5TAmcDE3wlTx3uAfYDUGTEdl5Vr9axepJayt0Xy6frTaNKVamoiONi50pYfknRC
	YcC+U1tl1mOmIL/TBZiMIHkFBAOSpnalihrMNwAP20iE7WCyFT1WPAPgKYJlyFXNzdLvgPupgdZC8
	bzG8zPkhdl0eWmdSB2y2oDRlCToXpsZhdqHZXN9qM5xyNBJq4Dn+Qyl93qFQUBvf6QGLxgiKZqR/e
	WCRS+5HYWQZnWQqtcl/96hjHlwX9cuzpOpx02e7dPkCDGfntpI+IuAXaAozzNx9EKz18FGnHi1HmG
	mOiMq/vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyubi-00BVx1-1D;
	Fri, 03 Nov 2023 13:53:06 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qyubg-00BVwN-0S
	for linux-nvme@lists.infradead.org;
	Fri, 03 Nov 2023 13:53:04 +0000
Date: Fri, 3 Nov 2023 14:52:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-nvme@lists.infradead.org
Subject: [ANNOUNCE] nvmetcli-0.8 release
Message-ID: <ZUT7O9X6WkU7bBft@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

I've tagged a 0.8 release of nvmetcli at:

    git://git.infradead.org/users/hch/nvmetcli.git

and uploaded the release tarball at:

    ftp://ftp.infradead.org/pub/nvmetcli/


The shortlog since the 0.7 release is below:

Christoph Hellwig (1):
      bump version to v0.8

Hannes Reinecke (2):
      nvmetcli: don't remove ANA Group 1 on clear
      nvmetcli: fixup ana groupid setting for namespaces

Maurizio Lombardi (2):
      Documentation: fix typo
      nvmetcli: set up the target only after the network is configured

Tony Asleson (9):
      README: Update URL for configshell-fb
      nvmetcli: Improve IOError handling on restore
      nvme.py: Explicit close is redundant
      nvme.py: Sync the containing directory
      nvme.py: Make modprobe work for kmod lib too
      test_nvmet.py: test_invalid_input fails for py3
      nvmetcli: Report save name correctly
      nvmetcli: Allow different devices for make test
      nvmetcli: Correct xrange usage for py3

Yi Zhang (1):
      fix common misspellings from codespell project

zhenwei pi (1):
      nvmetcli: add a tcp example json



