Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F30AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRpxxMv6U0wg1kLLQhi2f5w8en3gd2OMJmwSSSpYwaE=; b=yE/KnkPU/TDirvag2gqHPuuB0G
	3MR7tDPPO9CFAGGfZR6tIYNvnsiYvkUBiyLypl5bj+yl0O26Nv6vli4Yj0G9jgyKDK9jbTsUu3Y8M
	UBiTj7VI6rCOPCEqQf4a0UbNpfeNhaitnzY3zSQJQjM5LE7GyUAfPQMhQtmhNDBZ0ZTadcAgMPb/h
	Ju/ZLOgwM/KKaxn0b0znvqNxGgE3Fz31viKSiIonEkMWkW2c5WeyWc725C1b/sGq2b3ArUSgrvWl4
	hwhW0Vxw5uwxQUkdzF+9Q+yYmY/qvr6DmYDE9UdWYzfbgHFbrfbq+wc34Z2+a7b324dGksOIHsPdo
	WRLFGufA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndsrT-008tBY-0Z; Mon, 11 Apr 2022 12:09:39 +0000
Received: from mail-dm6nam10on2062d.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62d]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndsrP-008t8x-22
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 12:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjDUxmbqdZBlmh1qkE7FCqXjDRdtuQELMRFsgDMBwHqnzySf8HK+T7Txq0MgJExKkgSMQLR0QtxdYq7eTyDWm8bLYwkRLedgXrghDhi8ALRjWXnaD5SxZybjnHGJMonYghUv26iLsaRp736mfNUIq2tDCZt3f9U497vv5F3zDfletiWmqexpt5H3iofrIuoG8qjZYQ+lLDXxlqgmXezP8GLiponDuGRuNuQxAzcoVa9Oyp8fzrer+yw5LyZ5DsMGaf5hNn0k/NHCDj36+yrSvFq4nOQ8iQ4WPUTuwRXLaotptCwB7xvagEIg5XdeAz2G4ISLvoqujQQtnWmZOfM/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRpxxMv6U0wg1kLLQhi2f5w8en3gd2OMJmwSSSpYwaE=;
 b=CN44U3i2JGZyGtV2pTDIjk2E5L1EppjjzLGf109rRAA7r967WGvhYPu7YA0dmpEmd2W9DpO9E/8oERNAZIbErrCWAzpfrvAR1OK4LdTkbL0oQEJ4lbxh5DN0FesJTO1JYcV2uWKjBLLGqJEh45ZuK5NEmocW8kxNa9I7QGEucmgD5kT3nmYxJHI5lkq9QXCXIKns2cugHCwET24G0aUkZOJBuFA7pD/VJ+hI4MY2U+TgukZ0j9aiCzFpgwJLtEpuhRwbEAxsCLun/CHQq6qx9joauJzWj/whfsBkgQJrR/SolPbIOGkd+IfY28X3hhZRI69DlNNTh11f5eLsioY/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRpxxMv6U0wg1kLLQhi2f5w8en3gd2OMJmwSSSpYwaE=;
 b=mgvnp3bZXBZ9ZOYUpvVgT2AzV+zIzq/gwDbfqvyAo4UJ07UDz9/bJnrR7UNLI6HA6zx+VgUcHgP95gRNmygt61kz+eM7H+rDNVptRq63//6JTxcOG07VoPdwBl2ZcauNdhZ6Z1xFxlOAA9bhXhI5UUaKrajXa3TlDhbNcji4Uu+O26B1J/2Y3gzxQClu7hRIGeDL7O1qlL6iDMUz+2pmWN60tcS7OI0CGUpYKitVG7YWbvefLi9WUYXo4l0iMGDIizlmsAF87n+27M46Ujy8clAr7aZu/k/ullUstLBtCAVAySRXgZu/c4Odub0QGlY2h31EuWTxxHOo9IjGWI6gBw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:09:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 12:09:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Thread-Topic: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Thread-Index: AQHYTVIa6YR5KcbjpkWDxqSgwxqmEKzqO8CAgABHEQCAAAY7AIAAFk4A
Date: Mon, 11 Apr 2022 12:09:31 +0000
Message-ID: <d86c4a83-ac9d-f0b1-de41-5d411f5444f3@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com> <20220411061301.GB14797@lst.de>
 <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
 <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
