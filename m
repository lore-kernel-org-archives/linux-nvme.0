Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CB6C43460
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 20:29:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E153611B0
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 20:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E153611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Bnd3Rcg6iopDWvXmE3vD27WnSQYULWbDlAunXWlGcLk=; b=O0pX8hBKFDPp+lWmIXN4VPrmM
	fBDqxiaj3iLDamLCn0+DGmnHz/ysjWSWzksNMA7VUdQrPwANjSckOTDdr2OT666VZqtXyWYJS1z1E
	TIbaq80YAlX9bUSSvaOCHDD2+EbSDWavOKQVZCWDWj/InMkHIbMMsj5U3QWprszGm/+oHZEMm4peE
	riLjpnjBqsy7zw/GIkvo4e+4BkwzxdndInGMDcrpiYUawTY6YDB+0MaZd1a86J+o6l0BU6hEmfXlq
	OPGTjSpjm8vf2KzTfUPN0G/EX7nyiuKYgpiwfRzvZoQu7YXJjvIpuu9nvj/UDESlTLZy3rd8RtWKQ
	0bGJSafyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj6LM-001pOd-N2; Tue, 18 May 2021 20:29:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj6LJ-001pOE-Ju
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 20:29:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=BDed3p78IfSkznYy41PKx23GIqlf7Z42eOfdy3f99SM=; b=VOZKHevCizf5yDHypUy+OvZgkx
 P1fEomdqzmVGD7RhfRYpD49hjWFA+KdllIpzgrJdnnXN+NmM26dbUs15XqvMD+vIvnmBopkxri3TG
 pMg24XemQoZMBX9xoiNpIMlf2foUjFq2KoeZh/r/SNnnyRZqrobnvJT3JhbXYlpDWIP9BRGUi5vgC
 fkftjjlesnmaibKoknNo7kIu7/xFrI52/IvJoOQV/+ewXLY/ATuFzGE2aocGLrLav5uMRSMcg9tN4
 oqT1k7nhLeCzR73Murthw0JhwcRH0sPP3ky0+oNdvpNKXpV7F+u7dpIN8rEWZgC45Q3lkMPx+DQub
 NcnLWOzw==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj6LH-00Ewu5-67
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 20:29:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621369765; x=1652905765;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=p8SjdMeffgscKYEZpuK7B0Hfo4uCe1ipmz+6NAODHz8=;
 b=llwre9Sbg4PbF0tmMDwEdUSs/Gt0afENTrpnAktKKPmTK1ne3yps7xtS
 o7xJYfLD/d0OAeBDvsJqZK8NaVSYQRrZFnebY4EJGDzeh0Bo3eA06RXXF
 9DqhMwRMgrrR2j1u6r2Z+g1YDGPVbO+0c4IFJilaa5eP+a53WX+Az8fwj
 svudtTSQ7SvaxRfkL987VJzRf1z6/u7k7T+95GOUO+En9uZUEp8GfbdO7
 GOu0o4y9mWZUUKzFh8IdFVHXRL0JavVQ0wHcBdpkVLJQIp1LykFJgOsP7
 xQDxprrMha9OmyILl2BpBKtnGFbZEpQSA2KP9m62RPN1gl57wpWtqNYZ1 Q==;
IronPort-SDR: l98rWhP+L0wTy1Q79VpCLHdlosaLatl83hscq3t/fcJsk7ynw4je+0F701aqPdtv5XdhNgLbxK
 x8prhbRKVarPCfJgOaC/cJwUD0axCUCqxAuKzwF/+DmOByP9UlH+GouZDOtpGmkkBc3RHy1bSm
 Sjdu25HGit9YGZcjWh8yaA1Pgii6tDEVBNYwEM0EiO7ZX1nACizM9EhVTwJ07QPcsO7Bhcunj0
 o346KLstKNDC4gamMkfwH0xWkjEeiq8CVQ4kiyy/nyQ296Zs3F94DIExGH6CIIA4jCiOf/G9/I
 250=
