Return-Path: <SRS0=MKex=KZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED13C47091
	for <linux-nvme@archiver.kernel.org>; Sun, 30 May 2021 07:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613EF610A0
	for <linux-nvme@archiver.kernel.org>; Sun, 30 May 2021 07:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613EF610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=T0pCaElaa8tQSAQFjpOVDzF8oI3t9ordyUqaCsrdYgU=; b=BcCTqhvgoWwc1P
	3VJFLnp58YwySX9zDJlyX/WYQAtZpCa6gFTUoZViEuXCln6bNut7tMqT6pr/fPnWof09swojHWwUZ
	7PqA8Hr6UYvJ1JnWAtmGgAuyvrZQfstgU56R162RYq79K34krev6tTtlpJqY0Ot1MAnFpsd3xr2G6
	mybwDpEcH9N2QFkWhU4l4cnwm5+ENwW6ZIXCp8vDWeL0fhpakvE3zyrZruz+KQSHrviX8Fu5LsiGY
	vES7g7HAnK30Z1slpGd6Z1gRPOkM2wuPMxwqF5DJ/H+1lgItBdYgGkpKdrNSHFURKP42/rZUnIJNs
	dZR0s0NgTsEFGRJ/rlOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnFx5-009Cf7-Vh; Sun, 30 May 2021 07:33:40 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnFwz-009Cdd-AR
 for linux-nvme@lists.infradead.org; Sun, 30 May 2021 07:33:35 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14U7QUBD015910; Sun, 30 May 2021 00:33:21 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by mx0b-0016f401.pphosted.com with ESMTP id 38un4qhsg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 May 2021 00:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anD9yUxQ8OxaAUu8C4BIcwO98wg76FWK6+NGwQgpn16gnvGUVE0XIQkgQWFWXXx/a3ls4pOB43WvAYpdXDwOvx7bOF7jpG0+vUTpkmdfe7uxtJSU2L/9EBjVOAvJ46k+S5PqSJ65fXG5T2EJoOZ5wxCH6Dx3I4EdqMiHMfWzUWwoS7nu133+rjaOrunA7QVfn/StYll5hbY9GuC/50EOJazRwNDZapsIDsQpQPA0k1Cd9KohJf0jcxHWivh7hZdqEmTfLhzMrP8Ik6EWXMEZam9IoPIMAEjG7tCmFNiBzNsbDJQXrgdoM3Ly5BHLLBZDoESlqkx4xl1tF5+PYXO5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVEoPI/WsCbXzR7xqfl93jxa3pAM23jj3aicAhqU7IA=;
 b=FDOwmbty1j+fXWwc3/RtoTE9mkgWM5aQc3puekzPATssDAXSPowPMsjY/WpRcFglU3pQBfthKP40Rs5SqQDzs4VPVGdi0TcnAfy2o/oEPAZKN3cIX/rPrGEgNuO3FyFUqnz+B2B4fDlKM+xy5WS5jK9jJqGasdS101xffPJCjde4hDsTZZa1548voLzmRJ1ZBtX3cAG5X6QMEarzfEwFfx6lhc1XrWWYDleyYzXBqWlS6PrpAKIHVsup5Deg9Emig0l11r3lb0i9EfWHj0l6L7iwoqClY2Msuh7Bir4K+6RDSfbbImcOvgwDKdh5rt2xdaZy9WngSVZ8QITY8ETcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVEoPI/WsCbXzR7xqfl93jxa3pAM23jj3aicAhqU7IA=;
 b=HcHELJgnV25/V0qFRGn/WKgUhqvrQSmSIOwF4/PcUDGsn/nRptayQ3NWy6aV4VYimvybi+9oYfHTa4wwzcLQKmsOW45EPtwNYnNarnM0dZVTKaBeHJZYYxZHkvLS5dXnTqZxtrLIUBnk1jyV65fMPTst7POM6TA3nDodRT76BzQ=
Received: from CH0PR18MB4129.namprd18.prod.outlook.com (2603:10b6:610:e0::12)
 by CH2PR18MB3301.namprd18.prod.outlook.com (2603:10b6:610:2c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Sun, 30 May
 2021 07:33:18 +0000
Received: from CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::fc54:cd07:ec07:4e77]) by CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::fc54:cd07:ec07:4e77%6]) with mapi id 15.20.4173.029; Sun, 30 May 2021
 07:33:18 +0000
From: Michal Kalderon <mkalderon@marvell.com>
To: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Shai
 Malin <smalin@marvell.com>, Ariel Elior <aelior@marvell.com>
