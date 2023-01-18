Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DCEC004D4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 06:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0f8yLUX8KjlXDsWoGk/scOrHjQM/CpnxRGpz/XsnK/c=; b=JHDCHCigyg16NWm4HTE0UCa+20
	5RTlzzw6oGafvFpsK/oupZ3fyLcp30QQsHvqGifBa/VhTY4RMVRtklHVZs/t0U9QqIS4YmX8M3J0a
	STMctFfNSrm1HSR3ZdFNUzgf9n2vjDCPLimYS6ai2J7nSwCRvrDk0w69qc9HGSit3zehDLbVGmzr0
	oT8VMZvIzysr0iuzDpJYYuEEUqvaGNNeY74pzDRnVFieHvQcPoe2UPL+KGci3PGILxEoaBfX0nxg5
	P5KHuPzjjJVJ28jStsMb+yND0yz1P5GXbPuYcRnwgW2gG3PURA/WXc51RWHcmJMxif/XE5wo7bmGm
	alInw2dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI2FH-00H7wZ-Fz; Wed, 18 Jan 2023 06:48:27 +0000
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI2FE-00H7vM-9C
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 06:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPnVaoyKrcq8aHbEvHnjw9Vr+ypF4sbt3Mb81NeDOB2PxfqXbcD5XT7Y1/HrNrIsy284AtmWy0AnOi/6zeM4dujUyjoL0mWfzt2k/zUSaFQTLSkdXlXpUllYkMfPCwvUFK3juYWB8a6srese1e8voSqRWu0A6x/Ic/4KHTRtFrL/X6SmR1vLuy2ZsqnTvl573yPsAUJMerbhaoKDELa2/fqnN9D5vQaIYbTdJ7nPYHcBHU+sgE7BYAX7FIDvZquOgVHQeLhAN8wTitSU9lgYF0tDZ9ijSEPbF14nCcpqoZ44RXJyTKEW6X5d3E8Wt8+S+NdFjnRKE3PZiFaHVbH7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f8yLUX8KjlXDsWoGk/scOrHjQM/CpnxRGpz/XsnK/c=;
 b=gmB+vOxlYqig2ELxCfcVoBFqQ7xydbyUIPZvjumMCEPhxXEOuZVXvcE55FnxoAMyAh9+1E0j9NdJJYwv1kejNRm0/IfilZGxBIcNz9lKVty2oA1X0iwsOF7oT0Ooodx1GXFzRyuGi3OJuxvbVN2tLHfSLGkI34pqNxHYI/IMpWfv164K5EPjOo73ceOi8YyFwmG5dqH5430R6ComJgfOA2PCa2qgNI1SMQq7K2gDVvzYwJ2OK7V8ZlzX1S0lPQ24cAFNzjwwqjzVsGHyi0cp7912WX23TLcGQG/o9ziQxv8iPWj/PhVEWDTyDEcck8PL/1Pnrte+CuvRoDWhUwncmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f8yLUX8KjlXDsWoGk/scOrHjQM/CpnxRGpz/XsnK/c=;
 b=S8sIuFz1WNa6NLYwe3epOaPXnknVNJAKoSqZ4/M2FqVl9lJskWeEpS0OyOsCzDYtByitzfa5kUPSgR4jbYSvLRKKWOLJH0GH+cGGnBZRCqbnvZWNUvLSdb3yDuPicMu/jHiD4aQjQs13P/dAiTo+Mbf7Np91dmygbOm0jJ6kAh5hprj0moyGU2DZKQRjuFjqydNu6SSGbIrY7IRzaLckYperP1rh1sAnAWc4azv8jhM5PkutfYI8KeORMLnTq1UzFFP6zAmvJyB0MYnJRHt45XcBeNnyPSIbpXPwYB/6YM3JlNsBQw/17v894o+QB3vIyUSc/Dss63JgXO/YVtPyBA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 06:48:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 06:48:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Israel Rukshin <israelr@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@infradead.org"
	<hch@infradead.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
