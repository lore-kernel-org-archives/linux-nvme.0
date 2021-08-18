Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72DC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:44:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C01A61042
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C01A61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=98L5h+xxApQysDCmtfI2ixjD9cuIbLIuEuCLxbFCBNU=; b=NeMITaFa/6YUmq
	J2+3M2SjdsevDCt5tcxS7BxxJvJp9jWsQeO3TxEcihwwN37HhweUIQm6ESXzsS3U7fiBhQMQ6dn3I
	FdDiyBNIsyAt/oFVvyBxdCxV296M6JwSIT2L/sQ10cJpbKDIA6Fgozi28YffRfvw9KqACmMisShiK
	W+B6M1Np4lQ3amnekUM8eIZSf6YMRfDotEhIQ75qdUb3lhEVRI0YpJm98mGqicHU0KZhhVOXioSAo
	cpxpcCjesSqiT0qkzIUitN+lQiSKqA8xolt7mD8OzUAFIvwR2K6rlpB+16ckWT3ntzPmq96ia+iSW
	sI4ln3xMZ/TR/EryF2pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGKvv-005Yhe-SK; Wed, 18 Aug 2021 12:44:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGKvp-005Ydv-8u
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 12:44:37 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C4D622065;
 Wed, 18 Aug 2021 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629290670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ydc0Xa0Qi2UmrhOCGiJvOEbT86AEUgdj8LlPA7LoqJU=;
 b=eWAdmWw5jyv14jB+gl+nZWJwCeSVxadiuFxA5NaLm9oZaUQKbCwBUr8b3lDOkQ+C/Qisv+
 gywzhArkgpVZEjDzow9KqO+ymMQj7z5z0cC7QMdTvUcqTT8xE44+lWEnffCW4WGDrxmS0y
 PvVEyBxMPFgIUjBTjKXhF4Lv6v5gsmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629290670;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ydc0Xa0Qi2UmrhOCGiJvOEbT86AEUgdj8LlPA7LoqJU=;
 b=xt2xX7LIubnglerRkfdkNvxAX6YqOS2uKdAEQLdkw/MB/7G2asxbJHeyO3mKAmV7y6YW67
 g5yRqXio/igYlHAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6B5ED1371C;
 Wed, 18 Aug 2021 12:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id nFTtGa4AHWGIUwAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 12:44:30 +0000
Date: Wed, 18 Aug 2021 14:44:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, yi.he@emc.com
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210818124430.hokmfa25lnhxnswu@carbon.lan>
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
 <20210809090947.luoqaooi7gc6u6yu@carbon>
 <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
 <20210811103146.ytqj5mqpioiba56x@carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210811103146.ytqj5mqpioiba56x@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_054433_499884_581D0308 
X-CRM114-Status: GOOD (  11.12  )
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

On Wed, Aug 11, 2021 at 12:31:46PM +0200, Daniel Wagner wrote:
> > It is the correct place, lets see that it doesn't increase the struct.
> 
> It should not according pahole:

Anything I need to do to get this patch accepted?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
