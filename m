Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F46EC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E2E206EB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="San+HZMT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vk8uWOhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E2E206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=plm5EXQjpeAaDSm69QCesXeGvUdm/agQi1j5Cudl75c=; b=San+HZMTSXmfLqGHMGngfISnM3
	+wG7LpuwUbxuC4/Y8YgYmLrJIzc+pNC887LBoQGW2bD4Q///ILOu5nqguirP81+zpLndlpbQ+h6NT
	7PNle6z6D+oI6PVcuH3pOU5NqS90hWJTQozqhHQPooVnTnSVfyY0y0PZPA+1vhMKJdYdEOLaYq0cT
	sL91So+F9NA40qLCiRiwLZquLCtpnmn98Asr8MEQMUi26LLU3vKezvQk0Z6x1epAHP1J5ETI6ROkp
	H6MwGaRZVJRNTERmETjBl4wL0cnqvNP5mYlo0E5iZRnh6ODh1ZQdWWgPwScjcFawkInGAEDl8EXin
	PRZH/INQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBSlh-0003tr-NJ; Fri, 28 Aug 2020 01:01:25 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBSlf-0003se-M3
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 01:01:24 +0000
IronPort-SDR: lREB8Heaw3uztehH4NCgdyGdDXLvsk6jxOI842T+PPmhFLqi+9cbMRdCLQ56akwGTkfJkdVLW4
 2IcdukMR+y3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="154004400"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="154004400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 18:01:22 -0700
IronPort-SDR: 3K3yVGiUTeWgdvchWZpy2nuF5QEK9bFSVZzjArwvkroxx1T/FFYCYUv9M7uhlgLJZ/M6bm8wRT
 Wgl+C7i+rJ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="500319234"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2020 18:01:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 18:01:04 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 18:01:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 18:01:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 27 Aug 2020 18:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkQFEGxXuF+xTg1trdSFdU2n1yWjS674Ua2POCO1pEby2KpD/z0+9L/mVt2vz8O+GWwyXhkBONhZogDUcVA2r0nGb+UkQP5db4SzhO0WUpD3TEBPjYpDGcJMOkVUsLvmLMH+oF+pUJLFTfB4HVGU5tmJY0Lk80MmcLaWxw0CRl+wMiNvtKf146glm0VJE/EoNuc7B/tuQ5vpoPYEqOgZBkAelf7Ig2NvBSdUfpo1vZrJ4hSfzqQ3BgtAWsOu/Uq9bEPyH2ZH4ZUqkG6WMr7SskbBPJs8Ct1iusgDNTldLLB2be7/CoEsVldS9kJs/jPNtesd7klhnuPCqI0epjFTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhXtZiDkfu9gDi1n2JtrTcz7qCszPyCf/j1uQBmCMsI=;
 b=UOhSvpmSf7vaE4ZuVA3BMNnSl/A4FPSJpp71/kuGLUcvR3Z25wcwvYsMIvsshYWN2pnhZEu2+Nl3q+24SqlIbpONU9ZEh6i3pNjREGcM9Juc/J3Mmc1Eqc8RvudXnYEHDrqGMfKT5NPxYxPetBgAgW2u0Rc2e3ItNfJuD4kCCAlVEEuIG0uORLKNK4cKWoDjihzxQJ9HssWzGTPye/UAIc4nW0Mu2ptUi7Oa64vI9VQdtVCtw8oo9DbdHYAwGWPqpSW80ExKfX7jG8tt8F8HychbskT4Y3pXvmwLiUNn9YnhO2x/DHPTszcRbngp1ymE/RKTIMUXADNb7DVOKRccNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhXtZiDkfu9gDi1n2JtrTcz7qCszPyCf/j1uQBmCMsI=;
 b=vk8uWOhUS0rPeBYAlywAyZfcsoVAs4EztDlPH5+Og0iCQMZbZz1JrAZDYxguxaFsmXhFicyuZryUMNYB8V8XvcOtGKkG43Dgx4N+mE0FCX+J264MWubdJFV62kBjX1gEaxv6TtsiRjhmcQITlOk5ZFLVZT/BtxKHl+y70HhCi4Y=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB2775.namprd11.prod.outlook.com (2603:10b6:a02:bd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 01:01:03 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 01:01:03 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 5/5] nvmet_tcp: release queue from group
