Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088F8C74A5B
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Mar 2023 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SZ/CYlaxiDIHU6OYfGgK+7VueV1TvxtyA/Eb4yW6drk=; b=gH6D6Hcjr66RSdttiTOd/3t1D5
	9dLV+kGrFGeB/tM7h7bUJjkTiT8qP2pGaIsvZgptbQz+FHlTNwo86rp7UpVD78g39qb2nB43lIcuz
	CH/AVO1fE4OCj0J3AzujcFmLPJ4HGPfoR4adA6DAqg35lsXVZFeiNP8t2mIZ20aAdZQuoPnhbt59C
	a9AdmSuD/lpgdHWADC/6zoiZpeis6K7lnbtsYQfAMQlYJPviWi/E5gJfqTDACfNMqDgD0KwaKFFiG
	cWBzXZyBcEXdSnRNMp0bmlg6g7jbqF8T+uXDrF8N4hiRzvUIduoqVS4gX1JvEeg3RepMYqPxB0sTq
	jqXbzJUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pd86v-0021aY-0i;
	Fri, 17 Mar 2023 11:19:01 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pd86q-0021Yx-09
	for linux-nvme@lists.infradead.org;
	Fri, 17 Mar 2023 11:18:59 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230317111849euoutp025cb280b2b2edb0bf91bab406059a300a~NMNWUWL0Q1165311653euoutp02e
	for <linux-nvme@lists.infradead.org>; Fri, 17 Mar 2023 11:18:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230317111849euoutp025cb280b2b2edb0bf91bab406059a300a~NMNWUWL0Q1165311653euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1679051929;
	bh=SZ/CYlaxiDIHU6OYfGgK+7VueV1TvxtyA/Eb4yW6drk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qIGOsgtcgwXrJVdvsd8ET/j+Kkbwt8pbU+jMRzgimB/WZ3HTHPbgdx7sLbkEKkjJw
	 6HuPlaYsQ6qOo0BDW045IfwCfUA7SQapUpGwxA5em2XqEDpiseOBvH2HbL7FKwV/xo
	 T0YwBmMHqSJELTV2EJCUCi5fhRSUxOmp23SZMMUI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230317111849eucas1p1a2bd8f6f225b87ef2ddcf558345124cb~NMNWHa7oa2049120491eucas1p1N;
	Fri, 17 Mar 2023 11:18:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.6E.09503.99C44146; Fri, 17
	Mar 2023 11:18:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230317111849eucas1p115741dc29cc0a5c57914e60aa5216288~NMNVvlQbH2045120451eucas1p1U;
	Fri, 17 Mar 2023 11:18:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230317111849eusmtrp21e1167306c2776f58dc6831bac69db59~NMNVu4SSs3139831398eusmtrp2g;
	Fri, 17 Mar 2023 11:18:49 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-ad-64144c994b61
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 90.6D.09583.99C44146; Fri, 17
	Mar 2023 11:18:49 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230317111849eusmtip2ed14adb4cbdd571c735cab92abb5b944~NMNVkQ8F93119231192eusmtip2-;
	Fri, 17 Mar 2023 11:18:49 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 17 Mar 2023 11:18:47 +0000
Date: Fri, 17 Mar 2023 12:10:31 +0100
From: Pankaj Raghav <p.raghav@samsung.com>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
CC: Christoph Hellwig <hch@lst.de>, "# v4 . 16+" <stable@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <javier.gonz@samsung.com>,
	<k.jensen@samsung.com>, <jh.i.park@samsung.com>, <p.raghav@samsung.com>
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung
 PM173X
