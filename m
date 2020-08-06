Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819D4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:31:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8822A2173E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m0wBkLuT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IoNKt4uO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mhCVKeKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8822A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Zf4coNN5w3VY8hozQvhg3gNzR6KaIM1RJLflNhOcQ7k=; b=m0wBkLuTUhAIKl1DIEizRCDWp
	DxeH78fDQt8BwmMLNc2pUybHJ0l1e2NaUYTuVdnk9JFL+RZoFg8wwMDyd3aKaBKI9tNwTOButZD/M
	+EYrgpkJO7w25qbOujU9AzwtStFwwZr+RqytF2tm3TP+jSNC0IK3HQJZBkZRDv/IfJyV0jJDfwiQ/
	PTW1l9YYIzA0oe/VT+bkQ9gbDbgqPEuI3ARwdR7XixcxWf1cHi2VK61N63/i0Z9FsMq0DvTuSGzIg
	9alstm9f+390yje5Yzt+iFcMt49HSQ1G6FMELB0v238nFs2rT/CUeHa9p05MOM9kQ07G6AudM8huX
	ffjIwDCpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lc9-0005W8-ET; Thu, 06 Aug 2020 19:31:45 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lc6-0005VT-RH
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:31:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596742302; x=1628278302;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PTtML5mWVlJvPmsEaTmxt/rjggbrKtLWNPTlbY3UePU=;
 b=IoNKt4uOur21T5lzjm+2Ff9HtHI7OK1seqUBWRH/PPZQ2VY1qtOA7dgS
 jQte8tFJtD2DqNMij9xotd4lOODjEY/xv2LCf0SlczCwPfu3IsLvm98fW
 VqkB3Te8/Owq84eRrT++nSyComnr06cLXRfMNSruFv4kqGuN2W+2ayiXw
 ufr1ymbk42dn/ZiOtqOxrR10XVI9/3RGHWxNmh7MdVXSm/ylDyGeJkLkO
 XO+ggyS8A0Eu+EXXPK1n6RwU4KgtIjRvXjHKInDjvKtjcAwr7yjF4Ular
 koqWMR1j17U058UdP4/R8rBaCIedr0603Bvknp2aQGIP2EKDfmd70yNGA g==;
