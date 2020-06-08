Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8F8C433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 06:21:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD202067B
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 06:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sx4+MMlb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ioHlMTlr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oLG3D7ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD202067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=YuM8z2NAYBBBsvvoqhtSFaVkDNZI5lbcI7UT7ntShGk=; b=sx4+MMlbcuyRqU
	M35xoxT4kJpwqQqVSs2aAUtx45jUkPSdqITknCA1RvuTCez+sTf8k+V2fasDua6oZNHVgan9ZrEZy
	wwinakarEVsvb9u2NK+OlfNsPyI+mnj2PZh1G7e6xqLd7Wa3NyEOverf6FMbXz4e8Ejeib8k8Fc+l
	DE4NXKpElpWtNbYTveOvNYoyhZ7PrhrGO8xpPIOhm2zanOtd8TGPnJuy2pPWmXDB1c2kmwfDMAixv
	u5rFle3Fn0lKw1NbN+jiBKvzKElLWlj9R7ywzdyrBuQmE9EVSUz7cxNB0y0ITmoj14GXXAaGHqz0M
	VBffxcX87Z97axHcR2EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiB9X-0003hn-S2; Mon, 08 Jun 2020 06:20:59 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiB9U-0003gd-Qd
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 06:20:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591597257; x=1623133257;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=J139l9O9uD9Y3lAmLymF11CDQutodV7wt/iv4G4CBgc=;
 b=ioHlMTlrRfV3hmSqzxzAoFGqsOp7NqDTN14ArAULccrdAdG09baj5d5Y
 KG94PawUdIBuwsblAOgemtA5Dn3hnrx0wxEAXiQ98BgoMlkBhaCV7Z3vl
 zZRQFCUOwkebdExtqD2o0pYjNSvbsV0hc7ySfgxiP6f5UDKRQBp/zNM6L
 s+OGNgW7cq8Cq+X20KbpxEz9+JmIQtJs2z+F02715ociCIcKsDWdqVxqf
 65afvn/JTcMBI1NQfgqWmi7yGfvB/2azaUMHJCsWg2m86U+UuUkBQZ+1D
 TM2EI9gi1XaLrX6ztdTuTOt/qYj/1UXw6Q6alSr3hF667TSjGarIETSCO w==;
IronPort-SDR: FFnpzOlJdoaV0R44ZngAw6tFdFzgKdaFYQEWr2LmuFltxVJ15c0WqxdSBRXrbOSQ8k+ZivaLGI
 z8VVpIrdmfnH3VNDfgboY1AN3MBCsr3UBcCMXFQS89sx3K3Mb7NfqTVh+L1j7YlyCgR8WWo2cC
 9ItEwGxj7GDsBUe2a/I+h1y1wDkCD+385KVRmQ8+JbJJWkS6nEoW33M/PD9DoEPfUBRxGCDARI
 9zZZWDT0Hni0GDLiv7UGUgnuH2o4XNF8Rw/9ozddsJL2UUGCT///6sDw89Tn7MVCYozs/l2XKA
 0kA=
