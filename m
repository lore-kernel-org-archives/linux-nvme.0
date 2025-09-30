Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37563CAC5B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 01:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3YJECo/AjbaioiBT/S6/xqv+QKPrQkhmaqj6i0ULWT4=; b=z74CPQuVpl654jbZiVfazLbDlD
	I0zR8hH71OiQRRhji6WXuOuq4eYORHNlKgvWXrUVbqDnAOQrW9xyUuxsVc2a9kihIm54KWFP/D5uH
	djqemQ8060ahj94XnBbXTOlq77kHcLE+2aruWcoCyHW5iQ9jzKHgf0AkUSxaUcQViJXAvq7goCHLX
	gfMmy35bhY3VnrgLy2VUXEzkfFE2tvFVvbAVxO1TZSuggYISrxjZMi2cLVNr7MJY0lf3o2/nHk/53
	OnpWOkxyEE0kzHCxy+qMdb9tMj2odiX7SdeuOcguVNXuqsmAhInMQPuViaJxEjdASvKX7piwJQe5z
	BJ38n8fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PPj-00000003oIQ-0ct2;
	Tue, 30 Sep 2025 01:44:23 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PPh-00000003oHX-1s6Q
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 01:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC1CYuovhhnk72VUQsXC6d6dFQwj4pA/PXi2+vtX3tky6qy6Cfu579OOBrrTIpdLP529lodZBA7mPaEm+RTU/W6DX/YiwyVPxikRKV46If+7oSYoVqEyniOeoD6kfoO7FIrPRzA3HRU6pGFlmkY4QMAKYDTHz9NSoY6o+O96+LwGaB52pqKZCTNMX94EY5Fh+RjdyvzTx48U092m4pFzmtxHXlzD5AKrGXAMj9pB2+A2/kGjyf7dx6fDy50G5Q182x0MM1RnOKlIL5Jhlgo2fQYFqKJX7X/NCTrKO6kXkUZpRvpo6b82fXlozf1VoSP2ChhIdnjlndtW6OhmCRAZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YJECo/AjbaioiBT/S6/xqv+QKPrQkhmaqj6i0ULWT4=;
 b=LZsW3NupPWQ/ZGrq1Bb/TQlq/P7wHB8PHLlds0i+4GO5E3+sgs9PD7QA/SWpMp17sfDgYmWznKW/IEjKSwf4qPhaSFNuBmFth0KhcwNawI7oWF0s91HsnTuOcQfAXKs+cuefsqxWdvjwnbYyTrz8oJmIbFBKOLgVnaP59GOr5nkMMZy2pbC3WvAseMCVV9lQoaI4fjz/YX+mavsmp1/fuffUTs/f07KlP1yQMbNqhohiqNUUTaWOrOmQB5BkW1+mg6QHLEjy5luvuPZ4ML7gyejgCKQgEQ9aEejAK6hFgmo0TsQF444uBReF7UNTInNHhWvpEhaLfRfTkWWgNdap+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YJECo/AjbaioiBT/S6/xqv+QKPrQkhmaqj6i0ULWT4=;
 b=TsJnkIz6OT4LKrRsxjRNtOruI6skKjvp5qjv2b+QP/j2S2RwR4bGt6NBjfiNKQTfyp8s7vZ3+MeR/2HGM+GJ4WPT2VpYEK0Pv1ZHOntt+TmDOxR4Jr9gN3s94xHW//f4sm+KKb6+/tkb9uRms7jfHCymrXyPf4Jh7Pr/BVa5JxK4wcx2E8teH3UdFbF0d+U6/It7RG3T42tN17wPuKU8W+r3y6cJvJW4/BoaZrp9q67BO3gkfWI2T9dUg7o10rfSqOidCpF+bKRZo8sPyVXFGkXK3jaf6s7zZEyPX4ELNaogkZAaexe9cbU/gj/eTyMS/EYu2uyuXhSKn0YK0QIvzQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 01:44:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 01:44:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "dwagner@suse.de" <dwagner@suse.de>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Israel Rukshin <israelr@nvidia.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/4] nvme/061: increase nvmf state wait timeout to 10s
Thread-Topic: [PATCH 1/4] nvme/061: increase nvmf state wait timeout to 10s
Thread-Index: AQHcMG4+deD9s9zJ+k6Y4XY7EyOQOLSq9psA
Date: Tue, 30 Sep 2025 01:44:18 +0000
Message-ID: <72449735-9c10-476d-9f5b-16c1d2784a69@nvidia.com>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
 <20250928115125.38383-2-mgurtovoy@nvidia.com>
