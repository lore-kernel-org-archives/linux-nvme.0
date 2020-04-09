Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD993C2BA2B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 15:57:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E4E20769
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ciEykP41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E4E20769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LCc7V4pX/FRURKu+VOsO9YZZU1rOt6JmceRtHKs4PfM=; b=ciEykP419hyRZU
	lSoQfxjYqTPUD3WCaBN754eh/Uc+OJOPyFU5mCliGgjR0YHclV37nmwiu9HN3Ar4sbhiEtQqcRr8f
	qpZu3OVYrv2vmp/Pl/SSdUC7LLdXQm83LgbGZ4R3USl59tDWxe0wRijZc0KoOTVyLPB3slpmwH/N4
	t0ED4MmADe/9k1H+xsHj9VjQ5R/I6Jd7mF4gGQXgJOSEBHOOD2wq8UjJY81Via4QpzCH+3tfoMihl
	Wc2et3Rhp/EJMQEOJC9ypszOfmAAVZiDgMxpOYNV2zPWRloXDRig48DyL0m+dGgRk/tA5ln5PCG8S
	4oYFvixH+W5nQXt1010g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMZYp-0002EC-AL; Thu, 09 Apr 2020 15:57:47 +0000
Received: from mx2.didichuxing.com ([36.110.17.22] helo=bsf01.didichuxing.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jMZYj-0002Cr-Bi
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 15:57:44 +0000
X-ASG-Debug-ID: 1586447847-0e4088309a6e0ab0001-VMfPqL
Received: from mail.didiglobal.com (localhost [172.20.36.211]) by
 bsf01.didichuxing.com with ESMTP id rYTwyxhjKl0P4G2M;
 Thu, 09 Apr 2020 23:57:27 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Apr
 2020 23:57:27 +0800
Date: Thu, 9 Apr 2020 23:57:26 +0800
From: Weiping Zhang <zhangweiping@didiglobal.com>
To: <hch@infradead.org>, <axboe@kernel.dk>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
Subject: [PATCH 0/2] verify module parameter write_queues and poll_queues
Message-ID: <cover.1586447291.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH 0/2] verify module parameter write_queues and
 poll_queues
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.211]
X-Barracuda-Start-Time: 1586447847
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 414
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81073
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_085741_556239_FA2EB6A7 
X-CRM114-Status: UNSURE (   3.90  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

These patchset add verification for module paramter write_queues and
poll_queues to avoid trigger warnning when them were misconfigured.

Weiping Zhang (2):
  nvme: make sure write/poll_queues less or equal then cpu count
  nvme: no need check write/poll_queues in nvme_init

 drivers/nvme/host/pci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.18.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
