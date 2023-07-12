Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C518EEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LopUFhhb9toXWOu0gdA3ljXayDvugPxlg9NY12mJyuk=; b=ivLOFk3xjq5seQ2fcwS0g7bWnS
	9gyamCFs5sg5z2X/lyn5hVQvqTlR9msYL5lgAdacP9yAXkLahBjNzArfXzd5lUTRZMSUNCp+0wDpv
	EXuSa+IiO4+MCceRDE17la3ca/lJeB/MpvOOmwfQdHC8DZyimx/+68Hz7xkl21MnVCjX6u8wlREzj
	UiaP8JAzBIrAn20tUHfDZuJgkVBNqFgNXbqeqwoTpBVqAzk4SPZux8/0KzdzvtEwDQhunGR/k9vl8
	XVxjdUMIuHdZwE6FDldfz8KSG/IZhWcKB5uVu5fDO8GkerxV6boJxnPoWxqpnVDjkgevkz4COSQZE
	sphSHDuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJccX-000ZNs-14;
	Wed, 12 Jul 2023 16:23:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJccU-000ZN1-0H
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:23:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52FEC67373; Wed, 12 Jul 2023 18:23:10 +0200 (CEST)
Date: Wed, 12 Jul 2023 18:23:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: don't unconditionally set
 max_discard_sectors in blk_queue_max_discard_sectors
Message-ID: <20230712162310.GA29557@lst.de>
References: <20230707094616.108430-1-hch@lst.de> <20230707094616.108430-2-hch@lst.de> <ZKvgnI5qZ/Z70ycL@ovpn-8-33.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKvgnI5qZ/Z70ycL@ovpn-8-33.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_092314_267885_770A9E29 
X-CRM114-Status: GOOD (  14.19  )
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

On Mon, Jul 10, 2023 at 06:42:36PM +0800, Ming Lei wrote:
> Userspace may write 0 to discard_max_bytes, and this patch still can
> override user setting.

True.  Maybe the right thing is to have a user_limit field, and just
looks at the min of that and the hw limit everywhere.  These hardware
vs user limits are a pain, and we'll probably need some proper
infrastructure for them :P


