Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA88CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rt78FZAYKe0gz/4zfRjF4IigBBCZLzvejiqCOF4t7eo=; b=mkB/uKKanmLqKIf65bFpiBmVtM
	d01oezaAkw0hUkHZr6oRn4/2KRLgbPS9/sBbymdrq7CK7J3DeOQ6MwJNx7XQupLF2JqUz+C292uL6
	WQfnilW1vWLk2/ZlA3xQwznEOPEy77Ua8GESTEjGKwVa0TavJiQxM89WIu90QdwHMPZzJ0jOn6hwJ
	adS48gVcHfNnfAxHuCSXHBu1YZpik7l14s30xJtDeujtWnZEBtUYwYUFbMh2QHC5SSNcnAvxJtG3l
	u6ignYEN4IuY9CLXwtn1jzqQkYACZGU8vwhCUPJTHiBejxSbBhy5toGnz1qvyDsLgiNyvwd1ZPHoi
	zHRAZ61g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLoc-0000000CjVe-3Z1v;
	Mon, 11 May 2026 08:16:38 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLob-0000000CjVL-2MDJ;
	Mon, 11 May 2026 08:16:37 +0000
Date: Mon, 11 May 2026 01:16:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: AlanCui4080 <me@alancui.cc>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make providing NGUID as UUID usage less scary
Message-ID: <agGQZU4NwAgSzHLD@infradead.org>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
 <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
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

[the patch seem to be missing some maintainer Ccs]

On Mon, May 11, 2026 at 01:19:59AM +0300, Sagi Grimberg wrote:
> TBH, I'm not sure why should this be a warning or an info log. This looks
> like a debug print to me.

It is worse.  For some reason the commit seems to imply the uuid
replaces the nguid and they can be intermixed.

We really need separate sysfs files for the different ids.  I gues we
need to keep the existing one someone, but it is a mess.


