Return-Path: <SRS0=Qd0E=EY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7444BC56201
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2020 20:16:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D285B206FA
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2020 20:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rEFXqkAs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="U2JoJC5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D285B206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bMexzmfs+gGqjrNdkNs0DOVzUHTXxNeE6GHs6vZ+hYI=; b=rEFXqkAsrOp0G9nIzPsxnSBX1
	p5qomra30Fp9qdIZmTHBb9evfrct+8E6wtmiVGFK4LEusTXcqcYLIA1X2XXnPDyprqLHeePsg8ULb
	+mRtUwfxHla1Knq9gMLQWiHS4kbwvXEcqRTp624/YO5qhozfsHkJQC+ooyIpMh7Mc11/wJ8Wc3oJJ
	gZ1R3ceLpKIz7MFPfFu7tihE1fDAGsQ5qwCWo2XXs3oWUiS7415LyfMeaUNrmiIBYOvzx2gJD9Lx7
	J/ncNOBP1qobPEcBZLRnEaKqdjP/kdI2z+xdDosBVR8GOBXWh+i+YlvMVwpnhatqyiHk1Ia4saT/i
	TUIeBnOjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfTsg-0003qk-AT; Wed, 18 Nov 2020 20:16:42 +0000
Received: from mail-eopbgr680075.outbound.protection.outlook.com
 ([40.107.68.75] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfTse-0003pn-3X
 for linux-nvme@lists.infradead.org; Wed, 18 Nov 2020 20:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrRid0NAqT4p5quIzUCON5F1C4pboxaXEa3P5mjGpQPtdx12kfHPmVr4n/97uaFGWl4uOqdwGNIE9K8Wit9jOp3jfZmYcm6qk8OfAmUe7jo0qdRdqFTMLX8F6aRjqoU6Hj/Qgphw//SWWiWe05b8zJvrG0Npt/DmrHrMhN1HVWRrBgWIr7EAPR9yRJi5QqX7R7l1VrTVVdyl75jGnW6vSKk/thVQlNzkYWs90IsX8buUBs/8x5GIvrLX3uznzVsDeRess1oLUlHHfqG4ed+3IE+f/p7MvL+X/7wv8roBlLkkU9p8UuPSARQX4dNrXVvaoVvSW3oZRcawSSIT+SkYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/KCBVpVfLS4zc33SvREEvlwUI00qJLGCbtAdPJamUs=;
 b=RcPQo5p95wgDpijxry2oM0yizacS/Vow334IQjOxgaFe/O5/zfM4ihPy4xppckLteiSgghfLKmYEk0p7aI7aVuGY3LNiN1qtNRIbCGYGk6ZlzesCuztHAfLQqMIlUkXQiqo6Xmt2s/R+31s3LWjSPgth5zQ0fEiviM5+fBVCDhbkO+FEIwcm4KrwFwnG5Iwce0mKRabwB5cS1SoWR93s+ddEsnQteGF02Dh1IKMvzQ7JiLYJbdQ+oDfhyNkgM/8B8PfyQX+P7Sah4HXV01yf19xNADd1bvZNLAUatNXpKjoYM408CUUS6eDcPgtrNJGct0sym7RpcZYLheP/0OL9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/KCBVpVfLS4zc33SvREEvlwUI00qJLGCbtAdPJamUs=;
 b=U2JoJC5qTDCMRRgnNBxx/8aaW/mGMM5yX/+ua6vXTd163Ixl3F55kULVRfUlRADYLK+fHws6/N1vV0sNNDVw2fCCcPFRsM7zhDZ74ABXDcrCF7Vj5Q6Z+WXEj6pNLg1nYBC5P/2JEO2tPyXw6S9G1RWVvKdPan9D3rG8tLXEfE8=
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM5PR06MB3387.namprd06.prod.outlook.com (2603:10b6:4:47::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 18 Nov 2020 20:16:30 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::e84b:922e:adff:146a]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::e84b:922e:adff:146a%7]) with mapi id 15.20.3541.028; Wed, 18 Nov 2020
 20:16:30 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvaDZ4On1YeAvk0yKbnb0IwXxeqnOGt4AgAA5RoA=
