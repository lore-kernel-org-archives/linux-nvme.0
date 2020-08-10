Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F40C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:34:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69518206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x9820BjG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B4X3LR5G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u4agRWp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69518206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=0ruHsIviKRgt2fwYJyy4J52mJ0LDOTpnsC4+bR7bSFg=; b=x9820BjG8uEF32CN2lckDFabG
	HczTNu5XhVn1OXAFi56P2lVjL5JXlowUn1tSQKQPrX3XX8PIz76STRLsTqCDtfuZhdQKSh4ygLDLa
	Y+F5HOE24+CDYF3OwzeDcdos+6kCSMJxV9MPmW3apGiqijo519b0JAekoJFn9jod2e/NI3DF/74ML
	rGy3oN5EuiTGepXMwnD8hNTsYyLTN0SpBmq9qJRHKoVopCoB/kxNAcEB/Ly1f6cwB5k9WvYATkQC0
	2j6iA6YxiOM8N9q5tzxKf/5u/NIivlXlxtTZzNlMP/0xXMtheRjqfn53Exp4o1Mg1CxOfak6AO1LZ
	u1dB2R7aw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5HIk-0004xL-Pq; Mon, 10 Aug 2020 23:33:58 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5HIi-0004wq-Vt
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597102438; x=1628638438;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=QsPiTlmwfi+Tw3eLa3dHIPIboCb3pczg7es0oJD5Z+I=;
 b=B4X3LR5Gdio9gfySCmVzpxqjrBpHJ8m+UakEKr58wFSoiLc9VSTVYy/I
 8cNo5E7SuB27Xeue3CDfM4rAsDhY+jDDH01+yph8Y2Ld+8FtEUNn3E5uD
 JEIUnnpBtRfT1oxTboKjevOMyu0r0EzDk/PASM2QvI7sYKixRZ0Jdqu9k
 XzotYft4ME/LztuaA3XAHjAONN9mTfPHl5aHqBALwBljWIIAm12TN7DHo
 S+FQHokYKfdHTL6I0SbDDrfPBsO7oKeQKzgHMVolR95g1PBzWm5u1PeSQ
 adJQmucJb9fsg8fcV+pSOqnh5V6IzhhVofM0RpMrEFRZq7w/v2M/uOuNT g==;
