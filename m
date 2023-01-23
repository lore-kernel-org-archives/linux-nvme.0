Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8E1C38142
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+GBBApPkBjcIhIVa1Z8f2DT2ZYB6qemtQzNrNSba9/U=; b=C73aMCinHYSFGrG8K2OZNBcK5e
	H9q/zY+0Z9+HffXQQsXFPoMqlR67IPA31JQFc6A9Jynn3FHyjMaHKUwENaNbWCna5LKuhNQdm8PoG
	dKXCJWU5fi01/BwPgDhUNj9QgnIRxQSqcymd5+WfmPUAmOXpF6EXil6R8U5ITAz6VecqGDj8440ma
	Xzp99YOm0hVCioEtMrGzTCZ/SlN3jpEM7F8yjGeEYlIfI/i74y2OAksTlWtIfhM6GA1a53sI+M/DG
	+Ba0C07doxItvbhCPMroa4gc50R8ihg7bD7OLupb2r000tR7mmJbpRp4PZymoITln3ZIcils7MCru
	jTjtjDTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK03W-000hjE-Mn; Mon, 23 Jan 2023 16:52:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzys-000fea-Qt
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 16:47:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5697760FB1;
	Mon, 23 Jan 2023 16:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5620FC433D2;
	Mon, 23 Jan 2023 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674492457;
	bh=+GBBApPkBjcIhIVa1Z8f2DT2ZYB6qemtQzNrNSba9/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejCwvY8xfDJzGWUUb/EhNIDZGb+DdUZ137zTATokcFRsaG9j33FN5j5CvW90YC6jr
	 +rrExffIcNDbTaKFT05C240RvHu4GdGSh617vWh3y9b3YPFVSF9Ky8RKovjkFWxLIf
	 86eIxI8YIMjzgzr/cFLFdgSMJvUO6WcloV6QJKbLFO6jK/becNF8B5yDhjKcuKk50G
	 QdnTocCErB7QjbF3pVh3VU/Jjjv8iJ1lLur9B1kSMTRoUr2D+sVh1wgPul65/RQ3Rr
	 LT1UriEadJUoKi8nSK7WnylfABEDxVs4FWxmMPkqTiy5LYmlH+YOm1BsIGwZxCAnyW
	 K32VHWs9M7QIA==
Date: Mon, 23 Jan 2023 09:47:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: mask CSE effects for security receive
Message-ID: <Y866Jr8v7aw6rBEC@kbusch-mbp.dhcp.thefacebook.com>
References: <20230120171731.652371-1-kbusch@meta.com>
 <20230123164118.GA8398@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123164118.GA8398@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_084738_956104_2E382751 
X-CRM114-Status: GOOD (  12.15  )
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

On Mon, Jan 23, 2023 at 05:41:18PM +0100, Christoph Hellwig wrote:
> As-is this only applies to nvme-6.3, is that intended?

Yeah, it also has a dependency on my other pending patch that always
allocates the log page, which isn't in 6.3 yet (I have to send a new
version of that, anyway).

I can backport if desired for 6.2, but I don't think this is urgent
enough to get in right away.

