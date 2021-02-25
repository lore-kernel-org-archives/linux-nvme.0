Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970D9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 02:10:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2ED64EBA
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 02:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2ED64EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cgXno7BlQcJ4cI+DjaGk3zSAcv4xseSM7rVC9CFjAxQ=; b=s9yCFnehWjdtsmGRh92i14osN
	wVtjrZFvSUxjE7RlA90ifWWLjfmLCyzGd8j0h+L8h39LoGmxWY3PCQoJfbm/LaecNnzMm9xnrJQGX
	X9WoeWqDOjSsRDG6hxHYtQKhucMpbFVbugF9TWva52WkdbWnufhVW9G2gT5RryiX13GNrI+x7eVVd
	Ho5B6Ma0KC33/CBfVI7gzoDSQdddgGVRgR4TfI7l525IjaNOItmH2/j/Q48WoelPgDrmqTWSv7LvH
	xKbfQPSHf4abBGwtLJra2HeZYkj2byncE4KdKGnoSdkpOf6ZWdiF7JQTuuNenrPUQG3WJrMZoPmMA
	Ai3b8CNIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF660-0001Ci-UJ; Thu, 25 Feb 2021 02:09:41 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF65x-0001Bj-Qw
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 02:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614218977; x=1645754977;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=w4tahclUU3R394dVvjav2S+WPp7pfEtP3r3PC0HAnVw=;
 b=ZIbvQUznV+KVMW1IY0EHt5Fu0Ww7Z8fH3ZVkmAAbZFzZDpBf0bFfuyyX
 u+03cjgVRKAgpUGt1whVP2jwRtr3oQhkSkVjpY1jIsTx5l3q/MocbuGe/
 t3ZQU+EmU+c8zYJEyevFgMkfxvQehRKCved4hkwdd6HrWoi8iEkoTvYlw
 6LtDVBl/0PVDDkkynmNHmnirEz/cB+R56Oo/jw6FKkHLD3+OraJAjswQ0
 HDk6crvUSWW2DnHJZZfzzg3CGeFiiyWiCnFjG94c9kpaUjaxMyYOvKvWI
 P2G7S4srulWMBEu5qoGRfJI1BZixQEUpigXkcpOz28HyP1JZlCMoPDBIB g==;
