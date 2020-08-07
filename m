Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E69C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 03:15:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A382073B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 03:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="boFcrigp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oSBHCRy2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GZjLpXAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A382073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=SeRmsTn8A8MaKHvfQqby1V9fqK8c7CXw4qo+DSGwBE0=; b=boFcrigpudjl3+GrwXLukD/vD
	Gn97Pn2M0WmJ8us2IT1l2ZMvrXbijsBW3KSXjEEttfMk3YbKqM6NuV1fjLY74tPnIUS/YNu0NY2WE
	e4AR058PUIz5EZCyX/OOAj+zte4+kR3Ny+rt01+KjdAKmFQytvzk/+9dOG2J2vVBE2Qeeik9zdavv
	sk1jO8rOgmjhsd9ONUo/rqqxhF6YAlB93SbE04FZ8ySnmdVu6okD9SgPpFRA9m3+xykxM4iYH8RJa
	4KKb7CWUzvlfaSM/SAfxgWLsfTPhYjEQVKa55QrUDeI9fISxM04puPcBhNxUgbet4Da86GePzi+R/
	fg0s5k3pQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3srB-0004yb-NJ; Fri, 07 Aug 2020 03:15:45 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3sr9-0004xh-4a
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 03:15:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596770144; x=1628306144;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=P4nDMVtXYuItrEd33PbZDyvLB6ddOewMMRDAo0JYjfA=;
 b=oSBHCRy23qg6F0QLfMOfydPAouILOb36RxWAlth8JC7IeGyaIf5ofc/8
 f/CMHQ3e8SeVyIg8m11ENoCV7aSwNQHwv3NIzQxVL1P4a6mV0RzYLip+J
 4vHZmVnwzEjF7aezaRWcNXbgGfLur+QwD1rQkObmmsnkN2pTnHp2cQC8r
 wDmGKMB92kGO47tIenIkikbaF9TB3tYAAFjHLYW+tGZl93rX2nPLGz2Az
 I79n/pW+WZDgBWS2b2ynQmCCkj3hM0hrauNblRnZOX250dPoMkaceFv+U
 SskHmMDDmLSBliKtKa4e5ZtkeixZtkwgLXcHX9ow6UGpHQVL/+llK6gvp A==;
IronPort-SDR: EtM+7Uek0xRMaNyO2+w3bAOnrib8d75bCh2oibNnGzLtOLaOPb1gbdDCAVSkNIdg70XN5biCS+
 QgKPRUE3i9B6gOxawRD2FUfrl9V+C791v0UqKTwGWnlrFbOeYELKopK/xDw/S+FeaE8ha63cZh
 noTNeJMdEfXG4gb8fo1eeHGm+OQ5luzW0foIOc9zomrj36tPh1Oej/P8jO+wz1FD3s1XXSBa9G
 w/GVPvyWwp/N+DqM+HiEoUVMZc7h/nrzlSutIqr4Tuup2Kfys+cjJL4Zafi+luWGU8h0VBHNLB
 7/k=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="144420207"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 11:15:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxkyvT1UVn6oSrEPVa4b2bi7G7oSnGR2K9fYBPpYCGT9bzqybnx95u0sBCgae7OT4GoKrzNIXtbctCbxd8Tc+cpXjJqFBR/MZ+fbbOwMXu/mrSFVcd5kCadX/0CbrOn5EXRnj6RM52Ne7hqJPbqxuTzuPW5gieoO4buObpGno+Y/WCLpw14FQQxu40i3/tkywADC9y57r1Zpu3mu/FCBj2fdjoGg+s66nL9lffdxy10EcUxJ2zzkv957jUxMvPGj/Ylyoja8qGSCsQnUyCJoFsTA1f9FtZ+OfUlEZYgqTyVZDv2B5WCMChgqm92aga9UVHq6NAK1Q3fKY4GvhlWkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB8Xa4kq7U99TUmgzUVYFw8Uib8UUfsTo8QAs74LBJA=;
 b=XORsJQI6FeJ30tGJKxvoRJLvq2pbRgQsb7JbFctRvkVcXD/LnvmrJe+UgNeeQjjwXIB+hgxe3zL5hOjq9qvNCU870YlSk2cwQH6zrcfEduMnjSelB2drVN7xx+/vt5pJIyHSraKAdfdkaAkqD4nTKCQQiMiAFUOYguMvUlgavLZj0ojmE8ZyjuojQC8ZleGP74bk6liG80tLpeUv8+Iwm7ckBEfIPVxv8MvcWun7FlTjb3HA7hkcMsYiSRFGLBclbg6P4hiX6dZqj+FxpvzFpWuILCeChRA4x5AevlO8vzTnfAA6up9ZI7XoYzMc908/ES2LI3htsB5uBiVnd3iYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB8Xa4kq7U99TUmgzUVYFw8Uib8UUfsTo8QAs74LBJA=;
 b=GZjLpXAHiLAGz21GffVq0BBNo4saSLLf2gC87/vcBFWqPRTBl04r8PEYvxbACa+tUZgVWAYPLTnanvCbxogF5RB3P6YhQb8bhXZsXOszCWosPsyWjM0wR6z2wpvSYpNv2MGa6qgzZNlbGZLc0V5ST5yQhp/Xt9zSPi7prlXhsU4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4967.namprd04.prod.outlook.com (2603:10b6:a03:4f::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 03:15:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 03:15:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 4/7] tests/nvme: restrict tests to specific transports
