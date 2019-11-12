Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D9C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22BD2184C
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="REXJjdMb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="B4irDw+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22BD2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EcteE7PuJnoCjwZtVSMxKW+DgqKGuu4sV0W00w/M4ko=; b=REXJjdMbdiFMOh
	e8F2uKEWtD9Z3JgdJ9n45HSCLY+QMN2/soKXHAHfDd+RIksIVGOclW8sD/079BhBI5GoMitfr/DlR
	lePT55OchXW3q4smvAPH9EKxQEjc3QJyqxcmA8TeHGfsCe5MI8Zm5mlKiUByt0g5WNavb5e2icIsD
	3dSD1MFr6DIrNIcs6qmxxlHBDI7PQUy6MisXFQ/xI3TQM2IhPNONh/bOtEEfE7cgnjGbGJvSyhSAT
	kqacTimcBa3vGaYyl3x5GUiG10eaOUzdbpHyfukWSK/7XOHTZ90oM9d0ec9dWg2i32D0zK3ZdQzX1
	Gtv4KggwDFIuBMVjrLXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUK84-0002oL-ES; Tue, 12 Nov 2019 00:33:56 +0000
Received: from mail-eopbgr730116.outbound.protection.outlook.com
 ([40.107.73.116] helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUK82-0002o3-En
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 00:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6qkXwif4mWxUWMvLtpNJlE1ijRBYAAtLsxD/u7cR8ZCAiC+4GB33iu8ue52SqH9Osq5eNg7sYA94WIM/I/ohTZYd3QrO6+4Hu2K9qHoGn+bvDYx4nQMXfdy4sGuX3s1uIl+PXiPmsRI6qaMjeZKigArPRBcunwCeaYQtgVMc96nPJLq3nYecMkmOxzv3YT0nzUwmm5lpKctaRnALXTISjHyt1o4+uW8CEGWicReU0iWCZro7hmuK+zYCswBSLYbvn7tkavfRtwj0Fvh3CnPJ76Pd6U/h2Uxcr9HfdO+sYDKEo7FiNN+fVyfn0xiu8XQo0WyLrLpWn20Viyf8I7NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQIyYziXH/BGV2tNrxXmSnKSAmsLb2jopdIo3iCL7Qc=;
 b=WNBdDQmALyz6diOHAPG+fnFsMN7fzbAeE0+qgBwMpuKKz4gRsJcAfJogjye63V/lUAm2rIzS9uiIflh4QcZtlmXldp3JGXlD7y42iFvBLudsyfM2E2+O/CFkHE+G31ww6pQ8qx5vCW5Y8+bh6Q9sBzlqKXjmYOVXD2aKksqKLoD2my2ub8dzesodQY0w8b0RaXudLW3J+iNGF3hue3gms9Akq2or7IuO0lRQlre2O9RMbTq0f4bOOOEvK41juCSxUlIQz/Vp77e/JXK/fpqQyvI70eJvagHyMRsWFArxrmB8ReUFDCkHns6d/yVNio7jurfJCdZ56zEhweEHEyhgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQIyYziXH/BGV2tNrxXmSnKSAmsLb2jopdIo3iCL7Qc=;
 b=B4irDw+XkfjHadjXHWYt75iKkuVEz5KmRnrYrmND6rhp32BEsVJR7IZZxeiRe8vv0Jos4XTxAPx6tjVo/jMfaO3AnJnWbGeec63+Ls5xsyfpAi4IN5g7ZPUp5KNUnaoeUQfBAr2gndOAiI27Qyo2vS44f8s9SBBsSj4FT05gQDM=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.5; Tue, 12 Nov 2019 00:33:50 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::8c0d:e8a3:4fb7:e083]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::8c0d:e8a3:4fb7:e083%9]) with mapi id 15.20.2451.018; Tue, 12 Nov 2019
 00:33:50 +0000
