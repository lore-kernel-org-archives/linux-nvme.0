Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CABC11F67
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 23:31:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E9861D62
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 23:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E9861D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=pqpbe0xlkrbPQA2zXTxCRhR2nh81D1JvLFHmvj5wC9o=; b=Ed7bM+bxSDBG+0
	y0E4d06EyWzfHMtVAoGh34TJNbg2/+fkYPAs5Q7nGexi5IcDStJeyH7mbaG+lQG3EbcXaxhZ/0Hff
	XOB1J8A+15lTuAoEe5xr0ZbdcxUJw/PDBcOPxNXn7dmr2EIxzSUtsq/s/Bavp4monK/CFcz4UA8YV
	ZlsL162RGNZF43pJkrmNXBsqBTxNPuu4W8A0vAZF6dmWCTRAcEmfHrvqlrhU00kzgHpOxAyrMdy7o
	NwbWLnfkTVushC8ZpT0wDlTjJeL4ls/uAEbvjIcHT5KJLpieoKcD3zM8f14bx0kwBaAkdZdTcgQKD
	3U1tlohYu+4j0ZtcLZtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyNBl-00CDh2-NS; Tue, 29 Jun 2021 23:30:45 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyNBi-00CDgD-Fk
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 23:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1625009456; x=1656545456;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=9eyevDGBnk0Y9w8L44YMJkN6fUkF43ValJD6VBSdgnk=;
 b=BUWbpMFLu7EYQ5PmtrJIDnnH5PwKe19//MUv+G3miSw+1rOq+FiEmWpA
 E9MMY8RREzLB1/5xiQmVs8i7hBD2VumjnHMysgrZPbwjLY6CBBkXztXRD
 /Gud179tsivaQ2nekbzpkyZDTYQv0/KInR2mNqGqHty8JXpVJSgMnc9Yc
 eTjJ4920nNP6s6NGd7FxUD4UXZZIC5tvWWkVoDGQ44RVic6s2QWj9r7we
 /+D/JqK79TEuEkgzRKyw+noRid4WNuJZs6CyUjQqS3dIx1IpV7iVDbUu3
 kFVKSfFNsQ3WaC7LjCqrWkEAjaoa0DSFpFI4wMsOWzsDOq8EqtNlhR+/p A==;
IronPort-SDR: YKnaHyGkAS1D075Fl2sp2Lg5jyEK40xsLDaM9i43m9oQt+jJ2fI6ZLHXqQRgoWsp65wRifP6FQ
 gfA9B+TBFLaqYdIUL3lAzlERV/0kw9V4uQlPWz+Px68PI777OuKnEwNERin6XM/lb85WA0rT6q
 zopbbtabvwpGbR7r0NAOT8CeyQR9XRqGpLYAE1TMdKTr96D/xHCOSM5ZDxswYeQExJ/6qVEZHq
 rykB2V3edEqo0xnGiitxJfi4Bv/Gqa+4RU4nqgHXwqroER19wvbh+Xl+zQ0uvq4OtwbdGbwpEI
 j4M=
X-IronPort-AV: E=Sophos;i="5.83,310,1616428800"; d="scan'208";a="277049626"
Received: from mail-dm3nam07lp2046.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2021 07:30:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGlSyrn6n+6i6cM+ke15ZlNjMno5gZkuzgYmzQZnHDNwG+7/l11/eWmOiS/wFsXhAaCF6oX4GGcMW52TmtEKeVFQj8cZGnSNduW7AOScmmT1Ps/q8sI3CSK6CV6teWXH8DYafCTmCOQdhtp4gU5jo6c0TU5X+crPmsE3qGmHNPf+vENRdrbRKxrDfdnmhNtmxCm9vBsXYQwLZVQyYS43Ri/7jgcPjx0x6/u16rqQCRG7VEOKeVBCknx31p0xOhxfYlDR8vZcPbijc7IDzn3pb7nsqtv1yCExF2DhSDiIkHdk4y1vGXh8DyJnmfwtyLalcwpCULi+lxlVZD7Q+6eOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu8PyTsLY0Kq6NOqM83kqcJzg0kLBuoyddY1k/w5mOk=;
 b=RT5spdtNULoIBoX5xuGuoVVlNEU3vH9u3IP04KlDpzXQIX5SIFmhSxkGrOnOjfoU3wryTy/qkAAJVNF0vIPU4V6GAyXDnriMv6HaNhWdZuuzJERjOQY1JgzBzqbXOAgVvfEXgRTpMyN39YnOvKrlXmtUu0q/1pkQ8HbhmzaldMnzhPafvGWkpzp+ojpZ23ufpWM7P9OxR1voyDQprILFrMaPgTCSrQKm+MA1fICU7CAB/05/38r+F7xbGW3W/xxf1SAK7isUk3Qd1xwL3RtBBDnVHtqBffhRghOFQKU1BwlbNLT4n2NhjxrYZODxGQXB6IXfCRJM26uDE5U96Th8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu8PyTsLY0Kq6NOqM83kqcJzg0kLBuoyddY1k/w5mOk=;
 b=xcdhgmzc/659iaNKI4q+fPd8Z9CGWZuRAX5PmpyZ9uusWjWIte47SU34+jqPai94GWGIe4ULZ8l6ADSvCcS6vmoa268mnwpxG3ihsKZhDYCQjtn8OdJRsG/wPz0N/jjYIMCE/QUgO+yUA/u21LVNp6l/4kaaUWRlm1r4QqBvAO8=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5243.namprd04.prod.outlook.com (2603:10b6:5:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 23:30:35 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%9]) with mapi id 15.20.4264.027; Tue, 29 Jun 2021
 23:30:35 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>, Wen
 Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
