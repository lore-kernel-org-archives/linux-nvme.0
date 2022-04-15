Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31FCC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IL/YFRXP4EfIheg9ThTlHkA3sXF1nKN+0GTzx2wXjkk=; b=p975xuIaKEivmgv+6ZxoGKOi0D
	Su/XIKhhD+FI/Z6HbF8jgeR5tSaoMiQEoJflildSF4DJVxhrXmkAK4k7/kWZonWkKNKekPNxQOrga
	PPrH8avNXG/znN3+C1ae8LE1d6D9avhOgoXamJvH0saWnVkmT1pEHbC/wxVXBHsI44/tUneOdlXs3
	5abjNawRoMzqbNHYH3JjBD/ibQ2VMkysHYAtGj325BTvP+6SXjZbsEqYmbnpxzDqJLDYVVEWV8u6B
	Bx9gXKjBFIHD8ZAxKSq5VjI5x7DhIPzgT0rfXK//566o73noYHrlS8RXuvlIAadReUibsFmt+sP2D
	oQjcqOWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfQEN-00B2ex-Kq; Fri, 15 Apr 2022 17:59:39 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nfQEL-00B2ef-Sd; Fri, 15 Apr 2022 17:59:37 +0000
Date: Fri, 15 Apr 2022 10:59:37 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Bart Van Assche <bvanassche@acm.org>,
 "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
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

On Fri, Apr 15, 2022 at 05:58:16AM +0000, Chaitanya Kulkarni wrote:
> On 4/14/22 22:20, Christoph Hellwig wrote:
> > On Wed, Apr 13, 2022 at 03:46:16PM -0700, Bart Van Assche wrote:
> >> I'm not sure whether the nvme-mp tests test any code that is not yet tested by
> >> any nvme or srp test. How about removing these tests since these tests make
> >> it harder than necessary to run blktests?
> > 
> > I haven't looked at the details recently, but if these tests still are
> > basically a copy and paste of the srp mpath tests I'm all for removing
> > them!
> 
> If it doesn't add a new test coverage in the blktest framework
> then please remove.

That's about 3 block folks not being sure whether or not it helps. And
the complexities of it, to test it, requiring a different kernel seems
just stupid. So I'm going to drop the tests from kdevops and not bother
with them.

With regards to srp tests there seems to be two modules to use. Do we
want to prioritize both just as much? If so then I'll just create two
guests for srp tests.

  Luis

