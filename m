Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFAFC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:42:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E107C613FA
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E107C613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Ha+VAHDaMjj+LJsCZMD/lceF3vPM+0oSinmVTe5cPCk=; b=hlLj+dp+zyzawpmmyqMxUYOpo
	PoPshmiTqXxWhZDnuWMzPmoPVnZzHc1O5hhox9BiuIc3zYKb0x6Ejmq4yrfjXzx9vkY3c8a/1XwPZ
	X58/rmRNF6dLgVpvQVt/lQXmpaAI1NMq8SOei17jlTxwxuW1tBHDMeyAvYCVRp/9eeanUqB+8pIuU
	0vNZI7yyWRLPanxYihVODtZBDbRD7tvCrvjx3Q7A7doNo5uF9KjOwcBnKyEjt0EigmXMueNtn3TxE
	msmCLJC38/J9ddZ9qhFqYuqIARaz2cOfbqar28nFtj2uQ1Kh7BcQ0SknHuWtjYCeVC1JX/rBaRQEK
	6Xp2b+zuA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbp8K-0045rj-35; Wed, 28 Apr 2021 18:42:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp8H-0045rS-0w
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 18:41:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=Q+AyTKaQJpkw7xyAlN3ATJm4KSug0mp0+YzFnrsq0jc=; b=FMVq8pZp4MGzHQTXGEzIieOVba
 wICkPev2P++VfH8VHx6QGkrXuPmsoUJf7P6mugZdxjjf0qw/eHpEUidH+OEPLVDMpCGZxT0/6LZrw
 RF9g/LsGG1fs+ouT63Wyxoe6MN8CBtcTJlOFifgOvJHHH72mZ/zBW9b4E5csfbNXTH328fTampX/Q
 X7hmWZtHkxGSokyoW6yCD+si2iTduCXiKgEhGjheYi4sLq4Z0opaKzRvovXQowCorXfBlPWYN3sjm
 geFYrdTKDCKmi0bLXa2aowr33ouWjxqKWbvAlmRqbPhVHJjPaMgVvA6RcYTiN4SeE75vzZbiaBwei
 bTjx9+kg==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp8E-0007Qe-9o
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 18:41:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619635314; x=1651171314;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=YEgdG64Hu7aF1mc+niz7/FjyBMdnBqZCLBWFN7sASAA=;
 b=Z0tmDQeI2X28N+y/ZdSQdWHEv8h/UtpNQLasRaSJMWJiuZ9tLFtYct4B
 lO8TnJJX0k6Maxgx15hWot9Lke4vkuL8HYyYRFXHzzZLvdqxIZoCz45X2
 aSBX3OS5XFRyF/rbYOa7KLyZrY9rojtqrgKXCHmRpgxFkxlv2MXmpv2nl
 /W+qCKpUOfMl1jVmBekaoTgZcAXdgR3ZKZzFaiVPncZG8GBbKKZXkOVyh
 AD7kRHcWQjiizVFuIrrSoPcJhn3sJobRixGxlXxrMM8iMXdc+kliGs6eE
 IWJyuM/UfTYY1wYSSOvQy9ixIw9oBdCfjsWnZY3747lMfINSGlkzabAf4 Q==;
