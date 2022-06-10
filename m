Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F301BCCA483
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hSRcRJkM6ag8lp+Q6GfOqLgIXg1a8FRmmAqi31PhmA=; b=Ryqhi3kpO503FEFRZS6QpHkEiZ
	wB4UB1bbigiGh4AWOS7SJnnGBStHE2XgZvdIHWpm0wCsN3wnuL/ZZxoS6Ms71BJchiYFdObqk4FsT
	fghp6MS/f5qlZCJq5GIpslit8YZNibTiR8jf7kO0EhU2wWmkrBghmX8n2WDFpDUXCYkL+Qsh4gXma
	hUDbtM0w/uINDdgERhljOt1yraEiPFIYFntnISVOWES3o/k5R96qU5mP7HWvxGCO8cRDkBZhc2xjU
	X98DzSMHJR4fo2wK3yYAO05EH0qFWR1Gz+9yVF8JrMU06YGbMmKBtZjkC9QmRYvS0Y0ICf/WN7LQc
	IpvCt/lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzaaw-0070ai-GU; Fri, 10 Jun 2022 09:06:18 +0000
Received: from mail-bn8nam11on20618.outbound.protection.outlook.com ([2a01:111:f400:7eae::618] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzaat-0070Yx-CH
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 09:06:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMnkBZNecKZjVl6tIHr4rCEeKoOFgkySO0BUDVPaFp8O/5Amv+FY0VGuLC1sfyS0qkhQ2jcU6+5LX6jx+wmpfk/z7M6v4eG8NmSurGfaTAuxkpasFrm4wrXmLO55qps8wr6pIJL4zhXBovWr9boOpFBq9jZLnwO0BQmPxh8vqSkl0FKQYbckDYmo2h+Abw63C+ZrF7614UglA1/pPEWFFxwbtYiymufwVvJoa9jzEg4Z58yEpRjJ7eBw30+eJXj7B9OYB0lFn95eQpE+GopKSlu8VtczbcdR/mpWSG8fZ31SUxx65SGe29Pn2UR5NRGh99jzkvlu9tCfggGaXXOZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hSRcRJkM6ag8lp+Q6GfOqLgIXg1a8FRmmAqi31PhmA=;
 b=oO2t9dAZKIUegICda5IKvf8wX9LJ406PVyA9iZHW8++I6iPmRO0/6i/1JMpQCev3pTiT74/dUB9T+JdtoukIst17SdQjsAubpYWzGV58Ytwr6c3NV5O0tE27Dx2q2t0Kqdlfgu6kg5ffoOze8WjIuAfkZItidSpK5wMu1U2ztAY+kx3taTaenrLbNByjeIIPnyowqtyWX+CTJaPYDo0T3Vr6+sGWfhbTfvcoYGZH8Ddg/yjuPcpd/0Qmy+bNs1ALJTrtVNorcwSFkVTQBLTCJY4KQIS3Zb7LwTsfSC7fV373kDiXsdqFh4mprdRUXbYHTbkrUAqeXbZNkO7qGpuSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hSRcRJkM6ag8lp+Q6GfOqLgIXg1a8FRmmAqi31PhmA=;
 b=ioVnoOmEFirl8do1YWvSopnbsdB+p77Piheia99w2UeBVenAANfoH14gqxwPZcF2bSix2i7SwLfPP1grX3kRd5NZOTN/lA8LyUnK4i6hnVmj0HJKm49WVjRHXWx06PX+0HKz6k0yIB8PpoZWNQ+trY+O8Ebs5ijKNo0SoAOSrgbzt8W+WrbT1WI3rcAh+lAVbOXL3H0AQ21FrXImrQHBMFTuVgNeDIo4+ECn75o0GFMgzEWzCRCgFnlKZXtGXABszMjpg/brf306kb1Hhs6VjApZy8WcK0S5qa3hnX9sGUPn7zP3qrEah5RHQE29fLsNlneA4I3DoNnZltHJRZJTZA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Fri, 10 Jun
 2022 09:06:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Fri, 10 Jun 2022
 09:06:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv14 00/11] nvme: In-band authentication support
