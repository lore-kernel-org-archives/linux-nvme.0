Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D60FC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Dec 2023 05:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yx/1KN/7fnxPzWnGymrHrN/RMyp48NCcNhujEpXFJoQ=; b=LIU1e5yl334fHoyFfbbErzk3E/
	jbr9sNlDztJ6w0M7FZmLe+jxFEozLruaLnTdlw2CXSYq06/uBMVgm6qmL4uQVxhyALQSbiEfqFkNk
	gdmv1MGQIZ0dyJtwwgCWyhH3lUW+kpdZ1rambq1uk4sGi/QepXEx3rPlCYPG/9h1A3nwN99sLan41
	TPePQYYzDj79Qsu4KCLS7EpM48jsQGa0pXtyHlxVvG6g+N299pYAfrHY2CGHlewDmb2GGA6cAWQ8W
	dIC7OVNHc/ft7USWzc9etXr6/FveqUVfqMReQMadG3Cq8yBFnmy9mpQexxfhQAoomggZ/MoMsrNS1
	PSHlxTUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCvBx-00Amfw-2b;
	Tue, 12 Dec 2023 05:20:25 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCvBq-00AmfN-2X
	for linux-nvme@lists.infradead.org;
	Tue, 12 Dec 2023 05:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEB1wehs2KtRf7WTzPIYQEHqIkKrWB+he9xyaONR8MOaHH4aXaoh+b60TdQ9MI2WjEe0fURgwvymcsS0HMzilCERX4kSlEG58gB/EfY/44nlHocA5L0CTfB5mKkaae/yatHSkREgoG2HqrPBMlyHNRIT0CQKSU2rSiLKqO+DRZEDUvbtgtOYbz2sehdS9xChNugP9rTSJk6shIXZmZp+QDkltYlCSWkghFL1+RiSvqa2JimyoNJusHhQkG7m1rb7uwU6Hz6Sz9MMxbw03LasVcfo1UnhvVGN7nkwFJ7vmY/9cx7mTjg1j1ED7PRLVHm2DNZkTIh8o7gdU9GYZLC68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx/1KN/7fnxPzWnGymrHrN/RMyp48NCcNhujEpXFJoQ=;
 b=miJ7RTP5J0aAtkw+6/GjVp3rD0UiNdT29BqwAfoEeTT5H3BsFFFKj5QOVJDTY7xIU+3enGSN6E2p6vhRLB/gUoryVXSKsQgHOsZIxiyLheKSr63xvL7n+BkMsP2C+CNbLmJzo5Xnoqf0XgolT/XQDZXgh9JKsLaPWtpAbmi/jHxEXg++HzGbH9Ih2Frd+2M5kNvCl7upgw3HzbTRiSWSz/om2sH0mJ51GP7lcpXQhxM5N8ZMTf+HARCBlXargZmidO/467xDkYSCXljle3E4ucGDigZq9u4p5JRZw5Xk2XHRQK61lngSAd78lQbki6qbzF5YBvY2SLTwRrYDYWlfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx/1KN/7fnxPzWnGymrHrN/RMyp48NCcNhujEpXFJoQ=;
 b=g1KMJm8tXtomzUlUEA6S2EW9X/oMeQc5YH9wQvG6DTb3J1M0ANaeAxcKYvvEz0/ocK0g8EfuxcPX2zofL136PScFhy3ixLGRToCxDAn2d1cfaMftKA9he5S5C8P45aCwncBXaBcYeyoJagJXhuHwqNvA3jRMHo4hiTwZc+1LHek2JSg3oLHpO56fB3v3Eshn1+kOVmyeZfphrC3ItFQ/xICdVq09t0WzPSU2NdlxDpn0wOYTDrFuqBUIOQd4Kyclm5QH37Tkdzmgh/zQ2qOKWp1eT0GOZ3dnu7bzo5BPpdIrxAJw+93k3q0imkX0hEDGyn0GKbdizbUzf2OFdKZGFQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 05:20:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 05:20:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hare@kernel.org" <hare@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvmet: implement unique discovery NQN
