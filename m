Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64570C88E42
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 04:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CwxH6H2CfkT8iMZqvJXDnqSuSDUBr+iSR8mDT1/rG18=; b=yIPdfXMJkXbHDVaQezGxHlmwFz
	/E5CC1bpoTZr1CMBR+uzUonavAp0zx2jxiZUTMJOGjHzEAkEhokY9Gc5xITtq+yJziuzZ1VpC9Xp9
	SKjnDNJBDmVjl5dJGeoKuY/kcVSNMPQTNxstZDfCIYA2WT6ev6CdfOOqwnnD4Xmut0tkvyA/Yuxq5
	TBLCuUEKxpiHLwGaYoZIG8kUsSWXHdBMiFgGufzhq+XkK5DmtthUsPtrwcKpVP6zQCTxrg7/8JOYq
	3Nh3SqehXt69m7PIKeeSzGcZB1hpi3FlG+mvCvjwI+YkT68LpjmttG4XH0P7zSu9kF2rDXRQKO+sJ
	B/+5x/5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEfO-0000000Buj7-2jY3;
	Mon, 26 Jan 2026 04:57:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEfI-0000000Buim-2a2P
	for linux-nvme@bombadil.infradead.org;
	Mon, 26 Jan 2026 04:57:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CwxH6H2CfkT8iMZqvJXDnqSuSDUBr+iSR8mDT1/rG18=; b=Mv57SXSoblNCSdkGpg6VVH1TE2
	2xZBULACwd9lKQxf8xyDCrethKEv/UI2+4nWUgOWSZY9AQD4282xNqgpnMb5seqMdEgH3dzkstT0V
	FQ0rnRIYSU/jEGEo3hxeRvDNTUh+8NZInZf5oR4yCWglKJP0TvVrlWN+5mcukOELRJoaMts+zz7up
	N64rtnN0eLyniFRAXOmeyrwAtDXZE4HzZyGQNtLMspzluUnWERXcKQg2iMoQmpVK4HXYFdYMMYmJf
	eIlabB4r/XLXj1BTRB8QadCF9rPgP4zrNp8LhCv2/6WmD46Rrl5dGdxp589kdunNsWTfDDhfwcXPK
	Hm1m6dsw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEfA-00000004dl0-2DPR
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 04:57:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3EC3227A88; Mon, 26 Jan 2026 05:57:16 +0100 (CET)
Date: Mon, 26 Jan 2026 05:57:16 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"agk@redhat.com" <agk@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"mpatocka@redhat.com" <mpatocka@redhat.com>,
	"song@kernel.org" <song@kernel.org>,
	"yukuai@fnnas.com" <yukuai@fnnas.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>,
	"cem@kernel.org" <cem@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 4/6] nvmet: ignore discard return value
Message-ID: <20260126045716.GA31683@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-5-ckulkarnilinux@gmail.com> <942ad29c-cff3-458f-b175-0111de821970@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942ad29c-cff3-458f-b175-0111de821970@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_045720_890812_F8B6A011 
X-CRM114-Status: GOOD (  14.15  )
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

On Sat, Jan 24, 2026 at 09:35:16PM +0000, Chaitanya Kulkarni wrote:
> On 11/24/25 15:48, Chaitanya Kulkarni wrote:
> > __blkdev_issue_discard() always returns 0, making the error checking
> > in nvmet_bdev_discard_range() dead code.
> >
> > Kill the function nvmet_bdev_discard_range() and call
> > __blkdev_issue_discard() directly from nvmet_bdev_execute_discard(),
> > since no error handling is needed anymore for __blkdev_issue_discard()
> > call.
> >
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > ---
> 
> Gentle ping on this, can we apply this patch ?

Are we down to three patches now?  Maybe resend the whole series and
get ACKs to merge everything through the block layer?


