Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB57C433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 09:49:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A07222227
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 09:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A07222227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PlW6crN9W7B3O2pfkkKYkniz7A5J6HB5rb3fnqyf6vU=; b=qGxqvCsv4sPzGSlo1KU8isetiC
	v0l+8fjSJFNz0rUhjgTvwnrCCT3NRm0FzAGuS+EFTmX1tu1lrn6YtrpmFNmhYamfO4zeQ63uzScVy
	4SeiJaVu10rmS7OvobONISlSYFvOQuVitXmLH1es//ATidp00J0GCJIVHgtWbN14dMRYG74F9Yii0
	OQ1gEbbvkoGGW66wZpQehd5ubQbAJBPe0xRW9tbvM7eAmiRvkrbppBr4rI6D6KAvXvkvckd113T8t
	UYblwo3z+HcYsDeIRDMS0kqv2FGppqQWiHriJ80C0JwPLLBuUqscUawWIQexoXvsMfhr6z/w+VdDN
	oDypxx1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2A78-0004KH-93; Wed, 20 Jan 2021 09:49:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2A77-0004K7-20
 for linux-nvme@merlin.infradead.org; Wed, 20 Jan 2021 09:49:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=WEe75gpbfE/3obtX8OF5F01qvBpAv4S8P0DHh2DfGiE=; b=FD4DpT/UbIt4uhXhzdq5Tf8g5i
 RQkPtQtI14r/LjSEsykfgK6Ya+eM9yL7CVJ7/lyrEQtRqv6sR9wH8YNvcxfL6dUgavMLOOUbzZ3mt
 rbgO7Yb0P/cs5+x/JV8VE62PuNGTeIflfMNGUVrG3o5Ox/CYmbcmGRVC+/Vc28nWCtnSlsMhoxhG7
 OeqpT3sp/H4tpTwUVN0goty7UkpHJ9Q6dF7vhoR01UkEhD/n9DVCN5DcQOR9xWRmN0rPeqlzLUHpR
 XOe9uer0as61DdZiwGYLDBx6ODbF4A03g85Tx0NsuVKG+uHqLGXmP2hN24vY+O76YRog5WWCQRHxE
 ulqOdi7Q==;
Received: from [2001:4bb8:188:1954:9564:b169:fdf4:9927] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l2A72-00FUso-Oe; Wed, 20 Jan 2021 09:49:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: fix error unwinding in nvme_map_data
Date: Wed, 20 Jan 2021 10:49:13 +0100
Message-Id: <20210120094915.3198346-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
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
Cc: Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

this series fixes the error unwinding in nvme_map_data after a report
from Marc that we see unmaps of not actually mapped data in AMD SEV
environments (which happen to be fairly DMA constained).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
