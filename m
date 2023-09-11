Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE1EEE7FF4
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 07:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=41ypZhWCBmNAXL8iu5S6DXWnNQ2Hoq08FmP9zKAN93o=; b=CPGmw4k106a6Cs817j1u4wkP8L
	+VhLFU4GkIQ3TMvVxqHKA+GaoU1YRsumL+8lRnN56PhU9CUFHMdkL1dKuva/kXU1Dean4h+bu2E6V
	+zEAsq6pXI+fLmnh1GZFi7ZacsxW1TResvJIrJPVT9tJycRKv2hJtwXIEGppv4f8jMbDC7Hpr35kK
	mOX1DM3xYNSgdir2StkY0+3/n3V025zaVx42jBQIzgh62aA3pJ8CqtVQeFXt7dJ2L59kwBwdc6acS
	p6YwwEW8m6PXmhbvruY2zrCsIkXnAYGetWtKUQZKY0aQqI0Fh55LiVrLtcbeKWi85Z9rvyHK+u6Ot
	jyCOBDJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbLN-00HPRN-1I;
	Mon, 11 Sep 2023 07:28:25 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbLJ-00HPP8-1t
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 07:28:23 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230911072816epoutp03e7fc884985a77a6acf336887983af63f~Dx42ttue90196901969epoutp03T
	for <linux-nvme@lists.infradead.org>; Mon, 11 Sep 2023 07:28:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230911072816epoutp03e7fc884985a77a6acf336887983af63f~Dx42ttue90196901969epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1694417296;
	bh=41ypZhWCBmNAXL8iu5S6DXWnNQ2Hoq08FmP9zKAN93o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d94Fi3oQdw43vLTLqiTCLVvXtNsBzcSAuiBcGOy1mJoSat+OvRF4cqecU6Z3olFy3
	 djfr/Hxtk5uQSYzN4SxdHb25FZOGhwDvfNHmv7gkLWNMBkzbqZK3dlD+hUxeYXr2ZP
	 6q3jvEKTXcKwHP7qNPeB/qOpH6UMhrSEPjD0uI0s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230911072815epcas5p4e1db6037f39389ed18eed8c5dff8cf21~Dx42ZcxS72592325923epcas5p4V;
	Mon, 11 Sep 2023 07:28:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Rkdbx6sLDz4x9Q3; Mon, 11 Sep
	2023 07:28:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.D8.09638.D81CEF46; Mon, 11 Sep 2023 16:28:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230911071540epcas5p297dd9e968175a690230b83070db95297~Dxt212gQZ1723917239epcas5p2p;
	Mon, 11 Sep 2023 07:15:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230911071540epsmtrp100882cc832a2441441fad12d7d2e2b71~Dxt2yHsCa1482314823epsmtrp10;
	Mon, 11 Sep 2023 07:15:40 +0000 (GMT)
X-AuditID: b6c32a4a-6d5ff700000025a6-27-64fec18d9268
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.D4.08788.C9EBEF46; Mon, 11 Sep 2023 16:15:40 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230911071535epsmtip19947303bee5f25ef26e583ff9e5e7a01~Dxtyjz6fl0330403304epsmtip1k;
	Mon, 11 Sep 2023 07:15:35 +0000 (GMT)
Date: Mon, 11 Sep 2023 12:39:37 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, martin.petersen@oracle.com, mcgrof@kernel.org,
	gost.dev@samsung.com, Vincent Fu <vincent.fu@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 04/12] block: add emulation for copy
