Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A806C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 03:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQrSB+kTkS9fW8QXMq95RaYeJObEFlahl3G/uPylsJI=; b=cT0qbyHuMP9ZakDXtuFeno+a0p
	+9XtPXampsAP+eyWzmzFAPfMtZtVQxhO+wGo+H9JXQIGQGYsVYtPD2e/Y/Gi/grhAteWBHQtjJSwu
	il7gIIlkRhMlpOhyU5Qu44t4O1uPB6QDjtYbZb1Dm7msSvhbnga2ip2VVmMxPWm1lnu8cGtw+9ux3
	1P6ihRXSyiGGbX0JJxup2Vj7mkOPPQq9Mi1xYWdHmnyf8cklJgdLK5xo9IWkXSiXvZJGOyZ4sq7tS
	BXUkROgr+pG162iWZDYgcINY54cpISgXLRu2ECRoAf8CpTEgRGuwXzUzJOFeSRKeEV2HNglAXp+XH
	DFjYIdVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun62-007Lqy-1L; Tue, 15 Nov 2022 03:58:50 +0000
Received: from mail-dm6nam12on2061c.outbound.protection.outlook.com ([2a01:111:f400:fe59::61c] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun5y-007Lod-4T
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 03:58:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF0kQcdZtdTNfb3dOZ5fbZQrls5/z9FxFtF4SYosAKBlFIC10laqkotQdex7dLan4R/8O19BvI30ZgLuRZo3VcUct9kLbZufEPLWqxzwrhS3JYSP2GCB9V7IewwXw6bBn2u5B/qTPTU+sGM64skKnw2gxvcIvrswR2IUR/ukkHXjD1qOUBVneYwJFBFyAilIJQvx2t6BGtf3ak+XY0B4a5ntGcqr+DADuskSQzdr95GSE5fQaAvx0oI1jHaxkut60UOcgaMwRf0FvFYP1EoZgobsImI6CfEuU2ytCZemkJ32CreD17SJAioR9XYVKfCherz959813uaAx3sUTEZfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQrSB+kTkS9fW8QXMq95RaYeJObEFlahl3G/uPylsJI=;
 b=TYQDKSuovv+3w2lArEM3DdQugpL05sFpsZC0XpWA7eaC3m6LgfntNo97MWypI78J/uDemr3wZi7i9J3kuiCyCNetgueacWYPmWYkFJC0U74lwJ2D4jDLaHRbIZm5fcmnMlVFnK3dciAfSga0LSsgguh6h/0oQmv2ydMJE4/DdZI95ltgkN21P3Q/BgQwiUmmnaie1rtD6ksfqSBXROEklRV02q5EQZGXYcEnNqDzRq5D9J3AogvAxry5T2Jx485Udu0LFJpvIvzik9cNh2ZsG1/7hSUWIc1Ma2+9AnKxXTkAjHmAf045S7AZJGBubzJM4s7yho7ExYfFABTtGDjQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQrSB+kTkS9fW8QXMq95RaYeJObEFlahl3G/uPylsJI=;
 b=mRZL0x0/TNndJN/DJMo/gfHVEJcDZFKCl5c0vCP3/ESa19NNnNw6To62wY6Ygof/5EF+mMtAQ2XxuPKxVyneS6/lhYnGLooyjN3euVISr0aarUDrqZzncItRnINL97EakBwk7kJCbYeObqPrkkOult9SSGOTSfFHs3dEyNOJpvqnQO54Uw/KN96pS9xqcHJEDtwg/HKF0Y7Hy/BLFwzvzLujjiD93x44IMbbtlR0jGuZFh3xjFtlGC/aWbLnTw/2OPH6OBgveGq+jv81t88aALNNBMgM5ShbAK7vWUdcCfFU7UgbvWAYLJgL+XS2554O1l+UsMNrNTP+bFijf2YXNA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 03:58:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:58:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 08/20] nvme-auth: remove redundant if statement
