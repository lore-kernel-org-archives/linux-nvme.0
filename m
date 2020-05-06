Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0941DC54E49
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 23:42:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CCB20746
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 23:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOTqkJvx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WC+0Cx8O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mFY/kj2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CCB20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=e3RQH2446ixL6+WCbFr0dmrNLYn1ASzvLM6AKRc+EZE=; b=jOTqkJvxdA3bwQ
	xwe1ZeXWb/60ZoJGmHycDKvxb2TsVec+qn8mAQabCs0o5rO8UcjuczkwNh7+N9Jurm4dK7Jsn0pSl
	tfPxXmzg2wFhnLrctkggY5NdL8MUkiaIx7WLwo5E9YwuHel90TO5+2omC8PVxfMMLHMl1rXTVSZjr
	w7hvZbnaPuxn2K1qpjtDvY5TnCeUCX0wqemlWAHDTnMfkAMAhSALweNfZbMWhXunX6QF8lKUN5vpM
	7gQbIzJlJ7oNMHw3cFc1Vw5LdAQhKmioh79Crr9kI4dCA06wJNblPO1AETWNd+WDBKrgA6x2fOpOB
	QmzXE2uEyYvZJ85Y2Qhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWTgG-0001Zf-Fc; Wed, 06 May 2020 23:42:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWTgE-0001Yf-Bv
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 23:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588808542; x=1620344542;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=13TFfMIQgt/XNANwpXXBJcs+4LKox6qKCVibfBElERk=;
 b=WC+0Cx8OH1EFywlJvfQZatejL0xhdCT1e9dY+utlsopN6jXqAjtqd2lk
 Edig9Xed1Mzaci++0Lpwx705+8IivEbEQoAByAUPekLUQ266ayjaAweCo
 F8DYtCWxs6ke61pN2nBADl7jNYkn96XeBZdBJYBrN9uRA4ulLtwIQFmCn
 S3yndwSHVTLG4lRU3ZM6yNBbu71XRmZqy0EeoXCkRYjlgYygvqa7cc7Wo
 bJzXY0CJCK5XQ72+dRRwdgxzIxtoHPd/VMjWqa7A2c3ej5HrTtpKkdoJg
 4XMku47qee0NPPSvTvbnYb/mKoWxUQ+dpzrgqqVg1PcGp8Rlvh4yFhnpo g==;
IronPort-SDR: LXqx9w4WmzLhLh5JRCBPBbBWim9EZSxAncICcK1UJBlTRt20xPH7Ue/haaBiYr1KBRZCCi0YPx
 TcFANslnpE2amqzA+5BvQDbYR9t6MYxqU8z5xULmR1bv3ZoDMPxUMnuTojqchLd1tWZ3lF22vR
 2slke7YqqETRvmZ/B+sMdjMWM0kwSWnPY7U0lcMseNOVp/xuW0ursU7Z/jnAbeBGWwG1+JZqQL
 PwKz2E0ZBFlB3fryQog3Nsg9KkOHt4sqKnJqwnqnrVVyfFP7qkLiJI+MIeurNm+ahGbhKcR82f
 31I=
X-IronPort-AV: E=Sophos;i="5.73,361,1583164800"; d="scan'208";a="137092774"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
 by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 07:42:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GblwOiNinkgFCB1rUOkYIEIOi4MSu2PGZ9hMJnRyrxOlxO62aBgel90QV3kRpzkfHEdjpVwf9Dz30bDCaXhUQJvtashlmdm5XHaA/xYzAbVWFvWcCwjLE/9EhwjPP80jb3T6DoO+liZ1fWNUZtC1rQ5jRTO6jhTb9IMu4ftykZZLk5E17PliHiKlZoVQSui1zdlM/Pp6YKr9regZoNiYOCkbpJ8W6oYUVa9WUK0p+30dQO3/oC9DOL5xttE91Trp3gdxvvjAFg1RYtl3IlsYG8/OkhM2C+BrgCfyjoIavb43IzdoS998p9zZYuipe+eVXHQWtWDH3In6Gl7Bas+Ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13TFfMIQgt/XNANwpXXBJcs+4LKox6qKCVibfBElERk=;
 b=kbqMNqTQZ0r7za/uItsqEpXlswny0figsprCmWz/ZGpKEZoS3g8CHxqkio+Q1GzFgzvmQV9mmb3Z0YFXSKxlyXO+DVkZdbaS08Id0xiioGXmvXuwIudIebiYTdMPCZtcy9eI8n7LGf4k3uTKEvzMVvRFx5iQHJWq3CHKVPV2KiRN9c8rNnCL7ioQ7vzlAtk7UE8veI10AqWIjnD7TM3WV17DHvxSATes5FJchTbb+8ZtEyOdfKWeqvsZgftcQZ3OD3gOfH4+A7Su0788gbz0i06+kXODpiyjXT7tLiquMWPe4RBLM59TMNWtCXIQxwuI1ny/qgH8fzd2gemYmk96mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13TFfMIQgt/XNANwpXXBJcs+4LKox6qKCVibfBElERk=;
 b=mFY/kj2xqSgqVka4WNQkunpg8u5yNjBosVYw5WfOKXJiv177cf5d3G3+8KX9nFTH7WJxknh7P1I9V/jEMxda154G8Q6wGLd08MG8N77F7B3GCVeW8Im9/wivf/y2He5i4/7sseB5BhM4dK6H+akAyz+rPl2WZRwaBnyoNMHJ2E4=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB4138.namprd04.prod.outlook.com (2603:10b6:5:a5::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Wed, 6 May 2020 23:42:19 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae%6]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 23:42:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] nvmet: on ns size change generate AEN from configfs
