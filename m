Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA71C35278
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wJXuFlw2t/Jmfbu8IW03uiLIkfvKnW7nbmlg0TmqAfA=; b=V7CTXtHdPIR9LQFZ0l/sEY/BMF
	xUIBld/MSrPWk15XVG/ANYPybULYWz+GVdlERlUaZ+8JKEA3jAXo902FHPXPewhnNRwb9N6+dqE3r
	rApihYq1kg5w3GLOxq5KH7MDdYcXkNcYFTWP/9Gv03f0NcJU9YjwPrxG4kBCAxEJdKFneQgCCADbs
	vu9FXsEsbQQgp9/NRpQ6K/M+hoQcua6QFTCKSQH4tGtqIaOhSouTzZ4xsAJYJofvIYZpUyUQDJQlT
	tYvuAwRwqynsSNaC4nyH5lIoPfvTguZqdwopWke803wOHkU/aTp5Bp06rQ01pMwt0cymHQxb+RElk
	8Rf0+Pgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK1LH-003qUM-Ga; Tue, 15 Feb 2022 17:10:19 +0000
Received: from mail-mw2nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::624]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK1Kl-003qIS-Sa
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 17:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a90Ktn8Y4HmPlbwgru4M2SdbvuMTJMmN8cY6wPtpDpb3A2IHOpn/hvGQF1QErBB7mpe1qjzBXBZz5qepSw8xykH4o9p4hyODHEp/3AbeU+tLZRUitoTg4Cg87Px37uwdkjtyBABuWEe0fYKKg3uWCZSgNbu5g8PPNRTk/IDRkfJBnazw4rjlR3kum7FdDfPPWRIxibwhMyWhmmX08xBao3QkwxBuA2E9uSY5wr95vekjCgAnAaX9OsZEQbw9JkvrKFBtzJRVPbZm6+W4t2yHJdUKD78DfGmS2CCaIse0VuDapGUiy9G/O1JWRNuDK4qT4rKkMsSCVL9nMQt/iBNGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJXuFlw2t/Jmfbu8IW03uiLIkfvKnW7nbmlg0TmqAfA=;
 b=E7altXlzMb3WJyvbSy3Rbk1BGyo1QHM+jW77a2L+KD8Zqt7VXMUDHyfbVAizsnwHznR2/RzwSYfcwfgAG26te6M5DrkVmFH45rKIE5lPamq4n6aSnbrBmTtRJAw4TYVx5U+3QKypEMpD+PXzO17+PSt3siRjJg4aGaN4ahY8Czs731IK3gzgw7xXsBvn1sy3H6NfWq4e6T9xImFy5pqGnhKPO6Qd2UV5dIQNawzLe3IOKH8WnHY3nCtAQgF3CRLBhXeByq7mYJJdfFneNefVmgoTzEv1jG/QISoUX6geonDONDNj4Am48kTIAxOhULpdcbw4kx5YAVx3vPAApkN56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJXuFlw2t/Jmfbu8IW03uiLIkfvKnW7nbmlg0TmqAfA=;
 b=Cq0ZyktiaPQG83aER1ij0OuXJxIgTY8aXizSYaai4VsxsEekZCqfT5IC951hsYhBZBfT3HN/ybsbK8XL+hESSR1SThxS09TlTl5IOY6Be46rbZeowE/vEHMVl4wyOCZANaP4TaQrmZ9URIZvMbNXgozy5osM5nf/7uVUgJX0NXIhG/zZ357qWOyHqw3ZDKB+44HELmNrthpT5Z/TE0B4VE5T/OvI/6WsZVHtUHuHgLreKYR4g4z0air/38LuqGHAkwm0BqwSe+m9G6vpwpmEGsGFfdbG3gUVMnXoZK7fpJ1k9obXYtBmdhJ+qH93DxS05tj4qD0I+DFQhJHtQiMQxA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Tue, 15 Feb
 2022 17:09:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 17:09:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: remove nssa from struct nvme_ctrl
