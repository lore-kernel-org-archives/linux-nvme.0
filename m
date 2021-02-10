Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D3FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 08:52:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D9E64E15
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 08:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D9E64E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=GYJdn5p9nyprEr2bxbxgU7pvzYI9QFxysTCa9ppa3cA=; b=buxo05eQOloKtRMK7vKmg0rjf
	oVgDMfiJ3JbmBPGHhQodJ2hjrNzSJNMaxTdJQEdsOdMnB595KJMLmfKcxTGdevwUAknVyjjZcAMEN
	wQd6XDKTlff2JFeUk8gZJvo9BBSndk6rQDCrwPFrJovhO6SmEc49V8SoZCwUV3RxKKjffkz0nWDjn
	12NsJb6iy1avQcTfRjm1pynpyWyswWSORk0tWfjZ5v2ivZrs8LDQSsjJUbT42mxDzGkoEct8yA5qY
	Gf+ZhRCX8kz4fjkmjpU0LBOwyEKoOOO3DIJ5PnaWkvPWu1s+lp3NtZLtI0hwk1tSwkCXVmlsT7aq/
	IRJGXScvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9lEV-0007jZ-T8; Wed, 10 Feb 2021 08:52:23 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9lET-0007in-CI
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 08:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612947142; x=1644483142;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JeCaWQVr/cTU79v2VQTnzYay+IlpQ+stXNhZszIr4hs=;
 b=X3AazsdleC6utbLw0VrismHJdtaPWGq+vU6Tz1vEw9Z60Sb+NpE72dOw
 KyEAFUrI4P2l5rv4c/DvSVykuORaTWH2v11YzjQ3s74aTLeYcbWO+fCQZ
 zFRKrOg017hSCjr7vfcZlrADAgUZy+k8KhQmTJ/OkithR9CvStf+eI8fe
 UJuuA5RbyHLi9SFJ8nxNf6/xl0WGyOo98W0H+d3AGyMplLcc4woTUZsfi
 FFeD2hyyC1b9jUtbK3BEt4802tIVCHXULxIviqusCExiCoNTckell+5I8
 K4DRr/Z3YYwbmot4dfSsQIJV6MW0hQHvE/VRj2xedcivLrM2WeejRA5jm Q==;
IronPort-SDR: 8sYiCMLdVYmYuZKMmeQx+/oFN9ODLg7S0KD7UTQqCa4KkCSuJRJGLqPek3Q3XvnTI+dkKTf/sf
 f4QqX0822me1raPHcTBt7MEjV2qq0xIRM03lvdkLF5B8yLTsXoC4f8EQXsJvaVdKyiCQ1wHLMk
 0jI8O04+6iFIAXYXqSIIxE6y/9qNquVIrkKMSPQ1BBcmg93EHMVIdWJYjIw+XWg8+8sDEsSUOh
 j9o/I9yO7tLZnIoglE97t973ASWnJgy3JcEfsOQWzDG3z+zFYSNPVXb9Yz+c/RfPk6V3lun+Sb
 gJg=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="160791579"
