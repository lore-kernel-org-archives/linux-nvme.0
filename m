Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66AECDB483
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnekdBLvdBZ3/BD0lTuUjyIhhw4YnWgK3yI8P0+hlBc=; b=MAYRYv7rsy5OT4pQ53xcZENcf3
	S9KXHGDKjMSIPzqJzukq0G6vdR8SLRG43JUX6zhJfYxYu/wWRFhqUi0BlTtgxj3aXBXRjCjlunQkI
	XEFpma4QFCG/icYnMgqqTicfdssH6XKnXLg6lHiYXdpBiYssj40+9j4ZUmsCA82GGKyd9gs7iS5qC
	SDoVrdce+16gynorJ0wOiiT8sFwOs+VWQmSZMSd8Cxgy7MsxZcb/56kgA3VqepdFKL4px21nXleQu
	ouVrXIjXqraj+2uW+KLRS9wcQoPSuXyQ8tTiv2JMovkPjx9RGrWil9C6GIy9yObme5NZe6tV9ZzMp
	l9WR0J6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsqfm-00DCSf-2W;
	Tue, 17 Oct 2023 20:28:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsqfi-00DCQr-2I
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 20:28:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 03FF0CE20E8;
	Tue, 17 Oct 2023 20:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3867C433C7;
	Tue, 17 Oct 2023 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697574486;
	bh=DnekdBLvdBZ3/BD0lTuUjyIhhw4YnWgK3yI8P0+hlBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Go4zkLBrn4oUzaC3J+jxXiiFFz7hXXSrzo2EuKcknHkHncHb9bK4mJi7qdAfcaVyR
	 VvmrG2nD1greb2DKA5ove1jpQNwLZScvLaFj+12UC/86mWiZe2or9838J5mxcOBIQs
	 r7i5ypkK2i4DAeve/kOOxLjgInkfkQidPao7aV1yDuBEaXG81imy7HXbWxCviLgRml
	 FEV7bXgh+dA3Mx4pd1xK9YOOeRt0mDwWD+pj5ByjOIGxq6bAjHUDxGFntd82QvThY8
	 fSBTvEAYVDa1AHye5/4gabUkxz6iOwnyQZoNsLD68cJRKyDQCExYkkdk8paIqadr5Y
	 cuXtKQYrGTbQQ==
Date: Tue, 17 Oct 2023 14:28:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH v5 0/3] Remove secret-size restrictions for hashes
Message-ID: <ZS7uU9GFtFSKIeJ-@kbusch-mbp>
References: <20231017170919.30358-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017170919.30358-1-shiftee@posteo.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_132810_952177_5132BA93 
X-CRM114-Status: UNSURE (   4.93  )
X-CRM114-Notice: Please train this message.
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

Queued up for nvme-6.7, thanks!

