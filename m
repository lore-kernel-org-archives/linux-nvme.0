Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CEBC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 20:00:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01D5619B1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 20:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01D5619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rFxw6MNJX1EJUK28NLtd73SKOvkhluHEibmFSIvVwuk=; b=ECsTGtE4WZvd7Zy2qZXXyPHZR
	wMKDLVXXA+wlN6IIPVjrLFDspn+u9KtNoT2J0dpPRKuAnmxoRSmZg2mA2pea2PIg4ERHjZE9fQyV8
	Z2LONaNd6g2KBU1pPJYvf5KVr+z1gdCaeuTQ7MffvenIv7hmpbQ+GqBZINQ62jMeVsclvttjNIola
	WEkaQhA31K0AVI8jmLTmGnnisL7UoB+/hr8gHp74QHI2o1v9HAPIDrlrGP+P1YBS9GduEbQ9UqDYl
	CpcAlzQvqcGkp1HGceviZQnWqWbye2SUefeONjj83f3mOIA78TiypdccvPLolxQWaOd0wr5XGsXBC
	UvJm/ILzA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPsdN-004G27-Ny; Fri, 26 Mar 2021 20:00:41 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPsdG-004G1A-Oq
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 20:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616788835; x=1648324835;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=keJXvJ7shV9NvRdtR9MB/z6DKDC7P6IOlTZns0mhoHs=;
 b=U3K7bv2TXXghK7fe0L9R5zv5Pw/QSGDcrgH4W0Il6fXFZcejoTPdoV3s
 0BDpYD7b4Dongvmrfa5SqXJXHSzlOOuJGivmpxjhcfq6ApaKfubqF5B0D
 By9PH4riqX9fuvT0cMGZ32jRY1lu3dIg1gKJjc7tj8MJM5kbA11TTAWac
 z6WE7r6Gnbp9KcHkK6gV7MinCFQJ03/yu5U/9p0Be3IlTOLmVZ4121Ddw
 GeDq8qGEwwm3usPuzQhaLPuyDFIKIDvKBh7fErPslxC7qYvxx7Yq69njj
 lZD0hVFMKGQyBxKMdNSyVDjMSHe0brB8sj7G3JfIU6ZxWFtsMHVTQT3se w==;
IronPort-SDR: adM344tlMulK/QI/jMMj/Y50X9wwuUGFok8HYNn8MBFhmVrSWFDun+VB1N9B60KR/Tkg+1TbH5
 msxZT0AfkynW7PwgL6FaeWuXFAwVkdVWG1gOWv1cAJZpDcJGZT/94xtN8U+0FGS1Eh0S6THOSA
 b6Qt06SP4YaeXWcDk12Nfm49Ix5Hs66pfrLswwQTfrw6NVOWK7t73sPMOS42UcGYJdfHqmaNQ2
 uNYlaPeaz3CTMY6aQgLzecwwEvjJ0S2n+zAW8Ufyq3AjNpHetpuJb209B87EP9fdzU8bwOYP0U
 1QQ=
X-IronPort-AV: E=Sophos;i="5.81,281,1610380800"; d="scan'208";a="164207393"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2021 03:59:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY61BmS5L7cfUTvELzKBJGiCxrzVcTqR1DdygbiZgVADjgnDZlfQF+G25UMd/xkph7ccqSy8oPfEdtW7cnQ8Q/mKm8K+tFTQHMH/dKbxH3ghWbc2OXWcOm8ZmDkqwKNhc1/MqFgH4GJggzz2OhNPb6W3W0bfWLpqrlNocJgDOiRkJHCzQNnHaHS6Xx8de9ZpjergpepwitynMcIbvr+pQMV7TOnFigblQ3OzgpypJZWuUFKaV+FE27UFfDdnYON/05HlVuy3Y/jc5kZTcUzjKJ4XCduvCaSFGwQ6klL4013LCOfts7mxs3XgD/hzrFyjZSckzzo1RxnoqdFUM1T/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keJXvJ7shV9NvRdtR9MB/z6DKDC7P6IOlTZns0mhoHs=;
 b=g+ECZHwSuuLHBzWtlIBQ2OEcNHNILA5R27RdRICap7e/euSf5EGodHKIGAMTkKfzR/RUAZI5LU+WnqZlvi/fyW/7d1UFXMkdi/ZNShfPV/TuoYi+BizhEwKaOGw6qTU8Is5DxlpDEiA8Mh7nd06CK8osvCFdjgLBk+QDS0DRjGORuIO8i7QXP4qD27PGmWP8lBSpgQzE4B4jVCKw3kFeRnJaZIhWnBykFodQVZ0F3ClR6qE8/5f+0oMHtRrzzWx2/3lvZssxE5cLWu9g34NTYjNViafkViWlqv2j+Crm/Ryx3atFO58q0Y4644JIrQikZExUMOccPEFuEhfHHuM/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keJXvJ7shV9NvRdtR9MB/z6DKDC7P6IOlTZns0mhoHs=;
 b=Bj54rTmnKsFp8MqOYQUL3756PmiAzbL8lNKB5O2J5KcRNi1NL9Yxe9lLx7nugdFs2/5q3sFfoQUNqsIKdVf2iDDOzpLfxWaYmOobbesJ/pAQEP9cJKOsCOuH8k6BwNZmLiMUQsBZLH2V1tHMOn3KLfUOEdl+LIZ/M7MwwMiqYbY=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB5755.namprd04.prod.outlook.com (2603:10b6:5:162::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.23; Fri, 26 Mar 2021 19:59:22 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046%12]) with mapi id 15.20.3955.027; Fri, 26 Mar
 2021 19:59:22 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 "javier@javigon.com" <javier@javigon.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: disallow passthru cmd from targeting a nsid != nsid
 of the block dev
