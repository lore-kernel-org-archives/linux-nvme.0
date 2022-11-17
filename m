Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8ACC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 03:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=llP6ogVl7HvPG8O1Sa6fIFY02qTfVnabtABKgrSQhnY=; b=Xwol7cFXiBF3YqbHVPZn4DO4MJ
	6G7ltBxemf17sm2LAgzZS2kunnpZwiYiKH5klkG+hIJ10n5CCNggxOIPF0tcImjSAmX9/pHiZFipZ
	KD3F5mgDwcx4z9jGZZvoULZ1kOHNgDowfHZHqnVFGQ+ekoPpX8Veg9bQc5lVXQ1HpfF9Qx+iN7wFv
	+tCwEoo8kbVNArvDMORmFl5FuXfMzNluZxq1IO3YSyzNw8x4beJKQAVyV9Rzw0LldqAipaxP53mIa
	otogmq+Zq11Q5BP5cym8qbyzswHsl1ybhqrn1rb/sIEorIwKRqA6PmHsgeXisULm5gwsXP1JwwlHe
	UkmcGQlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovVWf-009qjk-BX; Thu, 17 Nov 2022 03:25:17 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovVWZ-009qho-C2
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 03:25:16 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221117032504epoutp040939924947c1fe7d66bf2275d654d214~oQVcU31iM0682906829epoutp04E
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 03:25:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221117032504epoutp040939924947c1fe7d66bf2275d654d214~oQVcU31iM0682906829epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668655504;
	bh=llP6ogVl7HvPG8O1Sa6fIFY02qTfVnabtABKgrSQhnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jbnq9H3wJY3NSS9LIwA7JMmXufpXaFfVQnL7Gz2m70+hGaRTX7yScXdN8HZT8sFjg
	 YhueqE6Chy6rn+vsTHPt3he5dwPgLv+0SeKUhklabx/xLKSPSKuMHpvyLRlK4uRU6v
	 90nys6Jk8zydglYHmvt3viH++s4F74fgn2RDegOo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20221117032503epcas5p183639d4031e580d59b03b4c484195930~oQVb6NuNf1734917349epcas5p1n;
	Thu, 17 Nov 2022 03:25:03 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4NCQJt02d2z4x9Pr; Thu, 17 Nov
	2022 03:25:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.77.56352.989A5736; Thu, 17 Nov 2022 12:24:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221117032456epcas5p34d72cbcdde00c69b0c14fb7c18f3dd3b~oQVVBsvlz2327223272epcas5p3J;
	Thu, 17 Nov 2022 03:24:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221117032456epsmtrp25c54532c98ff1dacde0cc79db50197d7~oQVVBHJNP2798927989epsmtrp27;
	Thu, 17 Nov 2022 03:24:56 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-28-6375a9898243
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.57.14392.889A5736; Thu, 17 Nov 2022 12:24:56 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20221117032455epsmtip2f63fab338bd648c3b3aaa6258fdfda51~oQVTx1xUT0410704107epsmtip2y;
	Thu, 17 Nov 2022 03:24:54 +0000 (GMT)
