Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6951BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7wha3f/KVca8fqtTLPOf0Qc0u8PDc5Pb517GFsWxRh4=; b=e5g7ZZWFJxCmJnZgf6KkStrUi+
	6P3ebv+2KBwurAS8TeKgticXi2zxIxhhtxuHmlFnnj7NG8YMd4YmIue8HPrLAGl6A3fJzp/yqvZEe
	2+oPT03iHnXQyDTxoPVb8c65kY9HRe1CLbKnPM+vekfKFyXJTk5Y15f9cXwF6U/X+KYRA9nL2lT0n
	eG9us9XNrMFsMco5kRFY4PH8nzlDbi+wDAy0KNL028KQSyVYwlDAlFCFT7Cr5fD7wfQRZHHiofG/n
	4bwJ2SKZzdRPbL3pcGpJIkHWneU5C5Np5augZJCQhgTYRqHOKFYY7r2ZqprRmy0qJTr9NNGWKpodT
	L5SB7qgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neARj-00C0Oq-HB; Tue, 12 Apr 2022 06:56:15 +0000
Received: from mail-bn7nam10on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::631]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neARg-00C0My-LJ
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 06:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+vSuh1ZdNoEEfcOTcDVQN1p4n2SSbZhweLIlvembnbY+/N1QGYxy9iTPKJ4t4ZLMYtt0yzNgNnSljSUO0RvB5NwP/B3FqVI2yjyVIaSCLFG4NfCa6h4iBxF7QL01l1dHoj4qB/+i1xSLe7r/A0QAAHg0vEm8UxVB4VRl11fDHfzHsc9L1+opaj8FvdF8PqN/XoTsdHaKZkTCfHk5tr+ikuI2a/UhiGbJ3J7/0nIIHHNH1VqwkS0NQIZu8P62Cnlci4lRriNXW/yhF2F6BINyL6nLi+s7KC/iSpenXmIcBO9Nq6dvO2BFNbXvTuSfubV/1zI7ZeWm/ajM9soJHgZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wha3f/KVca8fqtTLPOf0Qc0u8PDc5Pb517GFsWxRh4=;
 b=m7xS+Dn0mfAnmZIRJCGqj/WIJD/zFqcgYRoBdSAZZ74gN+sh5wCdtGkcChf1njphtYk4vwxs59NcmnZ5SV0lAWvDzxB9q+gY02qRH/yd+UjN5y+Uf2yOVaY40tstQz05DUEzCN48+k0b0dOXH/66+ZNiiCIWaKZS8pZZ3Mmb93hDA+H7ve7t78gYSOhJ8J8UVJ3VRT58xWIEIk+8g+bcxNEyqIMZoYalcW4WqZDfWJu6I6jyja4GzitgoBiYp5OEoKWxEh5pZSUdp4XNY+Q6rFhxlICfRYJHVH2+hmNo85lTDnG9z88camUZZIqZzZDNxGFvAv12XG7Q2A4wTYoZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wha3f/KVca8fqtTLPOf0Qc0u8PDc5Pb517GFsWxRh4=;
 b=BRboeQ9SKO2G1uPs0l4vYksQ9nacrshWbzOBcOB+23oGQqrbY3bEnD+xXZ7b6wvJFhX7I3z4VuP8ixhuCzNz/fGGR7LneV6VYg4IyV22Nlkwpu7UnFee6NCaz4qmXevig/rPjOKOb2ss9qEZSYwknUkJn0lD9NWE/TK54yFMYBZfaEVy4tKyFPHz3K8g0mj0hj290irIHfxjcpDMMARy4AlChnZj3Jlcv7Myau3IIMxvLOyp2wyAtFZFXc4i/wRZqoZgj66/73ak4Ewcd0RfTuj0h6p+1SJAdi2XiAGxEJR6GAZdWxPmGk4JCYFHL2hVHNfo+9o6/p/qQuV4kP9F2g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:56:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 06:56:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Luis Chamberlain <mcgrof@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme: add a quirk to disable namespace identifiers
