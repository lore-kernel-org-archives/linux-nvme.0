Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C1C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 08:08:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A2E610A1
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 08:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A2E610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=VK+gdaiHAnEze5CNn2s8tbwGK
	n6Y5wwPow0dFbNcfbk3VIn8MbZeSVGYnYUeVriDVEX8IYfX0a2/O1eOEAKOCBfCAV+1Esmc8voon1
	JRWhtgM8qHRAXo3YKwb/xVEvrI72nLOeVhlYZVHqyeeJUtwzKynI77/8JwBW+JgUy0oyZAB/L5NHR
	itTXoTW9WKMEXtFVZ2xaeIUkNjRLHsvUacazlYZ2OuBiK0JxpSd9iox55wHJmaUSuOBGjkoypZXbW
	Y3sz8bghtBumzwUJyOA4RjkOVsR0SSnNzz5c++SIgkVs64X5mrgZo/38CXmjyy/34OerKlFDJKwod
	MBeaLgMMg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYlQV-00BXlI-Q6; Tue, 20 Apr 2021 08:08:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYlQR-00BXkh-0h
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 08:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=O+dfAg7L9Tqp7F46dsG5HdZjFI
 x95JsB7KSz6v7Iv+nUm1B53Cxb5KC2z1P5AOvHiwfCwqEYunivRbPzyrv0m6EYKSunR257y9OTGFI
 ymj5t9FYCQe4yGVUAoUVnZzzxBxQxEk55doL/hcaQ8Z6J/wcnjvUyzdItOpuYM2wJVL0K/xxTMOJ9
 FpF78g9aLgRTP9j00IaKrlJtjA8EyCE0H9V8hQSgzK41pDpgGaIavu+7H9kD38L4I/yubnA2WPq6N
 lOidjn86lJfOowJeqaXsYrnLCptpEJZR1vdzchpmsMt3h5u0ilXvR3+udktE4rDnF4xryEB4b4J0+
 QQyJcMcg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYlQO-00BuCX-My
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 08:08:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DA66B68C4E; Tue, 20 Apr 2021 10:07:58 +0200 (CEST)
Date: Tue, 20 Apr 2021 10:07:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv4 0/2] nvme: sanitize KATO setting
Message-ID: <20210420080758.GB22035@lst.de>
References: <20210416114621.129736-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416114621.129736-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_010800_907504_2413D033 
X-CRM114-Status: UNSURE (   8.42  )
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

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
