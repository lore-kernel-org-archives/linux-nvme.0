Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F454C6FD18
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 04:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bD4hVIMI4l/4lbPK0Sk3FntNI4LlCcHz+FSXRt1bqU=; b=wJo4sGeySMHiBj2cBnEdCRt+6t
	wf4hmtzH+NLiRP4khtZO3tvBITsyC2rgxSryQXbXBVbFIIybDYQZCkZ0mhSTntmqAKfpYXVetQb6q
	PphAmXBmj/sWIF+hA+PhyujOd1UlkgFf/YTDjgVSw6c07C0lAkqHWSdUN7PkfCTRAhhB3xuWiTTKA
	KzPvN6MIbMwikZ/m80K92CoVk4C34ShzYmFqWwOF6NbR1JpCnlwTS0GRCa4GhiM3LOG9WigymzC+q
	RCpmc1VPkEJGM9OGaWOdSKH2LFfUL+GQEqBvjuJHgiRufSijodyNO9b+cy1OTzsDR2+YgbMRAS8Y2
	gRIqJLPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi6oe-005plk-1H;
	Fri, 31 Mar 2023 04:56:44 +0000
Received: from mail-mw2nam04on20612.outbound.protection.outlook.com ([2a01:111:f400:7e8c::612] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi6oc-005pl6-0V
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 04:56:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP+LLBOny5X6WXJkshZdFDoPSAiiQ5oFN8ffVX0xDft0Ha5mS+hpk/CNO+USopOJiyZx11OL5T/qluMy9BXR6Bijtp7K3iKsA09XoXg+SaDoujuKVdMqLAOBYLcmNik+Pa7RjvPYImsKcTcb6ku92vFz0OpjZAL4ofZJOKE3yH3OrYlY8dcoEo8pdxaOPG9nPajEp4bAapuTK5j0+417QUgxUkLT7dSREPJC76MTNw9/zxfDDHqzmXfeLHUP1lccwQsZiNXJMd+UQCYPfRFmKRHiEGzpGCZ0KQjJHVffvF4MSYmKW2oSWrF8gHLcwOYUdazJQE7xaQYFlYgBK8dgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bD4hVIMI4l/4lbPK0Sk3FntNI4LlCcHz+FSXRt1bqU=;
 b=eHsTODbtyXnFR97lJLH32QUoyEbPK8T73HQo0IfSQehcRh5Vk3K1FmiWxYe7mtkxFIDd1kI0PgbEjgJ1myjv3OTr9DpURbfhfxb0A70UxzujXGX33N4McLgJ3nBLBQPhmbQ/oW2xIIU2XIy5euyCYTKvttJl14DONh2EV8c3Z+2y4HiUxi1pCrl3hsyw8dKNX3QKImqWfREVYLdMmafRxg38tW9BBbH4GVChaUwFhdN6auJDMS7aL+J5aPU98F1laZ2u70a3qG0fs8eQiCHYM+dZ7zQuyODKcbfz5/LBkpwOCBZo70llbKKMxuy8Ql5NclnXhno0k3lp6irGXfmhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bD4hVIMI4l/4lbPK0Sk3FntNI4LlCcHz+FSXRt1bqU=;
 b=GgZlFEiRaWXavOd1L9tqY039UQNesa1T7l5DRbf4dUDlrHsEft0ViDP1zSdQOTI42ZUjM0VKUOs+i69epmf78pDdv9xkTqMgxtTShyrQsMe1E37JDmANI9qRAmIBkWbmEsV1grJiTmlgnVDsOaGMfOeQL6fLaSHrxhbWY/qW205eHshynEMqDlmj1jNCzu+PzMyG+WCz6MPV/4YafipHfvVrqWzfILfOn/F6OQ7wB6l/CugKUCMU1xTSp/Mbljl5LsXkmEXr8c+JL8WoMvCyRhVEPuMBkVaQQRHr/1Rpy+8AyVlkNS67K0OSNnz712txrTNC0EAgTkatAKQuLLUHyw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 04:56:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 04:56:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH blktests v3 2/4] nvme/rc: Add nr queue parser arguments to
 _nvme_connect_subsys()
Thread-Topic: [PATCH blktests v3 2/4] nvme/rc: Add nr queue parser arguments
 to _nvme_connect_subsys()
Thread-Index: AQHZYh0jRkbi/SJCTU2hszxzsDpU/a8UViCA
Date: Fri, 31 Mar 2023 04:56:37 +0000
Message-ID: <6c763de1-a98a-0cfe-a899-5c1474a5b9e5@nvidia.com>
References: <20230329090202.8351-1-dwagner@suse.de>
 <20230329090202.8351-3-dwagner@suse.de>
