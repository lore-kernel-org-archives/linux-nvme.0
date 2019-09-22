Return-Path: <SRS0=CsQm=XR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD35C3A5A2
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2019 04:27:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115B2208C2
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2019 04:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oClG6yYy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jok47W4K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T6xL+aX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115B2208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Wnv1wK6J/mTpFLoFgIxOHPYvWMQj+j9ei/0HEzzXlhY=; b=oClG6yYyu60fb6
	EYT39lEyNP9mrO9WSBqA42KmokS4zJ1qoUUZUWgNj7LcoX6TUnv32X9+u9GCV1z8vXEXjvdJjsVG8
	MywPY16hITTUT+NkWyZz3eVvyCzmPp03G99rNiHV8/3YxTRDUt3d3jFbQpVRNV4WwZ+O3qG9I25Ca
	SB9oPYp21MlkaVJSj7MCwvCsV6UuARYP8/smKj6Xp8ievacYu6ExHccCZZU4V63RsFWDKGC287HFE
	t3CGbQHRfE6GuYbmn97oAUYeyU8FXlXCBvxOgnTdVquSNdzzrZ3OA9dkXrR6w/aY5GgRhd9spFncD
	kItbEANZC5AybDgTAsBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBtSZ-0000uU-Ns; Sun, 22 Sep 2019 04:26:55 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBtSS-0000u2-FX
 for linux-nvme@lists.infradead.org; Sun, 22 Sep 2019 04:26:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569126416; x=1600662416;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=1nAx0CYdCe9cfMG/1d5Eo/0Ttp8h6QtC7PFXo+Zsvbc=;
 b=jok47W4KObl4MgJYMXESdIRkYC7TWqSozKEFZVfEjm+9ZzGkS0My1Xeh
 Y+Q8lGmxGQ71Q6IrmVfw6yudBFWvPckyRcboK5p17BRsGHL6ghqA3E6mM
 4EpWMNMaTssTN0mKS18zIyi2dBrrmmQ65Rw03nYN6oQ56J0NXDkLdgUdI
 vAe8ns2g2RkxIQzJErA2ZBavrimWoHg26+ojoa+LFu0LS+mfhQJWUnUb9
 hpkUdqirtITksn8RqcCKPCghskPBu8dXlFnxD8NwugxeVH+sJZJm0+/0p
 JJpDqLNcJLFHUuAwCL+oKuWpu+sXhc3UvBsuL9aHvVATM41xJJB9tSUx9 A==;
IronPort-SDR: HmzMRr07bkKyz31Rn27ntUs2gHsitN5Zfl11oJ2kyE8ix7ySIF8/YkAQmYeTJo/y33fSNuhgTr
 Dj4ZHZe7I5unz+uNt7VMhDShcTw79d12MIdFSfzlFyRo5X6oKrkk1vAthIMUTNMvoQdcY53h0L
 ALNCuZVLlCD0DwHWozCF/6ZGuhlzfYujOzhrUQ9++petUkKEAC5HqOpxt65NFB4eRVYSxBELXf
 +RxUCQKD3ISunS4MJE5REQNtEfKoF5BRbrx9zM4I5ZDfIRG8qz8UyMCw2B9eD+1XPGiNcEpDSy
 fvA=
