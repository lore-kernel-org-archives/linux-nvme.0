Return-Path: <SRS0=NYF9=3C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC40C33CA9
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2020 23:53:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3FF206E5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2020 23:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MZFa/iNe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FH0/iI/V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RhRqrNlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3FF206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=KQT3WI5MP5xifb6ZlUAv55+4yle9SZ1vG6ySoKkMKIU=; b=MZFa/iNePwG8UZ
	fcW1d5YZLq8QYwdiJtYmfPA7AegX5Y/o/zN0bEJm3AOV/yDfLTslBpEbBQK43g/L2ZZYXTdjrKHC8
	sfMnCBQctgZ9KdEvcSg/86mwwLinRHtVNXLgGZcb4Wtsb835qbnWWUSAsXbznLQKfiE/DJTJyPL03
	3JEIfpM96ft51erJbw8BAPDnJhHZX0Z1jlWKu0S4xlN9FeKLDlKB6SkgLt5hDC7KaTsnM8VrfNK6K
	ccG6w/kpgzftp/NNCAj1yE477GIJCOPnLoPKC0nWh2Qv9a0kk/wwWWnYhFw9DH8UDDEPf5utzLFG+
	Aa2WbHrEdPv9qVurbFbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ir9WM-0000EF-6F; Mon, 13 Jan 2020 23:53:22 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ir9WK-0000Dq-2W
 for linux-nvme@lists.infradead.org; Mon, 13 Jan 2020 23:53:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578959600; x=1610495600;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=cVWTcYU6D+kHi83hYSkv+arU4rJIlXtRziPisNZ86GQ=;
 b=FH0/iI/VCCKk3Mcw3jG9EdeqgI/Qy36XmPc2r2rTP2mw6jds4ZPQOgNk
 clzlLVLK4sOHE8bcmrGESCkqC/uUNENOF5Ttl8RIec3zHfQSmUEqnpnPe
 D7M+2+RMNwWxxFnySh/L1zF3nqZFZbQL59hus8dUER8hWmOOrhV3ty594
 FkoIkZkihhs0njhjgpgTsr6fi2tLe3Q6dAdLnS1NGSfAMVB5S1WfT/Xm1
 mMDaqS5K6+IH3llMvPHULRXHX7uFuJTB03ARTeOyyHSoONcbE3PV4NxIb
 ix/6/sKHaU2ve7YKM6kC3QOTYxBXrdsRBPYfqHqz8OENcCw2qAonpTe4C A==;
IronPort-SDR: YtKs/7VP2c4d81f2eanXl3QwX59/NgdEbT/MVRHBostuShVJDxEgPqxrRNu8RY+zV0ownQyXuq
 qcEb2a0jJLwcS2lo1r7f8eXtaCIHDwbcSjFYqOsMVt0W2H9EKTY+ks+IVUNe3hrRWNyucSu6Wa
 xBu8JQoLZcuc4hUmvZbVRwstqj6IBm5Qr5By4NOrz01/jwzDJqivMsx0YxjlNuHQJKL8Ymt9Lh
 SFV4IuqmJJ3wsLmooiZ/RdOJ0aOga+wLPVtcprKzkL3L/3Ofp30GS1UZvdMVuaXUZcdcAKXiZS
 a4I=
