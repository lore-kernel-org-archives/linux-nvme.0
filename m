Return-Path: <SRS0=ldP/=42=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C10C10F25
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 22:17:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B9824654
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 22:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FWyPjJlI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iXhVb8pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B9824654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o8ugy+al9RBevblyT35YMYDKsuJs0snGn4zFlzzHgWU=; b=FWyPjJlIuT6rrG
	BhnOKU7qLnq8L980i3x4W2cGI1A5o4h/1H/DhwRKblx8kCIVGAHqc50S4dS5mL2v/4xMdRcMZe8IO
	ZTATdZzMijxt91UjnMMdajGpKtiVy6eUyTe1ZhizJWxd0QBEOL8+EGO5+bENq4MiQv0QB9rhw3tce
	gtmcqEDsV28M6V1LgNvMgBARpt1M/uiNjlOwgaxD9h75yBkD9y9zO6tfbVen/usc5MnOfONcfhW8/
	+32KUQPNDUVsb7yDbE0xms51Za5/4Z2BisSTT/jsNLxG3YNDnQ6W2r6ZP1HuaxGNEmTLlO8TsLIBf
	Xa/lICkVHxAuWKJkLbHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBQid-0003p6-Ve; Mon, 09 Mar 2020 22:17:51 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBQia-0003oP-Ib
 for linux-nvme@lists.infradead.org; Mon, 09 Mar 2020 22:17:50 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 15:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="235733841"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2020 15:17:47 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Mar 2020 15:17:47 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Mar 2020 15:17:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 9 Mar 2020 15:17:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKsvBmWp2cwYOgWlf/uMNF1nW0d3mv6npEPoP6+kGSf35JEnByeeTzXochjD3JcWZc/qHq2kURC1FSUI6SLA7bH6sX1eGn/lKQVaQVOYa1a41+y3v//bPShqI+L7ap+MzSAzhMQIad6hzKoCZwhSydqEuEdxfMfsr1dcn1sOl1zh/9hB8V9LhCUYfKfVaPenLdtMM1F0aO+8YKevBCUrxVT6+i9XMgYCnlbdhxKPDvHKFLrv5toZGeyAEySkYsE9z57dm/qjFCN14WUbDf5mRS0NA0vdHgUFcfWbfMBrX+9pbWVJhttRFuDFz85YIDPpqvNSIYL1IDIbN85hrtF6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/l00dLACp9nlaPmVWvu7IXFaVVMoPqXWGz3edMBXcA=;
 b=FZ839Meh22IOwLcz7p734+x4m/uhuFkV/xTjfVFpsRnvAPg9AgSdK0RsIMymm4SHIl7uRxbzT6spjxIYDtZ2oLxrXTB6GtsvAgc5VDQmzgqrya+Y6oKk8s9xp6BmZDvgE8Dw28saCsy/JquqgS3/ePckz0pXe02GudSBYyvpaJjKq9bXpe4nCyMY2VO0C7Bzj1I+W+KcU73ATr7KqgBTkxp+Gi9162SSv6ooSdtxrh0EBR3oN9iKDi5LNOsjPTCbZM8olwceLCpqW8CsUw6JMKNeqfdhkVXWqNgRMBH6ue7wXfP5HQC7zmrQc7snpoKeH5AkzTwE144FReBM2+qfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/l00dLACp9nlaPmVWvu7IXFaVVMoPqXWGz3edMBXcA=;
 b=iXhVb8pSbZYCa00VdVWaLfCRHDj4LAN2ZsDy5PYWIXlv3w0Gv8ngVW+rcpRaAdmz2Bs1uv0dWTsBJatvUDFRFAOsZUfdcmuHEoY8xIqcAQmCYBnIHgkoVfNX9MkRQR2rmKj0D+ui6iwNmNel+FmAqYVBTTczS5JYUw5MENY/NFs=
Received: from CY4PR11MB1351.namprd11.prod.outlook.com (2603:10b6:903:26::9)
 by CY4PR11MB1927.namprd11.prod.outlook.com (2603:10b6:903:120::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Mon, 9 Mar
 2020 22:17:44 +0000
Received: from CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc]) by CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc%12]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 22:17:44 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: Sighting: Use of 'disable_sqflow' option shows drastic reduced
 I/O rate for small Queue Depths
Thread-Topic: Sighting: Use of 'disable_sqflow' option shows drastic reduced
 I/O rate for small Queue Depths
Thread-Index: AQHV9kmB1xPGOrsi90S3+8np2DlTQ6hAxXtA
Date: Mon, 9 Mar 2020 22:17:44 +0000
Message-ID: <CY4PR11MB1351F639D6B6582D5EEBA74DE5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
References: <CY4PR11MB1351F4B992E207DCFD610FE6E5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
 <79eb6f31-1c65-7920-5e66-8ee9a6e81aae@grimberg.me>