X-IronPort-AV: E=Sophos;i="5.82,310,1613404800"; d="scan'208";a="173222023"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 04:29:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPyYG4Yb41UM3u+H7wQ9PQyA77uuzFlQE2Ksq9yGE21hQE6CqzPeuTj/E/RSvALZt5lWY7r8/6Zf6XF7omfPeOs0+gdfYhKNErdOf0kCXrNM6hcuriCqo+gYV+aXxPTAIyuqLoSpvB5RKmmwujqbWtHAh/5Os+rWMYLtxb6OUqIASPwDbG8zRlZYVjDVUM52u0cWTevkq6Tj+VLNTkaEYm7KUHEVOK8em/JMC3nRkUNcqJLvnneVB5PYkETx0jBKri/wkkXggqHPWv6u4wLUiYgR4QbRg1bygEzZdswwzlGvZwmHg9eDpuC6PED+GUT/5eC4Qnnby9M5pxfhAk2Y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDed3p78IfSkznYy41PKx23GIqlf7Z42eOfdy3f99SM=;
 b=gJ1sxjoyhprKjlWi6vvSJrch/wcA+F7AkUe7jjgpdKeQsEwcRx7JCyrU4jsFZhzM+3jTlh5n8lR4scB5dyRTF/uj3oJyFRM0QXu5kSEx5MLg3jJmtZDvWep8WpZMfS/ZOYSQyw+KHPexz2jyQkLukADBbtreNkZSOc/hXBROD//cnxrpEuAjQsrRwBgkCb8f7+7ZBfLIZPCkv7BNahk0qfP45/mCiVgRK4sXvN82YS3pCkDUMD7gUQKNhYgLN30MPUXRsXEU7PuoRdca/31sfIZHnm3ValMGqRQeZB9ISX8BT1WoVGOVsHrEw6naUSXGORr1nVM5hsdqmlmSNuoeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDed3p78IfSkznYy41PKx23GIqlf7Z42eOfdy3f99SM=;
 b=sB0enYk/auPxiELSzs8pReJjCzm4qoHM00yK7Db1C8RN5Msy2jlSvl1t2bO/+U8o5w586gopslHzyUb3mfWuOcQ5bVnVbmsrvqCNM52ZLG7n3mnyd9lYrNgfM61JL20yu8HBEyEF2+hsNLPXeHx6lIIM/0iWHLIE+YDweiD7ohY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7456.namprd04.prod.outlook.com (2603:10b6:a03:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 20:29:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 20:29:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH 0/4] nvme: nidt and ns-desc related clanup
Thread-Topic: [PATCH 0/4] nvme: nidt and ns-desc related clanup
Thread-Index: AQHXS6OBCI0RHXJEfk6650Sq1YO3Hg==
Date: Tue, 18 May 2021 20:29:21 +0000
Message-ID: <BYAPR04MB49654FBAEFF736C21AC59747862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
 <20210518064917.GA8093@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52d0d8b7-1122-4993-7536-08d91a3b9e7e
