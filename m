Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C4EC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 08:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YddEi5l/hMjKfNJeQXJK6G/1YQ2KXXJklIU6uloMe+M=; b=mXFaDdC8QpOLxfYBY7iNPzHsu8
	4XIn3qph2lp7vbmy/GKnSJRlzVr+8T6rL8zntvL9olpese2X36PcrZwVPhX6W18kQ/cB2c3ySCuIv
	ONWuxSPmKUNjVfPrBGC+IiLh0A8kn1352bi3rqSpTvLt1LQflNHLj5PhIZoxQ2oFn4epeXqEOQ8tc
	b8XePMCrp/Ck61IBFuJl3a66inQcCyXbWVQm9jgJgvMpZNeKDjWs3T8ZXbILa5NLbNoRSVYAUbZ4R
	b7kQioJaHTWm3N8qrQxyPyPrQg6B7ciK7ITklKK5uwxDHbmiOkmit/go1nwowEUfAS9/8uICw7eTY
	erzJR8bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkjb-0000000CzvS-2Zwe;
	Thu, 28 Mar 2024 08:03:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjdf-0000000ClsE-3Y59
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Mar 2024 06:53:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YddEi5l/hMjKfNJeQXJK6G/1YQ2KXXJklIU6uloMe+M=; b=EHLpmfn/LBRU2cXppNbS04IcDf
	EAZgad4QZgNvwAVFwmgILX5sgPsM9Qo2lFtYAugV0eUK7yYJnKfNUcqM05GA9U2XeQUwFpAsLXow+
	b9jFlgseVTsKhaMFOYWHAOdliJ7Fhh3cVUi+TbbiOxt+YDu/pGXpbBpOvX+LtLsubGFKAm2BIOI31
	ahF8BwWnX69j2PojsQYsVsbZ+lp2Zv46TvHs5BveVKZUyCOEEUTdzgpkleerohUbGMKynNhUu1IA7
	f3ThtiFNINkyqMgB1cR/8tiXlLPwqBJE5oUiWx9z9YVx8Lw4fTaKt7CGrZJ0xqMMJ2+EmGQvi8LbK
	uq8wvo2g==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjdN-00000000phB-1t7y
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:53:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA3D268B05; Thu, 28 Mar 2024 07:52:56 +0100 (CET)
Date: Thu, 28 Mar 2024 07:52:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
Message-ID: <20240328065256.GB17890@lst.de>
References: <20240328043016.GA13701@lst.de> <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org> <20240328054652.GA16237@lst.de> <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org> <20240328060357.GA16819@lst.de> <ca3fe7b0-7e27-4ac9-b669-5263c3cec550@kernel.org> <20240328062237.GA17225@lst.de> <0d54c569-f586-4b75-a8a3-509e3f3717e2@kernel.org> <20240328063816.GA17642@lst.de> <b144a7f1-af29-4c0d-96f7-c0f16b2299b8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b144a7f1-af29-4c0d-96f7-c0f16b2299b8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_065312_881298_EF24EE46 
X-CRM114-Status: GOOD (  14.90  )
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

On Thu, Mar 28, 2024 at 03:51:09PM +0900, Damien Le Moal wrote:
> I am all for not micro-optimizing the free path right now.
> I am not so sure about the mempool being simpler... And I do see some
> improvements in perf for SMR HDDs with the free list. Could be noise though but
> it feels a little more solid perf-wise. I have not seen any benefit for faster
> devices with the free list though...
> 
> If you prefer the mempool, I can go back to using it though, not a big deal.

A capped free list + dynamic allocation beyond it is exactly what the
mempool is, so reimplementing seems a bit silly.

