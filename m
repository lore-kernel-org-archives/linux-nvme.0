Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71F6C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fa8r8WW2pxVamcUlGFgnD0PZQxDnIG072fSiD+wPliM=; b=pKgffO8SNU/kn1
	pHpcpo7d/u0UC6Ebm5ApJIudQU2LeSeoqFGJiy5ojq5yygAYYsQ/iOdztrUHdmh+cMoXLtruekNzo
	OTwkM+oAhrCBCY9je+wzNUAeD+PQbkgbuM05fTpemCPmd7M1ay0idyMT0YuQbubemg0na0rmk1vjR
	0fJZahtX0CcvQYPBbGEzn+Fr3b8HS387puIRxNADeRuOPo0pD9e9PDIsjsl5BJOauln9eQ72Hqf/S
	I3jGA2QTJINhp5sMiyZMhUHrF5/2lpDQ9Z9sFtpEzxK+2859P0bVv5zYllDi6PRpOJUp7kCFzXlhU
	rtuVfhpjTINbbI3cQ0kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD4ds-00FrSQ-7I; Thu, 27 Jan 2022 13:16:48 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD4dk-00FrPt-Oo
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:16:46 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220127131637euoutp014632c0e25878236f588779ad9ec0b33d~OIwAn59Vy2614626146euoutp01f
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 13:16:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220127131637euoutp014632c0e25878236f588779ad9ec0b33d~OIwAn59Vy2614626146euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1643289397;
 bh=Fa8r8WW2pxVamcUlGFgnD0PZQxDnIG072fSiD+wPliM=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=vKxuqnGACSCBhofTOnnuVUu/V4rX98+tP0V5Go3hGLgIUVVUg/r1zQ7RUQkyI1Ed6
 SKFzOvz+JowrzL4BMTO9bBps1kP5oJYGlCTB4CXF9ZqJfYO3AvU6/IVBhaOSvb4QK6
 Lh+tNBkp4Afi5E09ffeDVR7mL6sFFBqDCRVtthUE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220127131636eucas1p1162a315f0ac80155351f26fa4ba7f157~OIv-vuMMi2432824328eucas1p1F;
 Thu, 27 Jan 2022 13:16:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 19.CB.10260.43B92F16; Thu, 27
 Jan 2022 13:16:36 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220127131636eucas1p25c880e2eb4c56d6cb26a3738702b7492~OIv-PQ6aC2964729647eucas1p2_;
 Thu, 27 Jan 2022 13:16:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220127131636eusmtrp2362a6fbeffaa58b3e6cfbe7763cfcdf9~OIv-OonX41525615256eusmtrp2T;
 Thu, 27 Jan 2022 13:16:36 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-57-61f29b34389d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.77.09404.33B92F16; Thu, 27
 Jan 2022 13:16:36 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220127131635eusmtip26b5d62d80c41e0b179316063c9735d99~OIv-GO9mj3018730187eusmtip2T;
 Thu, 27 Jan 2022 13:16:35 +0000 (GMT)