Thread-Topic: [PATCH 1/3] nvme: add a quirk to disable namespace identifiers
Thread-Index: AQHYTjRSbT1OLv9mFEOAsjHKy3ynX6zr2FuA
Date: Tue, 12 Apr 2022 06:56:07 +0000
Message-ID: <44f60505-724d-0a5a-1f0e-488c323acdce@nvidia.com>
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-2-hch@lst.de>
In-Reply-To: <20220412061126.244414-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 747e23b1-1f2c-4aff-d9e0-08da1c5184fb
x-ms-traffictypediagnostic: LV2PR12MB5773:EE_
x-microsoft-antispam-prvs: <LV2PR12MB5773AF28BBB418FB258B2DF8A3ED9@LV2PR12MB5773.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9HlUSOt8xaSPV41CNb9+mZPmj2Sf+h6cwbofPW6/Vf9IVFWtnhRHXW7+csWKAXlXDf88NfUTuTJwParAQYxKjHXL1G92UAVu79TbtJbXY5teFai901ccUGuVjmOO2WEiF+aE23qW70jhevK1gbySIKShBjOqsa31BHAqUMdfgzljtQ3RWC2pNYd/Ber3p9TtCht9Pmjt/5DIN7zrkEme2ajoNRiErTSp9QsxkMBBmy+tcQRoPJMZUdglU/UpBicDJzETlKdYKIXPs4kaS2pVfOy/+WRepiUArcUemWuSpDciwHy5I+XBjPSFuL6MrxpzRx/tMmGFZygrJIDXiQU1S1DuFjY6elEPDAoW5QMenkT8S25xolxXOUTq4Lm7fYruRBChVi7x+fUP4u3IsLvZNDrzfamLaaS5dX8gUMpobTUcLR/c5V0Cmt44gbtKir/AiJuWq2QQXazbrQrITlwAQlh4b1TIUx1VLelTFLC7QpN7uVljUU/l0zp/J0TfQN9kAO9bfrhGB5bLeY6tKmZROwL5rQ7JbOMIKukLWwSJ3x4v9lVlppKnhycywE2So5/p+QC4eY/HzSFcZuxKV0QKOfdFL4sOEnAxiaZXhX1+dp9EBFBAIupzQHKeVJ/Visph1P1JxcQo/mWzPpSERHWqFTvvOEKKuokvLyfx7M0y2w5vhEGUwUZhZZa12f7TDs1yyFrnI45qxvQ090+6Sn6uIXDrDs4eCSgZnk7yFqveUC+/vvoJgZdDyfFvX0pF7JIQtZhSe9EaGFrNhlkrc7wtcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(2616005)(122000001)(54906003)(2906002)(6916009)(6512007)(508600001)(53546011)(316002)(5660300002)(36756003)(31696002)(38070700005)(186003)(91956017)(6506007)(64756008)(71200400001)(66556008)(66446008)(4326008)(66476007)(8676002)(66946007)(8936002)(86362001)(76116006)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmUrU0pDQy91TzlpcjBYa3VGVitYQ2FHMFVWcHczRXlGZEFUc1RxUWNmSklZ?=
 =?utf-8?B?YjBmNkhhOUZwRFppanhLc0JtSU91NllWeGpmTkM5Ty9PMTZjcUkrNU5KeFRu?=
 =?utf-8?B?YXNLR2NoemN2QUJXaXlDTkFrQnEvbnh4RU8vOEFGWE45ZGRsZUNFdVJwOGxC?=
 =?utf-8?B?N2lSVkVGd2NXY1BJQkNDUGZxVmtCdmVxa3I0NERHc0JGWktiMU0yR0x6d2tH?=
 =?utf-8?B?T2xqMjRhVS92eWRLNm5BQzFSSVgyVnVaQlBET3V3ak11RUNiRTh2NkE3cW9Y?=
 =?utf-8?B?VmJZQVM0cGFhc3BMRVpoTzVtTDFSSWlUU3dRcjlJUFFyZURpSS9ybENHWFBn?=
 =?utf-8?B?RGt5RDBSajArYTR0NENIL3YwSzRXenJnemNyS1V4STlub01rV2M4dWlRNGxs?=
 =?utf-8?B?MmgrdVZ1UmdMYzBUUXpOdFRuUTN4ZGEwT1grdWFzSXNneEJ2K1lSZ2pRZXJs?=
 =?utf-8?B?cG1Za0lZRVRsNm52NXVsNFRkOHFSM2RUVkpXd3BrMk96RVZHSCtBT2F0cW9Z?=
 =?utf-8?B?ZG9pL2dKK3phV29pY2ErdXlobWhsSW5ycmtDb3NrYkxHOVZTSDdLR3BoRHNM?=
 =?utf-8?B?d1YvZlJ4dEtpQUtKR2NYSUtjclhFbWQrTTRWY3R3ZElUSUJ1WHVnYU5jVGlJ?=
 =?utf-8?B?OE9BUE92V3k3OW9RUFZ0dWFTU0dlcEowNE9qSHFYN21xWmhZdnQ2NW13WU1E?=
 =?utf-8?B?Z0E0UU1hK0Iwck96aGpDRDNFTWF2UGVXUHBOT21EblhMYVNvNDBRY1g2aEs5?=
 =?utf-8?B?dU13NmFRVUcycDA2THk4TzBOWjJjbGE1Z0pZMWNXaEx6N0UzSFh1NCs2QXJ6?=
 =?utf-8?B?SFpld0dpVFhmSXF5YVdOdjlld2M4M0N6Wm5NS3hQTHE2Zi9TOHNWRlc2WWhu?=
 =?utf-8?B?S2xpM3hkVXpqbzlpQzltRllJcVF4OWN2NFBHblBlR3lkcENBczRvKy8ySHR1?=
 =?utf-8?B?Z3YxQWxFZ3dwMWNiSDgyNWw1SitDMjV1aFBTSkM0QUFBc1UzYXd6ODBNbTZW?=
 =?utf-8?B?UnRoRDNNbzRrNk0yNDM0U3REMzJMWlZoVGtaeEh4b3pvdjlSYU1RNzJkSEEv?=
 =?utf-8?B?QVVwTlF2UFhrN09Fa0wxQmZLcWh5Q3JseCthM2lZTmFzVm9aVHNPOHp6WSth?=
 =?utf-8?B?VHRWV0RIeHpraC84a3U1d05KM0lQSENyNFlFdEFFb1k1V3BXZWZTaktBeWho?=
 =?utf-8?B?TUFVdXNBdlF1NGluRVVxUVFlMm1KbHo0eEtSQUVuNWhycmZiYjN5RzZMeFpZ?=
 =?utf-8?B?UFJDdG1SblZtMG45cCt6eE50SGoyUVUvNmR2ZWxtY1YvM0lJckJJU0VEck9z?=
 =?utf-8?B?Ti9WTnJjaTFHa3dtdHVlSytYMTF4YjA4T0p4bUU2Zlg4emxyVmxEVE5iMFlP?=
 =?utf-8?B?ZmRhbzZmYlNFM1pSUTY5dTJEN3l1N3VLVm0rQkJreVdSUE9MS3RQS25rMHJz?=
 =?utf-8?B?VC81TXJxK25SOUg3eVBqSE40YUMvMkQvR3B4YVNpNStMSFYwOURJemtaM3lp?=
 =?utf-8?B?cjIzazJ1alBWejNMbWpGSlRTaktLTlhFcHRWWEdtQnVQdm8wTUxNaGFyZjNm?=
 =?utf-8?B?K0J2Q3JVeFB6ajJSU1hvRXNma1VQWXRVbkR5RWx1Snl3V0I3VjZ4dEFnY0pV?=
 =?utf-8?B?dzRpUTBWYXpDMlZVc3h1MHEraGpVcGpnWlpUUysxWU9tRUM1bnN1dGZZQVY3?=
 =?utf-8?B?KzdYOVk5cGhNNHZ0T3k5eFZDNkc3YmtIcTZKQ1JBdnFpYVJ3dGg1dUVURDZY?=
 =?utf-8?B?Y0JxY09DNjBrcm9jVFo0SjFtTWo3TGlNMlhkZVdUbWZpdVhlT1hVMDlzS2Vx?=
 =?utf-8?B?Z1Y1Y3FqN29Oc2d6OE9paGk1TWg5bkJqdGhxcmgzZ1hIYmgxK2cxLzR5YUpI?=
 =?utf-8?B?T0dBNnVmQ3RZMEswakt3c3JMNG1lQXpja2lzdE44V0x2NmI2bW1tTDN4ZmFr?=
 =?utf-8?B?aXM1OGh5SGV3MkdoTkhtK04wNmhRZ0ppQVFaQ0REYmJqNldPODhaQnVxVUZ0?=
 =?utf-8?B?TmxNT2tPNzlLdFV0WnpQNjdudGljNmdMeTB3emk5aUpFQTNIRE9BVlpaSS9y?=
 =?utf-8?B?N0VhblE5eFBxN3F1NWFnVjIwc29rZkREWUR2aVBvQXFjZ0VRcFM5bWRrTTc0?=
 =?utf-8?B?UGNQdnkvL09Ga2xoQzlxYS9jUnh6aDFFdy81YVlMZUpLcDhTc2ZMVFBCeElF?=
 =?utf-8?B?ZWlPNWdkK3VBdDNvUXBCazhVdzBBT0hMKzJvWXVKQ05HTTVwS05mSHowa1VI?=
 =?utf-8?B?QzBPQWVpemltV1YvMnBlZENlRmtWaXRpOWZOUkJLNFdFcGVPTXlrS05KNkZh?=
 =?utf-8?B?NElBeEhSWkxZMlJsN3dkTFE5UWRoUGtEUUpZa0FxQ0tMT3kzWTVyZTN4ZEZJ?=
 =?utf-8?Q?aTlpR6zwWNN4y1OcNJmNumQv0KXVcDgdjxRpIgDf/Qw2M?=
