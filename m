Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4825BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 04:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jzyctvn+J0zRtGQIXYubbyvHIw0RrpJ6tXrimyUEZ/k=; b=hLfw9a4nYWzruwydFRQ+iaTG5C
	qzt7SaDmd/FmTWweckUhyOiFI6iSMyx9Tzgz2k18nG1lX37orFToFboqXQIR801QbhY0bxor6DEiu
	9tTSoVRT7/LsYoBnjdjrqQd/tM97oh7E9iWTS6ukNU3iHC7R3t8Xd1R65s3fJLwPsyvdUfN5I1CG7
	PZUtifwZnyRK4nE7ybhQjPayPwxHuiMXKZwS5PbHMkB6pM7Hfi7T/tmGa8bTYaMjTv3SARbtv0mi3
	q1QgeKmzUT9ztPvwjxYpc4x4NIOerjqWjXZLsa7BecTTDzs1q/Y4v2x+psFlaX0puL+uLQStsT0fu
	E2I9fCEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0yOj-0071cC-PJ; Tue, 14 Jun 2022 04:43:25 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0yOh-0071bs-8J
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 04:43:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655181804; x=1686717804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rvkBbb7O5cy79K1ATLN2/9P8nXyE5+dn/LdbnNvkkMs=;
  b=afPt0FKsj9jbUc07Jm7bb/e8yPDmMuWZbOZ6qkd4oHhBYgFjmjJICrKY
   qlqD1W11GA1+hsuIORIXoiSwjYZqiV23f4X6V4iqimGTZDkdyQkKOq+da
   BXXtribumWThWGx2r3w0bdTrgoL9caaG9c2cjOrCOgrpnU81Vjabs7JgU
   KbZQOQHdRjjjPFuo2xNFVhpboZB5a53/nQ+vwxKOhhk8W/akWnU3EuPHt
   4o6H1mpz43R8kw/LQrccNBIVNP4Npq0aF13n0d9esqi+GVHEOOCvn49Vb
   TGA6FJFWRRcyYvxP4UVzzbCyzub89y0wKy0LX6ZsxysRj28GpXE8otUYA
   w==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="203831496"
Received: from mail-mw2nam04lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 12:43:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mdgdlj9E7KB+/nXMHzBt6K/VmBHTidx8YnehPj47BVVQtPCRPABfL2/VAyvb4WaQeTbbE4bkyrz1cgTbiebGiu7xMsj2piq8V1ZUSc5DgPsZ4922hDe2wNeXyBbXCO4eLVst6+KRI+hZPhiYLxsK8P+h62lQTdvF275EN20fjubM3jMsxeshnC1uTe0KX9zrcAYfCKiGFKcJ+R99s0nMiOo4r4rcOdpe4Mth+qnKQ8YO65n406SYdN/G2zU0FG1mJ9mIvk0qfmAEWVXsFnre7af3Zs+8hC19eD5JOautrukOhnms0mlQnw42v2crE2h6TxE3gQZiXSUFssnYxCD1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzyctvn+J0zRtGQIXYubbyvHIw0RrpJ6tXrimyUEZ/k=;
 b=bGoNruEafb0qNC/NoCSZulOSOCW7+iXCSIRiedLMTN1iWIf5qaCp9ZQFSbdkc/Kau3XEo4K5Yeee6y95BvEruaULUc9GgFkMNKy724yTrFmYRnBWnF7Ifl4hA2ECJZ7BXJtd+Zy19foCmcc2J8RVzLjUAzUwoODHemkRiNnriEkE4IPDV1qeMKKV/y9IRJolH9mpzi9vxSxoB/M5/OFaL2US4WJ/UtHVcKCeiBwAI5ztgOe+xzj3gh3yzJolUHaEdY2pQ64uG99bApQFfdoIn/QCRoh8uVvQIAtotdZqC8tAA8phR/RcPACbFnQjLfykO+Y1LH0g/2M0l6OIObQApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzyctvn+J0zRtGQIXYubbyvHIw0RrpJ6tXrimyUEZ/k=;
 b=M9DSbpml2SqoANpkRDk/F0cpLzQKcBNlzD4+MJLufDUad9OByIPHZLEeJaOj/OPrsXBocfbq4hVdijyBa0C8b+cQgrHGGguWzrgdPd5ZPBiJ/FIpoPa7y3iypdjSDVSn56UBZm0JPxap0gIhFBOQ+8fr+agYT8zUFgieIlaBJpI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5111.namprd04.prod.outlook.com (2603:10b6:a03:44::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Tue, 14 Jun 2022 04:43:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 04:43:19 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 07/10] nvme/041: test dhchap key types for authenticated
 connections
Thread-Topic: [PATCH 07/10] nvme/041: test dhchap key types for authenticated
 connections
