Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8883CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 04:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLF0ZXV+VLdhINaCXtHi7CEvE6pxJHlPgZH+J/p6RL0=; b=y33gW3tFGjonLafeV7GFjr2EEF
	fUqz2DcX7Co5ci7Mmj47F+D5I8KOiP1NP/ZIAxXyoVAH9twJJNzQmkAJ/Ltd/33Z+Lt3H/GaylXqz
	cyGMecoa7f/sup031fDfHARKg2f+/LY1Y3z8ZOAn1Q7TPkhxQ2RYw9VYCFHRTfdStXvf+TJRBBGFl
	vysKbTwgke76sdcJc935a2IQ/B8Z640yEmOxe3zXtpadQuNH24mfDVma6weUoeyvZCfckMt0qARwO
	+t1mSbww9+Es1SZa2HdjvOGQ4FEZ6x8zylJqepAQKCp9fuqKeRwpvIxjTDXRI32dwpk90wb09e3Hu
	oByR7MRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovW7I-00A71O-PI; Thu, 17 Nov 2022 04:03:08 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovW7F-00A6zt-1C
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 04:03:07 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221117040252epoutp03fe059f83465d408ad30fe03246baf310~oQ2dTAKwe3260432604epoutp03s
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 04:02:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221117040252epoutp03fe059f83465d408ad30fe03246baf310~oQ2dTAKwe3260432604epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668657773;
	bh=yLF0ZXV+VLdhINaCXtHi7CEvE6pxJHlPgZH+J/p6RL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXUCH5ltbxZTBlfsxFcXJgkhdWjP+lIN/X+xeSjF9PKMlY1QJMr9DpnYj9bGY5B0L
	 Pw+2ElxQBNwNHie00w2pw6oJwzDx64GWwH4dyC5lxTFIx3fTKppsWY0QQlZ0+FxRte
	 1VieRWW+8W5S3CPFZ4aOiaF47xVFocW5vffH7uFE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221117040252epcas5p47050a2fb7ae27d9a2e7bdd375086dbd7~oQ2dBzs551885218852epcas5p4z;
	Thu, 17 Nov 2022 04:02:52 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4NCR8V5c6dz4x9Q1; Thu, 17 Nov
	2022 04:02:50 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	36.46.39477.162B5736; Thu, 17 Nov 2022 13:02:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221117040241epcas5p3f0a877aa6177e8e5867a45cf6212aa6a~oQ2SaXhO_1809418094epcas5p3R;
	Thu, 17 Nov 2022 04:02:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221117040241epsmtrp2c9fb8e524a3518bff6c43ed1ca1a7901~oQ2SZwYf61902919029epsmtrp2Q;
	Thu, 17 Nov 2022 04:02:41 +0000 (GMT)
X-AuditID: b6c32a4a-80faea8000019a35-ab-6375b2610ae4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.0B.14392.162B5736; Thu, 17 Nov 2022 13:02:41 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221117040240epsmtip1762d70ac2063bc29a2e92d431e1176ad~oQ2RnAcmg0870508705epsmtip1W;
	Thu, 17 Nov 2022 04:02:40 +0000 (GMT)
