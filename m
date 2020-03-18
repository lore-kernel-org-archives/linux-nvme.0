Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC960C4332D
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 21:48:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC2720768
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TUShs/Rr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YLZvVD9u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="y11q4v1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC2720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4MQW23AIW1Bz9jhnSsk+/QKoeedP5K3XR5C9WRmiY4w=; b=TUShs/RrCvcegj
	JLca/pAvHckrdvqW4yc4PbX9nSfgldq+Z55hzcV2I3neolZ4HRzrk+gPEb1Sb2qHIQwIK3YmihwR4
	SnW6PKWm5JKq3Ya2DARF5AFSKPtC95jzSTL75hoz9tfIhhXC/71b5odm51p9hkYSoIUWr573a4A0t
	pnVxrbExpMI1qFw5DC2Sqoqz6K1a38EW0lqm1u8K/BpnDEVvSUvTrOpe0bZYUBqbl/D2Re7BZrSDE
	Pq2k+VRTSZiHz4aBuDojiWTcvzW+Jsdtgr5Hxa5gBOYwnBBOFYhhFqCBLrCI6HqlZ8GNW6Pyi4UM5
	FIvvgVCQVPQz5c0QL+iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEgXv-0005cA-Gv; Wed, 18 Mar 2020 21:48:15 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEgXt-0005bo-7u
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 21:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584568094; x=1616104094;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zZ+jUOPcEy6wCJIPsqPjLFQ0D1unxOfgYegCPOVCFZM=;
 b=YLZvVD9uO8a00yi9RZagIshhsGGH0d7E4gtSXRiGCiPoLcopasKNSQos
 9doqEKbt6beB+1GRxA8JklcJRv9hs+ARK43IAwdWCaNa1j3WHSX8ImlQE
 23Oedh0g4t5kndr4rtWL1kK4HjIL4+Ql3tsh6GS0gzribCVi5ddgbCDLO
 La1/ZXwJeunmlKLX4i5MWqWTWDV1eiXxDcNRiCIY4fy3ZG8deqHGW+Wv4
 9z0H83lM0q+I3YojlwH22gyolF8o4Omz35t00s7k8oGlXXs5/cElhq8pA
 vEB5d1O8caZ+FKp1CNSjKZlYLAW7J6NcikpiFeAO45AdkB9cZ6CfJHuEL Q==;
IronPort-SDR: lhyluZxYNZ/QCFVNu3wQHmjMjgYhyBjEfXKm8tce0QsJrNsVXa5denmUrmaiz2fQDLF5puVHon
 UqqC7zrxm0WtKDVPf0bxggqgZU1P4oLF3Orqfzp+VuK1MyG5WevglHTcML2SsRcl/O97mwrQRK
 cZ0cJKIgvWqCwuLbDYbMMmTUy66PUMmSkKABBQJWhuetdPFwPf2/ZLjpSKflfg8nV34RdcVm39
 Hsa7KRcpJwdnFDsbzo0/LaL/x+YF0AQ+cSGXxo27sqqoMRiKESksTvW554OmMMU56jFeMuAfuZ
 CSc=
X-IronPort-AV: E=Sophos;i="5.70,569,1574092800"; d="scan'208";a="133339011"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
 by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2020 05:48:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfwvXkZvxp0kVt1q2YuDqOGM1KJTIguS2oGR1yMlT0x3GYgIIvGevHkHr8qFcef98OZWSv+szY9g5aiTtCDprNFnEI7WF4PW3R0XGA6YZI0uYPGheVPVCPAi34fVVg4GXtMS+gXxw/JuMR4+EoqmemF92UoH111z3e3nUoo+TRZ8pj6wQqpeerHHHH1+l2uO2kvB7Mxdu18ywYvo2VJ0BLrPdDWhBhlQHgByU/sD0e/fQqko/xcwBPr7g24v9bJ5soev+5298fLqokyPp9u3ilvfDMR/Ko6mlXgQEaeTeERn87vK1+paY6LA9LynWiAQW4PSjUiWB/JxNXy6hakIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ+jUOPcEy6wCJIPsqPjLFQ0D1unxOfgYegCPOVCFZM=;
 b=MTJt1do+o0O3F/uOGCoUXOqPOPipp98eSeLBMu4YOZzhYeFxeX716EkEINuCHBp94YJz1zhw+NsdVDNzYHkIa+L8VUMR3lC2TokLETDbDUwatRiYtOSb9dvpHQURDWpZubKpQmcSPorSLQm7G5pdYBE3AJlAdZns0DzLdRiLroA1LVBdXZZlKxY9OoN8OmMdVGeoheswxYw7KypQ/WNKlgD3i65hqaieXDkJKDOBL+eYH1aKPnyTqZagSvtTHX2hRQpMuLlI8cpZkQ/xQUxxVAjPlZHFOlhG3VcDXrsBNPQ2L4n5Cmqp4DTAteoDRa8N43wdtNl8KMF8n247JV39mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ+jUOPcEy6wCJIPsqPjLFQ0D1unxOfgYegCPOVCFZM=;
 b=y11q4v1PbmlJoKcP+5i+MlT9sRVW6b58w106DRYa7fpWlUvWIeOhYPDUREzscrhqjEuBiemNAeiXyDY44CsYCHSiLzybW0Q/ddFkUe5seAe8KrySTeCHLcD/t59IAhwN93HI5AJBz8wbQIyqvxzre+YI66l3dFWLQ6PDjtp5eJY=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (2603:10b6:5:16c::24)
 by DM6PR04MB4540.namprd04.prod.outlook.com (2603:10b6:5:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 21:48:11 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::c0fb:7c35:bcd2:fd28]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::c0fb:7c35:bcd2:fd28%2]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 21:48:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: James Smart <jsmart2021@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-fc: fix typo in comment
