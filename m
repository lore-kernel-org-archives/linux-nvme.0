Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CABFC83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XD3WMtFFcZEtLLlgzhG0JYUkydBQtleRzlIeV8Rv+bE=; b=XHjBB+ArIzfh0YpNC9K4uQ1IF/
	boSoc1AutNBvEhR0E1X5nuOdbbcskEToOJFrqfPH71x87jcoygTYdHd3wEpD6AzlfTlVwm6n1ufCq
	zb3SCi0oiFPZ1gDqd5KFCyxwPFuKXGDVD8Zvd/Q2W7TVHrPQvL3FMzQTzZ6/UwSPnd+nDbUvH4Pxw
	W2MGOfLJpM3rTWpzFXFtd5xk05jlWyeROoX7ijPrxTnRcZJeYaXQ4++DUZq8Nkkgq9vVl72b5VyWF
	XS7efaOfwgK57N3Tk4EiaucuCmsGvnQb8lhBZJe2y0/iICO+E2+b2wU6SrmH6tJZOdcSfKlbEwYXH
	FQ5qEkZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udtnO-00000000F8u-47KA;
	Mon, 21 Jul 2025 16:55:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udsh6-000000006aB-2ALi
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 15:44:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753112687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XD3WMtFFcZEtLLlgzhG0JYUkydBQtleRzlIeV8Rv+bE=;
	b=JmndHW73vUzXo0m5e0lHdS+ykx8zb+TqIBnjTT6WlVDWrK4bsMQI6AB4a9ddMzCTXOqQJr
	xQt3GKKDR0e4eW6U2aPsrSY4Iwn3V9HyFoWxKQ2hDY0luW2c5J9Iz5/1I9RyR6jl8ZZq1C
	5adiUBi6wpgO//7YRFIVRTRkUuwBRic=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-zUXBC5TKP-KwdoosA0HouA-1; Mon,
 21 Jul 2025 11:44:41 -0400
X-MC-Unique: zUXBC5TKP-KwdoosA0HouA-1
X-Mimecast-MFC-AGG-ID: zUXBC5TKP-KwdoosA0HouA_1753112680
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8899F1956055;
	Mon, 21 Jul 2025 15:44:40 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.27])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA07B1956094;
	Mon, 21 Jul 2025 15:44:38 +0000 (UTC)
Date: Mon, 21 Jul 2025 08:44:35 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	Prashanth Nayak <prashanth.nayak@netapp.com>,
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/1] NVMe/TLS connection issues to SPDK
Message-ID: <aH5gYzXAIGdsCBsn@cleech-thinkpadt14sgen2i.rmtusor.csb>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <546f62d0-3f1d-4619-a668-d087da5b44fc@suse.de>
MIME-Version: 1.0
In-Reply-To: <546f62d0-3f1d-4619-a668-d087da5b44fc@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ycj1HdwmJvJ-OHoBa-HuYmWwH62IjXZtY74DVqEhg9w_1753112680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_084448_622336_80515F01 
X-CRM114-Status: GOOD (  19.25  )
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

On Mon, Jul 21, 2025 at 09:11:22AM +0200, Hannes Reinecke wrote:
> On 7/21/25 04:17, Chris Leech wrote:
> > ...
> > The NVMe/TCP host driver then quickly fails when SPDK sends a TLS "New
> > Session Ticket" message before ICResp.
> > 
> > While possibly pointless due to the transport specification prohibition
> > on session resumption and 0-RTT data, I don't think this is necessarily
> > wrong and the host driver should be able to safely ignore it and
> > continue.
> > 
> Sigh. The neverending discussion.
> Originally I didn't implement key update for NVMe as neither gnutls nor
> the kernel supported it.
> Turns out that key update was implemented last year for ktls, and gnutls
> has support functions (gnutls_session_key_update()) for this, too.
> So we _could_ start looking into it if nvme wouldn't be using the
> ->read_sock() interface.
> This interface just works on skbs, and as such we can't easily get hold
> on the TLS alert data required for figuring out if a New Session Ticket
> message had been sent.

I think this is a bit different, as it's NewSessionTicket and not
KeyUpdate. NewSessionTicket seems to provide an age-limited PSK for
session resumption, allowing additional connections or re-connections to
bypass an expensive certificate handshake. We're only using retained
PSKs and prohibited from session resumption, so while spdk probably
shouldn't be sending NewSessionTicket it should also safe for the host
to just filter it out of the data stream and never use it.

- Chris