IronPort-SDR: zo2h/ypt4EpW0F4eOxUYfDCr9Xpa007Obw1uzdgyH/JUPsIoMc7QZKnz0HEf8hCCav1yHa9ShW
 ha8vlNPmzIMinlIxhuaBhH1XuXdtxG1rvVA+Yd9RyF0aKEjHDdbjKFdsejtsSOqK/B2WDh7z1+
 bhtJEBAU2WVK2w39VIRVnq6ki3tKk1+9B2TZKMI9HAA1JXRwUXDKN77r0GYunDTu9tKlCcDjRk
 m74eiJ6kMyqp0EuV5R8imx7Uxst6j0InaSf3MfA96Tvdthfmqx7vCsKtHPGucnkDO/ROhCzxff
 2f0=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="167113288"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:41:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmefNIzUJ0AcXVTLEe+J4SvZJ46IaX5h1GuPpofG1gRk329bmQDhaZ7TGxoYEIdtB+a1/Ge/SpiD2u531a9/JpzFJoDbCRE6aH1SBOnXdLopeKbu92xUcIMeZK8xEKq5nbqBwDnvWbR6PgaZ+o4tdhVyuMMNxLmIA7al0s/qkz4QuOLEkMTd/G8fIqrFk2FHElyFl3jR020mCrkKEX/5ArGuJN8FYcT1LT9efJV+jR+169p3usSEyTHnw0ZlyU83lqdApSjRBeoxYqoxoil+vUVf6+Lb3ltWrsgiGqSFx7AYLQF3vkocS//mploM+1Pzl3jnAeaqVdACgvqdyQrY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+AyTKaQJpkw7xyAlN3ATJm4KSug0mp0+YzFnrsq0jc=;
 b=lFfjfE8bBjFNnUAAGNcc500jeqtE0Alipjv9RyvL7sudYpp33izCluSEFUejgz8YZSSzmQtSKxqPdO0k14h4f4LKOJaQPrnqUwfnEqctT3xFvhAclo1HoOIimCUJ+YirwyxUjo8RVxWvtdrhbIhb0tQuRETUzjRfirmGJqPnQpTOVDSiK39VEgcPUwDdgLHVbDQSMUc1zEqsQG0JK98zQ5zy9w73PUcm/9Yx9EOH61v1mHD+X99zNqJl9KaZnBJRiTO8JVxL0UfYpuX/icoH5ChD0UwUlGcF2m/I30KSEzFN+wqco9M50iTxxoQ8csQVDsgfzDhHVcuzFsEf3XbLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+AyTKaQJpkw7xyAlN3ATJm4KSug0mp0+YzFnrsq0jc=;
 b=Ya1MvSFBs5JBJtmp+nm6PU3NsqKBZNVrxqYCE3JNKZm0aukCp5AIicRjOf8orUl+80JoO4NT35wWCBQXJO5fSDj+v+6XTgAk3ftqriP0n/TWWxnpiCZl2EZxZkQn9lEe87zIkH19vdBTCz2URsVAXjK9LfA1FgE5lYGCgZweYVY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4133.namprd04.prod.outlook.com (2603:10b6:a02:fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 18:41:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:41:51 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "wenxiong@linux.vnet.ibm.com" <wenxiong@linux.vnet.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "keith.busch@intel.com" <keith.busch@intel.com>, "wenxiong@us.ibm.com"
 <wenxiong@us.ibm.com>, Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>
Subject: Re: [PATCH 3/3] nvme: Update several detail information in pel code
Thread-Topic: [PATCH 3/3] nvme: Update several detail information in pel code
Thread-Index: AQHXOtH7WAkrtd+TmUmE4jBaAmQeDA==
Date: Wed, 28 Apr 2021 18:41:51 +0000
Message-ID: <BYAPR04MB496555DDC1C6E6F86ED9931986409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <1619459538-3998-4-git-send-email-wenxiong@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none; linux.vnet.ibm.com; dmarc=none action=none header.from=wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 535d140f-2567-4b08-733c-08d90a7549c5
x-ms-traffictypediagnostic: BYAPR04MB4133:
x-microsoft-antispam-prvs: <BYAPR04MB413366D9B2D05B8217253BBA86409@BYAPR04MB4133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNDMV9FF0CgVUZmzzKztqSYVCQlD6vCQsvocDBXkMMLrQj5VmEEB1EZSCbKslv8ythqL7AD4HuYpA8q1hhiyxPLSEW3yvqetChwoRb6qXtQKjuD/pmvM6h9auh940sPsJkrhys43lq8El/9jv0h+uy6MM+3O75ZWfAjSuP7P5cDj8bhhUM17Y7uEdIm8FDqd/11nW+6owmXS5Hw7DnN8x6KZr9RQUQxUyAWuy26arRp8SDQI8yw4CsHZoJJDCTOH0rS7CNXyihpo6PluBDTOPhBSidUOU6fRvoLFztK2SD7gU/YQzs6G2MbNV6nynUpoaldeBdvGUbcRFGoG9GM5PPNeS/bRlmK4BakXW1xmY38+ea+r4OH56y8YG0B4/vEH90VHlgNaz2EUjKU82fkpZzYAVkf+K/64JNPSHgdlFSwQa4Q01OWmLAKFyH1YPUE6bw20mGDCML6ovC46U9PNW+r5avPgF2pZt3gHrRkuxyy1dZA4DCmsm3Bh4yGJ3J1X4cb6JqLfP5+cQlTFf0YWa4X1ZjXCy/Zhgh6pPQGLwmn+noTM+xFA+U5UCITzFA/0m/fH7fORGL6XZ2gQQ1TiW7yjKvOtBzb8ZtDq5W9Qwdg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(38100700002)(9686003)(33656002)(110136005)(8676002)(7696005)(2906002)(55016002)(54906003)(26005)(52536014)(122000001)(6506007)(66556008)(66476007)(66946007)(76116006)(478600001)(86362001)(8936002)(64756008)(71200400001)(5660300002)(53546011)(66446008)(186003)(316002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?igTNyB4BQ3Xy4xOrb6K9rjZC/IB66Bcs00rKL0WW056uQnvoyNcTmpAXAil5?=
 =?us-ascii?Q?uveA7t6Y/Yipx+9qERdhQDLpKV7n2U5Tx5ENdlr28D7SYji40oSp9P7l4lIu?=
 =?us-ascii?Q?3pL4ukJf1jjloTYBFY8G1+IJqv2xbEVIi/GOMRdXleWLoBFHu5/4DZ0F2WZm?=
 =?us-ascii?Q?Oef6pV56bJZblVk0R5ZzfGoxjXZTKgeYuPZUD8jPJWnfUOel8EQjhJLeBq+2?=
 =?us-ascii?Q?qO+1/794wmR+G4kHQFSBsqOJZazj8obotF31RaORhPa4TgahXMX7ie86Rp62?=
 =?us-ascii?Q?eHfwnA5/lpzZheNt/Mr7AQk07NxBNrCYfzBJbFfEnm/rBdr4J/NhPv1tPMyJ?=
 =?us-ascii?Q?VJ448z9WPdKkXOb0DtgcQUXCU8ciS03tb63PcxgjokevmSbUCs7xtqGfjmr3?=
 =?us-ascii?Q?FsHaSagkIfFZ6F/F85z6dxQtOQhJ9E9JFoczhr+79i7eVeNwJsspMNXw+4Rm?=
 =?us-ascii?Q?lstYvGSgVMEuYJIz4BVIY9lB+QDcgpVDyn4vRlSqpL/R750xBC0kfSfd/aGT?=
 =?us-ascii?Q?FFhVWVUU8qS/+iWxe0k0uG8gt/ng1PX4dV/G/KXyl9owNZD5pODWZMIZ1aFk?=
 =?us-ascii?Q?MalZY+MZz6gBV6ic+FUI43dWfstQH6fiqzJ4sdmnN5QJD4MDna0uks50Sg4N?=
 =?us-ascii?Q?aFEjcmLvWoyStf7qnmjYQfPPNCb8W0zNCGjaLLRSiRK8KzYaQZ7EhCNB+AmP?=
 =?us-ascii?Q?AEiOJdHmU3rOPJnTZj3WY7jarAmQ+FNVFlk/I7D33gcMJyaIglw/Ux/mMbaq?=
 =?us-ascii?Q?eyzMy7Luho+sCAyIawqYzoJU1ZeAgpfe9XumiCm/Wn8nWElMt/v0tfvDa36x?=
 =?us-ascii?Q?MtqWILY1dwBejt29ykPuO2XHJxdYhgUwkxPm38ukKlA16VArCeTkzeYVBrXv?=
 =?us-ascii?Q?S8wpqv9xSt4jomCA/3rBEmWEnAW7Z4ml+XM5paqWR0k0GY94CVbBLtjG2GLn?=
 =?us-ascii?Q?u1dV2G6A6ycrlVNneS9oPQsbwBXqx2dvECQEZnQTgPX/Eh/+z4+tlsqaQfl/?=
 =?us-ascii?Q?ASZ6U3e4QKTLujq5uNhJnmyl9fTRI7RRZpR1+HH5RrO6c3jbmIeTHqitoR/x?=
 =?us-ascii?Q?qCSeAfkzoAAd/gCvZAoDIxaFXQJ/Ty0bI1RQW1Hean4LRBk/YEWP3v7PbjoR?=
 =?us-ascii?Q?P1krH7v7PDcf9PmyXjuIXF3RqlCP2FanjDtVUedxKzIR/LefF5BI2JePBhvI?=
 =?us-ascii?Q?+R1fzQuk/vcuLDgyZwqO52MTK4KzPxO05T0LCpGjohZIXzLaAslMMXkLXarL?=
 =?us-ascii?Q?t6pYrttsEhmWeqwAyXbLwgEoeO1QIEa64NFWUha+WkzIzhaKv5TKF/xdelyB?=
 =?us-ascii?Q?SAMgOUm4bJP4vl1B7jYfC+IU?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535d140f-2567-4b08-733c-08d90a7549c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:41:51.3464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u66ic+BU7QNELBGes4uoQcTI3kRgYc9AapxLcvBg3Cmd/iEmhW7Zx1UkCGT6jfeyFRKSXdXrIUBJE68ohPpqCtAOq5cRWnl5O5ZaKswduUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_114154_424179_6161F5E0 
X-CRM114-Status: GOOD (  10.83  )
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

On 4/26/21 12:25, wenxiong@linux.vnet.ibm.com wrote:
> +const char *nvme_pel_event_to_string(int type)
> +{
> +	switch (type) {
> +	case NVME_SMART_HEALTH_EVENT:   return "SMART/Health Log Snapshot Event(0x1)";
> +	case NVME_FW_COMMIT_EVENT:      return "Firmware Commit Event(0x2)";
> +	case NVME_TIMESTAMP_EVENT:      return "Timestamp Change Event(0x3)";
> +	case NVME_POWER_ON_RESET_EVENT: return "Power-on or Reset Event(0x4)";
> +	case NVME_NSS_HW_ERROR_EVENT:   return "NVM Subsystem Hardware Error Event(0x5)";
> +	case NVME_CHANGE_NS_EVENT:      return "Change Namespace Event(0x6)";
> +	case NVME_FORMAT_START_EVENT:   return "Format NVM Start Event(0x7)";
> +	case NVME_FORMAT_COMPLETION_EVENT:      return "Format NVM Completion Event(0x8)";
> +	case NVME_SANITIZE_START_EVENT: return "Sanitize Start Event(0x9)";
> +	case NVME_SANITIZE_COMPLETION_EVENT:    return "Sanitize Completion Event(0xa)";
> +	case NVME_SET_FEATURE_EVENT:    return "Set Feature Event(0xb)";
> +	case NVME_TELEMETRY_CRT_EVENT: return "Telemetry Crt Event(0xc)";
> +	case NVME_THERMAL_EXCURSION_EVENT:      return "Thermal Excursion Event(0xd)";
> +	default:                        return NULL;
> +	}
> +}
> +

Please align the return values if they are not already, refer to
nvme_cmd_to_string().



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
