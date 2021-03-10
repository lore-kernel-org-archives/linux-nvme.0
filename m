Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD2C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 08:53:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41C364FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 08:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41C364FCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wNg6g3QuEEHMNXQE1OFkMW8lkf+o+RpFEDaWAkAtSU4=; b=DMdkVAolf7CuM10fQ10TUzNAQ
	XixYwUXnbgRgWm+djaS6HOXZfE/OfbcZScH4HDZpVg1zdB7ujikwN7ps54ZYm3X++hs+zelw9JOKe
	J5ZNKhJ/LSXBR9cHl79E62WPoMeLSrAywsRI3qqvn3NE94/9K2by5Knq1VVS+AA8DJxlWUiEYJ6G5
	onBGuJtr+0F3VFmS8GIuURiybKjxfjCfGgzDEJBMV4vw/+GnE4ZoUUxM8IZxgPzAvnjogOXaTpNTh
	PNfmtUoNYYdw8ZxlBq+4vpExeGUFnT6hQi89CA8Zm1VPa/+Q/dTwo7d+fUdWbCkKIgP+fUSs5+FSS
	0aqJXS34w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJuaJ-006Mw5-SD; Wed, 10 Mar 2021 08:52:51 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJuaC-006MvV-TI
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 08:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615366368; x=1646902368;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+arOXBiw0fgJQtgYti2FW9/un/KkHn6fpCPN+1PSa5Y=;
 b=StNZGPqyo0a4LC8Bmt31Vw5Q7erUq4cHPVQ8O+YvS9KnkdgkO1DXauY6
 TFZvFSBfApjX3Jvp49kTZolxONLunk462d57mRl5CzxLDGwOnWT45fqPn
 HjJfI5aXLcmzrI6XqApaz9PqjgmtNivBRZP8tjtYyGwja7r1miSV76iTs
 Hy62BJdD+5BvAGGoqLjDaYT0OS1WSyCOuVJz54Xpw+qPhxo4OLAytygRN
 rMWIdFOYBoh7dwMCoB3le8Em94LVaHy2I1yKXxGkawPrV5eMlg1hYXgIL
 WFXSDP+OnlKbXq3SjwujksfjXanRTjQxuI6+RhV6mIIVK7bh2q2IpPgxe A==;
IronPort-SDR: khkD9Wpc827/Pu+Xd98KgRm+opEyfrqHbN5jmkVGcB0JS/Zrrv3psQ+cpHju+62e81eJN0UslR
 AVXhjX/QDTSo9G52uPEUGa6GVQEECyqt0SzPJCIZQ+8wGLvNomH2VH+wqebCyhtgyfLvQY/0WS
 PBhSMmqNf9PmdJH2mQPukDTPM8yrC+7J/HFZkWc+Vs/6F4I8dVsf2UCoFNrf4sA4vx2Tsu5iS+
 hAbid0bw48njU0VuFvqze8DhMpAMnNDKeYDuF5cBqNcpbgrN5JjzfRoaTHohntjTt2T+6TBEOl
 EOs=
