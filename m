Return-Path: <SRS0=sRvj=BS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96682C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2020 01:48:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646832086A
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2020 01:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oi3zdeo1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WzIHby7U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qRkJDrUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646832086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=g5avNOhO5ajVWduODHjfBsyzVF8Dakqk4Q3bIyX8xd4=; b=Oi3zdeo1v05hRXjpzIdtF3dWo
	wwHUxJTAUUg+BHRIMk53XtAOCz7NUZLwWCMmv+K2irJAY7gkdZVKjXofSi2fi4Rq2Qakp02j6JivF
	q51SwoHxeNLgSyUo5JsNcMJTRCDCKwleKOBjU0XwNL/huUyXOQ3rKOGv41E8kOdNoxbPoQN8j9JAH
	oybpmuy2RY9No99fR5+eriwneOsfeqDyS7nODBd+CY3iI0Vajr1jrx+p+XpwfV/5rhIZPkfKctsbn
	21/jxidxIaQ7Hk3DLO4Rh7S4Abui2YaQF6+LzgR1j+i9+cTpLsFJ+IjXw02xdFo4RcClIyAIk6T/I
	Pd4KzpAlg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4Dxn-0002xk-Tl; Sat, 08 Aug 2020 01:47:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4Dxm-0002xH-3j
 for linux-nvme@lists.infradead.org; Sat, 08 Aug 2020 01:47:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596851278; x=1628387278;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=rCegO9ukV37K8mwAmVygqH8R+MCPhOsv3aFR0UV6EkU=;
 b=WzIHby7UvJdmgkivn391th/rpy6IpewWh3/yAI3pYMW3qMtpByEmsZgY
 QIIkzzoAC++wm9u+MKobUB/G2jvl0sryI1vtj+vMe+XY+DEg+vwab/akp
 HhGUjI6ic2G757DgicTXGmoTE8QjuQGfX5V8Mac0Sxi8EXnED/LtN25YS
 rN+zqCwpdmyv9E9M4dDNJ1yASsBs41PlCHXvHLqhyjagZaHtBab+VsN8K
 xv/qV2n5N/q7jJd2uaKhZn77YU5ooieM4YvYgNd1brkC63sckMmYMGJnC
 l63hfAYaaC8K5xGrB84tBWpDx+FJEZFY72uKpUrCnLoDovH+eDm0Z3JWd w==;
IronPort-SDR: iwscVfPx/WempDnIFTedJPZW8c0jPyluoK6Jpy6AQ3MYanvDXcm9HwNyHQRqyMPu4r1YyCm/nY
 wR7dvZ/Sv42ahrX2+Jj40aD22XB+JKS0b+Rp+hurS5ciOQrvvFqWs3+PBwX6IJljUEhRQAy3IU
 uDPM61iqhPKUuOaAzF2G1WcGn4jzIne7Fd+gmbXihAIBA9xIvuM3Z8ZHKhFq8UWbGTwIde3Av5
 DQIHETKHQnQOFvSQni8fh/hxgQMBAC1qyIsj//SU9yJri6J42p5eOpkzeBMzM50tNJUKL2lPpw
 Lfg=
