Return-Path: <SRS0=bb4v=IL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D4EC433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Mar 2021 02:41:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB2F64F83
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Mar 2021 02:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB2F64F83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nF2SI30vD1rpEs90LHOWz65L9WW6gG1Ey03g1uZxGCw=; b=E17f2xdD7dRcnXa3eYSsrkMuf
	MeMMeZOf7LfiYnbEpp8Lo/qCBgl3xDUi7Q/aErv0XJbcgsqA6Q/no+F2Vbstf5xOWMAeFwSvA/i4Q
	WQHEPWH47dPs1HBFSTwttpsa7lHcrc5rSdZRKzKY4SrVBJWWajYGyXux7CrCSBu5oq6Q9JVvCImsl
	nSsstKX2DWDE39AQlWBo0Hbz/eWDtLdJUeVRG8HVQ3yy4OC7haDP6Ht7WgqVLBYnz2A9AMgkINgsB
	RSHR/rtQPENP9jcusnUrKGq8lybCBydD4Kmnu0DOrReTQem6WLJY1+DU4w6hT3eD9ha5em0L5+HMr
	VcNdxJSyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKuDR-00Cj3K-EC; Sat, 13 Mar 2021 02:41:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKuDE-00Cj1Z-6u
 for linux-nvme@lists.infradead.org; Sat, 13 Mar 2021 02:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615603270; x=1647139270;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=1CcSuVB+gskPWCqQzgiZ07zjbYYyUNb1D7J69RRQ+A8=;
 b=DTRjV6U+Ob+3+Q0RPaS4crlbFY2AH/9ZzYSSHohZ046bPqEvxW38jxX/
 sdPg9cg/G5Mgt+DD4RMHIBYJvfNYBqSLRhCPy6QtotAHsgIOMjzkZDd9+
 uBLElzX73fRU3K6BV7V9ia82mZbxzLCKnoGM5SpNLvs4Pk7bu6um/rhyv
 H8gR9jmfKezhVaN0SzGqqgdDf7KJuWLYrjhh8XiTo7lRPTcamVwP/TKhl
 SU+lKbuwSMxVgf2r+EA/BlIruK5sLN0SlT7JWC4IIv/w46B9dZtnAHZ43
 oUlQFXNBoQpYSwO5CO+mrbusP0lFoaz05+Jlxi3colhESMigl/KdAyMuz Q==;
IronPort-SDR: /lXfX6QzeyjzydjCNT1ZqtNAffX8W0/StN5owxXmUfKb4qymbWOkDtogmNKUiNIpCQjy+OzaDp
 2xgr2mKMwoCgpiUgAprxVz/r/mfQMey5fZichnbGcHNUFUw/ecW8vfW656hVCJdja+bUWUmKR/
 eH+GvxuoXM5HilGV/p1XlFhxP2kJXV/bUey0YUx/+iqVhOaB4FudOie2R/vqWXapVSpGOFJeth
 r11w7vM8YmQvicB/ldY4FNX3iMEEZOQq+qhI/utVXJkcVGnwUgvPiRypANUuuVoyMyKQ35YSJM
 6Dg=