Date: Thu, 17 Nov 2022 08:43:36 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221117031336.GA392@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221116154415.GA18491@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmhm7nytJkg9tH5SxWrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEtUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGhdf3mAp2c1V8WnyTsYHxBkcX
	IyeHhICJxIYXd9m6GLk4hAR2M0osuT6dGcL5xCjx8Mh0qMw3RolNi2aywrS8PrQBqmovo8Sl
	XxtYIJxnjBK/D99jBqliEVCV6Hu/FSjBwcEmoClxYXIpSFhEQEni6auzjCA2s0C6xJxF38HK
	hQWMJHac3Adm8wpoSyzpPgBlC0qcnPmEBcTmFNCROPr+DVhcVEBZ4sC240wgeyUE7rFLfF26
	hRniOheJM09/s0DYwhKvjm9hh7ClJD6/28sGYSdLXJp5jgnCLpF4vOcglG0v0XqqnxniuAyJ
	7V/+sEPYfBK9v58wgfwiIcAr0dEmBFGuKHFv0lNooIhLPJyxBMr2kDi15gA7JEy6mCSuzGhn
	mcAoNwvJP7OQrICwrSQ6PzSxzgJawSwgLbH8HweEqSmxfpf+AkbWVYySqQXFuempxaYFxnmp
	5fBITs7P3cQIToVa3jsYHz34oHeIkYmD8RCjBAezkghviXppshBvSmJlVWpRfnxRaU5q8SFG
	U2D0TGSWEk3OBybjvJJ4QxNLAxMzMzMTS2MzQyVx3sUztJKFBNITS1KzU1MLUotg+pg4OKUa
	mJxlyrM9HHdmyE9WP5jObbSG09l428T/t28ucNrXbOZ++E8a422JzL+Tb12YrqK11Tf6HVuS
	WKPRx7vbO85Vz08V5Mj48iJskejt5AdvPd5+fR7goFEb4mzt42x+QuNceGz/TvbcQFev6wlF
	W5guNuz4aHKt/o9PxPva7c0v3keIX3zbqxyV+uX1GfaFRjmvD63YnbvTfUbO5jQb9SsV9fxa
	NmG1x99ffJawNuG+0mkR49KEhv0iU0zXbKhe3Kui2+l52tyereym9x+pAy1LEqTE5YT7vi3c
	ldN5M/nxqqNCUe/KhQ5NPLNho6C05L/S03Ml3Z5G1bX9yJ9+MsHOvj38sUuZRJaUi47Eanct
	JZbijERDLeai4kQASJrPQw4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvG7HytJkg6Pb+C1Wrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEsUl01Kak5mWWqRvl0CV8bUOTPY
	Ct6yV0y81sbcwLiErYuRk0NCwETi9aENzF2MXBxCArsZJTb9msQEkRCXaL72gx3CFpZY+e85
	O0TRE0aJfxtWsYIkWARUJfreb2XpYuTgYBPQlLgwuRQkLCKgJPH01VlGEJtZIF1izqLvzCC2
	sICRxI6T+8BsXgFtiSXdB6AW9zFJzLk4hQkiIShxcuYTFohmM4l5mx8yg8xnFpCWWP6PAyTM
	KaAjcfT9G7A5ogLKEge2HWeawCg4C0n3LCTdsxC6FzAyr2KUTC0ozk3PLTYsMMxLLdcrTswt
	Ls1L10vOz93ECA5tLc0djNtXfdA7xMjEwXiIUYKDWUmEt0S9NFmINyWxsiq1KD++qDQntfgQ
	ozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGptOTDjhlWB/xLlK8tiry+7t9d5Rs7vjN
	TZ8kt88soccs/ZPL5bdJrQpJsiueXsmaKvNvU+GCuiVrSj657rhTzPNQeSrnpX3H+ffl/PkZ
	7uiWLPJbu3ZHRAWL/LQN5Y9zwjb+uyEidfCIeFgJY2utW4DConlaXr6LpMSSHbcZnQi12Zzh
	NOOHwH/jx0e/Vdpt3J/IJpQ4VW3ePv2sWsbafO7LHXfdH33ISFC1MeswuH3RwFw2hNHRwt5D
	+m6FQcZSkevfkl02y3ndOP5+w4eCIIX/mxY+6ZwxM4aZ6yGX6zuezE02Mt2vHj18Fil8+3w3
	v+LmVc/MP7jZTBftPv4t/0jgmbkbDj1Mmf/fn0l4ixJLcUaioRZzUXEiAHvxb+rcAgAA
X-CMS-MailID: 20221117032456epcas5p34d72cbcdde00c69b0c14fb7c18f3dd3b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4ca2f_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221116130636epcas5p39a586e15d27045752f18d022f4efd74a
References: <CGME20221116130636epcas5p39a586e15d27045752f18d022f4efd74a@epcas5p3.samsung.com>
	<20221116130104.2186334-1-hch@lst.de> <20221116132502.GA5094@test-zns>
	<20221116133839.GA9364@lst.de> <20221116134322.GB5094@test-zns>
	<20221116154415.GA18491@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_192512_880008_B8F13082 
X-CRM114-Status: GOOD (  15.25  )
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

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4ca2f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Nov 16, 2022 at 04:44:15PM +0100, Christoph Hellwig wrote:
>On Wed, Nov 16, 2022 at 07:13:22PM +0530, Kanchan Joshi wrote:
>> I see, good to know. I am still missing something.
>> This series is on top of nvme-6.2, since nvme_cmd_allowed did not exist
>> earlier.
>> In that case having this series or not having - gives the same effect,
>> no?
>
>Yes, no change due to the series introducing nvme_cmd_allowed.
>It is just a convenient place to put the checks.

Got it now. The series is about restricting root/admin itself from doing
certain things.
If we end up going this route, putting a new helper seems clearer to me.
Something like this: 

if (capable(CAP_SYS_ADMIN)) {
	return admin_only_checks();
}
/* regular user checks as before */


But if there are people using the upstream driver for testing
nvme-hardware, restricting may not go well. Stuff like creating SQ/CQ
in early stages of new SSD/controller development may just be
the thing they want to test.


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4ca2f_
Content-Type: text/plain; charset="utf-8"


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4ca2f_--

