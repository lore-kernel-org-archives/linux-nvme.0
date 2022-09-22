Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6B8C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 07:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yjn+tDFsebpBjwkT3jLEoiR2Z1sDQI5OTUL4KkrLPWE=; b=Uu0K2JDvai/5F1ijd6HSJE5HBJ
	jeyo2wt+cFZPxEfosppFqPayvt/2A6rWXaj87vSDuvcxP4KdcLpxUQ9zZHTNHqBdWxVgXeXtfGZU4
	sK/mhV2W5aNegyqS64BbwcQfsFh0iu/iEOGOWYgWwn+qhDI9EuL0O5HIP2FEPRLY48xdMTi0ATs7H
	ekKjlSmR+pVDD1mASGt/1Tri1+SzvkyBzorW0h8S/+o0TcaXOzBYNFcCbVi4ZAIPHaAeRzrVGChAK
	MsPzCaqix1q1lARMx8a7dnG21Owcogts406+t/blF9a8XvF26cN9Ys1GvV625gOb2iBV800O8SMlU
	veDDyn6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGcm-00DprI-F6; Thu, 22 Sep 2022 07:27:56 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGci-00DpoD-3C
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 07:27:54 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220922072740epoutp0116557da36515d92e7c18e7f74ccd2623~XHhRre3DN2219122191epoutp017
	for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 07:27:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220922072740epoutp0116557da36515d92e7c18e7f74ccd2623~XHhRre3DN2219122191epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663831660;
	bh=yjn+tDFsebpBjwkT3jLEoiR2Z1sDQI5OTUL4KkrLPWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oD5rXzm8EiqEli+z1oZL07G3cv2SCVDXTfQa9uGHA0Uvw8Xym3k2RAkqMZ5CstVNo
	 53ui2dvWUGX6kG9F7NDsL3qtlUKvmDn3Y9pw9AfPH0vncX3HtjN1dyE0xLWbEUS1dL
	 Mtj03nLucIjAprkGTcttqBOUvjsNQhaxa6czg4c4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220922072739epcas5p228b06860c1da77ac47b4d9020cb47890~XHhQdZrzm2965429654epcas5p2N;
	Thu, 22 Sep 2022 07:27:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MY6Lc2S0sz4x9Q2; Thu, 22 Sep
	2022 07:27:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B6.E0.56352.86E0C236; Thu, 22 Sep 2022 16:27:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220922072736epcas5p34ca93702d574253a11e324664ba6b594~XHhNnOJMt1100611006epcas5p3V;
	Thu, 22 Sep 2022 07:27:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220922072736epsmtrp1eb1daf3ac7311f1813d79d9f34240660~XHhNmVClk1340413404epsmtrp14;
	Thu, 22 Sep 2022 07:27:36 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-bc-632c0e68ed5e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.78.18644.76E0C236; Thu, 22 Sep 2022 16:27:35 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220922072734epsmtip28457e18f3048d43c78cf46d41234df4d~XHhMK7Ibs2167321673epsmtip2i;
	Thu, 22 Sep 2022 07:27:34 +0000 (GMT)