Thread-Topic: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Thread-Index: AQHXbLtuHkNoWHYc2kOLK+PDH01yww==
Date: Tue, 29 Jun 2021 23:30:35 +0000
Message-ID: <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3c1e:efb:30bd:d238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e058b6b1-438f-46c3-35a2-08d93b55e590
x-ms-traffictypediagnostic: DM6PR04MB5243:
x-microsoft-antispam-prvs: <DM6PR04MB5243CEE68CD7CF51793C1688E7029@DM6PR04MB5243.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAE17pzl+rbrK6A9Q6wf2gPANVPbv9xe45ZqKt3q+nHCA+lzXZ5lj2uwWaK70mqTQ1NvQkYnmzkPfmAPNWh1VD6Df/pSlyyv3wqxtcYCeGxTPzwc/vSn9eRrWlfhK5PZiGo/533KHVV77y0qEKLaBeVR8gj6lKjAwpOU69reQx0OpIPBdOkL2WgjE/SXUgdz35MZUtXcYpcK93/AwlwDNNR5jun5lPrWWcXaAYXmaTsCZ8W3s2+7Zg+bafg1+jwVdzMYr4q/mQCxrOeivuQg0lGb2wX5TNOquGpSRTQReQuEgqR+t4Sq3kjfmtfWGNoIa7bK7gb7qRV4L37NPxxjLjHcKrX3NaRVNMAX+SbR50HyvMKEdik67beg/2Dxb2SrENCaA31MMIKD18ZKN+LMJZftTliw+D0ufHqAMFXl3RQfAY2ZioUpp646AEYr3QcZ5wNASLTMF398b1U1Kc9V5PPl3p1chd3AA5wTQrcrgkWs+hZ8GkJnItc9lJ8vguP1OrqDAWk3+5Wg42MsBsdUY1q9Gfkgwoy3EwqR4Hh8gjomr+VW6MYyYX1cZFOoW4WGShbtPgLRJ8JOJxP20AIZwobuRuSQFBN9NeWa4wekR3DRdDE+Rqnuk3EPN9gm77hhPCmZZZXLyfqbXoE8kytBEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB7081.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(66476007)(55016002)(71200400001)(66946007)(64756008)(66556008)(2906002)(122000001)(86362001)(7696005)(52536014)(66446008)(9686003)(8936002)(76116006)(38100700002)(91956017)(478600001)(8676002)(4326008)(6506007)(53546011)(33656002)(54906003)(5660300002)(186003)(83380400001)(110136005)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?psw6XeuEygRBKdXZGIzD6q1JoROu7bUCd4AEpjju5v7s+/PTAIlFdnFvnJQu?=
 =?us-ascii?Q?XP7RvfAHmrbNQ9xMF7CwNAkWoTe5x4dO3FhArx8PotCOPEByIrTf8GDs4iuH?=
 =?us-ascii?Q?iN80mp42vmY/lPlkbBnKTM/nsRnMx6QG9sl7nw9ShHsS7tVR3N/od9yCDNwk?=
 =?us-ascii?Q?RJ6hGJ526lIqo7ey9iIw4ZXULep2/XEgrl6h1bh0YaTArZdiyML57ElQsQs9?=
 =?us-ascii?Q?B8f6AQPabZUdEqT8POVLxng72o/868BsZbfuKG8iDdhpXsySfCgprNpOR/Xn?=
 =?us-ascii?Q?gPSzXzIP5kttSBkyFITzoxPmSinwJyKjTGWBVVG0rB9K1nedgHLWoRs/QD5/?=
 =?us-ascii?Q?fuGjeJqIdIgpPMXQgIlaQ7PopegIAa8mEpfKIviTQ1f5naIfkk2cKHqhQ/94?=
 =?us-ascii?Q?+AcRBDBG9vdUNeIMKM+1JImEN2Gyjyn/6LZ85zW/u4SnDNSrfXI8Dg6lFCq5?=
 =?us-ascii?Q?aTx38alIGmsEDVEyf78se3p01c+r3JaZtnV8I4g7gRrvt2BMp2E8DmlLpFk7?=
 =?us-ascii?Q?Ltk01j/ifNl4NIkSSUHgVaWlqm+Cus4ez/3SY7QYiSPjogORXvEsGquTSCfo?=
 =?us-ascii?Q?f7TyE1XlKKzcsT5YGvQdFMv61rgEzj7keRN8Gckm+vOgclZENkkdV5Bux7uV?=
 =?us-ascii?Q?c0L2tghhpqIEc/bYfPq9gTtDzA5YSpkGDTZS3uwPw6rk0vzdd+/eMSdz4rXz?=
 =?us-ascii?Q?QP250R3o4ulwax3hsfsqIt4sSgNdvBJSdS0MUfT+3T4kxmKi6SRZnLcrQ+sx?=
 =?us-ascii?Q?WKhgQQnyJrMw8EHnEDM+xX+BMX5The/jD82m0b0xxoxL/wyvQ9YHF0LQAbNa?=
 =?us-ascii?Q?z9u6Uv0xUko+XlB8Z18fgLg7Cr7zPXbVpZo0mDwt0UCzxJgu7K8TwdOcIEXq?=
 =?us-ascii?Q?nJ0M0uTjn+WKLK8t3LDUJwRqXHtvioo1mzYHDffKAHWby4iPfIZ4nEC6Qdwd?=
 =?us-ascii?Q?TSzixjFYxZUFE/zKd2DjwuNiTdEezpQ+XVD7/3Yb79ScGZY5+9PzyNVrTMBQ?=
 =?us-ascii?Q?8SqJMMGNttCWqsaQlegainW3giD6LExyCHCXDpEO7GJLo14z5WONTC0ZBWoX?=
 =?us-ascii?Q?aRyh8f5rSt5W6zfLAvZTUsTiJKUrZkVAK5UmxYQpTwLfX+tTCG4DbOFanxM7?=
 =?us-ascii?Q?X0Sh9nwfgsBAG57OP1XndEjbh2hwUSLG4f8rqWkiZUKTKuiFoaFquk5BMNym?=
 =?us-ascii?Q?C1k9meHq/JmA6jZHPv6KswiUlplQmLzqqWGiEh3j4+jU+25jZo+P0563oNpn?=
 =?us-ascii?Q?zg4z0oHN2n8Jc/6+0zyGn6cpm3mGYhxarqFPMlndFRqPrwq62cQicvT57UD7?=
 =?us-ascii?Q?AHNrIWSFW57Jfw79L3SUI7W1d08tZl1MzUURBe2vSWEJ5hMm/WcT3XX7ODMr?=
 =?us-ascii?Q?exn5XNmnI5Suxt9oG0LCSm2v7ov5CdA+8R8SKxEDC51iTSPQmQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e058b6b1-438f-46c3-35a2-08d93b55e590
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 23:30:35.8093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJAKN3QzI/CpkiqHCXYmnpH2zYFdpgQ4aOo/l9f+rf05wvjVmiRlm84xbjOk3vz89n5IjCv/JR10mpufoo/9jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5243
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_163042_700321_FBC4B798 
X-CRM114-Status: GOOD (  22.24  )
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

