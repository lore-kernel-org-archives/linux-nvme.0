Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4961FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:45:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079C3206B7
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1EzydcIa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bh6gl0fm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MKaJwVVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079C3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=pZkfHAmvm9KRCSqg/9kHsqBy0Ch2GIPXGIsAa3nqqBk=; b=1EzydcIaLPwFzIAQ5tNDnZIEF
	hpKck6EI92sWRl8Vcgq8aeKWqc4uNfzoQXRTlMrLEFsVw9dHNeTO3WfYRrvHUPZ4KxBock19ZBSPd
	EC9kJsIJTZ6X2oT9kOoKyA/Llrq1n1wDMvDA+oMOij+PTrZHOKpT/XXlVQmt571qkBDSC+YlVJztV
	gTC22UCjBsoIG+FKIRURn83Ox4KLalkq5ZU2EMSH5Uq8uHcgI/hXDXcQXS3vo3lIZQ5T6WyABSnf3
	FXnCWVplqF4MKuR2++ois4jVO5LqHGlKtJ1cDl3sSegDCCT2HZFK/JCqz9WJjb69SJkyzTh7Z23Iv
	vqmjpHnnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolrM-0003iB-8G; Fri, 26 Jun 2020 10:45:28 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolqr-0003V5-VN
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593168298; x=1624704298;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=C9NdNwRcHDIdkR39gpY0ry8Ns5xsG6Iyjh3Q8KgYGgM=;
 b=Bh6gl0fmysaA9044d/LN5QR6PlMJy+P5umT7mGJrX88paZBOOA4YSyNd
 nN7n63JB7eBcx21YoIOwDyiI+NF/HHai/uegtzEj+HUwPY+P52pjhKy4l
 2MNzNXXtq/+mPlaXPErprEp93BWL4k91KWva9kui+6GV7NrkXYDwQZySx
 lmQb7rMrN4bdx/r9xYvcf6K2+9JFAFnB+LnOiUe11zFXwstVAl7eAfEAk
 LAoW12cNIR/+zUOEkMFsP+9VGTZIZzIQVuxq6ahN5QQxHzMoiz4xNjPMS
 Ieezfn6XY3G7C52eQMeWi2GtZ0gJlEJNL91QnV1+waCW+Z/qMjI0mbvxm g==;
IronPort-SDR: 0ju2qf9KulTnrcn7yT3XuvpfED74IzfPdig3HU+rlMwULP3Av9rWL2QxbtCQa9n0636lhNiEHx
 AXi+KYHge6w6/ODUYmfMeS6OHlC4u28g7/7ZCl9QuQty4PRoRWyXJTk8GPe7U2hsS2vswGk4D7
 LEPKfJV7WwgIjqQOSEKepeC0gvaQskiMqwYA05Ljnf+yFqah9osAIEfGx3mkZ2/H7tcTKqtPKK
 cgeVlXPFypSj1k0tympgBeYgkpDCFfFKvvh2F3/mKXWdDzioV+kSPnrTV/sDkLKEZWplisnVgc
 AqI=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; d="scan'208";a="142346710"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 15:06:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkJbYhoB9WhvttygzGo+vLPKrJ6aIh6JrTF+dpA7TdysjXpK02ICU/r49dyg+JuFxvonJWvWBwdzdJhJH8LCgGsL+PXLPQPtNBJ6jdrLV3+QNu39ggY8hgzBnvwg/qfu+FoY8i0HNeSB4Qf2sVaf1miYH2cAItEWiKTe5ddO5df1lVdBprvMPzZxPArLYtIRKbtdNDUWTMFe2MVyK3MhYwHA8yzbe1+CRssiQXRbn71YlAiDFRUvJowt5u+aZBI8QOyNwEyXcyIrgaMvYxwFuQzH/mdi24VBvrP1UHidyNNALTMknkk6zeN77YACzxJ56GT9c+wr6ramb1rQVmvhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clnAStJUcMgNAK5FKKBCCZS79EBLTojaoXzkOvzXlSI=;
 b=lcZq7NFPc99whZ0wCY4eqYz6XEqXPt0tubz4MpRmYgZxRzhO1V2Tmw+ujw8MMx+rPoGIs9ztuwG/opTCPYw8xpNtK+7v2qqiIr4DrBk00N7vuNQPlplnBLqlHXt65eKZ9TZpIAfnYVL2Mq+GOEg1ym/+rYI0ypLUHpnqWhYyGEBEnFWUbdIcEECu8m9fGPb0ryTRbCbXMdm9VAyBTVPXTXjHDC2/k7Hi4LVYs3CmFjYgyJd2BSzXnbqioK/UFysdiNVF+xCSpcJPWcj21XMoJUYzz5lU9AmJ67Zuo/tkBQOTO0Y7P23EVQKT+ZDACRr20t/f4F84IZZVmAPF7m7d0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clnAStJUcMgNAK5FKKBCCZS79EBLTojaoXzkOvzXlSI=;
 b=MKaJwVVaIbEynDvq7EiDK1xo8G+LTXmuSb/hFzKJXGb9gCUCLIIYM7YdP8l5rEuilwzsSMLiCdUxKP6ch5WEs2Ugj9/m05jm8i5ejMWQvGlT5BMCujBSR4oOJhU5DouD45FiHtWYbXTH0LPmOv4JRVdzM+8Oai5D+70Ak26nwOo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0344.namprd04.prod.outlook.com (2603:10b6:903:3d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 07:06:34 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 07:06:34 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 2/6] block: add support for selecting all zones
