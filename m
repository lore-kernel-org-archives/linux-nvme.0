Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC72FC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 20:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20BBeE9FNDnApd8L4bGkUtfewRpsjbbAgsEwX3MOoik=; b=Di1jssKcin7AqgDeniH4luUSDj
	YV9cW63cFDUxoqWQvRILzSTpSUHLOOgD39B3L0Hsn+P/rjnDpwVPT4UIxeJawR2npC9VSOfeYc7y4
	7v4+3AShOIXRDHVzS/SecrceaG8m6eHi/GmZUQnZUjuf16pNIsdOhGrVxODWejl1l4+plZ/XsLafM
	aV+wQH4Edx5v6gl4oNT0BOgryxyJI7Ypl5/yIoNzMsAL1bdGxvlKDjs7vcZhNhP0WI9YEKGb2LRMK
	eyndxqrCWPSROH+C1ZYioA8puZBemBlMPJlSj07KrGGwARjLHZQqewFZLUnKjG/XgBabKxJJdJSx5
	ielK3atA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSmCP-000F9D-1b; Fri, 11 Mar 2022 20:49:21 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSmCL-000F8u-MT
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 20:49:19 +0000
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20220311204916usoutp02d69c28b4aec4be9384a6e0666b69e6e3~bbqfrDIeW2051320513usoutp02K;
 Fri, 11 Mar 2022 20:49:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20220311204916usoutp02d69c28b4aec4be9384a6e0666b69e6e3~bbqfrDIeW2051320513usoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647031756;
 bh=20BBeE9FNDnApd8L4bGkUtfewRpsjbbAgsEwX3MOoik=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=nJIHFCbeG+t5UpGIj+0i/k69dYr9V7dFbmw+PHyG0v7kiecy5a1pfg3av59jkNolN
 ln5/xHGJFLDlUY1dV4d3K67UK2GlaTJj/A4vEmaDAJ4sA4LbZEyZBz6LHPzzxtC696
 /PFpyQXZ3gN8EogZDac9xA/OzZas13VWJK2MnqZ8=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220311204915uscas1p2f75a623343d92799332f32c3a27c66b6~bbqfR-D680279702797uscas1p2f;
 Fri, 11 Mar 2022 20:49:15 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id 42.51.09744.BC5BB226; Fri,
 11 Mar 2022 15:49:15 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220311204915uscas1p2194f3456f818a6daae354d5de56c221c~bbqe10qap0278802788uscas1p2g;
 Fri, 11 Mar 2022 20:49:15 +0000 (GMT)
X-AuditID: cbfec36d-879ff70000002610-f6-622bb5cb5ea0
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 19.63.09657.BC5BB226; Fri,
 11 Mar 2022 15:49:15 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Fri, 11 Mar 2022 12:49:14 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
 SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
 15.01.2242.008; Fri, 11 Mar 2022 12:49:14 -0800
From: Adam Manzanares <a.manzanares@samsung.com>
To: Pankaj Raghav <p.raghav@samsung.com>
CC: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@edc.com>, Chaitanya Kulkarni
 <chaitanya.kulkarni@wdc.com>, Jens Axboe <axboe@kernel.dk>, Luis Chamberlain
 <mcgrof@kernel.org>, kanchan Joshi <joshi.k@samsung.com>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Topic: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Index: AQHYNYTs6p9GZnAauUi2ODqsLrRJLay7LfwA
