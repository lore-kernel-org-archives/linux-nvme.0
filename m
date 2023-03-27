Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68602C76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3apNoQTqmZir6DDMrTsJ4c0Q/YxApGcuA80g6I+Whw=; b=CzgD669XnuNYpPHnzDu7kc2n9c
	NGK6CVi9JDm5+SwoZ1Q6HA7A/0mtul+zuP69k6XgXxP/BL7W6qvg9PoHOY6Smq9BZ7GA7usXWups0
	HBvVqE7j7gJbLpbAS3DXxlTJd+cB/5UB+fvE9Ao3nnPV3SNvBNywbRk0p9qoM9mvW0ZUdBFetGnYo
	bJnJSDw3WEP1vLreohGOwD0dKTamtvmUXxAl473j4i0piOXJf1qgD7cLbfGRNEYbiE/W8vUv7v6d1
	pkrvdqkHc+Z65swx3eC/BRRNsQaIYGFdvsXJjdwA+VuHihRL2Dguaqkny7chw46hYmPgMJVGQ0lRX
	SkV0h7zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgonM-00BWb6-17;
	Mon, 27 Mar 2023 15:30:04 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgonJ-00BWYr-2S
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 15:30:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 17FC6B815FC;
	Mon, 27 Mar 2023 15:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A85BC433D2;
	Mon, 27 Mar 2023 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679930996;
	bh=Xgtuhef4jyW2cgWrSnfZWnXDNN/zG9DkTw9F06RZcJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAyJJC5zXCo43xGgrJmkH+9sAYCguC/EtXKclwU0CerLyucQYI37wM37/HlRVV0/B
	 mvSwjsBWrsC0HKY6XePoaIjUOREhY3BCO0uBKVtqFmSsYkJXdrxYF6oUstRc/COKqB
	 ODux3ROTJHXhF16lWj51qMbL7tTXi/ZfpKiBBixu+wJBIgVcD5auDU2fmx8p0gHsei
	 w5Mhl5/XgoubdIYEoDU6aFQzBJzF7Htd2R8Iljkw75hRuzS19MvqZghhWQwRK26ASX
	 HlXoJBipwTP1D6o77rDydfDBHQ3Zjha+sd/qnMf7HGgV4lCek3jE9mH8XWMISyNMyj
	 ogPfS0BwqLdmA==
Date: Mon, 27 Mar 2023 09:29:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <ZCG2b85hN+pTm/VZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <55f9c095-32c2-648d-7ac9-84c1d9224abb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f9c095-32c2-648d-7ac9-84c1d9224abb@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_083001_953531_FA1E1B00 
X-CRM114-Status: GOOD (  11.51  )
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

On Sun, Mar 26, 2023 at 04:01:46PM +0300, Sagi Grimberg wrote:
> On 3/25/23 00:28, Keith Busch wrote:
> > +	if (blk_rq_is_poll(req))
> > +		WRITE_ONCE(ioucmd->cookie, req);
> 
> Why aren't we always setting the cookie to point at the req?

As in unconditionally set the cookie even for non-polled requests? We need to
see that the cookie is NULL to prevent polling interrupt queues when an
io_uring polled command is dispatched to a device without polled hctx's.

