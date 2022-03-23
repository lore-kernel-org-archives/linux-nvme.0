Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC891C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8dtrijHNAC0yod7pLll8blxx6cp4ntmhhj/UHYohdzY=; b=uaJfXgZ4BEQ082v4XL8al5+var
	v1dEuPiejUZLghJZSLJNngb9DrL0/sPPUsZ//PF4+k0/oRFWObmBgjoUebT0E/yNrVzq+yeOwbqX3
	XvcjYC9gR4b56oX7CPiZxiiCHk3wtY6UD3/nMjRXQG5xp6PVDEcJfE0UU+4iDtS9nV9ACR0Xebr7K
	kmLEw+0Rpmf1a0AI7sHkubLV/0hECIrw6LdScaRwsAIPnw+ehOmA8AihR5O11OoBeq1UK+I/L4MCL
	XWSj/43jw2fmIPH1sMX/DeN2Dt8x2DpSlhTniS/YyIDw/lo5UYyqgRtPgg6EA8tfFW3okscOuUgF+
	44jqz+wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX4sm-00ETDq-DS; Wed, 23 Mar 2022 17:34:52 +0000
Received: from mail-dm6nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::61a]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX4si-00ETD5-Rn
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 17:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liOzxRY/2J8oR4OVmdo2D/qGT0jURnE6Bmmm6XfG/zsoD0nA4U8ZMO2ZbEYPYS43AM6KsiQu17QLgfBQVEGgY38JZ3xNA79rXSWwdrHya4gprINW5TjcCDTCONYrBTAuVGw3pMmoC/Yz6UCXKBlV483sA2WHcUTL0wqLvs0KJa0n2Rkj9ydy5HlkactwSzj82LPJvGHm1ap/gqb1o34xp2rQSPF/AOOQAf/eQRJM/8H8/6JSGSOPRoQo8cr9uSDs29ajd9AT027th/U9h/7kgRyfQvGzDwEUAf0kbXOJHC8IJrK2UR6VDJwbnR4e31Lek2veJCzWnGpH4vyuoEsEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dtrijHNAC0yod7pLll8blxx6cp4ntmhhj/UHYohdzY=;
 b=lVGVp+G7viVfNzd8BHurFkjFWfbpVRfeBUqHinTepRkdVqT3RCSFzIU/ZxVqTmoxWH2kVjwfn3mIl3KC8DSN+MmGEFH33tDSFL9c1EMUr9oR/BD+ER/5rKW0SzQ7MlFZJZx147DoaUeh5nPYjfQ3ZLgYU1N9t+Dfde2ongt1s20uF9fZ3wpaXZpzVtqxMS9ak1+33enVwv/sB5qp0PSk+IbePwUEAGi0wRwS/BOI3ldtHb+LcP82wMH2fLr9bbhfM1yfO+JslY3S4PJErIvrJea/99c831fqoNqLLW6iGxAeLR1fYqppzzO3g/drgNNYSorpOXaonFpVUVx50nfEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dtrijHNAC0yod7pLll8blxx6cp4ntmhhj/UHYohdzY=;
 b=SRHW//prYqiZQGibQQ3p19mYkv0i79Mj9oJLZRTpAgeKvEghvzsrPRrKIGBgoiAtqAHwhYMD2xu+iqkSv4+qKxQUjxUyawPc6UU5qDXr3IhkVyScJ4hXgKtHve+1GdeHIwtNWfid0ITNMHswKFwcenddNvcs80bw/m5cEfAPUfDgi/+O+rnoKMXi0JQMQy4jkJJRF3hNC/rbNnxLCLBm2TZ7vZfaJMPgFCQHuNSfQ6CduBRiYe93OaV8YMfQqHwPUiz9hHHaAoe5La9wfrpp7c/U88DqPytr7jBnOwRHNW6cJj+LCNnmTB8AnF0e+6oPVt+MqanZlfTN/3Q/MZ/8BA==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 MWHPR06MB3472.namprd06.prod.outlook.com (2603:10b6:300:121::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Wed, 23 Mar 2022 17:34:45 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::2d43:b548:21c9:699c]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::2d43:b548:21c9:699c%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 17:34:45 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: John Meneghini <jmeneghi@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chris
 Leech <cleech@redhat.com>
