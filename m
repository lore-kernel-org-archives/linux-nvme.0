Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1FBC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2SXoeRzxLfBqxwX8ljQppdHcrQx3gMHGmHUyo/+uOVg=; b=gl95d0bHluNW8ic+PHXiL0NQRq
	jyFo6Ow0o8CqIDhv054qcHaZ1KE47fYarFkO0hIenjrNUKa+BQ/GxCRzvRPaWOU3P9XF9I5Lx93IX
	pu4UBhkPT4Oeqa8/lE9xji0WJP2XZeq2pXoG7CMqB/pFSMnaWKDGkr0A6Xroby2H3KKKtNE6TkEgD
	JJFNwHmGcwCsjotIVJhL9xMGqpe4vjUIaWjNSduHHkm/ahWPphzqdgArkr8KXkxhZ0HAOFGb5CRgi
	JS11lhAeQaLjqT4T7o9vgZJ2kXUXQijTCl/UOWPTTeL+0qknq6zENfZ6NxWuxoxt/3Bi9J14eVQ1z
	PRBr1gzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npDz5-00DAai-J8; Thu, 12 May 2022 18:56:23 +0000
Received: from mail-dm6nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::62d]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npDz2-00DAZN-B6
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 18:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwcuxnWytEWXy46/QGmbhiK8sxn1wtgtw9gVY6sLTQsi3ja7q6rK1yO8HF7FsFRNB3xUrrVwA9Xw2PlKKSNNCJf2W4Jgm4fdKYv2KvECxtAZpqmYhKp/UnXSyzNILYnZcgrvpxzgXCJqSqK/FE8/UpdpuLFyrH2wh8Z74RfT3fh4TQXoB2brqBAKlRYubyPnPBJESPvmPJzhlH31GHBDTeo/lUBrdvaM5AeAuCnAfE25+JCNnu6MERuGuAI+h1uqwsNITMNSl6zS2TxKXLSCeK793x2vIxA9oTfX0etBpr2CNUVu3YrRnZdQmXmGo7b7SxlCHKtZf5OT04DrCX/j4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SXoeRzxLfBqxwX8ljQppdHcrQx3gMHGmHUyo/+uOVg=;
 b=VPx9GwHbnPj8pkkhQ2RTj+AWEJK/61ZkC0NcTUGHwsbTSZ5uCfJzZ/3jwVEoo43+uQ1ZmqufARgm7k6Rrm34i7lVO61Ggo3oPXULKPKZ1eH05p+YTRTnB0pU2JZibxgDcgsSG+vURlZKtysDZQ6VpbMVU+n+4edozph/CmXyLQstvpavnDBFkNd38ZLYQGzVdEyPEZTqREv8N77+RDoflUy/W7+h09MP6R74Y4hmpBfnn/RtkSu2236FqKuyPKKe79+SGJkYbMudH3qrOE1keXQIJlSZqRP5CdAvbYg0f9VZTZ/IsGTS9ufF3FC4dGppr9B7aclyj/Yr+kp3oAzWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SXoeRzxLfBqxwX8ljQppdHcrQx3gMHGmHUyo/+uOVg=;
 b=l7TRVL1zmlmpHS8xlvWWMltQn87DPrSpBs1X/lgduAzivckAXfswucy02Bmy7x0smXMaxiGFcM2VfWvnwsoaU77bXg3Cq+QKIag1B1KHq/coOutkcLKZULXBXgNbCYT3Bmxw39Y7PdZZ/U0MPtHGJLmm+IHGQi1+E9d7+3jElVaFYjD8lDSuN3Dg6Brztefh3edVFWygFHRgeaGD83q/e97XcWzho4f644g3qBw8PNTkdUYF5FclpqUYt3nDbtK93WoIF4Twxh57ciXfo0VkJAqaG6chNC5L9GdPoQJwup/ddZrZJTGw8BBDxHTX1GDxWVIn7AdtLcTshYbH7jflSg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 18:56:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 18:56:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYXBXvgw8igX/zVk6hotp6/G/rIa0WbaWAgAU+FYA=
Date: Thu, 12 May 2022 18:56:14 +0000
Message-ID: <4a655f3e-a5dc-6aac-c1f2-a9620d05ae4e@nvidia.com>
References: <20220429220946.22099-1-alan.adamson@oracle.com>
 <20220509105242.hv52nmc7yqd4chnz@shindev>
