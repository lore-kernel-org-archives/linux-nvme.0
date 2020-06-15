Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CB0C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 12:47:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1AD2067B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 12:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lw8Ug6Gl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QNtJVDYT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dTwC2Qkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1AD2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8w3VRkN16ViQCT5r1iFRsfcFf8xWSzvhdMdbbGzTNAA=; b=Lw8Ug6Gl+dKqNx
	zLUJ4iLtPkFo3VbeE3CGHtADEnrOjTJAkGjZKjrTHi7oHXnvUUIsO7FnZEJqHY563QcGrcI4L6WN7
	biDxhwNiHg9CXmkf0M23tP94+pn6q7fwctrsQAkhhdjb3Rf5RIDu5yZEeL8fmMPm+wZtqdRD77FEY
	dRzNo0wOsgzpfy9VHM2YRgxIbOkVtQdj1okOEUSTEn4mrUK94nCxaTqBYt4JsRVL2aOKWQCwPhdQ8
	dL2xRm4fITAX40jr8HEOBIQTBO1JgkYUPBOEPUrZtACLitCHcLmQHFLN0e0b5avqhaBvCrEk8sAhV
	GlQKAw7oo3SJLv+qPnFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkoWW-0005NN-UX; Mon, 15 Jun 2020 12:47:36 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkoWU-0005Md-Mq
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 12:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592225315; x=1623761315;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n8QcfEHSZM2cFJ/OJ1fbj9q1lFbzl4IEDlsKFhU7NxA=;
 b=QNtJVDYTyeeUmW33BjM2NUi0HY0DwsgI/rGB6+7FKLT5F9jg1TxXOYLJ
 4dC4aun51F0jNIZUQGm7mRRGWT+yUmkglBhXVYVWFvg8h0indbi1BYal3
 qxlyaHce/v51sEGIfpaXWlM2V9NBM1zhR+TfiITM+SEoieOyyor+NqX4S
 DImPJjr/1tg1KCMzez0wIIKqDswgWfEry/GYZI6ViiJ47xtwu3quVYjd+
 CCZ+iANl1dFJ/VtG9f4PkMdxJMcDrEiZ3yvk0idVSQpQGt/jMyrQehNrz
 29Nd5zU/1Oiai1fzCOiZea6VgWI/YR/yKMAkagE3gETvVP4kJDsQ/Lyl1 Q==;
IronPort-SDR: 2nDIlmxvLes2t0tWXMBG8wORQKr1F06mwZFqnN2vfRA63xCYXqggx+naemPff3h+IbOryQC43N
 py1I9OtAN4i7VFcjd9LE52xKOYa7wZ6T6X03Ra8PvsarJmmPql8D22bw2j7ACTiDKzbpdY7ghh
 cENeLl6zXHQz2CpmeuhWp3AgJ/28varRDF14xumUDjq2raLk3ofCMmUk5lMvxte2AuaWll0EOb
 z35d9xbBGJ4g3bKR0uIIp+WTvnUdprJcGkjLemzFQ6UjoqLCwGYAWvjeewdTnjCm6Q3ybKCRAB
 14w=
X-IronPort-AV: E=Sophos;i="5.73,514,1583164800"; d="scan'208";a="242974960"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2020 20:48:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaoHzrJw2OwVzHmBO5d7O0nWe10EOq4d4wE9s2+qu/DFO4lZwo80DEkE+kQ//NVv4Sw0LWn44bO11VNDVLY+QwmE4xetD5pLuLt5sByjvDtZ2QuIfz9m76h053SBD8GQPX/wjfyQTUbQIVIZBVruM09r7MD0MNxze8M53XsPScL1BVyiHdCh2HQKk8K3v+mQMuwF09b90DL868rFvinPnurfKSEbtd/t9qbd+3dFxtwvh6p7i4hcGCv5Tr2HlUo+IlQDnfDw3IXBgX5Wul1aSObLSRHOZXkcbXJFHeIKs4wTu2Kj5V3nlXhs/BYsRfeUqsxIp0p48+lssOsj+a+l9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhL6F2kTLNDv15qUQZrcDbluB0SQpNSHUvZwTjWdCzk=;
 b=etL55sT/P6gqxb8uUus4kTb243kB1epW1d8sdknk9eBjLrWwwr/8cUREJRLtSLQkI1pMd8Dcb3u44YsK0PF0H90jf6Mmmt7+kmy1XJk5v60IGRS2M3B+bxbjRs8DN97t8sAL50y3Oa3djJiOeWPIHk1Bar1t/4dGC7/gJnPtQoRljV+I2Q1BCXMub03rfc3Zpd/cZFvc8Pl22kwhRBy5a+fP6T6tHBjZCueTg7rPfRNCPyg6Sepvu4q+Ufp0WuQnYbAKsESni54XkcF1hfk1VQFt8Gn6frAasAya8MywmEWbjncZpqbwWnFdfCNP2BlE1Wk1zq0sNh/FM64QkcR3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhL6F2kTLNDv15qUQZrcDbluB0SQpNSHUvZwTjWdCzk=;
 b=dTwC2Qkd+6bSt7V6eITXy4zz6aTLmURMwDHZs+86DWtomJem+MJ5M9jxprk+ZAH2FHR0/O21XQQva+2hKrF2U/VYh+DWl7E5TlBVNsFL94QTEBNF0yB+w0q6a5V21zvcQHV+wrJMVj0qHjp46JxOMRzJuAO47Qw01nFSyXe6ONM=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BYAPR04MB5783.namprd04.prod.outlook.com (2603:10b6:a03:112::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 12:47:29 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::2001:8422:8f69:2a89]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::2001:8422:8f69:2a89%2]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 12:47:29 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [nvme-cli] Commit fix apsrintf return check
