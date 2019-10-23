Return-Path: <SRS0=6M3L=YQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC2CA9EA0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 01:18:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430AF20679
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 01:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iq+BlYyW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUoKG6JL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430AF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oh99xhCa8wRxA+ZSuWzVNS1maFCfNELGJbPTDMRpi3k=; b=Iq+BlYyWkFxXey
	BxGSczfYLCaSkd5MR5OsMSOBR2g6xPosXcj04HIstbPx/zyBj9LO5cRZqeEp57oQOZVQmpNVJmcZC
	5qySA+YtAfEuA9VUr1ZEJWFjdDgzVg0CrKocBM6IYjCxkJIhTRRpqr/wvn3TzIh2/UI9nbyKTo/ce
	Tqd1frFlthf7Fy4plssxN6c2nay/72Bhuog3qFFt88YbkmvI7Ykvyc3uKFekRDQnwXsgl1i2+vsqU
	hF+D88YnQAcGWfSjxEmBa5WdwHZKoOoteRyFbPgdCrcMu9smPIdNsY/ud/8zFw7GawpCnQxvYzW8i
	8WGJl6lmqfZSA5frqnYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iN5I9-0004ZX-3D; Wed, 23 Oct 2019 01:18:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN5I6-0004Z7-Dd
 for linux-nvme@lists.infradead.org; Wed, 23 Oct 2019 01:18:23 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7659A20679;
 Wed, 23 Oct 2019 01:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571793501;
 bh=Bw0/TnI87+PCX28Mqjm+a+pamH85slRig8ez/oJLqHk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tUoKG6JLiMBpyUThnswyrzp0gZGqrvxX7LZdeyGM21roJzlZDzqEQ+4QSf8ujbRvS
 lZGpsmb5Ui07UVje0TZI9DV4+xSVqckZh+KtnP4mcAn8JDjol/xgx0okFyJMF4UjEv
 fMHwNPJduk/+cJg+wPZRYUIwNM5ldH58W84hBZIs=
Date: Wed, 23 Oct 2019 10:18:14 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/2] nvme-multipath: fix possible io hang after ctrl
 reconnect
Message-ID: <20191023011814.GA15012@redsun51.ssa.fujisawa.hgst.com>
References: <20191018091016.GA25478@lst.de>
 <20191018183251.501-1-anton@lightbitslabs.com>
 <7180cfee-d1d0-6dda-1bae-53235dc49a05@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7180cfee-d1d0-6dda-1bae-53235dc49a05@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191022_181822_485435_F7DCC622 
X-CRM114-Status: UNSURE (   7.85  )
X-CRM114-Notice: Please train this message.
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
Cc: keith.busch@intel.com, Anton Eidelman <anton@lightbitslabs.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, hare@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 22, 2019 at 12:48:35PM -0700, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Keith can you apply these to nvme-5.4-rc?

Yep, applied to nvme-5.4. Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
