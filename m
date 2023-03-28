Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BECC76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 06:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2QaGgVy+n7gtxhvIKs8XnvdrewymbPbIZFJlakTzoc=; b=Yj5b7y+3miEfktYj1nzbtXkIN0
	2VmdDEclvUTGDC7i1qyeKMD/AxHw+Fwh+OtqWocKnJlx9y3wvVKpSoParfDZGZ4Fbbwj17tk7HR9d
	WseqztXB43BKL81o0qB3x3FsZJkccQpwxVCToUHerx+0U7dSd0ele3Dgh/n/NTyicpmv10Fq90Lfg
	cWvFMb/CiC5q8KKKA7qFynL6JnFdJZCWZB18UP4SHglVFV4gwOIXpSVhK+wEF7wLd+SijX6p6dLKH
	OWKQ/azz6fsqL0T/yFF5Qspt4c9mFsk1DLUQIAnq9zUpa0VgVYnXTEXb6HRU180zjITQO485MlG5z
	6euGPoZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph2Z5-00DGWI-2J;
	Tue, 28 Mar 2023 06:12:15 +0000
Received: from mail-co1nam11on20605.outbound.protection.outlook.com ([2a01:111:f400:7eab::605] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph2Z3-00DGVA-1H
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 06:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOZ/fZq3rOd2lbf+E3Gpz+WF9uWxoOA5mJsuFAk5CMsNKvTDym39DhdSb8Rf1uIHvaZaVsJyeW7oZ8NeXQdxWyVAw5onVzFt+swFqEgpVd2rlWVOG+3G90ANh+q10BP9fDwgNldcTqxyanWcIoAAjcTvQbG7BWvGKnaBDfiqQdYuiCbywQdZVqLfKxVGMrAjSpDwSdJkGo1n3bStv2kpSiHSFDIBhuj3ibtHSlRetrDC+UtBPxbf/56H6X9wlnwOsISYnYBwHfdaEcePUU2P+cd2qbxJYM2b8iHblb0RBm6K5QxKe5A6decacfXSujG58gKUoH+rF6bbKpNgzH32sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2QaGgVy+n7gtxhvIKs8XnvdrewymbPbIZFJlakTzoc=;
 b=VE7ur9Xko2dRdzyekN28+dRj9xyQxnQ7FLZa0pmMgJ9VKAF5ZOIRmbwKaj8Z496FOqXkKfOPCeRUleTURjzcEATMpeBtLWrFkEfBjvKIfYE79V07Uut2tnf/5mR9EekWqPr8XJxOeOulZo/D7v3BewHQj23Q8waQTMXaGv1B2TJcLuTjhadJkK7qtIs7u3fn6EiBk+cPMdjEy9P1rulum+rYuZBTEZQYj4HfxmkVlsTL8vt7XaAuDyLkVRzM9xyzta5BP2oM+8gY7oNWwoeu2W5hAN12STfOGiEeVyoS455s8ESniWkuozU9YIt2hiRqfBrZKxD/7K0PTCm/C0oPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2QaGgVy+n7gtxhvIKs8XnvdrewymbPbIZFJlakTzoc=;
 b=oCGK/qG58UaGjkoPIU6HndtUbl/HfwINAQeY1E0cxlgyk/9uM6hUQHPXIGeC4DD63MltwDxSxcsbwEdvMsCx1XJ08s+VEypJiArGNYEzZ3j7BSzOEdjWLS1j6wXpNvOvOJXwat4iOxcvAdNjs9DjJL06POPyFH/xb+lCpQ3auZcM2ESXHU4dsXJF4glPmzZKdZHx/G/ZvDYtowQ3AMAe3QQyfGvCn+RD94DlZAGxXQLLWLgBZarXK4OCKh6RGDwbcCB9nm6UeSZJ0DkRtbdhSoskC6SUKsh/bisnHgGbMqlO7u2z7h6JAizhTIixgK6dzZ1/3Slg6O00c9ceQHd3uA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 06:12:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 06:12:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH V2 0/8] nvme-core: trivial cleanups
