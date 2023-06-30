Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79E8EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YY8/bCzFCPE57qh5AkwPDAgLNjakHgRTdvWZmqV57VA=; b=tMtX+/f/PwLMw0uVuVigDQu6kI
	3Mfe5gOyaSngjCwS37MRtPi+/OWXDIP42y9zcaLrtLzfKh1TPD94CbEB/sNEaNhaoZQjCo5qgdFHD
	UzGt/0/ManQulgEXb6npXr9tDwcPAj00coCsv6r4jLa76s35g9AWY82eDJ7QZvkf0yyjk5KBfFJC1
	Mv/GAiG9u6Jug9xU1lIsnLctiU9iPsnogmhT8/uBPrT/AuH4W1QoLNj4h8iqmxEEFWD8Z+MlXeuZb
	dTtCtoXUp3jIvblPc1dfI2GSdXXLR7rqik3nUirNpQF9HVD6yPS/AsCiwhC9dPO2lRahfhzkfWFnP
	iiHWYovg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFG7t-003xbl-0G;
	Fri, 30 Jun 2023 15:33:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFG7p-003xaw-2z
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 15:33:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 415C961768;
	Fri, 30 Jun 2023 15:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B676C433C0;
	Fri, 30 Jun 2023 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688139212;
	bh=YY8/bCzFCPE57qh5AkwPDAgLNjakHgRTdvWZmqV57VA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N0pfFcCIgh98mjmTeDC+Ct7EH9/QWz0a+kmyDggfq2pot8qPAmQzP5NFMihIKxdZW
	 BWzVVCfZV9n0+Q8FueNNWgczPYTwZ01TrAKswY9PeEXrHy86UfpKgv+doXgRNLJMzS
	 oqPyBCbUATh78OKXk79CksnzhR0BSYGaypf+VqPlFARQdcv1c8JGGUhXmwWTzSz11+
	 unx+4qBkRBDfRHwUr8WOvI+BgUwEr7rJlwKU0Bk0mDCmYmwXKL14f/82GbSGaBjiKO
	 1n7OYVkddAp0S1B8L4B2rRNKbE97MUDTMtofMLeF6Sh7OuldwkNuIWRNyLel4rvpUe
	 eIK6zxP3sXBvQ==
Date: Fri, 30 Jun 2023 08:33:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, Aurelien
 Aptel <aaptel@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Willem de
 Bruijn <willemb@google.com>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>, Matthew Wilcox
 <willy@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net] nvme-tcp: Fix comma-related oops
Message-ID: <20230630083331.6e1527bd@kernel.org>
In-Reply-To: <ZJ7yyEiUWBTf8cCp@kbusch-mbp.dhcp.thefacebook.com>
References: <59062.1688075273@warthog.procyon.org.uk>
	<ZJ7yyEiUWBTf8cCp@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_083334_026569_E53E3C3F 
X-CRM114-Status: GOOD (  10.21  )
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

On Fri, 30 Jun 2023 09:20:40 -0600 Keith Busch wrote:
> We don't have this breaking commit in the nvme tree just yet, so feel
> free to take the fix through net if this can't wait for the next nvme
> rebase (we're based on the block tree).

Ack, will do, thanks! We'll most likely send it in a PR later today.

