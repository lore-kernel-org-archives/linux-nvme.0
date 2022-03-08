Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8251DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UsbxH9fg3b5xy+eQ7G64zPG/vz7t9w1vpzYP7pFWkLY=; b=UmNsZqF1JRANAv
	898/lqYYNhPp6SLrk56x/Yv8S75NcKBfBA15WU6QVwNPedyIfkUHkLX+NmeZzxM+Io5cYDX3AlAev
	zW8p0fNFMD/5hgiK+mSofV6uODKHNivtFyjU0xw9gfdmh0zURi2EUAXeu9fJpaY3DnkD0NNv1Vmyw
	pPhXYY9LzK2kAjrSliMh3rP0epfVE28gfrICYxtxOQLjfLye8ROhG6qe8kFo+WNTeNMEAanChlJG5
	10B+nDRWJf/iV2Gy7y/qjSMOlZA69eH96EcpusF8TY7kWMzk9Hx9vmEMbiBNsjBsMEWGu+iHj3gMA
	EAMzYZZIZ5NiC1SoP11Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRdta-005cxp-2u; Tue, 08 Mar 2022 17:45:14 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRdsI-005cK8-OY
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 17:43:57 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220308174353euoutp018ab53ee76607e76873a8716742d2ff1c~aeMxl_ser1811818118euoutp01m
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 17:43:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220308174353euoutp018ab53ee76607e76873a8716742d2ff1c~aeMxl_ser1811818118euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646761433;
 bh=UsbxH9fg3b5xy+eQ7G64zPG/vz7t9w1vpzYP7pFWkLY=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=Rs8gS3uDO8R1cIjTONiYNlhYW7WCxlN76W15T7uJXFNPDaSEF92fEMjVSevMV7y7i
 Mf82lXt1fdyzzkkwOLTLQxpQZ0N0bg+eFrQahCIdmUMu6PHVHN08tSxWqCPr9hm1ae
 YYw2nfFf2m1Fzz+s8Lyr2qLjujkouOAG83Hk4vFE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220308174352eucas1p1aaaec481d602b464e8b3f8c749ec971a~aeMxTjOi52364123641eucas1p10;
 Tue,  8 Mar 2022 17:43:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 34.32.09887.8D597226; Tue,  8
 Mar 2022 17:43:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220308174352eucas1p274d31bc984ef986db5fa81a1af0ed79a~aeMw5u1vy2114321143eucas1p2a;
 Tue,  8 Mar 2022 17:43:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220308174352eusmtrp27ff2367cb879c65630cf89d3b98622e6~aeMw44eQm0325103251eusmtrp2k;
 Tue,  8 Mar 2022 17:43:52 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-4f-622795d8e1be
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.77.09522.8D597226; Tue,  8
 Mar 2022 17:43:52 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220308174352eusmtip15000d2bbae96a65daaba579199aa454f~aeMwt4oJO2560225602eusmtip1O;
 Tue,  8 Mar 2022 17:43:52 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.181) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 8 Mar 2022 17:43:49 +0000
