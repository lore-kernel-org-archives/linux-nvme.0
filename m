Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB19C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:40:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3882B206FA
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8qT2KjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3882B206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QdK/nr7MPekp5EurZDmASrOBNjhXfX3xvdfTGS5/Prs=; b=G8qT2KjNwIoGeutXDccE9xUI+
	e6jQ3q/m9GmmPyAhxZPamvBlsOwT2R3aJO8yxiIlZAqqiDVqNk2R2UkxBwE2jxTUjkCEmArs7he20
	mG4IuSynVrCUDMd6K2rxymZ9dyaejgy5RmHTo3mGkTVJNSpc1rV3v5SSZNT59HXAvcq5wl4/bYhp2
	Z/+ZbbcfCd66O6rbXv8YliMPU9FNyrIVS2tH8RisZHQLPRYDCdufVe+Lt7Scmqddw2SOwQrFFavWu
	kr4qubIkfR3JwG78m4lvPYeqbe1CfpW0xfIaTlqLAsVh2EghK0dQRcmMcyINkhooGEFl3GZvUe1mr
	9lNh1W4Vw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnz5L-0002Dv-DP; Wed, 24 Jun 2020 06:40:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnz5H-0002Cs-6p
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:40:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9436A68AEF; Wed, 24 Jun 2020 08:40:33 +0200 (CEST)
Date: Wed, 24 Jun 2020 08:40:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 for-5.8-rc 5/6] nvme-multipath: fix bogus request
 queue reference put
Message-ID: <20200624064033.GF17594@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-6-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624001853.5408-6-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks sensible.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
