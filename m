Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21714C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 22:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BlYlbf7TsiHDIwyYMMd+z2pAw6evq48k4M89DGsrcjQ=; b=Srv2z0cNVJoH9nt5l/MM327pXb
	XIjZkHrhCintPr8rEqSxJGH8Oroq92XBY8tBthzWsVyJVcBlHaFYpLNrFi5muwvsxK/6Td3yKV4cS
	7m29u79LaLZj6vOdx6Zmg6MjfNzvCwQaPUTbtgIn4c5oJq6yFQFxjtEl/zNot6z05REHzAdBKBto4
	IXTtUG92eVNbLdavwWJHze4wwOFJ34c7k6fKtqEqqRxQMqGSZhH26IUI59E6gx/8LxER2sslbvkU0
	cosevrn4KHAbt0AwUZphMIupu86kIdC4+QTKAzpZLWo4J6idkhx9i1WhYq0otBKspCUqwiWiyBU2X
	WzC125eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZz3-00EeV5-0q;
	Wed, 15 Mar 2023 22:52:37 +0000
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com ([2a01:111:f400:7e89::604] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZz0-00EeTy-0S
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 22:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib7tlwf5sOB/NLq+ubSyvu9seukWZnsmBpKFfogyRZ2EcvYUWx/VSWGjSpg4HzdU7ymYz0Cu3geK6JheeUCZLwirF61ZG3SkbtOtR7WxfW016K6QL5HnuT1Mh9T5iSfdeYbvfs4YF5aBrJr2fyHg429jml8vvqOS0Neeg/7gtCAcGKa9kk6srkcC2zWOrsFN2Qluk+09PWk7QyWwwcOPIHfB2ND1B9kMXjxn5hHUTwWR/SyEe1j0T+zEzm1yLMij3+9HA5TgcYskZLl5rTDU20GT3P2mxt3ZYQfZX7yZ2WfN2p5HT8LTDbZc0lufSNmCL6RIFRcEbVW5zWJ1VwfzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlYlbf7TsiHDIwyYMMd+z2pAw6evq48k4M89DGsrcjQ=;
 b=jqVDxBLv6nfLfydSQuMpM7QOpst/0gNghIAIxq6Q1dtRhKabJ+dAqwpMwAsOrw16SIDOud/pmCFX9eG0HZiGOWpVFenwYQb2UFpTfz7hIxKgqMn8sBtPES6PCM2hq9r8jBr8c6MCByqnBnJFzRyM0gKPGtOWjzuFMNPRdfzeIYPEj2Zia9faXgCU7MIex+qLGydCKtnrVTDZOgEVk/QAOhFAhIMYuASkaFk96fsrBAEposl24ZC/JzRta2Mv83abu71M3A5Uf9sO45VMqRefrAK1vIDTd/R7m3ItXUKByKvlWm1A8KigAv9GvK6JGCNJXc9R908cW9wGM22iAZHMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlYlbf7TsiHDIwyYMMd+z2pAw6evq48k4M89DGsrcjQ=;
 b=mJhnecGqG/40oo6q1Ky/fKr2jO3uhepakzjQAc68oYE44rwjWL9JTff7sEokyn0x9fANenq7xI/9WT9zlS8bu4ozOB/cwuhOfNG1AXMBOVXwhTEyxKhHnnqW+sQ4rYm2JyyqFvGmJZmQER/j93PuL74OiJKlFzZVxTc/duk2PxpSFrjPEj2CjWZxf9pFK2MNKBjo6FUVtAiSHIbNZ3P8hxoylHyImJFwxzzp/O5TXY5BPxWE+5sEMgiob/gFp35K1EZdAH/NcWEXAyuDuUropXGJ7//Tx7sGCythSva1dGek1pMrwHWpibRRn3HAzxXD2jxXBHRoCSrzc4KmVdHvvg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 22:52:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 22:52:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: more nvmet Identify fixups
Thread-Topic: more nvmet Identify fixups
Thread-Index: AQHZV0lRyuE1Da8B/kib45QV6DqYZq78cxCA
Date: Wed, 15 Mar 2023 22:52:29 +0000
Message-ID: <0fe36f74-b9d0-4b68-1cf6-4d436b15df3a@nvidia.com>
References: <20230315142032.507083-1-hch@lst.de>
In-Reply-To: <20230315142032.507083-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4579:EE_
x-ms-office365-filtering-correlation-id: 0d03abf8-5bb3-4539-ec8c-08db25a7f4a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  +jW8oD8DhiV8rYsLTljfZSHH4NFliXQX1WlGNxjAxFGKPoJjqgcquA8MfoD38X8rJ9r41WMLNp8S1xZWAryr7Vnzys9PlQigY7GWDcUaNk2k04lmvgSPSpjflECwvHUoQISa4OGAZ8Pxf/flfOeF9Iarh9UfrLZTMquAcfjzYapyHgjku9UGiFWtB+xCvLii4CX/wfmC0Fz97uJoPPunAp1/QoQBdoHM3iicmOwr1dBVjwFx0pcry11Zq9488I5PdJ/c8T2GszrGgA5XkCRt5MS9zF3vqO8E6XwNUoWG9boCsQRNFyaI9N1yTz2YFgkfDbvf68Yumy9LP2oOHUcpVPC25vderltddxOa4mh/7s9ZVGj//zejs8tw88QS/qkRlEOaUwrbT13NPkMzHYcxs5sicex6azRjfrQAPnF0RKsz8LGCNq1GBaYbx/eZqxr+FzYx7/uyOi1vS0dJjxUQHiLoI/fFKIe2YtegYGCi1wEY5RMx66+KzuSBZr+DBMtupo2Q4HVCuhra23je6C+nLMJ13GEoaQb6KPTfiekqsiC5E1Db5EELWng2InirdxxsZnnH9aXaEDdlZURYq7piqakfBGPi89KbQt9YEwwFjkpXjs/42M9oKzLatmgvp0dwCwA0iW7+tVFpbiKUtL2HdOrJDpOa0sLge6TvASk7Djc2r2ShAndAJJK2c1XbTfq1ImuTdEFdnzD42Mtg3Ez+qQH+IuOrBogzCG6by4v9ysend6BE1BC3oiKW51Jk+Q+rbNAulYMpcELaeBNoa1yhZQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(38100700002)(31696002)(86362001)(38070700005)(3480700007)(122000001)(558084003)(41300700001)(36756003)(2906002)(8936002)(4326008)(5660300002)(6506007)(64756008)(66476007)(6512007)(2616005)(186003)(53546011)(54906003)(110136005)(316002)(66446008)(66556008)(91956017)(66946007)(6486002)(8676002)(71200400001)(76116006)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?K2NQOWdFRzJFdkltSDgvZ2J2TEI3aXptejFrcmJ3cGU0OUcyZzByYmZxam9a?=
 =?utf-8?B?QlZlTVN3QmplTG91Q1RZRXlBS29wcnllQWxzUDcvbVBla2NOa3BvbUNRSWps?=
 =?utf-8?B?eW9SY2tseVlvb2FVNGVVOHFuRE4vTmNwaWNCa3FWOVRvRDFnbU04QmE4RmRR?=
 =?utf-8?B?YjJWY0ZQMWxpZEFmRzdLZjJ2Rm9VdTJDWHdnamdSMUpBWEJsMzlCakd3c3BN?=
 =?utf-8?B?MGxNb3JzNGh6VUhQN1AvYWJVMGtYTmEvaVAvQkN6ekZjUHVaU0Rmek5sRk8w?=
 =?utf-8?B?bURDR3dTWm9KeVFQNnJuNVBGY084RzUxcWhqK1p4bG1YYThyQzlRRTBrZzU5?=
 =?utf-8?B?UjI5TWFRVGNWaDRQZW9lMkpmR3hjR2x3OEhhWW15NWorY2UycVp0UFlVaDZ1?=
 =?utf-8?B?OURWUkd6b1ZVcWloT0NQY3ZIcXdZdjJrRXBoamhmeFBLaFFld2RLY0VnYU51?=
 =?utf-8?B?T01sVDdNVTZXYkJMQ04rSWxNNlRNY3VtNTVvelBJWTd2MkZxc2VybXB1Z3NL?=
 =?utf-8?B?ZXRMd2UzZlhicjdIVnFPRTB0UVlKU25vOUxSTjFYZGVwL3NpQklReFJvUjVR?=
 =?utf-8?B?c2lWb0wvREN5VjVUUkVaTFpERHcvL05kNFZiT1BwWEc1Y09qUGY2VVMyTWxv?=
 =?utf-8?B?clgxVEpiNDBNSkl4a3hESjg4U2lZV0ZMS1l4TE4xN25leGJyL2p3aC9hRSs4?=
 =?utf-8?B?b0piZ3lDM1paTHIvaXJ6QklPSWI2UUw0S0hEWUhHWUZJVE0rb1FWdnN6Vjli?=
 =?utf-8?B?L0pzbEk4OHpzbGdVditNOEpkUE9zVHA4dGs3Y1JSb3RMYmNHVk1Renh5d1Ba?=
 =?utf-8?B?S0pjdDdOUFVkeTZzUlhwT2cyUVdlTUxvQ1JTUis0Uit2ek5KaHFRUVNnNFVk?=
 =?utf-8?B?QTV4NHp2MWx3NDRPY0pxRG1aMThpSzByRFFtZW9lc1hxek1RWlM3dnZWTWs2?=
 =?utf-8?B?VkFsNDBLaS9RbTNMQnlqeFNibXRVZ2tST1hhM2xZM1Z1a0NFb2VKbzdMVDNl?=
 =?utf-8?B?TVMyNGwvNjI1dGlrUHFPOVJzcnpoS2FkWG1yMUpHTjBWQVRvcFIyTkJlU3NG?=
 =?utf-8?B?djduWU9VTGUwb2NJTTFhS2ZNVjBXNEVWVEtxMmxoRjQ5UVdiMFkzZk9ZUWZH?=
 =?utf-8?B?REJSaTFOTmhBN3cwbGluSWRNaG5tQUloakxvMys3WjRERHJpVXBaQWpGZWkv?=
 =?utf-8?B?WXYzc0I2TE4xUXlRL3NNd2JvNk1QR2F0R25uMjZCd3Erb3ZBZ1RTNGlYNXNF?=
 =?utf-8?B?am1VS0lKT1Z2Z1NSei9KOWRTUFBlQTE0ZXkzbUw2cHc2bHRuZHFsdkVlWEt2?=
 =?utf-8?B?cEJuWmtaQ3FGREFRc05tZ1pSTFFIWlVhQVl6Sm5vWXVpQzZGb0lhY3V3S1Iz?=
 =?utf-8?B?MTJMZVBtbHkzbHlBakZ4d3g0b2duVDhIb093Um9iRC9QR1VubmdaRzE1TWV5?=
 =?utf-8?B?a1RqMC84d0pWdE5JSGIwSFFsY3dheXdRUng5Vm5oMnM5aVBCMnBHQVQxSzk5?=
 =?utf-8?B?VVFmNXh5MlRiL0F3OGJLajVuVzh4bWVTeWpmR2xNZndLL0NFNElMWVkzdk9W?=
 =?utf-8?B?cUxtR2ZWSVd5WWlLQUFQYVEwd2VjMHVEZzNrWEo3czJJMkJpNERIOWdOc0hj?=
 =?utf-8?B?TGF1T0lBV0ovdkNEQTdNd1laSFhoaG80VzhtYmlhRmZWQkQ3VkRxYTRaVm5v?=
 =?utf-8?B?OHVZdEgvQVU4T29hUmx2VEdSanNDNTMrNkN2NXFvNkpjWXhQejc1UU51WXg5?=
 =?utf-8?B?U2NRMTV1d1Fha2tvN3gzV0JuWUt2RVNpdDFsUWZqQXVRd3d0V2s0NjkyTVk1?=
 =?utf-8?B?S05HOW15aVRsWWpYVjRNR2RObE9EektDQ3pXeWcvMnVVU0EvN3pkZ01TY1FG?=
 =?utf-8?B?dUdiV0RFd3QyRDdYaGFFUWFoRmdNNHoxZVlLakcwSnQ2eWhLdW5nSE9kb0lk?=
 =?utf-8?B?K1BtbXgrN0RzWVFYSDBQdFdrZm9XNm85NWtoM0F5dmVOK0hOU1BkTEtpYmdG?=
 =?utf-8?B?alFCcmNsSTdBT1ZYMUVHWlk3UWk0NUZpbWxTcVlOVFJFdlowTkVPNzgyTktN?=
 =?utf-8?B?aFkycEtUNzZEZ0FDNGFkL3VoNXBOWER0cE5aend1ZkYveGE0bHMzOTZ1eFBv?=
 =?utf-8?B?SWlOTVN0d0o5Z0hGL2dMdkx5SXN6OVFHT1FpbEVCMG8vMG43bks4b1J0T1Uy?=
 =?utf-8?Q?vYf9wQOvXA2Jiv/jCYkzkFXPPLsuxTrn6kxUPbI5Xb1h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31552FA7A271764DAE1BB9DE3C6A6AEC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d03abf8-5bb3-4539-ec8c-08db25a7f4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 22:52:29.7247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B647aOzL+j8MQivXafHeAjVtEmOAWpCa+UJ18HJ8opxet1OHfsyZ3zSjHmJxD4jfwtSNoUCpLgBk01PJhZ2Z2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_155234_176734_A3664FE1 
X-CRM114-Status: GOOD (  10.00  )
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

T24gMy8xNS8yMyAwNzoyMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEhpIGFsbCwNCj4N
Cj4gaGVyZSBpcyB0d28gbW9yZSBwYXRjaGVzIG9uIHRvcCBvZiB0aGUgd29yayBmcm9tIERhbWll
biB0aGF0IEkndmUNCj4gYXBwbGllZCB0byBudm1lLTYuNC4NCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==

