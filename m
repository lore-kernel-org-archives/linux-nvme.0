Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489BCC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LPCQzWxGCc0rWJ/F02YBTEpZK0cnXUAiYzs3rewgxd8=; b=vrdLERSKeFYnwr
	T6W0z8jYtKa9EhxOaXmO2FoVJe9VW0N0m+6RWal9k9IyR4RtvyvX1SzUkt20+zdf0ZC1d6EL+BXPq
	9Ok5YGTdmB0EDco1R+UTWA4v3IamW7uhjo6uCw+mb6xz/egkF/UTamHxyQ3UrIZvp7INu7PWZKxp3
	ge1ynw4jayzVUYJX6qKFrqbevmFQzwjrJHlkcMn/GIuxsSaJRI/KNmNhJPHQKdsfrQ55ZSp3YTISj
	wVK4+xsw6sjIZ1cEFQ3AQuOpFf2H2EEi74dDeaoYBXomCMFrv1tZ0y+Z+RBtO9gXhu8PCITfKnIq7
	f9kGP6DyGmauVheGLTKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol6xt-000pOU-Nx; Wed, 19 Oct 2022 11:10:25 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol6xq-000p9R-Lg
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 11:10:24 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221019111016euoutp01e691d2af15ba898ab9b17978cc2c9540~fc_Ve_4aE0706007060euoutp01O
	for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 11:10:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221019111016euoutp01e691d2af15ba898ab9b17978cc2c9540~fc_Ve_4aE0706007060euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666177816;
	bh=LPCQzWxGCc0rWJ/F02YBTEpZK0cnXUAiYzs3rewgxd8=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=e4CuHJ8zIkdTvsZAnfEgj6xvD4FM7UdqHwXfuP5FQovVsn32syV8brPYidzd6Y7Ul
	 0W2MzYwA3ZXXrhuIrG42yBB1q6XOtf8aTpTJaVI1a+hHZtZE04Cgz9wqlVC/ZSuVxF
	 KVcQp3ARczuZau/MiyJueBokuT0X7tolcS+XlrJk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221019111015eucas1p13da3865b052f043af6071c93c0bc8938~fc_VP6gs22896228962eucas1p1P;
	Wed, 19 Oct 2022 11:10:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id E1.FA.19378.71BDF436; Wed, 19
	Oct 2022 12:10:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221019111015eucas1p2f453277601c458d8c98dbfd96f7e023a~fc_U5HzPO2526525265eucas1p2Y;
	Wed, 19 Oct 2022 11:10:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221019111015eusmtrp11d636caabb765ec18c82a91dea56df16~fc_U3wIFz1691916919eusmtrp1g;
	Wed, 19 Oct 2022 11:10:15 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-cf-634fdb1720dc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F8.1F.07473.71BDF436; Wed, 19
	Oct 2022 12:10:15 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221019111015eusmtip15d5ef5af00aea89d9474a7ced92ef0e3~fc_UpxypM0401004010eusmtip1f;
	Wed, 19 Oct 2022 11:10:15 +0000 (GMT)
