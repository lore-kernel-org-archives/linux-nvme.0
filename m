Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D4FC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 10:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o/HCOktaQheYuQP6gSAYtOZx4T4bt2l35H+0gO5eWMc=; b=ucnOj8gQ9mVfESda8fSBYnjrb2
	0RocV3kox6rBUz6wqV4AWrPrygDdbMR72pYMbzr6c21qBLzgsQRq55gzOwxEHd0sn7E+vzFRf8/Qb
	sOdVe2QuJoSBKlLthP1V7pyywtg8pRNSN/N7WYutCUftZTcddFjYufbiubp8JmaiHdKzmNRyORB+t
	cKDsoQEsG/6NJ21QkCc77x37NTAYnIk5HX+VIdocpZlUFpf8wvaVETMN+rLXsS1EvONUKWC0i8Oq7
	SwWhDU0+w9U30lpT2ctZa45ZdmYGkuUgqNhuNe/cmNUJ76pM7ar8rMh2V3/GvhSZeLesiR5Vuhf2N
	EfKAk/YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nITJm-006bkA-VP; Fri, 11 Feb 2022 10:38:23 +0000
Received: from mail-dm6nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::624]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nITJk-006bj5-NO
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 10:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCM5sXGhsl9/Lh0C2sCEQ+bLq77aofG2muzFMpHAUTyaUrQpQXpeahTECUumolsHN8fow4hHVqIzFDcL6XeRSQaBDc2tZtmx90zMFTSSBhKGO6OUv9iAMX0DOfHI0gaQsDvDdy/vuRQkN7wvW77Ng62bujX6ha+a1wRR5Y6Edyh9nK0U0bgj3bAME0Vk8Sz6SLs4h1s4iKUB59MAl1bdYWvT64tsX1gcnx+0mSVVSoHG+BMYKekreUVPzSDPN+2Ncrplxgsk8jz3sYBg1osItd5yhoMHTQaOV0MfHh6Gx7gC/tqHHYWqn/65as9Gd4PVIOk/4ITqVr5B4N7kvFY+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/HCOktaQheYuQP6gSAYtOZx4T4bt2l35H+0gO5eWMc=;
 b=YyesdTEUp0/NAlWlIeFqc5CgUNO7wkLzxaoRTLVdnkwJjlqjgRP9Tw1uVWHZlPUPy9cfsuQhzPsYwOlnZ3M8Wcd/QXkvyn5mG51Y1cazTt71ROiN95YkFcYD6Dj49CNHNfOVoLGbTG3+i1w638EhkMekA5wQe5JoLbku6P+LLn2TBlGlh37/T/CtL5cwH5+GBBhBQZVxNoSgtaBOOSH2ljZcDGjdZx2ifH9TjG7E/iVy9ERqAkAtfdXCiRV1GY20UD1rkFgH6ctyjtJmfJbn31Cj1baAVQWnF9CDxul9dbChoxKWo2EnHuNV9UJeja5hjjSJ0Ee1c2SL5pzRsZ7eXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/HCOktaQheYuQP6gSAYtOZx4T4bt2l35H+0gO5eWMc=;
 b=gaWsNlEUuu7IBw/ZoZFCKV1w2T3FllslTVuzEnq0AwiRPijZmNDE/24J5SS9+aenMcl2v3k/qUU3urMoz6OPkj6mlsxY4QXCDTI6TN+YtvvXAKczAiORwF/ThwootPzMtUkGEWsC6sq5h3MQ+Ek2kSL+YZ6UlICNr6Eqcr/x2S5c7rEoWN+uVomjRCajHqI9ntCCjHrp2QQPV3Q3tvPqh3apUPTxKwbaBvTf26klWYQU7mpE6vsOAdaDpjywh6LDGt2edqZ/wlzEi06Tb0hNJLlRqBCYlmlojQUwcFQrZE/HbpkKWZX6QLUKXIof/NEGBHw0nC9MtS0YOl17rr+iiQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0111.namprd12.prod.outlook.com (2603:10b6:301:55::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 10:38:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 10:38:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Gopal Tiwari <gtiwari@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: Warning traces for WQ_MEM_RECLAIM
Thread-Topic: Warning traces for WQ_MEM_RECLAIM
Thread-Index: AQHYHv5PS+XdWecOEkaN/GUPTqNiD6yOKPiA
Date: Fri, 11 Feb 2022 10:38:17 +0000
Message-ID: <be11d8a3-995a-b434-3152-3c0b6de9503a@nvidia.com>
References: <CAE-9DvtdE6AA9F5zjFqTwZWtoPZJ45o_rx_oce=3smDjh4E24Q@mail.gmail.com>
In-Reply-To: <CAE-9DvtdE6AA9F5zjFqTwZWtoPZJ45o_rx_oce=3smDjh4E24Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a05e9524-fa19-40cc-2be8-08d9ed4a9dc4
x-ms-traffictypediagnostic: MWHPR1201MB0111:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB01113FEAF2D07ABFD871333FA3309@MWHPR1201MB0111.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORWaJrNoqZL2PQgvKFnsKei2s69T55QQU3kO5kGF/CrVGTAhl22XrGFpt/7BuLKssc1Fx0LMYXBy8936ndCIE2cagg/BN0a4Ad+Fgc73U2VUC8AvW5furQk/NSfk0pWEY7VUoJjLrHdo3OOyCyI7ruRy4hLE7RzjQXb3vyx4cBidx33VXZqGdwXymOXwy/jb3CEmUDk6B+nBEAeXhPlEUoCtN3zdcjWB/TDqr37htYx7rTP2MNCWHxD7997p+rlsrPU4afxIny892uanUIA1Win/DErXNvZGJCMCc2LD513F4pL/TIdrYzwl8cAOqwb24vZ6hyT4HNcaY+Zb5k2D2gDjtSmeP3yoUiPV3amJzwbT0UOm5tSeg5bISXPv0V4KfFBJevmNry8LZvJtaFNX8kCql4tfcGujPPxgLap4NIcBC9+vqqVaxwOsU/LCh2nq8CXENtDg0iLS0wMzNIwibXHmopG9v5JOUz17dq8+76Cc3viujJLgp0AJs3dNx/fqAtW/zsNRpIpyPP5xacB19mUdf6RZFc+Pba0r69BUZlNx1GsQLhlt9mV6ZYndbz3sUdLKy4IrII1LFc38YcaOEKX3oKRT3hUixNuHQ3HGp6HPKLUELRfXftAyVXTgp7nQ9CTm40iJNJ5G/Jtb+lr6GdSJ6d6lLreYbZ0+YN3N8cFIfNB8NCYZinCkDgsMNb6xGeo64o8NYcgVPL9k/XhitfJJLNqpO+UkhSpxxt0a07zQxQLPxg02aOGWhXsRamYUqVwSg1lDT3bJFefdbBwM2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(36756003)(316002)(6512007)(4744005)(38070700005)(83380400001)(6506007)(86362001)(31686004)(508600001)(31696002)(6486002)(2906002)(122000001)(66446008)(186003)(2616005)(8676002)(71200400001)(110136005)(38100700002)(66946007)(91956017)(76116006)(8936002)(64756008)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkZKWmhUU1pVN1dqejdON1JIbi9uNG1SRWc0Ymw4RW96NnV1ZkZrQmNHMWVh?=
 =?utf-8?B?Ykx0L1V5RGFld0VQZ2RYS1F4VklvQXZ5c3pQYy9pcmVjUEZ2LytUcWxFY3ls?=
 =?utf-8?B?WDFpMTVNWXJGb1hESDN1OThVTzdvc3dFVkViUlhtV0hCcm8yYzhCUCtmSnd5?=
 =?utf-8?B?MXNOeDg1a1ZZRm9adnM0eTlCWjRQR0F5ZG1TZXFkTm5Sek0zSTE0THhSMEJy?=
 =?utf-8?B?bjlNQ0lCRC91YXZIcG1DNzF0K2ZMY0RmS1cvRDZCTWp2QjBKTE5vbUduMXRw?=
 =?utf-8?B?dHhIWVp5RGR6dTZqa1JwVTB0ZUdzR3kwVTc2S1FubXhsNFMzK2J4c1k5WlUx?=
 =?utf-8?B?TDhhM1dxK0JseWkwdzZYSzBicUdEbU93LzFscFRjeW1weUZRa3RvV1lBTkgv?=
 =?utf-8?B?ZUtyQXFHY2xRRjczdXRuME1MWlZac0JrUUtESGZ0eTFQK3hwRnRUNmFkaExr?=
 =?utf-8?B?OXFGRElsRjBTYVJIcWkvNkRrelFWSmZ1RU5IUlFFc2RZWEVkTkR5ZkNzNnBT?=
 =?utf-8?B?ZTBudXlZS1ZqZ2dwaHZob25BcERBTlYvb2s2SUphMGJJSUYyU2lPd1ZBODBj?=
 =?utf-8?B?OHBKZjQ0Zm1hWTRhbnRKYmlGN0RkWVM3WTNIMlJPSW90U1krdWVweFZxRVhL?=
 =?utf-8?B?dGFxZXp6a05VYXFsZUwrTEliRTE1MFQ0SWk5YzQrazlGY2lMM3RKNGNJbk5T?=
 =?utf-8?B?K0ozQ2pYa0plSWYxbiswdlFXZ1ArZVJIclV4Q21LeUhOTW9MRjRWNzNRQ052?=
 =?utf-8?B?MCtrK2hnaXByTTRtWWlKL3VEM215QmJlZ1BETDdaMXpYZk9uZG5HMEd0N1ln?=
 =?utf-8?B?akJPQWNRSDBBWm1NYXRYaG8wY3hEYy9sRytxWUJjQTNwb1o3bFRlRUE1QUgv?=
 =?utf-8?B?blM2aXZrSVZoSVRQMWJGVHIwSlRMaEIwY0lCekxrYmc4eHNWcnhUZXZpcDl5?=
 =?utf-8?B?VGlSQjNDVEtwVDIxa3Vvc2lrNE9oWkdmci9JU3NUOHI3MmZFb3Axa2FJLyt3?=
 =?utf-8?B?eitnZTJDTlJITXozOHlPd0VLUE1yNVhsWHp0L0tVdnI1U3QyMDZnemJBRC9Y?=
 =?utf-8?B?SXlvSlpNZjVYSk5JbU1ZNURPY3N2UngrU2dyWVNxbUdIbDdEemduUkpDd3Bw?=
 =?utf-8?B?a1JRT2hiY0UwUno5VkNuY1BXZFJiOGxvajdpamJFbUJ1ZjhRRFBqOWhVaHF0?=
 =?utf-8?B?ZzIrM044S0I1TUxSSkE5eFFhd0lta3FEMzl5dU9mNi9QZ1BJOVlBcnZMZlRt?=
 =?utf-8?B?VTNPR0cwaFF6eHJBc3p6ZmRUWUpOUXVublVNK2JVM3JuQi9sUFV5cThVTzh5?=
 =?utf-8?B?L1pJdWtVNjlKL2hsTjhLdjdVeUpIcE1zWTVydXJnZkdwWHA0bkNTZTcxMFNL?=
 =?utf-8?B?TDJDb0tzL1RETDh0TGNQRUp0RzdQRnZCdDdLdk1XQk5TY0pmcnNPanFjbk9X?=
 =?utf-8?B?OU40WHNLRHdIRy9FWlFXU3l4eGJUTXZPQ1cxSXNFVTNOaSttSVZVUzgzaW50?=
 =?utf-8?B?SUp4SlZycFB5UEU3Y1k0K3ZBQ1Q4KzBLcXZibDhCWWRVcXkwVk9abWIyeFhR?=
 =?utf-8?B?ZXMweFF3MVgxSURQbEJNTHR5TmJjeDZTYkxncS82VEJWeFpGbEpmQ0tHS3pm?=
 =?utf-8?B?SWJXcDRPU2JBenlDRDhRcHYzT2xJazlMZlpZRjRVbjBVamlDTkJrOGRESDBX?=
 =?utf-8?B?ZURHdVZTU3dvMWRacm9JVnZHek1Ib1J2cUNDUGhRamxNYTEvOTlGY0s2SUFo?=
 =?utf-8?B?ZzZPOG1FSW1XRHArRGMyWWJSRTFFNlFWRktITCtzY0czZ2FlYk9Mb01zRlJy?=
 =?utf-8?B?NHd0OWFFKy9DU2tIQ3c1alFEMDlCUzVqa1RYelp5VlJKOGdJMHNmd2lJM2xL?=
 =?utf-8?B?ak0zcmVjcVI1RDRyaWY0Nk55RTFTTU5uUFh0SHB4NDQ4ZnpsaVhKRTFyVGwy?=
 =?utf-8?B?Z1JIZklzWHRyUk5EdXJNYng3dk9UQ1VHcVZtdVNQVDJjRHNpdmRudm1Pc1hs?=
 =?utf-8?B?MFo2Ujh0SDlGb3ZQSXZISVJFUzd6Z1JzS0pYY3pvckgvaE5HbmhZcVdKQTgv?=
 =?utf-8?B?ZjduL1RDS0QwVVNGcDUrMkFNYkREenZrS1M3REtvY0l6alg0ZWlQU1pKVWpI?=
 =?utf-8?B?TmxVUXNKalhaK3FsTE9McEhHK0tmY2VIT3UzWVdsUDZmWmlpWXVBbDRncXNB?=
 =?utf-8?Q?GGYi85tRQKoJr4FwDzYXNydHx6iCXNRLObWFuD5twLt/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F98E971AE0494B4CA01D9188AC284232@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05e9524-fa19-40cc-2be8-08d9ed4a9dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 10:38:17.8784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOu/WQvBmZgRDGIZzQb0q0cjTid+ObzduT9bfU6x7BtPTuDglFX5FFl477jr8GncC/AyhEhuCegXxfpQbWu3JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_023820_801078_E5794B77 
X-CRM114-Status: GOOD (  10.58  )
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

DQo+IERvIHlvdSB0aGluay9zdWdnZXN0IHRoYXQgbnZtZS1jb3JlIHNob3VsZCBhbHNvIGRvIHRo
ZSBzYW1lIHRvIHN0b3Agc3VjaCANCj4gd2FybmluZ3MgPy4gTGV0IG1lIGtub3cgaWYgeW91IGFn
cmVlIHdpdGggcmVtb3ZpbmcgdGhlIGZsYWcuIEkgY2FuIHNlbmQgDQo+IGEgcGF0Y2ggb3IgYW55
IG90aGVyIHN1Z2dlc3Rpb24gd291bGQgYmUgaGVscGZ1bC4NCj4gDQoNCklzIHJlbW92aW5nIHRo
ZSBmbGFnIGdvaW5nIHRvIGZpeGVzIHRoZSBpc3N1ZSA/DQoNCldoYXQgYXJlIHRoZSBvdGhlciBp
bXBsaWNhdGlvbnMgb2YgcmVtb3ZpbmcgZmxhZ3MgPw0KDQoNCj4gIMKgIMKgVGhhbmtzDQo+ICDC
oCDCoEdvcGFsDQoNCg==

