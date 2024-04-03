Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB05CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 22:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jlNz7xGHIN5XfJxWT14PGdpI0va0oIdzqQiW97vYIZU=; b=Bv1/4WHDAt7om03OqY0x3C+qPr
	qGANmnFnZ8dXLPubKSw8RRdOl8dpWbIwCgeYiJBhwbrtwugGJjKTTjEjb90oYNsi2Z0YBzS8/n4M1
	W8nUbRYD5E1p6yNI+in+GlqR3VWG3HbW/Go1ER89w1hLyzgqV9APgVeaEQ0/9rJdFpt6jbqGSkreW
	G1ePOQctPSDZRAaFYLMeYwp5F6WVoPQRabAJxcr8p9EstScFy6za1PKRjY9qAWEDYQf26kq6UeOGy
	z/jcxVzQub89o96DPFoWJHTcZG+LPvC3zGrv+UV9jCbVybbEWPaosG9Jbqdkq4wwhgctN7D5NqTX/
	hVRGIsTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs8zO-00000000NSt-1rLg;
	Wed, 03 Apr 2024 22:21:50 +0000
Received: from mail-bn8nam11on20700.outbound.protection.outlook.com ([2a01:111:f403:2414::700] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs8zG-00000000NRS-1cns
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 22:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQPDfnlDsy3IM39A3P9F+P7+31W/pzpc+VagcEL3cImFAGjMk/1he0vrwp6ot6zUKDFIZsDU2Nn0BbEqfThUPApdRkCgmogor70qf3oIzpv5Sobz+oyVdGvhMsF4tbdSJVQkfONbS7tSUqmqfQlcGFcbFnuMJrKsNVLx0n3OrpcmNUdWr9Ufn8MZMGO9vHr4ug9KZIbYtjEl+ffCj5sY23ueTXXQ1DN4KrHS05Tf2hn2753LM0FF/+oIcCvQujmeLIW4JrJ9Smc0MwilIs6CGRNx4Yyl6qT6E4Qkc077/qeNFjEcWCWW7FUoSOOZMhkXwmmAz1WdCHbTWEXHRxl4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlNz7xGHIN5XfJxWT14PGdpI0va0oIdzqQiW97vYIZU=;
 b=dBfIG8DzRAyZZixyLG2crNKK+H5fnzBkPjEKE1dyLqr8atucUlRWBiWaMGYJCiicN3csBc97i0bMPehGJ9E/XtKbdVq0mJ1hsaOnmIiVqAnYzDnmhfzePEbO0dpEAAW0M6lVr2USDiTxwL3p9YRD9CyNbJY6jI0nRPEtCIPwyx6f8/1mHX93H8xfDFpWjixTntdyYUtnLiEkYKkmeVpF65D2O0yfVvz7gqcuY5B/IU6CqbBdtxpwG6JMqZl00NBlcgAipbtwDw0PGUbMO7Ue6nzmekSkeTDCclpnH+rXAqwi5iSbGuIMMkeB33rbvLMVB+VJA6BQqabFtmsq7FCbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlNz7xGHIN5XfJxWT14PGdpI0va0oIdzqQiW97vYIZU=;
 b=suTy29q6pNLdR7OkyMeOxQVSHkLM1/ooJdor5TumW1dy6peLlQx2+6ItUVrjLFdvtLx5ynZ5y4OfZKD+Ty4KVPoQEte/5qFVPl6BYQgCn1j9yCj75/hYBN8uQfoPH67bjQeol0qwT8aYnSvKjqO//J+zqXQskGJxJ8t8Kjltnf1YHS90rGBInBfqE0jVonUAtBJoRBshxJP4s0RGVjxl/OyLBkq9p2HnP2vTuPPOHh/8/BRVS+CXe8Oli0ppG/zsSM0W7MYqcBeCUtY/ONWNavOp5gA45PI9Am6+/kLZjCkUd6CIyXFyG1TmLoTo9N/HMe/LA7Iz0H4gYCoI6zrc0A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 22:21:34 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 22:21:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Nilay
 Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme: don't create a multipath node for zero capacity
 devices
Thread-Topic: [PATCH] nvme: don't create a multipath node for zero capacity
 devices
Thread-Index: AQHahcUg4YV4+OLZkkKkwXtQg63vC7FXHwcA
Date: Wed, 3 Apr 2024 22:21:34 +0000
Message-ID: <56cd4b02-9c8e-46d0-b1ab-ad039d527530@nvidia.com>
References: <20240403124717.931577-1-hch@lst.de>
In-Reply-To: <20240403124717.931577-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB7752:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBifuklmbuEG39JR8JDDYpeYmB3q1/w/prRfq6CPDamrm/6FAGncdgtea0ix8prohcru1QYbJoLMM9FCiBLzod8sYKhuO9MYO7Bv6v9w8KVrMXNBk6SH1W6XFy98EZem3XkTgGn9KARFNgVxqUJ2gqg7ZiNUNvIrTvyxvpv3nW3vt34SBuVzXgk4yA/8A1E4dJWl48nv5Qb7AzUfcyBxi1qpoY7oZLycDqILuWdN4cgjAxbiPi/rg8pszy8P2bwC4+oF71AQAnvX+gTZYtpttOaOfn6BehQlqNAPzhhVIGAERqH0QuBQ7jehxkXHpMkNWnxPGzv1sKrSAHl6qbYHWQ8dRdOnCwi+5TBNaytKezCtP9n6QDIGfPFB0XU2AjXMi0ZeMIWIB1s8UPHbsaWaGAY+BBYWsnnV18IRBjID4EtjEGnXFKvw3VnFCv2OlJz7MBft/jJN36vPdn3IbMXY/2q4t0VF5oHcz6nXtcqeIM1lfo1p2XGJ3t13s4dqIPDxuvPHac1OEU28Y8NGp9Gf31HcF2DIcbD/EujEVma8BYrcCRoWE+nVdAeYjbZ4nKv5ACqcaHCP1NT+O+TxpxwutIVp3QcBfBPZty1kSLFPuKimBTk4KFgK8y4W1Z0i9S/Q/UysPhGRuNB/+5iYdfo2FOeiCaiAA/n6++P50mu9sa8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0xiN0tXdzU3UjVlcDRsR3pLditRRXdWN1RSc203RG9FcDdWMm5heHA2Zy9H?=
 =?utf-8?B?R2g2ZjV0eFNGakpMdHhMMCsrMzE1cjF1TUFWeWRhVkp2NFpFZUYxZWFWVHhZ?=
 =?utf-8?B?VjE1UGxRWUFMWDREQ251c0pIbmNIQmdIaEdzc0VuS1NVdmJpeEJwdWVaKzhI?=
 =?utf-8?B?b1hQTGt1NTRscU14WllsazlWUU5Db0NqQ3JUK2FLdWZ0aG9vSFlzMTcvcXBo?=
 =?utf-8?B?Nk8zRGEzTUpIcjgwUThrOUo3MDRJNG02L2xZaUk3b3BIVWxDTDR4STJPTlpU?=
 =?utf-8?B?aUNPRFR5V2tNY1lFdVFEb0h4cDd4OXNqK3dRRG40dXcyemVZNjJkZDZIbWZ0?=
 =?utf-8?B?eDBrazZpUzJaOGY4R3QxQ3R5U2JRQzMvODBEQlBiQVNIZ3Z0U3Q5MktEWkdT?=
 =?utf-8?B?K0tJR2M4RnpZNUluU2UyaTBvSWhBOGpjZ21XdGRqSlZFak9KVkN4SlcvMHpF?=
 =?utf-8?B?dEY0SG9tdzl5YUJwOGNNcE5tZVZMRGRNQlAwdnNpaFoxaG5rYVE3NXRtU243?=
 =?utf-8?B?WjBOUzdRWHMwOVBSSUFVb09TMVFRTTJzdjd2SEhhcHBabHNDVFJUQis3MlA0?=
 =?utf-8?B?M1VPMFIrTzdZNEZ1anBLb0NNMyt6S29UV1dHQ05oOTdRelJOcnorT0xuc1Nq?=
 =?utf-8?B?V0xwbU5QeFNPNldiRE56U1ROSSsxSG92NVE3QXh0VW1OUHl1VkVWdzF0aTdB?=
 =?utf-8?B?VlZtN21LcjZReHg0ZFpYUytNU1N4WnplbkJIb25YeU1acDZUQ1NhVlNmYWVH?=
 =?utf-8?B?Zk9PSVlYbkttOUFYYzlWN0laUWF5dW4xdFcxQTNJN2tSZEc4MVUzdzlmUEEz?=
 =?utf-8?B?UlozZExIVVc4WEJMNjFxVWNLTi8vNlFRcFdzK1FWY3ZlcXlmQlY1SFpER0or?=
 =?utf-8?B?WFFRN1dWak41bzNJOHRWOGF6U2dDY0dQdHBHV1RKZkV5SUc5amFYOEI1cDZI?=
 =?utf-8?B?VjkwME5iQVFNTzl3RjMzY0xzdlZycnNaUVp0YlJkUGNYbzc1am80TjZZZU11?=
 =?utf-8?B?amVFdHRDL3c1SXpWcDNSVXd4eUxJWmlrY0J1aW9CUncvcWZnVnVrTFhZK1BT?=
 =?utf-8?B?NmtNcG5oaG5NbHJuYUlhOFQ2V3JFdi9QZFNNUTh2RW5jZFNiTkloaGJNZFdK?=
 =?utf-8?B?TzVpdEw1ZlBzTVJSTzY2c1VUeXhOWUVSMWlUMDY3cElWbU1OS3pBMjd0V3RE?=
 =?utf-8?B?Y2Y5QXFqYmdQaWczTVg0Y1NBaTJNLzdOeTA2VUdvLzRxRlNVZmhpSzRCMzNZ?=
 =?utf-8?B?d2FSbVlmT2Z6N2FDVjFteTFYbVZoVkFUZVZRN3RibDlXdFMzWVIvVGt4K1I0?=
 =?utf-8?B?ZDVRMVh5RFQ2ODVxNXUraUNHa3I5TUkyM2d2STduOWFJc2VRaGllYktGVWNQ?=
 =?utf-8?B?RVo5T0x6MXNzZy8yMGdySU5sM1lHTHJFdjNHMFhVdUI1V3F2MU4xbTZBRC90?=
 =?utf-8?B?Z2h3Nm5vTXRENzU5bzd3cXI2eHhyaFhSbjZsT2Y0SnZ4ZmZpanVmTlY3aGRo?=
 =?utf-8?B?MUhUYkxJQWJHaHpDTUNRODhpZ1h2SmFNVXhiMHdXZkNnVlEvQ1hEUjRUenlQ?=
 =?utf-8?B?cWxkTkNid0hUK2d6QURER1p5VjFvTlhFeEYyS3hpV0NNN2N6cVFCMFh1TGZR?=
 =?utf-8?B?cXJOS2dZYk4wcmZRbVpoR1pzK0JjNVJHQnpxVm9WYTRMdU5HMXhPeFhOWE1L?=
 =?utf-8?B?cHVOZWt6VzArazkrbUdjK2hLczVzcGFmcjZhM3BwaThEbk1FQ1ZyWGtJRDhR?=
 =?utf-8?B?ZXZjcEU4TUV5VEMyU3MxcG1aSVNMbk5GemNDK3Vva21oc0hCTFZyaHRkaWZV?=
 =?utf-8?B?RXNQSTIrdDF0TGNicTQwc1FIYkMwZytrZHJKeE16ZWtnQitrUDhsd2R1N3JB?=
 =?utf-8?B?c1N2M0F4M0RmeVBNSzA1MzJib2pvMVlGajN2SUI5eUp0enRqcFFRZlZHTGZX?=
 =?utf-8?B?SlRxdlRXSkduNStkUm00Mkx1NXBEZnBOa2dJVXUxVm82NXRBT0lnSWtFc2FD?=
 =?utf-8?B?SVNGcFBrVHV6RzZQNG5VS1IrcEMzeS9IQUxGRmUrYmttZUtNU1Q2eWdZZ3pS?=
 =?utf-8?B?YzBFUXFCSHZvaitPUkJucVhvb2VycDlyM1ZhZ2NINDJKNUxPUk1QL2hNdXpo?=
 =?utf-8?B?ZzdsVGltV1JTTkxGNEtiemdmZmNRRjRRR21kUi85bzNBWnZkS2pwWk44dnRy?=
 =?utf-8?Q?DPJXvMJCyStRQLjEI1nftSIJr91clvkFYxv/K4TBOwWt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3952C41ADD7C94D81A1096D788E62A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fad02a8-3bc8-49ce-bd24-08dc542c6bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 22:21:34.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kaRbzPIWUJ8m3bBALTShCEcnaTwEIj0BSNgf1IYUOO92IygMe8OXzeBeULdTyEjIwW/aPPSp97qDfriXyjEjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_152142_472773_72E60364 
X-CRM114-Status: GOOD (  12.24  )
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

T24gNC8zLzI0IDA1OjQ3LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gQXBwYXJlbnRseSB0
aGVyZSBhcmUgbnZtZSBjb250cm9sbGVycyBhcm91bmQgdGhhdCByZXBvcnQgbmFtZXNwYWNlcw0K
PiBpbiB0aGUgbmFtZXNwYWNlIGxpc3Qgd2hpY2ggaGF2ZSB6ZXJvIGNhcGFjaXR5LiAgUmV0dXJu
IC1FTlhJTyBpbnN0ZWFkDQo+IG9mIC1FTk9ERVYgZnJvbSBudm1lX3VwZGF0ZV9uc19pbmZvX2Js
b2NrIHNvIHdlIGRvbid0IGNyZWF0ZSBhIGhpZGRlbg0KPiBtdWx0aXBhdGggbm9kZSBmb3IgdGhl
c2UgbmFtZXNwYWNlcyBidXQgZW50aXJlbHkgaWdub3JlIHRoZW0uDQo+DQo+IEZpeGVzOiA0NmU3
NDIyY2RhODQgKCJudm1lOiBtb3ZlIGNvbW1vbiBsb2dpYyBpbnRvIG52bWVfdXBkYXRlX25zX2lu
Zm8iKQ0KPiBSZXBvcnRlZC1ieTogTmlsYXkgU2hyb2ZmPG5pbGF5QGxpbnV4LmlibS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