Thread-Topic: [PATCH] nvme: remove nssa from struct nvme_ctrl
Thread-Index: AQHYIoXgocEhShxKnkKjy1hThFgXH6yU1s6AgAABzQA=
Date: Tue, 15 Feb 2022 17:09:44 +0000
Message-ID: <0c105b7f-c24b-ed24-1dcd-e9d22be13b1e@nvidia.com>
References: <20220215153719.1934484-1-kbusch@kernel.org>
 <8e48a72e-8d52-2395-4889-6ec6a493c3d6@nvidia.com>
In-Reply-To: <8e48a72e-8d52-2395-4889-6ec6a493c3d6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5092383b-e4fc-460f-fae6-08d9f0a5f6be
x-ms-traffictypediagnostic: SA0PR12MB4512:EE_
x-microsoft-antispam-prvs: <SA0PR12MB45120B8FB609D08A7071A91CA3349@SA0PR12MB4512.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZH7fHc1HBMi+ziJXUgH9EazoYW+n2TGNymx6SE8iDawS8TOOY57G90OrdXnjtpoThwSYqVhP5jYTtw3uy5R402EsE4xxpJkR+S6VeLlD4+aBsH4ZUIm2SvaFjXf/TZGOqdRWXQiT1ACDkwinl0Q9O1aUJ6vMOhV0gFlsXWzRoLqvbpQbGMP2Hv9Zm0VmFgQtrVgRSW/S34tJIiTHr/7oCcSyK1rz+H87AngjFc7Op0JQ/SG+ptpCBBJjKZuF3YllNuy7tErMqb9u/m21Giw7z4fIEW5mOmh5aGY2XAPTtrcN/j569tDUC/7G376UJ2a8qzmutdNXGZ3m4pzDzwx8OIBRLPktdhMOxfZGKhk1EeahvTsb15p3M2EIKbGVn5zpaqkwtUy+RE0nlMUmz60V8bVNeZoswvpIoR4rRWhCjtN40r4thVgRrwZThK2rJVKyFyNo1Q7qinTMDWZlvQ3/vB2D2aiZTKMjpEdALqWVBY31XD9hKiCs3KbY1WPkx/S+7Ygl0z95lkwZ4r751xAPLYxghkAkEwTjprE18TFqgJ3rxsqgmY05mMIFkfldOCOwZ1CtiLzGxSy5anhmz2dRhvQrFBVqGzJDGKC0fWqucZgdHR8yf//b+mtexNH8IIAzkNja+vmvibkHAb0fwu5oBMNlme7UiySSOmB6tBqML1fbr8yVrTxEeYrMQlabRSriQdreBf9v7vZRNwOB0Yf+2cVsg8R9kuphOxsBEi9B37cK/dc7pa8XZCI0Ga3YuCvkphRJBaweZdOFN/v0yM3pA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(2906002)(6506007)(71200400001)(6512007)(8936002)(4744005)(186003)(66476007)(53546011)(5660300002)(508600001)(91956017)(66556008)(64756008)(66946007)(76116006)(6486002)(38100700002)(66446008)(4326008)(8676002)(316002)(6916009)(122000001)(86362001)(36756003)(54906003)(31696002)(38070700005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFBRNUxxR2Q5K1BzVlBDdDcrUWdXRHQvbFUwQStQRFBzSWZXYUE0TERmbjNt?=
 =?utf-8?B?N0ZIU1IwMjYxZjN6WmNaMlJmMksxOUVMVm5ZUG85ck92b2FUNnBLbU1EWUZa?=
 =?utf-8?B?dDdwNWt0cm8zT1RhdDNwRHc3WFBNU3dkVjQ4STRObUExQ1RMakR6SmJwZWha?=
 =?utf-8?B?czRSd3Z4cUZEUjdBdHVLZWRnYXUrSzY5dVgwZmFka2cyRXMwSERkTkNpZ3BF?=
 =?utf-8?B?K3ZjM2JxYVAyNXZLQjR2OG5UU2t2SEl0UHF2VlVxRXFnN3QrTHFNRzVXaC9W?=
 =?utf-8?B?RUtyY20ra0Rud2lYQjRYOEVYVGpBckU5ZktuUThLYnNBcWRqMjdOUklURkY1?=
 =?utf-8?B?WlB4djkrTXZzOUdaVFIrUThKRVhQODJaQk1Ba29uWUJCc2dyUCs2YXhYZlZM?=
 =?utf-8?B?VnRTYjBndmJKNmxjLzBuaVRPdkFOb2xVcVRRVzBoUDBabkZ2OXVUREhGZjJp?=
 =?utf-8?B?M0lrRWc1aFdSVUZTdHdpYmNMY1J2eUxUOFFEd1pZcGFLK3BGWnVwcFZsTlY1?=
 =?utf-8?B?WmlYVWxJTmFrZnB4ZFpESnhpWVJCaTZkb1dyTWwraS85aTZXZnY2V285UHNk?=
 =?utf-8?B?VXV1TDgxbjIxTFBNM1A2VDhpSWlPck9FTnJVanFCYTJldW9MWHZOU3lCNlRY?=
 =?utf-8?B?dGZ5MFNranRWeVR4bHhKVUhaMlJabmJkb3NhdllqbGY3TTlzTlE1VTM3ZkNh?=
 =?utf-8?B?d0k5S1Q2Y3VnbjFKUzA1bnpoem10UE1IanRzc2Z2bXVSaDlab3FMUE4ySG5T?=
 =?utf-8?B?NE5jd2FRRVhIeTVvdFY4Rjlha1MwaXFabExBOEtFMnpZbmYrMHBGTTBDaFhs?=
 =?utf-8?B?M09BdktjRGxKSXRwMkdaL09hQWZ0YVJlY2xnMnRqMzZmQkw3TzdhSTh1a1FJ?=
 =?utf-8?B?Q2QxWTRYc292MHRPVDVheXYyZmhuY3puZDVSY1pheGlwNWlhL3I0cWFOdVZO?=
 =?utf-8?B?dWxrRC9ETmZKTTFNRFNpYk93Zm9ycUlVVjJBZTRUT1kxaEErcnRaZTVwUUZN?=
 =?utf-8?B?aFVpbW5XZkNHbkxoSXo5MWM3c3pVdituVkw5VDY5MytWQmd5SWQ3cllKdzBi?=
 =?utf-8?B?SGZOOERzNkVLcm5YUWNjZGVGR2MxYmlkK0ZtQ0hwaS9EQjdMbW5rNGdZcU5q?=
 =?utf-8?B?VHIrL0xGUGhiODVSMFFQak1kTlM4NEVleGFhNFQ4UkJLTlFXY0lEWndVQk5X?=
 =?utf-8?B?dDVvaEluOTVDYlE0RldDMW11bFJyMXF5aDk1QnRrcTdSVW5VTkJ4WXpYU25V?=
 =?utf-8?B?VlZNaTliS3VwSTdvNjdMcEM0NlRQSlYxR291Z0t3S0ZoeVdHRDdJeDNwWXMr?=
 =?utf-8?B?Um13MitFOXFqNGFvWlFGV2RHbUlXQkp2NDRkd29rTk9xNjlLU0Y3NDZ5L2Mr?=
 =?utf-8?B?cU5xV1BTUmNRaUhnakJiZkwxSjBqN21WRTFqWWw2VjNSM1VJeVhoNnQ3blpr?=
 =?utf-8?B?RmlYamVFSmVMa2Z3Q0R4ZUhONWYzZU1ZSW5YU2RBTFMraG15YW5YdGg1L0pJ?=
 =?utf-8?B?ZTdjQlVlZjBKS2JXdWxmZVhidS90MWdUaTNETklpNjYwNnJUbGhCUkdKazM1?=
 =?utf-8?B?YTc0Ui9TdkZyd0RsT2pGbzluQmdyT0UybG5LczBsdFJXSTdodVhRcER2NEpF?=
 =?utf-8?B?eUdYdjcvQTAzMHZXSEVFTEFRczZ3emJhQUtIMGZIOGxYUUJNRXJSRkYzSVJo?=
 =?utf-8?B?MWpYbExFN0x5Q2hOQUljVkE5M3ptRWoyYjlaQ3ljZDlmSHJNTVpaQk1nK2I2?=
 =?utf-8?B?ZnpIcmI3aHR4emtPc05UQUFMQjFZcFg3QnlOSi90U0xqN3FhVVg4RXh3anQ5?=
 =?utf-8?B?U0VxRmVDRngzMnJNOXpaYStUaU9iZTlSMXpubWZXTU5qRU1UdGFxR3JSckpX?=
 =?utf-8?B?T0lyUTJSZFJnZGJxclFKSDhtZTZ3SnNXVnBRV1RsbDRMQjRsaWEzcUlja094?=
 =?utf-8?B?dEJrcnhoVXp0cmpydmFHLzd1NkEzSnMvdVFXNmdyUktoQXl6MFdIeElrWUg3?=
 =?utf-8?B?Wm9ZcHZKVWgxKzY5QWU1UGdJOHVLdG1ld2FkN3QyanhDbFR1UkczYzdmZERI?=
 =?utf-8?B?OWJraXUwT3NSR0dvMzVZczI2ZU1VWmRBYVR3dzlMK0hhTllCM2t4TDhucWxn?=
 =?utf-8?B?RG40aS9JSW5ySnNqR3pjZ1J6Mkx3VklwVFFLeTYyZ1lWbEdaNEU5dzVBSHh5?=
 =?utf-8?B?Sk9ZZ1VNUmFCdWF1QkpIMWdlT0RjQmxIK3NDL0thOWxPNFVnczJYalRMK2xL?=
 =?utf-8?B?V3MwQ0EvTW5zais5eDVBWHlnUElRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBC24496C0C65949BF76BDF5B2090CC3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5092383b-e4fc-460f-fae6-08d9f0a5f6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:09:44.8679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jf60fi9kAn2SL6YnV/Ava/ZNpTv/fMxjrVqqYsgynECNLcUphHlWwykY9/3acj6VS8/aPLCT925jlGx7YDm6wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_090947_972556_5D0E8D34 
