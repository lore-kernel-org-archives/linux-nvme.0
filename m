Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808CCC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZwAnHvFyqYMc5lVjUvvb9YSFd6aaFGY3wnM8kXbjck=; b=Iygq0QaFdS5oyhB/x6zb6lITay
	wpStsnej/jYM+mPsqHAnf5kux76ySdxdgT3H2IklWQM9B3U3/18tA5pmXSHjHrx3+SiLvOJbDUnZD
	9ZBZpx/LLFoLDZs5+oD+Q8uee6liMGgRSEzxWmoRRS6K0ZxG+nIKhYXinmMBK54xeNBw1EZTvs9cf
	CIvdChiNRijpXq987uQRKKpguRiEMmDZ9VUceZ31xpP99z0U3ov7sxR1x7RPHYmcxWCqybXVyXL8a
	PBtlXGktZcOLsY1ZwLhN4ybGfUH2FUCj8H1zD7DuXZPj344FoXM8MPyjAIZZ7oFIamyrkwWEjjVxk
	9EmmYJxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJa1k-00EznR-S8; Mon, 14 Feb 2022 12:00:21 +0000
Received: from mail-co1nam11on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::615]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJZ60-00EfZG-7o
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 11:00:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kD5A98q2NRsdG/OugAh6wR6Q6cwse6VGr/yCuYgCoz9UT9Dd0l7EVSttNcrVuZQ5yOCsLi9ZjGBPC1JiAyyx5JCkjG5HpTdiGxKyrvxNOzhp7oqow8YrN5MduXPG30mOE0ZQ6iQ0Y1n4bt8qZpOu0kB3wdYxrjs0uIEujmvBhrQhHg3Lo9g/r/Ls4OZlk5w9FmKSCWgOgp0rz1fMZiTrB/4G4XQTFpeI4qm8W4wtInJ++vELXA6V2xoW6mzXTX61dLWBYhfupkOqDy3YIjvJX3kxaF6O7p0ANZPCN9aXOzPt2/dXVIe1ICA7lH25sa0/amKPZT/BSm0sg+qmgHiLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZwAnHvFyqYMc5lVjUvvb9YSFd6aaFGY3wnM8kXbjck=;
 b=IDSIish/gK6rQFcvAMx1a2oz7FLtpidfYrkLnqN09wX+jgthFxmuf13p5BZ2e7U3H3cwK8gaMpr8fZ9eERizmda5JrkeXiA492dFqqF5EgBGfH38qJxayiKpwfXB2X6DNaR0YSWss4U0iYqj6N3AMRrpc5TarU+PaiZ+2yAnWWDNeWRauYhRFw3KbuOaOnF97q0KjiKLdFGtol3RNgHBO60Q6vi5WqYCI6GDiFdDP0aGj9W29n5Xu0Y/Ubic/OpmvmJoUEyA2mmNhBU7Cjc8zEz5dm3rxmwg16DY9TwBXbhc2w3NKhvrDkeYE/eJLPYNEBN/88fFMZREkRWZJZ1XDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZwAnHvFyqYMc5lVjUvvb9YSFd6aaFGY3wnM8kXbjck=;
 b=sa69dwqdF9szPis7o0bob/H9f4BowqP6Ma4oBHfoFfozN972U6axnBAIXlttsU4/OlKtoe29oZ1W9OihbeGrdN9MdZ1ShmFKir0+wu3iYdhdTm54Ecsh5TiLxc6EcvpfW+vVgpxyESMFKMcZM03ofPaKr2Ewf8X88LBg8TuCy7xxlWHDPRoXr3WcuR5jF0f19RptnvahuI4LTi+CBbBa8vgEJvFCONgqi3kYbCxtp7uq1RedRmVAClZYvDNuWPr0HdyTjLQA6o5xnWkzj5dmfOGbNbb8+/5sPMx/bmN2cfA/LMA/7x3EBZXey8dehEzXlVmx8iShRBEFTT5MEfkOuw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 10:44:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 10:44:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Thread-Topic: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Thread-Index: AQHYIYRxGili+sccbEWgjaiE4nwfg6yS0TuAgAAFLACAAAZEgA==