Thread-Topic: [PATCH V2 0/8] nvme-core: trivial cleanups
Thread-Index: AQHZYHIFC7Zkf4AvhEyJpOC6PBSeEK8Pt4gA
Date: Tue, 28 Mar 2023 06:12:02 +0000
Message-ID: <6db918d7-1ec0-6264-9389-5abeb30ef100@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
In-Reply-To: <20230327060418.86655-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5948:EE_
x-ms-office365-filtering-correlation-id: c0fc19fc-3055-4206-d0e8-08db2f535903
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  MuUauO8lOlEiF5IT+aLaY29CWUbc9p+GcnI4Oe7pFAYbLcpKJl/hBNqE2qGLsBNEtGwkoHkvg1OWIBP69kPyv1uG2ZmUTWKThXf5OVQOlbsmX5KPhowq53b7AwLOTZJz/mk5bbdyM3gQWRT2fG8b+7fwiPd6Ml9RUCe5rLlppv0MBYXi4iXsiIGQEYqlkVEjgbZdwFzeFw0k7Rfn1solfd2CyuTCxWIQ02z+rWsFGv2LTFdaLBge5COsAt8oJEPhUewvkBd9n58Q/HOQCdSUR02FfG0oGTG5taB7vhkvXX/bqN1ayHSka0G1wgaxHnnXNVmH2Dh+PEQzHqfpF/Bte8UrBvPVbgf21h+eOTIcNkQ0ylXAr6UGsQjbKPgXSrpgdEyuXwJlnysL6FmNSvCQdpRW9Q/ec+H1gpaX/d/I86XIaf5Y66M+tQoa9a3epdekKha0T2/TqRek4t50kZ7zXlsvZXEC51boty+8G1nVF9XEKbd+1FfSmxGeEUdWEE5nqyIfbp7qs4Jy9zn4UYORfoE7HTyo2sbgKuMR/66ThNhZArZTnUsvJKlg1dknvchk/G2zPocfX6aN1Y1mvA3U3HmQ3l+FaPiZ5b1jd04wxNP87vlpAHpOi9nwz3KrgzQ+yu3lB5o9/n73WBZMyHCFOutJp7uqEwav9DZjyHlYySMVopOe+7On29vkGiNbIq6v
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(91956017)(2616005)(83380400001)(8676002)(66946007)(66556008)(64756008)(2906002)(6512007)(4326008)(66476007)(6916009)(478600001)(76116006)(71200400001)(54906003)(316002)(186003)(38070700005)(53546011)(4744005)(6506007)(66446008)(86362001)(36756003)(41300700001)(31696002)(8936002)(122000001)(6486002)(5660300002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aWkzZ2J6WmlyK0YrU2tLeTB1bkNYeTdJUEk2WW5VL1JJV0s0WkU4RDdGMWxF?=
 =?utf-8?B?T3d4U0Z5ZWw1TERKd1dMTTBoRzY2L29BeWJ5K3VZeFprNDFWQnY0WW1zNEJ4?=
 =?utf-8?B?NDJCRjlBWStuc1NweGs2U0llOElSMEV0cjJ1dHZGL2MvSEVFcjYyU09TTHRY?=
 =?utf-8?B?NWJqUmlubWhrNXZ2dC9Sck5uWnhqQm5SaDM2RHMvMUR0dE1IRHQ3UnpHR1g4?=
 =?utf-8?B?ZCtrUWV6b3BSRUVnNWJaSEdMY2xyZWVSRXJvOFlaU0J1cUtRdGxhbDRwSFhj?=
 =?utf-8?B?ZDNDdXZCei9PYWRWZVRWWWJQcm1kT3dGY3BSaEl5Y0hlUU1VUklqSGk2MzVV?=
 =?utf-8?B?SDVub1NMbXpaRHpxR3E0VnRNbkJZbVNkdEZ1ZURSSHRvc0FwVS8vV1lCL1Nk?=
 =?utf-8?B?N2hLWXJ0eUh6RlRIU1VuaDFiblJESnV4VUtYV0loRTR4bWxCbG5XL0JyZ0xo?=
 =?utf-8?B?K2NSUzlVZFNmZHJGRTJPZzBtSzgvRTRPUGtRWXQ0UTNsY3ppMnJlbys4ZlJ3?=
 =?utf-8?B?NUxIME1LTnBnZHNpSGRUUGVwTlVmQjRKR3NWQzZPKzFRek0rSjBMMFN3bmtn?=
 =?utf-8?B?aGllSVZidy83T2RCUWFPRkZneHZJTnpVdHllQ1Bpdi93aUJ3dlMwY2RQdzY5?=
 =?utf-8?B?QWR0YnRJeXFMdTE5ai8rUnNYdmczajVJWXJlcDV4dCtnUEN6NWd4alR6Zzhl?=
 =?utf-8?B?cmk5NGFzWFg4ampyS1NwcGpXRU1lTDFyMnhmNms5S1AxNWhWYlZVN3laZWRI?=
 =?utf-8?B?L1pYSmhLdXVyQUxaNi84UWZEVWVDYzhJT0hrZXBReXlHOE5nZktRUDFHSlFL?=
 =?utf-8?B?RHg5MGlwQTJURWlaaWhDOFJ1bHVOR0MxSXNYUzkrTjJGMTZuZGRuNk5FdFlE?=
 =?utf-8?B?cGFRQ3FNVTRud2VONS9aS2pYK25xeTZ1L2REUjVvbTJRZlcvT3lQMElIYU5Z?=
 =?utf-8?B?Y3dKZGV4NS9sKytNTjVpZmtPVXRhalBTaVpjbDF3ZkdVcXlhSnd0NEQzYlpL?=
 =?utf-8?B?Rmhja0IyeEJvRGlPN2xhbkNCaUZTdWxWaXlBdnpseURoSm5oQURILzNhSm1V?=
 =?utf-8?B?VTlUMlBOUDl0dDhBd2ZReXZqV0lkRmN5TTRvWjliQU1kb1dNZC9xTG1hTVZZ?=
 =?utf-8?B?ZTYzd3J1Q2FlbDdxZldGOTY5bWw4Z2xBOHhrR244Qm4raitMTGlqblZ2VWRw?=
 =?utf-8?B?c1p4RURsWU1vZXBmN0dBM2hiYjcrZ0gzdTI2eXhBYThrSXluVWpKOXptQlVq?=
 =?utf-8?B?REpqTlFXbTg1d0l5VjBBM0ZjMnRJRSsvMXdHd3hmT1VwNm1oaWpzWDd1SFUy?=
 =?utf-8?B?eWxkUWJTTUd6QXNUM0owK1IrVmx6aUtHR21GNFh0TitvOFpqYVpOeWJFaXZX?=
 =?utf-8?B?S0xNbUlJU3pGaEQ3M2ZWaEtsb3R2OWFoME9pbkJvOW5QYjE1ektSWUdxMjBy?=
 =?utf-8?B?bktoMzhTS0JRdTg0ckZndURzbEpGS3hKUGJYa2QvNGFRaXhVRDRSRVpwemtL?=
 =?utf-8?B?ak5VQVM5ZzF5b1c3ZnJ0Zjd6QXhPRXpIeWJRcWlwZ1ZIbW5MVE9LYUROaUV2?=
 =?utf-8?B?RFdMeEhIL3VpUjRLU0Z6TE9DK09qclJUaUtKaURWdXJDM2ErdEJ6SHhMZ0kx?=
 =?utf-8?B?TGpRU1Yrd1hkWkFQNStaa1B2NVA1K0lIdFVrMStVRlB5bTVhN3ZRbE9FNGUv?=
 =?utf-8?B?dWlwMEozVHpkcEdJbW03K2hTdENJR2RBdW1WUHdacVJDWGQ2RFNCNFJ1c0lN?=
 =?utf-8?B?WW5uZlFnMkFYMVE2cmtiTGM1dUtDaEN5MjZCZzZ2RURPTVhGeHJUbmlkdGN1?=
 =?utf-8?B?UnNMY01Uc1g4aUg0TGxJTTRiN1JXOXMvT3dUVjdEV0YvVFBxcHdHWlJkYU9v?=
 =?utf-8?B?Znpmdjh3Ni94ak0wWUFSa2txR3BIU0pDUTh2a2JzOFdrWTN2R3grU0hSdkpS?=
 =?utf-8?B?UlExZkJyelFjalBsVE5hMFJwNjRFV0JFTUduaDEyejJjajhYS1k1QTlpbnU4?=
 =?utf-8?B?bi9uRFBQSXovbWhqaE5GNVk1ZU9sSnF5M0JhWEZUQWswUG0wVXczUXNVcW1D?=
 =?utf-8?B?Q1ZzK3lKOExCazhFTktVcUpEZElxUjRZbGlUTEt6NEZGaXg1N2d5UllwVTF2?=
 =?utf-8?B?WkNONHBicis4aTQwejV0U3BzNVBkZGxZRm1VKzk2Y3lBN2tpZnFxSmdnblpZ?=
 =?utf-8?Q?tVWbZB9HnOTQf4w/uD702DXZaaV2GrclktDfi2/RjKgI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA3BBA28E61AC34C8FEF7AA2CE0D733D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fc19fc-3055-4206-d0e8-08db2f535903
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 06:12:02.4922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQxfAQpIxbJrh5kXixUcLlI6Zm4/KmHK+swJuV0H7k8yDRBlLi3VdeKTygC1BRDH34WKbXvIiokMki9WHJJZvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_231213_436770_33EC26DF 
X-CRM114-Status: GOOD (  11.90  )
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

T24gMy8yNi8yMyAyMzowNCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBIaSwNCj4NCj4g
U21hbGwgY29kZSBjbGVhbnVwcyBmb3IgbnZtZS1jb3JlIGFuZCB0aGUgbGFzdCBwYXRjaCBoYXMg
Zml4aW5nIHJlYWxseQ0KPiBsb25nIGFyZ3VtZW50IGxpc3Qgb2YgX19udm1lX3N1Ym1pdF9zeW5j
X2NtZCgpLg0KPg0KPiBQbGVhc2UgaGF2ZSBhIGNsb3NlciBsb29rIGF0IHBhdGNoIDMgYW5kIDgu
IFRoZXJlIGFyZSBubyBmdW5jdGlvbmFsDQo+IGNoYW5nZXMgaW4gYW55IG9mIHRoZXNlIHBhdGNo
ZXMuDQo+DQo+IFYyIGlzIHBhc3NpbmcgdGhlIGJsa3Rlc3RzLCBzZWUgbG9nIGJlbG93Lg0KPg0K
Pg0KDQpmZWVsIGZyZWUgdG8gZHJvcCB0aGVzZSBwYXRjaGVzLCB3aGlsZSByZWFkaW5nIHRoZSBj
b2RlIEkgZmVsdCBpdCB3aWxsDQpoZWxwIHNvIEkgc2VudCBpdCwgYnV0IHBsZWFzZSBjb25zaWRl
ciBsYXN0IHBhdGNoIG9yIHN1Z2dlc3QNCmFsdGVybmF0aXZlIC4uLg0KDQotY2sNCg0KDQo=