Message-ID: <20230911070937.GB28177@green245>
MIME-Version: 1.0
In-Reply-To: <e6fc7e65-ad31-4ca2-8b1b-4d97ba32926e@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH97ttby+PsruK7GcZCpfJVlyhZQVuFdBsul3nzIhjRsmSWts7
	YNDHelsfWxYQeTMeOpaNsiEbiPKISCE+KGysuFVQwhJTJmQgIDAVEewCy5yUUVoW//v8zvc8
	fuecHIzFL+YKsDSNgdZrFBkE6s2+1CMUikp+dqrEjnEp2dL3K4vMLl9ikU0jZSg50+MA5GR3
	PiC7HlVxyKHuqwjZ+cNphGxo+gUhT1sHATllNyFk1/AW8vu8OjbZ2dXLJm91fIuSZ+qnuOQ5
	mxMhb5dPAfLCzBybvD4cSN4tLgDkwJKNsyOAGhhtZVO3+o2UubEQpdrqMinLUBZK1ZZ+yaFK
	Tj5CqcdTw2xq7kc7SpW2NwKq7cZn1F/mjZR5chZJ5CWnx6XSChWtD6Y1Sq0qTZMST+x5X/6m
	PDpGLBFJZGQsEaxRqOl4Yue7iaK30jJWmiaCjygyjCumRAXDEJEJcXqt0UAHp2oZQzxB61QZ
	OqkuglGoGaMmJUJDG7ZKxOKo6BXHQ+mpF2tyuLpcv2PN18pZWeAnnyLghUFcCh1NNk4R8Mb4
	uAXAhamLqPvhANA5P+JRFgGsuONkr4Xk90+vMh/vAvDpqTC30zSA/darwCWw8c3w6dAiqwhg
	GIpvgTeWMZfZHyfg43wr1+XPwhs5cOTkKNclrMPj4Oz0TdTFPFwEzVYr180vwN7KydViXvg2
	aK6tXvVZj4fC7ks2xJUI4me8YFXBrOd3O2H1wD2Om9fBB7Z2rpsF8H5ZnoePwoaK86g7OAdA
	0+8m4Ba2w9y+MpaLWXgqvFM04UkUBL/qu4C47X6w5N9JxG3nwSvVaxwKm1tqUDdvgIN/n/Aw
	BS2Ttz1znAfw4VgFKAebTM90Z3qmnptfgzUWB2pamR4LD4TnnJgbhbClI7IGcBrBBlrHqFNo
	JloXpaGP/r9ypVZtBqtXEf7OFTA+Nh9hBQgGrABiLMKfZ7Auqfg8leL4p7ReK9cbM2jGCqJX
	tnWKJViv1K6clcYgl0hlYmlMTIxU9nqMhHiRN5P7nYqPpygMdDpN62j9WhyCeQmykMokv1mh
	YPcJ7dZ9z+29l72A5RBPtoXtaViYC/+GKh3AgoQLpVVKi6Nk43lt2REw+Mm1kYlNoyHLxzpr
	E9TPd3z9SujLHwTUJzsXCWvSxxLmbdQmKMxMV6LKsn3Cjzbzencf9M7pkReMQ/7NcnNrvUx5
	eCjLu+dA+Be1r9ZdJo6L3nu4aGWcewsDDbt8xGfbn0TuMrPbkPsLzli7RZqsijIFRSaoQyce
	kIMv1TSn1yX5BmT+EeIl3M925BDJlWGVH8qEMrvP528ois/6/zmWi9Xvv26/fMjewhw8cLh/
	1DcBGIcjGn6j74pad2T+k7cszxZ0RoREan37/Y2ZsaFJYwSbSVVIwll6RvEfTPzr9p4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RWUwTURiFvTPTYajWTIvLhYoPRR6oFgXUXBQVo5iRB2MgxKAYrHYoBiik
	ZRUTEaPgXms0ssSFpSqQGgtBpUBgUEGgIBIUmkDUFkQJi0qqUSjaotG3k/9855yHn8JFnYQX
	dVSVyqpV8kQJySdqWyQrZcWNDsW6avsi9KD9OY5ytbM4qhy8TKKxli8A2ZryAGqYKOKhgaYn
	GKov0WHofuUzDOm41wAN9xViqMGyGt05U0ag+oYXBOqtKybRLf2wG7rb6sBQv3YYIMPYJIHa
	LGJkPZ8PUPdsKy90GdM99JBges1pjLHiLMlUl51gTAM5JFN66SqPuXhqgmQ+D1sIZrKxj2Qu
	1VQAprojm/lqXMkYbePYXsF+foiCTTyazqrXbj3Ej58evMpLebYwM7/xNJEDbrifA+4UpNfD
	PPMIcQ7wKRFtArDo+ZTbvOEJ9bNP8XntAe87PrjNQzYAOztaXBBB+8KZAftviKJIejXsmKOc
	5yW0BH7O41w8Tht4cE7bzHMaHnQIHB/pJJ1aQMugkeP+lE4B2FNmAvOGEL4osBFOjdNS2O/4
	iDkHcFoM7zpcA+70ZmgsvenqWUr7wKbaVkwLhIX/pQv/Sxf+S98GeAXwZFM0ScokTUBKoIrN
	8NfIkzRpKqX/keQkI3A9XCp9DOorpvw5gFGAA5DCJUsEqdysQiRQyLOOserkWHVaIqvhgJgi
	JMsF9rGLChGtlKeyCSybwqr/uhjl7pWD0ZFvNR9DagxDMTJd6ZXg5ME44SC7w2LHTj6hxmqb
	tHyJKfqRzdvfR1ZUfOFU+9z1KOzn4aAIY+ZknlAn3NTFPY7ZHjnXNuP2LnxNvtWqL2juj++q
	O1BeHjcdDDau0P1I9ii4N+q5ZdT3U7c451uM6HilYmL3my+j5g1hQVFxBnEaL9BDb7bvM18b
	XxA63cZ+r8kN7C7xVWcpX2burDPdiVjsl85Zq/jZYRa/H7my5jC/PTWbjySEey3qyrZ6zwxk
	5I5G65+u2mZ4hUl7IqeDlDvSLbHZGcE2x/uDsZkLswSHvc/a34Rju0Lt7aqqKKusvK94lehy
	z6PUjmW95HYJoYmXB0hxtUb+CxdGZ7VfAwAA