In-Reply-To: <20220509105242.hv52nmc7yqd4chnz@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c27ce8b-7165-49af-b269-08da3449169a
x-ms-traffictypediagnostic: CY4PR12MB1767:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1767FB988738C646E256529DA3CB9@CY4PR12MB1767.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G8O5YPIl4opuwnTtptmne3TOsp10gLVazbtbnHKRccnpJp8gLdwwsR9GLJuK7AFzmYqRtVcA1goZRJhNIGllC0+AcoWhQHNW3wWmP0xVaTgpwkNu0gf3zFbdvdc/rhVNHXjlJ62J9jbGQXrYQ16w5QxBxDKKFbTZ6UASCX+6/9LCEHYhnw3IlgeazixdMlZm85Z6GD8t4DYrELHecNGzO/IRMrIBYJ01UyqMkdrRZ5D1XbBR8LEozeIB1CVM4Uz+NgXlUjC09UXf8klpvgy4GNPMpPyDZQzFEtFETzmMmpHWplIboX56OVEBh+sehjslTugMbKcqj2WSAZvY0gWtqZc3WU023UxQVtXFa3tWoczFTyHK2a001jo/ljhr11NEgWsqRVh14fjTqaTd4J4GdP1XsWdeq9vtnRW8KlNqWowUV7UTGgwqOKBm9169tVQlPw/VS06lJEC+wyYeVHVxt0zXph0lWP0AwwiaG3jD7ALkoFQ/KNtTHlLwAIrq6jSLXiCrGTJCpr1eGP8isenpzJyYqHmfH402m2fhfhYDaS13+/M4xFZCieVh7MLvRtnq0mSIRpC8hWpknQUjM9SmqO5bB+4QJtF1O/DQwWHVdi4GPtWdNldLdwlsUYxxowGHf7KmX0DicDdXzkybfgF26B3vhHZJC2w1bNhEa2c6qsEsJgwvBRX3RletYkOeRj8RnZ2xBNBkHGINxFdXyRi4mWkYJwPtZUnQ8MqDhT4RW5uOWKqDN8bMZzOMtXXWji/leu53k7OZfN0JdulypRRUxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(31696002)(8676002)(71200400001)(86362001)(5660300002)(4744005)(53546011)(2906002)(6486002)(8936002)(6506007)(508600001)(83380400001)(316002)(186003)(36756003)(6512007)(31686004)(54906003)(122000001)(6916009)(2616005)(66446008)(38100700002)(91956017)(66476007)(64756008)(66556008)(38070700005)(76116006)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWNCTTQ0ZFBOeFF1N2VKTUdMdDZ0TFRXaHhoKzI2V3RTUXBqQjNiV3AxSVN5?=
 =?utf-8?B?V3JJSG9GSUQ4V3BOb3JqNXVEZ21XcFZxSVBIbDkyUGFRWXpJZXI1SW95SmVu?=
 =?utf-8?B?aWxCaUFTNDNyZ1hMeHk5bTVCMWpmMXYyTFBCTFZZNFE2cnBhWW9qZUNnS054?=
 =?utf-8?B?cnc1cWlKQ2h5MmRYTnprVFgxemdxQ3JKbkZpUTRvQnd1bm14YVRpYlViMFdL?=
 =?utf-8?B?ZkFMYTBlODFWQW1RcmVKMDdRTW1EbzV0V01PY2NpUXNxYzJ2SG85ZlV1TUVJ?=
 =?utf-8?B?RlVBNThuOUdSeU1mNkhPYk81L2xSMUpYSy9XWnRpNFNuaXBEQmx6cWpjSG45?=
 =?utf-8?B?Zlg3VzFFNU9wSjhPTkpEcmc2Mm80OVdCUWh5UmpWRXY4YW1RMXFuNkYydWgv?=
 =?utf-8?B?K1Fhbjd2eXQ5MkpHWnlUMnlvdTBWd3I1eFJxazRPd1NaaEJaR3M4MytFSEZ5?=
 =?utf-8?B?YUdFYVR2NVROVWdldzFJK0liTXBoUElGeFVQcjg4NUJTMnhDSkx0azVzWDhV?=
 =?utf-8?B?L3FSbTV1NTE0MkNuUUJjQVRkcEJsRWJ6YmV0Vll6Wkp3ZGZDbER5QkkrQmZy?=
 =?utf-8?B?T1BqTHVZK2xGb2U4M1h5SDZyK3VuWHVnYVBQbDY3RTVhNWRjSkt6K0xkb0ty?=
 =?utf-8?B?VzA3Z2JWbEMveDhLbU1KY2c4NkFUM1dnVm9qR0R5eXE0Z29FTWVOOUNMZEUr?=
 =?utf-8?B?WFVmMDhacXhFK1ZXRTlRZjJUaTBqcTR5Vm1YWG45ZGhITGNMYURudWprTjdJ?=
 =?utf-8?B?SUtQcjVhMDF6c052VnJBVUo1c0VLVU1IQ003ZVZoaUlYT3lja1NCcGZzUlJz?=
 =?utf-8?B?OTVPem5kMy95eVdZbWdjYlQ3RDMxREVrRng5S04rYWd3TlhHSE83aFo4UHFj?=
 =?utf-8?B?b1RzQVBWTkk4bWpUclVsK2RRcklDSEs1Q3dWMW5LY1F5ZzR4cGFCbUZBbjhq?=
 =?utf-8?B?Q1hGc0ZwWU1lTXdHVDhKZ0YwMm1ZSTBPaWpDTzBpVFdZQVZIemp1dVYwNXZD?=
 =?utf-8?B?QUdRRnQ4aFc0SFRwRXpHL0ZaNXEwZGtpRFJvRHdTN1p0Y0dpL3pnZjd6cU5D?=
 =?utf-8?B?Nkc5aytYVEFrNWNmOHA0cmJnelFFbGVmekRYOTNRUkZEVEFncHhmSjFtMk03?=
 =?utf-8?B?MXpFcExTTloxamdqOGl5TTYrckNLVEsxVnhCNXFXS0VvakcrZzFwRXorMThy?=
 =?utf-8?B?eUphTThwcWttVFMxUWw1T3V1aHdZcllFSlV5dENzRjFRYTZoN1NVd1RybVo4?=
 =?utf-8?B?b3A0SlNWSWowNmJYaVhSckdtY1dzbzM3U2Q3SkdHZTNYVndNclB5aXZRb3hE?=
 =?utf-8?B?VlBZdmUwSVpQeExFUGxjT0ZBZkR3ZDBwUGZ5cU00VERadWN1QVE5L1QyR3lT?=
 =?utf-8?B?b2c5d0RWSWFhSE1TaUZ4MEJTTHVDV25SSE03bEYvYUNIbFRpL0liWFlUSUpj?=
 =?utf-8?B?OE1HR1pxTmh6WHZkZklpdklHMFVjN1BNRnhpTHlSQkl5a2p3Szhqazc0SFNQ?=
 =?utf-8?B?NFhSRHhocE5adVk4aStkVlZXMDJxa1RjL3h4Z21QZE5HVFU2RC9lSU55RXJD?=
 =?utf-8?B?UWhyTmhlMUZlQ29qOWtjd1loZHd5K3RkNXBBUWNTRXJjWUhncFhwQU5hdFhI?=
 =?utf-8?B?cU9BUkFVVjR4M0szSVhPVlh6eHNmZXA4cncwUHhmZk5UdmVBekhqcS9QN1JT?=
 =?utf-8?B?RzRVdGNUaDhiZ2laQmMxc0kvS3VkNkRKc005MXh4bDBuZ0xiNjIvOU5PdTVN?=
 =?utf-8?B?SFBUa2FmOEZvZlllR1NzWDQ0NjRLVVl2ZFNNemg5a0VkZ3dpeDNoMEk4dWZK?=
 =?utf-8?B?K0lwbmdSQmViMGJrNThuOWdmVW9MbTZvYjgzT09jdEJmVWFxazVyVlVRcFBu?=
 =?utf-8?B?em51dmdyaC83WjNKbFROYVdsZ1Z6dW5xVW5zQ21TQ2N2a011UlhxMHNPZkhl?=
 =?utf-8?B?eS9pWUxGZ0E5SG00VFlGT3FhRWNBeitZcTlCRlNKKzJGU2FlSGFCUkNoc0dn?=
 =?utf-8?B?VmV5TUIvNzhUTURYNmpyZEljdVcyNWlMYnBWOEZyODVSWFJZdDJOcEpKSlRJ?=
 =?utf-8?B?eGRZa2JxSVFvS08zUzBreXVTK2xvVks1TTNNM3dQUHM5MzhOdTVOOEkxdjZG?=
 =?utf-8?B?UE14YklRejhMbG1CTG9zYXBaSkNjekV1MEFvZWdwQVJsZDh3MWRmSmwxZUtq?=
 =?utf-8?B?dXlwTW13NWFuZFd4bWYvMWxFZjJSZGEwZHBYb1gyQXVKU0Z0YVIwcGpBd283?=
 =?utf-8?B?TjlGRUdTOWdaUTZMdmxrWUcxWnQvazFuVDZpNWNwYjZOWWpoWnlMVlk3MjM5?=
 =?utf-8?B?WFp5SnJIM2hHUUJSUWxUMGVzOGpBTzZGTmZyTys0WE5TZGFLZzFqcFBKRUk0?=
 =?utf-8?Q?tSU1afuIzmileOcE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E30EBE83CF6F44DB33529074CF2A2AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c27ce8b-7165-49af-b269-08da3449169a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 18:56:14.2371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgUlS1r150scqB1mzEYjhwNXaHf3n4wLEyG35Wa/n2U3bxell01XIDyJj6Ee0CPW6eKHKpk/IbJ8dndGf22oRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1767
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_115620_610209_EF601EA6 
X-CRM114-Status: GOOD (  13.81  )
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