IronPort-SDR: wgDDN3g+0u3IiQb8XXcPM8WcIkwGhrzv3WdhQmukpkKntQSNkTy4+5tdDXwoqZrYZ/1SGRBZE6
 temYuIx6NPyi6+UcfOwuLmeknAUFc2x6X+zmteF05nw+Me/e3VQEeyThlVc4X9ATl61KzXn7p+
 8dd9GRXGXNJcI2pXMoFyZVdvk8BSmq7ALUMqyUym1DkY4Esv5dhuo2EL7Pswdw1rm0ctx4F1mE
 CCMnNKX+L3uuhGXtW9Gca20YlnMP0hxjso7PLL0mnKwI9ExCd5L136hDjDRXL9DTUDSqECTqbC
 I8s=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="144330771"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 03:31:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uuc7dzgcLqg9whJ6Ecc2TwvX3yMmcls3DMvvEk0vpl9GWASPiho09uWs8jN/R5+phDM31r/JxuFTraq8EEWP2ED8g08vkAuf+LAAUTWtd/hL/c+lGbQusYD2Ng3FO+El/GoahV8Lm/AhaVldDJDP1TzdREfr9sDRUIgnaVYbISOF4++7urZPwAWRtvfjvzNGC6JtedXRVWrilXYLwWepXVEibJds5CS7SweG+LmvtLt47SNeZ49wsmSe4wlv3FvCXoTk/owEhMy0GT30lTKTnrnZxGETmd9D6rYViY2+hSyAvSJNg+xRCIH0xZD43yn6LthtRGNjReIZe29Y+MBGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plKYZtN6TpsBb58ShFyWAZBZZfwXhVSJZdKxzUicfxo=;
 b=LF7jS6Oqf9hDK3L7P9ws+VTNS3H9Kr38QNFUOhBS3/BgnSp21SxqvDYy/hNCIva0BKkS4WOr12ceJVnXb5Qje0G50+AeriSnufvEJich8dSHev0rZr+MS+4xQhQ4ay6wA3mg6Rb1Ycnt7JagSQZzmKG9ka6ULdYdG9W4kCTg5/SsZxmzy66Eb/9U2kEV7FDnSwhq/rd5D93OIJDfT6F0trKIksa8qHaBgPU0ZLZD7RtFqp7B9EUMo7hETmzsIgL5vJoZ/nRlDadu1leLpZhKV+MwTsjJzrTGQ/R9ALmQvpP5JPJby4HCv0zrmz4LfSFRm7XbObT/Hk+Lf3yWDvRvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plKYZtN6TpsBb58ShFyWAZBZZfwXhVSJZdKxzUicfxo=;
 b=mhCVKeKcKUGW+L1UBhYTyfxj7XPJy4CQbwTvIbTNexfA+BLC1YhfwSAriF4H2XtlXf9jbXcyjSCW3JA9OPlmEwZG+8XUFk56otx2D3QxSvl7tF5zSC2PMV7oHVxUABpR7i3bC3VW1lMYW3GksN9/1sPFBHtiZSVFvfQlplSkzZE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3957.namprd04.prod.outlook.com (2603:10b6:a02:af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 19:31:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 19:31:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa8OqKK/52UoSzkecfpDi4eSGxA==
Date: Thu, 6 Aug 2020 19:31:38 +0000
Message-ID: <BYAPR04MB49659642F181754E06FF02DC86480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c4ee1cf-1d00-4b42-a20b-08d83a3f5693
x-ms-traffictypediagnostic: BYAPR04MB3957:
x-microsoft-antispam-prvs: <BYAPR04MB39578C0E0A9D156E0C49D58C86480@BYAPR04MB3957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sqY0458KbmTIJozv1P8Ssu6EUjIwThEvn58qNrJEJDzIAIzXaPueXnJ8asiJUjrpvP0+7LgFsNeV+pDNsch1jsP0K45DR9VtJrWe60BpVtRPscpSyhDBZSswo9TeBo9dQgAlRXchs2rbc4kndVdYBaAv07xyHDBCUl0eWHw5r22G94OlFtvXu8hha+9zK7tHa+hJFGKMJhzEj7a222KYCG81YFQAg2OaXc+7I/mtNu1XJfTz+pKIFThplbhmCAk8mJEP/hH0SjSTrMsp7c+AIWzvZle/vN7hyvJR0sy1S95tSn3EKvFdsqdKEtFuoTuxY7mbnCMhj90K8McvkHNT5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(7696005)(8936002)(316002)(66946007)(66446008)(86362001)(33656002)(64756008)(66556008)(83380400001)(9686003)(66476007)(478600001)(54906003)(55016002)(2906002)(186003)(76116006)(26005)(71200400001)(4326008)(52536014)(5660300002)(110136005)(53546011)(6506007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uTiDTPSlpqKqmQnRoSBkyx1t2xFnd7EAimGT8zlLteM488/ZJ/lxtUlRmayhCfS4SlS5dYMCI5Kqpg8h6deEoEspYlnVgs+ArJ0/vg234GkRpY/h+xTbnp127S16Qn8HlNBpMUh6GZR1zFjT5AA16fYDqCW10Dr7p9GnxE1uCyspdBtFKzrZmkiZNbSSGnF51IGDJYyzlfxD8JznjmWLF45VDFwsgioSxtZoW2o1AEsr65Tn0fmAU3jhmP+QUeDLJVUxM9tvk6J7N8LAueG7idM88nq7M2kQvoHU4OqvxIIn4MsiHN+ypUNtDWpvrwLciVNwwFxHeT3m8spHOb5cUjCdOBjukgU0ZskEPeJAclSfGu9f+uEHMRw5ok5tCqXh5utUEzv6gNxbE6P7obP3n97P0lnD1XtP2XW+WdtKdHFfpe4y0Vf2esnHt7Qsuz7NnAniBw3OsWPZNHv1LnlWkkZPm+V4IbqPZWVHoLiwBHfgG46P4DqAyhY0pku4/Zvxetsd1HOj/qWr4lCougizVSq+lQ8bnQutJAU21ySF5m5UQon7k3iSmW86MMIgX+j0k6MCW9a/NcHOym+9yfdP/5eEWKxzDVkBbN/kX1jcicTvW0TTFqAjj/FsuGBYUsK+DovPzJoAnkq2YNuthxDbKQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4ee1cf-1d00-4b42-a20b-08d83a3f5693
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 19:31:38.1762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0s2fXGu036fDMOx9x/hF1qIc/L9TR/jcCandRxDbjB004WfvnrWM+R3dMf+nXD554wIk8nevyKD0OZFH5T/QzOORxpkeq3J+5PGbfskH3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_153143_009403_6B21E33A 
X-CRM114-Status: GOOD (  25.32  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 9:12 AM, Logan Gunthorpe wrote:
> Hi Chaitanya,
> 
> Thanks for the fixes but can you please CC me on bug fixes to this code?
> 
Sure.
> On 2020-08-06 9:42 a.m., Keith Busch wrote:
>> On Thu, Aug 06, 2020 at 12:31:50AM -0700, Chaitanya Kulkarni wrote:
>>> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
>>> following Oops :-
> 
> It would be nice to have in the changelog what was done to trigger this
> oops.
> 
>> Suggested changelog:
>>
>>    A passthrough request may be NULL if an invalid namespace is used, or
>>    if the allocation failed. Check for a valid request before releasing
>>    it to fix a NULL pointer dereference.
> 
> I don't think this is quite accurate either. It looks to me like it's
> just a bug in the error path logic. If the namespace is invalid, it
> doesn't even try to allocate the request so it should really just order
> the cleanup correctly and skip it, if it's not allocated.
> 
> I think a fix like this would be cleaner:
> 

Christoph, Sagi how guys would like to have this fix?

I personally like to avoid introducing new labels unless they are 
extremely necessary.

I'll wait for Christoph and Sagi's opinion then send V2.

> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index a260c09b5ab2..96bc9aa11ddb 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -239,7 +239,6 @@ static void nvmet_passthru_execute_cmd(struct
> nvmet_req *req)
> 
>   	rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
>   	if (IS_ERR(rq)) {
> -		rq = NULL;
>   		status = NVME_SC_INTERNAL;
>   		goto fail_out;
>   	}
> @@ -248,7 +247,7 @@ static void nvmet_passthru_execute_cmd(struct
> nvmet_req *req)
>   		ret = nvmet_passthru_map_sg(req, rq);
>   		if (unlikely(ret)) {
>   			status = NVME_SC_INTERNAL;
> -			goto fail_out;
> +			goto fail_put_req;
>   		}
>   	}
> 
> @@ -275,11 +274,12 @@ static void nvmet_passthru_execute_cmd(struct
> nvmet_req *req)
> 
>   	return;
> 
> +fail_put_req:
> +	blk_put_request(rq);
>   fail_out:
>   	if (ns)
>   		nvme_put_ns(ns);
>   	nvmet_req_complete(req, status);
> -	blk_put_request(rq);
>   }
> 
>   /*
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
