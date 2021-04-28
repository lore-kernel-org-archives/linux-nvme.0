Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7447AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:38:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FAA61423
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FAA61423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=5RyLoXBdKCNz+H+xVGkGJ53QCJaNgOPOKonxIz+h2lo=; b=oVhhpuig6Myg6JoVQpH7S2yYn
	e3cMaC8rPgZjVyIUAGyIebnWBC8ahIZ9ttM4ayxZFc06SyuuI7PiyYDkA1H88ojBzkC8nKF0ttjn4
	JIaJ8sb7W/7yHmM4rMSneoravcTIyVmVP9K3DHzOqyFoWAjj3eyfy16D19qgSCr93BSQTmpuf/oN+
	2JFTLJZQmEs4y2aZNnzFg7r6rg34OCfCN1e0d1Xu56Tdw3lrDeLQQ81BoAXeS4ZyswD16Gvh42iqP
	IdKuspKFjsWEBXpeIWGF8yNW6uDZkrMlH8rbES5pN5GKkfmrmeIV/Dv6CYQvUkLLr9rd1q3E8oTzc
	5Z46bpHqQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbp4y-0045Mu-KG; Wed, 28 Apr 2021 18:38:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp4w-0045Mo-Tl
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 18:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=iF8vWN0vS2AZK43b0djYXJcBTz7CBISTXGlhypgmw8g=; b=FlLagBGXKzdXmdTkb7gRiCnFLu
 0/Q0FB1nRQ6FxXDHThzoIJ40TeBpYTdB1ZMEbHZ4/Y4IM+uONXH5NLRfBlpz1BQVbSIZYHRbQvCOa
 Kt9KicSXYAcIo2wnY+QNspSrMR/at+FTjvbvPhYFQrW3+Pzrg/48c+Z7wlvYd/KQ1io7krphYpVl5
 K7D5Yv9/V0kPRk4pJpdBV9n3ulcaPSBOXxEKVRH9ouNkBpHdclwLEQWJU5w7CWqclBgiKo3BE8DrP
 TdmuwVYoCHj0cAwrcBl1M/YPsaAwBIav852GciJakUvthUNseQxcaCcelyS8qNj74/T+T+uha/Tqs
 8+8zjGSA==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp4u-0007G6-JZ
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 18:38:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619635108; x=1651171108;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=M8W3YDXloy1jRsuHadFGoMupKiD4QmKfWrWBYdzNtA0=;
 b=SoTxtAyYwQnc/R2sZvHGiemXGTGgpPkY2wZmqEubkjStKN1ra5wmEfnf
 T2cmdx10eUIJLYNZodx46p0sGFi/hM4ezDwF7GHSRV9OCXd10xI99gfVn
 DWdbLySX+EPn2SrIKJVs0mVxWSq2fLI16v9CzVBZTcXPlmNgC8hfI7V/8
 voeqY6azVC2kdfOzeamTpHZr/bfFDvwyZtBNKhCDFQY0yKMuySIvx40cM
 V8O7SUloyDn2sPfm4IH4qAnbTU5o97ta4DDlVJcPC6DfrlS/HFRM5ovMA
 zvFXnxS9uVxPUet6NoOB8ARkmx6kuRPkPJdwxOPkY7fGUQD78qEpQsBW6 A==;
