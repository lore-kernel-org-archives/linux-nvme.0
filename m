Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8044AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A0sb/vR/95IwrniFAWbX2+y95HReMw+pj6lVjQXUEwM=; b=2cctbtWb4Baka5mqbTcALrXYn1
	a7rz9YQqt63GnR8BSW5Ty0L7UeUfh+3/B23hS79boOJW5imA9q1BYFRFnZt/0dJ5+khWlmZAgxX0J
	p8GSg/2cNaNJzIhWuS828YeCJmuWchpEznqyx+Py0a1wn8YFbX8GgIVqNZdBDVVZ8DwNbCr3sDTQW
	qCPc0ahcsaH6ZD3SPNtGUXCj0W8a55yG5bgxugKVQlaB+6zJ1JSPshK8IkBzFM5EQuLyddONkqQJD
	pcZS7exMt6kEDZM1T3Ze8AsJSPXpjbkIWnWTwHj2flUFo8ywRTZSjGN+yONSwMLULh496g5L1mtWy
	Cu/k51/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRysG-009HHK-Cx; Wed, 09 Mar 2022 16:09:16 +0000
Received: from mail-bn7nam10on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::60c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRysD-009HG1-JE
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 16:09:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPU0gfsWuzZg34t7fWZGDLVhooNaPov6/7A6pBKXYiOubVakvZ5FP0SnnS7Oq5nLUiyu0XNBxWIyXJywMZw3UEs1Gww1nfmZDfrlUbRo1KI0GjF3KKTBUMGjPKk9z3F5kMpBkgcTYxSUUsiFW0ppYEH51F5yVwP/D2BjzX3MdILSus7FJcE/FlbttCo2PhPXrue/SDUgR18X5cU/d5owriRc+oe/1jcOaiRHU+j6qxY8T27KVOQhTexmdTiw2JpCmSMlM+qVWzWpBen/sdbAVH905iC+vjS7tZljpOMv5IBn+fXOu7mXL4Wwa97F4S6LWsFxfgfyIl1PbCOY2dBpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0sb/vR/95IwrniFAWbX2+y95HReMw+pj6lVjQXUEwM=;
 b=h2nneC0ede+oZ6dczMgy5kFqL6C+oeRGUroDzQ3mY7UnpjKHPDmeQrKyoOcs7+qcq2nGOlEvGSriIjF6Xd2r+6kkO4bOqk1UoRsgO/pNgoJeuv6GhKN/j9qUF/a0NKbJgSeinQNj85Al1TAlZM8IpT29SdcF3soGqbLL1Fz5jXDmUZ39PXsU/LZBm+EskySJHLwsZVZ/4XBkJ1LUASqUKPdwTcqL2qGdTbBhnMdwxbs9ix7dTmVF233IT7/A/+5KaHQ6df6xdjtTOfYphQGXKVb4kTnnbdLEV+zv3dWSmk1O/9CHdUN3Xi79vvS79seuMzUdzN2PUHgrAlJli8CYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0sb/vR/95IwrniFAWbX2+y95HReMw+pj6lVjQXUEwM=;
 b=qJftP53XocEPhN7eZbpAD/UpD+EkuNrovJtSco99J81yyeAtiLYf4SVLQapVyYAh5d3LLnmY6K7B2otPspejFcMyWRNEDg8sNtN8//C6p8pKdDDnITMYB7DD3dQbEFjfr9Yxksvds/Kxvxbn5jGJV0p+58aAr3xnVCJT8GbStia6KuVIDkPnnU4i58wsK9UD86GWYE8zmWgofHxPSE7KMF6qrFg3Z+gYkL8vh/YyAw7U0CHcW+A79TpmRwuS6XMmuQjKWik9EIALPc8KmNWi2ABzZF1zPwD+vukxgL697/y4ytii6qv3tG2Kl+4BeyltoDbyICoCZjZXjZES5OSE4g==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by CY4PR12MB1720.namprd12.prod.outlook.com (2603:10b6:903:121::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 16:09:09 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6065:161f:451:70fd]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6065:161f:451:70fd%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 16:09:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-multipath: use vmalloc for ANA log buffer
