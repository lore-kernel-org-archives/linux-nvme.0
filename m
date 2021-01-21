Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2EBC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:23:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AE4239A1
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AE4239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=5V8ORoiP2qkXpp877/rh6Zwnvh6r4F+q12InJ+/2eok=; b=EzO2LO76VGl6benCj8AU465vO
	eFR8BTeMbmrs/w/JIm76Rbq+g/glVj2YyNB9+MEbuaNV14Ftrx4372O9YRoYqKRRaMn09xaL78eAO
	GGMEXyFBpwJYm1Q1TP5sScRnjvco3OmSP6IKU1abfbwZPWxzIf5e9+d8m5haoX73i6Gb6hHptIchN
	Ddimv9gndaHCujVuCJ7lW58PGVRQX9krt9VDZtzlifJOtWGSs13V9Hvm1kszmZHypQLsJxfTiyOLR
	QtdaJZGUhlusMIbruG23ktI9bqAj/P0jNXe93Vwul7etjTXf8zdx/vg+7N/m5ghIr3dnoxRVrof/+
	ePuIjGLng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2VFZ-0003AZ-Im; Thu, 21 Jan 2021 08:23:29 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VFW-00039v-2E
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 08:23:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611218593; x=1642754593;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5xDViCNWTWpt74+S63VrlNc8LWu+dxnOf+RyPFe7hss=;
 b=YUiazqLoKXvKOfN80FD4h6C71tCH6pAXt+36pAkquIA2VQk5XSTJVOW6
 pC5gUYGjPdAwxXtwDuth/KMWe8WhCneVsKNkI6YYhEafM1k/F9lx3RXTD
 AHIuXIQV4aXJkYty2fNUx3cZ4cCIz9xTtQr8oZ4Tod+++2LfmKaRS6cHL
 CpLkO2R2cF4YGe5Uc5y+Ya6EEbPmuuJgqys6YRKrhvMAEMY8wOXx7JSdH
 Ws9Af9uKQnDep4oeZMGtLwEBOScH28aQXpJuElsKOXEKrzmov4NBpGfAo
 ATfOswfp+gti8NrcJKUkWKICaKfBRmAlxatvj+A9EhrQfFzxA5yBQZsvx Q==;
IronPort-SDR: nopY/1/vZtTbFd6l0+IpzksjZWV827taoYGdI6nTCvXcD+NT6atg+8pFyCQqv+c16JkaXOoL0D
 KZ4ZA1yIKpkpX5wZeHBX/9xKxHqY0oEbQqAoXtVeOlDWitYpkamuITHncU/F4of0v0+vfTCvA1
 8qvStsDmXY9OCQe7EPLXrsBBarKmqoRU5iWs00KcZ6PkYEsEa49IMfyV+qwhw4SkboXxG08Km6
 tzg8JeOoO/gZkor8VHecJdk53+ftE6lSIRjTitLfOZZNK7atzziYHzHo7RWXAh9orbProOBDgX
 qkU=
X-IronPort-AV: E=Sophos;i="5.79,363,1602518400"; d="scan'208";a="261948044"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2021 16:43:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw68XCNKrU/qui9r1XSPq6hnWUBUdN/CfDi270C7BJeOnIzrp6qBQlCcjU+S9EGPNdg/DQ8OYphkmMhy7CVeybh82BxKsz4MwvpLcFqZIiOBiSQjpDQ2Bqol9TSWenr6xXXpcqa3xNnfKtOclaOqXDe9MnJy6nuBYdY6xn3P2cH223ZYGc4Yc8qw1KxiWmgpftekj+FIBNuNiz7iUfzVH04NZ+jD1ozB3trYByAOZMz6ZU+c3NCyxa8JoMF/m62PWe0Md2WN9/pUQtGLkUgsHuk6lut1C/P6B3ex214voxw3DMPYPzPhMXbM++tqT3pYdhe93xkdY8lAPQY+rboeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0PH6GNao/klmOr5IzzIaOMg/PvFVYJ+pZQvveYwX64=;
 b=bOjNMUdbSeuUnFo9IrVW/LqAa07ep3nTQcmI2FgbBgtSEiGlbP9fxaIAWn2bLwbR0qxEwbpdToLb5qVWFFxaJfPspEcT6gxgUWyGagD3htFPcBoSUJobCMw95Ta5QLNipzaiy85bcNYkfnVc84J/ZnGPEkGjqpuM8TjJ28AgBENd0TJ28lmYt1CoJ/MssPzIgsbkg10pF6WAWCw5BgNsH3D9dOpKfeZ9EPW2PXfg4ZRHc/yakrCdIFQj9gu6QfyLcuag8hD2+fj0xanIYMuBDpIhztQAzTX6m6QXhR+FTzbm6JliOr6eDJ5KFR0uLV90E75pq3cV/uBINjreOzEzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0PH6GNao/klmOr5IzzIaOMg/PvFVYJ+pZQvveYwX64=;
 b=tgQ731nUeMOhgE+X8aJokO/3/gyG/vVOcs6a2e/emcs4H/n2HmGEuaZba4xmEtuF7WrO9aQ4Anb5zLf+0Gh/62xUtq6RSHNCkq8+v/D73mis01yDlsTmWrqZaqc9MCJ4Vvx5Fzn5ynIqnpCID+L0WCfk+HJopSJseRjrC1PJxRk=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM5PR04MB1035.namprd04.prod.outlook.com (2603:10b6:4:3e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Thu, 21 Jan 2021 08:23:20 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3763.010; Thu, 21 Jan 2021
 08:23:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH 00/37] block: introduce bio_init_fields()
