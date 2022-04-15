Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF414C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 05:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iz5Wp+3v9LrYuxHi4agFqP0fu511cz1lRwqz9E+6cb4=; b=KRIEG5Y6Cl4Bm5wVh7Qg59csSd
	FQg245shOF7UTsLgkqs8B0kHXEGJWHoWjg7FOGByODS8M6Dirn4mS8+mR5jvgZSiq/gPwWceTGOMj
	XlRxfMqel+Rb5mU9fCNejydWaE6IqZIA4ukh0w8/I6GKYR3jYMLEJYW83COfwG6UzLWCJVZhpquiY
	GJbqQy9ZwOapszvkUzvwS3OeFcVvp4QOyeBOpchkwjoTlKnoxPN7vvN04sH+msnukC95/UDBTHRmL
	/FNHkyupCMfFycHVmI36qIoF3QzS1cNUK8ITVYRPLGLUpYkqf+yo3CRibqRU42DrKgJoZi+pFYu4c
	ri+tQEWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfEyQ-008nix-0k; Fri, 15 Apr 2022 05:58:26 +0000
Received: from mail-co1nam11on20621.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::621]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfEyM-008ngq-Q0
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 05:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3YkjfNTWRdm1GfWKNgpAf8qSXCjMLVTpkrg+3gO1SWwf14b4I9ndWRqAlCzR4ajyWuEAVovCHXMI1yJamuUPrS1i/rfJ+pDH5oFDtUpHKxbYAfkqLjwh0Z+EEUWqOKmLfdjcDL/a3sVypKYXhBsR2hq11xXNXpEG1IMD1GmVI7ajal5jP3aGK5pb2eXs5xGKJjj+5K+FVkhXqYSZH1TG/wz7yr0rVIiUCNXc819YcnOjB6hfPOTzY7jHQj0AiuHDzs1Amy+Sjw9HYHUscQS4xqUnvn8Hco/rkRbxSBcLDrdXpC36onZhIQS4bnmzqIGU1QaO9qjgGZAuBKXLE+AuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz5Wp+3v9LrYuxHi4agFqP0fu511cz1lRwqz9E+6cb4=;
 b=DCY4G0rRfCpbU6r2Dn7Ir2mWSKsrXnGX4x7VafRV9jpR5xQiVleYKYUt9uOOBbV00Lc4BoQCSaEc1rZldSAE9nGrr4/PGY1wnXjkP/+QZ2zjYYHfE8dGIxt5uv9DIcLMqPRc05kueUWX80iLk3NrqY1s0RU8/TxY9MzuBeWsde47tOFEHqZQR+AVd8Er6ekx41Dvu8wo6S5vR9cVcewNdkREwGCXwN/DYXfIfSUse9EhFQX+PufcESo9QwCn6KrVlD7WMlPkO6hAEiRUoxOr0SeziUW4cQClmONPAY10gjelYhKA9cq3k9pFrPuEYve4a530wSa6K8c/kMQhyPFByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iz5Wp+3v9LrYuxHi4agFqP0fu511cz1lRwqz9E+6cb4=;
 b=ci5VL8hptygWD/b3qpbBCRtBGd0ixcGeq02wC0sjp2lztfXT8eYvssEgQ8MIXyTYSIVBQiLj0CeHdwxjZ70VtIpDCRYbNQNGFw31SzgoXWaBlPtazWmiiFeX5bLe/jHkvBhSqaZvZ1MeKQt2SmxAPDiTbELDntbuLOLe1VUapnbSA4Zx3EuF81FWGK2qVkDF2W/wTRRrM/+Q4nJ0R79eQUSsgdftLOjSymzULJPUsMgX/otpDN3tXLIalSRn0rjJZ5kbjBjgP5OZlxp0BRIMAcVhxjwJ03FpTCJXmofihgaZTbXQF0QaHnIz865ZZUerHSaS8eXezZ+S8WDGvjpL/Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Fri, 15 Apr 2022 05:58:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:58:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>, Bart Van Assche <bvanassche@acm.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, "yi.zhang@redhat.com"
 <yi.zhang@redhat.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: can't run nvme-mp blktests
