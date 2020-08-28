Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30948C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B44206EB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jU1x28GB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="uQ07bemi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B44206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LozIGp+QMmZV8t8cTtLZlt0L4PhAl5jodG2BmqSwyLc=; b=jU1x28GBWVoWYXUy0kRKRSbDZO
	Bfn8rFGm9FjGzQnKwsefuKgthyrgmv4cD+XL/vO7glc1u58T/F5PjeeLL6DVRixZAeOHeqleUShiG
	aHriuyIr1Kjmc9oVjIsCB1bzLcvj7xWUXunEwYbgA2iWJE0tfM8COY2nw4/rwsGmlqn6rz4MZzKlF
	NZuWD7n2EfBx5qqVw/TkqKfhnpOMxOYl3rbGIeFCColD72H/Hv+IoG7GZnsfxpPv4sDNzReecR4MR
	77NNMja81jDPrlcI5Yz9x8wgI11Grrj24dhrh/DXrgcOOQY0rSdEyto0/FE6g1d9pdt99a/eqgblv
	QgwyknTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBSle-0003sY-Kz; Fri, 28 Aug 2020 01:01:22 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBSla-0003rO-7Q
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 01:01:19 +0000
IronPort-SDR: NENfz2R6vvoMOuinK6QIlljTZ2/5RBNgZip5CGF6RzUtVpBlr+1bfu+28gFOfbu+wu8W5AlHsI
 /kDc4G5G0sIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="154137669"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="154137669"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 18:01:17 -0700
IronPort-SDR: jLf1tCLlb0+HgR1SDAmzEhcbaCHSZQw3+KiFR+GwzL1oZMGVnXqyVNSz1QIN7NTzNyKKF0nhtH
 XESKtqXCOBsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="373906523"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP; 27 Aug 2020 18:01:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 18:00:57 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 18:00:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 18:00:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 27 Aug 2020 18:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZfnVmZKB+gPFKKgrwR59JP+H/G+jQVtyAo38pXG8yyGAvnQR+yVgYiRVEuhjhiWjKXEeLRjRJoZIHqdp80B+5IxqGkE+lO6t1UZgB5qdM9G4NQqEM/W6nXGyCv56RsFyj+pUn3k+QkAdXmvegXQJ9vDidUHsP1E5Rszxpp4j7iUEyanqMlyd1D8CoYIMX1GYWhnOnpFgFYhL87hkGn091qHXWT+mNQlmVXuQBe90Y9gQOoNvEzVSgQsRlgF6iVmgZMaH5x6GLmMZ36B11JrgxKkYzSh3OtMfw/1z/OAfeyQ3MwlH+zybRRW7CAQ4KXYRF5hIrM2tSkGLgA9k3fZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITV1MocFMbECJjVjs/yrDlvbKi/r3nQDH0Ji4Re8Na8=;
 b=lw+d5xseXwaz8Hj6ulv9Bv6HIKiaQWwDQUBIchPbT4zRi9KZhoy/JHX1qSkcc94IwaypuKgvOepQ3BtQFRFIGgLHjcWqhENHyk5J1pf0YHFezZEDJrUpBq1tty/nR9ZyJ66xFfnlKjgpiOj8E3HXIvJg/oDEaRZTS4wTIU7MOpr3MtNv/RiSYEpot4Sug7qVnSBEdwLTi3iyiA2ACH2mNfJLH9OoHrMHqLGBNE8LHb1NeSTC1YwefT8OxKYYYrSZek7QHmGfxUdo42dvkHmEyaAeAeKE4RUO9+5Xtrd1EfNPOT7UWDccBzCRUWHfT4Iz0e53iYrroRxoyCZtmfYCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITV1MocFMbECJjVjs/yrDlvbKi/r3nQDH0Ji4Re8Na8=;
 b=uQ07bemiYMf2VII/PDpfPWL66IaOJWXTJAgSWolomIPPuiw+UMiZYsjZM0i+EpdX55RuZi62cn1q/3vWT901vqBTM6HCWMKI8iA1/m68ZUVKH1jOagRwKuluzWRjrrHGjFwBqqz+fUuys4lwU4W62BBaqttBaiXgGh5HPhqCkto=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB2775.namprd11.prod.outlook.com (2603:10b6:a02:bd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 01:00:56 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 01:00:56 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 2/5] nvmet_tcp: introduce poll groups
