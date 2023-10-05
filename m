Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155BEE9370C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8oh84wv4BpHh5bEuSWpNHH1TzfuQNXxhFhUs9JhPYcc=; b=xpBowtIlqJNHCF
	odqY5ZMXW6u09f5znLdMMzonS58MMzSxGQLBzdsI7Dk1vBlueHcQN6gwIHDRShxlyyRg2DrZEzk//
	X06PQY8tLjRx1mQWY4icm99cgQTu8OBzAmlZdeqTtMdP6ie/OuyUjoL1Dx1yIUjvCz6ew9CQ4gAW7
	OIaLULTAoCDGzdiNTHzXS4jVH/F44NecXvD773wxlKTb9MH82+KH6BDl5hWxoicIzsww8/bb2yKtL
	Ywhm4fgrxou0QW+zjb4Px2qx8YmIweMMhyCv4Y5UqBOSgNofHTGIQb/pcNOxn4trhjEf4NavPFOJ0
	gkOOhTEnbCJKafNOOr8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoOT7-003RHG-1h;
	Thu, 05 Oct 2023 13:32:45 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoOT2-003R9S-2V
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 13:32:43 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231005133232euoutp02219fdd1bb358a06c981bb03bfc526efc~LOVwnruca1145811458euoutp02_
	for <linux-nvme@lists.infradead.org>; Thu,  5 Oct 2023 13:32:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231005133232euoutp02219fdd1bb358a06c981bb03bfc526efc~LOVwnruca1145811458euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1696512752;
	bh=8oh84wv4BpHh5bEuSWpNHH1TzfuQNXxhFhUs9JhPYcc=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=nJ+q1MaOlno70kH1ngY/IHPLmefWq0+3qe7nC7PVQpQ0AlJ0pG9oMD/H6O2XCZDlO
	 VC/eSFbNkZw7FZln9y2SR7j+mdRyo+ZO/cRMiFU54i0rveY+u2Qlxokc41UyPFokdE
	 +oyOpIA8R2SvsuB8R2jQCk+Btab20GKpjFLL+Amw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231005133232eucas1p194459d5c2154b380ca2aa5767b65390f~LOVwPvDiZ3103131031eucas1p1H;
	Thu,  5 Oct 2023 13:32:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.77.37758.0FABE156; Thu,  5
	Oct 2023 14:32:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231005133231eucas1p2df60b494ece43160cfe55304468308fe~LOVva1K6J2036920369eucas1p2w;
	Thu,  5 Oct 2023 13:32:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231005133231eusmtrp21abe9236253ea4b8693fff68e2310973~LOVvYgaza1834818348eusmtrp2T;
	Thu,  5 Oct 2023 13:32:31 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-b1-651ebaf0393a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.6C.25043.FEABE156; Thu,  5
	Oct 2023 14:32:31 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231005133231eusmtip196d343ea8c1e6b872d69f4abd5ac4f36~LOVvME8bj0869408694eusmtip1-;
	Thu,  5 Oct 2023 13:32:31 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 5 Oct 2023 14:32:29 +0100
Message-ID: <83f58662-d737-44b0-9899-c0519a75968a@samsung.com>
Date: Thu, 5 Oct 2023 15:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
To: John Garry <john.g.garry@oracle.com>, Alan Adamson
	<alan.adamson@oracle.com>
