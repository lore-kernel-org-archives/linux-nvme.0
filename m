Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C060BD31761
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5jkeGmkp4semAIZX7n/90C8ORabYxEHI+8ih6AZ6r70=; b=LKA/45g4bWh8/HEOmSswTIEod3
	UjtDSOClbcf7+PjIoDISg7SiGHZXnPr6Wo1yefZblkHmAUTRsEM+SnL35wau/+ie+0wTtdId48m6/
	y2Su2ZxqMkde1Kp+05MK4dYf/OJ0Sde+yhbQLhHmocMuE+Y5/baox2r234hr2sy29AErbVSu2FM6C
	n9oKFis0yKApE7x7cUAYZgAVtQ+0f84PVM38XPfByc444AFl1hc7bsdsbhSvHJrAaIRNu4DVNEI7K
	Ku9/eUT6BwIPznF0ndzGwrksHYnegWyR6mZ1q4MqJ8nr0ON+S5G43YLSA830nU+ckNp2h0G35nRO/
	/iwBBJqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8MZP-000000004HU-1RIF;
	Tue, 05 Nov 2024 16:38:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LzD-0000000HXhP-42mK
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 16:00:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD1D5227AAC; Tue,  5 Nov 2024 17:00:51 +0100 (CET)
Date: Tue, 5 Nov 2024 17:00:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj gupta <anuj1072538@gmail.com>,
	Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk,
	kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 06/10] io_uring/rw: add support to send metadata
 along with read/write
Message-ID: <20241105160051.GA7599@lst.de>
References: <20241104140601.12239-1-anuj20.g@samsung.com> <CGME20241104141459epcas5p27991e140158b1e7294b4d6c4e767373c@epcas5p2.samsung.com> <20241104140601.12239-7-anuj20.g@samsung.com> <20241105095621.GB597@lst.de> <CACzX3AuNFoE-EC_xpDPZkoiUk1uc0LXMNw-mLnhrKAG4dnJzQw@mail.gmail.com> <20241105135657.GA4775@lst.de> <b52ecf88-1786-4b6f-b8f3-86cccaa51917@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52ecf88-1786-4b6f-b8f3-86cccaa51917@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_080056_170835_B6EFCCE2 
X-CRM114-Status: GOOD (  27.46  )
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

On Tue, Nov 05, 2024 at 09:21:27PM +0530, Kanchan Joshi wrote:
> Can add the documentation (if this version is palatable for Jens/Pavel), 
> but this was discussed in previous iteration:
> 
> 1. Each meta type may have different space requirement in SQE.
> 
> Only for PI, we need so much space that we can't fit that in first SQE. 
> The SQE128 requirement is only for PI type.
> Another different meta type may just fit into the first SQE. For that we 
> don't have to mandate SQE128.

Ok, I'm really confused now.  The way I understood Anuj was that this
is NOT about block level metadata, but about other uses of the big SQE.

Which version is right?  Or did I just completely misunderstand Anuj?

> 2. If two meta types are known not to co-exist, they can be kept in the 
> same place within SQE. Since each meta-type is a flag, we can check what 
> combinations are valid within io_uring and throw the error in case of 
> incompatibility.

And this sounds like what you refer to is not actually block metadata
as in this patchset or nvme, (or weirdly enough integrity in the block
layer code).

> 3. Previous version was relying on SQE128 flag. If user set the ring 
> that way, it is assumed that PI information was sent.
> This is more explicitly conveyed now - if user passed META_TYPE_PI flag, 
> it has sent the PI. This comment in the code:
> 
> +       /* if sqe->meta_type is META_TYPE_PI, last 32 bytes are for PI */
> +       union {
> 
> If this flag is not passed, parsing of second SQE is skipped, which is 
> the current behavior as now also one can send regular (non pi) 
> read/write on SQE128 ring.

And while I don't understand how this threads in with the previous
statements, this makes sense.  If you only want to send a pointer (+len)
to metadata you can use the normal 64-byte SQE.  If you want to send
a PI tuple you need SEQ128.  Is that what the various above statements
try to express?  If so the right API to me would be to have two flags:

 - a flag that a pointer to metadata is passed.  This can work with
   a 64-bit SQE.
 - another flag that a PI tuple is passed.  This requires a 128-byte
   and also the previous flag.


> 
> 
> 
> 
> 
---end quoted text---

