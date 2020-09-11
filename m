Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3279FC43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 14:40:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36EA222D5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 14:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ea5a4cqJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T51LKT47";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T81wsvqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36EA222D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E2BHDdlQAaNoS/TqgapRix3EUJXxrJux99aHOxUymuI=; b=ea5a4cqJpXrf2Pz7UhMkvyejXl
	ZZoF8MhQHl8o2hthPHksnZQcFVI32rsHKaChKGYxSgYm5AftKAMjrtdoUUUeDapsf1daRTlO1EN/P
	XMonKVnMq05Wz88lNzP1HU1Nlz2CCge4+EU6ZNA8/242AGzQQOFmH2L3XVrs8INcbA8dTDlCBXZw9
	NVHi9tPCnVH9/91LM0SNHsClxDBtonLaQIEenAcvEMleGpe6AhFVEJJEV/k9XaXYLjrOKNT2slL9b
	3vxCFQ0Yzz97tTWhKNG3Yvbef++bChtTiT5PHcir7WPMM/EkO6weact7y5sjRoAcHBPq3dQgTBfux
	Q054n+zw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGkDm-0004ze-6I; Fri, 11 Sep 2020 14:40:14 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGkDi-0004xj-KT
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 14:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599835210; x=1631371210;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=g9P+QohQoPbeUL1PmMgggUULlNqE7VLO8t89UgyIVOQ=;
 b=T51LKT47Zd7GGjrU/TstuPFlSyOA4iGpXMD7XUOifkfco2WtCmUBjTfq
 clrXdoSo/7SAI1n0CUkxidW7FdJZQlad5Kw7LbwHfnLS1Ck1/4C/uP5+2
 WEahE/aq3y60hPgyU5ntH7rTnTGZWz4WKOg/lY7Ksw6iL+DHGHAi33OXV
 R77FL81j+x2raBABgRHwR2cMma8IToYi1SM2MHmFgUYmg2+imX2OEIPDW
 rNvVnT7UdP/gA3LvcjvEFjzoQGjUwtphSn6lC020ffc/kDIEJfJKghQfU
 c9HT++QJxdO0FweHFC6fMBM/m+vaKWo+It2el7LTd5df3qo78dMB9kyvM g==;
IronPort-SDR: wUwC3ib6rY/R0rjZrndGFK8gaw5ordktX9l90yguHGBklEpG5/OP/nxHlYMdf0BzAIUGl8wK/M
 mT7A5OoLX8+OHNZp6qPyCzfmggPomArIR98ytIx8tqE6lWh846RyQqBvfQg+DT3y+xo+Q/uD9W
 ve7Rgr+O8HtX/5vkGg/zdLmSPLQxl+XC0pEXXPVYq37QaC2j7bYf9MsIlrCGUKILLEhSfIKYjS
 tO6+XAHjEDSaEn1VFxu/qlF8N7aGcpGDL60OlwVJmkHO4i0Oe5jGPmK+s+zlEaosqZcznbWgcT
 TGw=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; d="scan'208";a="147059207"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 22:40:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQwKW/6a2FJbkz4G4wXOgVv1a15e7mDgBHVUU5eCexhDNfo1e80xUNSOYycvr84AAv6B17Fll1O5yVQgXQez5sapjR3/O/nZZ2rZPeB2RQ2tTSrsMT7mKSboOOFD88tsfA1p0SdbBOraRWBwYg92XIrItpSNQ7wGhKmhw2yP8vx8Max3cvi+wPE+UUXN+YcdVRLljlIiCnKZQSps80PjCjMWvMuesIJ5P+xY8YeLXSQiZ3NsXbdoPHIyJpClqXwSNHAwc5DmkPJm320CSY45mM6MM7rJRhaOmBX89wBKgrFU9V7PNFEtxtO6qdXtdN5FpBylNgxN6rr6zo63YPI67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXRb5QqpCYqfnbsPoTOKRp9oKvf49ZtTt8YdJ3kBeY0=;
 b=dvJpdFsTvJDKiMEms7VP/qUuwnd5i/zTnadznqQtF3S7pYA3Teu4uyYLN4lrYQDnyHu2qrO/bM3lGRnPY0yl8YqrdfxhkXpeqRm7Zjdw7+7B9ZbeV/tUw6/E+uCleM4degFNk32Ol91K4kNtWDSi/DBJxAsz5ma4Qof4refueE1JtCC56D8yu+4NE82EkmsPkSGLjfAxZfVg2rBp4DWpstuvL2+MgjD8IPvsdyqiXlSbRnIAhoKZQElj3N6p9y8G5sMSw2GwiTnoQqKeAKXWhlaUb+c2hIkiUoCnNZ/hhiR78iUOzBScnchJNWlylOe7v/2sgTjB2PuKF6gPtb7pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXRb5QqpCYqfnbsPoTOKRp9oKvf49ZtTt8YdJ3kBeY0=;
 b=T81wsvqiCYR3vZGnWjK7KQvSfhG6b3laiBXGsFWlc9KoHu/YRrKzwqEpb2tUhKredKQqv0CYJMhK41I/vh/yvPKKSW29Us2WyUqDEBtqq0exlHp4BrVcqySTUKWexE43vDybyE/gclCuTVAAoFcDTPgYFiRAdzzYpsTu+PWSBqE=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BYAPR04MB4999.namprd04.prod.outlook.com (2603:10b6:a03:51::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 11 Sep
 2020 14:40:05 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e88d:80d4:a916:d197]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e88d:80d4:a916:d197%5]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 14:40:05 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Dual controller sysfs Question
