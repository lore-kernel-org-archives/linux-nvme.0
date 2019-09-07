Return-Path: <SRS0=r3NF=XC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A76C43331
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Sep 2019 18:19:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AF221848
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Sep 2019 18:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YUvyaWnz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EDPm/pNE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v08h+9rQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AF221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=AHUzR1/lafGpWZk6sNlBlMAUfi57PeYjByY2xqT4MSM=; b=YUvyaWnz745Y/p
	4Tlo/IY6kt2wVISDk0FROtw5rYAoQz/Omm3tNcziUyN00nzKEhpmSFbDA6YAYupJSewdkdTopylXK
	y5zlG70sMeLohMibXICQzfPjpHEpqJ94M6EaHiPlglafoXs6eY5BwurW2hIe+jSYko14kYmsbnSPg
	lu+HruWek7heCnmVLl3KGLc37HPQT8LgFN1JOPEew32uLRwUVQcMnirll6ak5FmqENaP3tc2sN1Q9
	osPKIJdYYbbci6xTkgFUlxzxqPvKcySYzkR2r4M61MSXMJtPzXWmqIitEgBJVZ+YtaWBhxRCPCdd9
	g8kDIt0Q27U12+W47kmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6fJD-000332-Kr; Sat, 07 Sep 2019 18:19:39 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6fJ9-00032J-EB
 for linux-nvme@lists.infradead.org; Sat, 07 Sep 2019 18:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567880375; x=1599416375;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jeUPPlsk1roi7pXzNyYNHvjs64pP2G8YPJ3tr7qh04o=;
 b=EDPm/pNEcXw03hcSU5sMrAPaWMGsKJ8nhUIZLmdOOClgzt3bIRnYEiUo
 jO8xdD3DmImhz6+D38NtrtbrO28Js/9EU+QLsn2ux7U+9FC+gUJOBM7se
 G7AcsD9OxH/CwET5ZJVLnTp/w+AYYpL9jh706Y1VyxoS+0x1eMRXQCGF9
 PSxKHjHQ/vXT12Yy1Tts0B5LqjUF9W79GNjvsB9pYEykLgRyOQp2e9/Iu
 6Q678k12df5bJ6D08Nqu+UEpvRzg6Hr+r9uYo1CCec8XVLUBEHODXHuSX
 1yVR4zoA/smsJF2eVhkuMN99hjxdezs7snNMKfvS4T6rj4rcPVIy7IUxu g==;
IronPort-SDR: InlaL53MzF3uCAG9WtCNcBZWjq/Dk2fMbdcDYRuZEFp2Q/kJw6Wac2J7VsDhGGxe3yo+AOcpWf
 hRYqHRBeqefTtEHD93r7mNF3UooJPGB43yr9Grp4jLTs+gialR97ZpABM0/+u6n6FchaE5qeBS
 4ht/wOdVf28HyGRdyOjxaA2r7L9b5YmYXJW/gSWkl3f+LuS3lWNSmuGRH0DVWr9Yn7choFJ+Ji
 tMgFTAOhzFqi+hSOgkHqbkOfr+LjeMykqWlfE050KUQNQ/3GUO6ePzor36VcBgr+ggE+77iyZk
 q6w=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; d="scan'208";a="122310913"
