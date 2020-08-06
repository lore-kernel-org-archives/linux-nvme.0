Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA48C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:40:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F472177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kkrLk14r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NPX+/JoF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YUZaS0sB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F472177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=v8kBNo3CkRphjQ68F1/NMoI1aeyk0qYq9JKYQw65w34=; b=kkrLk14rqU2pGaUADZj/GWjg/
	rtyuc4ZbgrrlrgO+eXpSee99gezP+UK1c8HkWWedapLnFaYATeMQwLc4LqNrMYCAVW+Wl/koKPMUV
	EFpksAjop+eQ9VkUZE6Bbf8eaG29sD8m0WXmLFq2UnUE7LoAAVWUFkris9mTFQj1E85b3BHWtLS4X
	YQn/Me0Q5GL3f+yFqgrqlqALwUX81+KuXOSjX658aRVDU58nXWafOw8qsKbj92XKQPnOJGuQf2EBQ
	IvszqVNO1qtkgaUatW60E72kL56/tDpwSB68axbSW2jgn7Su+kMP2LTQvlxSjwCqEqRgoUvcB97EG
	d4LETsimQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lkn-0007Gw-ME; Thu, 06 Aug 2020 19:40:41 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lkk-0007Fz-Tr
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:40:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596742838; x=1628278838;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MS0vorG2vvY2O/XxpHff2Bn1xfBYE1Z6ZjZUDEma4yk=;
 b=NPX+/JoFiHrY68zAnmvlRjCdXoV/23j2fO1PFKHt7tSu4LVfmJ6aSeAY
 N0jeoil+uIsVFUviqokTGQf7uHKBBbred2PZSaNOmeF20tpRdzCiaZS9w
 qKKuTrW7AgsZtjOZNmDiHaKtIiY4d/k2rsqfyajU4aP5wFWrFq1B8l5KD
 TjZ01/y4tpGWWNfUSRzPJS+7opysolBRcyWcSnS5bD8GhVeOBcn2UjNrZ
 BBs2sNB3U66mGszTQZMYyl+rwBjOxuMMVCNNyslMeU/KaMVJ9fu0ou6EK
 Gi7hju4/6csObAQBfVl3NJc7uPrYU2RSWBd92BUe4tNTfkurA/p8k7IpM w==;