Thread-Topic: [PATCH] nvmet: implement unique discovery NQN
Thread-Index: AQHaLAmh57OP/GgxJEOHkBa2RdLoeLClHagA
Date: Tue, 12 Dec 2023 05:20:06 +0000
Message-ID: <8aea5054-9acc-4123-be68-6c51f0ab206e@nvidia.com>
References: <20231211081033.14529-1-hare@kernel.org>
In-Reply-To: <20231211081033.14529-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7000:EE_
x-ms-office365-filtering-correlation-id: 736dc56c-61e8-492e-cc09-08dbfad200cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fRJ5nPEOGLHUCnflmf9RT4QpBkgZrJEE3yAyd1/hOL9vRTWpMXw7InXag7R0RtcG8s/jbCrRAm7sfSshKKr3xVfupmhANePsoG70SvukPKY6KexcWs2f55J53o5ocDNxKcu7iUDxuzixL8OQXsjuGhkIIIb2vQ9du+JCbyyDilopQrBiZXNAuFGXvef9D1Wd1K/YZc1eppPk5UHllVFRoXH4LhqAz2k60JjaO+i+eTYtFgCZCpvPXUGO+wOkRZH6drCy2e7wGVsg5IDt/yIaKDZnNWHIp8J5vI5nwGmwiQ+2g+1VXPziNoxXQ+p5s6Xs1r7zXR2VY8D8mKi85vI5kyohaQkqCGTaFrrVxiWZp+j12BrqQ9ii/NVonLLFJqHmvyBb/9Jfc312ujv4ouCMIfmnpLHCWN5OyHq5n0q4AgnnLkhvVr3GgSl4tYzVrVqlZz4glRC5s+skxCpEYlyZnz79XQrgGKnbCG+O8yOt09qYvyXBB6/7k/jEI8xiN8DuBZQw3D7lAg6sRZsbu1hkbo8EGDnoSFVurmPmYssgOY7fVG53H78pUkf34t2Ppwt4WF1UxEkmDk/3asQAnzKJ1HN3vSqs/OcppToLSHq5lsiBujlXzYECf28d2d/3wNgRoNse+vvROg6SBwh32Go09lQtDgITCmubANRYmpSAJsDAxIVb5NfjR27Aw5wiQ23J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(26005)(2616005)(122000001)(38100700002)(316002)(8676002)(8936002)(4326008)(6916009)(2906002)(5660300002)(6486002)(6506007)(53546011)(41300700001)(71200400001)(64756008)(66446008)(66476007)(66556008)(76116006)(91956017)(54906003)(66946007)(478600001)(36756003)(31696002)(86362001)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0Z1RmtMNWh1YjhUZkNqTkVpVUZxQkNhRmk1b1IrdktFVXRPdGFvZktxbzBG?=
 =?utf-8?B?R0hST0lxMkVpb3hFYmFiU0NMVytwRlg2a1pJM3VCZHN0UUxvbTVXSmpnY3BK?=
 =?utf-8?B?Q1NjQVdPZ3c5YUJFR1hYRW1sR2pzQ21tR2pKL0IzdktJaldsZGorcU1NcjYw?=
 =?utf-8?B?VWhOYjZ1Z0M5YjZlRUhjUDZERWZPUUkwSVgvVW03VkgwMUxYWjJYak85U0ZL?=
 =?utf-8?B?RUx5THl4YVVRekZqYXlKR2xEalpGd0gyK2JQaU5XUmMrTDd2OS9nbmxYbG9B?=
 =?utf-8?B?ZVNqTjgrdU1JMXNsWlhtZ0VRYU9HY3V1NVdpcmJ5RGVXUmZEckRFVlZCWlRu?=
 =?utf-8?B?NS9mOTUrRDQ3K1dNcmRMS2hFYWppR0ZKQnEzZllUQmM1Qm5ENXh3YjlkdThq?=
 =?utf-8?B?MXJtQzVEY0M0ZndFaXA5N0ZtQTBDRytRU3h3Y3huUnkrZ1BVbW1pYkl3eWsw?=
 =?utf-8?B?MXVLM21JTVF4bFZtYi9VLzhsU2VVLzRXOEVIdVRXU1dUeGUrWHd5UUo3bko4?=
 =?utf-8?B?ZHZmcm1tS1dKb0VydTFZZkpVNVd2dnJvNlEvQ3BuSXBvZ204d0hVWUkzVXRs?=
 =?utf-8?B?cVJqSldiZCs4QlVxaHpUMjNGa2tPT3VyUE9ReFF6V0pPNXhIaXQ0K3dtWTJU?=
 =?utf-8?B?OFFOZmpZOWJ1KzYyd0V1Q1ZRWG9YaUl4NzhvajJMMHRuam94bWdOUGRmRkMy?=
 =?utf-8?B?RlFBQ3hoWFYvQzgzRkQ3MEpMZFV4MjZtbUpWNURKUHRNMjBKRCthNzdxNEpi?=
 =?utf-8?B?TlQ3WFRKOW04K3dOampjWGVpL1dseVVRL0VFc1hhNnZOSmN3QXNzNTNJWktn?=
 =?utf-8?B?ZmZjZU9TU2ErS0lrK1hRS2hpemZibWxiVU01WnpBcTc3QmZXeGhuUnQzNU1I?=
 =?utf-8?B?MlA3L3NFeWx0SGVjTW8vWXM2cU51dUpkcVFncXVJL1B2SXRRK3B3dWFSMzhh?=
 =?utf-8?B?N2ZVN1hJWGhwMTNCRzl2L3RTVjl5ZGlIeVF1clp5TXUwU1VlMGpnS2QwOXp1?=
 =?utf-8?B?WjFSbUxGaWVlaERvQ0VBMUt2bTMwMEJ2anp1TjBneTNiQU84YXFqdWtsWHNB?=
 =?utf-8?B?QlI2Y1pXY2ZIZmlRdkVhTGsyZW5MZ1dxZUtuQmpNbUNFQUlmeS9VNGtmcVhw?=
 =?utf-8?B?N2daNmJBdzJhTzVrSy9qa2dydk5VSlVEK1dlYStxWjFPRXJOV3B3U2R2SWxv?=
 =?utf-8?B?MlNkZlFuRU9WS3JldWQvSnNwTlVtbGNwYngvREJZY1MxL3l0cjN6VnF3K1JW?=
 =?utf-8?B?Zkp0K1JNMWpZWDN1clFqM3kyYWZyejJKWWp0cHpGb21EcmU1MFcrSjRROW9U?=
 =?utf-8?B?UmppejcxVVMreXRHdG1sQ2lpZmY4eTBZbFpFSHZTYUNVMWJSWHJqUmlybWNq?=
 =?utf-8?B?eHY5cFVYRm5jV05ueC92ZTZORFQ1K0h0K3FoV21OVWRRdUlTYWkvcDBsd3RN?=
 =?utf-8?B?VjRoUElHaFBtb0lWWEJia0RlQlN3dlZzTVZDRUFqbXYxeUZadno0R1cyTmdx?=
 =?utf-8?B?aTU1cW5IV0s0cllyRkYxdXQ1RWdQWWVZM0J4Snd5dWhnVjN5N0o2UWRaUVdt?=
 =?utf-8?B?S0dVd1ZBVEx0Q1c5alljcUJzb010akRRMS9wR3VxOFVvYVJ1VytXbGVBQzhG?=
 =?utf-8?B?dGE4dkkwbk85MEVPOUJjcVFibTdpM25HbkI3RHVVbGxObEtPaXhUUG9rZjFx?=
 =?utf-8?B?a002M01IMEcrV1NrNXpXRWpnNkQwSWIvME9zUmV2bHhDQWlBRmllWnBoWUtT?=
 =?utf-8?B?WjJETEp5RTF0ZXlSS3BIeXJmYzIxc3JTRzEyRkFwaVJTTVR2ZTR0Z1Naam00?=
 =?utf-8?B?U0IrRUM3M0xxL1hMWEZzNGhWSnJWYUhZL01HVi94SmNjRHVXU0M1RDlLb1Uw?=
 =?utf-8?B?djhMcUhISXB0Zk1TSHZMQmZkSXNBVitlb3VvWldGUnV5NkRPWHcvU2hlYjJC?=
 =?utf-8?B?dFMrTThCS2gxYmJCaTlDWGFyU1RDVHlrMlNNd0t4ZzNMN1dRVERnSCtWdVBK?=
 =?utf-8?B?S3E5dURXeGFScTZZTGVJWGt0TDdscCt0SFJ2VVhSckN2VWNtb1haTEJYKzc0?=
 =?utf-8?B?d2N0aDAwNkZONXJFV3FtbGpyd1JkUTN4ZXE1MTk5bTdkcTVHQ2Yyc1ZMQmd5?=
 =?utf-8?Q?Ua8RQ8DQtInv3rAtDqFd9VV+z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C2BF0B8BFCB994EA9671D88EBCF9643@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736dc56c-61e8-492e-cc09-08dbfad200cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 05:20:06.6312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayx9aOXd+bI+ThLegImXTzoGjmHiloPyV5ZzalBfCM3W9uZyNkyIxsq97UNssGO3pm8tstKC+oKRIemK8qCPqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_212018_850162_1C7759DC 
