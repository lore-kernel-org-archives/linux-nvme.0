Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FFFC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 16:23:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BABC206D4
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 16:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wlPyiQOD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JtXPHWa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BABC206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hdl1EOwJ4GZofWIPwykIaVFL/vIIQ+WKuJIuJRblKMM=; b=wlPyiQOD2JfoyyTE1Kdt1/vDHx
	jXm76G9pUuFq43gFNM6K/ipI6cChqYaCCzSUN6ylMVOrUQxIj63BtmrjfoYUoMz89XjUWKCpEyNl8
	fnMTwIbprS7ZLxQxawrK2ik+HGrh+OceLk2TB1IQKP1wI6k5A71ioz1gdm4wFj7EBnay3EwHzTIPY
	kUqTOsBZ6rpvyPTVfqFoWfUeFurEVg25TegEoSBQftRZ2sjg0lUKKr2CSo5BIk/aqzHF6+4y/tOCz
	g35hCoPF/g1qZh+qJ5eCsARDSFHr2ue4EoYqsqcZ06MHnVvBbsW7SbeTkRfMFa4Kk2xSOr07dYJOk
	XSIrRLrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnlhH-0008Fj-6Y; Tue, 23 Jun 2020 16:22:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnlh5-0008Ew-SL
 for linux-nvme@merlin.infradead.org; Tue, 23 Jun 2020 16:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=UyiZAnlEgqraCMEtF1hIe2+4CHeGBcb3koOcH3rzrio=; b=JtXPHWa5DChIPqjcClrPQlcjMa
 ld0fcGmia/3btk3A4rLu9O2AYIRNtDdHz3O8ZjhCTtsWl5ChghdVIoL/NWMwFtPJxFX39bJ8yYNOA
 Kagdf0TWwrOraSAQJMWXS55aHYwk9it2XJvDgV5ZdU7kfFdiMKi/eSE1TAGmU7W1NqsSy91InKJUD
 V72wBTuPsYaU2MyFy5T8xIlS9naXl9HXGESsTCONHe2lyBTje5vY0lsdv7sNdIRL1fOuShnU4PEJM
 oHkfqJ1BRpGrF1aP6kedsYCHbhw48BkHWJ8Z2bRKeYv2Vn9HuH7MWdi4G1cqrL5wDb48GjwU++1sJ
 nkGCzNPw==;
Received: from [2001:4bb8:180:a3:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnlh4-000230-3I; Tue, 23 Jun 2020 16:22:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Subject: nvme-rdma regression fix for 5.9
Date: Tue, 23 Jun 2020 18:22:38 +0200
Message-Id: <20200623162239.950789-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
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
Cc: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

can you pick this patch up, it fixes a nvme-rdma regression in
for-5.9/block?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
