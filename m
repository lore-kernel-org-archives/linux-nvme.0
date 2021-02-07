Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98174C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 05:58:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E02464E8B
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 05:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E02464E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=HMpdQikMARa226qG5Etvp9AzwDithGYQQDUZzEY/dOI=; b=ifSxxRdveLo44HWcCYutQK/Id
	u8PKSQEhIBC5dFWIiEsak6/P8ugQqsFAjcZbCNna/7aFI0eMWTahflB0QaN61l/PM8E0+6HgU/a+O
	f/LP95UAMaJGdst05U3CpqrVb7omsyKkzstVfIep4oj+rAt38mGvFwaQaSh+nEn9fuuVLECzmT7we
	NI2GHpJBVxvc+nwMYklRz1X2iQh+NzTSQRJaw8wciiOJPEIhiBrUTDSgtsh75BmivhZVJtGjHCOA7
	daFwYegPir9iopci7xR4iMSSx4bYgPMfDdOPMw+CHPHOHs31AN9UMTo+Vp5A/qpbCPIjpo06ppwOV
	wdbA98obA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8d5G-0007cX-7D; Sun, 07 Feb 2021 05:58:10 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8d5D-0007c8-GL
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 05:58:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612677487; x=1644213487;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=9DdhWcFrRqN4EZS3rSv6l5jOVJxF1n+F0b3SHvz4ihs=;
 b=SYtiW3vI9+hVyzEodEcDeNWRNJuCUbZ+l2hFOiTwE2JCGWBLyMUqNlm6
 c66RT0qu/hvzqlBWlFUILWGTn+oWD5op7Cp3UYE/1nhVBqFIk+dO09+ZB
 nmM3RiYySTytcy9LNm+1e4gEcEgXYAEdI1/+DP+s7H5Pjemd09rO/pVyp
 aTMlo4/qQ8C21sJBWgcHqlH3w7A+Mp0BRMC3twe/oSnMEXx7npl82eP47
 EsjlPhpaI2qNUjNZkCh3Md1wi09qG9PR82qy2EOFPac8tiqlTUu0oL/v5
 5SwygOFxipNlbyES4dzG8UsFRtORCZR+Ou80ajGM1DUoYQc78tWUL3vOl A==;
IronPort-SDR: /j/RHtkvskd1LxJmX0fSvCqJCYQXpt1qcIgbLL0O9Xs0ONpdIqD0d+upqrP/3O2y4u3DeLgqPB
 j8+rZj+8JPqgjY/mSIFW4uvRJS02lu6WZIhG5slr7Da5oYm8z8lZdXhEEpYPWUkOGOXDuO76Mj
 gg6ZvpjbUp/UZn6uOeNeg0XGep7opIGGk0aZQFedQyj6G0CDPoyKhpyP3hsGeneZDyVRZD+pzX
 xMA2RP22EVVh4By+4XFpAb0mKsYSFzQvu/ViAQ34yCRd3CU7EYNPBdlDhuDMhBDYIZvoyiVlO+
 Dso=
X-IronPort-AV: E=Sophos;i="5.81,159,1610380800"; d="scan'208";a="159377874"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
 by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2021 13:58:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4cPHNC6BUUhNgNFCc9brpG677oKmGpia2a4ly/AdVoZOFpJmeY7AyUHii5cxCgze7Hj8JR0x0iefa5unweoCmk7F7/aofCk+lF/34vwN8TYkkFBmNCnbNzA9mOs/46RgwC/q6yJFt0005G/9LSHtNq+/ROm/uy0uszFFi5AT+TlKbVE9lFd2s34KAmK3X1VNm6K+tnV5OSpuZ/TvN5IziAyDLV+1JviEWOGs+fq3W14pixuKgxh98rIeEIcn5+2NpqD+C12cJKYDGCvpGcIhYDh9dOU6xwPTnodzaFBLUzeg81QGedRpzEplchZhk0Anlp0ymT848nAXswNNDMWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnMSlhtlOVBjIRxQi0hDHbqZCZKRVreljCFJamKssWI=;
 b=JSLiJ5sBb1gF0AnwrYInJZVMmLQfWiARDZc6LTML1ESsvOvbNYE3fTOhDs784nxe61B1ygVe7Ox8WRdgst/0Pj8bnfcgERQTnZ/cQJQhRjR8K711bMbgQ6s89WvpfBdIUiyrTn3GFEWJdVbgFLjOnBAx1v0GWgYtrCOTHmsSKR1nAy2T1aUUzrLsHK7wYIapaSvpgrKDN/lpkMp8TaQVEjkXFrrHt8AHrjOtItrx0hJDK7yq0poP7ebw5Mx8zPjvbwirHDRemW+N2O6NfJTbuxx6usO+SLcLDBuqW34LFv2ZZEgfYm2s1MtJCUzGgYDKT25UCr4ly7QkReZA/zsD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnMSlhtlOVBjIRxQi0hDHbqZCZKRVreljCFJamKssWI=;
 b=hMxWaXNwFDt7KkUV7TruzSJ539Qn1Owu2pktb2d48LQw6GsPwNvUGrNorxxvGq6RiOrt7Ex7hUkZWa11o5sVyhJRsqiQDBl4kzPXOisqyWNsSLacluBxDiNsG81M58pvt7Td4Vdadc0C9Hc+Uf7bD/c5Dc2bADtx1i3RjpOd+z8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Sun, 7 Feb
 2021 05:58:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 05:58:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>
