Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17541C2D0F0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 21:06:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD00920772
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 21:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YiOhm3ls";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BQD9BwFE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R5icKXhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD00920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LyH2gnBBfq6SYU8Mr9LrbNqHiH5a3YNwHM8g68XE5uo=; b=YiOhm3lsyJGZGS
	9hbHqesRkWMpLduf0RyDFTJOSzjjHHEYtW5ccl2kweBiJ9J55u//kSwOGdjKeovmI2UacThVK3tor
	HpYKFKHiFsUk5Rq0FDVkxOwIYhcHCVWQdHQL0iKWjGdOArHCeSRR/Ns+5haRgMlRG/GzNqxet15sn
	0au291kFrBsrnBCwxz6+HR4n3Dx5VmWob/w04IAMqiOfiaj3/Lk3TBWeP/KDLJc4lNUNHGkWoV8dI
	2T3zZCJzzc9f3fy28S3lgQuZdjjPIdwRqe6yUStEDo94//EAjHYNkj+H0DKi7utw3oIbhutVRv54e
	RPwG4zIh3/CJBlQut7Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJkZ3-0003qQ-Ms; Wed, 01 Apr 2020 21:06:21 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJkZ0-0003po-IU
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 21:06:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585775178; x=1617311178;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aLHB4NGIg8QB/7iQbNuuk5elMlFmNq8LDlb46FOEwV0=;
 b=BQD9BwFEwbmg7lXIPK0ZOoRozU5SPM3I6EjP3JAqjxxBmfckGd2iZMNW
 7nz9J1XPXWCpiUGltK8OMuNo48qS5bgGxaukuDOhgvKLcCsPmBLKDMHxj
 kLVloN8KTNNHYFhMwb6++4AoGiCVZsEj3eU0SgdTwsMq/a/x5SKqMcbXr
 vi8eC71UtskOwiWXFgPDqase98jEK68i1wgHxllN1co5aiCSYE2M9Gmu4
 zJxbykPsQngQmasXrpFUvaGaZ902N/emL8E8xLsjiN7kB9POcGpoJfydC
 Nrsyr9nXqSVAm2Q/uKwePZ7DKYM5ushMUbY4E1ZUX5BizkrvElHlLFq+K A==;
IronPort-SDR: lxDJQ0NaFFfQHFzXeTZAMoOxJ6N9wKtdbFulrC6SdaxZRIKiCkuY99L30nGzRTfzhbkVceIILw
 5C3gewR/IKCqfvS5xBi34j1g1cCWmDQ+rb8dXV/ympNAQzbBnDKn7qWp0NSTCIJPlrt2QRlVvz
 B6uEt3YwGbaWGJNGT7sr8ShwDuFO22K0iU+JAgAzSv1nqaiSw354l1UUmbGTdizhEJIAZWtNOK
 0k1mRcUygdm8nzlfWGL4iZL9/ykw7qZv31drP6fYq/08gtTcaEwvAOgmxxlkqpBOCZjpnDHG9u
 DNg=
