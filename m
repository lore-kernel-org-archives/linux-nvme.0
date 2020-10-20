Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE73C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 15:52:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C4721707
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0ftc61k+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ev9dhQCQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ROnJMpiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C4721707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+BygHxfWQTkrYauNn2zaUyjkJknBnKomUJ2TTEqk1Jg=; b=0ftc61k+G/Icdx+8D4o4Xoe1hC
	t3/QOoU6S9ww6ANYt25SzmDH2/p/veCNh+vZU+lAtt4+rHEPfiqJSqpZJMX3Clf2zdGv9XluPd/BY
	ZZ9oufr+bskMs4LPnetWa479KKi02/Q3ZD/b/eE//3vDaJY6DU9PL1FX/VoQvmrmsxDJL9kmWNOhy
	Lz/WZvePCwJvCdmbpR3DQHycQcMLR+pdnccfjrqlZJ6wKeeomzlDYndMIjMhrsXkKOUflVg6QozUv
	BM31Lh5j1n1uVpmWGpqMYekvz6daHWrad9wcCyCCBGS+F/SotovNpfaj9I5ONas+KojOovFfoOv0P
	ebyeTiSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUtwE-0001dJ-0D; Tue, 20 Oct 2020 15:52:38 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUtw7-0001bG-9p
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 15:52:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603209151; x=1634745151;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=5G8XPXITBMTtu4RjEENPqRvko1ZOG1WfWd0z+3W+uVU=;
 b=ev9dhQCQWWq83kN1geitJyV8tTUejl54w0K/3MqGmWh0/zmETJuj1mT0
 g8ftnay5uiCPsq9OfMCN7suyajkDAhTP4BGbdG5LtgZIqCLaJwPdpGvSj
 nN8lr/tQzrUQtK1wn89Eh+Xhl18ea+UDYr24E+jR9dBKp3tkJYJ27eEpU
 MX5DP7vs6k5nA8fZZ2ipMe6Bt2eG1YaRvKfgUJ94pYpISCM//qkdgwDXg
 PCy4ygRxMx4eLjvsxLZPMnceYU6cuLB7lFsSL0ZQe3pkb1nFm4uuTVOVK
 OXLwNKCVpBElyVnHM8w3HHUpME1Pp7+wh1S8NiUGiCtAJSkSXhLXrVYE3 w==;
IronPort-SDR: 5IlK6K0rZt5kxxvwCJefqRX+b0r9cyCH+g8hU6jq+BG8QOToA+FJHtr+QM4kmDC4p9HxDHjrOV
 zzN/KAcBF/D1N+dtisCOOOaHyRu95esSSqx1Y+aQiB28XmGwI6pDZD6SUU+VIXWHtUBPV6yjM7
 uhx//09WXrhJatSUvky6zcIK/KhUd5aRkyc84HR4kvKI0qBYL3iFBiRkz83bFFu/ySmHBvFI4l
 JezTKf21IEAmLGNC4oL5SSx6Y6Zjg9KxoAxcAW9WJ5RaxyhOPK3XgwFwdR7I2z7lKXh3fXQ1R3
 +9Y=
X-IronPort-AV: E=Sophos;i="5.77,397,1596470400"; d="scan'208";a="150353813"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
 by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2020 23:52:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6JFFJmcryFtCS+mTofNBOro1p3EQ7cQKmhTcI5UTgFFtuZUSs7VsGeidM0otL1mewd0WvAL2yKCymJ/CxsoJBtGyRWjLbVHfwIFn6pHl1QOPoLgK87RX4+l7EK4ifNBpSEPi4j4qbEGtDxqUr4+U/fPfLqHhu6dlrZDusIuIVHf2rHJijXvIb2o4elhODCKYzHbbT6xdwo7Em2Lv7r/XH1VknElT93P4CHbsrF+qzWf9sx+sHw35D19t3dtLuLciDaIEH4leEeBTnaapNGmbiLyUm/8mjsYKDW9l0QH1ssaYvcd81IT3teLjC2X6J4sqor/vhKc7nm85rOYz/U1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7TUT8ErkjUlGpzrgoUKWSNfeS68iyTs8ZA30NQoiEo=;
 b=Oda8lrGdgof25O5TOjUbWoHpjyPN4gPbQLYeRRVFIRYrXC8dR0B8DBT/c0q8J88cANRqWr1i4VrWebqOTZXntlqMKcL740IMfO28v1u8ULCvFUbz49t40/IKbEkWsCcwOnCacfcoQVdZym5y8xNTRHMuKXnI1Pp3wNX+LRZJlBd2IxQzQHdR+Ax+Dc2AffKaXvm3+St+fLGp3e/dd/VY5LlQ2o5Hy6wwI4LFPpGwQUOZ2UZlyDKGlHnSLDVMUSgnmVgGwCvOQKucGnJ2dDENxYxGVU3bP+8Lggx/IfIApQi7g8mIHnOZywSgokVSvfixkFM2oIxwGXe0EgNzjta5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7TUT8ErkjUlGpzrgoUKWSNfeS68iyTs8ZA30NQoiEo=;
 b=ROnJMpiJMR8K9inlgKg7mv8iQeCIHbNgrmhaRaJ3WAKVAmuY/HM/6rGpusKeMuDJltNSPfznn2tQB+/WYTZJNR/RHtVicODnzFFAqebqKXOpL8D6GNNWBnWxbVG9obVbBlgr/nlBp/OON/nK73QPSTRINpY5YGPVFJzox0JYHsY=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BYAPR04MB5654.namprd04.prod.outlook.com (2603:10b6:a03:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Tue, 20 Oct
 2020 15:52:26 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::1c83:9eaa:f9c7:aecb]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::1c83:9eaa:f9c7:aecb%7]) with mapi id 15.20.3455.037; Tue, 20 Oct 2020
 15:52:26 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: NVMe CLI Version Tag