Thread-Topic: [PATCH] nvmet-fc: fix typo in comment
Thread-Index: AQHV/W3vZhG9txVaTU6ZuJLqHvGsMQ==
Date: Wed, 18 Mar 2020 21:48:10 +0000
Message-ID: <DM6PR04MB57543DE32AF438A84008314086F70@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20200318214043.18211-1-jsmart2021@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 081e3636-702b-488f-586f-08d7cb860dad
x-ms-traffictypediagnostic: DM6PR04MB4540:
x-microsoft-antispam-prvs: <DM6PR04MB454062C32198C3229346E35B86F70@DM6PR04MB4540.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(558084003)(26005)(8676002)(110136005)(86362001)(5660300002)(81156014)(55016002)(7696005)(9686003)(8936002)(52536014)(81166006)(478600001)(66446008)(64756008)(2906002)(53546011)(6506007)(66946007)(71200400001)(186003)(316002)(76116006)(66476007)(66556008)(91956017)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4540;
 H:DM6PR04MB5754.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pt+hUKWUsfvOP4/SxKzGnG9MAUdtqEnMH5w0M2YUf6p80N875NVL0TKhoMYvgJh5STrdaUI56DDIfvw+46buEPy5F/XwqrBtwfSSGSCYlSaGt52DGqGmroor1epnD5EuEWqffn/3IMWULLWE6DHWg/v4c7ZIgVI2HmaldO71UFHDMsTGgKC5nMlzgFSa/KENvp6a18XAQvonGB+Oy7NR2NW6dAQ2WPMmtoRzrFnDr4LGxCB99EmwDIbhJfTAl+CAJFYBzLohsGSbaSHwWQPkrlAwpNTwfwa3/X1mn/YlIakblPyIWz7G7NVLOqXj7aDew0Btdh4H/6tLjpIEruT8a0T87wxSDoIsM5DFqcV5m4Mw5G+cLkTN06qLoAfmr5qIWpoaCHrRL9oM431TsBrfLlmUftJQnDq/9fycQmaQApfJh/y+Mm9RaS/5/8Wnudor
x-ms-exchange-antispam-messagedata: yKvb+0Yw6tdstmSeEMEl+uDArFAJnVeudAYftg9qVl9K1hV0zd8udPZbV0r3iETzDqsSC5wSqzmUG4JHPTZzSZCGrayh3yg1dKvs5oXGVnNN4UHuNToq5ypzSd5zLvM1fxWpbXojZuGnZj9QSDcuow==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081e3636-702b-488f-586f-08d7cb860dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 21:48:11.0035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aYJit3nStvUM5j0+BcXBsuq60YO4z8u0qcoKab3rOVgN8xXe2WAiSJE1dxjcRw/PCC6PetFWfxTZXW8+HkI9K50mK7LJ4bOks2faa6hEE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4540
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_144813_369328_64A95876 
X-CRM114-Status: UNSURE (   7.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/18/2020 02:41 PM, James Smart wrote:
> Fix typo in comment: about should be abort
>
> Signed-off-by: James Smart<jsmart2021@gmail.com>
> Reviewed-by: Sagi Grimberg<sagi@grimberg.me>
> Reviewed-by: Himanshu Madhani<hmadhani@marvell.com>
> Reviewed-by: Hannes Reinecke<hare@suse.de>

Looks good.

Reviewed-by: Chiatanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
