Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9838BC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:02:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3119E6101E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3119E6101E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v5pmljaPl4ulbgOvqt+zWdn/D5NrTQXc7eET+kala5Q=; b=BQ9S8x6aecRiJ5GedQN7SdA/9
	p0/8ljey5TI/VxlXPlq3HDE29uDaROn0zxNkoS5S0bRiUwbXtBbSfg4J5HwglHr8giy7t5Ayud2GG
	3gGf3aCLMO0fN4nfCEAycj19swbExz5xeVpa63hbnhnZVliKCB4TXLGAKMfnZ6CeeqrVX/AEhWsr2
	8QCLsvm/K/yPJLINv+bZDvXew3yj+UDJ6ksxhlsoWYNbf//rMBSVVCb9ByvhhpT5X07Bzw7qLbe8l
	KtM2WzvsXQZU6vDdTyuJZ+aM1gqwzfZghRPVOR5muzQPUjz0GKaEuKRnqVNQR4JtepIGcQ3On59Hv
	rrkoZSzLw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1litjV-00HEpz-Lc; Tue, 18 May 2021 07:01:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litjR-00HEpl-Er
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 07:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PmUHhXVA41Uddlsi/HXZNOX9h1NibyZFqt7oDZm1BYM=; b=nLvhduUUDhv/yy07VnjsqIIFgy
 BGs+jMiOwEnOJZO23714Z4C4c7g+ktuJ+LJmVf02qPV2PVi+op8NeMvnPfz0o8Irb8hn+NaBLvHNR
 EaguBDow1e1RqxiZzKMq6l1SKSNnizbCBAyTTrNMjtxzCAcCMLZMRleJzylcrTxBmydscGrB63r2n
 cG9K2obddgmn7V1dhfjEEkKmrqDFfcF0Sex03jalQ/NbFvksBxXoOChAjVFfh3Av6nt85nZc/2yHV
 8lovXgjgpyrfhqLxex+X2mO2qbo2MsFhVuyLSk9lRLtCmmnM5TA1LJveZs7c9FSubo/CWPSIQqYWC
 WWGA1ZIQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litjO-00EO7s-W0
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 07:01:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 05ED268B05; Tue, 18 May 2021 09:01:28 +0200 (CEST)
Date: Tue, 18 May 2021 09:01:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 2/3] nvme-pci: limit maximum queue depth to 4095
Message-ID: <20210518070127.GB8300@lst.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517175955.602725-3-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_000131_191504_C06036B7 
X-CRM114-Status: UNSURE (   9.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Can we lift param_set_uint_minmax from sunrpc to common code and use
that?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