Thread-Topic: NVMe CLI Version Tag
Thread-Index: Adam+KTkcOJMFnf2SBKOklv1Ntj+ow==
Date: Tue, 20 Oct 2020 15:52:25 +0000
Message-ID: <BYAPR04MB5656B49BFE47211B3A2F1748EA1F0@BYAPR04MB5656.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db0dfa47-902a-4b6c-4ec4-08d87510244e
x-ms-traffictypediagnostic: BYAPR04MB5654:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB56543F07BC378DD943AEB867EA1F0@BYAPR04MB5654.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IIooP4imRJ0amxHHH3rr3hG9vVl6+LC7GwDzggR6jQsKmk7Px2pVSDoIdX59le5LTouDK0uojrdDXMBtHrXwrxAbmtmd+6EPcBB0YGj4S/DxkiwWFPrR+JfMgxkvwVttpktb0h+9urdWWxyLUlO8TKMVJe9jeamifShhSy9esCEqxtoyLMddP+CXwAIbcmQc4r57jQascU22fnVfL+fHrtEQ8sUv57aKg1hYTjaVV6pJAxLFjupQztPZTmvaqN8ZGRFOxJw10JjrNadP5hYp4WUVapCgzKVa516eXmEs1hpjqC7OZZfS0p64+jCbtwuG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(366004)(3480700007)(54906003)(5660300002)(52536014)(26005)(9686003)(83380400001)(4744005)(8676002)(110136005)(316002)(33656002)(478600001)(66446008)(4326008)(7696005)(186003)(66476007)(86362001)(66946007)(66556008)(64756008)(8936002)(71200400001)(2906002)(6506007)(76116006)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 1WpoKOYz+gHbX2n1WzXvZSHxjpk5oWZZPcrsCEY+3gDmRbzi/JpVoHHYFPdsp4wmI8iJIDQPs40zxS/8rAiPDYNBOdKCLJG3VThZL02oOBajVcU/FQq747YLxtu4iw+4IV7OP7PI9+6+PJC1hRSBSS2qvBkYme8xZJcwZ9jJPjI16zbfeGgjonG1wmgXMrk9ukh0HUUoACDeyUWU4x1LGj9qGW2yYeiKz2XcTxtEDNLZzV0QxD4VyURBMMTES/e6pOFeigRdVfXbiJ+weFxe1uV4WyyhVfDHEcXjiV6tnDoGTwisWQHgUUQAUxhXS9osTnCV3Lm1zCFWUK+juf1vMiffOB6AToL/LukQRkkDiEdC62rp9rO/iiql8Y+hpDGiWv1piphPwBWy4+zVPOvpByOplVg/kWTFmMe7u1xkEMuwEUBCpFQF+tpmKMa2nqUpRXZYC0ZWKNkLkrmHXHrfAaseftDjnlsi3KPQ1dZOjt0/4qaLZLDVGor/MbpbMsUqELkfmcD9Bdm2hM/8TpZcxBSuo7Ru95RXp/8vyozMMbYtaUNbWU0F0n3Jq0VscTDJVsNqnwKyJtOpfgYPaxG+++UdueBbJ/x8wYqN/9qC2CMCFtM16TPY5EvBLxGa7pTKn0Pf1iNfPQcMaM92U3JkwA==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5656.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0dfa47-902a-4b6c-4ec4-08d87510244e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 15:52:26.0614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1liyA8NY8M260cnJZY70qhQkjDlwc+Wg1nbnLyxaCOoa/u5Ttuou63RDlkUx8Rc0e81hrZ5CkYPExH6QYvx2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5654
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_115231_554525_B9C40F15 
X-CRM114-Status: UNSURE (   9.46  )
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
Cc: Sean Brownlow <sean.brownlow@wdc.com>,
 Randall Bates <randall.bates@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith,
I'd like to request that the nvme cli version be updated to 1.13 and then tagged.   It's been 4 months since it was last changed and tagged.  

Thanks

Jeff Lien
eSSD Core SW Tools & Drivers

Western Digital
2900 37th St NW
Building 108-1
Rochester, MN 55901
Email:  Jeff.Lien@wdc.com
Office: +1-507-322-2416


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
