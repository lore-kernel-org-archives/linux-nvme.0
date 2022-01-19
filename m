Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F62BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 07:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HkiBZRo5tjdxfhZzDSE/36pRkNb6Z2NFyWzf2TqUXeo=; b=UK1/5a72Xunq9LhZ10GRAULvTi
	r/Xwh2UGse/VD2MCy76n9gdEX2bc3gsXsoADHLK0Le9sKhgQ7ABUrMmjf+ax7PUUIi7IsmwNr5s2q
	p1fFmTTpHki2WNUAVgVwd2Ij60PaD7VkDERm5manUKO5uK6BIrqR9Ft2qEVVCyXHh+Gp3Ce4z7rr+
	vkrTzJKr80XhqW2Za4PVoAXTB/5bn+i/h4BZuk36TEzOfIIbd0B5A2RsNW9Ac12XsjBbeek5a5nS/
	tGDfqgMCLQTz4+wPKx70VjJQKfxpnU+8+vmJs8Sa2ox+2gKGpQor7c8B5+/tcXBZH1wGc8WizOY43
	ofisA/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA5ce-004Dcp-LN; Wed, 19 Jan 2022 07:43:12 +0000
Received: from mail-mw2nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::60a]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA5cc-004Dby-76
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 07:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy7T7QKbeRlEmYi8bVUwLU+jYJpwMLk+TFjMlezLtXT/RcJqrhAzmr3EAPYHrtCGQcFP1tB55lxCQ5v5417UfE3AqIqXRyjTdriKRgPQxAUy8DEZKvrrGgr5sVq9gX+nbAsrylXDiAQ96QoaGNOqt+1z+8nXuEODl36s7B/gMckeGxXsXRwuH/ajlEiIXQR2I9PyCc2kKAP3lQ+e62n78TbuNK6M0osssEXkGiZ+vIs4Nr0T6vax1yIfsR4Tcbg7TwB4talBtRXJoxc/4L6+7ZkCG/z3+nxz4GffS6Jw/CPs1lnmjDSfzWpXD9PLnG/1fona/eUxmqa6U2nLtIOTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkiBZRo5tjdxfhZzDSE/36pRkNb6Z2NFyWzf2TqUXeo=;
 b=J+U57Gg2E8KYuut3CONaGIFeWmuKlFsKfh7ESvWkphDji9TWBFkvuDwu4luLtDV8toFaACalVeMj2xLberHcgIOjERmx8ZMD9YQubInZeMUKkwkm4p8aUBlJ/RwYVNQj7vP/UWLtXBlEzbwdviCfQIhrMpzsEteS6vS2vgMF4pjSuOgOrHl7YdBhFLg+Wsn2xw7FFKy/6xjaJKlchm1zR6mmum830FMTP6na3nk86pvNRxHpmFqvj4m9B2gvzjj3GPIqKnSTOMfhLnEgY82VV2GmJ8ZvDihjsS1K5Ys5Ak1QXO4Z3P+4Le0IfO6EVxGWlIqloX3pI3KGT51GMm/Faw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkiBZRo5tjdxfhZzDSE/36pRkNb6Z2NFyWzf2TqUXeo=;
 b=ZHEUp1ilGHM7B+vENFrMJj1nJ1PrxlccojkpUqAuBriAGgyV5cMHmqewN7/VySsJFO4PX8502QxTY/mc1bbZZBLor+vLp/fkrgpjZ/WyBfWbZkvSDVIL2kAWjydLJ3O+ImN6pR3GZ+fyw07BIj03AS+cNNVM8QQGeYJOXfMu8gi6+Gk5osbhkWKauVzL3PS5zkryzWReQktM71sRncehW695htW/OvnQEOAPrd9P0KfKeMfCnyqKOyYz7hqp1Gqg8FrXEY+LhwzYNfrCj4AMK8umo7EwNpvYnY/HKmxlqbbZRWBEXRF1GzTIP6XuD4XzHP22y0V/HeZAWW/E5i1kkA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Wed, 19 Jan 2022 07:43:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 07:43:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet: add support reading with offset from ANA log