IronPort-SDR: zsOD+Kh6Fgljpz1+8jhgj0aRuun0ucPkIOlfmkK4kwdazPtsubY83mYdoFYTEbqlLfoFZR5fwV
 9ktEC5GpVN8Qo7ptP3uIVsy1STyslAs2CCCo9OeacjX256fPky7LKyDNra09iPriZCZtxg4wo0
 IqXf/LlRoKSeqteyaVsAfOK1i+Fu48oaXfzqn54q3o8wKRUIFi0r1F4SnelcHTlcypKjXswair
 ZLXpflgPKJV1pjU8NlGREU5rLAqrJZsfOEoRZBDaDAumkTcoRSkbQ+PjDzBffZ25/TfLAsck5Q
 gX0=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="144331256"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 03:40:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyzlQLc0pBWovCFOWx3QOWFNpCO/7eHkZunE7MU+taiaTm9ekFfBZYl4GsJVb3syNWR+lRYM8JvZZiRJVDZYzQC6H/B93A7i1HJJmtHxB50YjP7BlzWRv96MG47L6y540bBp87eBZohi8PXxlHDXJZSwQauoPs5dZhLlFfsmWh9FicyomyohbEIzDmqaV9NBueF1aJqT/atAZ0VkQuZqsoqkYHecUk/3/ZYNxvqxys2nmYqRHVdYuktxfUlT+nEHGVI4/1aeAQqRgHSwAy8SE+JHmItEH0LYZk7ak6yyMp4t8QtV3ZOxZPMkiUSGb3HzCgNh06H+afwVXBphfft14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXSsZ7jROXjfARCmQIHmGsNxWqoQusf/b5rqIuR9mZA=;
 b=i26O/oGtuDI5hTX1vM4hFsgyLsd+rpH8m2jkKm24R/xit/3FNBQxTPLIMyAT2m08/iER0f65+jx2krZ18IcmwSEb9ig4gAhMqwx+Vhxm89CAvpIlAjeT4v0BOMXYsRW2X4dV2OJ4MEdPiwChk169D21x3XUk6HGsagjT/0NrQNWN74qHGMDLcQeCCCuCmpWJAh1h29GwbfVfx1oX1S+Sn8NJyVjkv+spUEkNsLsXozVQHOWDLtjzAqWd+i34fk2Lysz4Y2DNPREXmQWWHkff04pCEpTmQKCmM0ypPAw76Iz59yOvTpTtv+uLiHbz1mFmWOkKmQrqiQjGVM5EKDOuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXSsZ7jROXjfARCmQIHmGsNxWqoQusf/b5rqIuR9mZA=;
 b=YUZaS0sBpxlMFK7MI9uKojhLTU2w5jwVb9mJxxjOzcO330lKBIYNupYngDnZIZ2SpRUSGr/d4zEUtGlenc5I0quun18Gr0PgdeUHSQYQrYiHHkaFcEyCESKIMDcCp9l7VLKZHKEIIkhF3ERuO+aWtH8eqwmuof2pysemVp4BOsM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6584.namprd04.prod.outlook.com (2603:10b6:a03:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 19:40:35 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 19:40:35 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa8OqKK/52UoSzkecfpDi4eSGxA==
Date: Thu, 6 Aug 2020 19:40:35 +0000
Message-ID: <BYAPR04MB49654162034AA3CBA2F4E49B86480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <20200806162602.GD3075319@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0dec23a-f6c8-42fd-1846-08d83a4096d8
x-ms-traffictypediagnostic: BY5PR04MB6584:
x-microsoft-antispam-prvs: <BY5PR04MB658409CB64DA6871216C703C86480@BY5PR04MB6584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilqG94U6CnYerc3Pz+5zPZcGjtWAevJDpbZkp/QQvumC3+uYky1sfAxTp705vxYS0lEmO19YdhSDB4QJ0GBj+KGqytS2NPyd3nFNSypD/aRKnhAtAdTfAKqncbE6J/tp03Njb+rgv7AKK0e25cpGsG+adm7d7TdpDPmlbeQhuAPXpzaFKF52qrPxTfRH/MX05FR53QYaEsfeQiq2FI0dGZLXQH9FwFwZi1I2KEWIFBkAgTM3Tex6rI6+0bjAHu84WwR6xfx4YSSUtK87+XOU1WjzKW2f1vlUrcM8CiXBrpJHmr89QP8FZRNNbk2MpsVOThNYrM/t33Z0lVGqCP14ig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(8936002)(55016002)(9686003)(110136005)(54906003)(8676002)(83380400001)(478600001)(33656002)(66946007)(71200400001)(66556008)(86362001)(66476007)(64756008)(66446008)(6506007)(186003)(2906002)(26005)(5660300002)(52536014)(7696005)(4326008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: IPaV3A7JWb1TQLL7Hdr01GTe3nIFkPtYWpkm+YCwTHZBmLz6iSQo17DeEu626QSJh729SM/waPst9qVU7K5Qx5Lmd+IAU143S1JlogcmxyH5dI/gF7FAHzhg1axk0uES87ItSkPeCBipBncsWMaezRJZjH7VB0v5sqMJmAnNUZiDlqIeYIx+RfYo52Cwm03hXOoo87glgIVBbeUxdsuWKdqOroOFnu+25kHS7cjzMvYH54qondN3N3Lx3ltDlW1qRGgV3klnLYt2iwei1+mNgUTpMt8xpKcgYq//3funYNVvxUShthgimb1MjNgVY9bZRYlb0AwllLV6cVDAUKcP4ra+c3KfAFmFYjr9EinRVlOV5TsUWmejNreYSL7LH62TwMuOZjyCbIvJQMZBfBKJtIcMAlRkhZo2ihSqU556bQ9RCxpvwYCor+qXjx7zMF+0BU/KO9K2/sB1P/1W2wn5NifqPg2swFdkLSgmM2KS0FlnkSU9pMXBRtj8OP6fqG+atlHcPxJTGHO+KeMDeQtOSAoUEY8lWEY3K6WaGhe+K+M/T6ysu+H/KivMVf17Mcqw9tlt6L0MOlc4UwbXoa++B3LZp2xAm026L10RJlaG9ogUwCf0nPrCwTWtNHqWCAS4kgLk6mZLpRfcHVrQdmm2xA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dec23a-f6c8-42fd-1846-08d83a4096d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 19:40:35.4798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNDs7AMKfdBxzNxjw8ML/R2p36sv3OKdHyN9t0QfPY2cbFep2T8uF85c5B9BgFfJAwC6rBXnAItDmMxkZL+AMlDyeP4hP2sJbt2jDn3JDCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6584
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_154039_125455_85AFF251 
X-CRM114-Status: GOOD (  12.73  )
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

Logan,

>> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
>> index a260c09b5ab2..96bc9aa11ddb 100644
>> --- a/drivers/nvme/target/passthru.c
>> +++ b/drivers/nvme/target/passthru.c
>> @@ -239,7 +239,6 @@ static void nvmet_passthru_execute_cmd(struct
>> nvmet_req *req)
>>
>>   	rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
>>   	if (IS_ERR(rq)) {
>> -		rq = NULL;
>>   		status = NVME_SC_INTERNAL;
>>   		goto fail_out;
>>   	}
>> @@ -248,7 +247,7 @@ static void nvmet_passthru_execute_cmd(struct
>> nvmet_req *req)
>>   		ret = nvmet_passthru_map_sg(req, rq);
>>   		if (unlikely(ret)) {
>>   			status = NVME_SC_INTERNAL;
>> -			goto fail_out;
>> +			goto fail_put_req;
>>   		}
>>   	}
>>
>> @@ -275,11 +274,12 @@ static void nvmet_passthru_execute_cmd(struct
>> nvmet_req *req)
>>
>>   	return;
>>
>> +fail_put_req:
>> +	blk_put_request(rq);
>>   fail_out:
>>   	if (ns)
>>   		nvme_put_ns(ns);
>>   	nvmet_req_complete(req, status);
>> -	blk_put_request(rq);
>>   }
>>
>>   /*
> 

This adds an extra label. Also I don't understand why we should change 
the order of nvmet_req_complete() and blk_put_request() in 
nvmet_passthru_execute_cmd() and make is inconsistent with in 
nvmet_passthru_req_done() ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
