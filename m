Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D03BC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 04:26:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385C120885
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 04:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jaOswp1n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="fmwhbfRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385C120885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yBs0FtHUBbNgIgJ4IhHAX39j2WaM9sOOMOBnEc0Xcrc=; b=jaOswp1nhNxIDQepvaoiRjQib
	rZE7gfOHZ7FAEPBx/UxesY63pNPT5cIJVqAVK3OB41T9IMSKqf4K9GLI3TVWlhTVkFJfzB/aizpNF
	Opk8QibdwoHiN8lHxUWepcJOE/Cg/jpWX6xk/h018GBFyUQicTLErcpFZGHGxQuwW75rJQpxMGOt7
	22c5Lm9FyV1CWaQA7Ei5W9ZwkqZZ3HsouVjt505UR90UiZC0ouDmt7ueXciFBsd9IzbA1BC+vKYty
	5OkwXalvy5XWz1lqcbftFJFkqAF//i/A271iJtKMVu1bijZzAE0FuNFO2Ay6OMkynJsqc54Cqaz+0
	AmLof3ROA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6RIg-0002yS-36; Fri, 14 Aug 2020 04:26:42 +0000
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com
 ([40.107.244.68] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6RIc-0002xS-AG
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 04:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkZIE6CYLh9oDZO2DLM6k2g7TyOSuBnpEolSMYVIXXpVBdNFW0H63CYIbUCHWWeG+LbLwotKsGcO2azKkaKFDsa/vy5HUgL5NCgZV+ce0qS9eIxfPdflXhhpytAOtPMzKmRXE6/4I4IQ7EoUGQf9BhCrqcS7TWpcUkxFUN3EwCAOGLAcAAoBclELMUGkPF+6S/OWq3ErZFVZXk7nR9QcVucwGmYRV9z6r/A+0dM/OjwouGukwfYNh2yF8mDKwTE+Xjo2gybsx39IkyQ5xm+UGVOAbuAKpLxUVCzx42y/dK/xGCoycBGqp3rhyPrWWQ4BUIXHG/2PBToWx4c2HBml3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGjpFgYM+u1jyKjLc0eDzh/mj14XFZVRTGqL1VpnjsE=;
 b=HyfJ0B/oCwNaxm6WLTmVZyOvq9ngp2mWBYVf1y0xzf756a0on8HTeURKPTxu/mAA97sd2BJZoxm+Qh8/LW4Lnfla+3j1kn+Jo89kuobhkbwYnfiZjfgjjSUhKrWmKJDV/5gggqXIckIj6JXMUJj84I00przNoLNXr6RLZo8PB0oMcKNOQZmpx5FEX0l39odlQaUDjQH0nxfKIXERWl3tfnE2hQKhBBetD0GV7KFzQu19SgwjGC/NF4RfBsbbv8UNolUTYQxdXF0eVtkS+Ot9Ae03xrVCFif7AgOm/WpdJUnM1gS8pckAjHC0t/8IYNJ0alvXX5kyGPZIQzBe+WW+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGjpFgYM+u1jyKjLc0eDzh/mj14XFZVRTGqL1VpnjsE=;
 b=fmwhbfRVH0OLeVqh4kMxTfYbT20CrGfJcQrWIJR/HETOhnFqba8pti2vKQRBib7N+ZFtxV7MjIBsXPoc7rl2VDpYQ/FY7hCI24PiB3X3BfIHcrK+yJAItJhVo7BKyXnJcOwEkPCcJIqm6gr3C09yShq/QB77W59175Y0OaxibkI=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (20.179.140.160) by
 BN7PR06MB4082.namprd06.prod.outlook.com (52.132.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Fri, 14 Aug 2020 04:26:30 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9%3]) with mapi id 15.20.3283.018; Fri, 14 Aug 2020
 04:26:30 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@redhat.com>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Thread-Topic: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Thread-Index: AQHWcYDS3N6K/RiKVU6UaUdcYydCWqk2K/2AgAAkgwCAAA/bgIAAX76A
Date: Fri, 14 Aug 2020 04:26:29 +0000
Message-ID: <7A5B9516-373E-41A3-94F8-5ED16BB968CE@netapp.com>
References: <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com> <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com> <20200813153623.GA30905@infradead.org>
 <20200813174704.GA6137@redhat.com> <20200813184349.GA8191@infradead.org>
In-Reply-To: <20200813184349.GA8191@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c953dad-d3b1-413a-3d71-08d8400a37a4
x-ms-traffictypediagnostic: BN7PR06MB4082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB408276D712902FF3B7C722A2E4400@BN7PR06MB4082.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(6486002)(86362001)(36756003)(54906003)(53546011)(2616005)(6506007)(33656002)(8936002)(2906002)(4326008)(110136005)(316002)(6512007)(8676002)(83380400001)(107886003)(76116006)(66446008)(64756008)(186003)(66476007)(71200400001)(91956017)(5660300002)(66946007)(66556008)(478600001)(26005);
 DIR:OUT; SFP:1101; 