Thread-Topic: [PATCHv14 00/11] nvme: In-band authentication support
Thread-Index: AQHYe0aSk0irjXINo0eCGJTZzeAdv61GRZ6AgABSZ4CAAAOUgIABwIAA
Date: Fri, 10 Jun 2022 09:06:10 +0000
Message-ID: <1951ac91-edf7-815f-bd16-271cb7911e1b@nvidia.com>
References: <20220608144518.67607-1-hare@suse.de>
 <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
 <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
 <55751e76-de76-59e1-541a-6f4c93acc378@suse.de>
In-Reply-To: <55751e76-de76-59e1-541a-6f4c93acc378@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdec6107-7bd8-4fa0-cdca-08da4ac0768c
x-ms-traffictypediagnostic: CY5PR12MB6059:EE_
x-microsoft-antispam-prvs:  <CY5PR12MB6059185D38E1B7514AA4AEF2A3A69@CY5PR12MB6059.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  DLjL0oGlwW6Q2S8TGhFnqfCE5YT7ws69fLOartUsU923hrKWLHu0bhSo9cYJm9e2hheQKLhnFUgEqHmg8Omx1idvS5xBwz+rgUqqL0lxiqsz7Ox+BOOewniSmVFivGbQgHa0RuPDIfY9orh9MAthJkJsUapXktrcSak0PHXI7B3volAGm1aMGqBhwtZdK8RM1B51X7OPyPI0zcTa8XUxBHdYqWZyj2Az60gnbyzPKa6Pue7k7T7beBPTS6flLPjPVTAxjPamozJ9zmgSZ8VyTRe4T0FgmqAjbyKZRFZciLuHaEBQIem2TOcKzFX5VBoaTrRedBfrmURBKKkcIYWK0Slz1EHY1AUapEmGzfBetPMd4LAxtBhMRX/UGLDmc06aIliAvhTon/3GS2PoQy/KBrL+BhpDgpHjvYnPDcDdjoP/MTiuyS+GoJ8HOn2LaLr1VooJC7DfbIRhHcU5N+Iv0nhjKrEMwRE8NvAOuCiUajTBvEckbYwn/ClRSUA6HGv8X3VAGEdYqbMtJIh+b3/I2j3qkF/24/+K/YevC5kwJXBC4QrskpssuhXsbgEukD0b7NDkGRvIDrrSiVUAzA+o9loYoWAjVtO9oBKaTcIWF22NT8pIshA6dKtel4eaIdfVOBJJpAM60PXYq2jVceF7qJBpIqURgcclmRbsI/+mHagBSHh0cwWubPyP2M6SmKLS12eWfpXQHyvtQu9x3mwr0VFrTW7BvZqbT4MvyupbGil6hQ+EaRGJJus53wt6iOFKtQ2NTI+YRSQ1WARIeStDig==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(2616005)(66946007)(66476007)(6916009)(4326008)(36756003)(6486002)(38070700005)(31696002)(186003)(38100700002)(76116006)(66446008)(5660300002)(66556008)(2906002)(8676002)(71200400001)(8936002)(86362001)(83380400001)(6512007)(26005)(122000001)(53546011)(6506007)(31686004)(64756008)(508600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WjcyNWUvb0RmSkxEcWhGdUluOXBNSCs5TDVuYjhSUGJnclE5c3FVdkd0aDU4?=
 =?utf-8?B?ZlJjT1ZGdWhRRlI5aWlwbG1heWJDN2xRKzVZYmNVRGJyTmZMYW4yQWhzUXg5?=
 =?utf-8?B?aVNhWEo1QzBzUGZWbnhOeHRxVHBvL0gxUHJnNWNvclZKdmlBZXBSRG96THI1?=
 =?utf-8?B?d2dIa00rMHl5Z2hnVVBmQm8wdDg4b2ozdkp2Qi9XaTE0cE1rRnNvYm1jRVFr?=
 =?utf-8?B?NzE2akRyYUtrb3kwTUd1bXUvLzBNelF3Njd4UUtEdzVldkZxVTNDa3FyT0Ji?=
 =?utf-8?B?ci9jbjMvTysyTHBPQVd4UXN3R1lkSGRjNVN3SVlXZmRPS2RJWXdjWlpzcTNR?=
 =?utf-8?B?VVZYTXI2cTFoNzUwOG12MXRvODRNcWRTRU52OWFXOXA4R2lTc2p2dW81ekN2?=
 =?utf-8?B?VGYwaVFlcjdudTFOTWp5ZDRmWldUQmhEcURjUjM3UkFJaFl5TktqNGtTVGRG?=
 =?utf-8?B?aFZzRFdUaTgweC9lQW1QOHVpUzl0REhQS1BYZ3pYR2RSK3IvV3lPTkpJUFhU?=
 =?utf-8?B?eVVPNWhkdkJ5QVJ0ayt5bC9FQUlwNEdFN01uMWtXbmJmMWVHTzJnY205UGNo?=
 =?utf-8?B?VFNrcXVYbm1ZWEVsczYwcUpEeU1LRmlMUkNyVnBSUldkKzl6N2VyQ0hKYjAz?=
 =?utf-8?B?Y1M3RTltNTg1Z0pnRHRycVpCV002YTNIV0hUOTdrMkZ2TFlnQkFLVFhBU3JP?=
 =?utf-8?B?QWRkeTlEcmRuM01PcHNvOCtkRWtyWHJMWVcrbUpNRDRHNjVqN01lY29yUHdr?=
 =?utf-8?B?ajQ1YnRwa1V6YlBaaDBMbGpvWFdBTmU0S2J3UHAzUWpvd3NmUzBtREUwT3J2?=
 =?utf-8?B?MGYxNGNJanF6bDM5amFleUQ5V0U0ZGw2bG9wLzkvdGg2eU9zdzVZdjZ6d3lU?=
 =?utf-8?B?VnRYZ0NjeWJENHJ1NGhQQWVBMzR4RC8xVERBaGFVT3BTNUNQVmNZSFV3WGlx?=
 =?utf-8?B?aVM2VmRoOVNpQ2UzaUJKMi9QZmpPbGVMTjlGTk1aVFY0Y0VLZi9yS3BJT25m?=
 =?utf-8?B?UFdiZG9LUFZUT2pNR3YwNFhnTmFubkVoSm1qQldzU1ZsTTV2TFY5RmYvanlJ?=
 =?utf-8?B?MXNZS2Jab1NJMzVYaXJrc3lsbi9TdFlZYStUUDJ0ZXR1Y0ZmenlvUDlCc2o1?=
 =?utf-8?B?QWNrZHhIZjlsNWl6ZitETlBWSVJvZlNueXIyQkR4TlU2MUIxWFM5b2kxcUhV?=
 =?utf-8?B?ZStablJyNVE1K1lXU2tHcWt5NFNiZnVwVDZmdkZTZ0g1M2ZJbVNRN0FhQURU?=
 =?utf-8?B?eE54dWNuUUo5NTdjM1UwS2RmcmdrZkl6VS91VmorbS9OU1c0TVV5MXNrTjBO?=
 =?utf-8?B?ZG1Dd1Q1OFAwK3ZHVjYyTExSYnNtNlh5QXhQUGNXYWhheXdHLzdxdjBFbnJs?=
 =?utf-8?B?ak8xZkxDNFBzY0N5ekswQkxSOVZuMDFPdnpqRHpjc0FldmRKbEMyYTAxTnNG?=
 =?utf-8?B?MWdMWnJJYTZWanh0bHVFb3RsMlhzdlZvOFJMMW9OWnl1dlA3YTAyVVF5dXdl?=
 =?utf-8?B?cW1QQ0dvalpkdWtWWVpFK05hdDZqM1BZRzVDanorVHVsNC9EWnlubkhqRVo1?=
 =?utf-8?B?ditIaXpGRzZEQTIrbTlLOVRuanc1ZXVSa2E2TVpmd3FUcnhVTlZwUWJ4TXJF?=
 =?utf-8?B?L1l6ODdENGdEWFRyZ2NJeklnaGNtMnhXYXBFR3B4L0VUdWpkNitoN1V5cFM1?=
 =?utf-8?B?cWk0dExRK2dLbWVQQ3B1Z0RMV2VZdXVoK3REMWhPNmJpQ0ZxUFltNGpxa0xj?=
 =?utf-8?B?K1hVU0xoSW9vVmVROUkxM1JvQTZxaW9UZ0t3LzMrbG5HVmhEa3pWZEpLa3BZ?=
 =?utf-8?B?dXJBNGxWbXhLVGZvbk1Cb2JPVFE4Q3ZFTVRpQU5CY2MxNUZ0WlFobEovbzRu?=
 =?utf-8?B?Ui95MVljOTlRckd4Q1NLQ1psdTNVc0Fzc1k2SERxZVExZUhmcmhxeExvVmhs?=
 =?utf-8?B?QTkzUVZVbnhqMkVCdDVnY0EvZHVvbTAzbVJWVjEwd21tTytKS3V6WTNzbUFV?=
 =?utf-8?B?QlFlaFlNVzMxN0hBZ2gwRFBZYnFSUkt2cjNKSWdFUVR2MmlsU0U3dG9QQko5?=
 =?utf-8?B?dzhMM1paVWx3RFpxTko1aUFId1lILytJYnp5MFhaY0pJMWlUQzN3MlNLQWd4?=
 =?utf-8?B?NGRSemRBT1gzMWVPcEpmbWdKWVlpRmlxcnZFS3dXVzk3MjVsT0xRZGVLQWE1?=
 =?utf-8?B?T3NyTXNLay9BUmxGdEdvUSt5YXJ3NlJoWVU4SS9qWXhhR3BweHNza1ZaaFVM?=
 =?utf-8?B?cnFhZzVIOXpsdGtlTnNNMnNpZmtOS0pncmdTTmJyZUFDK1lKaHJVQy9iQW1S?=
 =?utf-8?B?by9seFVpblIzNldqMmErM1Q5L3BYSG5IRGFWbTQ0cEFOMWhxRjJuZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45F025A956F7164AA7308E0582BE4EE2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdec6107-7bd8-4fa0-cdca-08da4ac0768c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:06:10.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTWLSPulClIO6B6ctNZ6GOVRrWCiFQvb3RQyJ6zMWAiVaJ+MBUZz+JoPBi9UFNHjcHkS4QjQONE+KqweY8yKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_020615_515714_52D3F413 
X-CRM114-Status: GOOD (  19.89  )
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

T24gNi84LzIyIDIzOjIwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IE9uIDYvOS8yMiAwODow
OCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPj4gT24gNi85LzIyIDAzOjEzLCBDaGFpdGFueWEg
S3Vsa2Fybmkgd3JvdGU6DQo+Pj4gT24gNi84LzIyIDA3OjQ1LCBIYW5uZXMgUmVpbmVja2Ugd3Jv
dGU6DQo+Pj4+IEhpIGFsbCwNCj4+Pj4NCj4+Pj4gcmVjZW50IHVwZGF0ZXMgdG8gdGhlIE5WTWUg
c3BlYyBoYXZlIGFkZGVkIGRlZmluaXRpb25zIGZvciBpbi1iYW5kDQo+Pj4+IGF1dGhlbnRpY2F0
aW9uLCBhbmQgc2VlaW5nIHRoYXQgaXQgcHJvdmlkZXMgc29tZSByZWFsIGJlbmVmaXQNCj4+Pj4g
ZXNwZWNpYWxseSBmb3IgTlZNZS1UQ1AgaGVyZSdzIGFuIGF0dGVtcHQgdG8gaW1wbGVtZW50IGl0
Lg0KPj4+Pg0KPj4+PiBUaGFua3MgdG8gTmljb2xhaSBTdGFuZ2UgdGhlIGNyeXB0byBESCBmcmFt
ZXdvcmsgaGFzIGJlZW4gdXBncmFkZWQNCj4+Pj4gdG8gcHJvdmlkZSB1cyB3aXRoIGEgRkZESEUg
aW1wbGVtZW50YXRpb247IEkndmUgdXBkYXRlZCB0aGUgcGF0Y2hzZXQNCj4+Pj4gdG8gdXNlIHRo
ZSBlcGhlbWVyYWwga2V5IGdlbmVyYXRpb24gcHJvdmlkZWQgdGhlcmUuDQo+Pj4+DQo+Pj4+IE5v
dGUgdGhhdCB0aGlzIGlzIGp1c3QgZm9yIGluLWJhbmQgYXV0aGVudGljYXRpb24uIFNlY3VyZQ0K
Pj4+PiBjb25jYXRlbmF0aW9uIChpZSBzdGFydGluZyBUTFMgd2l0aCB0aGUgbmVnb3RpYXRlZCBw
YXJhbWV0ZXJzKQ0KPj4+PiByZXF1aXJlcyBhIFRMUyBoYW5kc2hha2UsIHdoaWNoIHRoZSBpbi1r
ZXJuZWwgVExTIGltcGxlbWVudGF0aW9uDQo+Pj4+IGRvZXMgbm90IHByb3ZpZGUuIFRoaXMgaXMg
YmVpbmcgd29ya2VkIG9uIHdpdGggYSBkaWZmZXJlbnQgcGF0Y2hzZXQNCj4+Pj4gd2hpY2ggaXMg
c3RpbGwgV0lQLg0KPj4+Pg0KPj4+PiBUaGUgbnZtZS1jbGkgc3VwcG9ydCBoYXMgYWxyZWFkeSBi
ZWVuIG1lcmdlZDsgcGxlYXNlIHVzZSB0aGUgbGF0ZXN0DQo+Pj4+IG52bWUtY2xpIGdpdCByZXBv
c2l0b3J5IHRvIGJ1aWxkIHRoZSBtb3N0IHJlY2VudCB2ZXJzaW9uLg0KPj4+Pg0KPj4+PiBBIGNv
cHkgb2YgdGhpcyBwYXRjaHNldCBjYW4gYmUgZm91bmQgYXQNCj4+Pj4gZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2hhcmUvc2NzaS1kZXZlbA0KPj4+PiBicmFu
Y2ggYXV0aC52MTQNCj4+Pj4NCj4+Pj4gVGhlIHBhdGNoc2V0IGlzIGJlaW5nIGN1dCBhZ2FpbnN0
IHY1LjE4Lg0KPj4+Pg0KPj4+PiBBcyB1c3VhbCwgY29tbWVudHMgYW5kIHJldmlld3MgYXJlIHdl
bGNvbWUuDQo+Pj4+DQo+Pj4NCj4+Pg0KPj4+IGJsa3Rlc3RzIChtYXN0ZXIpICMgLi9jaGVjayBu
dm1lLzAzOQ0KPj4+IG52bWUvMDM5IChDcmVhdGUgYXV0aGVudGljYXRlZCBjb25uZWN0aW9ucynC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtmYWlsZWRdDQo+Pj4gwqDCoMKgwqDC
oCBydW50aW1lwqAgMS40MDBzwqAgLi4uwqAgMS43MDdzDQo+Pj4gwqDCoMKgwqDCoCAtLS0gdGVz
dHMvbnZtZS8wMzkub3V0wqDCoMKgIDIwMjItMDYtMDggMTg6MDk6MDYuMjM5OTMxNTI5IC0wNzAw
DQo+Pj4gwqDCoMKgwqDCoCArKysgL21udC9kYXRhL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvbnZt
ZS8wMzkub3V0LmJhZCAgICANCj4+PiAyMDIyLTA2LTA4DQo+Pj4gMTg6MDk6NDAuNTk2NjYzNjky
IC0wNzAwDQo+Pj4gwqDCoMKgwqDCoCBAQCAtMSw2ICsxLDcgQEANCj4+PiDCoMKgwqDCoMKgwqAg
UnVubmluZyBudm1lLzAzOQ0KPj4+IMKgwqDCoMKgwqAgK3Rlc3RzL252bWUvcmM6IGxpbmUgMjY5
OiBwcmludGY6IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQo+Pj4gwqDCoMKgwqDCoMKg
IFRlc3QgdW5hdXRoZW50aWNhdGVkIGNvbm5lY3Rpb24NCj4+PiDCoMKgwqDCoMKgIC1ubyBjb250
cm9sbGVyIGZvdW5kDQo+Pj4gwqDCoMKgwqDCoCArbm8gY29udHJvbGxlciBmb3VuZDogZmFpbGVk
IHRvIHdyaXRlIHRvIG52bWUtZmFicmljcyBkZXZpY2UNCj4+PiDCoMKgwqDCoMKgwqAgTlFOOmJs
a3Rlc3RzLXN1YnN5c3RlbS0xIGRpc2Nvbm5lY3RlZCAwIGNvbnRyb2xsZXIocykNCj4+PiDCoMKg
wqDCoMKgwqAgVGVzdCBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb24NCj4+PiDCoMKgwqDCoMKgIC4u
Lg0KPj4+IMKgwqDCoMKgwqAgKFJ1biAnZGlmZiAtdSB0ZXN0cy9udm1lLzAzOS5vdXQgPiANCj4+
PiAvbW50L2RhdGEvYmxrdGVzdHMvcmVzdWx0cy9ub2Rldi9udm1lLzAzOS5vdXQuYmFkJyB0byBz
ZWUgdGhlIGVudGlyZSANCj4+IGRpZmYpDQo+Pg0KPj4gSG1tLiBOb3Qgc3VyZSB3aGF0IGhhcyBo
YXBwZW5lZCBoZXJlLCBidXQgYWxsIGJsa3Rlc3RzIHdvcmtlZCBvbiBteSANCj4+IHRlc3RiZWQu
IEknbGwgYmUgcmVjaGVja2luZyB3aXRoIHRoZSBsYXRlc3QgbnZtZS1jbGkgYnVpbGQuDQo+Pg0K
Pj4gV2hpY2ggbnZtZS1jbGkgdmVyc2lvbiBkaWQgeW91IHVzZT8NCj4+DQo+IFJldGVzdGVkIHdp
dGggbGF0ZXN0IG52bWUtY2xpOg0KPiANCj4gIyBiYXNoIC4vY2hlY2sgdGVzdHMvbnZtZS8wMzkN
Cj4gbnZtZS8wMzkgKENyZWF0ZSBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zKcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW3Bhc3NlZF0NCj4gIMKgwqDCoCBydW50aW1lwqAgMS42
MjVzwqAgLi4uwqAgMS42NjdzDQo+ICMgYmFzaCAuL2NoZWNrIHRlc3RzL252bWUvMDQwDQo+IG52
bWUvMDQwIChUZXN0IGRoY2hhcCBrZXkgdHlwZXMgZm9yIGF1dGhlbnRpY2F0ZWQgY29ubmVjdGlv
bnMpIFtwYXNzZWRdDQo+ICDCoMKgwqAgcnVudGltZcKgIDEwLjQ5N3PCoCAuLi7CoCAxMC42NTdz
DQo+IA0KPiBTbyBub3Qgc3VyZSB3aGF0IGlzIGhhcHBlbmluZyBhdCB5b3VyIGVuZDsgdGhlICdp
bnZhbGlkIGFyZ3VtZW50JyBzZWVtcyANCj4gdG8gaW5kaWNhdGUgdGhhdCB0aGUgJ2Nvbm5lY3Qn
IGFyZ3VtZW50cyBhcmUgbm90IHVuZGVyc3Rvb2QuDQo+IE1heWJlIGEgbWlzc2luZyBjb25maWcg
b3B0aW9uIGR1cmluZyBrZXJuZWwgYnVpbGQ/DQo+IA0KDQpUaGlzIGlzIHRoZSBudm1lIGNvbmZp
ZyBJJ3ZlIDotDQoNCm52bWUgKG52bWUtNS4xOCkgIyBncmVwIE5WTUUgLmNvbmZpZw0KIyBOVk1F
IFN1cHBvcnQNCkNPTkZJR19OVk1FX0NPTU1PTj1tDQpDT05GSUdfTlZNRV9DT1JFPW0NCkNPTkZJ
R19CTEtfREVWX05WTUU9bQ0KQ09ORklHX05WTUVfTVVMVElQQVRIPXkNCkNPTkZJR19OVk1FX1ZF
UkJPU0VfRVJST1JTPXkNCkNPTkZJR19OVk1FX0hXTU9OPXkNCkNPTkZJR19OVk1FX0ZBQlJJQ1M9
bQ0KQ09ORklHX05WTUVfUkRNQT1tDQpDT05GSUdfTlZNRV9GQz1tDQpDT05GSUdfTlZNRV9UQ1A9
bQ0KQ09ORklHX05WTUVfQVVUSD15DQpDT05GSUdfTlZNRV9UQVJHRVQ9bQ0KQ09ORklHX05WTUVf
VEFSR0VUX1BBU1NUSFJVPXkNCkNPTkZJR19OVk1FX1RBUkdFVF9MT09QPW0NCkNPTkZJR19OVk1F
X1RBUkdFVF9SRE1BPW0NCkNPTkZJR19OVk1FX1RBUkdFVF9GQz1tDQpDT05GSUdfTlZNRV9UQVJH
RVRfRkNMT09QPW0NCkNPTkZJR19OVk1FX1RBUkdFVF9UQ1A9bQ0KQ09ORklHX05WTUVfVEFSR0VU
X0FVVEg9eQ0KIyBlbmQgb2YgTlZNRSBTdXBwb3J0DQpDT05GSUdfUlRDX05WTUVNPXkNCkNPTkZJ
R19OVk1FTT15DQpDT05GSUdfTlZNRU1fU1lTRlM9eQ0KIyBDT05GSUdfTlZNRU1fUk1FTSBpcyBu
b3Qgc2V0DQpudm1lIChudm1lLTUuMTgpICMgZ3JlcCBOVk1FIC5jb25maWcgfCBncmVwIEFVVEgN
CkNPTkZJR19OVk1FX0FVVEg9eQ0KQ09ORklHX05WTUVfVEFSR0VUX0FVVEg9eQ0KbnZtZSAobnZt
ZS01LjE4KSAjDQoNCg0KYWZ0ZXIgc29tZSBkZWJ1Z2dpbmcgSSBmb3VuZCB0aGlzIDotDQoNCiMg
Li9jaGVjayBudm1lLzAzOQ0KbnZtZS8wMzkgKENyZWF0ZSBhdXRoZW50aWNhdGVkIGNvbm5lY3Rp
b25zKSAgICAgICAgICAgICAgICAgIFtmYWlsZWRdDQogICAgIHJ1bnRpbWUgIDEuNjM2cyAgLi4u
ICAxLjY1NnMNCiAgICAgLS0tIHRlc3RzL252bWUvMDM5Lm91dAkyMDIyLTA2LTA4IDE4OjA5OjA2
LjIzOTkzMTUyOSAtMDcwMA0KICAgICArKysgL21udC9kYXRhL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9k
ZXYvbnZtZS8wMzkub3V0LmJhZAkyMDIyLTA2LTEwIA0KMDI6MDI6MDMuNzM0MzEwMTU1IC0wNzAw
DQogICAgIEBAIC0xLDYgKzEsNyBAQA0KICAgICAgUnVubmluZyBudm1lLzAzOQ0KICAgICArdGVz
dHMvbnZtZS9yYzogbGluZSAyNjk6IHByaW50Zjogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1l
bnQNCiAgICAgIFRlc3QgdW5hdXRoZW50aWNhdGVkIGNvbm5lY3Rpb24NCiAgICAgLW5vIGNvbnRy
b2xsZXIgZm91bmQNCiAgICAgK25vIGNvbnRyb2xsZXIgZm91bmQ6IGZhaWxlZCB0byB3cml0ZSB0
byBudm1lLWZhYnJpY3MgZGV2aWNlDQogICAgICBOUU46YmxrdGVzdHMtc3Vic3lzdGVtLTEgZGlz
Y29ubmVjdGVkIDAgY29udHJvbGxlcihzKQ0KICAgICAgVGVzdCBhdXRoZW50aWNhdGVkIGNvbm5l
Y3Rpb24NCiAgICAgLi4uDQogICAgIChSdW4gJ2RpZmYgLXUgdGVzdHMvbnZtZS8wMzkub3V0IA0K
L21udC9kYXRhL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvbnZtZS8wMzkub3V0LmJhZCcgdG8gc2Vl
IHRoZSBlbnRpcmUgZGlmZikNCg0KYmxrdGVzdHMgKG1hc3RlcikgIyBkbWVzZyAgLWMNCiAgIDgx
MC43NjUxMzVdIHJ1biBibGt0ZXN0cyBudm1lLzAzOSBhdCAyMDIyLTA2LTEwIDAyOjAzOjQyDQpb
ICA4MTAuNzk0ODI1XSBudm1ldDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMt
c3Vic3lzdGVtLTENClsgIDgxMC43OTUwOTRdIG52bWV0OiBudm1ldF9uc19lbmFibGVfc3RvcmUg
NTM1DQpbICA4MTAuNzk1MDk4XSBudm1ldDogbnZtZXRfbnNfZW5hYmxlIDU1NQ0KWyAgODEwLjc5
NTEwMF0gbnZtZXQ6IG52bWV0X25zX2VuYWJsZSA1NTkNClsgIDgxMC43OTUxMDFdIG52bWV0OiBu
dm1ldF9uc19lbmFibGUgNTY1DQpbICA4MTAuNzk1MTAyXSBudm1ldDogbnZtZXRfbnNfZW5hYmxl
IDU3Mw0KKlsgIDgxMC43OTUxMDhdIG52bWV0OiBmYWlsZWQgdG8gb3BlbiBmaWxlIC90bXAvYmxr
dGVzdC1uczEuaW1nOiAoLTIyKSowDQpbICA4MTAuNzk3MTQ2XSBudm1ldDogbnZtZXRfbnNfZW5h
YmxlIDYxMA0KWyAgODEwLjgwNTU0Ml0gbnZtZXQ6IGNyZWF0aW5nIG52bSBjb250cm9sbGVyIDEg
Zm9yIHN1YnN5c3RlbSANCmJsa3Rlc3RzLXN1YnN5c3RlbS0xIGZvciBOUU4gDQpucW4uMjAxNC0w
OC5vcmcubnZtZXhwcmVzczp1dWlkOmRiZGYxNGFjLWQ0ZTUtNGEzYy1iNTQ3LTNjMzk4OTk2NTBl
NyANCndpdGggREgtSE1BQy1DSEFQLg0KKlsgIDgxMC44MDU1NTZdIG52bWUgbnZtZTE6IHFpZCAw
OiBubyBrZXkqDQoqWyAgODEwLjgwNTU1OV0gbnZtZSBudm1lMTogcWlkIDA6IGF1dGhlbnRpY2F0
aW9uIHNldHVwIGZhaWxlZCoNClsgIDgxMC44MjQxNDVdIG52bWV0OiBjcmVhdGluZyBudm0gY29u
dHJvbGxlciAxIGZvciBzdWJzeXN0ZW0gDQpibGt0ZXN0cy1zdWJzeXN0ZW0tMSBmb3IgTlFOIA0K
bnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVpZDpkYmRmMTRhYy1kNGU1LTRhM2MtYjU0Ny0z
YzM5ODk5NjUwZTcgDQp3aXRoIERILUhNQUMtQ0hBUC4NClsgIDgxMC44MjQxNzRdIF9fbnZtZV9h
dXRoX3dvcmsgNzAxDQoqWyAgODEwLjgyOTA5NF0gbnZtZSBudm1lMTogcWlkIDA6IGF1dGhlbnRp
Y2F0ZWQgd2l0aCBoYXNoIGhtYWMoc2hhMjU2KSANCmRoZ3JvdXAgbnVsbCoNCipbICA4MTAuODI5
MTE1XSBudm1lIG52bWUxOiBxaWQgMDogYXV0aGVudGljYXRlZCoNCg0KDQoNCg0KPiBDaGVlcnMs
DQo+IA0KPiBIYW5uZXMNCg==