QWxhbiwNCg0KT24gNS85LzIyIDAzOjUyLCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBI
ZWxsbyBBbGFuLA0KPiANCj4gSSByYW4gdGhlIHRlc3QgY2FzZSB0aGlzIHBhdGNoIGFkZHMgYW5k
IGNvbmZpcm1lZCBpdCB3b3JrcyBhcyBleHBlY3RlZC4gR29vZC4NCj4gSSBmb3VuZCBzb21lIHBv
aW50cyB0byBpbXByb3ZlIGluIHRoZSBwYXRjaC4gUGxlYXNlIGZpbmQgbXkgY29tbWVudHMgaW4g
bGluZS4NCj4gDQo+IE9uIEFwciAyOSwgMjAyMiAvIDE1OjA5LCBBbGFuIEFkYW1zb24gd3JvdGU6
DQo+PiBUZXN0IG52bWUgZXJyb3IgbG9nZ2luZyBieSBpbmplY3RpbmcgZXJyb3JzLiBLZXJuZWwg
bXVzdCBoYXZlIEZBVUxUX0lOSkVDVElPTg0KPj4gYW5kIEZBVUxUX0lOSkVDVElPTl9ERUJVR19G
UyBjb25maWd1cmVkIHRvIHVzZSBlcnJvciBpbmplY3Rvci4gVGVzdHMgY2FuIGJlDQo+PiBydW4g
d2l0aCBvciB3aXRob3V0IE5WTUVfVkVSQk9TRV9FUlJPUlMgY29uZmlndXJlZC4NCj4+DQo+PiBU
aGVzZSB0ZXN0IHZlcmlmeSB0aGUgZnVuY3Rpb25hbGl0eSBkZWxpdmVyZWQgYnkgdGhlIGZvbGxv
dyBjb21taXQ6DQo+PiAgICAgICAgICBudm1lOiBhZGQgdmVyYm9zZSBlcnJvciBsb2dnaW5nDQo+
IA0KPiBUaGUgY29tbWl0IHdhcyBhbHJlYWR5IHVwLXN0cmVhbWVkLiBJdCB3aWxsIGJlIGhlbHBm
dWwgdG8gYWRkIGdpdCBoYXNoIG9mIHRoZQ0KPiBjb21taXQuDQo+IA0KPj4NCg0KDQpjYW4geW91
IHBsZWFzZSBzZW5kIG91dCBWMiB3aXRoIFNoaW5pY2hpcm8ncyBjb21tZW50cyA/DQoNCi1jaw0K
DQo=

