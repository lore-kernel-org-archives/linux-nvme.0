Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC383C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 22:36:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2527820732
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 22:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2X0KgFSb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p4BdpPfb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Qi6iRlaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2527820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=CFdtnUlhTn6xXDZ4Sx9ag+fZioz7V3JoQ1JrvKTYM5Q=; b=2X0KgFSbPDvTlXb0n2eI4TJXa
	P04nM+QoRXuyIImcA6TXKszTApzlzSoXVmgFy21xP57DUggucx9IEwMqyfBczfE/+CZ4BsxmkhpFI
	qOfNm/dKj4pR7FrR9to/ruofECZdywFhB8GRSYMKhqBjcyfH0siC2rM0kwZ2/INq35NYtHeuclSKO
	1Z82LpUMHMJK7SD97OH5lBd+EseAs8JTxu7GlFfAGUJN+otNqV7TThw+Bi1ftHUJshfNLTPS85dAp
	/k06COb2zTppTL5yr33zqoXJmE9MVPjua38Mlf4JQmH3uyhBtF4uW83GXoaGa/0ATaHHHJi1ijTFE
	UZ2P3YG9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIg20-0001Ki-4P; Wed, 16 Sep 2020 22:36:04 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIg1x-0001KE-FE
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 22:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600295761; x=1631831761;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=91CzyDFLuMJLRWsZfy0YLMP6z+Ln5H3z3WZlh6btBoA=;
 b=p4BdpPfbqnElXK/Ly3kdr1gtupuqvL7fT/r5XxRuQSPnVEjrN5LNH7JM
 rdEW4rDFtSu2Nc7zJEmJEptHMrmNlxSf3IsjffaixAue99V6gM7fkoHJM
 LqshisQ33rErXABBSY64n7yfM4Ebd5aPDsDDTmhtyIHMEli+LskJ7w4Fm
 vmeb5oRMMvBb8qSoo0BAKoQ2L9E3TJPt3dbO3r6a0aprgBLbPhGtZWxAP
 jVsrtGGba51jMyMTuqsXF0nwrpFuerUAdUL5ft4SbSPpIH6E4p1vPgsOI
 zDJ8wGKauSiN3JEDPLxVZdrJVUlhWbdv8gB4VZWMqV9GXs8ltGo3S3EOK A==;
