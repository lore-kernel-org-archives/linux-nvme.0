Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4631FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j+v40RHPB1UVEqMJ0EcbkvBgS+le4AGmKV5CwY9Ny2k=; b=s93u3VOJI7JhCyPK8ot5/HgVqL
	Dwvs3g3DXwO/Ic3XbqLk7r4ltWWCESjYN0A7aaEO6DuSDljH7lOxsakh056nlfXziLYtFyf4teMtR
	Wrx/119L39Ion+tyyva61gfPDytxHlEyYJPDjBmirf9ozuA1pgWbi3+vEYPRn+WwYIJxy/COPv4bB
	KdM8oD39weOZGhOTSMKxFutfgOJqdb79b3U/uFmBjXCLWUDbKbDlzumPG8CVhsvrql2V1GXRRWp+k
	qZ8CoeHwEUvcwvqsvhlil48m7OF1L0OWWdlZj3Lky5ajzIldg2hapY9zkIZzLxdIIg4dgATX0OrUY
	kysPPCPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nP0O2-00GLY8-PS; Tue, 01 Mar 2022 11:09:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nP0NH-00GLGA-7t
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 11:09:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ED29068AFE; Tue,  1 Mar 2022 12:08:40 +0100 (CET)
Date: Tue, 1 Mar 2022 12:08:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Randy Jennings <randyj@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org,
 Prabhath Sajeepa <psajeepa@purestorage.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Uday Shankar <ushankar@purestorage.com>
Subject: Re: Native multipath across multiple subsystem NQNs
Message-ID: <20220301110840.GA2005@lst.de>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
 <20220212063422.GA16561@lst.de>
 <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
 <20220214081252.GA18231@lst.de>
 <20220225001547.GA3454995@dev-ushankar.dev.purestorage.com>
 <20220225005306.GA904231@dev-randyj2.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225005306.GA904231@dev-randyj2.dev.purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220301_030859_495736_D0106571 
X-CRM114-Status: GOOD (  19.83  )
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

On Thu, Feb 24, 2022 at 05:53:06PM -0700, Randy Jennings wrote:
> In addition to other considerations, migrating a namespace with hot data
> from a different storage vendor array nondisruptive to client i/o would
> be difficult to do without having a namespace exist under multiple NQNs.
> One approach that has been used for SCSI is by multipathing to both
> targets & a proxy mirroring writes; on cut-over, the other path
> disconnects.  If the filehandle has to change, that is disruptive to the
> client software.
> 
> Unifying different storage arrays behind the same NQN/virtual subsystem
> requires coordination of nvme ctrl_ids at least, and doing that between
> different storage vendor arrays is unlikely.  Having a mechanism to
> migrate between different JBOF devices non-disruptively would be helpful
> regardless of the source/destination vendors.  Such devices will
> probably not have the option of virtual subsystems.

Yes, it does require coordination, so please coordinate.

> In other words, even with implementing virtual subsystems, we still have
> use for non-disruptively moving a namespace between subsystems.  How
> will this usecase be supported on Linux?

You can create a mirror using dm (or md but not as easily), resync and
then cut off a leg.   If you want to do that transparently on an
already existing device node you'll need to pick up the block device
interposer patchset and help to get it upstream.

