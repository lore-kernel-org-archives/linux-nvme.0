Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362EEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:43:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD4A6112F
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CD4A6112F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xzFIqmYVd3pPxPZ23Qn28RljsZxWk5fnDDNaoB2UFQg=; b=YMC0zQ7iSTY5I/
	r5vUocJCNWl2ut/r5wMhNVKv7/i5ZckSL+5Jn91+dRAzDMN/08DKbEj8LDBF6/gnGY0/QBHotHqo6
	OPICyGnELdUmTSmzEmbYKx87lm0w9Ot2mNSkdONJHW3z3XtafM6cGSOzLkNVEHYfSAUCAkKDBpD3a
	pUyyLMVpNK12fF6cy0sCCk7XdUiLNASRBJiQzKeVFgoi3LsU0JXhYYoa3uOG4rOR+lsUoMc8iK9pc
	f157hIKtHC8dnFomfBAjWv9memfK2fSVhqfkqMlMBVCl20I3JRe1Cu6hLyVMp7GNR3oFuKJiPzv+m
	KW6G+DalGRxfn+Cn2FpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSlfR-005eoR-N7; Tue, 21 Sep 2021 19:43:01 +0000
Received: from mail-eopbgr30127.outbound.protection.outlook.com
 ([40.107.3.127] helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSlfO-005eo2-UB
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 19:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex+5ySZjuUQzdhN0yHPDV7+kCZLMxkt1cxQMTVEcnQHZwSIUqEUpj51OCz3OpAQ/eQwcf4qA15jsO+H/wJ5lSrDt8zQBle27NptpqMFxJoiYqUy9Ka76lSrod/N40yip1tryBJATqYBO+bxYNKNNCDpSXioL99Z3JID1tDZuTM400xV9PmHyGaJI95VwQ38lhvAvP4SaqIB41Bt+MKKW2aThlNr0VFKaroQQzuFwYdGoWjrS5ld6hWmtbEpQAdPycz19ZoQ7iHQO6iFZ2WLtjVtHT+S6xmT7hryPcI/o7zIEqkAnuHSGYZPZqM2ovHr3qo/rp5NoDTJx7JQ7De41GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=gof8n7SD2atbcKqTFryVwo4x5ePnQbnG1uiy9gr9fk4=;
 b=iLW9NND/4CsS1Qbuwif2xeuuMvmsHly5U9rDErzgRa4CLj7mcEvB+nErNJdgtUJptZ1kPyzJ6jFxwHGbwUKBImDEzYRSnnWF7VpyHTLdqFaWtAwsYciYDALhR2WS6C/tdt/gWNT5m3LKrHVsa2YNx7ZQftU5LwAEo+9a5eAbRe2kgH5j8gp11pVUXqhejn76F7HfWRr1SJHMoFMNaZhsHnSfjPcwWeJZ6za9GgM99yoPrahC5VkyiGxWGO8wUGmYyEmoy7QgDEAwAjDxhE1U5tYLq7KLbdzajBYS5VfGoBqrs4OzOEHS8SrrSWzvqJ42Av+YLpLX4ABo9HUBDRMf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gof8n7SD2atbcKqTFryVwo4x5ePnQbnG1uiy9gr9fk4=;
 b=j0Bvkczxc47r+wqzXkcdkHbzCPS8DzN+IfIa91XsDHp1LZ4jO/SAdhyPRGpg+MV5Xf9/8NevxjVye96YV1i6bv5Dj4zZNare3mvLNeu2Ed8SL2zmWOMQIx607YYaYgnZRAUwWoWRAi3MAsBLZZslv3JV2ekfkZN32AaYmFzfwqA=
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com (2603:10a6:208:c1::28)
 by VI1PR0302MB3184.eurprd03.prod.outlook.com (2603:10a6:803:17::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 19:42:53 +0000
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::7047:f279:7815:7767]) by AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::7047:f279:7815:7767%3]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 19:42:53 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Israel Rukshin <israelr@nvidia.com>, Oren Duer <oren@nvidia.com>, Nitzan
 Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v1 0/2] update RDMA controllers queue depth
