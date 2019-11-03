Return-Path: <SRS0=k2Ai=Y3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E19CA9EB0
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 18:55:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23E42190F
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E14RWK07";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i0BDnvsv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ke7dZUqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23E42190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=9yhYaCOxinliB2R0sOkdQNABVAi8sb0Ffw1ywbTHZck=; b=E14RWK07QQuOrv
	Ek0A4Lco1AucmS20wA4G1NHV1h3QfHgdASlx6UO6QIN9IPzActpHGUI/M+fzULqnrrxnaO/E41+sx
	NgnfVMC2hYonTOTJwD29dYeV0ph0OQksNTb/9GV6SwwjtGNJuDgmKYPyKYnrgoMaXf5gRlcxLtqv8
	Scaf0ta/LMe3Vj4xE7lAk0sQvAHOSgXeCjuB2ZBGud5E0fL339cVlt50Gh38QqFhCUB84tSO9kzUn
	pemAZGumRqFnOlpE5OIpjNdb+5rvlhq6H6vbQWbHGFn0ghIdIWF6al9MCRX7snopRSLOSCW9UWBKB
	BcPF0H5nZgkUgSiD5eXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRL24-0003i8-2B; Sun, 03 Nov 2019 18:55:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRL21-0003hO-6D
 for linux-nvme@lists.infradead.org; Sun, 03 Nov 2019 18:55:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572807320; x=1604343320;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=RzA+PurWZlAL959Q0Fc8ISMLr2TFsmZsdWcAa6rvGqo=;
 b=i0BDnvsvqwsGXc/qRK3ObshMcjXkOjW4ihYab428qhxLWPyE8iXTKktm
 kSY/aaVehcEuY9yypC6GiT7d6Blo9dCKF322ytggv5Us/KHIfsxRwB+mT
 p8kGN5IRqNfXMQYpJEWhKphToFbkYfnsA/HYUKOPOIAvRLANyB8WwGy9c
 XOonvBBHRyjsShLicIMv9n21SYd0TicQPgTHOu9JquKi9FOfSu8aQkJEA
 ryTHJdYK9JcRE32j0zyb9KeRCvgSXwB8AxZxpPklVgKjg2vRAcde6qL2l
 JfuvLqZCGAMH7yQsUSrMIBi0vJzeqZiUlUiCMKReOU/XneVfoxHbXfrIs g==;
IronPort-SDR: ISFXh6M9sd0sugAB594TitF5eVgs7M6AdJ+IJ6NFNd5ZIq/GG3u6Ezfp7FDLCp10+qwhojv7wb
 7avJQAY8hkttbd2R/UZID/lyZ72dqyKdP/3mZdwsJMZ57xN6bTLEb+RNIN9scdJ/Kw1rdpx0xw
 O0Z8HlX0uaZCNj8+n2RE9RErsTtp1p2RHgKgZstknVhuBFtZNMT5RyPgGG3SHDT2439R0P+cqL
 pieoLrp7L/id6y/YUUpdBJrIo+15bG0X3RXlF6jru4EJL9cDZIMwaKIU1tkynfOEE81beFN3WP
 N0o=
X-IronPort-AV: E=Sophos;i="5.68,264,1569254400"; d="scan'208";a="122013056"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO
 NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 02:55:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In72s1xsOU2O3vv1iBD9ySPCUjznqtZmr13R2YcgZrBQiXubmHXZkcH7Lr1cFMFCLCW7EPmlRGd7+aLlffL0K4a8B8aF72SWZFwbu8C9SdGTVM7zh+BjE0aolXyjWeBflb/Pwyv0eGOE3R7IlwPmjJxfO5ioq7EfSHtaBQ/KQwej092x8uk252M2204bdstg4o3o3ig9tlP1d1S7Nqj+I17yMKNeI4DnpI1EURxxKUMiihl8Whgle11aIfyqJPWVCaQ2bSlXmHZeTip8simV/BGql2zCFhqUU616uVNCFrrKBSvazXXDLFVwB8C4A9wkD2pVwM8ksn/IS0989eSfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7NLUppQ4MERkczk5lhlhBf7kQmzcbUTSqEYsnrPWlc=;
 b=IINMuzuiT6tJjCVcz0E3ye65/XshaVSNPF1GpnVwbNWTUeaebXZ25rNBTKdu7V7pNuFo5KiecIHzG5dDv6RDmksol18ZWCjybA+llxZxzbMQOrIJ9dObvBAVf2MqSh08Hca25cnWYllh3TbGmA4Sppe5igejLR/ac6mUsc9kV9LdW1kkmnKtksul8ku4cmt4vtr4aVRm/rJJyLJoI8Odxpcf6Ng99T8LE+XQZTHqIXZbHQQb/qqft8qNGJ5V3TDPUku8pCLcg3ors7M/PkIwr4XqqWSRbGasMBy77TD86ey22IDHdZMZIoPIasnMe7uM+DfTmcypLqY+adfl6g3A6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7NLUppQ4MERkczk5lhlhBf7kQmzcbUTSqEYsnrPWlc=;
 b=Ke7dZUqRAYPhx+7nSbLN+uV6GnvUdAh5Wf/bbW1JT9HBSlwZoSTjc4m6B/gqM/6k63OJ5jF1h0aa9nc1yJJP79fEGCVbz0JW6eND/kToJTemXsX8DKxRyS272EZrhC+X/3H/J4uNzLyLQHAZvOIM6hCD4n2x54za9yKj2sh8Ixk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4678.namprd04.prod.outlook.com (52.135.240.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Sun, 3 Nov 2019 18:55:14 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 18:55:14 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC] nvmet: Always remove processed AER elements from list
