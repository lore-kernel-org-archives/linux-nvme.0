Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C44C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:14:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DB864E13
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DB864E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=XOnnjD/clSaVU7+f6ClKTHtRAJkrg+AKMt1bWELYVjY=; b=aMLTuHLh7lX+r3EnFSvrFw5Zu
	C9ZcXyKjY6YBLTrDGmBth2kqpTFVqNv5nR4n28zCelO3bxRXrUPAuBrwfYIe9F7vhfXNGIxkD3EE9
	QnZw32vFqHxTbp8JOwYszpspTKFi4lq7WTR5WL1HUrLisvzqiv1H9Xc60yHuQRhDv9JF1F9l6Mqlp
	awQq2WaoqWS8wmbi56VWcRGfALy5gYTXqMRt2IENMuXYT7WsICPLFyc5pPgk+kCzV98vS5U5epC4n
	/v8mi3Uv7zQ+fARiudPdMI2yqS46Y93wB3HzRmz/R01Ic2wTGSQSj4jXyKq7UWbz/TYOZeU77IKnr
	Iez5kdb6A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuXC-00GumP-Os; Mon, 15 Mar 2021 21:13:54 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuX6-00GulL-9A
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 21:13:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615842828; x=1647378828;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SIww3K+D+pphbBobhZ8bWOTNM2Z05q9dqVah/Z3SSTw=;
 b=cHJxTetbnq+WMWFkb8hjmAN7P4g4f5uuzN073THA5wjHTjOVDmcNnRVF
 XVHg6Q+6oB/MFXfILhvjQWeo7maF/xeMMNfHo8ERjUf10wFP4xadeQIMy
 hqpdFik6iwlbHE/cWJ9ypCi4V8YRDKwg/YJK5kPGmA9UHyfc+o77P/LAE
 7g+LoQl9eIteBp/qBWNyf6n8QUZITuQ1ag1ZRYJfqcTLEB3HhJ6EPo+Zw
 ln9DtYqTBHKFT6gaYGjyOCQekodAUvn9My/HDZTUqLOx4+6xpMPvY/3ZS
 5SsY0W0ZT7bgaiPvheGMPx0j+RQ7ldE0cEbwJ4xsZs5zX9ABEPoWULzpr w==;
