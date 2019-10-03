Return-Path: <SRS0=6Jtf=X4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B3C4360C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 03:32:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C3021D81
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 03:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eVAB14SW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YbBfegIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C3021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s88rse39kIW4IEgqWTUnoxhf5F7bTSyLRq0A8Jz8J1c=; b=eVAB14SWJ/M2pD
	SHQddM4CuuYS6AZbXX25uP7GgL+D2ynFQhsn5aX3V8HZ7M5xSwOFYnoBVlKcnxK+Hbjs+aoHOeUC1
	CGlvr3GHLuuzRZlxQ8fFicOQMLG2KekxU/lsllfsPyOG/CxkiEcV2ZnD8yIgXucfWcwL1ASkywHXS
	rXYvFdiYwb6/a72cAujuVoSsD7GZBe8+/TJE+ys8kp87yKAX5LWuqykOxPWls+rbiNrvbPOCT9nyU
	61Sa2SuHC9beYXFBxFJbZEgoGM00qDbl4D1zhJFWJEkwlydN0qvnQo3u++QwiuYrrPjdB/Ql29LDw
	A1oW5Mm27MTzyxYhwWcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFrqg-0005gh-9p; Thu, 03 Oct 2019 03:32:14 +0000
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFrqb-0005gC-G7
 for linux-nvme@lists.infradead.org; Thu, 03 Oct 2019 03:32:11 +0000
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20191003033204usoutp01de51bf56ddb3fb23d7e677eddafc7fb0~KBY1PNXfr1376613766usoutp011;
 Thu,  3 Oct 2019 03:32:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20191003033204usoutp01de51bf56ddb3fb23d7e677eddafc7fb0~KBY1PNXfr1376613766usoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1570073524;
 bh=DmUdji/J83xOQpqq0zzqrnHriVZ1l+EbgDvui1PPLqI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=YbBfegIEcsGIAUw2FGchOIptcyLILgDxKoslWjlJjw3DTsg+6VP8UghBVQGWRYUuC
 CpsNIoEAx9S//MJhzzBzp0oFv+qhFVD7MA9x9iD4jjGTvT5YfuQ12PHFG6bGDVDZnq
 qCWE0xMZhJS3DOZxtJovpfn5KvTdcR+xCQfHSunc=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191003033203uscas1p12fc09f2cac027f248f908ff2aba2cad0~KBY0qjgj_0375303753uscas1p1L;
 Thu,  3 Oct 2019 03:32:03 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id CC.C8.04674.3BB659D5; Wed, 
 2 Oct 2019 23:32:03 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191003033203uscas1p23c94dfdced401b4a857a3fabd36415ca~KBY0JGluX2826428264uscas1p25;
 Thu,  3 Oct 2019 03:32:03 +0000 (GMT)
X-AuditID: cbfec36d-09fff70000001242-4f-5d956bb3a238
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id BD.27.04525.3BB659D5; Wed, 
 2 Oct 2019 23:32:03 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
 SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 2 Oct 2019 20:32:02 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
 SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
 15.01.1713.004; Wed, 2 Oct 2019 20:32:02 -0700