Received: from mail-mw2nam08lp2171.outbound.protection.outlook.com (HELO
 NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 16:52:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYwxmg96leMEE/yz7xG1UVCVIXzTJ6MGXuFVMj0Y0g0XvTSDEwYSS/zNeU0ZLyYnNNVKbAJdnh8VMsG+VydYGcCPBVXashNp7m0uRt/rOb7sDYOJppFHHxj19WMz3r1xgyQ7xsgl6wOzkwtMCABPtEg6BjKAvOnw16iFzMzaf0391HFGQllz0riAmEskGg+LT8sVt9KNqc6xERk1ZtW59AdJ5ExVGciLACxO6zdfcIL9HkYL04URQmSeVRuMGEXVtjIonauGJtACgIMoNblHZ0UwuCUAxu544kEug/ceUOWXtkCD3ZMlIHGH43FEBlgTa0g2wwRU5St0FjiFj0F+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUkSij8TnlByTBVDw7FYm6T6cxG3nW3neH9xSsC92QI=;
 b=WuNVTh2Ou6lhyPz5x9ngigbJBi1+hJIwxmhbgXYtiD0CH8irPut8o7WKYL+C+LSfhn6PVKGcf74gpcxPYKyppDRbnTtJWms/8l5u85k383Hv6VPoVoCdwxQDymzaYVKzNR6EdxfB2/Kq8/sSRjSZ1YV9wNihhE/CLroYwptkDoWvb22TfO0h+MfnaA62MFOpInltnvvUJowM4+h/k1VK+aZfPs9M/xoIBudjvhrG6TEYlKbcFy8E1+J/pw9YK+/hmpl09Zhw47SiXcikqf6rlLxpfSwdHrQEVdHG4bEnDOGu4Rpb9OUnKa5N4PGkGvqH3FlSII5YkMP/iOJZKkRQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUkSij8TnlByTBVDw7FYm6T6cxG3nW3neH9xSsC92QI=;
 b=LV0e4OqVbbsfhgYeyVhbMixpcB4Uh2hD//Bu0c1CZx965uhinPxoNjofvxmqiB6xICeoHkPcEX0buydORvKYQbxKa8osvfTHgk7XuCyY3BRQ7qwwDIWkzIS9zbLdlDy/van2Bz6c70yH8xFMvKnSLih5juJznfC+cDuy3M3k3Kk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6248.namprd04.prod.outlook.com (2603:10b6:a03:f1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 08:52:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 08:52:15 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 00/11] nvmet: fixes and some cleanups
Thread-Topic: [PATCH V3 00/11] nvmet: fixes and some cleanups
Thread-Index: AQHW/3BRvDi6ccN60EetS+VVpeZAuw==
Date: Wed, 10 Feb 2021 08:52:15 +0000
Message-ID: <BYAPR04MB4965C6B3B16E9919691B6B4D868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
 <20210210081155.GB24040@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bae4ed48-1b2f-4f1a-07a1-08d8cda12a86
x-ms-traffictypediagnostic: BYAPR04MB6248:
x-microsoft-antispam-prvs: <BYAPR04MB62487384771A94902F85D163868D9@BYAPR04MB6248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTYj78HfsPElQiSb+hi0vWPOWSz3TOYuParMCo0qDzkNnqFp28C1YxKLcXsFyMWZ+68Kj9LF6LEhnCTZRL64lNah5Y2UtTt4qZQNBO1BzlglZmbbzH16QOqnNadQPmeFsvtjt1VrY3N6Vd3SctnVxDWMRi2nULGDjQcDDJ1l7SEzTu332nBBn+EmABxtBj5KuyMqGFb+xpgdML+8ACn59owaBAAUNz4U8K92HH7/Dg/D6z0I9KXrM4jU883nVOZ/wAT/JNR7e1R7HpvWwLheAGbX7pEz+ubIk4C4ac55KCBPu0rvGdXECiZPWGEkKn2W3MdCj7iwbJNoMoIO/nM5FsUSeLfrmpVwT2kdevbE+kBeeMm1xLuuMnyUlDm25e0+yqO3WpxNU/YeJG5AYwSpIOA7dgCyAoRINoMfZihrsvHs/YnkUUsJQP9QX2iXSedteqliRGnKjWqfhKYRljc8vyTbyIbGDIWsCuxdnVqDDYjEcs8u36ygBsSd+UqSEvUO18joobbrGW/N7W/skDsHIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(33656002)(186003)(86362001)(8936002)(71200400001)(26005)(52536014)(83380400001)(66946007)(66556008)(64756008)(66446008)(6506007)(2906002)(66476007)(76116006)(5660300002)(54906003)(53546011)(7696005)(478600001)(6916009)(316002)(9686003)(8676002)(4326008)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SrQNFbC9h/dXg8kDo9tTHXvaLCo7vnm5BP9tR074nxAN85et4tvw4KzPbF7L?=
 =?us-ascii?Q?4ujuRNISnzN8w3F6Ia9a/mdUNbnUSuqh0a8YgkanuNVSsD6OunCOIpDn8npq?=
 =?us-ascii?Q?psHQVkjp2cxJmSdRsWU2MoyAT2CuGT+MaZXo8iHW0euLYg1DIKAzkVO19r0r?=
 =?us-ascii?Q?qXcR4gTksNBzb6oc4SJOhjswAh3I0Ejmde/sFq6gtQE8xTQS+GHjPao55rEH?=
 =?us-ascii?Q?OSsA5vWbKbJ8jMKYz/hZSSbVNsb0mppuYhdthWrFlWCVrkOrj/mRIwZV2At3?=
 =?us-ascii?Q?M+qsz8l5wvqo4MZSomNHhycS8evMC2wVXpRFohD0LdK17JbZyGIC/HDb5Ii+?=
 =?us-ascii?Q?scBDI1m1xbIHMFIfCRI7lbTClBWyJ/pfWiZYqfjpOJLk7uLdVw0U71Is0TJc?=
 =?us-ascii?Q?uJiNmmn5PIxgLmmmleDEMBdtVSJsqbCvsaTBPDHEhkrKRa+g5WimGzsi18FQ?=
 =?us-ascii?Q?ViOH6mRppY2FUPS2wAfuOv4whE7vbSBsOJCZKbzU7qzEZ4yFMKrFEMO8Gm64?=
 =?us-ascii?Q?hY6SVaSeOPPbcny6ROx+gNdFW4d8qNind/tZw2tdHBouFJT5j5+Bqi2DkVyY?=
 =?us-ascii?Q?W2epKcAe5zfj2BPYNYDU+WC45O1cbxlEv71wb9b+m1IwRvIVm7R9VrF05ceX?=
 =?us-ascii?Q?6kpmfU8O29NASLnAgRmBmO5cUq94h4cEbB1yUZYAzigoWJUPwRtEgTTpcy9E?=
 =?us-ascii?Q?n6vO6xeJQd3ed+YuYsTzII2CH7/i8DYl9aOgSdmU6mIc2V3SD63QtcB0Hu3P?=
 =?us-ascii?Q?miVvtAcFrSctfM7MFE1CN+p4VPPbGlMsmHSR9o/IZvLSqqC0We8gCfLWATQU?=
 =?us-ascii?Q?cvCadV7n5Ngmli+cfwezOYSh+0z1rBlGnE1xZCporf9/63Gb7rsO+qqbZWJz?=
 =?us-ascii?Q?RIosAAq21aFcyo9pD4oh7uG3BtsD4WC2MTltoJihW41YmHW4ByASJGmB9fwe?=
 =?us-ascii?Q?eAHGKpnOuL+mohD5B48KHBlp+9YlyPVHUUfOhcH2J26YPShYpSdbqYVUC5aM?=
 =?us-ascii?Q?TS9zrIvbPhkMqF8pQNi7zi6iZcL+qCm+JE00e27KKgdSHJcu8ZqHyqw9LwYF?=
 =?us-ascii?Q?H+450EgGtCo/o3aYSyS40RyZe5fj/E5iNHP37T6GTgse6WPWA9Npw+MMrdOJ?=
 =?us-ascii?Q?WPqhxlM1FyZyAthEKemjMsZBXiuKktjMW1b50hxIvwXpfBepzVN7y90+RAlJ?=
 =?us-ascii?Q?/Sbu4tkMxqMw8+u34OuLSOU2AXk3APZsdTNjj6tCFiptKu9bkcOJ8bGy208V?=
 =?us-ascii?Q?XVX/2zx61Nff5H53zyXEQtkdYN7VlFnxNyfoaqizjKZBgW5p369zKuSUDSzB?=
 =?us-ascii?Q?ySbfqEwus0jzLwux1sPLBTNM?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae4ed48-1b2f-4f1a-07a1-08d8cda12a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 08:52:15.8381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEy+FjLIM190HF6WH4rRNfJw2DWp8dOv5QOJurmCF88D3ANaZnIw+5RQR1OcUCNPMxivvUcUl+W7SBYAm97ygKMPgk7V4aH5AF1CCTYJc5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6248
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_035221_614741_4232123F 
X-CRM114-Status: GOOD (  13.45  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/10/21 00:12, Christoph Hellwig wrote:
> I've applied this to nvme-5.12 with one exception and a few tweaks.
> More in individual replies.
>
I've pulled the changes from nvme-5.12 and ran blocktests. It seems to
work fine.

# gitlog -12
26bb85e126d0 (HEAD -> nvme-5.12) Merge branch 'nvme-5.12' of
git://git.infradead.org/nvme into nvme-5.12
523bb6d79f0e (origin/nvme-5.12) nvme-hwmon: rework to avoid devm allocation
4da2cba48943 nvmet: remove else at the end of the function
7684ff0eac09 nvmet: add nvmet_req_subsys() helper
d93178da21dd nvmet: use min of device_path and disk len
ec3dc8c50add nvmet: use invalid cmd opcode helper
ff887268ac4e nvmet: use invalid cmd opcode helper
022b300c9227 nvmet: add helper to report invalid opcode
1be5d3ef5976 nvmet: remove extra variable in id-ns handler
214bffc29d79 nvmet: make nvmet_find_namespace() req based
617e7b18cc7e nvmet: return uniform error for invalid ns
275f63fa4ddb nvmet: set status to 0 in case for invalid nsid
#

# ./check tests/nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  19.845s  ...  28.439s
nvme/003 (test if we're sending keep-alives to a discovery controller)
[passed]
    runtime    ...  10.131s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.595s  ...  1.704s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.078s  ...  0.112s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.073s  ...  0.073s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.619s  ...  1.707s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime    ...  1.663s
nvme/010 (run data verification fio job on NVMeOF block device-backed
ns) [passed]
    runtime  24.800s  ...  26.836s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  262.535s  ...  284.324s
nvme/012 (run mkfs and data verification fio job on NVMeOF block
device-backed ns) [passed]
    runtime  46.843s  ...  45.088s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
ns) [passed]
    runtime  280.317s  ...  324.476s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.985s  ...  21.937s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  22.981s  ...  22.106s
nvme/016 (create/delete many NVMeOF block device-backed ns and test
discovery) [passed]
    runtime  15.777s  ...  16.286s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  15.995s  ...  16.244s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.650s  ...  1.664s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.677s  ...  1.726s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.660s  ...  1.668s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.652s  ...  1.669s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.087s  ...  2.098s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.697s  ...  1.735s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.794s  ...  1.682s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.658s  ...  1.655s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.651s  ...  1.694s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.654s  ...  1.763s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.659s  ...  1.654s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.007s  ...  2.051s
nvme/030 (ensure the discovery generation counter is updated
appropriately) [passed]
    runtime  0.321s  ...  0.316s
nvme/031 (test deletion of NVMeOF controllers immediately after setup)
[passed]
    runtime  5.528s  ...  5.587s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.046s  ...  0.044s

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
