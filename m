Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE52C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=utqgg/7GI2/uRGIW7KZJsKy1Rcrpo9pdQP6I1C8Ng30=; b=i6GpSJQI1yyWK3DhLVdQiniGGB
	QxMpRUuBpBqx/6PMRZZnJRoWjlWjXtGjFqWHbLAxuw6yOpyxnD0QGN93XvQA0ViBMhkUSPvbHCs2T
	nPevLUor6AiQd52uYdVeKLkpvUJ1e4bar8UQKvwYEl0qSzHh9iKXNDQUq61dXofWBu4aV7eNhU7Hg
	X4SUynUHqKhMHccQzRoHs9e0UrbG19t3PBX7Blwgy42UF30XgZJwq1lXvTqmysZYLK6OMlgAaSrj+
	w7Kmm3pzV5BoP3D21pN+8r8ZQWZpHTxw8faUt5Qe/eJNx2QGn2Qq07X4tSVE9TiXD1NLHHVHPleRN
	ZzGEEVHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBzn-008kZZ-1C;
	Wed, 17 May 2023 07:54:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBzk-008kYj-0f
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:54:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76E4968C4E; Wed, 17 May 2023 09:54:44 +0200 (CEST)
Date: Wed, 17 May 2023 09:54:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 06/17] net/tls: implement ->read_sock()
Message-ID: <20230517075444.GA30685@lst.de>
References: <20230419065714.52076-1-hare@suse.de> <20230419065714.52076-7-hare@suse.de> <da7135cf-c96e-f79f-9d49-87ee269871cf@grimberg.me> <20230509174724.4a198306@kernel.org> <0097e7c0-351a-b922-dd77-ab414b53170b@grimberg.me> <c711fc3b-08c4-6673-0f22-f73bf377a072@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c711fc3b-08c4-6673-0f22-f73bf377a072@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_005448_387906_7B42B862 
X-CRM114-Status: GOOD (  13.64  )
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

On Wed, May 17, 2023 at 09:53:10AM +0200, Hannes Reinecke wrote:
> Problem is the MSG_SPLIC patchset from David Howells; that essentially does 
> away with ->sendpage().
> So I'm not sure how to go from here; wait for the patchset to land, and 
> rebase my patches on top of that, or proactively switch away from 
> ->sendpage() and resubmit directly.

I'd wait for it.  It should make life a lot simpler.