Thread-Topic: [nvme-cli] Commit fix apsrintf return check
Thread-Index: AdZA+VlzF2is4QufQ8KWbJpmcCqkXAAFPJKAAIEm9HA=
Date: Mon, 15 Jun 2020 12:47:29 +0000
Message-ID: <BYAPR04MB5656351DC71312CE844BDA2DEA9C0@BYAPR04MB5656.namprd04.prod.outlook.com>
References: <BYAPR04MB565662A7A29C4A0EAE3F64DBEA810@BYAPR04MB5656.namprd04.prod.outlook.com>
 <20200612230751.GA8834@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200612230751.GA8834@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e119f74f-33fc-424c-9a9e-08d8112a43dc
x-ms-traffictypediagnostic: BYAPR04MB5783:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5783CBDACB37A92F1977D133EA9C0@BYAPR04MB5783.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjL7Q5VUvbf7UtFCfgRKVDP77xOtjWEfpO3ZsJ0/6UuKCbpAoj67Ol5pnYIUsBua+H2TYpU0nKl8sBE+iaFTE3kqaJNREqaUDpmrI052qPvFQPR7rrmr64HZN2bdkCV2mC+p6zQ+gqoSUS1udZpINiG/8/JOMPSZkHbMPwx6bEi7yxsYcF4plRFcGEfbv2uvNttKVGDRF3PYOTHJ0IXhZ/ctJdPyPyo+QsucwavSdXzuZ8Caawz+frH6sKCcs2ElzvwTPEyKrsyy2nlRBjbvPpAwUnWi3pzRqNLQNmb3WA++qIQudh620ENS3SOTSp+W4xk5i1sfdsiyV4BYLgnAcITfzoFGl6/y3PWTy/XTfX+UgYU41lEgELKOIAUP6lIxBWNsX3xRwhJ9q38gfzGt6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(8936002)(9686003)(8676002)(186003)(53546011)(64756008)(66446008)(66476007)(66556008)(6506007)(966005)(4326008)(2906002)(478600001)(76116006)(26005)(55016002)(66946007)(86362001)(83380400001)(6916009)(71200400001)(4744005)(33656002)(7696005)(54906003)(52536014)(5660300002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: rZbskBKmYCmYAm3xSZTGIAy3ItKzMQBQ6FwgQY/86gyO622YhZZH6J0u8j+6jZBtVQfgx38GoF7otSNpumUjI9AiptrHizRdFsW32sgcA53ZXp0vCaKsG64nBkY59mBjvsvk87cL7ApcCS5kNqbPdrB1GcxCQihp60IQnfawMa+rWC1ClfM/BPR/z2krO6hXWdICS5DQaN1ddR5XwwxHRdtu77Xmti3wk4HPtuRDh1XmO0dcdneBbGpg3tLXxOAVSwMxVJk+/00PQ9LTNA6OzTa67RzlR7ARItwGJPPp9qUc16s/24TCSHb8ruMMTBhW/tvO2iFfhQLgXcoleMoNOZ8pIpQscdG7RFMrhogn3AqGECUTmBWlaEkRvUBZeGmFE93jNzoYbkrDytkYweC7JRX/zrk7eCXRVkYmRekfhnMqCKfi83pJLGf5g73vtKt+rmNnCXXdD/w17Mf8z5IwzaQm6TVt3vS/HPPglC1VCbo=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e119f74f-33fc-424c-9a9e-08d8112a43dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 12:47:29.6225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJKvqGf8Am8+VsgvXXBiWsoQ0RQdtqL28JtR8MH92LiGAIY7padLIl0a7SAKhIwWzbtgatdOkltkcaMXf8pSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5783
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_054734_867341_7B4D322B 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: Brandon Paupore <Brandon.Paupore@wdc.com>,
 Randy Bates <randall.bates@wdc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ok, thanks for clarifying Keith.  I couldn't find that commit in the git log and wanted to make sure it was there.  


Jeff Lien

-----Original Message-----
From: Keith Busch <kbusch@kernel.org> 
Sent: Friday, June 12, 2020 6:08 PM
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>; Randy Bates <randall.bates@wdc.com>; Brandon Paupore <Brandon.Paupore@wdc.com>
Subject: Re: [nvme-cli] Commit fix apsrintf return check

CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.


On Fri, Jun 12, 2020 at 08:40:57PM +0000, Jeffrey Lien wrote:
> Keith,
> I noticed this commit (f719dfdff59518c2ea75e82695ea0e3e6026a4f7) is only in the 1.11-stable branch and not in the master.  Just wondering if that was intentionally or if it was missed.   I was expecting it in the master branch.

It was committed to master first here:
https://github.com/linux-nvme/nvme-cli/commit/f4f3fd2ea4b878fe38fd3409f374ded8d5b34a4c

It just has a different SHA.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