Date: Thu, 17 Nov 2022 09:21:21 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221117035121.GA22055@test-zns>
MIME-Version: 1.0
In-Reply-To: <Y3UL2LER7I9KUxGW@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmpm7iptJkg+PHTSxWrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEtUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG9WOrmArWc1R8v9LC0sDYyt7F
	yMkhIWAi8fjid7YuRi4OIYHdjBIdnY0sEM4nRonXhw4zQjjfGCW6fuxigmk5+LcRKrGXUWLl
	4Vao/meMEh9uPASrYhFQlTj5YimQzcHBJqApcWFyKUhYREBZ4u78mawgNrNAmsSN3n4wW1jA
	SGLHyX3MIOW8AroSMy4ZgIR5BQQlTs58wgJicwrYS9x78gusXBRozIFtx5lA1koI3GOX2PQa
	5B92IMdFYmEoxJnCEq+Ob4H6Ukri87u9bBB2ssSlmeegXimReLznIJRtL9F6qp8Z4rIMifZF
	05ggbD6J3t9PwB6REOCV6GgTgihXlLg36SkrhC0u8XDGEijbQ+LXgbPQANnFKDFrw2zmCYxy
	s5B8MwvJCgjbSqLzQxPrLKAVzALSEsv/cUCYmhLrd+kvYGRdxSiZWlCcm55abFpglJdaDo/h
	5PzcTYzgJKjltYPx4YMPeocYmTgYDzFKcDArifCWqJcmC/GmJFZWpRblxxeV5qQWH2I0BcbN
	RGYp0eR8YBrOK4k3NLE0MDEzMzOxNDYzVBLnXTxDK1lIID2xJDU7NbUgtQimj4mDU6qByeqy
	9dzphjPSLra7Nzcx/7CdeMt2lczjXOkEfpZuVfYTk75s2Sra1NYuvv+kZ/pnb5ndc+S3tEVs
	Kjt2yFrU2pXVqv6BxMEHYYL7mUxr73gtX2Fi+/Qpc4CZoFBMQCnf4Q+7+TQv+Wm/tDlafK09
	9NayP0pqQc4N5a+EjlVJBy18Zv4p0e2ryjaug2nLp1/YEThly2qhZZ/efTp0oKRM4ED8WSX/
	H+n/y/Oz0tS2yO4xzJmx8nDCXt/mY65JU+oiLM7LV1/lVFy49tKiZU/cG3eY6f01vvj5Tebn
	NIXI4OPJH/snyrv9nO++OPhX+oqzze+nm0q+YHfWPNLFecDAgb9b9/9cPfmeLzETjmsxK7EU
	ZyQaajEXFScCACUTIKkLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnG7iptJkg+cr+CxWrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEsUl01Kak5mWWqRvl0CV8aZ919Z
	Ch6yVhz5N5utgfEiSxcjJ4eEgInEwb+NjF2MXBxCArsZJaZum8sOkRCXaL72A8oWllj57zk7
	RNETRoldv68wgSRYBFQlTr5YCmRzcLAJaEpcmFwKEhYRUJa4O38mK4jNLJAmcaO3H8wWFjCS
	2HFyHzNIOa+ArsSMSwYQI3cxStzZ8xeshldAUOLkzCcsEL1mEvM2PwSrZxaQllj+jwMkzClg
	L3HvyS+wclGgVQe2HWeawCg4C0n3LCTdsxC6FzAyr2KUTC0ozk3PLTYsMMxLLdcrTswtLs1L
	10vOz93ECA5sLc0djNtXfdA7xMjEwXiIUYKDWUmEt0S9NFmINyWxsiq1KD++qDQntfgQozQH
	i5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpint8xRc5kdY/2ZrZJfK+SS+1XHVuoadvY6v
	DRR22S420qn7/+rmopiZbb96d/I+TTY765uzae1EM9Mp2v/qWQU2LFk/QX2fiUzdHIufv56X
	FqceO8UfWXP/5s7ebJvCzIYM0092Aer/XS1qO6UqPIscJi2S8O6JePdvatjUBWHHGA2nf3x9
	4OKOn8eWPMhKbU7Ys/Gu9uolb7YrH36QI/BEyytrPUPR2m9LgjI1LayN9k49ufZC79PKvc9a
	N6clz9giUSuw9JEPk/5HaQbLuCo16RedL8VUG1Z+n8F+fOq1ldeuHdPc/1HosdYzDv3jB+w9
	2QWZH4gWzPde8Mhlx4WX3wv+9CRcmGzMN984hEeJpTgj0VCLuag4EQBCFs1S2wIAAA==
X-CMS-MailID: 20221117040241epcas5p3f0a877aa6177e8e5867a45cf6212aa6a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4cbf8_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221116161659epcas5p4bcdb97e2fae59e65bd2bf913cc3e686f
References: <20221116130104.2186334-1-hch@lst.de>
	<CGME20221116161659epcas5p4bcdb97e2fae59e65bd2bf913cc3e686f@epcas5p4.samsung.com>
	<Y3UL2LER7I9KUxGW@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_200305_774219_64CC2052 
X-CRM114-Status: GOOD (  16.36  )
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

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4cbf8_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Nov 16, 2022 at 09:12:08AM -0700, Keith Busch wrote:
>On Wed, Nov 16, 2022 at 02:01:00PM +0100, Christoph Hellwig wrote:
>> Hi all,
>>
>> I recently had to debug some testing code that tried to send fabrics
>> commands and caused a major havoc.  This series adds checks for various
>> very low-level passthrough commands that have no business sent by anyone
>> but the driver itself.  The list might now be complete, so discussion
>> is welcome.
>
>People do use the fabrics command for 'get property' to check on their
>device, which is a harmless command that you've blocked.

Not about this series, but should not fabrics command be allowed for
unprivileged users? Trying to understand the harm linked to that.

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4cbf8_
Content-Type: text/plain; charset="utf-8"


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4cbf8_--