Thread-Topic: [PATCH 5/5] nvmet_tcp: release queue from group
Thread-Index: AdZ81FpCY59L0Rh7SmOma6czAN7Vlw==
Date: Fri, 28 Aug 2020 01:01:03 +0000
Message-ID: <BYAPR11MB2869C44561D43E52B019D8C5E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [71.238.29.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 025370de-3aaf-4867-4c4b-08d84aedd60d
x-ms-traffictypediagnostic: BYAPR11MB2775:
x-microsoft-antispam-prvs: <BYAPR11MB2775D57E549FB0971B5BDB5EE5520@BYAPR11MB2775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uKL4Q8Kbx9GNAjzXARGVPTGa+UtRkvcBq5YcgFWgtvu6v7fB91X3oMBTDH8Y9Vuzjt0rNbnJiq3euzF60EhnWg97b181Z2YJMotRapUBJVD9D1Znp+zV1I6X1mPXUvrb5YSRCvyY2tdZzeI/RqYb9pT7NJGZ4dkyuuMjar5BcU6tYr2p2cU10dcZAWcI8R6UQwh9U/OKLNsQsIWy4e+iaScmbsGwT7vv9yri8Gtle42/G/KqVDyneNOJJ6Sdplp84ueHWddA2Htkxl7f3VmRVjB8dquHzdExzyR4Bt47bzCTMGNo1iRywk3wuBeyJe0RGiPFhC9Ju5Ym/qX7T++IUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(2906002)(7696005)(316002)(86362001)(8936002)(52536014)(5660300002)(6916009)(8676002)(33656002)(26005)(186003)(4326008)(55016002)(66556008)(64756008)(66446008)(76116006)(66946007)(66476007)(6506007)(478600001)(71200400001)(9686003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: fpXKjDKCZ50samCLeZSi52ppiXm1SJ2In6/AgPN+oamkrMm0+hX6pMiOcdKxOeqNg2rHUquJcougvVdzGt/JXhCSqymcZ+pv8GxYcjv3zkUNs1zwL8QulzQf7q62p1hRL9UnJOjG/PJm1t6pSISRU1Fme1F93Zy10BH67SEQuUcANU/XsIIBWNOUn9l11S7wb0dWhnUy+Vo+nvOWjcr1eZhIjNBmzm5C1iEN8FqE0qyK05NT2/5waA8EdE47JVNIT1qr8UTgJTgMNed6+2Hu7QbZS3TNdry4qImXgOTekSNc8boyzhsGUSsiW/ndKX/435jeqCO0IhR8SHnNig/kRXOwfePEiBUoIufgoUgGghQLZFhBD3ubgA+REewr8USGRkBQqAno/7qfzebXDCaMpu+Kk6+cl9l/ii+GrFjtDs5bi+v59sRCbwruMYggCvMpum9LZQfUScj7LAtNMjSiBXUqnBo835XLXprISu65WuxyWQl1NmNfNoBLLp8+bed1/tQ83xywYQaBP2DoW9yvpQgXPCBzan06NsC30Uj/dL7bVh0AS+VZPx2OgoEnC+eD7zXNbS0/U4LxG/Ywq2O4/mxPfEKYuotosN7c7RIm3MqMlbciwOgSxcUpTH8Csqy5v7lb8hYhJ3sjmRptidvO/g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025370de-3aaf-4867-4c4b-08d84aedd60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:01:03.1075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /I2osE30Cm++8GS+VW5csu406z4GYjSbog/EpvgvHVTBSwoVkR/i3Q+024LNWOxfP7apHpDAMMJhQt6BULHb68F2LqutqIorirAmeq+7e2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2775
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_210123_945781_3885F0BE 
X-CRM114-Status: GOOD (  17.10  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_tcp: release queue from group

The poll group constantly processes an active set
of its assigned queues via the work_list. While a queue
resides in the work_list the queues activate_mutex is
held.

The release changes introduced here support the graceful
transition of queue state from Live, to Disconnecting,
and finally Released as part of queue removal.

Only the group worker migrates queues from the active
work_list to the release_list during this release process.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3955dbe38f0f..1aded6f3837d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -96,6 +96,7 @@ enum nvmet_tcp_queue_state {
 	NVMET_TCP_Q_CONNECTING,
 	NVMET_TCP_Q_LIVE,
 	NVMET_TCP_Q_DISCONNECTING,
+	NVMET_TCP_Q_RELEASED,
 };
 
 struct nvmet_tcp_queue {
@@ -213,6 +214,24 @@ static inline bool nvmet_tcp_has_inline_data(struct nvmet_tcp_cmd *cmd)
 		!cmd->rbytes_done;
 }
 
+static inline void nvmet_tcp_release_queue(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_queue_group *group = queue->group;
+
+	spin_lock(&queue->state_lock);
+	queue->state = NVMET_TCP_Q_RELEASED;
+	spin_unlock(&queue->state_lock);
+	/*
+	 * Queue mutex is expected to be held, and queue
+	 * may reside in work_list. Mutex held during move from
+	 * work to release lists.
+	 */
+	if (!list_empty_careful(&queue->glist_entry))
+		list_del_init(&queue->glist_entry);
+	list_add_tail(&queue->glist_entry, &group->release_list);
+	schedule_work(&queue->release_work);
+}
+
 static inline void nvmet_tcp_queue_work(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_queue_group *group;
@@ -1221,9 +1240,10 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 {
 	spin_lock(&queue->state_lock);
-	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
+	if (queue->state != NVMET_TCP_Q_DISCONNECTING &&
+			queue->state != NVMET_TCP_Q_RELEASED) {
 		queue->state = NVMET_TCP_Q_DISCONNECTING;
-		schedule_work(&queue->release_work);
+		nvmet_tcp_queue_work(queue);
 	}
 	spin_unlock(&queue->state_lock);
 }
@@ -1257,6 +1277,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 			break;
 	} while (!time_after(jiffies, deadline));
 
+	list_for_each_entry_safe(queue, next, &group->work_list, glist_entry) {
+		if (queue->state == NVMET_TCP_Q_DISCONNECTING)
+			nvmet_tcp_release_queue(queue);
+	}
+
 	if (grp_ops > 0) {
 		pending = true;
 		group->deadline = 0;
@@ -1408,6 +1433,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 		container_of(w, struct nvmet_tcp_queue, release_work);
 
 	nvmet_tcp_remove_from_group(queue);
+	list_del_init(&queue->glist_entry);
 
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_del_init(&queue->queue_list);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