Thread-Topic: [PATCH 2/6] block: add support for selecting all zones
Thread-Index: AQHWSutRrDHAt43U1UKTuwgck7oDsA==
Date: Fri, 26 Jun 2020 07:06:34 +0000
Message-ID: <CY4PR04MB3751CD082BC0F77A5284EC34E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-3-javier@javigon.com>
 <CY4PR04MB375143652B4BA25F1680A91EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626055852.ec6bfvx7mj3ucz5r@mpHalley.localdomain>
 <CY4PR04MB37515E78D85933EAFE159B0AE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065241.u4fd3m7624kdsonw@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5946aa23-a38d-4b97-263e-08d8199f760b
x-ms-traffictypediagnostic: CY4PR04MB0344:
x-microsoft-antispam-prvs: <CY4PR04MB034477B9C07AB2913BC0E8B1E7930@CY4PR04MB0344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKIM+zK0gRvCvdcSRcLIGcxjOfnQNi1Mv/OLX5UxyVpV5B2pVq7LtjlNwYMwTitRhkjcs9sMMyoYBrzWG5iDcYzEhoJPXfE/DQUEk0Ba4rz6zYu9GvlRUa8wuv/3x5HgO7gyeph+Xx4U1IgYijNGTF6KagROomDYNvg1MSdUmVF4rP+CrmAfmZctT5hneJuV3AJVqpGo7Vhi+CLfjksMwgvDRqLeV71JrAoPjZuj+6XrDpvN2Xh8yV5Z9gWetPrGGDs8uoYlXGz/dLHbni/DgesZ4Wfl9fTo7oAa4vppgBMY/b7igC9qzbWG2h3/zgV2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(66556008)(54906003)(86362001)(316002)(5660300002)(33656002)(4326008)(478600001)(9686003)(66946007)(7696005)(66574015)(91956017)(64756008)(55016002)(83380400001)(6916009)(66476007)(2906002)(71200400001)(76116006)(7416002)(66446008)(6506007)(186003)(8936002)(52536014)(8676002)(26005)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: UnYfSUkxD44fpxUMw1mWrdLoluuQ86bvWye3pd9r/SS8NNtliWnn8gyL1O9TF868j+TEB9OAAqaJiZemU+wu+VqYQ2hRLGHj+OmHmYH9f+RzTy5x5adOXUwspoPp/B5FR2xYfkQwVOIA3FJ5VeBD7NOiRgS8dZAuAClgWevlfF2nNcC24hC0DsLUQH3H4cuOGvuE+gsmk1Dh0PmFiatTsMa7Rzf0jSxfbWthW0DGIq6oBn2d/Iov0tfzsBxEsaFPhjM/TvPqL9oV7LZtoQW+Gvuj2y3QAzHx11Bnov2jdlmsZd+5CfDZGgFI3SwyAXA9w6SHaopOymtGxAWHKD6QD7r8/Eavj7OIEjG50WavnfaeBUqq0iiLU8Hr/ui3VBfI+KB4DIhityIYjxbNkTSWb/LQtpXBIXc0bDwIGlTQtQC0eUbcNiwia93u3CpQ9lrCXPqACPSlnvFImX/Pee2t66iPh62vRt2yoU7NompX5cNLkTabLd3AqTXbQ/EvfSyA
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5946aa23-a38d-4b97-263e-08d8199f760b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 07:06:34.2772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkJX5ygFY6I6L5NFABdwEuFcCkppUqlrvAnvJkXarVjGlQI0YhE4TlyKmj5GBB6NuVUCB3pWDLe0CAIxuClldw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0344
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/26 15:52, Javier Gonz=E1lez wrote:
> On 26.06.2020 06:35, Damien Le Moal wrote:
>> On 2020/06/26 14:58, Javier Gonz=E1lez wrote:
>>> On 26.06.2020 01:27, Damien Le Moal wrote:
>>>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>>>
>>>>> Add flag to allow selecting all zones on a single zone management
>>>>> operation
>>>>>
>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>> ---
>>>>>  block/blk-zoned.c             | 3 +++
>>>>>  include/linux/blk_types.h     | 3 ++-
>>>>>  include/uapi/linux/blkzoned.h | 9 +++++++++
>>>>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>>> index e87c60004dc5..29194388a1bb 100644
>>>>> --- a/block/blk-zoned.c
>>>>> +++ b/block/blk-zoned.c
>>>>> @@ -420,6 +420,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *b=
dev, fmode_t mode,
>>>>>  		return -ENOTTY;
>>>>>  	}
>>>>>
>>>>> +	if (zmgmt.flags & BLK_ZONE_SELECT_ALL)
>>>>> +		op |=3D REQ_ZONE_ALL;
>>>>> +
>>>>>  	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
>>>>>  				GFP_KERNEL);
>>>>>  }
>>>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>>>> index ccb895f911b1..16b57fb2b99c 100644
>>>>> --- a/include/linux/blk_types.h
>>>>> +++ b/include/linux/blk_types.h
>>>>> @@ -351,6 +351,7 @@ enum req_flag_bits {
>>>>>  	 * work item to avoid such priority inversions.
>>>>>  	 */
>>>>>  	__REQ_CGROUP_PUNT,
>>>>> +	__REQ_ZONE_ALL,		/* apply zone operation to all zones */
>>>>>
>>>>>  	/* command specific flags for REQ_OP_WRITE_ZEROES: */
>>>>>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
>>>>> @@ -378,7 +379,7 @@ enum req_flag_bits {
>>>>>  #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
>>>>>  #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
>>>>>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
>>>>> -
>>>>> +#define REQ_ZONE_ALL		(1ULL << __REQ_ZONE_ALL)
>>>>>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
>>>>>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
>>>>>
>>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzo=
ned.h
>>>>> index 07b5fde21d9f..a8c89fe58f97 100644
>>>>> --- a/include/uapi/linux/blkzoned.h
>>>>> +++ b/include/uapi/linux/blkzoned.h
>>>>> @@ -157,6 +157,15 @@ enum blk_zone_action {
>>>>>  	BLK_ZONE_MGMT_RESET	=3D 0x4,
>>>>>  };
>>>>>
>>>>> +/**
>>>>> + * enum blk_zone_mgmt_flags - Flags for blk_zone_mgmt
>>>>> + *
>>>>> + * BLK_ZONE_SELECT_ALL: Select all zones for current zone action
>>>>> + */
>>>>> +enum blk_zone_mgmt_flags {
>>>>> +	BLK_ZONE_SELECT_ALL	=3D 1 << 0,
>>>>> +};
>>>>> +
>>>>>  /**
>>>>>   * struct blk_zone_mgmt - Extended zoned management
>>>>>   *
>>>>>
>>>>
>>>> NACK.
>>>>
>>>> Details:
>>>> 1) REQ_OP_ZONE_RESET together with REQ_ZONE_ALL is the same as
>>>> REQ_OP_ZONE_RESET_ALL, isn't it ? You are duplicating a functionality =
that
>>>> already exists.
>>>> 2) The patch introduces REQ_ZONE_ALL at the block layer only without d=
efining
>>>> how it ties into SCSI and NVMe driver use of it. Is REQ_ZONE_ALL indic=
ating that
>>>> the zone management commands are to be executed with the ALL bit set ?=
 If yes,
>>>> that will break device-mapper. See the special code for handling
>>>> REQ_OP_ZONE_RESET_ALL. That code is in place for a reason: the target =
block
>>>> device may not be an entire physical device. In that case, applying a =
zone
>>>> management command to all zones of the physical drive is wrong.
>>>> 3) REQ_ZONE_ALL seems completely equivalent to specifying a sector ran=
ge of [0
>>>> .. drive capacity]. So what is the point ? The current interface handl=
es that.
>>>> That is how we chose between REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_A=
LL right now.
>>>> 4) Without any in-kernel user, I do not see the point. And for applica=
tions, I
>>>> do not see any good use case for doing open all, close all, offline al=
l or
>>>> finish all. If you have any such good use case, please elaborate.
>>>>
>>>
>>> The main use if reset all, but without having to look through all zones,
>>> as it imposes an overhead when we have a large number of zones. Having
>>> the possibility to offload it to HW is more efficient.
>>>
>>> I had not thought about the device mapper use case. Would it be an
>>> option to translate this into REQ_OP_ZONE_RESET_ALL when we have a
>>> device mapper (or any other case where this might break) and then leave
>>> the bit go to the driver if it applies to the whole device?
>>
>> But REQ_OP_ZONE_RESET_ALL is already implemented and supported and will =
reset
>> all zones of a drive using a single command if the ioctl is called for t=
he
>> entire sector range of a physical drive. For device mapper with a partial
>> mapping, the per zone reset loop will be used. If you have no other use =
case for
>> the REQ_ZONE_ALL flag, what is the point here ? Reset is already optimiz=
ed for
>> the all zones case
> =

> OK. I might have missed this. I thought we were sending several commands
> instead of a single reset with the bit. I will check again. Thanks for
> pointing at this.

In block/blk-zoned.c, there is:

static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,
                                                sector_t sector,
                                                sector_t nr_sectors)
{
        if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))
                return false;

        /*
         * REQ_OP_ZONE_RESET_ALL can be executed only if the number of sect=
ors
         * of the applicable zone range is the entire disk.
         */
        return !sector && nr_sectors =3D=3D get_capacity(bdev->bd_disk);
}

And:

int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
                     sector_t sector, sector_t nr_sectors,
                     gfp_t gfp_mask)
{
	...

	while (sector < end_sector) {
                bio =3D blk_next_bio(bio, 0, gfp_mask);
                bio_set_dev(bio, bdev);

                /*
                 * Special case for the zone reset operation that reset all
                 * zones, this is useful for applications like mkfs.
                 */
                if (op =3D=3D REQ_OP_ZONE_RESET &&
                    blkdev_allow_reset_all_zones(bdev, sector, nr_sectors))=
 {
                        bio->bi_opf =3D REQ_OP_ZONE_RESET_ALL;
                        break;
			^^^^^ This means one command only...

                }

                bio->bi_opf =3D op | REQ_SYNC;
                bio->bi_iter.bi_sector =3D sector;
                sector +=3D zone_sectors;

                /* This may take a while, so be nice to others */
                cond_resched();
        }

        ret =3D submit_bio_wait(bio);
        bio_put(bio);

        return ret;
}

And see scsi/sd_zbc.c and zns.c. REQ_OP_ZONE_RESET_ALL end up setting the A=
LL
bit for reset command.


> =

> Javier
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