X-IronPort-AV: E=Sophos;i="5.75,447,1589212800"; d="scan'208";a="144442908"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2020 09:47:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg+UtL3Lkc74BNuS1n9sFszXNk+IqksxfC/9ysIx3TTD4/s/H/hOt2XgHoQCu4ouPm4CxrlrmDj+PA1RvaSH8Np7trvtlly876mm9+QlZdz1pXSyfZ1qz9pjV7X9i72FYiA93Tf0jBG1+dczBJJSyZA0TW81a45jLtzdibYCpgadQ8lFnNlRBB+eyEhU66PWeRqy0RfF1MPdRuXKBPTvUvWsfFE24duLRa3gwl7uR05Sf9ZX410XL3glFt6+muVRRCAf77PrTYChFMfXuZ72DsMDNHQYwLDLMqaL/51NYn2Ab2JY1GTU+2o6SnzYq2HtLn1zMYVmI1KcCB27SobMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCegO9ukV37K8mwAmVygqH8R+MCPhOsv3aFR0UV6EkU=;
 b=BaupdJuytRf3b1hPwfhXfTlTU5s/3kLf+5YSNa51WOqjUaKNyQ0dH4KR10kyB7AUdP8LMzNqoeAokhJTBp1EPxj3egKWXHyJyzDM597YHZn2Q6oLuN9HiEoQNZNX/Ej+KaAlBg5YFPxnCcuemLvWb04W91kA3S46eCaEpCuk2XhWLInZ8OTbN20kAX2jKS6d1ry2MiREZJHd9MR18pHaKW6CEUmquT+8Se3lGW8bcgDEDe6IyVBmXp7xKvvW1cTMBPfYKfWuS7ZXpEX7wLohKk8lkqdjxPJKYjWLBTDMDZRx1x9MEoi2fA8NRWWRSPkyEZ25vYXGk5XJqP5mkespWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCegO9ukV37K8mwAmVygqH8R+MCPhOsv3aFR0UV6EkU=;
 b=qRkJDrUI/Tdj2fYIRKx3tpnYqP9npGc/oSOxb1f8HhjiZyAlxO6tTbaJjv9NSPPq1HWHTa65Qb0uNRlIC5e0sCmcmEmS4JONbCxCu8AeaZyT4ErrQAy/OJMnZt222MEffwKD0o35HYMzOSJJvdaB2tPeh1T+zHQ0nE7SkpQ86Qc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4661.namprd04.prod.outlook.com (2603:10b6:a03:12::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sat, 8 Aug
 2020 01:47:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Sat, 8 Aug 2020
 01:47:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Topic: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Index: AQHWbCXyfk97HUGSg0KKD45yS5/FoA==
Date: Sat, 8 Aug 2020 01:47:54 +0000
Message-ID: <BYAPR04MB496552B8C73A602C25AA67AA86460@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-3-sagi@grimberg.me>
 <BYAPR04MB49654E81437918F224CDD26486490@BYAPR04MB4965.namprd04.prod.outlook.com>
 <aef21d09-e31a-de7a-54dc-974c0d65756d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d48370c-aa99-49c6-7c89-08d83b3d11ae
x-ms-traffictypediagnostic: BYAPR04MB4661:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4661D14009C171CA4266333586460@BYAPR04MB4661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1dCHB78ZBoLZaEJDDXgH15jSFHC6fISEiziqAg52ACHaAe9f77NL+R8VOEM/P1f21BUQisX96StHCifCQCDZxv0wbbRG3o2MZcoWua2/ztdAj5O1a+Jrl9pR2jB65y81IP1QzjgxdC1wdVptv+8Gq/JGidsH35mBkz7TxUCjKtbJ9LchInem2Gw/reeCPm6mOfegUfpE6bf8KnTEZp5dmEEMAMpe01UxzWSNAU2T9Xw1Hyf/E6umqSPN1rTeOVNoQLNBNa4Lb0rFwD4TrcXfdSVbbGUt2lAp8khfpTxG8rIuu1AX+UQkR2NiAI7qSmN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(5660300002)(66946007)(66476007)(76116006)(83380400001)(55016002)(66446008)(52536014)(9686003)(8936002)(66556008)(64756008)(2906002)(4744005)(478600001)(110136005)(316002)(86362001)(54906003)(7696005)(4326008)(26005)(186003)(53546011)(6506007)(71200400001)(8676002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Z1fxvmtsutb/FONkstRpzx1hvJUSmpevhs1JK+ap4Az1pYNcyOncWNOcnEwqeZaBvLt2CxvhMKVl0Io4zcneB2Ho6yInLy8N1cDfxLdv8jO9RO9R6DwdYW2DPtvqqwI0lVs/FMpcsDGpxKES9yOuBJA20ApKWyrJvvFCiKjDRFR0rrY1OF53irUwxWoTO68gpo+ikzoEW5J+2BJuQa8VhXNKUKq7aetNZ7rFNc8nQRNaXALTjPP16CTHZ1dq87xMH+FscxjLLZxgGVReuVXwF7neJBXjitJkDL41JMlHzXE64RwAx2gyxTKaZ6UyEJj2sSbQOXF+H4oPP+L/nTTUhjGqW1wkSrY1iuxdIyyMiDFbVPDWTD4pKefWeLKMMz3KjrtciArk04sQtWTIW27KAUoRLtfee+QoogUf7OR0YPbB4L2hjrbRRIOMZxA3Rn9qOdjUt0Ki4muXgz1t0qeHkHzIxeel0zlaG4EpAIWubajQXqPACpoGrp4UDUG+imLC8UMnKyJH1Jhy4xxsl2NmRmY2shvaneJILpuINrTxAR/A1hQY36hpPMiWMbelkkEUlu8Bxv1U62sYXPZ4fzWXrrYuc8EJwUBjPNBLm1gxgisonjuV+2LlTSjnpVhVaBShkkpZBAJU3EDqApcEI9mh5w==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d48370c-aa99-49c6-7c89-08d83b3d11ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 01:47:54.6857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uocRtmPxrlfXqBuTSZX8E2p+58tPUCpR7xpH8dEBFcdnjpeyadmIY1OFKZNc2cDso3bqvrRNVZvJNRAbHnMtHGKbsb/BVUQh1dJrggR+3y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4661
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_214758_277020_5ECA4836 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/7/20 10:15, Sagi Grimberg wrote:
>> I'm okay with having a wrapper for disconnect but for connect and
>> discover command it can have many arguments having a call in the
>> test-case might loose the readability.
> That's why these has default values.
Okay.
> 
>> The downside is it will need argument count handling in the future
>> and makes things not easier when user want to skip certain
>> parameters, closest example would be _create_nvmet_ns().
>>
>> Also if we are adding wrappers why not move $FULL 2>&1 to avoid
>> duplication ?
> Not exactly sure what you meant
> 
Leave it for now.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
