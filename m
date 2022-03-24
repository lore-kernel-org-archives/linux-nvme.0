Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C96C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RXT+F/Ra9tEyH+GWgw8Y1vf3qfYJJwKpOBJtKxL5UvY=; b=XYXmiAmQ0wQVHb9zfbRU29ktFe
	Q3TEhbkXlPNp4mm1rkdFKTjlZ5lACQ7LUKV8hi2Bq5kAz2mxFYxnvx0hXd9549x2823QRyUyjLXXW
	bkKZuVZTboyRQUnFr4lf9p5BmR8Nzleq2dWH2XIW2/SvS7c81E9h3xz90qyu11XUcgsfeClxDM5u6
	TJtse7z/0Iq3JqQW0RHNK5ZqBZtHVBZquaHICBGh57VqHYV9b17lskmuEfDUz4oTcfClZwA/VeKoH
	rtoQ/C8iE1zNmhPbKHXETYFAcoEXhaG1jQaICcpZX0yHEu0GtGlZJHEI//RTPTugSAzaBpMzycVkQ
	5e98ZXKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGqC-00FoTh-NV; Thu, 24 Mar 2022 06:21:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXGq9-00FoSQ-Ox
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 06:20:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E22FC68C4E; Thu, 24 Mar 2022 07:20:53 +0100 (CET)
Date: Thu, 24 Mar 2022 07:20:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshiiitr@gmail.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Message-ID: <20220324062053.GA12519@lst.de>
References: <20220308152105.309618-6-joshi.k@samsung.com>
 <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
 <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
 <8f45a761-5ecb-5911-1064-9625a285c93d@grimberg.me>
 <20220316092153.GA4885@test-zns>
 <11f9e933-cfc8-2e3b-c815-c49a4b7db4ec@grimberg.me>
 <CA+1E3r+_DEw5ABPbLzSp9Gvg6L8XU-2HBoLK7kuXucLjr=+Ezw@mail.gmail.com>
 <3ed01280-5487-7206-a326-0cd110118b65@grimberg.me>
 <666deb0e-fa10-8a39-c1aa-cf3908b3795c@kernel.dk>
 <28b53100-9930-92d4-ba3b-f9c5e8773808@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b53100-9930-92d4-ba3b-f9c5e8773808@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_232057_983182_81EE59EE 
X-CRM114-Status: GOOD (  18.96  )
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

On Wed, Mar 16, 2022 at 04:50:53PM +0200, Sagi Grimberg wrote:
>>> I know, and that was my original question, no one cares that this
>>> interface completely lacks this capability? Maybe it is fine, but
>>> it is not a trivial assumption given that this is designed to be more
>>> than an interface to send admin/vs commands to the controller...
>>
>> Most people don't really care about or use multipath, so it's not a
>> primary goal.
>
> This statement is generally correct. However what application would be 
> interested in speaking raw nvme to a device and gaining performance that
> is even higher than the block layer (which is great to begin with)?

If passthrough is faster than the block I/O path we're doing someting
wrong.  At best it should be the same performance.

That being said multipathing is an integral part of the nvme driver
architecture, and the /dev/ngX devices.  If we want to support uring
async commands on /dev/ngX it will have to support multipath.