Received: from [192.168.8.101] (106.210.248.178) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 19 Oct 2022 12:10:13 +0100
Message-ID: <0b93cd38-0c41-d91d-b169-b01e647dfde2@samsung.com>
Date: Wed, 19 Oct 2022 13:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.2.2
Subject: Re: [PATCH nvme-cli] tests: Update license to GPL-2.0-or-later
To: Daniel Wagner <dwagner@suse.de>, Pankaj Raghav <pankydev8@gmail.com>
CC: <linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20221019105336.n37oq5u7gbgynrqy@carbon.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.178]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djP87rit/2TDXbsMbQ4/HgSu8X8ZU/Z
	LdbcfMriwOyxc9Zddo/NS+o9Np+uDmCO4rJJSc3JLEst0rdL4Mpo61rAXLCVveLL1NvMDYwN
	bF2MnBwSAiYSkx/dZAaxhQRWMEpse+TUxcgFZH9hlDiy+TwjhPOZUeLM8Y2sMB2bO4+wQCSW
	M0p82XSbGa5q65u1rBDObkaJ9WsegC3hFbCTONn1ghHEZhFQlZh96SMLRFxQ4uTMJ2C2qECU
	xKVNb8BWCAu4Szya/BTsKBEBD4lFp26A2cwCNhKLfh1ggrDFJW49mQ9kc3CwCWhJNHayg5ic
	ApYSs946Q1RoSrRu/80OYctLbH87hxniAWWJHxtOQ71fK7H22Bl2kJMlBM5wSGy7OJcdIuEi
	8XvHCUYIW1ji1fEtUHEZidOTe1gg7GqJpzd+M0M0tzBK9O9czwZyhISAtUTfmRyIGkeJ46dA
	3gUJ80nceCsIcQ+fxKRt05knMKrOQgqIWUgem4XkhVlIXljAyLKKUTy1tDg3PbXYOC+1XK84
	Mbe4NC9dLzk/dxMjMI2c/nf86w7GFa8+6h1iZOJgPMQowcGsJMLr9sUnWYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjgv2wytZCGB9MSS1OzU1ILUIpgsEwenVAOTiLzNp7xwJYbUIMYvs8yfq7M3
	SbVcPNl5qlGs5k24ruOZKK3vfGtevHq4xqXWU8ZWLmImy3/RzN1KNVvUjNybSh+d2vL+/Hme
	/7U6k6NaC33q9O4f6+2sFWJ+cTaoU/tmzKcjGpkblvw6PSVuoonfXc25kgLL91rvDOUOaX+z
	eE37n/JiIZNv09pSFaJuvJ73RHBDdcdWIcWbmiWJ1c+axE3mZcmY7z1e/tD1ysRy1mUevk7q
	TXI7lOqYz5em2MWc/j/d31Ss0uRk4/HJDjdv9S49IMPlYTl3n5f8j9BLz/+kruG0rl37RW7S
	vTm5t0sWnIixbBSMns0xf9XsmFx/XuUHp1XZFro9O5kR+0SJpTgj0VCLuag4EQB+rxdKkgMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7rit/2TDTZ+EbM4/HgSu8X8ZU/Z
	LdbcfMriwOyxc9Zddo/NS+o9Np+uDmCO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
	j7UyMlXSt7NJSc3JLEst0rdL0Mto61rAXLCVveLL1NvMDYwNbF2MnBwSAiYSmzuPsIDYQgJL
	GSUmTAuAiMtIfLrykR3CFpb4c60LqJ4LqOYjo8Sa6YugnN2MEqf+9YNV8QrYSZzsesEIYrMI
	qErMvvSRBSIuKHFy5hMwW1QgSmLp4x4wW1jAXeLR5KfMILaIgIfEolM3wGxmARuJRb8OMEEs
	OMAkcWfODFaIhLjErSfzgRIcHGwCWhKNnewgJqeApcSst84QFZoSrdt/s0PY8hLb385hhnhA
	WeLHhtNQD9dKvLq/m3ECo+gsJNfNQrJgFpJRs5CMWsDIsopRJLW0ODc9t9hQrzgxt7g0L10v
	OT93EyMw+rYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4XX74pMsxJuSWFmVWpQfX1Sak1p8iNEU
	GEQTmaVEk/OB8Z9XEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cBk
	F75+YYnZgds8G5drSaautDwlK+WvmFnOtLci7wqHq6JZmQH/720zmN33WHZ8+Rm36lurrW1G
	uQjzsh1rHmSIxaxwXPfp7DrzJutelmXRa5dOvyzDZL3kw85fW1h4Zkx8vOV04XndsH7R9TMi
	T1x/a8QtV31Tmku4b6rVzVsB/Husb2txZ/9PKHnxt6CiPr3g0Yp5k3gO/5gjnmH9+o7wLmv+
	2LvMX96Evlje9F07cQmTulQ8U6xUzBphr5hzM7ceOJa9YXVDeHuNJ4tT672WOczRRxoPKutM
	4V3/+vChmUX+x36+VC7Y9rv+yTG3e0K/3sjHpCqJ3Exnfer78tc96RLTG/cfe4kKcahn3TNQ
	YinOSDTUYi4qTgQA+nMWUUcDAAA=
X-CMS-MailID: 20221019111015eucas1p2f453277601c458d8c98dbfd96f7e023a
X-Msg-Generator: CA
X-RootMTR: 20221019105342eucas1p22028535789c015121826a4847974e595
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221019105342eucas1p22028535789c015121826a4847974e595
References: <20220517061456.7623-1-dwagner@suse.de>
	<20221019070321.ra5wns3sc3dv3r74@carbon.lan>
	<20221019085004.54mtkhi5qoix5ef6@quentin>
	<20221019105302.tcvfxn4z7nzkit5d@carbon.lan>
	<CGME20221019105342eucas1p22028535789c015121826a4847974e595@eucas1p2.samsung.com>
	<20221019105336.n37oq5u7gbgynrqy@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_041023_278626_9EB5C886 
X-CRM114-Status: GOOD (  14.94  )
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

On 2022-10-19 12:53, Daniel Wagner wrote:
> On Wed, Oct 19, 2022 at 12:53:02PM +0200, Daniel Wagner wrote:
>> On Wed, Oct 19, 2022 at 10:50:04AM +0200, Pankaj Raghav wrote:
>>> Hi Daniel,
>>>>> When I reviewed the tests I asked wrongly for GPL-2.0-only. The
>>>>> project is using the GPL-2.0-or-later license. Relax the license
>>>>> requirement to GPL-2.0-or-later.
>>>>>
>>>>> Cc: Arunpandian J <apj.arun@samsung.com>
>>>>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>>>>> ---
>>>>> Hi Arunpandian,
>>>>>
>>>>> Sorry for the mess, but could I get a signed-off-by from you?
>>>>
>>>> ping?
>>>>
>>> I heard from the team that he left Samsung. Do we have any other
>>> alternative to get this patch in?
>>
>> Right, the mail was bounced. I think it would be enough to get a signed
>> off by any Samsung employer
> 
> employee obviously :)
No problem.

Looks good,
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