X-IronPort-AV: E=Sophos;i="5.73,487,1583164800"; d="scan'208";a="143748010"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 14:20:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGztljE9Ab3SdD1y/yGhnR9+JcVJiyDnjy0OmpDmB2rFQFjNWmX7Kh17131jgtQs/tsVEGl1fV4yfNUzf5NXCUNquD8Rb865iWnZsVhK4HYWQnuFSoCi5MvUyUL8UhjEWrNGlaNcumWlOo4o1UU9S3/gZn2Rsw+xTXEL6CvFelSZl1O6Jj6NYEjB+oYTbuxrAU1Crn+YtrYUBmt5tMt46oMvDM5D49XLD6w3ZVY/zEMtkLYm/lJoUHEIvjYIuHazysdYVpHrOo+xd/oOF+Ex6HpmKzFOovTWTvOg5cYtoQ8Y71I7pHfULK4DvXVebzl5xzdctoxaOX4/BJ18qTlkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFVQcj1fzL7ZtQRh6qVTLFrVDUriAnGv3QRezu4XMFA=;
 b=FHxmcSSNgxhrH+eRl4iiQU3+9Fydjn5LOh0tguqrYqjeBCQ9z5VwgntYWp7HNNl+z2DA2ZUpwJ6+6ctEU5hY3bBQW6mTpwryQ2DU6TpboLi8Vt6Tiu9CS2IT0fIDbpVbsYnDyAHuQ0sjzLW9m+wBQAv9/I4Sn4B78JwCM0jWn41/0ylhCU+VYcqxvgUDy196hillzAWJsYPJW1iNcTnjjq5Ur9DWy+CeDG9KNLd2tYWhZqPKVfRYT9EsWwmstJhKS8J1LVYeK5lbHPEo7cF4IVnctnIcvtwXcksTqVYrV/e3N/mt8nAuUZQReDSc2yFvpPK+AORpspOCLtXaY5PFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFVQcj1fzL7ZtQRh6qVTLFrVDUriAnGv3QRezu4XMFA=;
 b=oLG3D7nymVAcpfUg6MtwSY6Ox0tMEbfIYno/AENk5GCATpeN6C9UgirwU3SCGm3svuLvfRnhoPuF88OuqLMgtC4WsVfDYvrYfXq8U7weraFa5lWENjJQ035y5VoN3iXLNkGOV17tqHf9AZYkGtNe/0hLdyKcTr4dvyeqS11Z5Zg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4808.namprd04.prod.outlook.com (2603:10b6:a03:12::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 06:20:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 06:20:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: blktests test nvme/003 fails
Thread-Topic: blktests test nvme/003 fails
Thread-Index: AQHWNIJZVRL6ENIo6Uy1ge01JbudSw==
Date: Mon, 8 Jun 2020 06:20:49 +0000
Message-ID: <BYAPR04MB496561CA8847308360CBFDA686850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
 <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <fddde27a-eb61-7031-a067-5538e0fe3243@grimberg.me>
 <BYAPR04MB49651CF1169CD33108A484B386880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965217373E87DFEE2398D3F86890@BYAPR04MB4965.namprd04.prod.outlook.com>
 <96530c68-0cc0-8b88-4d3e-c2a66be44167@grimberg.me>
 <e110c297-a357-5e8d-754b-09a5faec7399@grimberg.me>
 <BYAPR04MB49658EAA5D722230E5036DE686850@BYAPR04MB4965.namprd04.prod.outlook.com>
 <d3a692a7-bc4b-215a-4d02-a6711d542d97@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0fba4ed-2435-4a01-5493-08d80b74168e
x-ms-traffictypediagnostic: BYAPR04MB4808:
x-microsoft-antispam-prvs: <BYAPR04MB48088190D285702EC05A088D86850@BYAPR04MB4808.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 44kIrH8kMy2g4hmcU7OPOdGjtplGobI5AdbmvoJ32NkPfqi1HYgtdOobvGVoyaT5oPHzZ5wzoxI1tX1DRN7gzVavKxDS/RMrFah9hgFlYX4h6k8HFMnjL2leFcp2Pep2vKeYUVYaa2OCsUoLukJzAEtrX8HNShLh91NltH9muLLe1hEdROJIAhnmZPIZLQ4QXoAifMXFSaPZwpcqFX6FLegtFtvGHJX3IyDWAc8lkJfDC+adkbkGM2KBEwzNgo22T5QwaYExUvAFAm0jbkh5h67krarahOcKyGHValvg4a9n0D5WedH4BeorJbyRehhMd+HghlwTQsj98AcOiJl0qA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(52536014)(26005)(8936002)(8676002)(186003)(4326008)(478600001)(54906003)(5660300002)(66446008)(64756008)(66946007)(71200400001)(66556008)(7696005)(66476007)(86362001)(55016002)(76116006)(6916009)(33656002)(83380400001)(2906002)(9686003)(316002)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VM5pI2Ph++6qnCTxGgXlX+5N+w8g0j5NhQPeBC57NCLUPx28PVSj4FfUXVh0ImYObR1GbivqzDjn3NcJzBET/tcd+hyiNHkdqdtdBpDCMTOPEedv3Tqmz66pA90ShOr3wCo55wWWZpNUkzMxbNUopZrbxui4pUCLqLB1tVp7UCwKV+f/Ch4E35vj1eNp0vx77fzZV1FP7sP8QhMPVzpJLc0ny8293Nk7gf+xZZIlhgCPAiDx3Heo2Bg0h24ZzZE05kKT+n9y88dgrDAGMeDh4atTe7lWFxuCcURupQIqQrd7sDPbHFTbA+Tc7JhOmFOiJFej3FTcncjnZLA71UOT+/hfHmXj6DJrIKHnWgE9aObGSJu7eGPzqw2z1a0E7uUpLHEDXzY/fSfRE1AmbhhAK33W6IDJGTZKslPKHefTuuWd3cP+I/38q+Ky6BEOzKeH8bD1Bcbb/28dUDLKq8za1RLHPC+fK4X0hLm8OV0YPWQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fba4ed-2435-4a01-5493-08d80b74168e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 06:20:49.4723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyZV6Ki6w0i72CqlZOMMQ3Jv649ymNjnTHzKxS5cz77grO75P5JoVr9lIpDG3sr+oBMNk/l7x5Oplx9Vz98vi2WY8s0R5lNQDyVuwxbm4O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4808
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200607_232056_931324_95127BA7 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi,

On 6/7/20 10:34 PM, Sagi Grimberg wrote:
> Chaitanya,
> 
> While I liked this patch better, did you check if the events are
> coming out correctly? when I ran this path I saw that I'm getting
> constant NS_CHANGE events in udevadm monitor...
> 
> I think we want patch 2 instead...

Wait, that was the bug I fixed from initial patch to Bart's original
email which was running while loop infinitely since
ctrl->nr_async_event_cmds >=1 and never could get back to 0 due to
outstanding AEN, are you still getting that with following fix ?

With following fix I can run blkttests it does pass and only generates 
one AEN from target side :-

blktest :-
----------
blktests (master) # ./check tests/nvme/003
nvme/003 (test if we're sending keep-alives to a discovery controller) 
[passed]
     runtime  11.149s  ...  10.413s

Tracing :-
-----------
# echo 1 > /sys/kernel/debug/tracing/events/nvme/nvme_async_event/enable
# echo 1 > /sys/kernel/debug/tracing/events/nvmet/nvmet_async_event/enable
# cat /sys/kernel/debug/tracing/trace_pipe
             nvme-28716 [011] ...1  5485.088313: nvmet_async_event: 
nvmet1: NVME_AEN=0x000000 [NVME_AER_NOTICE_NS_CHANGED]
^C
#

Which seems to match the behavior prior to the problem.

Can you please check following patch if problem persist then I'll send
2nd version as we agreed. (Sorry for the confusion)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6392bcd30bd7..843da121cddf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -139,12 +139,26 @@ static void nvmet_async_events_process(struct 
nvmet_ctrl *ctrl, u16 status)
                 aen = list_first_entry(&ctrl->async_events,
                                        struct nvmet_async_event, entry);
                 req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-               if (status == 0)
+               if (status == 0 && aen) {
                         nvmet_set_result(req, 
nvmet_async_event_result(aen));
-
-               list_del(&aen->entry);
+                       list_del(&aen->entry);
+               }
                 kfree(aen);

+               trace_nvmet_async_event(ctrl, req->cqe->result.u32);
+               nvmet_req_complete(req, status);
+               mutex_lock(&ctrl->lock);
+       }
+       /*
+        * When status != 0 we are called from nvmet_sq_destroy() 
context that
+        * means we need to complete remaining host posted outstanding 
requests
+        * in ctrl->nr_async_cmds[] which doesn't have 1:1 mapping onto
+        * ctrl->async_event list in order to put the reference on the 
req(s)
+        * which was taken by outstanding req(s) so that we can make 
progress in
+        * nvmet_sq_destroy()-> wait_for completion(&sq->free_done).
+        */
+       while (status != 0 && ctrl->nr_async_event_cmds) {
+               req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
                 mutex_unlock(&ctrl->lock);
                 trace_nvmet_async_event(ctrl, req->cqe->result.u32);
                 nvmet_req_complete(req, status);


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