In-Reply-To: <79eb6f31-1c65-7920-5e66-8ee9a6e81aae@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d079800f-3bbc-4b27-92fa-08d7c477b111
x-ms-traffictypediagnostic: CY4PR11MB1927:
x-microsoft-antispam-prvs: <CY4PR11MB1927DE6FEFF6DCB5CAE47C1CE5FE0@CY4PR11MB1927.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(5660300002)(66556008)(7696005)(52536014)(76116006)(86362001)(110136005)(66946007)(316002)(64756008)(33656002)(66476007)(66446008)(9686003)(26005)(81156014)(81166006)(71200400001)(8936002)(186003)(55016002)(2906002)(8676002)(4326008)(6506007)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR11MB1927;
 H:CY4PR11MB1351.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rl1EzBXR1d/eozSKlwqbxAVopR1ztxc+imBR8z8abzKiBqBBgGOhVYrBMSaz/vTXLe5x6oXFgZHWaSMqIn1M+BkgcB8DqTutY6CCwSzFhHJ73Jdj+ZdXa7clQAiEUapum06msUGRxhspxlszyUhw+eS5wGQ5wgXkjyV+TCgPhek4KIhTnfzPm1lQ+ZrTEHKVOX9wJrQBswXpDc+Dv/9mexnqvTYCgk6bwRjNCwSOpPmLT8JUBkkIowBV78x3CVm+ipPKAHMR2GLdg6OLyeqT4/wR50rBxc2DE3Fjlm2VUDryDMAYkCfGJeOuEmGHeKgNMn+sI1EMTEgnLnciTBTP2VWy0bVTg9QPTVZuKCYEvqFFtlYN6T0vmI1q154qIB4EWukpaMEkDcT9VM1lTskMSlvbyDJPHBoPHDf5xbPCGeQP8OjWC0Q13+/nzHmUJxcX
x-ms-exchange-antispam-messagedata: fTO+kLUaDpNy57Ol/Se4pExNJvyFb/fKgabLbsCJ7j261d4OV5wiFi6pIwMhfqBt47CPIj5GnmnuZA8P56eD3plQdo8WmNXX4HT1QT15khBJqOGHHWc/CJ+mwQuQdD8KD7+nmsehzbNdwY2feguvJw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d079800f-3bbc-4b27-92fa-08d7c477b111
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 22:17:44.6296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtenkxEaitiEzvXTXo7YhxlqJLbSKbE1vTY2EW8JVY5b6b/+JY0Uy1m28DZfwLhqvKL8zM6H56DBUf7ZSK0DAFmGHtzKRs649Hhz4VObMt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1927
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_151748_682580_F0A6F37D 
X-CRM114-Status: GOOD (  16.42  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> There is a problem that I see with nvmet-tcp target usage of msg flags with the SUCCESS flag optimization.

> Does this patch solve the issue?

This does improve things.  For queue depth of 1 now see ~49K, but the rate is not constant.  FIO output will at times show the IOPS rate drop down low then back up.  Also, a test run for queue depth of 32, and batch of 8 shows lower performance now vs. without this fix.  Before ~287K, now ~249K.  This got me thinking why would this be, in relation to 'disable_sqflow'.

Because the send data frame could be the last in the batch, much like the response or r2t frame, it made sense to integrate into your suggested logic for setting the flag to add that for 'last_in_batch'.  So modified to be the following.  This results in a good steady performance for queue depth of 1, and what appears to be a slight performance improvement for larger queue depths.  All good!

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cbff1038bdb3..7b2027cdd715 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -525,7 +525,8 @@ static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
        return 1;
 }

-static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
+static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd,
+               bool last_in_batch)
 {
        struct nvmet_tcp_queue *queue = cmd->queue;
        int ret;
@@ -533,9 +534,16 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
        while (cmd->cur_sg) {
                struct page *page = sg_page(cmd->cur_sg);
                u32 left = cmd->cur_sg->length - cmd->offset;
+               int flags = MSG_DONTWAIT;
+
+               if (cmd->wbytes_done + left < cmd->req.transfer_len ||
+                       (!last_in_batch && cmd->queue->send_list_len))
+                       flags |= MSG_MORE;
+               else if (queue->nvme_sq.sqhd_disabled)
+                       flags |= MSG_EOR;

                ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
-                                       left, MSG_DONTWAIT | MSG_MORE);
+                                       left, flags);
                if (ret <= 0)
                        return ret;

@@ -670,7 +678,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
        }

        if (cmd->state == NVMET_TCP_SEND_DATA) {
-               ret = nvmet_try_send_data(cmd);
+               ret = nvmet_try_send_data(cmd, last_in_batch);
                if (ret <= 0)
                        goto done_send;
        }

--- Mark
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
