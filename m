Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E37CFA749
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 06:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9Gv2ForhV6hTrvVmLhgEigzeBV339w4jLSMQBIETrk=; b=0bL9xVx0UqGfJJ+KOLekPOdic/
	ws7NffMToP7Y6lCrBe+ZbnYoKunNPtmuxBsfXSYm9jYMNRTN3Qc2fO9ylfM3CXtAbeE/3oTRRTowh
	aBR6JngivCeAm2FMdwpFbxsMWNXOO4iQPLi4magOR1Qtb1RHxNMiONL7kyexQtfgdsWeV2HRvjwda
	b0vtuezU4OWW0KT9sN7hw1NBx51H21DxFrmngA8hRgE9SFPZ9XYLweFMyfe7MZbkfM+L9piiZ5MBe
	87t+kYmxxhd9rRiXSW6nAU1P614L7j9K2MDbP5mVREOKahysuL5ET6FY+VjR/+78UZooH3WaxvnI0
	gsuAHw+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swbh3-0000000B7WT-23vg;
	Fri, 04 Oct 2024 06:21:37 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swbh0-0000000B7W1-1MGW
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 06:21:36 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241004062133euoutp0185a670e9328f9082e92e8b7fb601daec~7K6pwP6h81464514645euoutp01f
	for <linux-nvme@lists.infradead.org>; Fri,  4 Oct 2024 06:21:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241004062133euoutp0185a670e9328f9082e92e8b7fb601daec~7K6pwP6h81464514645euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728022893;
	bh=F9Gv2ForhV6hTrvVmLhgEigzeBV339w4jLSMQBIETrk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Cwln0NeAKRONWcjeVFsGuWT6Lnpliv6ZhlzAKIrg3xPLii+qtbp1YzfOa52Hm3JQ4
	 JFANKF5hB7iCa+BTCY/Ryi0+U82jZh5ZkJHwAXvhggASqB8fYF9oP8DZ0oDAuTEX8V
	 SrgsToiMjfSLucTMPyQeoxNsD/MvKoHauvjbqGPA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241004062132eucas1p26097cf9947f923223405394528ad8773~7K6peLcOZ2042120421eucas1p2B;
	Fri,  4 Oct 2024 06:21:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 99.DF.09875.C698FF66; Fri,  4
	Oct 2024 07:21:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241004062131eucas1p2ee4e9ef12627dd234ff9812807c9e04d~7K6oqc2S62042120421eucas1p2-;
	Fri,  4 Oct 2024 06:21:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241004062131eusmtrp203580cb9fe83d3cd8e4aaf08dd6091b6~7K6oprF391557815578eusmtrp2O;
	Fri,  4 Oct 2024 06:21:31 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-bf-66ff896c6a94
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.51.19096.B698FF66; Fri,  4
	Oct 2024 07:21:31 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241004062131eusmtip1c6cdc7643a8ac562e3f26ac833a4af04~7K6oYk-911305713057eusmtip1k;
	Fri,  4 Oct 2024 06:21:31 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 4 Oct 2024 07:21:30 +0100