Thread-Topic: [RFC PATCH 00/37] block: introduce bio_init_fields()
Thread-Index: AQHW7iDfXiv5iuHOl0mGSxMcJ7OwhA==
Date: Thu, 21 Jan 2021 08:23:20 +0000
Message-ID: <DM6PR04MB4972029B58F81B22033E31F386A10@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
 <CAGRGNgWLspr6M1COgX9cuDDgYdiXvQQjWQb7XYLsmFpfMYt0sA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:6c3f:2942:f9ba:e594]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b399c6d-302c-405d-7f89-08d8bde5cfd2
x-ms-traffictypediagnostic: DM5PR04MB1035:
x-microsoft-antispam-prvs: <DM5PR04MB103558D7CAA67BC277FBE0E586A19@DM5PR04MB1035.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luBm2A9fQFDbAs+wwf5UQLQqGI+U9qrY9qOoLl278vLFEhZYF8PCPE1mzg6Tt00oqorUoJZeH6SroLCiDqfwK9XrIA5LmEasW9gV2WFpREOKVrf0vl5YIGT/uz5MOZLMc95bMXi+Hw5BHRva63Z5/1PuoE1WocRTm129bzScDkldj9CvFwvFGhDH9Et4QKMXUX+IciSSEzf5XTQnwBQ4Ce56JAClngNy5hTRHQCC5L4OmkCPDAyuCVPr/ljXo1Jgx+wBya1uqegcbpFR6wk99WVD4J4hLzl4XOz2eSJuA7hIeWxB1OEAXp8WrdWox86N/lXoRtgzme1lqsuaDmQHfwv/fCM9Q/yzofM2yqu2Jy068UIlRYCsj/6zdaLjN0gxaku4C3m0vY9X1srG/ZD+9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(316002)(52536014)(6916009)(186003)(54906003)(5660300002)(76116006)(9686003)(55016002)(8936002)(71200400001)(83380400001)(4326008)(53546011)(7416002)(7696005)(8676002)(66476007)(91956017)(478600001)(33656002)(66946007)(64756008)(66556008)(86362001)(2906002)(66446008)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iASZoPJYzsgBoHOG0e4uj4eYwMJzI7AYx9ibXkU8WlIY/45eI5Lozn9IMLqg?=
 =?us-ascii?Q?K1fUjrE61rIj9pVmoTN18nQMr+gvGY4G6wJ+Ny4pZYARx/NQUcSJcxlwZktO?=
 =?us-ascii?Q?bHqvL2+WTuwKfq2jk97rHh4iKZQYlGKj9o5IFGIIiC6E0WKGXNOAogExeiH7?=
 =?us-ascii?Q?tO53jk+LmhpLuLYm0OVz3gHZc25lTvqogVwbwvUqG3rX45XT/251vlSLhLDN?=
 =?us-ascii?Q?BiAaGVE7uBNDX6Lo7JJvKKpz+6vrvuvatx4hhONQ7MN7a+Zn8FxjYQrE2SUa?=
 =?us-ascii?Q?uH7RyUQL1jRl4VoRuKHUwCaNA0ebTkVOQKvC2VmJ6rJqt2gYMsgZjF2sAvYF?=
 =?us-ascii?Q?ZwtuZCJhEJsAawETHIlGBaxry0pr7057QSOs8vA7S+uAfyiqeL3YEqc6ejxT?=
 =?us-ascii?Q?RixON+06jvKRSioN7m1wLJ0XqsMUTEiwAu81zEEefyjFa/50E45jN0Pifbq2?=
 =?us-ascii?Q?YQIZxBpt2Hqxx1KKyTlN2pXg4IQbafIQchs+7TVmwY/vsp9tQR7uEafp0BDS?=
 =?us-ascii?Q?bu5T812yyckpVYAeXogWT4zDgQOCOO47FhLaIz3EFn6kvRW51FFMDKyBoiir?=
 =?us-ascii?Q?wXwhkX75FSf1Qw4pnCXK4hYvl2cDv1YYOEYl1WdmIjJ5O2HNpEWKeTvOxwCX?=
 =?us-ascii?Q?6grVS6+rBLLWAffAcMo7a016G35j79LX7hwn96/LgR3wCcwVNSh6y48Rw/g5?=
 =?us-ascii?Q?buriD3gNHqhP6WETZHEu3zlHI7zs9yJmY9x9tAS7fU8E1W8RjXRnFv3rsLTV?=
 =?us-ascii?Q?mGTcmEpB3F0x56xPLqIzECmw12+8LqLQ8UDlGJuGXusb8MbbIGileZPhB+uM?=
 =?us-ascii?Q?eYZwo7QTxj15lHNkB6nFsDURRPPebs3b77L/3uwexEDpxECQDVj7jI8ssHcj?=
 =?us-ascii?Q?+WRw7u4eTJ3rUDPixBZPxm7sdD54H8NacygfAoLOu7DQVosWaIjmoJMeqwei?=
 =?us-ascii?Q?UQpipq7k3iuDVr8GZd3RD+7YB2iiiLLxt9SAooJrWAExIIw2daPBw3LpDI2I?=
 =?us-ascii?Q?v+AxiMYRd5DaVrZHEoGe1XFXE53nsSzE545xeS/B8kIzqSQ6QWmjCxUgzTIz?=
 =?us-ascii?Q?RlRAUztqVUa3QAZZjmDwWD85Sb5txeijXEhtYjBST9cPs9YLaZg6pekySFU5?=
 =?us-ascii?Q?eMN2lhUlrZ6V1wO6BG46/XYS7R06vKBnUA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b399c6d-302c-405d-7f89-08d8bde5cfd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 08:23:20.3555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/0OYkC/ek5ytB2UVtDM2si2ySo1pVi+WyQqr0ClrR0sMEWiGpRaV17E+ClET0fPiMj8qHuKJIGPJIy3pAz1DySUTHtG+BdCm5OrLj07ghM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_032326_238897_6BCB9C1F 