Thread-Topic: [PATCH 2/3] nvmet: on ns size change generate AEN from configfs
Thread-Index: AQHWI0hGikd0EjJKmEyyE1uTM6iO3w==
Date: Wed, 6 May 2020 23:42:19 +0000
Message-ID: <DM6PR04MB497285E282365230AEA6B19286A40@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
 <20200506014629.39509-3-chaitanya.kulkarni@wdc.com>
 <20200506071325.GB12145@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e63d2361-d38e-4a72-c3a1-08d7f2171dc8
x-ms-traffictypediagnostic: DM6PR04MB4138:
x-microsoft-antispam-prvs: <DM6PR04MB413889294307E21F4F712E1A86A40@DM6PR04MB4138.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUoqYYVyQBhDhrwEr8GexnXoDPbn9tH7pAQSiCpeF8MSDVipRzrsD91387og57Ivt9Z3MnIvuNSgb+MEWieKJXrCFlTg+gkECC2ysE6gT7c+UNQyB7H1Ya3E68kIfZvXrHQQVaY4P7CCDyknh3ESgWCs4uDdp6rOzO63XtWp6SlORU5+Ozv2GDe29sHiIUuxM0UMx95biD0IdX5tkPNMl4FLVR6J5tIPtrhNDRcyLAo3Vc+VkJeM9MKh18dP6FOxuK+zGoCfT53z14CL7LcN8yyEC5WSIIZsxpwdEWaZx0SSE2bWGyItrMxiQJA1jaL8bwhTdsngcIpgWFdtNIYwTJq8HzIk/FdXhp/wZ+c8XId7tHsf6VRJ1epVdkgFbtM9k8vBQGOBjBgdOj1VFiNvquJ8JCvTBjwUo+/RaxafdhRqKV0VoBKEWohk0wOpoXksI1kGQX6xyalj+XhSl0SPOjqRe6zE8PmqMrLH4CyqdlX6lKs1p+h+bDgJiDOcpczFFMUbnt17vpLFHwtgvck4bQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(33430700001)(558084003)(9686003)(55016002)(52536014)(86362001)(6506007)(53546011)(2906002)(26005)(33656002)(316002)(33440700001)(91956017)(76116006)(54906003)(6916009)(66946007)(66446008)(66556008)(66476007)(478600001)(64756008)(5660300002)(7696005)(8936002)(186003)(71200400001)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 7eCTSskW5ac7EoSNOT8NiwUTUNDqzc1Ae4X15857jrx7yTse+MdGR8VMqpeD5+e7ORWUOMXHDSs2bVxA/tTfExlirWHh8oWinzK5BlXI7gJDKBEgHXbtTt6sfsREKUB1ZT2LFnOrNTQ9JBG53qkpF6MGiZ+/oUXbUurIT6dqaB6gXKOOmPlMs5cbyqgLnCgzjK63yzrop29xX0n/iHQC9eC5eE2tq9c4AgNejyh0bWQ0lF8rH6hCH2L/xhU3iqjqdC3tre8dBG0d05qVgUWlrH7XdyxH6SRxO5PxLdIP3OdtDxGyBGkcdUdhRP1az9pNjdX+YipaxMBUrGKpLJgYnaARm6eQrwvQDdPvnLHtAuPtNJtk7IVq3P/aHvwIfUhk8qIXL6OShgnJwdI1xfAx4+gt+K0ukj8qLyCjiKkJFEsJkoN0OCWyRgswv8xfbXGV/Zd2vNydDDtGLIlc8r/AlKflqEh1tfpK3fkxqOyrnRWpeOqkzHVmxmLeDLBNHNHGny0hbnjsRfixB9M76RPKS9wQJnyRONBTKL16R23pgpT90JNPOBA+KDuopYdUTXD/Je+IC9DktOgkbz+GeahQsrJ/nbyNoY8dQMJeOwoSpIj7bEuutIs29cpOypjmTVjIBKRkQhYI9koFBJ5qLKkyPLMyckSu9+0uFyvMyeqn3EooxsqOi5HRK9+1hAKtqu9XWVBv/9G5pUWYc96XeD1PbHU/4+tZPjiF1rSQiigwemIENb/XNwlmXOEny5bpBBPcjrFGquDwZc9XqDqVBcNkRu1XTrCNQSLYeGNka4LfEF0=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63d2361-d38e-4a72-c3a1-08d7f2171dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 23:42:19.2961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaPJ7vJE1qK2OjBAmVARx+GyUomuvRe9U/RoMZb12MUQSd+O52IIKf5NSEmm3XNdsEXHR3bTj6u1MzGLLn99DYm0aMacT87Z3cUDMkLiDJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_164222_490686_F6C5B53A 
X-CRM114-Status: GOOD (  10.13  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 05/06/2020 12:13 AM, Christoph Hellwig wrote:
> I think the nvmet_ns_changed should go into common code, even when
> revalidating as part of the identify we should send the AEN.
>

That would be neat, will add into next version.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