Thread-Topic: [RFC] nvmet: Always remove processed AER elements from list
Thread-Index: AQHVjzYhgmqnvQGm+02Suay/wXEq1Q==
Date: Sun, 3 Nov 2019 18:55:14 +0000
Message-ID: <BYAPR04MB574907EE2666D6DA48DE30AD867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191030152418.23753-1-dwagner@suse.de>
 <20191031145127.GC6024@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95cb049a-9583-48d2-1954-08d7608f5ca4
x-ms-traffictypediagnostic: BYAPR04MB4678:
x-microsoft-antispam-prvs: <BYAPR04MB4678FBABC0AF3692A92A67F9867C0@BYAPR04MB4678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(52536014)(4326008)(53546011)(7696005)(14444005)(55016002)(2906002)(9686003)(86362001)(6436002)(71190400001)(71200400001)(25786009)(76116006)(229853002)(6246003)(54906003)(66066001)(256004)(476003)(110136005)(478600001)(305945005)(66556008)(74316002)(8936002)(6506007)(66946007)(26005)(486006)(316002)(64756008)(81166006)(99286004)(7736002)(6116002)(76176011)(446003)(102836004)(3846002)(8676002)(81156014)(14454004)(5660300002)(66476007)(66446008)(186003)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4678;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1Jy1c42RhZ5ir4V4p1PEeKKQXTji/ssWViHg8WT2t7BEj+NETZCblBvSkea+fBoQUE5Cg7WgdCY6ZvmmQsGo6t1Z1ITxLZDexiAJc/qa544mwAGDMnZCwOEpf22OUbsryMEv2IYk8UGL/VKizOGfVjO5aI3HuqMZAQq9naSI6pAcvRP3kwj5NGzhfGguUqLb62/WjdBV1zN+hZEukseswkVBViO72tHB3VKUL2Vznk+COmfV8gXfZAltIqiywOci9vOC7Q77VzKZUFYZbVmUVcsDPfv22dQyRBB1dvJV2cukSMs7w10sdPNyzqsdKH/iHm0dW086AkV1hRdgoLjCL/l/HeF2/YyrxcMjVbZqRFfLzTj5Z+/BLLdmwUPMADmxITCxBMDvpxX2aNCnWavBq1gyblEpy63hx/dHeCng6EoexpDC+gplibSIGDFxnPW
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cb049a-9583-48d2-1954-08d7608f5ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 18:55:14.4933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azcSfx1I/x7MwA5d11OHaxLHT0UCSQH0jXsyFQO5jTqSuxK0EJQFGRwTjK0gcyU5Umog3kn39fVM59eGUtu/jdCK8+0J/X6aOWwvIqfUbYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4678
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191103_105521_286921_5301DCBE 
X-CRM114-Status: GOOD (  16.18  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/31/2019 07:51 AM, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 04:24:18PM +0100, Daniel Wagner wrote:
>> All async events are enqueued via nvmet_add_async_event() which
>> updates the ctrl->async_event_cmds[] array and additionally an struct
>> nvmet_async_event is added to the ctrl->async_events list.
>>
>> Under normal operations the nvmet_async_event_work() updates again the
>> ctrl->async_event_cmds and removes the corresponding struct
>> nvmet_async_event from the list again. Though nvmet_sq_destroy() could
>> be called which calles nvmet_async_events_free() which only updates
>> the ctrl->async_event_cmds[] array.
>>
>> Add a new function nvmet_async_events_process() which processes the
>> async events and updates both array and the list. With this we avoid
>> having two places where the array and list are modified.
>
> I don't think this patch is correct.  We can have AEN commands pending
> that aren't used - that is the host sent the command, but the target
> did not have even event yet.  That means the command sits in
> async_event_cmds, but there is no entry in >async_events for it yet.
>
> That being said I think what we want is to do the loop in your new
> nvmet_async_events_free first, but after that still call the loop in
> the existing nvmet_async_events_free after that.  That ensures we first
> flush out everything in ->async_events, and then also return any
> potential remaining entry.
>
Something like following on the top of this patch ?
(compile tested only).

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b1b9dc58c3b4..36a859082846 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -153,6 +153,18 @@ static void nvmet_async_events_process(struct 
nvmet_ctrl *ctrl, u16 status)
                 mutex_unlock(&ctrl->lock);
                 nvmet_req_complete(req, status);
         }
+
+       while (1) {
+               mutex_lock(&ctrl->lock);
+               if (!ctrl->nr_async_event_cmds) {
+                       mutex_unlock(&ctrl->lock);
+                       return;
+               }
+
+               req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
+               mutex_unlock(&ctrl->lock);
+               nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+       }
  }

  static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
