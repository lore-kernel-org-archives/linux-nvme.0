Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B180EC43461
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B222080C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rlcpmvbF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="LHCwaa5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B222080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pAd0vtRyMZuI8RBMIHvgr8ylwypxmJ3w6LvSDAr/Rm0=; b=rlcpmvbF/a9sV25R4j13RUE2WL
	HOgnpzTYWxUtdX2AeXxHTb2xFvafAZ+j4tEWE/R8PtgmbE4JMLNzR49px9IgaHNcqcJQWVkuVBIvX
	nPYlTs/AV1MZRjJwC6Xsc58sTDBbRERKdlLqLlx3qBx8BhxAKLrlBPFw/pchwvgpguEF9+AtVafMV
	5u9kEONZbX4GrRSjDLQMeIQuOfla220DsQmCdBUm20YC86ask9cU9fbJXrgFiG3hUeOsvMQ9vz9n3
	2U5QDsUYyhxvFHeA0UvmbPXO3WfDta0bi0v84JS3R2rslHihIgiOb/ZmpawAc/MJLNYAMIQwRMHiB
	sriJ9geQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBSla-0003rR-E5; Fri, 28 Aug 2020 01:01:18 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBSlX-0003qH-2P
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 01:01:16 +0000
IronPort-SDR: Vl1lHq+Cw+ovK+IoW9UyBwUDfeIZTdmbSM+G0rObMpHMZNu4QFXjMMwRKTU9sfBDa864r8C4jD
 fuoJUG+2P1wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="220836332"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="220836332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 18:01:12 -0700
IronPort-SDR: JNhoPrqB8BGIIc/GOvwIlU3aG8PbnOAXw5TDk0QH8rvhgubS2SKOjdC0YOeeiXEhuppRzisVJP
 OXx8/6ogHIpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="323816618"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2020 18:01:12 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 18:01:00 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 18:01:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 18:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGP5cHzkWQWb9PuYL18PUFig60H6ouOlmC5da13gkosML5rGx1X88eDfjxwXMCN7iLpP343J2mPk5AkaEP49lT0y2uCuVSnEjv+01J6TEXUX6J6ZutoOJARyrCARGD6YElrC97uWNfBgyyZtpIy5XEOy1TEI0OnBfU52Z8iRN+Kfyr87apwpSKvElBq/rPkMaJh1iVcU5vD/I7/8j/l56+SYSk13f341O8LQXE0cuzgR09Gulc0kxmIJaoBHFaFKo5HOam17DaoaBfoiU/x33zMwc/iBzF/ntTfJWDtp0U+LcgeP9/CQhYEqoWL8edBddEIbjd4DNZxe0goMZ0Jqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOfiYU+kz46IxVlkdy7pzBY+i7ceZvgPfa74hHVxNwQ=;
 b=ZHweIRkuWR3RN0D62dHpkD8iCJmOzBjT1hgGvR6972aQjwCzCqUWMpE85SVYgUPoVOhS+Ql5VQLdNEaJ1aLis3UKPFfPCSHkpW6wg7wfAweIl5hfXQ4S9URSgND1UUImHc3W69QkbZzRzHyHAh4iVBJilNcsQVkk7C7pR2cIEg9wPRbBbJGEX169JHhq1+Otf7Mo7gK4KRQDWAzRYOCWW4mmjvmO0N1lJq5pZI+F2XNHcuf+MU4w8zrOhi5Mw2MUqRCH5DfyrMOtjBQFvLaUAQHrt2HmLi6bEtY1moCIC7n4Tsr5PPFwNvb0ZyF7l5iwDrkNkZosBPOjSGIUsK/Fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOfiYU+kz46IxVlkdy7pzBY+i7ceZvgPfa74hHVxNwQ=;
 b=LHCwaa5vLg5dEeTHoK93sHpjKOTMsA42/6NbD7N98A+ocJQZbyVI45XDjOEfUhtXvO0wqKC7iaMj0flCvmmz7Pq9PAoUb532AWgQNyacc6tXDwuHXhqVxUcoNO+bEjPO+xwme6bnLmlFnrpQL0A9bsDAyjKmI6Twulecn4rpppw=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB2965.namprd11.prod.outlook.com (2603:10b6:a03:82::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 01:00:58 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 01:00:58 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 3/5] nvmet_tcp: assign queue to group