Thread-Topic: can't run nvme-mp blktests
Thread-Index: AQHYTszV+3u4N1FyaEK26iQxNB3DuaztRycAgADV6wCAAACpAIAAVTwAgAIAbwCAAAqZAA==
Date: Fri, 15 Apr 2022 05:58:16 +0000
Message-ID: <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
In-Reply-To: <YlkAlHe6LloUAzzN@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ababe9fc-79ce-491d-e3c5-08da1ea4ef77
x-ms-traffictypediagnostic: DM5PR12MB1513:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1513305AC17E6D2ED8644BA4A3EE9@DM5PR12MB1513.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3fos1XTQqYoa++MMHPMfDev3OBEuvRrgJXdRd95lM3sPg+DYp5G6nmr4gAT1/PB4l9k7wl0+atoVQOY52+0F5OH7ZcIIN/BvyDoGtTw2RK7sO8FCptM7VcxqXyPo5JCrQ6WMnQ34JP0stQz7ZPGIl/yCDJiWqXe55J18NgM73V0zJTJD1F2CdsiNPoY9Kd9N/GPeZ+fvT0B2ekDrBkdJfZYeeZc2Px8rO1yGjaaNRFCkmFOwfp74bd0XwiuAGSHTDyKlj6/k90EFzJBBhCOvzqhl1oplcwHcKxX2wAdNpuF3MikIhX2UeJ5DrcJxe9SH/4uvF720Tiqc8mgXF4mqwgTqUe6ruZhWwCvE5qw+wDVdhhVcbrsb3VT/+s3KZBnXoh+GhkSKkcZQuyQFpj+87ChQUwUjscQAe+JbvRoxMsh4+VV86gD6E0AH85h7HBX+ApJaLerwubu/aXryPg8yMrheXoF06MiKFdsrYGg1VfG3PaZUr/b1k7SmEEmD0T5T0q7EbYCn3YcM8eLnaeqV7slWYmgdNKTb9FFCrZVfKNapzgi0++4CMuQRzGpq49OmJ9POoiP47sM1e3uryhFTmvqE0ik1bs5jjdT3U96iKCRDLBhRZCisGyHNHuJCI2ntCAOt3EpQ2wexcE65RPfBqtK35DbJGPY8muiqodt3dKSfxB44WTQ0TwQrlLK7/stqGvBu+1Elb7nChCgO3W5ztlCvwRwoZL7h5hALYq3wzU2OHtRexD2iGXjoVkXCX9+shMNeQBkQPNgTYHoyvC1hOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(31686004)(6512007)(6486002)(316002)(5660300002)(71200400001)(54906003)(110136005)(2616005)(91956017)(83380400001)(186003)(66446008)(64756008)(66476007)(66556008)(66946007)(4326008)(8676002)(31696002)(508600001)(76116006)(86362001)(38100700002)(38070700005)(2906002)(36756003)(53546011)(4744005)(122000001)(8936002)(3480700007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0JTeXNrbE9OQVg3N0M1SEtBRlF1Rk82ZEF6S21rZk55Q1JuNEVjNGtqdG4r?=
 =?utf-8?B?S21ObHNEcmtKM1dkU0p2TzI4YkZnanQrdnR1VlQwUlVsMDdrZlB2WjdvSUpq?=
 =?utf-8?B?RkZYR3IycjByZllHMEFKYnQ0d3kzcFFRNkJtNytsS2xobEovNDdYd01wWUw5?=
 =?utf-8?B?Tld5djJLUlVpNkpkcGl2V1dDc2xRUUhlYWVYM0xoOW9laThKQVJsOHpyUE9q?=
 =?utf-8?B?SlkxM2VaSG1WUVRxa0N6RFo2b2ZKZStLSTVZMWo3ZjRFbjFiRFp2dHVCOWZw?=
 =?utf-8?B?WFRYWlI0emJ6Zm9HN21MTmNWS0loVmNUZ3ZyWmFTNjUyKzc2Rjc1ZUFBSi9r?=
 =?utf-8?B?RFdVOFVEYmtzbGJnUTNPeFh0Vnhza0R0SXkzN09WNEFTb1R0UTVSVjRMSFo4?=
 =?utf-8?B?T3M0d3gxVDRWSlFyMDNvL3NUbm9hT2Fpb0JIUitCSEFDR2IreFp5TEFINi9R?=
 =?utf-8?B?TFU4eE85NkF6SjdGVzNxcGx4M2syWHpUcC91M0ZKVXlrVW5PMTR3R2x5M0lU?=
 =?utf-8?B?Sy9lbloxeXJuR2l0WmwwSlpZaXJ3SGdPUHlrTWlXUm0wb1M5S2QxUGw2a2Zo?=
 =?utf-8?B?TGhwTklvdksvRUtOMU9KejZ6MHJ1M3F5SCszYS9GVk92UU5YMGpQbzRVOU50?=
 =?utf-8?B?eEFtWDZObjJrWm5CVTFUVEZDdVllOTk3VHJLU0YxaHVJcE5aK1pIOG14WGov?=
 =?utf-8?B?cllvbUorS0JHRzF4K0ZEbXpJbU1zcWt6N2MveTNoVWxLU3NaU0xRL3hma1gz?=
 =?utf-8?B?WjN1azVOdmh5SG5XZ3UwNHZJK2JLWTFiNzd5U3NLYngzK21UUTluQXQ4eGhs?=
 =?utf-8?B?U25aS1NtVEFWM1cxaTVlTHRLbFJrQU1LMGNTZ1A0ZTVVKzhiYkhwRm9OYk1t?=
 =?utf-8?B?QVNRMkFGWjNPNWdzVWVUYnEyTFhtOXRpNTMvZjJ4QiswaVQrKzVlTmdQZk51?=
 =?utf-8?B?ek1MTkllMWVCbWN1SVJFZEtTd1pPQjIyZEw1dXlkdndwUFVzTHRJYW9tQkRI?=
 =?utf-8?B?dGpVYjEzaVpLQ1BkQUdXb25HOGlkM2N0eHl3TXdwRXdVUGJTMFVBRkcrRTZV?=
 =?utf-8?B?MkVTSDdSMVpaNXpQU1c1T2h3ZjJ5MFBlZzByTE9NMlJiVWRhQzlXYWlnSnYy?=
 =?utf-8?B?OFRMOXBwRUJFRXQweENRZVdraU85LzkrZjNWdCs5djZPL0xvYzdkR3dmM2tl?=
 =?utf-8?B?Y0FyUFRVU1dpajNmbGcwWWNvbHpyVlhjMDVENFVJNkFEVGh1NFJHZVluMzJw?=
 =?utf-8?B?Y3F1MmtTOFk3V2YxdTQ4ZkFvRUg2OE4wOVlVNUxmb1J1QjE4WDlxTW5pd2Jq?=
 =?utf-8?B?MkM2ZE5LdXoxTGhvRjdWazA5aXZsVmcyUjV3MjBLM21FV0xnUjVGbnV3WWZn?=
 =?utf-8?B?YVpPQm9iVi92YnlGcVdidUw4eWN5dkV3WnZUZ1hMWFMyMG13OW9tZU51YzVM?=
 =?utf-8?B?ckY5c21uNUhYTTZjemgrMWhKcGpCQ0R1L2tMS0RHSU56eENxRUxJWG5UMVdy?=
 =?utf-8?B?K2NQU3ZwdVlQV29LUU1zK2FrUkNYYk9kZ3FUWkVPVzdnS3gyUlBPcVR4N2tl?=
 =?utf-8?B?d2JWSlpHYjlWWUlpY1ppU0VEdGZCcy8vUHFHS1pUMXpjaW5rOEZ0dWdOeml2?=
 =?utf-8?B?WTNUOVRmeVc0eEFqVXpTWEMvMTN6bldQN1VHZVFKTnJCRDYydGg3UkNkWHZy?=
 =?utf-8?B?YjQvZ29MWHQrUnNkUkZ5K3F3cCtEK29BU3QxNGlWWjZsN01iZVIvWmZ6a3ky?=
 =?utf-8?B?UjZwTisyVFY4VjVJWEtDWXlBUnFycElMMmtCRnc3V1ZLUmVobWVHQ1g1QUJ5?=
 =?utf-8?B?am5rZWxqcmpRZTFnQ1R2RzJpQnp6bG1hUVFISytrSkFKS2V4MUVoVWJJSHhz?=
 =?utf-8?B?eHFnRVRPUVlWbllNZk01dG9ZYkNiWGJkem5jeCsxYVZ2RVk5Zy9paFlnSmFQ?=
 =?utf-8?B?M1M1YS8vbFlmZnJZS2lhQ3BJa1ZKMUlUTXRSN3BBendkSk5VZERKd0l3Rk9m?=
 =?utf-8?B?OXRHUU5QTU1XYnhJdDIraXV5aE84ekZZMjVySHlnZ2h2SlZEbXBLOUExaGUv?=
 =?utf-8?B?VUloQjNOaG4yL1l5N2Y1N20yTTJhaWQrbkl1REtOTjdienY4Z2dCUkxoeGJE?=
 =?utf-8?B?V2VVL1pkaVh3Mm9Yb1I1UE9uZVlmWFZUSFMrRHRwY2J3dEdJVGE1cUVOMHhW?=
 =?utf-8?B?M241TVFWaDJTMEQ4VjZVZ1R1RjZkNEJmK0VoVG9mOHJwMU5YT2ZOZGxoZk0r?=
 =?utf-8?B?UEdzdUhwSFZVQnExUGdLL2YyeGdDL1lBbTJNM3NUREtXc1lra1dlUWx2dzY4?=
 =?utf-8?B?RlpQNk80d0ZGdEhveGxONzRyYWJRMWc5NXlzQjBmaHc3MndWVTQyNFhFOGVo?=
 =?utf-8?Q?p1ttOvU3gTcEnZdk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F65BEE46775CC4597CDBD95A0A38CF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ababe9fc-79ce-491d-e3c5-08da1ea4ef77
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:58:16.6646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBxYJPDTNFtw4mgyFPF/EgBoaETEAhkQBgzRSICCCA8wILC6F92uZgji9eDYw/IpIpvvYN013A9tGg6vtiImVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220414_225822_923845_83ACECD3 
X-CRM114-Status: GOOD (  12.64  )
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

T24gNC8xNC8yMiAyMjoyMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwgQXBy
IDEzLCAyMDIyIGF0IDAzOjQ2OjE2UE0gLTA3MDAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4+
IEknbSBub3Qgc3VyZSB3aGV0aGVyIHRoZSBudm1lLW1wIHRlc3RzIHRlc3QgYW55IGNvZGUgdGhh
dCBpcyBub3QgeWV0IHRlc3RlZCBieQ0KPj4gYW55IG52bWUgb3Igc3JwIHRlc3QuIEhvdyBhYm91
dCByZW1vdmluZyB0aGVzZSB0ZXN0cyBzaW5jZSB0aGVzZSB0ZXN0cyBtYWtlDQo+PiBpdCBoYXJk
ZXIgdGhhbiBuZWNlc3NhcnkgdG8gcnVuIGJsa3Rlc3RzPw0KPiANCj4gSSBoYXZlbid0IGxvb2tl
ZCBhdCB0aGUgZGV0YWlscyByZWNlbnRseSwgYnV0IGlmIHRoZXNlIHRlc3RzIHN0aWxsIGFyZQ0K
PiBiYXNpY2FsbHkgYSBjb3B5IGFuZCBwYXN0ZSBvZiB0aGUgc3JwIG1wYXRoIHRlc3RzIEknbSBh
bGwgZm9yIHJlbW92aW5nDQo+IHRoZW0hDQoNCklmIGl0IGRvZXNuJ3QgYWRkIGEgbmV3IHRlc3Qg
Y292ZXJhZ2UgaW4gdGhlIGJsa3Rlc3QgZnJhbWV3b3JrDQp0aGVuIHBsZWFzZSByZW1vdmUuDQoN
Ci1jaw0KDQo=