IronPort-SDR: Qt0II/xwB41ParGRqi8s88CX8P4Y6GplvIgVjlQ+aslouc98Ic0qqVRCr8dhvLjMYYCDA76cd4
 hS0u7HVPGstF6uypeshIXG8+7xvjZFJ4VEisloSht1Hg9L2vbcsoaKKcpUuu0g0pauj9Ijx5LM
 m1U0KDd5vyOt8lsd2krbzi1ipGyt20ixSqDwL10jwySFXlRgnOViTDoWeCjqTFAMcnl/foT2S0
 M3XmpyDsjH42rbBDfVXjrgGLz1PRt67ETlql4rVYb1fASc5Z9Phi2EDLK839MLF9uhpS/TFsq9
 4Ws=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="271300580"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 10:09:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnCejFi6dri/OsgIVBkQzODf4YmzA0VWCmDgICYCiEaDeG8yQRdLILznwCOs8I/GuMENliZfs98SBO7gSSSggaDPfsgGmbxRzEoBPp3aBTi7kONKF7U6V17ZCH9MRqx8Z/FjIjLY756jqCi2Lk6pjdap2nINFROifiRH0DGReUKugIW/TpNcspJXQ0VL7h0rGd3raNbjdaTsErRO6j6/USA3YEN5FQmHlVYgseDWaFwo6p+396pwQzaqptBE0mbobPzBoPZwa0Y9afY9FlUIcWoWL58gfyuKFeDkpaXNxFiFwHK7ymZmRSpDyS2fA6a8iYkGbQe5fgruuTl6eoPo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSnVLMrAcFsUl1hAi3M2XAe27dYty+iR4bUgj4d+CB8=;
 b=TlD5FWUX5Vgj9G20ScMw6qBx7DaOMRaZb/ZEZJpR3gsEmtdIrpeAO001VvB2wi4seCGDdnilbF7Go0XDhICqC12AuRf3YCrrpXcO3mNIZqzcc/KuCk44Y+gFyKoxis+Cp/F5tByaCwZZzCIBuERK4CDyQRrb051/bzHLPEiefFkdRlwiSX4VjpFeoWoRnA+8/ogBN0UAvMobVlEpzSgEp400u0njwx1r7Ci7z84wRuG6YI06WfHXAYKYdn9+jBR9jqpkQEQKQGUu2AemcS1OCFkjozf5oeAGKOAeQ5fTr9gvK33QO2Nci0r5NpW5mz5Tr2nzDsp8oVNUklX6Snpi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSnVLMrAcFsUl1hAi3M2XAe27dYty+iR4bUgj4d+CB8=;
 b=oMsNsFwooFcszR7DO+kwioOtsdnJkKY65MGvncM0CWjZGK80Qb/nPbbYZ8EBBMPGq+cl8DFqZLFgFA4/fhhDzHMuYadmHRakP7v9I/SLD/7UlTPkvZi+h87/84V2flLkpfEDKcu57DkLhZD9x0005jTlzQCPfInT7/8ZwA5QKKs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5688.namprd04.prod.outlook.com (2603:10b6:a03:104::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 02:09:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 02:09:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes
 command
Thread-Topic: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Thread-Index: AQHW/qFWhMgmVmIHi0+62c2Fpd6hig==
Date: Thu, 25 Feb 2021 02:09:33 +0000
Message-ID: <BYAPR04MB496509F7429C820F6A8DF37F869E9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <YCOxjZhBTBchOq0n@infradead.org>
 <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
 <20210210131557.GB29904@lst.de>
 <BYAPR04MB49650A271CD1C1B3EFA72F3D868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210211070748.GA13852@lst.de>
 <BYAPR04MB4965C95C3F826D7222EB3176868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210224091326.GA5159@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51cb10ca-5a7f-4231-5c4d-08d8d93264d8
x-ms-traffictypediagnostic: BYAPR04MB5688:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB5688334F0E9A5F77FE808D35869E9@BYAPR04MB5688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiFURStxu4mlxu+ssU3OKgoBYOrQxGdKOt5wjam+lgzwtRGqDs+BlIPnG+XZd/uR8x9r0KB+NrBFgMN5k6OQefZc1zT8a5jiXh3/r1/trS0s7Px1LEvo690XNrqUEceC9N5833SbsHZVK7IvtYAKzhL1LOs6Gui2gGfeNAN6/f3DHQo82qOkl2XtH8hqIHnxS3FOr48xgZ9AfWjgztmnwflMENVqi0W1rBTP9En91oALuMRultB/qiY+suqprlVd7e0Xzf6Of0SCkSncYyow46DyKKCtoKoKtLQT88dxH8CPIW/aVm/FC1vF8swQw6xXeQVJF10GTfPf86trHLfwWubO02ER5UKrgCdq+vnROPrk4SLPDNjACMRAs7AkN/6p+477VM7chfbrV+vTb+ClMJ0be7oAx/IhwbrE+5uWZNUeyFHRJsBU5EyadF0Zavz948zGrroHoxUabSSO82yrZgJ2VTyAkPMtyUJ7nwlnJxZLBX0j56GyEnzBKz3mbJyUxtQMoCAPoYU4016DCgl1Kg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(9686003)(478600001)(86362001)(6506007)(6916009)(54906003)(76116006)(4326008)(66946007)(52536014)(186003)(7696005)(64756008)(55016002)(8936002)(71200400001)(316002)(66446008)(83380400001)(33656002)(8676002)(2906002)(26005)(53546011)(66476007)(5660300002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?We/9nB/seZX4ka+2UMKAkRSq5n8ejyAq633xITHciUkUssCqwvx3ADempes3?=
 =?us-ascii?Q?iTK1KwzuCSZb/nWKb8In4Xam5SirlXuYtLUnnJlEMJWxviwukEb2qODuIG5U?=
 =?us-ascii?Q?u3iF7Xk5pVF8PDbgT7uS9kYrb6BV5Ln9RJX2KqvzyfBm9+wlfM08trbDHeZM?=
 =?us-ascii?Q?NaeIozWPVhu7tfDoGZl5okUm2q3x9f914WG0uHd/PwpY3XEX+wkPWZ6ViBmY?=
 =?us-ascii?Q?s0iClYYiNyl4/4oZYCzAIBAScTojo9Hp1//FLCNfLVl07CyJ4qW/B9VKxqFQ?=
 =?us-ascii?Q?47rp8tp57nSpfUmhB/DI0QgUp6g8EemLSm6IaKp10OkT/IeYllbfytXtPf+K?=
 =?us-ascii?Q?QXiocH2BCKA7yHYNlOy5PzCC1lrcgNrpxHVMSfgCSD8OISBebwv4C/niRwzu?=
 =?us-ascii?Q?C1gxIU1JBeJVf4OzVd1I7UkKTOS/d3pUFdPqX7JDKiVjENHc1sYXcBkN9W+i?=
 =?us-ascii?Q?Wn+bWTcxL38wNRpwLvjo4ZdylMKpz65Qpl6st70oxp2JlTHmXKfklSCqFotB?=
 =?us-ascii?Q?qqwqLOy0wzxCgtlNVK8AqNlsYckE64rOD2B2Ks+aOhnzbg0xn1vq5sKZLhYh?=
 =?us-ascii?Q?37F7Z2O7JCZiFCm0D9DkduieUnF0XDIVSx5OgxYjivQrBYoeQbsIjHyvyHh9?=
 =?us-ascii?Q?nvlFyw9S7n5Fh4i0C1FQZsL+uFsNGF/dTO5CMV4QFDuPaVEut8NY+NvYqsMj?=
 =?us-ascii?Q?TOrsYKo7HJqTY14L587K7GK6Fwpye5GIzuEllIlX8BTwAVdcEEljx9hvUqQZ?=
 =?us-ascii?Q?sClCKUZ2imaKdzvHbLMC18vgg1xxjLiICz71979M+5vRZHQSsE+8OAmKxGyl?=
 =?us-ascii?Q?I1/9+Br/MZR7zmFwofsVip2k65JIslm32sUeMapbboTfQms0eKj0PoygUrDI?=
 =?us-ascii?Q?1mf1YA9fUyCOOC1OTlpKcwuXheCF6NBjpeKbptxW2OQy2vdyzFRPt2kGAUPZ?=
 =?us-ascii?Q?yxanaVpH8ALOG7Orriv3VHjt9NJvgWPYy7MwDdlGAkvkvr6uWTF8OezEXxtO?=
 =?us-ascii?Q?8mKgo9wMPHoNuNInj5ZdodZKbTUzkd1nRUQ1zxbLzhcD6XpQkTv740JJCaxD?=
 =?us-ascii?Q?MQMY/NzXxrdVSlDjZT8Y71GdeAk1IPyrgmkv4J3vxlKGKr2pSXwdGGdTKV/K?=
 =?us-ascii?Q?Wkqu3P/KmjRzQnIogbnndwLSUv4TxWpwaAt50Lw69PL4qRNlP+/72PoLV7TT?=
 =?us-ascii?Q?RODqo/8KrI4SerY1J61Q+dQNAlIRSI2Tz7/rEZFtoaxCuDGfW0QZiTm7x1al?=
 =?us-ascii?Q?EXwECiS9pjc04cfvJmc58z9+tByVyvocrVLB3iZ7/o8ppW/5AGRYiOEtKL+4?=
 =?us-ascii?Q?xmdb/P1f/9wuzjphqG2dS28upAnFYn7xoTrs3Qrbsef1tg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cb10ca-5a7f-4231-5c4d-08d8d93264d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 02:09:33.4759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7LlYAe9yrcqe+k/l058RZTj33tQLwfcFNBDgtCsAsu9zLPoSawoHiwhil8jB9LOHaB/UHiP+hVopfKXK8V11uhcRw9sg7FhQddb1nhL3fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5688
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_210938_102230_5FEF9AB6 
X-CRM114-Status: GOOD (  17.44  )
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
Cc: "hch@infradead.org" <hch@infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Gopal Tiwari <gtiwari@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/24/21 01:13, Christoph Hellwig wrote:
> On Thu, Feb 11, 2021 at 06:11:19PM +0000, Chaitanya Kulkarni wrote:
>> On 2/10/21 11:07 PM, Christoph Hellwig wrote:
>>>>> I'd also love to retest most Write Zeroes quirks with that in place.
>>>> Do you prefer some variant of the following patch (totally untested)? OR
>>>> something else ?
>>> Somwhat.  As said I suspect defaulting to MDTS with a big fat comment
>>> might make most sense unless the new WZSL is set.
>>>
>> Okay, will send out patche(s) soon.
> Did you get to this?  Or did I just miss it?
>
I sent out WIP to Gopal on 02/13 due to lack of drive.

Not sure if makes sense to start the review where patch is
not tested on the real H/w, here it is :-

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..62c928fb0ded 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1965,6 +1965,7 @@ static void nvme_config_discard(struct gendisk
*disk, struct nvme_ns *ns)
 
 static void nvme_config_write_zeroes(struct gendisk *disk, struct
nvme_ns *ns)
 {
+       bool use_mdts = ns->ctrl->quirks & NVME_QUIRK_USE_MDTS_WRITE_ZEROES;
        u64 max_blocks;
 
        if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
@@ -1980,7 +1981,9 @@ static void nvme_config_write_zeroes(struct
gendisk *disk, struct nvme_ns *ns)
         * configured based on the controller's MDTS field in the
         * nvme_init_identify() if available.
         */
-       if (ns->ctrl->max_hw_sectors == UINT_MAX)
+       if (use_mdts && ns->ctrl->max_mdts_hw_sectors)
+               max_blocks = ns->ctrl->max_mdts_hw_sectors + 1;
+       else if (ns->ctrl->max_hw_sectors == UINT_MAX)
                max_blocks = (u64)USHRT_MAX + 1;
        else
                max_blocks = ns->ctrl->max_hw_sectors + 1;
@@ -3136,10 +3139,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
        atomic_set(&ctrl->abort_limit, id->acl + 1);
        ctrl->vwc = id->vwc;
+       ctrl->max_mdts_hw_sectors = 0;
+       max_hw_sectors = UINT_MAX;
        if (id->mdts)
                max_hw_sectors = 1 << (id->mdts + page_shift - 9);
-       else
-               max_hw_sectors = UINT_MAX;
        ctrl->max_hw_sectors =
                min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..906b26b3d306 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -150,6 +150,12 @@ enum nvme_quirks {
         * 48 bits.
         */
        NVME_QUIRK_DMA_ADDRESS_BITS_48          = (1 << 16),
+
+       /*
+        * The controller doesn't allow the write zeores command of size
+        * more than reported by the MDTS
+        */
+       NVME_QUIRK_USE_MDTS_WRITE_ZEROES        = (1 << 17)
 };
 
 /*
@@ -274,6 +280,7 @@ struct nvme_ctrl {
 
        u64 cap;
        u32 max_hw_sectors;
+       u32 max_mdts_hw_sectors;
        u32 max_segments;
        u32 max_integrity_segments;
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 207137a0ed8e..f9f36d26828b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3268,6 +3268,8 @@ static const struct pci_device_id nvme_id_table[] = {
                .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
        { PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
                .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+       { PCI_DEVICE(0x1c5c, 0x2839),  /* SK Hynix PE8000 U.3 NVMe
storage */
+               .driver_data = NVME_QUIRK_USE_MDTS_WRITE_ZEROES, },
        { PCI_DEVICE(0x2646, 0x2262),   /* KINGSTON SKC2000 NVMe SSD */
                .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
        { PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb6f86572b24..38fffee6b85e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -688,7 +688,8 @@ static struct nvmf_transport_ops nvme_loop_transport = {
        .name           = "loop",
        .module         = THIS_MODULE,
        .create_ctrl    = nvme_loop_create_ctrl,
-       .allowed_opts   = NVMF_OPT_TRADDR,
+       .allowed_opts   = NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
+
 };
 
 static int __init nvme_loop_init_module(void)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