In-Reply-To: <20230329090202.8351-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB6762:EE_
x-ms-office365-filtering-correlation-id: 2fe55593-a08c-4b4f-7a1d-08db31a44efd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Va8sGt6RADHFwZPErxayp1Zd7PUKw7OU83Nt0tor5KH1C9YbEd3bplkrAyGiiDJsnL4Og4vLZEJYy44jtYXLHWchbKMb3VicpZucy5cUz8ne9LAV2rE1gh33ioUTiBj7M9vm/INvczcKXHSQmuftCN4Z/ETbmpLNItp+xQVw5x1UuUCZIPo3bnFjxadlO4116XQD2TvfDPnPOQzp//RN/jINyO0CP0vf/TJEWyg6btnIZUxJcDQsVfU3veXk5hT226zHEI9K6CaIBJqdj+AojgBQ6sAnzwRxr2ZWtcW20eg+tsAK3xAAi72XtKM7vu89MKqLGHWd4f4h1kquZbEhZN61aVER2hgHHAZSUgCtTsd6JEgaST3iFhv9km9yPENiDUV6zTOhU0rOo653xm0WeOrI8lSs6ZM3Vsm/3yOiGKTdwWIkp+Bco11C7YHYCtYnQbo4q4rUVLuPhdfpt6UrJsMjzS7FZpPNBJavuwwV9mbrPyiG8PT9VIysheLfsYPdWr83Y6P7P8vHEXzB+f5FSaik64Aij2mauYDLQBknoWiGQA+5kerDlW3Ng6hitGrhnfL++tboL2GZptnhRG4BrsaaVmZDLXkpwn5DM+ooUFsZwcWDSmGQNFkKgfela9dQaCfS1647ut+wLXYwFJUpuq640pnjda8FYhU07y3bEh8LqxS/XiMKd0/4qPYnz2jW
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(53546011)(186003)(6512007)(6506007)(41300700001)(2616005)(110136005)(54906003)(91956017)(66476007)(66556008)(478600001)(76116006)(316002)(66946007)(6486002)(66446008)(71200400001)(8676002)(64756008)(38100700002)(4326008)(2906002)(122000001)(558084003)(36756003)(38070700005)(86362001)(31696002)(5660300002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dDFJa2lRMWp5QkZtSnh4T05WTUlqR0RqbkpNY1ptZXhLU3ZFd1kyUk5iTW50?=
 =?utf-8?B?Q0tXZHRWSVJOYkloZXBMYjdTa1F5NURKZEhWbkd1LzExcEdmUnpzdysyaFRR?=
 =?utf-8?B?bVZ6RVIza1gzK3hmRVdwZ2YvcWpjNmN2blZUUlN3OGVZSXpqaXU0V0pVU3ZQ?=
 =?utf-8?B?a0VQUVA2ajJNTjNiZ0lMMGZJd2JNbkg2RWJ3ZFhvMWhtcmc0VDYwUHFUcWpU?=
 =?utf-8?B?Njg0dFFnVmdmZVd3Qkd0OFFVKzlweHVjUmc4N3NhMlFraUxTOVBCMDluYVRG?=
 =?utf-8?B?bVk0dDI3c2xhRFJCZ0RENU1rUm5JeTd1Q1k3ejR3bzdzV3V6Tm1nYnRPc2oz?=
 =?utf-8?B?Y0RUWUxhcExtY1hieUxuaWdBZFNTR1BTTnVOQ1NPc0lZQmRuNWNVaCtZVTUw?=
 =?utf-8?B?YXZ3UlVac0pPbXAxMnFqY1hFUWlLSXVIaktGSUcrclZieWM5SGdGS0h0UVRq?=
 =?utf-8?B?amtoempORzhyejN1U1FGZ0pPSW1aYk9qbjhDMDljVTI5dWIvS0hpOUxXRmpj?=
 =?utf-8?B?d1BUUzI1K1RGamg4MnJrOUd1akFhWlFSZW5yN0lyMGlZOGVlSU4rNzNvdXZz?=
 =?utf-8?B?ZU9DZks2aDVvVGpsRlJZZ3h0dTA3eHd0M0NWaW12blNJYWRZK2k4S1FrMVIv?=
 =?utf-8?B?OGZHaGZJeHJ5V2hoTHhZbTJBaVprOExoL20rUFpvQThMQmovOHJYUFI1U0RT?=
 =?utf-8?B?cU80K1BqcE8vcmw0SFNsUHVXeEtBQlIwbDQrcFNEb1VIdDB4OFcrS3BFWkZR?=
 =?utf-8?B?M2NwNXlReGpXSVhsRVpnNHJoak1CaVg1VlZpRDZ3T3l3RjI2WEtaR2R5UFFJ?=
 =?utf-8?B?aUhoQ29jQnVIMFZNcWVOU0hvR0VPY3EwQWkxeC9EYUlTbHFBVXR5elR4Y2dG?=
 =?utf-8?B?VFdRMU9DK3ZxLy9UZmZQNFpVcTlHV3pZUDlNMXUzRU4zSC94ZGk3b1N2TzJJ?=
 =?utf-8?B?dEl4K2xidE5oUWx3NllCQ3dCN1pUNytNbFo4Vk81dDJjZWRyRnltUzV5djNt?=
 =?utf-8?B?T20wN0o5Q3BWWDU1dCt0cENCTUhibnZRb29BTUx5UXlsU1c4UHVJeTFiUTVk?=
 =?utf-8?B?K0t0bG9xQTU2aUp1Z1lQZVBHZlBPTWtwZVM4TzNQOXJXZUMwZGFRcEdTNVpO?=
 =?utf-8?B?WVpKdElXNEdIVXgxOXlNYjlhMTBPU08yZnJGUEtzWHlVWGdmWFpQc0V0cTlR?=
 =?utf-8?B?UEVHMS9GYXRPdzJnN1pnYTRXNVovQUZQTG5SK1AyS0dDOURwa3NBcTRxaTFG?=
 =?utf-8?B?ZlBOb05nb0FxZmpQeWFaNHp2TU1yU3UwcytiZTRaUGEycDI0dHhVdHpSTWZ1?=
 =?utf-8?B?V3lCTEYrYnB3Q0x4OE1uKzF2c3pUMDhUMGRES2dFQVByaGhIQnY5d0VJaU9W?=
 =?utf-8?B?WldnSytZSnJvN3FXaVJzUnBKWlpJKzVLV3AwYjZCZ24zL0JyOWpLSzBTcnNU?=
 =?utf-8?B?bmMvMGJiWUJmQkgxR1g4RHlobDdLUmhCZXQ0dEluMXVPcHJJODZ5Wi9NN0Y4?=
 =?utf-8?B?SGNVSjVSUUx3cnAvWWhnOUxJVjl3aThlVHVhRFdCZHBSZHdac2Q0KzVEWm9s?=
 =?utf-8?B?bk9RdVB4R2NoekU1N1BRd2IwUURQSzJuRWVaMkZxMnFocnJrRG1WeE8xdlZT?=
 =?utf-8?B?dEUwTlZLazhXREZwOVBtSEJvZndsdWh5YlpCNEllNy96dUduNjJIQmhyaHND?=
 =?utf-8?B?UzZTRmI2bEN5Umc4MW9VRjNBN2pZb1d3eDhIMmErT29xS25ZR043Um5nNS90?=
 =?utf-8?B?OHRFczc5VCtYUk1lVnJJUjNtK1R6eVhaYmcwdk82WUpIYmJsMGFGMUNsZThX?=
 =?utf-8?B?SStDeks1a2R0RUJCeVhqMm9KZ2I2YWVWVGxrZm1UL3lJM2pNOVdJZHQwTTlJ?=
 =?utf-8?B?aHJpUzB6UXZFTjdFcGtEMVFoTEhLWHFEeGFISllwYmxmbElTWHBER1pvRkFk?=
 =?utf-8?B?WG41bU0rWFRISWFYUEhzTGtBSnhBK0t3Qjkxb1ExdFgvVUdTeFo4bmtjMS9h?=
 =?utf-8?B?b0tuUjdvVnRZdXJGdTU0bExkMEpZWDJYN0RGWjQ2VkZDZ3E2ajhkVFVaTlUx?=
 =?utf-8?B?Q1paUHVVL3lUWkZuOHBBeHBZVTRMMk9hbFErVC9hZnhnRzEwZEd5ZkhMTEcx?=
 =?utf-8?B?WFB3c2dNeGhTTHhMdUhOSVRxRy9vdWdZT2dDRmdHVXBKVmFQRGg1SUZNdWVT?=
 =?utf-8?Q?U2linQW1Vl/NW11r3UVdMbgPW4++BPQusC+ZMTylMeQE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3D26E70D1830D4193D87F36A5CD9320@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe55593-a08c-4b4f-7a1d-08db31a44efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 04:56:37.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NKm1bJSIPYCcY6TUsY/BK1XQuAE6jyMlWkYLAVEROhhgHMf4ClsnOorf0+DNSfDpQSlM2bypUy8ZdcJRZJgQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_215642_203008_79F88DA3 
X-CRM114-Status: UNSURE (   5.87  )
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

T24gMy8yOS8yMDIzIDI6MDIgQU0sIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IFNpZ25lZC1vZmYt
Ynk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4gLS0tDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

