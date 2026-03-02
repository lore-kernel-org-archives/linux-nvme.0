Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274B3EA4E07
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w2YDu5rMtbMMxT3t2H4bsBgwmSSKVHaJSN2ub4jHoRU=; b=bPZaUAtPOuD4+Tjk1jep1SIdq6
	h0KFoqqMPucSjqg8eeNLog15RSBT8rpyzZ9A0e5Y777uJ4puzgVx0Wmlw2xisnoETSu+/ZCmRNb68
	cCtWdPFZvKFxyJmwmj/hdRypqXV7mqvseNbbNUYvwtUsfwcHEA0Djhfu8YCOQjHUOCsFOQQgQfdO0
	/xKbw9043X4KflzctUY27V6InkTgJ+HQvN708p4xZXDQZX+5glGoPW02a9VIjb+aA0hch+b3WilM2
	3conlJ9KWFrkOg5MgItyu2r3ovxv/GkKAEBSsMsh4Xp1iJsraTaA7PA1tq8KTq9BoKdXB1Udrg+GV
	vui7IIdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx40L-0000000DCsU-28wp;
	Mon, 02 Mar 2026 14:12:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx40I-0000000DCs5-48ik
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 14:12:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97D8C68B05; Mon,  2 Mar 2026 15:12:06 +0100 (CET)
Date: Mon, 2 Mar 2026 15:12:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
	hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, michael.christie@oracle.com,
	snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] nvme: switch to libmultipath
Message-ID: <20260302141206.GA23439@lst.de>
References: <20260225154007.1033735-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225154007.1033735-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_061211_212752_8F765A59 
X-CRM114-Status: GOOD (  13.34  )
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

On Wed, Feb 25, 2026 at 03:39:48PM +0000, John Garry wrote:
> This switches the NVMe host driver to use libmultipath. That library
> is very heavily based on the NVMe multipath code, so the change over
> should hopefully be straightforward. There is often a direct replacement
> for functions.

Given how little code this removes while adding the new libmultipath
dependency and abstractions I can't say I like this at all.