Date: Fri, 11 Mar 2022 20:49:13 +0000
Message-ID: <20220311204907.GA109568@bgt-140510-bm01>
In-Reply-To: <20220311201608.275384-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3E1FDA693719FB4ABC8242B63DA88F51@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djX87qnt2onGRy/qWWx+m4/m8Ws269Z
 LH6fPc9ssXL1USaLKVeXMlmcf3uYyWLSoWuMFvOXPWW3uDHhKaPFmptPWSzWvX7P4sDtcfnP
 fiaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2zgc1jZ+t9Vo/2A91MAZxRXDYpqTmZZalF
 +nYJXBl7N+9gKvjEV7Fi9zSWBsZFPF2MnBwSAiYSO/vaWbsYuTiEBFYySmzfcQnKaWWSWN7U
 yQhT1X1xEiNEYi2jxO4dD9khnI+MEvNmrmIFqRISOMAocemGBIjNJmAg8fv4RmYQW0RAQ+LZ
 lc1MIA3MAntYJCY1LmECSQgLJEgcWnUTyOYAKkqU2HdAHqLeSOLysp9gvSwCqhLX9y4As3kF
 TCX+3WsFszkFrCVmL3/OBmIzCohJfD+1Bmwks4C4xK0n85kgrhaUWDR7DzOELSbxb9dDNghb
 UeL+95fsEPV6EjemTmGDsO0kTnedh5qjLbFs4WuovYISJ2c+YYHolZQ4uOIGC8gvEgL9nBK9
 C5awQyRcJJ4e7YSypSWmr7kMVbSKUWLKtzZ2CGczo8SMXxegzrOW+Nd5jX0Co8osJJfPQnLV
 LCRXzUJy1SwkVy1gZF3FKF5aXJybnlpsmJdarlecmFtcmpeul5yfu4kRmPJO/zucu4Nxx62P
 eocYmTgYDzFKcDArifA2hWokCfGmJFZWpRblxxeV5qQWH2KU5mBREuddlrkhUUggPbEkNTs1
 tSC1CCbLxMEp1cBksfjVx6AfVivmGKdL6yr5H1p1lmOx4cFff/68WHPCf37wn889M9Nlv3/L
 c13SEF13eeclu38HX8uGzGB+5X7+6T/7S3qCIbUtqg1qAquv11+JYXh6ZYLGwwtWlUd2ODd8
 FSrSPSSfUNs4K0Yntqz2wS/DdPuaV9f2tWiz6v0t3TXLt/pOXJ7LWpvqvP+bJQ/6T1wVsXFl
 ZODrR/fN96w/I/Og+Ppq5Zj6Iy3OIWLsd9x1cqYKVrK/Dop4tD2jNFpeuFqTZ3Zl80+FJiOL
 qp91s8NkT4V2c9ZLnrIsibicwr/1/blV4pMNm1Z+mzD528p9H1ryFmVlcuw+r3yndvI1gTd3
 2FozvGM+ngpLtOFTYinOSDTUYi4qTgQAE60YYegDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWS2cA0Sff0Vu0kg117+CxW3+1ns5h1+zWL
 xe+z55ktVq4+ymQx5epSJovzbw8zWUw6dI3RYv6yp+wWNyY8ZbRYc/Mpi8W61+9ZHLg9Lv/Z
 z+Sxc9Zddo/z9zayeFw+W+qxaVUnm8fmJfUeu282sHnsbL3P6tF+oJspgDOKyyYlNSezLLVI
 3y6BK2Pv5h1MBZ/4KlbsnsbSwLiIp4uRk0NCwESi++Ikxi5GLg4hgdWMEt9PTWGGcD4ySmzc
 PJcdwjnAKNG5+xkbSAubgIHE7+MbmUFsEQENiWdXNjOBFDEL7GGReLB3CStIQlggQeLQqptM
 EEWJEnPf72CDsI0kLi/7CdbMIqAqcX3vAjCbV8BU4t+9VqjVfYwSXxasAUtwClhLzF7+HKyZ
 UUAM6L41YEOZBcQlbj2ZzwTxhIDEkj3nmSFsUYmXj/+xQtiKEve/v2SHqNeTuDF1ChuEbSdx
 uus81BxtiWULX0MdIShxcuYTFoheSYmDK26wTGCUmIVk3Swko2YhGTULyahZSEYtYGRdxShe
 Wlycm15RbJyXWq5XnJhbXJqXrpecn7uJEZguTv87HLOD8d6tj3qHGJk4GA8xSnAwK4nwNoVq
 JAnxpiRWVqUW5ccXleakFh9ilOZgURLn9YidGC8kkJ5YkpqdmlqQWgSTZeLglGpgKv77daaB
 X/C6gv/f26cvz9ixf6/flZ+b569/VHOKd6f7M/28Q1lNLe9PVubHV1UYr/2fU8fIFTppw6l2
 mbc3agx9M1O8TafLnA+bs4lZdsanSV2uf0uVX5qvUK/nsjB0T2av/zq56JfFbGmdgrVXA2XV
 1M9+ehNgnJG7YLNpSYXiofVsrTqVxzbev7QxRu3ZfpYO32O3Aj9vvsdyOynwjT9r4Ywcr13P
 lF0Co35emR8v4bVQWWiBnh+X3rW2+yulDANrDC253hypsfu4erEmU/OkCyv3LpZU89OT4JWJ
 nRxkur/ekyOmtv/gtgN/A+Ji+Xsu7TVYUze53jI4Mr+LL9L+8u8L0ZzFudPC90kpsRRnJBpq
 MRcVJwIAySx7k4YDAAA=
X-CMS-MailID: 20220311204915uscas1p2194f3456f818a6daae354d5de56c221c
CMS-TYPE: 301P
X-CMS-RootMailID: 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
 <20220311201608.275384-1-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_124917_981936_481F1D6E 
X-CRM114-Status: GOOD (  23.73  )
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

On Fri, Mar 11, 2022 at 09:16:08PM +0100, Pankaj Raghav wrote:
> This commit 2f4c9ba23b88 ("nvme: export zoned namespaces without Zone
> Append support read-only") exported zoned namespaces without append suppo=
rt
> to be marked as ro. It does it by setting NVME_NS_FORCE_RO to the
> ns->flags in nvme_update_zone_info and later nvme_update_disk_info will
> check for this flag and set the disk as ro.
>=20
> But later this commit 73d90386b559 ("nvme: cleanup zone information
> initialization") rearranged nvme_update_disk_info to be called before
> nvme_update_zone_info thereby not marking the disk as ro. The call order
> cannot be just reverted because nvme_update_zone_info sets certain queue
> parameters such as zone_write_granularity that depend on the prior call
> to nvme_update_disk_info.
>=20
> Call nvme_update_disk_info after nvme_update_zone_info again so that the
> permission for ZNS drives are marked correctly.
>=20
> Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 51c08f206cbf..67a78653b07c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1913,6 +1913,11 @@ static int nvme_update_ns_info(struct nvme_ns *ns,=
 struct nvme_id_ns *id)
>  		ret =3D nvme_update_zone_info(ns, lbaf);
>  		if (ret)
>  			goto out_unfreeze;
> +		/* nvme_update_zone_info might set the namespace to be marked
> +		 * as read-only. Call nvme_update_disk_info so that the disk
> +		 * is updated with the appropriate permission.
> +		 */
> +		nvme_update_disk_info(ns->disk, ns, id);

Shouldn't we make this conditional?

>  	}
> =20
>  	set_bit(NVME_NS_READY, &ns->flags);
> --=20
> 2.25.1
> =

