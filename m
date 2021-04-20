Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC62C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 08:08:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0416109E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 08:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0416109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=jGtql8AFcffSxjdoJRZ3E583k
	bVN3RdrCFgSfwbu2AbdZGN/oAEf494kCtpDf66ostHb7cy24iYaUwmdphIbKA8242rUb3fDdELCFh
	LZhqWrkK3UZdn/fGbGU2DftKWy4SjjTT9NrXOVzqYVjencwhmB1iX/X8NQkP4u+hbW9KJ6pYY5RhA
	iF3TpY4LTcdMBL4VDIzyl6Q1SALwVayZNGAc04GR1RGol9DIrjMxzthGgMS6S9JYyaOK56ABnpCZw
	s3RUqeYvOPuG63X4pAAtajHnqXOWN19W5IzB4AG7OjIr3607iSuVIQ9ywPaSCdboayRcFc9UwsLrd
	N92TRDdqg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYlQK-00BXkD-SJ; Tue, 20 Apr 2021 08:07:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYlQH-00BXjt-WC
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 08:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=Z2ynDUUeIItmQtXGobiveN7G3l
 zVtxnOB8Hdrg2nrdDjVUQfWxCJR9MGKibyf+P3qhT6pWSNJn1A6HDwztTZVYjiOhg5+/Hdc4WsbrU
 HZaU6db3Qca3fmX2bU2Zii1yuajuc1wCrUf+Q2R2m86gCxTwZuUXDRaY8GMbEo7dhMc+L1DQYjJVp
 pF+BYW2fEjWLmTG1UjAOzQieM7L8bnTQorZDbW+h69IkJ17bmmMYd/CXRbTaC9dUvEgVeAjXHE+Cp
 dIUT29kvdufK2uIkEBuzrSAd4Gf+I/QisXLpIp801cjNx797E7ZBrebq3m7HhpjGd4Uc1bU+GvNLl
 wiNzdgfw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYlQF-00BuBl-JA
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 08:07:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1560168C4E; Tue, 20 Apr 2021 10:07:49 +0200 (CEST)
Date: Tue, 20 Apr 2021 10:07:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hou Pu <houpu.main@gmail.com>
Cc: sagi@grimberg.me, hch@lst.de, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: avoid queuing keep-alive timer if it is disabled
Message-ID: <20210420080748.GA22035@lst.de>
References: <20210416024521.19661-1-houpu.main@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416024521.19661-1-houpu.main@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_010751_793052_FBA5377E 
X-CRM114-Status: UNSURE (   7.95  )
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
