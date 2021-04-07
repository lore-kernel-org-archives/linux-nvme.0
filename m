Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01779C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 07:42:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5B561019
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 07:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5B561019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PCEpguH2Gu5gyaNjZ+O5jnCdZTmUFMIKy+XdEoE4QAY=; b=ebDiXGa9maywcWaaecu2NHO16
	JYFC4z9VXXUHSwIAdsC1xy/MAhG+wz4BZjG7F+wO4HZDSDUR3a7ewcqY62UkrsGjqQR1VOIXNIL/I
	jEbBQHRthdAtXFWkEeAmWxhUd49xsPvOtutMuKhSZpE9a2TpzzA5gY8aswv9Bs/5g7E0vDZT3e2G7
	OX110p0/CkXvGWCgNUap1t3lozS1FXRp/TnDmjeW5mINMxPx3wlgbDRFJQkJv2U7Tl9WNzmDrQYTg
	8yAUgOvJ6Z+KOsm106XiFwCcWPujPo5MUKTQV4B1JPIodyfjXuleVuZYWAsPmsm85JfiQ/vu+VgGb
	xf3octZbg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU2p8-004Pz5-5u; Wed, 07 Apr 2021 07:42:02 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU2jm-004NwW-KF
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 07:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617780990; x=1649316990;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JTyrapqZBdd5QQDzLDJluVyjNHdyjz1NbUNUzzWvDdI=;
 b=NwtHmG/Vmey2OB9kMPDiBJp+uoMUYpzBM7L28iRmzJGiQYB0xNZ6QpJq
 IbKXlvwX7Y9qSGVkvkHcyVp5CK8Md8lnp1xsDTTB6hJXKmARFwgkTN/qa
 RX7/zSbng3CmQY/4654s6deFGxtOrcSErDCCUlhJtI5QMT/dJ6KPzYqq1
 ZcVhqFDCAqLa8zH2fcTfjVgWSXvYdzL5jO5ZqwpRzM+aKIiQRZSEgaR5A
 dksN82RPw1u9X3G54METidPTkJl2vZJyP5TJCLoAecJbOtVvZWylbURmq
 lBtq5LK/d+sCCXBjmFVcGAcP3PZNPoO0q5qi04XkddQbfUVsDaMVS9sEC A==;
IronPort-SDR: jO5b8WPSVfHr08pM53FnusVM0E9/uDtHxxf3BAvMlRy7ovlImJoKb7TjKJGnj+VLYG2g2beRvO
 p9+3B4nAhe5XQ+h0UdMGGTKq6vwtTD5hgPMA8gE4M9wrNOactLjwAsCWwd5orJfwc4mvlsmNvQ
 Ov/h7Km46tEDHvS+e5MM6Ny/qNIXpkKEja9zILWHaUU6VsbfQCW0DB6PyRfcy9c2Ht8XnfdHxG
 nO1SaWpCxUN7jL48LPYuAo1xPfrq6aFS769dcHJdJmNcJXfvGRfJplS80Yh07mymQ6Jt9DNbrw
 lZ4=
