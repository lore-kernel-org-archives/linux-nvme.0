Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAFFC4708F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 15:16:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC2760FF3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 15:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC2760FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KPRnOr3nrC7/OJ9uMpzytg7b0Ea93o4pm9d/oBWhPtw=; b=zVRPWz5CiNEfmc
	hnItYkaUp4AOgI3A5t33yd0Yo04CBHf95ZBeKzx4y9C1rmYqN1ZK8iYFie8Y/q/QdYGI4qtCTo4+c
	r8eG6sm8H4CxKnB+h5okUJ0z+SHnUneKGY/W00kUWY4jaHrffnRUfoLkv1503l5QvG6Ik0qTQ7CSh
	H4TOlAk4Sm4xw8bsCTxtRE/2ivOmGaKfo0RGd/KbGAmNHRKBCZYDsVQKu/lBK1qF9+KTV5dRnMyfu
	WcOfCtsEwaGg2xc/GGdcehfB28oAn/zfyrX/4oFWN7Y2DSTzM7qvdyeRVOWDsLdliKa/sOY9BMKJL
	e4AwQa68DGzIw01KytJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo67l-00HAi1-Fo; Tue, 01 Jun 2021 15:16:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo679-00HAPI-Sq
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 15:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622560530; x=1654096530;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bjOO6I/yE3H5O9H9JMLzXqJEe4diT399FZPEixnog1A=;
 b=dUypJFXZUdh0SRNMkth64x3GiqPNFHlPOo2bBhpe2f2m8lnASgVdQSnA
 y7GZ8YMZZ8iwS7lc5m+cfjsT8iMSy5J3qtMSJYR/1g5F0bbhwgiQAGw4b
 CGnelXQwrGdjWp4IMQo0SdauSC574k1yFzIEF/wTGnTr7rKZMItSDiEdv
 8FmMQKx5Ai0DN76pRcJYV8uE2quGqmta00H8ZtRB4nKc/I3ligynP7LLE
 RhR01072ergHQp/ARkFBiOiQ170uKHxcTGkUmzyFZZSbufMPF8UPAOat7
 NehhhhDmNRa4+RsxxUXET0+h9dHbZEOzs2Svgv3qx4KlJjOTnmosh3iqh Q==;
IronPort-SDR: y8UddyziGgqm9VTDkzhnFcfbxe4yF/QHLjklEcioIzZGpBVy72xU8vO89hXghJtqXsJaO/v51P
 SLpueidObQfyvypN99QZIN1qmktZcytESsIo8AfroGnthxg8qZgk/pTm1UzWJiwVvHDc0BCHJm
 tHv+7sPIMUE/J/ynfxJxP2rEJzlY0eraDj+ykgvNUBZjvBadcgpmyzROSUeU2ssc55/Ao8QjY0
 HffyC/xQw6RVUXM8T0eMdLjIJlfdb46TmFoNTkWb7WONAux+cew0IMTG7iQcK8NspvOKiUvMqo
 lB0=
