Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74726C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 05:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WBdWGQpTgSEaKn75lpzU/Zvw7sHxhGIfJU/WXdIiml8=; b=JkURRYzFaC7DcJvHRhmACUuLOW
	A0/yGfBJdqFNqlqN/ND0G7PTYiH4MLYZe4aZ1ezb03Jh0lKCl8JlBMhfohtUneENbFfbeemJJWQxB
	EBjfeB7LxKhz+CNsvQMbkbMNT3+oGLS6uBRcLMjr/FehiuJWNsduLR2PYOg6JLC2jJoCBeb2pOWtg
	u3QuXC4BO2v+ktoMbHhyRQz8SqUt7JgriHT+GptRdIaZ+cd4pk0lWZm5IQ5EpAJ9PT9lN3z/UTaMm
	YBuuxs/ZNO+B8iUkb3vIDyZfrcsGtX/fXOSnubioRks8gPzeK0tm3BnN2rLmkIZraE7fixViTVk5T
	Q6jkaSTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peUMK-00BFFK-0j;
	Tue, 21 Mar 2023 05:16:32 +0000
Received: from mail-mw2nam04on2061f.outbound.protection.outlook.com ([2a01:111:f400:7e8c::61f] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peUMG-00BFEZ-33
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 05:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfKq5qKG2nU3OTDYfl9OOzGZYFFLxZi0MyInP8lSjO3mRnINCYRL+lO85Xr19xSQv9tgF710B8w79jMJJaCF/24Fp5/Fq/iJmnDkDweLicIWZcSvanYXNQVfBVtKOd29Vm0eRGjZGeTBV2sM3pWtdyZWKZUzWYAcWfXdRz88wRbJWwQkLII7Uyqh23ISOEodXGZEpRt6wXz1+42RWaXH+oUfDYNeiVNhBPBHyo98WndlxeT3BS0MOZZWKAoqr9naEV6OtqowkfQCNcquLh1bXK+sX0/pl96v2XHJF69KxSqT3aQCeRAokDKV5y3G7EUQMz/7SHh3s+VEG+GKYYsERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBdWGQpTgSEaKn75lpzU/Zvw7sHxhGIfJU/WXdIiml8=;
 b=N23fGhyMXsSqKgDvOl01cdi+tOWzf3ctKPBWqHy3HmgpAhUCzve7elqKyEoJ4cq+/S8VVDe4Jjvox28zQcFC1N/4EDJ8FQ4YBZ3GHjDorGVr/wa1Sua+qb1qU3ehUGyuSiCURW8hkuxiK4Htq0DSSJ+GiQ5BbjB3Rqh6MgCKB2hYDY4ONAW7GCrd2nivgUrq68Q5cTwKKGbrGgRJIpNWysMfQughJWEKeqtELv9IITUEaJF16ovsojRZ7qujRNU93pnx7AKqfq3RjgdpHvQlPFiDtrm8CNHw0KIZqLxHKqvoYU+Of2+bwVWexJ5AkwO+4FCWCJihgzEv++0JclDCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBdWGQpTgSEaKn75lpzU/Zvw7sHxhGIfJU/WXdIiml8=;
 b=s76sJaq+qd0ofxLdufJapqnmregDum2IXiMD2w4s2FDdxYZhbqVkD5gHsR/9V5xv7TqXZl4zY9/kr/HuMiZPKhKYKSznb+MYdTH/WOTK6N3NL3d2gPDItt7/kJ/xF5PKSPU2t6Hzjj3T/TYAwywb0Zic6y6cP4dme9kFrZZhRN2WM3iHCbS8+CH5SyIFHUrPKSoOqY77CHuJ0d7OJPwXGO/Isw57aCcUf24snrsjXRAAufaUv6dNRuuYRCZjXTMoEOpNmVzpCAxwADywG+Dxn1Kn6qXzDLw3rpN92Mm/1/UiLO82LoIJ70zt/EIxW5WTLvvb4gQuc2InyjwEzXcwZw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:16:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:16:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH v1 1/2] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Thread-Topic: [PATCH v1 1/2] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Thread-Index: AQHZW1LEXdVEx1qDa0ilhWRAD8zngq8EseuA
Date: Tue, 21 Mar 2023 05:16:25 +0000
Message-ID: <a46e4e5a-69e2-509c-2c20-7ea01bf94f50@nvidia.com>
References: <20230320152204.g27a6jqbb65xmb6r@carbon.lan>
 <20230320173806.12784-1-dwagner@suse.de>
 <20230320173806.12784-2-dwagner@suse.de>
