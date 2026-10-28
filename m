Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E8606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=i7CN9UZ1EniID2srh8hMoXqIRVDTaOl+lNyxN0JseSw=; b=2l5BPT2evwMAGbGd8rEhbeg1UL
	tn8HFH4Mt6fR2V5NOLv/XSGpaWiooGZNn7sm0o+Tdq/aG6mpRhoUaErIBZsCX5p8dzjagBq0BxwJQ
	45hOeqJbjyPGbYFvn4DW2t1pmNFr9qqO0ubvXIbKwjH25aweAuRU89kKUqQqRkAGZnGXASaj4Efrk
	rZtyV3KzI4fQjNWmg8tSsFDQJ8rsLyg0oQT3f3qKsdilP4K6Kz2xbUXpr8VYDDm9SJu3ktJni4dmx
	PSy79ZYKYgsbpO1tEBsaSNzXQ+FHF2bOTQ5s/IixrPbioS6gnDuRYXVwv32bdEqiTDz0Ra4EpLWvv
	G7BYx26w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5h5-00000007Pab-1Jz9;
	Wed, 28 Oct 2026 15:36:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5h2-00000007PZn-2rmj
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:36:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A95D768AFE; Wed, 28 Oct 2026 16:35:55 +0100 (CET)
Date: Wed, 28 Oct 2026 16:35:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: wait for in-flight TLS handshake callback
Message-ID: <20261028153555.GA18772@lst.de>
References: <20261022071934.3818224-1-thnkslprpt@gmail.com> <20261028145743.GB15112@lst.de> <CAKOB7-a3r_YBz+i2zyRvu+3GvzeOpvZtHY0r0Fzs5O3mKj25EQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOB7-a3r_YBz+i2zyRvu+3GvzeOpvZtHY0r0Fzs5O3mKj25EQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_083600_936678_C393D2EB 
X-CRM114-Status: GOOD (  11.25  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 05:27:44PM +0200, Avi Weiss wrote:
> It seems relatively independent (and pre-existing) no?
> I could address it but I think it's also fine as a separate (future) patch.

Ok, fine with me if done separately.