Thread-Topic: [PATCH v2 4/7] tests/nvme: restrict tests to specific transports
Thread-Index: AQHWbCXzWHmgafZUt0e/II0q4e3grg==
Date: Fri, 7 Aug 2020 03:15:36 +0000
Message-ID: <BYAPR04MB4965E3767211F0CD3DF7CAF186490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-5-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 683824c5-1796-4fda-0765-08d83a80278d
x-ms-traffictypediagnostic: BYAPR04MB4967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB496791DAA0842B47F35B25FA86490@BYAPR04MB4967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: id6CDNWcNbSHANO0+KP5Ntg60PiZ2T6wJmHTIA6fVmGARL32PpK/RSs9RYiSH/15m63A4QbbPG6CH5qHyRIKZe1aiBOxHOvBO/H1qeELaM+yyxhFtOSbGiKtu4ci/u0JWGCKDejLKgR5+FJwj2Po57L9wmlm6YBBUJcyEJzxI9wWqDKnpACBB4UgduxwOICyF8LXHKXsgYS8zfpOhMe+hWJ2+zqbFhsJHV8zfZfHvQ6hTo5md96dtHF0mrOoWGvfggeMtFpbZc6Re13AhNrMTMdSbv2oLRsFljl+Kb84tW1Dr/pf69PAxSvNhKJsj4Ix
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(8936002)(316002)(52536014)(2906002)(66476007)(66556008)(64756008)(66946007)(76116006)(5660300002)(55016002)(66446008)(186003)(9686003)(8676002)(71200400001)(54906003)(110136005)(53546011)(26005)(33656002)(6506007)(7696005)(86362001)(478600001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: QQtITHo8mcc+KHWN8tkG/Yms5WxvFDzZbhUs31+gusc+4LR1EE+jGvZtD7RfDCKsUaXrgQ3XFXbjastc5LG/hb+kyHA/igvkussaQYqFxMhZ7gfkBvfnjS453wQbaMFMgGOZTnbRzq/h9DWXxUPVH7VgjT1BGrQYxum6Mb/SdGU+tK6h2Xj+kCJWpTNm3Yl1IAr/jgDodyUnBp1IjMd+qXIfjOa6gDPJLzrFLw4e80QwcuoWiUIf52cMwYYCs1rXXY/ZAUnj+RkwQ4GTUEDx0IFA71OKciSQWW6RrXXtibAmAEy9meqA6/2VHv9TNXZkMupNeQP/HtsuphapDo2ozh3hSdLj8s/cfe00Zw/BgpJTr7akj+zSredox6S59cUJRwoKQFWGTpH7ZFVXuR1CL5Tm61CqrxnpKCJ5jZ9D2ChxgEuK5zQPt3zMaGVTxWZm6mzOAmZSozGqPsKXJsOBvr19Stcyktb/KQTZ7gOczDBwJCwlR08w5vqS2ietPyqT53W1Mh+WaBVmpyh/moMuhu8XuFOQosdOOnAYwvzQtZeAM5zvKPtW8T7rbDy5s8Y4zCQCWZEZYFecQIthC87Qp7sxZT2rK+R+P6kNWkDyt0M2zUskrtLDYel05cnLBf2xFZgP6L1sM1M4U6xiemURCg==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683824c5-1796-4fda-0765-08d83a80278d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:15:36.4425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hdgfo2eDv2OTvNMMGGJBz9wcTM89gPDqq3Nup8j+fRh+ZB6xt1vLwQ6CYaFs5DVNFd1NJd2Y/3kZ1yS5DB9aJwQkKqnQMelIpVDdPhHVYuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4967
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_231543_321396_12B1E113 
X-CRM114-Status: GOOD (  14.55  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 12:15, Sagi Grimberg wrote:
> diff --git a/tests/nvme/027 b/tests/nvme/027
> index 805a3c63eba2..53766775e096 100755
> --- a/tests/nvme/027
> +++ b/tests/nvme/027
> @@ -12,6 +12,7 @@ QUICK=1
>   requires() {
>   	_nvme_requires
>   	_have_modules loop
> +	_require_nvme_trtype_not_pci
>   }
>   
>   test() {
> diff --git a/tests/nvme/028 b/tests/nvme/028
> index c9bd3dde7f20..6fbf0d6d7938 100755
> --- a/tests/nvme/028
> +++ b/tests/nvme/028
> @@ -12,6 +12,7 @@ QUICK=1
>   requires() {
>   	_nvme_requires
>   	_have_modules loop
> +	_require_nvme_trtype_not_pci
>   }
>   
>   test() {
> diff --git a/tests/nvme/029 b/tests/nvme/029
> index 7bf904b16edc..7a4fd8d6d4c5 100755
> --- a/tests/nvme/029
> +++ b/tests/nvme/029
> @@ -13,6 +13,7 @@ QUICK=1
>   requires() {
>   	_nvme_requires
>   	_have_modules loop
> +	_require_nvme_trtype_not_pci
>   }
>   
>   test_user_io()
> diff --git a/tests/nvme/030 b/tests/nvme/030
> index 220b29f42962..44f3b56dec4e 100755
> --- a/tests/nvme/030
> +++ b/tests/nvme/030
> @@ -12,6 +12,7 @@ QUICK=1
>   requires() {
>   	_nvme_requires
>   	_have_modules loop
> +	_require_nvme_trtype_not_pci
>   }
>   
>   
> diff --git a/tests/nvme/031 b/tests/nvme/031
> index 001f9d2b0b3a..a5714982b5d9 100755
> --- a/tests/nvme/031
> +++ b/tests/nvme/031
> @@ -20,6 +20,7 @@ QUICK=1
>   requires() {
>   	_nvme_requires
>   	_have_modules loop
> +	_require_nvme_trtype_not_pci
>   }
>   
>   test() {
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f0497416a..a2cb0c0add93 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -46,6 +46,22 @@ _require_test_dev_is_nvme() {
>   	return 0
>   }
>   
> +_require_nvme_trtype_is_loop() {
> +	if [[ "${nvme_trtype}" != "loop" ]]; then
> +		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +_require_nvme_trtype_not_pci() {
> +	if [[ "${nvme_trtype}" == "pci" ]]; then
> +		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
> +		return 1
> +	fi
> +	return 0
> +}
> +
how about instead of not_pci  if we can requires_nvme_trtype_fabrics -> 
returns true for loop/rdma/tcp etc ?

It is a same thing, just my preference to void not.
>   _cleanup_nvmet() {
>   	local dev
>   	local port
> -- 2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