Thread-Topic: [PATCH 3/5] nvmet_tcp: assign queue to group
Thread-Index: AdZ80wA9LrLs7sR4QTer5VG+X/4kyA==
Date: Fri, 28 Aug 2020 01:00:58 +0000
Message-ID: <BYAPR11MB28695D53112B8AA5BAF552B3E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 335c91a5-c53b-4b51-4411-08d84aedd360
x-ms-traffictypediagnostic: BYAPR11MB2965:
x-microsoft-antispam-prvs: <BYAPR11MB29655EA45ED17BFACF652A18E5520@BYAPR11MB2965.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJkbALRM/FD8F4qGMCfV8iktBhAjzVsK2Zj1zQAgUqSjAz4iu+lFTDYDzQFVXPICSChTvPwpwPFakyiWjXt/Pc3EHjn6QFYnnpX94hSzPbKYgwnpCM9kGMT0RRb+L0RLWnvhI8llRx4kFD5TdAZLGTKfZemlvgQ3v1tmxRTOZn5TwNQYWOnSEppA9AiGN1r2PXtH3fgyxInokwsKO0rEb1FHE2YXJVmmesy+TmiMEsn1ffJriGwBSMUpomkcjdxPRqUg4cAGVpFt2OfAZ4oHlEM+w+zGGn/hY5Lo2faK0XDEiuzCKToSMJi54yk385++XM3PNHw0jOKWLrsv9qrKXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(2906002)(4326008)(52536014)(55016002)(6916009)(83380400001)(8936002)(5660300002)(8676002)(6506007)(26005)(66946007)(9686003)(478600001)(71200400001)(76116006)(7696005)(66476007)(316002)(86362001)(66446008)(64756008)(33656002)(66556008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: YCKK+QETFK5uLrPeSGg7NBWOnwAeagsrC9R3PiW/hJG9emE4h4keDgZOOk4eR+p4/fmflpvoecyMUxV5tNqGFw0ucwUkuoie3USbU2WpN4Hts4iyfn92sRh6AJ1uk9A080kf6nai9mbTa0MYqufkrsrLq10dSRBnsL4BpLU/O68Nntrs03fQK9xQz8eyR4cOfxKHCzDr8o3bFUiOVA5QYsAlgtTFd3GGI3S2uL/GcswZU4BJg1RSUevJhwFdS1Q2aJ6hCPSsEOEP/+NiM3EzcUsoa0hpcp7hLhWMfU2o2WEy8SV0qrcGdsFvOpwptjDvK2kMDZ7tb6Ca6blvEgyUfD4L3hqTDc9UUvTqHx4Ng6tzXmgFbdoQZAPgpuITGIgSAxS7Yk/qFBxE3bAB4ZGiALaE+SUo6xVxL+i0xLip/SjdYQpuVcL1oNtvQ2Ws6fgmI9ACSlovs5i5M4OUHpFxLpl4IkKZGicoVlSLRsxSfea/uYSPwcguaM4WNgOl78DwsoIYjkeaw4Xq9IjuBOYYTqhuMtzBxYt0Q2dI7lk5710EnygYgcLJnLhn9Nhs0VknynFp/1Zg4OawOOP9vXRG8r2DYg3yxR09WR/INI11QGOkVC2GDTqVwY38wtxHP4lqhh0sNrcKy2UX2TpaMr2ENw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335c91a5-c53b-4b51-4411-08d84aedd360
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:00:58.5871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ/uBvYkyD3tkT2Z8Ikaa6qqxVaP9fEuhYQN4kPq3IJgskE6Hfkva1IOt3gycb8Gt48Ty3LHpnbmTM2GsAYjaZTpWYD384afnU8nHRJDrIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2965
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_210115_314921_021EE470 
X-CRM114-Status: GOOD (  25.00  )
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

nvmet_tcp: assign queue to group

Each newly created nvmf target queue connection is
assigned to a specific poll group.

The queue group assignment is based on the queue's socket
so_incoming_cpu value.  Since there is a pre-allocated
poll group for every available active CPU, this policy
will provide fast direct queue to poll group assignment.

The unique napi_id of the new queue socket is added to a
group list.  Multiple napi_ids are maintained per group
to support multi-port configurations where the number of
socket connections could exceed the number of active CPUs.

The group napi_ids are maintained for future patch for
polling when the group is found to be idle.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   78 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3e3c217c77d4..84dd5b300a1d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -128,6 +128,7 @@ struct nvmet_tcp_queue {
 
 	int			idx;
 	struct list_head	queue_list;
+	struct nvmet_tcp_queue_group *group;
 
 	struct nvmet_tcp_cmd	connect;
 
@@ -169,6 +170,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
+static void nvmet_tcp_remove_from_group(struct nvmet_tcp_queue *queue);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -1367,6 +1369,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, release_work);
 
+	nvmet_tcp_remove_from_group(queue);
+
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_del_init(&queue->queue_list);
 	mutex_unlock(&nvmet_tcp_queue_mutex);
@@ -1487,6 +1491,73 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return 0;
 }
 