x-ms-traffictypediagnostic: SJ0PR04MB7456:
x-microsoft-antispam-prvs: <SJ0PR04MB745607C117BE7136A123B9BC862C9@SJ0PR04MB7456.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWkAnRFoGkDJpCd+yloE6DKbv5ichGTd9T1YNmuXU4fcNS4sFKErL6mU60/AqrW+8woz3NtwuQekpeD/njM+PYvYWrsXWi5OvXaTIKpknVamoOftv2xq4qK850fSkVxcLy4fuIkQME2fOScOfsAyUYwkyHrtfCMzYjnoR9Xd9cSseJnW4nISUQdOs2vQSCp/6LcMqqQRUai4Xw5bx5g6lcjkelRaUfa25VizI8H3+w/d1UPGrvJHQemk3JalnbvYp6QpJzd9MeZ4RDBOG3nZ6dtiymThk4hoV0cAWd7NIOSO2taIqLnbh7QYozI2guLvjwGsxOs9g6hxNLG/6VK2HgckXOCXrQWIoWiVPZeO3G+BpXgUhVrc1AHmP5QJxjF/V/iSXEyw4fM2cwcVesTHEQQZLhBgI7crAzCY86E4Mub8Tj0cH0PdD9AxavJqihFxvMGDFWsL1ugBIWwGOXXDNm66Ib/m8yjEEFqbMKJlk+fHYHZezmrMdehJZl2aM/mamwrMsUmAYbBYbkZ1louo1Gpa+1v2ysjlfabUoSXemZNI6VPJkRijqevyIPD9GYt2ZVN6wHOVdn5RF0mrc9KQnROyMzdYib0Gf7thsP56SMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(86362001)(122000001)(38100700002)(316002)(52536014)(6506007)(71200400001)(83380400001)(53546011)(66946007)(66476007)(64756008)(66446008)(66556008)(478600001)(6916009)(5660300002)(76116006)(54906003)(4744005)(8676002)(26005)(8936002)(33656002)(4326008)(186003)(7696005)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2XPpljG+vYsFmj58Zav3OcmP5PWOgiYmTF9Tr2L0CrIJdYpGkEw+p2uvkigA?=
 =?us-ascii?Q?kgPww5KKQ6hFuBH86fc+lBvxYaV13ZIPo2q5YNfABxAR/nzQf/1IfT/fJW2w?=
 =?us-ascii?Q?M06/BmmUDeOm9qThkh4OarCkWk4nXhquXSw4A4UuIwtCCTg1EhimEg7lV3eP?=
 =?us-ascii?Q?/Cza1duGwfxvY+jZa7g0zz5LtqFcAHWzWC78BiLSLVdINqGcG8Y3JQlyXKRs?=
 =?us-ascii?Q?WkaRLoBQucms1vEIqqQb80T051xRd38/xyuZ4tk+kvEctvGW5XFXr+HW5J8v?=
 =?us-ascii?Q?3cl1Gale8tNRgPdzHxtE4nB7PliYoj+TGCrCR0O8UXutafwXnmcSMR31z94R?=
 =?us-ascii?Q?bN/PI2nHGF3gomfVQx1Sm0sfFmRMuKHmxpM5pBZmUEaQnODMAG771yviq6gy?=
 =?us-ascii?Q?dhjPXWjZdGiXw1qA/qYd9g14RTyNnJSF9w2EtjCysTW2mRQFwslbqh81R04Y?=
 =?us-ascii?Q?5J792JTso7NNT22abmjEsBdjn5JmW4Xnl08O2Hyghj1XdkutN0w7m3V39TLr?=
 =?us-ascii?Q?M0zqGQwgW6Aa2AGACLW3k66DuuGzRwSzf1v44/mZc22XOHeArNnzEcii/fO4?=
 =?us-ascii?Q?JX3vuLRDKeZzsMBMZ8f08oa4bDl6b8Oq6oKG+tI4GVZ+6c/msRdJwUFGz6PN?=
 =?us-ascii?Q?vb48BQhxMjNj1Q8gSkcszZ1yR0NsHJ/KV+Bvo7elr77m83OB4IGB1Vjurigl?=
 =?us-ascii?Q?mQcTs9rSsJFspSq4ajG5dDwvshVt/fu6qOLGoKYJmqMxz0fRJ4eqVwfoq2/5?=
 =?us-ascii?Q?ADwBDa6FIB69AaYDBA3Wjn5mpZCB5CyoIWvFsFDL7G8PzOXKauVrec5qJEwG?=
 =?us-ascii?Q?no7FBPqmh2HoyztN6whszGUXmJSaId/eqswgLTxpRXTclV7TxsYrp2vxmWF3?=
 =?us-ascii?Q?RONjAoK9KnJhEVpQ+JDWDSBb4BOrtFJ/e5RDEJOG4BWnjcxCyO7IZJWNpSC8?=
 =?us-ascii?Q?48PaL8a9sXS7iZio4s4qhM88bnNjg3wef5M4YJEBPRRQkHabCxqqiZWS7dbW?=
 =?us-ascii?Q?6ivnVz3L9/7JVQGrFPVh759QaNKPOFx1cCNMTxWFySyreopJQG+cF6/Ale4e?=
 =?us-ascii?Q?NfBnEeVSk9PrrDuIWXvTwuCZDagB4lmsJj3dSuAdM6oI+wEr1IxYwYH2vvMD?=
 =?us-ascii?Q?+4a9tADlgwHg1IXTJzF6wjJa8d/BhDyiP3UxjtlBDo+3vm9SiEcmVpU8pXDy?=
 =?us-ascii?Q?UzOCsvtgEw3/YGKuGUVk/sYWq4gZWx01aXBbg5epG4stYZoxHZLb2jXt9Dt7?=
 =?us-ascii?Q?70QIPs/RJ5tyuA9hCmQLM7nlIg7OrBHHeHdUqOFoYp0R+RhRfvHIJ1jC6ihL?=
 =?us-ascii?Q?SPvAvzHOjDiXG9toWD/2etm2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d0d8b7-1122-4993-7536-08d91a3b9e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 20:29:21.2427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzKQ+k4BL2xsRTzoBmwlrZ5ocvZUttImaOWYDV4l9vlGmmaud40rwOb4knzJOM2ADJqyecD0/SX3mE73WdTBB/fOOa/Otkx11f8rkSOOBE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7456
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_132927_253783_FA0F2304 
X-CRM114-Status: GOOD (  11.39  )
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

On 5/17/21 23:49, Christoph Hellwig wrote:
>> With this open coding in future we will have to maintain one extra macro
>> representing length for each new NIDT identifire that we will add.
> I really don't see the point.  You remove one define per type, but
> need to create a mapping table entry.  This adds (slightly) more code
> and is less obvious.  Do you have any grand plans for which this is
> a preparation?
>

Okay, we can drop this. No grand plans, I just thought open coding could
be avoided, but if that makes code complex no point.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