Content-ID: <66C07CD1A8013D478B4CAB755053F779@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c953dad-d3b1-413a-3d71-08d8400a37a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 04:26:29.8907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2xwAOZ9Cl47hHxxeWa6jX8tOna8l0UyQUAhpMvq7C/Vf7aMEc4JXqTms9FEi6oRCvJKkoFZCd2KOE9ZHKN7WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB4082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_002638_578139_2D77CEB6 
X-CRM114-Status: GOOD (  24.65  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Ewan Milne <emilne@redhat.com>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/13/20, 2:44 PM, "Christoph Hellwig" <hch@infradead.org> wrote:

    On Thu, Aug 13, 2020 at 01:47:04PM -0400, Mike Snitzer wrote:
    > This is just a tweak to improve the high-level fault tree of core NVMe
    > error handling.  No functional change, but for such basic errors,
    > avoiding entering nvme_failover_req is meaningful on a code flow level.
    > Makes code to handle errors that need local retry clearer by being more
    > structured, less circuitous.
  
I don't understand how entering nvme_failover_req() is circuitous. 

This code path is only taken if REQ_NVME_MPATH is set which - unless I am mistaken - in
the case that you care about it will not be set.

    > Allows NVMe core's handling of such errors to be more explicit and live
    > in core.c rather than multipath.c -- so things like ACRE handling can be
    > made explicitly part of core and not nested under nvme_failover_req's
    > relatively obscure failsafe that returns false for anything it doesn't
    > care about.

The ACRE handling is already explicitly a part of the core.  I don't understand what
you are after here Mike.  Are you saying that you don't want the ACRE code to run
when REQ_NVME_MPATH is clear?

    If we're going that way I'd rather do something like the (untested)
    patch below that adds a dispostion function with a function that
    decides it and then just switches on it:

Christoph, it looks like you've moved a lot of stuff around here, with no actual
functional change.... but it's really hard for me to tell.  Please be sure to cc me if this
becomes a real patch.

How does your patch solve the problem of making dm-multipath work with command retries?

Mike, do you want the nvme-core driver to retry commands on the same path, with CRD, for the dm-multipath
use case... or are you looking for a different treatment of REQ_FAILFAST_DEV... or what? 

Maybe I'm not seeing it.

/John

    diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
    index 88cff309d8e4f0..a740320f0d4ee7 100644
    --- a/drivers/nvme/host/core.c
    +++ b/drivers/nvme/host/core.c
    @@ -241,17 +241,6 @@ static blk_status_t nvme_error_status(u16 status)
            }
     }

    -static inline bool nvme_req_needs_retry(struct request *req)
    -{
    -       if (blk_noretry_request(req))
    -               return false;
    -       if (nvme_req(req)->status & NVME_SC_DNR)
    -               return false;
    -       if (nvme_req(req)->retries >= nvme_max_retries)
    -               return false;
    -       return true;
    -}
    -
     static void nvme_retry_req(struct request *req)
     {
            struct nvme_ns *ns = req->q->queuedata;
    @@ -268,33 +257,75 @@ static void nvme_retry_req(struct request *req)
            blk_mq_delay_kick_requeue_list(req->q, delay);
     }

    -void nvme_complete_rq(struct request *req)
    +enum nvme_disposition {
    +       COMPLETE,
    +       RETRY,
    +       REDIRECT_ANA,
    +       REDIRECT_TMP,
    +};
    +
    +static inline enum nvme_disposition nvme_req_disposition(struct request *req)
    +{
    +       if (likely(nvme_req(req)->status == 0))
    +               return COMPLETE;
    +
    +       if (blk_noretry_request(req) ||
    +           (nvme_req(req)->status & NVME_SC_DNR) ||
    +           nvme_req(req)->retries >= nvme_max_retries)
    +               return COMPLETE;
    +
    +       if (req->cmd_flags & REQ_NVME_MPATH) {
    +               switch (nvme_req(req)->status & 0x7ff) {
    +               case NVME_SC_ANA_TRANSITION:
    +               case NVME_SC_ANA_INACCESSIBLE:
    +               case NVME_SC_ANA_PERSISTENT_LOSS:
    +                       return REDIRECT_ANA;
    +               case NVME_SC_HOST_PATH_ERROR:
    +               case NVME_SC_HOST_ABORTED_CMD:
    +                       return REDIRECT_TMP;
    +               }
    +       }
    +
    +       if (blk_queue_dying(req->q))
    +               return COMPLETE;
    +       return RETRY;
    +}
    +
    +static inline void nvme_complete_req(struct request *req)
     {
            blk_status_t status = nvme_error_status(nvme_req(req)->status);

    -       trace_nvme_complete_rq(req);
    +       if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
    +           req_op(req) == REQ_OP_ZONE_APPEND)
    +               req->__sector = nvme_lba_to_sect(req->q->queuedata,
    +                       le64_to_cpu(nvme_req(req)->result.u64));
    +
    +       nvme_trace_bio_complete(req, status);
    +       blk_mq_end_request(req, status);
    +}

    +void nvme_complete_rq(struct request *req)
    +{
    +       trace_nvme_complete_rq(req);
            nvme_cleanup_cmd(req);

            if (nvme_req(req)->ctrl->kas)
                    nvme_req(req)->ctrl->comp_seen = true;

    -       if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
    -               if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
    -                       return;
    -
    -               if (!blk_queue_dying(req->q)) {
    -                       nvme_retry_req(req);
    -                       return;
    -               }
    -       } else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
    -                  req_op(req) == REQ_OP_ZONE_APPEND) {
    -               req->__sector = nvme_lba_to_sect(req->q->queuedata,
    -                       le64_to_cpu(nvme_req(req)->result.u64));
    +       switch (nvme_req_disposition(req)) {
    +       case COMPLETE:
    +               nvme_complete_req(req);
    +               return;
    +       case RETRY:
    +               nvme_retry_req(req);
    +               return;
    +       case REDIRECT_ANA:
    +               nvme_failover_req(req, true);
    +               return;
    +       case REDIRECT_TMP:
    +               nvme_failover_req(req, false);
    +               return;
            }
    -
    -       nvme_trace_bio_complete(req, status);
    -       blk_mq_end_request(req, status);
     }
     EXPORT_SYMBOL_GPL(nvme_complete_rq);

    diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
    index 3ded54d2c9c6ad..0c22b2c88687a2 100644
    --- a/drivers/nvme/host/multipath.c
    +++ b/drivers/nvme/host/multipath.c
    @@ -65,51 +65,32 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
            }
     }

    -bool nvme_failover_req(struct request *req)
    +void nvme_failover_req(struct request *req, bool is_ana_status)
     {
            struct nvme_ns *ns = req->q->queuedata;
    -       u16 status = nvme_req(req)->status;
            unsigned long flags;

    -       switch (status & 0x7ff) {
    -       case NVME_SC_ANA_TRANSITION:
    -       case NVME_SC_ANA_INACCESSIBLE:
    -       case NVME_SC_ANA_PERSISTENT_LOSS:
    -               /*
    -                * If we got back an ANA error we know the controller is alive,
    -                * but not ready to serve this namespaces.  The spec suggests
    -                * we should update our general state here, but due to the fact
    -                * that the admin and I/O queues are not serialized that is
    -                * fundamentally racy.  So instead just clear the current path,
    -                * mark the the path as pending and kick of a re-read of the ANA
    -                * log page ASAP.
    -                */
    -               nvme_mpath_clear_current_path(ns);
    -               if (ns->ctrl->ana_log_buf) {
    -                       set_bit(NVME_NS_ANA_PENDING, &ns->flags);
    -                       queue_work(nvme_wq, &ns->ctrl->ana_work);
    -               }
    -               break;
    -       case NVME_SC_HOST_PATH_ERROR:
    -       case NVME_SC_HOST_ABORTED_CMD:
    -               /*
    -                * Temporary transport disruption in talking to the controller.
    -                * Try to send on a new path.
    -                */
    -               nvme_mpath_clear_current_path(ns);
    -               break;
    -       default:
    -               /* This was a non-ANA error so follow the normal error path. */
    -               return false;
    +       nvme_mpath_clear_current_path(ns);
    +
    +       /*
    +        * If we got back an ANA error we know the controller is alive, but not
    +        * ready to serve this namespaces.  The spec suggests we should update
    +        * our general state here, but due to the fact that the admin and I/O
    +        * queues are not serialized that is fundamentally racy.  So instead
    +        * just clear the current path, mark the the path as pending and kick
    +        * of a re-read of the ANA log page ASAP.
    +        */
    +       if (is_ana_status && ns->ctrl->ana_log_buf) {
    +               set_bit(NVME_NS_ANA_PENDING, &ns->flags);
    +               queue_work(nvme_wq, &ns->ctrl->ana_work);
            }

            spin_lock_irqsave(&ns->head->requeue_lock, flags);
            blk_steal_bios(&ns->head->requeue_list, req);
            spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
    -       blk_mq_end_request(req, 0);

    +       blk_mq_end_request(req, 0);
            kblockd_schedule_work(&ns->head->requeue_work);
    -       return true;
     }

     void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
    diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
    index ebb8c3ed388554..aeff1c491ac2ef 100644
    --- a/drivers/nvme/host/nvme.h
    +++ b/drivers/nvme/host/nvme.h
    @@ -629,7 +629,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
     void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
     void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
                            struct nvme_ctrl *ctrl, int *flags);
    -bool nvme_failover_req(struct request *req);
    +void nvme_failover_req(struct request *req, bool is_ana_status);
     void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
     int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
     void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
    @@ -688,9 +688,8 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
            sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
     }

    -static inline bool nvme_failover_req(struct request *req)
    +static inline void nvme_failover_req(struct request *req, bool is_ana_status)
     {
    -       return false;
     }
     static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
     {

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
