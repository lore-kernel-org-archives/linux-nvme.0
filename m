Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF01C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:59:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC8820771
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hR9zjpjf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="YPgfKpIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC8820771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cJo9MupLvA5SzM4u/N/DGZoqdn/pqI3GfxBR4tZLrwI=; b=hR9zjpjf/551YLPlybgEoWHzL
	oTxp2kJ23qIxVhdKGzbRhkCUF/qwuTJDNsisfSHLFdkuR2Uayr/ANiydMrKA34U2boH/qY0qyVAwq
	HU7oD66+wymUu4Tg4Gey3PJIEV3MpuISE7FCJFdsPkOqMF3ME2YW4SvcgPrqbbMPmyik3ielVwuS3
	8499mdOzLYU5VreZnxuBu/lobZeyHqnAe0PMavGC1xI3h5ypat9/Trtau54EA4gtWeNeH/OWpl1kO
	sDx5bA/9i/v4M2OrT83WcsfL/SgX6aFiBvDsEA37tX/Dup5Vexgw4wZst2PXTNXRhUhlW5x1ybI6f
	qjW8b9z4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Fda-0004lh-3E; Thu, 13 Aug 2020 15:59:30 +0000
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com
 ([40.107.237.83] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6FdW-0004l2-W0
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 15:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1l0n87L7C6f1lbTPVPUgy52Ahfn3gNxiwxFMdUQEKO+q2bR++dvJRXtTCYRNfClH4hmf6JNUEUGRRGpRIPNFMP2kfuToMQ7WLK2UqvDXtYMs815JZVWGtyvP4wbMzFHG8gauO3OhNp/QX2i6fyzylkoPeIArUgmnnRcLAaGWim01/UzhAyJCn1zfsiPXeyLhkAgKhejiOr9RnwcxtB+nle41TuGXvQ1Eki8/HEwiYbI0ttjbZRR/fSlIFqKcEN4S3jtxsQwx1w+s5S3IUu3HysBdYX0wGoqlwXYvrZrNa8c4gdG/65k2+jHrD6lKLm8vV2/7UUXwoet1xhMyk0GKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqelheQuIqNFOjUCMKcB1GIdqsnUjHZkf4rEddzDGzY=;
 b=bAv6Ffybp8QFVJ0yDVdYYyeOfdzNY6XMtp9lp7Req789wUTYyvK4KVtB/PRAzwC/qq4VqQcB89a0TMUkfQU63aLbf+wS/PsrwFRFLDGiA4mrq3sadvrYI1jX/YQmmtC2XE8D8Ta4P0H//sltnnmtM/QwXKAaUsEDh0CQx6wQqiCAVxeZYpNuJoIM59X2j3z4B75K1ixzGrFQfSsVNkN7yJplPDHm8Cov17G/FBMshObG+60kUPOwgRk51UK3B5p6LnmgKcuq6nJ7KkuJd7XAt69EUSKR0ox7r0m597giGq8XXQNRaiRXvUcDtVW46whNZZI1fhcglwXXxPWdvcmM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqelheQuIqNFOjUCMKcB1GIdqsnUjHZkf4rEddzDGzY=;
 b=YPgfKpIcbHRdT2fsIXQEa7/HGwuuCQMAdzy62czJlzB+IwraUS+nrovz4S3Ml3IH4fND4J0w4qv52drsyBEsI0gjoGvJ34l6vKc8W2y64nofADO5SdrTlBBbYr591Klw/BfnDN4qjqLqLvh0Phnpc8eaPo80oOLhjNi6NxHVk6A=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN7PR06MB4004.namprd06.prod.outlook.com (2603:10b6:406:8f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 15:59:22 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9%3]) with mapi id 15.20.3283.018; Thu, 13 Aug 2020
 15:59:22 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Thread-Topic: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Thread-Index: AQHWcYDS3N6K/RiKVU6UaUdcYydCWqk15t8AgABHDwD//8FsgA==