X-IronPort-AV: E=Sophos;i="5.69,430,1571673600"; d="scan'208";a="131797630"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2020 07:53:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfNXpoRqKg9xIUBDXNFSKIY1FTHabcfmN4gZ0fKHxg0eIWq3kpBmHgtB7K+n5OrT6+VJAq+TIFtmdQH8fSDZDoWrgYJsSZHEDvEje3QsCdJXF7Z/yx77JfgmnAolkPCesXQyz4HAywCihWVUOJRW4mGIFymbvRGUzFjvpSos+jAd4YAO0U1GzNglcJ/Sdxsv8J6P2tW33pu6EDXarMc0u6fv5nhgjfTZFVpF6VlW7WSYu4Z0WQw+yHq2U3Sza0kMs3WE/BjDTFqHfcvjQ/MeBsJFDHiytsAtkSEsEd8dHFGgPtVV8PRSFugvXhFQVl+coEFajIaoHQResJyhDUHIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lobZ/k2cZW6IUhKZesvFsSwpzACwj/aaIbpk7kOhZY=;
 b=Js/bWK6j49NzxubZEDG1xEFH64+nkZ05UfOLbxQ02y3gQHwvZ8eJMT4WdSV51kmBBl+L1zS+Fdvqo7ga2b1wH2KcshzNevCiSD6WvGgMvUZGxWepfmgdum6Mjj09QLkd4HTa/6XjfCg+cWHP94Du3V6pkPLm5/qu2A5JH+KLgLzonhckwu8e6ZexX/HMLirFT3R012W1WlOnTvLM/+aQkG4SCUbQBnbylJA2M7p1uK6qDqhr96D0+2eC0P8wjN01AoFabF+6HWuZ1V9u69WnG1sapTaH+yyvP2l2VWmSvMiYyVeJlInRXOb1Il294gz2lK8Qy2oHB1167T4e7OoNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lobZ/k2cZW6IUhKZesvFsSwpzACwj/aaIbpk7kOhZY=;
 b=RhRqrNlK6t56D6ryc69zKPB2FBYwJOMQa+P6fO3hNjrOVcCPfMr8MXCtlARXvMLcr4KtOnaZwxLyEjCkAFwhCYu3IA3Bf1zjTC29/LZ5YZ/LVv4qJRjuYsLaFCy3mSnTNiUuDr0J+XgemCu3mHb9bXgCA1Xt251wF07a/7W9hb0=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.51.24) by
 DM6PR04MB4475.namprd04.prod.outlook.com (20.176.113.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 23:53:17 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::f123:d623:d0e3:daab]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::f123:d623:d0e3:daab%5]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 23:53:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Thread-Topic: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Thread-Index: AQHVxqpUXzd8VxYIIEalrO1b4yEvMg==
Date: Mon, 13 Jan 2020 23:53:16 +0000
Message-ID: <DM6PR04MB57540A44AA6DC1E2DC67180686350@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a66749b-a406-41de-e81f-08d79883c2a4
x-ms-traffictypediagnostic: DM6PR04MB4475:
x-microsoft-antispam-prvs: <DM6PR04MB447585F22E7F62F12353F9B886350@DM6PR04MB4475.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(5660300002)(6916009)(91956017)(53546011)(26005)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(2906002)(6506007)(186003)(7696005)(52536014)(33656002)(55016002)(71200400001)(4326008)(478600001)(54906003)(9686003)(4744005)(316002)(86362001)(8936002)(8676002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4475;
 H:DM6PR04MB5754.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EU8Eoz9lJ2Zvlz+Lse/Gmv4346y5naABpA/UtjHTurlRcjCYwo/5L9nW482KYD8wbuuOHpQpDNJZnOGgymTV/e8drU9eKT4nydSWkk+ZWP6L0a7qBYZjGnmEUnHZcHSS+a21cqGVVJaXt6jZ+eXlgNZPBPcieQHsHXswIvIJpvRuwZh6IuczHAdZkVBTAzgoerjbFTfnA3HX6jk3q7tJb3FawXpG1aG3mFpYzt44AMPLuExsj4cIt/0yc4ZVPL1rgoiALXuFqqD/iFwkjDDIh+iU0lEWUka+olXegoAP6rmgIihpyy4uGrzn6nNch3GfGNVghibM+dvJSjs9kyMj5lFSikhj4ucUcLpRm8NCOag5TM6U292nxTVsv+NylhhoXkCWFmIfYLmMpN48C26Fs8knue3uorEzLzc7nLOzKDnm2XpD/oa99qiWNHKICRnm
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a66749b-a406-41de-e81f-08d79883c2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 23:53:16.8950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eeIJlcJuAumLnGJDYX+3ROuvsVEBgYjYxto+zhZ7+toXXM0h0ta1eDqDxLySiEmb7mWzVFwERPhISHVQpsRXzXfQ2KuvMOHOwCaqRS0A0Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4475
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200113_155320_121047_D1550CAF 
X-CRM114-Status: UNSURE (   9.34  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping?

On 01/08/2020 09:04 PM, Chaitanya Kulkarni wrote:
> Hi,
>
> This patch series allows users to set the subsys model and ctrl-id
> fields.
>
> Chaitanya Kulkarni (2):
>    nvmetcli: allow setting of the cntlid[min|max]
>    nvmetcli: allow setting of the subsystem model
>
>   nvmetcli | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