Thread-Topic: [PATCH] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
Thread-Index: AQHXIVwH1ScTxDZzaECPp8Ru2XC2tKqU0dcAgAHgdQA=
Date: Fri, 26 Mar 2021 19:59:21 +0000
Message-ID: <YF49GFrXUyMkNNhA@x1-carbon.lan>
References: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
 <20210325151942.GB31394@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210325151942.GB31394@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee64acdc-5fcd-4e1e-a722-08d8f091a613
x-ms-traffictypediagnostic: DM6PR04MB5755:
x-microsoft-antispam-prvs: <DM6PR04MB5755CE0F3C720ABC3212597EF2619@DM6PR04MB5755.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Un71ScZYC7q4clUgueIoKbjLPNceCkl6157syco+Xdx6LpORuho18yVRJ+AWALeJgXHQ93GPmW091873tL8MePEBKXx/TRx5dm609vsXsb0GlSPf0Z0E7pOpi2YbMc9snbQlATZlbBHAvoCn6rmn1/mNczEFSz3IBufDG2kYEn8MDaMp1RCtI640huQt2H79IuM73E1/aCIPAnPtipGaZOAx37hAbIzQz2tHjF50y36ZMfVuWNCKRgPSYV+M96WXt7ZmIPacqPUtXw9WX0vtoDIihQ18aHKHzz+1EEmP0+gIWscmVo4oA8thA4dw80pnrZQ62szVngMPKRLHEg27JGfS3dDIhN+STycX8kqmFofEh4WCXdYfuTn/HrB9XMOK8luy4cXNogJgwM8IjkvTCcgK2aDfXTiIrNRWztD35sCAPYMJ4sJqFpOmiSv6PphFWNCBQqwxFV/IsGu9prGZWcYThMCSepEN8dhQiKNSCS+bC3tFRY0UR2NjmlUv6eBp290E9r+56HMskFVzIsFEQHDFphEMI7X52XPK69PtSKt3s94LjvIKdfCI7RYIemOFeK9tg71/DZYbD8CAvH16BM55fiZhecCnCI8TDwU6Y2v7K0syVqGvx2kQnU8c5a1n9gSFGTu/SxVQNtHw57FUPsESI0OCI8WsxinWPfxlrn8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(54906003)(26005)(8936002)(76116006)(316002)(186003)(64756008)(66446008)(36756003)(66946007)(478600001)(6916009)(86362001)(38100700001)(66556008)(8676002)(6506007)(2906002)(66476007)(91956017)(71200400001)(6512007)(83380400001)(9686003)(5660300002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5nG2dAsb+sGLJsHGStQsI/STHCSGAqdMEAI5ucfxJpcl96CZM8sE7enmDLqK?=
 =?us-ascii?Q?uOnac+OuETDLN17M0beDXWFEntkIEvOrHw0NyuX8B59NkBmIaSolii+yTM7z?=
 =?us-ascii?Q?XB0mTfdAk/cOfRo8NPDubKbBgqyzgmZdzxw5p602Ek73qvCJCWhU7XYmfL4G?=
 =?us-ascii?Q?auZcvBbnt38ScJfALQraxj+8DeoTlWug4RA26gJmaOyQtRYFUEjjJBbQvzCz?=
 =?us-ascii?Q?v0xq7ZTAtBL28xjUIkXxr43heDFu0LZJHf1GWsffMFe8DxQ2hOvCMo5QNIOV?=
 =?us-ascii?Q?2JHtbKk5OmOnBfMakCllXtYEwfQtkuYusFL+g4IOONZEbhj08+uOxNltLwBM?=
 =?us-ascii?Q?rd7B0jM8zvZ37GmCRECYUeIScPeMWEa8JLNBAGQZSzl1Rlp45FofD2FuJNHY?=
 =?us-ascii?Q?giPMEIDzKJFa27KDvkRuKPIhd/gV43Jy4jGRiLoW3RbUAP9hpD7QtxcNkfhA?=
 =?us-ascii?Q?mKMg9hdmDPppr3Q785jmMz2q7jGDGoG5MxmG7x9relihvtxDzImROhfIv6aP?=
 =?us-ascii?Q?/OJw5RAKhWMp2SJkKT9e70DxS6rsZPiw6+6NZ3xRwXT/G0jq5tjwcv71nPTQ?=
 =?us-ascii?Q?UsZ+v2D5bUmrUTB0f7kp3DwgODkLZD+qv4Y6cx/Ktnejf/bLNT9qKslU6uSx?=
 =?us-ascii?Q?L3wjlCV/BcAP7HpfQCPdl8EZP8V1I1jHduOuCF0omDLdtSCQAQNotV11gcYz?=
 =?us-ascii?Q?T5iSyrRYBWv29VmiXaZ7tV1rOJYtBno60zxzvC6R7SQKnh6mB+dwY8kxqwLG?=
 =?us-ascii?Q?VrIdUNAgoYaKfzan7UYkX5sado3Arl6hTJ2zBYdttzM9I11c5JRNpiT+5d+K?=
 =?us-ascii?Q?+ipdzmzGLFTVwPZba3Qo0jnst8R3OvmCW8SYB6vr31XZgb5NTDKDKWVSIOnG?=
 =?us-ascii?Q?OVXwyv9EJcRcoXozpxqAiBvk1sU41xjY2YPMFwhqd1z5z7W7aYpuro7nxCwR?=
 =?us-ascii?Q?wgYkjfzOvgQC48Him2qNecuPpOtNRazvxWgmcLgp62vyK/A3XXGjFEM8dbb7?=
 =?us-ascii?Q?ZS8J/0bDREPhhR6Ja3dOHOuIOzi8pJNS3hGGIv0eyC1PjNW+/uEZt2PktZZQ?=
 =?us-ascii?Q?j0lW2JDvpvvaRP4a4Xr6xxeA+GdX5wVHBv3HoUnbxBlSsk9E4gxtcI+jVDpb?=
 =?us-ascii?Q?I08aJCgpsMxfPnbNLrn2Sb7ip6a8yVvDD+dfKLIYL7ejfA/T8H4TjXRYc0H9?=
 =?us-ascii?Q?KkegONjm4F0dzY9fVVGWO4ZB6q9yJ3gn8UXzycBInq78nj3ysSQcCGmM4w8J?=
 =?us-ascii?Q?90ha/e4+szFsgmH7o8Qe5re3G1UXao8rttiWPnUYzebjw45GAWWmOKmFz4mI?=
 =?us-ascii?Q?RG/Ms37cXvlmHCXwbB+paYC4?=
x-ms-exchange-transport-forked: True
Content-ID: <010AD3AA47539140B6F9B1F9A1E9DEAB@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee64acdc-5fcd-4e1e-a722-08d8f091a613
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 19:59:21.8335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ga5A6eTEltaItIszq7/7gZ2MUkdYgi9rTM+rsFn7URPIV/pr2DRsKe9i5eASdTzpcoY+FcBUCUbaG3XWXtkUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5755
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_200035_165581_32DAC15D 
X-CRM114-Status: GOOD (  32.16  )
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

On Fri, Mar 26, 2021 at 12:19:42AM +0900, Keith Busch wrote:
> On Thu, Mar 25, 2021 at 09:48:37AM +0000, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> > 
> > When a passthru command targets a specific namespace, the ns parameter to
> > nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
> > validation that the nsid specified in the passthru command targets the
> > namespace/nsid represented by the block device that the ioctl was
> > performed on.
> > 
> > Add a check that validates that the nsid in the passthru command matches
> > that of the supplied namespace.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> > Currently, if doing NVME_IOCTL_IO_CMD on the controller char device,
> > if and only if there is a single namespace in the ctrl->namespaces list,
> > nvme_dev_user_cmd() will call nvme_user_cmd() with ns parameter set.
> > While it might be good that we validate the nsid even in this case,
> > perhaps we want to allow a nsid value in the passthru command to be
> > 0x0 and/or the NSID broadcast value? (Only when NVME_IOCTL_IO_CMD was
> > done on the controller char device though.)
> 
> There are no IO commands accepting a 0 NSID, so rejecting those from the
> driver should be okay.
> 
> FLUSH is the only IO command that takes a broadcast NSID. I suspect at
> least some entities were unfortunately sending broadcast flush through
> this interface, so it's possible we'll hear of breakage, but I'd agree
> your patch is still the right thing to do.

I don't think this should be a problem.

You shouldn't be sending a broadcast NSID via the per namespace block
device. It just seems silly to specify a specific namespace block device,
and then use the broadcast NSID. (This obviously should never have been
allowed.)

If you wanted to send a broadcast NSID, you should have used the controller
character device. However, nvme_dev_user_cmd() currently rejects any
NVME_IOCTL_IO_CMD when there is more than one namespace in ctrl->namespaces
list, so they could never have used the controller character device to send
a flush to more than one namespace. So here we don't change anything.


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
