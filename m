Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E888AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JTOchdeTVk+eBXTRzAF0YcfuOpiAURM76OByzae9OSk=; b=QeAuLa5NMGw4ZGmhMQk+f37FBJ
	5t7Am+iltRDPE2GpdqCOjmPIlzKWGAwGS1frGiE4CVwc0pt1rW44FrGEs1YetUnqEZd4A6xS2z28l
	vmn+g8aID/RINgQ8l1ztaOrVHIOfIJUCFcu3N/h+cDp3k5dMiIDPPhFpSL2FW5OyulnvTBpScIWyC
	Yo35+W/HRr+KuTDLdWQc6a8uYAbniCjSTaO1L387+9jAWs2ywjxX1yCUtK7/PYHhnCppXKwcjoV5q
	a5ZboL8/vhRj1jCRqepRL1zJtRZekNMfihNpafKpByqyvGjY4bR8s+HvVfkicG81fXiubSoDtlQpT
	4wcc+6IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIsf-004JJ1-MO; Wed, 16 Nov 2022 13:55:09 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIsb-004JCo-8m
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 13:55:08 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221116135444epoutp0260d22e63ecd6f899c684dbe5ce5ffef1~oFR75Q2yr2539825398epoutp02A
	for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 13:54:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221116135444epoutp0260d22e63ecd6f899c684dbe5ce5ffef1~oFR75Q2yr2539825398epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668606884;
	bh=JTOchdeTVk+eBXTRzAF0YcfuOpiAURM76OByzae9OSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k0rJO5SY2f14VV3/MkVeBk/MdyDMLzjX5/tqJZxZRNaJ9z7sKVX+agRjAoLOr3u58
	 Uw+29C92d+q8WVKXzVcPXrfsdrE1lrafn0H2nSyVAir2VvzpoRYXyAb0xZi4HZqoLq
	 Ni/kR+ZzUYAAM6AfLyTujmaQHGE05CRUWacWHH0A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221116135443epcas5p4c0e9774844f9bbd2fb527d64bd772e04~oFR65jrmK1489614896epcas5p48;
	Wed, 16 Nov 2022 13:54:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4NC4Kt0TJ9z4x9Pq; Wed, 16 Nov
	2022 13:54:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.CF.01710.1ABE4736; Wed, 16 Nov 2022 22:54:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221116135441epcas5p3ccd8635b318fdceffe206106c41de8c5~oFR45Ktc72508625086epcas5p3H;
	Wed, 16 Nov 2022 13:54:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221116135441epsmtrp20191b773a632625cc804b3b6b22a0434~oFR44mzNI0324803248epsmtrp2C;
	Wed, 16 Nov 2022 13:54:41 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-bb-6374eba1cb1f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	36.3B.14392.1ABE4736; Wed, 16 Nov 2022 22:54:41 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20221116135440epsmtip27f34490fd9446368eb4b9c82623c06bc~oFR4D6Fnr0815708157epsmtip2N;
	Wed, 16 Nov 2022 13:54:40 +0000 (GMT)
