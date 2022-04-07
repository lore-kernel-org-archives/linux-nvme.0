Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EC3C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 20:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6heeagSvh9q4Eu57QIC+7K0KCWJxZ5ecPF+27QZLJg=; b=U6Cds+eQvOMFPGARpC36nHXZoR
	UwslAufK4ctoQl3Czh9PoOauqt5QbeZKILebZ/8R4VqJXEkd8PY30cspgb4jBZmtHQf6N0HTTd3gD
	tj7PWDQRpp2oHoT49dlBEotAZ5RBBTurJII9Ip48nIP21ipO5FIsjr21KQBJL5CGenNLNULH4EFI/
	euCTfLlU8/8wTR/kiBKIgV2GA5E/St2whg7Poq/U53siA9XKZdsw6wg8WgNYrmhmLdVhPf+9FNR1e
	tn+7Qcyg/6AJQCqL6QP4/coKQrOIwjb/ClBcZompTNDbOozQJ2Of6TfkHIWzWANcCpAMQ5a1C8/Mo
	xGlJ7f7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncYT2-00Dp9c-K4; Thu, 07 Apr 2022 20:10:56 +0000
Received: from mail-dm6nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncYSy-00Dp93-L9
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 20:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neZcAy3nzbUktgSZ0446wvqAhL/WyS2mOM/T4Ym7gtOdbeiLnOSV4xfedr0AVIlmE2l8QTfJ6RJvQf0Dw6DXSI5wGyIdxU6MpexSNW7JillaIkUz9A7rUVIVq9skqoMrtpT+5g/85gbAzsg1LmX1Ru0Eyh6m8+CKZzGOwJyqYJoihjUGZP/Ha3gSoDOFwctRd4vi306MJ75GDzC6C9NGLotnsigbjGzdQ/5ZDicZ8jpXcvLDcdUXubBFFLYJanv+9/BFiZMERlM2BlOjCAo0bn0HeVabn3+VOzyNgQN1AkG7EuLFBvMik0y1t4/K2U498K1SeMAS11mMMF7uRFBRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6heeagSvh9q4Eu57QIC+7K0KCWJxZ5ecPF+27QZLJg=;
 b=Ad/wehVtkLxTfhsNbfpSrlJ4M966W5eSpwoeKLF6Ivn5N5bZbyMopuLLXEfNJesib6oslCBjX/pMU/LMxvOkYUrc6gWy8GEBXQACSv9XOgmBMh/7/9BZ2mxfVqT4s3XL2A+/FhSn6UEun6DzTV8h05lxky41zbryQkizkg5gP9lx61LVv7sBBB16H3biExcHJUZHiqvvMioCBPwGqKwRGBi/rkXu2AWAHNW9iCEyO3eKlkfCFcXCPglR1h6kQLpjfW4nyTVX65AGj5RJ+3CnvOlpeqJfVS4zUO2Xz+KexV/++BQoJJIUI3I0kJYqKLHycWSPDxIMajenYQtNjV1Y3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6heeagSvh9q4Eu57QIC+7K0KCWJxZ5ecPF+27QZLJg=;
 b=dCO2LPSF/9apIc1S/6qgKJAxmtS2Ys2uKnuDVDTpT07UiIXTV7kJ9ahbdoiBm6eklKgwQIAQhqDaoDFlt7UKi2tPan2p1YuTZnh3Pg0quZPcyX3EEY7hD1FgSInMZL+UFvJGg+EnobR761Z6G8BtP3nImIitVxY6Aj+obvaB7AGQ43MNgFZoKCJdULld7k0WfkCGiPivJjbkBpgVgPdZNrFcU6RorKhETRaA4XO9g1Bf+ZDvSXjRvO/GOf+tbRYKWn+y66Fen9QkR7rNKa1tdG//ASIpxDFrmf8yBbcTXTBZnqpA/HMxJojd+Fg99w5lcW6rhLX0S6R4geEeF6Bztg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN6PR12MB2608.namprd12.prod.outlook.com (2603:10b6:805:68::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 20:10:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 20:10:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Alan Adamson <alan.adamson@oracle.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUmD3brgDUei0iedZF8Ixk0L6zjGb6AgAAClgCAAAWlAIAAT2MAgAC0PoCAADK+AIAAiyCA
Date: Thu, 7 Apr 2022 20:10:48 +0000
Message-ID: <4386789d-6722-add8-5b42-f605e48e894b@nvidia.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
 <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