X-CMS-MailID: 20230911071540epcas5p297dd9e968175a690230b83070db95297
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----EkYAGCX2vluH006HpQv8E927.wBqYttzOq6t00vxo_cq_k4p=_daaf4_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164321epcas5p4dad5b1c64fcf85e2c4f9fc7ddb855ea7
References: <20230906163844.18754-1-nj.shetty@samsung.com>
	<CGME20230906164321epcas5p4dad5b1c64fcf85e2c4f9fc7ddb855ea7@epcas5p4.samsung.com>
	<20230906163844.18754-5-nj.shetty@samsung.com>
	<e6fc7e65-ad31-4ca2-8b1b-4d97ba32926e@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_002821_972926_A80C126A 
X-CRM114-Status: GOOD (  25.09  )
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

------EkYAGCX2vluH006HpQv8E927.wBqYttzOq6t00vxo_cq_k4p=_daaf4_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Sep 08, 2023 at 08:06:38AM +0200, Hannes Reinecke wrote:
> On 9/6/23 18:38, Nitesh Shetty wrote:
> > For the devices which does not support copy, copy emulation is added.
> > It is required for in-kernel users like fabrics, where file descriptor is
> > not available and hence they can't use copy_file_range.
> > Copy-emulation is implemented by reading from source into memory and
> > writing to the corresponding destination.
> > Also emulation can be used, if copy offload fails or partially completes.
> > At present in kernel user of emulation is NVMe fabrics.
> > 
> Leave out the last sentence; I really would like to see it enabled for SCSI,
> too (we do have copy offload commands for SCSI ...).
> 
Sure, will do that

> And it raises all the questions which have bogged us down right from the
> start: where is the point in calling copy offload if copy offload is not
> implemented or slower than copying it by hand?
> And how can the caller differentiate whether copy offload bring a benefit to
> him?
> 
> IOW: wouldn't it be better to return -EOPNOTSUPP if copy offload is not
> available?

Present approach treats copy as a background operation and the idea is to
maximize the chances of achieving copy by falling back to emulation.
Having said that, it should be possible to return -EOPNOTSUPP,
in case of offload IO failure or device not supporting offload.
We will update this in next version.

Thank you,
Nitesh Shetty

------EkYAGCX2vluH006HpQv8E927.wBqYttzOq6t00vxo_cq_k4p=_daaf4_
Content-Type: text/plain; charset="utf-8"


------EkYAGCX2vluH006HpQv8E927.wBqYttzOq6t00vxo_cq_k4p=_daaf4_--