Subject: BUG: scheduling while atomic when nvmet_rdma_queue_response fails in
 posting a request
Thread-Topic: BUG: scheduling while atomic when nvmet_rdma_queue_response
 fails in posting a request
Thread-Index: AddVJduDAzSsasp/Srq8m1sJiLA/Sw==
Date: Sun, 30 May 2021 07:33:18 +0000
Message-ID: <CH0PR18MB4129247C2B9AE092E3C59740A1209@CH0PR18MB4129.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.32.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31ea0f3d-6153-4870-b22f-08d9233d31a9
x-ms-traffictypediagnostic: CH2PR18MB3301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB3301EDAD24D185A782BCEF09A1209@CH2PR18MB3301.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: flOZm5lHWUn+CHRv3zJ501ymIOQLWY5yoCkg2h3HXWt9ByJheAifOXpTVDC28jKwIBfrt+nTWgV8yFdURvk/4b9hCKsy4xS08+0qd72pz+YzEARu3e7YzQLeRsKMDjOD2hjQfxJG/snZfAeKp1YtzvDfPQii8v2xRFsMKbkqUVpGqv2Z8aNdr9yOduOsrntsX9vJ7Rp2juHCkpbpqdHAim+DidncqjmjJ6uMe5DLQKJ8l0ix+rTOQjhE2SPcby7YOc+5ckAXggqvlIbW5Xwg/EYs5tkCt4rfjVoK60MSOcMXjG90vcTHYGOAsfc5RSSF7FUZMG5meDdx6UylADzdjj3vLSmIpO8aHExFpgoeDkUX9N8Mz2XdJ6eXqf46AeKRHCUDRUblxDwemJhK1yqd68lCitozt6TGTs6OK3LydqvJ7bci685xYUPjfp/6hQOrJWiYsgOyVZCwkqvEzYmS6FIh38rC5zIPsBm1UKVFbjSY/2K+7FaXWF7X6iGSOAHh1JKYVmGvtivoJ+ADMaBjU5JwjTCPhNRf5lMai1hozBn9VjwfVxyVTeWXEkZIe8NdjzScNE3aXuVUpyXjIrOdA282ES1GWP3HBNdnabP5w3U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR18MB4129.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39850400004)(186003)(4326008)(6506007)(5660300002)(9686003)(55016002)(76116006)(66476007)(26005)(478600001)(66556008)(33656002)(64756008)(83380400001)(45080400002)(66446008)(2906002)(66946007)(107886003)(8936002)(8676002)(316002)(52536014)(38100700002)(86362001)(71200400001)(122000001)(7696005)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ek8dI4PRBbTj4/nyK7FOJkbfifJC41esxQh+7c55I9Lwwsueku5w1v+ioU?=
 =?iso-8859-1?Q?vAL6usOhYkbLsNN+Od8tDaQQnDlsM2PNrKODPHZ4bsBETVbfPL2qQphId3?=
 =?iso-8859-1?Q?lecQr2J979Un/9b2GbxHWjMSZxXHuVQw00LatidFFE+Yi/4usDaETV2nPm?=
 =?iso-8859-1?Q?WEiq1B8HwdrSBoJERz6hvFNXurNv+c1qiRxOWwTnHXwFaFAPjXE8KJ7S7b?=
 =?iso-8859-1?Q?OGG8tIbUK+5BeihvA3id+twaLuqX5OmKHJsrOIkz8yRzq/SHTLt4vVu3Y+?=
 =?iso-8859-1?Q?faXk/iTJg7QsTF8AbYeeUNyPsf5KR1dnYiB/0utVYxGLzq81x6JQbb+pdY?=
 =?iso-8859-1?Q?MiM9f0fH9H7GfRUNoRZYfdbqBl0zwdegI02bX1ZC0Dls/rH1jGSRz/jMLa?=
 =?iso-8859-1?Q?SLwoiTXpxj6m3KgwXTYUjSckAdtmUaIGC8ApY/stfqmRReyWUBzM7eCjXk?=
 =?iso-8859-1?Q?rr7vUL9VhJY6Ft9Vpac8bh8M1lh1fmk45qeU/c1idq/z4EolFI36Xyjqrr?=
 =?iso-8859-1?Q?ZjQtAQoNDlmfV8WcHOwpAIXPbR5qdIxEUX5hh4+apm8FUXYuWdNMQz18TF?=
 =?iso-8859-1?Q?HbCb2kcwMf0wU15fEeW+GRmggy+f1xuRFEapK3P8nmBT3mPj0JsU0fNuV9?=
 =?iso-8859-1?Q?dWX1rQdLJPmrmLhkxQe+pdOt4p3vx5qQxbNOY0/PqvxAr/lG2FlDYMgspC?=
 =?iso-8859-1?Q?KFlt1jeVzCVD2daqXsvi79RxYsGiix4s9mpSdluh+PMbg/3q8mpNtdTlFq?=
 =?iso-8859-1?Q?ZQFtOj6EzLzo3QXHghM697yHKOdM9Kt3BcZvhd4w4hbO/cgweMcAg1p1PF?=
 =?iso-8859-1?Q?wDj2CdqpsVk577OP4Q3GpYEbJtskACBY957pqb7YHe7XqD1d8s07y0xMj/?=
 =?iso-8859-1?Q?95c0YMEFCjVUCHEtoWH+y/Yi+gRabapTO8buiposvZmOMy3uXbI6VOW40r?=
 =?iso-8859-1?Q?Xr5swhv5AwpLacRL1jcxiwPREkL/ArWbSjujTCzGnRS+e6w8JMk9Zu0KvE?=
 =?iso-8859-1?Q?aNwBJZ0zH30L/jsfIYeBhVCcTx8J2W3sTRD3MP0Nk8GF/MPGK1dX+mx/ya?=
 =?iso-8859-1?Q?4AywZ7TteY0NTobERfTRAf5hGR82SQl3a2mYmo6/SZ/b4pgKfhoqJX1pQc?=
 =?iso-8859-1?Q?U1MpdjmcjOlsn4zTmZvUsDvGSuiN/P/LXkyFJ4O+hdA9D7+dp0hiFNMnVG?=
 =?iso-8859-1?Q?lvC9uVYTnsHEFxrO4D5twF6r4Ht7kI912yq9quKWthNvXzvGzCH/oOqkZT?=
 =?iso-8859-1?Q?V1k6apxG9rl+Fm3QkQ1J703myGmYjvbyN4tQlobAHZT8aTzz6hAkoilQOn?=
 =?iso-8859-1?Q?qkhNgY32TGb52oeOA14FTR7c1azjcQI8YHm4S6nj5xbuHXh2b1vTXyaT6f?=
 =?iso-8859-1?Q?BisUJEkHUz?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4129.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ea0f3d-6153-4870-b22f-08d9233d31a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2021 07:33:18.0836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNwU3vSw7eboF290yGPxQEG3fEXOwTSjJuCA0CMGbOojovsyqq9JysmsiD8flmBspB6OTercVV04xwc7Ep3TCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3301
