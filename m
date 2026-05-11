Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A0FCD37BE
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jZ5m11CWnORvbvwpr8PwZVYROFjvHy8UmC9udekSGRs=; b=zRIG0wcLi10/risd132yLaDU0E
	j2vZqlGAP1V07uChOWcC/+7yV98Fi8/Y4XO+tQJmpsD/LtZY26T/t8Cl+Egbjp2NxIrPppoHacG4b
	Nm1Czy9O4To33o3hF1+aypLMK7zGivHLAI2HmXokLex29Mv7kur45h1KvRJUGD5RRvF1MQkUjk3ab
	QoEuVngO4nGbZmANtGdlk/rArn4ubjO3WoiA/B8T+PublbR8q3TtcFR28aTV+GZQYJOfnTzH4m7sN
	3CtoZQyUL30Bs59w85GjqewdmE4weCttn0ibc8TBKwVVLnH2EONchl9wHe1E0AktP1dH0EfTZ2kSL
	sfOjvw1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMRwC-0000000Dx1p-2eMJ;
	Mon, 11 May 2026 14:48:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMRwA-0000000Dx1a-0lkS
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 14:48:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 533716001A;
	Mon, 11 May 2026 14:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79AC2BCF7;
	Mon, 11 May 2026 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510929;
	bh=2favqUqgmzwLBSdzdJayZG4j4Xz6KcMDYMEslx1Fc8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muhLyGb+3SwDKYAnar025r0+CATdv6NrMPOoY6WrsY8iCDZjtIGWSY1KkI0khBI2l
	 iGbvD92tDvmzc/NbXqkjD9lFNXvnShqnkqw9ySuprd0UyMpvEwGCY6ybpa/hDX68n2
	 hoS+WKvDDmNVXqW6wRDT0NsZ6h64rxVQbCt3rutj1WucP3cKUSfFTWny3LA0S33ioq
	 rtEN+EYwSj584BMM6tNmfUv+i0VJPfCKyCVJHsbZgDUHFNF3jac+WDXLHDz9AvpXVr
	 3r+6qzrw8lDhdnGAVk+8VT/OjXEHUN5WEzIGoN2ZT3VSo6UvapzLzvI+GEQtMbgjD7
	 MzDyIhxrrZtbg==
Date: Mon, 11 May 2026 08:48:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, AlanCui4080 <me@alancui.cc>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make providing NGUID as UUID usage less scary
Message-ID: <agHsTnBOgkadTqkp@kbusch-mbp>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
 <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
 <agGQZU4NwAgSzHLD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agGQZU4NwAgSzHLD@infradead.org>
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

On Mon, May 11, 2026 at 01:16:37AM -0700, Christoph Hellwig wrote:
> [the patch seem to be missing some maintainer Ccs]
> 
> On Mon, May 11, 2026 at 01:19:59AM +0300, Sagi Grimberg wrote:
> > TBH, I'm not sure why should this be a warning or an info log. This looks
> > like a debug print to me.
> 
> It is worse.  For some reason the commit seems to imply the uuid
> replaces the nguid and they can be intermixed.
> 
> We really need separate sysfs files for the different ids.  I gues we
> need to keep the existing one someone, but it is a mess.

Yes, sorry for the unpleasant situation this is. The attributes were
rushed into the driver at the time.

