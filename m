Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD262C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 16:21:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F367661077
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 16:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F367661077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Zv1ZLjxBnxl59rdS/RRPA1ocSrUwgLcLTFS8zLTAgnY=; b=jmnUGXpHLNoUDF
	/a1/xqOOgvqQqZ9coBiCURbf0aVnRQ+KEZ67IbZgsjiq8yj93r4Ycmrzew+YmY4BYV7N+mCkcJigl
	Xq5k39USSDHDsQu2w2eEe2dWCBTmWQtgljHyBveOewYKHz3JLz+f05AbVJAWtabMhdUtDYUUb10j6
	Lul1ZFcQQ/+etCaTQZapi1q/ZL/UW4DVJA7hVscNmhdmJU157nJB92xcMT6ZXZew8hdgBOkKGUKFP
	/RPSDqXYxi4WEfYgURFAUDxZJxwdv7rwVd1Znhuqt8t9h5YiA/7lkP7RQoSY5QV9pPWcoq+Ku3Jn8
	LiEnId/Ke9oqp/XqWMyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYWdc-00AH02-4q; Mon, 19 Apr 2021 16:20:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYWdZ-00AGzk-Lu
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 16:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:Sender
 :Reply-To:Cc:Content-ID:Content-Description:In-Reply-To:References;
 bh=/lDjR5b7BtiDfiTFFxVNgA7tVnvH8zM4J5BLfjnLQ6Q=; b=4g7ZNY1YPkZC9Wp+2QZ0DlAK5i
 xIuMzOMyuKCS4B3gSw54NF5Zj2ms1SEqI2qhfyoTTBlXWycXh4sCRoRCBMV+G6obmYLyTKe0uvNkU
 w7x8dMdgC5B3DSDy/4CUCGYls0la5pV2qblvbAjDiCJrVUAIcepG4+lXQfaw5vrnPmtaLqho5hOS6
 tNl/ihyIQmPVKxKQN79fQ1s4Sj8oa1UAySW4BIilxEtpUwj0iU2VuwuNZH8kHsk2eHa9GGE/UDkQM
 ou/DdWU0M6ts90IO4Dj1eqQNFgtXwKZj+3FSD69KhRp/7cVtZkM+okiPJzg3OOnhutVuz5U4pce3x
 TZPiD7PQ==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYWdX-00BWNd-4r
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 16:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618847889; x=1650383889; h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=L+hPwvLDQh2YqC4tjpb2eWcFT9C/9VF8cSRXGICuo/o=;
 b=BodWWBtMNNlQ/s+uCZ+78Xs8UJyBwFur6Z4lKJV9nw09n54bS0EgPUj8
 zwcAuuNZS2G4SsrCXqgVFl+B3wI7qhrMXLXiOU0UNaAOCo5sNZeK7BlSj
 MbrXTEvgLEv+ZS351z+wqmwHVLPvVtQFIaD+tmmk6ppjlqDYbb0+CMY1v
 Ztd0keWHGbENt4NNGBzyqv7eEb7mXtFDReR/j1uICJNWPHEGfk+J/V8tK
 fEb/YEiFGJYwR9daXfafLncY6JinoxWElmHYxJQLQqZIAs3VrgnT9PoG1
 JQQQ3H4LEGoQadyFFW2o3Vui083le9ptgM4c44FI0Y47MSuRt+QSBiPmo A==;
IronPort-SDR: +edV6SWUsTqFRWvHO6oDrYpRgBj67Rgf2bOBlpaaPCNIAHgH1tz2pkVm4qPe9SQEZWPrNPxwP9
 tJ2SFyMzvCFNeEHYxriLXcfpBwwL8nTfv6MPxoy5U13d3icp0YtxbhZ8aCM7YF83P8v9KgXINW
 eYS7CfTPwnKwrYQkhhWCKw1Jv1LzKGknRmX/mCQBS9CXBVjEFwzNWzq3Y+594i17rCNR2Kg0sW
 UiX5RE9sfLKeW6Fg3UrKZeSLC5TiR77hZKsTT4OV/8eTzgcoFok2ci/z047Gh0nlQGP3hmVIPE
 Tvc=
