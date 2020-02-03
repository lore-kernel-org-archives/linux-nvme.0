Return-Path: <SRS0=7ucB=3X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F8C35247
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2020 22:48:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B297520720
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2020 22:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tZuAaGON";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FpCR1cID";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xMIpLmPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B297520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=pdyA+u7iqlU3BTvyvjtzzwNKP6aAm19vBIsFKeVbcaw=; b=tZuAaGONrddh2q
	a28ywzfpGAPM6TLf9bchtCIRCJHpOSqJLuDG44Bb2ufA0YxT53iuRc8SYNx0alt3SlnoWDTXimNl2
	GTcq2KxuRCRc78FUb531iBLzsz+qWZOHAhyMYkgMezyVs9AILcRWzLCZIph77720tBKIogqlzNVC4
	TX71WCjO+WT0zVeE69FCrM4fkvP68gmcR3nWynvNVXwS6sCdzqS+7EGjTe3SDaybDildhvrMagt70
	EUdp2BU3zXdkiQWZkChXcVGwVrA7Afvh7coQ8Ci0WDcbaG8P4EIQV7P3MgGCjSWC5dl3vsPNl9C5g
	XeOcVTd6Bk1u+xi/FeOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iykWC-0004n9-KD; Mon, 03 Feb 2020 22:48:36 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iykW9-0004mV-DK
 for linux-nvme@lists.infradead.org; Mon, 03 Feb 2020 22:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580770114; x=1612306114;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=bB91vEqcHN2d7XBDzoeiwxk0h+MhyuInXEi4t7jESI0=;
 b=FpCR1cIDLLShw+p5q7ytp8xJ0YVP5cll5vXW6RSM1DmD6HMxoBtcEyYr
 DfntKOqzMzH2w097KUimY6xqvMjnE4iLL6DZHDq3xh7ySgZ+wYXFLYjlB
 f0prUfFzUby+5vt35ELcaG1cp74Ilv7GB+lpx+XTDTAvN4JCDTPTs5l+X
 SRxaAY6Q1wgpqMVyDalz1r9Wz3If4nVVT1f2xRUL/ex16Vx2bYbzYXdHJ
 FjKbuoaHAkMjizQiogR2Y0IfvBWhIpUmjkCcBeJ/hjtcpBNJC/nIwEZlu
 xwF/6o15s4kIoeKT3atkEyIn9iN7ImsGCROw6fnoDHIR26nhxvK1bqgF1 A==;
IronPort-SDR: TriN98imVN1RXNfWW279KZk/Y7N82ou9E6io1NmH5J5YkEU9NRZPdop+4dDwP4chbNkc8yGxnp
 XdzdZZYm9TPbw8Bc+RfzeGxlPzhVfYq80vOBE4lfu/BAMCqA1cgXWrs0rNLXvIBHv5aimlxTNJ
 dMsx3e8aCLfohA3MshSd3IQ426RbgF9ZXktLnXkHFQ7WeilTlMI3xqsi/ArQFlqctyENWJNeEe
 qVfhnS//LxeKYnwbKPfwNyEhCqRsjPrvqFpeC93+1I9bnyxkHmCL3iASCU4QR9q859XWd/Qfv4
 Lpc=
