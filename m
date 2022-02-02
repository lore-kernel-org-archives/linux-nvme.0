Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7729EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVDVk70gixMkoMjAQfyRcJo5lCWzLHQARJql54KfVvU=; b=bj2hx09Xn/P8Rb8+qPMWAm0ckV
	Lexc2PG/Xi2j+cBn45jf9a6T/Lkl3jo0iBK7S588lXG3m/Ygm1aLOPc9isXBMduGfE8mnq/IZrI7N
	JEd2+92plDFO6YZdnZeuZEB48ZsHypGNBAvRxe8B4PxwdtkLXj2WebsmeGuiYwDFTBL/Q7KCh26Ly
	1gKgM41//k+WqGXTNQI810+LmPADWOMtyLyXww+3D/YtQl2e+86XMyYEEBG/kj386lT1qrWcSUpSE
	OzEuefQEC6ejrL4naJUEDZoBSBLcg94aSSl4snSjksfCI4LYWhs2/Guy0CLzcKBRde4xCgIqujauA
	ugLz0G1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nF9Py-00EKC3-DG; Wed, 02 Feb 2022 06:47:02 +0000
Received: from mail-dm3nam07on2045.outbound.protection.outlook.com
 ([40.107.95.45] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nF9Pv-00EKBD-Fc
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 06:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7MpHx5YuI852siKyq1J6yFvAKxpIpgC/LG0FGkOhu9ZAOOOZbnmcBtcSRKJVO1eVrz5ULvJP3MfBdrThsPjoJHVkkZk6QD0yJU+FhOP5ijESbRBvuN3L/wc8Wc722gYPhvsUJqubmowFw3xx8fjeUjNgo5z6WWMsCswLIufzoQZQyLgD6ccDwjM2JvomUZCceMrZbivao80SeCHtcPa8PkX7n3pDLxMQUQA/XFq3oX7JESri/uWf0h9eDtNSNbbi7WiQUdDclXuYzNGZsDoFavORyTNsjoxg/X5UeqPIC5efvS43nZ2lYre9Io5+ovlcYTnGlOEpQkR2H3YWMSP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVDVk70gixMkoMjAQfyRcJo5lCWzLHQARJql54KfVvU=;
 b=bEXoFgzgfaNo/oaWDQRAtn9daE2ZF2OQLW/xO+gLsf2S8xyxXhYV97EW1b9e4Oe34kamjt+CAobUbT9aL3ZnhNzMAoB1DZpeqWFeWx/cj0VmhB23gzh+hEA5spY95yTDyGUBlyd7CUsrkBg7iN3IYgoClyIxZZyNvJn4FHg+FsvhEspEJYwlRJ9ibixl7Arz+QA1x+qyUyPWCJiyYndgaOkCKQlBn6GivcCxlLUNbz9k8hNh5JFHAMZTHzxOVRSOvtMlndUObgt2Sr9N9JdSr9t5tORvtggcvJpvdMJw92Aj4NpZY/WiJRQpQGaqBebIwA8ylxrsJ78TQn2lwxrAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVDVk70gixMkoMjAQfyRcJo5lCWzLHQARJql54KfVvU=;
 b=OfWDXpY8e7hvzGEVMpqyPPTeM2W3LJ1jBJDGFYVSWqc1R90p73hSHpR/tfWt+sam6V8xm2OJJFRj0uHm0I0BWusfZ1pA8FiVYuHyXsVcob9Taz40ChxtlgPYVY0KzhkfoBxYriFnVuEZSq9UvvKj5fcZ50tccL+lhdY/yqLDeBGbVNK21TyHlIsCeK3vL4NguMdH6TxDdcMQAZ05DTPuVecs7l3kSLTPAYLNTcELrU5r3ZsDe5pnB0q4BV5Tk1PPG7TXkk6PHwO6vd7CzC+2OBrfDXFTA96I0/OI/E6FN37vj0BREdE4XZH3SxzDD7mxpCUHoGN4c7E5EBNlNXNZQQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 06:46:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 06:46:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Thread-Topic: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Thread-Index: AQHYFCh95lgiCCmEvUGD5FramLij8qx+XjGAgAF604A=
Date: Wed, 2 Feb 2022 06:46:55 +0000
Message-ID: <80f3de76-a3c7-f15c-200c-df55c3c2d0bd@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-6-chaitanyak@nvidia.com>
 <20220201081103.GB29769@lst.de>
In-Reply-To: <20220201081103.GB29769@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f51dc1b-131f-4d7f-a07a-08d9e617cdc5
x-ms-traffictypediagnostic: BY5PR12MB3730:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3730FB1430CAD23BAED7A3BAA3279@BY5PR12MB3730.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LaBEPpvoTI3yk7KiwVXzpJ5i3D0V0rah1DtL/lvdTCKGyT/aDKPl1UBHcF387mcWA2T1KqaPDSEbMmyLoBVQkam5lsQgE3pHGDWMFhM1nNg81Cgsc3MQdmM8b+rspnOFJBOsCOXMbzX9RGCiv2KBGaOZwqI4Ozz6odo8W/4wLVSZzpfntWapVQmtJo3yX3b1Hwugnldv5zm4f500et/xKN6Y3XsT1FL2VdgzgGR/W1ygriE0BEWPAVu0XWOan1HXCjrx9uryAZKlqC4XDTGNgKJl/Dz7eJSvaM6z8IinkSSAQ/lqCe+bGl5wQ/ynMOGnNTSnqu5Xf6Hs+TfzopVxplezX/HvvAKz4WbVYb4xemnbqPJ90uoPV25oiznQxvDYi6zWD9kxwPTEPw9IpAuMeNSx8w4HCe+lRSAVLU0RJT3nd/vZY9stwQhAbUabnHflZnwZpFI0cMY1e5fc5vtRhIUrdP1dQRkgsVLYVdBYHK7+CgfBh67F29tAn6nnXuphWpwmiNUECzCjnVBR/xwabzt9KNrP+zll3+vfeLejRP/OWey/cfoKqjToa5OUmIhGahowONEGQz6rQfPrur5QQ+pqkWcX0Qv8a5EqOSAeNb0CzfcRh/BWcLCfyZTqrzk4tLiyCqb0x2TqSpwNOZBcmRJFrRlI3b6SSm0QlDdiyEwM5yNR6N8YFnL45bc3s074L8o2iCUa4XxI45Q9Q9fVZAfkhK+FSFx96USj/taC2CHaE6HgyPMdtTAWhn6JKQAmOGTWJCQ/R4T2nIYiYnd4HQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4744005)(38100700002)(38070700005)(64756008)(66946007)(66556008)(66476007)(8676002)(8936002)(66446008)(76116006)(2906002)(54906003)(6506007)(53546011)(122000001)(508600001)(6512007)(6486002)(6916009)(316002)(31696002)(86362001)(2616005)(107886003)(186003)(71200400001)(4326008)(91956017)(36756003)(31686004)(5660300002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzBINVFiL2VFUUVUSTVMWVJrWWRJeHJKd3RCby9taGZOSnlnaktpdys0dkRv?=
 =?utf-8?B?TGNKLzlqTk5MRVRxbFJoZ29FcmFYRUt0V2I4ZjJlWXUwc2dRU2pSZ0k3d0Zj?=
 =?utf-8?B?d1FvSlVYRkhRSnBqRXFSblpNaUxpOE9FT0tVV0F0RVZXYWphTW9qR3R6Lytn?=
 =?utf-8?B?VnlHVVNnQjloUjFIVDkvWk5lNmNtVFlIUHg4eEhvclFEV25wSmh3aG4rY0Fn?=
 =?utf-8?B?ekxZRTUvS3YvUUtFREZ3VlJ4ZHRaS2JHMzRHV0RLRXhsRktlaFRpVWtNdGhz?=
 =?utf-8?B?cUxRRGxTaU8vZWNEY0ViMCtPV1Z5TkNUT0pPNENPVW5YdytEY05oRHJPenRz?=
 =?utf-8?B?S2xBMVVzMmlQU01Ba21tZmMxdEM1OGxub3BHTi9uZU12dERDYkE3MmpPeFZG?=
 =?utf-8?B?WnkxRE1sQVBRVEhDZjlDZk85YmxPVVRaYzJFTFRpcUV5OG5xSUpKS2J0QlZ5?=
 =?utf-8?B?VGJaUGZwK25TSFRJYkNSeVg2OXZtcmhPT29VTkZxTmh3c3llbEI1M1RmL1N5?=
 =?utf-8?B?R3cyYS9yWTRXL2h6dktZOTlneVUvdWphajJLYUk4NzlVS0Urb0drZnVZbUNT?=
 =?utf-8?B?ZkFUTHVITjNaSWtyZk5TVHhsdDVOK2RNbkVYdzZOS0xKY0hlRlRKK0dXNHZB?=
 =?utf-8?B?S1dwc2Y3cm8xMjl5ZnhEYVlWRUs4Z0RJaVdoRmNoVEt0Y0JnbnNNRytXd0Qw?=
 =?utf-8?B?VTVhLzZtK28wcytLVXFQNGpjaTRnS3p0WERVaVRBR1FOYWFCSW05MkcwQ2RH?=
 =?utf-8?B?b096dXpjT3J1SEZTeDlkNHpnbjdjeEJtRnNyeDA3amMvVWxWYnFZVHAxbzlJ?=
 =?utf-8?B?OUhDNE1SN2VsRmVhdFNsNlNMOEdMY2VDdUVTdWZPM295bG1HSFpaV0xZcEhO?=
 =?utf-8?B?MlFEUWo2ZDZNUWVDL0pjUTdhREVncmZBN29NWTJqcGJIMW9nbnJHTHZlbFU0?=
 =?utf-8?B?QWZLVUhWaW00WDd0dDA5czVJbTlKN0JCWHpxTEJseWVEZFdEVDdQTG9tSm1o?=
 =?utf-8?B?TFR4RjArSGVYSzBmMUpydGFoQWZQZXR1dFBMeFlKVi9qMGhvR0QyNkdRYXlI?=
 =?utf-8?B?VElBcXJsd1VGaTRRR0VzZjRaWjFpWTdpanQ3di91b0w4V1JKR0tjaTMvTGhn?=
 =?utf-8?B?eTB2YnRPTzdiRStPMk41QVBDTnRvKzBLd211VFhyUllaUUZRWG1ZWmxFUVlv?=
 =?utf-8?B?UFVCWndpeUNLTzFRQ09HdnBwQWpJVDQ0ZjdZTUR6azVEUVpxTjNFdXlTbU5z?=
 =?utf-8?B?WVVBanhEc3A1bTNuVHdCSUVKalEvV21oVFR5SU5hekFNY1BiUWIycFVBVklk?=
 =?utf-8?B?ckVOL2g5V1dDdCtRSEo0eGp1V3F6dGc0MjdHSDdRU2l1SlRoNjR3aEpPdzBl?=
 =?utf-8?B?aDJVQWtyT1JDTXB4U0hhS004NzI3UzRVMVR3WWp5clRGVUVYZXBpcXk4VE8w?=
 =?utf-8?B?dUxsM2tmU3I0K0MrVXVKSXNaTWtyc2RaUDEwOUtQWXZkSGQ4aEY2Q1Buc3dJ?=
 =?utf-8?B?YU84TXVhN3g3NG5mRXZ5WTB0b1g5eldRd2JqL1N3aUdEWHF3emMwdVFqY29h?=
 =?utf-8?B?Mm5FcHFoMkNSRTJBdzBySGF2ZkRFYnhyeW1pL0FXSGcwSnU2cEtJK010dFZC?=
 =?utf-8?B?eW5lMHNTNFczKzRQS3NwaXowaWNCdGp2MWJkcXZ3YmhRRzJZYVRQTno3L0N3?=
 =?utf-8?B?UkpMcHFVdmdnUlQrY00xV2QvbzVTVmd6OXAxMUxIU09FY2FNR1NObENFbkZK?=
 =?utf-8?B?OTdsbk9sbTFIbGJYMjkxYzdZOTFuTElpWTgxclhsK0tOL2tTWXR4NHYraXYx?=
 =?utf-8?B?WW91M2tkQWNWWEprTzNmOEt4MEo0L1RSeXMwVU9XU2JmUGJPSWxPQWt0am1F?=
 =?utf-8?B?ZzVKOE5mNkQ0UEV1QTIyMTA1RXFKeEp0K1ZscFEvRmpYQUR6RHZnODNKR2NG?=
 =?utf-8?B?NlhQYURwM2d4ejh5ZjJ6WVNHclV3TmswMTZvNWdhMjVPcWYrcmdaRjhRakNH?=
 =?utf-8?B?VW9ydGtOaDlEMzNOZDB0WGJWalNXYVg5b2xVZEQwUUFPdStsRVdnYW5GWElT?=
 =?utf-8?B?cEdHK0VkZWtNL3Y1Zm1YM2h6UW5lYW9TbUFSOFduemhDRS9oUWtzSnZ4NEQ4?=
 =?utf-8?B?SDBSdGcxUUN1QjIwaUNWTThsSnJPVS95RXBDZTRmcExrMnZ2YzBkbUdocFIy?=
 =?utf-8?Q?7ah4PaZjRdOzvvezonx17NWUA0K5pFB1rxuqLeKkb+l+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7AAB28005F799438B6BAFE61AE61EA9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f51dc1b-131f-4d7f-a07a-08d9e617cdc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 06:46:55.9459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1Zx5Fz3fC5SNtnl/nixHh44bbUy6n1FHfdFxWzyxF2TpDaB6ErRs+BOWO+A40GiGTSniii86P+xP9Squ10xKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_224659_572238_996CD273 
X-CRM114-Status: GOOD (  16.85  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xLzIyIDEyOjExIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBPbiBGcmksIEphbiAyOCwgMjAyMiBhdCAwMToyMDoxMUFNIC0wODAwLCBDaGFpdGFueWEgS3Vs
a2Fybmkgd3JvdGU6DQo+PiArICAgICBudm1lX2luaXRfYWRtaW5fdGFnc2V0KCYoY3RybC0+YWRt
aW5fdGFnX3NldCksIGN0cmwsDQo+IA0KPiBObyBuZWVkIGZvciB0aGUgYnJhY2VzZXMuDQo+IA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHJsLT5jdHJsLm51bWFfbm9kZSwgJm52
bWVfZmNfYWRtaW5fbXFfb3BzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBCTEtf
TVFfRl9OT19TQ0hFRCwgTlZNRl9SRVNFUlZFRF9UQUdTKTsNCj4gDQo+IEJ1dCBkbyB3ZSBuZWVk
IGFsbCB0aGVzZSBhcmdzPyAgV2Ugc2hvdWxkIG1vdmUgdGhlIGFkbWluX3RhZ19zZXJ0IHRvIHRo
ZQ0KPiBnZW5lcmljIG52bWVfY3RybCBhbmQganVzdCBwYXNzIHRoYXQgYW5kIHRoZSBvcHMuICBF
dmVyeXRoaW5nIGVsc2UNCj4gc2hvdWxkIGJlIHNhbWUgKEkgaG9wZSBpdCBjdXJyZW50bHkgaXMs
IG90aGVyd2lzZSB3ZSBuZWVkIHRvIGZpeCkgb3INCj4gZWFzaWx5IGRlcml2YWJsZSAoZS5nLiB0
aGUgY2hlY2sgaWYgaXQgaXMgZmFicmljcykuDQo+IA0KPiBUaGVuIG12ZSB0aGUgaGVscGVyIG91
dCBvZiBsaW5lIHBsZWFzZSBhbmQgY29udmVydCBhbGwgY2FsbGVycyBpbiBvbmUNCj4gcGF0Y2gu
DQo+IA0KDQpPa2F5LCB3aWxsIHNlbmQgb3V0IHYyIHdpdGggYWJvdmUgY29tbWVudHMuDQo=

