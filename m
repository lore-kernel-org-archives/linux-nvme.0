Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A21C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 00:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YN5fFq5Uow51rbSY1hm/LOmWcOktJInffuU6H2OC6vc=; b=pD3KNc16PTmCYTYw6HS6JUMp0e
	Oo4iZkHqRf3K2S+hzn5uw0u1gZxWG9BAvBwRdMpXtB/fAVzW9gU21ACqAwIR7X+8H2vRbshtf6LGC
	mqXrcDFEQg1bd3BJh7+LL+1e9Cf7m94ORCMGwuQnsQm1yuYHdDCPChzN1PS48UvM1dLJRER+gsG88
	9UywjLcYE03P5lOICBb1Mr0utlXpNwdppsyPUtxuxi1YFeTcIrtNTHnGbml2fQE4a/ri1/hHIhmP/
	LMts6WJe4pvD0SLJNjE7gTv8SGEHdoIumvdCLta0Tq/V9XaqVJc1wJbpt5jTIIPdE05cpp0Cw/WPB
	eHdaSmOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny0Mm-00Fw9j-Pd; Mon, 06 Jun 2022 00:13:08 +0000
Received: from mail-bn7nam10on20629.outbound.protection.outlook.com ([2a01:111:f400:7e8a::629] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny0Mk-00Fvmb-4A
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 00:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSxk9zafFIk4/OWRay89MRSpgBh13brjoS2GK2oH9NfEUUnQtel+XBUgiGIQhezhDSTYwCwE8DlS6sGppglN+1aMabowo4qAwAmS2ws2skeC5VkA7ShhHveUuRHAqTRiiErFNTfochcODRM0u4xEefBrI13Zo/toSCzlQO8NXNbJXys/LQ4uDCl+Mw7YImdA5+tb8sOpGQfeMUcnjrnpotitrcPzRcGlZobIwu2xyf1A21kaPdEBJrC3u+dhQLWfmndMagoZR8vP7bpowT7tXAWfIaw02fa/6dwDEnUJ3ZfYHt7x8Mx6V6Fyf/G3Di2OGa0ocErCPuN8uMNkOOf+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN5fFq5Uow51rbSY1hm/LOmWcOktJInffuU6H2OC6vc=;
 b=YfMIfrwc4rNv0HHbR/t/8xgS7ldg9YWCo0Hs/85IMfSDVajIUCA8TmwkHSNXVY8i8+RvGblbLaOmgdPKuYAkYxVIzmfDx1KVS0F99KyqZ2oaGVzDgDEy/piRbglaCMNr+9Wf9yZqQfaOxMhuKdC80tW91Yits1SBMdlJSc3mQLvDk26DI0WAsPXFKplhtuaZkSHxzG1guFPNwjWmwmAATNknXTAxY2tQAfmid6HFbds0fZaDAwfxeFBxwkpUzxVU7qy9OxQJXRc/2yPkBHE1pa6vf3z5tixn5ouy9S9rmWTNH7ytNo0yNDsGUTEz/bddiU4IftQOfuVGhX5qHZ8WCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN5fFq5Uow51rbSY1hm/LOmWcOktJInffuU6H2OC6vc=;
 b=ugCkMfnvzNvaNgyBFwJfXYYD6AC0XBXxcpH/dHgOY2JQL3ZPIdmEXTrKb4e9wv8xj3lbwKXviRiSPE7A5sja56n4L8f8IjdDM31CHS0/vtMinNZ2xKVZphjwZVgS+sCY7aaAZmxfpXZoMetOat158TB4XloaQ/VDGkAuYfLnzdZmElb+tX3PEYO9ShORChlzp/uj3rHldCZr5878o7Fmhs/swehImmtVQKsAGY1nFL0NJqTZdcYWN5mlDrfF5zv869+MVJF7TG3rFdoUGOgj9e+l5dn5fRJOVtL0RtUPlP4xw+ip2r8plHBzgQ3fvZEX+K+SiwDdknKRMbym6sLFpw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4784.namprd12.prod.outlook.com (2603:10b6:208:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sun, 5 Jun
 2022 23:58:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Sun, 5 Jun 2022
 23:58:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 blktests 00/10] Testsuite for nvme in-band
 authentication
Thread-Topic: [PATCHv3 blktests 00/10] Testsuite for nvme in-band
 authentication
Thread-Index: AQHYeTgnXAsQVar7yE20C0k0u/hh+w==
Date: Sun, 5 Jun 2022 23:58:29 +0000
Message-ID: <a258bb78-4009-9f27-e178-bac596569b46@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf4b8f37-ec73-4e72-dd02-08da474f4a1b
x-ms-traffictypediagnostic: MN2PR12MB4784:EE_
x-microsoft-antispam-prvs:  <MN2PR12MB4784ACAF21CEF6C1F5C291FCA3A39@MN2PR12MB4784.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  x91kA2EzSM5Snurpx4qCNJkE+WyZovMshUuzsD+dCZhLEnln1vQh66QEWGg2rR1Hcp87W1gdZmZ6SiWF1gHXnaQBwUgB17KOO12wA0/GKLdkmvKWJLcvnsbLnYsgVbnQtuMuaPaqmccvtdOHNx/pjAwRiex8sO7CWcNSMfuDh9pRq9k2Ux4fO6leeK/EJkocO4NBGqjToBqYfsaQLl+/RNjJqujFDp6GOt1HZo3AabXziBxo9xp5uPzj4aYK6XManRhxqrHh3IYgPT69YmoP+vFPNW43Qjo1Vl/++hc+e7MVx4WMYFQjgoPXiJtHfeHgX4mdvbLZzaFK6IMQybWKDLHdZ4Dzge2/peH/I7Ktle9u2QjuXeoWJDGEgNFvtOE3HZVaqhqcZxiRVHvEtJGLVpzDkx3znW1C+PLJn6+BhJfFiH/7kzOtJly+8wrCvsvWMZ/Me8ydhbonRVt3JfNa/IeDpurZNKXx5IyJpGfItvJaU+04eo6gMjlXV9H9CrVNGJUwgfrd8MXTn4Wxc45dZ5HQq8Ukhlmg6ZpuntrL05lwL9ORK1RJkPcqAqNbogzswD8uTcZDCQ4f/CdHsPlL0MA2bkeRLUnndBhzKoqz5r7OOStY6wRVMm/IHv6ijj/ksr4OMJ+CLpEPZGrqqBfSqY8QxahPmSeeoslJD8AHPMLq1Rw1EqPmqlUcngPvqFwYwgRfQTK6FdvDp/wVtg2hj7TMx6KS2xVjDEfj6EUECfdnCMAPfNvrP6m80+QGGAQAU93uHu4OL/Uhkj/EREiSvQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(186003)(83380400001)(53546011)(316002)(54906003)(6916009)(6512007)(2906002)(71200400001)(508600001)(36756003)(2616005)(31696002)(6486002)(86362001)(8936002)(38100700002)(6506007)(122000001)(91956017)(5660300002)(31686004)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RWFkSnAzTjhkYkNIaEl2eEpGbU5NT1RMQnJKVXZkdk5ZamN4bkVKNUw5TEFw?=
 =?utf-8?B?d1FYK2RCOXFTUHZ3elRoVDJLL0d3VGFNc3lDRXYyWVE1TE5QekJlOGVnZzBL?=
 =?utf-8?B?dUFFSTVUZzFFM1V6ZU5qMHRyaVFxbTR4TCtSL1lkS2xwV2g0cnppSlFWZkJS?=
 =?utf-8?B?REFzQVZSZnhBSDBFVThlZ1UwUVpvM1RFc2FjWExJS0RKSkl2MW9iUCt6dGVv?=
 =?utf-8?B?NjQrdmxwQXZxTjRaY0lXR0dYdFZISUI0UzNEQ2FRSGlxTE5jSW15SzJwWXp2?=
 =?utf-8?B?MnlDTzNUdXF1MEtqMkRibEpIN0ttazl5Q0tCY0w5cmZRVDJrMXJJVzRGQnM2?=
 =?utf-8?B?ZG81dFRBblFyOFVJOEZwdXVwVGNWZ2xhUnRSMWRuL2xHVGU5bFZ0MzN1N2JM?=
 =?utf-8?B?eVdKZXdoN0VFRWQ0UC9BQm5oYXhxQk5ud1o2L2VEa2xzdWJ6S2pmTTltVzZ3?=
 =?utf-8?B?NUFIQ1Fzd3Z2WGVvNEk4WmMxRzM1U3lQY3dwZDF3enRFR1JGRjdnZUZibHQr?=
 =?utf-8?B?ajhyblpEOFVlSmlYeDEwYnBZLzFtNldoQXovRlhmc1piNDE1ZXdWaGMxU095?=
 =?utf-8?B?RW0zOGs0RHMvQ0QrZ0c0WHVyTFJWZ3lUNUVtajYvemdTcDdCN2doaXliMWdu?=
 =?utf-8?B?bGlxMVFRVFlpYXZ2OWxTNzJlR1Eza2tnY2ZndHAxSGNpWW5QUTNyQlVjdXNF?=
 =?utf-8?B?UXd2Q0xNdkM4bzJxTTE5L1RoR1cvMVdpMmxNUlh6VEFvVW11eVlIVFhmM2pn?=
 =?utf-8?B?cUU4UytzdklHT0xMODJEOUZ5SEVUSnN1SW1tWWRGM1ZMejZjQ2k5MnI5TTFU?=
 =?utf-8?B?bUFmNk1PQ014WlAxZWU2dzhZRkFEUXk0emIwdE5pZ3JwTkdoUlJwTnMyeGRM?=
 =?utf-8?B?NXY3aEI5Vm9zVHdpNGUwZWN4STJ6SE1lNjV0eUoxQnZzOEdKaXZXcnEzcUtP?=
 =?utf-8?B?OS9jMURiVEZya3B5TWdoYmt4SVNYU0lHR0V3MERab3R0aDZzdStFSmR0MDhL?=
 =?utf-8?B?STl0RmFOS2VoQk5MMkt3UGpmQ2FkanFJR1BnbGd4VHBUMmF3eGJMMzBvbjdx?=
 =?utf-8?B?YngyM1RSZmhOYmxkeGlpUmI3NmhIWlBnbWdLWUl0eFdsN3ZKcys0ZnhrcG9X?=
 =?utf-8?B?UlgvaVVRNzJGczdla3FJVWNhZW9MeldtZ29uNkhySXUvQ2lWWG93NEdxd3N6?=
 =?utf-8?B?TTNMTlNMdG9lYjNkM3RHeWtzeXJhR3l1R0JFaThqN1NNK0RnRkFVVDBreFZx?=
 =?utf-8?B?WU14K2t5U1FOZENpeEdLa3lNdEhqWkxyM2lPcU9WaWROcFYvYlRYVHhMV1Vz?=
 =?utf-8?B?WG5rSWNPRUNjMUk5Z0E5ZmlCM01Mc2RsWS96Y2p0LytwdG1kSUk3UWxJT09H?=
 =?utf-8?B?WVVrOWpORzJzYXAwSFU1RWx2OWhRSXdpemh3RDJPZ3pnMXNjVzBwRTR5Rk44?=
 =?utf-8?B?d2J6Uk10blFQWnFIU2lEZEF3bE1IUFo5aUQzSDNSbnZkenpVTmtLenZJczJi?=
 =?utf-8?B?V2NISEdMMXR3VEJzSnFaWU1McXVBNStUOFdUREdvazBpQ01HVnNHeDlGOXRs?=
 =?utf-8?B?RmQvRXhRc0c0MFZKaVdWdUNBLzFNQy9NVlFwYUU0WDRNTHhzOVlicjRCb3pE?=
 =?utf-8?B?VVE4czR3cnVSTHZETmdBRk5sVGVyZndudjVBZTh2ajI2QVlubklIeEtlbkJi?=
 =?utf-8?B?emRQTS9XT244bEhucHduOWVNYjArLzRzYzhTZzkxZmtOeG4wZDJVcEl2cmVy?=
 =?utf-8?B?czl5QkJSNVVBNEgrbnVUS0FUdjY3THZCbmJDdGdkSm1GUUI4ZFQ4aE1HOWhB?=
 =?utf-8?B?Z2JURkU3SUlBTUVlbVpxc3RqdFhwZEI2Z1kvMTg4cUphRDJ2YndCSlQ4Z20r?=
 =?utf-8?B?ekxsckJPRkx2T0k5YTNIbFZ0UitQMGxoUzhxTHB2aktTV0RhdDNjM3FSRWdu?=
 =?utf-8?B?ekMrM1VOck5KL2l2VDZuMWdQUmg4a2dvVXhLbTdoNit3L3JESnFaZTdKZUlu?=
 =?utf-8?B?UE94bjR5aFFIRjZ2TUhyYzBmbzNFbDVIaUVQZTRwajJKckFaczRESDhrWlNa?=
 =?utf-8?B?MjBwWEtLYzFZSTkzQ3FLMmJVTEM0TXZlLzJxM04rZ3VrdlU3UTlVZEl4Y2o4?=
 =?utf-8?B?VkhtQXVlWDcrdW9JZmFWMFBDR1lUZkJGbFFpYzk5UEE3RzZIUnRIdE1idk8v?=
 =?utf-8?B?bE1YbDJ6cThiNkZRRzJSS25kTlUyWWh0ek5OQW1FWVpSUElGcXp0TlZDaW5t?=
 =?utf-8?B?NlNFdktDME5MSllFUDEzMlNPckx2bTE1bmRoQjlla3FkTTdQQ0RhQTlqS3NV?=
 =?utf-8?B?SUloU0NOTE5MMW5uVDZyOVR5Yy9tWWZhTm55MVY1c2JjQi9weG1HZ3QrRCtu?=
 =?utf-8?Q?GlMdRK/k80xdwnRFlF9fQCyTO/kfIob4Lfs73Pl9EHLNE?=
x-ms-exchange-antispam-messagedata-1: Db2OfHLmTgkGIw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2D3CBEF4C171F4E8E72CEAF3EAF298F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4b8f37-ec73-4e72-dd02-08da474f4a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2022 23:58:29.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTv1GRY//BFojHxqbeO3zTbWbP55+GLTha8SN0GoFlgZZpByZLzd694ZGuy2MrirIOfi5xIJ/u+Fj3LeJVk9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4784
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220605_171306_207195_DD7C7F48 
X-CRM114-Status: GOOD (  11.92  )
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

T24gMTEvMjIvMjEgMjM6NDksIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gSGkgYWxsLA0KPiAN
Cj4gc29tZSBwZW9wbGUgKEhpIFNhZ2khKSBoYXZlIGNvbXBsYWluZWQgdGhhdCBudm1lIGluLWJh
bmQgYXV0aGVudGljYXRpb24NCj4gcHJvdmlkZSBmYXIgdG9vIG1hbnkgY29uZmlndXJhdGlvbiBv
cHRpb25zIHRvIHRlc3QgaXQgd2l0aCBzb21lIGVhc3kNCj4gY29tbWFuZHMuIFNvIGhlcmUncyBh
IHRlc3Qgc3VpdGUgZm9yIHRlc3RpbmcgKG1vc3Qgb2YpIHRoZSB2YXJpb3VzDQo+IGNvbmZpZ3Vy
YXRpb24gb3B0aW9ucyBhbmQgZmVhdHVyZXMuDQo+IA0KDQpJbi1CYW5kIGF1dGhlbnRpY2F0aW9u
IGJsa3Rlc3RzIGFyZSBmYWlsaW5nIG9uIHlvdXIgY3VycmVudA0KdmVyc2lvbiA6LQ0KDQpibGt0
ZXN0cyAobWFzdGVyKSAjIG52bWVfdHJ0eXBlPWxvb3AgLi9jaGVjayBudm1lLzAzOQ0KbnZtZS8w
MzkgKENyZWF0ZSBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zKSAgICAgICAgICAgICAgICAgIFtm
YWlsZWRdDQogICAgIHJ1bnRpbWUgICAgLi4uICAxLjY0NnMNCiAgICAgLS0tIHRlc3RzL252bWUv
MDM5Lm91dAkyMDIyLTA2LTAxIDEyOjMwOjM0LjU1NjgwNzM5NiAtMDcwMA0KICAgICArKysgL21u
dC9kYXRhL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvbnZtZS8wMzkub3V0LmJhZAkyMDIyLTA2LTA1
IA0KMTY6Mzk6MTkuMzM1NjM2MDU4IC0wNzAwDQogICAgIEBAIC0xLDYgKzEsNyBAQA0KICAgICAg
UnVubmluZyBudm1lLzAzOQ0KICAgICArdGVzdHMvbnZtZS9yYzogbGluZSAyNjk6IHByaW50Zjog
d3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQNCiAgICAgIFRlc3QgdW5hdXRoZW50aWNhdGVk
IGNvbm5lY3Rpb24NCiAgICAgLW5vIGNvbnRyb2xsZXIgZm91bmQNCiAgICAgK25vIGNvbnRyb2xs
ZXIgZm91bmQ6IGZhaWxlZCB0byB3cml0ZSB0byBudm1lLWZhYnJpY3MgZGV2aWNlDQogICAgICBO
UU46YmxrdGVzdHMtc3Vic3lzdGVtLTEgZGlzY29ubmVjdGVkIDAgY29udHJvbGxlcihzKQ0KICAg
ICAgVGVzdCBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb24NCiAgICAgLi4uDQogICAgIChSdW4gJ2Rp
ZmYgLXUgdGVzdHMvbnZtZS8wMzkub3V0IA0KL21udC9kYXRhL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9k
ZXYvbnZtZS8wMzkub3V0LmJhZCcgdG8gc2VlIHRoZSBlbnRpcmUgZGlmZikNCmJsa3Rlc3RzICht
YXN0ZXIpICMgbnZtZV90cnR5cGU9bG9vcCAuL2NoZWNrIG52bWUvMDQwDQpudm1lLzA0MCAoVGVz
dCBkaGNoYXAga2V5IHR5cGVzIGZvciBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zKQ0KbnZtZS8w
NDAgKFRlc3QgZGhjaGFwIGtleSB0eXBlcyBmb3IgYXV0aGVudGljYXRlZCBjb25uZWN0aW9ucykg
W2ZhaWxlZF0NCiAgICAgcnVudGltZSAgICAuLi4gIDExLjE5NHMNCiAgICAgLS0tIHRlc3RzL252
bWUvMDQwLm91dAkyMDIyLTA2LTAxIDEyOjMwOjM2LjY4MTg1ODI0OCAtMDcwMA0KICAgICArKysg
L21udC9kYXRhL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvbnZtZS8wNDAub3V0LmJhZAkyMDIyLTA2
LTA1IA0KMTY6Mzk6NDkuMzA3MzE0OTUxIC0wNzAwDQogICAgIEBAIC0xLDQgKzEsNSBAQA0KICAg
ICAgUnVubmluZyBudm1lLzA0MA0KICAgICArdGVzdHMvbnZtZS9yYzogbGluZSAyNjk6IHByaW50
Zjogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQNCiAgICAgIFRlc3RpbmcgaG1hYyAwDQog
ICAgICBOUU46YmxrdGVzdHMtc3Vic3lzdGVtLTEgZGlzY29ubmVjdGVkIDEgY29udHJvbGxlcihz
KQ0KICAgICAgVGVzdGluZyBobWFjIDENCmJsa3Rlc3RzIChtYXN0ZXIpICMNCmJsa3Rlc3RzICht
YXN0ZXIpICMgbnZtZV90cnR5cGU9bG9vcCAuL2NoZWNrIG52bWUvMDQxDQpudm1lLzA0MSAoVGVz
dCBoYXNoIGFuZCBESCBncm91cCB2YXJpYXRpb25zIGZvciBhdXRoZW50aWNhdGVkIA0KY29ubmVj
dGlvbnMpIFtmYWlsZWRdDQogICAgIHJ1bnRpbWUgICAgLi4uICAxNC43ODJzDQogICAgIC0tLSB0
ZXN0cy9udm1lLzA0MS5vdXQJMjAyMi0wNi0wMSAxMjozMDozOS4wNjU5MTUyOTggLTA3MDANCiAg
ICAgKysrIC9tbnQvZGF0YS9ibGt0ZXN0cy9yZXN1bHRzL25vZGV2L252bWUvMDQxLm91dC5iYWQJ
MjAyMi0wNi0wNSANCjE2OjQwOjExLjczMzgyMjk0MSAtMDcwMA0KICAgICBAQCAtMSw0ICsxLDUg
QEANCiAgICAgIFJ1bm5pbmcgbnZtZS8wNDENCiAgICAgK3Rlc3RzL252bWUvcmM6IGxpbmUgMjY5
OiBwcmludGY6IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQogICAgICBUZXN0aW5nIGhh
c2ggaG1hYyhzaGEyNTYpDQogICAgICBOUU46YmxrdGVzdHMtc3Vic3lzdGVtLTEgZGlzY29ubmVj
dGVkIDEgY29udHJvbGxlcihzKQ0KICAgICAgVGVzdGluZyBoYXNoIGhtYWMoc2hhMzg0KQ0KYmxr
dGVzdHMgKG1hc3RlcikgIyBudm1lX3RydHlwZT1sb29wIC4vY2hlY2sgbnZtZS8wNDMNCm52bWUv
MDQzIChUZXN0IHJlLWF1dGhlbnRpY2F0aW9uKSAgICAgICAgICAgICAgICAgICAgICAgICAgICBb
ZmFpbGVkXQ0KICAgICBydW50aW1lICAgIC4uLiAgNi4wNDJzDQogICAgIC0tLSB0ZXN0cy9udm1l
LzA0My5vdXQJMjAyMi0wNi0wMSAxMjozMDo0NS4wODkwNTk0MjggLTA3MDANCiAgICAgKysrIC9t
bnQvZGF0YS9ibGt0ZXN0cy9yZXN1bHRzL25vZGV2L252bWUvMDQzLm91dC5iYWQJMjAyMi0wNi0w
NSANCjE2OjQwOjI0LjQwOTExMDA0OSAtMDcwMA0KICAgICBAQCAtMSw0ICsxLDUgQEANCiAgICAg
IFJ1bm5pbmcgbnZtZS8wNDMNCiAgICAgK3Rlc3RzL252bWUvcmM6IGxpbmUgMjY5OiBwcmludGY6
IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQogICAgICBSZS1hdXRoZW50aWNhdGUgd2l0
aCBvcmlnaW5hbCBob3N0IGtleQ0KICAgICAgUmVuZXcgaG9zdCBrZXkgb24gdGhlIGNvbnRyb2xs
ZXINCiAgICAgIFJlLWF1dGhlbnRpY2F0ZSB3aXRoIG5ldyBob3N0IGtleQ0KDQoNCi1jaw0K

