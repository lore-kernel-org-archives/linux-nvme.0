Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,FUZZY_PRICES,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC9DC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 06:58:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196496100A
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 06:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196496100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WntbzNRoXcFMHgq7v4ZdPdWuN7Rx/ibFD97MhcR7kI4=; b=dR3xVlDeRT846lKKghG4wPx6y
	MIKBZ6ib2j/EPnmi8yUEvT56NkqaYSYpMyRlsITuNeVh1ev35rRy8cTsCg2MHldfcDjABqtQ1Dmwv
	Bz8AuBoCaz36WfuG7jmdPulgDLAHbn/VvsiPolFsqUUWvdj3SyXJY3r7W8Ygy3NWvHEtOpoSY1Lir
	c7uE8gpCp5f+YQt/JvmX2vFD/9TWgrG+z4SLAEHaoMTwTD9eVszYUQjSN+20XaaIHZlbY33xH2Zin
	1XkD8LMRNWF9o0gambXLHHrs9R6o2nSJo50/9wuAycIdjWAywLcbf0kXKD7oC9RU27RZSVo79t45w
	0lDfrseTQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljcdG-0065IR-7j; Thu, 20 May 2021 06:58:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljccv-0065G1-MF
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 06:57:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=WBZ7fC0VkonSv2xqxrQY3G46zVdjEtBFIccIWSeii/k=; b=WnxLCzAATG3a3wwRRqQZ/mU6zj
 d5G3WYVi7oK/Isk6vkTs6BtccP0cDW+o5ubyfm3UCt52poBSi1QY1h1fGihQecb/GZMwpUeod6Qjr
 CMWvTFklbkUxzQHsgTUrxWPelQxmwmW72DiMQOQD+zRw0P10/ZrCB1Twwntmb6k8yHGr34JT+f4QJ
 eNZ4E0fCJ37GIWYl15X76KkBb7FNFzeKWKS4slvfw0qNtCusDP1JwJeNQ1zGP3uXCG9X30AzZtML+
 QZm1BG8VmwxQdXVx7xQWW4LIBMmDwq3DKt9PbpQthCEDl5GTxbOgo4yzXof1s+Z3ZKPY/YQVP1bW4
 QQADFvtQ==;
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com
 ([40.107.244.73] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljccs-00G0id-02
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 06:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcMzCnWviq3klZwzVfrxO4Kfa7QyEaPXru9xLU8SF/KLh2KLFHA5SvS1Kzsa+eMmVVnzCZ1VEBgLw1GMTou5ClnEAOPopNj7SyCUmUshgNqlzT1D71niQYO00T2n3f2WbTQbTH/YpQX3mg47Y3gU6So97L5qsy/NEqmN/v8DmLKUKyAtFEyJkWv+bQlnQZHp9ksVY+DGfNGp4QDzVwYQ1Ewr5Qx0A2mOOs8t3UCRHX+lQgaQ2BkArv1apbyDlewC6QVib52pMrOvXmH/lOj6oSRzQfhf4sbykumKQqPuHTI30oGv2JVhXEcibQSVNovlDxrT5w3KmtT7xkgZg2h7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBZ7fC0VkonSv2xqxrQY3G46zVdjEtBFIccIWSeii/k=;
 b=mZikNoML5PwQjLssYTWy5fVclQSVmjUeCvhIh4KXdpJjKFfib8OHWYlYQyNG7O/1QtboULGVGL5ziyw0/WzvKNwGo88DVysx+j24uwAwaIM5rAR4w99F09O0G+8LDBtMzta42xF4qJPzFjiIsb+pC4QHQtmH9/K9bI2vWQ8bFnx+7khHl1uyfuXr1n/pBOAm6goxjXoKrawHC8VWbQYPneneT5+A/pG+ie2GalEMj06e+PwcFtxQQz6fntKxwsoFfPuaLqY/go6as1JYA3zvaxQXANQkW9vORvMq2d9il+DWw3Zng0tdQVOIng+RpuN7JMdzQvA3MUyo/Q8frjqzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBZ7fC0VkonSv2xqxrQY3G46zVdjEtBFIccIWSeii/k=;
 b=LoHaF2A1wDo7tphEMI/xvVgqCiv82TqXqmcANVLnxZjx81ju7YJW2WxlbdVDzbsFrzZYWneWfchQh7TTq7hvCXAbzQ5e8mIu/WNvOlCY94XOOFH8XhqAhReLFDv141Ip+vicvn9HEqebRT2v2qmfK6aKue3m9A2lGr50zDT1Hyk=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2838.namprd12.prod.outlook.com (2603:10b6:a03:6f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 06:57:42 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7%7]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 06:57:41 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Topic: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Index: AQHXS40NwJGcnl+fXEefhkrBDeVCF6rrVkGAgABQJnA=
Date: Thu, 20 May 2021 06:57:41 +0000
Message-ID: <BYAPR12MB3238055D4B08CC91D9ABFD39FB2A9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1621304675-17874-2-git-send-email-Prike.Liang@amd.com>
 <20210519213359.GA256663@bjorn-Precision-5520>
In-Reply-To: <20210519213359.GA256663@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e64b5bf4-3dbc-4dda-90e3-6fd45c730f33;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-20T02:21:01Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.226.130.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2926611d-9fe1-4047-b23c-08d91b5c902c
x-ms-traffictypediagnostic: BYAPR12MB2838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB283807F3FC904A219205F19DFB2A9@BYAPR12MB2838.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7EQeIZrZqGzZIx/P7qoL1poku5FxaNetjiJ4yBaG+eLDBbKmrsi4K67ajQFHDKTZ78TRQ+vVlQHQjYaUqcZpJZ75dRWa862PCRE64ticLLCNgTudnv9kwOtHptuH8YCXdaoFjabuS1Y7n03Ij7n/ces+vPQ2b0MfvsHAhFoWnBZBNd24DGmoWYCJdYNGEt8mXdcT0c/ESY3kH7/vWyGICew5bg8VX4b/oQ3Gn+CdduLnThCKQMCgPiKRXlRH7f1XY48epWMvh10FP6GNsgOA4eqaTwz3jOOFhY/oIxtHG8s8jDP9oC2nNB6iUQ6njBDgcxzXdoo/r6QlKRXIhLcALOzcdcwWfg5g/4yJ45qGRWdoZ492GRdIeFxBVZPXhNjaj3DXFAFuulM1kXYARqCdk1ALdLRZAY82mFFOE0LlMo4rkUH+Yw8C+OMe1Q+jjDPCqQltz/FzpuSjx8JEDZOzz9HlHpuDowDtOLpf+bFCQ5lpCDBiOJKlbdXA754qnkK5ULTaaADxR2c7FmtX49+X/qk/nkcP9o5souvTqJpCWN3OiwenpDRqJsFh+u/SQciY+h3BrvRX8ux4HuVUkWMdRVZRpbMCPc0jA+pAmEqNk0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(478600001)(4326008)(122000001)(38100700002)(66446008)(33656002)(6506007)(53546011)(66476007)(64756008)(5660300002)(66556008)(76116006)(52536014)(66946007)(26005)(8936002)(8676002)(7416002)(6916009)(86362001)(186003)(54906003)(2906002)(316002)(55016002)(7696005)(71200400001)(83380400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Sgiq/k4AeVVAXkdKr3FWy/iHxXW4vDnGl4YXFCqa6QU+nJ5Q8ynVPPdJqjRS?=
 =?us-ascii?Q?vt0RnrXPWWPkxjhHPlPieYHq/ydBztxt7k9kHWugsJzFM452lQOOpnc+q21a?=
 =?us-ascii?Q?emYalAziV84DJZ95APB6YuW2ciwyYfNy8BgKp8pHxXS2SKvO2EpUe6eO7dPu?=
 =?us-ascii?Q?58ibUR/VAQoHw30qwtdMU7BiEBpnjXfuGM7n4bPukxke6J1HGhDCxL5XPuek?=
 =?us-ascii?Q?HqJPjA14J+Ny24KueYg6EjxQxsOQGOoqEmLttMT+j8vx6rgIFKqj4WOhDt0H?=
 =?us-ascii?Q?W70fVCSp4Ow1ROdPApV9XkPAr++sShfk+LPiCwGRcYXya/TeFoSlf+B3a0FM?=
 =?us-ascii?Q?chn0riKnyrn/BcUfqiFjeveTTjWI3shRCA9g+rHhPV5J6YfVIHBz1l1/H0Kw?=
 =?us-ascii?Q?AUfS+NPd9JOBz1vF89EwJbtctFPC+p66iOasBL7xGz4ga/rhiMvIjpglXzpd?=
 =?us-ascii?Q?OC0taSz/Yrm3PIiEsZOHv6HY7e6ameeMzVZk8vXSfcU6HRRRtG4jvf0tU74u?=
 =?us-ascii?Q?BCgJmNtT845WAOHUuLQBHsnR/bwRJkY2HlFaSQ8cMBrNQXhyPZrnHb2um3ew?=
 =?us-ascii?Q?tmtvyInT0qSom/OFSTLNjfK2qJu1gl0ARVpeXDNf0bishgFfyDsqNPvna1JV?=
 =?us-ascii?Q?Kwemi4rWbkg3apAkJTJ4Qk2lO/pDEanFOtrMIagNIZxW07odpiG75Z2a5SCw?=
 =?us-ascii?Q?Jq7mDBnm57d4AYyzUe7zFGC9kSvaeYU+phVLC4JfCvNdv0Zd+E+ZJNTQF1Cu?=
 =?us-ascii?Q?Tq8Hm0c1k7U0xDCiZrxu5+epB7ea8sKs3LuJKOAze9MTSlX9R51gRPyPKKcZ?=
 =?us-ascii?Q?uEf2c3JjG6gKChqBlYdh5BO5ucX8wAGqb67DKu8EUUnwQFZsppkBwbAYJWhZ?=
 =?us-ascii?Q?TrbqLJIdjgu7/qobli6f5ByOQ3wgf9vnEHRn2RvRgEGX2ZjnNxmYdHvQd1yM?=
 =?us-ascii?Q?ZXAKAobg2XLIyHfMB2R5nvIrB2592YkAT4Y9h/5+R6+ZEJ3wD9S/24uGl7t2?=
 =?us-ascii?Q?4T8mlmUQRYtekS7qxaDrfXN9xtLFod4feVudUaEc9LT7mYndL+SY3DhDw80E?=
 =?us-ascii?Q?Jmmf0xzKh3Uw/7z+3f4KJZ2HPMfhrqwEWc4dqV9XaEdtiwq/k26BauF2JJzg?=
 =?us-ascii?Q?h7Wz+Nqy//+0/pSzw3KudaMYu5rcTOjXF/FT2YoxLCxL8Ob51+BHqljuueKk?=
 =?us-ascii?Q?HywP/OMtymMLYBfC5ERkU+8HZzKwRTMZRmwdZaKlLyDA0+1l8CJDWdz67O7Y?=
 =?us-ascii?Q?se0EDN7mN8+53viodWrlyDmnKZZzsTuYa+9g9z594gLfF4b0LqX9kJe/Jdr7?=
 =?us-ascii?Q?FvIPNotugxwHanAxDtkIxDaQ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2926611d-9fe1-4047-b23c-08d91b5c902c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 06:57:41.7976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5WPgS1KErgL2l0nIXKlZrycdr6mjXZu3pxluFfJ3VL2QDfr9Z9a5DrJeJLwxvr+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2838
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_235746_099582_202E54A7 
X-CRM114-Status: GOOD (  48.07  )
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

[Public]

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, May 20, 2021 5:34 AM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: linux-pci@vger.kernel.org; kbusch@kernel.org; axboe@fb.com;
> hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; Deucher,
> Alexander <Alexander.Deucher@amd.com>; stable@vger.kernel.org; S-k,
> Shyam-sundar <Shyam-sundar.S-k@amd.com>; Chaitanya Kulkarni
> <chaitanya.kulkarni@wdc.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> linux-pm@vger.kernel.org
> Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
>
> [+cc Rafael (probably nothing of interest to you), linux-pm]
>
> On Tue, May 18, 2021 at 10:24:34AM +0800, Prike Liang wrote:
> > In the NVMe controller default suspend-resume seems only save/restore
> > the NVMe link state by APST opt and the NVMe remains in D0 during this
> time.
> > Then the NVMe device will be shutdown by SMU firmware in the s2idle
> > entry and then will lost the NVMe power context during s2idle
> > resume.Finally, the NVMe command queue request will be processed
> > abnormally and result in access timeout.This issue can be settled by
> > using PCIe power set with simple suspend-resume process path instead of
> APST get/set opt.
>
> I can't parse the paragraph above, sorry.  I'm sure this means something to
> NVMe developers, but since you're adding this to the PCI core, not the NVMe
> core, it needs to be intelligible to ordinary PCI folks.
>
[Prike]  I'm sorry to make confusion here. Those patches addressed a s2idle resume broken problem
that the NVMe driver's default suspend-resume policy of using NVMe APST during suspend-to-idle
prevents the PCI root port from going to D3.

> For example, since you only use this flag in the NVMe driver, you should
> explain why the PCI core needs to keep track of the flag for you.  Normally I
> would assume the driver could figure this out in its
> .probe() function.
>
[Prike] Yeah, we can assign the quirk flag in the .probe function or add it in nvme_id_table and this also
the primary solution we tried out. However, that seems not possible to enumerate every uncertain NVMe device then assign quirk flag to them. In this case, in order to handle various NVMe device we can use the root complex device ID to identify the question platform.

> Quirks are usually used to work around a defect in a device.  What's the
> defect in this case?  Ideally we can point to a section of the PCIe spec with a
> requirement that the device violates.
>
[Prike] In this case the quirk is only used to identify the question platform which requires the NVMe
device go to D3 in the s2idle suspend.
> What does "opt" mean?
>
[Prike] I'm also not dedicate working on the NVMe driver, but from the software perspective the APST
opt is used for handling the power state S&R without PCI interfering during s2idle legacy suspend-resume.

> What is SMU firmware?  Why is it relevant?
>
[Prike] SMU firmware is a proprietary micro component which responsible for device power management. Without the quirk flag, NVMe device will not enter D3 during s2idle suspend then SMU firmware will shut down the NVMe device, unfortunately since NVMe is a third-party device the SMU firmware only restore NVMe root port power state during s2ilde wake up process. Eventually, the NVMe device power state will be lost when back to OS s2idle resume  and then result in NVMe command request failed.

> Is this a problem only with s2idle?  Why or why not?
>
[Prike] Yeah, this issue is only found in the s2idle scenario, and that's because s2idle will check whether
each device will enter its own minimum power level defined in the LPI constrains table.

> The quirk applies to [1022:1630].  An lspci I found on the web says this is a
> "00:00.0 Host bridge: AMD Renoir Root Complex" device.  So it looks like this
> will result in PCI_BUS_FLAGS_DISABLE_ON_S2I being set for every PCI bus in
> the entire system.  But the description talks about an issue specifically with
> NVMe.
>
> Is there a defect in this AMD PCIe controller that affects all devices?
>
[Prike] In this solution by checking root complex DID to identify the question platform which need
the quirk flag. So far, only NVMe device need check this flag for special processing of NVMe
s2idle suspend.

> > In this patch prepare a PCIe RC bus flag to identify the platform
> > whether need the quirk.
> >
> > Cc: <stable@vger.kernel.org> # 5.10+
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > [ck: split patches for nvme and pcie]
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > Suggested-by: Keith Busch <kbusch@kernel.org>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > ---
> > Changes in v2:
> > Fix the patch format and check chip root complex DID instead of PCIe
> > RP to avoid the storage device plugged in internal PCIe RP by USB adaptor.
> >
> > Changes in v3:
> > According to Christoph Hellwig do NVME PCIe related identify opt
> > better in PCIe quirk driver rather than in NVME module.
> >
> > Changes in v4:
> > Split the fix to PCIe and NVMe part and then call the pci_dev_put()
> > put the device reference count and finally refine the commit info.
> >
> > Changes in v5:
> > According to Christoph Hellwig and Keith Busch better use a
> > passthrough device(bus) gloable flag to identify the NVMe shutdown opt
> rather than look up the device BDF.
> > ---
> >  drivers/pci/probe.c  | 5 ++++-
> >  drivers/pci/quirks.c | 7 +++++++
> >  include/linux/pci.h  | 2 ++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > 953f15a..34ba691e 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -558,10 +558,13 @@ static struct pci_bus *pci_alloc_bus(struct
> pci_bus *parent)
> >     INIT_LIST_HEAD(&b->resources);
> >     b->max_bus_speed = PCI_SPEED_UNKNOWN;
> >     b->cur_bus_speed = PCI_SPEED_UNKNOWN;
> > +   if (parent) {
> >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > -   if (parent)
> >             b->domain_nr = parent->domain_nr;
> >  #endif
> > +           if (parent->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
> > +                   b->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> > +   }
> >     return b;
> >  }
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 653660e3..7c4bb8e 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -312,6 +312,13 @@ static void quirk_nopciamd(struct pci_dev *dev)
> > }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,
>       PCI_DEVICE_ID_AMD_8151_0,       quirk_nopciamd);
> >
> > +static void quirk_amd_s2i_fixup(struct pci_dev *dev) {
> > +   dev->bus->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> > +   pci_info(dev, "AMD simple suspend opt enabled\n"); }
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1630,
> > +quirk_amd_s2i_fixup);
> > +
> >  /* Triton requires workarounds to be used by the drivers */  static
> > void quirk_triton(struct pci_dev *dev)  { diff --git
> > a/include/linux/pci.h b/include/linux/pci.h index 53f4904..dc65219
> > 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -240,6 +240,8 @@ enum pci_bus_flags {
> >     PCI_BUS_FLAGS_NO_MMRBC  = (__force pci_bus_flags_t) 2,
> >     PCI_BUS_FLAGS_NO_AERSID = (__force pci_bus_flags_t) 4,
> >     PCI_BUS_FLAGS_NO_EXTCFG = (__force pci_bus_flags_t) 8,
> > +   /* Driver must pci_disable_device() for suspend-to-idle */
> > +   PCI_BUS_FLAGS_DISABLE_ON_S2I    = (__force pci_bus_flags_t) 16,
> >  };
> >
> >  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> > --
> > 2.7.4
> >

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
