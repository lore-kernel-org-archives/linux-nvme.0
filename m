Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55148C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152DC613A2
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 152DC613A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fd+qIwCg0M7Q1epHFMQJk8b5cUgGGwtRAZOlxNK/j3Q=; b=eTkpyqiLJiaezglUAAcH1dVFtX
	qshYT1rYOGVfYHdG43kv1c6l/H6yXVFCPiGoR+SPG6PrCgRjy+7UoV2ivHWqTi0UYXI+vh7f1OgFp
	dTTqAjZQYYTd3B8K23CVErOyqlpNoQiEOjIozCdeWTqXqWECMY/I3swHQZoBULd4cv+igu1PB9DjW
	r2jtWxWoYwMaCaCsQGposgV0l5YIlqJloIXMly2kCf3IUNgmzmFFXLd6b3L/1Cstp15Fo1f6xBZ5m
	eh+WwRgwDVorHESFyWeRP/wRm7RfBCd5apeAKh9+5he++VMvf57NhVoB6wElvVsJImio9aG/va5UF
	artiHh/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnWeQ-006i9v-N2; Thu, 18 Nov 2021 01:55:46 +0000
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com
 ([40.107.236.49] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnWeN-006i8t-Jb
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 01:55:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8TFxbxAENsDNOVLxAUPOK9bJGnqNVkOl65htur4bu4c379PVFUyNcVPCIMAJRujVEJJwZ0ISP4J7rW/4C2w/l8zOP7lvabg+xVACulnzDsC4RqMADeTH+fD7iQhWAE9rUd0qxjL79Fi7cKQElJ/64cwA9v8biEYHA6pQtOoVWXSWqE7hW0UAAQE+3bXnbuVnDPtlODGPuaTOVlt2p2x84z8N+Hb9xOdoqTu/A1QTa2WM7dF9VroestuFoiRXRNgo3dTJKYsijOyJmKmoaEsF08v8coGrl2JxiQp7zqBq3n4id+O/9wyiMOZQRmSd6+EEIAf16/JAuQMMjAuGrgp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd+qIwCg0M7Q1epHFMQJk8b5cUgGGwtRAZOlxNK/j3Q=;
 b=CqNJapzOEpXpLflWuJrQkGaUL5YGiIPSPvgxBc5OaU4uMXwVaoG+y1aB6vT0z/faNkJwETv9MzIlEapJaTou2rLe9ZYZ1+aIGeKoOagMA1hr6SJTzPh21fwIgNJU/BcMjFzaHvU1YtUp4pJ2VZmqL8AHbZF8Ort/jN9XG8WX5phi2Tdc51qN5IYvf5EpNIMEgoh/wd42pmXewqISquBrYbudJdDI/e3t5wxs6YlsLNEQjCgogjdoibltrqZ0bk3sKlABfthxrw5CTVfHy4AZLoS0dIpP2kJj3AesyeM9/b6HAqRDqwlnb5/jBEhYrUALg8PfBToYK/w6cWPpFHqhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd+qIwCg0M7Q1epHFMQJk8b5cUgGGwtRAZOlxNK/j3Q=;
 b=AMxuKnuD9qum21j8Q3hcs52bl+eaF7np/3WEmvVs8qIicQXJju2HgzWiuoX9HU4Y2pHf+Kt3yzXogl/FidLw6wlre3QCHycpZzOt7E7F8ssaXToZMb7LwGb91cWcSaLVXfYVU262ml0ecexMmyx7xr+9ubQhy6jYaAEstDFJs5WJlw7/C+oDyRG/sHW6BDzrM40ubJQC8tNypHc5vkDk9os1cgJnZizkTlJnkpPvVcOGcoAZn2z5fBdHZAIZd0bWdMm5KN8WH9ReKuCoXa0rEF66eCvoLt3dIiwmLLQW8vGRX75NPDnwRz3YTR0JfOYgXdhhlqDfCi36ho0WtTP5zQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 01:55:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 01:55:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "wenxiong@linux.ibm.com" <wenxiong@linux.ibm.com>
CC: "keith.busch@wdc.com" <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hare@suse.de" <hare@suse.de>, "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH 4/5] nvme-cli: Add support set feature event in PEL
Thread-Topic: [PATCH 4/5] nvme-cli: Add support set feature event in PEL
Thread-Index: AQHX29n5/5SZOFCWvEiBbhO600dwwawIhv0A
Date: Thu, 18 Nov 2021 01:55:22 +0000
Message-ID: <01347d85-5fd1-16d9-14e7-f0c42115eb96@nvidia.com>
References: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
 <1637165088-17007-4-git-send-email-wenxiong@linux.ibm.com>