IronPort-SDR: VgQsiiJzjavLwxqKJVTj/liX4RhARkAV5tvrlF05X+YN1X1+8eUrE4JECr8NjVrdK8ZniscUsw
 z/vYSO76TP3MF4w+PTIZiQvOMegeBUTcG/MNXQWj6F4t+wKNhUy8wdOpcypf3p7TjgrhbsapEx
 by5Eliqhgnpf2Fx7HiLDZ2Is1nRtj3B5GljPKZi1X97+SYvxkjZJCSN0Wenc29zR6RZGZONgpY
 j+zC1WhK0DwoWu85J9Wz5MIgAO8sO553dSw332OOA7CIvFAcNfgMyqqfqTKmv10KVIWAk2kGrX
 sxU=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="147488074"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 06:35:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQp0ohVvwPkIQ3hhgI6Dtk79Qjt2BesnWMqQ9B3VaU3/wpsaFd0ms1w/+JyjOdyH10ZlYonzTUJL8/LfAZirJJywyzcU2AB36DdPE3DHJ3VVCLZxjHsjUTs5dcx8qELsowntZSSiB0AoEXdX2pRIt6ZoXntVxQmjdNVC1fkJYlLbfrLmGXMeNrOiSQJbafGx3tQAjvjwUqkvTQUiWYEqI/dr9ew/qTEgkkCyszchc3m0xwZjPF9Sa2h3rgo/VhbYfFxxI/R++RZTRNbW/+RDVGY9MgNp9mQkdKvdUVxh/rKaRX9wd1qbeSnFUhrSfdrrKOSTWrc8cT5g4az0niOpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGbFOXzRhfB0jrP7L7yfCM9JwsWNgfDvAFYg1nqYoVo=;
 b=nme5tSFuSkg7oayQbfy2Jlc121KNtTJ3iPPCEfpLLLxkv/njYOqVhddsPvn2BA4jCombvxGZvJlmTHc/NxKmne4VbptDGqiHdsgWfu2W0gtXs7Uq1H2ZSKSQe2g8cVSho9IT21F+DMBqitIx3T481u7QobWmCuNSCk9rzxFM8QvGU5Smm06bdXFa/eUtbO5gDMbq0eZ501DaStxCRY83fBh0KSjG4l7oJj7MYn843ufiZX+ND06LrkGt15T+aTsFebSBI2lTflodkPcPMQEVnmhA6NdAlDMHIBTRcZ9QbhpU8tx2gVf5xaQfMZNN96A5wAphZc+Fm94u7Q9eVOcALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGbFOXzRhfB0jrP7L7yfCM9JwsWNgfDvAFYg1nqYoVo=;
 b=Qi6iRlaDTcT6XyCyy5uNpZhMTdZwCoZoabLEVg71iN8fR0NbbZlgtvM3o3i0yoItFI3JvqxkDhsaKIoKhY38e5+sMnDX+zqso8HqYP9Qf7dxIgXkAu1Y/eu2bftiiy/ybtaujrvETFEXyadBfCJcGxQdTyyv+a4erXCVbY55gIs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4663.namprd04.prod.outlook.com (2603:10b6:a03:58::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 22:35:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 22:35:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 5/7] nvmet: add passthru admin timeout value attr
Thread-Topic: [PATCH V3 5/7] nvmet: add passthru admin timeout value attr
Thread-Index: AQHWi6pxd3K3tLAyyEmD8ahiGRI/nA==
Date: Wed, 16 Sep 2020 22:35:57 +0000
Message-ID: <BYAPR04MB4965148920CA649C99C0C55C86210@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
 <20200915215118.3934-6-chaitanya.kulkarni@wdc.com>
 <20200916071221.GB9592@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9f17b56-2a75-4234-2a10-08d85a90e184