Thread-Topic: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
Thread-Index: AQHZKMiq7GXW8ulP6E+s3WZB+5NcBa6jwCAA
Date: Wed, 18 Jan 2023 06:48:18 +0000
Message-ID: <90404ac5-3c7b-e0a8-8fae-6dc30485d7cb@nvidia.com>
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
In-Reply-To: <20230115100341.40347-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB7282:EE_
x-ms-office365-filtering-correlation-id: 261e9924-e0fe-46e7-a348-08daf91ffbd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  X5Mx4tTa8GID2QFBYxmJFiv26baYEEA73Sw2Js6k6+Zekf1dySNRB6oU3fTN1XAGmsIkesNaIcP39zCRYJKrt3QgX1d067mwtINxanDxpKn0vwcGIN4YdLwCYzkyeq0kkad66jrXvrjGnNEbgXQxUuuT81WwMY/HuKMDZtLp+6Q+NIhun0INVefqbMQgYqIK70pehLdZfRuncMxTrjrJHKUst79n/s+8RfeFOO2leHbU4qtLzqJXefeVIrW6pbxOCxw2giNJZsgnkYQmukPndojuhMQhpwtleELXSgIJnRRkhTpuG1alB2YQRyUrSLkwBSQ6wxGBpVSl1xxZQed+igRCb7pFDE5Qh+mjz/sRE/IVLGaobo2FulFzDwwwbEqrTM2m78CdmTEVyg/3iEx/PIUM8uhl6msJYTe39MHy/uwz3A6e6Rps0fn1xFihBjWd4UwzQRiIQHC2fP7hyElK8bFNY6waWJd0VDrUuM5to4uO0/fAbrqD76Sp7vki8umSqXVH7OkioHsSlEZZrXMT5b6bDpooM3XBmFV/NzdtqTtwx0jKpyQmLwsxXdPE2E0GLh1lxO6agrr47dJPqzaPPzmf9IisdZ56pmfbG40t6zyZJPxhR/NJWOsVDs70iL9vzVX1Y23HfHfrD1NC4eC5BbSBNciUu4em0EjSt1Fmb1PzA6HXqxY5ZW8wWlmxN+/q196BrZtj+n+jmxbGp3/N1rG8NihNZ3pxhX8HxliPLxG58FLwmm9pNlrRQb71eq2ClQXBQXCsB5iXHqazXkr0Tg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(122000001)(71200400001)(53546011)(6506007)(478600001)(6486002)(31686004)(6512007)(186003)(6636002)(54906003)(37006003)(91956017)(316002)(76116006)(66946007)(66556008)(4326008)(66476007)(66446008)(64756008)(8676002)(83380400001)(41300700001)(2616005)(36756003)(8936002)(6862004)(2906002)(5660300002)(4744005)(38100700002)(38070700005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZGUyS093d2svblpOYWN6elFuc3ErNDlBZitpMm9WRG5yandCUW5wRXBVaEhM?=
 =?utf-8?B?YitMZFdBRUxpQ1JqMFNSRDFINjBHdUVGbmt4UWJuTjRFVG9JMXhCd0JKbWY3?=
 =?utf-8?B?U0owVHhPZjF4QTU4Q0ZGNEQrOXJYa0hIcTlJZzN3d2tMKzlEczc4L1RmODYv?=
 =?utf-8?B?bU9PNVlxMEJldGYyRGpyVDA4aGt0OEhCZm82dWpWWERYSEpDS0R0cm5LMENu?=
 =?utf-8?B?K09aY3EvYzA3RzJaSDBRb0pGcTZnbjZQSnRVODkyVUhGbmh2WUxXc1BTWWRj?=
 =?utf-8?B?eEl5eHdsMUU0TDd3eXBwSlRSb0RyczFndm5sWmo4UkhFQktmUjkvVzdsUWFU?=
 =?utf-8?B?S1N2YkZVbU9ZR0ZNZUpyeS9vYk9lckI2M0pnanptYm4vcWYvTkd5dlpVZDZK?=
 =?utf-8?B?YTJwMHlyR2tUMndobUdOWGZzdXpQSjAvbXdQajFLaWJvbWtlUE5Ubkp4UjJk?=
 =?utf-8?B?allYam1ISmRyanZHYjFmSnl2N2REUnFSM2tmcmpwemJ1WDRjOHNqSTJUUFBJ?=
 =?utf-8?B?cjhUVHZHeThSalc3WENnV2UyWm5vODcrRHh6NURORjVmNWZkS1d2L0NkQitE?=
 =?utf-8?B?T2VYbnN5MmtyOEl6bnArL3lTdXU4Tzc5K296UHNOQUV3UXhYSWo3SzRWRUIy?=
 =?utf-8?B?aFYzMytsTHI3UVpDM3N1V1l3U3J5dExsK2F4U1o0bjNyY0ZSaXFSdWN5c1NZ?=
 =?utf-8?B?dmRXdkhQcGNKMXNXZU80eU9SZVdYVURaRVVUbXMrVjNwV3hadmR4TGt2NmE3?=
 =?utf-8?B?RDFCQ0JCYVhuNWcxZEk2ZHBwdW9XNk5lQ2p6TzAwT0swclRvRWlmcUthVjU1?=
 =?utf-8?B?L2NBQ1c2bmZxSXdYaktlYVY4KzdpSWQ4SmpNOUtvbUJVSkFBSGNwTEdhTEd1?=
 =?utf-8?B?NGVyVVgzOFZBcm91czNEWXA5VlR1aGx4V1BYV3lndmowcm1ueDFPMFkyY2Zk?=
 =?utf-8?B?QVc0THZRR2gxU0loa2Znd1JETGs0dG1JdlhJMEFSQWRHM295OTM0T0tZOWt0?=
 =?utf-8?B?cENONEhYSmswSUtZM0VEclpNM09CblBNQkZkejQ0NlNFdGhEN3hlQ2s5RzNm?=
 =?utf-8?B?M0lmajB6RzVKTEZ3RlYxNzBVV2ltOFpMZ2RsMlF6RkUvNzRJa2VxcUs0YzRi?=
 =?utf-8?B?YzhldnJHa1dXcXdadXpyWExrclFhenZSaElrWnVNOFk2NHV2cmhSemRXMG93?=
 =?utf-8?B?QWMzdjFGeDJ3SXpSU1F4c1JiYnJiK1pPTDFzU1VJbHNXUUVyNkttdWJHaUhx?=
 =?utf-8?B?MUlpYnNDUUVoZU01VytmaXBJcGJFQ1Q1ZFNFQnRoRCtvVUk3alNYL1NsTTFr?=
 =?utf-8?B?bzZCb3FVOVUrRG1YVVEwdm41WVV5SmxUYUtwalZFQ3pyUHlDaW9rNGl1d2Ez?=
 =?utf-8?B?OU9DUWtZMnNNeGJ1QVJiTUpkdTFJQ3B5WmM1Q3Z6WEp2V1RZZWlCNGxlV243?=
 =?utf-8?B?Slp4YW56V3Y2L1NTTi9CaVlJL09BUHFUMTR2NS9RWGJVTUxTcmVBZ0hXamJr?=
 =?utf-8?B?dEtZbk9PRlNXZXlNb0NCcmFhUWw0ZnRzZ1JZNjRsQlI1aWhBOXc4dXhwdVlD?=
 =?utf-8?B?ejlVM0IzeVRmTlV0bENiUThYUGNRcjVWN282Z3B3akFZSVJpY3B0M1o0ckVy?=
 =?utf-8?B?NWY3S0RHOEswd2gvOVJvSzNFWEhxTGJXTmpoOEZxT0NITjByY2JFNCsvV3BF?=
 =?utf-8?B?alp3eFA2ZGZrSUg4T0FTTzc5c2EvWG1JNFFmWUl0RnRBNWM4V3FZeFJ3cVB4?=
 =?utf-8?B?cDJZcWRoTWxMd1pUbG02YU1CRWFFQytwU3BVeThtNU1xNElqbnc0enkyc1Ru?=
 =?utf-8?B?Q3FqWmdPNlo2N1IxRVpPeHpHTDNNckRMbFpmTEp4TGZXc2Q0VE42ZEVCMlVv?=
 =?utf-8?B?bUkybHd3UnUrbFFuNlZUbk1STC9YSU8zNEd5RVJ6TW10c0ZLdWY1SytIaUZQ?=
 =?utf-8?B?dTF1cHpKeFNjc3hzT1g2c2kwWW5SZkZOVGFGZG1iQ3U5cXN0THIxQkVvQ0p3?=
 =?utf-8?B?ckk4S1lyRnppL2F5NFlId1ZLKzByei9XdUVIZzFyQUE4RnQxQWRnc3FDbkdy?=
 =?utf-8?B?VTV2K3hMb3JBOEtydVF2aDQ5eEh3dmcxVWYwT20zclFYLzlJb01wRys0aHlR?=
 =?utf-8?B?R255U01jM05YcE1LcldOWFNMeDJUNHhWbkx1MkdIM0dBS1hRcnc3M2VjaXhW?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7876DDBFE5A5A445A16EE6D2FB862940@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261e9924-e0fe-46e7-a348-08daf91ffbd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 06:48:19.0262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MAnwnIigqMPv74GY73oM71JnUnw5ygATaDVTvqZJ6PbYpaOjLycPIYocUV3GAjiem3yckkkT5lAXoG8TD/T9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_224824_369714_228BF925 
X-CRM114-Status: GOOD (  11.88  )
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

T24gMS8xNS8yMyAwMjowMywgTWF4IEd1cnRvdm95IHdyb3RlOg0KPiBUaGUgY2hlY2sgaWYgdGhl
IGNvbm5lY3Rpb24gcmVxdWVzdCBtYXRjaGVzIGFuIGV4aXN0aW5nIGNvbnRyb2xsZXIgaXMNCj4g
ZHVwbGljYXRlZCBpbiBzZXZlcmFsIHRyYW5zcG9ydHMgKHN1Y2ggYXMgUkRNQSBhbmQgVENQKS4g
TW92ZSBpdCB0bw0KPiBjb21tb24gY29kZSBhcyBvcHRpb25hbCBvcGVyYXRpb24uDQo+IA0KPiBB
bHNvLCB0aGlzIGNoZWNrIGNhbiBiZSBkb25lIGJlZm9yZSBjcmVhdGluZyB0aGUgY29udHJvbGxl
ciB0byBzaW1wbGlmeQ0KPiB0aGUgZmxvdy4NCj4gDQo+IFJldmlld2VkLWJ5OiBJc3JhZWwgUnVr
c2hpbiA8aXNyYWVsckBudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggR3VydG92b3kg
PG1ndXJ0b3ZveUBudmlkaWEuY29tPg0KDQpUaGUgc2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUsIGRp
ZCB5b3UgcnVuIHRoZSBibG9ja3Rlc3RzIGZvcg0KdGNwIGFuZCByZG1hIGZvciB0aGlzID8NCg0K
LWNrDQoNCg0K

