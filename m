Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F71C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6C1maRmnQShkYnoGnKw8z2XB1hU1X8ZjRGem4o/4QYI=; b=Ti1UdMN5fWg+dZ3YxoP7vUJ822
	A3pLyqAAFCU/dU3Y8FcPpJE0CWWD2oNAXMi6T0i6XiYqscJbxPnZBeyXpoyKdMEh80wOLp0ytx5er
	DiWhOTss9zLtVsgpOHmGOeu/7ypyaeacPWfkgWHF/to0acO6YDKBU8gITsSju9BDsLJ8xExrTcWIe
	xYDAq10nDAsy+v4HyWzGvbRaitZa7+BanICIRb+EdgDutKmrsxrGorYxIj2JBdaf9jj5FfadYTrpF
	Y4BPs2Tb79Y5ngTEaGZPf/H3Ts/52M17tf0aeh+I9xlwKSg5tG0iasjop4dJmZYk7YG16kZw1YTO6
	a46+h0+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odE3u-00BvK5-27; Tue, 27 Sep 2022 17:08:02 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odE3n-00BvIH-Ei
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 17:08:00 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220927170743epoutp045ed31899d490837929b69cb1900c64e9~YxqKL-inz0150101501epoutp042
	for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 17:07:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220927170743epoutp045ed31899d490837929b69cb1900c64e9~YxqKL-inz0150101501epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664298463;
	bh=6C1maRmnQShkYnoGnKw8z2XB1hU1X8ZjRGem4o/4QYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DuWRP5PIfr+vigBfbUdNnVNcrAy5pcXTUyMxYIYD4FYjC7o/pCFTc/Tx9lIl+CKBz
	 Eni4el2wsg6QpHSxzxf/5ohzpAd+sAbyoy5S4incxhmzJvjGyJnCYbJvzFvFxI/IE6
	 e469lrBx9tw0gRMrhScxAsXybmKrTVdDC8fxa4BI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220927170743epcas5p31a0a49712e187a477adceb91f8b96746~YxqJ4LAW-1205712057epcas5p3F;
	Tue, 27 Sep 2022 17:07:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4McQzc6gjVz4x9Pv; Tue, 27 Sep
	2022 17:07:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.F5.26992.CDD23336; Wed, 28 Sep 2022 02:07:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220927170740epcas5p42508665faac2d17e4afa5feb200acf16~YxqG1441r0904409044epcas5p4y;
	Tue, 27 Sep 2022 17:07:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220927170740epsmtrp17d6765ee655c865e08f600650a22f11b~YxqG1AkN02765427654epsmtrp1M;
	Tue, 27 Sep 2022 17:07:40 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-92-63332ddcc2ea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	59.95.18644.CDD23336; Wed, 28 Sep 2022 02:07:40 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220927170739epsmtip19d740ee2050dfefa7658119f34811b0f~YxqFyi-4H2251322513epsmtip1e;
	Tue, 27 Sep 2022 17:07:38 +0000 (GMT)
