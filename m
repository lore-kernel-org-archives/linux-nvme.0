Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F552C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 03:24:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A25920715
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 03:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b8c13Y0m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="KWUUMqws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A25920715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OWDsIMirlJbEkFCe9prYCoU7rDHgfSRLA0iD0k2ZBQQ=; b=b8c13Y0mM+ERIiPou7Cil1WQG
	LuqMRKfBccaUK3G1aDr600ap4JrtGo6fVUTqwq2W74asYYeeHk5wcpa0hLbTsTc0Hpg7C2Q0AhJvq
	fZYOnwuI1yS2Ugs7tQJKFQLBarfXB3/qhadVlfQyg897/ERAHDqZo8jZ1KZfY4wxUJ1QtF3r9TEdH
	A684ccI2UzfN1jomzKOzeTRHMmTWAVwaarSE/o87K4mzeMnyvOUxcMPynGaQ6GIY/8r2pbQNk/KZh
	f2vW/YSKAkE1eUFL7s4AeuQGJWpj6Hefs1CxEoYbYGG3JWZ9c1vg/K17tOsvxAEU+gssxmf5vEVys
	oX/1DSXMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6QJw-0008E4-BP; Fri, 14 Aug 2020 03:23:56 +0000
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com
 ([40.107.223.89] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6QJs-0008DG-Bf
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 03:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjYrAQ8U+SFVWv9HG8RrGxnlsG1AWoFfAfgb8loiWHLQF3BLKJCX1f6oJMvlAubjhwU4Pk62znYXC6psaQR2Niu/0wDpe/VX7O4AT0CIGkfZnS99+EzmnkMqDLv9d0rNZc3WOa1W6siRuAyFstVXCUnBnw6eAtLQMcmLtBiRyiAS1vSW/MrsT/JV8vYkACzpct19PqvZWJZt2J3c/mfBwYqPIZSeCrxGILidh2Cy66NdK00iiezsgNdf+npi7c0rYMuat/Y0OQkFzS44PgGzNlmjXcjPJi3UYhg96mcHFIrczxqGIGFUxEg6+WhrZ1FIG2cpmm9dQq9YK0dKqPWF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVAWLuAq57kC/F0HCo/FzWe2lMM4TZbTCUk5SQTyy/A=;
 b=UE1p1h+WczkimzQEyRcwIwvgk2CfG+pTiL+sEFnaIY9M2d6Gh2ZVOGoCbve5r9nHHnTfwSZSb+oJ51UGNEYhq8E+mlsYsDC+YMk1DjOq+Lk+rv7JDXJEaGRh+oAP04qzF8DDMGtDvNavIxnQTRnrLSjCfHbK5GIaPB6PWduoQOBwoFFeW7fZFuVC7EtnIkdQJXj6IyrfsHS+zsO9PhLfCG04oYz/Ibvd+J6QzDxhYe7c+gKVJsicqw9An8dplxIL+wYKofOd9qtKgnUj+T78ab3R0adzVJ6rYBHBf/uph/RoAUqrIXo32XWWZWOJyqaLBatt8eRKp8yrZ+3JUiqaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVAWLuAq57kC/F0HCo/FzWe2lMM4TZbTCUk5SQTyy/A=;
 b=KWUUMqwsaEoYte1c8dwdxmWUt0kGmRh7xuS9M2gw/Hh0cOY2coYW0ZeKZP6MhUnaqu/us6xv+Ykc6O5H6aQnzx8rnggtZIn32S+yDb0RKyvmVB9LQ4rLvxOw7eEfFq14s/sdxOWfR5YIj7ipvbWp/5Lu9z7eBeLJzsEeXKhBM3w=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN6PR06MB3331.namprd06.prod.outlook.com (2603:10b6:405:3d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 03:23:47 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9%3]) with mapi id 15.20.3283.018; Fri, 14 Aug 2020
 03:23:47 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Mike Snitzer <snitzer@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Thread-Topic: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Thread-Index: AQHWcYDS3N6K/RiKVU6UaUdcYydCWqk2rpSA
