Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D8C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:42:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0304565078
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0304565078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=oDk2TYZbDqlhcpda2rNKl9wqMN7S+Ke7ODURvazRJp4=; b=AwfcLo+3g21B8c8r6hODsw9lw
	Ck+0G790tlMtxekdB3NQwMEEgZw0zA7kPzFKwBAur6p2Glp8KAKBZxjKKwWHuW2zGvX4NNqzrHQz2
	0NiG3LGqfZoexYW3DYCKr5HFK2Cm3/DjMhzP0TLchN7824m0hEBhOeQ2zSmXr4YYhFZkSssvSbQL7
	/RPimG6bI7QdS+pQ64bmXe719ou1khZ1xIxU1cIhdwMvcGlQDR41AXO9cPOz10opxMqQLUlncPlX1
	EPJ9x+hFcWNL4aBY1PFMrr7uyfQBhk4JGtKKLKwxB3Wgj2FaqBbqpJSmEbG+dHZm3Av4t+gmN8NvM
	GiB1WZpJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHd0F-007Mo0-8D; Thu, 04 Mar 2021 01:42:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZ1I-006ar3-SS
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 21:27:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=I2w5C36KLV8kpagkSLFQc2/n+BoYVXXysOxhjf0hWHw=; b=V5Njbg+XcicBnPvnVuZGbj+pzr
 qG5VqG0hAGnLzAop7Q7BhzFYzJ2sR4I45YTPn/PirUki96X+nCd/E/rlNp6oM6m86+pk+SZtjA6pO
 UgJkMHFMv3Ay3UgRE5nJ7tOBwxqsXK4v59TIoU4327Bl8fHWYnBJvU1AvmDnu2LiqqBESbiWQCQL/
 sU62DIrH8u1PuP2Jf2dDQUxrA81roHoEQahJFKjPFtw8IcfhleRiQtBOZ5oZ3Z/Nqhjxx+pil+nxe
 sUd/ZulPIMMoP836EHL4yj84TfRHuHx4w1T5YpPwjlvBS93D0RUbxa9CXSoyKoXXE4UkfQPdH4Fei
 W2Si0HAw==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZ1G-004G9G-LO
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614806818; x=1646342818;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HCcbZTpVEIDwIEiKqhAEBH8tudSotmcJ4VsfaRLv6Ys=;
 b=Pkr7R75M7qAmvSouiuP/T4zxsg/z+mTspHZku4L3mQD2LaqpGc7GqFRc
 tijMIfJhshswMUnRGGkkS64Ns9hkrsH1sZWEjfs8W3sf8xNLpLKCkHAlR
 OLCBy574H0CrJEXc60K+q1vuod00kv6A7quhrWkQ8Ynstame4QdRKituV
 Y4fTXT0lpHv4zp2vpWsgLLQ8y2jVWWOPxhzIeMBMa1gnC+dG/GfxiY0qR
 qxNA0GnRHb14lqOGeC/rYAqY2ulw4thb9vv6FsewGAIsv27BHa5w6IYAV
 wy/Ku3nfQ6v5Gn45fVv29baCtYqUmD/w1VYSa/ZffSTmn2u+oUcMNrCDc g==;
