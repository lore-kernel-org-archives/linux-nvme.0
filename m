Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8D2C83F2C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NIODgjYa7PuvXGsEAPMzKj+NfiGv8Os/+c+vFOFDL0A=; b=DGWb4gqPjplxzEr5HugBA4VvCG
	pyn8La6Yl80Ncfs54NS8TT67TXVnlt4v1YGE7wtTjedOaq2QDg1H/QnODAVKR8F74YLOk+4LAIdnT
	DXQCwENmMjLnp8P00ZL6K/lpiryxaRFGYxPZSn/8kUgePCVjwi2ymV0CWuF7f9bIns6we9gjxwUFo
	FKa50xJXK6AkQFN6XZGZAs1PinzFM71PGH0tW9UrcrqauDSHSVuZW0CnxvGaQ9txUVYxy3ViHu4Vx
	3uw2dfWTf2LCbBIN0XnzJoBX42pjtpq2woYYOh9Mlk56TOQLrlKtg5NlOEfvsRk3WZi+1s6DgfKVL
	MegueX0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdRWC-005XVJ-30;
	Tue, 05 Sep 2023 08:34:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdRUq-005XUD-31
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 08:33:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 30B4E68AA6; Tue,  5 Sep 2023 10:33:09 +0200 (CEST)
Date: Tue, 5 Sep 2023 10:33:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 1/4] nvmet-trace: avoid dereferencing pointer too early
Message-ID: <20230905083308.GA20920@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-2-dwagner@suse.de> <20230905064846.GA19701@lst.de> <77nt3zr7rap6w7bpvm6vfdqqf4xc46afq4tzlifsn3zlry5wvh@t2e6orslw6on>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77nt3zr7rap6w7bpvm6vfdqqf4xc46afq4tzlifsn3zlry5wvh@t2e6orslw6on>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_013317_119446_E586828F 
X-CRM114-Status: GOOD (  16.24  )
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

On Tue, Sep 05, 2023 at 10:24:51AM +0200, Daniel Wagner wrote:
> On Tue, Sep 05, 2023 at 08:48:46AM +0200, Christoph Hellwig wrote:
> > > +static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
> > >  {
> > > -	return req->sq->ctrl;
> > > +	if (!req->sq || !req->sq->ctrl)
> > > +		return 0;
> > > +	return req->sq->ctrl->cntlid;
> > 
> > Can you add a comment here why we have this check?
> 
> /*
>  * The queue and controller pointer are not valid until an
>  * association has been established.
>  */

sounds good.