Thread-Index: AQHYfL3ymxjgBSif+0C4iqAUWSbTpK1OWQwA
Date: Tue, 14 Jun 2022 04:43:19 +0000
Message-ID: <20220614044318.q3v4pnsahbxig5ty@shindev>
References: <20220610113324.10294-1-hare@suse.de>
 <20220610113324.10294-8-hare@suse.de>
In-Reply-To: <20220610113324.10294-8-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cbd0dfe-c230-41b7-9fd4-08da4dc067ae
x-ms-traffictypediagnostic: BYAPR04MB5111:EE_
x-microsoft-antispam-prvs:  <BYAPR04MB5111863C4A7A1D20EA21FA14EDAA9@BYAPR04MB5111.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  hqjRChi9gwwIzimqYGYuAyjVVpywixxESSdh0Q4C0FM5Lp72ke39ncBy02thQFfdvMIXCBrIeH1PSp1mVk622Tobt1aBC9sg01/5N7JMKV61oupUmop/ih6LaMhAzfViYHgqtb0qPGUyrbuGM0CxVyPDV0a43e1OWr8pGcEHI/za2mXCkB+4vQX24dfhgvT92YB09E1/XsOSszNiTBG5T8tnsIJiJi3LBFyCh6yShtUc4XfosBM5eGiPP1BVdnlzBzL9mrRkwP247MZtxARjihelcghH/Yu274JxZ+QhT6VrhlB5s7LteEmSthsPDdKFZNiAQr8sCuDYYd/Tz8nIdF/HX5Q1LsjVfL1KTqMBQG+7K8Fkh8e77T75M0N3f/BREZwFtPqmbcQ5A78S/ch60y+uVZsfeDAMYRkp/1TomCniaIfDClhqS0avLagjVZoqJfMvaluudzhUTgdd383HDUEWhfIWQNO4YVS80+duyhz0I2E1p1aU58wjSjuNkOI5ZNT3CTZYAS65FMMrMqkcSb70pu2akFcpc34aCdEQDgLwSOhEdWwKZxhwROn0QyJ5ZaQp5PqPPc3VNhMFLqUB/bc85ZjcK60ubFC0JBx5gsvKBeH7Mr0atSF7ymr/loeG340plYbop0aR+9FIzZuFOAJlxUWUWCWqoWSBye+5twSg0wnmfPc7jtzxRzX81FyLKY1wjG/Iyb/Pfgh2n8PHQg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(316002)(6512007)(82960400001)(4744005)(2906002)(33716001)(6916009)(186003)(44832011)(54906003)(26005)(83380400001)(9686003)(1076003)(122000001)(71200400001)(38100700002)(5660300002)(4326008)(8676002)(66476007)(66946007)(6486002)(66556008)(86362001)(91956017)(66446008)(8936002)(6506007)(64756008)(508600001)(76116006)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?Dr2YOVIxgZROiTJpsmDtQO4DGTcH5iqcahe9BJTCm4NOw0x1IiIYMhNkpLUU?=
 =?us-ascii?Q?3gJxj/Mj3RXX0OssjaP5np0XspEV/EpIS06jNNxWdY7sdjXtlrMjLXO/rTWL?=
 =?us-ascii?Q?+qw+ymAXxqCuqO4zCmqsYKb8Fs6ig9424FN2b1TQFGjYgd6Zc2ARhiwGmKOz?=
 =?us-ascii?Q?GrMLUTkLlqyk2Wl/wMM5z/9WvMdtcLahB+ri5FDujbgTTQK7FNm8h2PNRxVh?=
 =?us-ascii?Q?0lzmHjp19RGRYKHsWcqnKDvI7XQHdXKHR/1mAaVrpaE7AlKdm9w8TbuEn3Ix?=
 =?us-ascii?Q?NEr/HPF8Z/i8ceVStKHjhJOWuH5gi0pcDIu5C3Ud2ea51V1YdK3VIPNn6O/2?=
 =?us-ascii?Q?5CFX/g6H3VUU2Gh2KjNBTV+k5UbgWbR7AJv2EuJrKm4QdyoiapBTEZmCAcoh?=
 =?us-ascii?Q?vmY4we/epAEGUSpY6WkF4ss+bieBZuOo7zhJ3IZzTw10zzrfM/YI4g8PX/Cv?=
 =?us-ascii?Q?TuHNdqRARkR9nCWY+AXyQhqzhAWPJ2diJrqw+utqV511N4uOPTFnFDd+jBhI?=
 =?us-ascii?Q?t+Qb3wcfwHvhs7JCF+/mGHtdine49vNXVRP4I4yJ/J7sOIdPXtKPBdWlkGZp?=
 =?us-ascii?Q?GNjwuMx/DRoMBkjciSOmZHFuVPAxQ1lW8Z7NTQvTPz2G0jX6pkVdMox1moW5?=
 =?us-ascii?Q?6eOl79cxtRgFmcKwrFH/Up6l1BLR4jKnniyOgkiulCWMQvaSTI7jh+zNa4I+?=
 =?us-ascii?Q?JFM6FzzUV+uHNUpeph5TyxYXj0DwX6HnhnNmxA+ui075wqO6m4c8Qf7wc6q5?=
 =?us-ascii?Q?DQbeckTEJLPC+vRaCyHo306Zw+2A7vDM70kEOo8SYPKyEXmL9pw4N+HH20/+?=
 =?us-ascii?Q?vMijoE+ChpiV5szQbBMMmh9YBml9EOwvolxJBo8zsocP+/DMwX3NTkLuaXFe?=
 =?us-ascii?Q?dSyKqL4y0rSQQXqicKhzMFnEzuzMRjtFQlmVj3d1Y30kTJTrlNfaF6TgizkW?=
 =?us-ascii?Q?cPbJiSkLZnUe/cARCI3lv/yhxqpqQKajPCPmBQ532z3RO94OWzutiy6/kxeI?=
 =?us-ascii?Q?zK/CmXliNcuE1vjq7otCgPzxww/mNZaZRu5QVEJMOG4+FJuZTYQs1A3+Of1p?=
 =?us-ascii?Q?zJg4tYRf0hXyZ5xXy4OEbvpoP2o4GKuxJCdbgrP9QPhq2Aw7lq9SP8RLJ70E?=
 =?us-ascii?Q?OuW7roNwHa9tZFq7EJqIwj52TEiCLlFJF6/NDDgLhushSdI8+HWCik9cUWy6?=
 =?us-ascii?Q?JUY5Siun7Ek86s3qc2+HyhpUtezAsHAAF8RQDcWryWwncoPZuR9O2vfQs1uD?=
 =?us-ascii?Q?BWG9CUDVTVX8mXLGCXmh7+GOW2xFnnOOo9Nzms2ozAhAo/3R1+TAXL+WMTW9?=
 =?us-ascii?Q?a+Xm0hVIV87aSpVNd/b1NXaub01flN6jRImOtDawQUdK/oqFi0VQ7AECaOvJ?=
 =?us-ascii?Q?Gagme/GC/hLcqucXj0EIKWzLENWKldfP3g62qk+tYniiWqWFDBcy+77/4+BU?=
 =?us-ascii?Q?5mPZQHs6Yzcu4iQcbv6CsS7sKD8zGH9y9P4LtS12Kd0fwJunwgO9cPtdDEl+?=
 =?us-ascii?Q?hSsAKbJ9TGbWXUKaG1g4A0i5VP/7BRQwLW42yO30dMVYLvLlz1624dcj/VS2?=
 =?us-ascii?Q?vHoYv+7v06bjHFS7IY9z91zzgNBuvnq6RIChnvfLV+c40uBygYQow4wpyQ3R?=
 =?us-ascii?Q?07cWG57EjS7vSLUsTtAk/ARJo7jTiO8/G5SP/I2Bc1m3DIzHh/x1b4/JEnYm?=
 =?us-ascii?Q?vnv4xlbCVdSl43+ZB6INhN1vObs0rZ3vCr/I5uwOFllTnrO7DEJ1dVGRVqHd?=
 =?us-ascii?Q?5hQ33yUc81nlRrKusmgRyCKxRUNv2dpKhp1F0dLNZkdrc+l3sEIn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D5E235C0AA4D84AA229FF5DDA5B6861@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbd0dfe-c230-41b7-9fd4-08da4dc067ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 04:43:19.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nMJaef9QPge3Ulph+SB5cXeg3ktM2QQX5H0apmwGy4pWWG7CIfUucN6/oyP4CsGquyXx8gUx1e4JG06j+eoGr56QxsbXVLt/uHc10jCyt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_214323_419317_37F11BFF 
X-CRM114-Status: GOOD (  17.12  )
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

On Jun 10, 2022 / 13:33, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  tests/nvme/041     | 95 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/041.out | 16 ++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 tests/nvme/041
>  create mode 100644 tests/nvme/041.out
>=20
> diff --git a/tests/nvme/041 b/tests/nvme/041
> new file mode 100644
> index 0000000..2ded9c9
> --- /dev/null
> +++ b/tests/nvme/041
> @@ -0,0 +1,95 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
> +#
> +# Test dhchap key types for authenticated connections
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"Test dhchap key types for authenticated connections"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have loop

_have_loop?   '_' is missing before loop.

--=20
Shin'ichiro Kawasaki=

