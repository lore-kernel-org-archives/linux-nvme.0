Return-Path: <SRS0=vQ/w=LH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEABC48BDF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 21:05:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909D361354
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 21:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909D361354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=+BgxtSWmsRko5splnPy7da04u0UJ1QL0PGtgsyjdvhY=; b=LBqNPPAdNasFKz
	czUXAzPAH6qFUvCRncXJGToN7eYllB1p45UMfj5yo5gue8C8dgW/ENfIyfUJObeRmy5mom7AyTVoG
	oBRz+sBpZlKFuLTsTtE0xbMVGhQhCepSR5Y4LMrESl6BhxPr6h326PiB7Rys84yxReuxIHLI0gAj+
	x0HZflNxNyrD0w/drNMFjqbgM3saqXUbxC/CWmZRE2b4tYrPZSgrzgA0FhU2P3qTNARENTqxUasEK
	ZVVA+CLLG1WoM1YHrp29iGx2LVlqFFGgSX/5RISQkir8eK16ztz3iF4IH3HLitgPiGmXA6ueZvnIg
	oSgugbg+34MVpBD/uanQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsXHt-00BH8P-OF; Sun, 13 Jun 2021 21:04:57 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsXHp-00BH7U-Sz
 for linux-nvme@lists.infradead.org; Sun, 13 Jun 2021 21:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623618297; x=1655154297;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=VWm3aakJAcXQyEeYwcpAfm+AwHnaXT9oPgjrFU6u/Vs=;
 b=pfxWddxlMU7RXxS5fAav+WiuEYRXIEDyoTe730FjJ221JJs1gXtKfFX4
 gCuOaGA+QXpOaxTQyZbddXKE6PXzRcP1EHSNaUP3/MiokdznL3CmyWK9P
 m6kzOuYoDV4paIBhMJHj8CmFq8eukryy+o/bdfmiWvkcmjQN47iQ2jKbn
 8WP2KDBYioic20NnQVPXB0fXxgqqxH9+O/ST8F2dW8/j+J6QQGPTQBVa9
 aard3kUEhDz6/ekSEah9uHGlqi/nyQ6IyUMQ3dfIHYcGGCxHiOKzAXBCv
 qLnYfeLDZsGVe/mflvfXHqy8k1A/AJ/NFcmXm1RYcUo5MlcJQl+ny6zvc Q==;
IronPort-SDR: MFWK7/S2np6p2Z7KuxXqOU9i2Uvqw6Wx3C91GIIzNekjeYE2FTzqWndPz2P924PCPCWQoL2jxB
 fQJXFHTR2A8yowL041ucJmkQs4eZIUlytg3NQKQ/ngUXqBh6GdWrX/Ol0EXpFymnwVNTLobgSA
 OkZw2nJjWA5+K3N6+dHckedMZ0fhhWJD+jgA+VhcX9z/M8dfzukkTkvWjF8PqNeNWCLyrhFWL/
 WNT0r2isGw+JzEbJfuSR5Y9H497C77uHQSu5volbUkLnVp3hzn9lQcJlOhyH4uI+hPAPNXRVJM
 vTE=
X-IronPort-AV: E=Sophos;i="5.83,271,1616428800"; d="scan'208";a="275547532"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 05:04:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLwUt0wwYryi8MkF81/We5epNeFHlgN7iHbllPGO/x/ZegJJOTpBTD40yj7zlMQDRmB+hhBFSzu/n10tfrgw5l6fdwv9kRl/Y/gvKLZkUjh1bvFL4O6cqEfwEiWU8HKfZfCDP24hekRsnPMVN08n+jiIY91q27SCzP1MdFRvN27c0nfS8WZRzvzHD8NYvyFWTDLIOZs6yQswwum6qdWCqYOYavnDCHz+5H0g8T8PjSJ/wf8XmMCWCGoS2YCBR1W7k6nTsUY3wXwBerh8l3lAJdmJSFsPbsFWCHODqEg2+orv0fkuxoj7rROtGP/a+xewq8jeYXszA6Ukor/oP064sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWm3aakJAcXQyEeYwcpAfm+AwHnaXT9oPgjrFU6u/Vs=;
 b=CryrgCe7EPAd3wbOzxXVFCF73KKE42VdBa/mIi0P3keBT5+ts8O8/yBZh5hUDC30hQxbeyZuFr+FRsUCgYe8JbBTWIg9VAed1JixpJJQREAskf8qhN7PRfpNOIvdAATf+giKf8clwouafFMgn8yIkOd9tE4ntf6fl9Xuf7G3/H8bOhYih8Yxa587kuvz+ragbgucp77mU9Pk7+JwrGIkrXLtwXJB4GOuwN1oKGMpDOdOSpgHLvwnz/0Z6G8H1KkOU5TFVOiBv192LYWsIbS1e7i+h4vNzLaH3m34blogYv8uQYwS/NMA6RagoMLcjrhGC1+KpVFbfo4YDSsozT9ObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWm3aakJAcXQyEeYwcpAfm+AwHnaXT9oPgjrFU6u/Vs=;
 b=Nx06pC0pCvwXumkJDdRNnNiQ94SuRHcezG9NSL89ujCfOiR/ALSMaAgJIU5dr+nhRRCmYmDg0AyzkvlPHPTCSH8qFxUUGmw48cjb8rX55M7TNHsWQJ7lpYtbHMVqEyQK78iV6A0zymI5+oEMES2YD1o1Qj+m33epqOeG9N37PJ8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4869.namprd04.prod.outlook.com (2603:10b6:a03:41::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Sun, 13 Jun
 2021 21:04:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Sun, 13 Jun 2021
 21:04:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "dwagner@suse.de" <dwagner@suse.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/3] nvmet: use right MNAN value for controllers