X-IronPort-AV: E=Sophos;i="5.82,201,1613404800"; d="scan'208";a="168534069"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 15:36:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=honAZf455zS14Cm7njL45W1z1Kel/2EAMBY7rSyWbwOAw2CsDqtRNuJ7jDmuA7U4esMetkWtRUtbz0fQy5Qgle7BOGMwB0tq3AMZVWnvs017toKYN41Wfm5NisRm5lH8+O+FEEMRrI8SHcH8uKs4wLMEcqT4RUofDVvtI25Bo1U8ES3Tm3vWaoyBuOpXYEYV57LuxwWPzsBhlkHEOGyDJzOlSPna+MeoQyPB0c4jCXV/qwHAW68mxv7Z92toCFsh5MIT2QusG9GvbdBfeKIpy/gPHX2/Vs3X7nnNym+8L/wOEG423DMVfRUGAlWVfbDYlaOv8Lqorgi+0j30Mt935g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUzk4iNN6Q+Gm955FDy4hzdm6bWxp87DuCyBqQXevdc=;
 b=HyZb1SuyKlumE+gfwuHKXlws1X/nONGCibSbUw2MwUDtvekRXtjkhWXJCCzxp+n23lrdy0mcj44dYY655FiNWX30vTOCdgO2DJ1UgXJCzjhuSNoWRRoz8k8rQ24nL5L4pDXvfKuZDiqJ7ukhEe9gEUe08X+1nocutNx7MxLHjzDhKQzpRGLZ2vfVbva/6qtRZ8kUiq7mURtCv04Lhu0dwe5SPzsB5ErWm1+AIKHhvpXKkmuSIwfPxK+FnosFRsN8HhuYtAN6cfhtX/dnjf8n0y5O+T2inBuyr7RGY8UZn1z8lpWDc+mk5V/6ayb/0S9yULn/uoOtDTog2YJdjLkYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUzk4iNN6Q+Gm955FDy4hzdm6bWxp87DuCyBqQXevdc=;
 b=gJU+6F2qdXMJtAJQVbrlFx8zIQeY40EHs6dxEXumvpvaeAnzfNQVSWHVX5m5nztdtN1ZVujuf3Mn1YrsHc7PkUMLlIy0g7dEJ2QWwI2X/Q+7vxTWZuPt4xiXJqqBz6vLAIdWS0+QPU/mAnOXE5Fmsg5z2EmvVKXKiWIXr0obC1A=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB4124.namprd04.prod.outlook.com (2603:10b6:5:95::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Wed, 7 Apr 2021 07:36:22 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.016; Wed, 7 Apr 2021
 07:36:22 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi
 <joshiiitr@gmail.com>, =?iso-8859-1?Q?Javier_Gonz=E1lez?=
 <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Thread-Topic: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Thread-Index: AQHXKsN1pjvW+Y7eAUiYEfo71YOF9aqnfeiAgAAXigCAARZvgA==
Date: Wed, 7 Apr 2021 07:36:22 +0000
Message-ID: <YG1g9bMYRjS3uCXs@x1-carbon.lan>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan> <20210406133533.GC2594@localhost>
 <20210406145948.GB7790@lst.de>
In-Reply-To: <20210406145948.GB7790@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd56aea2-5033-463d-1b0b-08d8f997d790
x-ms-traffictypediagnostic: DM6PR04MB4124:
x-microsoft-antispam-prvs: <DM6PR04MB41243EBD5ECE37C19A2F573CF2759@DM6PR04MB4124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUEUKoD8roULlISQ+hEm5Eu9AqW++65T9KhlGO1G1fHKuDY60Ot3O02wQ6Q2S3cDij7cYFUpKdyX20Q13Y/4N1tb0GZzXVL/D8VUMkPeJ3Mijc7SJKdwaDtngRQD1AWlhgmA8lLdkmm9PLdch6rWZMPXQ8jbkEvzHdt0xyO5J+DUW22o+DHPre0lmdU9b8Y8Kcg+auQONn2Z6ikbPFnO8+wWQa4iRBXBEGFJlbWKRx/ZlDfbOPb2T8hMpcmZ/tAe8705IxBYa85yXAaZc+AwLqfgZO9YAv4H6gNzXT5LkPrg88wIPjDw8AP3ZA/nL0oKCoazySC5usNv1UxynYXLEcSz855LftUogzl89ga56QAq6i8HZa1wghHRrboSanz1b6H89vWt3y0W2andFaUYPomqAP/k7yH7rlUbUVpDBRhT4s/rcAbZcYAU52AYliZEyrmL1MYTgDBXeOEluG+8+HHZgUC5b+7CnFDmwkPRb0tzZxAGLYD07Hdbf3HGYThPecXYGaO1yc7FC3MObleVEKY2bl5A/bTbrAVHM+PnsHNXgSWxgz+lN11cetLtaTp6/HcvpdUG06V1BFvyX/n35kEjTuUaMZjCjNuMuOpw9Eh8iQAUkg4PkW1Gb4mkZuYgscgmhasmY7eG/reH0xhbKelWkjX4evIMGaL+fTH/EBPm+fYKmT948N46x1m1VPMD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(8936002)(4326008)(6512007)(86362001)(38100700001)(6486002)(8676002)(64756008)(66446008)(9686003)(6916009)(2906002)(83380400001)(66556008)(76116006)(91956017)(5660300002)(316002)(54906003)(478600001)(36756003)(71200400001)(6506007)(186003)(26005)(66946007)(66476007)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?RSnRsFqADnjFXCjnyR/MIV7cx5xdL1Ni2ifKfQJwMtSjgXnTNTwP3ZwtvX?=
 =?iso-8859-1?Q?6cGgpdzaEj7w7lSJMxUPb4EBobp2N9Op1LFoqZVLcjc+TKgyeOufIqURT4?=
 =?iso-8859-1?Q?B/AclKdduufuVHWOGnRn6miBOEJHWdDPz9s+dWPc7/mnUs480WVNPm7gni?=
 =?iso-8859-1?Q?NKukG58TaaCpGnn5EiFUDrcU0tT++t1bYiT2LqiOmmAbqBEbKDdJ6MPE70?=
 =?iso-8859-1?Q?Qz+Pd6DoScjKYrnrNXDZBE3ohVtoDKs3PeE9vu3pWbqj4ZYkAvgenpczPV?=
 =?iso-8859-1?Q?F4jSlsrXnkNj32c2ips7ZQjjMpzshD/DOeoGa+hfBB4Ro/iOs2JOmBEJtm?=
 =?iso-8859-1?Q?xiaZrjULbXoBpN0xXXoi+MD6FlULvqC8MF1M1Hgv1Tw7HK6lacMi/DF15L?=
 =?iso-8859-1?Q?Bx9Q+dip6BByZKuN7tuzruP9sZ3V/I5El+uuabhXwF3lMhLpzJDNRQCcHN?=
 =?iso-8859-1?Q?Bs8YeIX7+Bp+bCft+vujON9hAJwpW81K+RuJDCMPcQdkOH5Dgv5Mtq4dn1?=
 =?iso-8859-1?Q?y8vL4OJLScJJiC1GEVVA4w0/LqiBDCKjrQJ+afjIrCiYivBkDEpL2XoIhx?=
 =?iso-8859-1?Q?kihb5vmzwVBltjQ1U557quJ3vM/Qv3sF+zo3/Qk86/M1wpSdTWWouO2Lcd?=
 =?iso-8859-1?Q?tF7xmOc2TXhTvIWeiu1yOeqETUhLyB36lY/coR5W4IViexTHmkNo37KOTe?=
 =?iso-8859-1?Q?q497jDaxL7527n3H/42uv+Jti+Y4fBdzdmdyYEd6u8b9pduHkiW+5l0SUU?=
 =?iso-8859-1?Q?av/PxtIby+ELONts9uvqiQpRRH9+OWjPTlbk8Yk7Y/4CerchSxfpcgRx0G?=
 =?iso-8859-1?Q?17SYTHke1VIhdYMhBKjf1mJuD8TxWHwakMy9UfO+shKOvGHjrRMRMRa/zj?=
 =?iso-8859-1?Q?9kHzWjYfrXEfpu4zcmlHN0fZvZVCfeJmQ7Mx2EmvPKF7EZlKWo3xYChPbW?=
 =?iso-8859-1?Q?xwKDex5Z0iJ6aV3kG+pZhlx5P9veH66sTTLXxzyKgjvaZqoch8q66gAKAs?=
 =?iso-8859-1?Q?/RoY1Aicw39dynxEQYHSVbiYcKfd02Zgot4IXnQJ2ZKpqpfZZ0mJTFr1Q1?=
 =?iso-8859-1?Q?BCx92xUsd5CLVXH/w8YDFaJn1IGnnfBLGqwV89KARmau3NWY+LdZvrmASF?=
 =?iso-8859-1?Q?tFE2K2TL5RGQPEx4TDPzGMFPfVBmX/Py2qqlCc9a5T/iEkiXETtri84ibp?=
 =?iso-8859-1?Q?CHqFu138YQU89TuE65zukgaQ9aQarRnv4A1WVlQuLC4Kk7sZlSEnxkGkRo?=
 =?iso-8859-1?Q?8jVeYsw7fIRqj8P5fwJpgpRGGSoXwMNzGnPeKjKyFHq3H2/UDdwXipjfbV?=
 =?iso-8859-1?Q?RK+POA2808B/Y93UlGI7YxYIF1kZ1msi3GCK98Z390NRuRuFutW+QQwIXE?=
 =?iso-8859-1?Q?zJ6zlzdlX/?=
x-ms-exchange-transport-forked: True
Content-ID: <267F5721C5138B428D612AA1DF71E774@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd56aea2-5033-463d-1b0b-08d8f997d790
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 07:36:22.2239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJqSADUtgkyF4l25RvkiAneiFkWSI7VjyVEdhFmrYpSEWICah//EQUHv5XPnlsf4KnIO4dMQrpDBPV9ulmm8Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_083632_269460_00C9AC1C 
X-CRM114-Status: GOOD (  19.61  )
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

On Tue, Apr 06, 2021 at 04:59:48PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 06, 2021 at 10:35:33PM +0900, Minwoo Im wrote:
> > > with e.g. fdisk, mkfs, mount, in fstab, what to specify in fstab, etc.
> > > 
> > > I think that there is value in reducing the confusion for regular users.
> > 
> > Agreed on this point.  We might have thousands of namespaces and it
> > might be making confusions to users.
> 
> How does this create a confusion that it doesn't for the existing NVMe
> block devices and the SCSI disk and generic devices?

The SCSI generic devices are named /dev/sgX while the SCSI block devices
are named /dev/sd*, so the names are more distinct compared to /dev/nvme*
and /dev/nvme-generic-*.

A "regular" Linux user who writes /dev/sd<tab> will not see the SCSI
generic devices, but with the current proposal, if he writes
/dev/nvme<tab>, he will see the NVMe generic devices.

I just had a gut feeling that this could cause confusion in the future.
However, I trust your experience and judgement more than my gut feeling.


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
