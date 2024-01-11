Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74690C4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 03:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I02FLNhgqWF5pEOLfpjWDPQRHevmqkxXea0/4wOHebU=; b=xuc30YOV5P/5EnhlscHyUhEjZH
	tSLtdz57qtKx0WkQgFOJb0Qurka/I58MmhmKOdwO6YRy/ghgLovZkrab0iU3L91wjkcS8S/QJW/8H
	s+8n8UaOQS+FBpmdsP3aO+5VM1BjKiP0uhy/6DbyR514m1vHcsnrrkJt9b7wyOKATAZlW1mBv9D74
	GfPL8JPnTrmu0bL25CK1FnxrcBU9M4PL9A+5e0T8BqzZ7mJs/OLMdW0r3OiPU2/6qehtcdIx1ioAj
	Kbl7L3/J8TR5RoaMSdu5Q/EPVK0MzwiszpWLjQZT/mqBKe98z4mKTOXWS3GAB26xu0kRUXmndJYm1
	ayVqazcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNlSJ-00FZWz-1c;
	Thu, 11 Jan 2024 03:10:07 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNlSE-00FZSe-15
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 03:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUxvUf9XphGOecPTuFjVCfawEHcKa/ru9MtUvTVYVPbFKz3YckzGFzsLx02sGbl3drrF+ugIKQvg+MPi12/ynJ47MX5UPRp0rSWf3uOosBZmo65W3y76NHoyMkg3q9QPBII2Sl2JSSA0K084ga2wGSSImTRYPEl72QAL3KYYMQRPaa+aDmrsSLgURLHjrlFl7EYhca/Ce4/dp9nulMT83O2IxnwY/ztX1NDX/TFLP7TjcgJycnQjq1alLzlcA0IZRqkVJ9ZEVpvj0RMNTaBf3NqN8pmXmiJgIhJaYtazvq9ayLf4TZMM3wis52ffpfh8/ZJApNymH3LyGtAdG5rjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I02FLNhgqWF5pEOLfpjWDPQRHevmqkxXea0/4wOHebU=;
 b=YDEVrMMHYHJznymEsvwMu+g6dDpxmWqrTznr2QIZNCdl76rlNy+4imAYOZLeNThSH6GzYoZRxJ1Yvh4kuCfroPEPlKY7JZ9N7HXCPOAtk9Vc2qWsQsf0EdIy4nGs5+WC5s9WF272bE6i24sz1QiKWxO26AjtOmZkItclqtBuAG7XXIlPZ/vrBysqVt9mOzwZcebW1l22TMVVqNJBIBHkQHVpxEInvhwixt+W87uRkr5tktSdP/rPt9FJc8HZAvKmXRNMeG4G2BxXnNxRpdf7SERanmoRyko4IyNO3kqOuYpuEkO0memisn9CcW8yOdXkJ4FZpbPXdEi5n0rmSkClhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I02FLNhgqWF5pEOLfpjWDPQRHevmqkxXea0/4wOHebU=;
 b=UpYGRmNs5WPkG9SzuAcDgmy1cLWeqDvwo+9yeyxFugW1aHun3T5vvZKVa9mHJDOIlbVJn6D5nxVv+BYm1BbJoqjbKDWr+aQzyMh8vMXrDfwZWbKngpTLR7GeBF21IrF8n/t6CDmF1sJHCYS6VY1mIONwNbmKYxwEmWkZQeNO2it5Fv3wOkqZVhqAWZg01iBme8+RVVTGsK9tLjrgp9pjT3iklmxMDMs8BOYFJqgcxAdAHuxSlECKHy9yZehZyraadXi+tPg/FmhBTX/PMaA2Z/ObPR4QKlLUDdTGGfZXiF0nExLv3l6DTeaHqfqnOe3nFcHYUPqNxuevnJAewJ7FNA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4953.namprd12.prod.outlook.com (2603:10b6:610:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 03:09:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 03:09:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index: AQHaQ3lDV0aWrUFAIUCtA7cIZYYqELDT0w8AgAAdP4A=
Date: Thu, 11 Jan 2024 03:09:45 +0000
Message-ID: <94beb551-18a1-46f4-995d-a4cf8ff6fa7c@nvidia.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CAHj4cs__ObsuA_hXHeSRPwHy-uSc558sxQy-jD2J85gQEg4BXw@mail.gmail.com>
In-Reply-To: <CAHj4cs__ObsuA_hXHeSRPwHy-uSc558sxQy-jD2J85gQEg4BXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4953:EE_
x-ms-office365-filtering-correlation-id: 17a57609-f54c-4cce-133d-08dc1252c37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IGz0/zoTSeAuEOucrMAVd9OPdigf1gHHjscpHq0w0ntf+UgHtMkNIZKRhR6tq8WBS2F/zlq35gKx9vaMzMoOn+wSQne8GxDT+fRBg4ZETqoMTfybuVuHVzMfs70WcQDmx+2rYHL6e0sZ7sWtO61Exs6/0jVmGPTuo6rmYj3OlVxShoxe2P0pnEDwIIrjPjaM7CywzKBxilkeDRBaseLqWukwGxvo6cegXFFeQEs3+za3zleUsJo+yVT9ltzc5JrQSpZT3WwDJga2L52phmDMncvfEn+xJcbE/nQtgfRVdw/vWQRnn5pe2OFOee8tCD7fB7ui2Edm/VPZmESXOyJYpKL6dh6gUg6CRr2PcapSpJqwbdEMYVyExDpB8kDkWMGxEeF6t5sQvjwNr+PMLY3kFXx5hU0HZNqWaRrX2ce08qWvRuxJAGnUDbDBMfkQxKY5rgzRO4ZyKMBm9DrKop0ZJ0+ozeRLN6k3+L4oGGSffvO6ftxcwisWk9IFI8bdsRcjEW7bQn+opLZ0ewdBCgVXSDdxBT/xifbNjUMFSUYlizy/lxsVKSZ2oMHK1JGmb8p2NBpWp6SIgMelCekZQJqOGYQU9nGVHS33qB2G4tD2Un8O2W17liA4R8U0iBifEaHavBXt+7kXNclC+2oST+iyctrKawabxYNDFxoU+DH3LP2beV6XMMEha3KlvUpv0DsQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(6486002)(71200400001)(122000001)(64756008)(66446008)(31686004)(31696002)(8676002)(54906003)(66556008)(66476007)(4326008)(8936002)(91956017)(76116006)(316002)(66946007)(36756003)(110136005)(478600001)(53546011)(2616005)(6512007)(86362001)(6506007)(2906002)(5660300002)(38070700009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZStOcGQ1UnZpbVhWOEN3enViQU8xY2crM2szeUNHWUxLdEFYMW9UR3M0YmFO?=
 =?utf-8?B?RVV5dlAwOHNSK0tVdUFSZTlyckwram1hSVZiVEFsZHVzWEo1d2ZDdU5hZi9C?=
 =?utf-8?B?TTUreE9yaENmZ1RnU2RlWUVQdTZ5UGtUK2FHaXZWbUVjemhTeldZMk9rS1Zr?=
 =?utf-8?B?eTFEcS9iR2tiU3I2cHJhd1ZkYy9GSGFIOHI1cU5VeXlrTDlzWENLbmxOWTlK?=
 =?utf-8?B?TFRRUkpSRldSOHlBWlQzWC9uVDdjNDNGS3N4SnNMa2NFQ056ajRhck1RU2VL?=
 =?utf-8?B?LzJJZVdKREtLeGRiZDJhWUxjT1V0aGlvazhRQTlQNE84VjgvS1hDMGtHM1FE?=
 =?utf-8?B?SHhabU0xREZYTXV4eGtuQ3ZqdHFISk1qQmtFMjNTUHpTU0VnQ2NuR2xMT2NY?=
 =?utf-8?B?Q3A4NG1hV3VUZlRXWGNHb3l2RVpFakZwUFNqN1Y5M2lBUG52ZldnNVBORFNV?=
 =?utf-8?B?WWdjR2ZPZGJhTGw3MENCZVRwNWZtWDU3azZ2V2lHQnRaMmNMZXI4MS9CQ1ZJ?=
 =?utf-8?B?VXVBT2JyeXBxYVM1ZlBqcU5zYU5oNFZLWm9rdHYyS29rSHhIK2YzbGxxTDR4?=
 =?utf-8?B?ZE5rOHZMZnNYVmRoUmhsaWRrR2ZTZTBNcGNBeEhvV3VrTDgxQUdWL2tDSnZp?=
 =?utf-8?B?MXZrcVpiTFA4ZTZ1MjBhajVSeHA0K01ZM2pqQkFVVzJtbnM5T2pnV2N4MGNY?=
 =?utf-8?B?bkc2blNvOE1zMnpKblkxRHFmMHk5cDkxajRESVdVQ2dSbmJDMnAra2xJTENa?=
 =?utf-8?B?N3J6ZE9mZkJ0WkRieHgyNkFkWExqeFRiU29pVlAxYWJYSWZDUW1ZUm9TRm1H?=
 =?utf-8?B?aVNYVkoyK0IxWDFwaXpkRThQVnNMVndPOEw1RW9yWEhXSGR1aXREQlVSaisr?=
 =?utf-8?B?RTFGU01CcW9GdFNPb09ZaG1rdURmTWp0Q2YwdVh3QlFLbFdoYmtMRmtDaCs4?=
 =?utf-8?B?Z05ORE85Wkhqb2NFT3VCSVZqcVZpczljanF4cnNRZ2RKTm14N3BmODl0eTNh?=
 =?utf-8?B?ZTltbk9tZks0V0ppWmt1Z1lKS1dOL1VxbHJDZWNDYXZsV1RMOG1OZlBidVZ5?=
 =?utf-8?B?S0VFaGZXZ3RHcE1SUnJCbjl0ZlppbnFvSEQ0ZnZ2alVIY2hVbS9hSVBraHky?=
 =?utf-8?B?RmZjTWJKdlMxblFmak0xZnJDWUlBaEZXQXRZaHNVNlMzV3RwNkcveTJhSXJB?=
 =?utf-8?B?OTMyQWYxbUVTemlBNlhkNW9Ga3VJSG9KbEljbEZjOVRCSTBoZkZmaU1WVnZL?=
 =?utf-8?B?VWtjbURKWUoyekVzTnUvTnZDdWVCcW1RYlJkR0x6aFhkREZjVFc1aGlyd01r?=
 =?utf-8?B?MlJ5TDdCYmQyRVdNdlhubTBKUTBPT0krODU1QmdwMHJQYkZGaEIzbCtzZ2Er?=
 =?utf-8?B?Y0Vza0IwWjFlZnJSQ3ZDZzJiZmdrWVlRTmRMZ2ZKcWh2eUNmTG1qb1MxckFn?=
 =?utf-8?B?eHNtU1FoTGdlMlV1UHFNME9MSnE5dHBUUzFKWTZDSjJZMzhHSHJmSTJrUUlN?=
 =?utf-8?B?MTl5RklNdzFHRjAxeE40MTJYUVFvR01DT21neTVBbEQrRlFXVmtTM3RtZk92?=
 =?utf-8?B?aVZFdkdMMFgzbllGSWdjZkRodGordmRnMTh2WERPdXk1SGgrSzAvQjVsZ2tL?=
 =?utf-8?B?ek9oczg5ZGNlUHlNZkExZ3lOQmxLM04zaVJuNzRkZTU2ZHRnQ2dkdjkvYzVT?=
 =?utf-8?B?YUpLYXNIN1FTeGIwYlUwanJXckU1NXhOK0dmdmNISllKVGt1ZHdXVnNITHZ5?=
 =?utf-8?B?ZEVBZXQrWFpURDZFSFpGUXMwRkk5dVdZOWZ2S09kSXJBRGxhZU5KKzlIY2d5?=
 =?utf-8?B?d0hONkhXblFROTllZng4RmNTVmsyTE9sdklOekZncm5uWmQwTDN5ZUx2Y0NV?=
 =?utf-8?B?WElmczE0ODU5dy95SFdtZlFRUUZkUE5POEhTc3RuSGRIS29kU1ZCcDdkMmdh?=
 =?utf-8?B?bEdXdWkrVU82WFlvQlgxSmwvMmI1REVUeDhMSm9JNkY2WER4TTg1QnU1eFhO?=
 =?utf-8?B?REEyMlFSZGdMOVpBUXFYRy85WjZ4eUlUdXVSQ1RneXJEU1gwa3VLRGNnWGtm?=
 =?utf-8?B?VjhXYitRT3BsUS9icVRqemR6SjQrZFloMG9Xai83eXczWVZxeU9IeVovaHJx?=
 =?utf-8?B?MjNER2hCeHdTM01rQUwrbGc4S0o3dzdwZDZ4SXExUzFXdzAyWGwwT2VKVXQ0?=
 =?utf-8?Q?YZFHLc9Fx8KJy0hkz1dihg7UwXUCHuYMkah9Ix8xZVlL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5508C3D8BC5A364DA65E61E6157864E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a57609-f54c-4cce-133d-08dc1252c37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 03:09:45.5959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvuhweVEGar/YhBvAAPYpqAP5UkggyR0owpNL705nhyKvyMy65Z6/B8aLmUNOjLz2Hoq/x4mmYvtncpvDGss9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4953
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_191002_493387_42A6056D 
X-CRM114-Status: GOOD (  15.13  )
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

T24gMS8xMC8yNCAxNzoyNSwgWWkgWmhhbmcgd3JvdGU6DQo+IE9uIFdlZCwgSmFuIDEwLCAyMDI0
IGF0IDExOjU44oCvQU0gQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4gd3JvdGU6
DQo+PiBUcmlnZ2VyIGFuZCB0ZXN0IG52bWUtcGNpIHRpbWVvdXQgd2l0aCBjb25jdXJyZW50IGZp
byBqb2JzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvbnZtZS8wNTAgICAgIHwgNDMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9udm1lLzA1MC5v
dXQgfCAgMiArKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKykNCj4+ICAg
Y3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL252bWUvMDUwDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy9udm1lLzA1MC5vdXQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS8wNTAg
Yi90ZXN0cy9udm1lLzA1MA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4+IGluZGV4IDAwMDAw
MDAuLmJhNTRiY2QNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3Rlc3RzL252bWUvMDUwDQo+
PiBAQCAtMCwwICsxLDQzIEBADQo+PiArIyEvYmluL2Jhc2gNCj4+ICsjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMy4wKw0KPj4gKyMgQ29weXJpZ2h0IChDKSAyMDI0IENoYWl0YW55YSBL
dWxrYXJuaS4NCj4+ICsjDQo+PiArIyBUZXN0IE5WTWUtUENJIHRpbWVvdXQgd2l0aCBGSU8gam9i
cyBieSB0cmlnZ2VyaW5nIHRoZSBudm1lX3RpbWVvdXQgZnVuY3Rpb24uDQo+PiArIw0KPj4gKw0K
Pj4gKy4gdGVzdHMvbnZtZS9yYw0KPiBIb3cgYWJvdXQgcmVzdHJpY3RpbmcgdGhpcyB0ZXN0IHRv
IHBjaSBvbmx5PyBqdXN0IGxpa2UgbnZtZS8wMzIgZGlkLg0KPiBudm1lX3RydHlwZT1wY2kNCg0K
WWVzIGl0IGhhcyB0byBub3csIHNpbmNlIEknbSBhZGRpbmcgVEVTVF9ERVYsIHRoYW5rcyBmb3Ig
bWVudGlvbmluZyB0aGF0DQphbHJlYWR5IGFkZGVkIHRoYXQgY2hhbmdlIHRvIHYyLg0KDQo+PiAr
DQo+PiArREVTQ1JJUFRJT049InRlc3QgbnZtZS1wY2kgdGltZW91dCB3aXRoIGZpbyBqb2JzLiIN
Cj4+ICsNCj4+ICtyZXF1aXJlcygpIHsNCj4+ICsgICAgICAgX3JlcXVpcmVfbnZtZV90cnR5cGUg
cGNpDQo+PiArICAgICAgIF9oYXZlX2Zpbw0KPj4gKyAgICAgICBfbnZtZV9yZXF1aXJlcw0KPj4g
K30NCj4gQ2hlY2sgdGhlIHRlc3QgZGV2IGlzIG52bWU6DQo+IGRldmljZV9yZXF1aXJlcygpIHsN
Cj4gICAgICAgICAgX3JlcXVpcmVfdGVzdF9kZXZfaXNfbnZtZQ0KPiB9DQo+DQo+PiArDQo+PiAr
dGVzdCgpIHsNCj4gVXNlIHRlc3RfZGV2aWNlKCkgaGVyZS4NCg0Kb2theSAuLg0KDQoNCi1jaw0K
DQo=