X-IronPort-AV: E=Sophos;i="5.82,234,1613404800"; d="scan'208";a="165455120"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 23:58:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOc561g8SxpzJeDA8OxVgZrSg63bxAmD7Jp5CdDQKc0Sod6pY72kzPPZvHOhruHcQiLM0vZlUSF68iyFCjIlgo0kW0WuN9F0BbEl3lTONj6HKBFJXUbmFYzWRT8t01A8F5bLPpWEkoQCfRUqV+bOhIrSVgl3KP9y0VLRNj8v5zvb1zxyxBsbJtTbsK/lVvYkSpK8c8difmF6Dta9qBm09SOb+pGrwgFhkpO7fCdmTEMJEi5/HandgtGo2ahgdTNd2g288TgfnyXqIlHGLeWNiSEFBzF40RfVxXIm9gecy1o1TayJ4Fab6pprlUWlzUNtHcd81jmAX+PabW03NqOuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lDjR5b7BtiDfiTFFxVNgA7tVnvH8zM4J5BLfjnLQ6Q=;
 b=ZkUJuarR1TGMPP07IccuVpmgQH4RIzT3SLZkTwePMMJMU1fmeGsf3DO4nWhnCAyUmoveMKN3oIyGb57vQwcyT5n4mOnrQ5laN/LoJmRPE8DRLW3an/NqQ7ATNK5RSESwisKPXp+mnSyx1R/26YGjmYwyZ77IIAek3xFZU2wrejnkXlh5uHKSRcgn4eNYLec229DH3oFYptsoeV3DiAYcWKxPdpIytxMSf7vmoUP7SJ6av/piqpm4RmPL8MEftU+rvqZOQCiDGIBmw2BOvllYsubxkwHs49g9UYVAwPxXim2+NtdgVpYJoZF2CcZqhC5W/tJherrzHr/MFhNWQiDgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lDjR5b7BtiDfiTFFxVNgA7tVnvH8zM4J5BLfjnLQ6Q=;
 b=WzVsh0m3ucXkbb9Wlk7RFoPli4ewB0b3AUNsoiyf9PFIsJMB9Wq6nTh8s4T1xH/sREznXG5qJGFVs3h/o0PvJBJGnwNLoP8YvmSCm6x+80FBbWLauwXhxZDOm/JO/jgTkrmppuSOSqH+HUBu7wQxKyV2sPSg/PfWGi2sNRfsHSU=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by SJ0PR04MB7646.namprd04.prod.outlook.com (2603:10b6:a03:325::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 16:20:31 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::9cdd:ce22:386e:c1e2]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::9cdd:ce22:386e:c1e2%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 16:20:31 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: NVMe CLI Version Update
