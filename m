Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F4FC61DCB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2026 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QdjCvINA0cwlE2/4yuBDf8b7Wm2saPmhAU2BAVB86Ek=; b=5BAscOb/KImlc3p1UpjT6Cbqxq
	vzb8pvb9RfVHmJUxvecY5360mMsDpsLNcvbw7R/Kqqrq8dJ3JAhC8ybwuKFJclCp0zFNW/fSInLfI
	y5qd+AhBT6eJFTHOFuKsC6J7afW9Ykkl4G46J42Kj5wnNfwVvVAHKx/E1zHcpsRYirk42Vi4SZWZf
	wVpDaw+v//LEU8MaXm1aEBA8ytDlhUEx3WnSL+q5KEfKSnSry3wFulR1LgOiHXugck7FzfaMldmjE
	ENixhLfsw57Qy0V1Cse6xq+KFI3cEtIUkGLFUjBUY9BUr3nKaJ335pQLl/8Kne1HgvHVbHmfa3+5e
	rOZk/vjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzyXW-000000066AY-31Ay;
	Fri, 28 Aug 2026 15:30:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzyXT-0000000669V-11dX
	for linux-nvme@lists.infradead.org;
	Fri, 28 Aug 2026 15:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787931040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdjCvINA0cwlE2/4yuBDf8b7Wm2saPmhAU2BAVB86Ek=;
	b=P4ogReT6YozS2UnrFsgG/DmjAo/FI5u70PsCb6VCsX7OcZbEM1JWxMqbSNAzs9idcSHH5M
	QGr1hutv/bS488P6M4SCGSwhsuOcJqkLXTW0DmhrFWwA++yy9+DvhLPB94sOfjUi8FKY8H
	eiAGLlIWLnHecKCCLsgsM7SLiYTUSt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-Cnz8mARjOdKTPva7-lntBA-1; Fri,
 28 Aug 2026 11:30:35 -0400
X-MC-Unique: Cnz8mARjOdKTPva7-lntBA-1
X-Mimecast-MFC-AGG-ID: Cnz8mARjOdKTPva7-lntBA_1787931034
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1EE219540CD;
	Fri, 28 Aug 2026 15:30:33 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.80.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 472DC18005B1;
	Fri, 28 Aug 2026 15:30:32 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [blktests v3 0/2] Test multipath and marginal ports
Date: Fri, 28 Aug 2026 11:30:27 -0400
Message-ID: <20260828153029.853768-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: AenaLruztDB4PQmwyoj39dstL-37VsH7T8I-Cw3Zol4_1787931034
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_083043_346577_54D38443 
X-CRM114-Status: UNSURE (   9.25  )
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

Tests for the upcoming nvme-fc: FPIN link integrity handling set.
It tests for various multipath and marginal port
scenarios, while confirming the port usage and state. The test is
intended to emulate receiving an FPIN event in a multipath environment.

In V3 various generic link checking code was move to common/nvme.
This is so that it can be used by other tests to check if multipath
working correctly, even on kernels that dont support marginal paths.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220329
Link: https://github.com/linux-blktests/blktests/pull/264

V1 -> V2:
 - Fix timeout issue
 - Skip test if /sys/class/fcloop/ctl/set_marginal_rport does not exist
 - Wrap lines at 80col
 - Add John's tags
 - Fix various change requests from mailing list
V2 -> V3:
 - Add tests for inaccessable paths
 - Fix fio not exiting
 - Move generic code to common/nvme

Jesse Taube (2):
  nvme: Add _setup_nvmet_port_marginal
  nvme/070: Test multipath and marginal ports

 common/nvme        | 278 +++++++++++++++++++++++++++
 tests/nvme/070     | 454 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  49 +++++
 3 files changed, 781 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

-- 
2.54.0


