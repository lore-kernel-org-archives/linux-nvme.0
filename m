Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67A5C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 16:10:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3628421D7F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NNLDJEmG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwZA9Aww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3628421D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sj+FJkQIerdXZjSU0csguIhDwnROfQSu19DVd2SlmXM=; b=NNLDJEmGOp4qI3Av9JCKHM8z8
	fHPvTi5cZvN/uXuoTmnksvuzhioxLGU/qLpRH+E6qFhMCvd8r452BlLcJGoTC/fDjDMlVz2hED345
	PNLfPNPIa2TLe6H6JH0jrQ7QRghDxkokrABIl6qQ4BH8jNyM0Lt2sMneb3moniF+5xcv5yPbWFbRM
	5YCgGwVl1cJZZqVbjyoqGpn5fR+vR5ABjsScYJcyQ3Bjjblalzt32GMhVZtVT2l5M/vmkxZd9mosj
	KrwVKRd8noCzTd0E1ICTMQvKyiDU+Ea3S6l6JoTxfxHK7EjZfrADQ6paczsDVEHMEVkUzX1+WHZpU
	MVhQsfe5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSjMd-0005MR-8s; Wed, 14 Oct 2020 16:10:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSjMa-0005Lr-8t
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 16:10:53 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E514F206F4;
 Wed, 14 Oct 2020 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602691851;
 bh=XKX2oUmGeNqyheyV0mb5u9TSV9LACj1x1Zo2RhAnypk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BwZA9Aww7+yxdB7jErWtlQgwtkmAuYTtm/hceEiaLKDAt/M21+1rT5wQy9j0N3mq0
 niy9aHcOYfx1vC5P3a61igk+Otz1AN1F5RhmD8mDQVtBTEhYkiGFGUKsYa9qIzoaSH
 l9Co+/SFPxSKA3IXiNjvDc9C0hjXrH0gNxTne3Qo=
Date: Wed, 14 Oct 2020 09:10:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v2] nvmet: fix uninitialized work for zero kato
Message-ID: <20201014161048.GA1267726@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201014033650.953656-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201014033650.953656-1-pizhenwei@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201014_121052_673245_F70A3B41 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 chaitanya.kulkarni@wdc.com, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 14, 2020 at 11:36:50AM +0800, zhenwei pi wrote:
> Fixes:
> Don't run keep alive work with zero kato.

"Fixes" tags need to have a git commit id followed by the commit
subject. I can't find any commit with that subject, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
