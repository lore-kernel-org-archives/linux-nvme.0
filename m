Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A40C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQiBUuuD5tf5gyBhh4Ra5spYQa9o6dzW1h2pco/Ct0E=; b=ZU0cdbY2PstLKD1HYsueEsL4AV
	28kJIUJfKFbJP+ekqkzaHgd+snt30xMFB4ZzOBFkGWCXipC4eKT/gsqEyzcX0eNGTN5RUJrFqGZSU
	fA1koSwsNTUoiyjT8aKJiLjzAnpvoOI+DPnSdPfRrAuJI7cx7Sr6bv7eSzfml5Ze1ZhBgK65f6uvu
	Xt4pvd+qIbwHqWB51H/k3dkhW806KAMj4NL1JYjKQCqSb6lbpHElsBMxYcOJ5MWdd9sTloNM3byoX
	3TGi725gZXlHBKa//Q7dYiotfVYea7uOplV2qqbrktvlwJNAKsRdWQ5Zhn+Zsd1AFACRYLi6nuNWV
	5VutRrJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf2vS-00GyBA-1H;
	Wed, 22 Mar 2023 18:11:06 +0000
Received: from mail-co1nam11on20626.outbound.protection.outlook.com ([2a01:111:f400:7eab::626] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf2vQ-00GyA7-1y
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 18:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LteF+jZWEAHKTDzr1TALY7wbEyeRZNZ+vAuwjof6YUH1TECzybtyJ46Jf00h+8PLbx/iVpeykCjQRxVpgdDmscSEC34T0DrFuyBXl9XXvwZsu9a7TDEfRxmaesro73xJgeMposOMs/aDMMyKLX9lHCawPBqenpI0OAAnj7WuV1fSi48OysWrK5ekNPAsyAoF/KQNzzJXx7MY3fuSNUvgwk1yiVGStGwJBsd3PIkzEuPkbvZ8YXH47Dr3a87kuFXEicaKJEau/I1+cYsOuFDMbA7ifO2TMHIvSUemVk5sy+ZdOvc9OOdKlxs4si9LXzPCATwYPQ6XPhmLYoX0VKS80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQiBUuuD5tf5gyBhh4Ra5spYQa9o6dzW1h2pco/Ct0E=;
 b=NliqCPmfWdp+Thbtg+JbW/RwgswzpkpygtZI0rrYYLgymWf5FET0DjcdRI34BXrrJqBR8oID6YQ08KVAJOLuWesDS/PaTLU81diqaPbMvT/zz2g//3v6/5pebz1mMBx4oGqNhTzegTDkQUh0wQKYBcnIkmtZdCb+6U6kaGa2BP12To0Z+Pf3mZ0tB6HquiorfSs6qEVWzLmw+CgjUYfRy8/OXEMSsI2RtDVz8MP1pqmOMUhm+8EQ9VPXf+hjqgj4s6SBIlgi2o3oopSa0j4l1bVDUz3klTxGwAAl4WtXwT2ft+Qp/GQMMrrWEUSIKp+t4bAFV0L+MjD8H5lgwvR+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQiBUuuD5tf5gyBhh4Ra5spYQa9o6dzW1h2pco/Ct0E=;
 b=lK7mRHtvhFz1dJ1JTjql+xa+uC0vy/9iRzjM3XLWYpnasEAihVLnk/v6TliWtvdo2+EFRnLwyVNzummahK3nxhsERUPYwnpWx8lgTSUOMAA/4rIRT8jzHCWEVP5ilEj5a6ufh+iKY2b18MyznoV59wHd2JbfjwyoL8StdZAu62o0vS5ykyNnVWacID/pCGw2QvlZTvkSOihYmlQwUii07oYSk/QJ35PrA+QKoW7STYE9VOx0tbhgGvvLBxWhWHAuCaRRbSeVW535+6m33ySAkQM2MFcMiuTQ4qlH+giSFevXu0WKZ3YnwHQ2J8xb/p3WbpIQqk38jMSiYlgXqVSk+Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 18:11:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 18:11:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: remove nvmet_req_cns_error_complete
Thread-Topic: [PATCH] nvmet: remove nvmet_req_cns_error_complete
Thread-Index: AQHZXJWldSbE8p2HmUKDSK9166nMaq8HGiQA
Date: Wed, 22 Mar 2023 18:11:00 +0000
Message-ID: <75aa7cc3-fcdf-4ff7-04ef-da9c243bceb6@nvidia.com>
References: <20230322080930.230269-1-hch@lst.de>
In-Reply-To: <20230322080930.230269-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4261:EE_
x-ms-office365-filtering-correlation-id: 17f2f45e-b9ee-4221-3e4a-08db2b00caca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  mrjjnqcV8SJBNyFN+9XRWf2Ssf+zeu6/QSTCtfA9doOhwpoC+k8j7S1BEQ635bzrGoy0syqZzP7RdhqdpJSk0QXEX9FuWIxpQVY9uRp9G7NdVneBsOyI4D924HW4hHqJsYN+bicFUTw+aceFbjTHfw3IJ8O9Fl+Eu4iTcbORDmoaRDZT2NrClV0nWutS3LER+Iud+I6Voh7E4q4PEiUlII/h8tuJ8j+aHQF/tKtA5VLAMcLCTXn4RU7+SkdqrhXtaXVJX8JZ07wttpDNE3g3mri51F3osidU31I45cphbPv5uQEtuPrx/pN5Gt0/NSPvH9Uqa8OSqDTnZawZUFJ5i2PQuNIG9Bcez/SNQNw/7pp2ULZ3NZiTsf9hG7N0/lthcxPHOWQBaEz3IK9t6zkZ0B8duO5OxfQxMUKfsoI4UOBWsVflnPAPAkbFvFfPr85+q8CHN6aaf4+wXu5Db4ToTnM68PVHgC0g32wzTk5SmZr4mCSgfyU1woB9wip9zUht3P5+wST1FmXsky+ff7n5GmjNarzJdXcKc4IWIwdBRnag7YJW5ur6BUtkjsn6c313uQ/ruWSeLfuP3PrpnoRnDiuFGqAasiMkQh11Jb6K7uy6SchPh1Zw1Sx47T6VtCExY7vwezHH+AOtDLm5MEUfvPRtJuP5/QCKGaJ3J8cXR96OvLo5a9kS/kD/JxPBoXYO1217JIFIS/PWdUIC+jt2x58LCxqJVp55+yE+ntmjct9RzPhU9M8bfg/VdX+Kcg8zzixjg65pYc7dYxZxlJ5q3Q==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199018)(53546011)(38100700002)(8676002)(31696002)(71200400001)(86362001)(4326008)(110136005)(558084003)(66946007)(316002)(36756003)(76116006)(91956017)(8936002)(66556008)(41300700001)(64756008)(66476007)(66446008)(478600001)(2906002)(5660300002)(122000001)(2616005)(31686004)(6512007)(26005)(186003)(6506007)(38070700005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NDBldHR0ZnU1UEpTV0Nsek9Zb0tXU2Y2VHlaeG1vNnpOOTFaNlVzY2w3VFZZ?=
 =?utf-8?B?TmlDY1VqL1BYVjNkQXlLNHFYS3kwL1NlYUxGeERWK3ZyUUNva2gxY0FRWUJ2?=
 =?utf-8?B?TjlwR3dISjBvRE9CMnNnUDlQQU9NUGZvbHBqL09KcDgwekV4b1FTY0M1TGtO?=
 =?utf-8?B?QzVxdHlzNllidjAzcFVyc0lRMlhuUW5qN1ozTHBGTzl4eTQrdklKNG8veVdV?=
 =?utf-8?B?b3BDM2FQNTE3bDlnd0hUUWllQXpUSER6Q0tlVW1lc01xWWtVS0oveHFLYjF2?=
 =?utf-8?B?Rm5sS0VJajVVd3cxNWVBZHl2dVJteWYyZzBUckVDYTRRNU9jL2hyOHFmQ1Z5?=
 =?utf-8?B?aHFGUmp3U2p5ZFVQNkRiUEgxOTc0dmtrM2dUWWRYbHlEN2d6UTAyNStpOWgy?=
 =?utf-8?B?T0F0WEhNdUtNREh5dXNhT0xtRTZFUjR5amFKektHN0JOTDlkMnNQSWU1NWNi?=
 =?utf-8?B?ZWFqcG1wTnVNb3dMK3ZOWDl3K0hML2Q4NzVPd2JnTm1GOXhqZVowZEx5VmZD?=
 =?utf-8?B?WmZOOFpOQlZkNDZSYkFvWnI1azBGZm8xRkZIS09TMGFQRk44UGZVYVZlb1lP?=
 =?utf-8?B?NEFOODJqTzJOc1NEV0liakNVRzJKSlZXNVI2enpXZnVLMENJZTlTSFhhS0RC?=
 =?utf-8?B?UDhxNVFjRE1HVm0zbGkwNlVTWXI0WXFvZ3oxN1g4YjRNUEtQMEVEMDltQkNj?=
 =?utf-8?B?Z1BCd1J2dUF1OWIxWGFLYzhwTm1MUVQzU2FrOWJpRm40RUdnMm42WTFGR29E?=
 =?utf-8?B?UGVaMmlLQWJUTDd0TzJMRmduZHZiSUFYbE9QRDlMOW01UlhXQlQ1WU5UY3I1?=
 =?utf-8?B?YmdEUlUxM1FnZ3BGQitqYysxK3Q2T0pYVy94TTZRK3RqNWFNMTRZRlA3OUs0?=
 =?utf-8?B?NHBmQXhyQnJlTVByOEl1UkE4NXlTVmkvQWdOL1NUbnVwR1RKNU9SdlZ3TUhx?=
 =?utf-8?B?eml0T01FNTlKejFmS3BJbzdBNzRvN21HV0hXRkFhbDh4YU9wNUdIaUZtbjNT?=
 =?utf-8?B?djZYRVErQW1GYU1ZcUlLOG11VWJjWTlPMzhtcDVNd2ZWdmdrcDY4MXF5SnM0?=
 =?utf-8?B?TE93bmtCVVdsSnB2a3JZbkR3c3pHL3ZCSlVFL0hSMzlTZ0JOaFdudEpORWR4?=
 =?utf-8?B?dzZSeU8vc3JJVTQvWEtUcjhUS09veWtXM2FHWlpnU1F5MTVwWnlYci92RDJR?=
 =?utf-8?B?Q29vNGdXMVNwckI5clJ2dDU3Z0NJdVhiR3FDbFFHd1NxMkhJa2Z3aVBGSHdC?=
 =?utf-8?B?MVZMUGlrd3ZSUkN1cGsyRXNQd0YreDJ6RHhGK05McGNNd2o0VUdZZ1VYdHVo?=
 =?utf-8?B?dEZIeDNpK3FlQmxtTUNpejZ6eW9LYkJDNVZpb2hGOHY3aTZFWUg2Z2tmWjRF?=
 =?utf-8?B?SzhoNGovWUZHZHB3aXZHVjF0c2lKVGwraTIzRENzeTl0dElxbTRRc3M1SGZE?=
 =?utf-8?B?ZTA1RUg0YS9scnhYTTlXYk5ibElHVmQzc3VhbkRvS21DVFRDcTBPUldKaWMw?=
 =?utf-8?B?NDJGdXVrT0RiNTBCVWtlcEpCWVExMk5wMGR0OUM5WWs5R2F3UytmUGpBdHBI?=
 =?utf-8?B?TTEyeW0xbTVMZ3kvVitHVjBzNVJMOU5GQURwMzR4TXZXK1h5bTJkRWxrU252?=
 =?utf-8?B?cExhYTBHaUJtNDdBbE5BNkM0VkZWS0xRaVI1Sk81dzlTVktHb0N1SG5FYmQ2?=
 =?utf-8?B?MWtKNGZhL2FucHlaR0EvNWkrUkIwcm1aY29oMjMxMXlMd21LRDZDK0ppalZr?=
 =?utf-8?B?KzhVWmNJZ21POW5obDdQWCtzMUkycFJrNkVyMUF1U3FVdXRWS1NhK3IyTFov?=
 =?utf-8?B?UDlBZytxVTBuOU45QnlXTi9UK25ZZ2o4YXdpdFZ6b3hYK3llcjJ5Z3lHdjAz?=
 =?utf-8?B?V29adHA1OWNXdDhxY0hnKzNlUGh4M1ZIOG9yZkppc1lGbUg4bDB4cUFoeE95?=
 =?utf-8?B?UkM3VlBLcXhRSEtEZUJjandoWjV1Rzh0ZUFLYlk2OUdXMXY2YkVuSzBpdlFB?=
 =?utf-8?B?THM3d1YxRG55aUlBRlM5REU1YUx2UUg4cjcrMXNZRWU2K3F4SW92ZzZzRDc3?=
 =?utf-8?B?cWZJTlpkQk9vZi9qRDhZd2laUWhudkE5eWttWGlBVE02cGpRUTVwYmV1QlA4?=
 =?utf-8?Q?LhKhw0Voj/DkndVDKanWDqnfE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBAF28485F64A445A9FE709616C4FF54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f2f45e-b9ee-4221-3e4a-08db2b00caca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 18:11:00.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFxsf8dfF0bcMROSaFcPc5wyjlJCLPETPnath+q0zAQIPhL+YtecA4oE4kxsXcP6ukOZ08zMFQcAcIUiV9lN9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_111104_653268_DCA3D770 
X-CRM114-Status: GOOD (  12.99  )
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

T24gMy8yMi8yMyAwMTowOSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEp1c3QgZm9sZCBp
dCBpbnRvIHRoZSBvbmx5IGNhbGxlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPg0KDQpJIGhhdmUgYSBzYW1lIHBhdGNoIHdoaWNo
IEkgY3JlYXRlZCB3aGVuIEkgcmV2aWV3ZWQgeW91ciBmaXhlcw0KdG9vIGxhenkgdG8gc2VuZCBv
biB0aGUgdG9wIG9mIERhbWllbidzLCBMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

