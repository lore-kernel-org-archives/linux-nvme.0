Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C1C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 04:52:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6C360FED
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 04:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C6C360FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=26/ah4oDE+4JMRMNFUdl3Br0EEtpwhXGiveJxxFU+RA=; b=sjKEiWo6tuKX2Q
	3E8yekHrINhovqZu82oodOVyHJrt1gYkzfcOjNEDmtXTePtJnvAQuDZgFU/rYpgB/r/Jsr23Zg8mu
	IrmzwI2tZif+x+slzXltxeSyDJTjdD1ksnYmQbU+xnEsSHDlGnxxWFsKlRzSMfgyvGxG4ERsdRqHd
	l3tAsmAg5dvp7YRLhS2DmuB9L/oNjb1fRsoO71jah2qQOEPqC2iL0sOodsHEEkoHe7cdXoGddR6LM
	xCKhfDDXwy9rltj1aoNqTQ5q2fIojPIAKIfdU4qK91gx4LLdRR3xNo0/SVfoXfn+BvjNUGXEZqbtJ
	xBP9qVjiYkY8r/BtK4/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUicS-001YyJ-UY; Mon, 27 Sep 2021 04:52:01 +0000
Received: from mail-ma1ind01olkn0143.outbound.protection.outlook.com
 ([104.47.100.143] helo=IND01-MA1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUicQ-001Yxp-1M
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 04:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQztUy3opnu6g473NOV0KVM4z1XAmbfeI3XNHjjb8g2ckhkgHDcnc/vaP7MHXgfU0eTdQPhrTnmncoUgY0n4lG/8vlJYmk4dPefKVwqzc8nJt98A19pLmU/xfTBbxFyEvt3TZTH1grmBowhcc2FUa+3LpSEmRb5pA9TPzcgCg6Yrr40w5O7oT2NY+0w5+Goyz3uQxHld7+zxYfFNMYotv365oIAsv31pgDTcc9g2DqW0OLclVSACZyjkgfhSGthUaE2cTg6OW/427+zajbSm4hp36cTWEQA8KPYrTf9oZtuVLNCDReCFdDkb8JD02eoKRHky9p2SvvgVr+YeyxM+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ohqAZxbULPnG7HzMclSqjh4dwvbun6Qb4uzJviiyiwI=;
 b=bCYkGnBVl82EoU8bgWpNNLEEC/wmzRCMNBXI9CbesqsUpXJ0CwJAU+vBqmNw42znbpSHAjCg5Q+uCHv9VbPjs9nTdPvd0QbIqq4JkDhyDxSgxygU9PRSqKku4Q0Qp2waJeRKO39vlpc5AUnZ/tOBR83ZoCpBe5PmU9Nrds0O+wsJKoFxQA6r7SclC5kWIdFPD+IvDG0u4f7kBYWcArvxsGcJUMGGwwrQiDCmsTf/dKMUVNrccw2IZ6hYDGJ7PiEgAzKwqLkfL9aKze4xksJxfcv7L1w5RhYQ6KAJ0kKk/Z/jqPlSZeCHk5vvgYN3j1B8FEf2h2Q0hwoU+0fNdd0SJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohqAZxbULPnG7HzMclSqjh4dwvbun6Qb4uzJviiyiwI=;
 b=QVRMVV5gM2ppr22nvX5mkyY6EklULWuTR8Bik+7sEaJ6+yHQbQfVYrJXUiQeqCRRKyTrn16ffWw3VaUxnDMVfbzMkGNOt4d5jtm5FjyViW96ZcdcZTHx9o4fOZdZAec5YARqJ0wo4V/GdjJjiqHvMOqctRMzkBnLtcdP/sMNiXLr/ZrTOLBzZn1osBOerM95s2/AKG76Xv+lT+soVN/UyXbylGVB8bMQ5tnFq4rSI+qeo/kpfS1pt1ZaI8lnIp6Tb8Ro/5mRN6P8u658SQrPPXt2EV0a28Urwlff6Zu0MXNy6dLRoDdHn8Ac/RTQyZgM3Ng+/gDiXiGvw2yJaeZvZg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN2PR01MB5303.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:41::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 04:51:40 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 04:51:41 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Orlando Chamberlain <redecorating@protonmail.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "hare@suse.de"
 <hare@suse.de>, "dwagner@suse.de" <dwagner@suse.de>, "hch@lst.de"
 <hch@lst.de>, "torvalds@linux-foundation.org"
 <torvalds@linux-foundation.org>, "axboe@fb.com" <axboe@fb.com>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
Thread-Topic: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
Thread-Index: AQHXsg7CBo+QhwDP1UmDUyEbq2iBR6u0/f0AgABrS4CAAClygIAAHUkAgAALvgCAADxJoYAACSmAgAFJI4CAAAePCA==
Date: Mon, 27 Sep 2021 04:51:40 +0000
Message-ID: <PNZPR01MB4415F35759F136E812A8F91DB8A79@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
References: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
 <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
 <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
 <20210926020839.GA96176@C02WT3WMHTD6>
 <1a6f5030-27d9-d1ae-aff4-0ed2a10dce6b@protonmail.com>
 <1b5d6bef-db6f-073f-8d24-4963f0df82ab@protonmail.com>
 <PNZPR01MB4415801C6084E8CFD068A84AB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <d65ecc69-35c9-4400-8fb0-95aa04360b03@grimberg.me>
 <31c4dc69-5d10-cc6a-4295-e42bbc0993d0@protonmail.com>
In-Reply-To: <31c4dc69-5d10-cc6a-4295-e42bbc0993d0@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: fdfe681c-7e35-0900-3d68-f150ad9ae297
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [fAPw0Df6oF/JyrNv7ppmT+hiArvnqTWF/7rM8WXHIxa3K/pYowHL1M1+ewfQtOvU]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c45e1c-ec1d-4e64-82ef-08d981727f39
x-ms-traffictypediagnostic: PN2PR01MB5303:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2wM+pbR4hQme/EmwA+fmlN8y4dzR0eS719jQgeyR2g0Rr+lYKIJNNTk+thUyN3nFpInd2rfEsxqW9ma2alIxyVfSmUb0Dv/vKGWl0WlYLh0Uti6zh6sgIb25UP25ec8evT1tQGR5CopS+uPda5TC6H31JHFs2fFfQo6CmsJa4I/sb1AYUmyYtNxZS/A/ihMHP1OIWwlU+Ae0DfmOZKBLSmbgVvjIRWAUczDZ38l5zsMJp91cB8qxBln3lwYaflVfx7uZMkVQ53z/zvSK1DA8Ut38ryC0Xu8FLlX+pxWoJF7so/iwQvS5Yt3y/u4gh0uRxB/1o0mlx7afqaJFiStBIkvNsZNsweesETARP02gHSMARCLl8F6xlqD5RsCTgEjbTUIYG/CgHezO1tcL9sk9CkaI0MJW90ZEOSbokxhCsUx3iZUPNE8recN55v3hFp1/c8iFhs8qvwNTbKMKXtZjKTyTwGBTQJ7PWqXKshZY3X4DPanW6H2LbdpGKnmqrYK1K2H1HDblfy6Uxlg5SkKZQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: Bd/jQMSCrc+iZPb6hRJtGBBxbn6cTxZlxX0ZmYDD9zNz+PmY4SxhYbanj3F9PBB0H/KTegkU14opJ8VMuCdA+D3aigYnjq2M1qvKxd0PBisIVTAfDECOYndjVmTM7GxrN3+SlW4wq+4UClkzj4wx4yqbrB7OaNr9uMSgBEct3rf8C0m8K8KQoT2t908Spx49xaVrahdoFS7YiP5Z2Udb6A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c45e1c-ec1d-4e64-82ef-08d981727f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 04:51:40.9509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB5303
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_215158_091678_8C0243A7 
X-CRM114-Status: GOOD (  16.18  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I am getting the same error.

________________________________________
From: Orlando Chamberlain <redecorating@protonmail.com>
Sent: Monday, September 27, 2021 4:22 AM
To: Sagi Grimberg; Aditya Garg; kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org; regressions@lists.linux.dev; hare@suse.de; dwagner@suse.de; hch@lst.de
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for use-after-free validation crashes apple T2 SSD

On 26/9/21 18:44, Sagi Grimberg wrote:
>
>> I checked out the proposal sent by Orlando Chamberlain to replace NVME_QUIRK_SHARED_TAGS , by NVME_QUIRK_SHARED_TAGS | given in the patch on http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html. The , still causes panics to the T2 as described before. In the case of |, the kernel boots correctly without panicking the T2, but in case we are having Linux on an External Drive, which is my case, then the internal SSD doesn't seem to be recognised at all. I've tested the patch on 5.14.7.
>
> That sounds like a separate issue, because with this patch applied,
> all tags should be within the queue entry range (with generation
> set to 0 always).
>
> Is it possible that the io_queue_depth is being set to something
> that exceeds NVME_PCI_MAX_QUEUE_SIZE (4095) ? the default is 1024
>
I've been able to reproduce it by using the same kernel Aditya is using:
https://github.com/AdityaGarg8/T2-Big-Sur-Ubuntu-Kernel/actions/runs/1275383460

From the initramfs:

# dmesg | grep nvme
nvme nvme0: pci function 0000:04:00.0
nvme nvme0: 1/0/0 default/read/poll queues
nvme nvme0: Identify NS List failed (status=0xb)
nvme nvme0: LightNVM init failure

It might be because this is 5.14.7, while I've been using 5.15-rc2. Additionally,
there are differences in kernel configs, I've put both configs in this gist
https://gist.github.com/Redecorating/c8cf574df969f9b4f626dfb9c6b2a758


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
