Return-Path: <SRS0=IJIS=Z2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6492CC43603
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 14:48:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276AD207DD
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 14:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="riKJF8oQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="NOn5O2md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276AD207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KB8dIJG/a1kShbjBD0mTILVYKAtIIFGUQqsDDYfXDO8=; b=riKJF8oQOoxqeu
	iHPHAt2YKmT4HWApqyeLCVAr/Xt6qDDAS3T9cCh75iOpe7NetGzFrad61kLmoiVx3/IRAGxBtiHQC
	iCJz7cMqwfQqqYLHmD+EGHH9dWnBE32P6W8QWVJBYxC+Jf0o14+qaqZ7c6nxWyQTrVgFTykRakChn
	f9G2mUrAEtoe9vJMI5xsS5crOT17A/dDjd14xRcHb62LXgXJUUXdq+Hzd408e22EXjTOt7Kzek/T3
	m0Tq19bhZrZND/w4IInfiWDKjponepAfOdV0qk30m5GkQqqTnY23Q6de47pqT4D0QR/58VG4rHSbp
	nCfmSHfrppDJMlczOKlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icVwk-0004r0-8n; Wed, 04 Dec 2019 14:48:06 +0000
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com
 ([40.107.237.71] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icVwg-0004qO-O8
 for linux-nvme@lists.infradead.org; Wed, 04 Dec 2019 14:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAWiw3o1hJh0XL6DPzTOTNGkZHqswWbTATrp/fuU4SGlk+IFa8QktzC7uGq0idNaLjJeAAUMXN8moNPmbiUmqhcRQYwBv7vPD7IkVIb1dB5VLg+wN/eywktFEpPz8deNdv57lkzeFAxmj30jY7+McRdhDBbAJbv0BDzcSCtUgOdupGly+TpGCi6F69XM0H1Ldzpdcg9q8m1A2aYqhxp8ZaPrKi19UZxgoBgK4sOeO2tyeuzpCHGNxERzc8wJMR2LjNK7xlMoyD4MfqqDb8N3cqsNmSxOvAPYHKwjuN21vdzXf96oDnD9D6pSh91az3/S2bE8OEBy1LVJolxrY+9cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suY5JfKDKMNNqzfeFCKtW9zdjzWwfcRDWVvuUITb/zs=;
 b=jf3aOy8Iv57Ve43J+jDeayOUpz1nORnt5vwlqfkkl2b/vjSmWLKyJ0inCBDqzO0boPONrvfAdGltFA56uD1nNFR/ovCM1MrBws9zibozF4AJXT8i+iqMXQwpnpo8VmvrEmusQ2XdNLokEP5Tzen0SYy0ddiozYOFBxg/ODRRUT6doxy5t2+hCHQd5CTYDENeqLBFqULJUj93ULhW7zIDQCTxMpkmeLovQEu2JCfuj69oEnFqRSKsKJrZvzreD240+G/rLU/I3F67wqq43qe8XJAKI4FFj8B0Qoi0rjz38QeXHG1X2hyhmHM96N3nHUe4/vg1ixCPp/dHNCDEbagGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suY5JfKDKMNNqzfeFCKtW9zdjzWwfcRDWVvuUITb/zs=;
 b=NOn5O2mdAzYIY1bicxz4QrNqk9CIx61PfRHI7RrUVaSlNjIUvDCOZ14lmvZslVhlp1pEJMSZv7R4NXj9Xut/2PInl2H3eAJdzhNfpPzUibGc54bMc3yXNySHfqDxz+iqVRCmbxez7Fn1PPUO0D+KkZSoQdOpSyKn7KKhJJKcwXo=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5475.namprd06.prod.outlook.com (20.178.209.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 14:48:00 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 14:48:00 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Jen Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpVats5+vHBHUUEmIVsgThSKMw6eoYlUAgACMT4CAARNyAP//ww+A
Date: Wed, 4 Dec 2019 14:48:00 +0000
Message-ID: <8FAB1EDA-3B06-43A8-92BC-E0840593E144@netapp.com>
References: <8D7B5AD6-F195-4E80-8F24-9B42DE68F664@netapp.com>
 <24E2530B-B88E-43E7-AFA2-4FDA417B6C1E@netapp.com>
 <20191203210015.GA2691@redsun51.ssa.fujisawa.hgst.com>
 <04835a2e-1769-36c9-63b8-173f247c862b@suse.de>
In-Reply-To: <04835a2e-1769-36c9-63b8-173f247c862b@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbf1833b-5fee-4d73-c6c3-08d778c8f58e
x-ms-traffictypediagnostic: BN8PR06MB5475:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB5475F16852169B0C27625827E45D0@BN8PR06MB5475.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(4326008)(107886003)(66946007)(3846002)(229853002)(478600001)(6246003)(6116002)(33656002)(76116006)(6512007)(2501003)(14454004)(6436002)(6486002)(6636002)(66446008)(64756008)(110136005)(54906003)(316002)(66556008)(58126008)(25786009)(66476007)(14444005)(305945005)(86362001)(36756003)(99286004)(5660300002)(53546011)(7736002)(2906002)(102836004)(6506007)(186003)(26005)(2616005)(71190400001)(71200400001)(8936002)(11346002)(81156014)(81166006)(8676002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB5475;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lxxAzaOghv5rKzy6yM5yYsn0IvFQ9h30s9qCDCC2UvwEVEiuj8aJFD8Ny9xq4nCNkPQNpMLAGZ+V4dCgNDf8GotEdybEChsWFN6hkTQcZHofklfi8ige8qQZ+d/5rvWwebBGICGj2DLeTPcAAflg3CR1aNBg6c0OkKrlVTJ0rU5kjVwi2THdTWMt2j54TApTDAm0yD3pPqHWve/TIF9RaZTyW12TnF9CmjkW4BJAiCWHlQ8YqoyejDz9av7tTUWTw4PT/0WW2hPsxjO5E9tiGDusMdbtn05dUrkb5CvFc9RY1C/G0ePdNm3VkRM6lxaXxl7vEr6o0CvFEjKnM4fbBCZ95h8XplNXXy+wI/4Nqktlz9UeUypYuY/Pc5pr53sYvcK5rHhHyojIsDGqmGV7QtGseK9J51DumtU33UZ1ql3ZuOuj9ki0QEtsSUuDkX1u
Content-ID: <6804DC86BD225D46A4563AF55F704A03@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf1833b-5fee-4d73-c6c3-08d778c8f58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 14:48:00.3502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoMN2fGcY+SNwidL67Ik4bzRYViCgMYzVGNPkLp3PAAYBpbB06ymxBNJtfA8dLa+Qqfnnb1HaGfu4X3xaVv6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5475
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191204_064802_843956_C7A36F84 
X-CRM114-Status: GOOD (  22.02  )
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
Cc: Hannes Reinecke <hare@suse.de>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

    On 12/3/19 10:00 PM, Keith Busch wrote:
    >> If the controllers returns Command Interrupted too many times, and nvme_req(req)->retries
    >> runs down, this results in a device resource error returned to the block layer.  But I think we'll
    >> have this problem with any error.
    >
    > Why is the controller returning the same error so many times? Are we
    > not waiting the requested delay timed? If so, the controller told us
    > retrying should be successful.

Yes, this a problem on the controller... but I only did this to test the pathological case.
I think we can all agree that if the controller is going to continually return Command
Interrupted, the controller is broken.

    > It is possible we kick the requeue list early if one command error
    > has a valid CRD, but a subsequent retryable command does not. Is that
    > what's happening?

Yes, as Hannes said, in the current code: NVME_SC_CMD_INTERRUPTED is not
handled in nvme_error_status() so it's translated as:

        default:
                return BLK_STS_IOERR;
 
This works fine with a single controller,  but when REQ_NVME_MPATH
is set the code goes down the nvme_failover_req() path, which
doesn't handle NVME_SC_CMD_INTERRUPTED either, and we end up
with:

       default:
                /*
                 * Reset the controller for any non-ANA error as we don't know
                 * what caused the error.
                 */
                nvme_reset_ctrl(ns->ctrl);
                break;
         }
    
So, the first time a controller with REQ_NVME_MPATH enabled returns
NVME_SC_CMD_INTERRUPTED it gets a controller reset.
    
    > I'm just concerned because if we just skip counting the retry, a broken
    > device could have the driver retry the same command indefinitely, which
    > often leaves a task in an uninterruptible sleep state forever.

No, I'm not recommending that we skip retries.  My diff was not a part
of this patch.  I agree that it's not safe to skip retry counting.

    >>     diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
    >>     index 9696404a6182..24dc9ed1a11b 100644
    >>     --- a/drivers/nvme/host/core.c
    >>     +++ b/drivers/nvme/host/core.c
    >>     @@ -230,6 +230,8 @@ static blk_status_t nvme_error_status(u16 status)
    >>                     return BLK_STS_NEXUS;
    >>             case NVME_SC_HOST_PATH_ERROR:
    >>                     return BLK_STS_TRANSPORT;
    >>     +       case NVME_SC_CMD_INTERRUPTED:
    >>     +               return BLK_STS_DEV_RESOURCE;
    >
    > Just for the sake of keeping this change isloted to nvme, perhaps use an
    > existing blk_status_t value that already maps to not path error, like
    > BLK_STS_TARGET.

I can make that change... but I think BLK_STS_DEV_RESOURCE might
be, semantically, a better choice.

[BLK_STS_TARGET]        = { -EREMOTEIO, "critical target" },
[BLK_STS_DEV_RESOURCE]  = { -EBUSY,     "device resource" },

The one use case we have for NVME_SC_CMD_INTERRUPTED in the Linux NVMe-oF target
is a resource allocation failure (e.g. ENOMEM).  I think Hannes came across this once 
while he was prototyping the ANA code in the Linux NVMe-oF target.

Another potential use case in the controller might be deadlock avoidance.

I was experimenting with NVME_SC_CMD_INTERRUPTED in my controller as a 
QOS mechanism.... but I don't think NVME_SC_CMD_INTERRUPTED /CRD is well suited
for that use case.  This that's how I created the pathological error case in my test.

Either way, I don't think that running out of retries when NVME_SC_CMD_INTERRUPTED
Is returned a critical target error. Moreover, it appears BLK_STS_TARGET is, everywhere,
related to some kind of LBA range error.

/John

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
