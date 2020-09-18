Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E93C43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 00:30:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C79207FB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 00:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aie33Mc9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XMs0Jtn6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ELyM1AMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C79207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=YPRJIrznzGAKEwSjdi4iCE3FVi0sElFjFvJjoFwm9GY=; b=aie33Mc9xX4mGgrmJADIYnaLc
	CEo3+wvMG6wZCGpGpFkiOjvKQgBd2K7G4HQFCdEeGAJOe9F2N77Ca4vsZcEPBm8vHDARQZRxD47AB
	ExOqdEZOcpnHSm1Q/kX5V/y06u85kmYBjDn43SY67OYlXeImsxwRCkptCXkmPrOtKls+KsJDnRcUI
	A2eaKgPAIRIVjnI+yjukwz3F/SnYAcylLIGzFZYcDQc6UK5sN3Bcx7/5szWfdg5Z01Z4uR4q0lXiA
	Umk0QPhzeRj40GtBf0WSphKhhUQpPkD9NSqbcVMiyavkx4SMPlxZosX9V6vOR6aVkseY4eDD1gEcq
	iZjiWF1qw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ4Hi-00045R-3J; Fri, 18 Sep 2020 00:29:54 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ4Hf-00044h-D5
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 00:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600388991; x=1631924991;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=iO5T+TT7o5/XCfx1nibdtjtMa9Ev6HMYKPKtrd0QWZY=;
 b=XMs0Jtn6mDB1Zvl75HY0LBWp+ZCn470JeusWUmsfTUv/jn3/VvcG6SI7
 8z7BwUizURQ39cNA8dfpP08PbMUl7OcJg8z5D2CtOFuVzmKr/ho2ND7J+
 vpbimKKZX52CoZOOZRp2Vz3RWoCgEbMWoXZNTgXq2OUiCFOEGpFISNZqk
 Ob4FbhbUKPgDR+KdyKQoJ6c2MdKcbS5BwfmuLFy/6oQnL2yo5bNaCTIhY
 UmKaY4KfA90xLqMUMSHGbnnrUnu2FwnD+LnHW7CknrMp9T9JQ0/AQJ51n
 rSFc7DZQz8UNbI/WZeJJiLZRNOgG2azmOAp0Y6ZkLCdeDBa2lcx0/MvW4 w==;
IronPort-SDR: 5xxPAbq+wMY7JAllik9WdSIUc25EMiGZvzphR+Ut4UXC3NSM1xfK27tVFpLmg5UoJPBWysBb8P
 d9hj+5Rw5kVKCm4idAdaFTNXzKEQPeKk+ORSjfAojB0rDrudsxxQJufbVXJGI2D5h+24WXuDvW
 QZ5pAA/jNlZzaTH6I93hp0iGeacjwDTQMx9qhYaRkFU76clxZgCS7vBEZHZIgLwNgX6w/1rb6k
 HSlJpXleJJ0uCqbBcSWMxf0R51Vp5powF0f287s57hIe06qUhn+QIT7XDxQDw6Ti4CajgJ6/+z
 2ss=