Date: Wed, 16 Nov 2022 19:13:22 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221116134322.GB5094@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221116133839.GA9364@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmuu7C1yXJBideWlisXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJaobJuM1MSU1CKF1Lzk/JTMvHRb
	Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoJVKCmWJOaVAoYDE4mIlfTubovzSklSF
	jPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMfXcLC55zVEz+cZqtgXEDexcj
	J4eEgInE1iWvGbsYuTiEBHYzSmx48Z4dwvnEKDHxyCpmkCohgW+MElMWGcF07Pl/lgWiaC+j
	xNeF+6E6njFK/Ji5ig2kikVAVeLz5F9A3RwcbAKaEhcml4KERQSUJJ6+OssIYjMLpEvMWfQd
	bIGwgJHEjpP7wGxeAR2JP2232CBsQYmTM5+wgNicAtoSx9+dBLNFBZQlDmw7zgRx0D12ib6H
	OhC2i8TGeYeZIWxhiVfHt0C9KSXx+d1eNgg7WeLSzHNQvSUSj/cchLLtJVpP9TND3JYh0d76
	FepOPone30+YQF6REOCV6GgTgihXlLg36SkrhC0u8XDGEijbQ+LUmgPQIDnOKLFw2hq2CYxy
	s5C8MwvJCgjbSqLzQxPrLKAVzALSEsv/cUCYmhLrd+kvYGRdxSiZWlCcm55abFpgmJdaDo/h
	5PzcTYzgJKjluYPx7oMPeocYmTgYDzFKcDArifDmTy5JFuJNSaysSi3Kjy8qzUktPsRoCoyd
	icxSosn5wDScVxJvaGJpYGJmZmZiaWxmqCTOu3iGVrKQQHpiSWp2ampBahFMHxMHp1QD07Sw
	FwdWrrL7cnSR+ASJm7Wrix6+vRR5xWfyFA1xZ2EunY+bS1Z2zVny5ubaWOPZt78Ipz9f1vNe
	7II4f+RWuTNLGmv1s+Xex1Sv3iNxPHpZ4V4uJrWPX4v+z+jJMlcqYdEye8Nyx9HSPPWCgcz3
	zr3TTswKL9z97DQ3z5XVWp4aIT/f7X/XKz3x+hH3+d8WdE/MCHWX1Ql5unNdhOfclGoFpldv
	H9vU3pUqPL281TXr5dN3ftJT9+R52WuEyE/vE5wW1Sm5Tp2zM0Zr15q6nXf7rV3/MClnPsgN
	3sLnenhtt8Du85U/xO0nK9aHMbhtOvdBgv3QzHvb84JTdi2tTpgi65Duu6Z2f8v23KxnsUos
	xRmJhlrMRcWJALb8ldMLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvO7C1yXJBqtfi1usXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoLpuU1JzMstQifbsErowDH3+w
	FMxkq3j8ZRZzA+Mfli5GTg4JAROJPf/PAtlcHEICuxkl9n26xgqREJdovvaDHcIWllj57zmY
	LSTwhFFi9ZZaEJtFQFXi8+RfzF2MHBxsApoSFyaXgoRFBJQknr46ywhiMwukS8xZ9J0ZxBYW
	MJLYcXIfmM0roCPxp+0WG8Tek4wSy783skIkBCVOznzCAtFsJjFv80Ow+cwC0hLL/3GAhDkF
	tCWOvzsJViIqoCxxYNtxpgmMgrOQdM9C0j0LoXsBI/MqRsnUguLc9NxiwwLDvNRyveLE3OLS
	vHS95PzcTYzgwNbS3MG4fdUHvUOMTByMhxglOJiVRHjzJ5ckC/GmJFZWpRblxxeV5qQWH2KU
	5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCk8fNWtf76qEqpW7eiV9pnH7rmfEx0aVd8
	+Z6Wir7vQtOTg3bJXQ0VyXuRfPhcturMyG8X7BhWTRMUrm1Y7na03Eji6tyNE9cbOGz4kXOl
	lvPAptD/8XZlv5dE7ZizqPJ3ypK16yMlOo9vP/gkdEX/jyd/Z/5nevoy/I11GYO7LuPZKWZd
	c280L57t03llrvbWTt6iJ5ukNzIahh0qEf23d2HpyRbGypn3d96p+1v07KHI4pAA0XtHslYy
	lHDPUG5pFAl3/bR8lu4xuSu870NntVQ4OU9vuLNr54NLU4z/8VfuNplWOTnz0FlXLqNik1X9
	VZeeyLq9DQhawP3CQCfX+69Pl+BZ1RauWxl7dCwtlViKMxINtZiLihMB1ZJqptsCAAA=
X-CMS-MailID: 20221116135441epcas5p3ccd8635b318fdceffe206106c41de8c5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4aa84_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221116130636epcas5p39a586e15d27045752f18d022f4efd74a
References: <CGME20221116130636epcas5p39a586e15d27045752f18d022f4efd74a@epcas5p3.samsung.com>
	<20221116130104.2186334-1-hch@lst.de> <20221116132502.GA5094@test-zns>
	<20221116133839.GA9364@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_055506_005229_47B6570A 
X-CRM114-Status: GOOD (  13.93  )
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

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4aa84_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Nov 16, 2022 at 02:38:39PM +0100, Christoph Hellwig wrote:
>On Wed, Nov 16, 2022 at 06:55:02PM +0530, Kanchan Joshi wrote:
>> Sorry to hear about the trouble, but I am confused how did this
>> happen.
>> The old code also did not allow fabrics command and any other
>> admin command except id-ns variants. Yet this series had to
>> explicitly disallow admin cmds such create/delete sq/cq and
>> set-features.
>
>This is not a regression in your code, sorry if I made that
>impression.  This is a long-standing issue since these ioctls
>were originally added.

I see, good to know. I am still missing something.
This series is on top of nvme-6.2, since nvme_cmd_allowed did not exist
earlier.
In that case having this series or not having - gives the same effect,
no?

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4aa84_
Content-Type: text/plain; charset="utf-8"


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_4aa84_--

