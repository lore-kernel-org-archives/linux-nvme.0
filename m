Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B362C47080
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:28:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B437460234
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B437460234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ince8Coo4GfiNGTQwOIkDkYiFutSKsV1rVR3trpgwWo=; b=BrNFBDYDg0kEUG
	eROKX43YyU0+KXYPEgSKLSNHs081Mm+5jnnN/BVz1MNytztEjJudNLTZxTf0y0/SHa0pcLt/dckUj
	kEH5GswiRAKTey6eELTLPNL51u7qR5qxPRd5SmloU6Wni7V1MKZn/HinMZJpEVf17iOMXBce4Zh3l
	h2B13lT8QxdCADXdjXabg87Thif4kY6Tg6JgcayPvkeDKs99a6HxROsww+QEUc8AXWN5SR3xiWAbE
	NSoTDoYwXrYUVd7AamcLjREXrfQ6HLDV7xqHCb2yG5R0w37EwGm9TodjIKOiigjv2i9Z3laLRRWVc
	CgOFwPpNQCezxg9qYfYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo8Ba-0005nC-OG; Tue, 01 Jun 2021 17:28:14 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo8BY-0005mR-0X
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 17:28:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622568491; x=1654104491;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kIaTdUnp5hUZXTDzkap0c8oQpCucHiEMnXe5pa644DA=;
 b=pcm3ZHa7DUO9wB0ywf5t9SrPt5U7CiF2MLQN2Ir4/ADLu2rc4Arbe/iD
 wDvu9xv0IptAHVwI7TFZ8SPI+/W28v+MZdIw4dzvu2ziTPS0vH78me61Z
 nxdCvBiTfaYru10LnnmH1Z7VpseJbdUPURpok5VdlwixAmhh+WANL9U1S
 0O6OeFPUwQnTzJYVRwpbThBR4c8KMuKNTiuHuAnp9J2paUXSt8tTldIFx
 EvcblDl+4kIDsuuyIL4B/ZQMSYBUiqBmT/d88GcJTiLtNfbdLAgb3lerg
 5mSL1apfyd83/o7iGCyOmM9ZRUWXkXM502LAvq9Oib/huP9RyeBxPTmKj g==;
IronPort-SDR: 0ELqhGh/JigugnqgWaKB1aCjW7d9NPeNKj8ohiVKUJaRstzD6ZOkUlhE3x34aWRSrEyW1PIxQc
 8NI6RkO/ze/dsQ+qnKIbs4TEVa5LNa5oSYos8x2UUQc9mjaC/bU+sq0kC6PIk3wrfKR9on1XdG
 tcz2BxGTMK+Dj3+go52AS08mL72vs9sxzPh34TrmlhycNx9WzuN5eExxqQd7iwdMKx+nwS5EuY
 nw3XsCPM8F7A1KFTlWnSn6ki4Maw6cYrQTG/cId/bk4gYW/NWZx5eY1GryeCWRFT3PbvBqg78d
 eNE=