Message-ID: <943d3d68-0a6b-faba-74b1-10aa4c26d99d@samsung.com>
Date: Tue, 8 Mar 2022 18:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier.gonz@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
 <jiangbo.365@bytedance.com>, Pankaj Raghav <pankydev8@gmail.com>, "Kanchan
 Joshi" <joshiiitr@gmail.com>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220308171457.GB3501708@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.181]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7o3pqonGVzqVLVYfbefzeL32fPM
 FitXH2Wy6DnwgcXi/NvDTBaTDl1jtNh7S9ti/rKn7BYT2r4yW9yY8JTRYs3NpywW616/Z3Hg
 8fh3Yg2bx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2QCUa73P6vF5k5xH+4FupgCuKC6b
 lNSczLLUIn27BK6Mi/9vsBY0sVdcmnqMqYHxMGsXIyeHhICJxJoLn9m7GLk4hARWMEr8OnKL
 DcL5wijRvX0tC4TzmVHi9tzFLDAtJ3acZYZILGeUaPt9mBmuav/+41DDdjFKrJk7gx2khVfA
 TuLz/B9A7RwcLAIqEif+u0CEBSVOznwCNlVUIELi5ZG/TCC2sECkxPS1e5hBbGYBcYlbT+aD
 xUUElCXuzp/JCjKfWWAfi8Smu9eYQGayCWhJNHaCreIUcJaY2XmXCaJXU6J1+292CFteYvvb
 OcwQHyhLvJ28kBHCrpVYe+wMO4R9ilOi51chhO0isWP6O6h6YYlXx7dA1chI/N8Jcg8XkN3P
 KDG15Q+UM4NRoufwZrCDJASsJfrO5ECYjhI3D5pBmHwSN94KQpzDJzFp23TmCYyqs5BCYhaS
 j2ch+WAWkg8WMLKsYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECExyp/8d/7KDcfmrj3qH
 GJk4GA8xSnAwK4nw3j+vkiTEm5JYWZValB9fVJqTWnyIUZqDRUmcNzlzQ6KQQHpiSWp2ampB
 ahFMlomDU6qBSYx9i2R8I3vm4o3ey36kzJI6z2Kg7MD5Oim7IZCR5+8pA50P/PLciqpTtqjZ
 P9uwjjX//Ib0ix3HgjZ7nma4OMssIczx2Ks05QNt53RWq1a9aDm24vykTStPdnEnZzjdPMng
 4viIZ46ZQERB26kfWdUs8RFfQwzndjgbTmRbPFEuwdr6scFjHV394yfZP1rmXDTTWHDwuvzk
 HSwlUq06Ft9Mzb90LlBQ32HnN3PBBt6Y+VIrc1dc2LaWy9bpOYPJV1ff9qXvPmx9IrJ3UvWW
 jAytqey9TzKmhLTNmsf/bXWQXtcNnTah2JkmcV4+lzM7lZew377HfFE1Q9T2+vSw44UmhTxh
 uxpLZjXvdnugxFKckWioxVxUnAgAh9ofyuEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Xd0bU9WTDPrXcFusvtvPZvH77Hlm
 i5WrjzJZ9Bz4wGJx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5MeMposebmUxaLda/fszjw
 ePw7sYbNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbADKtd5n9fi8Sc6j/UA3UwBXlJ5N
 UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gxf83WAua
 2CsuTT3G1MB4mLWLkZNDQsBE4sSOs8xdjFwcQgJLGSXezL8KlZCR+HTlIzuELSzx51oXG0TR
 R0aJzYdPgBUJCexilDjfwwFi8wrYSXye/4Oli5GDg0VAReLEfxeIsKDEyZlPWEBsUYEIibZl
 U5hBSoQFIiVm3fQCCTMLiEvcejKfCcQWEVCWuDt/JivIKmaBfSwSm+5eY4LY+4NR4vGa+ewg
 zWwCWhKNnWC3cQo4S8zsvMsEMUhTonX7b3YIW15i+9s5zBD3K0u8nbyQEcKulXh1fzfjBEbR
 WUjOm4XkjllIRs1CMmoBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwMSw7djPzTsY5736
 qHeIkYmD8RCjBAezkgjv/fMqSUK8KYmVValF+fFFpTmpxYcYTYFBNJFZSjQ5H5ia8kriDc0M
 TA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamDacm3ThTd4XhfTyG1+2fS8t
 q6/dmWaZbeAm/uHppmPLZmi/cD9pob+QIeev4CzG70k7rRmU2C7zLbnx4Z94//9tsYkBFp6K
 wSlZM68smXhiSa8l/y+G3B72dxu+Oe/mDVESsb29LDqAW+7ZRp4jgY1R7jvVK95e1NU0nH9n
 wim92cpJ74QX9i7y8m657PA27L/EQvOak83My93Nj4usu3Jq8qGo6QsczQoYpigkNmoWPCyy
 al1vwa5zuPtQEROz7zTVGinrDZ+5D4T2lfqWyUximifwXoOl7XJE2ZZrHrWTAv/mb3SNPftu
 wTK1r+ecBWwNCi4sfJV/4EjiyZ4ehRX9/41PX983cYekqk4erxJLcUaioRZzUXEiABoBjriV
 AwAA
X-CMS-MailID: 20220308174352eucas1p274d31bc984ef986db5fa81a1af0ed79a
X-Msg-Generator: CA
X-RootMTR: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd@eucas1p2.samsung.com>
 <20220308165349.231320-2-p.raghav@samsung.com>
 <20220308171457.GB3501708@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_094355_130649_172D997D 
X-CRM114-Status: GOOD (  15.72  )
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



On 2022-03-08 18:14, Keith Busch wrote:
> The zns report zones realigns the starting sector using an expected pow2
> value, so I think you need to update that as well with something like
> the following:
> 
> @@ -197,7 +189,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>  	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>  
> -	sector &= ~(ns->zsze - 1);
> +	sector = sector - sector % ns->zsze;
>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>  		memset(report, 0, buflen);
>  

I actually have these changes in the Patch 4/6:
-	sector &= ~(ns->zsze - 1);
+	sector = rounddown(sector, zone_size);

But you are right, I should move those changes to this patch as this patch
removes the po2 assumptions in NVMe ZNS driver.

I will fix it up in the next revision. Thanks.

-- 
Regards,
Pankaj

