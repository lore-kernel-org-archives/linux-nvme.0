Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C3BC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 00:20:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB732078A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 00:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D1hD6Qvm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kVA/0SQZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dYxiKUxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB732078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=LBm7jr/6lLx4TeqEpBVS8q/SDyYYanmgCRBJZcCVUtU=; b=D1hD6QvmEIgUrzuv71Yppiqdn
	qKfpC5IRyr8hkxYeoudCAe1MutOJl6Lns38ywQY6ulGss8bvRUniwLVVD8ocETjIqMs1gshlxgcOP
	5+nUzlam+qcCMBCnllmbNriGW5o4lQCsP6EjzU1DBmQNBrxN5kzMIvhf9Wvr8OsWmIg5IPkCLxTTM
	luSsSh3GEh6bQdi1JBjbvhS2IZyC+ZV2j4p35X3kP+66/Ilv34F7UItQ7DEXEDJqKciTkt56pSrFr
	Kl1q8R7lGEo2mD6c0qPxJv6H9/07mHV/vCMWY6J9+UkC1ywFES4CK4gJo0nLxN+VNHDDwGv906FSF
	zjqa+zxhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSUWZ-0003Cb-Lp; Wed, 14 Oct 2020 00:20:11 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSUWX-0003C0-My
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 00:20:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602634810; x=1634170810;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0/TlRSoHxD0jOB+fYQJXpprbQfix0bHH0qvUSQO+MIw=;
 b=kVA/0SQZAtTsFzxZ9CIHUY5DzrptIoPt/7x1ojfF9e0bFEUkilGPRM6O
 BXmGD2DG9uUdA2p+5eHksrH9C7p8MPiE//5DtKe+cwjZfauGiavLjV9p/
 JiJ8YjlupXAifYEkmIsq+SOcMkGr/LO+BnBN3wpwDLFDaErJL52w/gbW+
 Hpb9m1BJH8sOpShwSwm7TsAS6qpwswiGMjv8yH5DkWLKsCsQeKA296Gan
 24T/ifFoCQyzYPLSa0aXK96l13g6CEeJ/KitMuJQbp/DMhwrpxCKuX7G9
 J4P9VeWUlsOijd5XxtsGnEzCBQgST8O/t/5FUhYtxEtj2SaYIYne3gEJw w==;
IronPort-SDR: mV5o+lH2b6VkQqULtJX2aVmj5EBIupPBkF5oFxd5l6szLbJGBJzAiIdCGWHEwaGo04+KhKpFm9
 8IfIiT/OOWQj6rL71SlPVA7QSJ1MEhURdDpSv01iXi5rb7VRSlDNNUz/FxqFDTPY8SYQ7z9z2N
 NgCWL8m1ZQKMYvRvkkaPyTd+7JfFbotOJFuE4RZUPzdw+0BUKtEotye0GQ/5OvAy2QEmVln443
 4Kck21xE90BztmLCqFvM4cWbFtuWX5oV94XzgWbMrOQlBOUpx7Xnbbi/QDSmLmFXxazStSMplQ
 BLk=