Date: Thu, 22 Sep 2022 12:47:47 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, j.granados@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <20220922071747.GB23511@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220910053403.GA23158@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmum4Gn06ywbsnAhar7/azWaxcfZTJ
	Yun+h4wWj+98ZreYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	vi2rGAPYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
	c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoY
	GJkCFSZkZzx58oCx4JJQxarX+g2Ma/i7GDk5JARMJL5vbmPtYuTiEBLYzShxbe9hKOcTo8TC
	2auYIJzPjBKXtsxhhmnZdWYXM0RiF6PE2YerWSCcZ4wS+y7tBatiEVCVmDfnN1sXIwcHm4Cm
	xIXJpSBhEQEliaevzjKC1DMLzGaU6Pu2lREkISxgI7Fp+QM2EJtXQFei/9NsdghbUOLkzCcs
	IDangI7E2j+PwOKiAsoSB7YdBztPQqCTQ2Le/VtMEOe5SHxb8p8RwhaWeHV8CzuELSXxsr8N
	yk6WuDTzHFR9icTjPQehbHuJ1lP9YA8wC2RK/H/eygZh80n0/n7CBPKMhACvREebEES5osS9
	SU9ZIWxxiYczlkDZHhI7dy1lgwTKJCaJh1OPs0xglJuF5J9ZSFZA2FYSnR+aWGcBrWAWkJZY
	/o8DwtSUWL9LfwEj6ypGydSC4tz01GLTAuO81HJ4JCfn525iBKdOLe8djI8efNA7xMjEwXiI
	UYKDWUmEd/YdzWQh3pTEyqrUovz4otKc1OJDjKbA+JnILCWanA9M3nkl8YYmlgYmZmZmJpbG
	ZoZK4ryLZ2glCwmkJ5akZqemFqQWwfQxcXBKNTCx9AXYTjkUc3KnDrvjbfEVnSZC7/62+0uX
	pBXen2Xl/p5bOnDq/XlrVL0/iav7zDTOFXRx3pzdsK/F2pjdP8D/4/yVSeUfdygf33H8w5+r
	2h+tJzhMqVJPfal8fVffP8OWtVbbl+yXn59dm3r1TdqE5Tt+bHnDvujpriDnwp3ulUFz5xqu
	XXe4W13yn8TBMjM2DVvfWyITplctOPCfQYgj76mGtNhd78NaQT+53Vbc8sl4tv+lcJITT7fT
	RyW3MCWXybpn2p+/33Vg88cpy/nkQ4oO3tuav0WuTN+xl7/POD2aW7795yYNpbCgsNnRf1Lf
	tUa0mrwU7v9/P+LTZOHv+5WvHg28a6a6WOJcwz0lluKMREMt5qLiRAAMlRtbJgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvG46n06ywYtPlhar7/azWaxcfZTJ
	Yun+h4wWj+98ZreYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	vi2rGAPYorhsUlJzMstSi/TtErgyFu+5xlbQKFDx6bhqA+NXni5GTg4JAROJXWd2MXcxcnEI
	CexglDj4YDELREJcovnaD3YIW1hi5b/nYLaQwBNGiWmXgkBsFgFViXlzfrN1MXJwsAloSlyY
	XAoSFhFQknj66iwjyExmgdmMEn3ftjKCJIQFbCQ2LX/ABmLzCuhK9H+azQ6xeBKTxOEvV9gh
	EoISJ2c+ATuCWcBMYt7mh8wgC5gFpCWW/+MACXMK6Eis/fMIrFxUQFniwLbjTBMYBWch6Z6F
	pHsWQvcCRuZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBkaCltYNxz6oPeocYmTgY
	DzFKcDArifDOvqOZLMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgs
	EwenVANT7QxbDX37xIA1/x9znmK7ZnyH/+lB68SGcIMtlyLNHxpJ/D9rxtgqFnWoJ+NNdtBU
	Y679u79tjjf8sWDvqTupf5LDJCpXhXaaeEpyT0ib6aqpO0nO8KNk/Aa+nBn1jzaeULafx/P8
	6X2mG/3NziU/Qt/KuUvm8Gn2HohZ7idT8enQLfbQAwl3VG6ylzU/tVWYem+umeue/3/s89Z7
	ztqb8lVkwxL526xNkp+XX9pUllPPmPg7NdaM8+LqvKMn1+/hmT3P4CuzIVvb6kMuJR02gge1
	q2duCjHfEF6mfKVk/Yov23ONL7JYhj6S1Om4UTBnU67VUdZrMwWjtB+wVj/cu7ovTvFd+RWr
	CL4AkSIlluKMREMt5qLiRAARRXYP8wIAAA==
X-CMS-MailID: 20220922072736epcas5p34ca93702d574253a11e324664ba6b594
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----WgjG.75RCK0vaugoxekoY7._5exx5H51ZqHYxOO8vRDHiV2S=_12ee31_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
References: <20220909163307.30150-1-joshi.k@samsung.com>
	<CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
	<20220909163307.30150-2-joshi.k@samsung.com>
	<YxtwiDE0amT5DuNt@kbusch-mbp.dhcp.thefacebook.com>
	<20220910053403.GA23158@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_002752_828229_CF7250FF 
X-CRM114-Status: GOOD (  25.67  )
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

------WgjG.75RCK0vaugoxekoY7._5exx5H51ZqHYxOO8vRDHiV2S=_12ee31_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Sat, Sep 10, 2022 at 07:34:03AM +0200, Christoph Hellwig wrote:
>On Fri, Sep 09, 2022 at 10:57:44AM -0600, Keith Busch wrote:
>> On Fri, Sep 09, 2022 at 10:03:06PM +0530, Kanchan Joshi wrote:
>> > +bool nvme_admin_cmd_allowed(u8 opcode, fmode_t mode)
>> > +{
>> > +	/* allowed few read-only commands post the mode check */
>> > +	switch (opcode) {
>> > +	case nvme_admin_identify:
>> > +	case nvme_admin_get_log_page:
>> > +	case nvme_admin_get_features:
>> > +		return (mode & FMODE_READ);
>>
>> Some log pages have read side effects, like Namespace Changed List or anything
>> latched to RAE. That opcode seems a little more dangerous than the others in
>> the whitelist.
>
>Yes.  Some of the log pages (e.g. the persistent error log, or the LBA
>status log) are also getting really close to covert channels.  Can we
>please have really good justifications for why we'd whitelist anything
>on the admin side?

some of the information (namespace size, lba format etc.) is essential
to form io-command, and that information requires issuing admin-cmd.

But it seems we have another way to look at this.
Since we are talking about kernel (nvme driver) deciding what admin-cmd
should go (and what should not), onus in on nvme-driver to be right with
the choice. With pure static (driver-defined) whitelisting this is
what we get into.
Would it be better to consider dynamic (or hybrid) whitelisting for
admin-cmd? In that nvme-driver decides nothing (or little) but allows
admin to decide which admin-cmds are sane on a particular system. This
will still be on the line that 'root can do anything'.

Code wise, this could be a bitmap of 256 bits, one bit for each admin-cmd.
This can have few bits set by default (that driver trusts). 
While other bits (admin cmds) can be set only by admin-only ioctl.

Perhaps discussing this with code will be clearer. And we can do that in
a different RFC. And we sepearate the io-cmd whitelisting series from
all this as we seem to have more consensus on that already.

------WgjG.75RCK0vaugoxekoY7._5exx5H51ZqHYxOO8vRDHiV2S=_12ee31_
Content-Type: text/plain; charset="utf-8"


------WgjG.75RCK0vaugoxekoY7._5exx5H51ZqHYxOO8vRDHiV2S=_12ee31_--

