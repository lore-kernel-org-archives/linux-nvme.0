Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D335CC3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CFC23427
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dYaVy3vQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S0LEwdaY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sFTROrKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CFC23427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=zMQETCyI9IJ9c54bChiKNbros+uQdcUqdsur/16wKOo=; b=dYaVy3vQeVw6C9
	KHfyEvfYYnxHjxadjX5Afb8gkZgkN1iMzS6LKUZMjCbN06pKqSaTmtFo9gHRbDXhSu0aTwIByld3e
	t/Pwq4JtXQmmNzMn97pwt3mB8rTkJeBG/JnA7Nwa/7V0Lw/EH1Ayv0FD8E75gaE+demIC20KxrLKy
	rBYaYbWmqnbp8j1iZ6c604kxg6o7DIxi52RM8DwgIhwpti64vDx0rkOCa4A8PTVEfmTt2G25cMtWm
	lAINQBR5IN+poYqdRau49lPe5efaPck5NIyes2yImjnTgCtAtl+604F2a7cd4JEmPbw/+jKXKdHLU
	DvSy4urwJ4gsX+RPGfYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3mAC-0004Wc-NK; Fri, 30 Aug 2019 19:02:24 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3mAA-0004WA-0h
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 19:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567191742; x=1598727742;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HKOL1hHk8+ksi60mxk44rj2x16Xu7kTEXN9tj0B7ZZA=;
 b=S0LEwdaYcJKnYAgww7/Ek1KqJLNLV92WRjomuKr0/+kOJrePp9Q3fKrr
 207BhX2Q6ueip+QVgFR+rkpo/Jp9pAQ9u2idRPx/POWPTx8JM8Ttb7UQl
 x680MJgZR2MDdRN3I99upSgmhHbGDTfM3R832x43sHiKb7C5u2HziqP+J
 Ejb8yvd748cT0w+04Otd77DLTtItMj21HZNTbGiKq82xOMrG0Fp4OnlW8
 HLKUmb7gUx/mBCgxV0911uNOi5TAIv4OSags03HmRC6zN1P5bg4F7+pMj
 G+s4Yk7ec/G+n+HQFOvCKbYAKa3xAvvJeztd+yvpLhRIBhYaYM09t+Nv6 g==;
IronPort-SDR: oeHWf/7ke78z2jUyemkoBRbJkaWwmHnbGUOgEX8f4L9pNyvsdeHnoshH5kuH+bhUxVUJjP9GRr
 EAOshZg/lZiZPs3lBLawaEy//EAM5BgKmuwB4Xde0zHwJwNy/Q/MsMAEqi/el/NGp0PrjlHHso
 tQrRI7smotvWVxDyjA5XnjrTT/SaQTyxSUgkHR82iTdBcF3yGoRXN6EIXyECg7w/wXabsXscs4
 0kHSkJIRoh0VWcgUc0rcG/rXfaQNvnto6s62EDD3NNs2b4Rxj1H4neTi+TNb00xWkbsbIZdnW4
 gNw=
X-IronPort-AV: E=Sophos;i="5.64,447,1559491200"; d="scan'208";a="118642779"
Received: from mail-sn1nam01lp2054.outbound.protection.outlook.com (HELO
 NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.54])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2019 03:02:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx4G/PhnAseII9TP0/q34XHh+ObHZPXV5Idx93H4wUwuZznnS3jAJng1Z3tCRve04cnCg606Be7H07OmoEXtjXAzfJNGZqTjPUKHdRIp5mdYA6ze5KXUQwoeZDuICshhxfFyNoZ3Q5g//zp/ojGti0SCMm6hNMc2OAC6/hYcUwnLVo7R5H4Nq/ZjOX2HhM0xENMJdscHroPrODWYJeCo/iTd1zUvCsD7TahVlDYOzpCY5AO+t20NisKu1G27OqwKyOIy1it7PXnFHs2i1dDBOVazRmXs41dWsvW24OZzkdhZ4d6QzdjV+rsAvyvZRCpl9FOkGJN14yprTzCneL26dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW18eJ8jdiXIQuI/G/DnNF+GIKjEacDJ2TQbZAOiuqk=;
 b=KHBK420K9tNn4bLuI4pxHyfq/y27CXAirU0OGtm7ONQyPKtbL/WpZyuZCrYhUK9nfcAYaY5oAsSh9oyLiXaj7ROFcFvYl7iU8VWCeGkYS1IT2JYSv+CrC1ZywSYUfteV8x5qhlWD0vOMi99VLzaJhCxXkoTG5HNkd0ZFu8sLPilbE1EqgKmFXiZnar3FA8i31IGIvpkTfVFPJDLl+Gb4GcS0U3UgFhUbEgb7URCLSLwrGpHR/051lyjGLsjEq84sieRTpktjJoZybPX3IMGBtCYVOMKTLI5UxWWYh1CkYldEiEuifGHxiSmGuZr+zOjlbcUWlxMpjBNiQAm2t+Gc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW18eJ8jdiXIQuI/G/DnNF+GIKjEacDJ2TQbZAOiuqk=;
 b=sFTROrKomfgq/3JR80+c8NAVdsWaQ2dLSfp1cgJfyj4WW3VuX+8WDu5WSStsu38DFFJDY/oQcJ/QmKjPGnsrtFpQMAPRfHPSVTXglhp3+r0h2Q9CU5xdySwtYR6RQTIUwpuDBEnwaIdMPWncmczpeB8gvDvGcDJGExTNpPs6BFM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4215.namprd04.prod.outlook.com (20.176.250.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 19:02:19 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 19:02:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v9 7/9] nvme: pass status to nvme_error_status
