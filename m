Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F8BC54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 06:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0wt1q4zvEmT4tT75PmaVKGxIO5GXKhComU7a3UC531U=; b=kAFoeo4SLQ8Y85Xdi25Yu5Ag5T
	8Vqdcppd4CXlzOIbAvFoWzfpxkPBjOLpzepOQgIgD/jGm0yllfGOuNwYXvRrkm9bSEkSLbcqzZkU7
	XwRgCBWgiNsGw0yJdixbQIsG84xEArdJAX4NSNIWJdT0rZhYfnMDZPq+8XRrWvooSGIHtD3JxP8QU
	RFMw8GZGnZTiriOp4r9cy+zowhjcK5NK7vnotzeHYV4MFsd//+ml2NeWmyt20GESwoCw+qVGRMjKh
	qiGcjY+kL3ng5WH2wLq9Qxa9T8WP708WQIgOMiZZyvnE+ChRE+8/8zJApbS/6yjWhmjcze9jVM7wk
	UPHk9tVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhknR-0000000GYmf-40lC;
	Wed, 06 Mar 2024 06:30:33 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhknO-0000000GYm9-2Ssf
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 06:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/YNc1JOG/xlrak4/a0JjbFe8evQ8F+tzPYxR7Vm9HXag7p08eUL1necIc9JzI4bV2+pg4gZaI9oNIMtGmZoTiglxzbBotmb/wkqALKSU+BJbpywhrbK/VLVc/d02fa0c88V1NhglNIC1swnXRpHtlJNO81PZgep/SFXBYJj1uprPIuWsQkPXOF5wTz/MGBHLipASM1OCYdVS89PQIpkTmHn+93ThAei9rvdpsSzgECYlg8hLtV8SygFdRrYpRrbIt9wbO/B6WaovRHWPusalOPb7w2F++Ne67XKQK/LG9RCoJlIXpPLkT/1t3T/zfV9lMnQqmMK22uDGcWDEkUiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wt1q4zvEmT4tT75PmaVKGxIO5GXKhComU7a3UC531U=;
 b=EVwZDKsgt/apdcvO9zP/2yA9bXSNkSB+dQir5haX3tzg9gjkYyJ8mQtKxL+q2/C9Tz9rBqd0JkSQNvUzd/iFgAdirgfuJ5Gey890qNwt3eLq3D90Gt8hMSvqGkyrXC3hvdkjF1G+Fzs1An9yh2poVaGmnmE/oIzJPQmNTplzwNKQHBgdSBab9wbqh0B2A3zQc/XAZX+1NmsK+tEkrf7RRn/GoUvJNSIg49b87hedYnu1PUsxoIuvAjdALG+OaohTS1Rid2d4v21XwvcrDEzBlb0kraSW4a+CWuU6yoRmsf4ASt9qvlP7DGaj9XK/BfvVEgTECUxad3c7BRy1M+OXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wt1q4zvEmT4tT75PmaVKGxIO5GXKhComU7a3UC531U=;
 b=K0jnMOTQqK3/zEedVx4sfex2QQvafndvj42nUCpnrYAf5DGiBw8c9jhc8QdrTn5r5LiiHS8Fv/gYwS+ImCGJYLXOgURXKjCNhrxr917IhaWFdF7mT9G/K5uPxNFqrNbH5sKrBCgSqtut+7cFmAiDCF51ZKRVHERUnCyaENeb5ZQkHPRvx0pUrqRznibd2m6OGE+f92beFNHkwuvjgY/klNQHv/5rj3NvOGvUOP8Cp5YKXzaY4Z27442bccRpFQrfwJij1VSDLPVTvwqc/ERfSm4NiG6JhPdcJkcDXsv63JAQSkpidYZxdTgeF8KKWXzBV7QUa5BM2/RkIbEeF74Yjw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 06:30:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 06:30:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Thread-Topic: [PATCH v2] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Thread-Index: AQHab4v43gyF8mhjKUKh5YNxEXSWS7EqQHIA
