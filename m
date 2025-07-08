Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F4BC83F12
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LAQpXsFb3/0GEm8v58bKjJqP4pRbMdJNvXJ0Svahw20=; b=hrNwjqLQpD5A1LVdrDdrEZBj14
	1wNjZnSptuaoI03rOX6bg2PFE17Ya1PQwz0ETE9ulBXWJiqmIHqyv3RQgUXkT09HkII2Rd0ItcgvF
	4EyN+6pb/fXC2FehTPM+YoBax9iHn9798MN3F5V8taUlgZjuHbBI2MN51B9cdCf0RQ89Dxncwg2wM
	gMeenoa+eQU9GhqQUlWyaNzBc8N1E+k9wv950aqZbaQ+33/Q+waVxbre1s0u2w685L8fNPBZwczE9
	LHxOP2qyYavz/RxHE0yLYvEZ4n8cEAu2Be1gez8yX2gdNLL7UvHsQc7sS5mpwpE1aQkodt/D5HM4i
	jGpg6wgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ5Fi-000000051NR-1hEt;
	Tue, 08 Jul 2025 10:08:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4wA-00000004vo8-0bim
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 09:48:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0349E68C4E; Tue,  8 Jul 2025 11:48:25 +0200 (CEST)
Date: Tue, 8 Jul 2025 11:48:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <20250708094825.GC27634@lst.de>
References: <20250707141834.GA30198@lst.de> <aGznAUVxSl5_Xa3E@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGznAUVxSl5_Xa3E@ryzen>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_024830_322778_CA9F25A6 
X-CRM114-Status: GOOD (  13.66  )
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

On Tue, Jul 08, 2025 at 11:38:09AM +0200, Niklas Cassel wrote:
> But NVMe should probably push to deprecate AUWPF, and introduce a new field
> that is like AUWPF but which is specified in a fixed unit, e.g. bytes or
> CAP.MPSMIN. (I'm thinking of e.g. Zone Append Size Limit (ZASL) which is also
> a per controller limit, but the value is specified in units of CAP.MPSMIN,
> just like the Maximum Data Transfer Size (MDTS).)

There's not advantage in having yet another field vs mandating NAWUPF.


