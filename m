Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D320BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pzPEac9qf8uKzme4W7jZluuPgXHk2smbOZYsmh1aHv0=; b=Ufhx6NW1JnLkCW0KucqokudVRr
	CjVt3my7F7JE3WzQwhcRPKfYjQsziymeaYdMd1jJNdePGKeovetc6WxP3wLYHdX2pbmpu6z+DQFTh
	lh2qgFK4UYp6zfrTsto4MfdpWM9EjvsOuCSUzPVJm0kT9Wa0jcUt5P520TOYmcRSnwxP9DV6vK5Hf
	1AGpX2rbKOtXxEd6JBITNZ4LTGKjWAimjoX7jRedLHnUMFQQwgPHh9/HBoRoRwEBADA4lDzz8wJiN
	0WmbGGMG2k5s0UW609fguHuLSAbuYj0ZC1GEzhuW23iNSab3kIo/SnPGsZiZWVlXGzQfuBdKVXVrr
	NE6K65pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negzS-001yjA-JV; Wed, 13 Apr 2022 17:41:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1negzQ-001yhj-Ct; Wed, 13 Apr 2022 17:41:12 +0000
Date: Wed, 13 Apr 2022 10:41:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
 yi.zhang@redhat.com, sagi@grimberg.me, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcLOM49JsdlBqTW@infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlcKqu3roZQSxZe8@bombadil.infradead.org>
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

On Wed, Apr 13, 2022 at 10:38:50AM -0700, Luis Chamberlain wrote:
> On Tue, Apr 12, 2022 at 09:53:12PM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
> > > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> > 
> > I'd suggest to ignore broken tests that require a deprecated option
> > that will eventually be removed.
> 
> CONFIG_NVME_MULTIPATH will eventually be nuked?

You'll only get a single namespace without it once the phaseout is
complete, yes.  If you want nvme multipathing you'll need it, which
is the story since day one.

If Bart wants to test dm-multipath I think his earlier srp_tests are
the much better choice.

