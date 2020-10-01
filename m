Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8853AC4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 20:51:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8EF20738
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 20:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U3ysmxC4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0HzB2RZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8EF20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wanu9QZENqHwwRRhnq5h+P9YGjlLKjMfPKtAJDsscbk=; b=U3ysmxC4nF3IzWK4XYmnxsdKh
	KmFoaeRgf8QboO/gT4D7wGM1iTSWF1Z4+QBOKVmA01qJBs/iddYx8orWK1h2UG2bdvQaxKEhecMvH
	22HgwbH1klX+bDF0DUNMPmU1x3Skcnmhopfbtd3cZFT2veKG2Fsnq5EJIRhHJoTW0nxcDORUpgMa7
	yjkLXg92+12EpDKuLqMNCxhu7MDtB7Vw9r/740xsMuCS5Cnu6kv8xevyDw64GK+qmSKEDRiKFJTW9
	UOhQRt/epbbsCcLWvxGt1WleprbHOJR2orwh91kvPbPVQukLi+ND5tVOXLVTLTkrlVJKwLj7VItay
	AtCcXQLUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO5YJ-0006J9-GK; Thu, 01 Oct 2020 20:51:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO5YG-0006Im-Hu
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 20:51:45 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB5B3206A4;
 Thu,  1 Oct 2020 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601585503;
 bh=WkcV9F/1ljJti9fq2GZyv7bUVcea+OoH0NudcD/60mw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0HzB2RZMz3A0mGUJp7qKPrWa3lWFeN2jS4LbvgnM+s/OPiE7xktq2DtPRTtU7NsZj
 iK0PsJl/JGN2Q7e+joNlPp1tJNwyNvn1Aa9nQgQw0VHP5bQq+OM9IfDtbqLBJ9fV1D
 3g4NEP5ti+7PoUi7U2LULaACQp6toHoEWP16efHA=
Date: Thu, 1 Oct 2020 13:51:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 2/2] nvme-core: remove extra condition for vwc
Message-ID: <20201001205140.GA565143@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201001185432.5464-1-chaitanya.kulkarni@wdc.com>
 <20201001185432.5464-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201001185432.5464-3-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_165144_667046_5131B79B 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 01, 2020 at 11:54:32AM -0700, Chaitanya Kulkarni wrote:
> In nvme_set_queue_limits() we initialize vwc to false and later add
> a condition to set vwc true. The value of the vwc can be declare
> initialized which makes all the blk_queue_XXX() calls uniform.

Looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
