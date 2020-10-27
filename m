Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B17C388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 09:07:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1B9206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 09:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eu4CaE/4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/ss4O2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1B9206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tVmJpHih2quVJrI90sfe/vidfieqA/mfCyWUEgzl2Ao=; b=eu4CaE/4rB5kMtlo6GoRiY0fW
	A+foTd0qUFUU6P7bLOiGWNWELe5FdITjkCbiHZoKjJlizKBaST50qwuROSBhLxzOwZLevw8Qk1BLA
	aNVKveA04avxwtx347pmeFjd7C/vgHU27xRADTMIrLZObMEBvRpHaA9XupmR+cdCD/aqD8N0jI7wX
	xDsi5JZMvIguc6atfZEkrVR38C9xe5oHgIZQ0prAZL4hjDe8QS0ww7afs/zViHi5EN/xtSIQf0VGq
	NLlaq428totXN9AQ2b7hQVUwvJHqTAkp+mX7dBeJLiQmRE1yDKvEH7dU4rFDPbsISE91F5cgRtUgH
	sioHDb1Nw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXKwn-0007Ly-RP; Tue, 27 Oct 2020 09:07:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXKwm-0007Le-Lt
 for linux-nvme@merlin.infradead.org; Tue, 27 Oct 2020 09:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JCXyOa5uxUpAjzOJP2AX3oeKCJVkWYZ6cJtg6FEK9aA=; b=Z/ss4O2vhTJmuhU1ZeLGT1NAOL
 GrWDDli4l70gjtcPEmS3tSo6a6BEwiNMMwaJuKfewWQFU6Dx6Lr7o1QTjCM0/EJOLvVWsJliXuaXz
 rLSnh4LdzQpRScFwE5k0++uZ5o//Ux4SdY6ek3927FoXbG1LNuW1TgFwUwQhkorX8gQJcOwGpYh4N
 VSmV/idiyYII4e0S5kB4vpmmdRvnZHPI+JJn6V2YBUQh8eTIwm0XL1MHj3Z+6FLTQSEeVfOSSiL4C
 wvxQRFL0AtLt3wTLHbQKg3R+uUtAWPhEl8cBEFSAX0eNUS7Z1AD5fwlbJ7/V2xay2YSw9Pyz8kb7P
 QBSK7k+w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kXKwl-0004Uq-Im; Tue, 27 Oct 2020 09:07:15 +0000
Date: Tue, 27 Oct 2020 09:07:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 0/3] nvme-fc: clean up error recovery implementation
Message-ID: <20201027090715.GB17222@infradead.org>
References: <20201023222752.90621-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201023222752.90621-1-james.smart@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.10.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