X-Proofpoint-ORIG-GUID: -ebTnPLYanaVWGEsgqsDguw4M5TjGoNq
X-Proofpoint-GUID: -ebTnPLYanaVWGEsgqsDguw4M5TjGoNq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-30_03:2021-05-27,
 2021-05-30 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210530_003333_570649_AF5DAE40 
X-CRM114-Status: GOOD (  10.41  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph, Sagi, =


We're testing some device error recovery scenarios and hit the following BU=
G, stack trace below. =

In the error scenario, nvmet_rdma_queue_response receives an error from the=
 device when trying to post a wr, =


this leads to nvmet_rdma_release_rsp being called from softirq eventually
reaching the blk_mq_delay_run_hw_queue which tries to schedule in softirq. =
(full stack below)

could you please advise what the correct solution should be in this case ? =


thanks,
Michal

[ 8790.082863] nvmet_rdma: post_recv cmd failed
[ 8790.083484] nvmet_rdma: sending cmd response failed
[ 8790.084131] ------------[ cut here ]------------
[ 8790.084140] WARNING: CPU: 7 PID: 46 at block/blk-mq.c:1422 __blk_mq_run_=
hw_queue+0xb7/0x100
[ 8790.084619] Modules linked in: null_blk nvmet_rdma nvmet nvme_rdma nvme_=
fabrics nvme_core netconsole qedr(OE) qede(OE) qed(OE) rpcsec_gss_krb5 auth=
_rpcgss nfsv4 dns_resolver nfs lockd grace fscache xt_CHECKSUM nft_chain_na=
t xt_MASQUERADE nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 libcrc32c nft_counter nft_compat tun bridge stp llc nf_tables nfnetlink=
 ib_isert iscsi_target_mod ib_srpt target_core_mod ib_srp scsi_transport_sr=
p ib_ipoib ib_umad rpcrdma rdma_ucm ib_iser rdma_cm iw_cm intel_rapl_msr in=
tel_rapl_common ib_cm sb_edac libiscsi scsi_transport_iscsi kvm_intel kvm i=
rqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sunrpc rapl ib_u=
verbs ib_core cirrus drm_kms_helper drm virtio_balloon i2c_piix4 pcspkr crc=
32c_intel virtio_net serio_raw net_failover failover floppy crc8 ata_generi=
c pata_acpi qemu_fw_cfg [last unloaded: qedr]
[ 8790.084748] CPU: 7 PID: 46 Comm: ksoftirqd/7 Tainted: G=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 OE=A0=A0=A0=A0 5.8.10 #1
[ 8790.084749] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
[ 8790.084752] RIP: 0010:__blk_mq_run_hw_queue+0xb7/0x100
[ 8790.084753] Code: 00 48 89 ef e8 ea 34 c8 ff 48 89 df 41 89 c4 e8 1f 7f =
00 00 f6 83 a8 00 00 00 20 74 b1 41 f7 c4 fe ff ff ff 74 b7 0f 0b eb b3 <0f=
> 0b eb 86 48 83 bf 98 00 00 00 00 48 c7 c0 df 81 3f 82 48 c7 c2
[ 8790.084754] RSP: 0018:ffffc9000020ba60 EFLAGS: 00010206
[ 8790.084755] RAX: 0000000000000100 RBX: ffff88809fe8c400 RCX: 00000000fff=
fffff
[ 8790.084756] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88809fe=
8c400
[ 8790.084756] RBP: ffff888137b81a50 R08: ffffffffffffffff R09: 00000000000=
00020
[ 8790.084757] R10: 0000000000000001 R11: ffff8881365d4968 R12: 00000000000=
00000
[ 8790.084758] R13: ffff888137b81a40 R14: ffff88811e2b9e80 R15: ffff8880b3d=
964f0
[ 8790.084759] FS:=A0 0000000000000000(0000) GS:ffff88813bbc0000(0000) knlG=
S:0000000000000000
[ 8790.084759] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8790.084760] CR2: 000055ca53900da8 CR3: 000000012b83e006 CR4: 00000000003=
60ee0
[ 8790.084763] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 8790.084763] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 8790.084764] Call Trace:
[ 8790.084767]=A0 __blk_mq_delay_run_hw_queue+0x140/0x160
[ 8790.084768]=A0 blk_mq_get_tag+0x1d1/0x270
[ 8790.084771]=A0 ? finish_wait+0x80/0x80
[ 8790.084773]=A0 __blk_mq_alloc_request+0xb1/0x100
[ 8790.084774]=A0 blk_mq_make_request+0x144/0x5d0
[ 8790.084778]=A0 generic_make_request+0x2db/0x340
[ 8790.084779]=A0 ? bvec_alloc+0x82/0xe0
[ 8790.084781]=A0 submit_bio+0x43/0x160
[ 8790.084781]=A0 ? bio_add_page+0x39/0x90
[ 8790.084794]=A0 nvmet_bdev_execute_rw+0x28c/0x360 [nvmet]
[ 8790.084800]=A0 nvmet_rdma_execute_command+0x72/0x110 [nvmet_rdma]
[ 8790.084802]=A0 nvmet_rdma_release_rsp+0xc1/0x1e0 [nvmet_rdma]
[ 8790.084804]=A0 nvmet_rdma_queue_response.cold.63+0x14/0x19 [nvmet_rdma]
[ 8790.084806]=A0 nvmet_req_complete+0x11/0x40 [nvmet]
[ 8790.084809]=A0 nvmet_bio_done+0x27/0x100 [nvmet]
[ 8790.084811]=A0 blk_update_request+0x23e/0x3b0
[ 8790.084812]=A0 blk_mq_end_request+0x1a/0x120
[ 8790.084814]=A0 blk_done_softirq+0xa1/0xd0
[ 8790.084818]=A0 __do_softirq+0xe4/0x2f8
[ 8790.084821]=A0 ? sort_range+0x20/0x20
[ 8790.084824]=A0 run_ksoftirqd+0x26/0x40
[ 8790.084825]=A0 smpboot_thread_fn+0xc5/0x160
[ 8790.084827]=A0 kthread+0x116/0x130
[ 8790.084828]=A0 ? kthread_park+0x80/0x80
[ 8790.084832]=A0 ret_from_fork+0x22/0x30
[ 8790.084833] ---[ end trace 16ec813ee3f82b56 ]---
[ 8790.085314] BUG: scheduling while atomic: ksoftirqd/7/46/0x00000100


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
