Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27713C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:44:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A682C61028
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A682C61028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ETXX1OT87dZe40SqZKJQEI0lKr7XPvy1KXjyXkaq0Zo=; b=C9peLAZsQ8FiSOrqd6pRKablf
	6hHozevGNK1GY5cWyKaJ/kGKUhZUEy3ZNwJ99S4b6lyVq4exFBYUUgs00ls/kXYyH06s9cF2IWZgb
	ntGAgoHWSF67sQ/BRmUMxCwREWdJqwL66gr5scKSnMDQl0nK41d0Ib+N8s792mBatQUG8cvcRZUil
	8v6FjQlemDWpOju8uXSDKfKQgINE3NG//kbSKc1MEt/kh5qxBSpA2+8bD8DM1tSACXXvVb5t8E4la
	0T9qPSNMKemMpI5K9IQNKXMYu9BPe4YsdZVFmijCNHMlHgQzJIsMYEd1bHwOPhCpxzYoWCshTqkTD
	Y0XicC0mA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUjwT-00ABfT-Iu; Fri, 09 Apr 2021 05:44:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUjuS-00AB2w-7V
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 05:42:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617946944; x=1649482944;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=RSM14hJ6BUtF5JTjBFkwWq4NpiUaz+FAG2h9NEuQfxs=;
 b=JfqBfuxuII9gCc+LEExWPes4+R/Wc0EXKd7P8PKjRmxufn6qrCqcyX2F
 CyInkJzXrEGAeM/vKTZ+md84luSLgAbRpkKQFOl89Z9C0P/zMl3TC26v1
 JFgV6yDGLVlVELGne25xd8VI3qHRUvX1Sf3pM6tkBeXXayw0jZUOGi4jg
 1D6f6AB8KS8xMLpZffhwh90JuODHWpb31gAdMQrk1OMx3ppsc/NyW8C+f
 ZuqUYs44q8F8eRF2F9HwiwMaiaX9U8/7GxbTFSOHft+nHtG3FFapXTdOc
 1Fi8a968JTl7MzAhBbIlQIg/Lm3j90T0Ok/iTG/zf66NW+SfOuKm8NntU g==;
