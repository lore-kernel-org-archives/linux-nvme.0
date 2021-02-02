Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D0C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:14:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B312E64DDC
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B312E64DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=eY3Gt7YdmyF/Aofqj8qEcF8D0EFbOa3QcvnpA/2LqbQ=; b=b4vMd8tlSgwjw8fa2BvkxNLeD
	WhhwU7ESznUU8vJav4eLfjwm9cVuzCECmx5mPkmhCSEbkIVQ+0jHDdakEJIoP30jeAi8pF5ZBW4g2
	Wg0gkkyndXqRglitMDZ2g6EACpnUSxGU2HBmzbERtZRX4gOZ4oX1SaaRHKQQiqIEFRt/BQuHumgKd
	Ewce8kQGe8Bwu8r+nczkoAS5ptieNJ8EUHWY3F1pHsrr7tRr8IKk2UQLy/7mLPAHYtiUhYBx+Y+rS
	dfhb6tlN2mqlFdmSj4yKSnioWdYjLQGUt0y2gMJbAst6h+OZDwi2O4B1g3sYNiS2ySsdbXIu1nJPy
	BkxpYLfYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6jLI-0005q8-7z; Tue, 02 Feb 2021 00:14:52 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6jLF-0005pY-OP
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 00:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612224889; x=1643760889;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=KTxoUDGjVETkONuqGxy94MSzxYzbPl6GCA6qwTh3cNg=;
 b=OnesfQOI2mgbY7x70mVKEoT8a3OBi93LQxEOckeNkN4PZ6E2hnx91wrn
 ITCWRVAq5CZ+MLbSnYbDPxE3IeR+JDgQPFlV4Ta26ylTmPlvTymJ/NZj0
 PTMjHvtvhY5U7imGnj5SOqqwpbW9hd3EX/thZg+2Hb5PBElH+srXDtrK3
 O2PotMPKqdiN78l2kXJ9udL1fyVjHFnffXoMOjBVYGH6Uwuo+qr3ExT3i
 tH8OiwS73I7efQHhZZlb/dAS/7UuO99MwL4TKQoBn6fS9FLbvRgAAog0w
 gAWvSFg6ZkpP/YOTFVa2utErUYeoUypuM/meujM92Af+DfJnYEQU80PNJ A==;
IronPort-SDR: LoyZpXTd+x/NUCWI3lKMBrwv6GO/QEwnY3iompPqBQ+DBqeKqvenmqtDZl8qCBUWwAMdKzbtzB
 lZvIafYrMiZfaCx1TTbvU1ZH/fdNEoYS+cZh301qOk8rsTY+1IDiBMzBse1W9PwAekqKxvZxOt
 GiE+eKBgHqWta0vG9llTrX4QxgPV5C/RC4iH2mNmgc2IjmVImd+xs9OzxzVu2sJbxKD1oZ0SaU
 owSYKrpmnb8xMYx5PfJNHcznxe/qrbGaUDl0ovu3ElaEvK8HEvJaaF10zDrRvCKPho7ZiuXRWA
 pOs=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; d="scan'208";a="269276666"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 08:14:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv8g4HYtoR/lPba+YwcStcCUfDnUiVV0mmPhFQK98NwdR6K/XUF7H+tusc1HMbqtcbp3MNYEgwC9fxyB9uI8NHhf5tmXalY20j64n1hwsKaQrnMafgypck4Xi9WEr/6Hwk+WllP2xKvCK3uHmrZXHJR7a10DCA+lxYTNMyP8vJRd/wbTO71SICYDH9NJniYpjfjfJ5yl+GFHS19Kh+6dCr0MoS3lbpeMQCYKmo4KpV13gdgaUUTvPT58v/bQLrDxcw9qjxl3ukrIpc0O0W1bXXNjFwWR+hNM1/7RRxRoCCQZ4skjMUZmemhyMYTlAR9cH9wCoQ0K90aeazFcPLiiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8A2ZLRWxsjCD/vABUEsJxZhN3OxvEZVAlnlURS9LAQ=;
 b=XekIjFLv6CsA+ZHjzsQKgJC1IWCOvnxzIF9Lsb4+QoaEzrpueWEozgS1SsLJgHBwMSsFC3/YIjAm3s7KmZxOFRir2O2QL37oX3R449uKyGN4/ApXXBIdpoZiDYF/XiPj/vgD+BAMODZGTWcDhuklsrD75WH59bwHJ4OqN403kzcH5UlX9TR3anC97QKMQCptJnuZfGnrSe634YmyxGx6inW+U0428v+r2gjyS24zt4o9LFwUw+9lUNFF2rnsXUbboEj9bvLWg0bxmr89LsfBFx+Ww7Hx7WeqC5JsOs558GXADKJ8lIPqPd2G1f0SrvM+qfmUzHneBaLjfXmjZElcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8A2ZLRWxsjCD/vABUEsJxZhN3OxvEZVAlnlURS9LAQ=;
 b=gCdKM+s8ss1RxrID8mHMAr8iYUBq6GpbvsQGTjTQM0w/vgdPaKedd7xtCoeQFZLAeesmVPIkq1uGbwtvLYQ7r/NcBYYw1oIyAJ1Nzt8fpEzPSwUQ7xCy8l7TDemYhAwdKIZr/KZODzuPsnhL8t3QOxU5/zLIOp3F034yq9nNWes=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 00:14:47 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 00:14:47 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/10] nvmet: add helper to report invalid opcode
