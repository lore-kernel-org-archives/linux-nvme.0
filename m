Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163BAC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 21:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6SrLsiZNR7I2d24mmXxAcEAkf9sreW64GXvKPxhXEY=; b=PISUXmDVioU6Ltn7KopfLk3uLV
	TkEYRrtvZFIjssDQXsPUMLAdhZP3DDGwJ9PR+KQoSTEr8oRRmvcs1NKWr4JgDoY0VqgXL6cx0f8Yc
	bjQHm3BpZy3SkzNO2LWglre0TiQwlY8OgGK5B8qLIm4B5Na5bKaLFEMz+EUWGtd5dtKdzXtTcV58n
	pG8oZ/HGahO+eBk2zvZfJ02+IuE/Kr6M/qcpHl7x1ILd/gIfHPC8w4i7eugsR5iqhr8ytZIviO7rp
	SGxHAOQDtCLxeuiZxF4Rd7YLptYYGIfEFBK9bmd7biFKhsMJ95/B51gFEIrb3BwUgE8B9Kg5ABXbj
	4m8cNevw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSmqr-000LUe-OY; Fri, 11 Mar 2022 21:31:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSmqo-000LTv-LZ
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 21:31:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 272CC61FB5;
 Fri, 11 Mar 2022 21:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8779EC340E9;
 Fri, 11 Mar 2022 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647034265;
 bh=hYel3HbpvLen6sZ3euben+avywStvvz0gp95k3KsGBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qpUuCWrCbsGl/LITMp1atVWBazFlnkYOWtEbc3DsKA1++oysWd5hGW3/PXkhS7ZY0
 CpKdqSlg9/3iwHmT0vTqdf7tXpplB6NPuoqnlDf8nLqRs5QF7ojqd6R+WYXC3lqoqc
 TkgSoYtCNLGAEeCZNv7aT1hg3sUKBpD6CposEQkRKdJFNFi1rk8W1XLZDUJDbXEWw0
 BwS26apkIj8l9pqKb6G+ElCEk6ELp9mDMA7eaon6rTbtOEAtF487QSpoMXGg1PUZb0
 2LZFD93Sf/Fg6pzvjLjbh9eyCdXfgZO4lASBKSBA04rjA5MgjKTLYqfrC7Fr35lzB4
 O8jwE1TKTUznw==
Date: Fri, 11 Mar 2022 13:31:02 -0800
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_133106_773233_C8EF8D43 
X-CRM114-Status: GOOD (  11.96  )
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

On Fri, Mar 11, 2022 at 01:04:35PM -0800, Luis Chamberlain wrote:
> On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
> 
> > I'm starting to like the previous idea of creating an unholey
> > device-mapper for such users...
> 
> Won't that restrict nvme with chunk size crap. For instance later if we
> want much larger block sizes.

I'm not sure I understand. The chunk_size has nothing to do with the
block size. And while nvme is a user of this in some circumstances, it
can't be used concurrently with ZNS because the block layer appropriates
the field for the zone size.