Thread-Topic: [PATCH v9 7/9] nvme: pass status to nvme_error_status
Thread-Index: AQHVXrY7MGmEPQffXk6Uin0185fcYA==
Date: Fri, 30 Aug 2019 19:02:19 +0000
Message-ID: <BYAPR04MB5749778152EA94ED92EA2EC286BD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190829220645.5480-1-sagi@grimberg.me>
 <20190829220645.5480-8-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 367ac02d-0679-4a7e-b788-08d72d7c950b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4215; 
x-ms-traffictypediagnostic: BYAPR04MB4215:
x-microsoft-antispam-prvs: <BYAPR04MB42156C8639DD96D06C951DFD86BD0@BYAPR04MB4215.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(4326008)(256004)(316002)(86362001)(7696005)(26005)(74316002)(5660300002)(53546011)(102836004)(6506007)(76176011)(6246003)(478600001)(66556008)(66476007)(14454004)(53936002)(76116006)(64756008)(66446008)(66946007)(52536014)(25786009)(3846002)(33656002)(6116002)(2906002)(476003)(2501003)(71200400001)(71190400001)(486006)(6436002)(229853002)(66066001)(9686003)(110136005)(54906003)(55016002)(305945005)(99286004)(7736002)(81156014)(81166006)(8936002)(8676002)(186003)(446003)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4215;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hWPIBrMbE8Yw07LgCsh4RsdezK7XAhGqsrKeB6qlLBhXcuC4p1NKGeloRO+KZDu7izoiUvCKfU63aHqB9QJPCNtIP7mEBhanr1MU9juRtA2U9WrjopT5rN3aaXUBa83pIV+jd1cOGm2XOXFXlP0NeSyINX1BddwgtKXgcJMtONn0KxfYNV76eslP0LSY8Qx+lFmMyQf18wYqvO7uWHUQ6mM+vo81FxqNHMrHPUq4Beo1F4Y9dujZfNlDyRGJxYrkRoxDrW8UGaOhmd2EE2+3HbIwi0icXKqI1QKsJeRcQqvR7sOyfrgWn82sGWbBN0nougQk8YuWq/hWQqrh37udK7bb83XrnUZkiBEElxAvw21JPGARzIdfgt967rt8FBtPcs3E1/8K9MqIUnhdPE/CJs8S8VDU5RDrbBpExEihwpc=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367ac02d-0679-4a7e-b788-08d72d7c950b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 19:02:19.5292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyV4IRFnRSfFYBmDLm1JoeytEI/AHwyxDxz7fUdDIDwKVzHL4TXQ1ZbXNYUXlZxmFXPQAWEBZ92gjT2BU70jNXq4Qo7szLQPsy7/wPTXzpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_120222_100497_82546743 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Do you find any issue with passing request structure ? or it is
more of a normal cleanup ?

On 08/29/2019 03:08 PM, Sagi Grimberg wrote:
> No need for the full blown request structure.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0916c0e8d572..8f0881dec907 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -197,9 +197,9 @@ static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
>   	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
>   }
>
> -static blk_status_t nvme_error_status(struct request *req)
> +static blk_status_t nvme_error_status(u16 status)
>   {
> -	switch (nvme_req(req)->status & 0x7ff) {
> +	switch (status & 0x7ff) {
>   	case NVME_SC_SUCCESS:
>   		return BLK_STS_OK;
>   	case NVME_SC_CAP_EXCEEDED:
> @@ -262,7 +262,7 @@ static void nvme_retry_req(struct request *req)
>
>   void nvme_complete_rq(struct request *req)
>   {
> -	blk_status_t status = nvme_error_status(req);
> +	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>
>   	trace_nvme_complete_rq(req);
>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
