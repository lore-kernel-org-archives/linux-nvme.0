Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5364EC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 00:58:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FA720674
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 00:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rrhtcGos";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tw+q5WBH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nALZ1V/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FA720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=AztbaUTkSNnlvZbqJC41luqyE54D11PUQF9b8YGGgzo=; b=rrhtcGosrsYj2J
	petN803yc7aX4dYOgDsRECJlFeQgMiW0PTW9fn/9UT5Pw7BhSQcM2Lmjimz5y/cuszB6tGf8p3Ci2
	itZ1KGuM1UMHxz7ueg+fpFWl/pseMqVkEO8q6Iat6IBa6ECs/6KvZjC+rZq/l6jupz0ShVt282PBk
	S+4O5HUXW8le4ehir6rCsfpBPSarS1k5snHohAbCejB6d7+OWvox7Iip0odOvhBGWv3AZdC3+5wyS
	dp7EwH4FusYRWV1nu1L7MozBgytEXvugM/xpv0R2AT8Sonn6xCzuO0Q9CA3oby82U7vxkmrqsy8vn
	OeX4SGeyxgdeJb8qmlww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaqaa-0002Zb-07; Tue, 19 May 2020 00:58:36 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaqaX-0002Yy-Fp
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 00:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589849913; x=1621385913;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/CFVSfJUH4RILjQXt0HOVwruYwr+XnVKxlsb94mx8cA=;
 b=Tw+q5WBHkQsJIvcgS2g8GDPQE54YWltYuZwcitwoqnQJS6jv0dBM3NFi
 nogJgrzWAB5arCapdVzzeXiRbyGSX9RTdGzXkGg4s3gG2SQpxUNlETCZU
 R/Y9fPAAF80yu85yislORRmmMyeYIRbm5XAXBhGmE7X463gEWI0sEkLSW
 XM/xtN3GEfHiNRy2SVCQuLPwYABf4g1jOsPGHgdJnvzGRbU6hc/L3zpPk
 7HUkSV6FaBGSdu9ee0OyQ4TbF30hbxfnDuJCfgcXfwgnTfHuyN1KDEPm5
 le9plrG2XNi0S7VdWo0hcbuowaRZ4QyL3/5it0sbSh0+qNOpAO9jjhp58 g==;
IronPort-SDR: 6SUfRV/Hk+uGdR+Jwl0sf3swvt7HdLFa241I549JPmXjOIRuluZLdr4tPo1qZbCWEcmN5QpZgj
 0VbKnviPTp1xzOd4Un1laVeBSGEb4r/wtE6J1a1CzJKeZV7RRqr2hxY8EmBDzGJJh7CIejgPRX
 A+hAGU7aWbP07uHC13xxYkPXblfUj8FUck85MYAN6J+Z7TKlnrSDGArHam2Elk4QtztcJKg+c5
 OEzPhgnv6/+p26ZK75JSr7wbwYNLPtiNKb42ytJ7W6IUALjdhhruanOB8oxSF+QMLHpN0nWe5a
 I2w=
X-IronPort-AV: E=Sophos;i="5.73,408,1583164800"; d="scan'208";a="139426565"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 08:58:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ditc6+bsVfKqY1P+lxr870YNBuZ2GkTeaZf7KmX9j0yXrHEx8k3MusKCB52jWhY10At0Jl/ZzlRqLxPwnqrVlcrJxhTZ1GJ/rUptBgMC8uwS7X7oIsqJsRkjf/LQyPwMqtm7hEaoWhV3+m0nnGxiioDeER69jNTAiVavWuRldSl204W8Dddpbmo1cgizjAv8IiOXKHQH8EYJz4SPQHl3KzcdBP1LF/iFCuBONa0vdAQ09soVMnvHyf8ZT5MYAFGSNLuGYHR+9PnElW+su64sXtc5/NdN5JnLScNXD7Qg7+l9dyJ4nUE5VQyUDYmHKnk7WIUG4v77OUu7VDo/dP8g8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYWdEtzCla84lHLIich6KSXQ6i99iVn14Fe7pTsF+Ec=;
 b=Gv4is8RRDDKGyZ4XmhyGblUfHjANYPaAVJkEbijyAyEFVuwsbJ3Wz3v9YW3q9HXrnywGUS3JaxtXjKe8z51hF6CuLp5Ymt7j8FKm38fr/8hWoHlPeCtBGgdlNvwMVJPXsZzIB+ovppW1jdRDLfKXvNtoBjt7LinLkQW49cpBhBm+6QKr2Pi0ddftrHpwwJmLYc5+4A5yeI/ayvfs5TBRqqLAguQqvQxf8DLFhsRa0Zhclp3ZO0jQmw28VKNYNfr5OxM6huSI6QjMAF8cCmTa7XBqnuGI5EiheWB9TyM5GnfILm4y2R2xXlbwgORe9Zv6TD3pYrkgnpoFiQDFXdLqow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYWdEtzCla84lHLIich6KSXQ6i99iVn14Fe7pTsF+Ec=;
 b=nALZ1V/ibzOyxtvX+LCL7ril3lwCYJp0rVz1v+PwOKJDZcTUWFeUV/nwg9MxwD0QFC3t3gEss4SFPGeWxGQWlETZcfOSQtW+WzOBDHukpFwZHqHTIgK+XxazVN2fDVSUaGmr2TE/mlk7gt8/gVXVdhXLXJpXTmzZVmnkoFNxku8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4711.namprd04.prod.outlook.com (2603:10b6:a03:14::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 00:58:29 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 00:58:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/3] nvmet: revalidate-ns & generate AEN from configfs
