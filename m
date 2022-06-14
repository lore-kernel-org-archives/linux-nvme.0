Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C0EC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 04:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jBGjAVqDVjn9mfNPhpYbv2+P8bsJSTe68TPY3b5cOBs=; b=vhjv71QRKFlke3kdBxI/nQ8XA0
	eq3QNF7M8T3jGFPe5z8itAeDSqykQvO5qSnYKrhFukfJsV1PayPgCcYD5DatNXrjUUSQu4HJmJgNr
	w6aXNC2Es1yRd0YFIQTpXgSRbredhcseLT1g5jURAgrgnTv1ZbV4C39OyoUvbx5M9cdrHPRgFc771
	IxvohJ9XQHK0Im+CdaDNi3sp4dHuJ812MemJkpt7QSt6J5sMGOopLHL6odeW6h+MAt/hwFsh6UfWX
	gd0I9XwKvUzNBI1j0bdXxTuo1qN2Ff3ymmkxlJBFc6sI4x47NICX6m6yAS0zV36NBkVJO7BdUu0T5
	aZBsnY+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0yIH-0070rG-Pz; Tue, 14 Jun 2022 04:36:45 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0yIF-0070qe-Jk
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 04:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655181403; x=1686717403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+jrXBk+xbqWfQNHYpGicrCJYefED5Q4fzUDcWewHsnQ=;
  b=Wq0lSjl5PmeiRa3KYB/at1vXc1Rpa/KPk+unUVQSseQScGM3nVCSfWPl
   3VZwLFd6xd2boWUt8h0RUOUIitQ2uWnG1EO6gIvxDhOchdKVxyNPsiXVW
   Lyu6skLWf7SwFB9tfSoYth4n33EqWM0rbQ+LYVWuSsKps8ld6DaLobP6d
   Mwrs9o7Yc6jdewPQaTKDuSwkBp9sLfdrAhgTRDF0f1fQiWMENkHXydP3N
   mzKS6eQ+1CbQhD3DiWAcMHJ7MG3zelos8wqgq75WLcA/oZqxdGhEYXLt3
   Th2pT3XC9XWHC6sS81F0Tz7XpQex+rpOEzyg5InHG4420ik/NKJIrzc27
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="203062966"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 12:36:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxgDQfAWQmjRHtE/S7UNPmFhrFPHh/jriQ9OrHA+gWVUfSE7CVRrnrBI73zvW323ZCDAGoMzNQNU/4nvoS39q94nlYFONW4bw7/Rgj7CsuRbkMGA18N6sH991OpJfWQzeP2BUVrR1xRYtOvyqnWvGN1ndU25LYAZsC1pTJ5/Rgy3sWeDcRWJ/C+GlEzBkfkK4PAZggIpMKiaaPYUKyO641Bh5ju1GUGMrXwk3JosO5zE+WaGHK3WUxVnKILH8APCxg/Ka4bU2tGNx5Ru8lTx6e1Iz8CgCnMRzzlGk1eg49mFhd/dmEJuDHtMc+HDgl/p1rrFFk5jjPJ9TxVmEqCWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBGjAVqDVjn9mfNPhpYbv2+P8bsJSTe68TPY3b5cOBs=;
 b=oDqzQNB1g4OPerSUgMAUliGUViZryN5jnc5NusRf729d+vKQO+YmLk+308uY7l913TNfDjCZcs0Q3UNWYv8IeAKVRKDQ/CniZSrdkdKIQcwjeYrFsGmm5/sA/CRr9NfnwfRI0ffbKvhogkmMD9QFKZNZhLNYkqd0xQvpLsPfQ8Wmf5xgQY6Kk/YY1JOBlY9rVarpAhC04daDKHhG9x2jZyQ8riOPqOeYhVDdxsP1JWbJt8KNAvdtaX6n//7Sm6sU3mg+wGzDVuFsbAdGYSuXyRDqVOWlfz2ZaWgXUKOmTtHoeXHhNnvlXPq7KgHaONscsy+JglCurnvVznfmxWNcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBGjAVqDVjn9mfNPhpYbv2+P8bsJSTe68TPY3b5cOBs=;
 b=QmeMJ87CnFspnjlRG2aaWAzcbZKUKFMvamjam+9MRWFUbb8srjUoXoM3/EuTDOQpwQuRM1qfF97VE1pTyg7B4kmTuvG9dWntBnBcr8xUkoCo1BO2YG4iAZE7d+rajNmDZX5tFvW7FN77hv5/OHSlcDsxBA3axCXwmxvrts7t6+k=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CY4PR04MB0982.namprd04.prod.outlook.com (2603:10b6:910:55::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Tue, 14 Jun 2022 04:36:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 04:36:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/10] nvme/040: create authenticated connections