Thread-Topic: [PATCH 06/10] nvmet: add helper to report invalid opcode
Thread-Index: AQHW+F0LTp9BFIcVuEW0iZeQL0QorQ==
Date: Tue, 2 Feb 2021 00:14:47 +0000
Message-ID: <BYAPR04MB49650B7A725B55D0809DB0CE86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-7-chaitanya.kulkarni@wdc.com>
 <20210201172921.GE12054@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b95b21e-b402-4ca2-ed72-08d8c70f8cdc
x-ms-traffictypediagnostic: BYAPR04MB5431:
x-microsoft-antispam-prvs: <BYAPR04MB543138CB4E456B02A0BD3E9386B59@BYAPR04MB5431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5L+aGaFnPf85W/Frku/QPYB+g6oQ2/E5VDSA/KOJdJ9nDB0pH/nUsS5X3vYYTPhPmnH+RH1Gmc3mKygo7YjZRRN/nQ+eq4U2PeL1wm1OiHMoPDuvPgbuKkiCXe//RzQM8EcOybPNPtCZmNPwDsqflEIoNV5vOXm/2pp6Hd5Kw6re/eRA7wT1Dc/4qCwte/UOsMcA1q9Q/n1NT2caqZGmwXWtsN85SXOA+LJi3eRxoCATXzwt0sK+7r+cEO5Dco7NhA4KSwmaJOT1taX7MF2uGFia2r4iFsoQINN9FY9PK9+pUEIo3U5ktRrO92pYIMVdfI9CsmSReU5W9fRUCTIT/kzdyN3fXKHwWXHo2BlXZWi1pPVaYY8upgek5PsR53nZArcHto0z8IOYUG+/K7KpV8sGbPdvOVcerxIGZbOV2j0Tev/Id6/y5XZNBLWN441pG30SkuYfAOqXNZqYI/meM1ZHebnzhWiS6fXSowobl7Ba+gbVigieCPTSNHiXKslhPWuWUiqepTF96/jrdBo5lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(64756008)(66446008)(52536014)(66556008)(5660300002)(66476007)(8936002)(6916009)(4744005)(53546011)(86362001)(7696005)(8676002)(478600001)(76116006)(66946007)(55016002)(33656002)(71200400001)(91956017)(9686003)(26005)(54906003)(4326008)(2906002)(316002)(6506007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w5Rlh+Gf6jECG3x9hkpRRrvrKtQ72KR8LhcRCLgMMnPrMLEzOLFxwYydv4cB?=
 =?us-ascii?Q?o54U1ZFpFwBtWDSS7FW6HRaWuUIFhsUz97bBGIk5KP2VQu4XoKoXWc2It70C?=
 =?us-ascii?Q?0gqlz0MaszWbtc9aJb9yTNkDpl+otuKnyWE1zvs70hUjAYeE1JKb2ix0+oqI?=
 =?us-ascii?Q?TOAUEvWJ49GXCAH5rDagUNTWStx0g1mzGQNhIQfOlj3x8//HDn8oeEujaQtd?=
 =?us-ascii?Q?Rdsauv9gwtunrShydrwjyjTU+AOqjZI8wZlVs2zE9qOr1Ctc4pSk/I7zqhUq?=
 =?us-ascii?Q?k/39+2CZTNWFL14Bv5geUk1yFEGdfYLTbBUdhLfx+coupopXNN6x557gS0Dz?=
 =?us-ascii?Q?7BkWvX+GaM48h02z/4cK130Wj1JAHrdiMoAHHw+tc9X2+DcPDfbNG2xsNCLE?=
 =?us-ascii?Q?987RNkkT3LT5VRRsAO9PMTIqQJGI4DE2G6A+prtbPWwu6mHzDrDcLj1hkysF?=
 =?us-ascii?Q?U2AkoiV9Hs09O6Bl6d4qROBn1PNtOpnWYJIFlCA05G9uMC5UAHmhIq0r6V8n?=
 =?us-ascii?Q?rehT8tcBmRsXaz4PQyLY9CVtunad7KNQQ0DowVipK6Luktl4b4Mm1QAynhH+?=
 =?us-ascii?Q?FNIpKQYfRG12/KtAXJNG+cdWXF230fTCNR/mGLm8baojfwWcaFqFpIO7wtCu?=
 =?us-ascii?Q?JibP6nTfVnpmFArqlN8L3ctPQkwm51nTNGoRlMQN4eTunpna4Owq6EQJ5V32?=
 =?us-ascii?Q?JY4IfxXYOhJYWOSr3dnLzlh3CFSpZDpzh+CvDDtwwr7WihI+52dXSebr/S1q?=
 =?us-ascii?Q?GEkNTsPRBNJ9CAuGScrAO3M6eVm5NznNkcV5XfAzsG4rx6wPgjq6rwlDL3la?=
 =?us-ascii?Q?sr1qvRHdxcg9x1L13POSA6F6fxJDJHFDgUHl4uSobDXRdJefsP6xmY4KqUFB?=
 =?us-ascii?Q?aw+76yOVgRCiSega0r4oQxb0CeUGrlVYH8ukKy27gU+DDLU9g/W4TCsTihYJ?=
 =?us-ascii?Q?voZou3RExm+CUilJmPLab1uhusjuXQA7mKnLOeN4YJePRyVp0av3S1NII7kd?=
 =?us-ascii?Q?09Q1iknD4zf5eMgiUVpFnJsHQAvywVQDD5844NKxssNny1iiQ1U2db3jhB8J?=
 =?us-ascii?Q?Am2jA8z5?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b95b21e-b402-4ca2-ed72-08d8c70f8cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 00:14:47.3741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDFrftP1PZzYWA8zN4p5kzM34RlSZEZhEZq/uLa7qIAREcnk1Lm/A5ClplW5fPuhVIsJanmto5SENoyLPtd+pqtpp30zI6l6R6rMUAicd0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_191449_965051_FD11FB17 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/1/21 09:29, Christoph Hellwig wrote:
> I think we can just skip reporting the backend, as this doesn't
> really add much value.  In fact given that this can be triggered
> remotely it should probably be downgraded to a pr_debug.
It is easy to grep the backend given that we have 3 and ZBD is
being worked on. I'll remove it for now with pr_debug.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
