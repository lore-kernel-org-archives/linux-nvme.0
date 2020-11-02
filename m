Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B743CC00A89
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 16:30:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9B821D91
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 16:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cIILX4ds";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="blK9XhFI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ml8HtpYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9B821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ac6N5kbPAcLskn4JntTi42/Zedq9V1nkjxndpIe6z3U=; b=cIILX4dsOFhsf3lZipg2HVCwz
	WyJCorGUt/ESreMZoCeeroKw8qC2e3xOoheIX06fqQw5SST+/gmRCjj/RmwMd8wQq/R/lUNsTnDJb
	fG09qytz6yRgf1jk34aCsmifgEsXKYmZBtamRSvpV3u7/staX81/Z5spUOzapvwW/d6l0FkOcTPwK
	9chHLsWaQ+iQ1MHA+WtcU+ar3RJhB6NQSIrDTBShLiLkguWQQn7foZcw7xamgLWYO0+JPlM+pTZ3U
	ATQB0fV69RURqnYToGvnr71MTJ36nLszIkEGiP6HdNjqD0jdsEi8jhWTGZiA36odlmEKhf8r3oNsu
	iDfZPQKnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZciu-0002LG-2A; Mon, 02 Nov 2020 16:30:24 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZcid-0002ES-Nt
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 16:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604334608; x=1635870608;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Xrgb9pr8XiZpAM7lR0WSqRQZtXkNT5eeU5kC1G/gO6Q=;
 b=blK9XhFI1HJLpRBr5hZcu4Mq1THGC6Oh9aX1t4C9J0hAZi4GV2lHA//6
 okyh5snYjERTYZblF/j+QJxY9/WGkL5jgO7uQmovV3JFYPq5A4n5dshJs
 hWy3Kh4J6laTlJbcX9dERT0hprABbEYp57XkfmzRVu8Sg2phxnsB7sqaM
 hgoa6sfBjcpX+m3EvvZqta3X5T73NYxntmSlBjm/wHNZ8ml0ZQ7vcRto6
 Vf2PYFDYLJcVO/YMBnhUgkRWsf2R0xu2WhAvpOd43xz/KBBrXJmljQd0f
 pdtRzS8bbiwhQccicBG+rLAOTGUpZUXZSj7F4NwNFCGn7EcnVGg3gQ8XN w==;