Thread-Topic: [PATCH 0/3] nvmet: use right MNAN value for controllers
Thread-Index: AQHXYI8cca5pK3Sn502K/AGiPxNzDw==
Date: Sun, 13 Jun 2021 21:04:47 +0000
Message-ID: <BYAPR04MB4965B8BD0B2E0795AA4A84F786329@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f3b4818-55e8-4d63-83f4-08d92eaee0c8
x-ms-traffictypediagnostic: BYAPR04MB4869:
x-microsoft-antispam-prvs: <BYAPR04MB4869553ECA91783B71B23A4486329@BYAPR04MB4869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkrzoCD0D6I4daHtOHSHmR/51L7ez3fQClk20e01ibH3Y6mUPI6JNOyVQdd7tR6LyQndHodkoKWZUKVKWLU8E1L9xsqCZU8+VaVGg6JjFNJXtlOZ6iHmL7fGcrbhCJyQQBFuO6EwFZOSer6HSxt5AmaGTves0OBII8As99rGbJoHwsEH3LjV41UTkXqMX5WfkNu01SIW4mYg+gqPE2iSjhEgeAPQJP1U9qdlNsDFP5aDP/wewICZas0iNJTEgQTh/RjpdQzXANFRIB+NSdny0uVuFQlt0wt4OL/2myedyPPfgorpxz77ybG8vfvjZQ8htgTZ2PeRT4UG4e7tH1VRCT4mCZc+vDNtI+LH8ZZq+FAqLwXtYAkfW/B/SC2ioTuf3V26AWVLiRDULezXEA8BbxAHOHMv7/oC344Vx8Rpa/T7rqfKnib0IEiunsd+44I8q/WpnE8NA+6tyRVcgVJyb70HHC7sQc+QFUly2c9zDXT2rye7VtYwuTUHGUHDnJZaAfz22RdoV1YZLeQqTLWFg8k1CyT7T2HHgoVBqBTzsUU7fatafME2zleIiSWvL16ikx1YYYm/7gB6Bd9hOL7sCSBZFowSoqf4ALWHvvD3LqM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(7696005)(86362001)(52536014)(66446008)(53546011)(83380400001)(6506007)(5660300002)(66946007)(66556008)(66476007)(478600001)(8936002)(71200400001)(64756008)(6916009)(76116006)(33656002)(9686003)(4744005)(316002)(26005)(4326008)(122000001)(2906002)(38100700002)(8676002)(54906003)(186003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rD3AtQiVp/F8pQQlPKOlz8FMKJQg1KDWhIld7pVUwy98rwa6CCWqK5/H9zzR?=
 =?us-ascii?Q?siFv+Pvt02/OBiSR29pTCvzSRD3kbkXXSLcKLZLPmMCMNDopb1qYRsVrrHzQ?=
 =?us-ascii?Q?1Ejhom1TADtd+42teNFETw1kSXf3QqRdFWt4RW8Tsea2YhF8SPztNvHqJzpD?=
 =?us-ascii?Q?wV0PePphD8VcEg/duTqg/edI7qySsPj4QPxSSNFnUsYRGhrLVsV6PkRoe3C5?=
 =?us-ascii?Q?7akI3HYTZ25EAJLgISwATpyidnRlAucGtpe+Z2ONGJKlAw/NI11bn2W4ed1h?=
 =?us-ascii?Q?kbahOvy4FV1mG/1AwXE2IZ8mL6YuauM455oOZD+aJCcoiCvEGA2+XSEjBAVc?=
 =?us-ascii?Q?hKdru0TnEUyLi0/xaJ1vFQ5w466UD91HpQ6eiPTtZT0ELed+QQL4f0Tq6RfD?=
 =?us-ascii?Q?H9sV84Z9mrYLSb8gFngMUF0M37hnJC843oLdRjV2EVo1qSqqx5DeXikmEP6/?=
 =?us-ascii?Q?EPIgvc2t32bVgFwWFoQiwtK5iU9BTKKEyVTc6qrhlin+fMxBrWedxZFGU/MQ?=
 =?us-ascii?Q?0PoLDEbBoDZcwFVKspiV6oIQ7aN5enom3IlRzgX5YNL8yHNZE7LAtBP0lhce?=
 =?us-ascii?Q?gzRnb6dHHv11pivzyY+tm44ihsmXjCiQ0WojGpslGAWyvYWm4aOBQuU3GNWA?=
 =?us-ascii?Q?QOl0XrU8bN9wv2d/DlD7UHwJnD/2AR4cPVP7q+Pp8qpkVj+ffVvrAmOcuCAB?=
 =?us-ascii?Q?18DcBWiKV0KYosrDubHD8p29O2WR4ZxFvsvy+NBRM6PhyH+Yow/3wrcdAhQZ?=
 =?us-ascii?Q?i4FVB/0/F1Pao5FFSKdZzGybvZFOw/+XMytevsiv79H8vhyTWc2q52YVoLtl?=
 =?us-ascii?Q?nHAd+FkFBrD2yp8cyul8VmMPk3OE1tEjGdXnkXZi0B/m8uIMwZS/7d8LdS9h?=
 =?us-ascii?Q?/YPdOyvPLdxLmqyZ1Ij2lBpZtLG3tBqF+TBK+IPIkRnQ0bA2p8Vh+BFMb+7E?=
 =?us-ascii?Q?qiFuvMrPH90M8dQHRbtQeILks/ZOeQynKBR2Cp4N2OKx3Oh3RfZokXjUSeM3?=
 =?us-ascii?Q?vgP+RDbjS0vBHhJNrxjvwYzip1cGmv2r18zqTYWiM7Jbsec40p905OX2fdyi?=
 =?us-ascii?Q?/REL1wzAi5ChplPS0hxkxper6ZsnWwX9L32ro5qagHnQ6VXn7/iwfchimgOx?=
 =?us-ascii?Q?QtOZgBK96PkDp86OJbQ/8TTIVzZXhbBJexAs0QEVz51vo1j7mTOhp64ZrWZR?=
 =?us-ascii?Q?S2GpVlx1gSeevazpW5407TJfGhOAYuWKu1SRHSrKYh7FthIHW1oZdHuUAwXT?=
 =?us-ascii?Q?MD9NifF3vdUeL6Ttp4s/TK6LBWwtJue/VE0sa46PTIIvMSWvc97+1bAyEOOi?=
 =?us-ascii?Q?BqczODK73hnoB7R9EW/BR+D3?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3b4818-55e8-4d63-83f4-08d92eaee0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2021 21:04:47.9361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FM5orVkKKTQi9y+0kK9/ZLvSm0TQQbXUb3qVShtSHgRcEcIAQ3ydGlWbsjYUmYF+vm6cyp2OkKu5uOp7qB3d+mEwqczuHaMDXAizBvAUBrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_140454_052989_41BD1FCD 
X-CRM114-Status: GOOD (  14.27  )
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

On 6/13/21 13:03, Chaitanya Kulkarni wrote:
> Hi,
>
> In current implementation we report MNAN value as NVMET_MAX_NAMESPACES.
>
> For Spec regarding MNAN value:-
>
> If the controller supports Asymmetric Namespace Access Reporting, then
> this field shall be set to a _non-zero_ value that is less than or equal
> to the NN value.
>
> The first patch sets identify controller MNAN value to subsys->max_nsid
> that is always less than or equal to the NN.
>
> The second patch prevents creating the controller from subsys if subsys
> has 0 namespaces since it will report 0 (invalid) MNAN value.
>
> The third patch prevents reporting such subsys in the dicovery log page.
>
> -ck


Please ignore this as some of the block tests are failing I need to figure
out whether any of those needs a fix or something is wrong in this series,
sorry for the noise.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
