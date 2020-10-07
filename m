Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B9CC4363D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 14:23:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614B92076C
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 14:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Col7BQh7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jnpz+tBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614B92076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wGZaZ7jmDpQtppwJsLd9qJw0JkBFFzU67qw8B7hXueI=; b=Col7BQh7TYvMXzd4nZZaUs6lbX
	SeBXsmZW9upA7UwIw9H8m4GjRSY/3WhSMhmr4ieIBv+zwY6U6k8pHn5+f4WZ/bqKqSZGXxIAWMQDR
	9jMo4gRFBdy0ZFXyJfNM0+jYMelYGVPg2jjMkl0u67aY7BzbC5im9mStTMTSyu1BLVUALLZtFudds
	wwC1xHjFQiwNtEFrHsUQ/dOSq98by5OFZC9yLOhq9J/sO/GmMV2cEh9J5Q3UOmco4ErJ8sJeytP+3
	tCtWp0K10HFZSwYUlwrL8R9kylIZDiwGp8/bUSbsMDr/1eSkEyq51byu3d54qOwtkFL38LIIDs77R
	INCK3wgQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQALp-0003an-Nm; Wed, 07 Oct 2020 14:23:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQALm-0003aN-GF
 for linux-nvme@merlin.infradead.org; Wed, 07 Oct 2020 14:23:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=L3w1admStvlY1PqJj30y2+BznKvimoaQSz33TlBXa68=; b=jnpz+tBzZiFogXHyre0BlAESMu
 J/cgxXLdnunBgRbdMkmKKNOPU8trqXto1GJi4aJt78Jplo0EZvmxBHb3Cix6sEySEA6PU+TMIjB9/
 3RxSl6QlR+ElEix7omQZLSI1e5vUnO2FnKbq/78aSY7ufdVa9/2z//0GliJNY4QQpOoWVondMcGnE
 rE/G3dflsb0Bxhh8/KAJ3qpY+chTscm+/ACIDOtX6UYGorp9qVOIsaATvUgLbfQWogoyoqySwuXHJ
 Lh15wIgj2cOZuAehhNk6iMuo4jV3ecr80wUSeiuGosA0+UqmefakOqZGtuRfWFgz99/TFVvOHqff1
 Gi2GufhQ==;
Received: from [2001:4bb8:184:92a2:f749:31f9:6664:a99d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQALk-0003AR-QG; Wed, 07 Oct 2020 14:23:25 +0000
Date: Wed, 7 Oct 2020 16:23:24 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fix for 5.9
Message-ID: <20201007142324.GA1458015@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 6d53a9fe5a1983490bc14b3a64d49fabb4ccc651:

  block/scsi-ioctl: Fix kernel-infoleak in scsi_put_cdrom_generic_arg() (2020-10-02 12:01:47 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.9-2020-10-07

for you to fetch changes up to 4bab69093044ca81f394bd0780be1b71c5a4d308:

  nvme-core: put ctrl ref when module ref get fail (2020-10-07 07:55:40 +0200)

----------------------------------------------------------------
nvme fix for 5.9:

 - fix a recently introduced controller leak (Logan Gunthorpe)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: put ctrl ref when module ref get fail

 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
