Return-Path: <SRS0=P2Tb=7R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307F2C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 06:25:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67B4206DC
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 06:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A8ffHevc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l6Q87Ocb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GoPvwX2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67B4206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=gJLq19S86NeLoWzKMMbJ1c8tEysoHKREMwVOIlAJ++M=; b=A8ffHevclw1k/Z
	gNV4iT+J5mdHe0ZXtihE3xnuEw1LkiRefojMOWd0DBp+tTC28quf4PQft5yCxeztAecSHsI7VxzJ+
	6Kp5wLpKvJkTqPIBIQr7vxpb1zbvt4EEhzfraCZNmgDGC+8teEozn5W2DHlV0Q1y8jjnXpufCSjar
	3F7jvVA4iSLOtej0NLAXzKosW9ZNhlQJ+rnHuvyffTlqdbMvaNF10DaEFpO0jtvaGxn1GGjQOL3oP
	40i7BuZvfddE3KniQRs3ywfAGqGTYaCDJy32qjIxDCjiV5Mpim2adUZUTqGpA9i0e9EQwYeMtSzbS
	Irdfn1gm5gFPB3LAMXyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgjJZ-00082y-LU; Thu, 04 Jun 2020 06:25:21 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgjJW-00082d-8b
 for linux-nvme@lists.infradead.org; Thu, 04 Jun 2020 06:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591251919; x=1622787919;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=rLxhkPZeUbAGaOrfUmEDNfF4h1mpiXcYCjgLGcgFbXs=;
 b=l6Q87OcbAVdYHv7R7iWOJ7prO0roSlnNAlzcJXjndVgH4FYQa4MPwy5D
 4/HEsawalSgpC/FGU+nQRXCqE/pm0Wy9zDC2QZqhnUpN1TVrT02WHpkWN
 dm7Y6mGfGBXZLzr7aKeFKKqjRdIxvTptAwfmlf4fwDhrLzHpkqhvkRXTu
 gSLpNpTXPhF5ZG8DiieH6s301te9QXghsrC3jjgmafheqt5KiykJk82em
 TbQx8n5zlrI20i0bERwAnfT9olk03E7Xn8Npfh5+HX+YxzVgPkP6MTeC8
 4J4L/FPA5zH6DKudMxJooOBeCoQQAtCTHKuAc/cF6/m9wVqYQxf69pM4x g==;