X-IronPort-AV: E=Sophos;i="5.64,535,1559491200"; d="scan'208";a="219643206"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
 by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2019 12:26:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLVYSeNdnymk/HQPJbpPamnthMHG7qvrj0x0Z/8LFCgoNcPhT7X6xwcN9weXz0p3ForC960GorcOrk9AvFU7pxWyLzDqoxIZU2eiyzfznB+oNryXqJggnWF6K6iTYJS3mvnFSpf6i4cFulXuNxcCPdaGhWWjDm+bWVcAd/NmXeKZXZHkiXfpHvrtfqzPiSSrVjGwTKWjcRAbcZ8zicD7W+rrJOgCSpjxTAhhDBnvRd7bxZTlmRnNw9vNgfN3eyhG3Y46cYzyatW1bu37AEKqnf8MaaKu9rwD6w1m9AGNpQ84fybbQQ2M7dlYM+Tz8UJ9VXrPqf+2Ne5OxS/0HtJaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrb+56hP2gyPQx94rWObMREOGDMeHg04T1kz5dF7Dqs=;
 b=bS5RJ6l1KDxu2734mTg8oe1jDJBm6w82LKlb4NcabF67twXgLIFs1rUguYBTesbQpVHJkwhaeeuIOehTbHZLC6Ir+9Mz3CaCF23TW2lTHHZH8wvCk8Zdhd0ejMSUrnA27p4iLxvXQ+pq8VFhDP3oSUV0cr/vkoBzBvgxNkGL31nQI79oyDllI2AhTIt7+G4Pu6bUcu1SGjMAqFwZjpjk5VKvL2eTVPWml5PDg8k9in7BKx7pIgYnpKOv/iZv3sqYOaI7+WLBRS9mJSj+d1+y7Tm6/Ed7UoWKD98IiQevwKsgEW5gSyfknldlaBYRabN7CEo+6gPIKm36GCHICLYf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrb+56hP2gyPQx94rWObMREOGDMeHg04T1kz5dF7Dqs=;
 b=T6xL+aX3tS6ixy5YMdjmH8HvSUlkVOwt/yMwdDeOHpOwxnFqrhKgvgdgDHh7PAXDlyHrA5vAynHDrOWPRGYPDm+UA0dwEKAHnRJVgGNV53KmpxqxqaMvyWbNo6ZcANgXfADbwOMiki08CSs2JU2pmcKo05buOTz7U3usbvgOQEE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4551.namprd04.prod.outlook.com (52.135.240.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Sun, 22 Sep 2019 04:26:41 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2284.023; Sun, 22 Sep 2019
 04:26:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: set NVME_REQ_CANCELLED flag when cancelling a
 request
Thread-Topic: [PATCH] nvme: set NVME_REQ_CANCELLED flag when cancelling a
 request
Thread-Index: AQHVb9/uCvIXRTLrl0GVafrQHvP0Rw==
Date: Sun, 22 Sep 2019 04:26:40 +0000
Message-ID: <BYAPR04MB5749B6AC6EE50BEC6C63D213868A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190920181913.14723-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dd445e1-a6fc-4aea-94c3-08d73f1510fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4551; 
x-ms-traffictypediagnostic: BYAPR04MB4551:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB4551FA816B967CE1D58C3F9F868A0@BYAPR04MB4551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 016885DD9B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(39850400004)(396003)(366004)(199004)(189003)(76116006)(7696005)(66946007)(52536014)(6306002)(9686003)(229853002)(14454004)(478600001)(33656002)(86362001)(6436002)(5660300002)(4326008)(25786009)(74316002)(66066001)(2501003)(316002)(55016002)(110136005)(54906003)(7736002)(305945005)(966005)(76176011)(476003)(8936002)(486006)(446003)(2906002)(102836004)(26005)(53546011)(6506007)(256004)(6246003)(186003)(6116002)(3846002)(81156014)(81166006)(99286004)(71190400001)(66556008)(8676002)(64756008)(71200400001)(66476007)(66446008)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4551;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Lae4qLPt8u+ie0E0d42eITNelSB4jSxbPbkl8pc2/NCbV4ZQO7bTb0pziqglh8TNd700iWSji0axjTxOC/iYwgDIVGYX2r7gsEdQoGTcd3f3cQ4/ms4/btIJ1IrVqQWUQTdWzqGjlBJLiuHPcTgzyfNoq4broG/ZMV8bJi0BSRb1+1f95UdUlSg6Lpt/03I0hwdQanFQn5M9EasjRVf15Uh7BAlpPvlwP3SK2GnFuLH80Uw4zIpKYYK+X0fXLSCJJnEwKMXTfrma97pHE6glLxEd81GPeQBcj5e1QCDjo6GDVyWoSbftXXpS02ePIL957fj8cD1bPnJAjz+W42/bRsgDf0nciasAd9j54J857sntf9wENtJnmlqN00nwwR+69BMYes/Rrr7qQozsqsJH2OefeDSOnqsN5EDguxIx4c=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd445e1-a6fc-4aea-94c3-08d73f1510fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2019 04:26:40.5232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+/ze8BsTqjWefnlDnuNtlrx4DFtl5eLwOud2sTWtNx51nhY87hzkZemtYyrLQI7zw5rdEvoyef8wdJRfk1ZmpaWU8N8GC6P7+/a8ElEMrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4551
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190921_212649_031305_CB2DE8E3 
X-CRM114-Status: GOOD (  16.46  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There are couple of places where we explicitly set the
NVME_REQ_CANCALLED which is followed by the call to
nvme_dev_disable(). Since :-

nvme_dev_disable()
	blk_mq_tagset_busy_iter()
		nvme_cancel_requets()
			
with your patch nvme_cancel_request() will duplicate
NVME_REQ_CANCELLED assignment, we need to avoid duplicate
assignment. Following patch is on the top of yours, please
have a look :-

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6447702..4c71bbd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1286,7 +1286,6 @@ static enum blk_eh_timer_return 
nvme_timeout(struct request *req, bool reserved
                          "I/O %d QID %d timeout, disable controller\n",
                          req->tag, nvmeq->qid);
                 nvme_dev_disable(dev, true);
-               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
                 return BLK_EH_DONE;
         case NVME_CTRL_RESETTING:
                 return BLK_EH_RESET_TIMER;
@@ -1306,7 +1305,6 @@ static enum blk_eh_timer_return 
nvme_timeout(struct request *req, bool reserved
                 nvme_dev_disable(dev, false);
                 nvme_reset_ctrl(&dev->ctrl);

-               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
                 return BLK_EH_DONE;
         }

If you are okay I can send a separate patch on the top yours.

On 09/20/2019 11:19 AM, Sagi Grimberg wrote:
> This will prevent userspace to wrongly get the completion result
> when we cancelled the command. Also, make sure to clear it from
> the request flags in nvme_setup_cmd.
>
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f85e7b09d1d4..fc3ed75ef80b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -298,6 +298,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   	if (blk_mq_request_completed(req))
>   		return true;
>
> +	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>   	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
>   	blk_mq_complete_request(req);
>   	return true;
> @@ -434,6 +435,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
>   		nvme_req(req)->flags = 0;
>   		req->rq_flags |= RQF_DONTPREP;
>   	}
> +	nvme_req(req)->flags &= ~NVME_REQ_CANCELLED;
>   }
>
>   struct request *nvme_alloc_request(struct request_queue *q,
> -- 2.17.1 _______________________________________________ Linux-nvme
> mailing list Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