Date: Wed, 18 Nov 2020 20:16:30 +0000
Message-ID: <945aee5f803e7170ae44c7af5d333961ad22923c.camel@netapp.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <cc8f2a9b-43cd-7921-ac97-1d1d899748a5@grimberg.me>
In-Reply-To: <cc8f2a9b-43cd-7921-ac97-1d1d899748a5@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9376e091-a245-4673-3101-08d88bfed62b
x-ms-traffictypediagnostic: DM5PR06MB3387:
x-microsoft-antispam-prvs: <DM5PR06MB33870EBC9C069A0487F5ADE295E10@DM5PR06MB3387.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAL1lXmbBgg+X8jH+dcJFp/u7BTekrtWwjdvFrBdi3+syaRFb6G07I6XS2aHAOd38oXIOOcYr8ApqGgilQ3KSIV6jmNTOs5CaJv4A35X6GlrjwDVWJjxbcAgfAk5sovytMQP4+8Pq1/dmAvXWy1RlHLekmD76envPx+TfLPLCeBDwbxtMBEzMKYUqC6dexMAVZgt9NNddmNYMge935BfUdPyeDbPGheCu+hTQoc6cSi2zXRZZIFz16Byh+tMhu8+oawDqWvg9KWXFxv3wdHrLeqnHZSDuMpHOj4x4BJs2BA/pkG0cWE2eLGT7SM3ct8l/XngrBjhDcxPqu+hyK4wXS1FaV7S7lkeTe2podpYlmxjfVqTOvs+8bm0Heywlfj/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(15650500001)(83380400001)(8936002)(8676002)(2906002)(4001150100001)(6512007)(6506007)(26005)(186003)(478600001)(2616005)(66446008)(71200400001)(6486002)(4326008)(316002)(36756003)(86362001)(66556008)(91956017)(5660300002)(66476007)(4744005)(66946007)(64756008)(110136005)(76116006)(87944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: QdmQu/I9rfcYmzCTXMGX9NMZND3Tln5Fg/ZMhwQSQpInNlSy/6Ova5JY9cbvurWzh+ghzEvWJI6ed43SSt36bHdT4FhBo/Ae2HABP6BFmHTMhuAYycTVfQQ4oxzMtktnOIDJvNTTIcM+n6uyoz1jkVruT6JgIouPSaPHsOjvCXNklYTLNhgw49tLMJTSHi9ojQjs8q5eR3dz62EcYX+cqRG5g6Joh2EgbJiymx2ms0PYJ/RteWe17/cMOQpIHEjiQX6kH4DdHH0uWk89kh9z+WC2wnDlAO8092hNfOIGh3n54UeFF8cwRc7YwRZu9HFoMeDOBXyCk/07VpIeAjEAUrtRsjHGJBHd0kOzXsj3YBFgCp7rKXmwQBgHGALFzCZz5n1vhzHiJmhjkepr1oLRlHyGw9z9k66z+yueK2aMN2VduEVI6RKgIdLp0HJIDOnD24NL9L7jGEteCrzvE/E3yzkvdlJNExQ5cXv2WqLUVYhEcKgkq7b4JebM9JLyjAKQpYZLDmkXmaQIy1RFLPnKdg1arMJ1c/+XBflNxi/b75zQ80046orPjdCal184NcEogO3zzLdhx/5XCOKVsbvn+7J9ZtWSnT4v4QDSM/7H0X1npTbv8ua444uH1TR19fmuTZlHu0A0C8l5+w95zAZvCA==
x-ms-exchange-transport-forked: True
Content-ID: <F91B61F4DECE434DBC2B93194CE4E373@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9376e091-a245-4673-3101-08d88bfed62b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 20:16:30.3414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PifcZiSq9Lj2Z5vhXy6Fv/LP3djpj0lTCZjUTe9J//fjPwmaMfSnvRgAihGjoCZmGxNEOE3AEq0b3Wi0zUAxRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3387
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201118_151640_211464_CAE9A8A1 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-11-18 at 08:51 -0800, Sagi Grimberg wrote:
> Fix this by reading the ANA log page as part of ana_work so
> > that ngrps gets updated, prior to invoking nvme_queue_scan().
> 
> Nothing guarantees ordering here..
> 

Ok. I suppose we may have to explicitly read the ANA log page then to
get this updated, in say nvme_mpath_add_disk() or somewhere else?

-Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
