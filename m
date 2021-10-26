Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CCBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 08:43:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E13E60F24
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 08:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E13E60F24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9BeYcdDc/ss6JA62gbqAZ/iwjw7MIG52654lSf8Bf8=; b=WRH/jfFnPqFJFg2Y/r/HuY46kq
	F5yTkF2e7RfNvrCO8KLZvaQTq5SsFuBlXaASbxA5Fd5ps2DnKKXROpoV7o1d+AwiM8e5b79eZco9e
	FHZtSVPla6jZZ5j75BGEusBlWQ7/JmNtuemNnh9oCQLLmY5qGQnU/ZG1k3fWuYBBC2GPBhA9DGXBY
	NOcws2WC/FfSIN2QTyPMqcaspIXOvmYuUdvgjNg4nPtfjlBJF4VQdy6PAolzFuGF0K/3a0yy4efop
	pOPZAF5UfcXd9Etv0CS3syu/3KDF9SQoZdF9iyR34xFdL81TB06kZn0+f/Vl6pc7X0xnHJG9RIkus
	G2E92xRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfI3I-0016b8-4u; Tue, 26 Oct 2021 08:43:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfI3F-0016ZZ-7F
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 08:43:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ED6656732D; Tue, 26 Oct 2021 10:43:10 +0200 (CEST)
Date: Tue, 26 Oct 2021 10:43:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: Fix H2CData PDU send accounting (again)
Message-ID: <20211026084310.GA5270@lst.de>
References: <20211024074331.546635-1-sagi@grimberg.me>
 <20211025143838.GA2335106@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025143838.GA2335106@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_014321_449465_EE599DFA 
X-CRM114-Status: GOOD (  13.51  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 25, 2021 at 07:38:38AM -0700, Keith Busch wrote:
> I'm not sure why you opted to change the name of this variable here, but
> the patch is testing successfully: no observed r2t errors since apply
> this, so I think we're good to go for that regression.

I've dropped the variable rename and applied the patch to nvme-5.15,
thanks.