IronPort-SDR: V7C+8TD+Gpa4yhidjZWZl+GhwZ4py77YkaYMPGjIdju5XyfnVWk5T8y20riAdqgui38RQQNogw
 emrEzty6QJtvaqbt/+uu2tUGJQ8HVC/MBgxpy7ma2Z/zOs80dNoslXznOQJbRKyS2l4XHLj0N6
 VJa91XRWATXIiEBaQ8bc4BEHI0vYaLeGS37XoL0L2u9CE83e/5IZUDMZfVDwRFbJbaItcAyqrK
 3uZTbEPUqXbGERa9VNOWh1G3CuGjZRPWueiIEGgKcwobByey1HRjqclbAHp8/9bZoMmY3D2hxj
 KRA=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144666749"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:33:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWlq7Bf7QJG4ehgmYuK69zY466V5+7QLrtvVKRKQqNy97LtMEYcHgGRKegoqysfpXqunN+mgV+FmzP4SnqLhJMxVrLkWnwH704/G7Q0LsSGqyqfloKEwYTc8UYhOO2fvjbKjHp1U1WwjZcQdrTbGBUuf7hSjlSnOOyxxSfbMmVP6c2HXOLyTyPegFeFCHIqGHThHxjNkKqiS9EO46AXTB+htSa4MT//E3SpZ7IjOrrVA/Yn9F2FLJo491XcBDRaDUD2TOPDL5q1xIYd28iZI6Sx5g6X6BDcxAdReGyP0vRl3aSsjqCNiLcrni7PXx9nbDVJKQxLUio0GKGcGjI94VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsPiTlmwfi+Tw3eLa3dHIPIboCb3pczg7es0oJD5Z+I=;
 b=Tf0ms9BEJ7FKhXpzGmdEC95+36sRB8UzEAlf9VarafooyZ30wKJynG1nCTWB9w+w+4cC9zJdUZ2bj2P377yxPgWaSe0kgywyk7MaQKusplKKnbDBridx9sLCTgAppIK8LiKOblC97CdoDLFhM8ZpGG8He8NrB4GiqT3S9kErlo9W+UXBYJqnf1iz63Am0xZY9DauNEQ87hfMn1mHXRiuJLIF2j6V7xQ1ZZXKdqRqE3q1IXB+6u8GtUDJk02qTrow0IX4R+s1/a0571QXlUMiyfh7t3Hm+05uqZ27EocN3Hs66xipPZXP37e4Y90bW2lNgE1t3XuI0fC8pUX+oyaI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsPiTlmwfi+Tw3eLa3dHIPIboCb3pczg7es0oJD5Z+I=;
 b=u4agRWp1m3FQ2Jo/o6MzkvyAwedY122trgWhzv2ND8UZ9S6gk86pUiQWVQweQdqDgUXaB4p8BUNbNXhDOEEQv2EBtWMtBXh11Scw4NivJBZuApLKYkskOk+LsxBuZnT326ej+Qlt+WiwPUjRl5HBlP/YVnWZpColR6S3YgeMRq8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5829.namprd04.prod.outlook.com (2603:10b6:a03:10c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Mon, 10 Aug
 2020 23:33:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:33:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Topic: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Index: AQHWb0fs0yKpxgu3gEaaZuX9mEBqyg==
Date: Mon, 10 Aug 2020 23:33:53 +0000
Message-ID: <BYAPR04MB4965A89BFD241099DE1C6B7086440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
 <20200810211119.GB269401@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB4965560F533D2B758FB7132886440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200810231053.GC269401@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB4965F8FA39BFE340075BC37186440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200810232647.GA866477@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92e90d7e-be8a-4403-5b01-08d83d85d833
x-ms-traffictypediagnostic: BYAPR04MB5829:
x-microsoft-antispam-prvs: <BYAPR04MB582933F4C19E83CCA294190186440@BYAPR04MB5829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdn6JAQ1eAFNurzhcONxeKUJ+YVVoJLPaItODA2Pjl8lJhEOhwkFe/5B1lTB9AGFGOvt+kSLlhn98I90Eo4syijLpnUDzTor1DmT4TnBKYT23t4BV5Xv7j3garfy/ICixbUTpdpbvt82kl1THrE/KMqWy1LPFMWe6SamRCkSf838aSt3m2mV5NgbccKZ/wb4QsejHebT2lKDlX7+7ewD6fuE0WWf1LrO/uXXF9zK/oyV3DOTCQcktokmXB2PSuUM+rx+bsgV2XwRxPT4OXECKbt1tFLK+AvjhWG/jzoOoj+NQqpZForK1Zx5dauIHC5QzJDE+m5aiI68C7Ttpgf9vA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(8676002)(52536014)(6506007)(26005)(186003)(5660300002)(53546011)(478600001)(54906003)(55016002)(9686003)(83380400001)(7696005)(8936002)(33656002)(4326008)(316002)(86362001)(66946007)(76116006)(66446008)(66476007)(66556008)(64756008)(4744005)(6916009)(2906002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: LJKRy69aQ8pPQuU11G12Z2bHnusnM/pFqm6JwmUJAkIA2ad8I9vvy/17+mSOiwBRV7bOMS+7WDkGHIwAlpuExU/qQurCwZostCnuqp2DyjZwwMIhnPVwTRd00z5FCRcquW4aHbbxqoyxiDgXOntovvwy86Yc59VTgu1PIYqV2fGc/DyQKEelokOPpu1EDNtJw1dVwJt5BjSgvpPzQctvtNY6h0qBK3JfLiaU8vsLvpVGHD2cCXiZx+nDw//RPNZGIiJLb72BVp3vRKkhzYhHtHa+5fTszY1b59I4BHtnzvYQtKcaqxO4S6BK7wfZZgv0VhkqpN9IbQ6mH08XCQ5WztLekIVxMG9EQ2Nclv3peK4BdR/vkhgFX32TrYpKzCIoRnfmsqPlpIo+9BqQExTnu+UWef3itUzNz3EnRV6PgjRh46/mzc6Zc1IUiQSwMMSd9pggoip+PtNsYOtaTk11QXdyHlufStfQgPIp1mPkxx4vHA32fHYhU/pVRMYZhH/RhfveYKVDxAMvfKBYr+Y1cK5/0audfqwsVMb2fdmR9v5pR8Nhqrt66qkvIiewR4ZIt5rW6rxe1d0vTfTx5jlR7dtx7scCZG9r4Ov/6dwoL00X7NdWSBFZyU3k8a3jF6oxjxInvV7WzSUOR6Uakn2WNA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e90d7e-be8a-4403-5b01-08d83d85d833
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:33:53.9124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DX+2FqmKRUM+mAaxkMftD5vtTAJHNog/SWMrnVPWKcez/k8CP42bLh1Z+MaG9uPlyDmHQ3yRvC4GRqmNcJW7EJtftcu9VoDORwrQOlnK/go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_193357_193433_1C215ED8 
X-CRM114-Status: UNSURE (   9.97  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 16:26, Keith Busch wrote:
>> Then we have to remove in bdev backend also ?
> No. That target doesn't use REQ_OP_DRV_IN/OUT request ops through
> blk_execute_rq(). That target uses REQ_OP_READ/WRITE bio ops through
> submit_bio(). Big difference.
> 

Thanks for correcting my ignorance, probably then we should just remove 
it, will do in next version, thanks a lot for feedback.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