Date: Mon, 14 Feb 2022 10:44:34 +0000
Message-ID: <fd7fe925-370d-b369-97ce-119b852248c9@nvidia.com>
References: <20220214090732.479193-1-sagi@grimberg.me>
 <c6d8ce0b-7d75-7d6e-ecc7-e505de85aa4e@nvidia.com>
 <02763496-0104-4616-ef57-117eb741b82e@grimberg.me>
In-Reply-To: <02763496-0104-4616-ef57-117eb741b82e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f7e8426-a0ed-4c1e-918d-08d9efa6fd32
x-ms-traffictypediagnostic: MN2PR12MB4255:EE_
x-microsoft-antispam-prvs: <MN2PR12MB42559E7E20AE198F08C2E836A3339@MN2PR12MB4255.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2owRS/X6b6VYiLw8zL0ACj3u7QSEe+ioJNyeC8nbG7E8S970Z4DTNu76v30Bub9tU67rNPZvT1ySsWOpxVG1PZkYQWO+VRPmnGcWe8mwyIX96k+qvDbLEan0mHlTPhas6xmi88ZPLisdhVOW+fChLVSpg8H72wDyfFDpdPV4bNfoRoe2QxVs0Cfjd33cdAHz93Bnz1TxlrFTjzdY8tQjTGtcqI2APwKTzyPi8yb8U/KJ5U0ouMVZzvYYhCyh3bukdLNJ2I/vsHzekIDP0QusR71+NdvGajc77AASMCgUQxMdKXVZOw9khR6jqfFaOmY40mGkr9bdX20f7o2hOi9FEvWJrD4THKzAm/IK7IjaON0MSK44VVtPIjD3Cjf7wAiB10x0Mx+4JLWHMdlUuHjUY3Sr7woJrozg5Y6GVTHrL2+/yvu10/npT6ba1WYwJT0IwoIk2PXcTYyBfFnH0n1ZBDIiQtfaGJCRKGHAxC1c/9JZDzP/WPWNG5PzHkHoaA5ivjJsdidiCE3ebrs7TtaD/Ua1EugQiuTitCko7JWu9W3lqpsCdP8M5m5ZsBDeUmiYMKWRpnTXu4tqVGGbVNDKFh1dA2puhHMWZW642OUcwQcSvMIbtadFhkn2XEMQDHzZIrfZTwo5VLyP+TV9DoLXNjbqW2912lOMDaj6TI53qcZSoWvv8tJ6QtwWQXJIP2XaTQN8Tc8h8a0P5zGJ15WRazhTgcQUgz/MpapmPGMv1h9QH+JvXqiu2jnX5x5DiQF59BC5o/yzG3Czm1KIrwOrNmrnDF0MIs2dwOCBpSBADO8LJkAgAohHgiEGI7L0A62rmcKbk9vWI8vaNtqDVF/gpf9ohCfa3IndQFBKVwXuBTc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(8936002)(4744005)(4326008)(76116006)(2906002)(66946007)(66556008)(66476007)(66446008)(64756008)(5660300002)(38070700005)(8676002)(91956017)(86362001)(36756003)(31696002)(122000001)(38100700002)(83380400001)(508600001)(6512007)(2616005)(31686004)(6486002)(966005)(316002)(54906003)(6916009)(71200400001)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk1zSktDUDVWN1dwbFV4MzB2Q0dYdWVGb1N0ZU5xY1VJNlhEM1kzWGdkVXkx?=
 =?utf-8?B?RjU1cUVzc3JieXM1U3lja041Tnh1MzdHSC9kTStXeHZkMXdDUUQxU3BxVFFi?=
 =?utf-8?B?K2pTNkgwcGExOEYveXdIS3lWUW8vUTZXbXd0K0VyREUzaFIzTlo5WHhEUkh5?=
 =?utf-8?B?c0ZUeG9IQnM3VU5oUVVSTko2aWRsYU90aUhzQmt0VHl4ZlNRSVdEQWlIR0E2?=
 =?utf-8?B?OUVuM25GaExiRFNxTWhabmFOSGxrTlFsVkQ4M2tEQitIQ2UrQjRSQXIxTnJv?=
 =?utf-8?B?Q3g3b0dac25HVCtnblEyVUg0a1k0ci9XMW1lbzBudW4rK0xKR2tqOFVISi85?=
 =?utf-8?B?WkdNOGVrZEpKWldGbk5qMkY2aWNmMzcvdXZ5UWxzRlg3OHRJays2WkkyNTEz?=
 =?utf-8?B?STBBYTcvNDIyQ0Nld2d3WWI1UVlLTDZRS3NBSndhbTdjQ2daVVlLRzRMc25B?=
 =?utf-8?B?VSt1L0MvZHY0UFZ6RUcrV1NiRGNKa0gzV05MM0dtZUlXNmJqb3VRNHV3b1Fh?=
 =?utf-8?B?akNJajVLd1ZTRDlqRXhIY3U0ZHBDVm5ibXBDR05Gd25xbGJNdmc1RkNQbjk4?=
 =?utf-8?B?OXp1MjVob3Y1QWRjOTRuTHpoUVAxY1VSWGM2K2IwaVp1Z29rYnVpV3ZGRTNn?=
 =?utf-8?B?aEViaUhWcWlab2p4akl0bVFGQURkWVlYQTI1bUc2M2ZONlRJR2E5SmVVb0ZS?=
 =?utf-8?B?NFBJTEI1cE5PS2JnTUFFTTlIQUJNMWFvL3piRTltL1h3S1pBODhPYUVEeU5x?=
 =?utf-8?B?NVBIOE93eTRnNk1ZSmdxTEtmaGFPbWF6bndSdnh6a0FwV0ZsTnlUbXVYM3RC?=
 =?utf-8?B?UEpJNVArVk9SM1ExUWdDb1c1WW1vRXZhOXVqMmZ0Si9VbFJIU090TGZMVmJ6?=
 =?utf-8?B?cVh1dEpEdEU4QlNoOUp0V29ZMkdiSW5yWDZTN0s4RnlVWTZCSHR1TUlxQlRs?=
 =?utf-8?B?OFM4aXhld3RnM0NWd0pRUUlVVEszRENNQkRBVGt5OHovTU1ZSXhvNnJYWFZL?=
 =?utf-8?B?ZEpQekxqVzdDd2k0bjNEaDZDbXZUNjRIb1F2RVpZUnpRa0xSMzJVK3RpWW1x?=
 =?utf-8?B?cVQ3ODU0MXIrT3B4bkdKclhSY0ZQOGRjQVdxL0VFdzJkcldYUDB2Ym9vdU9I?=
 =?utf-8?B?bnkzZ0xuYVpjYmUxeWphS2NydlliZjlvTk02MDdnUEo4YjJXZi9pVlVXekdD?=
 =?utf-8?B?cWRpZERPUTVKNTJ6cnoxL1JwazdjM21pSWtUL295U3YySGVrRXIwQ0ZBQm1I?=
 =?utf-8?B?VlFpMVJsL0lHN2lmK1pmMjd2NjJ2Y01RT1crb3dGbXVDU2FzRSszV2RJOW5S?=
 =?utf-8?B?YVloMGgyL1lSeS9IL01OU1dBV3FGTTFEM3VteU1FWjRTUmhJVW9wczZpSjMv?=
 =?utf-8?B?NVdLT2Jid2labk9URVJQYzVxZlppb2lxZEZQcU5aOVYrWlFTcHZ1ZC9qNW1V?=
 =?utf-8?B?Q3Y5QVJiVDVzcXNyMlIxamRGSlhEbVEwTVJIN1dUbm5QTGxxYlNHY1RDZ3oy?=
 =?utf-8?B?TFB4K1IwOTJUdW4wcjNTZ2xiNjRYUWJWMzJLOVNsMzNwbUdEMGZ3b0hIV01X?=
 =?utf-8?B?UndBa05JaDV3TTR5ZDlxL1VSOUNqS1FOL04yY2VOM3FQVHhGVDlQb2xIY1Jt?=
 =?utf-8?B?UTNoa0xHcERCS0RCY3BWalErWmxVazFlS1FGUkdhSDUxZ04raGFETHFveWlI?=
 =?utf-8?B?Mk5yZGFUNlprWi9oaWVNUzNmZXRoVGo3L3F4QXV1SjZCWDFaLy85QmVoeWI3?=
 =?utf-8?B?bTFEMmVHbGNDbWoxVWFXWEdsVzBJTFBxL2t4c25TK2xtTUpHZnhtYm1YOGw5?=
 =?utf-8?B?bG1QK1hrZlIrWHRCeDZndDdrM0xXVnF4WFVhN2g2NHZpN3NuYmgycU9oMHBx?=
 =?utf-8?B?SDUwWE1kajYrYmxyYnRLV0pUODl2b2NtM3VMSGcxUkFWd0hXdzJBelhFMkIy?=
 =?utf-8?B?LzVIdHR5ZkEzbEJIcDJJckJQeFowRzQvazV0WXFMVDVrczBVSDZuNVZVSFpG?=
 =?utf-8?B?bEdaV21nSVhNYXI5RDNyN0I0MnNwcnVyeEo2eG1BeExOZHV2RGlZRnBMMTBx?=
 =?utf-8?B?ckE1RWNvMzllU1dkV3FOYjFBekc3SG54S1hFSC84NnRmVmJycmgyWXBramhn?=
 =?utf-8?B?eDNIZVRjMDNaZEU3cGJ4V0o4ay83YWpSblF1dmZINkVPeWwvNkdaSGNGVnJx?=
 =?utf-8?B?SmRCVm8zZkt2NFppUzUvaEYrUTlqYnUwcGQyM3MyeDdpeUZGLzNNRFdzRHlv?=
 =?utf-8?B?ZGk5cnA1Slhaam44N2ZJU1BZVGlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF4E381F26081541A8AFC0CF5897EF01@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e8426-a0ed-4c1e-918d-08d9efa6fd32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 10:44:34.0570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sy0Mr9d8SnTL4odGyfg1/vLZdb1gBzPxpaLUWUDRKEKX6O4woBRS+jP+WCkLzAbqHN19jic0M6Cx6/nw1xJ1pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_030040_305504_8A903436 