From: Long Li <longli@microsoft.com>
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: RE: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Topic: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Index: AQHVlehiYcB/lSKxl0SzyAz+DwfVW6eGdeMAgAAtylA=
Date: Tue, 12 Nov 2019 00:33:50 +0000
Message-ID: <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com> <20191111204446.GA26028@lst.de>
In-Reply-To: <20191111204446.GA26028@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08cca30c-e06a-474f-41d7-08d76707fd1c
x-ms-traffictypediagnostic: CY4PR21MB0837:
x-microsoft-antispam-prvs: <CY4PR21MB08378125637B629F1B5FB666CE770@CY4PR21MB0837.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(76176011)(52536014)(71190400001)(7696005)(256004)(33656002)(2906002)(71200400001)(6116002)(66446008)(64756008)(66556008)(66476007)(10090500001)(5660300002)(14444005)(186003)(6506007)(102836004)(476003)(6436002)(4326008)(86362001)(6246003)(316002)(229853002)(8990500004)(446003)(66946007)(14454004)(74316002)(46003)(486006)(25786009)(76116006)(81156014)(55016002)(81166006)(305945005)(54906003)(11346002)(478600001)(110136005)(10290500003)(7736002)(9686003)(99286004)(8936002)(22452003)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0837;
 H:CY4PR21MB0741.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNOEIvNiLwUi5NYQncIFezgSUVYKu9+CUHA9AaV3JwXHolmFkCHoWMgv9zH2ZM5qw5gh2BudhOqIb4KiiYIXXH8aDJ5KYL1m9BZAdp4ms5zEXQkaCPRCUWgqKtONX1kH8g2FaSvdpVlcB/A/q1TATPU3YZqlzVlt/Xjb19tnUR+XrgkX8C9/70d++C3cCbER1Mfemmqi+VQC0hTSmDbolbiSXGH/WMMJeEaoYmRM8ArZ8llD8D+mypDqjzQUS7tNVpEY57+VZbQs5d4wOt0IVSgVSfq/RzoYQpVYB0HRvrJbOiSQdsW41Tx09zeg11YLz6x4T6sGqW/uToLNRaH1LFnyJwzdxdsNgujfS7W5BR12GkatHo0ewCsq4+0hCx6xfHVc8aUFxT+SkLrVjIFnY4haWzxIcFrmrGd7SSin1NKHCZECpP8CSU1w+qXZVyX4
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cca30c-e06a-474f-41d7-08d76707fd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 00:33:50.3944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPkiuWCsTOZrz1T6SmTN8A2p9/Xhzy/FY9a/0EDp8nbU70wjqN3O8xQzHxccrMVkVH9G0Vc5MXz2qoLsFF+puA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_163354_603024_0F92AD4A 
X-CRM114-Status: UNSURE (   8.50  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>From: Christoph Hellwig <hch@lst.de>
>Sent: Monday, November 11, 2019 12:45 PM
>To: Ming Lei <ming.lei@redhat.com>
>Cc: linux-nvme@lists.infradead.org; Keith Busch <kbusch@kernel.org>; Jens
>Axboe <axboe@fb.com>; Christoph Hellwig <hch@lst.de>; Sagi Grimberg
><sagi@grimberg.me>; Long Li <longli@microsoft.com>
>Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for multi-
>mapping queue
>
>On Fri, Nov 08, 2019 at 11:55:08AM +0800, Ming Lei wrote:
>> f9dde187fa92("nvme-pci: remove cq check after submission") removes cq
>> check after submission, this change actually causes performance
>> regression on some NVMe drive in which single nvmeq handles requests
>> originated from more than one blk-mq sw queues(call it multi-mapping
>> queue).
>
>> Follows test result done on Azure L80sv2 guest with NVMe drive(
>> Microsoft Corporation Device b111). This guest has 80 CPUs and 10 numa
>> nodes, and each NVMe drive supports 8 hw queues.
>
>Have you actually seen this on a real nvme drive as well?
>
>Note that it is kinda silly to limit queues like that in VMs, so I really don't think
>we should optimize the driver for this particular case.

I tested on an Azure L80s_v2 VM with newer Samsung P983 NVMe SSD (with 32 hardware queues). Tests also showed soft lockup when 32 queues are shared by 80 CPUs. 

The issue will likely show up if the number of NVMe hardware queues is less than the number of CPUs. I think this may be a likely configuration on a very large system. (e.g. the largest VM on Azure has 416 cores)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