Date: Fri, 14 Aug 2020 03:23:47 +0000
Message-ID: <FE38832C-9966-4455-BE4D-74745AD1AEB1@netapp.com>
References: <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com> <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
In-Reply-To: <20200813144811.GA5452@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bf8c35b-bd3f-4069-f9d6-08d840017513
x-ms-traffictypediagnostic: BN6PR06MB3331:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR06MB33318182D8A0D2ED9B1DFC92E4400@BN6PR06MB3331.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nzZL1wFZdoIdTKA2yjclEiBGZzOzvPakdQP4iIyrn2IzoCKQn/wKlGhAneHv3em8N3yk1mEgf4bNS9ELFuaje0eIkBj0Jjtu4TsJC7Nm4DzVTV0GmcGUBmTYErwWr5bAy9knxgrF0JnLMtvUZtIVQL8uRuuv/W5lao18gMyk8iXMAZcDNr3sK8IMwGmFuukANTeXELTZBS7qcBpzq172knUsTQU7bZa1EtVVFbachS7lVLrdc8PKvn8ba8NRdtCovNuwwox/66JcHUqH9ANa7pSyTlW9aUa21tFZqWVzHjKB8xNvclzVlkSNGTie+2SXdYDAmWigidGJuj45ULI+BA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(2616005)(53546011)(6512007)(186003)(478600001)(4326008)(316002)(6506007)(5660300002)(107886003)(8936002)(6486002)(2906002)(71200400001)(64756008)(66446008)(66556008)(66476007)(8676002)(91956017)(76116006)(66946007)(83380400001)(54906003)(36756003)(86362001)(110136005)(33656002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1IqT/Wu7mJADbftWaJVvtkVosap06bc+sNBMev+wrYz86qrvEphEXKPib3ShIqDWG2CnLxKIBCAao+9bifLN9OPU7U56UXvEYYYg+XmqNao5L+1OVokuVlPgTWWoCWKc8qzSchhiL4YtPKk7O/S/oElUrliAkj+MBTF13WUIqe6vftL0mGbECPb07DlDKkS6j2DY8i9MWNym2maPjQPRcS0dr3okup/F+2thJBRdLgbLyM9xT06/Kw+ugli0l8O1jww7j9mLuhPvW3AXY01gAiAIiomVntfJut7kvphAPvohGtdVQnhe22w8YSE3ra915E+tGG3vMu7vmAT1kD/Xbneo09wR5X6/wKarML/aKch5IoHsAICeL1CYx7cnLi91iIb5EF+uo+ffnnTkJo9+3+FrIv0c7yulIS+CWbVUD0mzue8MVq+Gz1vLc/WjQKLHzhOX89HdetD/ZyYXOgYWCByYlCypPqvejFRIFnQIwM+4/Vi0kwdT6S8W1XOAF9ijG10otioF99l+gntZ5ltLCGRUeUHMMZk+XH/KKI5f8HthoGa5X6jbyuiUCXDupFqLT//7jivVl5y+++NaJpj0o2U2B4cIxXTpMVwUUeI7gWnSvhx6BRx5wOwH2yYgA3/vtqh9dcevcffDbttSNudgGw==
Content-ID: <54BD68F19977E84E8DFC5E2383C18431@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf8c35b-bd3f-4069-f9d6-08d840017513
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 03:23:47.5484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWK1Or6+eYV10YpnuQ8k5nsoayIGGMSfgCDGhpVjdN62yfg1kKKzzkfDM3se0GNyx40oVTue1JMcqGj5KYCCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3331
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_232352_542301_55C64F45 
X-CRM114-Status: GOOD (  18.14  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini, 
 John" <John.Meneghini@netapp.com>, Ewan Milne <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/13/20, 10:48 AM, "Mike Snitzer" <snitzer@redhat.com> wrote:

    Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
    status"), among other things, fixed NVME_SC_CMD_INTERRUPTED error
    handling by changing multipathing's nvme_failover_req() to short-circuit
    path failover and then fallback to NVMe's normal error handling (which
    takes care of NVME_SC_CMD_INTERRUPTED).

    This detour through native NVMe multipathing code is unwelcome because
    it prevents NVMe core from handling NVME_SC_CMD_INTERRUPTED independent
    of any multipathing concerns.

    Introduce nvme_status_needs_local_error_handling() to prioritize
    non-failover retry, when appropriate, in terms of normal NVMe error
    handling.  nvme_status_needs_local_error_handling() will naturely evolve
    to include handling of any other errors that normal error handling must
    be used for.

How is this any better than blk_path_error()? 

    nvme_failover_req()'s ability to fallback to normal NVMe error handling
    has been preserved because it may be useful for future NVME_SC that
    nvme_status_needs_local_error_handling() hasn't been trained for yet.

    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
    ---
     drivers/nvme/host/core.c | 16 ++++++++++++++--
     1 file changed, 14 insertions(+), 2 deletions(-)

    diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
    index 88cff309d8e4..be749b690af7 100644
    --- a/drivers/nvme/host/core.c
    +++ b/drivers/nvme/host/core.c
    @@ -252,6 +252,16 @@ static inline bool nvme_req_needs_retry(struct request *req)
            return true;
     }

    +static inline bool nvme_status_needs_local_error_handling(u16 status)
    +{
    +       switch (status & 0x7ff) {
    +       case NVME_SC_CMD_INTERRUPTED:
    +               return true;
    +       default:
    +               return false;
    +       }
    +}

I assume that what you mean by nvme_status_needs_local_error_handling is - do you want the nvme core 
driver to handle the command retry.

If this is true, I don't think this function will ever work correctly because,. as discussed, whether or
not the command needs to be retried has nothing to do with the NVMe Status Code Field itself, it
has to so with the DNR bit, the CRD field, and the Status Code Type field - in that order.

    +
     static void nvme_retry_req(struct request *req)
     {
            struct nvme_ns *ns = req->q->queuedata;
    @@ -270,7 +280,8 @@ static void nvme_retry_req(struct request *req)

     void nvme_complete_rq(struct request *req)
     {
    -       blk_status_t status = nvme_error_status(nvme_req(req)->status);
    +       u16 nvme_status = nvme_req(req)->status;
    +       blk_status_t status = nvme_error_status(nvme_status);

            trace_nvme_complete_rq(req);

    @@ -280,7 +291,8 @@ void nvme_complete_rq(struct request *req)
                    nvme_req(req)->ctrl->comp_seen = true;

            if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
    -               if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
    +               if (!nvme_status_needs_local_error_handling(nvme_status) &&

This defeats the nvme-multipath logic by inserting  a second evaluation of the NVMe Status Code into the retry logic.

This is basically another version of  blk_path_error().

In fact, in your case REQ_NVME_MPATH is probably not set, so I don't see what difference this would make at all.

/John

    +                   (req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
                            return;

                    if (!blk_queue_dying(req->q)) {
    --
    2.18.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
