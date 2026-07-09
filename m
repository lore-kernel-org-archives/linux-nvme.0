Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE60BC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ZD5u1j99PnID68jkgO+3ccB0arYOSegCbBXuh/jBos=; b=o/Y15PoD+hS5+oep19UrVpwC7s
	0eUoQn4N+05nBLSkax4OeyNrn3/g1YDHEftQusxKuvsbdrcFLuV1QVONvBdNl6Krjr2mdSfNuWpTF
	dv9dFW20VKHTBCmtMaYi6amXk6Pa3d22Shm/v+Qj3fIazR25kYjCREXzhOM1ch5BEDHtqjVBl1zvw
	Nzg035JLRO3jQab59If2sIYB63JW9GUrMuU6oYFQnCs+JkQXViryLcIHW4u1I7Jgee9NWhmbPrSm3
	LYJhWXIkIgSd+XMBoHXrvRuukzXjvs/h+7WLJT4aqutU94Hu8a/qb7NzleWdHntSlE1GSD6DyOElN
	GWh+bDMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiFh-00000001AGk-0FL4;
	Thu, 09 Jul 2026 06:28:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiFd-00000001AGI-3YDV
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:28:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1B1E68BFE; Thu,  9 Jul 2026 08:28:45 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:28:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 07/18] nvme: add context annotations for
 nvme_subsystem::lock
Message-ID: <20260709062845.GA18056@lst.de>
References: <20260706141452.3008233-1-nilay@linux.ibm.com> <20260706141452.3008233-8-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706141452.3008233-8-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_232850_039388_14F81660 
X-CRM114-Status: GOOD (  10.80  )
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

On Mon, Jul 06, 2026 at 07:44:09PM +0530, Nilay Shroff wrote:
> Wrap the initialization of nvme_subsystem::nsheads with
> context_unsafe(...) to suppress the context analysis warning emitted
> for INIT_LIST_HEAD() during object initialization.

Still not a fan of that vs adding a proper helper.

> nvme_ns_head is allocated with kzalloc(), so explicitly initializing
> nvme_ns_head::delayed_removal_secs to 0 in nvme_mpath_alloc_disk() is
> redundant. Remove the redundant initialization, which also avoids a
> false positive from Clang's context analysis.

Please split that into a prep patch.


