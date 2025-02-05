Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D639C02192
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wP5k63LIHGHvPPq7QrAq8yES/RiflMNp6QoYoNrgB7A=; b=RaRSzguZnQYbpb1DfojpEwmSjW
	DttiSMj9qxiq1lBUkQoyTYherIrTl9K/ohAfasjppTz2aVF+myyh31XzVmlG727rzPiDkOGZX2NLo
	YUQoxRxyI5h3xnYTbkn4vvQcgK03nG9xDTLCEO/c1XirpOxM/hUUuevk+pyk0aCITkqWftp5pvCNt
	zCJfhxueIhwLVnLr4q9qxzyIZ3GibAGNJXHYDMW5BNNPRjnP3XLOS4RKcVs6XZWkaN9J8EgfYpABn
	aHw2gpuxVRrshfPSQNVIe1BcXm4QyBtJTjNtHrNKTR5Z8Z+ea7d8bDSDq7kZIaI7DSG6t7HhHlCmZ
	K+Afz7Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhXd-00000003ooN-2RAC;
	Wed, 05 Feb 2025 15:42:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhXa-00000003onX-41a2
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 15:42:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40BFE68BFE; Wed,  5 Feb 2025 16:42:07 +0100 (CET)
Date: Wed, 5 Feb 2025 16:42:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v11 07/10] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20250205154206.GA13814@lst.de>
References: <20241128112240.8867-1-anuj20.g@samsung.com> <CGME20241128113112epcas5p186ef86baaa3054effb7244c54ee2f991@epcas5p1.samsung.com> <20241128112240.8867-8-anuj20.g@samsung.com> <20250203065331.GA16999@lst.de> <20250203143948.GA17571@green245> <20250204053914.GA28919@lst.de> <20250205115134.GA16697@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205115134.GA16697@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_074215_143632_F76329B5 
X-CRM114-Status: GOOD (  19.10  )
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

On Wed, Feb 05, 2025 at 05:21:34PM +0530, Anuj Gupta wrote:
> On Tue, Feb 04, 2025 at 06:39:14AM +0100, Christoph Hellwig wrote:
> > On Mon, Feb 03, 2025 at 08:09:48PM +0530, Anuj Gupta wrote:
> > > +	if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
> > > +		bip->bip_flags |= BIP_IP_CHECKSUM;
> > 
> > We'll also need to set the BIP_CHECK_GUARD flag here I think.
> 
> Right, I think this patch should address the problem [*]
> I couldn't test this patch, as nvme-tcp doesn't support T10-PI and so
> does rdma_rxe. I don't have rdma h/w to test this.
> It would be great if someone can give this a run.

I'll add support to nvmet-loop, which should make testing either.

Note that the SCSI target code has the same issues and might be a
little easier to test.


