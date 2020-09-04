Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27363C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:23:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9212075D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0FtWVRgE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZO+tqSNK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xRsgaz5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9212075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=b/JQ4kP5ZX4/xD9zle9Vu5kezTaFCpjtehyBYIvlg0s=; b=0FtWVRgEURGNDs7j5Kn714ihk
	NtfN90Rudw2AsC6gxZvD0Up4QkGrXiUMuefIfsyY1quaTeqoaTNuJVOdzgV5dHYG6Pk1TNo8EYVNi
	XII1tmcW5JJYr7wx0ZbiB5yL9Avlx97UYX3NDmZgb1zAlX1l3qHAZ+6ucTUvmJPyC6MSFrNfu6Syi
	JDkuvfoAq+XL30pIJ2Xm3aXeEtSvoSRn/ePVeo5PadWWWk1hTbW0xaldnMnKzKURklc4us4fzGtXV
	qYBw97/UtGG195Tis/gFO+sGhBolzEAMvSjNn5S//UAbcriy6x3IdZgpSVaXeOJIioZm6oXIdINd2
	iB8g0P/Kg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzVi-00060B-4v; Fri, 04 Sep 2020 00:23:22 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzVb-0005wJ-T8
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599178995; x=1630714995;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Xy7nsPXbGiy+eUF2Tq//KyiXuDfd1zma9vU+7LeNoHY=;
 b=ZO+tqSNKu4MoJntDuYocyd4FWeG7E6FWakMcqr9MmJealju7/oJRd328
 TmFzHS59NKmkFRfAEGtNmrzDNun1jWHkhCUhVwBJf2tQp1ZrEIhCcuD+W
 w1IR4jx7X89qjZjUe407rRWZAyj8GbHzi7Y8LO0HRF6ZYp482NdA0AtKk
 FkgwQUMazr7DyWgFoZQmaxHRQZg7FT/Qmtz/Yo7xStcGTp7g0NsvnOD1T
 QWCB8FgVrPV6dLpjV+JKK272VTNdm7cjdrqoxeANBzJxMTS8YW/pfIKqe
 uO0mZPGd68S/8mr68O1SO+zwWb6bJCkiX9Wd9JfEqshetcTXmB4mmbiH9 A==;
IronPort-SDR: fusH+guujrwLeGWaostf/wxEvIXNSGZAXYD1YtoCJIJIN8zG1iNtaFK0FMkpjooUnnqrofb6G0
 He03y9M3BYUclNOoxOLkyk8Vmv5EAcNTgcTF3+yPJ3j/QzbJeRo55VT0HWZ+bDwWL9dD3fG4PZ
 ih6jDB/QJdVS28piu52DMDo4hHBJXcWqOKjpyrqeUdx+vS6Csm0eE9ol4WRWWjbIHStKDEIsbu
 i/pF689Flz52XHdllKkph71uxSUAZ5QQWMXaQVZtVpCj1feihZU20itnvXgKxe7Wqz8Q9apWhC
 WIs=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146469240"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:23:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbTY0IXh5guifowvRq1IrxtGlEVnIdbkvcu7bgKPZXGCuKXo9OXITTpCIGuJmgfc6bevcU34SSLmO68/W9GqBueYUsdpyzj5daLO3d9S7nM3bgxIHMf4zTo3xHBaj/BQtQVO6iVCAQH1owpfdJ2i4Kc15nW1Pmz0oIkExK1VdR/0I1GxQyQGMF/gkdJ+BDBnP7hF797uoCnZuEnP8q78O9uhdabN7jjVmfUHMsieBPC4eBwN+/VQenPVziuCzLB8GwMluGKzTJLx6If9ui11BTjBMmnXSWMA7h8fhFH0p0zCLEsJ9weRSRpz8a29S0eOyJQUSK5jiTubg1zSefYceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy7nsPXbGiy+eUF2Tq//KyiXuDfd1zma9vU+7LeNoHY=;
 b=Qs3irSpm7Xv6Pl4iVXXCLpQBw4O9WKHDOpnwlQK0PTv3wsEnn/bILt8hIS7wWswVGGCzsfOYujC+/cdk4FOBS2tvTO1X/6DYw8Baxno1gvRluSItjmn98cKASbdsoye8lUoDuIWtMEcY1pV3Tt5dNlf/1/fmKxsfnjy0QC2KYeqgQ9Q9dgn50qjHH1rqBc1txAph9vq6edJs/MDxWJnsKUCzASz3wTNve/YKmBVa73e+8sqOylUGJ5GPlQKgaBJAOxCGv+R7edBAwffZoVTDFDO1BZ/dewKvUU2ilnBmcEk8pKsLhtMqpb4wVMo/X2Zw9Qkso7mbEvsUhC9iQZeuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy7nsPXbGiy+eUF2Tq//KyiXuDfd1zma9vU+7LeNoHY=;
 b=xRsgaz5RLRLXcn1NC0gcmg/T+N9zkIX8HssjA0XPsuVFqCziTodFl7WwrHYhAU/C2gLz5ehL9xzAnVIlgIztMwDGb9r3fV2WzIqgoC/mceyVcJbyBmYK051uCfCWthVEVuKWcT7i1rSbYUiwMxWrpRR2lYN2A49TIaJnHllh1FE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:23:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:23:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v7 7/7] nvme: support rdma transport type