X-CRM114-Status: GOOD (  15.00  )
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
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "jfs-discussion@lists.sourceforge.net"
 <jfs-discussion@lists.sourceforge.net>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Linux SCSI List <linux-scsi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/20/21 7:01 PM, Julian Calaby wrote:
> Hi Chaitanya,
>
> On Tue, Jan 19, 2021 at 5:01 PM Chaitanya Kulkarni
> <chaitanya.kulkarni@wdc.com> wrote:
>> Hi,
>>
>> This is a *compile only RFC* which adds a generic helper to initialize
>> the various fields of the bio that is repeated all the places in
>> file-systems, block layer, and drivers.
>>
>> The new helper allows callers to initialize various members such as
>> bdev, sector, private, end io callback, io priority, and write hints.
>>
>> The objective of this RFC is to only start a discussion, this it not
>> completely tested at all.
>> Following diff shows code level benefits of this helper :-
>>  38 files changed, 124 insertions(+), 236 deletions(-)
> On a more abstract note, I don't think this diffstat is actually
> illustrating the benefits of this as much as you think it is.
>
> Yeah, we've reduced the code by 112 lines, but that's barely half the
> curn here. It looks, from the diffstat, that you've effectively
> reduced 2 lines into 1. That isn't much of a saving.
>
> Thanks,
The diff stat is not the only measure since every component fs/driver
has a different style and nested call it just to show the effect.
Thanks for your comment, we have decided to go with the bio_new approach.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