From: Judy Brock <judy.brock@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: RE: : name: possible deadlock in nvme_ns_remove
Thread-Topic: : name: possible deadlock in nvme_ns_remove
Thread-Index: AQHVeC9M907ALyOc40+AFvXfLsmGfqdGi1MAgAD2NgCAAMP9EA==
Date: Thu, 3 Oct 2019 03:32:02 +0000
Message-ID: <e4b068eda3b34712b793f365d221beb5@samsung.com>
In-Reply-To: <20191002084920.GA13802@C02WT3WMHTD6.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djXc7qbs6fGGty8ZmzRefoCk8WkQ9cY
 LeYve8puse71exYHFo/z9zayeDQvuMPisWlVJ5vH5iX1ASxRXDYpqTmZZalF+nYJXBm/J35j
 L9giUDHz6CaWBsb3PF2MnBwSAiYS094cZO9i5OIQEljJKLHh6hZWCKeVSWLLvaWMMFWvFv2A
 qlrLKHH73TIWkISQwAdGiQmPPSAS+xkllu5tZgNJsAloShw90wRWJCLgKnFs8QuwscwCyxkl
 Du98DFYkLGAh8XHXLXaIIkuJ/vMvoGwnif+XvrGC2CwCKhIzZl5iArF5BawkFlzdDBbnFLCR
 uLj5D9gcRgExie+n1oDVMAuIS9x6Mp8J4mxBiUWz9zBD2GIS/3Y9ZIOwFSXuf3/JDlGvJ3Fj
 6hQ2CFtbYtnC18wQuwQlTs58wgJRLylxcMUNFpAHJASa2SU2Nb6GWuAiMePDA6gF0hJXr09l
 hijaxSgxue8UE4RzHBhGJ85BQ9JaYtHXVVCr+ST+/nrEOIFReRaSy2chuWoWkqtmIblqASPL
 Kkbx0uLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMA0c/rf4dwdjEdOJx9iFOBgVOLhnXFvSqwQ
 a2JZcWXuIUYJDmYlEd5L64FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeU/t7o4WEkhPLEnNTk0t
 SC2CyTJxcEo1MGZYfJ7+/oDlb0WZzg0nDuWLsd862/5n8/UbbiV6Cxw1Cm8p3OgQ4pqkvZLZ
 hjlm/4TyLVlH9n6vqT0jl9u7SKJwhvK9uS3u8dujPxdtuT67WNBp7TzGVzxrfxYZ2tTahzS2
 hwqZn96W7Za5+pPckphbUyfP7Ui7/Gf9bhmOI8+mqx3WPmkSM1GJpTgj0VCLuag4EQABvPzw
 LwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWS2cA0SXdz9tRYg6tNvBadpy8wWUw6dI3R
 Yv6yp+wW616/Z3Fg8Th/byOLR/OCOywem1Z1snlsXlIfwBLFZZOSmpNZllqkb5fAlfF74jf2
 gi0CFTOPbmJpYHzP08XIySEhYCLxatEP9i5GLg4hgdWMEh+7zjKBJIQEPjBKrLzFDJHYzyix
 7+INsASbgKbE0TNNLCC2iICrxLHFL1hBipgFljNKbPnyEKxIWMBC4uOuW+wQRZYS/edfQNlO
 Ev8vfWMFsVkEVCRmzLwEVs8rYCWx4OpmVohtPxkl3i3vYgRJcArYSFzc/IcNxGYUEJP4fmoN
 WAOzgLjErSfzmSB+EJBYsuc8M4QtKvHy8T9WCFtR4v73l+wQ9XoSN6ZOYYOwtSWWLXzNDLFY
 UOLkzCcsEPWSEgdX3GCZwCg+C8mKWUjaZyFpn4WkfQEjyypG8dLi4tz0imLDvNRyveLE3OLS
 vHS95PzcTYzAODz973DkDsYTp5MPMQpwMCrx8M64NyVWiDWxrLgy9xCjBAezkgjvpfVAId6U
 xMqq1KL8+KLSnNTiQ4zSHCxK4rzLxRZECQmkJ5akZqemFqQWwWSZODilGhi7C+7d+x5ycJGc
 yKovMxOfPtNO0Ds048LtdYoBE+ttzzU/z99hw1hyi+3mdO6PK4y7cn8oPV/W+SnVQ81AVyPk
 pVnGJi/ZIMH8xrebHTvuPV64OuXopa9TFs8KvGrU6fQyq1tAdltJheGyJ5a7ppjtUH33PGHd
 5RsB3mVG10RnyAirFfB9OTxXiaU4I9FQi7moOBEA8SATR78CAAA=
X-CMS-MailID: 20191003033203uscas1p23c94dfdced401b4a857a3fabd36415ca
CMS-TYPE: 301P
X-CMS-RootMailID: 20191002084943epcas4p40fc6abf9d35fcf44e5df9486de9a0329
References: <04580CD6-7652-459D-ABDD-732947B4A6DF@javigon.com>
 <3ac73ede-1be4-8459-01f2-1a24b83a1155@grimberg.me>
 <CGME20191002084943epcas4p40fc6abf9d35fcf44e5df9486de9a0329@epcas4p4.samsung.com>
 <20191002084920.GA13802@C02WT3WMHTD6.fritz.box>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191002_203209_676874_E5C4B705 
X-CRM114-Status: GOOD (  13.47  )
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
Cc: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 Judy Brock <judy.brock@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We started the test earlier today w/original patch I'm assuming we should s=
top it and make the new minor modification, right? Just wanted to confirm.

Thanks,
Judy

-----Original Message-----
From: Keith Busch [mailto:kbusch@kernel.org] =

Sent: Wednesday, October 2, 2019 1:49 AM
To: Sagi Grimberg
Cc: Javier Gonz=E1lez; linux-nvme@lists.infradead.org; Judy Brock
Subject: Re: : name: possible deadlock in nvme_ns_remove

On Tue, Oct 01, 2019 at 11:08:06AM -0700, Sagi Grimberg wrote:
> > Sending this bug report from Judy, who is having problems with the mail=
ing list.
> =

> Hey Judy,
> =

> It appears that you indeed step on a real issue. It seems that
> if nvme_update_formats will fail the revalidate we will acquire
> the sybsys->lock and hang.
> =

> Does this change solve the issue?
> -- =

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fd7dea36c3b6..dc785b1aff8a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1306,8 +1306,6 @@ static void nvme_update_formats(struct nvme_ctrl
> *ctrl)
>                 if (ns->disk && nvme_revalidate_disk(ns->disk))
>                         nvme_set_queue_dying(ns);
>         up_read(&ctrl->namespaces_rwsem);
> -
> -       nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
>  }
> =

>  static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
> @@ -1325,6 +1323,9 @@ static void nvme_passthru_end(struct nvme_ctrl *ctr=
l,
> u32 effects)
>                 mutex_unlock(&ctrl->subsys->lock);
>                 mutex_unlock(&ctrl->scan_lock);
>         }
> +
> +       nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
> +
>         if (effects & NVME_CMD_EFFECTS_CCC)
>                 nvme_init_identify(ctrl);
>         if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
> -- =


Thanks, this patch fixes a real issue regardless. I would just recommend mo=
ving
the nvme_remove_invalid_namespaces() call from where you have it to after
releasing the subsys->lock, but before releasing the scan_lock.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