IronPort-SDR: I4sDmq2w187e10QGqYWc4q7hPVFzCCIzJdpLTfmpwhgHi9odsvTINw6/rWcLf4xvtDRImcJDwr
 OfQPjxUJk3KWNct7BtGwim0UnQjl9c6P9qy332jhxHnV8YIa2y0oEGGWgskc/j+gj6ob270JP+
 5Wk2BWycU/nNCUfNTSjtFtKvdz7e82xd6F5hPtJwPJeTXEg3mv1BozA+nRNy3G0hr+HOGzK2FX
 59Za0oU6XQaggaiKOG/+t8IQJxVXtxz1VoAyGRaQU+uHgm1WeH4/3N8gr5Jv5v/4fG6873lwcd
 mcY=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; d="scan'208";a="152767757"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 00:30:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfE9typ5sREMl7udZcwbLFMWBjr1uiRAHbeOD4LFL6ddoH8tYrJZtX4R/uGq1BbLFgXhrsWBlSN4PLW9kUR1F2FRENXlV/ICatYvcUseFhkjqEQv3YMBbH2FDVXsWZVl00ZYur5WCCbHU0Js48Wr0uM10UKWgRkmRczqxZsNa+CI9jv7uxnt8F9/ZaouhVUuMS/PPeYt+8FCJzx8E9E42tU3qmQ+UC6EcZaRjv4HO8Bi9LNy6XSbQIkvpD6N3whPqHyjF+abi2gzmH3gftQ+HpPmEeDSFjm2acd/Dp2OZH1RS/d/9WYd8gwsGKIIvtVywFK/YyUBFQRqNwQWsBWuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrgb9pr8XiZpAM7lR0WSqRQZtXkNT5eeU5kC1G/gO6Q=;
 b=UYoS3yk9k4fSVCMGoAcZjCDuj4VVqfbu2C1hEITtPaPzeI/AYVXBTjyOq5Cr+Ixmh8nyfte1LiR20CuYPviPsTKr5HNWsXM246GFv3rwqSV+J5Dx1udiQFsvw3nz1YXyKLB+tnYcabA5nqZ+XZ7F0yweKcbH3b8KsQo7xpYno+mHXM8xaMFvkigThbzQeg5iN/nfPuYavp+386yq485uCl36xbeepDw6Fn0dQKpkK0QAtEgoDxhJuGGKYWXmpXEs+363z7aQh83L+qPTCH3bjRjSOEuNOTbjvzQlQ+h8FM6Kkq2CHmhmW3lq5y2lp7aWFqCwY9ZboUAstRzRbDK8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrgb9pr8XiZpAM7lR0WSqRQZtXkNT5eeU5kC1G/gO6Q=;
 b=Ml8HtpYCW4Dj0n2uXRbQaMTSl+ZwkHslMLnbqTNNRFwfxftmn3X5Fa+ljN/dUYD8Q5AfjLqdgDtXgU5oZKUi+znK0wvgVni52lorXMqu8aGqucVKy7fs1oVsSUyEXsCe4jZLfVvRQbvVCCqia719ErAVbpHLvqQxu6gQAWdjI1w=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM5PR04MB3722.namprd04.prod.outlook.com (2603:10b6:3:fa::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Mon, 2 Nov 2020 16:30:01 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 16:30:01 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Thread-Topic: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Thread-Index: AQHWsTNRkEUsidIEyUOnKZw1g2ICjKm1CGoA
Date: Mon, 2 Nov 2020 16:30:01 +0000
Message-ID: <20201102163000.GA203505@localhost.localdomain>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
In-Reply-To: <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e48dd60-f0b7-434a-ce3b-08d87f4c8bb8
x-ms-traffictypediagnostic: DM5PR04MB3722:
x-microsoft-antispam-prvs: <DM5PR04MB37225D942D892B412789A815F2100@DM5PR04MB3722.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUPeUTmMIZ/IGHGJrW0QpSjdx1W5dXNVQtFiKdO/bZoxAk7X0ZIEOVHqVyXsS1dwuCiP5XelS1LzevB9oVtwibs7W98bHoFhZaezNymWK3ZTd5NZKPZdGepTvDcJrvCTRdKF3u/BLiXYG28JbpBPGxoR7hlEUnvu8qhN7QQMBo1qNIM7lA/k+X0Lfw0bM0Hd2Ukj7XOoB5F/1YmD9Br3pprgkN+pKikOfr6Ww1t7xfc7qhAb9ArwYhZj8VJh/FaVyq+GVE5EZF3X0xA85aO0OD2NXPox1UtaQcExDylOrcg1ojOAxRWQQFFVh503Ton2yWH15DvzW3pZEGvnAefn1coNf6xig/bCu/WxqKCNlBKPkuzWtA5IzB19PMLGuhMOe6cgs5GHkgzRmxYr1xK5Hg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(5660300002)(316002)(71200400001)(1076003)(83380400001)(66574015)(8936002)(2906002)(26005)(8676002)(6916009)(53546011)(54906003)(6506007)(186003)(966005)(478600001)(76116006)(4326008)(64756008)(66476007)(6512007)(66946007)(66556008)(66446008)(9686003)(6486002)(7416002)(86362001)(33656002)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3prRulJfyBpfO/QorqZnFFbGucSqAyu+pbVbA/nEtaz7kFXMwuTt7crClMTHp/maCS5YBVN/F/+7AtO7fbAIBLMCEhtYMmX+SSykuEyieTUbrnA6yKbk8H9x3wzmm4+LbIM7H/1im185ckUcEgdcfgEboLnq5vGM5sxQNwPVfJjJNrXLVf6v1xsCB9sZV4DcQPo1a1F0ZaIwTA/aONNIu3vVkMDpPO2iJdLx4QXe6/4rKj1AOvdZVqi+2JRrVNE+mm1oXytmu0exZWwKD1NtVepBu37RPitlL1w1adsCDHFUhI+hleN00KTGYyOIbHYSz4vflJuuve2H7pb/AmztJUZ7YLp/btIzy3c3seR+jj4nWhoCSRLWh4ZQuwuSJCFHNsGQniqM5ugwqv8X/NbNAdm0ovf+1gAabRQSF9b3VgEE46ROBrARH6H5bFzhTx9TqFJiNGwQl7Sy07qpZ2xX5g22NiaQWOwaQVW6MvynAOaEwZYDc4xzYwHcetnfRLGorxFzpVZ1vnC1KTKUXRozg8/dVHeTyGY06Vi3+em3Jm8jlI5LlOImetlWO4Zdgpf6ZuASOeGmQqcWXodJBAF8uHksnx8i/C18E+/Mobsx5yEmGlATXa7fIcipavTTPMmwFKFd2TuDJTox/PeXenGNLg==
x-ms-exchange-transport-forked: True
Content-ID: <73C44F660A27964DA5D4429636BDAF0C@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e48dd60-f0b7-434a-ce3b-08d87f4c8bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 16:30:01.0442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykh1OW4Ho4vcbsid5mAPDXoiG7Z1JTDh5GsImPz5Ou26PEuG20DVP4TIWszVE0FnJNOuk76C14Xu9+CyUC6tgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB3722
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_113007_961206_ACA43EDF 
X-CRM114-Status: GOOD (  22.48  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "javier@javigon.com" <javier@javigon.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBOb3YgMDIsIDIwMjAgYXQgMDQ6MTU6MDFQTSArMDAwMCwgSmF2aWVyIEdvbnphbGV6
IHdyb3RlOg0KPiANCj4gRnJvbTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiBT
ZW50OiBOb3YgMiwgMjAyMCAxNjo0NQ0KPiBUbzogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyQGph
dmlnb24uY29tPg0KPiBDYzogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1i
bG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGhjaEBsc3QuZGU7IHNhZ2lAZ3JpbWJlcmcubWU7IGF4Ym9l
QGtlcm5lbC5kazsgam9zaGkua0BzYW1zdW5nLmNvbTsgIktsYXVzIEIuIEplbnNlbiIgPGsuamVu
c2VuQHNhbXN1bmcuY29tPjsgTmlrbGFzLkNhc3NlbEB3ZGMuY29tOyBKYXZpZXIgR29uemFsZXog
PGphdmllci5nb256QHNhbXN1bmcuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBudm1l
OiByZXBvcnQgY2FwYWNpdHkgMCBmb3Igbm9uIHN1cHBvcnRlZCBaTlMgU1NEcw0KPiANCj4gT24g
TW9uLCBOb3YgMDIsIDIwMjAgYXQgMDI6MjI6MTRQTSArMDEwMCwgSmF2aWVyIEdvbnrDoWxleiB3
cm90ZToNCj4gPiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiA+ICAgIC0gQXBwbHkgZmVlZGJhY2sgZnJv
bSBOaWtsYXM6DQo+ID4gICAgICAgIC0gVXNlIElTX0VOQUJMRUQoKSBmb3IgY2hlY2tpbmcgY29u
ZmlnIG9wdGlvbg0KPiANCj4gWW91ciB2MSB3YXMgY29ycmVjdC4gVXNpbmcgSVNfRU5CQUxFRCgp
IGF0dGVtcHRzIHRvIHVzZSBhbiB1bmRlZmluZWQNCj4gc3ltYm9sIHdoZW4gdGhlIENPTkZJRyBp
cyBub3QgZW5hYmxlZDoNCj4gDQo+IE9oLiBPay4gV2lsbCByZXR1cm4gdG8gdGhhdC4NCg0KS2Vp
dGggaXMgY29ycmVjdCwgc29ycnkgZm9yIHRoYXQuDQoNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcv
ZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwjY29uZGl0aW9uYWwtY29t
cGlsYXRpb24NCg0KIlRodXMsIHlvdSBzdGlsbCBoYXZlIHRvIHVzZSBhbiAjaWZkZWYgaWYgdGhl
IGNvZGUgaW5zaWRlIHRoZSBibG9jaw0KcmVmZXJlbmNlcyBzeW1ib2xzIHRoYXQgd2lsbCBub3Qg
ZXhpc3QgaWYgdGhlIGNvbmRpdGlvbiBpcyBub3QgbWV0LiINCg0KS2luZCByZWdhcmRzLA0KTmlr
bGFzDQoNCj4gDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jOiBJbiBmdW5jdGlvbiDigJhu
dm1lX3VwZGF0ZV9kaXNrX2luZm/igJk6DQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jOjIw
NTY6NDU6IGVycm9yOiDigJhzdHJ1Y3QgbnZtZV9uc+KAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKA
mHpvbmVkX25zX3N1cHDigJkNCj4gICAgMjA1NiB8ICBpZiAoSVNfRU5BQkxFRChDT05GSUdfQkxL
X0RFVl9aT05FRCkgJiYgIW5zLT56b25lZF9uc19zdXBwKQ0KPiAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefg0KPiANCj4gVGhhdCBzYWlkLCBJ
IGRvbid0IG1pbmQgdGhlIGNvbmNlcHQsIHRob3VnaCBJIHJlY2FsbCBDaHJpc3RvcGggaGFkDQo+
IGNvbmNlcm5zIGFib3V0IHRoZSBleGlzdGluZyAwLWNhcGFjaXR5IG5hbWVzcGFjZSB1c2VkIGZv
ciBpbnZhbGlkDQo+IGZvcm1hdHMsIHNvIEknZCBsaWtlIHRvIGhlYXIgbW9yZSBvbiB0aGF0IGlm
IGhlIGhhcyBzb21lIHNwYXJlIHRpbWUgdG8NCj4gY29tbWVudC4NCj4gDQo+IFNvdW5kcyBnb29k
LiBJJ2xsIHJlc3BpbiBhIFYzIGluIHRoZSBtZWFudGltZS4gQXNzdW1pbmcgbm90IHN1cHBvcnRl
ZCBpbiB0aGUgYmVnaW5uaW5nIGdpdmVzIHByb2JsZW1zIHdpdGggbm9uIHpvbmUgbmFtZXNwYWNl
cyBlaXRoZXIgd2F5LiBTbyBJJ2xsIGZpeCB0aGF0IHRvby4NCj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