X-IronPort-AV: E=Sophos;i="5.81,245,1610380800"; d="scan'208";a="266408665"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2021 10:41:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsQiEY0EuYI+n57m2x6BLtpYLwPVkSJQ7tDsSscB5RXZmuw6D6wqeX5yeriYq1JkdW2hTjrk8ahVocessZb3B11lR/lntgLkaJodXpBGkAmclGF/09zlPLmCmtgtpOc5yJsxPlIecDdKja38Ufu8jz5HUYXSwD5BCsBs0fTGYdPsyV6qfvotEQ/jzS0jablJwSdnW4VKFeg9s+Z6LS4bdwwxxl2c3kmkAM8P/5QzG9FBDfx4rv29GibhCB0zK9Z7+sOapDSembiJoXBEO7uUamayV2rew/tolLEx+FVRLl5RV/pu4EQEarqxI+HWMCMBqhAWd+OFHNivVeWzxjnljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4M2/qSN7q1w8Z1CSs9Cfqb0Y+n9SQRzCq5qFq2YheQ=;
 b=Gm2bYLx4ecosXuhX+55ExoQJxSBuEqeOTdRsGDzRKffXuL0KDR1EQuEnUu0AnoQz5FCthP/dnHlMpikykToQKgK1/bsn/VnB/epaEevCSWHFDyW9ry42NP/N3JtZllFspKDSXlMFf0yRcl/Ywhhfal/GMlfL5EfkcH4E4sxm218WEIojBlcFI4ivbU9PSX2PhBdtZPCJx1VtHvZgUw1KnFPNXkKIvTzs4ISdcXjt8rLMaSzhATo587f+zueTUqArxouI7RjWxP+NXODwm7cpcijwf3NnlRHJduC8CeLpo0VW5RcqU/XtqMrFP1PuB+ZT5+zRc5gh4Pr6ZWplwPTn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4M2/qSN7q1w8Z1CSs9Cfqb0Y+n9SQRzCq5qFq2YheQ=;
 b=KSP/zgNDpBI9WMoZHSN32iWREYKvbrG1THriW8jkGZswZ85qeqlCVeBxXeCPiSN3n2kze267ptDZYeBaIV8h9XaIqEu5o5E/MfFqxTANOIP9iOiUmdlthTvocdP5sS9WLaROAhZ6OTBYsc6huGK2WgQxqpWMlh1+DO8J5BXo958=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7693.namprd04.prod.outlook.com (2603:10b6:a03:32b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 02:40:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.042; Sat, 13 Mar 2021
 02:40:59 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFkZtzlyRTj6MdkG4iVwqsOEFzw==
Date: Sat, 13 Mar 2021 02:40:59 +0000
Message-ID: <BYAPR04MB4965BE436BDFBA0BAEC43C61866E9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
 <20210311071530.18680-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B749F68EB412FEC032DDE76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49657E04A5017F5C31D4EFE1866F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BL0PR04MB6514F4EC40A62AB4763560E8E76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b22c1feb-640f-470b-dd5c-08d8e5c96fa9
x-ms-traffictypediagnostic: SJ0PR04MB7693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB76935ADED369E1F92E8BF698866E9@SJ0PR04MB7693.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BiAEsfxKRNd0wIRtV2T39mEnKHZryjRprWYDNCrYa4GmhDokIH7cYtKdKCP5Kk7FcGqZ56TD9IS6r89I3jYc47I5Hf6bINSE1wxMbT7Dz0GbFU6Gn407d3O+lTBSuIKM3wO59ftoyz7zOHnxgI6nf/t1fkAdQbPZ+4aNdlJBGGBIP6cqhH8X/J8mHCpqfCTAgRGEQD+ojYcpyy3MrPKpyl6mVl+Glg/4LNEV4f/HrN5/8cLEVbic2GDgT+GNpmIqkRwa12UqjZdbxkZ5cIZ0rSzW1ZpCWZV+HfO0SKdt28eRLwB3bl/1uMMXHbNcZk5qNFmvqVvllW4X0JKDvWsXSSiWqnkioao49yXCcf7FdD0dWAYRocEJ9WaQHzt8grpZBAYiMgTII46Sdxx+SyTq5Sjvu3qprIQ/1iIISFLrg95VSGUbuDyUpkzSPCBSzldWu7xvuKBr6kbtfBJD+uM6d6UBmt+AF9PMWmERPp7JHLgN2fycwdhK1DAH0wM5kUd4DjFEoI48D+1b8owkyeI4CG18Lp/A277EtN3vrOGSZIPDqU1bUxt5qMWUk7O1XzpV5WwFYQWjHmaDX6Ltwxx44JyJMi0awshDmliPvT8v90=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(52536014)(64756008)(6506007)(66946007)(66446008)(186003)(71200400001)(53546011)(5660300002)(110136005)(86362001)(76116006)(7696005)(66556008)(66476007)(8676002)(8936002)(33656002)(478600001)(91956017)(9686003)(316002)(26005)(2906002)(83380400001)(54906003)(55016002)(4326008)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FPpP1GHcPX4kPNykf8rJxzIHJuMQhDy7GPlVt8M9SnI3Kkqf9TyVrwmOfJts?=
 =?us-ascii?Q?7UD5um0y97UGR/1+DZFH9YwU1Pfy6TPbfGll0aZLrlFXa5JoAty02ualrcsL?=
 =?us-ascii?Q?7WPksdzgvcHb9psayNB4ZOOrSG0x4WuzseBjE1w63hZIr/yfBHJBKUZtYfWv?=
 =?us-ascii?Q?2ttkHFTfC24BfXWE7gLyjc3PygGNrDluhc1gKf7ilq0EzFNQ7kV9cr31xDm7?=
 =?us-ascii?Q?C394KFGJi5TLBk9KjZXEIFwJ/RHGwJz+N1sUI+1Uut6VrFQ/honQsHYzquvo?=
 =?us-ascii?Q?qcc346TxO0fSPj6E5tA0pSuqpn2sAPvYs5/2jn36fQFXOpkZxAc63OBMfrFL?=
 =?us-ascii?Q?5zYrtmu+qsbGsjYxcx25CiZlEumaOFv6kVUHde0Pjeb+GJplXKutM47TqV8o?=
 =?us-ascii?Q?eINdZ0aT23uJREWUnZ0BpAiL1Xf49fsJuMajg17ceQ537t/ENnS5mOda5zEh?=
 =?us-ascii?Q?EpZ7XrH7q32MC1oXLLJ3KV/K/lVzY6VDzvUff9yyHIbv49ABZOWYz4iZcJ7S?=
 =?us-ascii?Q?YEdGJCIoEcFEZT6wzeGStRKhc7nouSelkaSpv+uF/ins6Dm4J5km7yBEnjir?=
 =?us-ascii?Q?Brt4rNNQOcaesCUROKpENH2azO10O3x198SP4MkFGzPF1WGpmgYocj2c2dLm?=
 =?us-ascii?Q?xJeL9cVm2ncazLuC7gcrFygGV8TgMgVNpO+xp5Dcz+25Q+y3eWcsdWSoiJIE?=
 =?us-ascii?Q?OmLN2PE0RlVyD5GT4cOxNEIQbqFx5HBR+/NCP7JMSBp2Zs7aULatY1xgXH+5?=
 =?us-ascii?Q?N/0EgVwJfx7o2F86U2PPCCz3dDJVApMkaa7wN1xCSsvbIvJIO82PYgpjABez?=
 =?us-ascii?Q?63CuwaKEW/PKUbbDrvWIhl1H60ZvGJp6yFCvAa+1hqLL2KRoIRmXWgyQNo0q?=
 =?us-ascii?Q?122rLwm4SuKiSTt5FFpHo7DsumVv1LkyomhAnJXaxhMzvLJsIkcEpm+56gr1?=
 =?us-ascii?Q?fvoIYXWa6tvzCBnH56xitiJZw6/eu0flRDChhjnTeC11tic0i9kgW+Ps/NVT?=
 =?us-ascii?Q?djQgBDTxEFLdp+DqbzycD4Va/6sgV5YnjRrdiadcQJwVluBm2+gc2UM6Hj2H?=
 =?us-ascii?Q?isUdR9Z6LJ+1N4VoQQ9HqkpWeacKfYK9InaC9yWL2wlFILgOPtBObIJfPZgH?=
 =?us-ascii?Q?A8BROF2IOgsJX8tvom4dc6y/MV4r5rM0W1eSQhvEiv9vxsjjyXcWRb1AhmP0?=
 =?us-ascii?Q?UowObSoq0I7JfIrQDdKDADgh8wcxyo4cwFJvVni5s1ZVZOwWwfyYrVSBz26+?=
 =?us-ascii?Q?YXNa3ChQjSeHD5XxOVNipQh7o6ZZnS8QrzAG0GBQkX2adb2yZw60ktpWuyOE?=
 =?us-ascii?Q?8fnqanref0/HhADx/1A5RdzS?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22c1feb-640f-470b-dd5c-08d8e5c96fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2021 02:40:59.4357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqgbzZpcH2IMtoJwwkfKZf3g7wznDxm9na9eb98tnoE9VtC/SDtbfCXKI9BdrnzJqwzPwaHSyJQwCfCqmPTu4fwAIUK/Y+7RXtiUMdm/l/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7693
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210313_024109_180258_00590FDC 
X-CRM114-Status: GOOD (  24.72  )
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

On 3/11/21 23:26, Damien Le Moal wrote:
> On 2021/03/12 15:29, Chaitanya Kulkarni wrote:
> [...]
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>>> +{
>>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>>> +	unsigned int nr_zones;
>>>> +	int reported_zones;
>>>> +	u16 status;
>>>> +
>>>> +	status = nvmet_bdev_zns_checks(req);
>>>> +	if (status)
>>>> +		goto out;
>>>> +
>>>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
>>>> +	if (!data.rz) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>>> +			sizeof(struct nvme_zone_descriptor);
>>>> +	if (!nr_zones) {
>>>> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>>> +		goto out_free_report_zones;
>>>> +	}
>>>> +
>>>> +	reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>>>> +					     nvmet_bdev_report_zone_cb, &data);
>>>> +	if (reported_zones < 0) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto out_free_report_zones;
>>>> +	}
>>> There is a problem here: the code as is ignores the request reporting option
>>> field which can lead to an invalid zone report being returned. I think you need
>>> to modify nvmet_bdev_report_zone_cb() to look at the reporting option field
>>> passed by the initiator and filter the zone report since blkdev_report_zones()
>>> does not handle that argument.
>> The reporting options are set by the host statistically in
>> nvme_ns_report_zones()
>> arefrom:-  nvme_ns_report_zones()
>>          c.zmr.zra = NVME_ZRA_ZONE_REPORT;
>>          c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>>          c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>>
>> All the above values are validated in the nvmet_bdev_zns_checks() helper
>> called from nvmet_bdev_execute_zone_mgmt_recv() before we allocate the
>> report zone buffer.
>>
>> 1. c.zmr.zra indicates the action which Reports zone descriptor entries
>>    through the Report Zones data structure.
>>
>>    We validate this value is been set to NVME_ZRA_ZONE_REPORT in the
>>    nvmet_bdev_zns_chceks(). We are calling report zone after checking
>>    zone receive action it NVME_ZRA_ZONE_REPORT so not filtering is needed
>>    in the nvmet_bdev_report_zone_cb().
>>
>> 2. c.zmr.zrasf indicates the action specific field which is set to
>>    NVME_ZRASF_ZONE_REPORT_ALL.
>>
>>    We validate this value is been set to NVME_ZRASF_ZONE_REPORT_ALL in the
>>    nvmet_bdev_zns_chceks(). Since host wants all the zones we don't need to
>>    filter any zone states in the nvmet_bdev_report_zone_cb().
>>
>> 3. c.zmr.pr is set to NVME_REPORT_ZONE_PARTIAL which value = 1 i.e value in
>>    the Report Zone data structure Number of Zones field indicates the
>> number of
>>    fully transferred zone descriptors in the data buffer, which we set from
>>    return value of the blkdev_report_zones() :-
>>   
>>
>>    reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>> 					     nvmet_bdev_report_zone_cb, &data);
>> <snip>   data.rz->nr_zones = cpu_to_le64(reported_zones);
>>
>>    So no filtering is needed in nvmet_bdev_report_zone_cb() for c.zmr.pr.
>>
>> Can you please explain what filtering is missing in the current code ?
>>
>> Maybe I'm looking into an old spec.
> report zones command has the reporting options (ro) field (bits 15:08 of dword
> 13) where the user can specify the following values:
>
> Value Description
> 0h List all zones.
> 1h List the zones in the ZSE:Empty state.
> 2h List the zones in the ZSIO:Implicitly Opened state.
> 3h List the zones in the ZSEO:Explicitly Opened state.
> 4h List the zones in the ZSC:Closed state.
> 5h List the zones in the ZSF:Full state.
> 6h List the zones in the ZSRO:Read Only state.
> 7h List the zones in the ZSO:Offline state.
>
> to filter the zone report based on zone condition. blkdev_report_zones() will
> always to a "list all zones", that is, ro == 0h.
>
> But on the initiator side, if the client issue a report zones command through an
> ioctl (passthrough/direct access not suing the block layer BLKREPORTZONES
> ioctl), it may specify a different value for the ro field. Processing that
> command using blkdev_report_zones() like you are doing here without any
> additional filtering will give an incorrect report. Filtering based on the user
> specified ro field needs to be added in nvmet_bdev_report_zone_cb().
>
> The current code here is fine of the initiator/client side uses the block layer
> and execute all report zones through blkdev_report_zones(). But things will
> break if the client starts doing passthrough commands using nvme ioctl. No ?