Thread-Topic: [PATCH 06/10] nvme/040: create authenticated connections
Thread-Index: AQHYfL3uiyFkhl3bBESmB2yYVASgmq1OVzIA
Date: Tue, 14 Jun 2022 04:36:40 +0000
Message-ID: <20220614043640.vzu5q3ldq253rpb5@shindev>
References: <20220610113324.10294-1-hare@suse.de>
 <20220610113324.10294-7-hare@suse.de>
In-Reply-To: <20220610113324.10294-7-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b9685f4-9afd-4966-7780-08da4dbf7a1b
x-ms-traffictypediagnostic: CY4PR04MB0982:EE_
x-microsoft-antispam-prvs:  <CY4PR04MB0982F1D1B3C0B29DA417169DEDAA9@CY4PR04MB0982.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  3e3IfyffEOk5DlHwYQkSux668rkgGqx13LW9IX961lZoxNYcZU4f4DhUgeIh3udieyU6Vagh0aveM2CtZ5KJmxMtdZQjGF4ECRM5yqObKbLjjygJmUL6DtuAomrg6+K/9YAOSQ6Tk4dIHvTnOlRxuB2Z1ABf0UYgKxVAxx4Y6GOstkINogYhxIMzU6nmZImjZqeoh/C0ixoZxFIBejTtEDURa8ONP0mAgWFuyK6baWDCke972l/B+k5QeIsOnIXcULKpCO812CRYLnZ7OUbp1e1tXy9Gleddt/tJcH1L7j9/vmXuxms41hckgGXIZ/uQKObh0rY5N9UKX6pP1eEu6ATyVb+vnRTlfk86vv9QgXaaKPaFuFKgnzXZGtZuRMD0dln2DLF6HzOfhEPgT73ibZ0yKZfGaJ7UZFFVAOSsgd5JYI7NQMroCMDSmJvYbDM+AvPUXdObWo8dXbz5YBHzPuk0DBYqXecp1rizl8qYyfoNKpQKKgoSUNseIt6LcVNR4mrFWLQvB90qpTWW24b8qtSoIU0jBHOwBmFkm4on2dj3yn19p1KK6CxfWH2fOaFqzqNrtG6SrQEq5Qwnldm9MNuFhEQ88csU16d5ZJBSlz1OBrXfbuVQKSfPZDvOGwjYuwwqOcRL9cMOWhucUp2y1/j1zbmwhSlAxgloaepdwSexuTYhle60HeMgnUjbbGtPBKRWJceI+ybIBuxygXRmPg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(44832011)(5660300002)(508600001)(6506007)(86362001)(6486002)(38070700005)(8936002)(38100700002)(6916009)(54906003)(186003)(316002)(91956017)(64756008)(8676002)(66446008)(76116006)(1076003)(66476007)(66556008)(66946007)(71200400001)(4326008)(122000001)(83380400001)(26005)(9686003)(82960400001)(6512007)(2906002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?4a9VdMbnnxX/0Vod1hh9GgjfD/xrZVD4rNVahM7CJ7LJjOhCjNLnfMwQkhzF?=
 =?us-ascii?Q?DBI2x1Rhf0nYWwA26dcvePR29ol4AQf9OvZK0RvFivTg/CXns0Pt0q3krLBU?=
 =?us-ascii?Q?9x6fl7EXJGXnohfmEk+3dkwrPmtyAtyWDkBbEzCvpkx64mZtfZLTdhCA1E3B?=
 =?us-ascii?Q?mZkFFz3kdpgNy1BLgJMQUiabwORFLBvqiC45tvxpw+4vnJIi81ncJ6U5Y4Ig?=
 =?us-ascii?Q?v7AfQhrSl1Rqm+LSeQNPztSVQHncM6m8iwgc1wcZr3uINfrA1nQ1ZCZ2twyF?=
 =?us-ascii?Q?mp70bqyq/F7HJd5lFuUuA/WDaAxgmG2QhEPT4M/FDZ6Uhe5JmikIcFzOEjSp?=
 =?us-ascii?Q?T7vSTulmiJeHTBq8Hl+KN33GNSb4zFjdMYAHCJ8ctiDXa1vLVVPH02kUZ/ji?=
 =?us-ascii?Q?6fBO8sU6dl3kyl4YxCDWoatvydcu3uA0YDZ4Qwao4iKSQUUXX9g3Ectou/4N?=
 =?us-ascii?Q?+qs3q11khHNFF9N6y8ABWX9oKXVHvsZczV/eXnvmlxjBPrdhQxge1B2gEQ8f?=
 =?us-ascii?Q?fYLq4pgoPJtYBOaowCQjsn629whoBDtA5W1Es5ay/gBYLooI7skDrpZvW5J0?=
 =?us-ascii?Q?TK1cE2aKgPB0MrRyH5FdIdfio7jWbA4O3O09yIjUBdLI7Td5JOqSHSgxwGLn?=
 =?us-ascii?Q?d/BotHOcqGdB1Nbc/010XjzCvTh/JrMpQ3+aL0pdGqXHFB77QAyxXQAe1A2H?=
 =?us-ascii?Q?XFD/AhsAz0UmeK/qNblp/iz+OFgsISYBmSyhWlpvOf/Axw1viCdu4j9G3vhm?=
 =?us-ascii?Q?h1KdXcnOxj7PJRcoMDIQfm3CqxJqa3/hIt32UrilGdxzwrSw2K9XgS1Orsks?=
 =?us-ascii?Q?IHUWLZR3hBVfJ75X/dU+rBrAqfxq3EcWgd4t0sNB6c1S8HAVNSSYyHeiJ4uI?=
 =?us-ascii?Q?tvx68sMniotFBGjkj1t45l8P8k7UgkcZulL7DtZIfGwP3ZsygAfufOGnUJxK?=
 =?us-ascii?Q?e5b/2yIvqo95pJK2xDVVUQySYAL0lcqbEQFBmarwWrC1mnRKiBDDkd3Yq8Gb?=
 =?us-ascii?Q?YXDBGaImE5p1+uG6eTXLXVaT5ceZaWUWXReOH5D/mf1L/lXKMdC2PO5Z+Pbz?=
 =?us-ascii?Q?LD9mdFmrygg9etq6xRieKnn+R+9D844lWN2tRMMInnMTi5YhxJglIwQlA0DY?=
 =?us-ascii?Q?0BHsYq7sLB+Hgv3OV9nOPwaZL4G286LMO7kRFF+Og3CoAIGX7RaHDiz+H7oN?=
 =?us-ascii?Q?1X5auFlI3Yoqn0G1DiF3Sk3oi51vxB5emM7eB2zfCHzyLdSBcCAMAlfH6HA+?=
 =?us-ascii?Q?Y+HpOBLJvrD0EruZpxG6n8QEPA4gk1acMYe0GtLbJ3ztNd76Uj8l/XfaYS7K?=
 =?us-ascii?Q?4a0nFr+eow/dnrU9zdV6+j9hGeMbvXztu25BEa0a6uWLki3UBbVbHA3EPQCW?=
 =?us-ascii?Q?zXSM3qrujxGA7vG2fUsZqJVr7JnHzAqE6KD1MeT00346gRxRWEWTmVNUDcvn?=
 =?us-ascii?Q?Q7EFjLHGqqRnyc9h3mQpiHSEtVdC6hGw0LOKd45KM7MB7nHd2uCfqvZtqu8x?=
 =?us-ascii?Q?cfr3WpGOOVnuanFEcT52r4vR40JKcjWyqmAmF3vTlFOr0z2DKHhP6GWA+YTs?=
 =?us-ascii?Q?58EeW/JegweW9vldmp+wmPtQXiYHH7P9afUbEyyuYYhPdovSqxMv6aDHgC6Q?=
 =?us-ascii?Q?9kRVo4mJy9F5kdj+8iK9p0RqTVvZlNZalvgRVsANb01Iud2/9Afkc51HIBcn?=
 =?us-ascii?Q?f1vLBZoN5NRJ7nzv6r4Vx+liudRV9PpSYoIgsHqsFXv4NGtevEe7E5a+quMq?=
 =?us-ascii?Q?vCu7Fh5Lo0Ik0f6aMI5DhdEKX7/8GdLbjFAP4S5p0D/jM35j5ora?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47F21DF70EFD304D887FF061BDCF461D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9685f4-9afd-4966-7780-08da4dbf7a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 04:36:40.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kF05nVVCTBU0rkoOekmQce4T5TOj/mscJb9go+XU3O3n0R+VXHlit6cKt1yKazsD/rE/Tph9mbCXSMmKU2YZXe9pNwIGbSaJL6uBD4RdV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0982
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_213643_711201_18B6D55F 
X-CRM114-Status: GOOD (  16.74  )
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
>  tests/nvme/040     | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/040.out |  7 ++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 tests/nvme/040
>  create mode 100644 tests/nvme/040.out
>=20
> diff --git a/tests/nvme/040 b/tests/nvme/040
> new file mode 100644
> index 0000000..ce6157f
> --- /dev/null
> +++ b/tests/nvme/040
> @@ -0,0 +1,81 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
> +#
> +# Create authenticated connections
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"Create authenticated connections"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_nvme_trtype_is_fabrics
> +	_require_nvme_cli_auth
> +}
> +
> +
> +test() {
> +	local port
> +	local subsys_name=3D"blktests-subsystem-1"
> +	local hostid=3D"$(uuidgen)"
> +	local hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	local file_path=3D"${TMPDIR}/img"
> +	local hostkey
> +	local ctrldev
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	hostkey=3D"$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
> +	if [ $? -ne 0 ] ; then
> +		echo "nvme gen-dhchap-key command missing"

This message is a bit confusing. _require_nvme_cli_auth in requries() alrea=
dy
confirmed that nvme gen-dhchap-key command is not missing. I think "nvme
gen-dhchap-key command failed" is a bit better message here.

--=20
Shin'ichiro Kawasaki=

