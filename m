Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBC4C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:47:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114AE613C6
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114AE613C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=ITqCrdJM/F5kAjo3WdgiKo5s0
	J2wj1jezSged2rrEcBd80LrIhwapo4m5SmUEO03P13WYUJEQbpqcQXTuXHZuUaFjqPhWM9NLifs1H
	YS249avJXL7ssKZCyfSFOIbChkyhL4RL7BGA/4Ja0y1vO9V3pF3Yinj9fYWrV0pR85r2Uk+GT+Y8Z
	c11iKTzf4aWlnTA6fNv5CyrgPxt86gn2r84FBTWAm/h3fevBKiW1r7qfKm/bv3xCw6RSfBXpLyGlp
	DRGkxFXs8lztL/Wba901sST5afK8UROT8u19iHvNZMuQonqRRLS2uTF5luZ5zmIyynyVgjNOYJotc
	8ufdC7Rfg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVXD-000o4K-39; Tue, 11 May 2021 16:47:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVLB-000lJ1-PB
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:34:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=SjTk66r0HYYc6U56ExEvrnpovt
 fIgDR+9sF6rtahNi3vxsObjQErGh/Bj4aMMFmULMOgwv4Cykf1q+usLeVCyJEYgGqqO3gD//xiDZe
 FzZ4S4Z9ngy0Z87GkpKml8IvqAbS3mYtM5u1B6/3VG02uLUQ8USCR0mHKhMOlqVMEi8uGDsT7+xT7
 uq5DAsOEAcF6qOjSYdm/Pe1Q0LhqU7UDVIv8vq8vClzSCZAp0tNSGE9xlWWBIwqw2B8a9ejw6ZZ6A
 b1Pkqbl7VnY04pWjkgRugr8/WBQ8eL+efoFrk8BrWZ9sEEMuFH9zctfQ6GeKj5bHU67TsWracPrf0
 3HmojA9w==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVL8-009ln8-72
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:34:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C001567373; Tue, 11 May 2021 18:34:31 +0200 (CEST)
Date: Tue, 11 May 2021 18:34:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V2 0/3] nvemt: demote high frequency err msg to debug
Message-ID: <20210511163431.GA18815@lst.de>
References: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_093434_421121_80A12B72 
X-CRM114-Status: UNSURE (   7.33  )
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