Date: Tue, 27 Sep 2022 22:27:51 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v8 3/5] nvme: refactor nvme_alloc_user_request
Message-ID: <20220927165751.GB23874@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220926145159.GB20424@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmpu4dXeNkg7NnTC1W3+1ns7h5YCeT
	xcrVR5ks3rWeY7GYdOgao8XeW9oW85c9ZXdg97h8ttRj06pONo/NS+o9dt9sYPPo27KK0ePz
	JrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
	Q5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkam
	QIUJ2Rmrrz9nLZjPXTHnyyumBsYFnF2MnBwSAiYS009MYOti5OIQEtjNKLFyTgMLhPOJUeL6
	/XtMIFVCAp8ZJebPrYHpuL+hmR2iaBejxKS396HanzFKfN7+gxGkikVAVWLKip1ACQ4ONgFN
	iQuTS0HCIgJKEk9fnWUEqWcWmM4osff1HrANwgLeEnPmbWEHsXkFdCXOTX4DZQtKnJz5hAXE
	5hTQkVh8ewUriC0qoCxxYNtxJpBBEgKNHBLfzs1mhzjPReLnio9sELawxKvjW6DiUhIv+9ug
	7GSJSzPPMUHYJRKP9xyEsu0lWk/1M4PYzAIZEltbl7NC2HwSvb+fMIE8IyHAK9HRJgRRrihx
	b9JTVghbXOLhjCVQtofEvdVvWCGBMpdJYuu8yewTGOVmIflnFpIVELaVROeHJiCbA8iWllj+
	jwPC1JRYv0t/ASPrKkbJ1ILi3PTUYtMCw7zUcngkJ+fnbmIEp00tzx2Mdx980DvEyMTBeIhR
	goNZSYT391HDZCHelMTKqtSi/Pii0pzU4kOMpsD4mcgsJZqcD0zceSXxhiaWBiZmZmYmlsZm
	hkrivItnaCULCaQnlqRmp6YWpBbB9DFxcEo1MK01+OGX2WG9VO7G7pnyLvxxdwRmrXhxy6kg
	1+O7aP7lzO0aWh/sPSO43RnPNXz/1m8rJfmoKMIh8sD80usGh11b7q9aMO9GaNpehjOa2g2H
	ciX46qUVLyXKf7iex7TyHIvyU4OS/4tW7ZXTd93r8WPt7V3/uw9N7J9wZPqlLGG/8AqW7+Is
	rjFsP8V5AsQ+vJi/MCrirPi9rVqS9a18L6w0OItqVQpUtj1uWbfLJ1phUsG1UInM2I6oqAfs
	l1qeN4fHZqeqhrEvE2QLuvF2stIfc65jXt+trzOvnJJbtGqlfuLZgzNecqzZ8T9sjsGdNXrv
	f6w6ytL2/cWmaTuTbiy5uvNMyISnu0qn7GZaI6XEUpyRaKjFXFScCAAGi6FqJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO4dXeNkgwXvWSxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7GYdOgao8XeW9oW85c9ZXdg97h8ttRj06pONo/NS+o9dt9sYPPo27KK0ePz
	JrkAtigum5TUnMyy1CJ9uwSujEl/nAsuclS8ufGKpYHxDVsXIyeHhICJxP0NzexdjFwcQgI7
	GCV6ri1gh0iISzRf+wFlC0us/PccqugJo8Tpj/dZQRIsAqoSU1bsBJrEwcEmoClxYXIpSFhE
	QEni6auzjCD1zALTGSX2vt7DBJIQFvCWmDNvC9hQXgFdiXOT30ANXcgk8aDvCQtEQlDi5EwI
	m1nATGLe5ofMIAuYBaQllv/jAAlzCuhILL69AuwGUQFliQPbjjNNYBSchaR7FpLuWQjdCxiZ
	VzFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBMeBltYOxj2rPugdYmTiYDzEKMHBrCTC
	+/uoYbIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTG1f
	1jgH2WtMYRc8v/FDtd9KJ5Vvx45e2/HR0Un8rOGL+YXmUlVro/IZr0wrD1Kd5Zluc8Cz7UPm
	wgceEzsOJy4qvdmx/MuqjaphL3jn5ayyuepzsmTejPWR/sad7g7Ld65ZJ531MEbygVLHTNt9
	lreP1zNPCcs8fvaK0Qzf/U8ltO2Vg05kbTguFlDIV5nbqb77SZ24jHmYe+D+vtWCzgrTZA9d
	zrvx2G9m38PJC4WuaKbG3rszYYlBlP2dkwLbTr42PvFfuXdF2Supe1Wzkl7HLj3fONuXhb3Z
	3ofPuy7zxY1167ZeFrWbYz6r/5bJ+SVNsjIbP887YqQ0e+qV8HLd84s4VGfpPl7p93K9sKcS
	S3FGoqEWc1FxIgC5wkWv8gIAAA==
X-CMS-MailID: 20220927170740epcas5p42508665faac2d17e4afa5feb200acf16
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_17872_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220923093916epcas5p387fdd905413f6d90babecf5d14da5b67
References: <20220923092854.5116-1-joshi.k@samsung.com>
	<CGME20220923093916epcas5p387fdd905413f6d90babecf5d14da5b67@epcas5p3.samsung.com>
	<20220923092854.5116-4-joshi.k@samsung.com> <20220923153819.GC21275@lst.de>
	<20220925194354.GA29911@test-zns> <20220926145159.GB20424@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_100755_988114_4E93505A 
X-CRM114-Status: GOOD (  15.74  )
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

------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_17872_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Sep 26, 2022 at 04:51:59PM +0200, Christoph Hellwig wrote:
>On Mon, Sep 26, 2022 at 01:13:54AM +0530, Kanchan Joshi wrote:
>>>> +	if (ret)
>>>> +		goto out;
>>>> +	bio = req->bio;
>>>
>>> I think we can also do away with this bio local variable now.
>>>
>>>> +	if (bdev)
>>>> +		bio_set_dev(bio, bdev);
>>>
>>> We don't need the bio_set_dev here as mentioned last time, so I think
>>> we should remove it in a prep patch.
>>
>> we miss completing polled io with this change.
>> bdev needs to be put in bio to complete polled passthrough IO.
>> nvme_ns_chr_uring_cmd_iopoll uses bio_poll and that in turn makes use of
>> this.
>
>Oh, indeed - polling is another and someone unexpected user in
>addition to the I/O accounting that does not apply to passthrough
>requests.  That also means we can't poll admin commands at all.

Yes. That falls back to IRQ completions.

I think it should be possible to support if we use request-only
interface. Most of the information in bio-poll interface comes from
request.
But I doubt if polling for admin command is a useful thing.

------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_17872_
Content-Type: text/plain; charset="utf-8"


------Bhr1nD2Bk2LUmll8nJ7f302jVE_Mn2nZjP.Hr2fL4.Csl-BK=_17872_--

