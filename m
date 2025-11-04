Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB96CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IJZ6kmHZtNXhmLiTvDnftzGDGg2GMgieja0WjAFEc0=; b=BCwbRhRikqidB+gErUVZ4Tdjth
	DVloseLG87nj/B9LDgUcB1caVgY9M8p/0qmNFwShiXlB9OKO0Fv1l9QCYY+1E7JTjAk/RCqBPdsmW
	NtQ2D6VtMLqXokMDaRNFAaCoZ5mSlQ0qJi0QCNZYTPgxsEo/kIMwoeiz2+EfiPysbqs9OVbncLgKj
	UfRsLwdy7ybCyXMY1kPgP/PdsntFkhztheR/NQ6Znr6O2MoBbTD+n3g0STrTdaIvg+DsQOlgN5Hrh
	iKnzhGEBTYjVnRSSSPEG18Cw/S8DBC13o3P2d1DlgKCq5pArfuUSeIa8/YF4wzBuvGGJAwk+DG9FE
	gBBb4FTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFkw-0000000Bkhj-2D7a;
	Tue, 04 Nov 2025 12:03:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFkt-0000000BkhM-0cVA
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 12:03:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA5B6227A88; Tue,  4 Nov 2025 13:03:09 +0100 (CET)
Date: Tue, 4 Nov 2025 13:03:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	David Sterba <dsterba@suse.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 07/13] block: track zone conditions
Message-ID: <20251104120309.GA16283@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-8-dlemoal@kernel.org> <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org> <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org> <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org> <6008fbc8-b556-46d9-98a5-a4622731d206@nvidia.com> <83b60505-64a4-40fe-aa50-02a56ca7ad8c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b60505-64a4-40fe-aa50-02a56ca7ad8c@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_040319_348829_82370AC2 
X-CRM114-Status: GOOD (  14.83  )
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

On Tue, Nov 04, 2025 at 07:53:07AM +0900, Damien Le Moal wrote:
> > In case current file systems store this, isn't that a code duplication for each
> > fs ? perhaps having a central interface at block layer should help remove the
> > code duplication ?
> 
> catch 22: You cannot ask the file system without first knowing the zone layout
> and conditions of zone to check the file system metadata.

The file system also really needs to verify that it's view matches the
hardware view at mount time, otherwise you'll run into really nasty
cases later when they are out of sync due to a bug or corruption.


