Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1517C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 06:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R2627FP6ZZRf2YGpvaAgpNzB7pvuF8Bq8CyCIiXogF8=; b=MOcLn8YizfOs5EQDUd2wLRX9pW
	ZAEnePLKbEmOm22Z2/AAv3o+btlsY4oUF6HrfEPzlbU+FBVPW7SMpEbIWdTLk6D3LEvPnHk/xAsR0
	nJPeSrsPBPldqYg4Y12RPdmOEESpcjHzsULAoluxPIGG29a0UibMzUuUH3ceIyNLGwJGYGQUD8qJ+
	ukgE6Fb4Xh1aNJ9YTas0sDe8L7BqOW4ffcD4+1Yz450NzeKg389cV8shOj1aMVJwrRSiFvEwpSzen
	afzUVXTTxSHlV/bIoY1O/wq7y+4WLKTvCYYgIwd6FKf4ruM5k+FG9Qyf0LztTEHpon6ZrGZ1l3/5V
	iB2ubmcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nF9SD-00EKc1-EZ; Wed, 02 Feb 2022 06:49:21 +0000
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com
 ([40.107.93.55] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nF9SA-00EKbC-5f
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 06:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmByL7HImuVs5nn0vEClaVRQS+8Cev5eIYD0Z0biveoxTTHWiEBKYDc83q9qgUjkNR3P1WLzr2+SzX/r41uzPadb1KEDBXwGB3dmVUF+HMU0lvkrfSQeuLeWMV5OUNBdRJNxLevZKl8wtyiToiRR6VoOq7Xx1iquEEX1uuvn3zH9nuJRDBTMSgJBHEFZ+HWjGyDtWoWez1SQBBIRcTIg8n6F07lSZ05r2zxTBRjJuerqNm39rDkpf+cf3bJyXr79rU7h4kfIA44JdVn+Lk/mb2tKZEEo/v4DbSJeMOM7IIBoq4v82D6QsfOnb2bNMGCvsVoi8WUE/e9PGVvSi6PIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2627FP6ZZRf2YGpvaAgpNzB7pvuF8Bq8CyCIiXogF8=;
 b=Qg2CtA/SRJizbMyI93jTgwsJOs8Tgrhkjj3jnmx2RpUf5H9SejYOMgchvMJg8EA57jOZbw9Oa+5EskvhXS3JQg/X8PIejQvS+t4WMZcnRNrJr6Lei9vJvNVNEDa0xdafebJJs9AVxVZ9KA68z0hh/3XMUcBrPVXmM31NEH3KNWoQnnIEp9Xgi5Jd6btx0OocHHeuoRrHs5ND77f4fhu3zDKK556397WUGemkMROjoH/yg6FC3pi0FJ04ZnRyQ1ekVwXSlaTN19IeE1NVUvVsOtl99fWY+ivHdwoFaQq2vII7cGzmIWLQZlwDVABm1VO3Ek1n+Gsc5DsrF3JBWtuqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2627FP6ZZRf2YGpvaAgpNzB7pvuF8Bq8CyCIiXogF8=;
 b=JJmB+Nq5bv56y1UGWB/FP1Dz6mgyE1X6fpAzo0SMF3gqXz5OWLex/9U/R7gWq7ZFu90JRf3XjzV238Wn39bV+naEognQq14cZMqbB/YNpdcV3sBjZSm/CZf+kfRLi7p1gup++q0HVeFNQ50mzyRf99lSRU+s0RZskAJQ7BrbBKqLEtNlvZXFBvOEGaKUphnW7jiqszUWJqzqOn3wncQIJ4F0BAs+wn+0XY4vDBtpSbhLCoUoToM6rAIe7S7BwqA15d2HgHjasn5SzVhtBoeDNRbETNMlFyqF9+39Lt8lmz1oRdssOAmAgCkWk0A1lACKBv8JOAvSgJh4IMxlAPMIWw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4986.namprd12.prod.outlook.com (2603:10b6:5:16f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Wed, 2 Feb
 2022 06:49:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 06:49:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH V2 2/2] nvmet: allow bdev in buffered_io mode
Thread-Topic: [PATCH V2 2/2] nvmet: allow bdev in buffered_io mode
Thread-Index: AQHYFCRqb1uWtu33+ESogmiA6VO9pqx+XLmAgAF8+QA=
Date: Wed, 2 Feb 2022 06:49:15 +0000
Message-ID: <a04177a3-9a2d-c949-7e87-3d3dbab900cf@nvidia.com>
References: <20220128085148.11638-1-chaitanyak@nvidia.com>
 <20220128085148.11638-3-chaitanyak@nvidia.com>
 <20220201080541.GA29678@lst.de>
In-Reply-To: <20220201080541.GA29678@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8196b90-7ff4-4b36-105b-08d9e61820bd
x-ms-traffictypediagnostic: DM6PR12MB4986:EE_
x-microsoft-antispam-prvs: <DM6PR12MB49862F2C331E619176FA05B7A3279@DM6PR12MB4986.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5juwbeEV9oRPw6wpQ0YSRTE2nfqzfH4b8LYMi3ENOghhXuYshKr3dZqsktbdXfOA8rSQwX1QD/iT0eHP+imp7NcI8ODklo8+e2bNu7TwUPO9LnhYuW0u+wT3ElCdjVedwKswBHUkHdJBIKXsGzgFuTkztaNgk67e03dN1NsLHcRNHW+XLCZXgod5pQZxV9uycCB8dOt+hcuXHUWrQP6k/EVKEisjgdljkKcxtGspQtgXl+qg5BCVg1oEvieALSlpcdcLz7YGjxZbDtAmbXV9B4fOj5wTNQ1GxGsdHhdsfxEvkzvu8QxAQjjHhR6qsTjxuaHsRXC4a+LrbdINcl5zYnSwX9LPVl1RG/dZRycwePFFflDGzb+RbfKMbpMsrKnUn8loysFv/YT7Xc4rpMXg/2Vby7HbsOm6HY3sN7BX03z2PwVrk/+NkwX6cNVgx5xDQr1nIyTaCRKMKCQOdgSesfuheIZdkTfyt705Oim5x00UfPxiAER9dnLpkUPoOREY7WvkxqYz/VM7ugHdhaiNKTESRlcsyWoQgLhCvyKKt20zguK/KPaNUOwrLzgy4FSwApL0srQnqAYb5HCIAgD7PYDTsEUDWONu41+j0/vTCdqDfpqY/o0L4iEHKhW8kt9h5yTlSn/9/UUw12C08Sv3gcrl9RkvgisohKG6RYIk1B439/M8m/nA5fToF4+c+PcUB6L/aduuas7EEYDhJ3Jbg0BrpnZ7zaqBwNclOfbjNGFZVDYF8ALlJSr1S6O93YoHC+pFgmHj2BdmoweU5CATJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(8936002)(4744005)(36756003)(186003)(2616005)(54906003)(5660300002)(6916009)(316002)(86362001)(38100700002)(91956017)(107886003)(2906002)(66476007)(76116006)(66946007)(122000001)(38070700005)(6512007)(64756008)(66446008)(31696002)(71200400001)(6486002)(6506007)(66556008)(4326008)(8676002)(508600001)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Unl6SVQyNnR3b3E4c0ZRN1NYc0NZblpMeGVOWUllQ25oVVlsM01qRFRXVDNu?=
 =?utf-8?B?WDFPaHRNeDU1bGRpWlJGTWd6QmtEZDFJQVl3eHJEeTVmay9kL2RrT2ZveVVC?=
 =?utf-8?B?dFRBeUFFNVg3UldWK0tsSm43WWRrZmlQODBVNFJnUDQ2eXpCTjJPcDBFVVVs?=
 =?utf-8?B?RjMzRUNXVHZhLzlZSG5SbnlQOFo0K05sdEQvNUdLYUNyZ20xZmNWL2RLc3hM?=
 =?utf-8?B?SDFmVHM5QnV2eG1tdGc2b2JDUzZjU2RoRHlISTlPK054bUxUNTRJVzBrNVhl?=
 =?utf-8?B?Tm9ZNVUxVWNGcTVwTEFXYzg2VGNUUkhoR00wWE0yaGVmVDdIa3dOS1VDaHp5?=
 =?utf-8?B?VUQ4WmZwNlM1Sk95bU1CMzRVYzBhVlBlbGxseUxmZmxPV1dSZ0lEQmdMbG5M?=
 =?utf-8?B?TGdiNmVKRzArQ3Jjc05ObDdyUFp2MnZWL3NlOTErdk53cTZpK0dqT0RYV3g0?=
 =?utf-8?B?Ry94QmVtemQ2dGU1QlVZRlhXUlBRN0VibGFsZ2JxbWhhNitTS3JXd1REZ0Np?=
 =?utf-8?B?ZU5SMVpvRGpXdkVsRWFhMGcraTZURmN4Qnd6VmNLRzROSHc4V0xMSHZiOWRr?=
 =?utf-8?B?cXFXeEhyWFBuajk1czd6UUpDbVhzamZobUdiU0pHTmtKSGJhZ3YwWXdPamcr?=
 =?utf-8?B?RmNNbWZnMlVrZjV4azFFbm5CbWwvVmE0YngrOUtVaDVJOTZyRTRXTXBzTlpK?=
 =?utf-8?B?RktqTElYaEs3cVRmQms0NDUyVUJkT212c01SNXRTVmhCak5IbCs3NFpqd25Y?=
 =?utf-8?B?aHB4SmFwY1FkU3lybEs5VHlJdnlXS1Y5TjhCVHJWRGhoT1lUdWtFU242Q0Jz?=
 =?utf-8?B?Q0ZtMUF3SVRDSmkxa3k4QnJqajlkSUdSdHFQSzBXUW1KOHgzUUhlN2NkZVky?=
 =?utf-8?B?dlpMQ3J6S2VSYUlKSmZvNDFnNUtBcUNYMktjZ3dtMklKOU5Uek5QYjh6Smpa?=
 =?utf-8?B?UEk2RWwya1QzSDlZOGxVekN5Q3N3YTdOc2wwd1ZEejdpUlNJQ3NJV2o5NDJW?=
 =?utf-8?B?MFdnVm5nNXFPMHlWTXBGTnYramFocVFnd3dWc01KMENDd05SU1ZZZ3JqUGwy?=
 =?utf-8?B?aFJUVm9pNnlHdFRJUFpOMERVbXlXMDRLMkNrakIzSFFJbEFwcDJtTTM2TDI2?=
 =?utf-8?B?bnMxdXZaZ1NVbGpYdmxJT1NRc2xPMVNqbWQ5dWFNbnhaNVQzek1FY2ZPeFhw?=
 =?utf-8?B?T002dWc4K2JhVk9XUW16SGNHek0wbEhKTGJOVW1XM1RualF5MWJEMllVMjNh?=
 =?utf-8?B?VmNDUXhQdTFMTFlCaE1yMGNVQndnOEJmcWZyUUJPZ1JOM0NnU0VVamdmVXhp?=
 =?utf-8?B?VUhnN29UeDlONHdXWFBjU1hiYzBwUTBsL0JiV1owdldGdTNiWGFhbk9ncHdF?=
 =?utf-8?B?U3FyWkh6NGtKSlpwc05oTmp2Q1hjMExWcitDKzJvVzVQSStlUFdsWjRNbElY?=
 =?utf-8?B?bjlSNXlQK2pmZUdZcG1YVSt2ZlRHUzVlN3U3VmgyOWg2eVFtUmlWT3ZwU1U3?=
 =?utf-8?B?TDBIYmxQY1BTSTJ5d0taaG8rbiswK1REMG5XT0lRT01qMUlENDJCUDhMMjh1?=
 =?utf-8?B?UTNkTXZSQVIzVnQvS20wa0h4b3JJd29QVjIzanZ4Q3NDeGRranhuSFhsMThX?=
 =?utf-8?B?bk8zVDh2SjNaY2E4RHgzZDMrQVROZ2JhRHA5OE1wazZ6cng2eWtQenpVK2hr?=
 =?utf-8?B?M3hLZ1FnckU5QnJVTU1ENUNYM1M1VXM1NGRqR2lqaFk1cFBEcHJ4QnBZTkpT?=
 =?utf-8?B?UDVnWFpqdEZSRFZCMUtUU1UyanNZQXI4czI5NzJ2bFBobGUxMEJDSnZTQWtK?=
 =?utf-8?B?dEJieTlhK2xtM3hTNUozNUJQUGErSkZBV0ZKYm5vT3FkR1A3N09jb0JFNE41?=
 =?utf-8?B?UzlJblhxUkpQdk1qZnd6Qlp1RTM1ZFVuTnNLZGpaVWdxUmtwVHAvT2RIU20r?=
 =?utf-8?B?VEVqTlc2NStTN0F1a0xSOHV0cHdKVWxTYzJYeTFkakxVbWlTbmViNHdCbGZE?=
 =?utf-8?B?VUN3Y1pBWndnK2pNVEdjU0Y1ZEJ5T2hvYytySkluamFzSUoxaGRBN0FDbXN4?=
 =?utf-8?B?TEZlNkNhWWFiM0gyNzcyTU9vRDhXdlRsbEdPRzZBejVBUXBYN3ppREd3OXFx?=
 =?utf-8?B?MDRjU0IwbEFTcllrVE5pUUZWQndNWVRKTkhtYm8xZUZPQkVGZHFBK3JGUWZN?=
 =?utf-8?Q?99PsH0rKkT9viiuRKhb5sV9sDJFaGIQLeniFthFuoyxd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DDCCC97BE35EB4AA6F08FD11DF82AE5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8196b90-7ff4-4b36-105b-08d9e61820bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 06:49:15.1407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rA4Bl9xPiEyqzwIMkDbCbSwuycYLDU5OKlWrd9g86NiVX0qs0Ok2zg1f6RdZTNB8Jq6FUsP8biW4kZEEsrQsqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4986
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_224918_257903_23A708A1 
X-CRM114-Status: GOOD (  13.84  )
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

T24gMi8xLzIyIDEyOjA1IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBPbiBGcmksIEphbiAyOCwgMjAyMiBhdCAxMjo1MTo0OEFNIC0wODAwLCBDaGFpdGFueWEgS3Vs
a2Fybmkgd3JvdGU6DQo+PiArICAgICBpZiAobnMtPmJ1ZmZlcmVkX2lvKQ0KPj4gKyAgICAgICAg
ICAgICByZXR1cm4gLUVOT1RCTEs7DQo+IA0KPiBNYXliZSBhZGQgYSBjb21tZW50IGhlcmUgdGhh
dCB3ZSB3YW50IHRvIGZvcmNlIGEgZmFsbGJhY2sgdG8gdGhlIGZpbGUNCj4gYmFja2VuZCBmb3Ig
YnVmZmVyZWQgSS9PIGhlcmUgYXMgdGhpcyBjaGVjayBvbiBpdCdzIG93biBpc24ndCB0b3RhbGx5
DQo+IG9idmlvdXMuDQo+IA0KPiBPdGhlcndpc2UgdGhlIHNlcmllcyBsb29rcyBnb29kIHRvIG1l
Lg0KPiANCg0KT2theSB3aWxsIHNlbmRvdXQgYSB2MyB3aXRoIGFkZGVkIGNvbW1lbnQsIEkgZ3Vl
c3MgaGFkIGl0IGluIFYxDQpmb3Jnb3QgaW4gVjIuDQoNCg==

