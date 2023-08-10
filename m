Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A050DC04A6A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 06:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nFGtRGPq2lsVZJYtiPKBHOQS0MoVI3h//P6KNBW8RPk=; b=JVOze2xHdIcHy52BgMeV+SKcEK
	nlXx/OduKcJ+gqYSkPaXpKoWd4YOopJ1r+saxHlnlpQd3ssHMobZq2tmhLMZn9mBaObgbjxK23V/+
	LxizJajAPhzTn3KBSvvXMg44awfRAdUz5Y7HmA6RgVcmKdcgl4x9AF40244HiYmnIPKcEXLocpJHi
	VAnl6s9sNG4c/ZCprB9FYLh/TYG/JYTayA74CwoyZPlF6LLyZ4MY+KCl9R66+bXZXKbmgCr9/xnDR
	hrvHnT4ONJNGTOapQgY5eBWCm8/guBFVnYTucMAmQ3pZHNefVYIs/co88QD2muceT1cVPMSOONBFP
	xajSF/oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTzIo-006gS3-0l;
	Thu, 10 Aug 2023 06:37:46 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTzIk-006gQc-0Z
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 06:37:44 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230810063734epoutp03b0a7d47a28f7c225fee11445dcd4e5e8~58jdHK1fI1514015140epoutp03f
	for <linux-nvme@lists.infradead.org>; Thu, 10 Aug 2023 06:37:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230810063734epoutp03b0a7d47a28f7c225fee11445dcd4e5e8~58jdHK1fI1514015140epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691649454;
	bh=nFGtRGPq2lsVZJYtiPKBHOQS0MoVI3h//P6KNBW8RPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XiyYvfCSh2tURTlt5ZX+Sy0gL/a9x372jRd4BYNhiknD4vbM/Hxc3av9b7ZszfSKH
	 tlIKKW/eUtLxZ27P/BIKpyAAlucgGwXjb6Fh++wyiSreBidn+Dn3taACwQE1Q+KeMv
	 XCA1WnfdtZRWpBGYjRMONbGxpg3BrAjO15kmr1i0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230810063733epcas5p1739ecaffcebdbe51ca688d8beb8dd4e8~58jc1UbyO3259232592epcas5p14;
	Thu, 10 Aug 2023 06:37:33 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4RLy0D35Q3z4x9Pt; Thu, 10 Aug
	2023 06:37:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.4D.44250.CA584D46; Thu, 10 Aug 2023 15:37:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230810063732epcas5p326808a29ec3e75dfc6c8f1262f1b1740~58jbDE8Rd1665116651epcas5p32;
	Thu, 10 Aug 2023 06:37:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230810063732epsmtrp16fab55d9fa0397c51748fac86b39797e~58jbCRtta0577905779epsmtrp18;
	Thu, 10 Aug 2023 06:37:32 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-a4-64d485ac1c5f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.BD.64355.BA584D46; Thu, 10 Aug 2023 15:37:31 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230810063730epsmtip181e590b0d0b8aa13b59d1d1fcaec1cd9~58jZ-RdTT2499824998epsmtip11;
	Thu, 10 Aug 2023 06:37:30 +0000 (GMT)
Date: Thu, 10 Aug 2023 12:04:11 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, Guangwu
	Zhang <guazhang@redhat.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme: core: don't hold rcu read lock in
 nvme_ns_chr_uring_cmd_iopoll