Thread-Topic: [PATCH v2] nvmet: add support reading with offset from ANA log
Thread-Index: AQHYBituY7CWuSGp8UqO7RRln2vgRaxqBA0A
Date: Wed, 19 Jan 2022 07:43:07 +0000
Message-ID: <a6d52d42-1036-e036-e2b0-8f6aebe8ca2e@nvidia.com>
References: <20220110140539.25521-1-dwagner@suse.de>
In-Reply-To: <20220110140539.25521-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 811c3d41-31fd-4467-4590-08d9db1f557e
x-ms-traffictypediagnostic: DM5PR12MB1644:EE_
x-microsoft-antispam-prvs: <DM5PR12MB164499DE5298954882B9A6E9A3599@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mnCDIx1TeOePEmkfZr5VOjvZXe5WaleewlCDS+tp6Kowt2AO4QcSl6DWs0Tiq4rdI9tIsHNHn2stgNoJ9IFGajqBLrngKEtWCev0O0OvTZtl/YgpBpJz6pttVH1Hgblny7SvOOW0m9+HKyl+ZdC9tmroLLj96alkoMIPv5MPioEnxxDOTHAIm2e7lBMKsertIUGWa19BIH/64zbmbMUpptqx0sDWTRYDtHtiNX0cfHNrKVoywJ/RWnydYpDXe56SS6BAgsUOnvSfz0idJiOqLBltQThnAqKz3bN6mB+Pa84veJlz2jCRpyj4YmFbTpsg1PPMFveQfZ2QQ73gyQ7K81QpV/+KgUymfobwW8GIUD51Uz6ILVYM9XS3iylzEHtmsWqWqabF6ZVhDUwfSMsbKtZSYnf9CpNz9yi1D0P4u7KDWhCyWUl0KSrDysY09M9yV+ZN3x1hkwfvM+j5nNuVVykL4WMSIpkf0ZnUg+9mJK4KXYmCakUfLy8XvqNYvJoVbp4vrTXuDU4vnLjq25pCXSuRZytj6w2dDyArk/Y0nmbJqS3FfM8SqD1pSfA5uqVQd8OuCvPKP61e1t2tNQVn6LQIqQUrP2aw4vBWPeBgtvPhW1pOXKRSI9dQx7LckD4oWy34nDH+a6opf70afEa+fuYBNIp/JRZ7ixTdqk34aIBiGW3MGF5zQPut7LlqcYndoEk4yf1iFhmrWj8368EJHAe/ZUzjA0L/IASq2odk1xM1m+5goSR/fYviUeHLnkiN8exuC8O7pqmOAMcm33AxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(64756008)(38100700002)(6916009)(71200400001)(66476007)(2906002)(66556008)(66946007)(66446008)(38070700005)(316002)(31686004)(122000001)(2616005)(6512007)(4744005)(508600001)(53546011)(6486002)(4326008)(91956017)(5660300002)(186003)(36756003)(31696002)(6506007)(76116006)(86362001)(8676002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2J6d0tqblJkZTJjYW1TaUVTbjhHbUdseUlpQ0Q0cGU1NFR1cXlZSEZHNzJB?=
 =?utf-8?B?YmtYYXZyYzlvd0JxcjVtWDBXcE0rOWRyalBLMHZZaUg2V2VSSHRGQzl2S2pF?=
 =?utf-8?B?MnU5YjNUdWd4VC80Wkx1dFJWYkhxeUNPanVsVlF3YmhKRUVGV2hmOTNrSTBr?=
 =?utf-8?B?WTdnRFpZWm9UY2RhMTFTcG84enBSVXQ0N1B5UTBkSCthdUZhWjgxWFFwcU0r?=
 =?utf-8?B?dkR3U1U2c2pMQUJvODBwa0VXYlIvM2ZVeWRSSDhvZGJNUFNvbWVGR3hLUmhl?=
 =?utf-8?B?bUkzbjVQRk1XUnR6NSt1MHUvb3NDV3NURDZYUlVLVVh6MXR6d25FOVBNY3F4?=
 =?utf-8?B?ZFZRdHUxekVjOWw2VVVsZSt3dTdlTkh4aE50eXJpVHZQeWlxMERYOHVDb0l5?=
 =?utf-8?B?ZHMzc0pxblVISytwV2dJa3dxWGFoQnBtL0N2dkZqNm1vUGtkbEthT0pnS2lU?=
 =?utf-8?B?TE0wbHptOHRGL2l6cy9UcktwTGRCd2VaMHdQTHBadEUzT1JoNzFVNDI3NHlM?=
 =?utf-8?B?R2plbkFlRGc0LytrV0VWK21GbGxiNEVnY1haeXFlQlB0bW55N1phcHhRL20y?=
 =?utf-8?B?dCs2dzkxaW1sSXdNazBxSndFYVJVVGVrTHRKZE00bk9NQSsxRmhiaHUzVWxl?=
 =?utf-8?B?N3ZMSWJ4KzZoc3NHVFNST3k5L2RPNDBZMlFtUGt6OVdwUEF1ZGFFOThuRmZy?=
 =?utf-8?B?SVRyQWdHZUZZRHIwUjlnWEtRRnNhYzdMdGZBMmdXbjJsL0drdUUvRE1EdGg5?=
 =?utf-8?B?WjN1VGw3ZG9VaExtVXd0ZlFGVHlQRmRKN29TbFVlekpxZG03STRPUXdoYkl3?=
 =?utf-8?B?bmJZcVVpWlo1KzJaQmdEN3FyREJPR2E5d3I0MFF1eXpwdmRjdGllMlhZVHRp?=
 =?utf-8?B?bFpOcE43dzR4dlRHUHprTEdyRjB0bGxHL2VYS0VYRmpGbWRlQkhWdGkrbjBX?=
 =?utf-8?B?ZXdsektqRDd3eStWWTVHTmxkdUZ1MFVRVnlYSU1PQkM1U3phbjFMYVpneStL?=
 =?utf-8?B?dmY1MTV4TjhlNEZucmQxK0JmM3hXd3UxS0ZqNjRDRjg2YURHSHA0MFRzN0d6?=
 =?utf-8?B?bTNPYnFDc0JxYTlBamhXVFBNSjdQY1ZDelVjbFhZNzN4ZHh0anlqTTB5WWFu?=
 =?utf-8?B?REEraXJQMTZoOEQ0N296bm9uZXRwbWZ3NjhZRkpudTZQLzk3WDBTS01Xa0ZY?=
 =?utf-8?B?OWNJdzZ4SWwyZWRvRWFuV2FBcC9ZYmFWejhyVnNud2RTdjZZeGdQcDlHZ01U?=
 =?utf-8?B?Q3lWRUVkS2Rtc1pZcmo0YWtub3cycEtZdlRYTkZDTmpJS3E5aEswZ3BFWnk2?=
 =?utf-8?B?eS9nRFdNcmdxMWhQR0lSZDhNTnU1YlFWeVJTZVl2L2wvejN3SmphSkhlWWZm?=
 =?utf-8?B?RzVtTm9xbkh2VHEyblZmRy9wbE9KTzVqR015ZEFDMHk4QmROc2pXb1l3WUVR?=
 =?utf-8?B?WHlWWEsrT0NISHdIMzdVakNRajJVRmFzKzJ1Wm5Tek5iV05tZEJRQWc1U2Va?=
 =?utf-8?B?eFNMZW9ZZ2JrN2ZyVS9TcU1kR3h3R2pBZVBUdHU2enRjL0ZUdU9Cbms3U0dn?=
 =?utf-8?B?N1NQdTRYY1pyck41RitoVjFVU2ZiWElEZzBCTzJ0N0lvYjc1emxmVGFHcHJM?=
 =?utf-8?B?aFJVUmVmRUNHRTZKV2RmMnNnNVVOazRBem9uTmVKUDJOQXRJc1lTZWxpQWRu?=
 =?utf-8?B?WHFKaVhEWnU5SWtJcnpKdVpSUjI4bGNIVUdYTGZVUi9jd3VaN3U5KzdDT3BF?=
 =?utf-8?B?UzRZSzBraER0c3U2RnY5VzNGbTNNYkMzakdtVk1kQzBRc2x2L2ZYekIzV2Fa?=
 =?utf-8?B?RTVhUUpERUtvSDd3Y3AxdzA0M1UxMkVqVFprVHBLTDJrbTNycVpOUkdLTmZ2?=
 =?utf-8?B?SVZxMi8xSVEzZ1F4TmVGTjlqMjdtazZPZTZFRXJOZ3NPUlNCWEZCdTA4amdl?=
 =?utf-8?B?NUNrM2xhRHFIVjN5eis2a0crL1FjWElZYm80Qy8zaUE5YWFCS3pDUnVSL0lD?=
 =?utf-8?B?OG9LTVJwTzhOb0thTUdqY0ZUS2hGMjZ1NzlyVWREdysrS09PUkg5MXB0OW9T?=
 =?utf-8?B?SmUreXFidkw0SjExYkluWkZkc25CVFRaQUQwTS9NNUdnNEJ6MmFDdUo3RVNJ?=
 =?utf-8?B?M3dweVBhdmswK1MyRmpqcGZzRHVxNFJOZ3JuQy9STnA1QjNYeXZPTkdZNlVm?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1C34347D1764B4C8FDF03F1D13FB439@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811c3d41-31fd-4467-4590-08d9db1f557e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 07:43:07.3349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7N9bwrujsxf0PGQImCcE0j1jWqx1vwAfk0jMY4LYFnbryU5hQg9iNY7wbyyFMPPqu3MFBp6RIdN4S/brlfH/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_234310_302220_B5E402DC 
X-CRM114-Status: GOOD (  13.17  )
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

RGFuaWVsLA0KDQpPbiAxLzEwLzIyIDY6MDUgQU0sIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IEFk
ZCBzdXBwb3J0IHRvIHJlYWQgd2l0aCBvZmZzZXRzIGZyb20gQU5BIGxvZyBidWZmZXIuDQo+IA0K
PiBUaGUgY29udHJvbGxlciBjbGFpbXMgdG8gc3VwcG9ydCBleHRlbmRlZCBkYXRhIGZvciB0aGUg
R2V0IExvZyBQYWdlDQo+IGNvbW1hbmQgKGluY2x1ZGluZyBleHRlbmRlZCBOdW1iZXIgb2YgRHdv
cmRzIGFuZCBMb2cgUGFnZSBPZmZzZXQgMg0KPiBmaWVsZHMpOg0KPiANCj4gbHBhICAgICA6IDB4
Nw0KPiAgICBbMjoyXSA6IDB4MSAgIEV4dGVuZGVkIGRhdGEgZm9yIEdldCBMb2cgUGFnZSBTdXBw
b3J0ZWQNCj4gICAgWzE6MV0gOiAweDEgICBDb21tYW5kIEVmZmVjdHMgTG9nIFBhZ2UgU3VwcG9y
dGVkDQo+ICAgIFswOjBdIDogMHgxICAgU01BUlQvSGVhbHRoIExvZyBQYWdlIHBlciBOUyBTdXBw
b3J0ZWQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5k
ZT4NCj4gLS0tDQoNCkknbSBub3QgYWdhaW5zdCBoYXZpbmcgdGhpcyBjb2RlIGJ1dCBkbyB5b3Ug
cmVhbGx5IGhhdmUNCmEgY2xpZW50IHNpZGUgdXNlY2FzZSBmb3IgdGhpcyBvbmUgdGhhdCB5b3Ug
Y2FuIHBsZWFzZQ0KZXhwbGFpbiA/DQoNCkV4aXN0aW5nIGNvZGUgc2hvdWxkIHdvcmsgZmluZSB0
byByZWFkIHRoZSBsb2cgcGFnZXMgYW5kIEkndmUNCm5vdCByZWNlaXZlZCBhbnkgY29tcGxhaW50
cyBzbyBmYXIgLi4NCg0K