Subject: Re: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with blktests
 nvme-tcp/012
Thread-Topic: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with
 blktests nvme-tcp/012
Thread-Index: AQHW/Qz4wyJ1jVpJcE2ugUQsAFy3zQ==
Date: Sun, 7 Feb 2021 05:58:00 +0000
Message-ID: <BYAPR04MB4965F26763967C4EC93A73A286B09@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <80b7184e-cdfb-cebc-fe07-a228ce57a9e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 329bd7f7-f8c4-4f8d-fe86-08d8cb2d533b
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-microsoft-antispam-prvs: <BY5PR04MB675399B900007F1F9C7F964786B09@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCCBBZUh2SL/w7NLxQuez5+NqYgXOj1cEgKkYKJmLrHZ/ghzoa4QRdb5p6VTjXkUdXLjeiHI/sDE+pbdlbMHSUHUh3aP7q0gfDLmhEWzj0seM4iB9Bnfb1Gm73TRIbFTe3liTs66AIofFFrHs4+9g8qjLYwFcMg+eOrFbUl75OX+ZlHQBDLjs/b10y+im07/tTp8KNkRECdwfpErOamgmll2wl3Wt/JpNvwPV0JV9RuqCxi4K129vRMULZqPf0oGPUPhlCpajhhs6MrazNjH7EmoPEnwwaTl3SDs4KPV02FX621VQF7zhZyrRWXoWd7MScFfuI+4WNlilOfz51BHcwbOPYB4lvbQdQtMDfSwfUSCEZhego2RjYOehvgy59u7P0FAbGLUUoZUJzOXs2vyzQhR1sB9d8invgFMBeBDEf41cDwDyReFeuya/nbulGT/95L4sExq6Ov6cYbOm7jEuDu+ih3UFWyXcIG9fPb5YLT6lJfc2s1UOGIRRL5+f6SIgJwDAa1Wg+m8hiqFuOJvLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(26005)(186003)(316002)(55016002)(71200400001)(66446008)(478600001)(4326008)(53546011)(6506007)(86362001)(52536014)(33656002)(66946007)(76116006)(66556008)(66476007)(64756008)(110136005)(8676002)(7696005)(8936002)(5660300002)(54906003)(9686003)(83380400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?77vGhAIp81ZjKXTS08V+8DB9UMjgdDklFfYn/FXCUexeQiTATf0cyV10PZu8?=
 =?us-ascii?Q?49ZN7/SxwLgNJw5jX3WqdQvUv4F2C9XtXatn7nRM4ccKqc2/NdNqWdlgIfjH?=
 =?us-ascii?Q?l2IaUJLeOUJAE8uCLrwo4Itv8QoAwz/y06hdnPDRvSiZt1JK+yDcs9dwr17P?=
 =?us-ascii?Q?mAo6pu0/a37Z/NhK7f8yFRlfiV/ESpXpMWcxA3cwaKtYA9tT9in1uSXNgEls?=
 =?us-ascii?Q?r+vwU0i9P/Zs2lr8vnGxCaeTHV8R+ckirnRULVpZIXkAMJTULFLL5/7J1exy?=
 =?us-ascii?Q?XRovr4MsrwCKIAbtCfYPJ2I1gyGqo6r4P1ZpOHV3V1zX9sPg8EZ+cd5lPQ21?=
 =?us-ascii?Q?TWRgbdgfYeNhMI4675NV69ZhBIoHBYID/Pe6cjClkT+LbvwLM5laTv8oBtJ1?=
 =?us-ascii?Q?en/uzAY3RKDtXPo/Ibdoc3HDuT16nmmAtPmQ4Ls/zDWECEgl4XvmNMLTASRu?=
 =?us-ascii?Q?TB/Ix9v7hN0UpdyRu5xZjBmi0yoluZGChlu6+xJnUqbFQ3mQGCOawrOeucRo?=
 =?us-ascii?Q?Xx9aDiEQK8hCKng1rRauQ0JZcXf9m1uYwdg6MeXXY8g4Ea643/jR0C6PwH2W?=
 =?us-ascii?Q?7F8D6u2SZ2a6H8TlIuxb4IpKuWyVBx0cXoShNEVywjuY1wTPmTJhTUzMi+wN?=
 =?us-ascii?Q?imvVlgC4DAOmOogeYf8QPVxgCoBLFaizpJG+dSxegu3GxHQt1DQRrZmVDUqP?=
 =?us-ascii?Q?vqe3abz14hxkErnhzu8LYRyOHPzvAPgfaM1wO57FJYE2qD3HL+2Va2+qew4R?=
 =?us-ascii?Q?rWbTAyEC3K65ZUo2CxxMLzftepEhoaXb8n+yuGC18AiTbobMXemE0w0l6vgF?=
 =?us-ascii?Q?f6nCrUrl2DNr2FC51zYluzQDTv1ejdYIKVmLH9srGLFwkut+uzDjtxMdj5oz?=
 =?us-ascii?Q?wm97WJjewK9Dr4BbWRRSNeV38crQHIr5QOGywr0En04oAALJKqCyG89+42i3?=
 =?us-ascii?Q?d5+YRw2aOL+kUT5NNoGhJnPkFmZajhxcaqE/8bcyNzc3pRAjy4HMkHnKOJci?=
 =?us-ascii?Q?Tol8T2XQJaG4OocJGbyBNnU9O/bfMvZX96rgpFNzgZU+imNh2cslouv1Sc7F?=
 =?us-ascii?Q?ckMh0HHO/De5yW3k+NFHVzHClaNcA9raK7OnkdBvWnZe3y2SV6oyHP5mhteO?=
 =?us-ascii?Q?ZNG18ORO1Oc7tWGOcIN7h34JfrfM129XZaBLU7S0mTc2HIAGnnQqY9YK83ye?=
 =?us-ascii?Q?t3UmiHOaDTsQ/UOiz4hWWqPJrOYdsZOPJR43ie5lRfk32kzfyFP4wVVXr64J?=
 =?us-ascii?Q?Z3L7derfLU6HEFO83Y+8d4mVhs+NKCUJq+Ge/zos8FbBZjRz0TawEkjAmwsr?=
 =?us-ascii?Q?N3I6aSCtJH65JeTUhHqhEtKi?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329bd7f7-f8c4-4f8d-fe86-08d8cb2d533b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 05:58:00.2363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nS8qnDE6iF0XifLKX8pGqFgFzVQidzeZwOuyFSHcI+X0AgiwA7E05RhKf9vqwee1Tji+SS7gInb/DOlCx/nIkCMnej8t6GLCDLByzhAi62o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_005807_730982_03624294 
X-CRM114-Status: GOOD (  15.16  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Rachel Sibley <rasibley@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/6/21 20:51, Yi Zhang wrote:
> The issue was introduced after merge the NVMe updates
>
> commit 0fd6456fd1f4c8f3ec5a2df6ed7f34458a180409 (HEAD)
> Merge: 44d10e4b2f2c 0d7389718c32
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Feb 2 07:12:06 2021 -0700
>
>      Merge branch 'for-5.12/drivers' into for-next
>
>      * for-5.12/drivers: (22 commits)
>        nvme-tcp: use cancel tagset helper for tear down
>        nvme-rdma: use cancel tagset helper for tear down
>        nvme-tcp: add clean action for failed reconnection
>        nvme-rdma: add clean action for failed reconnection
>        nvme-core: add cancel tagset helpers
>        nvme-core: get rid of the extra space
>        nvme: add tracing of zns commands
>        nvme: parse format nvm command details when tracing
>        nvme: update enumerations for status codes
>        nvmet: add lba to sect conversion helpers
>        nvmet: remove extra variable in identify ns
>        nvmet: remove extra variable in id-desclist
>        nvmet: remove extra variable in smart log nsid
>        nvme: refactor ns->ctrl by request
>        nvme-tcp: pass multipage bvec to request iov_iter
>        nvme-tcp: get rid of unused helper function
>        nvme-tcp: fix wrong setting of request iov_iter
>        nvme: support command retry delay for admin command
>        nvme: constify static attribute_group structs
>        nvmet-fc: use RCU proctection for assoc_list
>
>
> On 2/6/21 11:08 AM, Yi Zhang wrote:
>> blktests nvme-tcp/012
Can you try following patch and see in your Oops if you get that message
so that
we can at-least eliminate one case ?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 619b0d8f6e38..13d44d155478 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2271,8 +2271,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct
nvme_ns *ns,
        req->data_len = blk_rq_nr_phys_segments(rq) ?
                                blk_rq_payload_bytes(rq) : 0;
        req->curr_bio = rq->bio;
-       if (req->curr_bio)
+       if (req->curr_bio) {
+               if (rq->bio != rq->biotail)
+                       printk(KERN_INFO"%s %d req->bio !=
req->biotail\n", __func__, __LINE__);
                nvme_tcp_init_iter(req, rq_data_dir(rq));
+       }
 
        if (rq_data_dir(rq) == WRITE &&
            req->data_len <= nvme_tcp_inline_data_size(queue))


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