X-IronPort-AV: E=Sophos;i="5.81,237,1610380800"; d="scan'208";a="266139613"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 16:52:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/dMcno2E8QVSbCz4CmlSfhzj/w52hZJCRz3yW2esIAxXACOgRioez5db2MWKSoV6wwkd1R/RfELs8BrmYLUBkm4jhycGTWqYTcwYtJYvENt1dVopVWIfS6pRhdd3pG082zU7qe4GW6+GVGvABwzsbywzTlISsE3Z9IMRGKsKeZHB6hPhOyhorF+FjbPszKZKJo3dpPQRkdNqGWSTuMIioBubrBt7j7l3tV9Jam8wqM7VOUII2ugMnO4TwZZnpJAhdCuCQJYNNw8CTv6W2xsINYzD6nhf02R/DIXy7R9CRPedcHeZyn2TqNL/w/uuJn5xu/3PZonZTZ2TCKNHLOrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+arOXBiw0fgJQtgYti2FW9/un/KkHn6fpCPN+1PSa5Y=;
 b=OWj+b/9NgGrFgUdtIrsZq6E8NJN3ivDTqo3e1hhTooqowsNBPcdI42dTDPtqf/SWdN9+CsiIo461AhfHSGnxzqb11Afwj54TSxvyFy0il6HNN6iDZCbqcNp3M0rbtN4/y3yjz/7GTbkQD6K6/S32w1yz5azjb6/l3s/Vv9MT1fLe1j8KYnOJ1WrB3bgp22+BYEVFUysMI+Bhw7QCuppyMcsTXQgkdAyErinZAurf+ve4symOgrB43Xa1BWqNCM7GKIt4wjIpH84kHts/3c6KXNci5xAnFy0UgQIxFd1c9bX8OCZDcUzFb0SAEwQNu2dVQdbXizcPluplzbQUFBCZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+arOXBiw0fgJQtgYti2FW9/un/KkHn6fpCPN+1PSa5Y=;
 b=gRGxc45d/zs0WVqh9g91aT+Ej7Usk/R3W0wZrDnwqFBxTG6kVlh8AdFNPIPT8zMeUiASKfFxV2n0aVOXg/s8jJcm7MJ0kFcSi11vpsb5cl3oMt+C6Z8RgnRPN0fm9kwHxOLbzfDTu1BcJ/apAOT69sOfQFmWI9ZZZxSq1EY1qek=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5894.namprd04.prod.outlook.com (2603:10b6:a03:109::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 08:52:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 08:52:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
Thread-Topic: [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
Thread-Index: AQHXFKDd0Blfx0b+CUmfKhVWopYbEqp861+AgAAA0DI=
Date: Wed, 10 Mar 2021 08:52:38 +0000
Message-ID: <96A40F76-1D49-4A69-B6BA-D3582602481E@wdc.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-2-chaitanya.kulkarni@wdc.com>
 <20210309113434.GA9520@lst.de>
 <BYAPR04MB49654C66E5F4BC09418DC61C86929@BYAPR04MB4965.namprd04.prod.outlook.com>,
 <20210310084943.GA5838@lst.de>
In-Reply-To: <20210310084943.GA5838@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [2600:8802:270c:1100:787a:f03:ccbc:6c8d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c207e4a-c01e-4579-1e2f-08d8e3a1db77
x-ms-traffictypediagnostic: BYAPR04MB5894:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5894AD17CA0B6CF7C20CEC8686919@BYAPR04MB5894.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NtPFhZGwJdU8mWovmPdB1eoyafqX0oKTDqx/qAefIN4ToY0DyrivsSPvpVIa6D8qoj4VqqsULwxQi30eOHLk8YFOzHPsE9gfO57lxyD6gGH4nT04nx0Lc6kSST4PalXsXENZ+eeJx7sdpd33DAJiDe5Ssv7BB/Cq8Vw+WpJSwO4bXFR1StwM4uvrENS2dlkBRkb2Ox/pqjkkb1DFMg+SbHhdSGDFjxqe+tjlg6azJox8O+g3Jst1ijvtoonY+GNA54MLoMvquuWVjJ0vqgMd+tqqnu1CR2L/SDJi0tJOvVDK73zaKnwOaUuqWmdofwUKNv9HQwc6x4WehY1x3SvlJS20bQpjZ4cHS87XC2/sfM8Fb++psJvBtw6q29+D4GzIf6Clcq3iDUCSMZ3HmjVcciGbKsb9XHg5SMnJTcA72oNc0jIaxXjsSxHHDzHnSJRD6bJxNx+OQGHa/DPfli6k68ggDJRspazQNWCt8+T1YTH0ned8SgJJ2PVdRaaJoB7miJ+xJi9h3ThShqpRRin+Mr+XZFm720n0MM6tMS/pzow/SX4BPoXimqg7VZT/BvAQ79DEjiNCCwqH9RtPfg4SNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(36756003)(8936002)(4326008)(6486002)(86362001)(316002)(66556008)(66446008)(33656002)(76116006)(66946007)(64756008)(66476007)(6512007)(186003)(54906003)(4744005)(6916009)(478600001)(6506007)(53546011)(5660300002)(8676002)(2906002)(2616005)(71200400001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VlNMTXFYV0xSaVpuM3FaMnExdjcxTXdhRUVEYURnWlpOeWtWTldXRnN4bHdH?=
 =?utf-8?B?WU43cW1rS093OUYwdmx1N2dhV0tvUXlZeUd0WjAydjEyK3RmVkRJSnBqNTA0?=
 =?utf-8?B?bFBzbUcvSkVtMUh2MHdNdjBqMEJSQ25tU2NzZ3FvZ0xCT1htNlkwZWdCUFBu?=
 =?utf-8?B?UGVTQTNVNzBsQk0yWjRWcXN0WE5WTVB5SUx0djRxc2JZaVN1Zm5NUW5wbmtE?=
 =?utf-8?B?dVo0dHAyVHRtZ1Jyb2FSTlNocy8xaktzSEZYMmhjRXlFOXd4S2xFS0xvTjZW?=
 =?utf-8?B?UHhpSUk1MXhmN1NpVk9tSTVDSDZ5MDl1ZUJFTVFPdVNUdm1PcEE2OXZQY3c1?=
 =?utf-8?B?eHRxakZHV0hoM2FieW5zSXpGQ1ErcncvUXNPZW1jaTlERWI4TTdJdmNLNmsy?=
 =?utf-8?B?S29kN2xEM29POWJBM1VIUWVXN3E4VzM4bkRaTnlRZFByWXFFS0ZUUXdzV3g3?=
 =?utf-8?B?U3llZC9Hb3BKc3RqbXhrNmJEUWpLcXhCMlFVZW5IMCtRUUJYN1lNOVJyeHZI?=
 =?utf-8?B?Tyt1Tm5nV3F6TEVhU2dLRDVpV2pCRUdPcGgxVHpYZmpkaDB0bndGK0FwV0E0?=
 =?utf-8?B?Mnl1L2lwRnhacGhhb2hiSGdKbk9JNmNuU2V1OVhrUmx4YUo0QzFpWkhWeHgy?=
 =?utf-8?B?cjRienExQkdxck8zcnpVZHNteTFQVTFnaW05NlBTenh6QlRwNW5nZ1lXVzV5?=
 =?utf-8?B?Zm9UeFVFczlrdUNZMVVsTzZkNmF3N3QrS2k3OGJkMUJsaHhKV0w5NVVMRzd4?=
 =?utf-8?B?N1FadXJ3dWt6ZHdvNUcvYjhPaXl3QmVKUG9aK3BNSXhET3RxSElSTWZIMmw4?=
 =?utf-8?B?SDZHUGhCMTF3N0ZNVEczZjJLS3k1MDRzWGU0NFBxM3Jxc2NsOEdlanl6ZHVN?=
 =?utf-8?B?YjNvamxWSVVXWjJKT1NtTm1wTEtlYnhZYUYvZG9Ca1ZFdjBuby85aWIzUXo1?=
 =?utf-8?B?UFNGWm5Mc1U0aEZGTzdDTjhVTHN3Q0YvQkdOZlNPWngybW1nTHFhaGFYY1dR?=
 =?utf-8?B?YU12L2NIVEJ5OFdDNTBHam84UFhmc2U1MFFCM2NVSWFYTU1nWDdHb1gyUGJW?=
 =?utf-8?B?WjlYbUE2Vm5BZEF0NE1FZzhoK1VZSFVLV3orellPaEdXV1NOTFBCUzY4SnZH?=
 =?utf-8?B?OUtMZkxUSlczTEc4LzV6dXBYZVlmZE0rNVIybXFUbFZzZXY4bkE0eUpDT0tl?=
 =?utf-8?B?ZHFsWWpEaUl4UytQQ0tsUG5DWHN1K0QvL2hhNk9Hb2dieGNtZHlTOFNML3JR?=
 =?utf-8?B?RzMxL04vZWRwUHNYYUtJNWZzanBqS0RiajJBdmhLanJDdlZMdmtqTnRBWWxI?=
 =?utf-8?B?VnJnWCtSaFpkWmMzWXRHem9xUzFNejVDbHh6MFVveDhRRUVxOGoxS2RrMFA2?=
 =?utf-8?B?cjlNYmRkdG1iSnR4bVRJaGF4SFdkKzdHekpUVFJxRWc2ZlBHNUhXS0ZsdUdk?=
 =?utf-8?B?TmpET29MYU9HanI5cUFVWTh4Q3U1RVNWd09rSEJMMjNkYUd0OEVwdjdkcWEy?=
 =?utf-8?B?eno1VHY5Z3drWFpBM2l6Z2l5MlVkVFJXNEloKzlmTmVWb1pjNlNDNGg5THlS?=
 =?utf-8?B?ZFpySk4rUmQ3dkJhZTZlK0lxOGJJdDZYMDBPSUhxSUt1RjRVbHJGbHo5Sm14?=
 =?utf-8?B?R2M3cGt5TVNDRk5kSGZNYzN1aGlTVk9HbHVJOFlydC9oM1ZlV0xNVUwwYS9S?=
 =?utf-8?B?K3lONDNxNERHaUhjOWRNQ1A2bFgxcEFhUURDMTlnYnVLeFZhejV0QkN5SUN4?=
 =?utf-8?B?MDZjOThMYjF3RDlzQkNZTGd1SHczY3BZU3VXQTU3dWY4MmVwUTk3blA4SFZ3?=
 =?utf-8?B?RzlGOU56amE4cmZxN29jSDg5MTEvaVJKMXpvRTVKeWtvWWdPZlZkNUYxemNm?=
 =?utf-8?Q?ZdwpoRJWRdxZO?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c207e4a-c01e-4579-1e2f-08d8e3a1db77
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:52:38.3102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdblPXF1uiDjtzqRqsk9IfCWtm3raP+KIdNvg1Uo8ILWP+3uiK+Xl76iy77f+kNr2E6kgafgmOdVI0wGp/W+Ari/uUX1F4F1k61DeYdWWwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5894
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_085246_911255_A42342AB 
X-CRM114-Status: GOOD (  19.10  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQo+IE9uIE1hciAxMCwgMjAyMSwgYXQgMTI6NDkgQU0sIENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPiB3cm90ZToNCj4gDQo+IO+7v09uIFR1ZSwgTWFyIDA5LCAyMDIxIGF0IDA5OjAzOjI2
UE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IExvb2tpbmcgYXQgdGhlIGNv
ZGUgYWdhaW4sIHRoaXMgaXMgbm90IGEgZ2VuZXJpYyBjb3B5IGZ1bmN0aW9uIGJ1dCB0aGlzDQo+
PiBpcyBhIGRlc2lnbmF0ZWQgZnVuY3Rpb24gZm9yIHRoZSBpZGVudGlmaWVyIGNvcHksIGFuZCBm
b3IgZWFjaA0KPj4gaWRlbnRpZmllciB3ZSBoYXZlIGEgbGVuZ3RoIHBhcmFtZXRlciB0aGF0IGhh
cyAxOjEgbWFwcGluZyBbMV0sIHNvIHdoeQ0KPj4gcGFzcyB0aGF0IHZhbHVlcyBmb3IgZWFjaCBj
YWxsID8NCj4gDQo+IFRoZSBwb2ludCBpcyB0byBrZWVwIHRoZSBsZXZlbHMgb2YgYWJzdHJhY3Rp
b24gc2FuZS4gIFJpZ2h0IG5vdw0KPiBudm1ldF9jb3B5X25zX2lkZW50aWZpZXIgaXMgYSBkdW1i
IGNvcHkgZnVuY3Rpb24gdGhhdCBkb2Vzbid0IGtub3cNCj4gYWJvdXQgdGhlIHR5cGUgb2YgdGhl
IGlkZW50aWZpZXIgY29waWVkLCBhbmQgdGhlIGNhbGxlciBoYXMgYWxsDQo+IGluZm9ybWF0aW9u
IGFib3V0IGVhY2ggaWRlbnRpZmllciwgbmljZWx5IHRvZ2V0aGVyIGluIGEgc2luZ2xlIGxpbmUu
DQo+IElmIHlvdSBtb3ZlIHRoZSBzaXplIGRlcml2YXRpb24gaW50byBudm1ldF9jb3B5X25zX2lk
ZW50aWZpZXIgZXZlcnlvbmUNCj4gYWRkaW5nIGEgbmV3IGlkZW50aWZpZXIgb3IganVzdCB0cnlp
bmcgdG8gdW5kZXJzdGFuZCB0aGUgY29kZSBuZWVkcw0KPiB0byBkZWFsIHdpdGggdHdvIGZ1bmN0
aW9ucy4gIER1ZSB0byB0aGUgZXh0cmEgYnJhbmNoZXMgaXQgd2lsbCBwcm9iYWJseQ0KPiBhbHNv
IGdlbmVyYXRlIHdvcnNlIGJpbmFyeSBjb2RlLg0KDQpJIHNlZSB0aGFua3MgZm9yIHRoZSBleHBs
YW5hdGlvbi4gTm93IEkgdW5kZXJzdGFuZCBpdCBiZXR0ZXIsIHdpbGwgZHJvcCB0aGF0IHBhdGNo
Lg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