In-Reply-To: <20230320173806.12784-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW6PR12MB8959:EE_
x-ms-office365-filtering-correlation-id: ae4bc779-57e4-4ac2-da6a-08db29cb6b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  PjJsSCDKEVEH2R/YkPKf9Vy0xpMi5+VM/bDtXz0y7Ym56fExbPZZcFYCNbYl4QUa+t6kdSTNCfSp//rkfCfPH9rNKY1duSgaQw3xTJt+bTo/9ic2goj8l5te1bwfq2qL7bkKNqII/3ZLSXnOTPdIbuC/cOGCRP5mA7W9EkCL+PTfvVzayjRD6L+JICG5kvFzC4kUCNziuvnzpk+EbtrmNgTghO4VnEQXAEK/7FUvBHxRnYBra2cdubG+dudML5GwIUEmZaSFsiCdbWuwiqIYeLb4nHp4KI38BbbYwjnHToKT2/EymQO0rrh1hsbte9vpOvAoiZIoJT+lZDgUu+/UR2dy0u6A0kNP8hnE1es2CrR9iyez/fwzFWH7T3iiEUVuZGztp0gbRDKc/Y3CmD9s+tlp7fR6gjk3Fv4mjNgLneTfqqQig5NK4uXexEvFfpiRhXqn85whIxIEbd/rp0Z3Sz4BnrcjW/y9M0TbXxIRdyONoDEd9eibY2iIvhzPlkLhO2j0SW4KpdKe6Xk5fc8J7NEMjMhm8dnymVbZXKI2NIqqYu42OjmBUsUx108+HCr55iV8w7xPomtDLcuHvIhYc8818gmx5qqrl+VPSjlvA9Pk0krn2wYHaO+5AodIBa+KtJXjoSRYIQBys8AqufZ/eNKDTvRxV1vxgR1PA3L2SYBKPOT7RpGJo59GBL3GXq0rml09TQheOA7P6Gafr+IrmEC1mO7+dryLMdo9dAdoonKe7C/HUSehUBVKMMEQLRMb
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199018)(8936002)(5660300002)(41300700001)(4326008)(122000001)(31696002)(86362001)(36756003)(38070700005)(38100700002)(2906002)(6506007)(31686004)(53546011)(6512007)(478600001)(186003)(6486002)(8676002)(71200400001)(66476007)(66446008)(66556008)(76116006)(64756008)(66946007)(91956017)(110136005)(2616005)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Rndyam1DZDIrbGk3MU1BaFFQY3B4Z2tGVXV2VUtqdHF1LzJkeWszV2tWWTE5?=
 =?utf-8?B?RUVqSjVJSEp3eE9XL0MzN1lxTDU5V1pXcHZuczFieWk5YTAwL0doM3dlak8w?=
 =?utf-8?B?WlRSOGwzN3Q5aGZsaURFUDNRdEY2UXc5aHNTMCt1OEhzc0lXNklkaXZEeW5P?=
 =?utf-8?B?bTNxTGdwRitFMmNYWXBSZEFnSUVRa3hrY3pmRnFnd0gxVlJzMERBRHJZWVQy?=
 =?utf-8?B?SnUvS2NLdU1aS2hLL3dsQTZ5QU5GQWIxZUkyM1Q5ODRYYmJZbm1xVFdKOTd6?=
 =?utf-8?B?VzBncExmVXZIM0pSbFh3YmwzMGtmNFZPWE1DU1lXT2lCZUxQMXprSHduME1z?=
 =?utf-8?B?cUJCbHRRS0lscmZuUTZsTVlLdkF4ellURHZBc1lSMVREY2xMWGZhQTlSL2tY?=
 =?utf-8?B?NDhUVnNQVCtlMndWRENIMFgxNmlCZm9qUFJrS2cxbmhNdFAxci91YVVSTWpi?=
 =?utf-8?B?THV1MTN6OWhZbU5Va3NzdUZtdSt6anFBZWhLcVNZYlFoSjRlaTUvb3MzazZm?=
 =?utf-8?B?RmFpSUxmdmo5NjEvVU5NbFdacFBxbFpDc3U0UEJkUTIwNS9jMHlNdWJOeHpD?=
 =?utf-8?B?eC90YjRMNkRmRXRLb0hUek9pT0VsVWw0eGs4VlBYY3pTYSt1WE1idGZuSk56?=
 =?utf-8?B?eVF2Z2ZaRWlpeXdxNlM2WFloRzhDcGoxYXdxYlVxdlhJM0RxZHg0VTlnU205?=
 =?utf-8?B?dW5wNzJhRjNQalh0bVZadjJGSXN5dE1JR0llcmcyRHNZSnNKay9oVU15dFMx?=
 =?utf-8?B?bFBFVDBOMllXVEJJKzAzaWhZVCt6ZGFpa0pLTm9JdDBjNHNuREdDYUhoaW1Z?=
 =?utf-8?B?Q0JyL2s0OUJ4NVR6TlFGaTNlclBKam9HSUluWmFlcG1BK1ZTc0RCY0NBdldZ?=
 =?utf-8?B?YzAvbXVDeUJhb2VmMUxFS1JQYk51T2h3VHhOSjBHSHRDandMN0NXYVVQMUxt?=
 =?utf-8?B?REdKY0lTc01tMzNCUGJSQmFRdjFmR0hWNXJERkhJS1h5d2lhYkcwTDFLa1Ex?=
 =?utf-8?B?cXpmTTVhcW5EQzJsczJyTXpnV3Y4VkxKZ0Q1eUt3MWJCUzRPWWoyQ1pXZlBY?=
 =?utf-8?B?QStGWi9tbXZhUlNaQUVzMWVjOHpCNDZDUktsRFVlb09xUnNZOWwrZ0tmb2pD?=
 =?utf-8?B?VHpaQWhtTlNKamJtUURMZ0V5OVdUSzhCOTl0aERsM3VrYUpkOTk3cVRRNjVn?=
 =?utf-8?B?NDcxUGZUYjk2OXpYb1NnT1dGdjlOa3hNUFdDUnc5ZWE0d05rYmpjMWVGVFBt?=
 =?utf-8?B?SHk0K3EzVnJXdW1nYzRWREl0Q1UzWU5lQ1NncXFlZ2lrSi9NQXpySWlmamxS?=
 =?utf-8?B?c0s5bXJXQ0hKN1RJcFFsZFdkcVVlRVB3ZHN5Nmg1WTlqQ3VGbzhDM3FJajNK?=
 =?utf-8?B?a29mUHRjcUc2MHIvenB4M2ZHUWlYNVova1Q1SUV1UDRCSDI1MDBIaFhSbGpv?=
 =?utf-8?B?blVJemViTit2elZGejRIVEpjeGg4RW82cHg2bUYxZUFkRDNYUXJhSWQ5TmhK?=
 =?utf-8?B?VEdSeDFFRWcrcVBGQ0Iwd2l2cVRsYXRaK2pEU1JTQkVFNTVLWTQvSzR5d0dE?=
 =?utf-8?B?RkIxdVRaU1NUdHRyNHRIdmxZcDVmQ3cxalBLRWhPekErNW5oc01CWmg4aitV?=
 =?utf-8?B?NldLbSs1OWN6ckRFc2Nrd2hFSExZT0l2WU0yeFc0c2dmNlVTZlRSTjR6Vnpi?=
 =?utf-8?B?eWVlOVpWM1NRTDR6SmNjcnFkR2VacVpFdHpROWxkT0VZR3NlbDVnMXlGckw1?=
 =?utf-8?B?RmhxcjBXNS9RN2xGQXU3cGNFc2xyT1N2MFBCZ2RUR2NFSzhuQVhTcUMrVnY4?=
 =?utf-8?B?cmlCZEpXdzlhaEk4Z2xqTjZ0d0UrdkNtMjQrSjlKY1NQdExvc09mN2pNVzJF?=
 =?utf-8?B?UE1xWFVyV0Uvd21SRVE2b3c2d0x0ZlNqbFlvM0F2SXU4QnM4SXIrNVFFS1gw?=
 =?utf-8?B?TEl4d2w5MXhHYVA2YTRqRUNkZmpQREdoeTdJRE1Iak9qM1BTL1EwbzZsWWJv?=
 =?utf-8?B?VU05YldGM1NZdEhCMnp4UXNXaGFyNXZCNUF1YWxpTURMNjNRS3RrSVNVbEt2?=
 =?utf-8?B?dVB0VENVNnFNZk9TWm1BT2xyRXVvSXJGK0NUMUR5K0VVYjk4OElkZHF5SGJx?=
 =?utf-8?B?ZGU1cnFmbENSNkxLWktMd2FkbW9US3JzYm1rUStjM0xTT3ZGLy85MkVPajZJ?=
 =?utf-8?Q?3yxByNQ0y9ZrL2tthKSf335mFog5RebBVqX2KGKUQMnZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68EEFC7923EF9D4396CD6537ED168CE9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4bc779-57e4-4ac2-da6a-08db29cb6b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 05:16:25.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnUhnpVpwsfXG9Yz4rLYJ0v75vm4yAmVcBDhQmqhRBhOrj19XBB/C95g6h7D/0hnR4IdQwhb3PKSBM710HygWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_221629_005983_BC710C51 