X-IronPort-AV: E=Sophos;i="5.83,240,1616428800"; d="scan'208";a="169583302"
Received: from mail-bn1nam07lp2046.outbound.protection.outlook.com (HELO
 NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 01:28:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgVsVG+NRAZOlWv+4x9zNE9cJl/f+a4bacmZGRrp+YeSAluqa/x1Nl/ta6yOZ2H37QLezBeJapEgRFV8G/2UfYZnKSKJbFKdmXgw2elgbCeE1XEQbDRIrS6bIcDIslpT9YgBrkWHoDFyH+L5P4IYrm6yuuCzyz9NF1Ka0qRLGoccYfwESIiQn4C+7QtlW6Evh0OH2LuI7jnAIMEhAfBrYv50gupnjmj7CTUVEH83oeOs9uMSYSlTDJH6lJjuDqoZjnNpDBq6MgSFLElVZnId97ClLe+4X7Ee6Y+1tExXompTZV+F7WiWuRfQAgG7i5uLxJMM+L0VP4PEbw6e3lvkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyFA6rmdpIQblCuvx4EN4nQXeAeXCK8n+b5/36JnAFA=;
 b=KP9LUrxAhkngMXwz1EtluLYwKj3yQPQWa1X9o4h4InToinuCzGBZJmeCVijY4sKUSpWy2Rru6nYDWPjepSiG2piSC7iQB1Z6CuTod+5/ETdEuJSYb7DN9Mhx77tZxFNgKGNc5+Vt1HJys3nwOpYEZDe4xhVzNdpmI9uXTwFXWpDX/h83kOW5w5J80SHvyE4w1JxZqIZyhVHheauMP2X64mqJfecCCfoTWsVf9Ob2H4km1P5syOmwUqSwnL1oouIi7lylINWBN5bZ8eS2kTWXHTKxaWMWgptt77F4qZglVjlXXcOjvxPm6q5PgSJhN28V9XnFWOiYmSIUgdMftemEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyFA6rmdpIQblCuvx4EN4nQXeAeXCK8n+b5/36JnAFA=;
 b=pK+sSPDvhMeUnp3jK9V9lFXrN8ytT60ehatsteZlMJvrKXEgjIjPGX9T+jQNe1JXoYqjBOyHEUTbRq/FBJ+n1LGVpXW7HJxkVgR0tho4fEFOqpQuQ95DyZkPM8qakjfm1arQ4tDVIqgCDHBgQHdqtoP2ucoJqLeZd2v7V1spCfE=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB4970.namprd04.prod.outlook.com (2603:10b6:5:15::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Tue, 1 Jun 2021 17:28:06 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:28:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: verify MNAN value if ANA is enabled
Thread-Topic: [PATCH] nvme: verify MNAN value if ANA is enabled
Thread-Index: AQHXVgnP5NluG1yM0Uu+5fs6wa2apA==
Date: Tue, 1 Jun 2021 17:28:05 +0000
Message-ID: <DM6PR04MB4972F39AB64A70710D8CD9CB863E9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210531103651.109426-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a38bce62-7646-4c0c-8185-08d925229e0d
x-ms-traffictypediagnostic: DM6PR04MB4970:
x-microsoft-antispam-prvs: <DM6PR04MB4970B778CBFA7165CEF58DFB863E9@DM6PR04MB4970.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwmvIFOXch/DRpFknujRVqirC4ANbW1+Z8OjfhHW10jnOab/sGY6BM3NdbBkDkNlYD+NYJ+RnJ3EPklStvbY99qguUXLHjb3TComqbwQRCA9S+pCcTBPAWQMO7urcPtF96uLc7aiJjXD2aLy9yaJe9Sprl8ofZnKcXwBZMDw4l6GcZjxfWjB1K5DWuhbsAqlQP+mJ6CxQwQvIibrmxdo/TUyGYEWVb4aV5a/QIdyhhZcmtEAQCpdy93lqky3g4VWE1AUbYSPLdyIlEWX+35SC7T4olfHTz4IZ2QD6BadgVK7q9Cc6MEdY/zg3YYrajba4KpGu4JW0ZErjoim7n6ca18PnxPUVN+ViwDoez/U3Ao4Z0ZiA/Geh685gDNuDGHAn0+SAcNorXgYEPcT0NWoius/0WTdOA157zhN2kSr7dMGAId/v4897Z2pDSndyGsn4YQPe+jCYnKG7aj2yAh6sNbLNWD8Mt9NMDBtxnL6rNIF83E6rIp6kPqPsp2HGJFA+JGjjWIY/0W1BlFEaOAuNslPzcWFDfzKRwaMhiXxVTYiF6OrO5y1voQOedBL0jf6gKQbwhFQPOtqW+jfyfViRdFhWx6cWLDNJewzIRXu7AY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(26005)(66476007)(38100700002)(64756008)(52536014)(91956017)(9686003)(83380400001)(86362001)(8676002)(66446008)(122000001)(53546011)(110136005)(5660300002)(76116006)(66946007)(4744005)(71200400001)(2906002)(478600001)(4326008)(6506007)(55016002)(316002)(7696005)(8936002)(66556008)(54906003)(33656002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Swxhjq9Q5HRDy0hNl+4k8K3qVcyjxiz3dXXJplZWw0gwpaZjqN6BFJVpP1tn?=
 =?us-ascii?Q?TMjriRpv369kzpMvsUW18fxAwAH0dZB9lkh83RnR3ryI9z693542MXMTroNs?=
 =?us-ascii?Q?cbbuvCwIZP0g4n9oGGBM0ylY1GYUXJhlmj2+sTPZ4k1Qsku3XrEqLerZbOir?=
 =?us-ascii?Q?WSE8VBql2Gmluja/SU81OhiPqUoAoJw8bkf5WSdsiKseqHfTShLSr6bHn9MB?=
 =?us-ascii?Q?7HaY4Pw2Gqd8ZiFs1NHOtGTEC9xtUJG5IQw7KjOAGBfhH8cmdusAmsveL8j/?=
 =?us-ascii?Q?YuxUMNkHjvUAJUVVJGHhe/M9lhDJEwjkvRnhWz5kWuy0i+KBKGOD6AiRAu/C?=
 =?us-ascii?Q?5nStq492dpRcKKjjStHYZpL4SuaAMPr8psY3L4K/2nU7gBD1m5wRctoWvM7i?=
 =?us-ascii?Q?2hji2ym3y6Y5MFJFToYG9C+AJzAM9stzoxr/1rTgv1B00ePoJv2kHQ8hEBL5?=
 =?us-ascii?Q?Z3S2Q+MN1OzDJbc++XS5IVg+QDTv9ndUc7TYX/87jOPgLxQ84zvotGTdwcvW?=
 =?us-ascii?Q?SjS9sQX7bJ4a1lGIe3yb55afVsydCYB85mXNnwjHzKUP0gmGEssuoqf/Z8ml?=
 =?us-ascii?Q?/79u5boy/w/OGMIB0nBQszCoKrQNSM24qBmCD1XbDOpkvFLf8gOiatl57ts/?=
 =?us-ascii?Q?fpCS5P69vFYqfWfizWcG6ijatgS2t1NV2qQiHWl/Z0vqp0o4rzl/NtFSZKzY?=
 =?us-ascii?Q?nfTdalWI/hq0QEesAhVDSGNgNvV7CeVxn4r2xCLSHiJY685IR5+qXe/M0wWZ?=
 =?us-ascii?Q?2kylwn36KZi59GEonOGxryplwKW06XLnK/qKqV8jmLJxzaQ3e71ZO5KrOMpp?=
 =?us-ascii?Q?PKq0oWWDZqO77v4aXTc7IRJlQvZa29LOesjY62qeyaeuo4LezzrNSL515c2k?=
 =?us-ascii?Q?VayUlxURPkVCDqli+hnEeVnhmTb2rFA+Q6UUvjLb5WPv562yuN70h0ZJOt01?=
 =?us-ascii?Q?hPQZ+jCzG7XUqWXUYCAiHMIJN1/w+Sq0c0I1GMnD64nxhu7LnjjpqmlA0gyA?=
 =?us-ascii?Q?QdTQvObe6ixXOlbPATLR7bL8DSErH3zKNRHoHgr412gRoTZg9qgjOaHj113D?=
 =?us-ascii?Q?0s9N94iNTHDompSJ0JzL/P8N5p/cnL5Mw1/s9riuxUUWCvn74fvBpuC1X1yi?=
 =?us-ascii?Q?nN4LdmTcOTsVOtWp6QbkvMZi0e3U9z2m35t0I73KUuuEQ7VZ6PPrwzblhlbq?=
 =?us-ascii?Q?1Svy7dgRohUmVTzORohBvQFajIyq3IghaLD7AzegfcXPkYREcIBSXz45yWw7?=
 =?us-ascii?Q?6jZTqP7py4Oi6w8RtpivTIxi3PXZsdPoYA4mXhJbsyCfJc913c82e9Vt3KJa?=
 =?us-ascii?Q?2XPxIsk/yk9ox7MXn/wdMXQY?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38bce62-7646-4c0c-8185-08d925229e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 17:28:05.9747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cv0gaIaVdeirty3mrqlOXq1i7BrrxziAloC6hu4PB5MLE7M/EQQUIi4VAahjpJCpa/oAzAP4hFZOF+mzvfH93poBMCIfbCHmNOHXQs5DZy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4970
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_102812_136713_41F4D70A 
X-CRM114-Status: GOOD (  12.16  )
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

On 5/31/21 03:43, Daniel Wagner wrote:
> The controller is required to have a non-zero MNAN value if it supports
> ANA:
>
>    If the controller supports Asymmetric Namespace Access Reporting, then
>    this field shall be set to a non-zero value that is less than or equal
>    to the NN value.
>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>


Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