IronPort-SDR: zhji2pPre8Zdje9tu7ak03oVyXZc4DlcB5kzRVhi4ks6vdXPlKHCVlWau8bu3cw7vjmAQWDFVz
 VajMqcxwB3AZU2aDM/wpPckFqcpDr/i8UyqVu6vy7ZQTgvP3gi3H+NT5LZRPNPKr51NytWjBuJ
 SZFmBFBtfZFgOhvY+RjvPcpMjtAWQ+/mRGtnb/GA3wtEqxcNKchP8wDKUmFfQAlO+KqbpBdQrJ
 zy4Ffnr3fslS3cjXSPqfs8Lx6P8ZzYBTgvAIlr5AD2MwOFQi+1SX8LZKqH+nB9tfJopyfYvMjY
 6us=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="164270252"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 13:42:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZQPTBAks3ncmlHuk2yup+CpD/wrFo5Xe4x9mOiK032qKPrpxRhdslvRE+A3VOotd3O18MG3QMGvKvetI4h4QdzbJdWDkkV4YiP1ablqYcIJqI9m8BftFExmI8ZA56hEnyxY3H8wvqs4YpH507lvcz8L9MNysGRoPKOdbwgaFVLFOgy9AgNRPlb02b7QxOM2JRLoyUdhvctLcTcHX0301rjkPTajybHDFQnZ0UpWC3UqzzvbzHpOGObaIBk8cA5iMR6PWE0dGS9ENxct3nj6saTQeXbkflZrlTp+D2j9Fc/5CIjpxD5eDrErNz+ZIjV9g0hvIEAK231vs4DEimM26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ6bRucE6d5az/T5l/Jwil6u++FinUxQP7TMOnFG04k=;
 b=UaJB9TFIcifZcXtyTI80pM2IdGzt8axE5qh6EwiFIOEqmNJzQ7pd0Uq7IjKyTuXvHAow30oKGxUXFNRniwUe5GcpEDglVIKIBQJLGjfTE+2MpJROtw2KnegC0PqFfH8kxmSo01RwGEyJFnBMoWqIntCAde4DtjEWStgdfMf5HzPqJUKeK7JOfk4UjFGGFRItSXbrziW869PbWkOxnQ3W0xlSJIjFBwkFuaxNWyUjpOPIJ0ZsK+uvb++3LTutIfkdKqfOh4MXQ7Mqw9cXK/TY6sYhfkCvKvvPf1ghaKLxW5a8jTZ1eonYGhc+XuGXD0/wg1IezKXpoc22Igy+f7Pzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ6bRucE6d5az/T5l/Jwil6u++FinUxQP7TMOnFG04k=;
 b=puu9qFO2XpltZ7cF7T4Nq5q6UP9aHZ67lRfGSaPyEfCoWxhVFkgwX1a7vgle4D/XTF3ICVneqqJGJXt8v8SLllZnatGzO/1y2c4YpZ7bKCXok6udB7UTjIxoII5lLrsQ+oTse2cANQCi2JyuEyYgE4a50xG+rqq6xVs0U80vnZA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5336.namprd04.prod.outlook.com (2603:10b6:a03:c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 9 Apr
 2021 05:42:13 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 05:42:13 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXLAw04l3W0N5us06JCpRfHcvipQ==
Date: Fri, 9 Apr 2021 05:42:13 +0000
Message-ID: <BYAPR04MB49654107971F951021D7025E86739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
 <20210408072337.GB24502@lst.de>
 <BYAPR04MB496576AC2F66933D9509A22286749@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210409054053.GA2783@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d394e02-15c0-4073-ecf0-08d8fb1a39f4
x-ms-traffictypediagnostic: BYAPR04MB5336:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB53365C3A53CEB81DE066676986739@BYAPR04MB5336.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZqU/RiqkoVeVTavSPO1Ll64P0WWL5e5ZjwNeeWwVKL06gEmK2S4bobuqXzJkX+j3BiCRQhWY+FLa5INlh7uApBubgMRVHug+UgTQO8BS4BZ/6mMlGH5VSUOe5DEjCOUeHwtHYj9P8qM5ryzhRuI2DOkAMDrR/8fngCgIbjqcdCgbS1A3bn4YjdUqE+Wqt5Ryqhumr9bvBORrtvyc2hekFea8T3Pio9mwmYLhQpfM81wTHfhw+Vm/UJD9N7IEF5leCFWuthH5fwfN5fDOLfG9zX7w8WpCGnwKjHqaLhiglG5WeefNxpyNm9IfTfvb0VfqxyDx2YdVNy295H0fw8EHsCWLUZDEQwyY4GNpUj5jEBwjelvCXwiTTUOn3B/44iBh7dZmanP0iQ2+mKf89K05neZiig8Qe+W9qGKtlflzMEvHmIrOs44/aGGlfocnoIoB3afz4z33AxKA+GoxU2U1xGLEITDKOc/96Kdh1kfKkYM0rub5ydCqM8ccbaLaDNiZxidDKm/8py+yJZokmIg11BUmd3VQvkKmsIU55MFPigpK9noihJMOMgAuV/w4acCzPYP4kT5nBRg4/uV8HF14zKHiFZxIkfWFkTeFpDtfB/+V2HsaJihz7bAMlGAomPg8gzZYoVdXb7WC1VeeUtLL+n3fyEYjpZ5kfcPtuooBAY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(86362001)(55016002)(33656002)(4326008)(186003)(71200400001)(316002)(9686003)(66446008)(2906002)(4744005)(5660300002)(8936002)(54906003)(8676002)(53546011)(66556008)(26005)(64756008)(76116006)(52536014)(6916009)(83380400001)(478600001)(7696005)(38100700001)(66476007)(66946007)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PIdDFuLhB/vg14z5fO4Qx/jpcJXRlw9rhmLdNR5eQgVDN2al6/IqoCIPIm+J?=
 =?us-ascii?Q?iIzxsmmplrYJ23SkXctvlabRoBEXCXgjlCJYw/NHnBb1v2d/3WPCAcSny35e?=
 =?us-ascii?Q?VEKcFElRIwqWyobZZMC4e98+NwF9/ieVTKm7bNpHxZdtstLOcaB7xffyb/sI?=
 =?us-ascii?Q?bna/Em6xhOjJOtPskfAdb85JMLQkdix7gU3ZKsAZL1sNRBx1YM3JkZrj5iuC?=
 =?us-ascii?Q?9pvANB14L3Njpu8ilA0DQ6ikQL9GDGMaCMkEBA9DgooDp2PeNd/Yf/SbVPA4?=
 =?us-ascii?Q?K2bsdwfcNS3uTlD626rcHkDOT7cDHRQArowMIwgHcbvxKg/siCm4wfTf9XUS?=
 =?us-ascii?Q?DDxn9xFiRBxlmi9gifwvr7OgjmNGYRw9LSDj6XLUVUuGIuYxCPvei1WN+G50?=
 =?us-ascii?Q?PxvScsuGP96TAfkRp21s03mFOFre6xGFP0fbMwu/MJbxgNat5Dz0SdNOvk2u?=
 =?us-ascii?Q?rA4t/24UHYOIgdGII7r+Y3gTnq6kZG/HdiolKBV/cKnQ9weqhLRsva2VWxCy?=
 =?us-ascii?Q?bCa6eRHDKNQl6+gpRqwYUYKgaIqXKsbQC8ajdcIpn7N+PuI4HJosFjev6b32?=
 =?us-ascii?Q?gKqS114iygvHuoe+Zk6qLjtgEPnvzRavCTPQhB4UdDnpJgjamDJB2xTu5VoK?=
 =?us-ascii?Q?jA5IZeUDYKmorN0QC/vuRfKvrN16jD2fmx0AzOZA2CQhDfBIyokgDTeGx7iJ?=
 =?us-ascii?Q?6jxnvwaNfx5LRiIPLTUui0ZkCAJqgyHhhSFFvLwXY/36ZKf0dtZPeRA05G21?=
 =?us-ascii?Q?16qb9uYNGMKnLangCkoUUX5mxX2b66hp7khckvA5d+M3rV2JSOKxirEdYEIF?=
 =?us-ascii?Q?yYipu6Iom/usIOr+F7w/99lU07Bkm+lKoNBfj4VZ6lC+X49Pk1IUfnCN57Jr?=
 =?us-ascii?Q?ts//MGVH5dBwrX0JERcB5aB9PBhYn/AFhmKvpWFLe7co9Jkj1Fb70xyqBqgm?=
 =?us-ascii?Q?SijaPdvj8+F6R5QmlnqjctqIVfq2y4p9JK2ciDtxAREBTfZ6a4id6Iqw0yp3?=
 =?us-ascii?Q?DdF+njusIqlw+uhXTq1vjBb4BAp84YO7vh4W75WO4OskGu/avOmqvLnabev8?=
 =?us-ascii?Q?vrtFG29ibUsjDwJQJHW1X2MnZP3hVznZafaabxW2zNAbKtbsGCKU5yNMLJpx?=
 =?us-ascii?Q?817Gp396d3pndpXB5M6YDwlDckoO76e9LV0YiXP13F0lrvtaqfofqgXx+rPp?=
 =?us-ascii?Q?94Ns0hu0EPORbzucOHp7UNvqhLmAm5rQl+70IM+4jO2M4R1HuExmaJEexPVJ?=
 =?us-ascii?Q?miyk4v1xNO5h7QVe9P0asplrmywJPgD5uc4SwoaX11Ufi3h6cen261QTL9bk?=
 =?us-ascii?Q?vWVx+7qSmPRAYAxq66UqAsq07rOG+z5g9py0cW12U0jqQQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d394e02-15c0-4073-ecf0-08d8fb1a39f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 05:42:13.1320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwVr1Mcp4aJoM7Yo+k73IipavVTAgytzYKCB/nxw9FLYtIMMVA3QsVWrRMofhz+xoGTZK9ofwUVH3W6Fcvyc4CMZu6kaD3bbGdpCMN8+7Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_064227_344000_663D327B 
X-CRM114-Status: GOOD (  11.02  )
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

On 4/8/21 22:41, Christoph Hellwig wrote:
>>> While not bad per se I ind the structure a little odd.  I'd move the
>>> checks into a level of indentation instead.
>>>
>> Can you please elaborate on this ?
> If we have a condition that limits a query having that inside the
> conditional just flows much easier than a goto that jumps over the
> checks.
>

I see, will make that change.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
