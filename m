Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB50C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 08:43:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACBD206C3
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 08:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F7VAZCoc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jl4ARe8n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JYSuVkIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACBD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=iVEwcIPilHn9ln0O1IXhDfVnb7pd+xcfzUS2qAdBOlA=; b=F7VAZCocS4y0sO
	t7Ka6T8iBEVcXGg95Hi/DGJ5eMctmw/N0OUseuAbcO477k+qOj89nW1oB5fnxPARMf50k+U+nn9P8
	neeDVOS6WbFSB1GgGeQ+ccaBzigX9+wZ07CrS2MgM/U3WHXn9mysmkAq2oito717drioMNHIPM2iN
	NlLmxWeQb+R8jD1O6dfNDTzEueM3WDyM237/UYZwKgZDXgonNIcBuUmMI8tvPtK4k1cATpOxHfzEG
	KdofW+ZTdQuDk+NtyDBO8TrkfwqsZUdN166UTjFwyocPfA/xSN78QPjPcR7YSCBQUXhZ4vZ35yhSy
	u9U+vBM9SmdTzbu5ifZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgOzx-0002Gj-8k; Wed, 03 Jun 2020 08:43:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgOzt-0002G7-KV
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 08:43:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591173821; x=1622709821;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Wl68cqr/XN7vVlFK2BUUciPO2Zr6rRvuOAA3T/m4Bq0=;
 b=Jl4ARe8nzNb7sMl8aWzu0FuB8RNkc7zP4n+8B73+mekFB9xWy3v0wHAg
 vOoFrr8g4cqZ3uW+NZGgFDiVhfeo2ImZ0zncv45KvfrsCzboCgdEbbRkL
 RmcZ5+9mCw1L2h45Qjhe7U/8Dzins7XjrXGhPy5VSvmulaP+ZvDhDh675
 NBJV+xZKVKYc9Kp00lGWqcNd0YdEvHxryOqIP+a4xR/qM5uukkzBLWNG0
 79Y3QgEJL2XZYX4GK0sENmHbeGSUmKf3PWnz6kAp2EgT1DsQuqx6z/hFR
 C8juUEx0xHHydCv3gUqFdgutpGTQGu563FQASRy/wpvrCUD3ueBEsW2pu A==;
IronPort-SDR: PWdUVOevzINaiAIRbJ/Vi9vHHbdql+RGN6vjieadp3awlqQ94Ok+l44z+CVwXxk36YiF1cDj0b
 lhgFYxfuMRspblyR2eNWPzRipHdToUMIlUV9m2qeBXCGFTnRhF5vsC3HHUj5KnruJeMdUnHCGM
 WvrRqFo+gTRtllNfEdzHyZyndJ4T+zcWNiOpfELlqguwsqSnDXqgzk9yma+fZOH3DNRD9m3zEq
 nH9Xh1MIQ/OMhe3MorWQCozr9+c5114Gxnah3s6FSjcxAXhTOYKPbyX1r9OAEcbRlnNHjDZ97g
 PPs=