X-IronPort-AV: E=Sophos;i="5.72,333,1580745600"; d="scan'208";a="134341422"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
 by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2020 05:06:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW+Q51QhMR0u4LEUQkRy2SCCHAsj14p8SClOD+b8MsigFDmVtfQUC0invPkT8mQ/4RdHVW2QZ9YnUQdwBEtVEPhhmPG5o8M0kHoe1x7cV1/CEGkOY/caNlEJJv26LIwTAGyDqfl4MhnZtwxmv7KLDUHMQ17eJLH3SX5z3W6bNC1WMNqp1+OP8mBBYpkEyYFe40uyNOqQrOtXynKpYivZZ4gf2WUb074eutadjjq0+AYn2ILiafwMU21K3lSPlE1Xss7jOl43PtVn1VC3RsLyLxJXqTVQCAFWZ9R5blHcyxQQ/U2TolEZklgbgBqNcEzkDCiyGLvoddTkR/L0zBa76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pGXSsLTrJ0mnYY4A1Ji507mjAkiBH4Xta0/IHe/2mQ=;
 b=OMjgTrTlJ1wHER394Db165eiXx123Yi4mA/SEjlhWQxEZplvf7H1w4d2Ybh5p1ZICVHPSicFb997NLgS/31/jHldhBk7ToZZAvDla0obZZAon1qGZjLkJjaIGbM5oWiBXVLF08RcEegIRr/Dyq22VlvQ6axAaST8jbdQvPzbAoLUqohyo/h7DxsMbHn7OrMk4lxWq40JL3L5UTD0w5eJ382eaqwCWhTa6ynBuA7bJ22906oNOazYLsvu4fcVS1Y1c9VBOMx5F/5U9yEwoyUU1vhyp6Kgrcfszdmc04BioAIxJqBFcfZ2FV3LDbSph5mv+8U3N0OHkyY6F9kv9FLZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pGXSsLTrJ0mnYY4A1Ji507mjAkiBH4Xta0/IHe/2mQ=;
 b=R5icKXhEYWbWvDinNHjDIKcLgQC5dp3oOzxPC6lXG4nQNxFI7+T0rzz+A7uGuo8SCq+MiD9THISwiziwWWONCatqTgqhWfUzHhR6Bn3fCPTEoMFPsktB7jWWBTcdKkKysJTfaskGGlh9DMp4FlH2yKO60wZwVKrXWRNHr/5JitM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4759.namprd04.prod.outlook.com (2603:10b6:a03:15::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 1 Apr
 2020 21:06:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 21:06:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "tasleson@redhat.com" <tasleson@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvmet: Kernel oops during nvmetcli 'make test'
Thread-Topic: nvmet: Kernel oops during nvmetcli 'make test'
Thread-Index: AQHWCFZ6FEtYtIMGXkGri3sX8n1wdQ==
Date: Wed, 1 Apr 2020 21:06:10 +0000
Message-ID: <BYAPR04MB496520CAF145C79746B85B9E86C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <bce98bfa-5740-d184-ac47-6ff1c1c97b30@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 886ae860-7377-4aab-35d0-08d7d68080f9
x-ms-traffictypediagnostic: BYAPR04MB4759:
x-microsoft-antispam-prvs: <BYAPR04MB4759F1B38156EAD55B08026986C90@BYAPR04MB4759.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(86362001)(6506007)(5660300002)(26005)(478600001)(66446008)(52536014)(8676002)(7696005)(2906002)(33656002)(8936002)(110136005)(81166006)(316002)(66946007)(186003)(66476007)(66556008)(9686003)(76116006)(71200400001)(55016002)(64756008)(4744005)(81156014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjzJMAoCtXBGyWl3Dr4nc+PNVwc+QmcVZzGK3s3Yw/khIjlFLWhfdeHcLIhRZa49khFvXWjPznSJ7lgeFFHy6NOre8ty1En1oqRJ0CFfY/FG//xwGWsSYi0MfAAyOtai7jbc3l9iIpnI31v1sNV8VaLgUG9LWWXnHv+5jwKr5ieK3PAuCmKXAWRKDRosALn1r8G8ARZUmw6Q/oDm6nRy+XSqhyael613gjGhFMbYnbj8CNf4VBMda+kCckDy/hh1dXAIpDUdpzBxVyFjzbBjNhrif0Mo/fWUeYqZCIesdVPNl1O/Jp3sgeke7zZ3UJaMqBLou7X9L9JpbYAVOC5dBKo6p7hp8RJHKbt/6vflRdiMgGuF8GndKXhOVlKhmF/FETJsXKjvHM1tFdgdE6KvXJZoDFscSDzVLa2K8PVgj/9aarDngtOFRP/CVUOQCxqr
x-ms-exchange-antispam-messagedata: GGRddsXR3ST3veoDp9jbym3mugXMpLIZdku+IqV+EdEJNZYGBYPBLeOb91VquPZEluS8Q49dEUjRV72GozoVPhPR0uMDS6E5Rw6t9DIZDe5tpF/VJ3BncXP5Nd4QLUZVOnxUJvxXvaZTEQ5674hyHg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886ae860-7377-4aab-35d0-08d7d68080f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 21:06:10.2159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DpYYlBcnko3Thm6UbgrSKylhH0DHGpR08Fd7OfHCHm5s07QPgYtlBzruWi4eVcgwylLY7RkhQ9K8apn2n6UkxE+RCE/ad3R+ozmBBEnL9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4759
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_140618_760685_D2048D32 
X-CRM114-Status: UNSURE (   8.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>
> (gdb) l *(nvmet_referral_release+0x14)
> 0x32e4 is in nvmet_referral_release (drivers/nvme/target/configfs.c:978).
>
> 973 static void nvmet_referral_release(struct config_item *item)
> 974 {
> 975         struct nvmet_port *parent =
> to_nvmet_port(item->ci_parent->ci_parent);
> 976         struct nvmet_port *port = to_nvmet_port(item);
> 977
> 978         nvmet_referral_disable(parent, port);
> 979         kfree(port);
> 980 }
>
>
> Thanks!
> -Tony
>

Seems like referral release has a problem or the testcase related to it 
which should be test_referral() 353 or 356, do you see any other
errors related to the configuration in the dmesg ?

On the other note logging for these testcases could be much better.
(totally unrelated to this)
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