X-IronPort-AV: E=Sophos;i="5.77,272,1596470400"; d="scan'208";a="152045001"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 08:29:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxKL9cbxln5tuuGsQJ+atWtGCxndnRs7feQTRV49U3tr4+/YWLudBV5c7Zsn+r9UKTpeUJTuYHGtivdf3fBeKOZcHq3VjVS7nTHuUi/HUa0MhYqnbZ1SXENMGPajLR09tDoMJkes6PApkRf3BMfE8BE31N/zWMDZfOiN4l1imxvyGghPGnKNthWE53js0NcCG2uyR+C9Y/2HLnLnHaKU3spTkYngMU68zawLwDsTd1l4I636jIowBF3dAST+BVf43CCYPvKBV3zmoSLtT3NsKOGt6c1TPhTzW63rm1WpSBW98t485ui0uOtSAsVArJky4K37UNeaGO7ktfvgDeosbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/7Scty5AIlxkb/9by+UNWusUqUQ5RZeq2fEHlhr7LU=;
 b=OXpZrOKDnrPK9vMnwMDW27nT/b9CNFQvJFIa0VFIj8EFMVzyOdFtGgBBS5NheogucTj1YsaVUjlfQpxdq351pKjyLhqcIPrGoQq/ix8E4T+nddq+z55v4xb2whS7B4mM/iT3nGCR0Qgmhy2jtE4yK2yXjX15qQUaYBQrvqlgdTxz2j8Ywlo1x+q6WfS0O3PFoC0V8kUQ4y1lTxA+tleI0sBAK+3YgVrZ6RC4IiR8fjRRt9SQSPthXY2HJtELG4XwB5blyc95SAUFB/nTa3eDFNE/bKOEljdoGllwlzYxW2Tjyy32zcKzhY2HfSHu6oM857Tj2psCLFbtF9oKGQ4a+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/7Scty5AIlxkb/9by+UNWusUqUQ5RZeq2fEHlhr7LU=;
 b=ELyM1AMmmUntpo8HNoDmX6Ofde0RiRFyUeGTFcePg5do3tW7UKA7VswRb0g/yFnvTgLpUkMr8yhGGTnQGQs9HtcXWTeeOY+QS2gzIQis3QZZ9tH70CU/+i6A98fxVGbFa2ecB70kur6XjRopv6tfXcWFseJnW5304INWmPd+36M=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1225.namprd04.prod.outlook.com (2603:10b6:903:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 00:29:47 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3391.015; Fri, 18 Sep 2020
 00:29:47 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
Subject: Re: [PATCHv3 1/4] block: add zone specific block statuses
Thread-Topic: [PATCHv3 1/4] block: add zone specific block statuses
Thread-Index: AQHWjUjpNXVoEDvZB0aLqQfrwXdDDA==
Date: Fri, 18 Sep 2020 00:29:47 +0000
Message-ID: <CY4PR04MB3751DAE164AA95E9DE09DF53E73F0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
 <20200917231841.4029747-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c162:b6b0:12c6:8cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 720ac8a1-34e1-4c55-3258-08d85b69f2b7
x-ms-traffictypediagnostic: CY4PR04MB1225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB12256E6755092159DD8D30ABE73F0@CY4PR04MB1225.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VH/Rihps7uFBl2KC8EVrlQjRCz7soLqrvUBqzkphvhD0PnYdCkeE6QarkXNnRLyD+nvreLiBASodz1XL7+sDyiBHeKLPKip4jd//uVLwu3h0puv6ZlHnj6W7KXuElASGqFuhfGquF3ksGG//fNgMQhAzYwkfk6GSI83e93vt7Qm4HMUBRrJVBjhmqa1TtltSMtbe2CtBqZksn1bLR1yX1/VrjeO7YON3K/14Yxupce/FZzObldxbIaPMd7YiOzWOGTGQww5yYXbTAIAQAvfbFjeAndcSZXjawkaOl8oNeIaXfzkhTfSFy0IuMpc8ekS9CKL6ifxm38j+srvRkcPp1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(66946007)(64756008)(52536014)(66476007)(66556008)(76116006)(4326008)(66446008)(91956017)(5660300002)(83380400001)(478600001)(9686003)(8676002)(55016002)(316002)(54906003)(71200400001)(110136005)(186003)(53546011)(33656002)(8936002)(86362001)(7696005)(6506007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3gDZ+/JGD5H1HpcD90OHiQmWHLpjoSPR+fYUu9O21+pP5Hh1mtJGFC5vO398BZ4ep5kxA3pFNi+LtDd82uL3EoeGdtfZ1UofXqHRRwAtP89lp3sGWFSyBOxctlUyMYYoe82rgVYU6RoVVUjxyo6GmCjacJa4NsjibbuVzp1cfGYOp6Wed3gnlqVEZvghTMT2bErRuU4XgRbbpaCtAMhlpEdn8CN39UcgS7KQmkJHZEUcKnnI8kFgm0m2fUDRklvEkqrfyxAttaFrP8LmXTpklzgYO5gfm+clV5sdIs/l8jxUdkMTjjdfJBm0oBVGqPrIvJBBo/IwjPaNQUEDSiQ4T8FLGS4IOyEKL5ShLhktamnCkyVpWgMsmqZgHmhwrYTVjofdmyZUBLNLfsL6S/cpUv+qGqjs/f68I+R/GMgl7Qb1o18pn53P3AKejeXGhzXwhN4R2eFuT170Yv7fqehj1qugqCpj+L+Exk2BVFmJyc1+irhYMddmk6pZ9yKGleXA/kEk6nUQE5H1UQj5wWKBgy3OoJsORiLiM8R4oAEpet2R/lTkLNomTro0kR+sYsOItLU9o5frEXvKIvN1Tpr8NzwzifHS8JDhAO21+YH++J3VB+7RQHISReB/4NhF8J+Tpa14aiGApUr2NOIQubP1vNmUxj1EpmGnE3juDMDKvookePkmr+C3c7W5zZ9IHHsv74ODtqkIRykqJO2HEWFDlA==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720ac8a1-34e1-4c55-3258-08d85b69f2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 00:29:47.3121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4qX2eIEAjse9vo9NaFLfvI8lPWYiFUFArfoUArqr6/U7dOGHm3lri0fSScXxiZbcMJ0v881Wpe9zcdA1xp3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1225
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_202951_659961_DDDE10C1 
X-CRM114-Status: GOOD (  22.13  )
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
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/18 8:18, Keith Busch wrote:
> A zoned device with limited resources to open or activate zones may
> return an error when the host exceeds those limits. The same command may
> be successful if retried later, but the host needs to wait for specific
> zone states before it should retry. Have the block layer provide an
> appropriate status for these conditions so applications can distinuguish
> this error for special handling.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  Documentation/block/queue-sysfs.rst |  8 ++++++++
>  block/blk-core.c                    |  4 ++++
>  include/linux/blk_types.h           | 18 ++++++++++++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> index f261a5c84170..2638d3446b79 100644
> --- a/Documentation/block/queue-sysfs.rst
> +++ b/Documentation/block/queue-sysfs.rst
> @@ -124,6 +124,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
>  EXPLICIT OPEN, IMPLICIT OPEN or CLOSED, is limited by this value.
>  If this value is 0, there is no limit.
>  
> +If the host attempts to exceed this limit, the driver should report this error
> +with BLK_STS_ZONE_ACTIVE_RESOURCE, which user space may see as the EOVERFLOW
> +errno.
> +
>  max_open_zones (RO)
>  -------------------
>  For zoned block devices (zoned attribute indicating "host-managed" or
> @@ -131,6 +135,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
>  EXPLICIT OPEN or IMPLICIT OPEN, is limited by this value.
>  If this value is 0, there is no limit.
>  
> +If the host attempts to exceed this limit, the driver should report this error
> +with BLK_STS_ZONE_OPEN_RESOURCE, which user space may see as the ETOOMANYREFS
> +errno.
> +
>  max_sectors_kb (RW)
>  -------------------
>  This is the maximum number of kilobytes that the block layer will allow
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 10c08ac50697..8bffc7732e37 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -186,6 +186,10 @@ static const struct {
>  	/* device mapper special case, should not leak out: */
>  	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
>  
> +	/* zone device specific errors */
> +	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
> +	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
> +
>  	/* everything else not covered above: */
>  	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
>  };
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 4ecf4fed171f..8603fc5f86a3 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -103,6 +103,24 @@ typedef u8 __bitwise blk_status_t;
>   */
>  #define BLK_STS_ZONE_RESOURCE	((__force blk_status_t)14)
>  
> +/*
> + * BLK_STS_ZONE_OPEN_RESOURCE is returned from the driver in the completion
> + * path if the device returns a status indicating that too many zone resources
> + * are currently open. The same command should be successful if resubmitted
> + * after the number of open zones decreases below the device's limits, which is
> + * reported in the request_queue's max_open_zones.
> + */
> +#define BLK_STS_ZONE_OPEN_RESOURCE	((__force blk_status_t)15)
> +
> +/*
> + * BLK_STS_ZONE_ACTIVE_RESOURCE is returned from the driver in the completion
> + * path if the device returns a status indicating that too many zone resources
> + * are currently active. The same command should be successful if resubmitted
> + * after the number of active zones decreases below the device's limits, which
> + * is reported in the request_queue's max_active_zones.
> + */
> +#define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
> +
>  /**
>   * blk_path_error - returns true if error may be path related
>   * @error: status the request was completed with
> 

Looks good.
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