In-Reply-To: <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69512430-74c2-4e17-3233-08da18d2b4fc
x-ms-traffictypediagnostic: SN6PR12MB2608:EE_
x-microsoft-antispam-prvs: <SN6PR12MB2608E23988C04799E92A3988A3E69@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mw+zH06D3Vll11d/4p3k5BlHdiB5WWJcg1efQUBkHgHwZBa/wFDtN43J9bnNSHI/ZU6yYQ6gVcWRUNIazhKVPoXlEFG7FtdsHdBp0a6ehRYmErLQWgPotjdF9BNS/Ke6lAq5UnjY6pGPKc/dx3ovXta+otEAFERJseOi9hCUUutyevTLhyHbRe4OIQS3UzHQWUPSd5rPbdiqVG27JQntHdJ6zAc0HCQS9PGuLrNdbJr+9PAFzZQhI+fpjcliQfL9bgw0DIRVQFsVUE+vM0LgVdn7fDlnFuIFT0Y1FBF1/1KGUGCOkkcqJqc17ArJbbeR2e1rr7fr452NeGksUxvLcMPl59aWBEajnlstAFoylbIy/ZrAgET+GYlQFFjAPGqaaRHL+xbOoBK8r8zf+pu0R+KTr6gsO/xjqHdxl69gEQSqbTFsFGSUdtUdW+JlCEJz4u+HQiLG+XjsMzH33QP3WCJHx8UybS1pDBYIXWmOQT+0SsKzov3euprwpWwpJW/3yk9r0/5dY6lCPiXR1jF4Ba8wHqU3oG2Vf7e4zntXgHqQwwa0Ksto3vTQbdXHIl4ESLIySvKaCVTiQgym6kA3WD9uJhhY9LnvZVTbQN9/Li0FhNbYCr/WYrzvI8lqCO24pNLbhwQTBZPEJQhyplMU+KgJbdgzN+s6OqXCtZQ/Qu4DLX8vGIBSIY+irTXX3sSSrNCD9FfFwidMNyR0TcNVHH8eEf/nH//6sqnlDwMQfYP8kRJKh2zow6y0OnPTURcYf+YHjJXlyhv+KC5A0HJLf7rtAy/9PTdKzHVt+Wxkqa+Yp+vGSP4rE9CxsVCKXYPdn+9H4fO0MNs8deoKSz9BcN3rlsWM8ul/tvsSqnLhXn2CLm1Y0cAxtz0FK7iiHft2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(91956017)(66446008)(76116006)(66556008)(66946007)(8676002)(66476007)(4326008)(71200400001)(966005)(122000001)(86362001)(508600001)(6506007)(53546011)(83380400001)(6486002)(2616005)(31696002)(5660300002)(8936002)(64756008)(186003)(2906002)(6512007)(38100700002)(4744005)(38070700005)(54906003)(316002)(31686004)(110136005)(36756003)(533714002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDQxNE9Qekl3NzI1dGZRUjBZeE5iN3BtdEF1NjYvbWs1cmg0Tnp1YUswdlFU?=
 =?utf-8?B?MU0wZ1ZMV1FFS1A2M2pWS0ZMSFlLdHErTjBSOGplajk0RzZvWlp0RWpYZ0sv?=
 =?utf-8?B?dkFiNUJEeENnbDA4SSt3Y24zeWptRU1mdjF4NWs5L0JJYnBJQXhIekYxOFZ6?=
 =?utf-8?B?Y25BU2Z5ajU2UVJLRzNSb2hURzZleFFaT0NvRDZqU3pGZW5QUkJPM2lEWHZ4?=
 =?utf-8?B?R2o3WFoyOUNDOUVkZTFPL0xFOFdUb2lpenRQRkFEVDV2aUhETTFMeUNLTjJB?=
 =?utf-8?B?N2FBcDMzaFZieUdPVGMxN0hGWU1tSVlPZTNPRzEvc3RKQ1ZBVTl6UTNvakU2?=
 =?utf-8?B?d3Z6VVg5ZnREdFczYTljb3lJY1hXblNOc0hUM0NrcHo5SHpLQWRuWVlUUUNr?=
 =?utf-8?B?d2QvSVF6VTNyeGVuMVY5djRDMDN1SjZvSlZLMEs0R0x4SlFRRU9TN3F2ZXZF?=
 =?utf-8?B?Ym5pK3pzWWozZW80K09aMEdVek9IaHVvSWZPejQxTWVKWGdjRVNrekozbENK?=
 =?utf-8?B?eW9pVG1sMUVlYU5EMnd0U0h0cUZLb1pzckNtb1FDakNiUlBpWUNlUzBUYW1S?=
 =?utf-8?B?STUyOWM1THVlczVGS0hIYml2cWt6K0syU2xsS09hendWM1R5TkNSeTlWUTFY?=
 =?utf-8?B?YUhhbzJ5WkZrOFAydXpGbDgvdWI2OFh3NldMbjU5VmtoWGQ0ejZSVlpvQ0RN?=
 =?utf-8?B?TlJXdmE3ZExuZlcvUjRUbUpiK3NqYkRQaEpGaW85UEtwblZYd0o3WnpVdmJ2?=
 =?utf-8?B?WXNOcDBxd3V2MTV2a05SYWFvU0t3SmNUYkZ2R3NneWV3KzgrMUVFUHN4U2VO?=
 =?utf-8?B?QmxRS1M3UnY1QXUwdFhSQ3p6S3FYbEh3bFRGZmRNekpzN1VXQ0xMM2VXZ2ox?=
 =?utf-8?B?SEtUY1F4Y3RTLzFQTE1RNFlYYzlobS9VQTVqVkpVZEJZMS8rd3V4UlZsVzgr?=
 =?utf-8?B?RXFQMzZKZXZKVUMrREoyOEpqUnAwbzJSYS8wNXI1ZlVDaVdWbms4RDFuU3hp?=
 =?utf-8?B?Zi84bStTcmpNRWpQbmp2V0hxb2gxWHRYK0svVDEzNUg3RzU5Yk8wUDlWUjRG?=
 =?utf-8?B?QStqSWx2TTBwN3lpdlJZQnNPa09VdmR3Z25QbjFjN1c4Y05GZnkwRi9idkVM?=
 =?utf-8?B?NzdOamF5QkZTdGpwV2lWSDVPM1ZSZk9mTEhxZEhodFQwWkh4NVo4a3F5dTZw?=
 =?utf-8?B?dGVsSEZuK2dPY3NNcGc5TFBaVnlXbmRGcmVIUEVnRCtLNHZEbzdxVFB0ZWFD?=
 =?utf-8?B?MklCKzh2RitOZHpmVkFJZ0RJYjJrU3JORWV6NzZaRWlXejJsODJZUWovdnRh?=
 =?utf-8?B?OHROY0ZoZ2Zqek9WckNLN0xXN285MHcwL01YbktQUlJ3ZkwvTFVHUVZFMkJq?=
 =?utf-8?B?cGFUcHJTTVVGYk83R29yQ2piTjcwdlpCamVHTzlxZWFtQVdJRmpPM0NzM3c4?=
 =?utf-8?B?alNmRlQ2N0lPcFFpUzRNZ2NYR1pnTVFwTldvbmpVdVFJMG5KUDdSeEdrekRI?=
 =?utf-8?B?d1dtbmNJcEtmWnR5S2ZuOXRzaXAwRHZDakZwWUZicVlQOGlIK0RUR3YyY1hZ?=
 =?utf-8?B?T1RkU2hSZzIxQlJGazNCalFUOENPR3dTaUdnV0dqOVh4SEhVdmFaVlNQY0RF?=
 =?utf-8?B?U0Z6SVhKdlZTV0JKMElERzBOSU53aFhjdVMxRFpaZkplbkg5Wi9JUkFrV01i?=
 =?utf-8?B?QmxpWjJCdkFoRGhNaG8xTzB0cWVuYU4xR0p0RS9uclVTcEFjQWoxdFN2MVgy?=
 =?utf-8?B?WjlzTnNhMFI0b1JUYUQwTTR2K1c4RUlqc28xdTZtTkp0V0Z1TFBidFFpd3Rk?=
 =?utf-8?B?RDQyeHRLTTQvai9PT2JSSENWcERpNmpBYUY1ZmZsMTA4c3AxcnNCNHRFc21S?=
 =?utf-8?B?ZDk3b1BwUW9UR2VSRjcvTjRtb2kyelJlUFVab01rWEh6dnF2VTlURDdSNkE5?=
 =?utf-8?B?SXYrdUhhR3B2b3VOejllMzFqaStuMUozMUFLS0Noc0tRMXprRExWbmRDZ3dK?=
 =?utf-8?B?Y0t6Mk9PYTVjREhaODVUWHltaFh5cWJ5YklsODliRW9zVjZrRkd2TEZyVzNl?=
 =?utf-8?B?SENkUzNaRWZUaGV3QWExTDZCdW5SY0ZvbzRkNGpudm1nZTVDanJJZUMxa1ls?=
 =?utf-8?B?WXRNakNaUEpHTm4xTXF1UGsxYW9EUGxWQmxSR1FvS1M2OHl4cU9HL21EdnN0?=
 =?utf-8?B?Q3JGeW1Rb3FmNlRiUlFCUTdvQm1NNERjK1IwMFVJUHVNL1lremVNZzBxdFhJ?=
 =?utf-8?B?eGUxYmE4c3pYbWRlb1ZvTGNlcHhOWXBCaEVQV2N6Sk1taEFYalVIMi9HZFFU?=
 =?utf-8?B?OU5Ya2wzQU5jdmozdTVaVFBUVUd3YTl2Z2JTQmtZanJMTmVGMHJjcmFZd2dn?=
 =?utf-8?Q?Lm/I/sYXAGDMC4sEMNvqZRWo1TB8Bi+mX2BuYyA+nngwj?=