Thread-Topic: [PATCH v2 08/20] nvme-auth: remove redundant if statement
Thread-Index: AQHY91LF/6fgip8bgk2tv56AHmLUxq4/XnOA
Date: Tue, 15 Nov 2022 03:58:41 +0000
Message-ID: <1630785a-2d41-8f14-2b53-a4e3bc2eafa8@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-9-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-9-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB5423:EE_
x-ms-office365-filtering-correlation-id: dcc5ab03-3db4-4702-e1c7-08dac6bdaf59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  qC6LnN6apTn9dBns+vAM3kSmdmmlyFHAwtVm275/3tnCLzc6u3jk/RW/fzV5moIkMKFUdu/TAayOEGnAVibj+JdowrDfwEbHv9R2kpEk97m/PKl94LZysRJhME80axZ5bgmFp0EiM2kKrd7gEuEw2mhoedBg2PbgdmrRhFelzNQihZ39wgVSwkavaXnw0ccbtJLdD7VwsWXgFW12S0SWUZycAVSlQ8hFfbweik4ak5dzOJ7YdnJb9U+RhUov7/HOmmOQ2GHmvoxzG0sGclZ9DGAzsRtRZUNuBrrErFkAespYoxRvqB4nyacAzK5LwQF1EBEMrdCwyqrX+UB2eMKhHeUHNh60cf8+CYylhSa4iF3CtFQSd/lCYdodmRMgp3PWLKFivNnP+GA96JxttsxTqo9ODfHyATolULP38vP4zxS+ojiZWLbAZ7Luu7R0MBGCodJTdVGyvn45bFXILiR7FJNdt//hR9fYlwYzonC7puF2Av/lwop/sbnuyO1OS/zVV/D2AtaM3wAMl9z8gySuib4oJvD7oc0u95BqCWJuDcGChkbNRSYVfkGJAnZ55rjaunpii7/lnsrXo3wz5D5c7J+dsapsU+Ybhq/XiTFGM/qDzUKf7HHIpAW2yNUoisoOe4BW8t+0y9RVLHPZhk6ZOXhNRLf2EBAgatJX9g75Ku08ZI7/VAfkG1tyNIZ46bThxsbFgT22ULYdtegjnxpklkIwO2FnUtvRLlPE7mkF2HWPl1aPn5gKrbxBee1L4fJuftbP5exVQ7Ay8BXTrqrteq8AmkW7kipSWTk45dG0h99WMXgqLPoVsCT///+6k8K6hSvE7cEM4j9tzM0rnKyvLA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(478600001)(71200400001)(66946007)(6486002)(66446008)(66476007)(36756003)(66556008)(76116006)(8676002)(91956017)(558084003)(54906003)(64756008)(110136005)(316002)(4326008)(38070700005)(122000001)(38100700002)(6506007)(6512007)(86362001)(186003)(53546011)(2616005)(31696002)(8936002)(31686004)(41300700001)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NCtWR01rUE9hTnluS0FTMHN4UWp5clQxY2JWaVFIdkNpWHFPSk1Ba3dPM2Zq?=
 =?utf-8?B?OVZIcVZsYWVBZmt4KzdjdDBMa2VCTU82M0FsU2RVN0lQdlBYaDRFOEZsVkg0?=
 =?utf-8?B?NlZobmFCdkpVVHZsYjdjS3Rab3AzcVFoY0tMSi8rNnJFQlpTR0hUSVhub0ti?=
 =?utf-8?B?QVdtVm1CajR0MU80Q3JkVTZNdHN4QWtqR1ZJZ1FoUGZPSXFDM2NraWRXMm9Z?=
 =?utf-8?B?dFh3VDFJbTQvTXlaZEt2SU1DdTZidlBRWUwvVDhjZjJ4ejhqdGYvR1JjMFAr?=
 =?utf-8?B?M2tjajVOSXRXeHEzT1B0WmpJQllzTURFNHVVekpnc1cyNWcyWlE1djVRMkZk?=
 =?utf-8?B?TVBHUEc4SWtJV2dyWnZaTThTWnI3cXdpVFhZQ3FKZzJseFFXaFp5TVNvVHVu?=
 =?utf-8?B?TGhXQXdxcHU5Tk9YT0hWVnNhNFZpTFpMZVhLZ1ZoYnViM3pqckEvK2d6UU52?=
 =?utf-8?B?MDlqRXBtRllTU09wdktSY3N5WWJIVUtKb3djbVIzZ0J5SnROL3BycW9JWllj?=
 =?utf-8?B?c1NlNkpOQ0RMYU04cFBoZjJWVVpUL1d1T25sSWg5YnZHSk1KSG5GQjVXQjc3?=
 =?utf-8?B?dEZ0aW55RDk0L3RqZHN4M2hrc3IzUlpsME80MjVSU3JNY3lLcmM4aWF1dDZD?=
 =?utf-8?B?TDRhWEh2VzQ3ZjlEQzFjb2RlVkFkVFNSQU5YUUt4MGNTaDZ2RlRXb0hXNnFy?=
 =?utf-8?B?WnM1K2ZTSktuelpWL01xc1cvNXk4OGo0NDFZYnoxL20rQjVGQXM1Zlg2VmdY?=
 =?utf-8?B?UStybmw4TTVHV0VLbDV4eE9Nc2RYZVAxM0VhSVduVkMwdFgrVEY5VlVBSlpq?=
 =?utf-8?B?MVNtTVl4Nkhpa3o5amE4ektWRTNPczBpQVNsT1EwZVFheXV4ZGNkd1h1MDZs?=
 =?utf-8?B?b1ozUk04dFp4bFhlK0h3OExKZmd1cWtQVm9jODVMRXRwRklJU0RTazhpZm1E?=
 =?utf-8?B?Uk5VVlp3R0JJODYzSVZZM0Z3OGN2QVNxWC9qQTgyNDFPYWM3QTE4a3dQOWhu?=
 =?utf-8?B?eU83c3pYWGdSZ1hBa0s3QXRiOG5vY3YzS0JVS1h0Z090alNhdFZ1WXZjb2Z1?=
 =?utf-8?B?TXRxcmEyMSs5azJ5cTR6VnI1SE1XOW93NmpEdndaTGUxa2ozUUNjdWlKWFBZ?=
 =?utf-8?B?VTZOUy94dXlkUkw4Y1YyWkwvNFB5bWs5RDJWUERjVEFxbmRLVURLSG9FNGgw?=
 =?utf-8?B?S3A2ZkZHOVIzNUkyMDd0SCtBd1FQU3JRUmMvTExwSkwybTE4UU5aaXBqcVUx?=
 =?utf-8?B?V1YrOEcrRVB0T2NITzdYT1V0TWVHM0tlZlU0aEhzS3gvQVJBL2dOcUVhQ1ps?=
 =?utf-8?B?QkcxbUh5MCtUZzVMMkY1Z2twYk9ieDF5Rmk2U2VyS00xS3VKZmw2eE1TTjhG?=
 =?utf-8?B?enRqU0YrU3hjY2dPZTNOWEliQ2Q0c29jOTVwWWlUUy9MTThiWm5wTmZReGhw?=
 =?utf-8?B?RmN1alQ5VUkzWDAyN3RuTzZCRVB4QmQxaHFzQjRjZ1NJUFF4ZkZUSHF3OWRk?=
 =?utf-8?B?eHBJb3YrWVVqdkNLRm56azE4VklUMmhrVGFOQ2RkQTl2TFdSN2lZNGpvSFFv?=
 =?utf-8?B?TWNERkhKMUx1b0xoaHEvV1AwV0JnQ0M2aDdscnc4OHg5M0FEa254M2IrRHBJ?=
 =?utf-8?B?ZFdxV2JzTkVxVy9wN21JbVQ0MEdPZTBqN21ZUys5TUhZS1dPRWVyUHdqaDFp?=
 =?utf-8?B?SjRSdjhSeDNVMzhCS3YyaGllZXlYVlZjOE9RZkZFdnl3eU16cVNZLy8xb0pl?=
 =?utf-8?B?b2Y4V3hIeFUwcXJPY3FIQjNQbVFQa0xOV1c0aExOMXhvZU1GNUdtTW1laVBi?=
 =?utf-8?B?cEQ4aXVyL01iQVBEYkFuT2tkN2JrTkE3c3dpL0g1eVBnc1ZSdGt3b3VlMmVn?=
 =?utf-8?B?Tks0bEt0RURjUUFkRG9TWXV5dVNzOFlpK2I5ajQyQUtNcEdqcTVvZVE2bU8z?=
 =?utf-8?B?dEt6L2pFOE43c2s3alZ2NlRLdEk1aFhOS0plS3VhM1VJcHhWRjZIc2lGalNs?=
 =?utf-8?B?bktUVnlUVkl5S0cxSFhmQXZ4SkdxaFR0b2xqOVVrNGp4UDAwTWUrU2NoUGhM?=
 =?utf-8?B?cGxVT29lYzJvN0RiVjgvWTkwN2NpZDJIcFhLdVJ6Q1ZxRWlLUTlCQWpqeFRP?=
 =?utf-8?B?dHJrNmFkaHhrelQ1SGs5dTNWcktLOHZNNFFVbHArQkFlbm56aUhCait1VHJ1?=
 =?utf-8?Q?cCa5fkj2BCAlCrf+m+sVc0XGwFAvA5x1sZSZLPLmQyIN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <614C612C16AB884C943C48E5358E60EC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc5ab03-3db4-4702-e1c7-08dac6bdaf59
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:58:41.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Raz57YHCJTjp296jKfMIQpAMM30L6WwyYxidq/gQXleu2BjUGWBpRmm47ONCNYPHEf0xwRUAz/JEBP8ONPkIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_195846_217978_CDE06014 
X-CRM114-Status: UNSURE (   9.15  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IE5vIG9uZSBwYXNzZXMg
TlZNRV9RSURfQU5ZIHRvIG52bWVfYXV0aF9uZWdvdGlhdGUuDQo+IA0KPiBSZXZpZXdlZC1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3Jp
bWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

