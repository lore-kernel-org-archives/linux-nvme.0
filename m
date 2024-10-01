Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD3CEACE5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2024 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GGOC07/e5j7kNuABhl9ggJVthMY4M6MA0mwKxxHdYuM=; b=CNy/Q2y+rjhEh/eMujvztzvYvA
	Z6Zz30u1j+jgwh9EPew6K9Sz6HEexEYzp0xwJUgHD4oTLB7AByMgYG82kNibYVglaptg+r+tN01VX
	OdxOdDWmkH0SwSDBanaw0zqCNhcckWKzkU1i9C3W91Yncbtz4B1qmHSvsk+dVI4mOI+k88Tlhy8kc
	rEJjyxKVTO6inABQ5oFxT+sO0iDwzrt0ELgJOKVYuPWvX1drpQJVAb83H5gtMS4Sc6dclRQRaDx8U
	PxKWOQXngybkuEHoEDu6h6kzFVqeBOBIuImIFcIl5qnWuwPO/s06SvSwCVCiQZQHsS55y4Eor2jd8
	Xz0ftW9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svffC-00000003XqP-0hPP;
	Tue, 01 Oct 2024 16:23:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svff9-00000003Xpb-2Ny3
	for linux-nvme@lists.infradead.org;
	Tue, 01 Oct 2024 16:23:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 72655A40FA6;
	Tue,  1 Oct 2024 16:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70583C4CEC6;
	Tue,  1 Oct 2024 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727799826;
	bh=w1g+MZ8OSr/yI8Fxcdx00lY1A/TRv9HBlLNAipFFr4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kt3ZiVnQmIb8+1XZ90iic2VM1jfsyrND5B4ffPweDTWhMOiqLSg8NggcpsKJQQzAT
	 fYshWYHV3OCZHoBd3QpRA5vaJ3H0uTIhvQyFK+mkjycQJSz9PyeA/VFKMUVw2wcjTW
	 nww5w4oxIPPZj4JftoHAFJhDqITWfTH0S69I4fi7pUPsUBM1rDw3xUqdCUu/hFpelN
	 w+8rsT0uQYEfA+rU72UpXCZYEttyUltTImUSsrEM+6i8dljg1UQMSXBEzZOPkUSBQx
	 gwYl6aUzfgi/lBIwG07o3VQYJkRInrnFRxFre40mKG4OHMTIeYTcIZtbSOFW6Odseq
	 KeNx+LcN5mT+w==
Date: Tue, 1 Oct 2024 10:23:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hare@suse.de,
	sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <ZvwiD0v3ASF8Hap2@kbusch-mbp.mynextlight.net>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241001092047.GA23730@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001092047.GA23730@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_092347_690486_1911B116 
X-CRM114-Status: GOOD (  12.89  )
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

On Tue, Oct 01, 2024 at 11:20:48AM +0200, Christoph Hellwig wrote:
> Any reason you completely ignored my feedback on the last version
> and did not even answer?
> 
> That's not a very productive way to work.

I think because he's getting conflicting feedback. The arguments against
it being that it's not a good match, however it's the same match created
for streams, and no one complained then, and it's an existing user ABI.
FDP is a the new "streams", so I really don't see a big deal here. I
understand you have use cases that have filesystems intercept the hints
for different types of devices, but I don't see these use cases as
mutally exclusive. Supporting this one doesn't prevent other uses.

