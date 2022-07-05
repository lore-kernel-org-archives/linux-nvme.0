Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C06C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 08:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bKMnhVKUNYykbjNZmD0zwAoEg8weTNBY2n23c4o61bY=; b=Nn/LWco20saMv69S4tcD4Q8NIi
	Yd1EN0NgLJ1PK0YewbWQbC8kTKT8OXrfjZQ2dwBJMO4yV8y22udc34K1qn/5rDXV/sUSX/U1q4S8q
	CbaD/XblI165pP3uDZ+tv70a+LnUBFZsIWu54dADESn8/5q1pH1c/P/ULoIHtw/K23Tz2CgNOPxeV
	SjuXENDyd1+CaJckYsSa5sxuoSJRFc1gy+Qg3wzsnD1yab6bejD63hpkLa4iKmlaiRuwfCUHYrgIN
	BDVjrvN8o5WLJGCCkn7M3IcYpqqEIt4pm6793wjSllYA4U1pk/WtRo9bJY/WTZl97HLITsc6ZU15s
	5V0AcHFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e4v-00GGUa-Sn; Tue, 05 Jul 2022 08:38:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e0q-00GEan-5G
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 08:34:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D265E68BEB; Tue,  5 Jul 2022 10:34:24 +0200 (CEST)
Date: Tue, 5 Jul 2022 10:34:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, agk@redhat.com,
	song@kernel.org, djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, javier@javigon.com,
	johannes.thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, ming.lei@redhat.com, willy@infradead.org,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
	dsterba@suse.com, jack@suse.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
	danil.kipnis@cloud.ionos.com, ebiggers@google.com,
	jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 2/6] nvme: add support for the Verify command
Message-ID: <20220705083424.GB19123@lst.de>
References: <20220630091406.19624-1-kch@nvidia.com> <20220630091406.19624-3-kch@nvidia.com> <Yr3OLiEd+/6wryCx@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr3OLiEd+/6wryCx@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_013428_370007_912D1CDC 
X-CRM114-Status: GOOD (  13.41  )
X-Mailman-Approved-At: Tue, 05 Jul 2022 01:38:36 -0700
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

On Thu, Jun 30, 2022 at 10:24:14AM -0600, Keith Busch wrote:
> On Thu, Jun 30, 2022 at 02:14:02AM -0700, Chaitanya Kulkarni wrote:
> > Allow verify operations (REQ_OP_VERIFY) on the block device, if the
> > device supports optional command bit set for verify. Add support
> > to setup verify command. Set maximum possible verify sectors in one
> > verify command according to maximum hardware sectors supported by the
> > controller.
> 
> Shouldn't the limit be determined by Identify Controller NVM CSS's 'VSL' field
> instead of its max data transfer?

Yes.