Thread-Topic: Dual controller sysfs Question
Thread-Index: AdaISJF8akXR9T8lQ7SgYU3Q6eKKuQ==
Date: Fri, 11 Sep 2020 14:40:05 +0000
Message-ID: <BYAPR04MB5656A018DD122D37806A8EE2EA240@BYAPR04MB5656.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [71.37.227.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6af6b0c-af5d-496f-62f6-08d856609314
x-ms-traffictypediagnostic: BYAPR04MB4999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4999E0061056C42DD58040F4EA240@BYAPR04MB4999.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMYP/dC5oWgW+Nt8Jw3vw+y40wgL/J3Hsic7fqbGTqVmzhwsCjeX3/FL41GREPuMV/qutXBY0lR3pylbAXKVUOXr7HMpm2tNcURbGanhsJaUBb9xMyy0uv/E07fgZqBwhFlKr4PyyRA4FK/jPvB6zpAMma07GJ/QZBzTk3hDQAjQ70VgcQ/mDGvjAQAnF3amKNBbKDztx0K2BViMbhreJrN6050fkfgfj2COjAg/K8cm8GDQseb+Rp4p92X7EsFI1gbVPrdAwJPJTYTC78lbjhks4mJrMJ4iX7we2llIAD7utwJRA4EwYxzONc056sRm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(66946007)(110136005)(54906003)(8936002)(66556008)(7696005)(3480700007)(66446008)(5660300002)(71200400001)(76116006)(64756008)(52536014)(83380400001)(33656002)(66476007)(316002)(86362001)(9686003)(55016002)(186003)(26005)(478600001)(2906002)(6506007)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wnFjE4mrFAkwdy28S5zllIrJf6xiTp4f2q2z4f8YJBlLLLYjvb3PpTrL2a900ooo+giEnL2TN8m1QaMogUuPQoZgra5W42CklaxRqTBnMSIwu6FXZkYayjB2R8Z3p6jjyWA4wGGQfJsp/SP6lsxOOLuN32YxdRTgB2TRZuuATBWqE62Uj4oXuOpFReDvoI0/pDhgE6GtPhHdG4/e/CsgKhfR7O/mxNrZR7Ru6UyhnoUiFeAh06UnUQAbh3rtTTVUnmQ25nLh7UKFNQ1KnlNGhZ7Q2PryTTogwp0Hua1Pv6o0f+AesXYCGOR638faAGVGYsNjmWz/jLAGiJHRuxyyqLDHOST5smI61FraIADz8CYw/bjVfOGJxUWFMYDILvKThRKz0hqWyek6xGBV7rCxY6weOYMBAia1seGR3tehIzuf0NVNcYzN6556Ac3NVw/FMAPv9IMgnFvKlQA1Awr4Dov94UwlLv/Xp6sQuicHl5eGTuJPEGy6BhkDGpH0fs34+bmLb+SYzG+uCWxYbtsZwuflfCNrYPBaeJYbOU43mo/DZ5rYVwCok9yY9eIrlitXZF69ir5nv9AHpmq1NbZDA9c8yhRs6IIQ91/skXlfa/4dK9VjKMyjkcPg5EjlS/BKy7PK+zGb6Fuoyu9adUSXrg==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5656.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6af6b0c-af5d-496f-62f6-08d856609314
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 14:40:05.5941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0V7GTcbxUj09RzjtKc5W6XASfL8FybKDYOg1dXjA98a8bx9OWle/W3wQvA0SrfSd0Yj+y64FY0dWDz+qX70Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4999
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_104010_898168_0CEE3D46 
X-CRM114-Status: GOOD (  17.38  )
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
Cc: Prathiksha Nayak <Prathiksha@wdc.com>,
 Yuvaraj Hosanthe <Yuvaraj.SH@wdc.com>, Akhilesh Rn <Akhilesh.RN@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We need some information on how a dual controller drive should show up in the /sys/block directories with respect to latest 5.4 kernel.

Below is our observation :
When tried  a drive in a dual port mode with namespaces attached to it using Ubuntu - 5.4.0-45-generic kernel version, we could see all the block devices getting listed under 'sys/block'  path but when we check for the block device uevent path of the attached namespaces  ( i.e /sys/block/nvme0c0n1/uevent) we do not see the DEVNAME details in that path but we could see the DEVNAME details for other block devices under sys/block. 
There are 2 namespaces created on 2 different controller nvme0 and nvme1 and below is the output from sys/block path.

                  # nvme list
                   Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
                   ---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
                   /dev/nvme0n1     SDM0000029DA         HUSMR7638BDP3Y1                          2         150.32  GB / 150.32  GB      4 KiB +  0 B   KNGND688
                   /dev/nvme0n2     SDM0000029DA         HUSMR7638BDP3Y1                          1         103.08  GB / 103.08  GB      4 KiB +  0 B   KNGND688
                  # ls
                  loop0  loop1  loop2  loop3  loop4  loop5  loop6  loop7  nvme0c0n1  nvme0c1n2  nvme0n1  nvme0n2  sda
                  # cat nvme0c0n1/uevent
                  DEVTYPE=disk
                  # cat loop6/uevent
                  MAJOR=7
                  MINOR=6
                  DEVNAME=loop6
                  DEVTYPE=disk

With respect to other kernel version which we tried (i.e SLES with 4.4.143-94.47 ) we do not see this kind of behavior and its working fine with dual port mode with namespaces attached to it on same drive device by getting all the DEVNAME details from uevent path.

# nvme list
               Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
               ---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
              /dev/nvme0n1     SDM0000029DA         HUSMR7638BDP3Y1                          2         150.32  GB / 150.32  GB      4 KiB +  0 B   KNGND688
             /dev/nvme0n2     SDM0000029DA         HUSMR7638BDP3Y1                          1         103.08  GB / 103.08  GB      4 KiB +  0 B   KNGND688
# ls
nvme0n1  nvme1n1  sda
# cat nvme0n1/uevent
MAJOR=259
MINOR=1
DEVNAME=nvme0n1
DEVTYPE=disk
#

Could you please let us know your input on this.  Thanks


Jeff Lien



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