X-IronPort-AV: E=Sophos;i="5.70,398,1574092800"; d="scan'208";a="129560054"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
 by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2020 06:48:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fftf9xj5Srav1f8kCOf+kk1p2PC8va/NSaABE3Nxzxgv1m+7RciJVHmOQXHXGQaLP4gJu8dAB5fRDqbroQSeo/QfrKIDSzG7kjhe+VJVfULOMrzuTly8JPyI2TO8d8ppUFAI1jm3gYrFJvG579DuB7IGTKpZEn3uH8MzkXM4jKSNFVl4HAkB9SyLI4BmCno1tbqMegX8yxTh3mGCZTudKlPYZK14Q4CVz2QSKnUfzkP8a8M+p7+rRwjPvNnR+P2UZaeWBD3BfK3gpardJEhoLoyWgWrSnxWi06ECYJXfkgHQIrT5e5iMyUNDbdneayWGBl/F0pz5VeyoVgbx9C4WiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON7Cwd1euX70wPLg8ZaxCKGOxMxte6GTv4l7oX3R60Q=;
 b=nH7P+uqbE3U3YBp44ifw35E2QGNejH78gOJe+M2HXrtcWyEyb+fkmZNEfAqf3uIbrlr6qKwvSLe/T7wyZzdWnBh6l7WFVWtJIn0iJEjRXgSgFKdkrPD2vy3LRJwuEQaUh56eDsXumD+fUh3Z7Hg8EbQUurvLxOidU9mT/X7v/1tvkYWbIvvAxN5JNJl3LPQ6/gcgJiXgQSoL9xUXM29QQoMf77VJ4ymaAZEiXYND9MPjViy6UNPJhaXCPq4hs7jp2SvAcXthBSY4R8Qc9yQ3vGufm6m/1NJjn2PetOYCp34OOvtK5ZMb/L23ySCJXhbSg9V/sIUDNXUzSYRjwm6F0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON7Cwd1euX70wPLg8ZaxCKGOxMxte6GTv4l7oX3R60Q=;
 b=xMIpLmPXScXAq/dHKLkagaRTGc95rlcs0o5gKptzG4DidhJWMnEsn4GZiYKn9YBOgJKm7BK9CjMxCugVJ74AxEi91JCKM53Iq9+P0TSG2J/MMmwFDumTXwlH6NWn8touUagl+V1s8CZ8r82vmFL19ewCW4htZGf8pLg3UxTTI58=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5799.namprd04.prod.outlook.com (20.179.58.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Mon, 3 Feb 2020 22:48:29 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2686.028; Mon, 3 Feb 2020
 22:48:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Topic: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Thread-Index: AQHV1vvxPjad+7sLRk2UwG5mK03ccA==
Date: Mon, 3 Feb 2020 22:48:29 +0000
Message-ID: <BYAPR04MB5749FE36341AB61547C1218A86000@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 536ecbd5-d105-48f3-f22b-08d7a8fb3012
x-ms-traffictypediagnostic: BYAPR04MB5799:
x-microsoft-antispam-prvs: <BYAPR04MB5799FE6FC46E5D7BC029A2BE86000@BYAPR04MB5799.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(4326008)(186003)(71200400001)(81166006)(66446008)(66946007)(33656002)(81156014)(9686003)(7696005)(5660300002)(55016002)(86362001)(52536014)(8936002)(2906002)(6506007)(110136005)(66556008)(26005)(478600001)(66476007)(64756008)(76116006)(316002)(53546011)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5799;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0F7ds17Zj44fZJfE3OfY5ZjJXkkETuAfrxw7gVAMkyP+yHwtPYtJIuVRpfgZ+BTw+qb7lz5cwnl+7Gbdh6EfZ5zieTu8cwYD+t2u5sJswJjhgyXXvMvYJbZ54apnc+jYmJWb/qJhrCVHtX+gYKhTnMEFffihIofdQjFnMUnXrPO6+PAptGnNY/keioPAg+tz54YPeounYRpyFRCrECGfP5lCnsi1pS6Bp6b4m5vZjsnvcnJXye7Lx+HRFur/LVT0JhcSi/D40/fmbcDPijTE1191XWDqKt7stWLbJJ7UycFuQsBWg6AH0XcyRRFV/UXW/nSsHkjBZhlXb3dvTBa1aQA1k64n8N9OH4YyK1aBXDfw7BYUFTDs7hLlKzLEwjeCbFydVjODhuiqPgsXxlvmXYsZ+GF/Jb6M/82a+yfky8ela5P22zDYXWXzhc1Z/vzh
x-ms-exchange-antispam-messagedata: riXwp4jSA0ah1EFE4W9j4YyR4vKp+xkph1Ty/myjirwFCr6LxP2lobZuWoE2oNg/Ewt6vl+BDBSmDF5YdpajXdJQZt/+NZ9hIdRLF72vJ6VH4MvCU+SAeGIUqEMWTvA2HwfEWZ0nLuFmSydDcDFPSQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536ecbd5-d105-48f3-f22b-08d7a8fb3012
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 22:48:29.1561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9Igu3RNEsVD5JSOmglFs99PSaMwx5Ar4KAS12KTzbDyO9QwWZ42E8CDRPH/DHAUZxnT57k3e8+hDzFloaAn7GGqkClQmyyz7/xdtbtVO7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5799
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200203_144833_492449_144D3619 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

(+ Omar)

On 01/29/2020 03:29 PM, Chaitanya Kulkarni wrote:
> This is a small patch-series which adds two new testcases for
> setting up controller IDs and model from configfs.
>
> Regards,
> Chaitanya
>
>
> Chaitanya Kulkarni (5):
>    nvme: allow target subsys set cntlid min/max
>    nvme: test target cntlid min cntlid max
>    nvme: allow target subsys set model
>    nvme: test target model attribute
>    nvme: make new testcases backward compatible
>
>   tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/033.out |  4 +++
>   tests/nvme/034     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/034.out |  3 +++
>   tests/nvme/rc      | 24 ++++++++++++++++++
>   5 files changed, 155 insertions(+)
>   create mode 100755 tests/nvme/033
>   create mode 100644 tests/nvme/033.out
>   create mode 100755 tests/nvme/034
>   create mode 100644 tests/nvme/034.out
>
> Test Log :-
>
> Without cntlid_min/max and model patches :-
>
> nvme/002 (create many subsystems and test discovery)         [passed]
>      runtime  15.246s  ...  15.053s
> nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
>      runtime  10.057s  ...  10.063s
> ./check: no group or test named nvme/0004
> nvme/005 (reset local loopback target)                       [not run]
>      nvme_core module does not have parameter multipath
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.057s  ...  0.065s
> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
>      runtime  0.036s  ...  0.038s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.233s  ...  1.240s
> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
>      runtime  1.203s  ...  1.208s
> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
>      runtime  14.572s  ...  16.051s
> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
>      runtime  13.584s  ...  13.948s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
>      runtime  9.877s  ...  10.750s
> nvme/017 (create/delete many file-ns and test discovery)     [passed]
>      runtime  18.902s  ...  15.584s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
>      runtime  1.217s  ...  1.237s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
>      runtime  1.204s  ...  1.193s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
>      runtime  1.204s  ...  1.195s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
>      runtime    ...  1.334s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.218s  ...  1.231s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.207s  ...  1.196s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.191s  ...  1.195s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.192s  ...  1.196s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.211s  ...  1.191s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
>      runtime  1.204s  ...  1.211s
> nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]
>      attr_cntlid_[min|max] not found
> nvme/034 (Test NVMeOF target model attribute)                [not run]
>      attr_cntlid_model not found
>
> With cntlid_min/max and model patches :-
>
> nvme/002 (create many subsystems and test discovery)         [passed]
>      runtime  15.053s  ...  11.918s
> nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
>      runtime  10.063s  ...  10.058s
> ./check: no group or test named nvme/0004
> nvme/005 (reset local loopback target)                       [not run]
>      nvme_core module does not have parameter multipath
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.065s  ...  0.065s
> nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
>      runtime  0.038s  ...  0.036s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.240s  ...  1.239s
> nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
>      runtime  1.208s  ...  1.207s
> nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
>      runtime  16.051s  ...  15.345s
> nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
>      runtime  13.948s  ...  13.977s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
>      runtime  10.750s  ...  9.698s
> nvme/017 (create/delete many file-ns and test discovery)     [passed]
>      runtime  15.584s  ...  15.514s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
>      runtime  1.237s  ...  1.232s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
>      runtime  1.193s  ...  1.192s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
>      runtime  1.195s  ...  1.195s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
>      runtime  1.334s  ...  1.340s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.231s  ...  1.218s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.196s  ...  1.205s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.195s  ...  1.191s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.196s  ...  1.186s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.191s  ...  1.192s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
>      runtime  1.211s  ...  1.187s
> nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [passed]
>      runtime  1.213s  ...  1.200s
> nvme/034 (Test NVMeOF target model attribute)                [passed]
>      runtime  1.223s  ...  1.204s
>
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