x-ms-traffictypediagnostic: BYAPR04MB4663:
x-microsoft-antispam-prvs: <BYAPR04MB4663EE5BFDEE0FA82D24978886210@BYAPR04MB4663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOJz4suo+/V9fMUy69vqN1j9RfdeujOQI0oB1C7p+QZeMSoYhjV09IQQMIKE+8qvWGyXd1U+s2NUpvneEPMrtWwdn9j81IV3imTIistvPd2Ae1z4ANMhHU7IDJ9Plh+vXaRldhHPg7GPCrq4cYD2mQkf65V7elvwtejAeLk/gsSeC5qzARHcz2tZYdfv1RUG+EtkHroscvi8TafITv4kS2lN9eYr5UwnZKK+lBBG2WmMagSKKZxo5yUBqU7S0LF50qYGJXIbqqWTRUwnTGaG/r9YvnJlDJ/OAOFImto62G2mjpM/8ctDzX5C315HsDDiCWHWBQLssUnhHGI6KLBaAUvMAFLAg8/w0WoHdnU7rAmwvMwivk6ooaMMFI/5jt7q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(6506007)(8936002)(2906002)(52536014)(55016002)(71200400001)(9686003)(76116006)(186003)(86362001)(26005)(33656002)(478600001)(83380400001)(53546011)(4326008)(66476007)(6916009)(316002)(54906003)(66556008)(7696005)(64756008)(5660300002)(66946007)(66446008)(8676002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: NN/Bs50N2FNCabxLhkNbV6q0nIqVy9YGfHs4JGIJF2LP9ptK4eGc9Q1Ray+CRQ06i3k+g1yij9tRfgokNOyE1JP5oE8AdMH8T9GM/6pRI2KmQGVFf2Q5HqZ6YJYJNj/Lbt421zC/D7lDkyQHQYlIEOhUSjMi6E6HBJLJoMT49uBaCzj59SGg3Xc17XT60DZDn+DH0XU6H1b4Yu/lIfBypCsdf+aHa4ZrnqDzakuu0Q57SPkwYBRmSTuYqjMjp+AEmefDzMbYZU8j7gENZsTf5+6mkA9FqKVLBdlx5pgyXZgkx2Suy6OQSi9TAPraBZmEWqSQ+oxZ4iZb1en5xI/BFgHq/WcwIeoD27+MEVJY27zXsBD3UUZoKJ0LbZW4wl3FvjF+C4DPmsftH6uzCw75wdLAhGeCjRiUH1S87tYtp7cwLxPaY2CCURo0mVJjMJMAYM+wgzJ4rFKmAwOWFH4BycMlmNLlDzQwO8+naNOgrhIGlbwmeif4FceCV9vUkkRm6Knjr0F4DRBBtRloDWULChsI0fSkmYWgVwlZpHwACP9cir2buxrOSVIjr9OOqcdAeOoamCVzE5LBZ7MFyh6JnAOTEvreurAdwsO8s9aPYAdJbFCPOazTS2zCRk9Y3KkRXNT61FmfrhSd2srd4E7bkg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f17b56-2a75-4234-2a10-08d85a90e184
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 22:35:57.7291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCFkSknE5RidrD/MitDuC1RuxMbp0Ps1wMQWbNZEi9JGaGUVHTJ+6aszhNvP5n6+q63tlqZtQDLVodvtw11M3ajrVLe278PEybgWN9CQwko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_183601_640308_EB9DA963 
X-CRM114-Status: GOOD (  17.96  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/16/20 00:12, Christoph Hellwig wrote:
> On Tue, Sep 15, 2020 at 02:51:16PM -0700, Chaitanya Kulkarni wrote:
>> NVMeOF controller in the passsthru mode is capable of handling wide set
>> of admin commands including Vender unique passhtru admin comands (VUAC).
> VUAC sounds like someone is throwing up and certainly is not NVMe
> terminology.   I also don't think we should care about stange verndor
> specific commands.  If we want to communicate command timeout we need

VUCs are Vendor unique NVMe commands. Given that passthru allows the 
wider range of feature and command sets it also needs to handle timeout
for VUCs to avoid getting stuck on over the fabrics.

> to add them to the command supported and effects log, similar to what
> SCSI does in REPORT SUPPORTED OPERATION CODES.
> 
I'm usually against polluting the configfs space.

If I understand correctly you are saying that user should read the 
command effects log and set the timeout per command for the
Passthru mode ?

Here is the detailed scenario :-

1. Vendor A has nvme-xxx admin cmd and nvme-yyy io cmd.
2. The command effects log page has timeout values for these VUCs.
    This value for VUC is larger than the default timeout values
    when the driver is loaded since these are not frequent commands
    e.g. flash-mgmt/Device RMA.
    User still wants to use the driver default timeout values but
    need an ability to override these values time to time on target
    side.
3. On the host side user reads the cmd-effect log and issues the
    passthru cmd ADMIN/IO IOCTL with timeout values from nvme-cli on
    NVMeOF target passthru controller.
4. Timeout value is applied on host side request in the driver :-
     nvme_handle_ctrl_ioctl()
     -NVME_IOCTL_ADMIN_CMD
     --nvme_user_cmd()
     ---nvme_submit_user_cmd()
     ----nvme_execute_passthru_rq()
     -----blk_execute_rq()

5. Now the target side we don't get the timeout value so it uses
    default admin timeout (ADMIN_TIMEOUT, given that we use the newly
    added nvme_default_timeout() helper) which is smaller than the
    timeout specified on the host side.
6. The target side request times out while host side request is
    intact due to default values used for pt-ctrl.

any thoughts ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
