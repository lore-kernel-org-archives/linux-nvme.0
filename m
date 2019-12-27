Return-Path: <SRS0=8Lqz=2R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B62BC2D0C6
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2019 14:08:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6A5208C4
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2019 14:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KXp/M0Kd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chelsious.onmicrosoft.com header.i=@chelsious.onmicrosoft.com header.b="IIvL3Yvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6A5208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YWmMytTPMY3q03BvVvM2KCqlazagSTBlf9zvPCSnC1w=; b=KXp
	/M0KdeL1KxYlr0pczaT53C6Lw1sXJ83sJ+lPr9MawSGYm/6Dav1ihtg1rtcaiWdFJKQ1AMrF+rH7P
	uOBpEH37V2xy17xppj1+nuthffhQZPQV42DgWBYziLABv8cuPmgeOhCklvd2AI78ZtwUFuW0cSTY7
	8dxtdziNK8IaRb17EWe8/0/jC2/RMAQ2qigv/HaZY1p9Bz6khsN0Kns9XbdO66gyarE6tOSJrfs0j
	5u8eXbhj+AScUtl5tm+7T7GQ+J1iTCHMKAei+QkO9HwxYiZwidUO2bovAeo2KVVkqr7HwyaTNjMz7
	u4JXY6+Hohol6/JRJ5mNSmImp+3yAhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ikqHw-0002R8-Uy; Fri, 27 Dec 2019 14:08:24 +0000
Received: from mail-bn7nam10on20703.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::703]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ikqHt-0002Qe-Dw
 for linux-nvme@lists.infradead.org; Fri, 27 Dec 2019 14:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmI9yj/h8hYCO37lDkbcOqtABDKRlXQgqu6lpM5JW8nGn5uqn6/S9x+IfOjCV+ydGfc0jwqUxwlfxaO3Wvd0AiVDwtz6yWVh9xdjVEf4BPalXZFRzPaVFStxQGu0NpaKmOJqQ1OtEJ6g/+4u9QMe+ykKFP4W+4Aza6G/k2KbChBsOdnxZrmzmgKqWhbZzY2O3pmhHsBLL1tQS8p+wmIUuIHiym9wwia4Oun1kk5vDM+rWFUVN2qjS7/pg9XfZxPO3mW5HycTuI8mFJ86VvgK9f0y37YV9k7CMktQ8Lf09kIwr4+CjUrm9hZ/DXVtlK60fYmC94nZEt45hugIu7LUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku6MPQ96hMzaBmqObVK4Px2WujJF4iaZuJJsBnNusIQ=;
 b=ApU3XdSh0JHG3Pb6Yb1FTuXLJBhiB1iOD/TfNVOw7lnCMOZPMc+sG0vsY9hg+7QiZgg2+2F4Pi2O8fLsWXXA7WChtIcjjfz/zkaUX9w4x9eUiBrHZEmiFrymwH6UH5kc7HaJIiDTxrdFwJoAueoyKQgT27PEsKzWtXyexUAGRRVXjEdElBbCdBaIqFzu9SJhP+21P9aOzLoLCFodkBiG90KKDwWbYw3bZnaL1Dw9wyVT+mbgUnnM3o5pe1HInT322BPHdBnOelRSYmEavLaMFrcXdWPKbmp4T9qMWWUloVUm/M1IJ5ElNThPPxSeINycy9V7mCzxqF1cOIq8eiWJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku6MPQ96hMzaBmqObVK4Px2WujJF4iaZuJJsBnNusIQ=;
 b=IIvL3YvzSP9igfWR95U+SVXhjluKJ+CRYsUPnRnc/SFS3pkqyNI5nkziFystWL3+wJeAH8FMTyx6S0mzTcGzCsgTwKs8SqR17Xu9KCGD5qZ8g7Y2swBoPm5GTQdCOAcDOniYrdKi1C0IBnOQPU56tymTm1QWXBSlIKcYj//2JV4=
