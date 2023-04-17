Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F1FC77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 20:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UGJUV+QOJ9TwngCZrRoaUhKy9sIkvhZVqVYZmUuossM=; b=vINEE7ZOxRWZsDfv407icsjNSx
	IRpoCVMRuG4065SsqfvvO0WPxkeXgZlP7wwPWNHIPsBE8hps0BIj8LHkyNhISMKOCM+KlZcs4HVDd
	wQXF2rKeRibOxLcS+Bt1FEu6ebmU6h9qPN/OAjhNVSSF6Yusun6U5l9plwJyL54PQnd+8iVaWtodq
	OFXgv2fzqW+IvP4YbInmT7A52rLDykrT2tmnFfQDugOZkviYkVPMW6eQaP+WFxMB+uwtcWZtuJW96
	L09K7t2TwYHLJWSDYuD5FUvK8l1NKbFB8/ictSmL/m3Nlt4kAG9SrtT3VfDHrKriJodbSR//QT3Yc
	qoo1EtLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poVHY-00HVJr-1K;
	Mon, 17 Apr 2023 20:17:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVHV-00HVJH-0b
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 20:16:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B766762011;
	Mon, 17 Apr 2023 20:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E572FC433D2;
	Mon, 17 Apr 2023 20:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681762616;
	bh=s0ENJSbqd0VO5HWeTuoTR97eEANi+iV3zsBdnSFglT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HK9eSq/rwqHruAKjXNBMFfnHcCy8VywdD896bb5D0wRYKf2GtkPM2zndiBUNMnApI
	 TUqP+JB3wzWelqzCKTpM5rdZRbVCPNlj8wNzMjEpGzNK9oB/Y9JwXdBetsBy6jVa2p
	 l1KZkobzHrjQQ2RXQiadDij2IAVuQkEppm9zuYzH7nNr/1OMpxxEPQbbMXyUBYWGEn
	 IDPyPTDknKkDIkwB3kSHQ7/vOTQqsCSsL827HTbzYGMPBWhRKDpG12/t/1l7yENuzM
	 rSGLK/mgC/BTuOkjMN96IiNBIBUCJOHq2tCccu6lppYxhXRjkly/VMyAIYKJKFNsMu
	 PaVCSjIjcmoHQ==
Date: Mon, 17 Apr 2023 13:16:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Chuck Lever
 <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH 08/18] nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
Message-ID: <20230417131654.427ebd6a@kernel.org>
In-Reply-To: <5df08f86-2599-6e47-2fdc-bda8d70edaf2@grimberg.me>
References: <20230417130302.86274-1-hare@suse.de>
	<20230417130302.86274-9-hare@suse.de>
	<36976756-b4c5-f2a5-34b8-e9731a49c477@grimberg.me>
	<654702da-246a-934c-14e4-7b179c46ed98@suse.de>
	<5df08f86-2599-6e47-2fdc-bda8d70edaf2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_131657_258303_729A8021 
X-CRM114-Status: GOOD (  17.33  )
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

On Mon, 17 Apr 2023 18:28:12 +0300 Sagi Grimberg wrote:
> > But then we're running afoul with tls_sw_do_sendpage(), which uses 
> > MSG_SENDPAGE_NOTLAST as a record indicator. Forwarding 
> > MSG_SENDPAGE_NOTLAST to tls results in incorrect TLS records on the wire 
> > and a transmission stall.
> > 
> > Took me days to figure that out.
> > 
> > If you have a better idea, I'm all ears.  
> 
> So sendfile is unsupported over kTLS? Or is there some special
> case for it in the upper layer?
> 
> Jakub?

First I hear of it. 10 sec look at the code doesn't indicate that 
the author missed this case completely either.

Hannes, any more details on what's going wrong?

What incorrect TLS record have you seen? What's the sequence of sends?
Offload or no offload? Easy to repro or stars need to (mis)align?

