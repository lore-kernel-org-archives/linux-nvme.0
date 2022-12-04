Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B52C4708E
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Dec 2022 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZMKHsZ9J/9HVqEI7K+PUN8AFaxYY3PMsxo7nv39BPY=; b=GUgZ3rkkpGrrZA78E+ftzaVU51
	Fcv8S2lHhGrrEF8CdLhC+cO972NX2FpXcdSs6vtqbxP7YM3KEtv5fE78VUu+MU//n/P1L2sOx0evL
	HXgQ197gzwNkwaQz3pDs+FJ6Eooksw7x9u69z+fYB7LWiJG75L0YuoS3+MImO15b66VPD88T88P4F
	p7qghmEhDJ3lW89D3rUsRjpcRwh03StnhpHv4ahYE7MH9p3PMTfTqKFDYTMXLux/cisr1cmjGmx4I
	oejJFMdP6MhKRYfctdUYTWFBfARCgfBuWZskJU32z0GnnEUWeF8qW9ODZEsQrsHfp5U9ZS4JMA/Dz
	DwtZoklQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1vci-00BEDa-EI; Sun, 04 Dec 2022 20:30:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1vcg-00BEBU-Me
	for linux-nvme@lists.infradead.org; Sun, 04 Dec 2022 20:30:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3E4DC60D2B;
	Sun,  4 Dec 2022 20:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF49C433D6;
	Sun,  4 Dec 2022 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670185796;
	bh=7pr8hVZJ6Hx+FhaG0oa2FI+IrcOdsDHZDzij5USkQBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFvp8AzxAXsyTBEEXEMbXnCLpf+zYijfGRBH4KHkeeX2G2mBh37L/+578ilVGPD2l
	 PoVAvjiI26kfkHkt8OMgVk4Gcs/8dC5RSBWLzBHfqNYgo5G0NBWpG0J+R7pMesASJ7
	 cvXULRwUdPgnjgPO+WBWoIUGv+y34BnD1BPDy2U3s9U22/QodgTeLHge8CCx2NzKcF
	 LUxs/vaZBRj3PAH644643/uG7BM0fmwvDKbjvZsv307Hx5MsEsRI3Ru/J+oAqoXXcv
	 ngbINzNer5vFsz2CdyEfCVtl2K0roS/mneQVhFN8E1djrf9eboEcFlTQVLvmyoWPs+
	 8inCg7btm82Uw==
Date: Sun, 4 Dec 2022 20:29:44 +0000
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, jefflexu@linux.alibaba.com,
	josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
	tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
	idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
	ebiggers@google.com, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Y40DOJ+7WlqIwkbD@kbusch-mbp>
References: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221204_123002_820331_AD509F2B 
X-CRM114-Status: GOOD (  18.65  )
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

On Sat, Dec 03, 2022 at 07:19:17AM +0300, Javier González wrote:
> 
> > On 2 Dec 2022, at 17.58, Keith Busch <kbusch@kernel.org> wrote:
> > 
> > ﻿On Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
> >>> On 12/1/22 20:39, Matthew Wilcox wrote:
> >>> On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
> >>>> So nobody can get away with a lie.
> >>> 
> >>> And yet devices do exist which lie.  I'm not surprised that vendors
> >>> vehemently claim that they don't, or "nobody would get away with it".
> >>> But, of course, they do.  And there's no way for us to find out if
> >>> they're lying!
> >>> 
> >> But we'll never be able to figure that out unless we try.
> >> 
> >> Once we've tried we will have proof either way.
> > 
> > As long as the protocols don't provide proof-of-work, trying this
> > doesn't really prove anything with respect to this concern.
> 
> Is this something we should bring to NVMe? Seems like the main disagreement can be addressed there. 

Yeah, proof for the host appears to require a new feature, so we'd need
to bring this to the TWG. I can draft a TPAR if there's interest and
have ideas on how the feature could be implemented, but I currently
don't have enough skin in this game to sponser it.