Date: Fri, 4 Oct 2024 08:21:29 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>, <hare@suse.de>,
	<sagi@grimberg.me>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>,
	<jack@suse.cz>, <jaegeuk@kernel.org>, <bcrl@kvack.org>,
	<dhowells@redhat.com>, <asml.silence@gmail.com>,
	<linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<io-uring@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-aio@kvack.org>, <gost.dev@samsung.com>, <vishak.g@samsung.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241004062129.z4n6xi4i2ck4nuqh@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20241003125516.GC17031@lst.de>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7djP87o5nf/TDK5+ULaYs2obo8Xqu/1s
	Fl3/trBYvD78idFi2oefzBbvmn6zWOxZNInJYuXqo0wW71rPsVjMnt7MZPFk/Sxmi0mHrjFa
	TJnWxGix95a2xZ69J1ks5i97ym6x/Pg/Jot1r9+zWJz/e5zVQdjj8hVvj52z7rJ7nL+3kcXj
	8tlSj02rOtk8Nn2axO6xeUm9x+6bDWweH5/eYvF4v+8qm8eZBUeA4qerPT5vkvPY9OQtUwBf
	FJdNSmpOZllqkb5dAlfGnhdTWAtmclRMPNzD3MB4ia2LkZNDQsBE4sbSJUA2F4eQwApGifbf
	f5kgnC+MEh2bvrJDOJ8ZJVpXHmOBadn7aSFUYjmjxL/lh5jgquauPssC4WxmlHj/8RszSAuL
	gIrEgZsvmEBsNgF7iUvLboHFRQSUJJ6+OssI0sAscIlF4tbFM2BnCQsYSLz/3gtm8wrYSiz/
	sZcJwhaUODnzCdgdzAJWEp0fmli7GDmAbGmJ5f84QMKcAjoSZ17sZoY4VUni8Yu3jBB2rcSp
	LbfALpUQ+Mcp0XhjCyNIr4SAi0TfB0GIGmGJV8e3sEPYMhL/d85ngrCrJRpOnoDqbQGGRcdW
	Vohea4m+MzkQNY4SB1/9ZoYI80nceCsIcSWfxKRt06HCvBIdbUIQ1WoSq++9YZnAqDwLyV+z
	kPw1C+GvBYzMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQKT5ul/x7/sYFz+6qPeIUYm
	DsZDjBIczEoivPO2/00T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoE
	k2Xi4JRqYBL/dPW53rGZsyXa5jWkZasnPTRPvdN4T2HR/Blpm5/NtfWX4F7FrrqqI1NULnYe
	16rY67uWnfsbsyCn7qzPbOnkaSU7dp1SfN9/2WhK8KJz5XMWdu3N11tjazV/l3rRsncXQxVY
	9lzqs7nc4v+PhT9Jc0Iol7fZyqKL8woizivmSPXMDgu5xb9k1/MvzhGBi3WWbf7zg+XQoj1a
	L608AySV/srm+j+I+GVQLtvJqNvseVrlpA9v/5V9L62aVklOTa55oLpcLeCyzOqzhzwSNQ/o
	XFW4PUFWjeG/kSTTNSbbxSsPHJ9c/oWx8u2Ov16zVZ6Ef7wnskU7pV7l5zynnbt85dxeS2Rq
	Wp0VbXmydq0SS3FGoqEWc1FxIgAn1AT+CQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsVy+t/xu7rZnf/TDG616VnMWbWN0WL13X42
	i65/W1gsXh/+xGgx7cNPZot3Tb9ZLPYsmsRksXL1USaLd63nWCxmT29msniyfhazxaRD1xgt
	pkxrYrTYe0vbYs/ekywW85c9ZbdYfvwfk8W61+9ZLM7/Pc7qIOxx+Yq3x85Zd9k9zt/byOJx
	+Wypx6ZVnWwemz5NYvfYvKTeY/fNBjaPj09vsXi833eVzePMgiNA8dPVHp83yXlsevKWKYAv
	Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jz4sp
	rAUzOSomHu5hbmC8xNbFyMkhIWAisffTQvYuRi4OIYGljBI3rhxmhUjISGz8chXKFpb4c62L
	DaLoI6NEw/2LUM5mRoltm1YwglSxCKhIHLj5ggnEZhOwl7i07BYziC0ioCTx9NVZRpAGZoFL
	LBK3Lp4B2y0sYCDx/nsvmM0rYCux/MdeJoipt5gl1v7YwQSREJQ4OfMJC4jNLGAhMXP+eaBJ
	HEC2tMTyfxwgYU4BHYkzL3YzQ5yqJPH4xVtGCLtW4vPfZ4wTGIVnIZk0C8mkWQiTFjAyr2IU
	SS0tzk3PLTbSK07MLS7NS9dLzs/dxAhMH9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8M7b/jdN
	iDclsbIqtSg/vqg0J7X4EKMpMCwmMkuJJucDE1heSbyhmYGpoYmZpYGppZmxkjgv25XzaUIC
	6YklqdmpqQWpRTB9TBycUg1MXV/zBPy2RW1x+L7DTazUY0lt1qErW0Um2zuzf/n3xmbVtKd9
	Nns1kx1qDrMeDPhz4crCqZ1rLl084n8iV6x/WZfS/wWW9hqqoRK3jzzrfPLYleFfgMrcJWVp
	9S9Cz/7YempqmOWnheVWX2dU+QbFMJirfGawnbuwz3z9tbnnvhc9v275wLbnoJFe2++zMjmH
	bkjfX77Iw+8K0+9Fj3LU907p/e9rtC47XOtM8ZeVU3UPqN6NrV1t0DDzxX0GHY5fqws61wjo
	8Sw6cO0In9OTjG/bNjJM/jpRcP+RU6suF8SWW8Scu+DDsTLq1rQKuyr2jy6bFCc6XeCUN5/5
	LXLpkaKAxXohFaIzFCsWmE1+/E2JpTgj0VCLuag4EQBtph7sqAMAAA==
X-CMS-MailID: 20241004062131eucas1p2ee4e9ef12627dd234ff9812807c9e04d
X-Msg-Generator: CA
X-RootMTR: 20241003125523eucas1p272ad9afc8decfd941104a5c137662307
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241003125523eucas1p272ad9afc8decfd941104a5c137662307
References: <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
	<20241002075140.GB20819@lst.de>
	<f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
	<20241002151344.GA20364@lst.de>
	<Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
	<20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
	<a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
	<CGME20241003125523eucas1p272ad9afc8decfd941104a5c137662307@eucas1p2.samsung.com>
	<20241003125516.GC17031@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_232134_654145_875DC523 
X-CRM114-Status: GOOD (  13.56  )
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

On 03.10.2024 14:55, Christoph Hellwig wrote:
>On Wed, Oct 02, 2024 at 11:34:47AM -0700, Bart Van Assche wrote:
>> Isn't FDP about communicating much more than only this information to
>> the block device, e.g. information about reclaim units? Although I'm
>> personally not interested in FDP, my colleagues were involved in the
>> standardization of FDP.
>
>Yes, it is.  And when I explained how to properly export this kind of
>information can be implemented on top of the version Kanchan sent everyone
>suddenly stopped diskussion technical points and went either silent or
>all political.
>
>So I think some peoples bonuses depend on not understanding the problem
>I fear :(
>

Please, don't.

Childish comments like this delegitimize the work that a lot of people
are doing in Linux.

We all operate under the assumption that folks here know how to wear two
hants, and that there is no such thing as so specific incentives
neither to push _nor_ block upstream contributions without a use-case
and technical background.