IronPort-SDR: XAlRpAUS6e8l4mFrisxkJja8aCJPSOfljMvk+GQiM8kq5BQkkAmkfF9LlA07zb1vK/C5MTV0Ji
 8tX0i4gwuPmWFbh1X9v1JZ9KRwhi6Lc1+4V/JnYBgTUYbwehdnMQfZYY2vWRDF0uJFGyAjXyHm
 fG+IOdSxRN5tjU4EZxacv5+ruigF7fs/eZeUd9lUX83oVRnmfkrr5FKef4/LlnQ5gdSoGbM8MF
 A6hcB8m4GuIT1ptcm1C4JyTl6Q26158xu13079Slcn7zQtgPIOk+WFgz6wbcmq5iX9MQK1J3I4
 C24=
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800"; d="scan'208";a="139491096"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 14:25:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq56Clb6gJ/vLDT2xFk8+K54e04Qi/j0nAemm0wzi1nJcIlyYDrB+wHm29bfCx60vEzlxYvzyWChFSwyBdsfQRF3CBIVJsBXqiQBQ8shzibJUAUcMDLC8fdCNrLdhvgcBmQxrhLRdGx/Gs1hMFbMvsKh9jeBqXliKENjDGOruhGEP18rvM6Cl6aUjoHyw4vyK3tq8hyi7Ov0OQlcrahSuFWsoHSieKphGBB2h3oShs7igX3SEuY7Ex7ahlQUOkfva2Z6TcZ+gCerzUwfMbXasMKJE81WPsLbq5aRPv6xRXluSnEfLyJ98NxSYLCUzJEW5LQKZHGB33Vy2IGwQ/mQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usWYuy7Kx/e0PIZwWuG+VjJK7SDg5QDtGqPYq9QE+zw=;
 b=SAgf8zgpSghR+l7pc+LyXpPI+JFGvPfjJKN4avANwGFZ0Smk3aThgBgEfonvuZwptgSS3CcOhxB95kQwYKJX6XqoI6D01fmY+kHDV0wE2R+S3/D0S9dGBy5OPr028cC09ADd9vt0Lvp8ztjX2UZoMizIjzU6I2+UhXTsaQD01nClX2EP3hGu7OJsna75pYaKYdEeqFxLAkIxSBeeiJi9+NjqVicC4o/BkDSvH0Xi9TAf644SmUYJvlMGKhajJzdhbSk23MSgNX2xow9Yo/3jJ3Fvv5XhFUVeIRTLM/YrL1HElQQqaiNgwAzhGE9jgJD2X9buvnG2A5PQe5A04+EfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usWYuy7Kx/e0PIZwWuG+VjJK7SDg5QDtGqPYq9QE+zw=;
 b=GoPvwX2RQsG8MsP5KCBUIoF68d1325mKXRvEAsm2O65upKHMh3+gUZZhc5VtSo1dqkOAU5kLezA3q+RSwjBzBDzhvjn2M/O0Xf+YjuVCoRLW0n5ejwL1/bXyUX+Te4ihe4amGEzddbEkr8s9bNjhXntRl2snMtRgb/AXBvDV0QY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4359.namprd04.prod.outlook.com (2603:10b6:a02:ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 06:25:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 06:25:15 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: blktests test nvme/003 fails
Thread-Topic: blktests test nvme/003 fails
Thread-Index: AQHWNIJZVRL6ENIo6Uy1ge01JbudSw==
Date: Thu, 4 Jun 2020 06:25:15 +0000
Message-ID: <BYAPR04MB4965217373E87DFEE2398D3F86890@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
 <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <fddde27a-eb61-7031-a067-5538e0fe3243@grimberg.me>
 <BYAPR04MB49651CF1169CD33108A484B386880@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e51a62da-d374-4952-d412-08d808500b40
x-ms-traffictypediagnostic: BYAPR04MB4359:
x-microsoft-antispam-prvs: <BYAPR04MB43591F872D0D95AA413255BB86890@BYAPR04MB4359.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+2zvqlRRCWQNYLKreChtkEPgyAFkL+MARnvcixw5GabaAJ65qabfJooIq+OGx0vRHCeDVZ/JNFRxMY0nGYwnQXq13tSxrJ70rWrLETNXKsdE9/AwDi0OHfJH+F+rmYBdX8FHjuVA0fbet3WxOczplUxwjabbCooBx9ojO+FC7jcsFpR2e4X+3d3p1V3zL3zumu8P0k8J9eMkgQj++CVn7u5qAikr2MMxMJI3PH2SSvLcbr1UgULcmFg+X3u34AUdChr3KQZN9BpV+8R/fqEAelR7Y0ol1t/Kty4Y6mkDiN00bMBlqaP0Dj9cJLVe+GrpyVjQcf/qwL7/hSGpnmLGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(76116006)(9686003)(64756008)(186003)(53546011)(6506007)(4326008)(66476007)(26005)(66446008)(316002)(66946007)(55016002)(66556008)(86362001)(54906003)(33656002)(6916009)(5660300002)(71200400001)(478600001)(8936002)(2906002)(8676002)(7696005)(52536014)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vQofRRCZBL3fZicWj30UHUxpnHNjCxAY0mCg5z0FAUkONrwxiaoQIXcYAXYJW8qSZScEJgAasmh3bUdtqI+737yq3RaSC9kua3hQ+ZBVSqrQo3r+1LhZje/1t1QCggV3J8PoGigi/37FCFQFlptNGt0m1xm6BN7oQZtVJ1TK+xmWQ9WwWdxyOK+aJAP5el/z88GkLieEw/MUavU/wzFsKFRu7z3Rxv/Vh/2mrsfK99x1u/lGzwR4sABSABs4+Vdao+o+YGsiSVEODB3g+F1tC3WxcKg1p8HsqsXUGaOOZQQ37gQ/+wqufETo42mzxZUB67mEMcgt4j5eKLL2NxIT6hhj8bV7GIOFHcI5KUS/wfyCLzhNyD3VghCXAQh/vVqkox9YlzDIwqxaH8caVN8dBnQDqsT1WbtXUsLysq1UWZmEnaa5pRx6bylwVCs0OSaNMLc1SqtU6S8ZLIImlNeyUlPdnkWpyVYtHfVJ7Q25Gtc=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51a62da-d374-4952-d412-08d808500b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 06:25:15.0549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sq0ojgPxPkU2H662ZWkxyMuFquz8uKchNwvnJrPpQRYe0gaPjYp1dtBgVbIO0G5K+/A5BJYgWl9ccooIlVgAenyrGuU78Wio4q1DF94fWWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4359
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_232518_392846_F298328B 
X-CRM114-Status: GOOD (  12.90  )
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

On 6/3/20 3:31 PM, Chaitanya Kulkarni wrote:
>> You already condition aen when setting the result, just free it after
>> you use it.
>>
> Sounds good. I'll send V2.
> 

What do you think of the following fix ? This is much clear and simple,
than modifying nvmet_async_events_process().

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6392bcd30bd7..b494a902c3fc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -777,6 +777,20 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
         complete(&sq->confirm_done);
  }

+static void nvmet_async_events_free_host_req(struct nvmet_ctrl *ctrl)
+{
+       struct nvmet_req *req;
+
+       mutex_lock(&ctrl->lock);
+       while (ctrl->nr_async_event_cmds) {
+               req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
+               mutex_unlock(&ctrl->lock);
+               nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+               mutex_lock(&ctrl->lock);
+       }
+       mutex_unlock(&ctrl->lock);
+}
+
  void nvmet_sq_destroy(struct nvmet_sq *sq)
  {
         u16 status = NVME_SC_INTERNAL | NVME_SC_DNR;
@@ -786,8 +800,16 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
          * If this is the admin queue, complete all AERs so that our
          * queue doesn't have outstanding requests on it.
          */
-       if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
+       if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
                 nvmet_async_events_process(ctrl, status);
+               /*
+                * Target controller's host posted events needs to be 
explicitly
+                * checked and cleared since there is no 1 : 1 mapping 
between
+                * host posted AEN requests and target generated AENs on the
+                * target controller's aen_list.
+                */
+               nvmet_async_events_free_host_req(ctrl);
+       }
         percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
         wait_for_completion(&sq->confirm_done);
         wait_for_completion(&sq->free_done);




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
