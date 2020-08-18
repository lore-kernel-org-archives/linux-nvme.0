Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F603C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:11:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B42320658
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Srbs0Y+M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTz9RlK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B42320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ljHlEbiFZiSI+bjdyWZpARMaqd8O0yxXWbpvso0NM3U=; b=Srbs0Y+MCi5IDvaCYlJ+IuduiT
	Bwm48omHUKIoxi0dKN8D0OC26ISxFdRQNo3dngOoIA06N9W/8QxMhNuoJZPeU5PmgZ9wBY3gGODga
	zX1AfjNxMWdGbjqGvL6r4nrIbueeZVMOn8Ki1arYVqDKwuopT83I1OvGaA3iL5zRualZHO84TQH1G
	T8VhPUx6XapqASdt1iVSoVMA9UGfZrGCcRszenWirLWvDdm2YodpydayxYthuZS/1SuGd3t86ldLF
	AmA5nrAMrL6qVlNtiwl9FxiCGiSJ3OCqao5uwbiUfzn8VsdpyD42F1T7cB8RLCudVgG7SIwDDtO0t
	N8dXXXCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vmd-00015R-EX; Tue, 18 Aug 2020 07:11:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vmU-00012l-A3
 for linux-nvme@merlin.infradead.org; Tue, 18 Aug 2020 07:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=+o/U9LH1ro0KIM3qLClG8HKoQUERI6tDemu6sWcZnPk=; b=NTz9RlK8Nz6oxhk1+D/YbnfRdv
 E6LPq3LJ5NWBuKpzBSHaLDnlDFf4xQorcrl0JWvrK8i9L7KH0b1EoAqUErJKHXvZpY399L683qzqv
 vrCsRlZd5Yx7rRvn1zmjNmarlx7G5U2ceSv0fs/qzgj+mURoPX2dkLQRFGieNLnqYqwRsy2TV8/HG
 gsa3Pj49jX8SkLaElbAJPJPeIhvY9vzb5apWP7hjOSxPKMltOj71rcf0IuT8Mt1ed17mHWZ083fWe
 veKSFpaExBZDR06L3pqnGacRtIS1/NHlQcXNm98CcCoDzEhpVl5ubwhaGgoFTRzJvzlF/rv0d8Xq6
 CxhoLw1A==;
Received: from [2001:4bb8:198:f3b2:a8c9:886a:f150:c8c6] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vmQ-0005Xt-MX; Tue, 18 Aug 2020 07:11:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: nvme completion handling refactor and fix v3
Date: Tue, 18 Aug 2020 09:11:28 +0200
Message-Id: <20200818071132.1136033-1-hch@lst.de>
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

the first two patches refactor the common nvme completion code
to be a little less obsfucated, and the third one is the fix
from Chao to redirect to a different path ported on top of these
changes, which now make the fix very simple.

Changes since v2:
 - fix a comment typo
 - drop incorrect comment masking in nvme_decide_disposition
 - add a comment to nvme_is_path_error

Changes since v1:
 - add a new patch to handle the path related errors using the
   SCT class

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