Okay, so I'm using the right spec. With your explanation it needs a
filtering,
will add it to the next version.

>>>> +
>>>> +	data.rz->nr_zones = cpu_to_le64(reported_zones);
>>>> +
>>>> +	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
>>>> +
>>>> +out_free_report_zones:
>>>> +	kvfree(data.rz);
>>>> +out:
>>>> +	nvmet_req_complete(req, status);
>>>> +}
>>>> +
>>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>>> +{
>>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
>>>> +	sector_t nr_sect = bdev_zone_sectors(req->ns->bdev);
>>>> +	u16 status = NVME_SC_SUCCESS;
>>>> +	u8 zsa = req->cmd->zms.zsa;
>>>> +	enum req_opf op;
>>>> +	int ret;
>>>> +	const unsigned int zsa_to_op[] = {
>>>> +		[NVME_ZONE_OPEN]	= REQ_OP_ZONE_OPEN,
>>>> +		[NVME_ZONE_CLOSE]	= REQ_OP_ZONE_CLOSE,
>>>> +		[NVME_ZONE_FINISH]	= REQ_OP_ZONE_FINISH,
>>>> +		[NVME_ZONE_RESET]	= REQ_OP_ZONE_RESET,
>>>> +	};
>>>> +
>>>> +	if (zsa > ARRAY_SIZE(zsa_to_op) || !zsa_to_op[zsa]) {
>>> What is the point of the "!zsa_to_op[zsa]I see, I'll add the async I/O interface." here ? All the REQ_OP_ZONE_XXX are
>>> non 0, always...
>> Well this is just making sure that we receive the right action since sparse
>> array will return 0 for any other values than listed above having
>> !zsa_to_op[zsa] check we can return an error.
> But zsa is unsigned and you check it against the array size. So it can only be
> within 0 and array size - 1. That is enough... I really do not see the point of
> clutering the condition with something that is always true...

Okay.

>
> [...]
>>>> +
>>>> +	ret = blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL);
>>>> +	if (ret)
>>>> +		status = NVME_SC_INTERNAL;
>>>> +out:
>>>> +	nvmet_req_complete(req, status);
>>>> +}
>>>> +
>>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>>> +{
>>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>>>> +	u16 status = NVME_SC_SUCCESS;
>>>> +	unsigned int total_len = 0;
>>>> +	struct scatterlist *sg;
>>>> +	int ret = 0, sg_cnt;
>>>> +	struct bio *bio;
>>>> +
>>>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>>>> +		return;
>>> No nvmet_req_complete() call ? Is that done in nvmet_check_transfer_len() ?
>> Yes it does, you had the same comment on earlier version, it can be
>> confusing
>> that is why I proposed a helper for check transfer len and !req->sg_cnt
>> check,
>> but we don't want that helper.
> Just add a comment saying that nvmet_check_transfer_len() calls
> nvmet_req_complete(). That will help people like me with a short memory span :)

