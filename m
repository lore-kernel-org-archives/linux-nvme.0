Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03733C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JpHgo91QerBYjd0IHS6jzMcvx9QFNGaoVlyFUrxjfrY=; b=bJL+pyNrh0IMAgP9WTYK69hMDz
	A1GgX2RaiYFoc8v9iB8JJLA5EyoBz9aDIVoeQma84pFnGGFY1W9vEqSzDEVwP6y1SwW0aUyRbhC0u
	SrtDYv/9t18devBfMUSpr5+49YJ7vEel/zsaTuLjzPZDhMw1hixM6ioQF6edFBzbKTmo1a/huSoAO
	bIx3v1Sm+qtY8R+QWd2TGZSoKxj5bDcZrcqlUOp7EnnwTv/yYf31dTtxk9r7gb1XT6eO/vLJhM/11
	04DGUGO8Q1FEpjDXczsimpwPBrwKeI23EoLaotYDgeKvPzHOBQIV5zzrERzzjRJhsrcyWoeHcQXsL
	LhCGMpiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nchBL-00F8uU-SY; Fri, 08 Apr 2022 05:29:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nchBI-00F8so-54
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 05:29:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AC51668AFE; Fri,  8 Apr 2022 07:29:07 +0200 (CEST)
Date: Fri, 8 Apr 2022 07:29:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220408052907.GA31990@lst.de>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk+KO8hEYpnKdGu3@garbanzo>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_222912_385241_B2DB25D7 
X-CRM114-Status: GOOD (  37.25  )
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

On Thu, Apr 07, 2022 at 06:04:59PM -0700, Luis Chamberlain wrote:
> On Thu, Feb 24, 2022 at 08:28:45PM +0100, Christoph Hellwig wrote:
> > Add a check to verify that the unique identifiers are unique globally
> > in addition to the existing check that verifies that they are unique
> > inside a single subsystem.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/host/core.c | 38 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index cece987ba1691..f8084ded69e50 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3810,12 +3810,45 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> >  	return ERR_PTR(ret);
> >  }
> >  
> > +static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
> > +		struct nvme_ns_ids *ids)
> > +{
> > +	struct nvme_subsystem *s;
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * Note that this check is racy as we try to avoid holding the global
> > +	 * lock over the whole ns_head creation.  But it is only intended as
> > +	 * a sanity check anyway.
> > +	 */
> > +	mutex_lock(&nvme_subsystems_lock);
> > +	list_for_each_entry(s, &nvme_subsystems, entry) {
> > +		if (s == this)
> > +			continue;
> > +		mutex_lock(&s->lock);
> > +		ret = nvme_subsys_check_duplicate_ids(s, ids);
> > +		mutex_unlock(&s->lock);
> > +		if (ret)
> > +			break;
> > +	}
> > +	mutex_unlock(&nvme_subsystems_lock);
> > +
> > +	return ret;
> > +}
> > +
> >  static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
> >  		struct nvme_ns_ids *ids, bool is_shared)
> >  {
> >  	struct nvme_ctrl *ctrl = ns->ctrl;
> >  	struct nvme_ns_head *head = NULL;
> > -	int ret = 0;
> > +	int ret;
> > +
> > +	ret = nvme_global_check_duplicate_ids(ctrl->subsys, ids);
> > +	if (ret) {
> > +		dev_err(ctrl->device,
> > +			"globally duplicate IDs for nsid %d\n", nsid);
> 
> So what sort of meachanisms would break in nvme if we don't (as it was
> before this patch)?

The most directly visible problem is that this breaks the
/dev/disk/by-id/ links - all devices would have to point to the same
one, and which one actually shows up is somewhat random.  This basically
means random corruption if people actually use the links or the uuid
functionality in any other way.

Note that we have alredy checked for this inside a controller for a
long time, the commit just extended it across controllers.


> The reason I ask is that it would seem tons of
> instantiated qemu guests used the default, and don't set the UUID,
> and so this is auto-generated as per the documentation [0]. However,
> I'm suspecting the auto-generation may just be... a single value:

Odd.  All my qemu VM don't show a UUID unless specifically set.

> 
> root@kdevops ~ # cat
> /sys/devices/pci0000:00/0000:00:08.0/nvme/nvme0/nvme0n1/uuid
> 00000001-0000-0000-0000-000000000000

And the 1 really seems like a bug in your particular set.  What qemu
version is this?  Does it have any local or distro patches applied?