IronPort-SDR: NQhg88HY8cpfsup9yqpjXUDNip6yXZCA1Qyk4yYzLNn+B/7VS/kBzo+jgKXPG5L/aKCEjIUUij
 Ay8WEiWT+ruuhyo4e25x3ixmecNGTJsCYUapQEVpruUFG/YwJ6Bq2HTY6kx5tWjBX0VrRyWMHY
 hHo2t50FfMyrwmQiOS4U+jLi/OSVFIZUDfYsTs1fiBh+cuhr7KjnRihfZWI4nP91r0xaMJNr2y
 01Ic6DsbmIuuD//P8VIOcLk07crmJ70qOcOgrn/jOWINIj7Q+aa5TJKCKhwqIM5eXDjfg+5BdM
 ZG0=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="171106307"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:38:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqqrwbaXD8CxYMVtkdbs9nAOLUmRtNZIp5nncS84i02PYzETKzZLVZz6ELPkTfpgHtYIbzI1dsbMGsvO6SspJh4dPCZSjmDICkHeZCZ9IOmDvngwhN/DU6NsKdp61XqzoYVHOrPl2pQVkZC9m5ZUFi3+9PGVAAUSsiH4pCOmY5IQxwSNyL9PExEWFaQScZuQvPi36Iigo+xoBfItaTwUqXItpO1bRPYMgLT0WN6xYiviEGCInnt7ZqUKyiXUpIINL+1smz7QGa4aN7zsUbNxCb228mZi9f3LrJ4jYkKpXRGJmz/JTmZ3JCCWA6Gfjk3Gtub7UatPPdVyNd9LjA+vhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF8vWN0vS2AZK43b0djYXJcBTz7CBISTXGlhypgmw8g=;
 b=Q1vGN8aDt5bAWsFL4X/EuVF6fkfha6KHG2+NYwTfHjVWwmC6pbTjBYKQjJhIEWervsJiFnvPdCZyl3Sqe3hKeCkSVwVAePyvMr5Iwc8STAY/mcfAYz6OBCcKNkwxMLu0jmnqJ/0ql+REBN9rKSk+Jhhjtl+k5gNcSbJiEqW9Nr9CeYPrpRi5wae4ENf62xcvtkl9pCOOvtCXIyk0gr4fo8uiiLPijYzhTORSg4uBixQaWVCXyTdZFDwx0IBcAaVPS4LOJsM0GjKcUvZAgEnE9UJnYuYVdRetxSKuXyeCpV8SHsu3VVtu08FxZFKTRkE198XOObm6cxuHknOSVyObLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF8vWN0vS2AZK43b0djYXJcBTz7CBISTXGlhypgmw8g=;
 b=c821gF3VndtpDeIYcBFwRS8VM7R9y78Ein//O4qS1kJF66UyNUzpHL4ihgXlWhZPzu/jnBVPhtgCxQcpRWmWet+zSsgwa8rylKH2j0UsyPV2Frf4Rs0C/xIHUh4hk4vG1czxfJdzqQBdig9WdpZO0xxIHP9+ipkI1i+8nLkioDU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4421.namprd04.prod.outlook.com (2603:10b6:a02:fa::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 18:38:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:38:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "wenxiong@linux.vnet.ibm.com" <wenxiong@linux.vnet.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "keith.busch@intel.com" <keith.busch@intel.com>, "wenxiong@us.ibm.com"
 <wenxiong@us.ibm.com>, Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>
