Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C899C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 12:44:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEFD206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 12:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6ppBtRW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="buEYOoIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEFD206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UQpVW4FIA2XU5Aa9VrmTfVtYCq/xf+SM+Z42p4erT9U=; b=s6ppBtRWm7hjvDjoPp39tYVas
	I+ZlFIP5cb7wIuvfu/ohgvAbGmgreeQnoeDvBc6gxNP8YZX1I04poml4UkV42ULYKcZROmDyqCZVV
	7GHL4xJRmeQpSPKsBxQSJzd+6yCwoqzTX9LQuiQs6qVE0bDPBHedcT/FwrBJ1KuV1KxxOJKtTb/xM
	riLFuwici+fxWMk/uJs3KmRGlYMn6Sm1rGoj3hK7y3SzPM6adFuaar5x/bRcgXQvGeXFitc/aQ+c8
	6Bup/keKNXYfE6WEuQt96R/l0GVxoidmTzrewp8nTUKAOZwzciiyoq8jI9ETn58PlpRAb6SMHAfLN
	YLH2GTGXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k579m-0004pn-5F; Mon, 10 Aug 2020 12:44:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k579j-0004pW-SK
 for linux-nvme@merlin.infradead.org; Mon, 10 Aug 2020 12:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HalEgJPe9NCqmF7LQ9A6d2sXhUtpYkJgMHSzl+96XrE=; b=buEYOoIS73AD3i5mQy08++vZWn
 VfNrhZWnS+eAXtQHupFLjaNlDYOLZHQ4+/GlQk6QgrCfSPV6AV+wbJVeGkYVxZNIYCRpAMbmKjm7s
 J9Uzj2TY/Rm3ndrl77BouYZkQxBH6/TyJ0Pvedi4/K6wt6O/lGxUZxkMmCyA5boWlLhjRBFnUb8bV
 rmLUJ+9Yln/REty+y9RLCtdsBjSrpuucrEnFSAptYKfo8E6aJUt75A/m+5t36p6P68OSu3xTNDGvH
 ar4lek13e2Do4Ct/HuV26RmskwRgXHJY3RTZWtxgXGZlePwLIeOOptC/tknbzWj+6Njkq3hRJPV4i
 ieMnPSaw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k579f-0006jd-Ks; Mon, 10 Aug 2020 12:43:55 +0000
Date: Mon, 10 Aug 2020 13:43:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] nvme: restore use of blk_path_error() in
 nvme_complete_rq()
Message-ID: <20200810124355.GB25070@infradead.org>
References: <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com>
 <20200806191943.GA27868@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806191943.GA27868@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Ewan Milne <emilne@redhat.com>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Just returning from my vacation, and I'm really surprised about
this discussion.

If you want to fix a device mapper / block layer interaction you do
not change nvme code to use suboptimal interfaces.

One of the reasons for the nvme multipath design was to allow for
tighter integration with protocol features, and making nvme do a detour
through the block layer for no good reason at all does not help with
that at all.

And if you want to support the TP that added the new command interrupted
status code please read through it - the status code itself is just a
small part of it, and none of the changes proposed in these discussions
would lead to a proper implementation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