X-IronPort-AV: E=Sophos;i="5.73,467,1583164800"; d="scan'208";a="248186728"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2020 16:43:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsuf0QLWfrIyvQoAsFD5WUG1z4e30clgVqwluXjU5QpvBCK/aCecFQtGMQeeAVIs0N1ORLJn4aChEgUI7MacxcYVQh8D93ds0ott+9Odapbt5TvOAi43xrNoqz8cWpjSTzgNQWlPbfuG1RppS8/fFCAI4SyUFQDJ9LV8EIfL+g3AFwqPqrwVMnrGVdZgZo5inefB+hUaVPDcuK470GARaUAL2v827d7KuJ2/C3gTbXzC/yeCRdveTmc3RWMmD4/wGAPJkWR8/Apad1FHNksJK6n4+jl6UNb0XniiLpz4FS4QinbSH6/yGrMIWum3HDwtNfulS622zpU9MGO4/voI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7ZOBUtz9vfF7893WyMPM4g2+JGK+JTuLvNmEOcbC7I=;
 b=AOeIEDvhfZFTO6nMG0Hcf7CnwcqZfX+M0UY1HVH5nka0BP67vaFBlktkNqUyYnN19pXQcsGtGVYiPTHMbUIPbuO8J05p6ZmnOPspNHUaaXI9I7TSvW0H3AjgAFQ8r74s4cBLLChJxIFucbvMo8OR51ceJ504QG2nZXqI2CqxxTnKa2AWa/JMY0blSPpT+ANS107e8/A33AGxryIj3VPQgSAEywnT3aGk5foPrbDjY9GsmL0RFzGlM2eyfXR+p0S1Jc6RMitZOwg2baRFmWRlMPjHYrxZUwcR/eYKLR0Rq7Rdcxyc6+8mlu7L2dTiydecXEc77yd9UvC773Q3MVMrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7ZOBUtz9vfF7893WyMPM4g2+JGK+JTuLvNmEOcbC7I=;
 b=JYSuVkINkazqi9ukS4NknaEBNfgI0hT+3dEV/nQJCvDRNzDHWVR+EhtwbAi36GuQshRYepW9w9Cym+5/aEV+dP32fyqwHbsSISVBNEkovmXg3gwlnslDLC0xkyya7xUHTtDv+Tm6J8aq5f7gTF+7Ec/oyp+rOIxVJxcTvnkPlSU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6117.namprd04.prod.outlook.com (2603:10b6:a03:ef::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 08:43:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 08:43:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: blktests test nvme/003 fails
Thread-Topic: blktests test nvme/003 fails
Thread-Index: AQHWNIJZVRL6ENIo6Uy1ge01JbudSw==
Date: Wed, 3 Jun 2020 08:43:38 +0000
Message-ID: <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f2c68ef-ea6d-46c9-dced-08d8079a35de
x-ms-traffictypediagnostic: BYAPR04MB6117:
x-microsoft-antispam-prvs: <BYAPR04MB611773292C09EB23C45B5F0686880@BYAPR04MB6117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wYQl4tVDwOlOsjicG4nYHJcDQEdoMt1BH5aPf+SauDABecEUVDeLIlHRI1O7ikTNBCZZ2zNaaB1wjgomssgyGuzNhsbGmjBZooIiiX0xGyzhlF0HYILwQCmNAva7/+Nsc8k1hD9bn/LQBj1+eYDTYWQBtotpsh6vzUipGD/QAo/P+muySvd/1hRU4Glm6qvrm+I635GipDBbVOwfjT8ul3XnJqhq5UjedVE/IQRO0ZYXOUdwfh11Rc3OefOgjz3NiAw1R303CuxPnVSuI1F+sZsaKQGdnzWMQe9xrKjYme0eZthKv4lIr1m1wyns5I4Kq2nn8XxHe3pVYbm+VXfDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(33656002)(55016002)(83380400001)(71200400001)(6916009)(9686003)(5660300002)(4326008)(52536014)(2906002)(478600001)(54906003)(8936002)(66476007)(66556008)(6506007)(66946007)(86362001)(64756008)(7696005)(76116006)(66446008)(186003)(316002)(26005)(8676002)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: diD0MAr9IpJfdNddUYOmkdhQO118TbltYH9/v2833O16K4hE0FG2gCliEOwKxsHPIImQpGJrGS6SAFZnk3vonYdEKOSuGlLHxozf6V2T4Q7OqYC75DHFtnPBSd+fbaJ6B+3zSuzQnxXnKORuBh8xRHcrUT19MzgFa2qsdKaFUwjqSY1OQH0h7wlGWkIxgzhvrvOFpz1uYIDh9dLwL5g8K47vBXCW3IzpIe5cNIeagB5/7hpSWZH+cnhLKfrP/EjeXnBvP3DRjmFmMAxmTwo3g7u4akypzybh5VRbF5aD8b3098YYyr/PFoTZZIdGvtdM6PrdmW4BFz3wQTCmre9xf1xj7u3kIDvtHlnyDqi55LVmivrypqfrMrITL8e1Sg4gKOOU7mJtaAqDlmKbvLpQSyJviyjJfq3R1jf/LsOnAWyetVxhq3+Uq6RMB3onFpd13hn/Ulkf3c+wM6b1SVUUiguZ1mR6SD4tVvGB2NvmXRE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2c68ef-ea6d-46c9-dced-08d8079a35de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 08:43:38.1931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yShv0kfclc00Ilqtoma6ZAInjyVgpjIzUm3to/YvOypmvXicafHhpUjFvOW0KGNzsGlSYAUZOsnH6H+/mg2duX4s2/5hPZQQ5iUca7qszxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_014341_775787_5AA84F7A 
X-CRM114-Status: GOOD (  16.87  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Bart,

(+Sagi)

On 5/27/20 4:55 PM, Bart Van Assche wrote:
> Hi,
> 
> This morning I updated my local copy of Jens' for-next branch. Since
> that update test nvme/003 fails. Is this perhaps a regression? This
> is what appears in the system log if I run that test:

Can you please let me know if the following patch fixes your problem ?

 From e2b5e0bc63d6544feda4354c92c6c9fab11a3649 Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 3 Jun 2020 01:31:26 -0700
Subject: [PATCH] nvmet: free outstanding host AEN req

In function nvmet_async_event_process() we only process AENs iff
there is an open slot on the ctrl->async_event_cmds[] && aen
event list posted by the target is not empty. This keeps host
posted AEN outstanding if target generated AEN list is empty.
We do cleanup the target generated entries from the aen list in
nvmet_ctrl_free()-> nvmet_async_events_free() but we don't
process AEN posted by the host. This leads to following problem :-

admin sq at the time of nvmet_sq_destroy() holds an extra percpu
reference(atomic value = 1), so in the following code path after
switching to atomic rcu, release function (nvmet_sq_free()) is not
getting called which blocks the sq->free_done in nvmet_sq_destroy() :-

nvmet_sq_destroy()
  percpu_ref_kill_and_confirm()
  - __percpu_ref_switch_mode()
  --  __percpu_ref_switch_to_atomic()
  ---   call_rcu() -> percpu_ref_switch_to_atomic_rcu()
  ----     /* calls switch callback */
  - percpu_ref_put()
  -- percpu_ref_put_many(ref, 1)
  --- else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
  ----	ref->release(ref); <---- Not called.

This results in indefinite hang:-

  780 void nvmet_sq_destroy(struct nvmet_sq *sq)
...
  789         if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
  790                 nvmet_async_events_process(ctrl, status);
  791                 percpu_ref_put(&sq->ref);
  792         }
  793         percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
  794         wait_for_completion(&sq->confirm_done);
  795         wait_for_completion(&sq->free_done); <-- Hang here

Which breaks the further disconnect sequence. This problem seems to be
introduced after commit 64f5e9cdd711b ("nvmet: fix memory leak when removing
namespaces and controllers concurrently").

This patch processes the ctrl->async_event_cmd[] until there are no cmds
available in array irrespective of aen list if empty or not and uses aen
list entry if available.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
  drivers/nvme/target/core.c | 16 ++++++++++------
  1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6392bcd30bd7..40d80b785ecf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -135,15 +135,19 @@ static void nvmet_async_events_process(struct 
nvmet_ctrl *ctrl, u16 status)
  	struct nvmet_req *req;

  	mutex_lock(&ctrl->lock);
-	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
-		aen = list_first_entry(&ctrl->async_events,
-				       struct nvmet_async_event, entry);
+	while (ctrl->nr_async_event_cmds) {
  		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-		if (status == 0)
+		aen = NULL;
+		if (!list_empty(&ctrl->async_events))
+			aen = list_first_entry(&ctrl->async_events,
+				       struct nvmet_async_event, entry);
+		if (status == 0 && aen)
  			nvmet_set_result(req, nvmet_async_event_result(aen));

-		list_del(&aen->entry);
-		kfree(aen);
+		if (aen) {
+			list_del(&aen->entry);
+			kfree(aen);
+		}

  		mutex_unlock(&ctrl->lock);
  		trace_nvmet_async_event(ctrl, req->cqe->result.u32);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