x-ms-exchange-antispam-messagedata-1: 3yv/bzRIrBrmGA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AE26BCD95D9A940AE27C2B0F1773E66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69512430-74c2-4e17-3233-08da18d2b4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 20:10:48.3565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1B72bcMEHc9BH6Ds2XurtHnOZgdnGOMK/uE/ZsFwx76GcHGBGkvXEZNohyL39Dul5ufE18zJrqWfjwr2xn+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_131053_036167_5845DC5E 
X-CRM114-Status: GOOD (  10.09  )
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

T24gNC83LzIyIDA0OjUyLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiANCj4+PiBVc2luZyBSUUZf
UVVJRVQgb3IgYmxrX3JxX2lzX3Bhc3NyaHJvdWdoKCkgd2lsbCBtZWFuIG5vIG52bWUgDQo+Pj4g
YWRtaW4tcGFzc3RocnUgY29tbWFuZCB3aWxsIGxvZyBhbiBlcnJvci4NCj4+PiBJIHJhbiBpbnRv
IHRoaXMgdXNpbmcgdGhlIGJsa3Rlc3RzIEnigJltIGNvZGluZyB1cCBmb3IgdmVyYm9zZSBlcnJv
cnMuICANCj4+PiBJcyB0aGlzIHRoZSBiZWhhdmlvciB3ZSB3YW50Pw0KPj4NCj4+IFdlbGwsIHlv
dSBzdWJtaXR0ZWQgdGhlIGxvZ2dpbmcgc28gd2UncmUgY3VyaW91cyBhYm91dCB5b3VyIHVzZSBj
YXNlLg0KPj4gU0NTSSBza2lwcyBsb2dnaW5nIGVycm9ycyBmb3IgaW50ZXJuYWxseSBzdWJtaXR0
ZWQgY29tbWFuZHMsIGJ1dCBub3QgZm9yDQo+PiB1c2Vyc3BhY2UgcGFzc3Rocm91Z2guwqAgU28g
d2UgY291bGQgbW92ZSB0aGUgUlFGX1FVSUVUIGludG8NCj4+IF9fbnZtZV9zdWJtaXRfc3luY19j
bWQgLyBudm1lX2tlZXBfYWxpdmVfd29yayAvIG52bWVfdGltZW91dCAvIGV0Yy4NCj4+DQo+IA0K
PiBNYWtlcyBzZW5zZSB0byBtZQ0KDQpUaGlzIHdhcyBteSBpbml0aWFsIHByb3Bvc2FsIHRvIGZp
eCB0aGUgY2FsbCBzaXRlcyB3aXRoIGludGVybmFsDQpwYXNzdGhydSBjb21tYW5kcyBbMV0sIHNv
IHRoaXMgc2hvdWxkIHdvcmsuDQoNCi1jaw0KDQpbMV0NCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL3BpcGVybWFpbC9saW51eC1udm1lLzIwMjItQXByaWwvMDMxMTYwLmh0bWwNCg0KDQo=