X-CRM114-Status: GOOD (  11.94  )
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

T24gMi8xNC8yMiAwMjoyMiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gDQo+Pj4gV2UgaGF2ZSB0
aGUgc2ltcGxlciBhbmQgbW9yZSBjb252ZW5pZW50IGlkcl9bYWxsb2N8ZnJlZV0sIHVzZSB0aGVt
DQo+Pj4gaW5zdGVhZC4NCj4+Pg0KPj4NCj4+IHlvdSBzZW50IHRoZSBzYW1lIHNlcmllcyA6KSBl
aXRoZXIgd2F5cyBzZWVtcyBsaWtlIGEgdXNlZnVsIGNsZWFudXAuLg0KPiANCj4gRGlkbid0IHNl
ZSB5b3VycyBmb3Igc29tZSByZWFzb24uLi4gRGlkIHlvdSBDQyBtZT8gQ2FuIHlvdSBwb2ludCBt
ZSB0bw0KPiBpdD8NCj4gDQoNCkkgZGlkIGNjIHlvdSwgaGVyZSBpcyB0aGUgbGluaywgc29tZWhv
dyBpdCB0YWtlcyBhIHdoaWxlIHRvIGFwcGVhcg0Kb24gdGhlIG1haWxpbmcgbGlzdCB0aGFuIGl0
IGFwcGVhcnMgaW4gbXkgbWFpbCBib3ggOi0NCg0KaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
cGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyMi1GZWJydWFyeS8wMjk5NTQuaHRtbA0KDQotY2sNCg0K
DQo=