Received: from mail-co1nam03lp2053.outbound.protection.outlook.com (HELO
 NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.53])
 by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 02:19:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFsBS/FIlSheso7XyoC9DGSG42mCHZTYveJvDo8C91ABX8DqTRNUynwg/uC7y+euOHwmPqATItLCHjJ1Rmo35+9ZqkwZzuLg6lQdui05d4M2B7CM+E4Gk0vV7Zl9eYpxpTTKfC1S5k9wU+b3u/W/v83AqZkr28O080vcEfA/Hc926PGtuyapWFNIyiybBgocDZjdrj5rWsd0S8mKUIsSuCcRh7KGqgFdTUZPvUYHooDZllGacxMYOVzqnQqvZMgvah6ZP3+yaTwn9i23TwYmHv60m553p6A8fzNcsPbcY4fM8fm42CxjRUg53n4Iahuhhn1V8E3ugb4Ygz5JV8v2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHfKOUQro8jgPq/LQoM8wnyLahSclTo3CK3OCt50oKc=;
 b=A4ksj4uYn3DBxQVRUJ4K6d+2HUo9IKC0IS+Vwj+2Ei11ictB4nbK+pHodDgAZQtAfsXziTQCZhKjpe+TGb33c+CNUWxynPHkkX6q+IyCd9rFqEyv8mMOUnrFY6J3UCoTFx5KCf/4NlPkPE9c95aURxhULsngQkyueNLd6HLuIm4y2I1hNbo2nxm4kzO3iqH554fFCivsgRo+uD05hRbWAFjkzahU1Vbkr0sDstDENZLTc7lg655KHoUfkwauE4CoVSl0ZMX8t3sup+xrKCEgD6V9NeZTw/XvBrNau0/1SD9lX5bIJGiKRPLM818P1HeCAJCirKfrM8SJkPS3PBlpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHfKOUQro8jgPq/LQoM8wnyLahSclTo3CK3OCt50oKc=;
 b=v08h+9rQazt1aeY4cTcaPHaEMKkQcXjV4Z0MT1G5aHrz37XfbwnwWLE/7VBO7BFaWu4R2+wxUnYN/k4TAb+L5pyso5yokid+yuAQEveK9Gqm5zUd5cGE5TgbFfQofRN1WKol6nS/MEQJJVAq+6GDmt/gwd0Vni1jDPyiRR23TK0=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5639.namprd04.prod.outlook.com (20.179.56.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Sat, 7 Sep 2019 18:19:27 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 18:19:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Thread-Topic: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Thread-Index: AQHVZBGFOhLove2B20W3iAzHm6F5Cg==
Date: Sat, 7 Sep 2019 18:19:27 +0000
Message-ID: <BYAPR04MB5749A3E9B06514AF589FE13B86B50@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190905174347.30886-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a78056d-4edd-431b-1078-08d733bfeb26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB5639; 
x-ms-traffictypediagnostic: BYAPR04MB5639:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB56393D079216B0BBA724249F86B50@BYAPR04MB5639.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(14454004)(53936002)(229853002)(71200400001)(33656002)(25786009)(71190400001)(478600001)(476003)(186003)(6306002)(966005)(2201001)(486006)(7736002)(81166006)(305945005)(81156014)(74316002)(76176011)(2906002)(6436002)(52536014)(55016002)(8676002)(64756008)(6246003)(110136005)(256004)(5660300002)(66556008)(316002)(66946007)(66446008)(2501003)(8936002)(66476007)(9686003)(14444005)(3846002)(6506007)(86362001)(76116006)(53546011)(446003)(6116002)(99286004)(7696005)(26005)(66066001)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5639;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: omMe5ZxokF4eXjbStNhhOHJnvdIgPonoPQHXkehn5WNBJt5mr4xIzaEiW80HbU4aPY1xpcKhj4Gs5UJutD70MkQOJ+K9Hzv3mRqF3xUyOFYg+gPWfabT+XggOw0iXts5+M2o9v20c5MpIo7MMf4o4LPoRX7fLM6xLOWvQbJ+47gCsxVVjvh23tJw3EbYenMIkQMGTX2tVHf05yfN56NDpNqIfLmn1LjKfzfcRmIoIj3BNDshRMOy0xK+iW1K7/cxSSeiPRmyHo2hIi5oo/DHJZ6Fbzf3vsw+R3WguWDaRercJdEd1nFlUaPYH2PkC/k8W0Q8ci07gd73x6hA48t68hp83UUcJvylkDK2xoeweNRikhegrw6SGx/5tuqKOBzfMYUWgZ8NbZOKKVLTOZGjOj8jeuNC0Z2MGsys68ui24w=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a78056d-4edd-431b-1078-08d733bfeb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 18:19:27.0256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRSqn20pNVXyH0MvRArWBzk4XuZZFK3uQ6mLyvWkvuY9MZviyzKyoVraO4oQJyjaQBqkGlSVzKW9qscNl26uuk5TjuuKxaO7ys1LzUpf6wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5639
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190907_111935_498741_936B4E2D 
X-CRM114-Status: GOOD (  15.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

On 09/05/2019 10:44 AM, Logan Gunthorpe wrote:
> A number of bug fixes have been submitted to the kernel to
> fix bugs when a controller is removed immediately after it is
> set up. This new test ensures this doesn't regress.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>
> ---
>
> This is reallly just a resend. The patches this tests for are all in
> 5.3-rc7 or earlier and it passes on said kernel version.
>
> I've rebased this patch onto the latest blktests as of today with no
> changes required.
>
> Thanks,
>
> Logan
>
>   tests/nvme/031     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/031.out |  2 ++
>   2 files changed, 57 insertions(+)
>   create mode 100755 tests/nvme/031
>   create mode 100644 tests/nvme/031.out
>
> diff --git a/tests/nvme/031 b/tests/nvme/031
> new file mode 100755
> index 000000000000..16390dcb380e
> --- /dev/null
> +++ b/tests/nvme/031
> @@ -0,0 +1,55 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2019 Logan Gunthorpe
> +#
> +# Regression test for the following patches:
> +#    nvme: fix controller removal race with scan work
> +#    nvme: fix regression upon hot device removal and insertion
> +#    nvme-core: Fix extra device_put() call on error path
> +#    nvmet-loop: Flush nvme_delete_wq when removing the port
> +#    nvmet: Fix use-after-free bug when a port is removed
> +#
> +# All these patches fix issues related to deleting a controller
> +# immediately after setting it up.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test deletion of NVMeOF controllers immediately after setup"
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme &&
> +	_have_modules loop nvme-loop nvmet &&
> +	_have_configfs
> +}
> +
> +test() {
> +	local subsys="blktests-subsystem-"
> +	local iterations=10
> +	local loop_dev
> +	local port
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	truncate -s 1G "$TMPDIR/img"
> +
> +	local loop_dev
Duplicate declaration of the local variable ?

> +	loop_dev="$(losetup -f --show "$TMPDIR/img")"
> +
> +	port="$(_create_nvmet_port "loop")"
> +
> +	for ((i = 0; i < iterations; i++)); do
> +		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
> +		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
> +		nvme connect -t loop -n "${subsys}$i"
> +		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1
> +		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
> +		_remove_nvmet_subsystem "${subsys}$i"
> +	done
> +
> +	_remove_nvmet_port "${port}"
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/031.out b/tests/nvme/031.out
> new file mode 100644
> index 000000000000..ae902bdd36d4
> --- /dev/null
> +++ b/tests/nvme/031.out
> @@ -0,0 +1,2 @@
> +Running nvme/031
> +Test complete
> --
> 2.20.1
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
