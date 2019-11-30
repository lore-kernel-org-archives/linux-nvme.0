Return-Path: <SRS0=mcGk=ZW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426CC432C0
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Nov 2019 17:02:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B602082E
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Nov 2019 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DYIKTSUi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErFLvVeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B602082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uMI6iEZ0nKYnjE4m70FHYuZVCgQk/HD6sFRVvtLRd2g=; b=DYIKTSUieHlTzW
	Nj7j1bVIA/5qkvKUnDHHcciFV1GzZgB3msx8oHoSN0G/xuQsJN9RH+2zQqCmKhoxKKklI2QzlcqqX
	qI9+tAMgwj7I1zVWdFA/S/OGfpHxwh9yPpmM4hFVxVxow82NV2OTyX/emaIy4f8OH3BZOgYN2MSxM
	2qwktW7gcmE1ZMLVz5dDIUUV8fdRh10GgizxQlaMoK6BWWyvumn6Xt2fZ65UukWBy0Mh2yvAm9Bvu
	ovY8W4n79rjVU63ZaGFYXqn3kdB0OK/hDNeLGWruul3jfiZg0BVutdUlOgyKMYmu7HzkyNu1JE3iF
	PH27j8sD2zvbQWB+hMUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ib68g-0005ks-UZ; Sat, 30 Nov 2019 17:02:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ib68c-0005kb-9m
 for linux-nvme@lists.infradead.org; Sat, 30 Nov 2019 17:02:32 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 410B82073C;
 Sat, 30 Nov 2019 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575133349;
 bh=4Z03Qq4Ko/UGElYVw5HFhFaBxkzGUvCLQACF5HtJHys=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ErFLvVegdbPkqxODcTwcFbriUOI277vNdhc24MwLNCWjoEEGs77aedpF/GSuFQFax
 eLHYXRa/in+Y4z9GD6EyLfxMbhNn5KQCj4YHp7ap8xWEYPoYBHD6EstRc4r10IZZFn
 k468Vt9azCR9ErzbITGgHcJRMytFbThYQrgSP7NM=
Date: Sun, 1 Dec 2019 02:02:22 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] nvme: Threaded interrupt handling improvements
Message-ID: <20191130170222.GA5273@redsun51.ssa.fujisawa.hgst.com>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191129094640.6fq6wcxmfi4fwnlw@linutronix.de>
 <20191129162719.GA47681@C02WT3WMHTD6.lpcnextlight.net>
 <20191129170545.axnykbrabigzcghs@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191129170545.axnykbrabigzcghs@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191130_090230_366708_3B2A43C5 
X-CRM114-Status: UNSURE (   8.34  )
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
Cc: ming.lei@redhat.com, helgaas@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 29, 2019 at 06:05:45PM +0100, Sebastian Andrzej Siewior wrote:
> Ach okay. But I wouldn't consider it as a "bug" if your threaded handler
> returns IRQ_HANDLED and requires a longer period of time. Thsi seems
> fine to me.
> The SDHCI driver has a case where the interrupt thread waits for another
> interrupt (from its primary handler) in order to make progress.

Yes, that uses a driver specific way to handle that. This patch series
provides nvme specific handling for long running irq threads.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