In-Reply-To: <20250928115125.38383-2-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB6437:EE_
x-ms-office365-filtering-correlation-id: db2bf4b9-046d-423b-f094-08ddffc2deeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M21RZVJuK0tpaXB6ZDhTWnRhbkhNUnR2SEIvZ2trWTdoUGRjOGJOaTQ5NXN0?=
 =?utf-8?B?YUhOU2ZQaGwrNXUxd2lGL1ZQbVdQalg3cC80dVVOZG9WZlMxZGVRRTkzNFVV?=
 =?utf-8?B?VXZyUDNhbWx3QWZZZmtYVlk0UUZ4Uzd4L2ZBNnlBYUpROWx3WnFWZ21MeWIw?=
 =?utf-8?B?TTNiNnFVVFdtYUR1b25WNGlsMDFSbjBqMHg0RFJFeExPQXZoZVRvTUJLSnN1?=
 =?utf-8?B?VGg3elgrV0FpYXFIdHJicExmK1RmOWhtdTdQZGttSyt4MzB1QXdNVlJNT1NL?=
 =?utf-8?B?Tk5jV1U5ZG1mWUFVcENpbE53NEtzTmhUMW50MytPRDUrUWZ5YnVGaEM5TlBS?=
 =?utf-8?B?ckJFL3ZKTklNUVVHbVM4TUtiWTFodkRXcWJHdkF6NFIvSWxubFVMWVJiTTY3?=
 =?utf-8?B?VlpsV05oUUdpbG1sVkhvQktWUkI0WjFKaE1wMGpJbFBKQXJ5cHVXanJVVExK?=
 =?utf-8?B?WGdkcm9pOS8zakZzS0sxekdSUXF0TWFiTE52eEJnSDdEYTVLaldROTF1UVVR?=
 =?utf-8?B?WXhyNWh4Nm82MW1uRHRDQUNZWk5JbTVzN2ozQThmd2JQQmdBTUlydXdFaG5S?=
 =?utf-8?B?bEpTd1E2akkrdjB4blFldHJWRjYyRllrOUN1bG0wOGRHYTcxanFVbFg1VEFm?=
 =?utf-8?B?QmxYZ0FUOWVlTURyY0svb210TUdUTEJVOEFVL0xKbGRXdzJySGJLdThHcXl0?=
 =?utf-8?B?U3B4NDVMVnptamdrdjk4MUtOVHhkL3kxV2JqemhaaU9CU3IyUFJmQjBiNklI?=
 =?utf-8?B?NlFjWWZqVFpFWENBVW5CRmlyVFF4cUc0Y0Z6eDNJaWxYdU1sYkY5bGRpVHlL?=
 =?utf-8?B?SWhWcWZWK25qMTBzb2ZpU0JIT2dOSGVwZEtUUERtZGFvVWpubEhXZkhsMjQx?=
 =?utf-8?B?aTJPdC9tRENLS01mbHJ3Q3JkaU9nS2RiSDVCOVU0OWV2bkdFVXcwMjhONm4x?=
 =?utf-8?B?RFEvNEt3alJNU0tEczJXTUtvSEVya3BYZVQwNDBjdVZ3TEJnNTVUZXdBYWxx?=
 =?utf-8?B?aWJmbE9SdUxyZjVmYmk0YzN6RW5PU3IzdG5lWGE1aVZMVFpieTgvY1UvQmx2?=
 =?utf-8?B?bmVyQmJYK1JQS21ZN1hZdURGNjNvNEdCQXR3a0ppZGFiUmRlREd2LzZadkdp?=
 =?utf-8?B?MFc0cll4aXRDNEZpdXBWNDVCcDNReEtGVVJUZFpDeFN1aFU2MlhkSHVNMGcx?=
 =?utf-8?B?UFR6aU5Ecm5PWGdpdVlkQmFDcHBzdXNwVHIreWYwZVFGcU1wTGlndVRWanlU?=
 =?utf-8?B?cEc5WitDN1FxVDd1Y2c2L1M4OTk1NldoMUFRN0VZby8xYUloQThRUmI3bmVS?=
 =?utf-8?B?Y0poWVhiTHZPWE9neWpsdmVuUzJCU1RQQ1FRZkpsOUpDNWRiU0Z1UWZiVE9m?=
 =?utf-8?B?OFVLUzRURmhrZElrYUF3NzA3YkpQOE5ubzM1TC82OXBSWUN3TGhQUHRudE9F?=
 =?utf-8?B?ekgzOVNYSE5vajVKQncrcXJuZ3p1d2pJbFoyWGxiWWwrNElVUldDSHBXVWJY?=
 =?utf-8?B?dHRJVzZmQ0FmdCszTldlVW9VbGQ2cmdWRzIxQkhLS1JGUk5JSkRmalR2NjVY?=
 =?utf-8?B?YXdEVVlUTWZSOVhKWnRYVDErK25xMUVLNklwWFlucmtyalhKTS80RDQ0a0oz?=
 =?utf-8?B?aHljOWw2ZkErZExJMzg0ZzQ3anBUUUFTVzl0U3JiRWN6Zk8ySlZHTVY4Tkp5?=
 =?utf-8?B?ZjJZT3kyL29HMTd2SzUrUmY5TWlYeGtKWDB0SjBxM1hXMGtadDBFeVE5S3Jn?=
 =?utf-8?B?VmtpZGcreEJjWkE2S2JjQUUyV0YrTUhPY2FuTzR4TUp5eEdqTkFKQmM1NGQv?=
 =?utf-8?B?cFVFSDk0dlNwYXNxTGFOTVRpZ0pMaERjdWh2d3dPT05WYXV4Mm5MdENTdnZI?=
 =?utf-8?B?Vm5aQXJhK2NRdmZiM01PWTdhVGJIT05rSExBQkhhaVZvZzBPbUZqMGRFUVgr?=
 =?utf-8?B?SDg3R3pXN2s2a3h4R2VQWWlLSmJReUFOZDFpOFVYS2h2YjEzZEUyZU1NTjBm?=
 =?utf-8?B?K1ZHcm5GV0hqV2pBVlppVThGR3JVUkdMQ0RwWWp4MUQwakx6VElPa3QyVjRO?=
 =?utf-8?Q?hKZsZJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVlSSTJ5cnlTSDR1bjBwWVUrbStKUEMvTE9YVTJoM2ZpYm5JRHZqa2k4T09n?=
 =?utf-8?B?Nkt5eG95aCsyVDNTM0dSd3FZYjMrSC9Sbmdma1Zka05qak9XRVNGaXIrN25l?=
 =?utf-8?B?UDV3L2k4Q0pQbThOUlQxOXhnQ1Ixb3ZsYTJjNDlmeUQzRXFRME5JVUxPQXZP?=
 =?utf-8?B?WW5LdVhYVWtMOXdrK1NBT291d0dXQzA0RXc1aHNnUVFhMVgzWk9lQ2V1a1l6?=
 =?utf-8?B?eThJZWNOZ3RFQVZCUXg5SmZ5TktQQ2JhcjhIYVBoL0R4TFNIL01ZOWIrYzZZ?=
 =?utf-8?B?STRaMmxmYS9tQ1FEOXgzZ2pCRVlsZXNkZk1zaVg1V2l4UWZQanoxcjZxdyts?=
 =?utf-8?B?ckhwa1dhdWh5MWcxM0J2ZWpkQW1qR3p6V1VWbEdKTTRCUmdYWTJtR0crNDJ6?=
 =?utf-8?B?b1NnSUM1Z2RnYkZPdFdSdG9xNklnQzVkQTF6S1lyRnN0a3paNWZvb0JtUUFD?=
 =?utf-8?B?dGVvS25qQ2s2V29KaEZGendiSWNmSStUTDBSTFZ1SnJ3MERHY1NxYXFkQThD?=
 =?utf-8?B?SVlmUUZ0cE9PYVkvUExNOTFuaFFxZU1IakF4cEJVbHNjVTYvc2ZPQnNIaFFa?=
 =?utf-8?B?QkNxREFXdHhmYWtvcEJEc0hMd1JHaVdCUElReG5Jbkl6b2c3WEpiK3RPaFJy?=
 =?utf-8?B?bkl3cXloKy80MGwxbkU1TUtmN2FBeHM2YnI3aVNzTElmY24weXY4RkNYRWRV?=
 =?utf-8?B?d1dYd3JmY0JnTGEzdCtsenZDSEtMSjFxdHRvNDloWUh1akFpcjVQdUl0OUN1?=
 =?utf-8?B?MVl5VXRrR0EyZ2t6L1Y4c0kwZVAwQTBJem5xd0ZTS29uZTBHUVA2SFNvbUw1?=
 =?utf-8?B?WjFGRmNHTWNvbVk0Rnl0UjdHdlpUYjdvNWNVdS83Vk5VWVJRRldQR2FSNTBC?=
 =?utf-8?B?YWxDQlVEaCszdWoyRXZJMjE0eHJwUCtqaVFJV0NQSERPU1RmVHhybnN2SDhx?=
 =?utf-8?B?YlNGNVNpOU4rME1MQmMxNWdhUld6T2t2bnVaSjI1U1h6Z2l2Q3lvS1I5Vjdp?=
 =?utf-8?B?NEVaeHljc0tlQ3pWSUk3NTZieUYrU2tCZWN0YUJaemdTbUVJOTVuZDk2VWM0?=
 =?utf-8?B?VzF5U0FsV3NlWWd4bXptSDl5NW9kZnRpUmEyVGJ6TXR1NXFtWDhWU2JuQ2Yx?=
 =?utf-8?B?T0lvLzIwUWIvTTU3bkh0M3BDaGwrdXRtRHE0eVU1eExscHVyZS85Tmw0emFq?=
 =?utf-8?B?Vm5IUDlOS3pGbkpmKzkxZXV5c0g1NzR4eTdUSG9WcGdRaTJKMEhSL09HRkpG?=
 =?utf-8?B?cW16NlFxQjZQVzFSUUR1QWErL1lIVzU4eG5ibU5BY0RQRzZDenRjL0hDaE53?=
 =?utf-8?B?MVAweHpSL2o4Zmw3UDRXWlJjNWpwSDM5R2VmL3M2YlI5ekt5MW9oUkduNDAv?=
 =?utf-8?B?ek9EZVVYcTRFcnJHdExIY3hBb0Ywck83ZGsvbkdVbldxc01wUGdCYmo2cGw0?=
 =?utf-8?B?R0FTUHNYSjlnOVJpQ2JQQitRdU9ZSjV2UVJFdkhrU25oSlMycGlVRVN3T2N5?=
 =?utf-8?B?N2ljZlpoU2E2cndZM2lBa0J3WG5HVGNucU0wNktvYjlTYTdhNEZQVVZoSXNT?=
 =?utf-8?B?MVFBUTdzNlVGYUIrWGJ0bk1aRndNZEdCRjRLRjAyLzdRU1JiVU9GdUFDeDlV?=
 =?utf-8?B?YWQ3dzhUWXJ6V2dGWGJnZHJMVDZ4RlpZbW1HVzlzWXQ2SXh1MXZnYUpkSkpL?=
 =?utf-8?B?THVwWnVYWkpjbGxucGpYVTk0SHhOaWxGT2lRZkpKUXpYTXhvTjFBQmdsdTNS?=
 =?utf-8?B?TlNFL3MzdFdSL2x1SnZ0TWI1WkFvQUY0WkpWT0VrdzZyY21mc2FiM01CVjZk?=
 =?utf-8?B?dlNUOEs2dkFDVmdWOThzZTJSN3FKVW5TcnYxVnZlWGFKSTBNRjBuOHBWTXdj?=
 =?utf-8?B?dlNpaFArKzRlS1p2bXQweURKK0sxcmlGQ0tCYWVIWHJneURPRXRISVJHVHdh?=
 =?utf-8?B?allhN3VjRW1sTER3YUFuS2dhcktpdnZ4SXZpUEYyczk0SkNZenBzWDF2eTZi?=
 =?utf-8?B?LytXN3JXYzgyMk5QNlAraytIN0lyWXpEL2Q0OTZHc3dFUjJ2Z0xDaGtSSmEw?=
 =?utf-8?B?Sit0Y21UVGJLNmtZVEdadWM1eTNFUm9xTHZZS29EYURHdWE1YTZSaTdrdzNH?=
 =?utf-8?B?Mk02bWxBQjVXT2VDNTJpN2p4RUR3bE1RZStkM0hVSW1KZmNTaXNrK0FKb2xU?=
 =?utf-8?Q?CQIVrBIGTcy8ERPrAbWyQ34mBq/swhMznnKhBqTk7c8A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB170C750234494198C07C0B122CF8DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2bf4b9-046d-423b-f094-08ddffc2deeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:44:18.5156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nG7Uh5ccKOAHEmfsZNcsSWVampscGUY/naOubqYfblBpNjIrLsIrEOq9u2MErwvWRYRJi1qSJwp3JPX2lfoqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_184421_486126_68283DA3 
X-CRM114-Status: UNSURE (   7.61  )
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

T24gOS8yOC8yNSAwNDo1MSwgTWF4IEd1cnRvdm95IHdyb3RlOg0KPiBSZWFsIFJETUEgaGFyZHdh
cmUgZGV2aWNlcyByZXF1aXJlIG1vcmUgdGltZSB0byBjcmVhdGUgcmVzb3VyY2VzLCBzbw0KPiBp
bmNyZWFzZSB0aGUgd2FpdCB0aW1lIGZvciBzdWJzeXN0ZW0gc3RhdGUgdHJhbnNpdGlvbnMgZnJv
bSB0aGUgZGVmYXVsdA0KPiA1IHRvIDEwIHNlY29uZHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1h
eCBHdXJ0b3ZveTxtZ3VydG92b3lAbnZpZGlhLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

