Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B85C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DC9206F0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VaR19ag+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="nlXWBSZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DC9206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PFSvy4vxe7vQHLoGYTf886mB/Z4yKDNV/XYtg2xz5vQ=; b=VaR19ag+uaQ7J3
	H7DNjn3hXfbYu4Yweq81jLDjyUyRCeBewUXFfDtRAlW2d6L2gcaY9WsuLVhYKacH2pHXqFzpEUk8y
	qhquEGccnC1f+R5pP4AMymHdFFzEq/ippvxOYjwEr6iw5gW1ECaJlOR7Nl9X5nwJ4cKtL+bCQFI39
	ls89i7VXjKYIpZ3lmKuzOkVe7o0ow+7DIiLCrC4cEhX8NyzKoT3duWnqfNCPW5vPg5vHhoBK3wiQJ
	m9E09ZzvRozL2Hd28lQbG6i+34b4LfLsb9d6l/cBlyX7d70NzHufV5q+X4ES76KkkyH5UMPnkmmli
	nPrHaRcVSbi3zkVb+zrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ia0wj-0007HR-O2; Wed, 27 Nov 2019 17:17:45 +0000
Received: from mail-eopbgr760070.outbound.protection.outlook.com
 ([40.107.76.70] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia0wg-0007GZ-Ta
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 17:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJRxdnpLHQ/yrIqIY/oQrVhg7ZIszH+/yINQP3zOEfa8YRrgTQXko4FqBiEw0JUVuii/P5TfFGpP0HElfMAVCLBP09nqwm7ZDIh9/bcfJP5+fDAtekjRnMG62fQtBqEYz10xGbMK+w4zrYGo0pwp0J6976hFVOUracXhU4Ei1S41lpJ21SGP6FRNDZL+akiQ14AVecbyngKa/ngal80R3RW2dMH4YOcGIHKhORouc9LHt8E9O8caHCSSccBxfauMRqGUIK7IaADV028OZDprD6yf6Ff69obi+DpXPLk34NqpDz+C4l1iHiBmF8dneK+4yoM6D5F0813XOqsocapUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLY/O4bRqda86JlCUwIaakfQjvrWOgtj5xau4jwvjZs=;
 b=KgzBi1MWH6n5rTpBIhHaJEH9Dk97gC51mYqJZ/p/HomXago05WkwqEJHxuvCtH5vA8c6Fl9T7UwFkKflePbOBUlq0mwKwXf6laxLbjy3qAfJ6O1ACmrS9J7QwJx9FzpWKA5YvnOdLYyV4LV876QQL5SUBUBVHrWgO0N515taixceSbfYDFRHwcNkpIuxTHOKeqXFbq65zLJM2Mv5FYlPulwSeKP6wVGOAAE+c29MV2X/FSXY72mYr28ueKfKB7791ZZLVkeywmHwz05X0Ypq/EsLAyBAWBUaU2vrbPLNVvfEdgM2VeHU9s4EhoM21jyAyP0qusiSdE6A/9DmX2Wolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLY/O4bRqda86JlCUwIaakfQjvrWOgtj5xau4jwvjZs=;
 b=nlXWBSZUMj785FViGHFEZyUddPHFKZcCZBS9j0901OAQGEhnJngB/khrANeph59vY4kpLqDeZ7VGrYEtfEjPdETMAEjKRpJkqYzqnGNTmjotMjE+enZAaRX5ba2DZOMv3zKfdLG90oQIyRrL19oEQHArdtwRw3XDd8IefR7sXx8=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5682.namprd06.prod.outlook.com (20.179.136.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 17:17:40 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 17:17:40 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpF6Ymda5HHf+tUmLPGNyVZkab6ednfwAgAAHegCAAUsegA==
Date: Wed, 27 Nov 2019 17:17:40 +0000
Message-ID: <FDC2072C-CC27-444F-8CCA-863E932666FC@netapp.com>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
 <90bb47cc-8a4b-1ddb-be6c-d237bfbe88f8@suse.de>
In-Reply-To: <90bb47cc-8a4b-1ddb-be6c-d237bfbe88f8@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3db49191-7b3b-4bd4-d80a-08d7735db52e
x-ms-traffictypediagnostic: BN8PR06MB5682:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB568248A45E9DDA73878CA09EE4440@BN8PR06MB5682.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(199004)(189003)(81156014)(66446008)(14454004)(66476007)(26005)(66946007)(91956017)(8676002)(76116006)(478600001)(58126008)(81166006)(8936002)(71190400001)(66066001)(76176011)(6506007)(33656002)(2616005)(64756008)(256004)(71200400001)(14444005)(7736002)(229853002)(53546011)(305945005)(66556008)(11346002)(446003)(25786009)(99286004)(2906002)(102836004)(186003)(6486002)(3846002)(6436002)(54906003)(110136005)(6246003)(86362001)(316002)(36756003)(107886003)(5660300002)(6116002)(4326008)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB5682;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y01+ytJ6ciT5jZAemeMBLs+vCbOK+4OHy0vm7daYG7R1qfcsdhIVp+dWr3Qu6wKvz0ZVdDWgPOoJf9K1nUBjV16e7qI94I/J2Rp36eOgDv9jTOzj8ayGwLBJV0DyXKYmUPuZIB8/XPtzBWTHRSUNvUDPlpQ7fr4XDsMpysQr5d46cl+fbW6jprlOUG0iNNEu9GGSfc/dwoBsKkuR54vTv1Ssr+gZo/UdrFYGeUhC4FxLdDP95tY39mGgXxoK/pdBFHpSHgCGK+XmPZxTx1iUIm0nG93KlGFDH1OkQ/I1jGFbf+omuKyAUqhH/Hm9Jy66jjKjjcgW0gTx3F/JWUpV12/fk2QisJSx+bEEz7DPbC6uJlm5f4oArF4cn8DPMmmYQ0vHw22SFI4hv3MfxcIw9aKlXKG0EP8f7rxpzb9lp25yKc6NeUYi34bPlGiIhy6b
Content-ID: <FC2CB1CCF146DB48B1AA8254B3B758C4@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db49191-7b3b-4bd4-d80a-08d7735db52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 17:17:40.3974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFYWYS119xsf7lCaomPrUQaHrh2u4mTptPTw7r6zjjjx4Ffy1QzlKmt4vlcBnxzlq3oaBuGW8LwfMmJxwJCDbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5682
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_091743_046918_310305D3 
X-CRM114-Status: GOOD (  18.89  )
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
Cc: Jen Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/26/19, 11:32 AM, "Hannes Reinecke" <hare@suse.de> wrote:
    On 11/26/19 5:05 PM, Keith Busch wrote:
    > [cc'ing linux-block, Jens]
    >
    > On Tue, Nov 26, 2019 at 02:36:50PM +0100, Hannes Reinecke wrote:
    >> This patch fixes a bug in nvme_complete_rq logic introduced by
    >> Enhanced Command Retry code. According to TP-4033 the controller
    >> only sets CDR when the Command Interrupted status is returned.
    >> The current code interprets Command Interrupted status as a
    >> BLK_STS_IOERR, which results in a controller reset if
    >> REQ_NVME_MPATH is set.
    >
    > I see that Command Interrupted status requires ACRE enabled, but I don't
    > see the TP saying that the CQE CRD fields are used only with that status
    > code. I'm pretty sure I've seen it used for Namespace Not Ready status
    > as well. That would also fail MPATH for the same reason as this new
    > status...
    >

    > No, true, CRD is not directly related to 'command interrupted'.
    > According to the powers that be CRD evaluation is depending on the ACRE
    > setting (and hence should be evaluated whenever a command needs to be
    > retried), but 'command interrupted' will only be returned if ACRE is
    > enabled.

Yes, we had a long debate about this with Fred.  CRD does not require the Command
Interrupted status, but Command Interrupted requires CRD.

   > Consequently, whenever you get a 'command interrupted' you need to check
   > the CRD setting to figure out the delay.

Whenever _any_ CQE sets CRD and clears DNR the host is required to implement
the delay.  The requirement is on the controller to always set CRD when Command
Interrupted status is returned.

Also, the host is required to handle Command Interrupted if it enables ACRE.

But then that's the bug....

    >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
    >> index 108f60b46804..752a40daf2b3 100644
    >> --- a/drivers/nvme/host/core.c
    >> +++ b/drivers/nvme/host/core.c
    >> @@ -201,6 +201,8 @@ static blk_status_t nvme_error_status(u16 status)
    >>      switch (status & 0x7ff) {
    >>      case NVME_SC_SUCCESS:
    >>              return BLK_STS_OK;
    >> +    case NVME_SC_COMMAND_INTERRUPTED:
    >> +            return BLK_STS_RESOURCE;
    >>      case NVME_SC_CAP_EXCEEDED:
    >>              return BLK_STS_NOSPC;
    >>      case NVME_SC_LBA_RANGE:
    >> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
    >> index d688b96d1d63..3a0d84528325 100644
    >> --- a/include/linux/blk_types.h
    >> +++ b/include/linux/blk_types.h
    >> @@ -84,6 +84,7 @@ static inline bool blk_path_error(blk_status_t error)
    >>      case BLK_STS_NEXUS:
    >>      case BLK_STS_MEDIUM:
    >>      case BLK_STS_PROTECTION:
    >> +    case BLK_STS_RESOURCE:
    >>              return false;
    >>      }
    >
    > I agree we need to make this status a non-path error, but we at least
    > need an Ack from Jens or have this patch go through linux-block if we're
    > changing BLK_STS_RESOURCE to mean a non-path error.
    >
    > Alternatively we can define a new return value, if we shouldn't re-use
    > existing ones. Either way I'm fine with.
  
It seems to me that the block layer is never going to see BLK_STS_RESOURCE unless 
nvme_req(req)->retries run out... and at that point it doesn't matter, does it?

What's the result if the controller returns Command Interrupted status
for the same request repeatedly and we returning BLK_STS_RESOURCE
after nvme_max_retries?

/John
 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