Thread-Topic: NVMe CLI Version Update
Thread-Index: Adc1N7XeW6l8LkA0RPqdTqcTvqlWXA==
Date: Mon, 19 Apr 2021 16:20:31 +0000
Message-ID: <BYAPR04MB5656669415965F63F56B8686EA499@BYAPR04MB5656.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.48.94.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fadc13f4-b5a4-4ad5-d3a9-08d9034f0dae
x-ms-traffictypediagnostic: SJ0PR04MB7646:
x-microsoft-antispam-prvs: <SJ0PR04MB7646BDC4DDD16689E350B5C4EA499@SJ0PR04MB7646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ebn2LlrGkSkN5e3bdajix4IqTKOphJeCd7EJ2UkQkL0TtWtsGxWxaRili5cXNIyYb1Ywgxr9HwhN75C0C4qH7opw2cztd8JHjU6aukVihHwwQOBe4WzWTb5xtwxp2Z3igiJ1S/rgi+c9qvlat/cbvR4BCuCxwMvtPiCPK5+liPYhAmrYUJKaYHGdIhcWWuZLmL8mxLlJgXGZ7esp1OdNFqgQ3L3KXf6iHhWnEtBN5L+jpviyVbyjBMX2hKlmG0AzqSF7/EsT1tO75oW+ZLuS+yQk6Aa5daopNTdX0Mg4OxOKVtGmeb+HOr5YvHUZgTrnjh83f/o/bJKdItt9xTjYeSJlvSp2CYNkOIJlNxmfNgpXC5eePjrfR1T8HqTn3o8D9+GQVDEQKqjR8+i6m0hpD00O2dTLrHepQ7j1VNEHqAQVBFPbTHSTnFmwOI509NWpIJ3HgxxPdp0r16FPQm4g5xkke1fC4Wk5xLscfaVEKSfkOvtl1SquqJPCq0O+HC4XCmo3pIHmr1PJNx0fu3/1HEwHcnKAWMO5PxKEXWQbsdRGEfOkTo2qyOy0QBm1Wvy+52JZI8kq7euP28k+P8ph7APVjT7vq9lkLUhMstAcZVQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(7696005)(2906002)(71200400001)(478600001)(83380400001)(186003)(8676002)(38100700002)(122000001)(15650500001)(66476007)(64756008)(6506007)(33656002)(66556008)(66446008)(55016002)(86362001)(110136005)(66946007)(52536014)(8936002)(76116006)(9686003)(5660300002)(316002)(3480700007)(26005)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BjW3qPTrs0x2txCQaXCnDnUCm/ZTrC6nZomDTUm3OmGXZcD+dT8ecf6tT2Df?=
 =?us-ascii?Q?zkTFxkIICjCbk3t10BwuB/mwlKkbWUZo+FbWp7f6eRfc5DNtC7B7P5H/+b58?=
 =?us-ascii?Q?PRed7jvMTc5RrnmtoXx18hUsb8B6kNVEThxgd2OW9Q+0yrtMkOpl3uN1IRnT?=
 =?us-ascii?Q?onblP7GprnUt6weq8Vn3HZKNPpWRcnhanfFDMXI2uRM7MvokOSRRHUbv4gLJ?=
 =?us-ascii?Q?I1Pg9NlTZ7FdQvnnmnfUrB4SkCkSq9CN3SW5Z8LiBaOwTnGoHwmrqcA+sbZK?=
 =?us-ascii?Q?PkMXDkhC3ZgZy8L3+Evi9+eMzBJYjSTuS/ytCa4NZJB4+G1ZbqZVHJsf5Pr/?=
 =?us-ascii?Q?uqkUQo1hQUnxIP1RC1GGAv4x+HOqH+61XxfxWSrk1jPhp3vTLZLN8A1ZmMZt?=
 =?us-ascii?Q?vtE0QgryxgapnuJsRXr0a8BXmI6ETopxx7LSyB5DjpPa/09B9Qd4dcR/s+cw?=
 =?us-ascii?Q?P5+tbv1S+PQZQv/TJvmycJikggWglgf6FP5NtmjmBovzTnuLwRabSP6597Il?=
 =?us-ascii?Q?mC4q7Yvufni72FEOMnA/2ycvkt2pwykrXS7qcpoJEbY2Bf36r/fkZckRY2TA?=
 =?us-ascii?Q?HDJM3MoDGzjIYCg8XGUpjofc4rWskmtr/H5S1EmMEuqOa/MIv8F7ufoaNjZI?=
 =?us-ascii?Q?cRx0afA/c3UWBSIJYIR7v/dE2Oje2AaTSCMp0D6cx6kOqu3sioLMcbzXMCGJ?=
 =?us-ascii?Q?bAhs9uY/Tuy/Zg6TkJ/7wfcxhJy3fbmywBDKnwGotX6KFgjgl63bhOBa+dbC?=
 =?us-ascii?Q?lGMqUWtiQyFAIUqvG/Tfr3d7KoupUeAOvfX/3fvEOSyhnwBCpSYBO4aq+S/D?=
 =?us-ascii?Q?jIZDKwzRIM4vwfmoLL5jjWIrL6fbFi/LPx3m4xHKniW+nLYpAWZUDFAJw4yE?=
 =?us-ascii?Q?SIKEcw6aRXmP9+zzxpQbwVdh8sFylQ1UcdFSZlquZbq+En23RsWC9fqv05Qy?=
 =?us-ascii?Q?FXDbM5rPXFRj4if5AYJRTNx9vO4MFsBYatZI3rmciGSfpnb0z7FcGq916e2b?=
 =?us-ascii?Q?4eK1mCaNG/5DsvrH3ceqxnu3ulWDpuRXyfN08cbZ+oyRkg3c3sdfbKuhfIPt?=
 =?us-ascii?Q?xXXL1nKMn/C47lJKc5yb5X8q9Z4qNZyUW55FRgB3P/JqDz3XSrT8kUHCEdM5?=
 =?us-ascii?Q?suEVps9o18gHchaKK6r0ch9Ct9kG2QKVScXbQH/67k1rMp3iZ0lEzsF7/CV7?=
 =?us-ascii?Q?Ot8M7nYRqrHUSnsE9uL62hZrsvtPpgqe/PC5Lq8QjqKzpFfAHU3xY1PxV3Mp?=
 =?us-ascii?Q?nNWsgdO0yAqKHuIfPGT+kifbTq61avifPIhIHXvRBL36Nju4hvndjPj6sbuN?=
 =?us-ascii?Q?djc1RNT6oj+T+qPfM9VF98Ok?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5656.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadc13f4-b5a4-4ad5-d3a9-08d9034f0dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 16:20:31.4697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtViHnGWrZpk0x1/1olr7btl53p/ExvgHWD1v8GDJwooPZ9axSjq3corJEZPA5Jm1WXt4+sE2r1CQ8wK4nV3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7646
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_092035_297610_31631C37 
X-CRM114-Status: UNSURE (   8.25  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith,
I'd like to request the nvme cli version be updated to 1.14.  It's been about 6 months since 1.13 and we have a lot of fixes in our plugin code since then.   Thanks


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
