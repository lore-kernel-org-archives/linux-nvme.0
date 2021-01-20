Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA579C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 03:08:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3424D2310D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 03:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3424D2310D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=sov710OfgaRh36WWmg0lK+U/O7bSMET0Aj04ZLBg4pw=; b=Fi+VvI1t62txQMTeqO6z595uaG
	4jTQCobkqG0RikECnRGePFFhG3dWmgIUFRSQDE0Z2CPD7a+riv8DTXXBfjHUIxn/iNpbniZrnPGYK
	mB2IuDgAZ9r37bynyeffuE8ygnRur5PUxA9wcEas3nCN3Z2cXVIDFISYZLyrA9HZg1GQCgCaD3pBr
	gBWYXbf3C4x+vpdcNU0MekxPQiqY5iSWvVBOP8f8EqE5mcBuRigLx+OlXcPkTbTh1hrsPSUQ77k83
	tId1zKyqlce6QnznC+7AYkhdr4FxYrgA9zat+NP/OoseQPQjUP/ltdCvsRwYXGcreWUnOsy9qq6oA
	ezy0XuaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l23rN-00059P-VJ; Wed, 20 Jan 2021 03:08:41 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l23rJ-00058r-RN
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 03:08:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611112118; x=1642648118;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=34cDd7ukDNBPzB8/i5WW/aK/JGoTNnBEy+RjmX2jksQ=;
 b=qvQJj+l64WQxF8hzBWVxnMKGZg3B5DL25ukyebkYEZn1knwJJk+z2AMe
 XjML2zpAeS/lUlzWw7F8xEmUmZJGoLZSwqk6bps8Oq77OrhI9birYszoG
 OGotXVbhLWxvW1VNZtj6iMGyTWa9pifKTs5G0NFvDDY57m4AtfwEQ+e36
 pZ8mLot8RUeSkwUuhF5c1JJK+sgut6KqVdW6gM8oJbcEjNX1yrAtrA34R
 ZvoD2FslYoBvheFh9amjYtwZcpNrOggdukyJEYZBIQyDiNLYXR+8/iPb3
 AG1MzQ4mHt5bsHc4cIORHhQTexPqbqjhsmvoMmItS30eBeJ372t6Cq/ow g==;
IronPort-SDR: g+kwArzYmloKNFa/tYOnr3xXo6HoF3Q/XTZv0QA3RNfY6okBr2PQDD0Gs/NfGd8T9MvRLBAKm4
 1QgYWH5GsJboxNVfIRZwfXnJGXWhYyHJyKsPpmSdoR/cpft95gNyiYDFFArn8eaGEDKFDJ24TL
 YwSqvhZKVr1TYRxHITIa7GVyGPHbtdga8iVSExvbf52ZdCKBWUH7NKli/fv1hIiI7Q2bwsmPY6
 BBK6xT8B4EZ2UyXMLstHj1TDZ+03zc2/MUfREJwEQcN9V2dGt8Va/S+IEZ0KHR5vxRIYs4D5yn
 BBQ=
