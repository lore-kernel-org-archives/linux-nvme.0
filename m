Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07051C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6lmUqoNb0Fl6tc7HphjzZeT0P3ilmXbW5wrobBmv+yo=; b=V26mkYPhmq+zun
	wi42PBAvt9C2sLxfJcDe2bI7Iz4/igtpf7fcDOl+5TlckJSGBWBsYYzSpoW+qdJTndrTrj8fFMtZl
	Du38HMSDb4IfzsUbF0MDpvwkA6ilf+Apnd+DfLn0/UQWf24veS5PDymcovbzb6flarbx/OFvXpYDO
	tShhb5GxFv516Fdec3mW/xoCFOMHa/RogpwGtC5d3LPZzCaKVRMq6jQvQDajhUUrrJaSOTtmkPrmC
	LWDW+2nTCOZ5riCzHEtvNmxndibbQgvUJW8YNrBZlQ9QtYB8n6tNojJgoM/SZ+Vk1k1AyA7T226sa
	I/6ruzUpsD6dZ8QxBt3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWwKL-00D6jO-Lp; Wed, 23 Mar 2022 08:26:45 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWwKI-00D6gc-H5
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 08:26:44 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220323082638euoutp010480b10e7b71224e3f6da555584ad970~e9RhTmI1a0348903489euoutp01d
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 08:26:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220323082638euoutp010480b10e7b71224e3f6da555584ad970~e9RhTmI1a0348903489euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1648023998;
 bh=6lmUqoNb0Fl6tc7HphjzZeT0P3ilmXbW5wrobBmv+yo=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=IeJp+FtGIYRZTQqIcl9YihSayTRMLE7deAS+83bhU4Svkld/3irrATiEVNSzZhkIS
 mxWeF5M8dyyyPM4U45xRkcWkUlcWSYSXlPutwhSwens7HzPfzx10yxm3g0jWr2ZVO6
 H+jGzMtq7u88K1b5kvHCTTr1jad0RncrhcSsTL+Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220323082638eucas1p2b2d4e17111718c69ab8a89cc7ea42ec9~e9Rg3994o0760607606eucas1p23;
 Wed, 23 Mar 2022 08:26:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.FB.09887.DB9DA326; Wed, 23
 Mar 2022 08:26:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220323082637eucas1p1da08bba01db7506a1c013c3198e9cb5d~e9RgZL-QV1157411574eucas1p1E;
 Wed, 23 Mar 2022 08:26:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220323082637eusmtrp1560e4efa9380a4da0ee7c88c7334918f~e9RgWHY1k1676116761eusmtrp1V;
 Wed, 23 Mar 2022 08:26:37 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-60-623ad9bd7a42
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.92.09404.DB9DA326; Wed, 23
 Mar 2022 08:26:37 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220323082637eusmtip23a31e761a4f8039136dc488c620bb93e~e9RgL7XSv1515315153eusmtip2b;
 Wed, 23 Mar 2022 08:26:37 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.55) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 23 Mar 2022 08:26:31 +0000
