Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87853C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:26:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3FC20784
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ST1c3n25";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K/o8X1dH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3FC20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3ESU37WKUH0I95o9TABxL+moB2KW/k0Jd4FuU8yn2L8=; b=ST1c3n25jo6bUU
	6WK7LUFiRzwr+IglK6QS0N11GZkmDgE2SaRwZVg5qOQOjmAoMn/ti/WND07ck7LjMruyeeCKNVVz3
	VdM5U5hzYpga0ffHcScsrjfUsFvdtYsMNsYf/Pq/SFLGSHSnPHj4PFNC77dRaBCeJ2tA7a2qPcxV7
	b7XpkXqJgQc+89Lu3Iq6uVCKZ4YDNZQj/42B8DV85pVyQzB5KdRF6Z5iSH95W8doBjImKt86uov7S
	yJ59d/UCs4B8kkSh0l9Rhz56nOAIoiFZ/2ev4nt8xUkyO5i5jns7SQknrRtdoGGgTl67vlfUB10tu
	sCIiC+FBfwXOzTagLsuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJii-0006cg-S7; Tue, 31 Mar 2020 16:26:32 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJiU-0006P1-Hb
 for linux-nvme@bombadil.infradead.org; Tue, 31 Mar 2020 16:26:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DrUHozoak2kP19jC9oO1omf/F1dOKBn/3zFtaE4eEyE=; b=K/o8X1dHaXPLJm181u2uFh+kcN
 WXy02lYOsiSXJV6gD7j2pOUUj4oC5yPYAc3Fo3GsHsRxt/p5vq+UKw/rtLq/AQlY59ox9Zdvna7fz
 Awco2gicvW3XSPZZcaNlpghk1bqfvR1N3HuTrpKVRHapmzT+i3MrXyTJ0Nszmnl8DUkP/iNfRmPqJ
 15C5rmEMySX/oXuBJ3dr7nlzvV6Nd4ucvBX/OPKEiUfxMzZgYQCUO+Fo7Z2NN/yeCCn9VRLdAK0X2
 BMKh8dn/KvvNrBw/kQigiBK6PzvBRFF+vWlOS1pgCTjolYoblsErxZjmp8F9hNekgW7xObdRK0oE3
 IneIgjxA==;
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJHoP-0003hM-9h
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 14:24:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 822DE68BFE; Tue, 31 Mar 2020 16:24:13 +0200 (CEST)
Date: Tue, 31 Mar 2020 16:24:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/3] nvmet/fcloop fixes
Message-ID: <20200331142413.GA18803@lst.de>
References: <20200306130440.16864-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200306130440.16864-1-hare@suse.de>
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hannes,

are you going to respin this series?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