IronPort-SDR: q6MStT3ouArDN7OCotajHaMz6I4RJlARh5ewrB2vYSYJ1Xo0/z6BhU9ELmQPrOYytbc9OCc0da
 y5bn6AkxP2t/NZvvwOsv3TyeBeRfoKihz0PhFkRrOaGtSkCi+T4oK3V8czdbC1CxUzesjCQFu5
 YjKvY7v27fY++UexwRGqypaITzJHj55kZaHwcsnKd9I2MoDOl2jU4lZcwvK/HdQuQ8Gx77qEtU
 8ejO8CZeIk2m5k+AwfSj5c6H26bWSGO8p6w7LY0t63LdND4AMC104QSNCrDfvPXYKDXniOlMi9
 CHg=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; d="scan'208";a="166689714"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 05:13:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPfvHk1dvwF8ulmvoz76VP2GNKhEatCQd531GMdB4E2IPNuS5OS51uMi1ZlFFwozzrApUKlTfVr316ZYTqsKj0dO3uL+DPX4xFMB1STVulNfTcaSnDkmiuOcwn5MqH0QAKou2nOYuc0VRHCcLHnfBWv88vQb3cI/3fNQJY1DldcUPSxHMgTgtcSJc9Xpe8tmFBXY693aF+f3tchYZWyldbibULLi1MOBsGeNrRbEMN13wr5ZeiuPXkPLfYbGGsigc2xhPcAs2xMxija3q8EA++IjBWxUpiLOp42qVE7bx1l3TucirT2nETzJL4GRivalQ0x+fSpKpYCkdyIMkriV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afk3vUK3jdGIp+tE9R0mXHclzYCh2iFG+KtJ1fdUfaM=;
 b=IVo+UbnPUEsAaFzFOof4HK3ZrhajD6W2RIq5vh0otuDYFJ+OCHVzb034gAtcCemOn/GUBE3to8es3MRLGsTxi7GM3GyO5Du1YqrQr5LEdha3Zen6NFeRzTrFEfY06Ghh0AsFo3ekDIsaC78a4ezgazr05vZjUGzmd+snePFsyY+0cWWlVD6DB9aMucCDOr5jOo3XjD2lGTZFwEtRXCl6yIbRENAoRoSYcLboJuGQEAM6+3+5GN2tQWKaqdCaix0XvtgHoOjCQM9fFyxGNWu1msBYpexArkZmBkr7FlXktHLveKRHRjMe3AzAD6Bz6Q9uT7vdoDfpgNTGcLTp/nVUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afk3vUK3jdGIp+tE9R0mXHclzYCh2iFG+KtJ1fdUfaM=;
 b=ZzFXk3E5LHLUIDLgLAYaYmCyafN35KzrPgp9BuSknuyDVan87nC0xnAiqeG9datmo5MUsGxJmvS4sVnq+AW7BwgOeNDNHuqrJaS3zpMLz+Qhm4egBg52i+7qAbpMBR9Xtx3aAoZ3KFZdM5WAMXkAi/N33ApRxs7f8BWFRH7EWkY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6552.namprd04.prod.outlook.com (2603:10b6:a03:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 21:13:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 21:13:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-topology: have list-subsys print only controllers
 with attached namespace
Thread-Topic: [PATCH] nvme-topology: have list-subsys print only controllers
 with attached namespace
Thread-Index: AQHXGd5fZB8+VRMYC0ufjn6SC4yjLg==
Date: Mon, 15 Mar 2021 21:13:45 +0000
Message-ID: <BYAPR04MB496584078ED56F2D5FD0BFF7866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210315205209.352846-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66495571-56c3-4f3b-f502-08d8e7f737d8
x-ms-traffictypediagnostic: BY5PR04MB6552:
x-microsoft-antispam-prvs: <BY5PR04MB6552BADBBF6E98FE230B523E866C9@BY5PR04MB6552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiLF0Wz4rqC7wJL9HoE6PpRGL0oRC30P8u00LfGwTvKZZkCam/chbXGmKjD9lI3Y+DVrTmOX03uYtEAbS1/S5aCp/6njw9sU3YhzlF6NyKlWscFUWSD6Q5gZ1AEuDtHeSskYg17xuUgx1mlDNiwkQwKnIy6S1w/xS6D2vMOLkX+9WJ3n1Bnyda6oJZVDv7qZ+AMt2t+WHkWK/+eRC3ltwoohZ/e5DqFHT5EFGDTg6Zh5Ht1QHDez3vmag/Dd6dFKXrr4lBoTaQrMOpoR2MO1eM0YXB5PJJwExv7/jil3+xN2b5cGDm+h8pPwM/kz5FXeyzhdzDkj6fkeX5B56iFI33R5OLDvtaMJhvP5kw/fsBwnFhUOja20+lHFfOUZamdmeGnwNo0019sLnlCHay3jbVB4RXvMD9CKAz8InPYa9rIiuanCo6qTGA1BaRbhJx5yBAyRm6kDUhVwQ0a07WotobGg9eCze8kdal5VlJwaI3O049fLWSGfGXEG8b12DQyaXwn1VTdfMnt1FWurD166Rij+OeyhEHRNEBIYWnNLhPMK/UsRIe4L0S/oLqIYBG+I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(186003)(26005)(478600001)(33656002)(9686003)(2906002)(83380400001)(86362001)(54906003)(66946007)(5660300002)(66556008)(64756008)(71200400001)(66446008)(316002)(8936002)(6916009)(55016002)(76116006)(52536014)(6506007)(53546011)(4326008)(66476007)(7696005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HxIwOeKUGQP/80hEya/7pQVpcz0iFey93Ojl2fqeQhQ1hSaNo75kMKJH8r2T?=
 =?us-ascii?Q?8NWhS9U1CltM2v1YHTP249nEQJxrqcr+R59UPZyHkcbO1vXWYHST5zM+Mlo9?=
 =?us-ascii?Q?LzjU/bOGfp7gaLTIaIz/eeIB+cTZFBDWTqdG6CUyx++Dxt+c4H2Ent441s3P?=
 =?us-ascii?Q?SwadgGM5JAVZ3WcfnJkfbTr2gWJ5x7W4eV7nmfuQgKiJkutquJ8hpjhhi5Ft?=
 =?us-ascii?Q?xsQOODvcNsq3SBzXBdoYF0AsQf0ARFLeutRavebaRocEEUKXkfZQZsIg/pXq?=
 =?us-ascii?Q?MhFlb1lrAiQG+ySo/1h1meBe/qZ/oDnB75dGCk5VevdsI5xeERRNec9plN+p?=
 =?us-ascii?Q?3qmiIoJNdgMwsDKupSBFJc50Is23lVnYgMwMVJ/GwzmdrD8qzYvn2dCV/Vti?=
 =?us-ascii?Q?tQyrkT1qM3KRs0KiZyPw7Z5Xgv3ymXAXRNiLXxr3p6dOvjhhAZAVyrk6c66N?=
 =?us-ascii?Q?4Z1lkVDVeZIA2qPeBMPeOvEw6z2YL2wnd7m5frmg8wCYpUmryW76WT9jwm0v?=
 =?us-ascii?Q?kWsNq4Xb9m7+IuOh47hEfFPwrGWQzwk4foltdIDNHFEHYXj67xo+PToqylDs?=
 =?us-ascii?Q?sJt2UzU/jV75ve/Y3TFOYG5P2jCIV86//lrK3iBHBb249Di3+Rnq4BQ4Uc8B?=
 =?us-ascii?Q?HD5Z/lRX7sJ5qYQfzSBWlO0CSc1sqsjJtSjGcE893dKsgOD4vF0u7jmpWG4f?=
 =?us-ascii?Q?gFfn3IGvY84Yd27bdHoIOUenTT9/zMzOJwgGtlUOhkmGp9AZzxQYmNL+ERYn?=
 =?us-ascii?Q?9GVo4KSExUIbLO/py/LSwX8xHMnR+fqNS4TY/Y3nXwbfI+uKjinNHFc5D42y?=
 =?us-ascii?Q?96hul+pOBFwOhargtzHLvRp+rKoD+OiCsoddek9BPsqhEi1fVBYvDXFy2+6K?=
 =?us-ascii?Q?Lh+sdXIPq+1uKrWWI5b5I8tr4DSzWMznaVsWZy7bZMJ7S0ej0IDgK2VwH4m5?=
 =?us-ascii?Q?oHA032msSfF1S3RCwWIEjTGuCxt+iiTm5N/L1bVGW89oqUx9DqIqcLJCui6k?=
 =?us-ascii?Q?k5ga60MHZi7c0e3k1Nq9teVO0ieTe/gH/2da32CWTwOjpflRJDoYT99VRFbt?=
 =?us-ascii?Q?XLV1qqgJXa6GlQZ/7k2MkWPvEio+oYMbeUUlYVQIGLnUDo8PvXJBsYT/5+Dv?=
 =?us-ascii?Q?5DcGJBmBsUEfsXTJHHLuGQx5x7zm8XTR0OJ5uzynzOvvFsRw70m07G1SwmEL?=
 =?us-ascii?Q?46hFwpjAiv8KIE+L4k41ojcPJ/LrMGWqp8XA7HJjvqYL/29MWbHfN7h9ASQK?=
 =?us-ascii?Q?S+IdqOQiqucxvytnqOMpArd8ulmsqan6EH7w/PwKxFc2w5v6sYApRb/EVIIV?=
 =?us-ascii?Q?g0sL/n++yUx57TfhOwXFXvc7?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66495571-56c3-4f3b-f502-08d8e7f737d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 21:13:45.1271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0hBs0Rd98XkSwDONIMsyQYObFJyT1+c44FneBFSv1UGDo2FSF6yt4hFtMjuMstyTFkeLOevWbZAml0XVLKe7pawJkNx8Uu71ANWFH85J6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6552
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_211349_219662_306B84EA 
X-CRM114-Status: GOOD (  14.73  )
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

On 3/15/21 14:01, Sagi Grimberg wrote:
> When running list-subsys on a specific namespace, we output all the
> controllers that belong to the subsystem regardless if the requested
> namespace is actually attached to them.
>
> Example:
> $ nvme list-subsys /dev/nvme0n1
> nvme-subsys0 - NQN=nqn.2016-01.com.lightbitslabs:uuid:07cfffe6-5a4f-4151-b663-e13cf835609b
> \
>  +- nvme0 tcp traddr=10.113.5.1 trsvcid=4420 live optimized
>  +- nvme1 tcp traddr=10.133.3.1 trsvcid=4420 live
>  +- nvme2 tcp traddr=10.133.1.1 trsvcid=4420 live
>  +- nvme3 tcp traddr=10.113.1.1 trsvcid=4420 live inaccessible
>  +- nvme4 tcp traddr=10.133.5.1 trsvcid=4420 live
>  +- nvme5 tcp traddr=10.113.4.1 trsvcid=4420 live
>  +- nvme6 tcp traddr=10.133.4.1 trsvcid=4420 live
>  +- nvme7 tcp traddr=10.113.2.1 trsvcid=4420 live
>  +- nvme8 tcp traddr=10.133.2.1 trsvcid=4420 live
>  +- nvme9 tcp traddr=10.113.3.1 trsvcid=4420 live
>
> This output is somewhat confusing and makes the user think the namespace
> is actually attached to all of these controllers, instead we want the
> output which provided by the change introduced here:
>
> $ nvme list-subsys /dev/nvme0n1
> nvme-subsys0 - NQN=nqn.2016-01.com.lightbitslabs:uuid:07cfffe6-5a4f-4151-b663-e13cf835609b
> \
>  +- nvme0 tcp traddr=10.113.5.1 trsvcid=4420 live optimized
>  +- nvme3 tcp traddr=10.113.1.1 trsvcid=4420 live inaccessible
>
> Do the same trick as we do in scan_subsystems, we add the ctrl to the
> topology if either ns_instance wasn't passed (see all controllers) or
> it was pased _and_ the controller has this namespace is attached to
> the controller (to do that we add nsid down the call chain for that).
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

This is much clear than what we have currently, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
