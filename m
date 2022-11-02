Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A35DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ECRNsFA0WB38ovTgaF7ns551q1vlEraCdrg/2HMZcA=; b=bRH8HCoJurtjyQ2K+NiepVNMVw
	mxQEaXHqjWlg22cZnhDcjcdVl4xIeqmon5tH34NDoSO8j6Uw6qFZFfkXPJrTysIDOTo1tJqOQ7p+R
	RXRkiZ1cY/seRg/MmKdkrsDyHyVeBdfyLqO2tVKDpY/+Ogqqolv2nxbB8aR/dxn4a6SldNkbN7EM1
	WMI3e+8bsLOhwRJhd1tNQnD1VZlAH/6IGbQKT24ECc2GE6VjPueG9/TprzjLd/p4d1z5jHJf7TqIL
	Id0weZyQBjG3rkFWcOATuNsAtVoGYTVGW/USUS15+wsxzxLR5khAYiKFNNj1jITJbyPYMba6/tjMJ
	WS4QK54A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqIQL-00CzyD-RN; Wed, 02 Nov 2022 18:25:13 +0000
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqILB-00Cvsh-JD
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 18:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnSMSfYhCh3920oaJm+6kh5j0vbELxaynkExsnsh9BgZDTrWJ+APc6Hq6LM19cLAxRA5seC/4v74OjE+oXMk/RocgmBavC3Yi5LWJ10WD9kCDjEsKsnJ9d9aZLw7MKA2a5F37i7oSdWnxMMEyEmXgyWQQKu12EdXCnj2MoudNYKSZ7uH7ba+XesM2DvqJLKuC2z+VgaUFvSsN61DY9xMu7uEvI4POuvQ8S+LyncmlYcDcotzHCLcifiSUusV2rwMkjD3cu7k2+0/0iS65PwWR1HLV1TkCWcuQpVGt64+L98WVB0gNp5NotObIF42fexfkGIUH7hSlFEiSOfYT0lizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ECRNsFA0WB38ovTgaF7ns551q1vlEraCdrg/2HMZcA=;
 b=Sh/BU4jMN4JnkAWvkSu1pZ6P4IcwRj8ZbRAV18JJrbAOqD8zKvuPGrcVJzNz5TRCiyRtIa1m70xDiVwHuLLK4+Ya1n8LuG8HYk2aRXmFcarauJY8gqSOr2cvZlS18Or/6Bqz84TRX2n15/tcm4OaqMDOypmLx8mRhjvNd/aI5rZzIEyu9+0yZqYWkM6VWI0Ptcv8eXICobmBwVIAi9EvfZJ4QDnXEX6DuzPgjV+Oh0P0f9RVWusLdlg25JSyrgB5z5x0yaleKE9qvaIU9QFsiqGzS1jbrxa1zfhfBaktHvpAlcgRw3ZzBBke4W/8t+4SpvMMtlNTv+6J57HdsIvTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ECRNsFA0WB38ovTgaF7ns551q1vlEraCdrg/2HMZcA=;
 b=BGE1ajYnaN6AYsYIH1TMcvFc8XoceodFkWwi+LaZ22iyzWUkSgaxhKmwso7dmpCBgid5tUb/DXfqyFdpHpE+sZEB8DDkzhSX6rTUrKOE30MkTUa156WR+lCXuSFT+6oi/sNmTCMeAWXcP3bAqJ+Hfmyiv3TaNeUDFCcDX5wYbwvv2PQ2Jtj7Ofk1TKQ6DkgnGNRxm6P0u4d+aMEc7mDNt7BSQx+eNOZVgX9rYehvUDQdtKr6wl7uixIY6bOO8gZF5/TBtG3Vl5RWQTPfO+QlPKT0hnB9Sc2xqVdtYGREsBTe6bPy1JHAluVGr9UKX59RSriSVmKLi+v6/QBAnr1M8g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 18:19:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 18:19:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Joel Granados <j.granados@samsung.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de"
	<hch@lst.de>
CC: "gost.dev@samsung.com" <gost.dev@samsung.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: return err on nvme_init_non_mdts_limits fail
Thread-Topic: [PATCH 1/1] nvme: return err on nvme_init_non_mdts_limits fail
Thread-Index: AQHY7t+WUHSk3E0LlEeRFWZ4bKea964r8aOA
Date: Wed, 2 Nov 2022 18:19:50 +0000
Message-ID: <3ae64297-b480-56c7-abbd-21ebdd74a132@nvidia.com>
References: <20221102171708.3303614-1-j.granados@samsung.com>
 <CGME20221102172043eucas1p226576ca0e881424e65d2e0b8c19d060a@eucas1p2.samsung.com>
 <20221102171708.3303614-2-j.granados@samsung.com>