Subject: RE: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Thread-Topic: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Thread-Index: AQHYPtnpTi7jgQcoLUOifsjMcQoVg6zNOZkg
Date: Wed, 23 Mar 2022 17:34:45 +0000
Message-ID: <DM8PR06MB770422A304E46F38AD030A21F1189@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <089e3056-e603-bd9e-6680-52a26cafa72e@redhat.com>
In-Reply-To: <089e3056-e603-bd9e-6680-52a26cafa72e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.400.34
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2baef894-e532-49a7-dc4f-08da0cf36be0
x-ms-traffictypediagnostic: MWHPR06MB3472:EE_
x-microsoft-antispam-prvs: <MWHPR06MB34721E18C61FCC5558739333F1189@MWHPR06MB3472.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlgrQJiDcezcr1eS7h+DfCcmyWUSbOuawmZ3/L1y3+AbILwjyS6GJWNvnYeAQQUDSW3bw+RREeEI4YX2cL+AuNdVHJDJyPn0gR9toamqd07AxNmgdgSC/1/IkoOITqq1cxQMLf+zEpZYqvdTTu3Me6pdZvkc6t+qEZYwjg1OGcVl9u4OPSar7Z8dcSnk6EAQDdXpaY9iM8pebiS45+pPt2jABh0d6oRoeqEf4xZ3tL++aYgwMBhSzDkEUEWa6cnBpy23GBBKVJUKoEq0YJD+0H8Rl/IHh3HtKN3PFav36wnExh5tY50ZoOMMcywQqeEDlXqaRQYEpI1cTeXJP3jmEELxY9bykps1Rg2GmHaAnmcl1NYYQfcgsOKA3WFizT6RhSnGji1HrJVhInkbAq2rSjdGPwVDzCh7qH+x3gCUixQbPMc++10/x/331pqAbw5dgGkxmHU+blF/hIrrx+AIVzvf5hzFt8AL7jmqAvwwXDAWiaXt8GY9GMeYQ/MCF2ArMqsZF/m+oH2jTHpsJFL2Q/SO3Q/oE3EdeZJSMKOzwoLwceVFX94q6hgIXKhiQCqrcMerHPoxfmZZ9cUoQqUV/u1yWomPziPoa9cS784v1yxvfh34Jn0ixbB76P9qo62J899/6q1F6+QmSKmA7LMnw6SK6OGlz9sCiuln4ukN+E+SBypfiYPe+v9f4po5qsXYza6JQT44oq1+CIf6q93Esg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR06MB7704.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(83380400001)(186003)(26005)(86362001)(33656002)(38100700002)(38070700005)(122000001)(2906002)(71200400001)(55016003)(316002)(76116006)(52536014)(8676002)(4326008)(508600001)(66556008)(8936002)(64756008)(5660300002)(66946007)(66476007)(66446008)(6506007)(7696005)(53546011)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUxHWUcwck9NUGhwWGxYMkRUQ200KytXajN4a3lNbTNNZm5nYjVrV0R3Vndp?=
 =?utf-8?B?WTdaT2svNUt2NVZIV0NuZGU4eUd0RWdaK2dMdzBCUnVsRElHd1Z2RXFRbDlB?=
 =?utf-8?B?QVhTMnJyWTZQYS9mZk9YVTIwYlByQ3FUUjVqNGZnbWRCR1NXeVovZkE1VXk3?=
 =?utf-8?B?Y0R6Nmc1ZXRjUFBHSXUwTjRlQ0ZDVWRwd3c2QzVVS2ppYUFnY291b3cvL0JY?=
 =?utf-8?B?T2JyUGUyQkx6OWpSOTZ4dTZ3c21QOGJkMUxUemttdThQK2JRRXduS3ptWFRy?=
 =?utf-8?B?V08yYUNvOUhYVmhzZVk5WFkzL0xzd1NTemg2bTEyZ0szWDdNRXRCajhoUE41?=
 =?utf-8?B?TEt1WHNKNWVNdUs2ZEVyS3NvZlpua00xZCtCRFdBKzNqS0Z2dmNpMzJkUFc0?=
 =?utf-8?B?b0lGVFlnZTFPbVBWTU1RMHUxNzU2alFaUnJaTG5aM3hKdDNtWGV1TnFJQ1A3?=
 =?utf-8?B?RGcwQ1RDemtMOVFWZTBnSjk0SVpjM2ZPc0JpSDJmNDhnRDVDMWFGSGozc3Vv?=
 =?utf-8?B?WitUZ2xpeVlINTlYZml0R2xhYUZyNmhXKzRNOG5kbHRSYWJ2NFhsTXNEc0xV?=
 =?utf-8?B?Nit6aktXT3pwUVFEWXF4OVVZdlg3UURJK21teEZXTmpEQnFhUEhaMFdtNnFN?=
 =?utf-8?B?WUdQQThrZHVDd2VQTnk3M2Z0Mm1TemNhUFZ5ZTdGdW5jamM1QVZFVWNKNytQ?=
 =?utf-8?B?SWttQlNrSm01OTZtY2hvUFI4U1FISDBhU25BK2ZpRnJ4Q1hWamdiMEQ5cEE2?=
 =?utf-8?B?eFp4VVlaeWZiYnZYQzM4QkFXK2ZFYmVocEZZZ29ieWNMb0NPYVRWcGhleEl2?=
 =?utf-8?B?ZnU3VlRYRDJJMFNDdSs5VisvdmFTOVV1djJNRHh0TUxaalUrcGZyN2FyeWs4?=
 =?utf-8?B?MkJBa2Z0ZU5zQ3ZlUUpYdmpHL0JtZm1OeVo1elUyWUZZbS9SaFZvTEVPWVp4?=
 =?utf-8?B?SFY0V1NwQUhmYUVySDdBbm1kS0dvQXZ2NlJaRGdNTlRwejlQdHRvcHBwdVZx?=
 =?utf-8?B?K203ZFhMV0pUVUh1TkprQnQ5cmhTQlpMeWJlR0JJclllL3Q5dGdpNUhQY21V?=
 =?utf-8?B?Ly9qQzFPRVJEaisyalZ1emFFZjNXTmh1a2NJRHBlSzB3NHg2emJocG9wRklk?=
 =?utf-8?B?cVpYQWNCMExycVFsMkFHSTE1UXVpdHhWNmFGRGZPc2lINzVVMTdHNHhhOVdS?=
 =?utf-8?B?VDdrMlRYaE9PckFuVWNiLzdQUmpUc2QzR2xXeEdZUEZORnF1UDNiSmRZRjk0?=
 =?utf-8?B?TjhRNmJKYWt4QytlZ2U2ZzhDWEo0WmZYeDNma25sSVJ3cjZkWW0vdzVtU3lP?=
 =?utf-8?B?TlFFQk1lMldjalRMSWluSzBEVnoxY3JQMmN5OUNORTAvcnhRMG8vUndWTTBM?=
 =?utf-8?B?R24zL25PakQrcGp4OUpvU1VUQi9IVm1RRTZ3YnhRQ2hrU2FQK0JsQ1RtQ0RZ?=
 =?utf-8?B?czZ0Uk5XaWJOSTNROHdGQlNLTFRxRWdMWVFrcnlJUStERFpJZVI5cDVZa0Iy?=
 =?utf-8?B?NnA4YzN3bGs5WEI2TjNxRXlhNUprM0lQZm1MaDZUMlBCOHdYOFhEUXhlSTRN?=
 =?utf-8?B?TGhoaVcyanliOEd4b1kxSWRrTzdudkRTNDkwbUNlZW9zY3MzUXJYM0F3MEgw?=
 =?utf-8?B?eStiMXYxVWUvS3A5Zk41eG5YVXowS1NZTUc5S3JEcDF0Rm5OTFNQYk00NTcr?=
 =?utf-8?B?WlNRQ3UyNFV1aG50YXdPVkgzK08wc0RVNDcwcnNlZUJoeUo3WTFJaXFXVThG?=
 =?utf-8?B?SmJxc2Qxb1MrM3IwMmZQNk1zS3pSNC9UcW9lUG9xM092VmtiNU9QV3J2VTNp?=
 =?utf-8?B?Y0x2akZLaFIrMlhNVFJLQWVRUjZrenFnZE1JZm1CVW5TOG9PRXlFb0p6QnU3?=
 =?utf-8?B?TGwxeVdFSzRsemFPQUlsbGdncVpyRHF6ZThEeGpON2dLZGdFNklWN0xYaW1h?=
 =?utf-8?Q?VVAHSja92Lw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baef894-e532-49a7-dc4f-08da0cf36be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 17:34:45.2206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWW09zYb+umoaaVPjGsYLWNlYv1bYAFm7RVz5GqkZPwYSs+ZdiBHuLfAj0KvrfWwfzHAdO2XOWQFVEzsKPxqYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB3472
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_103449_005127_7E97135A 
X-CRM114-Status: GOOD (  45.74  )
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