Thread-Topic: [PATCH V3 2/3] nvmet: revalidate-ns & generate AEN from configfs
Thread-Index: AQHWLM0jSPbMchjcMUmLGpuHRUKfuQ==
Date: Tue, 19 May 2020 00:58:29 +0000
Message-ID: <BYAPR04MB4965D66233899F1CF0290CDC86B90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200518043034.48277-1-chaitanya.kulkarni@wdc.com>
 <20200518043034.48277-3-chaitanya.kulkarni@wdc.com>
 <20200518150551.GB8871@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: daaa8c1b-5c8f-4a15-da94-08d7fb8fbeae
x-ms-traffictypediagnostic: BYAPR04MB4711:
x-microsoft-antispam-prvs: <BYAPR04MB47118D101AD3EB0EEE81CD1886B90@BYAPR04MB4711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3F2ROQ53eVTtDIny6HEmfv41nTAk2eS8dUOkWmRPyfjMdGc2qNrJs+ouvChIfpL8QuiW/JIm1aR252h0oJEkBCMMXcBc4bfC+TfXyb6duTX3f9DXTQrsp/ZaUovxKhpOn7Pn9cdoROTvrJ/jTOzYHjd19E1TKjY0dHFrK5amlyx1sRaQ8RzBKysVCebYkphJ/FGSktx2kWRU0SV1lJWrVb5ObIRdmdqs6/eOT4U9yZdGtbO/woYVfVjRz4UJ2lVqbkmhoPwCBGdXnTaxnRg/CYczjZbdcKNN/eFiF1V+EJGWvLhEPAZkRA/OCjTwr6B3RSL2nnV5/nPJs8WSM3cxMYQpeLeeZzdSgcERsA0oszNQv0Z+J1THnFdBfRIN0jSuXgFputJjrXVFb0aTkwFxNReMjERiI2MuFzv4ZM7tLPhCAvi04lltpgqsKfSBKap
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(6916009)(76116006)(66946007)(8936002)(7696005)(66476007)(54906003)(66556008)(66446008)(64756008)(5660300002)(6506007)(316002)(478600001)(558084003)(186003)(8676002)(71200400001)(9686003)(86362001)(55016002)(4326008)(52536014)(2906002)(53546011)(33656002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZLF4fWXyVArLL9AkoGJDGbeeLq0+UXqLqjOVZEnKfycc0QIs69ZSwY7nX4jsHuMgfpM4Sc+F27s96AMlb3Bq1uRQDqqc7LLL8YNp/K8Qbf96IcHQTXZbpULftMbksiHbZWqOtAGbf9V88B2Zydci46ZoY/32cKJ1BxqYDPn4Fx7TZJMuMgNVx8l3C0a6rWh5nvYcaDQ5t9FNNh2pUHcr24oq1O5VBh+bCBeztgIaUwQaOFpG8g140bHD34zin61Sq6m/V8gwZrRznj5kBL5Tnn30X4AtBIGYTy8u+r5SJdqimZXwUg1kieTS3QuWnuSPCK5mZBC6pqQBw2aE24M64SqZ2h6f5GTpV2RAk7ITdy1ALascLzUiU9kXL99VtPr0MMmPxfEQVSGM0icJ/iKcfZeB4D0r+8CNi1xVzmGJ/rpnDpLclveAsllAkHMm6atSs24wexLOjyRRXWK76d3xC8te8ShYXdbaMYGVZ3GyA+E=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daaa8c1b-5c8f-4a15-da94-08d7fb8fbeae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 00:58:29.3120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cb8LN+nnyr7XgnXC96WfA9oUJFvqj0e9J/iRifMhViVZdaMBqx88Hp7dP7WC+vDSUgDKzvjLDqKxaHtG+XTRySTRBVx+ldVM0NoZ012kNtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4711
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_175833_622221_4821BBC4 
X-CRM114-Status: GOOD (  10.97  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/18/20 8:05 AM, Christoph Hellwig wrote:
>> +	if (!val)
>> +		return count;
> Shouldn't this return an error instead?
Will fix in next version.
> 
>> +CONFIGFS_ATTR_WO(nvmet_ns_, resize_check);
> Maybe call it revalidate_size?
> 
Will fix in next version.
> Othrwise this looks good.
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