On 2021/06/29 16:50, Ming Lei wrote:
> hctx is deactivated when all CPU in hctx->cpumask become offline by
> draining all requests originated from this hctx and moving new
> allocation to active hctx. This way is for avoiding inflight IO when
> the managed irq is shutdown.
> 
> Some drivers(nvme fc, rdma, tcp, loop) doesn't use managed irq, so
> they needn't to deactivate hctx. Also, they are the only user of
> blk_mq_alloc_request_hctx() which is used for connecting io queue.
> And their requirement is that the connect request can be submitted
> via one specified hctx on which all CPU in its hctx->cpumask may have
> become offline.
> 
> Address the requirement for nvme fc/rdma/loop, so the reported kernel
> panic on the following line in blk_mq_alloc_request_hctx() can be fixed.
> 
> 	data.ctx = __blk_mq_get_ctx(q, cpu)
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Wen Xiong <wenxiong@us.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c         | 6 +++++-
>  include/linux/blk-mq.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index df5dc3b756f5..74632f50d969 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -494,7 +494,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	data.hctx = q->queue_hw_ctx[hctx_idx];
>  	if (!blk_mq_hw_queue_mapped(data.hctx))
>  		goto out_queue_exit;
> -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> +	cpu = cpumask_first(data.hctx->cpumask);
>  	data.ctx = __blk_mq_get_ctx(q, cpu);
>  
>  	if (!q->elevator)
> @@ -2570,6 +2570,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
>  		return 0;
>  
> +	/* Controller doesn't use managed IRQ, no need to deactivate hctx */
> +	if (hctx->flags & BLK_MQ_F_NOT_USE_MANAGED_IRQ)
> +		return 0;
> +
>  	/*
>  	 * Prevent new request from being allocated on the current hctx.
>  	 *
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 21140132a30d..600c5dd1a069 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -403,6 +403,7 @@ enum {
>  	 */
>  	BLK_MQ_F_STACKING	= 1 << 2,
>  	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
> +	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,

My 2 cents: BLK_MQ_F_NO_MANAGED_IRQ may be a better/shorter name.

>  	BLK_MQ_F_BLOCKING	= 1 << 5,
>  	BLK_MQ_F_NO_SCHED	= 1 << 6,
>  	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