UGxlYXNlIGRvbid0IG1ha2UgdGhpcyBhc3N1bXB0aW9uOg0KDQogIDMuIEhvc3RzIHRoYXQgc3Vw
cG9ydCBBdXRoZW50aWNhdGlvbiBjYW4gdGhlbiBkaXNjb25uZWN0IGZyb20gdGhlIFdlbGwgS25v
d24NCiAgICAgRGlzY292ZXJ5IENvbnRyb2xsZXIgYW5kIHJlLWNvbm5lY3Qgd2l0aCB0aGUgVW5p
cXVlIERpc2NvdmVyeSBOUU4uIFRoZXNlDQogICAgIGhvc3RzIHNob3VsZCBleHBlY3QgYW4gQVVU
SFJFUT0xIHJlc3BvbnNlLg0KDQogIDQuIEhvc3RzIHRoYXQgZG9uJ3Qgd2FudCB0byBzdXBwb3J0
IEF1dGhlbnRpY2F0aW9uIGNhbiBpZ25vcmUgdGhlIFNVQlRZUEUgMDNoDQogICAgIExvZyBQYWdl
IEVudHJpZXMgYW5kIG9wZXJhdGUgbm9ybWFsbHkuIFRoaXMgd291bGQgaW5jbHVkZSBsZWdhY3kg
aG9zdHMuDQoNClRoZXJlIHNob3VsZCBiZSBOTyBhc3N1bXB0aW9uIHRoYXQgc3VidHlwZSAwM2gg
cmVxdWlyZXMgYXV0aGVudGljYXRpb24uICBJdCBzaG91bGQgdXNlIEFVVEhSRVEgb25seS4NCg0K
QW5kLCB3aGlsZSB1c2luZyBhdXRoZW50aWNhdGlvbiB3aXRoIHRoZSB3ZWxsLWtub3duIGRpc2Nv
dmVyeSBjb250cm9sbGVyIE5RTiBpcyBub3QgcmVjb21tZW5kZWQgKGFuZCBub3QgdmVyeSBzZWN1
cmUpLCB0aGVyZSBpcyBub3RoaW5nIHRoYXQgcHJldmVudHMgdGhlIHNldHRpbmcgb2YgQVVUSFJF
UT0xIHdoZW4gdXNpbmcgdGhlIHdlbGwta25vd24gZGlzY292ZXJ5IGNvbnRyb2xsZXIgTlFOOyBz
byBhZ2FpbiwgSSB3b3VsZCBzdWdnZXN0IHlvdSBkbyBub3QganVzdCBhc3N1bWUgdGhhdCBpcyB0
cnVlLCBhbmQgdGhhdCB0aGUgaG9zdCBzdGlsbCB1c2UgQVVUSFJFUSB0byBjb250cm9sIGF1dGhl
bnRpY2F0aW9uIG5vIG1hdHRlciB3aGF0L3dobyB5b3UgYXJlIHRhbGtpbmcgdG8uICBBcyBmb3Ig
dGFyZ2V0cyAtIHRoZXkgYXJlIGZyZWUgdG8gaW1wbGVtZW50IHdoYXQgdGhlaXIgY3VzdG9tZXJz
IHJlcXVpcmUuDQoNCglGcmVkDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBKb2huIE1lbmVnaGluaSA8am1lbmVnaGlAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAyMywgMjAyMiAxOjE4IFBNDQo+IFRvOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT47IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiBDYzogU2FnaSBHcmlt
YmVyZyA8c2FnaUBncmltYmVyZy5tZT47IEtlaXRoIEJ1c2NoDQo+IDxrZWl0aC5idXNjaEB3ZGMu
Y29tPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBLbmlnaHQsIEZyZWRlcmljaw0K
PiA8RnJlZGVyaWNrLktuaWdodEBuZXRhcHAuY29tPjsgQ2hyaXMgTGVlY2ggPGNsZWVjaEByZWRo
YXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gbnZtZXQ6IGV4cG9zZSBkaXNjb3Zl
cnkgc3Vic3lzdGVtIGluIHN5c2ZzDQo+IA0KPiBOZXRBcHAgU2VjdXJpdHkgV0FSTklORzogVGhp
cyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yDQo+IG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29u
dGVudCBpcw0KPiBzYWZlLg0KPiANCj4gDQo+IA0KPiANCj4gU29ycnkgSSdtIGxhdGUgdG8gdGhl
IHBhcnR5LiAgUGxlYXNlIHNlZSBteSBjb21tZW50cyBiZWxvdy4NCj4gDQo+IE9uIDMvMTUvMjIg
MDU6NDksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+IE9uIFR1ZSwgTWFyIDE1LCAyMDIy
IGF0IDEwOjA2OjI2QU0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gPj4gVGhlIGNv
cmUgcXVlc3Rpb24gcmVhbGx5IGlzOiBkbyB3ZSBfd2FudF8gdG8gZXhwb3NlIHRoZSBkaXNjb3Zl
cnkNCj4gPj4gc3Vic3lzdGVtIGluIGNvbmZpZ2ZzPw0KPiA+DQo+ID4gV2VsbCwgaWYgeW91IHdh
bnQgYSBmcmVlbHkgY29uZmlndXJhYmxlIG9uZSB3ZSBraW5kYSBoYXZlIHRvLCByaWdodD8NCj4g
Pg0KPiA+PiBVbmZvcnR1bmF0ZWx5LCBleHBvc2luZyB0aGUgZGlzY292ZXJ5IHN1YnN5c3RlbSBh
bmQgdHJ5aW5nIHRvDQo+ID4+IGNvbmZpZ3VyZSBpdCB3aXRoIGNvbmZpZ2ZzIGRvZXMgX25vdF8g
bWF0Y2ggd2l0aCB0aGUgd2F5IGRpc2NvdmVyeSBpcw0KPiBpbXBsZW1lbnRlZCB0b2RheS4NCj4g
Pj4gV2hpbGUgd2UgY3VycmVudGx5IG9ubHkgaGF2ZSBhIHNpbmdsZSBkaXNjb3Zlcnkgc3Vic3lz
dGVtLCBpdCB3aWxsDQo+ID4+IG9ubHkgZXZlciByZXR1cm4gdGhlIHN1YnN5c3RlbXMgdmlzaWJs
ZSBmcm9tIHRoaXMgcGFydGljdWxhciBwb3J0Lg0KPiANCj4gSSBkb24ndCBzZWUgd2h5IHRoaXMg
d291bGQgbmVlZCB0byBjaGFuZ2UuIFdoYXQgaXMgaXQgdGhhdCB5b3Ugd2FudCB0bw0KPiBjb25m
aWd1cmUgaW4gdGhlIG5ldyB1bmlxdWUgZGlzY292ZXJ5IHN1YnN5c3RlbShzKSB0aGF0IHdvdWxk
IGJlIGFueQ0KPiBkaWZmZXJlbnQgZnJvbSB0aGUgZXhpc3Rpbmcgd2VsbCBrbm93biBkaXNjb3Zl
cnkgc3Vic3lzdGVtPw0KPiANCj4gPiBXZWxsLiAgVGhlIG9yaWdpbmFsIEZhYnJpY3Mgc3BlYyBo
YWQgdGhpcyBjb25jZXB0IG9mIHRoYXQgbWFnaWMNCj4gPiBkaXNjb3ZlcnkgTlFOLCB3aGljaCBp
bXBsaWVzIHRoYXQgdGhlcmUgaXMgb25lIHN1YnN5c3RlbSAob3IgbWFueQ0KPiA+IHByZXRlbmRp
bmcgdG8gYmUgb25lKS4gIEFuZCB0aGF0IGlzIHdoYXQgdGhlIGltcGxlbWVudGF0aW9uIGZvbGxv
d2VkLg0KPiA+IFRoZSB2YXJpcHVzIDgwPz8gVFBzIHRoZW4gbWFkZSBhIGNvbXBsZXRlIG1lc3Mg
b2ZmIHRoYXQuDQo+IA0KPiBJIGFncmVlIHRoYXQgRk1EUyBoYXMgbWFkZSBhbiBvdmVybHkgY29t
cGxpY2F0ZWQgbWVzcyBvZiBOVk1lLW9GDQo+IERpc2NvdmVyeSB3aXRoIHRoZSBuZXcgRGlzY292
ZXJ5IFRQcy4gSG93ZXZlciwgSSBhbSBob3BpbmcgdGhhdCBUUC04MDEzDQo+IGFuZCBUUC04MDE0
IGNvdWxkIGJlIHVzZWQgdG8gaGVscCB3aXRoIHNvbWUgb2YgdGhlIHByb2JsZW0uDQo+IA0KPiA+
PiBIZW5jZSB0aGlzIHJhdGhlciBzaW1wbGUgYXBwcm9hY2gsIGhhdmluZyB0aGUgJ25vcm1hbCcg
ZGlzY292ZXJ5DQo+ID4+IHN1YnN5c3RlbSBleHBvc2VkLCBhbmQgbGV0IHRoZSBhZG1pbiBjb25m
aWd1cmUgaXQgYWNjb3JkaW5nbHkuDQo+ID4+DQo+ID4+IEkgY2FuIGxvb2sgYXQga2VlcGluZyB0
aGUgaW50ZXJuYWwgaW1wbGVtZW50YXRpb24sIGFuZCBvbmx5IGV4cG9zZQ0KPiA+PiB1bmlxdWUg
ZGlzY292ZXJ5IGNvbnRyb2xsZXIgKGllIHRob3NlIHdpdGggYSB1bmlxdWUgc3Vic3lzdGVtIE5R
TikuDQo+ID4+IFRoYXQgd291bGQgcmVtb3ZlIHRoZSBuZWVkIHRvIGhhdmluZyB0aGUgJ2Rpc2Nv
dmVyeV9ucW4nIGF0dHJpYnV0ZSwNCj4gPj4gYW5kIGFkZHJlc3MgQ2hyaXN0b3BocyBjb25jZXJu
cy4NCj4gPg0KPiA+IEkgc3VzcGVjdCBpZiB3ZSB3YW50IHRvIHN1cHBvcnQgYWxsIHRoZSBuZXcg
bWVzcyBmcm9tIHRoZSBGTURTIGdyb3VwDQo+ID4gKGFuZCBtYXliZSB3ZSBuZWVkIHRvIHF1ZXN0
aW9uIHRoZSB3aHkgYSBsaXR0bGUgbW9yZSksIHRoZW4gd2Ugc2hvdWxkDQo+ID4gc28gc29tZXRo
aW5nIGxpa2U6DQo+ID4NCj4gPiAgICgxKSBrZWVwIHRoZSBleGlzdGluZyBnbG9iYWwgTlFOLWJh
c2VkIGRpc2NvdmVyeSBhcy1pcy4NCj4gDQo+IEkgYWdyZWUgdGhhdCB3ZSBuZWVkIHNvbWUgd2F5
IHRvIHN1cHBvcnQgbGVnYWN5IGhvc3RzIGFuZCBsZWdhY3kNCj4gY29udHJvbGxlcnMgaW4gdGhl
IHNhbWUgZmFicmljLiBXaGF0IGV2ZXIgd2UgZG8gd2l0aCBUUC04MDEwLCBldGMuLCB3ZSBuZWVk
DQo+IHRvIGJlIHN1cmUgdGhhdCBhbGwgaG9zdHMgYW5kIGFsbCBkaXNjb3ZlcnkgY29udHJvbGxl
cnMgaW50ZXJvcGVyYXRlIGNsZWFubHkuDQo+IA0KPiA+ICAgKDIpIG1heWJlIGFkZCBhIHBlci1w
b3J0IGtub3duIHRvIGFsbG93IGRpc2FibGluZyBpdCBpZiBwZW9wbGUgcmVhbGx5IGNhcmUNCj4g
PiAgICgzKSBhbGxvdyBjcmVhdGluZyBhZGRpdGlvbmFsIGRpc2NvdmVyeSBzdWJzeXN0ZW1zIHdp
dGggbm9uLWRlZmF1bHQNCj4gPiAgICAgICBOUU5zIHRoYXQgZG8gbm90IGF1dG9tYXRpY2FsbHkg
Z2V0IGFueXRoaW5nIGFkZGVkIHRvIHRoZW0gYW5kIHdpbGwNCj4gPiAgICAgICBqdXN0IGJlIGNv
bmZpZ3VyZWQgYXMgbmVlZGVkIHRocm91Z2ggY29uZmlnZnMNCj4gPg0KPiA+IEJ1dCBtYXliZSBm
aXJzdCB3ZSBzaG91bGQgdGFrZSBhIHN0ZXAgYmFjayBhbmQgZmlndXJlIG91dCB3aGF0DQo+ID4g
c3VwcG9ydGluZw0KPiA+IFRQQVI4MDEzIGV2ZW4gYnV5cyB1cz8NCj4gDQo+IFRQLTgwMTMgd2Fz
IGRlc2lnbmVkIHRvIHdvcmsgd2l0aCBUUC04MDE0LiBJbiBmYWN0LCBhdCBvbmUgcG9pbnQgd2Ug
dGFsa2VkDQo+IGFib3V0IGNvbWJpbmluZyB0aGVzZSB0d28gVFBzIGludG8gYSBzaW5nbGUgVFAu
IFRoZSBpZGVhIGJlaGluZCBUUC04MDEzICYNCj4gODAxNCB3YXM6DQo+IA0KPiAgIDEuIEFsbCBo
b3N0cyB3aWxsIGNvbm5lY3QgdG8gdGhlIGV4aXN0aW5nIERpc2NvdmVyeSBTZXJ2aWNlIHdpdGgg
dGhlIFdlbGwNCj4gS25vd24NCj4gICAgICBEaXNjb3ZlcnkgTlFOIGFuZCByZXRyaWV2ZSB0aGUg
RGlzY292ZXJ5IExvZyBwYWdlcyBmb3IgdGhlIEhvc3ROUU4NCj4gcHJvdmlkZWQNCj4gICAgICBp
biB0aGUgRmFicmljIENvbm5lY3QgY29tbWFuZCwgYXMgaXQgaXMgZG9uZSB0b2RheS4NCj4gDQo+
ICAgICAgSXQgd2FzIGFzc3VtZWQgdGhhdCBBdXRoZW50aWNhdGluZyB3aXRoIHRoZSBXZWxsIEtu
b3duIERpc2NvdmVyeSBOUU4NCj4gd291bGQNCj4gICAgICB3b3VsZCBub3QgYmUgbmVlZGVkIG9y
IHN1cHBvcnRlZCBiZWNhdXNlOg0KPiAgICAgIGEpIFRoZSBEaXNjb3ZlcnkgQ29udHJvbGxlciBj
b250cm9scyB0aGUgQXV0aGVudGljYXRlIHdvcmsgZmxvdyBhbmQNCj4gICAgICAgICByZXR1cm5p
bmcgQVVUSFJFUT0xIGluIHRoZSBjb25uZWN0IHJlc3BvbnNlIHdvdWxkIGJyZWFrIGxlZ2FjeQ0K
PiBob3N0cy4NCj4gICAgICBiKSBJdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSBhIFdlbGwg
S25vd24gRGlzY292ZXJ5IE5RTiBhcyBhIHBhcnQgb2YNCj4gYSBwc2suDQo+IA0KPiAgIDIuIERp
c2NvdmVyeSBDb250cm9sbGVycyB3aGljaCBzdXBwb3J0IEF1dGhlbnRpY2F0aW9uIGNhbiByZXR1
cm4gRGlzY292ZXJ5DQo+ICAgICAgTG9nIFBhZ2UgRW50cmllcyB3aXRoIFN1YnN5c3RlbSBUeXBl
IChTVUJUWVBFKTogMDNoIC0gYXMgZGVmaW5lZCBieSBUUC0NCj4gODAxNC4NCj4gICAgICBUaGVz
ZSBETFBFcyB3aWxsIGNvbnRhaW4gVW5pcXVlIERpc2NvdmVyeSBOUU5zIC0gYXMgZGVmaW5lZCBi
eSBUUC04MDEzDQo+IA0KPiAgIDMuIEhvc3RzIHRoYXQgc3VwcG9ydCBBdXRoZW50aWNhdGlvbiBj
YW4gdGhlbiBkaXNjb25uZWN0IGZyb20gdGhlIFdlbGwNCj4gS25vd24NCj4gICAgICBEaXNjb3Zl
cnkgQ29udHJvbGxlciBhbmQgcmUtY29ubmVjdCB3aXRoIHRoZSBVbmlxdWUgRGlzY292ZXJ5IE5R
Ti4NCj4gVGhlc2UNCj4gICAgICBob3N0cyBzaG91bGQgZXhwZWN0IGFuIEFVVEhSRVE9MSByZXNw
b25zZS4NCj4gDQo+ICAgNC4gSG9zdHMgdGhhdCBkb24ndCB3YW50IHRvIHN1cHBvcnQgQXV0aGVu
dGljYXRpb24gY2FuIGlnbm9yZSB0aGUgU1VCVFlQRQ0KPiAwM2gNCj4gICAgICBMb2cgUGFnZSBF
bnRyaWVzIGFuZCBvcGVyYXRlIG5vcm1hbGx5LiBUaGlzIHdvdWxkIGluY2x1ZGUgbGVnYWN5IGhv
c3RzLg0KPiANCj4gSG9wZWZ1bGx5LCB3aXRoIHNvbWUga2luZCBvZiBhIGRlc2lnbiBsaWtlIHRo
aXMsIGJvdGggbGVnYWN5IChub24tDQo+IGF1dGhlbnRpY2F0aW5nKSBhbmQgbmV3IChhdXRoZW50
aWNhdGluZykgaG9zdHMgYW5kIGRpc2NvdmVyeSBjb250cm9sbGVycyBjYW4NCj4gaW50ZXJvcGVy
YXRlLg0KPiANCj4gL0pvaG4NCg0K