In-Reply-To: <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cbfecef-e65d-4f5e-9124-08da1bb42269
x-ms-traffictypediagnostic: MN0PR12MB5716:EE_
x-microsoft-antispam-prvs: <MN0PR12MB57161BD39CE4C2DA6B011D5FA3EA9@MN0PR12MB5716.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AYyz2BbxkQLZw9BDcSQPLQ8Q4loWL5+BeW31kS0J4L9yYmjJhQonZaH0qucnB89zAxMUo9Zf6P29mYLVT0sk6fqiTmh6o2fHM/r4uf/VkQ44BFwk5bmQyBJEJYAyPZXAnDkqvlF+s7beK5S7eXaaCe6CBUoFVoIPDVE2iXJcRkNmGnl8YhSFiRi6cbP0bZckvht2rCHRQHM8lRYKnzAR6oQ6gGxIlXWHCkwzyTnnCB1pMxN7TVrQXDcFnn0IBs7l1sPnUKUNXrl4ieKJ8XSrecUY9UJ5kGgi8OzUOTW/fwT6pfepXIK3fEbKi/WzY6G7E2Y2450eQDrVWa8xq6iGG5iD3Bwr1t/pmNl2lQP0Y+PnYYAq2+g4iojjMLSy+wAl5/fb67JZe2xLPL25/c12/CElELKNsUfr759vYB4KWKk/mnRvObnliFrecgiag4wKR7zR/dgCpe1XaO8Kj7T0b3uf61HyXowaA8WUSCTK8hiCbwzMrCoXHYdNRa8LBhMp+wJCfqP2v00ouJmksZyxUZHR6vPKk2cxywnRGco6Jp9cEQChxpFtnqNbJTC2wChwEXyj/gMHyhEZGyuQ+ew5z5PtG9N3rRiWmWBSsXJ1j+6IPq0/OucfyeanJb3hz/VqKeKRSixtayVq/eNil33xCIoi4QU1evet1++P8BqSh3/NCe/8qFQgvShVUFBPRj+ZxP+cl6ZM5WoZywVDsZ3iJCv/weM5VGL2MdgRBzgBHQk5DdPIMNogIIPXlJnXpmNywWM2cpqZ6zviJKYlNu+Olg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(31696002)(86362001)(64756008)(66946007)(66446008)(110136005)(91956017)(66476007)(54906003)(66556008)(4326008)(2616005)(316002)(76116006)(508600001)(122000001)(38100700002)(6512007)(6506007)(53546011)(71200400001)(83380400001)(38070700005)(6486002)(8936002)(36756003)(2906002)(31686004)(5660300002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1V0OVJzQ2VxUURMUGdEb1hPVGRDaWxxNUhjemJqOUR5a0FINURBQTRCNUs2?=
 =?utf-8?B?SFRveFRNZG5DcW1TTWwxNm5mOVlnYjZ1UytLQnZXZlc3R0w0OFlYUnR0aVIv?=
 =?utf-8?B?UVJTbHIvM0NGSFdXclExb0llS0M4bDcwN2NmanJzQ2pLVHJSalprZW5aVVox?=
 =?utf-8?B?WXRScU96OEt3NjZoMmVNanMzckRsanVvMEFwSTkvVmV0eGVKalI4QS83dzMx?=
 =?utf-8?B?cnFwemVXMHpLQ3NBd05BeUZpRFdTek1GQzMzQjZscWdIWkdZcTloelY1OUU3?=
 =?utf-8?B?ZGNjaXpKRHZSdyt5dUZKMlBSOWxjeGhteVgvMklxR2tyYk5zQk0vWURoakM0?=
 =?utf-8?B?SlRzUW0yeGNtMzFYb0RzUURacnJVODBjdTRtSXpXTHI0MGFURS9rOWZyTDFl?=
 =?utf-8?B?RVdPU3E0dCtMbnFaYzIrZ0VCb0pjOHMzWmt3RjdqQUZPYXI2VHRSVk5PNzYz?=
 =?utf-8?B?RXBZQXBGcFZFNHdnV3NFU09NYUI5cEg3Z0xMVWxsKzFhbnBTUkl6OEtMbEh1?=
 =?utf-8?B?Y3JJeHh6VEdOdmJUREhZWCsvYmE2WG5xOGFCT1pVZHFSS2JNeDJlNzd4OEwx?=
 =?utf-8?B?RWQvc1FKcnJqaXJJZ3paS3VqNVBEa3h0Rk50QUFQWkFvSzVtVEZjVG1mNkR6?=
 =?utf-8?B?dlkybEZJZVkxQmlLL295NzFrQy9ZSk5jczUzZGxObmJncnVXTGh5cTlZcHRG?=
 =?utf-8?B?KzhpTUJDKzQ2dXVmR0wwSlpWVGZKV3kzcEE3M1l1djAvLzRNSmF4eEhBdjRz?=
 =?utf-8?B?REorNmRncm9hRHMwQTdMb3lhc0RGQjZBUkllbEdpUUFZNzNrZ0ZvMUFtNGlH?=
 =?utf-8?B?cE9GVS83SzdLTGlqOEM2bVVZUUl4NS9NRjZhR3ZZSGNCYzc0TzlYMmVKL1U2?=
 =?utf-8?B?d3FEaHJ4TVFDcXZoMjJXdlZSdE1pQWdhZDUrTHpKMkRpYlJwbmxPVno1T1dL?=
 =?utf-8?B?dFVkOUdXeVFUVGt0VytBUTNPeG1vZFpMUlZQdE15MVNKdnNMZ05pRGRZNjN4?=
 =?utf-8?B?SVQvRGduQytLY2dERDZCZkVqWXRqVUlJMDJXT0hDSTZKcUFncEJlSUFNeWM0?=
 =?utf-8?B?MHNnNlhPVGtrVVZiN3FFdG9xTTdJTjA0NjVrWXRzbGcrZDNQbk1CN3lXTEhm?=
 =?utf-8?B?b2I4Yk1oQ0ZYYnQ0QjE1NnRHQXNqTWE4ZFNaZEFibHA3SjFiY2RzeW1nM0tS?=
 =?utf-8?B?bFE2bUVEWmw5alNZN0NGMTliOWY3eS9KVXFWYkZGaDY5K0pwMVowK21vTHVT?=
 =?utf-8?B?VE5rekRQVDZpSmNIZVlNS2dYb1JkY0ovQkYzdnVTaUY0VWVHOU02cThtQWw3?=
 =?utf-8?B?OFZSTVBmOHRveXJrUVRFZ05FaVJ6UFFCQVI4UzRrczRaek9qK3MwREN0M05C?=
 =?utf-8?B?ZlZGN0JsVTVONlV5cUg1RS9mNDFIbThSK3ZZL0IvSW9nQ2xBZDFVdkJBUlUy?=
 =?utf-8?B?WTNFcnp2TXZPdTlXUTVjYmxnWXJNSUNvU25ZS1l6UUZGblNpcFZzZ1NUUGJJ?=
 =?utf-8?B?cHI4eGc5Nk8yKyszWE9sSVJkN0tTMUdIM3NSekxQWWwvek1JRktNZENXUktQ?=
 =?utf-8?B?a3E0eGdLd2VPdDVvUjhBYXQxZEd5YnBrOXhEMjRrOUx4TXZ2RU1nZEhGTUtr?=
 =?utf-8?B?N21WcWM2SkZ2Ung5MHlhWUxsSTdsNzNTTWphRmVkWFhib2sxTXRKTlNvMEZj?=
 =?utf-8?B?UnRMNUVnTDJqRlZpWHBXd2sraGpqMWxzaTVUKzhQWDlkMUpNdjZMTTg1Witq?=
 =?utf-8?B?UjJWajJPak5yUjBtWWh2dUw5NzhxbkY4Ync3THhNVm1DcmV5MmRmN1dsV3Vi?=
 =?utf-8?B?b1JuV2YydVhTUUYzcE9MeFI4MjdWdWVRS2FUM05mVjNYWDVnZURpdjNaY2dM?=
 =?utf-8?B?eGZ2dDkvMnM5eE1WR2FkUU85NE5NVjRLTmJ3aCtudEpqR0NGTE1MN2dlN014?=
 =?utf-8?B?SU91Z3BTOFNFcW9vc3VHL1Vkcmp6SnZielpOWklxSWNTWkhUMitrZkZ1QWQr?=
 =?utf-8?B?WlN0c0EzWHV5cVY3L290b21hTDJiWGZYWmp5ZkJ6K1JIWFp4QUdua2MrZFow?=
 =?utf-8?B?a2FRakJDa1RtMEY4b2NId3JBbThXWERTQkZUKzg1a1haM1R6U1lGYWZkczlO?=
 =?utf-8?B?OTRabTdYaUJKcStONWtVWGM1NjdvVUV1QjI5Tk10bCtIZklMTkZiQ29VY0Zh?=
 =?utf-8?B?anpPNmtxU2htQlMyREFKbG1MRG8zbTZxS1JxdGtlVld3ZkNUa0NDUmZmcUVn?=
 =?utf-8?B?ekxYbjFBNVpjZlN6QTRESEhSbGc5N1FtUmtxcllySmJEbEkwbE1ZMEZSMjlB?=
 =?utf-8?B?ZEM2WDU0WnAvaHQyK1hMeVdpY0F6RkNJQ2IyZ05RZXNxQzhXVklLYlczSTEz?=
 =?utf-8?Q?jWAdkD0HdgEGVQMJblKcBc1Jqs/IC81DLnxLZ19Yay3c4?=
x-ms-exchange-antispam-messagedata-1: 4lLHon7jCGT9GA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5797C490C62099459B4D0DBDAC378D69@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbfecef-e65d-4f5e-9124-08da1bb42269
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 12:09:31.0972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiWfHGwYHy+vs1YgFmC0qFXrUG0gtgaFLbhXxDjFOOk5j8rBP2DbJEjOuTTZSkWXl45nrDTDDa+TxGH32EIexg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_050935_349902_E25380EE 
X-CRM114-Status: GOOD (  19.52  )
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

T24gNC8xMS8yMiAwMzo0OSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+IEkgdGhpbmsg
d2UgY2FuIHNraXAgdGhlIHdob2xlIGNhbGwgdG8gbnZtZV9pbml0X25vbl9tZHRzX2xpbWl0cyBp
biB0aGlzDQo+Pj4gY2FzZS7CoCBBbmQgd2Ugc2hvdWxkIHByb2JhYmx5IGtleSBpdCBvZmYgaGF2
aW5nIEkvTyBxdWV1ZXMgdG8gYWxzbw0KPj4+IGNvdmVyIGFkbWluaXN0cmF0aXZlIGNvbnRyb2xs
ZXJzLg0KPj4NCj4+IEknZCBhbHNvIG1vdmUgdGhpcyBjaGVjayB0byB0aGUgY2FsbC1zaXRlIGlu
c3RlYWQgb2Ygd2hlcmUgaXQgaXMgbm93Lg0KPiANCj4gT2theSwgSSdsbCBhZGQgaXQgdG8gVjIu
DQo+IA0KPiAtY2sNCj4gDQo+IA0KDQpJbnN0ZWFkIG9mIGNoZWNraW5nIGZvciB0aGUgSS9PIHF1
ZXVlcywgd2UgYWxyZWFkeSBzZXQgbiBjYWNoZSB0aGUgDQptYW5kYXRvcnkgZmllbGQgY250cmx0
eXBlIGluIHRoZSBudm1lX2N0cmwsIGhvdyBhYm91dCB3ZSB1c2UgdGhhdCA/DQoNCm52bWUgKG52
bWUtNS4xOCkgIyBjYXQgDQowMDAxLW52bWUtY29yZS1jaGVjay1ub24tbWR0cy1vbmx5LWZvci1J
LU8tY3RybC5wYXRjaA0KIEZyb20gOTM5MTRmOWVkNDNlNzk3NDI5NGRjODE1Y2U2ZWQ2OGM5OTA0
NGYxNiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQpEYXRlOiBGcmksIDggQXByIDIwMjIgMTU6NTA6MTAgLTA3MDANClN1
YmplY3Q6IFtQQVRDSF0gbnZtZS1jb3JlOiBjaGVjayBub24tbWR0cyBvbmx5IGZvciBJL08gY3Ry
bA0KDQpWYWxpZGF0ZSB0aGUgY29udHJvbGxlciB0eXBlIGlzIE5WTUVfQ1RSTF9JTyBiZWZvcmUg
Y2hlY2tpbmcgdGhlDQpub24gbWR0cyBsaW1pdHMsIGFzIHdlIGRvbid0IHN1cHBvcnQgSS9PIGNv
bW1hbmQgc2V0IGZvciBkaXNjb3ZlcnkgYW5kDQphZG1pbiBjdHJsLCB0aGlzIGFsc28gbWFza3Mg
dGhlIGZvbGxvd2luZyB3YXJuaW5nIHJlcG9ydGVkIGJ5IHRoZQ0KbnZtZV9sb2dfZXJyb3IoKSB3
aGVuIHJ1bm5pbmcgYmxrdGVzdCBudm1lLzAwMjogLQ0KDQpbIDIwMDUuMTU1OTQ2XSBydW4gYmxr
dGVzdHMgbnZtZS8wMDIgYXQgMjAyMi0wNC0wOSAxNjo1Nzo0Nw0KWyAyMDA1LjE5MjIyM10gbG9v
cDogbW9kdWxlIGxvYWRlZA0KWyAyMDA1LjE5NjQyOV0gbnZtZXQ6IGFkZGluZyBuc2lkIDEgdG8g
c3Vic3lzdGVtIGJsa3Rlc3RzLXN1YnN5c3RlbS0wDQpbIDIwMDUuMjAwMzM0XSBudm1ldDogYWRk
aW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vic3lzdGVtLTENCg0KPC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLVNOSVAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPg0KDQpbIDIwMDguOTU4MTA4XSBudm1ldDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0g
YmxrdGVzdHMtc3Vic3lzdGVtLTk5Nw0KWyAyMDA4Ljk2MjA4Ml0gbnZtZXQ6IGFkZGluZyBuc2lk
IDEgdG8gc3Vic3lzdGVtIGJsa3Rlc3RzLXN1YnN5c3RlbS05OTgNClsgMjAwOC45NjYxMDJdIG52
bWV0OiBhZGRpbmcgbnNpZCAxIHRvIHN1YnN5c3RlbSBibGt0ZXN0cy1zdWJzeXN0ZW0tOTk5DQpb
IDIwMDguOTczMTMyXSBudm1ldDogY3JlYXRpbmcgZGlzY292ZXJ5IGNvbnRyb2xsZXIgMSBmb3Ig
c3Vic3lzdGVtIA0KbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3MuZGlzY292ZXJ5IGZvciBOUU4g
dGVzdGhvc3RucW4uDQoqWyAyMDA4Ljk3MzE5Nl0gbnZtZTE6IElkZW50aWZ5KDB4NiksIEludmFs
aWQgRmllbGQgaW4gQ29tbWFuZCAoc2N0IDB4MCANCi8gc2MgMHgyKSBNT1JFIEROUioNClsgMjAw
OC45NzQ1OTVdIG52bWUgbnZtZTE6IG5ldyBjdHJsOiAibnFuLjIwMTQtMDgub3JnLm52bWV4cHJl
c3MuZGlzY292ZXJ5Ig0KWyAyMDA5LjEwMzI0OF0gbnZtZSBudm1lMTogUmVtb3ZpbmcgY3RybDog
TlFOIA0KIm5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNzLmRpc2NvdmVyeSINCg0KU2lnbmVkLW9m
Zi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCi0tLQ0KICBkcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMgfCA4ICsrKysrLS0tDQogIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCmluZGV4IGU4ZDZhMWU1MjA4My4u
OTEzZWI0Y2VjMDQ4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQorKysg
Yi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCkBAIC0zMTAxLDkgKzMxMDEsMTEgQEAgaW50IG52
bWVfaW5pdF9jdHJsX2ZpbmlzaChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQ0KICAJaWYgKHJldCkN
CiAgCQlyZXR1cm4gcmV0Ow0KDQotCXJldCA9IG52bWVfaW5pdF9ub25fbWR0c19saW1pdHMoY3Ry
bCk7DQotCWlmIChyZXQgPCAwKQ0KLQkJcmV0dXJuIHJldDsNCisJaWYgKGN0cmwtPmNudHJsdHlw
ZSA9PSBOVk1FX0NUUkxfSU8pIHsNCisJCXJldCA9IG52bWVfaW5pdF9ub25fbWR0c19saW1pdHMo
Y3RybCk7DQorCQlpZiAocmV0IDwgMCkNCisJCQlyZXR1cm4gcmV0Ow0KKwl9DQoNCiAgCXJldCA9
IG52bWVfY29uZmlndXJlX2Fwc3QoY3RybCk7DQogIAlpZiAocmV0IDwgMCkNCi0tIA0KMi4yOS4w
DQoNCg0K

