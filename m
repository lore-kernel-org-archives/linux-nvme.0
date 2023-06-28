Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66605EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 02:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/cKcGeJBvdNI9PpD8AQRWiD3Bdrdb/kQdEMZepR6PU=; b=KGYvzQ6MfFhM3arsakwG9mcWEh
	AxEOgeAXc6C7p8SnXhMpk+6T85w0nQJc5nLgcUQ26+ftlGaMZ9H7VBEUmlX/YGdzTXd6WV7c2cTwq
	rCHUlcWg3WxTPiSvoylK/5P1q2c7Ck+/Nw/6Y+GdPDKHvMPlf8EZgW/yzAl5PWUX8qH3RMKExY8qv
	P/80Ywqvg5UhjhNXLMJAye4rIgRYgA14tmcgvH2jcVnStIIg4cjkqRybPRFjrnveYEVhrQH+QUNCo
	ziVAzzRwUN5bJlRF2/xsoEW49ptj4jl5V+e8abNE8O6Dz/t/m+OAzTwcQsXC+dAnaAwzo3Hrq9G5Y
	7osrCCZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEL0I-00Eb6W-2S;
	Wed, 28 Jun 2023 02:33:58 +0000
Received: from mail-dm6nam12on20619.outbound.protection.outlook.com ([2a01:111:f400:fe59::619] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEL0G-00Eb62-0m
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 02:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRRcsVha45NnjgmVWdeZ8XMdF8dcbUg19aEwRvtVYsq3V985NEyL1Kj7uKK7IiRAr7IY6LlAteCoeUWQDmUAQsWlcuYdMK+Adkr8UMNb9dlxnlmwEZ433LAFl0MIayndYJTxwmPiPgiV/GKQPsj2+dY1Mr+WtP5HaqD73inGPF+J6rmVwKHDLHDnojm/BZS9kVQIwaVfAGD9tdy00A/dB0F5gbQ9PcEKDMxs3WHWfKTWNjygBpJjyuE71wo3bXkNEGnf7jubVfgKVrCqWA3vt3bEsKbls3atjpY+sM3GUcnjfEffTon7mTKFv7PdWjDzOVzUCiQWxDfy70+ZMgz60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/cKcGeJBvdNI9PpD8AQRWiD3Bdrdb/kQdEMZepR6PU=;
 b=cOlNof1hVZNmRmRZ8rxWKtrWl2cg7vN33xRIj/GAZu81Zn1XrRlp51nwmBPgFjSp9VVCORQhVelrKw1/jGDr+8kUlqXXSNRqtqMREoGDxtwkHz7B9spOGDl35/+KQiLpK3vp2A+WcOM5DHaVsAQ48lBRDux3MM01iVVxxnyFguBSG9RPNlk9UzvRG7SirgewFnv+EgH4i/1Y1taErTcImZuyf/2UYqDZfSkoXp/AfDFihKowJP2H30K7zzspoCuZxRVQ1pqhuDODbyJHtdUg+GZfb9KCYRpOjIMx3KN8mtxao8bfBFuznTlx9cETTC8EVie7ZXtXvuJg/aHV0m6Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/cKcGeJBvdNI9PpD8AQRWiD3Bdrdb/kQdEMZepR6PU=;
 b=hez8EXJxM0rPS4khvu4Bn3O4xCYhPlkmdLBEiyzaxLb+TY7Ehu6KxtIl+cZPLx80OvnXiXRTikEAagPA9Wm0hsoxN7WxfW3qlWIrpqpXLy3wCb/MM5zPckE11HVNUiOJ/nJpFnYFrFUJ28teEJNzhoZbhg+WvOonoQk36jXQ1+dbS2d5V5btRRcc4KmbkV98ozUMSUmWP8uVWCHeSpqyTvsb4m0ASspgQLb9UUgwPtG/TFpKlStbXkC1FKvsQbsjq4nXLt+596yNCwQCuCtEY3qsDREPO9jDnp075GPO9h75I2sbzTepvmIlbsXfc1PBjHzPmv4MuL9q6he6pRQUqQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 02:33:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 02:33:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ofir Gal <ofir.gal@volumez.com>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Thread-Topic: [PATCH] nvmet: allow associating port to a cgroup via configfs
Thread-Index: AQHZqN6C7nKhQynbxk2VZvf4OTD6nK+fJqYAgABZi4A=
Date: Wed, 28 Jun 2023 02:33:48 +0000
Message-ID: <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
In-Reply-To: <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH0PR12MB7930:EE_
x-ms-office365-filtering-correlation-id: 9fc620b9-e3f1-45b2-0000-08db77801a33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Lwy5ZfKycHio25GhCR6zDi9ZxaEncl2K4afyB3kbyFjbtb5et7xQsMxwtHAEsGjqKHW6TW1ExUkgxh5pJD8aoP7z43MPOSifn480qZTbhdoLJKEqFwyDt+DOe8LFYAqk1gKOAbSIIp4aqJXX+TP5fDD6us1Fr6NAP9eCQ1adR1ehxpRZs5c6/G1GjMl5tEPmUxBrRzCzE+xZjPDAcEvvXkfoMLUZQQs7mAsSUtuz513O+F75Q4mnt8AE6jZazj7A0gr7os33t1Q3vRgESPDQGlGOmRUbdwJLFeZt5EbI1wYVrHswDyqv6YVtaqQf8oNfTalUB4vLALAL+C1ifGe6IgeAlUhga5A+Ip2ooNzeTm1+SQXxq5EKFRnreLNQsyfhLKI6nDh/DZjgyp4gEBPsI1AEo6z2p1IVgLpJL3uIudQHAqS7xJUqifBbWpstA4k+yrtf7T2EuHJ0loIC7tV3aRT6tze8WduACXOtHF8ZkmH0+QrxyVkzRW2h2KL2OW/tWQOazQ2ZhLHLvAIeFCx4FrfXyWZp53N1VLD/usVMjq8L5laV3NyWgLZCb9FXUqojxOjCedYengfg+yVhBZzCsmUbNrPFuWsVeuIh+GdWZozCLSfRMZxxGQ2+KjOlIA3rG2tuIJiDpfwPT6NLTlD93u8dXZACx9wxR4aK6yKpqWW+lSHBQA7vvoVWbzmryBY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(2906002)(53546011)(6486002)(83380400001)(38100700002)(71200400001)(2616005)(122000001)(6506007)(6512007)(186003)(41300700001)(54906003)(31696002)(86362001)(4326008)(38070700005)(478600001)(66556008)(66946007)(66446008)(6916009)(66476007)(76116006)(316002)(64756008)(8936002)(5660300002)(8676002)(91956017)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3AxZUtjSDRyQmxUR1dnZFBTditFNUJIOWZsSEcwakVram1hZmY4b0pCVUF5?=
 =?utf-8?B?elN4aUlpdW81T2pnWCtXU0Y0QTJFYm9zR0t0TnV0NHM2S0xJdGJaeCtPZnhB?=
 =?utf-8?B?bFZ1N1R2clBpRFA2T3JxWnVRZ0FSaDk0YU52ZlFDNklaUmtEeDBES1NjbkVG?=
 =?utf-8?B?NnlHS1hwd1hCM1U3ZTBmeG56bmVsQ0NNS040K1hOTTkyMWJFa3VkZUtvQ1lR?=
 =?utf-8?B?VGNaT3ozL0VGYnUxYlJoREZxWGlOZzgvb25WR2drYjRkRENaTnE5c2MxeU5w?=
 =?utf-8?B?MmR5K3hIK0FtejNOSjVleVl5anhnVmtKL25mY2JlRTFXa2hUVWZOSTRxb3lI?=
 =?utf-8?B?eGpCdDZUaHBCb2d1SVRpc1pobUg3WEZQTGZFclVUcnBJQlViTGdtOTYxQ0xi?=
 =?utf-8?B?Z00vSSs3aGlEa3NSN1laM25yRG5HUGh3ZjltZmFrcEhIeEVJSlJBMHd6WHJC?=
 =?utf-8?B?YTZoM29mSUxqZHhyMlJIaDhoRTVJZ3lpRE1wQXR6TXVNTjlXdTE3ZUF0NFp2?=
 =?utf-8?B?b3M4djFhdkI1L2NDZUd2VkRQRTlmcFlubHV6c25STUVtR1U2VjN6blFEUEFL?=
 =?utf-8?B?YytrckJFM1NpS0p6b3hka0hnb3ZVbnFjMkZZdDRlNjlaWmpNY1VhcEVDSk5F?=
 =?utf-8?B?dXBJYXJRNVNPMklJMDgxejU4MkkycktIQ0d1RGNmbmVTMnM0RnF0QURDNGxj?=
 =?utf-8?B?TmtTWmNyL2N4Y1FEZzZZQVpsd2l4TjlxZ1QvT2paeDBDbmtnZFdxUkZTNkpC?=
 =?utf-8?B?WDNsT28wa0Uxdk5RdWlvUndkTkhEejJhaldlUGI1RnZsY0gyc01lMFFqS3dI?=
 =?utf-8?B?cTBReE4yamkwc254Y2VoSWtOd3cwa2pLQmFIZ2ZFaS9zazdhUk82RzdDZDRW?=
 =?utf-8?B?UlZPaGMwTmpMM2hRZStRQXJkb0xRVDc1QUhHd0szWG5ELzFoMDlkY2E0NzVB?=
 =?utf-8?B?SUN1QjFOdk1QcXUvRkdhaEQ4alJ2L2VYMllncnlhc1RNdGYrTDlXRWhVUjM1?=
 =?utf-8?B?M0NBZnFPZ3c5OW9jcDloUGs4L1c5c1gwV204dHVaVXFDS0IySERJKzdhaEdx?=
 =?utf-8?B?SXBlemFmQzVHdUhhWUc3YS95Z0ZrNFZ6ektnV25vdExseFIxN09aWHJmdGpZ?=
 =?utf-8?B?YngzcithZ3hqUXppT1dpemJPTUpOWGswU1ZwTml1QkNLYUQ0eDVGYldVU1g3?=
 =?utf-8?B?Q0dLUUlHUWFtUVk2OGZNUlVoZ012Ty9OTnJTd2xjTncvZUxOMDZhM1l2VU95?=
 =?utf-8?B?SUU0T0Z4c3dEZ280aWVkV2Y2a1FkMG5tK2l4dUVlNmd5ZVdXcmNKbms4ZjRX?=
 =?utf-8?B?TmorZmlrWEUrOWFsdnZJdUxOVnNmaTR0QVc2a3N6Z01iQ2RYbTJVWVFGbmw5?=
 =?utf-8?B?b2Y0TUxxYVlPTGlCRUpidVpUamRwbUFNNE1jZTdqMjd1WWMyczh3aVhRaXVa?=
 =?utf-8?B?RnEwSzlFUkdsNEh2b3ZGRW1iSEFyc3duR3l1MHZieWNGRFdHTnpjbjBtUTQv?=
 =?utf-8?B?SmtyUGNXb3daRmlhU2RLdVdaVVg5QUhLRFFnUFlyUHBUM1o5OWNHMnN0ZGp5?=
 =?utf-8?B?dGVjR3hvZmFBOFFvSEZpR3ZIS3NsRG1OaDNFLzZidmlSTFk4VzRaK2JaS2NU?=
 =?utf-8?B?UEtFTnZJeEpVMjh4ZnNsOUxGMEdWamRaYmpGaHpicnJBNldpbE9pTytSSlNX?=
 =?utf-8?B?V3o2RlRkbXkyTENUTExuc1YwMFpqQ3ZrcmVvUzdHVFpvYzY0MjhJUlFTS3FW?=
 =?utf-8?B?bTZ2TUxERTk4NnNpek1CMzNDTUtqd2lneUZleG1CYWRzZWNDTnFhS2VMT2p3?=
 =?utf-8?B?RGZwaFZINXlZVnREczF1RUQ4TUprVDhnb2hHbmp2dGtQZFVPR25qUFlybVlL?=
 =?utf-8?B?TFBnNkZTbnFjd00ybHROZWZlbndPdit0d0lmNE5YY2NhbjJiTllnd2ZLOGtF?=
 =?utf-8?B?b05NMUJlUTBnaTRxN1daWFdsZXMwcDhWaERtUXA0cFMxR1dTN2VvK3NTbVAy?=
 =?utf-8?B?OGtyK0xhSlJ1N01pYlNUS1hyN2hyMzA2bzNwWHVHbHlIaXk4aGVvZkhSZjZm?=
 =?utf-8?B?akZ3Y2VIcS82Z1ZXWEhOVFpPdjFDTkNMdVd2YWh0Q1FJeDVHZ0N6dU1nY3Ji?=
 =?utf-8?B?SXExczF0bWZOR1RjOEdtNzFLWFZGcjVzMDZWNmZ4MWlGdUNvZUk1WHJGTnhY?=
 =?utf-8?Q?yobd5QbFZgLRB2zhPEEq9MNjmTjCo6yPrBvMlnK9IwNQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30A4F6DADD7F914C851FB2206D788E51@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc620b9-e3f1-45b2-0000-08db77801a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 02:33:48.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1xwRP1VO00EGBBOJiBd66H24Npl2UFNf1WgwhzUxxhN3qDdg0NgPTxfXORlohDCPNoff/0a3V5kPr/jHRfq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_193356_334592_0CA8E16C 
X-CRM114-Status: GOOD (  31.62  )
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

T24gNi8yNy8yMyAxNDoxMywgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gSGV5IE9maXIsDQo+DQo+
PiBDdXJyZW50bHkgdGhlcmUgaXMgbm8gd2F5IHRvIHRocm90dGxlIG52bWUgdGFyZ2V0cyB3aXRo
IGNncm91cCB2Mi4NCj4NCj4gSG93IGRvIHlvdSBkbyBpdCB3aXRoIHYxPw0KPg0KPj4gVGhlIElP
cyB0aGF0IHRoZSBudm1lIHRhcmdldCBzdWJtaXRzIGxhY2sgYXNzb2NpYXRpbmcgdG8gYSBjZ3Jv
dXAsDQo+PiB3aGljaCBtYWtlcyB0aGVtIGFjdCBhcyByb290IGNncm91cC4gVGhlIHJvb3QgY2dy
b3VwIGNhbid0IGJlIHRocm90dGxlZA0KPj4gd2l0aCB0aGUgY2dyb3VwIHYyIG1lY2hhbmlzbS4N
Cj4NCj4gV2hhdCBoYXBwZW5zIHRvIGZpbGUgb3IgcGFzc3RocnUgYmFja2VuZHM/IFlvdSBwYWlk
IGF0dGVudGlvbiBqdXN0IHRvDQo+IGJkZXYuIEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGlzIHNhbmVs
eSBzdXBwb3J0ZWQgd2l0aCBmaWxlcy4gSXQncyBwb3NzaWJsZQ0KPiBpZiB5b3UgY29udmVydCBu
dm1ldCB0byB1c2UgaXRzIG93biBkZWRpY2F0ZWQga3RocmVhZHMgYW5kIGluZmVyIHRoZQ0KPiBj
ZyBmcm9tIHRoZSBrdGhyZWFkLiBUaGF0IHByZXNlbnRzIGEgd2hvbGUgb3RoZXIgc2V0IG9mIGlz
c3Vlcy4NCj4NCg0KaWYgd2UgYXJlIGRvaW5nIGl0IGZvciBvbmUgYmFjay1lbmQgd2UgY2Fubm90
IGxlYXZlIG90aGVyIGJhY2stZW5kcyBvdXQgLi4uDQoNCj4gTWF5YmUgdGhlIGNsZWFuZXN0IHdh
eSB0byBpbXBsZW1lbnQgc29tZXRoaW5nIGxpa2UgdGhpcyBpcyB0byBpbXBsZW1lbnQNCj4gYSBm
dWxsIGJsb3duIG52bWV0IGNncm91cCBjb250cm9sbGVyIHRoYXQgeW91IGNhbiBhcHBseSBhIHdo
b2xlIHNldCBvZg0KPiByZXNvdXJjZXMgdG8sIGluIGFkZGl0aW9uIHRvIEkvTy4NCj4NCj4+IFNp
Z25lZC1vZmYtYnk6IE9maXIgR2FsIDxvZmlyLmdhbEB2b2x1bWV6LmNvbT4NCj4+IC0tLQ0KPj4g
wqAgZHJpdmVycy9udm1lL3RhcmdldC9jb25maWdmcy5jwqDCoMKgIHwgNzcgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gwqAgZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmPCoMKg
wqDCoMKgwqDCoCB8wqAgMyArKw0KPj4gwqAgZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRl
di5jIHwgMTMgKysrKysrDQo+PiDCoCBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmjCoMKgwqDC
oMKgwqAgfMKgIDMgKysNCj4+IMKgIGluY2x1ZGUvbGludXgvY2dyb3VwLmjCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCA1ICsrDQo+PiDCoCBrZXJuZWwvY2dyb3VwL2Nncm91cC1pbnRlcm5hbC5o
wqDCoCB8wqAgNSAtLQ0KPg0KPiBEb24ndCBtaXggY2dyb3VwIGFuZCBudm1ldCBjaGFuZ2VzIGlu
IHRoZSBzYW1lIHBhdGNoLg0KPg0KPj4gwqAgNiBmaWxlcyBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3Rh
cmdldC9jb25maWdmcy5jIA0KPj4gYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMNCj4+
IGluZGV4IDkwNzE0Mzg3MGRhNS4uMmU4ZjkzYTA3NDk4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9udm1lL3RhcmdldC9jb25maWdmcy5jDQo+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Nv
bmZpZ2ZzLmMNCj4+IEBAIC0xMiw2ICsxMiw3IEBADQo+PiDCoCAjaW5jbHVkZSA8bGludXgvY3R5
cGUuaD4NCj4+IMKgICNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCj4+IMKgICNpbmNsdWRlIDxsaW51
eC9wY2ktcDJwZG1hLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2Nncm91cC5oPg0KPj4gwqAgI2lm
ZGVmIENPTkZJR19OVk1FX1RBUkdFVF9BVVRIDQo+PiDCoCAjaW5jbHVkZSA8bGludXgvbnZtZS1h
dXRoLmg+DQo+PiDCoCAjZW5kaWYNCj4+IEBAIC0yODEsNiArMjgyLDgxIEBAIHN0YXRpYyBzc2l6
ZV90IA0KPj4gbnZtZXRfcGFyYW1fcGlfZW5hYmxlX3N0b3JlKHN0cnVjdCBjb25maWdfaXRlbSAq
aXRlbSwNCj4+IMKgIENPTkZJR0ZTX0FUVFIobnZtZXRfLCBwYXJhbV9waV9lbmFibGUpOw0KPj4g
wqAgI2VuZGlmDQo+PiDCoCArc3RhdGljIHNzaXplX3QgbnZtZXRfcGFyYW1fYXNzb2NpYXRlZF9j
Z3JvdXBfc2hvdyhzdHJ1Y3QgDQo+PiBjb25maWdfaXRlbSAqaXRlbSwNCj4+ICvCoMKgwqDCoMKg
wqDCoCBjaGFyICpwYWdlKQ0KPj4gK3sNCj4+ICvCoMKgwqAgc3RydWN0IG52bWV0X3BvcnQgKnBv
cnQgPSB0b19udm1ldF9wb3J0KGl0ZW0pOw0KPj4gK8KgwqDCoCBzc2l6ZV90IGxlbiA9IDA7DQo+
PiArwqDCoMKgIHNzaXplX3QgcmV0dmFsOw0KPj4gK8KgwqDCoCBjaGFyICpzdWZmaXg7DQo+PiAr
DQo+PiArwqDCoMKgIC8qIE5vIGNncm91cCBoYXMgYmVlbiBzZXQgbWVhbnMgdGhlIElPcyBhcmUg
YXNzb2ljYXRlZCB0byB0aGUgDQo+PiByb290IGNncm91cCAqLw0KPj4gK8KgwqDCoCBpZiAoIXBv
cnQtPmNncnApDQo+PiArwqDCoMKgwqDCoMKgwqAgZ290byByb290X2Nncm91cDsNCj4+ICsNCj4+
ICvCoMKgwqAgcmV0dmFsID0gY2dyb3VwX3BhdGhfbnMocG9ydC0+Y2dycCwgcGFnZSwgUEFHRV9T
SVpFLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjdXJyZW50LT5uc3Byb3h5LT5jZ3JvdXBfbnMpOw0KPj4gK8KgwqDCoCBpZiAocmV0dmFsID49
IFBBVEhfTUFYIHx8IHJldHZhbCA+PSBQQUdFX1NJWkUpDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTkFNRVRPT0xPTkc7DQo+PiArDQo+PiArwqDCoMKgIC8qIE5vIGNncm91cCBmb3VuZCBt
ZWFucyB0aGUgSU9zIGFyZSBhc3NvaWNhdGVkIHRvIHRoZSByb290IA0KPj4gY2dyb3VwICovDQo+
PiArwqDCoMKgIGlmIChyZXR2YWwgPCAwKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gcm9vdF9j
Z3JvdXA7DQo+PiArDQo+PiArwqDCoMKgIGxlbiArPSByZXR2YWw7DQo+PiArDQo+PiArwqDCoMKg
IHN1ZmZpeCA9IGNncm91cF9pc19kZWFkKHBvcnQtPmNncnApID8gIiAoZGVsZXRlZClcbiIgOiAi
XG4iOw0KPj4gK8KgwqDCoCBsZW4gKz0gc25wcmludGYocGFnZSArIGxlbiwgUEFHRV9TSVpFIC0g
bGVuLCBzdWZmaXgpOw0KPj4gKw0KPj4gK8KgwqDCoCByZXR1cm4gbGVuOw0KPj4gKw0KPj4gK3Jv
b3RfY2dyb3VwOg0KPj4gK8KgwqDCoCByZXR1cm4gc25wcmludGYocGFnZSwgUEFHRV9TSVpFLCAi
L1xuIik7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBzc2l6ZV90IG52bWV0X3BhcmFtX2Fzc29j
aWF0ZWRfY2dyb3VwX3N0b3JlKHN0cnVjdCANCj4+IGNvbmZpZ19pdGVtICppdGVtLA0KPj4gK8Kg
wqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKnBhZ2UsIHNpemVfdCBjb3VudCkNCj4+ICt7DQo+PiAr
wqDCoMKgIHN0cnVjdCBudm1ldF9wb3J0ICpwb3J0ID0gdG9fbnZtZXRfcG9ydChpdGVtKTsNCj4+
ICvCoMKgwqAgc3RydWN0IGNncm91cF9zdWJzeXNfc3RhdGUgKmJsa2NnOw0KPj4gK8KgwqDCoCBz
c2l6ZV90IHJldHZhbCA9IC1FSU5WQUw7DQo+PiArwqDCoMKgIHN0cnVjdCBjZ3JvdXAgKmNncnA7
DQo+PiArwqDCoMKgIGNoYXIgKnBhdGg7DQo+PiArwqDCoMKgIGludCBsZW47DQo+PiArDQo+PiAr
wqDCoMKgIGxlbiA9IHN0cmNzcG4ocGFnZSwgIlxuIik7DQo+PiArwqDCoMKgIGlmICghbGVuKQ0K
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPj4gKw0KPj4gK8KgwqDCoCBwYXRo
ID0ga21lbWR1cF9udWwocGFnZSwgbGVuLCBHRlBfS0VSTkVMKTsNCj4+ICvCoMKgwqAgaWYgKCFw
YXRoKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gK8KgwqDC
oCBjZ3JwID0gY2dyb3VwX2dldF9mcm9tX3BhdGgocGF0aCk7DQo+PiArwqDCoMKgIGtmcmVlKHBh
dGgpOw0KPj4gK8KgwqDCoCBpZiAoSVNfRVJSKGNncnApKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRU5PRU5UOw0KPj4gKw0KPj4gK8KgwqDCoCBibGtjZyA9IGNncm91cF9nZXRfZV9jc3Mo
Y2dycCwgJmlvX2NncnBfc3Vic3lzKTsNCj4+ICvCoMKgwqAgaWYgKCFibGtjZykNCj4+ICvCoMKg
wqDCoMKgwqDCoCBnb3RvIG91dF9wdXRfY2dyb3VwOw0KPj4gKw0KPj4gK8KgwqDCoCAvKiBQdXQg
b2xkIGNncm91cCAqLw0KPj4gK8KgwqDCoCBpZiAocG9ydC0+Y2dycCkNCj4+ICvCoMKgwqDCoMKg
wqDCoCBjZ3JvdXBfcHV0KHBvcnQtPmNncnApOw0KPj4gKw0KPj4gK8KgwqDCoCBwb3J0LT5jZ3Jw
ID0gY2dycDsNCj4+ICvCoMKgwqAgcG9ydC0+YmxrY2cgPSBibGtjZzsNCj4+ICsNCj4+ICvCoMKg
wqAgcmV0dXJuIGNvdW50Ow0KPj4gKw0KPj4gK291dF9wdXRfY2dyb3VwOg0KPj4gK8KgwqDCoCBj
Z3JvdXBfcHV0KGNncnApOw0KPj4gK8KgwqDCoCByZXR1cm4gcmV0dmFsOw0KPj4gK30NCj4NCj4g
SSdtIG5vdCBhdCBhbGwgY29udmluY2VkIHRoYXQgbnZtZXQgcmF0ZWxpbWl0aW5nIGRvZXMgbm90
DQo+IHJlcXVpcmUgYSBkZWRpY2F0ZWQgY2dyb3VwIGNvbnRyb2xsZXIuLi4gUmdhcmRsZXMsIHRo
aXMgZG9lc24ndA0KPiBsb29rIGxpa2UgYSBwb3J0IGF0dHJpYnV0ZSwgaXRzIGEgc3Vic3lzdGVt
IGF0dHJpYnV0ZS4NCg0KKzEgaGVyZSwgY2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB0aGUgY2hvaWNl
IG9mIHBvcnQgPw0KDQphbHNvIGZvciBjZ3JvdXAgcmVsYXRlZCBjaGFuZ2VzIEkgdGhpbmsgeW91
IG5lZWQgdG8gQ0MgVGVqdW4gd2hvJ3MNCnRoZSBhdXRob3Igb2YgdGhlIGNncm91cF9pc19kZWFk
KCkgYW5kIHdoYXRldmVyIHRoZSByaWdodCBtYWlsaW5nIGxpc3QgLi4NCg0KLWNrDQoNCg0K

