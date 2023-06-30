Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574A5EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zEFM5xqx6amIWw9nh2uvuGvvkz/Ljuz0miNcvZNAHdk=; b=CngCOXX0YMcb+2QjEQjL1I0w+l
	p/x7MendaooU1hcFLpAWJ71n8B9nWrX85aIO8PIkTHPRtwiJP2DRPqBhf0PpSouTYr7wGPbczb7bp
	W55r26tOODS4wEe3o33iQRly9bNYzb1/BsZt47u3NCMwafoAm5y8ueVWcQHD/gX+pd1frQsj52vcl
	qGYHEQe05khnGPy3OmIpR+4m2ZWeMc16hpMoyK2ern22PiHp9VzmwmuUM6yomUJbTlbJDyTgKuJXX
	vxe7+Mivpi+p0kH1xbwBqLOYueaMnmfos+lZt4FaokQWHLw7HenwfYrnG6YLasgODlUS0LJX6pHOa
	bNrfxD8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFFvT-003wCD-14;
	Fri, 30 Jun 2023 15:20:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFFvQ-003wBY-1k
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 15:20:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D071161774;
	Fri, 30 Jun 2023 15:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47728C433C0;
	Fri, 30 Jun 2023 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688138443;
	bh=ZluSqUFslLafiJuTcIEoLmWmA+UPQOYibxPoks+UiHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwm5aDBsvF+6RUs4wr6ONC+6dO9Jq6u45mZJK0cLrsc/7SqJbe0wceTjXyE/3R//e
	 b0bMNzr1AIesT5zSch6HtYLgsgKyiHElRhaAFooUcz/oLuOMQFMnD5KbKFMTYfhzaL
	 pz/KsX7OMhnExnK/fuoW93XqYxHG088pZiHvouWdt3uLEy22SsnOX1N8u85+gcX6Zw
	 M4jDZJ3CeK3W/93l0rU+V2iw6MlNv55aBE3fQvw7lsrdztyf7Undbh+oorPW+/PCK1
	 0kKjSo+2wPr5KWREbkSe1vOGJjxCjLqruld1vk49JRi0HD/twYGDfWQ4UP3rNSv8mD
	 31xcBURdrsGQQ==
Date: Fri, 30 Jun 2023 09:20:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Aurelien Aptel <aaptel@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH net] nvme-tcp: Fix comma-related oops
Message-ID: <ZJ7yyEiUWBTf8cCp@kbusch-mbp.dhcp.thefacebook.com>
References: <59062.1688075273@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59062.1688075273@warthog.procyon.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_082044_617449_C90D8612 
X-CRM114-Status: GOOD (  13.72  )
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

On Thu, Jun 29, 2023 at 10:47:53PM +0100, David Howells wrote:
> Fix a comma that should be a semicolon.  The comma is at the end of an
> if-body and thus makes the statement after (a bvec_set_page()) conditional
> too, resulting in an oops because we didn't fill out the bio_vec[]:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000008
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     ...
>     Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>     RIP: 0010:skb_splice_from_iter+0xf1/0x370
>     ...
>     Call Trace:
>      tcp_sendmsg_locked+0x3a6/0xdd0
>      tcp_sendmsg+0x31/0x50
>      inet_sendmsg+0x47/0x80
>      sock_sendmsg+0x99/0xb0
>      nvme_tcp_try_send_data+0x149/0x490 [nvme_tcp]
>      nvme_tcp_try_send+0x1b7/0x300 [nvme_tcp]
>      nvme_tcp_io_work+0x40/0xc0 [nvme_tcp]
>      process_one_work+0x21c/0x430
>      worker_thread+0x54/0x3e0
>      kthread+0xf8/0x130
> 
> Fixes: 7769887817c3 ("nvme-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage")

We don't have this breaking commit in the nvme tree just yet, so feel
free to take the fix through net if this can't wait for the next nvme
rebase (we're based on the block tree).