Message-ID: <c9b95d78-2a43-8122-8944-2ce5b7aaee4f@samsung.com>
Date: Wed, 23 Mar 2022 09:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] nvme: Fix zns drives without append support to
 export correct permissions
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, Keith Busch
 <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, Jens Axboe <axboe@kernel.dk>, "Luis
 Chamberlain" <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Johannes
 Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav <pankydev8@gmail.com>,
 "Kanchan Joshi" <joshiiitr@gmail.com>, <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220323082051.GE26611@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87p7b1olGex/a2ax+m4/m8Xvs+eZ
 LVauPspk8bfrHpPF+beHmSwmHbrGaDF/2VN2ixsTnjJarLn5lMVi3ev3LA5cHjtn3WX3OH9v
 I4vH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we7Qe6mQI4orhsUlJzMstSi/TtErgydr56y1TQ
 ylgx4U0fSwNjahcjJ4eEgInEqyeHGbsYuTiEBFYwSszuXMAK4XxhlPgwdStU5jOjRPf1Hyxd
 jBxgLR+nx0LElzNK9L9cwAJX9Lh5CTuEs4tR4tDzK+wgS3gF7CSaGh+xgNgsAqoSL1YfYYGI
 C0qcnPkEzBYViJB4eeQvE4gtLJAscfD3RDCbWUBc4taT+WC2iICSxNNXZxkh4t+YJV68dQC5
 iE1AS6KxE2wVp4COxJqJP1ghSjQlWrf/Zoew5SW2v53DDPGzksS1509ZIOxaiVNbbjGB3Cwh
 sJ5T4tCtHqgiF4kZ7xczQdjCEq+Ob2GHsGUkTk/uYYFo6GeUmNryB6p7BqNEz+HNTJAwspbo
 O5MD0eAosenOQjaIMJ/EjbeCEAfxSUzaNp15AqPqLKSgmIXk5VlIfpiF5IcFjCyrGMVTS4tz
 01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPY6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8iz+YJwnx
 piRWVqUW5ccXleakFh9ilOZgURLnTc7ckCgkkJ5YkpqdmlqQWgSTZeLglGpgKpPRmbubZXvs
 3eXHPi+raJ0uXOaVEym/OWuS//zm2wY/dHRmr462fbbO/d7OZvOr+VL5Ltrsbt8nTJdd6HLj
 8I1397lmvjqyR/HCwv5F7+bbfnq7K7VuX0/F9zkbvzPcYbLoXvnjhmmJjPw7HtXTN6d0nU9t
 S9vi4f80vsgm1/zHdYObhv5B5jL130Qev7+W+KI34BrbhC9XnNeqqnet8mtJ83DyWc6xgtHl
 mu4XmXnusR2XNu7kW8O1PUe1b5d9mY7+L2Enzl/XvL6+OThzqzTD99QL271VXH11dazPO67/
 8WsDj9oPz509K6Z9OWD/9UOw6xb23d2F64R0i+cUNfUkvnzm2X0s0n+ZQ5fvLSWW4oxEQy3m
 ouJEACkTnAXPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xe7p7b1olGdzvErdYfbefzeL32fPM
 FitXH2Wy+Nt1j8ni/NvDTBaTDl1jtJi/7Cm7xY0JTxkt1tx8ymKx7vV7Fgcuj52z7rJ7nL+3
 kcXj8tlSj02rOtk8Ni+p99h9s4HNY2frfVaP9gPdTAEcUXo2RfmlJakKGfnFJbZK0YYWRnqG
 lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZO1+9ZSpoZayY8KaPpYExtYuRg0NCwETi
 4/TYLkYuDiGBpYwS166sY+ti5ASKy0h8uvKRHcIWlvhzrYsNougjo8TrtvvsEM4uRomfX56w
 glTxCthJNDU+YgGxWQRUJV6sPsICEReUODnzCZgtKhAh0bZsCjOILSyQLPHzyikwm1lAXOLW
 k/lMILaIgJLE01dnGUEWMAt8Y5ZouvaEGWLbWkaJnZOfM4PczSagJdHYCXYep4COxJqJP1gh
 BmlKtG7/zQ5hy0tsfzuHGeIFJYlrz5+yQNi1Ep//PmOcwCg6C8l9s5DcMQvJqFlIRi1gZFnF
 KJJaWpybnltspFecmFtcmpeul5yfu4kRGPfbjv3csoNx5auPeocYmTgYDzFKcDArifAu/mCe
 JMSbklhZlVqUH19UmpNafIjRFBhIE5mlRJPzgYknryTe0MzA1NDEzNLA1NLMWEmc17OgI1FI
 ID2xJDU7NbUgtQimj4mDU6qBKSUm5JncGyuj0xnz9RfqWaU0/A++qP76RG6Zfsrt6oXLC9S3
 /C/ZeSxMQSD+7atl9xkY373uWR1+QMJA7uqk0AVOt6WnLTHMvOMqLNk54Z/peouH9SsWfndI
 i+tg5zINzPjS3DpxfZdN4qJTFWYTZwiY7r6beF/gy6q/P/lnqBwtWJSgtXZdQPlChgntCZnp
 ednB38zE1wRzLC0tjfhgW+L159bCo3tPbjumrVg9/Z//1glGIUnNc/xXPmC6Or38YLlx3p8j
 brmLFgW7HLsqL+XksfqQZ9vbSUu1GfK4d04sYloVviW9v/pBYuS86vmbAz2XyLced/h20Ocf
 z2xWmcfdP8xZQ64WL7BkXalnqMRSnJFoqMVcVJwIAJorvP+EAwAA
X-CMS-MailID: 20220323082637eucas1p1da08bba01db7506a1c013c3198e9cb5d
X-Msg-Generator: CA
X-RootMTR: 20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6
References: <CGME20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6@eucas1p1.samsung.com>
 <20220322092048.81622-1-p.raghav@samsung.com>
 <20220323082051.GE26611@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_012642_894312_A7A6E863 
X-CRM114-Status: GOOD (  10.70  )
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

Thanks Christoph!

On 2022-03-23 09:20, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-5.18.

-- 
Regards,
Pankaj