Thread-Topic: [PATCH v7 7/7] nvme: support rdma transport type
Thread-Index: AQHWgk2GEmV6e24DTkiZkG/6euyuHA==
Date: Fri, 4 Sep 2020 00:23:12 +0000
Message-ID: <BYAPR04MB49653396696DCA55DED93268862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-8-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76f556fd-cfd4-42cf-ff10-08d85068b58e
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB442426B286DDE590B82A4F48862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:338;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wb+EcsJeJ5GbWdsaom7O0ofnRxjTyKqW9ZVsT67dqjdJ2q4M4rKj4im0EvrUYPV9+7jL4+zF/Cev/eqxq3Tx8i7/SM0n+OtxyIinp/4ruuYZxsLBcs6AgTR+Fss1wnDfAA4gQpjoMRYxEolCzzZ53wGtI/OJFlO/Yc8pLDV7+tfjLb4u/Wtsz7Qmb+kKRdH+dllIiJcvyzM3nCgrzbeP3BUVDCpo9G+Zv/BfX6eAUvbNUxkkFuUz/LnSCED1TIFhMK9xE4yZCFCzhEzopRKTh4YMsxQpFreRQasUiJB5UwK5aZn30VY1gm5TDLkMEsBCnd5Xn8YgkxQ6VLfXf+ViXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(558084003)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WF9EA6FEDM9+0ngKpEedzPemp/CIll8al8ntb0qDrXrqNn1Tt7ciZJva3XHAcitiztPZqkUOfrtnSvjUf5893y+DvgT2kGWcFdYqPCHd9LXAvznnaOPQ+IShycKcxWX6rRhacFPiwBfziTYfN0aEiqumkDH9uCAbKTWBWjwl3JEUSK+8Kv0M4hVEuYb5PNzP1tbS+zbI/LiihTCw8eSq+CUSczd23T1HvE+OppNrWbiZWNU4DwoLARmRwd39G0wAQxVrxAjTfo4g23PAvoQ9UfTJtuTRD+8ChHvb2nPlqCS2V8fOg2Y+TNjyQ7VSuVrMKnoNY8uaTgz+Tqd8FBTfV38G2x+vIL1/S0gBJ2udWzP5yEmpmHDbEgv0yHU+TXNTo+j7kJKZ2FZsapeDFhcI82aKgBogqwDrecUxvce+hTLsrrwGnE1JEgYFhUONUAC+4H+SZQL95YUwY0XG7mIEStlUGF2WOw8kmxl5wpvnGZySjizYjYQOkMgmt95xwBQ9/2QusdMrkSveXlrujzqUbDVhARPT3dBQ4zvYQXJS22D38cpcwj30ShWKPQaMLl3UDNlbXHsPFx/bMOV83xfKcFcbKH7vwRfUwGN4V2122E55/Vfs3zVVu/Badj3TOJHYiPqL3xx7oFzwwVQrelvARQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f556fd-cfd4-42cf-ff10-08d85068b58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:23:12.4404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0Q70avdrAIykHhYldP7L7pHqb5QaySoH34UlVxVc6SJ8bSZhZTKFdpP6j8HuE3+GZ+M8S3gvU9i1XHHDyWka5eaRyxqxMKNFTdUM52jbrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_202316_165260_8E248DB1 
X-CRM114-Status: UNSURE (   9.83  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/20 16:54, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