CC: <axboe@kernel.dk>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<djwong@kernel.org>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<chandan.babu@oracle.com>, <dchinner@redhat.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>, <jbongio@google.com>,
	<linux-api@vger.kernel.org>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <b6ed0e26-e3d4-40c1-b95d-11c5b3b71077@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRy/533fvXs3A1+mtCdArFVyIhBl0sOlRNHu3j+0I7vy0utysSe2
	4oduTEPrGBAimICQKUNjh/JDd5UMgYGQ+OqkqYQXamMckd34wy1uIsQyGcV4seO/z/P5cd/v
	53sPQ8oK6QhGm5OHdTmqLAUtpTquPvw5/n53NE60/0SjnsprBLKMVtLIe/kBQL/Yo9GA56QY
	DblD0RmLnUCOiz4aNTg7CHTzHxtA1fwdgNr8B2nU61qHenodFBrqPkGj+qZxMeqetYlRc/8c
	gb73+ihU8tVDMRoM9ItSwzmz1cAN/tZKcUMDBs56tozmqhr6ANd2uoC7MGykuaIbdpKbHHdR
	nO/H2zQ3ZY3mrO4JIv2J7dKNapyl3YN1L6TslGouBbyiXb9KP2v1OAgjsEjKgYSB7Muw3H9H
	VA6kjIxtAbC400MEBRk7DWDTud2CMAVgzck/yccJq8VLC0IzgLOeRup/l5+3EsLDBuD1djcI
	RkLYFHg1cHQhTrHPweKuGZHAh0FHrZsK4nB2NRxzHRcH8Qo2CV65cGvBv5LdCmvOuBd4kr1H
	wlKeEbAcutz188MYhmZjYWGZOAgl86N6u7HgWAtLOh8tJlfD4va6xQLPwOphn0jAX8Br510L
	K0O2Qgp564hYEN6EU8MTtIBXQE//+UU+Cv7bVU8IeD8cdz4ihfCXAFZ2/UAHl4Dsq7DiRpbg
	eR2aav1AoEOhcyJM2CcUVnccI6vA86YlhzAtKWZaUsG0pIIZUGeBHBv02ZlYvz4H703Qq7L1
	hpzMhIzcbCuY/6XX5/r/soEWz2QCDwgG8AAypGJlSKYxCstC1Kr8fViX+6HOkIX1PIhkKIU8
	ZN0mR4aMzVTl4U8x3oV1j1WCkUQYiZa4d8i/k6j0tFayae19W/yD1tqo98em4/w3T6z5ZE2q
	MsWiy3ewjVsqlkW83QhQH3cIa2faVv1ewr8XpbAftZmXV9cVXHzy1MHlYZ79p+neHX35AUZ9
	O3lsJK6S3KGZfuvWRy1Fo5qi8H1bjTHMkfZTypiJjVuUxoFVT2vvlTaNKg9tKxtPDX/qm9d6
	NN8VOF95dio+9uNIz7s4dkTmOxz6RyApr2HAu6mzK3AgpTHtpZJzR2YOJypEyzSFG+7uBFcK
	vi41FycPmg/MXs5NljsTN2/ftmH9bnV+evKkNJARWZWmvYS+HZKr2vfMSujUD/bCN9R8dF1M
	81xNwuawu59XKRWUXqN6MZbU6VX/AfQjJ8UUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsVy+t/xu7rvd8mlGnR28Vjs6T/FZLH6bj+b
	xevDnxgtLh2Vszj7ai67xeUnfBYrVx9lsji5/z2bxaIb25gsLvzawWgx6dA1RovN3zvYLPbe
	0rbYs/cki8XlXXPYLOYve8pusevPDnaL5cf/MVmse/2exaK15ye7xfm/x1kdRD0WbCr1OH9v
	I4vH5bOlHptWdbJ5TFh0gNFj85J6j903G9g8ms4cZfb4+PQWi8f7fVfZPD5vkvPY9OQtUwBP
	lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gwb+v
	WQuuc1VsfHWSqYFxNWcXIyeHhICJxKbVr9m6GLk4hASWMkq0fp3KBpGQkdj45SorhC0s8eda
	F1TRR0aJNX0PWCGcHYwSXadeglXxCthJHPs7lRnEZhFQkWje+Q0qLihxcuYTFhBbVEBe4v6t
	GewgtrCAmcSR3VfA6kUEgiQmr3zCDjKUWeA5s8Tzebeg1q1ikng1sQusg1lAXOLWk/lMXYwc
	HGwCWhKNnewgJifQ4r27UiEqNCVat/+GqpaXaN46mxniA0WJSTffQ31TK/H57zPGCYyis5Cc
	NwvJgllIRs1CMmoBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwCS07djPLTsYV776qHeI
	kYmD8RCjBAezkghveoNMqhBvSmJlVWpRfnxRaU5q8SFGU2AYTWSWEk3OB6bBvJJ4QzMDU0MT
	M0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGps6DxgtCt7+WaL/EPcXtYMdF4e75
	eTVSTh8y1vL36vExZU6vei0QJWzuar/L1Szj8rLL7TO0L5wpr9iuskLIf3+flNhHz7+25frP
	1q5/9Pa8Vlrbz4imWzq8CRV+FiU2a213qCcLXquK62J/wMJ3zN9x1b1jD4wFJ31UfMqcVdi9
	wI/5u6LOijbdXfc4e4xDI4vUuL4/OmPyY5f8v+XzGGbMbqk2k/9qsjjmluRub27f6JrEhxIf
	K/ewVVTdFVx5TLt9ycJGIaOdCyef117/ty77dJaxXaDnkwcWT9f5KUvyfX0bNZu7+47ChIbj
	Nhed1rcFvTqzU/zJ8iaNBwc0HKXvfPiUrhfs/nipQ+JpJZbijERDLeai4kQAWQAI6MsDAAA=
X-CMS-MailID: 20231005133231eucas1p2df60b494ece43160cfe55304468308fe
X-Msg-Generator: CA
X-RootMTR: 20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
	<20230929102726.2985188-22-john.g.garry@oracle.com>
	<CGME20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc@eucas1p2.samsung.com>
	<20231004113941.zx3jlgnt23vs453r@localhost>
	<b6ed0e26-e3d4-40c1-b95d-11c5b3b71077@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_063241_304998_35562C31 
X-CRM114-Status: GOOD (  11.13  )
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

>>> +                blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
>>> +                blk_queue_atomic_write_unit_min_sectors(disk->queue, 1);
>>> +                blk_queue_atomic_write_unit_max_sectors(disk->queue,
>>> +                                    atomic_bs / bs);
>> blk_queue_atomic_write_unit_[min| max]_sectors expects sectors (512 bytes unit)
>> as input but no conversion is done here from device logical block size
>> to SECTORs.
> 
> Yeah, you are right. I think that we can just use:
> 
> blk_queue_atomic_write_unit_max_sectors(disk->queue,
> atomic_bs >> SECTOR_SHIFT);
> 

Makes sense.
I still don't grok the difference between max_bytes and unit_max_sectors here.
(Maybe NVMe spec does not differentiate it?)

I assume min_sectors should be as follows instead of setting it to 1 (512 bytes)?

blk_queue_atomic_write_unit_min_sectors(disk->queue, bs >> SECTORS_SHIFT);


> Thanks,
> John
> 
>>> +                blk_queue_atomic_write_boundary_bytes(disk->queue, boundary);
>>> +            } else {
>>> +                dev_err(ns->ctrl->device, "Unsupported atomic boundary=0x%x\n",
>>> +                    boundary);
>>> +            }
>>>
> 