x-ms-exchange-antispam-messagedata-1: SWpZbyMedPJyZQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA38295B41BBC478FA4D47886BDDC37@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747e23b1-1f2c-4aff-d9e0-08da1c5184fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 06:56:07.4435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGz48vAb3svkM+vYh1TMYUUcoKKNEay4S9vxu+mHKgY5LMA0X+oYvuOLCOXDB9OiYI9NebaxnsQlzGMKnCnwwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_235612_738237_7D143CA3 
X-CRM114-Status: GOOD (  15.30  )
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

T24gNC8xMS8yMiAyMzoxMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIHF1aXJr
IHRvIGRpc2FibGUgdXNpbmcgYW5kIGV4cG9ydGluZyBuYW1lc3BhY2UgaWRlbnRpZmllcnMgZm9y
DQo+IGNvbnRyb2xsZXJzIHdoZXJlIHRoZXkgYXJlIGJyb2tlbiBiZXlvbmQgcmVwYWlyLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0K
DQoNCmlmIHBvc3NpYmxlIHRha2UgdGhhdCBxdWlyayBjaGVjayBvdXQgc2VlIFsxXSBpdCBpcyBi
dXQgbW9yZQ0KY29kZSBidXQgbG9vayBtdWNoIGNsZWFuLCBlaXRoZXIgd2F5IGxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KWzFdIHRvdGFsbHkgdW50ZXN0ZWQgOi0NCg0KDQorc3RhdGljIGludCBudm1lX2lkX2No
ZWNrX3F1aXJrKHU2NCBuaWR0KQ0KK3sNCisgICAgICAgc3dpdGNoIChjdXItPm5pZHQpIHsNCisg
ICAgICAgY2FzZSBOVk1FX05JRFRfRVVJNjQ6DQorICAgICAgICAgICAgICAgaWYgKGN0cmwtPnF1
aXJrcyAmIE5WTUVfUVVJUktfQk9HVVNfTklEKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIE5WTUVfTklEVF9FVUk2NF9MRU47DQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQorICAg
ICAgIGNhc2UgTlZNRV9OSURUX05HVUlEOg0KKyAgICAgICAgICAgICAgIGlmIChjdHJsLT5xdWly
a3MgJiBOVk1FX1FVSVJLX0JPR1VTX05JRCkNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biBOVk1FX05JRFRfTkdVSURfTEVOOw0KKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KKyAgICAg
ICBjYXNlIE5WTUVfTklEVF9VVUlEOg0KKyAgICAgICAgICAgICAgIGlmIChjdHJsLT5xdWlya3Mg
JiBOVk1FX1FVSVJLX0JPR1VTX05JRCkNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBO
Vk1FX05JRFRfVVVJRF9MRU47DQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQorICAgICAgIGRl
ZmF1bHQ6DQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQorICAgICAgIH0NCit9DQorDQogIHN0
YXRpYyBpbnQgbnZtZV9wcm9jZXNzX25zX2Rlc2Moc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3Ry
dWN0IA0KbnZtZV9uc19pZHMgKmlkcywNCiAgICAgICAgICAgICAgICAgc3RydWN0IG52bWVfbnNf
aWRfZGVzYyAqY3VyLCBib29sICpjc2lfc2VlbikNCiAgew0KICAgICAgICAgY29uc3QgY2hhciAq
d2Fybl9zdHIgPSAiY3RybCByZXR1cm5lZCBib2d1cyBsZW5ndGg6IjsNCiAgICAgICAgIHZvaWQg
KmRhdGEgPSBjdXI7DQorICAgICAgIGludCByZXQ7DQorDQorICAgICAgIHJldCA9IG52bWVfaWRf
Y2hlY2tfcXVpcmsoY3VyLT5uaWR0KTsNCisgICAgICAgaWYgKHJldCkNCisgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KDQogICAgICAgICBzd2l0Y2ggKGN1ci0+bmlkdCkgew0KICAgICAgICAg
Y2FzZSBOVk1FX05JRFRfRVVJNjQ6DQoNCg==