Date: Wed, 6 Mar 2024 06:30:24 +0000
Message-ID: <0ee1f7a9-46d6-4855-b763-102da84e2009@nvidia.com>
References: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB5613:EE_
x-ms-office365-filtering-correlation-id: e0d03fac-b736-4934-dc9d-08dc3da6e822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIU2AqOJWLhghtnukZJmnFLp1nI8Hu1Xoa3ITh5rwr7k6faMWfKScWb7MMYWmxyZbYKXiMAxcJ+5olt5yggY83FVQ9++jxOjyZ/3SX+NFJTmqi3Q6qOPjFxNAFKpcQ1UQqXhCx83TAiFm/z8ctCO1juAcHIiK4bdjPGq7JT4A0QLq/o4nIvshvnmNKdn8LjtuD0Kf2ddM8d7RLQQYl+LaEspWnN4x4faiF0MKkJtHhabMW7kp+fNK97eTLXFtlMCx8OdPOeJvA/E1I2idSp7i5RuF2PQrl3XUhN/tIRLmm3wavh7svu2IdSKg+MtIGICFr1PKVaTkrRRb71bqa427gpiqZdcw2VQ9CzTOQ/M9NaNKBb1Q5dZVpEcq9ZhK1RYrZRmKA9FCM6PbwyKPc/MaR4vqlZwjxxuYjHGGkB/VVThXLROHUhV3o6tAo3MHKo1Lo+Fmi7Xf2WXlcaR1mD/l3nU4XjfVIxO+9qMc5+DMi0xWv2ils8GvhRu8ID5kiUgK4h9ZlT4rJBG0bwHCwids0n9fAE+wxTf4vFPtcHEj6PvXJmbsKVBmHEghAG8TIz4hByRk9JHDiBPDvTpdsNaPIPzdlDGOj5PEu/wzqXAI+HednNgowmNABKVBpfUe0lAtEKJUsNVM7dt/POm0pLL9xB+3lmsTh1wzbWecmGp2vtBY3n6SOiUi1N64cAEmJO6qdQUG9+m1V3tnBtA/9jP1Da2UjwgbCyd8yyyKAJcI/M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHZKVjZadjJkYjlwOFJRLytwN3FqTWJmL25vVFBYVWZzcklGNGlrblo5VFd6?=
 =?utf-8?B?N2tHcmJpVDRjODViaUFmdCtGdW9URmc4dTFROE1jaDFSMTRNK2lHUGovaTVE?=
 =?utf-8?B?TjloN3c5UUsrYU9mRDZTdjlHN2tLN2RmTGRaWUdtY0tLai9uM1l0ekxEaXdt?=
 =?utf-8?B?YS9VOG4vYkJjekxOLzFJTVNtZDVWclptekRwbVBwdkJhb2o1eG5NZ0d0K2pK?=
 =?utf-8?B?MlZ1c2s3NmlvemxZc2RiSUhnaDFqRWxHZWxvVnRaMEYvMTlsNHZkTzVEY1M0?=
 =?utf-8?B?VlRJOS9rYmcrMExOSWNOODJHcDMyQ2V0MU5RbUVMQWdObmdTQW5mSC9iRXcr?=
 =?utf-8?B?RXdJSnBSMVJVMjVpVm9KSHc4TkMzQUlaK3BnMUJzNGJicThxVmdqaFkrRWhU?=
 =?utf-8?B?S3pzYW9FUk9NWkZwOGpQYjlXc0hlQ1JxZlEyUU0xajRoMGRiZkhxSDJhZ3BX?=
 =?utf-8?B?OGV6bVcwSFBkaDE4NzFUTEFPa2ppZ2hCekFTUFVxclhXdHplUW1XYzZpckI2?=
 =?utf-8?B?UkRzcDR3WWhpOWRubEN5QkxqdjZyZjRXSjBWSE9WTXE1SFFtbFExTUxVanph?=
 =?utf-8?B?a3I4NVFWcHRVWnU1M3hDWXl6cDhTbjYxWW5FSUlTNlMxQzhWcHNFRlhLMjRF?=
 =?utf-8?B?b2xCQWRSTHY0ZG14bVpZV1MyNnhJUkxFQkFTK2VoTmtNUHFQOE1vaVUzRXlH?=
 =?utf-8?B?TG1zKzFnRzkxYVc5ZFRlT3J0NWJHTzZCSEpmVHAxcXowd1BMM3pBMnB4cm82?=
 =?utf-8?B?VnZwcjRVTjEySVQ0YUVnR3ZaSDh2TXBrQ0E1SHBlNDBneGg5RDNleHlXRXow?=
 =?utf-8?B?OE9xUSttNlpOcDVHZkJpS2xUZG9BcXpuS0huK25pRjQ1czFXU0FQQXR0RUQ4?=
 =?utf-8?B?K3pzNlMwbEE5aU5ZaXdMak9EOHhFS0ZaZkVKT1RaaTVsRm5GM2o5cXBvZ3E1?=
 =?utf-8?B?K1BYMVV0bWFZMzNhZnF1SEhHZlZTK0RHdU15VllVY21LdXdtZFo3ZjJORENF?=
 =?utf-8?B?c1VqcjNtRFNrWnJvSGRHYkVKV0ltbGN0UlBxMGdRelh0dUJ1Z0w3djcvMUNJ?=
 =?utf-8?B?Rm1ncDJGTVAxR2YvRjY3UEQzcncrbysxL1R3ajZGbGNnMWZHNElzb21QMFR4?=
 =?utf-8?B?SFFpMnJndSsrTVFMcm8xTktNZGpqNlZKeWVjanBMbDJTUUJVZHluYzZlZzEy?=
 =?utf-8?B?NWoxS0l1RTY0WkRhWEhDMFh3RWc3N3ZJQ29VWXNzaEVndjdUVEN1ZjZEcXhj?=
 =?utf-8?B?U2h6dWo5Q0h3Q3hvZ1NmYjlNS2J3Rm1OV3lWcFM4b0psbEFSbDFjc3dSQTBG?=
 =?utf-8?B?N0hjd1Z1ajEveDFUSng1U0xBZWZoWkhPMXROR00yWVEwaTd1WWMzSTc5ZENZ?=
 =?utf-8?B?aEV6Y2czaWhGZHE0TTltZTk5K29CZzNHNUtQejR4eU9idVNibSs4cXM0QTBw?=
 =?utf-8?B?SDFkSWlRZ0NCTlM4ZlE3bjc3TitIbzJrM3BQN2VTWGxPSjYvdE50bnBKeU9W?=
 =?utf-8?B?T3VuVjQwUXFPdGJBNVlxcHRYODAzbzgwRlZ1U3JRVGNUQVVjNzBPWUtyR3F6?=
 =?utf-8?B?QVgrZHd3Wk15d09taFVsRlhNRDhUUFZ3RlhVUW84OGNSYy9vMVBLZ05QTVJw?=
 =?utf-8?B?RmtNNlczalAxM1lzcWR2Y0h2emVYWUJaNURTcTdjVW11Vko4clg4aEluZktn?=
 =?utf-8?B?b3FXUkUzVnk2QnZWY0dSanFETXdieEh4NjhuVWhYWUIyWUY3aHlvSXRwZHFL?=
 =?utf-8?B?L2hDcmdRMm5ZSzdIV2RDSlBFNmZRczBQU0lYRTJSRndxVWZEdWtRbFA5cWpN?=
 =?utf-8?B?M1lYZmt3aXV6cEkxQi9Dc1pvZDdxeDFWekRpNm9NTzFLc1h2eVA0VHYxVS9M?=
 =?utf-8?B?RUVacUQwY01WWENVbTc4ZFVmVElpSTBHTmtwdW5UZmF4MVN4REJSYWVoYWhs?=
 =?utf-8?B?UHlUcGRxM3gxcVcvd0hhdzQ1bnJVS1plZ3FQdUdleFJHei9Da1NkWnRJb2xN?=
 =?utf-8?B?eUdCNVgvWWg5aGpXVU5ya2QyNVNjbFgreEk1MnAwZmhsaEFuaEV3bXIzbElw?=
 =?utf-8?B?L2tyaHQ3SnlCL0VLSmNZRWtiTFhEWHJnV0VOYk5aR0lwdjkvSm1oRWxady9i?=
 =?utf-8?B?U0FPLzlUNDhwVmh0bzFXTWNzUndhUVpaZ21taFJWNnpQKzhZS2VOZFU2bjBl?=
 =?utf-8?Q?nznmI/YmFB6f7UyYYMwJ3yUxhosANmy0zIn6wA9vNa7G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEC0DE8021C94D4EA4DE4D2C51001C79@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d03fac-b736-4934-dc9d-08dc3da6e822
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 06:30:24.7837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xm0d0S51G/oapfRMZEmtc232UXvms5V7WpGvmO0DImAbfOfOw2xWL/cfq6azVLfuJeVlbhPdipO4jvJdb+SrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_223030_665755_73DF4A42 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy81LzI0IDIyOjAzLCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gV2hlbiBudm1l
X2lkZW50aWZ5X25zKCkgZmFpbHMsIGl0IGZyZWVzIHRoZSBwb2ludGVyIHRvIHRoZSBzdHJ1Y3QN
Cj4gbnZtZV9pZF9ucyBiZWZvcmUgaXQgcmV0dXJucy4gSG93ZXZlciwgbnNfdXBkYXRlX251c2Uo
KSBjYWxscyBrZnJlZSgpDQo+IGZvciB0aGUgcG9pbnRlciBldmVuIHdoZW4gbnZtZV9pZGVudGlm
eV9ucygpIGZhaWxzLiBUaGlzIHJlc3VsdHMgaW4NCj4gS0FTQU4gZG91YmxlLWZyZWUsIHdoaWNo
IHdhcyBvYnNlcnZlZCB3aXRoIGJsa3Rlc3RzIG52bWUvMDQ1IHdpdGgNCj4gcHJvcG9zZWQgcGF0
Y2hlcyBbMV0gb24gdGhlIGtlcm5lbCB2Ni44LXJjNy4gRml4IHRoZSBkb3VibGUtZnJlZSBieQ0K
PiBza2lwcGluZyBrZnJlZSgpIHdoZW4gbnZtZV9pZGVudGlmeV9ucygpIGZhaWxzLg0KPg0KPiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDI0MDMwNDE2MTMwMy4x
OTY4MS0xLWR3YWduZXJAc3VzZS5kZS8gWzFdDQo+IEZpeGVzOiBhMWE4MjVhYjZhNjAgKCJudm1l
OiBhZGQgY3NpLCBtcyBhbmQgbnVzZSB0byBzeXNmcyIpDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4n
aWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IC0tLQ0KPg0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K