In-Reply-To: <20221102171708.3303614-2-j.granados@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ1PR12MB6098:EE_
x-ms-office365-filtering-correlation-id: a0c24d5c-cb47-4df8-666b-08dabcfed49e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  r5ZozzcF47iYWFP8ZhZOTIi4tSoWKFwo2iM1RDYqKLaBrxT7MiKZh0vrPyY2LwPMoFxzfPwRZKyS0gI4ZRVcalm8IBMnsfHEmTd2grSrRu+a5/LV7/hPGWM7iOJu+JOL2TcsE5XLzmZjOYtuVDixX1W+Dgto0+RT68qRTUIZi7vZQHlvq7z+ktejs881SV+ALI+KOzzzKf5QHihkihRw8yAQ7IOlprCEtHzseEI6kfU6jj4S+sxU1c+J/v3txrqiLiThbUlvVUH+AIiLevWXWsp+lEtQXvEzsKjG+Par4NeY0GT1Roy6FUV78sFh4QRi5/wPYKkiHKNnOkFsKWT6xy2JqpW20HjqfxBovvKqxZX18Qs7uOV+drs7SWHaKlfnJd9lNcRyczzCKgW/fBpnZRydBTscZ/Y55efGpOIMptASZxQdwpxY2jb0xa4P5vqJTV/GA30j0/1UYxwDh18ymwGT3ZOjBL4J2rdg9rJN/4i7RS1PnujBmyosFHNeJLYb0iHOuMm6yQrzW2xCg3YbJT493VmAutBprl2dafukfMfKvpEd9rnrSBl9SgKB5FlUQxwx8yWAWiDckT1FwosfQqQz7UbEGRvQY0KZpuZbBNuINIO5q+gyfcCjFPpZ1lxxkv3anoQuWa0GdOek8Jt51rnAv7A0msz+1qu9vQrAYiqVum8xmxi9aVJjhARVqIb1w3I6bnf5xMX/KrJruzcBZSlW6YJd57mHkpRGFF9N7ZnjetJ/QT5oqB3zOofew9/9iDaTF9xh6dynrqrj7vPiyUZF/7QCTr9uUltaWg0772zjQMGh759uWh5jd1pYIMiFFHTEG7MAnyHiZFLHgD7E0A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(31686004)(36756003)(2616005)(122000001)(5660300002)(2906002)(558084003)(186003)(38070700005)(83380400001)(38100700002)(86362001)(31696002)(4326008)(478600001)(110136005)(54906003)(8676002)(71200400001)(6486002)(316002)(66476007)(41300700001)(91956017)(6506007)(53546011)(64756008)(66556008)(6512007)(8936002)(66446008)(76116006)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?L2U0UksxRFZVQ0xRV2x0THZYem42bmdPVllVS0VHRHR5T2ZTbUZZWmxtRGdO?=
 =?utf-8?B?OGJsMldBdW1kNEZwYW5ZMitGR0hwZmh6djk0N3l2OE84RnlqQ25jRTlLNkEr?=
 =?utf-8?B?VnV2eVhpR3d5YSt1RUxUU0U0WUpBSGhMNk5qN0x2dGxQOE5VU2JXWkVVTUJ0?=
 =?utf-8?B?aU8yQ1UyN2hNcnFzYnA4Z3Z3S20zYkdMQmJQSjQrbmFTUmRodmZyZEhDcVd2?=
 =?utf-8?B?a09HMkFFM3VKeklPa2hrQkNGaFpWOTJMYkUwSGZ3TDE3bGZrMjh5T21acGND?=
 =?utf-8?B?b1RNekNhcUh5Zi9YaVJKZ09WSzZHUDhGZ0R1dWRFdEk3QU5BNGpMRXZGZUZx?=
 =?utf-8?B?R0RIWm5USjJwdlgrOU1ydUNxR1huS001aFRLcWtaYndUamY5RGhkUFRSd3hB?=
 =?utf-8?B?RVhMMjRFaEZXSDJnd3NJa1JPZnE5VDJqb01pelkwSHVjb0FaU3VHZEdXbVVW?=
 =?utf-8?B?MStWcnRkSUJOME1VTmovVjZTVkVJTEtIOUxnaHB1RTNKMHFRc1NSdWluNVMr?=
 =?utf-8?B?UmcwalRQNjNjQnJvMHpWYTBEVnloOVFpTUNLL3ZSYi9ZUzBqRlRpRlV3ajF1?=
 =?utf-8?B?ZHlBb0hETVdKdWwyTXhHMVB2bmowRW8vZms2TEZ6eERLaWhWbSs1bysrR1Ni?=
 =?utf-8?B?Q3k0bHlqWVlSWFV6QnM5Ly9jZkIyQlVCVDV0MWlkSm82b1U0akY2dzNTdDdF?=
 =?utf-8?B?ZWhnbGJIei8wWFpueVZvb0NyclZMY2FvM1FjY0JONjFMSmk2Y1VyeWpqbmRB?=
 =?utf-8?B?OEtHSnNzaktUSFpJYWxpdzhGcFBUMHFwUFFybTFCSDNSbUJWRHI5OWNrVGYr?=
 =?utf-8?B?MkxCbEZzS2Z0RUhhNm5BK0Z4Z1FDMnRUM2drRlh1b2lERE5QRmdvbCtmbldW?=
 =?utf-8?B?TElRdENPdldRT3VkN2dvQmJSZzUvb3o2b2szZTZMMjZIZzl5YXMxVit0Y2FW?=
 =?utf-8?B?dGZUTFZlUTJPWVNhMlFFVnZSVi9zemo1ZEYrNlpyUHljNHg1S05aWWZveGdK?=
 =?utf-8?B?MzN3bXJETkNoTkgrRDBXNW02T3Mxdm9zNHAwZWhidEdSTmtTZk9BZjJieWFt?=
 =?utf-8?B?WWVhNUlKc3k4RlU2QnByZnl1OFBZRHphUVFVS2M3c2loaExjdmdvbXlKdDYv?=
 =?utf-8?B?WmgxNHZyeW9YTGVrMUxrRnQ0ZUIxMDg5SlV1VFI1R3l3ZlRxUzNuUHNYaGRE?=
 =?utf-8?B?NEFka3hZNzlwUTVKWnVVbWZ3d1RNS3k5b2VJMkZ1eC82YWJTVGJmT2VxZURo?=
 =?utf-8?B?QzNhdWpSemlKQ0kycm9XdUZQNFI5LzVuSWFsOVdyN3NXbWlOSUhKT3hhMmJx?=
 =?utf-8?B?TmMrcCtzVW5FNFpOMXkyYlRwbk5NSTkrWXJCSWxsNFF1cnlzUnJTVjlHQ3I5?=
 =?utf-8?B?WW14em5oUm1SRVJBV0FEeG1ZS2lvN1VpMzNXTjZnOTJZdmo4QmVYSXdZeU5M?=
 =?utf-8?B?aVQ5bWppMlNhd2FlNmNCcGFMWUJkMFpHZS9mVmJDVVJSWGl3RzhoUnArLzhh?=
 =?utf-8?B?QnlpdjZVdWpiVFUvNjREeVZGYWNrekNWc3VpeEk1Tm5CY0J2aGlCWm4wNnYr?=
 =?utf-8?B?V3Z6N05KajU1bU5PT1lqczVySmJRNWYzVGdnQWR1NWJGQzZUY1BaYTlxK1Fo?=
 =?utf-8?B?VW5acDI4VUlnRk9uSTE1KzlCR2NiaUxUaWkyY2prRlBzL3UxWUNYNVV0ZklH?=
 =?utf-8?B?ejRHb3NEd0I1SzBtOG5hVVRaYnNlRHRQUGdNRUtNM25lQnBWUnIzLy9iNFZQ?=
 =?utf-8?B?OEMvNC9DT0QzME9sUW5NZWJyQ2NOSU14Ynh6VklEbXlDTUZFNHp5T3dBOFJB?=
 =?utf-8?B?U3RsajQwbzRkVkMrMkN1N0pVZnF3MjJiVldZRTRTenpmcE1EUkRtODVXai9N?=
 =?utf-8?B?VzFyaHZIY2ZPTlBtbml2SjhMc3BEdXhiT1dsbU51SzVCVjdaVkpOeDZOZ1d4?=
 =?utf-8?B?dFA4d0lSODZnc2dxbUlUeTNhZW1BZ05MUHV0NUJDK2pGRjkvMUhCM1JrMmU4?=
 =?utf-8?B?cC9xamxjUGJvTnB1RVJRVzE3aEFkZUhUVTArTUVXTEhZdTczcGFWMWZFaTVq?=
 =?utf-8?B?VmFCUGJzZDRNZ0VUaVVFNFBsZEh4OFpyekl0emtwRll5c1dTY05DeitWdHhj?=
 =?utf-8?B?WXdEcm1mQkp1WVBKMUlxcHRCMXpyZmM2Tlp3OFNBaUQ0VWNtWWxiQlI0VmJN?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B7A82651F9EA1408C830D421D4AC6DF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c24d5c-cb47-4df8-666b-08dabcfed49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 18:19:50.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHio/HMBaLbjwU+2iRBGMOxHFru070+C87e4hsQNH9UmCOy5mIRI4UxNXk5eF+sNDc7sVjM3Ehf0jMPmitRcCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_111953_885209_397AC110 
X-CRM114-Status: UNSURE (   8.94  )
X-CRM114-Notice: Please train this message.
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

T24gMTEvMi8yMiAxMDoxNywgSm9lbCBHcmFuYWRvcyB3cm90ZToNCj4gSW4gbnZtZV9pbml0X25v
bl9tZHRzX2xpbWl0cyBmdW5jdGlvbiB3ZSB3ZXJlIHJldHVybmluZyAwIHdoZW4ga3phbGxvYw0K
PiBmYWlsZWQ7IGl0IG5vdyByZXR1cm5zIC1FTk9NRU0uDQo+IEZpeGVzOiA1YmVmYzdjMjZlNWEg
KCJudm1lOiBpbXBsZW1lbnQgbm9uLW1kdHMgY29tbWFuZCBsaW1pdHMiKQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSm9lbCBHcmFuYWRvcyA8ai5ncmFuYWRvc0BzYW1zdW5nLmNvbT4NCj4gLS0tDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0K