Okay.

>>>> +
>>>> +	if (!req->sg_cnt) {
>>>> +		nvmet_req_complete(req, 0);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>>>> +		bio = &req->b.inline_bio;
>>>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>>>> +	} else {
>>>> +		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
>>>> +	}
>>>> +
>>>> +	bio_set_dev(bio, req->ns->bdev);
>>>> +	bio->bi_iter.bi_sector = sect;
>>>> +	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>>>> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
>>>> +		bio->bi_opf |= REQ_FUA;
>>>> +
>>>> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
>>>> +		struct page *p = sg_page(sg);
>>>> +		unsigned int l = sg->length;
>>>> +		unsigned int o = sg->offset;
>>>> +
>>>> +		ret = bio_add_zone_append_page(bio, p, l, o);
>>>> +		if (ret != sg->length) {
>>>> +			status = NVME_SC_INTERNAL;
>>>> +			goto out_bio_put;
>>>> +		}
>>>> +
>>>> +		total_len += sg->length;
>>>> +	}
>>>> +
>>>> +	if (total_len != nvmet_rw_data_len(req)) {
>>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>>> +		goto out_bio_put;
>>>> +	}
>>>> +
>>>> +	ret = submit_bio_wait(bio);
>>> submit_bio_wait() ? Why blocking here ? That would be bad for performance. Is it
>>> mandatory to block here ? The result handling could be done in the bio_end
>>> callback no ?
>> I did initially, but zonefs uses sync I/O, I'm not sure about the btrfs,
>> if it does
>> please let me know I'll make it async.
>>
>> If there is no async caller in the kernel for REQ_OP_ZONE_APPEND
>> shouldwe make this async ?
> This should not depend on what the user does, at all.
> Yes, for now zonefs only uses zone append for sync write() calls. But I intend
> to have zone append used for async writes too. And in btrfs, append writes are
> used for all data IOs, sync or async. That is on the initiator side anyway. The
> target side should not assume any special behavior of the initiator. So if there
> is no technical reasons to prevent async append writes execution, I would rather
> have all of them processed with async BIOs execution, similar to regular write BIOs.

Thanks for the explanation, I was not aware about the async interface.
I'll make it async.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