Date: Thu, 13 Aug 2020 15:59:22 +0000
Message-ID: <5A6AA63E-77FE-45CB-A16B-67AAB9346531@netapp.com>
References: <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com> <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
 <A90B4EF6-354C-4735-9E5A-45BF27F520E2@netapp.com>
 <20200813154320.GA5707@redhat.com>
In-Reply-To: <20200813154320.GA5707@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f3e2439-295a-4a31-98d2-08d83fa1d883
x-ms-traffictypediagnostic: BN7PR06MB4004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB4004FFBCB5F33085BC932649E4430@BN7PR06MB4004.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VV8H6jqtbrjCJHODcCbzi6uytm1rIjSOTq1iOVwp4+xsN4qgIc6xoZ8XSLoJA1Obw+fSKCJX8wA/CdgroN7eRgj7W1C4dXQzLF06YMnbWxicpCpc8tC7vQJP7TeUyD2It8YhIg0/TjrIeO5BcNpOewAMRhaXtC4aAXKGYFpAYTSnYRCGq/hyK+NHsSqEpNfH6AVIqx8yxpBY+gpyVQffh85vr8tHYq5nxuCLRziQQwVTY5prnyt0IrvamK4cBAvsHwrbXdblmouXH/a8nJQhWZ9QZO+8STPlmkUTzc09vfqyigHK906G3xR54JlK5sup7K/irbypu/ksuUxFcvJAhYJQOuj9fSRRsZai9jeVKVI5bsFhr9OoaiRc4/oIT1rGQhLTe45jtVgvAsHeIs9JAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(6916009)(5660300002)(966005)(33656002)(4326008)(66476007)(36756003)(64756008)(66946007)(316002)(8936002)(54906003)(2906002)(186003)(478600001)(6506007)(6486002)(66556008)(2616005)(53546011)(66446008)(83380400001)(91956017)(76116006)(26005)(71200400001)(107886003)(8676002)(86362001)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TZB9ddCBqPwqi8Cetql2uxpgVmcFki2psd1qOaoEhDLS2CyCQhPCd0LEIU2GwD599vUslxk+uBlBgYE+5cw221zu+3bADQwLbAiu60A1ghfhZ6bz/5cjqefGG9dSUPjJz8crmpu1u9yN1BzReoZJtXWYVc02p4NSZrBXCtzR5RjHEdadTq7iIQV5DEmnforrMe+b9Bpkkf4xBwPOFw3vdKGa4+uSR/II+SyB+gh9+OmckCZ3AC3jRv1gfAIpRaxDsa9gF4cCIuNsm/w1//+pSWABEQV16O5t6OY0h3cmNkvvY+QWigeK85E//XDr621gT3jEXsHmzXPwDf0YZVtkrKoSjeAohAUz1esc76pWxmOy1WIQ1QcxIfQCWppwZr8/EjSaKy+FH+McEiDbcYQGCqN+lL1aSEo0nYmy8QF0a+8widO7cp3Eufh0U/M4LSfVX4cBqWZEvTRcee68WKH1e0qSoUleBjrncTT+BXG3xmjzW5QCBEuti5G+nrS9uowNMDzHb5wJf7WQ9UETvvE9kK0hkCpfU0HvZWZ75+kAlqhUHWer7AzTpuuQbkluMNr0lKHzwBtzv8lp3a/lXkJgyEBblBwSXT0t26seLtpQrX9R37MyjB3giHrENlyZ/ZhhDnBRrd5u7S5qB2UXqV4QNQ==
Content-ID: <5E473B514C6C5E4FB04E642ABC4C6758@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3e2439-295a-4a31-98d2-08d83fa1d883
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 15:59:22.5913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHeCsoSmcoH+5z/mjBaWw/hfgau5QCtk0gEs7p58CmxZxCstDByCz39dkKHN4H2FkCfkDh2PiNJNn8w4v+pSCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB4004
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_115927_059693_AF315BCB 
X-CRM114-Status: GOOD (  26.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Ewan Milne <emilne@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhhdCB3b3JrcyBNaWtlLiANCg0KVW5mb3J0dW5hdGVseSwgSSBoYXZlIHRvIHdvcmsgd2l0aCB0
aGUgY29ycG9yYXRlIE1TIG9mZmljZSBlbWFpbCBoYW5kbGVyICh3aGljaCBzdWNrcykgIGFuZCBk
b3dubG9hZGluZyB0aGUgLnBhdGNoIGZpbGUgd29ya3MgbXVjaCBiZXR0ZXIgZm9yIG1lLg0KDQpU
aGFua3MsDQoNCi9Kb2huDQoNCu+7v09uIDgvMTMvMjAsIDExOjQzIEFNLCAiTWlrZSBTbml0emVy
IiA8c25pdHplckByZWRoYXQuY29tPiB3cm90ZToNCg0KICAgIE1heWJlIGJlY2F1c2UgSSBkaWRu
J3QgY2MgbGludXgtYmxvY2s/DQogICAgT25seSB3YXkgdGhhdCBJIGtub3cgdG8gInVwbG9hZCB0
aGlzIHBhdGNoIHRoZXJlIiBpcyB0byBoYXZlIGNjJ2QNCiAgICBsaW51eC1ibG9jay4NCg0KICAg
IEJ1dCB0aGUgcGF0Y2ggaXMgaW4gZG0tZGV2ZWwncyBwYXRjaHdvcmsgaGVyZToNCiAgICBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNzEyNTYzLw0KDQogICAgSXMgdGhhdCBz
dWZmaWNpZW50IGZvciB5b3VyIG5lZWRzPw0KDQogICAgVGhhbmtzLA0KICAgIE1pa2UNCg0KICAg
IE9uIFRodSwgQXVnIDEzIDIwMjAgYXQgMTE6MjlhbSAtMDQwMCwNCiAgICBNZW5lZ2hpbmksIEpv
aG4gPEpvaG4uTWVuZWdoaW5pQG5ldGFwcC5jb20+IHdyb3RlOg0KDQogICAgPiBNaWtlLA0KICAg
ID4NCiAgICA+IEkgZG9uJ3Qgc2VlIHlvdXIgcGF0Y2ggYXQ6DQogICAgPg0KICAgID4gaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWJsb2NrL2xpc3QvP3N1Ym1pdHRl
cj0xNjQzDQogICAgPg0KICAgID4gQ2FuIHlvdSBwbGVhc2UgdXBsb2FkIHRoaXMgcGF0Y2ggdGhl
cmU/DQogICAgPg0KICAgID4gVGhhbmtzLA0KICAgID4NCiAgICA+IC9Kb2huDQogICAgPg0KICAg
ID4gT24gOC8xMy8yMCwgMTA6NDggQU0sICJNaWtlIFNuaXR6ZXIiIDxzbml0emVyQHJlZGhhdC5j
b20+IHdyb3RlOg0KICAgID4NCiAgICA+ICAgICBDb21taXQgNzY0ZTkzMzIwOThjMCAoIm52bWUt
bXVsdGlwYXRoOiBkbyBub3QgcmVzZXQgb24gdW5rbm93bg0KICAgID4gICAgIHN0YXR1cyIpLCBh
bW9uZyBvdGhlciB0aGluZ3MsIGZpeGVkIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEIGVycm9yDQog
ICAgPiAgICAgaGFuZGxpbmcgYnkgY2hhbmdpbmcgbXVsdGlwYXRoaW5nJ3MgbnZtZV9mYWlsb3Zl
cl9yZXEoKSB0byBzaG9ydC1jaXJjdWl0DQogICAgPiAgICAgcGF0aCBmYWlsb3ZlciBhbmQgdGhl
biBmYWxsYmFjayB0byBOVk1lJ3Mgbm9ybWFsIGVycm9yIGhhbmRsaW5nICh3aGljaA0KICAgID4g
ICAgIHRha2VzIGNhcmUgb2YgTlZNRV9TQ19DTURfSU5URVJSVVBURUQpLg0KICAgID4NCiAgICA+
ICAgICBUaGlzIGRldG91ciB0aHJvdWdoIG5hdGl2ZSBOVk1lIG11bHRpcGF0aGluZyBjb2RlIGlz
IHVud2VsY29tZSBiZWNhdXNlDQogICAgPiAgICAgaXQgcHJldmVudHMgTlZNZSBjb3JlIGZyb20g
aGFuZGxpbmcgTlZNRV9TQ19DTURfSU5URVJSVVBURUQgaW5kZXBlbmRlbnQNCiAgICA+ICAgICBv
ZiBhbnkgbXVsdGlwYXRoaW5nIGNvbmNlcm5zLg0KICAgID4NCiAgICA+ICAgICBJbnRyb2R1Y2Ug
bnZtZV9zdGF0dXNfbmVlZHNfbG9jYWxfZXJyb3JfaGFuZGxpbmcoKSB0byBwcmlvcml0aXplDQog
ICAgPiAgICAgbm9uLWZhaWxvdmVyIHJldHJ5LCB3aGVuIGFwcHJvcHJpYXRlLCBpbiB0ZXJtcyBv
ZiBub3JtYWwgTlZNZSBlcnJvcg0KICAgID4gICAgIGhhbmRsaW5nLiAgbnZtZV9zdGF0dXNfbmVl
ZHNfbG9jYWxfZXJyb3JfaGFuZGxpbmcoKSB3aWxsIG5hdHVyZWx5IGV2b2x2ZQ0KICAgID4gICAg
IHRvIGluY2x1ZGUgaGFuZGxpbmcgb2YgYW55IG90aGVyIGVycm9ycyB0aGF0IG5vcm1hbCBlcnJv
ciBoYW5kbGluZyBtdXN0DQogICAgPiAgICAgYmUgdXNlZCBmb3IuDQogICAgPg0KICAgID4gICAg
IG52bWVfZmFpbG92ZXJfcmVxKCkncyBhYmlsaXR5IHRvIGZhbGxiYWNrIHRvIG5vcm1hbCBOVk1l
IGVycm9yIGhhbmRsaW5nDQogICAgPiAgICAgaGFzIGJlZW4gcHJlc2VydmVkIGJlY2F1c2UgaXQg
bWF5IGJlIHVzZWZ1bCBmb3IgZnV0dXJlIE5WTUVfU0MgdGhhdA0KICAgID4gICAgIG52bWVfc3Rh
dHVzX25lZWRzX2xvY2FsX2Vycm9yX2hhbmRsaW5nKCkgaGFzbid0IGJlZW4gdHJhaW5lZCBmb3Ig
eWV0Lg0KICAgID4NCiAgICA+ICAgICBTaWduZWQtb2ZmLWJ5OiBNaWtlIFNuaXR6ZXIgPHNuaXR6
ZXJAcmVkaGF0LmNvbT4NCiAgICA+ICAgICAtLS0NCiAgICA+ICAgICAgZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jIHwgMTYgKysrKysrKysrKysrKystLQ0KICAgID4gICAgICAxIGZpbGUgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCiAgICA+DQogICAgPiAgICAgZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYw0KICAgID4gICAgIGluZGV4IDg4Y2ZmMzA5ZDhlNC4uYmU3NDliNjkwYWY3IDEwMDY0NA0K
ICAgID4gICAgIC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KICAgID4gICAgICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KICAgID4gICAgIEBAIC0yNTIsNiArMjUyLDE2IEBA
IHN0YXRpYyBpbmxpbmUgYm9vbCBudm1lX3JlcV9uZWVkc19yZXRyeShzdHJ1Y3QgcmVxdWVzdCAq
cmVxKQ0KICAgID4gICAgICAgICAgICAgcmV0dXJuIHRydWU7DQogICAgPiAgICAgIH0NCiAgICA+
DQogICAgPiAgICAgK3N0YXRpYyBpbmxpbmUgYm9vbCBudm1lX3N0YXR1c19uZWVkc19sb2NhbF9l
cnJvcl9oYW5kbGluZyh1MTYgc3RhdHVzKQ0KICAgID4gICAgICt7DQogICAgPiAgICAgKyAgICAg
ICBzd2l0Y2ggKHN0YXR1cyAmIDB4N2ZmKSB7DQogICAgPiAgICAgKyAgICAgICBjYXNlIE5WTUVf
U0NfQ01EX0lOVEVSUlVQVEVEOg0KICAgID4gICAgICsgICAgICAgICAgICAgICByZXR1cm4gdHJ1
ZTsNCiAgICA+ICAgICArICAgICAgIGRlZmF1bHQ6DQogICAgPiAgICAgKyAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsNCiAgICA+ICAgICArICAgICAgIH0NCiAgICA+ICAgICArfQ0KICAgID4g
ICAgICsNCiAgICA+ICAgICAgc3RhdGljIHZvaWQgbnZtZV9yZXRyeV9yZXEoc3RydWN0IHJlcXVl
c3QgKnJlcSkNCiAgICA+ICAgICAgew0KICAgID4gICAgICAgICAgICAgc3RydWN0IG52bWVfbnMg
Km5zID0gcmVxLT5xLT5xdWV1ZWRhdGE7DQogICAgPiAgICAgQEAgLTI3MCw3ICsyODAsOCBAQCBz
dGF0aWMgdm9pZCBudm1lX3JldHJ5X3JlcShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KICAgID4NCiAg
ICA+ICAgICAgdm9pZCBudm1lX2NvbXBsZXRlX3JxKHN0cnVjdCByZXF1ZXN0ICpyZXEpDQogICAg
PiAgICAgIHsNCiAgICA+ICAgICAtICAgICAgIGJsa19zdGF0dXNfdCBzdGF0dXMgPSBudm1lX2Vy
cm9yX3N0YXR1cyhudm1lX3JlcShyZXEpLT5zdGF0dXMpOw0KICAgID4gICAgICsgICAgICAgdTE2
IG52bWVfc3RhdHVzID0gbnZtZV9yZXEocmVxKS0+c3RhdHVzOw0KICAgID4gICAgICsgICAgICAg
YmxrX3N0YXR1c190IHN0YXR1cyA9IG52bWVfZXJyb3Jfc3RhdHVzKG52bWVfc3RhdHVzKTsNCiAg
ICA+DQogICAgPiAgICAgICAgICAgICB0cmFjZV9udm1lX2NvbXBsZXRlX3JxKHJlcSk7DQogICAg
Pg0KICAgID4gICAgIEBAIC0yODAsNyArMjkxLDggQEAgdm9pZCBudm1lX2NvbXBsZXRlX3JxKHN0
cnVjdCByZXF1ZXN0ICpyZXEpDQogICAgPiAgICAgICAgICAgICAgICAgICAgIG52bWVfcmVxKHJl
cSktPmN0cmwtPmNvbXBfc2VlbiA9IHRydWU7DQogICAgPg0KICAgID4gICAgICAgICAgICAgaWYg
KHVubGlrZWx5KHN0YXR1cyAhPSBCTEtfU1RTX09LICYmIG52bWVfcmVxX25lZWRzX3JldHJ5KHJl
cSkpKSB7DQogICAgPiAgICAgLSAgICAgICAgICAgICAgIGlmICgocmVxLT5jbWRfZmxhZ3MgJiBS
RVFfTlZNRV9NUEFUSCkgJiYgbnZtZV9mYWlsb3Zlcl9yZXEocmVxKSkNCiAgICA+ICAgICArICAg
ICAgICAgICAgICAgaWYgKCFudm1lX3N0YXR1c19uZWVkc19sb2NhbF9lcnJvcl9oYW5kbGluZyhu
dm1lX3N0YXR1cykgJiYNCiAgICA+ICAgICArICAgICAgICAgICAgICAgICAgIChyZXEtPmNtZF9m
bGFncyAmIFJFUV9OVk1FX01QQVRIKSAmJiBudm1lX2ZhaWxvdmVyX3JlcShyZXEpKQ0KICAgID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCiAgICA+DQogICAgPiAgICAgICAg
ICAgICAgICAgICAgIGlmICghYmxrX3F1ZXVlX2R5aW5nKHJlcS0+cSkpIHsNCiAgICA+ICAgICAt
LQ0KICAgID4gICAgIDIuMTguMA0KICAgID4NCiAgICA+DQoNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