Subject: Re: [PATCH 3/3] nvme: Update several detail information in pel code
Thread-Topic: [PATCH 3/3] nvme: Update several detail information in pel code
Thread-Index: AQHXOtH7WAkrtd+TmUmE4jBaAmQeDA==
Date: Wed, 28 Apr 2021 18:38:26 +0000
Message-ID: <BYAPR04MB496548FC9612251BBE9E4EF186409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <1619459538-3998-4-git-send-email-wenxiong@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none; linux.vnet.ibm.com; dmarc=none action=none header.from=wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5000eaaf-32f7-4a2c-04d6-08d90a74cf68
x-ms-traffictypediagnostic: BYAPR04MB4421:
x-microsoft-antispam-prvs: <BYAPR04MB4421A2CCF0157AEA9AB2680786409@BYAPR04MB4421.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ynQTzoyubQKAFvP9lkL0/Mud3I4r883jo/Rw0gijT0wPZ0XPfKLLyoYBzs7H2ATuduwecHyYnXKLIpk2Yjj/ZQcVojNn/ebv4UyuIkSELlvubRRMCyZDKWyEyLdRQiz0gI9Lr4qcBjClMJdnbm1L4D2s6xaOgIbGq3tHgLWioRlJ9AO+Gb2EDnWzWmXoimmqVLA/6rBURWU8qihgZcStcsFm8W6hTDN/LFXyLW5QLEzEyPlriL4D5Ok+Zc2zTl/bw0uoT5QQA/bdGompJrxV2zJHWPgryw9NDD44umnjZxRUNC0rkrhVt/vksnvNMdT3QQvG4yuR/jzssOiofE1vGaE2vVGlFlmkY8WHbypU2feqxSBbnb+TJrdsiHae3sv9cAiN9i0tgJJUDXel+HjtpdECzCgdpKrJ7enI1GNrezegxN5woMUdXFWJBBhffy345WCsgLDNL0mS7Ayj7VC9GXFic+x576e78R6xW0EpsFkZP4+eK4Q0mSR6aN7Ms5HJcxf+HYtSpgvupPlYq0cPvgx8FKnAk1lssrn4RDINe8fCyZ8H000mhgelZEurop06gla3BPiNCWyTvL7hmQ3ChZJIJ42z9FSxnKHq/38VZxc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(38100700002)(66556008)(66446008)(66476007)(26005)(186003)(64756008)(122000001)(33656002)(55016002)(316002)(53546011)(5660300002)(8936002)(9686003)(6506007)(110136005)(76116006)(52536014)(86362001)(71200400001)(4326008)(7696005)(54906003)(2906002)(66946007)(478600001)(4744005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dXiLBtxq4y25Gb7Oj3Wq1/3CIFdY6x5pmqeHlfA+zsLYilDwxFcT1PMFcuxq?=
 =?us-ascii?Q?FsFi/N6QaGyuAwULSuJm63dhWAwyPLlRRFK4+2CDsQN9VyUGknKOk8bKKn1L?=
 =?us-ascii?Q?T2Nqe6o02tsGrTI9rtOkpNjKDl47e9eDkj/SrabL8FJST/z4gu657tkJmnwT?=
 =?us-ascii?Q?cb60oNbqNvXpTtfFoAey+Kg1u5QDrXOXLFP6CpgiuOHsX+4rYda9rlyjH5B3?=
 =?us-ascii?Q?/YHRqfYMRt9gNfLSdktZM/fcBeVRUwgpBPEpI1QeCcY6NSBoERzRrKRiIYj1?=
 =?us-ascii?Q?xUl19g8U7aKktz3pTMy8B/Q8VIRJA90FnSw8OdQvpjFxMs0FG9zKfEoc1snp?=
 =?us-ascii?Q?0lUDB51XZIUr4wtDa5JWkgrFGM1OSDOu9Fqn0Uu3HVVvaJzvCuymE/OK/N0+?=
 =?us-ascii?Q?icvOnqr9dEep90eq7uPP0g1BQRowVQgdwQ3s9iijpRplL9ePyURRuWLFsBiS?=
 =?us-ascii?Q?N8vGjAQYuV0bloN9Zx8oxwBWmk1DqH6n2fwmHGhj1bZy2LOEZvtSkDxi7dcu?=
 =?us-ascii?Q?l+nLKmsMIBx/QgWNboqlzWHjItPkY8ypY0TpUYC1CvYmZ3wST27tBfoq/W5h?=
 =?us-ascii?Q?3GdDJ2Cb4112LgM1ut0AIGbtnBYBHivrRnKYdiH63WRkCz900DcU5fmb+L1m?=
 =?us-ascii?Q?Ah8o0Jddiq2aZ+uRlz7uC7kWFFE2APJhSHft38s7lNxQdPsQAfwACcNQjXYu?=
 =?us-ascii?Q?iiGb35pEPE5le5aCMIt9DrrW11wuufqaK+89im0BAYxzkMorDHWlbWxak/Za?=
 =?us-ascii?Q?vShz1s+9pjjm8MQh0RZMRED2IicIe0unOSunN1EsD/V0gP8RKU5VKEd8iYV6?=
 =?us-ascii?Q?/qw0GF8nqhmsfVJ7gZ0THdJpVkpPyV4xolRICzyIx2R2pMG1l9qwRyYwiOEC?=
 =?us-ascii?Q?ict+lBJUxVZ/RwMP5flZo5dXkCToJoq0QErbLb8ECN2ntY7DOKLo74Q1hoLI?=
 =?us-ascii?Q?kiAPfKF3JIReXPsJ3bUxantpkGL1SkpORINN3soYRw6DLtsbcJmiG+rl8FSc?=
 =?us-ascii?Q?HpxLwtLbMqbk3DsqQr3lKYdw7nAGcj/xDyLnMDPCgENr+JKbGcaMxMrk30qr?=
 =?us-ascii?Q?Oo/GSPZBDPXF2iPSNmzfWah36MR2BggeMWkjNrP8nGArTrhqu8YYhB0FKWUF?=
 =?us-ascii?Q?fX7R/080etDWTGl4AGvLDr5lWuTxQzB/wjaAf1u8LoTozxkyP0SabiUvUoMj?=
 =?us-ascii?Q?jzcDl9/8IP5ceJANXJzoj/g5kEbchaYfNi3iTeibUQKc6qgmadf1nhyOktxL?=
 =?us-ascii?Q?yPqpiAYytjtutevLE8lfuXJ26/6zkPaDUPYU9TciDG4m3+jj3fcBIO/G1eV1?=
 =?us-ascii?Q?xEGWMfTW2T8z8Pd2/m8ez1dq?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5000eaaf-32f7-4a2c-04d6-08d90a74cf68
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:38:26.0761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/ZvaOJflWDaVTS3ldoW7aQuNd3TKFstbHq2SMyNfwdel6PI4n4ytEW4uE3ChkYi4p33dhrErfdAypX76Ppr59rnN++vGzhhe204NOV+LI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4421
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_113828_669650_D99B27B5 
X-CRM114-Status: GOOD (  11.02  )
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

On 4/26/21 12:25, wenxiong@linux.vnet.ibm.com wrote:
> +uint64_t int64_to_long(__u8 *data)
> +{
> +	int i;
> +	uint64_t result = 0;
> +
> +	for (i = 0; i < 8; i++) {
> +		result *= 256;
> +		result += data[7 - i];
> +	}
> +	return result;
> +}
> +

for a function name int64 to long why the return type is uint64_t ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