Message-ID: <20230810063411.GA13970@green245>
MIME-Version: 1.0
In-Reply-To: <ZNNF/2NEPYCeiXlM@fedora>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmpu6a1ispBm/3C1s0TfjLbLHkym4W
	i5WrjzJZTDp0jdFi/rKn7BaHJjczWax7/Z7Fgd3j/L2NLB6bVnWyeWxeUu+x+2YDm8f7fVfZ
	PPq2rGIMYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
	y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVo
	YGBkClSYkJ0xacE01oL33BXNL/rZGhg/cXYxcnBICJhInPmQ18XIxSEksJtRoufZGlYI5xOj
	xO55X5ngnHndM4EynGAdK/83s0MkdjJKXPm0HMp5xiixf90bdpAqFgFViUWftrOD7GAT0JS4
	MLkUJCwioCRx9+5qsHpmgYuMEtM/rQObKiwQLbH9/SIWEJtXQFei8+M/JghbUOLkzCcsIHM4
	BdQklq2XBgmLCihLHNh2HOw6CYFGDolTH9czQ1znInF+SzfUpcISr45vYYewpSRe9rdB2ckS
	l2aeY4KwSyQe7zkIZdtLtJ7qB5vDLJAhsfXqQnYIm0+i9/cTJkh48Up0tAlBlCtK3Jv0FGqV
	uMTDGUugbA+JyffaoWFymlHi68ozrBMY5WYheWcWkhUQtpVE54cm1llAK5gFpCWW/+OAMDUl
	1u/SX8DIuopRMrWgODc9tdi0wCgvtRwex8n5uZsYwalTy2sH48MHH/QOMTJxMB5ilOBgVhLh
	tQ2+lCLEm5JYWZValB9fVJqTWnyI0RQYPROZpUST84HJO68k3tDE0sDEzMzMxNLYzFBJnPd1
	69wUIYH0xJLU7NTUgtQimD4mDk6pBqY412Q3hkquayfYt/1gOlJ1xcy1em/+h1s6Rt9WTNR0
	uruR7W3uVP5F8cpT8j2+m2gauykaPepdX+GumlbAseOghXjWZPb87gkChbHX/so2P2ZcuOm0
	rur+WcXXs1MPpHW1Mh9Xtd3zab79avHb9Sv4nBZxrJao2GDP83iGneH6D7VHn6z9tlqy+NGs
	8lfS0zK2v9F75aNXVq75oWvyR9fUUn7N2/9P3xYrltzk8v5S4aGQo78+/3Ez/fLO/ushry8x
	EjyTcjTnG/DvEbu77cHJXbWVD//E7t2gdKRw16kp7ivY4q85X248Wu3Vo3Pnbsrzl9eZai61
	/Pk0eXO/caL6slVveb9tdT4k6Pzw+TJdJZbijERDLeai4kQA5yayWyYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO6a1ispBvMtLZom/GW2WHJlN4vF
	ytVHmSwmHbrGaDF/2VN2i0OTm5ks1r1+z+LA7nH+3kYWj02rOtk8Ni+p99h9s4HN4/2+q2we
	fVtWMQawRXHZpKTmZJalFunbJXBl7P2wlb1gIWfFkam/mBsY97F3MXJySAiYSKz83wxkc3EI
	CWxnlFjY+xUqIS7RfO0HlC0ssfLfc6iiJ4wSrc+2MoIkWARUJRZ92g6U4OBgE9CUuDC5FCQs
	IqAkcffuarB6ZoHLjBIzb+xlBUkIC0RLbH+/iAXE5hXQlej8+I8JYuhZRokXE14zQyQEJU7O
	fAJWxCxgJjFv80NmkAXMAtISy/9xgJicAmoSy9ZLg1SICihLHNh2nGkCo+AsJM2zkDTPQmhe
	wMi8ilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4BrSCdjAuW/9X7xAjEwfjIUYJDmYlEV7b
	4EspQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUw96XcT
	6s9dtQ1uTueNvBHD/iZD7/+Xw/LWzOmx7ZcuPgmtmzzjvebFw2yrAzzdVIVUQibfXMx+u7pT
	ebnfGuNJLLuOZSec+cf1WD5SymDXzTUrZ8r+Yn6lIb7cXGfLzJrly/eJbjx4c4rt5Fl+CsVW
	T1YlBb769GRODafyqr2n7c5mrNHSjZ4y9eJJ3leqrLHafyMLJq158Tj747kTc/esCFp7+I7W
	0b1y6S1v5U/nbli4+EyVV5jdss9LZ+sWn2pLNC6d6ecq0Zh4QYzR4aZK+z1m9s35HrsvHAmV
	/yd076uB7I4NS05fuLDvyZFI8X+XilbvfhM5w3bxsdKqw8vXn3nANIfz/Oo1D4J3THv4NFKJ
	pTgj0VCLuag4EQCz8MGO8AIAAA==
X-CMS-MailID: 20230810063732epcas5p326808a29ec3e75dfc6c8f1262f1b1740
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_43047_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230809020844epcas5p30e520491fa59ab8c20836d4275931e8f
References: <CGME20230809020844epcas5p30e520491fa59ab8c20836d4275931e8f@epcas5p3.samsung.com>
	<20230809020440.174682-1-ming.lei@redhat.com>
	<20230809065920.GA19415@green245> <ZNNF/2NEPYCeiXlM@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_233742_987455_0AB8F765 
X-CRM114-Status: GOOD (  17.91  )
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

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_43047_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Aug 09, 2023 at 03:53:35PM +0800, Ming Lei wrote:
>On Wed, Aug 09, 2023 at 12:29:20PM +0530, Kanchan Joshi wrote:
>> On Wed, Aug 09, 2023 at 10:04:40AM +0800, Ming Lei wrote:
>> > Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based io
>> > polling, and the associated NS is guaranteed to be live in case of
>> > io polling, so request is guaranteed to be valid because blk-mq uses
>> > pre-allocated request pool.
>> >
>> > Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
>> > isn't needed any more after switching to request based io polling.
>>
>> > Fix "BUG: sleeping function called from invalid context" because
>> > set_page_dirty_lock() from blk_rq_unmap_user() may sleep.
>> >
>> > Fixes: 585079b6e425 ("nvme: wire up async polling for io passthrough commands")
>> > Reported-by: Guangwu Zhang <guazhang@redhat.com>
>>
>> Thanks Ming. Looks fine, but any link to this report?
>> I don't see this breaking in my tests. So I wonder how to reproduce and
>> improve the coverage.
>
>It is reported in RH BZ2227639, and follows the stack trace:

Tried to access, but no luck.
Any chance that steps can be posted here?

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_43047_
Content-Type: text/plain; charset="utf-8"


------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_43047_--

