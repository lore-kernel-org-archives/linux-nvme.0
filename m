Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C97C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 08:11:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EEE21744
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 08:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pLmRshgH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LLut/x+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EEE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n9iysJHurJ5RAB0dZqiJT+FQesMXgXkzLVbCB3kDRjo=; b=pLmRshgHNYHrlmWtcMPlCqw6a
	0EJhpCrjsWywAjZt0wdhg+IFVGzumbA4w6U/FbgiqtbekURbjv8o+OAi7r+uirl9/OqH7GHTwy9oz
	zDNL/+pb/Oy2LPznEpVESh+d1bJlLDa/IVIghUU6f3HKdh49l0hcYJWLHXEW1zTOM9ffXlHAZsdBV
	CjE6VuQKCX3lI1LKaywwCETwR5bB7ASuesYt192KT4tho4kHrWmoiTuxyIy1Q5eSg1oyVob2CopUH
	v5eGWSlmtxhKxZc0oMOtat1iwhTpdcDnW1XXFFtc4twz2rPq35dmDzihTNOiTs/ioNapm9xe4mxTj
	E4416BpHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8ffu-0006dA-9X; Thu, 20 Aug 2020 08:11:54 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8ffp-0006ca-Rq
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 08:11:50 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f3e30350000>; Thu, 20 Aug 2020 01:11:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Aug 2020 01:11:46 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Aug 2020 01:11:46 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Aug
 2020 08:11:46 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 20 Aug 2020 08:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSeGQwv1i+U+c+2qqk/yAIU0G0cjRAo4GkJyM998Q4iTuFmoGFT/fC+zInXMXIv6YBTX1WM41wJTs4yehZquSCFzVcsXFhr9k062jgqK4rVJuuzojYoVTLc8Z3ZG7QAekbooFa3SOOXpTZMRl2y0nB0Ob/gPnLRfZVSX5fFEwI2Q6EXt9RtR4d+r6UxKSWNLGiVsjZy8yA+mHlqjChPYUtBCbXEZ1ynAip8JQsPn8LE8jlyQySC9HcxhS6OQ35pndZUVPdxw2/Gf9Kf4+DohBDHrBwqMp0hRDDaQ8IuPzKbd0H0ICW6BPoRjJEpN/37KRwEoES2xAJzF7KogZKCt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylhnEySQ49XautZPlRy8V2hjfjGYXW0wGBUVL5KC1uE=;
 b=LWfdQ5ozetK90v7LW0IrZ8r55xADZWBql5EpX0TRazTIXGv98blaTKeRN+ZCa67jVs8DIWS28TrhLldyP0t6Ij8RWKp08jl7ZiWUUK76ZkQm9Iu/eUp1+TE+bKca2GV5K/qesusYHC0nPtKz3K8/wBsBIPImMaajePcle8cOwHQnE4PPQPJfzX/ZAUGc+Jv8jQft1sjC1URFGhCU4+cFPCm9u+g6EZTIXNQepk/XV640cshsQVWFEhsJIvDvFDmrYc4T93WqG4IutwNIGSKiahwVo9VWa52GDdLhLXCmFokWZ7myCeNmvorTpc89ejN2Tb3qJB/yjDjps8e9Ok0NFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10)
 by MWHPR1201MB0239.namprd12.prod.outlook.com (2603:10b6:301:50::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 08:11:45 +0000
Received: from MW3PR12MB4412.namprd12.prod.outlook.com
 ([fe80::51a:ff4b:25b7:1c2c]) by MW3PR12MB4412.namprd12.prod.outlook.com
 ([fe80::51a:ff4b:25b7:1c2c%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 08:11:45 +0000
From: Yamin Friedman <yaminf@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: regression with "nvme-rdma: use new shared CQ mechanism" from
 v5.9-rc1
Thread-Topic: regression with "nvme-rdma: use new shared CQ mechanism" from
 v5.9-rc1
Thread-Index: pZSrAssP8UpjJvu5K5fy3epZLAA1rIOXjX5w
Date: Thu, 20 Aug 2020 08:11:45 +0000
Message-ID: <MW3PR12MB4412BEF6AC5D375965A35BD0BC5A0@MW3PR12MB4412.namprd12.prod.outlook.com>
References: <934717176.38045698.1597765603125.JavaMail.zimbra@redhat.com>
 <1476432272.38046616.1597766884817.JavaMail.zimbra@redhat.com>
In-Reply-To: <1476432272.38046616.1597766884817.JavaMail.zimbra@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [93.173.239.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd9fa1b9-5dde-485a-f878-08d844e0adfd
x-ms-traffictypediagnostic: MWHPR1201MB0239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB023922348E82912FF96EDA16BC5A0@MWHPR1201MB0239.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X8k+niCzfYYeXPQYF0eE9emdl583B1rc2VdxdZQO1Q6lb/Q3S9ewdf4ZLL3jB9Jw7Qw5SDbvj6Fp+wk+QZYvTUUZUhSQzwhjO6xXGmIqAYMDKInlhbdgfzlFV0SkKc2pe659KW9aIFPHcL+igxhnKprpLqnk1nmBJYs+YOs3i57lCM+BdD15NthuGfsHkQnjuey1zeKXiiJIKD2Jw2RQNHTkkk5aEiErC8JVK77ROdimFBVvTQXhn/9sXhHJT8fwc2ChVZCQXSjqMKVPnMGoYJ/xFOG3rs/myH/Q3mNuR2ataO5TLGr/ccoJlmCn7YIhVfNhrBPXtJsgX8WzVCOyiAK2v3lIGLQaNhoNQkgY5U2d6vLcJVhDzZsXvb0oUlBfcIEvMcN4emLKK1+xWxg9hQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(966005)(33656002)(186003)(55016002)(4326008)(53546011)(6506007)(316002)(52536014)(66556008)(76116006)(64756008)(54906003)(110136005)(86362001)(9686003)(26005)(66446008)(66946007)(66476007)(8936002)(5660300002)(8676002)(2906002)(45080400002)(6636002)(83380400001)(71200400001)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tuTMErLd0cgETT3vv0ix1GgcR4OmPgAr3jSN9JwzHheRe4Psz6BbdGtUilcCvQLSVVUX/efaLJQMIlgNYvK6sh0YydDwn2ZJGGlzl8O74YU+YtHPpB252qK3X6gari5E0EPZsz3gbRkGT+PycrDoTGJQA/Ub/pC+81tUHzooxBhAYYI0SqfQlYyTXlmBen/Wd8EGeioNMrgbjV+fG4bnLUh0dOzGA9UrDsxURVItyl6BW6QXACDdKU61tuBvXdbUaG+RdqvywMB+n9jt5ZmgLTf6yxh0CkpgpZbZZ3Zq19o5GE23VYdvrkIjDJsvdg5Gl7sG9Ej3fdkaDT1kTHBJVPQfrtW/okwD6yttFfZr5xrZ2C2tMbEV2NoYb8KcdDqc0JQsmyCtZ9lm6Nt1Y1hrUhgHSDuzFAj5ghqy7vHd/JY1O4Ty7/nVoEtwgybfeYUdt86lSZpuotWcoeup68+q0qtkMD/TowyZbzpc9Vr2biht0kIrA02nrCsl8M5gnqnuxNRIRX154GKaKKy1sXI+HiMoNNix6s8LrNivjey+fqRdOTIZt3fg2UyKqpOR+D65BSg6vItkjDiaYrU8prV4Y75DaDdK852NiaahkUBWtNQPx4UEwnGJKJMThtczziIyRwdknvEonygPAJEgxpIZbQ==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9fa1b9-5dde-485a-f878-08d844e0adfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 08:11:45.3389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHXPC6oqcUZruVL4Ur/SobyBXO6Sydr5YrapEpMqqt0q3wLY366K29ZemMSYrkCBTwqAABoSjJlCPTkI6uA1PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0239
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1597911093; bh=ylhnEySQ49XautZPlRy8V2hjfjGYXW0wGBUVL5KC1uE=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=LLut/x+9Nq1XQaAYISklnCserj0sjCYfNlbjwVk+GDpOvxNITlEpmMceI4o6IcYe4
 eg1OFd81PXFZN6cXRZdgqonWqT1dK1WbLVozG8OpM3+I57+pXolbSsM83mRxuLSgy2
 Kos9ifvz5yj0nVBukCFU/diL+5mytSFBl/QhjR0EYOrfD08Dspq8hXaga2MQUrzZZj
 TfDJJ3wKvt3wVf5PkeIi+jfvoQkNW6ZB7r9od19sfLg3efSpqd8yiWIAm0apxWf2M4
 nXFeEfPKeReUuvqSjaQ79zz2bYMAT/p2OfQiDeUD6lFgVL0WWK/1LgAoIsEfcSbUYf
 YwxEDCkgQzAkA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_041150_013414_AF370FA1 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: "yaminf@mellanox.com" <yaminf@mellanox.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey,

I am looking into the issue and adding MaxG to assist.

Thanks,

-Yamin


-----Original Message-----
From: Yi Zhang <yi.zhang@redhat.com> 
Sent: Tuesday, August 18, 2020 7:08 PM
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>; yaminf@mellanox.com; kbusch@kernel.org; hch@lst.de
Subject: regression with "nvme-rdma: use new shared CQ mechanism" from v5.9-rc1

External email: Use caution opening links or attachments


Hello

With Sagi's new blktests nvme rdma[1], I found one regresson that lead nvme/004 hang.
By bisecting, I found it was introduced from [2], could anyone help check this issue, thanks.

[1] https://nam03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmarc.info%2F%3Fl%3Dlinux-block%26m%3D159738590701657%26w%3D2&amp;data=02%7C01%7Cyaminf%40nvidia.com%7C81014ecff7834bf6380a08d843910c16%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637333637533835871&amp;sdata=YEPqQmeE36jJHfGSG7C%2B2HbNuCDK5SrJG3H3YLGpdPo%3D&amp;reserved=0
# nvme_trtype=rdma ./check nvme/004                      -------> hang and never finished
nvme/004 (test nvme and nvmet UUID NS descriptors)
    runtime  1.647s  ...

# ps aux | grep rdma_rxe
root        1657  0.0  0.0   8292  1632 pts/0    D+   11:54   0:00 modprobe -r rdma_rxe

# cat /proc/1657/stack
[<0>] disable_device+0xa2/0x130 [ib_core] [<0>] __ib_unregister_device+0x37/0xa0 [ib_core] [<0>] ib_unregister_driver+0x9d/0xd0 [ib_core] [<0>] rxe_module_exit+0x16/0x7d [rdma_rxe] [<0>] __do_sys_delete_module.constprop.0+0x170/0x2c0
[<0>] do_syscall_64+0x33/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

# dmesg
[  273.577444] run blktests nvme/004 at 2020-08-18 11:54:22 [  273.615610] rdma_rxe: loaded [  273.623675] infiniband rxe0: set active [  273.627962] infiniband rxe0: added eno1 [  273.639520] infiniband rxe1: set down [  273.643611] infiniband rxe1: added eno2 [  273.655617] infiniband rxe0: set down [  273.659713] infiniband rxe0: added eno3 [  273.673854] infiniband rxe0: set down [  273.677946] infiniband rxe0: added eno4 [  273.695954] infiniband rxe0: set active [  273.700236] infiniband rxe0: added enp130s0f0 [  273.717858] infiniband rxe0: set down [  273.721954] infiniband rxe0: added enp130s0f1 [  273.739460] lo speed is unknown, defaulting to 1000 [  273.744941] lo speed is unknown, defaulting to 1000 [  273.750413] lo speed is unknown, defaulting to 1000 [  273.757853] infiniband rxe0: set active [  273.762139] infiniband rxe0: added lo [  273.766229] lo speed is unknown, defaulting to 1000 [  273.771681] lo speed is unknown, defaulting to 1000 [  273.777135] lo speed is 
 unknown, defaulting to 1000 [  273.992958] loop: module loaded [  274.024550] nvmet: adding nsid 1 to subsystem blktests-subsystem-1 [  274.039541] nvmet_rdma: enabling port 0 (10.16.221.68:4420) [  274.066081] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e5372c18c860491bb18adb3b5b025a20.
[  274.081395] nvme nvme0: creating 32 I/O queues.
[  274.120241] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[  274.132037] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 10.16.221.68:4420 [  275.171715] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  275.311794] rdma_rxe: not configured on eno1 [  275.321210] rdma_rxe: not configured on eno2 [  275.333410] rdma_rxe: not configured on eno3 [  275.347527] rdma_rxe: not configured on eno4 [  275.362830] rdma_rxe: not configured on enp130s0f0 [  275.383157] rdma_rxe: not configured on enp130s0f1 [  275.406067] rdma_rxe: not configured on lo [  513.938222] infiniband rocep130s0f0: set active [  558.930867] infiniband rocep130s0f0: set active [  558.948955] infiniband rocep130s0f0: set active [  603.930414] infiniband rocep130s0f0: set active


[2]
ca0f1a8055be nvmet-rdma: use new shared CQ mechanism
287f329e3131 nvme-rdma: use new shared CQ mechanism

Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