IronPort-SDR: RrdTsXE+42rvdsvhf5Bznp6y/9M+ecyZ3xnRuI047c+StFUYvOlKHmHrPBAVu1FYeOUty2QV9A
 pKwLwVL0cVcDz4pyURl7exuY2Mt0OpHEl1S5xJWQu+RsL5KvEwpi1ENZOSzrt82o8d5N/6UTHM
 qogCowZq7reoCSBTbsWtOFgwtAJlOXFVsnSmLBqkH6+qAxli3LuPn/tQaAeqg7CwZZWXINbDK3
 7Xiqf2lt2jUzyL/gEwdrMxjNxcp4c2g2WVvKY878Yjb1OfzZcRg855e4msCtda0dAJn+0TkgCo
 NtI=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; d="scan'208";a="161304242"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 05:26:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJrmim1s4Dbu0DB4v6jTKKbh5lRw3RbiCJnJ3An3Mpp3LZ+rCH6YyrMex8LL1++8inj1EnzdT6+GCrB+jsUeeSjgGNjr0wi6pPTU3l0lY3jEnpItZYre9avPFQbVfibb30KCH2TChyKY+iexoqvfFlVng4lmPUQlr+0wk0wCMzenwdYO8BTKEPXViXkA35pO2Nctd5yF+HzH+py6r7IL7c2d/KeYbWn5jPstPA35Mq2UsctoELVr6JTEJiKFB5XbytPHOZO51HGocvObihXL81G6YwffDf0VBf40Ddr/NGYqmjjIoz0jZgG9Tx2o+qBeVhP5K7xP9Hbprp4rWWh/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2w5C36KLV8kpagkSLFQc2/n+BoYVXXysOxhjf0hWHw=;
 b=E0OjphqrP5+lHh6Puu8/4E3FF6RMM0uzegx54vwUsCWhHIbOo9syOYpx/Ve3P6m+96ZEvu17imILFCLhty19w9dirWFASVSSruDhnPUdOheUxqy7Ka4f87JR0R6VyYUY2D94fO8YwLrNgK63tF/0VTOAxeBKC7P4bbCNbbf+p77bGgQOloTY+HvT9Imoj8Bw/KRK2dhaczPdtL6r2edkEg6QrCQyncD9jNMamlc1QxKLsg9/ZWpFNpcK+bGCdoAcUIifaD6CVcKO8NgBxuiMj4OsfPJpRmSKSjU75yXGa/bxOWG1QR8+tjp1e6BhShN/fD/DsGnV7tvES9DBnPMZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2w5C36KLV8kpagkSLFQc2/n+BoYVXXysOxhjf0hWHw=;
 b=mw20iZSkYkLTzn0Elw03kDfJ6nteJ7HmGg32/gRb3gnvF8VZ4rXJ+Dfnob800CA+GECgBdsAGi+aU5KYDhhsG/AsezsMMn976G69K7xVwoZFHa1KWf8jG9DFgZ9Gds3pmGB/k3N3Xl6A000eRCSGqScZnkvVcJ4L8FQGgT0T8RU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6961.namprd04.prod.outlook.com (2603:10b6:a03:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 21:26:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 21:26:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: only reserve a single tag
Thread-Topic: [PATCH 1/3] nvme-fabrics: only reserve a single tag
Thread-Index: AQHXEHLDFIgtWfH7k0uW/e2KYTxTcA==
Date: Wed, 3 Mar 2021 21:26:36 +0000
Message-ID: <BYAPR04MB49659EFEF9CECCE81EEBDC9586989@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00bbc4ff-4c0d-43e8-206e-08d8de8b0681
x-ms-traffictypediagnostic: BY5PR04MB6961:
x-microsoft-antispam-prvs: <BY5PR04MB6961173D725AEF4ACB5ED44B86989@BY5PR04MB6961.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEAE4zVJ5yrWkra3wZxELC4yX4pr1E3gwmZE0XKODmcgU915q5pD0GUlHFU8SZpOVWJUkoRZMpKAgNYRqgVhDt7zWWIfoCcb5+Dt/RWBOgdnqNTAl3DWmqUMi/70+6T/u6DRl8OhOwP2hunDGSrtHGVHovaprGthFSPukqAbR2BJWlYIpJyi/HE8W7eNVFbifGuYDe15VfneuJQOc5PVLSURNPTEYdsF0hlRjTLHuh1uXs/dz5lP/eWYmqYVOEYDl69AQQYkmx8uiF+Eqsz7uIihQEX2vwMh1qCa0irKweiN08M/1cxfvSwUjEpmFwp2Kpj7jyrAalkTG3fzCz4DaKcr5PMn7bjTOACK6UMqdNKJF38Zdo2+4vscPsdgmWnEiSlxM1aNNycMMeSWDVyxG7uZfJLcSWuTIu7wPJFaRRrnBmxPnpkJczXI5Nfp75ja3T5RPi5GMK60iF1NWw0dbrgtWNgb4ny7VmGTTsz0IC9NEkiLan5JERZuPvARAsFPU7pEfABk9NilA3vq8M5kUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(52536014)(33656002)(478600001)(76116006)(2906002)(8676002)(71200400001)(5660300002)(7696005)(316002)(55016002)(8936002)(9686003)(26005)(66476007)(53546011)(186003)(110136005)(66446008)(4326008)(83380400001)(64756008)(66946007)(66556008)(86362001)(91956017)(6506007)(4744005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uRPqB4sCX4Z1RG4r9zawon/siKYANgMNcPXFcayZQUIYkPin/topTGyaucdW?=
 =?us-ascii?Q?FnFe2BndJrpEVKZgQjMNPnKWlMlYm2CluqY0pN9KGfxjWAn/kKm/lT4hEE84?=
 =?us-ascii?Q?eJ2XHd0al9kbrb5mA7Je/v/FIvbiLGkuY7CSz7TEDwqAYvVatxwHgp7rBfIc?=
 =?us-ascii?Q?3aqHD9J3rcSOHeSS7y5qYqjkzr7ZTcFKsvVOb4dximjUHbmmcpdvkD607+Av?=
 =?us-ascii?Q?L22p7DABx8Qa1ZK3MttEd5OiDsL9fqv8suIhlwpdk5fdg16raHnQcbOSLTyu?=
 =?us-ascii?Q?K018S5DrA4+vkL2aCCcg3qyizfhfALg1LRJIBSnn+/4MxGgnEkWUoXeRR5t9?=
 =?us-ascii?Q?kvA6496sRuUwZq9FDknJJh9J4XMGpBVMfvq0yDMFlw3lgeHxAP8mSytXzBvZ?=
 =?us-ascii?Q?TQWpra7xA4SiPftXnWz+/tGCghQN+McC+w19PQJAvDdMpQ8y8/eIor5UrBsk?=
 =?us-ascii?Q?3yng8A9V9m72V/hw8he+4eOeUJ2T15TUvNgvAtSmYLMiNdpbKgMeOcC+Lfsx?=
 =?us-ascii?Q?vGRowXzOQcTSUd4lFVEXmFNvb51EkdYgL8aed5rmT04loesCiB01bwF7d/bv?=
 =?us-ascii?Q?o0wRqistQqt8fLQbpY7F8RmidCIdnrq5l0pP9hBc4jIPd2dR+QzYQzjKZLsu?=
 =?us-ascii?Q?kVeWUD1YqKVxLpDgA6yliqQeMnzN+3fqmuGhJ7iX4GKuiUqzFXZv24Fz/kry?=
 =?us-ascii?Q?FkK23vjPXUBqKXb0dxIvXt5g96gz6yy4ZWGh8+A70gmAw9hSLrpc9+TyLwEd?=
 =?us-ascii?Q?hL0MuP2TQpUnO5eberKLO4SOWoquteVuETHhE2szFOr1wBV4EOJX1Yqdj0/8?=
 =?us-ascii?Q?kKuO2RMrzp4ZJx7En4s1AANe3ClO++YQWNfvN+XyoS+QtgQ4V5Ya6Ql/AK09?=
 =?us-ascii?Q?3UcTevi+7yfoNSu3GVPUhW/jz+V7DscBwPVM7sRvsTmYjR0DE+cLHMXWORms?=
 =?us-ascii?Q?ASVpFtciji04l7/FfgwF2tL8DCxZVeegZgDEmBsDCyhYHq/ZG88ALXI0tfGd?=
 =?us-ascii?Q?0hpTe2s7wNouHGMI2XmzIlV/nLwtSveWn8mZg1KcdVG3BU03PhHHVf0v+wWr?=
 =?us-ascii?Q?0V+VoAYmDBte3xDxQgxJz0gL6suYqtXGyq/Y8pZrN9YoMxWpNTjcEwDukvxK?=
 =?us-ascii?Q?G0yCWcwsmTfwQGkQVGzw3GAoYNV5SRZ7K0aY9GM/Y6iwB3ujuuPkYvbjEmc9?=
 =?us-ascii?Q?cyVgI0AOf9RMhxS988vqBKhk6+T82XLR6THDauS1itKwDEq9mxLWUKI3jq7+?=
 =?us-ascii?Q?0Fa+vsz3fAyfFCAdG96qUvIAOPG44WXaBlQdZzl2l+u5DLHtE7502waQHH9e?=
 =?us-ascii?Q?g8PE50sVKQPfdQ8irI5/UZaE?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bbc4ff-4c0d-43e8-206e-08d8de8b0681
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 21:26:36.3341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jp2hx2qX1TcwgY4CkoXQ8fgGkWEJA/vTNWwNdYDYlyeJ29zc9i37W1xsY4q/5UCKEZPZ6frbSF7Wtx05UGUts4G3+oUgjv2iEsgOzgXldmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6961
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_212659_558768_D04E0B3E 
X-CRM114-Status: GOOD (  10.89  )
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

On 3/3/21 13:18, Christoph Hellwig wrote:
> Fabrics drivers currently reserve two tags on the admin queue.  But
> given that the connect command is only run on a freshly created queue
> or after all commands have been force aborted we only need to reserve
> a single tag.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Thanks a lot for creating a macro with nice comment, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
