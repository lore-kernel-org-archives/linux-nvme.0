Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2042CCD98F2
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBa36oetGM98CKDff4iQR1LHwkI39+FDS5gJw9MMV/g=; b=jQvV2uFzZeUujpH4+GfhVtFgsq
	3xX7ig0shZTfDHxOol1bv/mypKQ4WoiS9xDulGOOELF0NwoFwu8EBgPQ060ENfKMzMgLmJgwVOifD
	fvL8wwJEbPwKFhv0b0uj24PfJHz2M6vLVH8Vmt/DTa28vhXDocbGEAJAhO+F+wGZeucCitNxc1ic4
	auyii8TKa17HxSbbQQcRwyIZve4e0ihQVYlXI3Q9FnXRoeb9IkzNud3HLBrtUDiwxxo1U5JMGrl6k
	E1vns6ltyjwQi3xNK3MfjSTKiJ64xRtnl+WdKsI/6in9oQsHytQVS4b+z894//IbbdL91Au6zojtH
	UMcxuq0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waeDu-00000002tDX-3JYu;
	Fri, 19 Jun 2026 18:45:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waeDs-00000002tDJ-3zog
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 18:45:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 36F66601E1;
	Fri, 19 Jun 2026 18:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C901F000E9;
	Fri, 19 Jun 2026 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781894747;
	bh=FBa36oetGM98CKDff4iQR1LHwkI39+FDS5gJw9MMV/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LUvuJba0n1qxs8+Uo/JYny0hhls3tq1Y9GEi5Y5BlP96op/MYpnRgKOndu6FYHi9p
	 ABMyNUidg9ZUeKtxwIyX+ypGg9a2ESByu1BxCI3ItMixPtxnBeZJw3otEoeBlOymHP
	 nJKbT094QZpe5NIyzMtWXEyONLLlnBtUTrzKJ8BQHpMkpdmXLKGCZpmNwJtnTNcbTr
	 CT91PJ9TI6MdWbzC/y0vlzzi4L8L9691gtQt/qCaleyMtpsb0d28E+HQj6DfUgTyUd
	 JXEVI5zHj3vXY5ToHQF+HxE9OIfv6m7j2rL5m7zspSuDE+COyN+MQ53P5T7R1goQjQ
	 dok0tsokqXqdQ==
Date: Fri, 19 Jun 2026 12:45:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
	John Meneghini <jmeneghi@redhat.com>,
	Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de,
	chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, emilne@redhat.com,
	bgurney@redhat.com
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
Message-ID: <ajWOWdD0P5ri9bWY@kbusch-mbp>
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp>
 <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp>
 <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp>
 <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
 <ajRpWLqaEyA6cwkJ@kbusch-mbp>
 <531aa19b-a9ae-44f7-82ce-3714621ceee8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531aa19b-a9ae-44f7-82ce-3714621ceee8@suse.de>
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

On Fri, Jun 19, 2026 at 07:59:43AM +0200, Hannes Reinecke wrote:
> The problem here is namespace lifetime. The ns_ida is only ever released
> at the very last step, so the 'number' of the namespace will only be freed
> once all references to the namespace are dropped.
> So if you were trying to keep the namespace number ordered you would
> have to delay the creation of the namespace until that point, and you
> would induce a serialization between deletion and creation.

Under the proposed scheme, there is no ns_ida. You just use the NSID of
the namespace, and that's it. You have to ensure that del_gendisk
completed on all heads and paths that was using it prior to bringing up
the next one, but that's not really a problem.

The problem I recall has something to do with the nsid not being a
consistent value when migrating a namespace to another array or
something like that. Not that we currently have proper support for such
a thing...