+static inline bool nvmet_tcp_add_group_napi_id(struct nvmet_tcp_queue_group *group,
+						unsigned int napi_id)
+{
+	int i, free_index = NVMET_TCP_GROUP_NAPI_LIMIT;
+
+	for (i = 0; i < NVMET_TCP_GROUP_NAPI_LIMIT; i++) {
+		if (group->napi[i].napi_id == napi_id) {
+			group->napi[i].napi_cnt++;
+			return true;
+		} else if (!group->napi[i].napi_id && free_index == NVMET_TCP_GROUP_NAPI_LIMIT) {
+			free_index = i;
+		}
+	}
+
+	if (free_index < NVMET_TCP_GROUP_NAPI_LIMIT) {
+		group->napi[free_index].napi_id = napi_id;
+		group->napi[free_index].napi_cnt++;
+		return true;
+	}
+	return false;
+}
+
+static bool nvmet_tcp_add_to_group(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_queue_group *group;
+	bool assigned = true;
+	int i, nr_grps = num_possible_cpus();
+
+	group = nvmet_tcp_queue_groups + queue->sock->sk->sk_incoming_cpu;
+	if (!nvmet_tcp_add_group_napi_id(group, queue->sock->sk->sk_napi_id)) {
+		/*
+		 * attempt assignment to another group with free napi id slot
+		 */
+		assigned = false;
+		for (i = 0; i < nr_grps; i++) {
+			group = nvmet_tcp_queue_groups + i;
+			if (nvmet_tcp_add_group_napi_id(group, queue->sock->sk->sk_napi_id)) {
+				assigned = true;
+				break;
+			}
+		}
+	}
+	if (!assigned)
+		return false;
+
+	queue->group = group;
+	return true;
+}
+
+static void nvmet_tcp_remove_from_group(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_queue_group *group = queue->group;
+	int i;
+
+	if (unlikely(!group))
+		return;
+
+	queue->group = NULL;
+
+	for (i = 0; i < NVMET_TCP_GROUP_NAPI_LIMIT; i++) {
+		if (group->napi[i].napi_id == queue->sock->sk->sk_napi_id) {
+			if (--group->napi[i].napi_cnt == 0)
+				group->napi[i].napi_id = 0;
+		}
+	}
+}
+
 static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1528,13 +1599,18 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
+	if (!nvmet_tcp_add_to_group(queue))
+		goto out_destroy_sq;
+
 	ret = nvmet_tcp_set_queue_sock(queue);
 	if (ret)
-		goto out_destroy_sq;
+		goto out_remove_from_group;
 
 	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 
 	return 0;
+out_remove_from_group:
+	nvmet_tcp_remove_from_group(queue);
 out_destroy_sq:
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_del_init(&queue->queue_list);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