X-IronPort-AV: E=Sophos;i="5.83,240,1616428800"; d="scan'208";a="170288324"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2021 23:15:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0RehHW0UhTEIUqzS11mQ6ZBLZWoBOGEWjMaJ1NuP8W5piFb3pbIdyyeTQG9ThlPogVwirWWRpYU9RV1MdPi6LDloZCOgZm8FDurdB+BaJn2xss49PhGyC7WM+ivw3Ai+TkVuIBwWurbx980SrI1bMDrJnl7maxwUjEr8Yya79LKY1CDMUES5lSm+QPrrgzYmfrL2ky/PIVB7eYxNcic85f99FHdo41oTRKjK7NHZbHKlHvR+8hzCqfIqiMX4dSq1rjcFOCN3CXJVf62kmTCN+4qBAIrtH++cvv1knynl6YDR3p0avegEd/Pb1Hs2VpLDRjhfoyFrFDTmPd4OjG+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjOO6I/yE3H5O9H9JMLzXqJEe4diT399FZPEixnog1A=;
 b=bGCEP1wYLMKFpR4BiLuu6+wCzEkg9XSJQhvnqgCS9OpWnTvaQGyjQpNYz9RWF0Jwqo0gyzxBfgZ7e2iGxclnRLJBHjJJ4zrRdZL2bPzzKIXGOQ68yYstZbIlf+b2croHDuZxtQ1PEFHOx8vRyXVYCzVH2yM/9m9IV2cMm0zkBLknljs1sO4z92pTjewd5RbTDFeZ1leRC/lwNXjirP3bp3R8ivBle1TAejrr+cs36ldciJYGqsZmZOU72tdJuvnp7tjrHER25Wj+XjYMoF6xjNafwENQHxuKJJ01lnlkxasx0RtnTvgjznNHyb/OIB6N9XKUIeQoDDQeag5pTHY0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjOO6I/yE3H5O9H9JMLzXqJEe4diT399FZPEixnog1A=;
 b=A4oD0xAfA0J8fjeU9piyGUI0vnfe0f3HTJdmd8vThNDuJ6Tl0cc3vblhggNN3XEekbyJIO+I7uQ+iNmt7duUfAXLPt1Sk9qvmYMOTJ3BXrRQ4nfoxCyhOKgurUrOkjmDExmMrfHg57s/x0y0/QjwPFxo6cESbfVtkqjGtpw3gC0=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7351.namprd04.prod.outlook.com (2603:10b6:510:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 15:15:14 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 15:15:14 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVME_IOCTL_SUBMIT_IO access control
Thread-Topic: NVME_IOCTL_SUBMIT_IO access control
Thread-Index: AQHXVg1wiuJ99YXz7kOV/ZWcdShpSqr/Ls8AgAAW7IA=
Date: Tue, 1 Jun 2021 15:15:14 +0000
Message-ID: <YLZPAV4Cu8ZuYe/Y@x1-carbon>
References: <YLTD7gcSIiNRJvGX@x1-carbon>
 <20210601135310.GA4197@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210601135310.GA4197@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3e50b47-0868-4c3a-45bf-08d925100eca
x-ms-traffictypediagnostic: PH0PR04MB7351:
x-microsoft-antispam-prvs: <PH0PR04MB7351B2759BF187326166BAE5F23E9@PH0PR04MB7351.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDZA2mmRNvCAtj6ODZvcRgnHYqUaR7YiuNQdsgZdtX1oTLsNRO0xeqMg1bLfzZWASwv3wVSY+cZ6G0Kit4KFqJmtyUqp3PeCTG5Sx1jkN87SehwAdVtSOEKFkNJWSe7c9bDlYapGa7NQ23ytkLiAeXVWSAfFHuQeOrVL6dzPDqLM38uydnG+FxPHk9JiL7koTcYim/M8IQQkamlLzXoDXX5HYUJj8VnablTdFxg53zjM1aJ6TCrsI9xCNo8z5m8jVfd2Jmf2EpTWuVsdH2x+A4bEeA9/QHpoUiYEGPhD4aMI/5UHkHsPKohOUFXPq+GzH2Mbvhk7X32VzA+2Dj0SKMZxrb3i09LNnXK4BS20ccNeQbNS0cegKwZPPrSV0p8UJ5LvRWgDMDN8xeEY2y1xrZH54pjx5mS2gYthkrb3m6shJQs3h6du/Waxg3wCHkrMajjIXsqxNjZKj/ohX2o4D2lkzVl1pWc2qargYl9+naLNBPABFIXVEHJxvh2SAmUfV7tsFUvJiNm8gdfufKTjFKVrt0kF8PVjyWU3aJceDXnYKiEmrQ825pyWCJAfEzDhLn24hABBLuK9humaa2F2bvnUJRqLjHcPoRARJCTud4U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(136003)(39830400003)(396003)(346002)(366004)(376002)(9686003)(6512007)(71200400001)(83380400001)(478600001)(8936002)(86362001)(66476007)(4326008)(76116006)(6506007)(66556008)(64756008)(66446008)(66946007)(6486002)(316002)(122000001)(38100700002)(7116003)(6916009)(5660300002)(186003)(33716001)(8676002)(2906002)(26005)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nhNwifPMS9CtNcQUyjCyD8maNSzYZ5QN+uxkqKU7jA/Cn0h+6L7x+Mk9mkcP?=
 =?us-ascii?Q?aoGC9tVe+D0G3p6WgCow5gp3r3LIxtmJ0BuTjdHJxW4Tgw3L6cj1ICcP3kYt?=
 =?us-ascii?Q?RtBaltS04masgt3zb6AN2qaXUpYfa7bzyTQI9h4UxNic1h7a9ZTo8df//Fqc?=
 =?us-ascii?Q?Re6csX4keYWIS/fZ4AOdJIL2cVQeUN+xH8KERj/WD7NUXy3qJb3b54FuATit?=
 =?us-ascii?Q?y9y7dI9TF2Db6swGIWKoHo3LshFI+d/+13U7PQzRVKg43UhAzt9ukmEIeH+E?=
 =?us-ascii?Q?XcMdPybGPMjHxfkq3dkcNm9J/3kbzfERqAG8TwFWLlb+F5LKFiNROZkmahto?=
 =?us-ascii?Q?oXcmb0kQUqwuPywVvCXky5pjlJ8ys3gFRgzxyEAm2kR0m/bNGVJiw9/jeR1i?=
 =?us-ascii?Q?PaYZ2KqBAAZO7QhmpMJEvecw19h0OvIwKgpnTdc1FNyN+OGA38Y+WYiyhb8R?=
 =?us-ascii?Q?qHvRfZKETLe/NrKM9OtzVzd4YbwYi6zYHYwyRRNMpp3zxQvY82WheZnq0R+l?=
 =?us-ascii?Q?hnytRHiihkFqUSnB2TvXighaFTfBMpEB+bX1n2SBjr7VhQx4tU/2vYSQws2R?=
 =?us-ascii?Q?HZ5PM3Rx2+aVSjaXtrbAc244u0ibPr0N01k3VcreL/8Nx46nSL0Ug/kQrap9?=
 =?us-ascii?Q?8hdHmzlbmo2uxPsfMgZ5n+SxgDU91rWNz+hfiCeuSAIAjtlTsn0THCiZk9d0?=
 =?us-ascii?Q?P6W6PETUbYkmdAfZIxOcIaMIFfFTRRwIdXx31zhZb0wlCUrVvAkWLc7bT3sE?=
 =?us-ascii?Q?lanz4m+RobaHyf1c7uJGjjnpt3ljMHDNjuxsvGNkBoXrBcX+9NvPJ/K2nOSd?=
 =?us-ascii?Q?0BElmxEgOuus0RBo/Msha574kJBI3l32m35hA/0sn1J57AIJKqUCrU8Yspaa?=
 =?us-ascii?Q?BBK31EkfLeEdBVPcoN495xqUZTkITSeSQLFwrJROhJm9TKlqgjqFxIdhPaa2?=
 =?us-ascii?Q?7m+zsvDcIq9EspezgSjIwKDPivMiyugy+NwtezBwVIe3m/0b0a/M1/FXtTTD?=
 =?us-ascii?Q?T3FHVhgxAIz4jcqz43CEUa0D49lg/Er6AFy2NCsMCZtExtqLIwHvIjUW+5rL?=
 =?us-ascii?Q?kiBPb26ZPYrDzPELlnqbABG0jUmd6u1Lt7XZvFucLgQIZVlsj5+Yyx4kb8qE?=
 =?us-ascii?Q?2MTKJzksuZz+06gnOl/NsO1h40pbrlDpJu/tUGe5jNjlfn5Kj+SZ2bsknDXx?=
 =?us-ascii?Q?p94w42bjTVUltbnRrmPezF3R1iZzw+OTu/lVwZFH9ipQMgy6nddnOTko1X6x?=
 =?us-ascii?Q?AWETFAJbq6oKLWxym5Mb7s4EFWTNGktx9AP761cdSG7ftF2AF4xd8TDPN9TX?=
 =?us-ascii?Q?UjXxUmnnTGC92syydAhVxk9z?=
x-ms-exchange-transport-forked: True
Content-ID: <2AE956EDC1AADA4B8908ABC38ED14825@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e50b47-0868-4c3a-45bf-08d925100eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 15:15:14.5984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OIIG5lj0usb5Q3gVwgFO0QMiVzfANum/hjt96T8xxynJ1DidDveKqNIf/kOBF5xZnwT5TzF+7hByOtuM+u2hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7351
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_081532_837942_73B0FF2D 
X-CRM114-Status: GOOD (  22.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 01, 2021 at 06:53:10AM -0700, Keith Busch wrote:
> On Mon, May 31, 2021 at 11:09:35AM +0000, Niklas Cassel wrote:
> > Hello there,
> > 
> > How is the NVME_IOCTL_SUBMIT_IO access control supposed to work?
> > 
> > $ echo "hello" | nvme write /dev/nvme0n1 -s 0 -c 1 -z 512
> > /dev/nvme0n1: Permission denied
> > 
> > $ sudo chmod o+r /dev/nvme0n1
> > 
> > $ echo "hello" | nvme write /dev/nvme0n1 -s 0 -c 1 -z 512
> > Rounding data size to fit block count (8192 bytes)
> > write: Success
> > 
> > 
> > Am I supposed to be able to do a write if I only have read permission?
> > 
> > $ ls -al /dev/nvme0n1
> > brw-rw-r-- 1 root disk 259, 0 May 31 10:59 /dev/nvme0n1
> 
> I'm not sure, we've always allowed any user passthrough command if
> CAP_SYS_ADMIN capable. It should be pretty easy to check permissions for
> any data-out opcode against FMODE_WRITE. We'll probably break something
> if we do, though.

Hello Keith,

Indeed,
NVME_IOCTL_IO_CMD and NVME_IOCTL_IO64_CMD does require CAP_SYS_ADMIN,
however, the same is not true for NVME_IOCTL_SUBMIT_IO.

Which is why as a regular user, with only o+r, I could do a write using
NVME_IOCTL_SUBMIT_IO.

In one way it makes sense that NVME_IOCTL_IO_CMD requires CAP_SYS_ADMIN,
since you can send any command to the drive using that ioctl.

With NVME_IOCTL_SUBMIT_IO, you can only submit write/read/compare.
So it makes sense to not need CAP_SYS_ADMIN.

But I probably would expect data-out to be checked against FMODE_WRITE.

I just wanted to raise the issue, in case this was accidentally overlooked.


Kind regards,
Niklas

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