X-CRM114-Status: GOOD (  19.39  )
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

T24gMTIvMTEvMjMgMDA6MTAsIGhhcmVAa2VybmVsLm9yZyB3cm90ZToNCj4gRnJvbTogSGFubmVz
IFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+DQo+IEFkZCBhIGNvbmZpZ2ZzIGF0dHJpYnV0ZSAn
ZGlzY292ZXJ5X25xbicgaW4gdGhlICdudm1ldCcgY29uZmlnZnMNCj4gZGlyZWN0b3J5IHRvIHNw
ZWNpZnkgdGhlIHVuaXF1ZSBkaXNjb3ZlcnkgTlFOLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5u
ZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL3Rhcmdl
dC9jb25maWdmcy5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
IGRyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jICAgICB8ICA3ICsrKysrKw0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
L3RhcmdldC9jb25maWdmcy5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb25maWdmcy5jDQo+IGlu
ZGV4IGQ5MzdmZTA1MTI5ZS4uODg5MTFkMGNkMDU3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252
bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb25maWdm
cy5jDQo+IEBAIC0xNTg3LDYgKzE1ODcsMTEgQEAgc3RhdGljIHN0cnVjdCBjb25maWdfZ3JvdXAg
Km52bWV0X3N1YnN5c19tYWtlKHN0cnVjdCBjb25maWdfZ3JvdXAgKmdyb3VwLA0KPiAgIAkJcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICAgCX0NCj4gICANCj4gKwlpZiAoc3lzZnNfc3RyZXEo
bmFtZSwgbnZtZXRfZGlzY19zdWJzeXMtPnN1YnN5c25xbikpIHsNCj4gKwkJcHJfZXJyKCJjYW4n
dCBjcmVhdGUgc3Vic3lzdGVtIHVzaW5nIHVuaXF1ZSBkaXNjb3ZlcnkgTlFOXG4iKTsNCj4gKwkJ
cmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICsJfQ0KPiArDQo+ICAgCXN1YnN5cyA9IG52bWV0
X3N1YnN5c19hbGxvYyhuYW1lLCBOVk1FX05RTl9OVk1FKTsNCj4gICAJaWYgKElTX0VSUihzdWJz
eXMpKQ0KPiAgIAkJcmV0dXJuIEVSUl9DQVNUKHN1YnN5cyk7DQo+IEBAIC0yMTMxLDcgKzIxMzYs
NDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjb25maWdfaXRlbV90eXBlIG52bWV0X2hvc3RzX3R5
cGUgPSB7DQo+ICAgDQo+ICAgc3RhdGljIHN0cnVjdCBjb25maWdfZ3JvdXAgbnZtZXRfaG9zdHNf
Z3JvdXA7DQo+ICAgDQo+ICtzdGF0aWMgc3NpemVfdCBudm1ldF9yb290X2Rpc2NvdmVyeV9ucW5f
c2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sDQo+ICsJCQkJCSAgICAgY2hhciAqcGFnZSkN
Cj4gK3sNCj4gKwlyZXR1cm4gc3ByaW50ZihwYWdlLCAiJXNcbiIsIG52bWV0X2Rpc2Nfc3Vic3lz
LT5zdWJzeXNucW4pOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3NpemVfdCBudm1ldF9yb290X2Rp
c2NvdmVyeV9ucW5fc3RvcmUoc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLA0KPiArCQljb25zdCBj
aGFyICpwYWdlLCBzaXplX3QgY291bnQpDQo+ICt7DQo+ICsJc2l6ZV90IGxlbjsNCj4gKwlzdHJ1
Y3QgbGlzdF9oZWFkICplbnRyeTsNCj4gKw0KPiArCWxlbiA9IHN0cmNzcG4ocGFnZSwgIlxuIik7
DQo+ICsJaWYgKCFsZW4gfHwgbGVuID4gTlZNRl9OUU5fRklFTERfTEVOIC0gMSkNCj4gKwkJcmV0
dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwlkb3duX3dyaXRlKCZudm1ldF9jb25maWdfc2VtKTsNCj4g
KwlsaXN0X2Zvcl9lYWNoKGVudHJ5LCAmbnZtZXRfc3Vic3lzdGVtc19ncm91cC5jZ19jaGlsZHJl
bikgew0KPiArCQlzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0gPSBjb250YWluZXJfb2YoZW50cnks
IHN0cnVjdCBjb25maWdfaXRlbSwgY2lfZW50cnkpOw0KPiArCQlpZiAoIXN0cm5jbXAoY29uZmln
X2l0ZW1fbmFtZShpdGVtKSwgcGFnZSwgbGVuKSkgew0KPiArCQkJcHJfZXJyKCJkdXBsaWNhdGUg
TlFOICVzXG4iLCBjb25maWdfaXRlbV9uYW1lKGl0ZW0pKTsNCj4gKwkJCXVwX3dyaXRlKCZudm1l
dF9jb25maWdfc2VtKTsNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQl9DQo+ICsJfQ0KPiAr
CW1lbXNldChudm1ldF9kaXNjX3N1YnN5cy0+c3Vic3lzbnFuLCAwLCBOVk1GX05RTl9GSUVMRF9M
RU4pOw0KPiArCW1lbWNweShudm1ldF9kaXNjX3N1YnN5cy0+c3Vic3lzbnFuLCBwYWdlLCBsZW4p
Ow0KPiArCXVwX3dyaXRlKCZudm1ldF9jb25maWdfc2VtKTsNCj4gKw0KPiArCXJldHVybiBsZW47
DQo+ICt9DQo+ICsNCj4NCg0KcGxlYXNlIGNvbnNpZGVyIHNvbWV0aGluZyBsaWtlIGZvbGxvd2lu
ZywgaXQgcmVtb3ZlcyBsb25nIGxpbmUNCnJlLXN0cnVjdHVyZXMgdGhlIGRlY2xhcmF0aW9uIHRv
dGFsbHkgdW50ZXN0ZWQgOi0NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29u
ZmlnZnMuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYw0KaW5kZXggODg5MTFkMGNk
MDU3Li4wNWQ2N2RkZmU4M2UgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZp
Z2ZzLmMNCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYw0KQEAgLTIxNDUsOCAr
MjE0NSw4IEBAIHN0YXRpYyBzc2l6ZV90IA0KbnZtZXRfcm9vdF9kaXNjb3ZlcnlfbnFuX3Nob3co
c3RydWN0IGNvbmZpZ19pdGVtICppdGVtLA0KIMKgc3RhdGljIHNzaXplX3QgbnZtZXRfcm9vdF9k
aXNjb3ZlcnlfbnFuX3N0b3JlKHN0cnVjdCBjb25maWdfaXRlbSAqaXRlbSwNCiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqcGFnZSwgc2l6ZV90IGNvdW50KQ0KIMKg
ew0KLcKgwqDCoMKgwqDCoCBzaXplX3QgbGVuOw0KIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBsaXN0
X2hlYWQgKmVudHJ5Ow0KK8KgwqDCoMKgwqDCoCBzaXplX3QgbGVuOw0KDQogwqDCoMKgwqDCoMKg
wqAgbGVuID0gc3RyY3NwbihwYWdlLCAiXG4iKTsNCiDCoMKgwqDCoMKgwqDCoCBpZiAoIWxlbiB8
fCBsZW4gPiBOVk1GX05RTl9GSUVMRF9MRU4gLSAxKQ0KQEAgLTIxNTQsNyArMjE1NCw5IEBAIHN0
YXRpYyBzc2l6ZV90IA0KbnZtZXRfcm9vdF9kaXNjb3ZlcnlfbnFuX3N0b3JlKHN0cnVjdCBjb25m
aWdfaXRlbSAqaXRlbSwNCg0KIMKgwqDCoMKgwqDCoMKgIGRvd25fd3JpdGUoJm52bWV0X2NvbmZp
Z19zZW0pOw0KIMKgwqDCoMKgwqDCoMKgIGxpc3RfZm9yX2VhY2goZW50cnksICZudm1ldF9zdWJz
eXN0ZW1zX2dyb3VwLmNnX2NoaWxkcmVuKSB7DQotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0gPSBjb250YWluZXJfb2YoZW50cnksIHN0cnVjdCAN
CmNvbmZpZ19pdGVtLCBjaV9lbnRyeSk7DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0gPQ0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbnRhaW5lcl9vZihlbnRyeSwgc3RydWN0IGNvbmZpZ19pdGVtLCBj
aV9lbnRyeSk7DQorDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghc3RybmNt
cChjb25maWdfaXRlbV9uYW1lKGl0ZW0pLCBwYWdlLCBsZW4pKSB7DQogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9lcnIoImR1cGxpY2F0ZSBOUU4gJXNc
biIsIA0KY29uZmlnX2l0ZW1fbmFtZShpdGVtKSk7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1cF93cml0ZSgmbnZtZXRfY29uZmlnX3NlbSk7DQoNCi1j
aw0KDQoNCg==