Thread-Topic: [PATCH 2/5] nvmet_tcp: introduce poll groups
Thread-Index: AdZ81FozQ7VabXs2Qz6ndrlqh3rtsw==
Date: Fri, 28 Aug 2020 01:00:56 +0000
Message-ID: <BYAPR11MB286917CB10A305378D4947B5E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 35e7817e-47ec-4e53-2477-08d84aedd200
x-ms-traffictypediagnostic: BYAPR11MB2775:
x-microsoft-antispam-prvs: <BYAPR11MB2775B4D6DBC7877056590A48E5520@BYAPR11MB2775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oTUFNPv/vspLbPg1qEiJPlN1wETAFHokHLvOkdsNDZThYNalX1VTT5JLsh6OO5oNVLqdfvI5yE3LFAFqP78tj51NCimjkeD9rnhYXqfsG4cPuW9m3dhobXaGeP4YMzDHimNq559KYRikyB+qKQOSCC/AuCRjg1jFH/6u4U3hv+TmTMRVXAVJ38jmtJ+OUrIg2mJdKu9G1OUY2NEFfyFbR+NqWpIyuCfYgvUnyduOlg+PATJQNRqQSg2pEd+wo6WpUd500osEDt+AVqGj0RgR78O0G5vGCZZjXyjfRFsU4CwTC7A+gQt19WpUbst/i25/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(2906002)(7696005)(316002)(86362001)(8936002)(52536014)(5660300002)(6916009)(8676002)(33656002)(26005)(186003)(4326008)(55016002)(66556008)(64756008)(66446008)(76116006)(66946007)(66476007)(6506007)(478600001)(71200400001)(9686003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Vn4gApLZFVsSy3J9Fle0g6Dvn4hfiMjllO71/UGplbp19QqQEOXWgENFFCqQ9y9OfBhbk96NjfqtwaUlyFskmrEAQBvX1DQPt/6fzwZyXsBJRTsX2WrHS2Vpkiq86sbqGBXphisbi4u1n1th/bajnMg6yXyFEQW5R+Q2OVqCdzwrDHjdMFSHhFYWRNu4Gte34zOXNlFK5P0Yra7lr+mXE2Z2HQeC3dQMYJSfDmzoIVPSdQfPFIO4hxGZgIVUB5XUl+3463OEfq9bIR9doKF+8MHBTEs0Fu6xcarDQ3Zx4NQLaTTC7GkAD9lzaQyQ6TidPmxKsKPHVhQtNp/4I+M6SF0p01QlXpw+CtUGnb4nkW2YCaJrjWa5BXmXX4mcRm4nMnVjQ/RhLDqo/uEobUv0ofORs6t2aiuIJm9poG6JFB8pPt4mc8m4cwaPmY+GXjy9qyGHIz95N6kJA0a8UEkNu/mxm+wa+J5uX6Hd71egWMOaiVZoK2oiQf8QiXOWrc4Dn6t/TFpqNtl+JvdWaygo2RHFZAiC466ajf4NRbpzx0sDL3VBfn4s1wE/YmM4wzdSLaJrcvfWPpgFihUldDwvpQG5JKsShJaS14lBNBTrbMf2hwg25QyI1f/c98xq6Ets9zlc6ZLoS0YylukxGxfRAA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e7817e-47ec-4e53-2477-08d84aedd200
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:00:56.2904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdkATERkxT+LH6Q93eLKR6qmqGeRJKzEXic9fIxtwk7/C4kbbNI1g+Q3RJ5vUFq1uJMA1wIDmDxIOPUsZYbTuuzrsvBibc8ovp0L8BgM2c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2775
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_210118_469117_B1A77248 
X-CRM114-Status: GOOD (  23.68  )
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

nvmet_tcp: introduce poll groups

To better support increased numbers of queue
connections over a possible smaller number of available
system cores we introduce the 'poll group'.

The poll group provides a service point for a
single associated process worker entity to service a set
of assigned queues in the group's work list.
The work list of queues are monitored evenly during the
groups poll time period.

An 'active' queue is moved from the work_list into the
group's release_list before removal from group as part
of queue connection teardown. A queue mutex is
provided for controlled movement of queues between the
group lists.

Subsequent patches will build upon the 'poll group'.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   48 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 911db3f170df..3e3c217c77d4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -146,6 +146,21 @@ struct nvmet_tcp_port {
 	void (*data_ready)(struct sock *);
 };
 
+struct nvmet_tcp_group_napi {
+	unsigned int		napi_id;
+	unsigned int		napi_cnt;
+};
+
+#define NVMET_TCP_GROUP_NAPI_LIMIT     8
+struct nvmet_tcp_queue_group {
+	struct nvmet_tcp_group_napi napi[NVMET_TCP_GROUP_NAPI_LIMIT];
+	struct work_struct	io_work;
+	int			cpu;
+	struct list_head	work_list;
+	struct list_head	release_list;
+};
+struct nvmet_tcp_queue_group *nvmet_tcp_queue_groups;
+
 static DEFINE_IDA(nvmet_tcp_queue_ida);
 static LIST_HEAD(nvmet_tcp_queue_list);
 static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
@@ -1706,6 +1721,27 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static bool alloc_group_list(void)
+{
+	struct nvmet_tcp_queue_group *group;
+	int i, nr_grps = num_possible_cpus();
+
+	nvmet_tcp_queue_groups = kcalloc(nr_grps, sizeof(struct nvmet_tcp_queue_group),
+					GFP_KERNEL);
+	if (!nvmet_tcp_queue_groups)
+		return false;
+
+	// Init the group list
+	for (i = 0; i < nr_grps; i++) {
+		group = nvmet_tcp_queue_groups + i;
+		group->cpu = i;
+		INIT_LIST_HEAD(&group->work_list);
+		INIT_LIST_HEAD(&group->release_list);
+		INIT_WORK(&group->io_work, nvmet_tcp_io_work);
+	}
+	return true;
+}
+
 static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
@@ -1722,10 +1758,15 @@ static int __init nvmet_tcp_init(void)
 {
 	int ret;
 
-	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI, 0);
-	if (!nvmet_tcp_wq)
+	if (!alloc_group_list())
 		return -ENOMEM;
 
+	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI & WQ_CPU_INTENSIVE, 0);
+	if (!nvmet_tcp_wq) {
+		ret = -ENOMEM;
+		goto err_wq;
+	}
+
 	ret = nvmet_register_transport(&nvmet_tcp_ops);
 	if (ret)
 		goto err;
@@ -1733,6 +1774,8 @@ static int __init nvmet_tcp_init(void)
 	return 0;
 err:
 	destroy_workqueue(nvmet_tcp_wq);
+err_wq:
+	kfree(nvmet_tcp_queue_groups);
 	return ret;
 }
 
@@ -1750,6 +1793,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_scheduled_work();
 
 	destroy_workqueue(nvmet_tcp_wq);
+	kfree(nvmet_tcp_queue_groups);
 }
 
 module_init(nvmet_tcp_init);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