Received: from CH2PR12MB4005.namprd12.prod.outlook.com (10.255.155.224) by
 CH2PR12MB4246.namprd12.prod.outlook.com (20.180.6.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Fri, 27 Dec 2019 14:08:03 +0000
Received: from CH2PR12MB4005.namprd12.prod.outlook.com
 ([fe80::1cfa:52cc:4992:1f51]) by CH2PR12MB4005.namprd12.prod.outlook.com
 ([fe80::1cfa:52cc:4992:1f51%3]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 14:08:03 +0000
From: Dakshaja Uppalapati <dakshaja@chelsio.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "eduard@hasenleithner.at"
 <eduard@hasenleithner.at>
Subject: nvme blk_update_request IO error observed on formatting device with
 kernels 5.5-rc1 and above.
Thread-Topic: nvme blk_update_request IO error observed on formatting device
 with kernels 5.5-rc1 and above.
Thread-Index: AdW8valXLRnTQ+ULQCyoSItdiN7B9w==
Date: Fri, 27 Dec 2019 14:08:03 +0000
Message-ID: <CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0@CH2PR12MB4005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dakshaja@chelsio.com; 
x-originating-ip: [111.93.130.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cf9dacf-a048-4c85-0796-08d78ad63082
x-ms-traffictypediagnostic: CH2PR12MB4246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4246507A379C64903E96318BDD2A0@CH2PR12MB4246.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(39840400004)(366004)(136003)(199004)(189003)(54534003)(55016002)(81166006)(81156014)(33656002)(54906003)(110136005)(316002)(86362001)(8676002)(9686003)(107886003)(8936002)(4326008)(508600001)(52536014)(7696005)(71200400001)(5660300002)(26005)(6506007)(66476007)(64756008)(66446008)(66556008)(66946007)(66616009)(186003)(966005)(76116006)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR12MB4246;
 H:CH2PR12MB4005.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: chelsio.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DsCie0ORvo6i0rrE0hDyYmeD89mtN0I4G8HwRSEQmI72pdMtIY57XdG1R7d4eiDKNMFP6+nNBawxq/uy9WSTyRgNXreQDXp4xG2Mk7+qT/M24fSyey2fZyfstYYrZOdu6qUU69VSmLvG+innw/s/OqgqLwYfeZdSvS4GUG/6P7V6wqZuCZElLuOYxEdzy5h8FEucuWKt8bED6wLE0QjzO00cFrVf03aVMI6GnIZ6y4aguXGn6JTe7TUAP1GYZFsfqsGhZ2/6i8EYCL8hMAh11wTXs8RycZn4uuTYsMoZbcBv2Fsno/YciFIWjA2uJupPofmlQyG4EQwikwqAwJZBC1n/dpPKeEy83+cfb6K5voqxcoCfGFd/nM4ME9cnAxO1sTuwLkt9+7TzfLZEvQdrMpoygksvFwTTWvtM4PodXIhQzGPuGRMOyLLVlSvs/Roy0jWHPqlw0WkrL7d3onkxYuMaTGXxKf/HHejJdmuuIk8gpyBFjhQe6vnlnj5VBqMRLbJsigWvdKAZSCZRaK7AsTDJ/KnltotMnBcC4ZJn7J8=
Content-Type: multipart/mixed;
 boundary="_002_CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0CH2PR12MB4005namp_"
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf9dacf-a048-4c85-0796-08d78ad63082
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 14:08:03.6437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yhnJEP1cXY1ITdf1kPv1C25KMDfqCxLHcrUZSM6bmZuuHi1iQcrhH0OGnK7vKUc0D5/wsGkm889shrH2WqsvBD8c1t60w1FGK/uvyeGi3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191227_060821_617109_BFE9B91F 
X-CRM114-Status: UNSURE (   9.48  )
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
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--_002_CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0CH2PR12MB4005namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to setup and run NVMF with tot linux kernel installed(5.5.0-rc3=
) on
both target and host. Attached is the target configuration using ramdisk de=
vice.

On host, I tried to format the LUN discovered from target machine by using
#mkfs.ext3 /dev/nvme0n1.

The following error is seen in dmesg:
[  219.507989] blk_update_request: I/O error, dev nvme0c0n1, sector 0 op 0x=
3:(DISCARD) flags 0x4000800 phys_seg 1 prio class 0

The above error is seen from kernel-5.5-rc1 onwards. Bisect points to the=20
following commit:

530436c45ef2e446c12538a400e465929a0b3ade is the first bad commit=20
commit 530436c45ef2e446c12538a400e465929a0b3ade
Author: Eduard Hasenleithner <eduard@hasenleithner.at>
Date:   Tue Nov 12 21:55:01 2019 +0100

    nvme: Discard workaround for non-conformant devices

    Users observe IOMMU related errors when performing discard on nvme from
    non-compliant nvme devices reading beyond the end of the DMA mapped
    ranges to discard.

    Two different variants of this behavior have been observed: SM22XX
    controllers round up the read size to a multiple of 512 bytes, and Phis=
on
    E12 unconditionally reads the maximum discard size allowed by the spec
    (256 segments or 4kB).

    Make nvme_setup_discard unconditionally allocate the maximum DSM buffer
    so the driver DMA maps a memory range that will always succeed.

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D202665 many
    Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>
    [changelog, use existing define, kernel coding style]
    Signed-off-by: Keith Busch <kbusch@kernel.org>

Please let me know if any info is needed further.

Thanks,
Dakshaja

--_002_CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0CH2PR12MB4005namp_
Content-Type: application/octet-stream; name="nvmf.conf"
Content-Description: nvmf.conf
Content-Disposition: attachment; filename="nvmf.conf"; size=1026;
	creation-date="Fri, 27 Dec 2019 13:55:41 GMT";
	modification-date="Fri, 27 Dec 2019 13:35:09 GMT"
Content-Transfer-Encoding: base64

ewogICJob3N0cyI6IFtdLAogICJwb3J0cyI6IFsKICAgIHsKICAgICAgImFkZHIiOiB7CiAgICAg
ICAgImFkcmZhbSI6ICJpcHY0IiwKICAgICAgICAidHJhZGRyIjogIiIsCiAgICAgICAgInRyZXEi
OiAibm90IHNwZWNpZmllZCIsCiAgICAgICAgInRyc3ZjaWQiOiAiNDQyMCIsCiAgICAgICAgInRy
dHlwZSI6ICJyZG1hIgogICAgICB9LAogICAgICAicG9ydGlkIjogMiwKICAgICAgInJlZmVycmFs
cyI6IFtdLAogICAgICAic3Vic3lzdGVtcyI6IFtdCiAgICB9LAogICAgewogICAgICAiYWRkciI6
IHsKICAgICAgICAiYWRyZmFtIjogImlwdjQiLAogICAgICAgICJ0cmFkZHIiOiAiMTAuMC4yLjEi
LAogICAgICAgICJ0cmVxIjogIm5vdCBzcGVjaWZpZWQiLAogICAgICAgICJ0cnN2Y2lkIjogIjQ0
MjAiLAogICAgICAgICJ0cnR5cGUiOiAicmRtYSIKICAgICAgfSwKICAgICAgInBvcnRpZCI6IDEs
CiAgICAgICJyZWZlcnJhbHMiOiBbXSwKICAgICAgInN1YnN5c3RlbXMiOiBbCiAgICAgICAgIm52
bWUtcmFtIgogICAgICBdCiAgICB9CiAgXSwKICAic3Vic3lzdGVtcyI6IFsKICAgIHsKICAgICAg
ImFsbG93ZWRfaG9zdHMiOiBbXSwKICAgICAgImF0dHIiOiB7CiAgICAgICAgImFsbG93X2FueV9o
b3N0IjogIjEiLAogICAgICAgICJzZXJpYWwiOiAiMTg1MGVhZTMyYTc2ZmIiLAogICAgICAgICJ2
ZXJzaW9uIjogIjEuMyIKICAgICAgfSwKICAgICAgIm5hbWVzcGFjZXMiOiBbCiAgICAgICAgewog
ICAgICAgICAgImRldmljZSI6IHsKICAgICAgICAgICAgIm5ndWlkIjogIjAwMDAwMDAwLTAwMDAt
MDAwMC0wMDAwLTAwMDAwMDAwMDAwMCIsCiAgICAgICAgICAgICJwYXRoIjogIi9kZXYvcmFtMCIs
CiAgICAgICAgICAgICJ1dWlkIjogImFmMDllYmUxLWRiMWEtNGViNi05N2VmLWJlZjAwZjQyZDU5
YyIKICAgICAgICAgIH0sCiAgICAgICAgICAiZW5hYmxlIjogMSwKICAgICAgICAgICJuc2lkIjog
MQogICAgICAgIH0KICAgICAgXSwKICAgICAgIm5xbiI6ICJudm1lLXJhbSIKICAgIH0KICBdCn0K

--_002_CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0CH2PR12MB4005namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--_002_CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0CH2PR12MB4005namp_--