Message-ID: <20230317111031.lygazqsaeekpdegd@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <930CF361-37C2-4625-B5FA-245248544F92@oracle.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djPc7ozfURSDPau1bL4v+cYm8XK1UeZ
	LCYdusZocXnXHDaL+cueslssXX6M2WLd6/csFgs2PmJ04PCY2PyO3eP8vY0sHptWdbJ5bF5S
	77H7ZgObx8ent1g8Pm+SC2CP4rJJSc3JLEst0rdL4MpouXObqeATT8W5S7tYGxj3c3UxcnJI
	CJhInGl/wdLFyMUhJLCCUaKx6y2U84VR4sfyblYI5zOjxIS9zxlhWs7eXcACYgsJLAdqeV4D
	VzT3bxMThLOFUaLv30KwKhYBVYnOBWeBRnFwsAloSTR2soOERQSsJJ6fuM8GUs8sMJ1Z4uC3
	5WAbhAUCJGbcussMYvMCbXvYN4UNwhaUODnzCQvIHGYBTYn1u/QhTGmJ5f84QCqYBeQlmrfO
	BuvkFLCTuHTyPSvEzUoSDZvPsEDYtRKnttwCO1NCoJtT4vvjl0wQCReJDZfeQj0pLPHq+BZ2
	CFtG4v/O+VA11RJPb/xmhmhuYZTo37meDeQICQFrib4zORA1jhJPd35ggQjzSdx4KwhxG5/E
	pG3TmSHCvBIdbUITGFVmIflrFsJfsxD+moXkrwWMLKsYxVNLi3PTU4sN81LL9YoTc4tL89L1
	kvNzNzECU9Ppf8c/7WCc++qj3iFGJg7GQ4wSHMxKIry8P4VThHhTEiurUovy44tKc1KLDzFK
	c7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTAt+t2ysVaodtW0J0lXP0ttL3r/6Slfu/ta
	I4fsvo/e6kwuZX90fMuYXLQUnN/X372mMddhnW0qq+fTa7E21XZ7L5+6JnlDTOQ/S06Fps0y
	Cw/JB7e4GIQ+d8ydPiVcISqfwUlhB8vefqnynjJ/Q5G0Lznis3S/Of7ZMD/yEedtn7XJM26p
	BJ+W2rGt9adAfipvby0H56aAnb+jrZx68sxaYvaq7oyQ1heaqPdpWfanSdztDDk6tX+U52z5
	bTrVeuNryVe+i84YbDa4MSk1kC9dIjTsye6LD9csTIhZ+ayJ/0yejZtaU1T1Vsbjv0u+Cave
	2m/U/Gt5V/m5STcmyVRp1GsdOdFx33Bz1OIWIyWW4oxEQy3mouJEAJ3+J7y8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7ozfURSDGY0Clj833OMzWLl6qNM
	FpMOXWO0uLxrDpvF/GVP2S2WLj/GbLHu9XsWiwUbHzE6cHhMbH7H7nH+3kYWj02rOtk8Ni+p
	99h9s4HN4+PTWywenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
	29mkpOZklqUW6dsl6GW03LnNVPCJp+LcpV2sDYz7uboYOTkkBEwkzt5dwNLFyMUhJLCUUaL5
	2jQmiISMxKcrH9khbGGJP9e62CCKPjJKTGjfywThbGGUWPzhBFgHi4CqROeCs6xdjBwcbAJa
	Eo2dYM0iAlYSz0/cB2tmFpjOLHHw23JGkISwgJ9ES08zmM0LdMbDvilQG2YzSnxq2c0KkRCU
	ODnzCQvIUGYBTYn1u/QhTGmJ5f84QCqYBeQlmrfOZgaxOQXsJC6dfM8KcbSSRMPmMywQdq3E
	57/PGCcwisxCMnQWwtBZCENnIRm6gJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmD0bjv2
	c8sOxpWvPuodYmTiYDzEKMHBrCTCy/tTOEWINyWxsiq1KD++qDQntfgQoykwgCYyS4km5wPT
	R15JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1PYyXVxDI1Han3/
	yU015FOdeWsGX6P8+/At+1ROOR/WClxxwvrgpXsTFhce8FW/ni3aVLqsyHWZjHC18RT3RoF3
	rvET/dPWekwQNFwX1MA/waxm3vEt974xeC1/6s8ZfdeM2fXhFYtLwo+U04znL98v+ystyr4l
	6+6H2au617PveXC9a269tW262WbpSSmuCvwFv71VbR7/bkxyv7DDMrA8OJ3pZfoTlkP/vbWz
	9gjvU1r9ZF37I8lwSXuT3lOnrb4p897K339swfotf064BW7fs747KD+RIe/KrSifeeUJ2Rdq
	JqcpJUpmi3buPjLvssSVm6sOOnwKP7+LWdjIIf7RdJe0zWGxzx44v3HNeKTEUpyRaKjFXFSc
	CACvOIyzZwMAAA==
X-CMS-MailID: 20230317111849eucas1p115741dc29cc0a5c57914e60aa5216288
X-Msg-Generator: CA
X-RootMTR: 20230317111849eucas1p115741dc29cc0a5c57914e60aa5216288
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230317111849eucas1p115741dc29cc0a5c57914e60aa5216288
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
	<20230316051508.GA8520@lst.de>
	<930CF361-37C2-4625-B5FA-245248544F92@oracle.com>
	<CGME20230317111849eucas1p115741dc29cc0a5c57914e60aa5216288@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_041856_689595_07289649 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
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

Hi Saeed,
On Thu, Mar 16, 2023 at 09:31:38PM +0000, Saeed Mirzamohammadi wrote:
> eui64 values are not unique. Here is an example:
> namespace1
> nguid   : 36554630529000710025384500000001
> eui64   : 002538191100104a
> namespace2
> nguid   : 36554630529000710025384500000002
> eui64   : 002538191100104a
> namespace3
> nguid   : 36554630529000710025384500000003
> eui64   : 002538191100104a
> namespace4
> nguid   : 36554630529000710025384500000004
> eui64   : 002538191100104a
> 
> I haven’t yet contacted Samsung. Do you recommend any one to reach out to?

I am able to reproduce this error with a PM173X.

nvme id-ns:
root@missingno:~# nvme id-ns -n 1 /dev/nvme1 | grep eui64
eui64   : 00253891010005b3
root@missingno:~# nvme id-ns -n 2 /dev/nvme1 | grep eui64
eui64   : 00253891010005b3
root@missingno:~# nvme id-ns -n 3 /dev/nvme1 | grep eui64
eui64   : 00253891010005b3

dmesg:
[174690.305507] nvme nvme1: identifiers changed for nsid 1
[174878.481002] nvme nvme1: rescanning namespaces.
[174878.535981] nvme nvme1: duplicate IDs in subsystem for nsid 2
[174878.599982] nvme nvme1: duplicate IDs in subsystem for nsid 2
[174883.673001] nvme nvme1: rescanning namespaces.
[174883.740045] nvme nvme1: duplicate IDs in subsystem for nsid 2
[174883.784025] nvme nvme1: duplicate IDs in subsystem for nsid 3
[174883.852034] nvme nvme1: duplicate IDs in subsystem for nsid 2
[174883.892040] nvme nvme1: duplicate IDs in subsystem for nsid 3

I will report this to our firmware team. Meanwhile, Could you paste your
output id-ctrl output here? I am interested in the fw version you are using.

--
Pankaj