Thread-Topic: [PATCH v1 0/2] update RDMA controllers queue depth
Thread-Index: AQHXrxuQY+hPfAzwd0yYuG1p3IEWFquu3eyAgAAFmIw=
Date: Tue, 21 Sep 2021 19:42:53 +0000
Message-ID: <BFAA4AB6-2539-49B2-A109-96FE4E80D723@primelogic.nl>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <0d80a3dc-fa1a-a048-46a2-edb1bcf76ba0@nvidia.com>
In-Reply-To: <0d80a3dc-fa1a-a048-46a2-edb1bcf76ba0@nvidia.com>
Accept-Language: en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05e4cee3-1928-43a2-87a1-08d97d3800af
x-ms-traffictypediagnostic: VI1PR0302MB3184:
x-microsoft-antispam-prvs: <VI1PR0302MB3184B06BE54228785ED9A0FBD1A19@VI1PR0302MB3184.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8xYA2vYZMnWh3r0nfzE6lk1fqH5ugmwhIY6XSujFQFr8Ggkl4OWUit2oShKE+Q8knpHwhceJMj8fa+0IaqCcFkuNAP4hMTlMnKa039tyiP7dHeeLZYyN43bWPhV/jJ8EFTyYN45I67zXchM1FPH7lj5MML15gLDdy+3K0+N7c2QfMg9Me3dZoN92g/2NkMTZZ1N+0JbHqPVTodF7eRBtlz2+228GL4JNv4tltXFEdad5sxOK+assph88cdrWnkC8xtwGxAHVKk4q+BD45tCY57YuYme2NHc3qAAb5WArBmb+T/PjqVce5X2DtJ45erB1mwOF5sX2h8QLAnMiz/VIUQnL/rpzYva4Wfg+VcAqgfYLw+sAtrK2uXq46DceIwEQUYQrIB/+oMfosqsdJLIYkWfCDZs51fybV7bRhS60w+MB1r/nHKBM8KVUXqzTiTU/ZBAZOJNqezSFKvKZnGV7XuUJB9SzOc5cAYz8RswParB+GlyXrO7MdBfJBPSDqNVejlpcjB9n8aara+jEf79+DoHKpAgmOtrL1qFGqEFOgz8/J6V2rpQJ+KnHmceDB76geruP/5ZqVbSX3gkTVZdAAFHemDxtRX2I32Q/r1r0hMS4KM4JQPp3jUVZGUhm2+afvvJrTeKbCLuaCnflaqFZkDpJLFPhz6mgKsjv+Ay+iORO7CxKYHQwc2LyYL7A5BeiLIZgbcMS6kO4i7kXVxzJgVU9iMdPV5CoJ/M8XTiSTU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB4211.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(346002)(366004)(39830400003)(396003)(508600001)(86362001)(76116006)(66446008)(64756008)(6486002)(8676002)(186003)(54906003)(6512007)(2906002)(122000001)(66946007)(66476007)(38070700005)(66556008)(6916009)(33656002)(38100700002)(6506007)(53546011)(36756003)(2616005)(5660300002)(4326008)(316002)(71200400001)(83380400001)(26005)(8936002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2hSK2FrYitZT3JubnFoNzZFNjJFOVdxMUl0aGV4U0VKTUl0N3ZUU29JcEJN?=
 =?utf-8?B?UGJGQ2ZoZHRhbmFKWFJuTU1wbzVyYmwzTkRXSWdNWUYya3NnNThiZ0prMGll?=
 =?utf-8?B?dTFESHpFR0RRTzQ0WjJVSlZzY1RHQWc2c2JQbTJMMndJaktBMnhTcndxbGxH?=
 =?utf-8?B?SnZnMjFYWW0vVldrK0gxYkhxbEhnL1hlTzZLL0VrSkhRQjQ5Mm80bzNYNTFG?=
 =?utf-8?B?NXk5RU9hREpIdld3OERyQkJZSlZwZk9vK09Tb0h4SWRkdDYyV0M2K3IzZ3dz?=
 =?utf-8?B?WmU0bWI4QjFkcW4rSzhlb0dkT3hvK2RZZ2d4M2MrNHBaeDJhaGNEUVNWMHM5?=
 =?utf-8?B?eHBVTDBmUWRmWVBaOWMrNUU5TEsrV01oWHlYN09rOEZtUHNqNDE5dS8xWm9x?=
 =?utf-8?B?QUNTWGRPeFFuMHpWY1hhSzFxSlFmekI1L2ozRERvYW15Uzk5S1JjZEd1aWw5?=
 =?utf-8?B?a20wdndBdEcybjVMLzkzNU00RUJNb1VqUU9iK1RUUU1vSnNRd3oyZFZRbmhs?=
 =?utf-8?B?Q3QrWUVQNm5YbG5PSTFhOVBrNkFWYWo2VUtQUnhEdDVZVDhrVDNJTUxWUG0z?=
 =?utf-8?B?WWRrbzV4S1pXN1RZSFBHRlpTMlhrSGNiVEpoMUY3ay85NzFrSmhEOTYwRCtw?=
 =?utf-8?B?LzVkZ1VxZGZyR1kxZlZQYXU5MVRhY29yT1RKOVFsR0dIRWUrbjg1SGdqR3VL?=
 =?utf-8?B?VkhXZXlhTGt2K09FbWY1ZmVhTk14QTdNMFk5UGdJbVBTaG15cUFlb2ZRTVQx?=
 =?utf-8?B?SVJjN0lhZ09UcHNlNEtVQTkrbTFlcTJGMm0xY1F6UDIwZWx2WFI4UHd6dmc2?=
 =?utf-8?B?Y1NtVy9HRVJ2L3RQRno1TDd3bm5SVjdYd0hGV21xamVGM0xlL0VkZEtXbTZZ?=
 =?utf-8?B?eG9vZmpZM0s3VllxeHlvaks4Q0RwaUsrV3JLSm50QXlnaEFZdFhvWmhTMjR3?=
 =?utf-8?B?V25qaTYzdDRSVTJ5UlNUQmRtTWsweFJvalZjS2VnMkpnN081MGU1THMrZy9t?=
 =?utf-8?B?R3NRSHRBS01PVFNocHNzcnhreTRWUkM0QklBV1ZoejlxREZOQkU5YXlmem53?=
 =?utf-8?B?bFpuMjlkN05iZ3BIaW10elBQYXV1NUdsakl0anUzUXdwY2dKMFAxeXJ0UFVP?=
 =?utf-8?B?akt1ZUp3Z2tUQXVnQzRxaVc2eUZhSFFaS0VwdlZyczE3OUc3bVIrNlFXbXZK?=
 =?utf-8?B?dXhteSs1ZGZuT0c1MW85Qm9JdzBqNmdaQTZYenJRcTZlbS9XbWNZRG1nRDNL?=
 =?utf-8?B?YUM5dCtReFFXcjI1WEpkeFBOT05jT1Nicm42RHBMZGM1T1lJMXFuZGRzTHE3?=
 =?utf-8?B?K09pZm1hTEtkNXNQV2JKUDBuNkR6c2lhU0FUTzFsczVIQXBjc1JmOVhoVDF4?=
 =?utf-8?B?c1FCSGJEdEw2aVNqT2VtbS96ZnBqOGx6bUZDZUVKTnRZWG16cXBEa2NZcVIz?=
 =?utf-8?B?amx2VHR4Q2NraXRvZHN6S1RXM1NRSDh0NEoyN3lOMlNzSno4QXhqQXRIUWw5?=
 =?utf-8?B?aWJUL252L3ZZcXZtOEdsMkF3SytOUlFEbjdRczg1ZU5EK1IzU0ZPUUZBZEdW?=
 =?utf-8?B?eFhzVmRnbFlBa1B1QzBRQ2g3cEowSHorYnAwYlAvbm1yaGphOW15RXdNWThO?=
 =?utf-8?B?SHl6dFdFZ2VVbmRSeFYraVM5cHllK3VjdXN6V1M5V21JK2hqdHJrOW0vQnFR?=
 =?utf-8?B?OHl5L0RLZHh1K0RwOCtxMGZ1OGIxR0xGNlB2Vk9vV2JRYXMxVjcwa1ZRbjJl?=
 =?utf-8?Q?+HUyF8sHs722Old4+Vn3iBnnjYGhJQmWCbxNFmi?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4211.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e4cee3-1928-43a2-87a1-08d97d3800af
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 19:42:53.1670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5SCw8Zc9MRAKNs1sWTX410FiuLkV1N+qBT2hAiSs5tvBa45ymlo8p47bIFfflOpCtNpPzvI/0etoCOesdWFajQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3184
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_124259_093985_A7CE5A1B 
X-CRM114-Status: GOOD (  18.74  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgQ2hhaXRhbnlhLA0KDQpJ4oCZbGwgdHJ5IHRvIHJ1biBzb21lIHRlc3RzIGFzYXAgYW5kIGxl
dCB5b3Uga25vdy4NCg0K4oCUTWFyaw0KDQo+IE9wIDIxIHNlcC4gMjAyMSBvbSAyMToyMiBoZWVm
dCBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YWtAbnZpZGlhLmNvbT4gaGV0IHZvbGdlbmRl
IGdlc2NocmV2ZW46DQo+IA0KPiDvu79NYXJrLA0KPiANCj4+IE9uIDkvMjEvMjAyMSAxMjowNCBQ
TSwgTWF4IEd1cnRvdm95IHdyb3RlOg0KPj4gSGkgYWxsLA0KPj4gVGhpcyBzZXJpZXMgaXMgc29s
dmluZyB0aGUgaXNzdWUgdGhhdCB3YXMgaW50cm9kdWNlZCBieSBNYXJrIFJ1aWp0ZXINCj4+IHdo
aWxlIHRlc3RpbmcgU1BESyBpbml0aWF0b3JzIG9uIFZtd2FyZS03Lnggd2hpbGUgY29ubmVjdGlu
ZyB0byBMaW51eA0KPj4gUkRNQSB0YXJnZXQgcnVubmluZyBvbiBOVklESUEncyBDb25uZWN0WC02
IE1lbGxhbm94IFRlY2hub2xvZ2llcw0KPj4gYWRhcHRlci4gRHVyaW5nIGNvbm5lY3Rpb24gZXN0
YWJsaXNobWVudCwgdGhlIE5WTWYgdGFyZ2V0IGNvbnRyb2xsZXINCj4+IGV4cG9zZSBhIDEwMjQg
cXVldWUgZGVwdGggY2FwYWJpbGl0eSBidXQgd2Fzbid0IGFibGUgdG8gc2F0aXNmeSB0aGlzDQo+
PiBkZXB0aCBpbiByZWFsaXR5LiBUaGUgcmVhc29uIGZvciB0aGF0IGlzIHRoYXQgdGhlIE5WTWYg
ZHJpdmVyIGRpZG4ndA0KPj4gdGFrZSB0aGUgdW5kZXJseWluZyBIVyBjYXBhYmlsaXRpZXMgaW50
byBjb25zaWRlcmF0aW9uLiBGb3Igbm93LCBsaW1pdA0KPj4gdGhlIFJETUEgcXVldWUgZGVwdGgg
dG8gYSB2YWx1ZSBvZiAxMjggKHRoYXQgaXMgdGhlIGRlZmF1bHQgYW5kIHdvcmtzDQo+PiBmb3Ig
YWxsIHRoZSBSRE1BIGNvbnRyb2xsZXJzIHByb2JhYmx5KS4gRm9yIHRoYXQsIGludHJvZHVjZSBh
IG5ldw0KPj4gY29udHJvbGxlciBvcGVyYXRpb24gdG8gcmV0dXJuIHRoZSBwb3NzaWJsZSBxdWV1
ZSBzaXplIGZvciBhIGdpdmVuIEhXLg0KPj4gT3RoZXIgdHJhbnNwb3J0IHdpbGwgY29udGludWUg
d2l0aCB0aGllciBvbGQgYmVoYXZpb3VyLg0KPj4gDQo+PiBJbiB0aGUgZnV0dXJlLCBpbiBvcmRl
ciB0byBpbmNyZWFzZSB0aGlzIHNpemUsIHdlJ2xsIG5lZWQgdG8gY3JlYXRlIGENCj4+IHNwZWNp
YWwgUkRNQSBBUEkgdG8gY2FsY3VsYXRlIGEgcG9zc2libGUgcXVldWUgZGVwdGggZm9yIFVMUHMu
IEFzIHdlDQo+PiBrbm93LCB0aGUgUkRNQSBJTyBvcGVyYXRpb25zIHNvbWV0aW1lcyBhcmUgYnVp
bHQgZnJvbSBtdWx0aXBsZSBXUnMgKHN1Y2gNCj4+IGFzIG1lbW9yeSByZWdpc3RyYXRpb25zIGFu
ZCBpbnZhbGlkYXRpb25zKSB0aGF0IHRoZSBVTFAgZHJpdmVyIHNob3VsZA0KPj4gdGFrZSB0aGlz
IGludG8gY29uc2lkZXJhdGlvbiBkdXJpbmcgZGV2aWNlIGRpc2NvdmVyeSBhbmQgcXVldWUgZGVw
dGgNCj4+IGNhbGN1bGF0aW9ucy4NCj4+IA0KPj4gTWF4IEd1cnRvdm95ICgyKToNCj4+ICAgbnZt
ZXQ6IGFkZCBnZXRfcXVldWVfc2l6ZSBvcCBmb3IgY29udHJvbGxlcnMNCj4+ICAgbnZtZXQtcmRt
YTogaW1wbGVtZW50IGdldF9xdWV1ZV9zaXplIGNvbnRyb2xsZXIgb3ANCj4+IA0KPj4gIGRyaXZl
cnMvbnZtZS90YXJnZXQvY29yZS5jICB8IDggKysrKystLS0NCj4+ICBkcml2ZXJzL252bWUvdGFy
Z2V0L252bWV0LmggfCAxICsNCj4+ICBkcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYyAgfCA4ICsr
KysrKysrDQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPj4gDQo+IA0KPiBJdCB3aWxsIGJlIGdyZWF0IGlmIHlvdSBjYW4gcHJvdmlkZSB0ZXN0
ZWQgYnkgdGFnLg0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