X-CRM114-Status: GOOD (  15.57  )
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

T24gMy8yMC8yMDIzIDEwOjM4IEFNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBFeHRlbmQgdGhl
IG52bWVfY29ubmVjdF9zdWJzeXMoKSBmdW5jdGlvbiB0byBwYXJzZSBvcHRpb25hbCBhcmd1bWVu
dHMuDQo+IFRoaXMgYXZvaWRzIHRoYXQgYWxsIHRlc3QgaGF2ZSB0byBwYXNzIGluIGFsd2F5cyBh
bGwgYXJndW1lbnRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25l
ckBzdXNlLmRlPg0KPiAtLS0NCj4gICB0ZXN0cy9udm1lL3JjIHwgNDYgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0NiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS9yYyBiL3Rlc3RzL252
bWUvcmMNCj4gaW5kZXggMjEwYTgyYWVhMzg0Li44ZjRiNDYwMWM0NGUgMTAwNjQ0DQo+IC0tLSBh
L3Rlc3RzL252bWUvcmMNCj4gKysrIGIvdGVzdHMvbnZtZS9yYw0KPiBAQCAtMzE2LDYgKzMxNiw0
MiBAQCBfbnZtZV9kaXNjb25uZWN0X3N1YnN5cygpIHsNCj4gICB9DQo+ICAgDQo+ICAgX252bWVf
Y29ubmVjdF9zdWJzeXMoKSB7DQo+ICsJbG9jYWwgcG9zaXRpb25hbF9hcmdzPSgpDQo+ICsNCj4g
Kwlsb2NhbCBucl9pb19xdWV1ZXM9IiINCj4gKwlsb2NhbCBucl93cml0ZV9xdWV1ZXM9IiINCj4g
Kwlsb2NhbCBucl9wb2xsX3F1ZXVlcz0iIg0KPiArDQo+ICsJd2hpbGUgW1sgJCMgLWd0IDAgXV07
IGRvDQo+ICsJCWNhc2UgJDEgaW4NCj4gKwkJCS1pfC0tbnItaW8tcXVldWVzKQ0KPiArCQkJCW5y
X2lvX3F1ZXVlcz0iJDIiDQo+ICsJCQkJc2hpZnQNCj4gKwkJCQlzaGlmdA0KPiArCQkJCTs7DQo+
ICsJCQktV3wtLW5yLXdyaXRlLXF1ZXVlcykNCj4gKwkJCQlucl93cml0ZV9xdWV1ZXM9IiQyIg0K
PiArCQkJCXNoaWZ0DQo+ICsJCQkJc2hpZnQNCj4gKwkJCQk7Ow0KPiArCQkJLVB8LS1uci1wb2xs
LXF1ZXVlcykNCj4gKwkJCQlucl9wb2xsX3F1ZXVlcz0iJDIiDQo+ICsJCQkJc2hpZnQNCj4gKwkJ
CQlzaGlmdA0KPiArCQkJCTs7DQo+ICsJCQktKnwtLSopDQo+ICsJCQkJZWNobyAiVW5rbm93biBv
cHRpb24gJDEiDQo+ICsJCQkJZXhpdCAxDQo+ICsJCQkJOzsNCj4gKwkJCSopDQo+ICsJCQkJcG9z
aXRpb25hbF9hcmdzKz0oIiQxIikNCj4gKwkJCQlzaGlmdA0KPiArCQkJCTs7DQo+ICsJCWVzYWMN
Cj4gKwlkb25lDQo+ICsNCj4gKwlzZXQgLS0gIiR7cG9zaXRpb25hbF9hcmdzW0BdfSINCj4gKw0K
PiAgIAlsb2NhbCB0cnR5cGU9IiQxIg0KPiAgIAlsb2NhbCBzdWJzeXNucW49IiQyIg0KPiAgIAls
b2NhbCB0cmFkZHI9IiR7MzotJGRlZl90cmFkZHJ9Ig0KDQpjYW4gd2UgcGxlYXNlIGhhdmUgYWxs
IHZhcmlhYmxlIGRlY2xhcmF0aW9ucyBhdCB0aGUgc3RhcnQgb2YgdGhlDQpmdW5jdGlvbiB0aGVu
IGFkZCB0aGUgYWN0dWFsIGNvZGUgaW5zdGVhZCBvZiBhZGRpbmcgaW4gYmV0d2Vlbg0KZGlmZmVy
ZW50IHZhcmlhYmxlIGRlY2xhcmF0aW9ucyA/Pw0KDQotY2sNCg0K