X-CRM114-Status: GOOD (  12.59  )
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

T24gMi8xNS8yMiAwOTowMywgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAyLzE1LzIy
IDA3OjM3LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+IFRoZSByZXBvcnRlZCBudW1iZXIgb2Ygc3Ry
ZWFtcyBpcyBub3QgdXNlZCBvdXRzaWRlIHRoZSBmdW5jdGlvbiB0aGF0DQo+PiBnZXRzIGl0LCBz
byBubyBuZWVkIHRvIHN0YXNoIGl0IGluIHRoZSBjb250cm9sbGVyIHN0cnVjdHVyZS4gVXNlIGEg
bG9jYWwNCj4+IHZhcmlhYmxlIGluc3RlYWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2VpdGgg
QnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPj4gLS0tDQo+Pg0KPiANCj4gTG9va3MgZ29vZCwg
Y2FuIHdlIG1ha2UgdGhpcyBmZWF0dXJlIGNvbmZpZ3VyYWJsZSBmcm9tIEtDb25maWcgPw0KPiAN
Cg0KcmlnaHQgcXVlc3Rpb24gaXMgc2hvdWxkIHdlIG1ha2Ugb3B0aW9uYWwgZmVhdHVyZXMgY29u
ZmlndXJhYmxlID8NCg0KLWNrDQoNCg0K