X-IronPort-AV: E=Sophos;i="5.77,372,1596470400"; d="scan'208";a="149838186"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 08:20:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWyYC9capuROyWJvF0mk8J5bl8INmCtUkquUhcUCltNzo+Oqu4a/XnfRl8kndVjPAH5o/Fzl1uAyxIPDyoVIZf1xbC9bxzINHpt80PEmfwFLD6a6E2anuc2DDkXng866C+cyTZYSPoUIVNFw6s5mN2dBTOn5xZTG/lHZKa+RWCa/8vtJrmATzcE8+CtQk6FECiEd5Ow6BKNvEbcylFV9db80yiWxQoOk7f16uc2H8WVPPrjFY8kYoB+4qubQuBiJg1khbNTrMKvC/c5EBZxJCEimSFprfJTqC2S/EIVKYfU5T/UZYycb1uQ1we9uvcbm9U11QKA+o+Y/RLhLvUWGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/TlRSoHxD0jOB+fYQJXpprbQfix0bHH0qvUSQO+MIw=;
 b=boUmY712tY+RvQQsuX+7klTPgMVS3Yxoh5ucPGV4oP4Jh6GUrBEm41uqrpS1L0qLOV+QYyidpnePD5BksDHNKY3GuoGkfv6uy1B0oLjE5eRjo5p0Cb2Y8LJbVNpohNIjklJmtV0mvE4Tzal5oNl5LZ4pp5r+2rGuJP0tBo32Uf0qzaP8Obt9nus5WssgWXC+07lLHKB2i7nK3V0OunB3eRkTVhfLRg63zZI5MaVxg0ZytoqqybGt0aJZE3SGyLgHCE2T/swHfr/Ao0mmVMkL+EuN4VhgMOVB28JpRjuHNH7KCHK2DpV9SnBBwQ4/n03dtw6Y6K0Fr9RNdfVMmwkFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/TlRSoHxD0jOB+fYQJXpprbQfix0bHH0qvUSQO+MIw=;
 b=dYxiKUxAbPxZBvcnJOikewiqnusclB6UHtEpDYD90x+YESyKsP0Abn/JSJtK7HSNlQgr1r3Z1+o/3K72mJDXTVkXarqEhFPO9+O6BVPWNCOQJ/JmB841BPc1H2BixM7tWff1nk8q2iC0E8rpi83y7O2LX8JEy5d/6ORviVDgiao=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6024.namprd04.prod.outlook.com (2603:10b6:a03:e8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 00:20:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 00:20:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: Disable Write Zeroes on Sandisk Skyhawk
Thread-Topic: [PATCH] nvme-pci: Disable Write Zeroes on Sandisk Skyhawk
Thread-Index: AQHWoT1BT5ZuzRm0u0uwFORdyBuENg==
Date: Wed, 14 Oct 2020 00:20:02 +0000
Message-ID: <BYAPR04MB496518A4C9FC65964C58453386050@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200723155731.22313-1-kai.heng.feng@canonical.com>
 <20201013083445.12317-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22f9bd12-9b72-418d-c9fa-08d86fd6e50a
x-ms-traffictypediagnostic: BYAPR04MB6024:
x-microsoft-antispam-prvs: <BYAPR04MB6024AA00D18306C3777D1EE486050@BYAPR04MB6024.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:96;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbodv/hsRSI5ymY1IwN6xExvErv5p8sV/zaYh7fIaoSOuiXci7A5C6UcuKHEtNtSNMmsSl6HYpM6kIdLJ+HgZOhtlho2iudSkesqcIVAg8leAcDzlPEsmCU1vqnZA/gLZRx4Feg/LbJXaa9pSIGwD1b9bCOM6E0WFcMut9nHasEH5l12k/d2U0oAqjiYfU4gXQvPimAslE9R2MLKVV4pFgHiQWwbjkyhy25qRqq2mKPA3Wc1SfC97C+lXFVP6HMlCLJdNPbXvd+LoPzOaZ6XwdBhUX8PuC+zQCaADHMa1kx1JgdzdJRlm7o08dD4WVbRgTtyoSiOGM1XOrdzmsHWpsX6yH12Ajw7acEFiM2uqbloZn/bUcGKL7i1CiokL9wyXqpLHOOZp9Ww/3w84DyREQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(8676002)(8936002)(966005)(478600001)(83080400001)(83380400001)(53546011)(6506007)(7696005)(33656002)(55016002)(186003)(64756008)(26005)(52536014)(66476007)(5660300002)(76116006)(9686003)(66946007)(66446008)(66556008)(71200400001)(86362001)(4744005)(4326008)(2906002)(316002)(54906003)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: d6r5OXmd7g465sa7I/wG3SFiNerQcdj0UScNnmBNrT7tWmqIdIKGmVkmDl/ICprtGS0lJwlA613gUmcRaM9jzNddBKi8sk7xY5q2xaxPc60qjienNT4e4OAtAvgwf/lWIGYn1P7dfhSW8M6HgRuEcF8WZhYGDDNd4Jj6UJs8ZYqwEqsDRG7+XK+EkdUnW/qb8K27RfvP6LYtCnbdPYRBm2eQX8DM7EHnKwVQw+YSYcj7+V7mjz2hD/Bh1zOXye8mrbMsDBVHEC0WMHVrGKA8RosyrwTkLgBSVaINy+2ShrfrmtFTAenxu03fsy60Z5ZYy7dp0E5a64DrnEel0zV0AazxobrDKKemlV+vu6cGKg3+yI+N+1kW4y/HSx44LHCmJ1ZbomPB5rGmJHBgEr996wkZRb9Ig7fCcorOt7+aNOivL8JcJFYSO8mRUTaTJl+/nGgRm/xKjs2Rr4vagZLbc3B7VDxLcGOuWkUeVHoyErjIC97hoEG/1B2m4VFZuYnOJvHPtW6YJKmej2/zl6BsxmR3EKAOAF51IX0ezIkCKF6JL12SMxtw2pgwh5CKZIsjLYMG+1CSyyBZ+1lukgk53bCH9qN7jBIokpJcd8z6/rA1xteDhE7f6iByGw/EVPffCsEPk0zOcBTOK2k2exOJNQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f9bd12-9b72-418d-c9fa-08d86fd6e50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 00:20:02.7500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8a61CjurbI8f0wCPziW9G63FSU2ogNJKlGz2XsEJbga6/ZXlGlYyMD5SfD84sN8EH1q66Lfl01d36Og3dbX3eWsqB345vbQ6PTMHXnqLNc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_202009_928943_D2FDA3DE 
X-CRM114-Status: GOOD (  11.02  )
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
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/13/20 01:45, Kai-Heng Feng wrote:
> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> Write Zeroes command"), Sandisk Skyhawk has the same issue:
> [ 6305.633887] blk_update_request: operation not supported error, dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>
> So also disable Write Zeroes command on Sandisk Skyhawk.
>
> BugLink: https://bugs.launchpad.net/bugs/1899503
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Are you sure this happens all the devices of the same model

and not a firmware bug on specific device ?

If yes then looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