Thread-Topic: [PATCH] nvme-multipath: use vmalloc for ANA log buffer
Thread-Index: AQHYM7ndJOlBcUYiMEO4Kg5u9rovaKy3OI8A
Date: Wed, 9 Mar 2022 16:09:08 +0000
Message-ID: <7ce203c8-792c-8e34-eda8-3b44f873c5f2@nvidia.com>
References: <20220309132900.1171-1-dwagner@suse.de>
In-Reply-To: <20220309132900.1171-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b155a4a-e31b-44bb-a04f-08da01e7249f
x-ms-traffictypediagnostic: CY4PR12MB1720:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1720DB57EF4E8C57061C425AA30A9@CY4PR12MB1720.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXplPP7pX9zmr9ySRonkDeQK17ndPbs0NPe+atFvPJhlvmq3IkQZlcisxKOal+BYxV1/4hQ+5doWUoylVbabC9Jtg4v7RdPn9KFYDvZ6UUkffuLVKkiJSwMjkusFJOpMecrcpLPan6z/q5yWFRhCcL8JtzIISOHCgpJcXSvgAwA9DFY4It9PJPNaw9W5SVvBup8fKIGp0anOyZhx4x5DHrkf4KSxGl1YLNJok17lIKMHfWhSgAXQa+47hVpktmsVZPi61jpXVl/ggE17tmEb6KjuQPZmyx9o4L8LZwdStu0ka4ZY7US5SIXtNhNrXKnRXgJiSRDS4EKeOYhjInf3jHm3SP00IGWGroolobOtcFBtrZN0SQmaFlawLzPyCq60vO2Vu41srXDzPAnjwfwKIHKGZpBA3lXdBR9LowVM5JTDsbEKfvJsT/M92SdkeIqVRgEegipPmDliJCVIhvlyvNWxqEuDe3eOsxmHrLMHmoaa892ow2RQqQt7Tebj4/yJwu7D6kRRrWDI+/spMiCSNeQoFEkWnimum/p8BK6MNA+WkZeWoOdEoqTEBQuMOH15OPd/wl6b9mr4j9OMxdjTm4moNy6SH2/Wapgq90yfDRirTxreqTRSoij1CcZM2XOoHlOS2kPmM2W43yEPyZ8Zdkpx3YSwNnomF1k4ALbjDnXpWKgTR2fImQ31EzLQ5m4sMxDH+jmCvU8SCjXk+zeRaJqJRWaib6dagaLBn9UR0+crl7b1YokxME7uBPmSr4iz03kPUIjJFudaX97gIxo22g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(4326008)(66446008)(66476007)(66556008)(8676002)(64756008)(91956017)(76116006)(508600001)(2906002)(5660300002)(316002)(6916009)(8936002)(31686004)(54906003)(4744005)(122000001)(38100700002)(38070700005)(6486002)(36756003)(186003)(86362001)(31696002)(53546011)(71200400001)(6512007)(6506007)(2616005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDdrWVZRSmhoZTNxbXQrYVV3d3hTclQ0a2gyUkpudHl3VWpsNGZPZnRocXVO?=
 =?utf-8?B?UitFMVUzOURmdm1oRnVDczZVUURnL1FsQmxMTTVkakF3b1R5czVZUDNtc0Zu?=
 =?utf-8?B?aHNzUzBiL3NBL0ZUZStWL0FFZFZJTTBSSklRY1hCWXhVU09LaFJtNHBXOHZh?=
 =?utf-8?B?OU55OVlRTi82aXlYRnhNaU05MXlqV1Q4MVpURE9oalhBdmtlM1c1VzV3R1Ba?=
 =?utf-8?B?NG1YeWFMTFc5NlBaci9meTFVWXA2YWRCTlMzamUvSE9seUhYZ1Z2M1dSdkZ6?=
 =?utf-8?B?QXM0dklCSkR1dVdwL1duNTN5V1NaTXNnc1ltdXowZmdsNEQva1lrVTRDYk1h?=
 =?utf-8?B?V1ZQYytxT3RzMlREUFVNY0hLNjlRSlRORkdOUFlnUE90M3llVGpLYXg4TzY0?=
 =?utf-8?B?Z2lYZ1FEOWc1aWdSOG9PMmdKRThlQjlJMzgyRVRoWnZVYlVSYnRGbXJXL29D?=
 =?utf-8?B?Ymt5NWRJRzN4eUdiOTB2eWJvNDBxbkhSQ05oaHlIMWVOc3h6RFU1M1o4UDhh?=
 =?utf-8?B?Sm52bTlxRGZ3VkpVQXJ5bnBpK0R1YnpUd3hITFFqZVFIbG8za3dLYUJJcXk1?=
 =?utf-8?B?Q1VLK0lHR1hsR25mcCtHTVZIUXFHNDg0aXdHczJaTFFDM0Y5dTl5eXdaKzZD?=
 =?utf-8?B?NUhXYzVwcldyZzFLREtDQzQ4dWFFdmtUS0JUZGJPYnFTd3U4K0YwR1dCeDZh?=
 =?utf-8?B?dFUzK3N0K2dUVlBRTkRtL25ldWV1MCsyYVJtQjVrVmIwYUtHVTVDUm1LaXNx?=
 =?utf-8?B?TWNLOXlJTDFZSmpPRUVLdEdKWWZXTHo2dmxUeWgxYVd2RVJDTEl5bFpWTEJJ?=
 =?utf-8?B?QVNXWFFVSE1xKzA1eEs1V1NVenpFa29CZnpQNHo1VHFPeVZ2YjdMNmJiQ1Nm?=
 =?utf-8?B?K29VSXUxLzMwekdnbDdFMWRtcnc2MEgzOUV3NXRGdDJNdkpTNjdMYWwwTWJD?=
 =?utf-8?B?L3Vub1pYUStUYkV4OC9OUkNnOG1ERXpib2Z4NzlFcDErM21mY0lJSzBsV0Fy?=
 =?utf-8?B?MEhkWDF3YVlPUzIwVjFTWXp3dVBJSERZeCtycEFkbVE4VHN5QWdsWG8yWmIw?=
 =?utf-8?B?V04wRFZydFZ3TXMzYmQ4cDBYR2dVZGJIUUI3Umt6YW9JbDJUZjVSbkQyUWRH?=
 =?utf-8?B?TzBORTBHRTNVdXNGVnZFeks1cFdSVU9qMU92ZjBjUmhhQmRzbzQ3VVRoaTE5?=
 =?utf-8?B?M3ROMm5ZV2lxNTc4bzg2TXlHL0RuVHp1NjJmTDZ2WGtGT0tXUFU0UTZUUjU1?=
 =?utf-8?B?bTRjS0pyUytJaTlPUWRURi9zU0lwTWVhd1A5UVpFbGFpbWloTUZTeXZyZUpx?=
 =?utf-8?B?ODRKbzRWL0QvM0RweWdTcFhKZVlFWE5yd245azk3NzAvSXJVTFBFY3ZEYnJ5?=
 =?utf-8?B?UFR1aGtoTHducE9XbmE4bkR0N1F0cy9YZ0VwTHBKUW1uc3NseW53WVBxM2dh?=
 =?utf-8?B?RFlQajg2OXhBNHJFTGsxVlFLdjhXaGh3aEFjekVnUDgwb0Y2L3dsVkV2QnE2?=
 =?utf-8?B?Z2EzaExMYTV5TVVWYzlXSkVBcC9kZ0g1K2tmaWJvWUtQOUNKYW0wQUlCS2NX?=
 =?utf-8?B?YjRJYnBuR0ZHZ0VLMklmaDJXWHc2aE9GR25udG96bXNPNTNTbFBldmRhaWIr?=
 =?utf-8?B?Nk80Z203VzNJY0IvV1B6eU53ckNUcXBjb1ZmUU9LNVlqZlRWYWFXS1dDYlNC?=
 =?utf-8?B?dWZraXRoQ3dxVmVDaE02d0IxUk4wSWpXZkRmZ3BSeEorQ1NiNUJRdzlkVGhy?=
 =?utf-8?B?VHZuU1Z4SWR2QjVkMDM3R0N3bDdmOWZBY2xmTmdqWWwzNTBTVkZqa0hINThm?=
 =?utf-8?B?UU52eE9JQ1JMcWI0VlU4c28wMXl1NTJwOFVqdnU2dTRJT29JTlYvcFcyRHFE?=
 =?utf-8?B?TVRMMzN5K2hLUXgrUFBtdTFiNkJXV0FKejVLOEQwNjBsT09kR0ZEcythM0s4?=
 =?utf-8?B?Y1V2b1N3clFrRVRFaFlYcXlQdnc4bStWTTZkelhYM3N6SEE3aFNZdy9FeDF1?=
 =?utf-8?B?YUdCOHFtODhYbFFvWjFUbUs3U01Dci9kNHZRQkVhWU1pMWVNcFBFb3ovcHBu?=
 =?utf-8?B?VGw4TU9ldW9GVnd4c0Zocjlra2ZoWG10TEVYOVNsUUx4bHZoSitPU0gyeWg2?=
 =?utf-8?B?L0xBd1k3UzkzMHVlNjkyNnQ3MW93L3RjL2RhdFZydGhsNTVTd1orMmhrcVdD?=
 =?utf-8?B?WjZSMW1PSjZhUm54a2ppdVpFVVFvTVRQa2hKeVlicGVhbk11YWg3WkI2TTBs?=
 =?utf-8?B?QVcyRU82dEg5czk5QzFVcWMwWkd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <404304BB63C60F4190AB0562B53A2C6F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b155a4a-e31b-44bb-a04f-08da01e7249f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 16:09:08.9079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iW74LHeeEkk34FQ5aj8BUj58OfPAyPFamqMCO6zuZR/6bjEdqqrLxt5WqI/kMltTxT+L5njVDtSefzaYtc+1FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1720
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_080913_655850_A99C6B67 
X-CRM114-Status: GOOD (  12.11  )
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

T24gMy85LzIyIDA1OjI5LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBGcm9tOiBIYW5uZXMgUmVp
bmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gDQo+IFRoZSBBTkEgbG9nIGJ1ZmZlciBjYW4gZ2V0IHJl
YWxseSBsYXJnZSwgYXMgaXQgZGVwZW5kcyBvbiB0aGUNCj4gY29udHJvbGxlciBjb25maWd1cmF0
aW9uLiBTbyB0byBhdm9pZCBhbiBvdXQtb2YtbWVtb3J5IGlzc3VlDQo+IGR1cmluZyBzY2Fubmlu
ZyB1c2Uga3ZtYWxsb2MoKSBpbnN0ZWFkIG9mIHRoZSBrbWFsbG9jKCkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gVGVzdGVkLWJ5OiBEYW5p
ZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWdu
ZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4gLS0tDQo+IA0KDQpXZSBuZWVkIGEgYmxrdGVzdHMgZm9y
IHRoaXMgYXMgZWFybGllciBjb2RlIHdhcyBuZXZlciBleGVyY2lzZWQNCnRvIGl0cyBsaW1pdHMs
IGFueXdheXM6LQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==