In-Reply-To: <1637165088-17007-4-git-send-email-wenxiong@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 238d0bf1-440e-4a40-f032-08d9aa367b74
x-ms-traffictypediagnostic: MW3PR12MB4348:
x-microsoft-antispam-prvs: <MW3PR12MB4348C4565200A04FA0CDC00FA39B9@MW3PR12MB4348.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5d45DgvGX9e+hD70c1z+bDQMCVSJVor8I5ixdCbIxs44aTgbP7GPRx/hl5dzRTV36DrEfcjdm0d4r1rop9JUGvdsVKxl8TDSiob09LjzkMjDCVx5CyiACkK+lUYEM07R6Qz5bVYYml0qARg4Xk+CqUH2GvJFn+CQbsmonoZKREYlFUL2nMSxiLqNFFJ5A7sJ3ULHVh90Gaj6dpQ6s5ciTIjA62WKmwVLTSk9PRjP5y/oZD8lD2Ux6KshLVBMeWJWnBm4jTNzCwWBnbGPs7e1LQ9ExA4VskQbPsDmuHdq0CfMnNL3HTkg75aueIG1I5M3o/YDDqkutvtYksZomeLiSVNzVx1DWdXAq/vGY1KabPB8U4Qp4T2WhMUhJZG76Bv0i0E1JQCn0orNpszWXtFuusfrc15qSt2Uygw+26QAvbeDKJMnZGShfPihlAEydPStjkn+2jtlGItkgD/EZTQRwX/sXilH0v1z7Xv4Z3MM3/SXEBTib+GxJ42MbpcVcRWfwOlsgZbSwPZFYcYMCrkBeVaaNmrJxDpsCToRAqaV77ZRhOn01FzQ2L5ITQ7l6nfrJH0VKtxBpi+rf+kMv5nLvSMBvDR70rmn/TNLXZVkEUH5DLh6TRyXK58NDwXE2OqEngkfysJK5/yUjrzgi76tNDOmXNMNgYSIcBf45SQca3AILbcN1z/uQieeRXEJxR2byVJhqkmdBLg1nnbGH7wovVr7+VRGY8l607VqvLXYiB0giV+o0yKaE0zCBbk1cbXbKYgt5ohQLFpUN4yKUsuOTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(558084003)(86362001)(71200400001)(2616005)(83380400001)(38100700002)(36756003)(31686004)(6512007)(8676002)(5660300002)(8936002)(26005)(6486002)(6506007)(122000001)(76116006)(31696002)(91956017)(508600001)(6916009)(66556008)(66946007)(2906002)(64756008)(66476007)(66446008)(316002)(54906003)(38070700005)(186003)(53546011)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnorVGhsME1kK3lZMVowT08zL2Z4OHUzVzVKUTVpekxvRDExc3QyNysvZ0xJ?=
 =?utf-8?B?bG1oZFdnMVhBMzgrYmhzYmVhWHp4djgxZzZaeVN3TTRPQ0k1SHZXU1VyaTVm?=
 =?utf-8?B?a0RCSWZ6ZjRMY05LNmE0TUpPZDNTdzJERmJ3WVpGRzlmRitXOXZjTW1ndnBp?=
 =?utf-8?B?L2dTaElPM3JEU1pidE1FZDlvZVVreFhVVlBKZGNsams4UGVxeTQyNUl4MTdj?=
 =?utf-8?B?aDMrcGJJSGZiMmNDdE4yRDM0bTFlQzN2bFkwMVFBWG9HSkl0NkJWWlEzSVdJ?=
 =?utf-8?B?L2ZaYzl2WFpGdUY2Tk9QN0VpRGdkREl0cy9uS0lrby9mWkozeGgvNzRhZzdy?=
 =?utf-8?B?ZWhpaFBXbU53Ukx1ZmlYREtvYlRoSE5ERWlxMFIzTU44dk5Uc0grbzRabFkx?=
 =?utf-8?B?ZkNGbzlWQUc1Sm5CVk9POTdiY3VMUlpCUXlPMUNzTUM5WTI0b3I5U1lKZitU?=
 =?utf-8?B?VndBTTZMYTI2cE9RYU41dVRJTWpGWlBIWFliNGFuVS94L2NuNm5zK2dmem5N?=
 =?utf-8?B?L1ltV3V2UW5xRFpublRzVUt4NDNuZVRjWkxsRXdIWkdTOGlKWXU5cll5WFRI?=
 =?utf-8?B?dDNvR1NmU0h0Yy9OakxZeDdrY0tvcUxRNU9UTENzeHNXdzVEQlVDeWE1dUlp?=
 =?utf-8?B?b1loT1BlNXY1U0t2N0xkaUYwMGsxbEpsbVNmb3JVL1RtZmxzVkRab243THRh?=
 =?utf-8?B?Rjg0d0I1UmUydzdpK2VVRDJ5ZU4zcWNINzRYbEZyNVd2Ymdjd2dIZHM0TmNq?=
 =?utf-8?B?ZXUyN21GMi9pN3RRSjUvMEU5eWFkSHN6UmYxa2lnMStEVGo2WnFRamdTTmh4?=
 =?utf-8?B?WVlBTUlJdjhNRlVIY1dyOXdyYUxGenAyRUVJVjk3S2hDYm5xWGdDQWtyNW5D?=
 =?utf-8?B?UUFDeWhXYkVpU1BLdVh1d1h3dHJsTnY1WHUwZDFDRlFabmE0T1JPVUd5K01W?=
 =?utf-8?B?aFRxR3llTC84aXo5UXY0THVNVmxQbDZrUEs0Mm12TnZ1ZzFlUmhwK0FNcGxR?=
 =?utf-8?B?YkxvSnphWUlNTDR1d2krandjeGdQNEloY1pHU3ljUDY2UDIzZ2R2TW94UGlh?=
 =?utf-8?B?bXZNcWVueThwb1phY1dvb2RDcnZYNDF1ZUdCRnZaQjQzcm9iQWNJUnlqOE9O?=
 =?utf-8?B?NG80Qng1Mks0a1JFM1BuUm5oRmNRaWd5MG5LeXpjZWVCMThhZUJibW96ekxF?=
 =?utf-8?B?cXFWUDFKdXRSWUZzTkJBUjV1R0pWRTZWZ1VRTTdmRG5NeHhxMnFuaG54Z1ls?=
 =?utf-8?B?RGVVdmZSRUVJek1rejJvb05XZjhZZElpOVNPWmU5WmxjVDdvOWtqZDlOQUdr?=
 =?utf-8?B?K3N3WHVHZW9DRktwVUJuT2M3RkV2VFdoZm96RmU2VDVRSXJwajhlTUpvR1ZL?=
 =?utf-8?B?UDVjdms4a2FDTjBrVU11UWh2VHAvRWRHcjVqdkpOOElXRFhqVGxSdkRPbnJX?=
 =?utf-8?B?MkZJNTZaL203UHhTOEVoR1Fzd1BMTWRtWmVBejYxSFEzamIyVzVPMnlKZitM?=
 =?utf-8?B?R1d6S3lMbUJNNzE1WUJnTzBSMFNXMjlsRzI2TGp0ZE1YblpjWUxQWVQveklY?=
 =?utf-8?B?R24zMlFqNWI2SzlKbUh6ZjdyOGJpQmY3cmRpeEIrS0xYaG4zT2xwdlZuK2Rn?=
 =?utf-8?B?Ulp6UlhMblM0N0RMbHI1QjRrZ0hVaWVvUXNkdWhlSzdjNmMwbFo1ZEVsd05y?=
 =?utf-8?B?ZGF6VjNYN08rUERoaUo1ekRjTWZvcWZPelJuTkVtS2s1V0tKbGw3bExYb0Nu?=
 =?utf-8?B?dWVDOTVSdFFVcUQ5R1g4dGhBSm9NSHgrai9ISzZWNnMxRGEzaE5qd2lyRHZX?=
 =?utf-8?B?NGlpV2hLTVNFandoNEFjYm5ReUFJYllrN1piUHpIaUFTRm4vcjdOalprZlVk?=
 =?utf-8?B?U0N6dW5uSzQzYWUzR2I0TlpSYVpCY1NrYjcrSlFGR0I5eVg3NExLTXY0QzRy?=
 =?utf-8?B?TGZJaGdRcy8zYnVoSU5GeU5ma3RkU1M3NlhrcU9WN2ZBNmtrUytBQ24zN0tC?=
 =?utf-8?B?OUZOT1pFT3ZMQ1F3a1JmaEpEdGw5VmRxeGZab1VyTEd6NDJzdFNIemh3Tk5l?=
 =?utf-8?B?d0t1RkVDQUhTZWRaZG9jZXlQNU1OVTFuUUw0RVFiSis2VGduT2hvSnFkbWFi?=
 =?utf-8?B?ZjZNUCtNTG1UYmJLV3AvZHkxMkFxUTVrdFpsNXpYbWg5YTlrODZuTXZoYTBY?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F328536A905BCB46A436A9BCD75F346E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238d0bf1-440e-4a40-f032-08d9aa367b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 01:55:22.4723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GanMzwzwcr/b8cX1oe9xD2q/6MtpsPN8nQpSUl22dK1II5gWmR1fyzbm9r0pDsPwoiHbMZbHfzKO5hFR6wPBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_175543_676361_CC52F1E6 
X-CRM114-Status: UNSURE (   9.99  )
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

T24gMTEvMTcvMjEgMDg6MDQsIHdlbnhpb25nQGxpbnV4LmlibS5jb20gd3JvdGU6DQo+IEZyb206
IFdlbiBYaW9uZyA8d2VueGlvbmdAbGludXguaWJtLmNvbT4NCj4gDQo+IEFkZCAiU2V0IEZlYXR1
cmUiIGV2ZW50IGluIFBFTC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlbiBYaW9uZyA8d2VueGlv
bmdAdXMuaWJtLmNvbT4NCj4gLS0tDQoNCmRvIHlvdSBoYXZlIGEgY29udHJvbGxlciB0byBzZXQg
dGhpcyBmZWF0dXJlID8NCg0KYWxzbywgcGxlYXNlIHByb3ZpZGUgdGhlIG91dHB1dCBvZiB0aGUg
c2V0LWZlYXR1cmUgY29tbWFuZA0KZm9yIFBFTCAuLg0K