X-IronPort-AV: E=Sophos;i="5.79,359,1602518400"; d="scan'208";a="159035749"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2021 11:08:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxN47/vf7ak4EzzuaKAfTL/Tu+oHSg6qdOuOdaun+4iYZH4vEe+nLxx/ZzghNCvGCF7f9UhuzRthukw0sv1/Dhe+b6QiimztQHgjg8hJh/RZLepyL5oR1FyE9FhLGyjg2+75WRHThuu9NMuW50qaiWERi4MaS9+vN26kwstLE5BR6sN4ZcOtDvsQHgIrnT+74IIFQ9NqaOWZOSOi7e20gdljdiu4vwVpu0enZBC6fFbUtZCnOURWNBJeM2qATkBk6hONdr8c5w5lWCHmvbZzOXoqYITBgsoirzq53F65pKAlrTiokgv6dVCe4noLhDRDUyJCHtFre/DV5d8minynvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34cDd7ukDNBPzB8/i5WW/aK/JGoTNnBEy+RjmX2jksQ=;
 b=Ked0QuMVe+LNToKpr7udA1tOSTzGzOK0JBbzWGO50wl5s+uDwhAh69yiKTyzTvBm9+RhNKbLXMC9JbaB/s/eDy6J9k/6SaYn+GWVOfJZxd5nDxozFxtBetziBOTSFocl0tuKnjXFy+lYGKP+mxbBch12GDDZAFsuSpojlio8blMCEWrr0eEHUFewxXI+axEJp6nlD/5Lv8Elk4+krfDfpJlQ2S9hUh3BW80GreB+FdGtxo/qZA9wEYcxqC4oqfH4AE+6gJpj37A/LGT8wO7g+XP0UAYO0IUUGPFUiRvHM2uARV5H06QWcBEWYsAt2hSs7f8SSnDcItwfRkK9UM2XcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34cDd7ukDNBPzB8/i5WW/aK/JGoTNnBEy+RjmX2jksQ=;
 b=XB6zRponUJreuTUlDlP6LggOMZbGUs7MlqZ/AgEY8L7kxncKPiWC1rsDiaEhj16wREw0gknn4YYmPf5/3YQQL8rL5LlSkyJbiuum1mAtZVZvRq1sZqwxGK2XMbKTX813F9x9JA1dzJoGtkOW8OQ0RxEAJIyQvrodF22uYfnyBmQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6551.namprd04.prod.outlook.com (2603:10b6:a03:1c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 03:08:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 20 Jan 2021
 03:08:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "chapman6235@comcast.net" <chapman6235@comcast.net>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7QO5MtNnJXjl5ka4VClzrgzGFg==
Date: Wed, 20 Jan 2021 03:08:32 +0000
Message-ID: <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da8cd038-a35e-4caa-adeb-08d8bcf0ab56
x-ms-traffictypediagnostic: BY5PR04MB6551:
x-microsoft-antispam-prvs: <BY5PR04MB6551CC21F02EFB54F768B20A86A20@BY5PR04MB6551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTN3HmHqXns5qQSEhELDc0nrAhmeRUycfwoJw9hE1a+nHIYAo3EHmCKQ7hrbctEgxTUtIzUeFbjU8X0jP5YJ9PmD1RPTIaYTjvRnHqp0m5komG8lIc/7sQZYuKI7wUB6skXxFLRR0gBhk+gz4+XAYDqJJ8Sq7OWqqVYc/nKFj/n5ITLvRQV5Lik7pxVB0kyXOAoAxWs3RrnNW+5aNsKN28I5RXKfrHCVKCI/1YVW5ipY0iRVj5ugpZtUw2gQkp3LWWQHEBg02rGwga7rdrmMyA98Vfvc4JrOMcp53WZxvD1xgmPFrzZBiy+0DGxAo2rk2LX5L2RnIGr43HO6BZPSsdhECKRrTgLHIFONXgKC08RlKBSPmB1lDbKAWNsrdvMJ2ONoj9ZAT1rNkw8OcK9XH+2+F9HLY8vqN8EQsqNdATHM6XRvrycYSrV36dfYvBk+Mjod8jyN2/Nz5NvyMmgm3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(66446008)(7696005)(26005)(33656002)(110136005)(55016002)(53546011)(966005)(66946007)(478600001)(64756008)(52536014)(66556008)(2906002)(5660300002)(6506007)(66476007)(8936002)(71200400001)(86362001)(316002)(186003)(76116006)(9686003)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K/hPQa/BQk2apkY7fASuIxlmJEuCEiJ4TSRl46K+Gdlc6QAMMDIWs4VVOJYa?=
 =?us-ascii?Q?lAUFPz2ThZeo3wsb6M6szbQlsB2gKGUpnFMEaPcswYsKdVlKdlGLluV0BDiX?=
 =?us-ascii?Q?5XrSIDjUTM/LtuFZKSDwe51Ry04I19iMvF6cyCiF8QExz55PL9dhGWPL4foJ?=
 =?us-ascii?Q?N/l4IuCEQzlyhLH+Max8+JCWGTJCId5VRke8389kylmwG60uyErXg/aTkimG?=
 =?us-ascii?Q?jhfyGb7oI7h+4bDTrS7faoUv4GZC0bPZWRZucHK6WYdhqNLPhVvsy8xHhr5T?=
 =?us-ascii?Q?TcHI0fCsr0K0J7TW9NggXsJuENoxl5fS/hlX4udUtLzkzEQ/i4WzzkONLI1k?=
 =?us-ascii?Q?3iETfDKVglZk39F4//45auooTgU7TkXqX0qQtAH90pZQlUKckZilJ76afNXq?=
 =?us-ascii?Q?OXxS73c9np+HvaOOuf95SZsdZMifiSxcVBcyqhdCtrF94ohIVz9+o72NjqbD?=
 =?us-ascii?Q?i3CVqsi7u6yGSFoaGD/ZOO5DGrGxOdeSx6ZANPTKM0tJ27y6OM3DyU1Nmnsc?=
 =?us-ascii?Q?Mq/+X8BUut0lnaL7YBovCTU9IUcO/IKPoRgbR50Q890UOqc0bvebyg5tLYWH?=
 =?us-ascii?Q?XThkpCDVQaX6tMHoOAWWBiwvxqgctOqIE/qV/Gr4ye5FECRQ9FzxjUXG7k4X?=
 =?us-ascii?Q?/yIYkTGPMomqrArrQoQF5gZEaW3o+WhhBI4Q0W2MAEAQhmXhvJjpVSVpBkre?=
 =?us-ascii?Q?n8YWDjfZW2n/BtXBe7KlDUAJP9WRFi0BrDs7gWnV9mDwGM51KxrIshSlebSe?=
 =?us-ascii?Q?GYTDec1uuKXs6z9dBhwyo8f02XWZVsK+3zkx9tokwaLRfzev9F2BjnU6DwNb?=
 =?us-ascii?Q?C5QcC3wjuWmCeiWYqkVFjkaZQ+vC2VFGnAa3pRM3RY5osk8+SDfx6JyJiSmS?=
 =?us-ascii?Q?YiXRr20WCCPuPxsu+1ZUzB9gvjNWKmRJDMu0eMAI1200uzCDllRlZuAnBGUz?=
 =?us-ascii?Q?Mr5+mz3NsmQ3bvzya4pZ3+wiithnmpNrO/0dCB0EjAhX+73eV+dZnhW7Nrne?=
 =?us-ascii?Q?3va1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8cd038-a35e-4caa-adeb-08d8bcf0ab56
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 03:08:32.4649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCAdy22AL55LbjPuNCGm7IAaYX3mDk6Ru9dfxttPNFD3zmKgCnixuLWCvxLr2Jwu/muvpGr0KpdXQ5/0R7ladUP4nxuT2oyXGwg4P5HNXSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6551
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_220838_187075_F51218FE 
X-CRM114-Status: GOOD (  20.40  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/18/21 10:33 AM, Bradley Chapman wrote:
> Good afternoon!
>
> On 1/17/21 11:36 PM, Chaitanya Kulkarni wrote:
>> On 1/17/21 11:05 AM, Bradley Chapman wrote:
>>> [ 2836.554298] nvme nvme1: I/O 415 QID 3 timeout, disable controller
>>> [ 2836.672064] blk_update_request: I/O error, dev nvme1n1, sector 16350
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672072] blk_update_request: I/O error, dev nvme1n1, sector 16093
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672074] blk_update_request: I/O error, dev nvme1n1, sector 15836
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672076] blk_update_request: I/O error, dev nvme1n1, sector 15579
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672078] blk_update_request: I/O error, dev nvme1n1, sector 15322
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672080] blk_update_request: I/O error, dev nvme1n1, sector 15065
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672082] blk_update_request: I/O error, dev nvme1n1, sector 14808
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672083] blk_update_request: I/O error, dev nvme1n1, sector 14551
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672085] blk_update_request: I/O error, dev nvme1n1, sector 14294
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672087] blk_update_request: I/O error, dev nvme1n1, sector 14037
>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>> [ 2836.672121] nvme nvme1: failed to mark controller live state
>>> [ 2836.672123] nvme nvme1: Removing after probe failure status: -19
>>> [ 2836.689016] Aborting journal on device dm-0-8.
>>> [ 2836.689024] Buffer I/O error on dev dm-0, logical block 25198592,
>>> lost sync page write
>>> [ 2836.689027] JBD2: Error -5 detected when updating journal superblock
>>> for dm-0-8.
>> Without the knowledge of fs mount/format command I can only suspect that
>> super
>> block zeroing issued with write-zeroes request is translated into
>> REQ_OP_WRITE_ZEROES which controller is not able to process resulting in
>> the error. This analysis maybe wrong.
>>
>> Can you please share following details :-
>>
>> nvme id-ns /dev/nvme0n1 -H (we are interested in oncs part here)
> I ran the requested command against /dev/nvme1n1 (since /dev/nvme0n1 
> works perfectly so far) and here is the result:
Sorry my bad it suppose to be nvme id-ctrl /dev/nvme0n1 -H
>> Also for above device what is the value for the queue block write-zeroes
>>
>> parameter that is present in the
>> /sys/block/<nvmeXnY>/queue/write_zeroes_max_bytes ?
> $ cat /sys/block/nvme1n1/queue/write_zeroes_max_bytes
> 131584
So write-zeroes is configured from the setup.
>> You can also try blkdiscard -z 0 -l 1024 /dev/<nvmeXnY> to see if the
>> problem is with
>> write zeroes.
> # blkdiscard -z -l 1024 /dev/nvme1n1
> blkdiscard: /dev/nvme1n1: BLKZEROOUT ioctl failed: Device or resource busy
This is exactly what I thought, we need to add a quirk for this model
and make sure
we don't set the write-zeroes support and make blk-lib emulate the
write-zeroes.
>> Also can you please also try the latest nvme tree branch nvme-5.11 ?
>>
> Where do I get that code from? Is it already in the 5.11-rc tree or do I 
> need to look somewhere else? I checked https://github.com/linux-nvme but 
> I did not see it there.
Here is the link :-git://git.infradead.org/nvme.git
Branch 5.12.
> Brad
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
