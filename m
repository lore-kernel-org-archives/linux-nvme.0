Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0E4C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TRkwhXTMm03IPLUoSM7D6tuewVzEMjKLlrQ9gUSa0+Q=; b=uqCEYIPjKmDl9L/zX0jc3z3Ecv
	Rv1rKpLPA/EKdCNQO0iPD36EwiqWSEEerJxm4H9ec6aMSYXvmDIZF0fdJ4JyQzswKnoKgIn5T9UzW
	/pV78Z9lu+V9ZvMGrsVPzipsBivXdDO/aFeUZc1//igEDW5kZo9ipM45XIsfxvXuXGiRHshnJLGfJ
	h0HWwI42w+taVzOwpG35aspRZ09/bM5nMAUuSFhmUSuJUfzZj72uOIL8YXffKlvLRKXNsZiTDGV8v
	XNDfgX3/0TmH+TMGE6VK4ViLLIeK5qouEudYLO8yalh7syh0TYqN7xb83192uqmgW068WvT1+6Nvq
	/bPywhLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6VZB-00BHJs-2X; Wed, 29 Jun 2022 11:09:05 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6VFn-00B968-VM
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 10:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656499743; x=1688035743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uNknonR1NwSRyF4vc0f9+T3eBJfuKn+MPJFzm3ZTlRQ=;
  b=iVQkmKIgNp6RWvOqQ97xiNhxX+nhx75xuwlsKJaDGtPV6Lokbww/5ZTZ
   TUq8awnYQCwwHXw6yEakVAnJ9pFbIGLb6y7pbiHYTx+wIN0z8gdUEovzh
   kDnH7qd+BoQe4KNk8hxX/5IKUi9PfkOIM0S6IrfqtMJDqYBVDXpBfPxhs
   Ekp/YCJ/w4Ve711dh+w5IzA9ZIRGtJKzkqJhZrct9SS+fvlTNTkJeGN11
   7Ta9dTggcn4Ms2IyAB3fFytQqv08mpJC/JOYRitdM+Cfoe2Wfe3zJXnpf
   J6Op9IrgS1Cx+wMrsTH6Uo75JxC39tp9JjPUwf6WrZGqju3thZTkA3PtZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="316486786"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 18:49:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCpnwA6qMnhDWKilGbXY2g9iJt+IdNwiRdKFI1A54nqIS/hewIrgsOQqhLXFfUXiqGnvrLGj1cEgkPs2LjqBYDHT1A4VKbzFtnN7p3SfbnuLYaLfiI8lBHdDCkkTHzz1jvm3i8ybopPLaKK7inj+Py/3KHgHAmVXUiSd+/uBhRMqQioAnyCOUJaK+SpAwdHio/A6pyssoWgIFygXPcNJp0/bIt74bfXexXVyVWFTePJf6fmB23Ttn/pG6LiebI4VXa664sxJB17OMJs8etZ1p/y3XJBcapTFZY3JPS5MMN2jq2yZQP6tYmAVoTEu/EASIdt/CAHyFh2m+b/jXIoPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRkwhXTMm03IPLUoSM7D6tuewVzEMjKLlrQ9gUSa0+Q=;
 b=R4wbLN4mhgdSzQD9RPsJotXWvak8pRV59OmdEdnCNtQQQB+UINWGZh5kqgzmF5Cg3FfXRy3zSC/pThITDL9mcFfIw9YndsS6cHXxbJ2RBjOwwdtrDx+W1PJ8iDshtRRjrypARM9OAsvXwjafnxKejg4V/jYLz9ULolIijh+9Ppj3OgoqEFCxZ1DyVPOYzYTolioemJJfYe6XVtJfq5tn1A7l/dAZ1A8Mft5MPnyWI/u9pPs9JcT/yGuQK5PgyHpmp2ctmPo2kX4mbVNHg/Lssp04DjoYk/nOGbTtnAV5xP6KOSlDz+QoGmhBtlmAw8NCSlhEjmUGssHR3JOIeCgcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRkwhXTMm03IPLUoSM7D6tuewVzEMjKLlrQ9gUSa0+Q=;
 b=a6NLZuokp0U4MXFJzcsw4FZdOB1J9qJGtVb4dfjju9tubTQlmQWGtZPrM1j9YleSYSN3nqlEil6c0GhEZKBSw3rzJeAsJ+FKpF7qwmKo0xu++nKkk8tjks+KDkqmgDBeFBV6w3UqVh7uAwN3pGdXRSljBqoQJj7W9KZeUAQP/Wo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN2PR04MB2224.namprd04.prod.outlook.com (2603:10b6:804:f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Wed, 29 Jun 2022 10:48:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 10:48:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: add nvmf reset/disconnect during traffic test
Thread-Topic: [PATCH] nvme: add nvmf reset/disconnect during traffic test
Thread-Index: AQHYi5XOJnY3UE7bokiGlV/RgM3CEa1mNHyA
Date: Wed, 29 Jun 2022 10:48:57 +0000
Message-ID: <20220629104855.7uns5gtk4xlhyxcr@shindev>
References: <20220629085405.357517-1-sagi@grimberg.me>
In-Reply-To: <20220629085405.357517-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e835f41d-6850-4dc5-c95a-08da59bcf7d4
x-ms-traffictypediagnostic: SN2PR04MB2224:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  70fb+aElBbzdiKbDLATwdvZ0JyvzCLXZ1GpmjX9yStQ28BVjNJWMS2JxzJdTolx/g7IsUwNGeUVMbxYs4gvzOd5nVOPrinIU15JgNa38ELj8SkWBelgAyl+6jiddZ5ObgOtRhz9BX31KbOyHlgmQzPEX6p1RphDP8SPwRxQX6LczNC0NeeSpd5jFtAb4Chyj+ztJ3ajB4EHjvS09sKu5+h293mcmDYXjC1EHDUxKZ0D8tvycN7xqB20SOr2sID75rWIn8CDxjls/rcQaVom9igut71hDl4+WYtYmsnQJe0K1AzRUn2qzVcxD5s0v412R4j5SUvqCB867uQfJt8w7z9FXCGCemKNSrUIelBhqHx7vmjMXq9N8/3OghUyBG0uF57R92qsZGREO5V4uzEQUVV24Kn/7rXG5bEjs0B5R497vrkztPPfL/bSPQmE/Cyx84HvOYdpr1u6QJU9fEqz3lpRuPs0vWMJR3/Ah4ZZIgnB94Ch/XIpMJ0K6Py+0DA6SKY2l2UXEho4prR/Ut1k1Emc7guZqJwfaW7g+T+3ZYIqDkbuL8ggnN2zjd3DTmtdhhB0+mWK+K3u6qT/esbRqA76iu9Vqlio+n67GyZUHkeQnjuCHURifiXo10DGgN2VTn8xkglSGlWnK//unLGPJ71tdIYZPowpBJ6bYT3Y/bqef+INDofpDnbxxvPU2WPTcA5n2h56vE8uT2z3n9gWKpURC+nI2vhXh/v4oGV/v963/0N8Jj1wXMmdWrc9UIJuwKggsqnsbkmWDBSMVuAFaRalhW3w3VFKlzZptVBy8Mfg=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(38100700002)(122000001)(54906003)(76116006)(8676002)(4326008)(66556008)(66446008)(64756008)(66946007)(66476007)(91956017)(33716001)(6512007)(26005)(6506007)(316002)(9686003)(6916009)(83380400001)(38070700005)(86362001)(186003)(44832011)(478600001)(8936002)(71200400001)(5660300002)(1076003)(82960400001)(2906002)(6486002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?NM9kMTMpJgK1Kn+ZDvCoJL0hvcL07j5xxhsdIU5m56bXf8pM4WfVbLLN3GzV?=
 =?us-ascii?Q?WLRJHPCxzrn3rJNbZWoDvUtXz4pdFUYzfRIsLU/d7HKUXAN1wrzTkBZcpyfy?=
 =?us-ascii?Q?lm+pj0z/g/JWhtJZtHmZ77sxqiWDmj+hBmybYCkuHS0IfPlWoMM7YGzeRJ0r?=
 =?us-ascii?Q?iPJveFqLK9xSmmxI71QS5/Tq5f9Kv0glzJYnrZClgMgJDcuAcUBAV9I0uZvr?=
 =?us-ascii?Q?St9Sg1v69SAWMShm9PjkwqCrEdXxfQS5fGPKmlZ5yeeCovJMjm9nR0NOF6Cj?=
 =?us-ascii?Q?hMrQbk2ZsayfcDvOpPskRf7xQJaz9nyuBJJiYRCIFksEQvYgPW1WUPm3tvQk?=
 =?us-ascii?Q?uUYt5MwihCXKSPVymo0AoezYB57UFyA3DiVtMf/tN37Z1FIuvsW6cp24p4GS?=
 =?us-ascii?Q?8DXpbLtrjJLiUif4/VGR5tjJ4LDRz2UZmOiNRs6DE0ES065nzn46KpN0b5Ys?=
 =?us-ascii?Q?TFGSZ17PHSTGGBz+5XIInotsYphWfCAtDFikfd2QQFBMI6ZW/aJ3eDeraQia?=
 =?us-ascii?Q?322Z/LYAAQCp63rq2rYgNuVLRjsQo1kw9g/P2mI/hcrBUjumdRf3KK4Uw39R?=
 =?us-ascii?Q?DO+I3cSi4l+BhgIZhNZLLqJOUHyWcXmuaz6Pw8q+n4AqkGkqIqBxDfIl2/xO?=
 =?us-ascii?Q?PaUygkZ3FNG/LTMoqgFu1VVA76W5+7RnL7PEbeRZXu96t+ZeE0nUImwMqYaJ?=
 =?us-ascii?Q?jiNwp/SPT2dO7btZSZs9DgeCIruCdD8ZKjhzEhcrzEITfsKvM87/FlJIPMRP?=
 =?us-ascii?Q?IUGzWAVY/aqCZd8UlCTfNijKChoWhrf59QAj5PrC7WfIw9CnIfCFV//iPi2X?=
 =?us-ascii?Q?5LQiYlRknQWtlUez8CI6ZRHSRgGlWeEmLYbCd+Uu5z/I+L6pZ1OEv4ZGdyeN?=
 =?us-ascii?Q?E81K4b1yckIH7a/zU0Nm57aplDCrjPBFJ40KPPKJCdDaEB+0Zjo/0Ft7/ktE?=
 =?us-ascii?Q?l7hJo77zbceJ6F9pbMeIW4fLjSM3Hvt4NQOfio/FnkN3jbcXsobwHnlcgXB1?=
 =?us-ascii?Q?cEigOGZT9yEvGujU0vCl1aFSCCC6/vajkPWZfwfJ/cmeNs+ktxmgMbAhEdef?=
 =?us-ascii?Q?Rs4ITHXihn8wK12kuQ0LuKT+zl8gatUVb6hBXeCJARbfWQDI0bK4v1FWDliN?=
 =?us-ascii?Q?3AYd0/1NY7mpBNWNU8Xz1JtCTRJA+5wOeb4OeZQmVGeMp446kS2r7CLWurAx?=
 =?us-ascii?Q?usmI/P/TZ+oJREch+G9fgBt897vExrUjqnyfY+Tld3WPo5+Y68mqVqNhrXht?=
 =?us-ascii?Q?Fg+BV5RGmDJRQexSlrB29NW/IgTtAmVZD3Qido1nzyWafm0PUpS2WW9Bzr/m?=
 =?us-ascii?Q?9/+WEIlW/cRSHJem/a2HzLlTfsD2NRTOYBp0WJBiwAX6OG+0k1zR3dp+tb2A?=
 =?us-ascii?Q?rCdHMkBQAt2uJodOtpTNF7IKIbc0VC5yZVLjPvkChyU/oDWXUhA3bDqhTZGb?=
 =?us-ascii?Q?DDJEJ56XKl5whiv2Yr9t5JCKuaeCh1C1XnJvJe6hIlF5HE0Vgc66h8OPkI6U?=
 =?us-ascii?Q?YGSk9yNOdAnJhLEYHDEeOotwqx0NLUxGa50sPq4Zz3cr5KbTGzG31CuAHBuM?=
 =?us-ascii?Q?hvXLMHm8hrQ2ZldtSTlTOwHK71pB3z2wcRhwW+vElTdDbpFJbSPqF0I6slb7?=
 =?us-ascii?Q?mUwtYTzD8ChxHGIPJnfx0Eo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD45442A73FA8245B48C2DAFC063B868@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e835f41d-6850-4dc5-c95a-08da59bcf7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 10:48:57.2519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xh2JI2atx4K1PmRz/38VJ5Dx3BruVUwYIjVyjIw92ypJj8N3gktT7PFKoeRnrJ1mn4b9varYT1FdtutUriBjpq1hVNCj5VWhgw2AxpGRI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_034904_272119_14C82019 
X-CRM114-Status: GOOD (  28.67  )
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

On Jun 29, 2022 / 11:54, Sagi Grimberg wrote:
> Test traffic controller reset and disconnect during traffic.

Hi Sagi, thanks for the patch. This test case looks valuable. Is there any
specific kernel bug or fix which motivated to add this test case? If so, it
would be useful to note it in this commit message and the header comment of
the test case.

>=20
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  tests/nvme/040     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/040.out |  6 +++++
>  tests/nvme/rc      |  8 +++++++
>  3 files changed, 69 insertions(+)
>  create mode 100755 tests/nvme/040
>  create mode 100644 tests/nvme/040.out
>=20
> diff --git a/tests/nvme/040 b/tests/nvme/040
> new file mode 100755
> index 000000000000..88d255a8d0e0
> --- /dev/null
> +++ b/tests/nvme/040
> @@ -0,0 +1,55 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2019 Yi Zhang <yi.zhang@redhat.com>

Was this authored by Yi in 2019?

> +#
> +# Test nvme fabrics controller reset/disconnect/reconnect operation duri=
ng I/O
> +# This test is somewhat similar to test 032 but for fabrics controllers.

Ah, the copyright was copied from nvme/032, probably.

> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"test nvme fabrics controller reset/disconnect operation d=
uring I/O"
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_have_fio
> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +test() {
> +	local subsys=3D"blktests-subsystem-"

As for the sub-system name, other test cases have a number after
"blktests-subsystem-". "blktests-subsystem-1" would be the better for this =
test
case also, just for consistency.

> +	local port
> +	local loop_dev
> +	local nvmedev
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +	truncate -s 1G "$TMPDIR/img"
> +	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> +
> +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> +	_create_nvmet_subsystem "${subsys}" "${loop_dev}"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys}"
> +	_nvme_connect_subsys "${nvme_trtype}" "${subsys}"
> +	udevadm settle
> +	nvmedev=3D$(_find_nvme_dev "${subsys}")
> +
> +	# start fio job
> +	echo "starting background fio on ${nvmedev}n1"
> +	_run_fio_rand_io --filename=3D"${nvmedev}n1" --size=3D1g \
> +		--group_reporting --ramp_time=3D5  &> /dev/null &
> +	sleep 5
> +
> +	# do reset/remove operation
> +	echo "resetting ${nvmedev}"
> +	_nvme_reset_ctrl ${nvmedev}
> +	sleep 1
> +	echo "deleting ${nvmedev}"
> +	_nvme_delete_ctrl ${nvmedev}
> +
> +	echo "stopping background fio on ${nvmedev}n1"
> +	{ kill $!; wait; } &> /dev/null

It looks like that clean up helper function calls for the port and the
sybsystem are missing. When I ran this test case, I observed WARNINGS as
follows, which _cleanup_nvmet() in nvme/rc prints out.

WARNING: Test did not clean up port: 0
WARNING: Test did not clean up subsystem: blktests-subsystem-

> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/040.out b/tests/nvme/040.out
> new file mode 100644
> index 000000000000..f14ae8db1ddb
> --- /dev/null
> +++ b/tests/nvme/040.out
> @@ -0,0 +1,6 @@
> +Running nvme/040
> +starting background fio on nvme0n1
> +resetting nvme0
> +deleting nvme0
> +stopping background fio on nvme0n1

The nvme controller name "nvme0" is assumed in the out file. However, when =
the
test system has nvme devices, the name of the nvme controller created by th=
is
test case is not "nvme0". Then this test case fails. I suggest not to recor=
d the
nvme device names in the out file.

> +Test complete
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 4bebbc762cbb..684d56b184e5 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -447,3 +447,11 @@ _nvme_disable_err_inject()
>          echo 0 > /sys/kernel/debug/"$1"/fault_inject/probability
>          echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
>  }
> +
> +_nvme_reset_ctrl() {
> +	echo 1 > /sys/class/nvme/$1/reset_controller
> +}
> +
> +_nvme_delete_ctrl() {
> +	echo 1 > /sys/class/nvme/$1/delete_controller
> +}
> --=20
> 2.34.1
>=20

And shellcheck complains that some variable references lack double quotes.

$ make check
shellcheck -x -e SC2119 -f gcc check new common/* \
        tests/*/rc tests/*/[0-9]*[0-9]
tests/nvme/rc:452:27: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/rc:456:27: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/040:46:19: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/040:49:20: note: Double quote to prevent globbing and word split=
ting. [SC2086]
make: *** [Makefile:21: check] Error 1

--=20
Shin'ichiro Kawasaki=