Received: from [192.168.1.32] (106.210.248.16) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 Jan 2022 13:16:33 +0000
Message-ID: <e2e59745-c7e7-5f00-bd62-9b2d653cb6da@samsung.com>
Date: Thu, 27 Jan 2022 18:46:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: Use pci_iomap instead of ioremap
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Pankaj Raghav <pankydev8@gmail.com>, <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220126172204.GE1885300@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.16]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduznOV2T2Z8SDb7OUbRYufook8WkQ9cY
 LeYve8pusebmUxYHFo+ds+6ye2xa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBm/Hv1i
 KbjCUjF5/g2mBsZ7zF2MnBwSAiYSe3aeBrK5OIQEVjBKvLjczgbhfGGUmHuolwXC+cwoseHA
 c3aYlgvLf0FVLWeU+P9oNjtc1faeN1DDdjJKvF+wkA2khVfATuL3wluMIDaLgKrEiu+N7BBx
 QYmTM5+wgNiiAhESL4/8ZQKxhQWsJdom/AOzmQXEJW49mQ9miwg4S/ztPQ8V95TYue4R0EwO
 DjYBLYnGTrCRnEAl/+aegirRlGjd/psdwpaX2P52DtTTShJvZtyBsmsl1h47A/aAhMAdDolX
 Z1qZQGZKCLhIHD9kCVEjLPHq+Bao72Uk/u+EOEdCoFhi0bZWVgi7RuLVoussELa9xL9Pm9gg
 bEeJV3vWsUOM5JO48VYQ4hw+iUnbpjNPYFSdhRQQs5A8PAvJB7OQfLCAkWUVo3hqaXFuemqx
 cV5quV5xYm5xaV66XnJ+7iZGYHo5/e/41x2MK1591DvEyMTBeIhRgoNZSYRXSOtjohBvSmJl
 VWpRfnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5OqQam3v49fW/dXr5Mb0+6
 KH5wYVoPW1rinpJ+jxVtja9+Mm7vKTMpYC883WM+/cqjO5bBV8v4Xs7fuugSy3/32Y5nTy6u
 vrzH0mFOrKfthmUXzX0CTomaRHtOPZtQu+zh9fWBO5Y1r1vAF7DwlNHlrZqNvLk1J1mbzHKc
 Ta9+nrKsaN+lX1FyN3vlNvRFRm34xXa82GR9uJwrC7P/lm2Oq44zz9/uoGs+/5pmV9WKQ0bn
 ZtU4zqq+5/v31OtTdrNnK83rfHBt8hb1a2pv2Kc8e3wo5E7RVae2reGBIoeXLueUObN2mbf9
 rPN3mTc2lLck8R8pP/6pgnXfSZU1AX9011z4Ez9Zib+EeZvBainZj1yv7ymxFGckGmoxFxUn
 AgBTC/KJngMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7omsz8lGuyPtli5+iiTxaRD1xgt
 5i97ym6x5uZTFgcWj52z7rJ7bFrVyeaxeUm9x+6bDWwBLFF6NkX5pSWpChn5xSW2StGGFkZ6
 hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gb8e/WIpuMJSMXn+DaYGxnvMXYycHBIC
 JhIXlv9i62Lk4hASWMoosfXAFDaIhIzEpysf2SFsYYk/17qgij4ySqzctpwFwtnJKPHy5RNG
 kCpeATuJ3wtvgdksAqoSK743skPEBSVOznzCAmKLCkRItC2bArZaWMBaom3CPyYQm1lAXOLW
 k/lgtoiAs8Tf3vNQcU+JneseMUIse8kosfD1L9YuRg4ONgEticZOsPmcQPX/5p6CqteUaN3+
 mx3ClpfY/nYO1JtKEm9m3IGyayVe3d/NOIFRdBaS82YhOWMWklGzkIxawMiyilEktbQ4Nz23
 2EivODG3uDQvXS85P3cTIzAqtx37uWUH48pXH/UOMTJxMB5ilOBgVhLhFdL6mCjEm5JYWZVa
 lB9fVJqTWnyI0RQYRhOZpUST84FpIa8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1
 ILUIpo+Jg1Oqganc/NZVvdRHTml378++ILlzP5esI3u6dETS0bQt87W93u1v5dYpOFTsVCK6
 TNojpWKHTtMr654liVzhCua5831Dtl/NP3LnXNm+lJX7w88t9jS+8HFzyS7GTS7cCZN4tMW7
 9+WzGb3ctKr6e5jm8w0nf7q3ik00nPEjsP3hZuNkj3vyWkzJwTx1/R+eXLBPKp1suem3zbab
 SSw/2hb/3jH/dWzL99zM5w+ZxNrWaoVFmct9DyxxXHH5n6K5q9//e9zbPhRH3HCb/2+T28sM
 xY9tPid3lDboz8rinPr3tsLxRTbfnm2cYqO9/c8rlRV5R298VrvkIDrfKHyJamNo40TJAM4H
 unIvlc7MsU3ovqXEUpyRaKjFXFScCAAyktHcUwMAAA==
X-CMS-MailID: 20220127131636eucas1p25c880e2eb4c56d6cb26a3738702b7492
X-Msg-Generator: CA
X-RootMTR: 20220121143539eucas1p20202376f83b0b499143c18b1434ff000
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220121143539eucas1p20202376f83b0b499143c18b1434ff000
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
 <20220121143533.164928-1-p.raghav@samsung.com>
 <20220126163306.GB31892@lst.de>
 <20220126172204.GE1885300@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_051641_146228_F9E13C41 
X-CRM114-Status: GOOD (  12.82  )
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



On 2022-01-26 22:52, Keith Busch wrote:
> On Wed, Jan 26, 2022 at 05:33:06PM +0100, Christoph Hellwig wrote:
> The one problem I see with this, though, is that pci_iomap() will
> automatically clamp the mapped length to the resource's length, which
> may be shorter than the potential doorbell registers that the driver
> thinks it's getting.

The current implementation disallow the size to be greater than
the pci_resource_len(pdev, 0).

if (size > pci_resource_len(pdev, 0))
    return -ENOMEM;

So, clamping shouldn't be an issue when we use pci_iomap.

-- 
Regards,
Pankaj

