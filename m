Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B630C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:11:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B1020734
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EdfSbKLz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MB92bVpQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fjm6bVsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B1020734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=n+UbNj8oq9hMZhuanltCvugRKVLfApGS/B/oT14UVmE=; b=EdfSbKLzN8OhqkwNZow7kxAB+
	mlOJX5pJQhK6TtjXuOncx9M5lqrgEpPeRGxK6sEpEv1AzUTZqAumYRFQ6m4umir6jmIHY0CHDcV7k
	LOPMbpmrnJ31XLJ4Jv2qEgEdcH/9O8ldnL4vHADB8QxYCp3Jb06Xle2AC4Q4W8x36vTr8nYorY8TP
	oA0VIgrSImCrSaYnJWc30oL1/mLG2DfCPKsDf1kQ1l7U6waN16nV3/su4zQdB63E5j8RzXm97KfBB
	hw5+/XMKiWd89KU6TrFN/wmlmAuD5kVeltkWaGc3EIsdKITDocDNggsXaaodh5dfCNZ3UCXEu/wqL
	GZHhPSffw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Gwy-00010n-Pi; Mon, 10 Aug 2020 23:11:28 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Gww-00010H-NM
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597101086; x=1628637086;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+WXGfk+Er4ucN7zrrOAMnVW62yHLArZBfS06lSJ7w5Y=;
 b=MB92bVpQyZ7WHsIi7HctCXDuLNVHJZ0Q54h1XFAHBzYyvtapAmIcoxUa
 GrifV7c+hXGUzRFChbX2g38s4wyGPtBiXZ2NVByq5YpiMSqx5SoDsoMf4
 sP1OC/AN8v2J9r/QBLxyZJNDFRfdTnmimZ9/KBkWb3rJ1ObS45Pgy61Cp
 frQQPvlTGmIyWIr1dVZmxIUDLwr1Hn7F+S8HfPt1Gp1JM6Gw41WMhp7JU
 A7/5aD63NLv9hQyUaWFYG7BbYP0SrKWj1EVaHPpq/jvcxg/ZNhpyxT4Fq
 oiIN7onIrWPQikXXyWUhc+N8rDxgQo0v/kIGLUr1ebNf8JLk7pK3dGb8s w==;
IronPort-SDR: 2cenBa7teHjl1B/ZWNjpaTQ3v3Mfqpzn1Ulg2Ny/hSpDPLixVEEH41o7jw2PsKw8YZFfpptmEg
 SpZYP9V6Jym2Zx117glogrqNFAxwpRlwBiCfLLzEpXe3pDXGH8Zfeu+2ru/LI+OVq51yc9wwHr
 XGqcC7lCBQYDxUHjpRwRc4VV2wiot98pPuB9wuS/kwBkPi4fIUJGijpU2k5SylVJ28k/qST8kD
 Yie9dQfCPw9TqYHloKBogQaiB78y/dH0t7bl10FnxXeIlMmCMaXdxNKBsFe2YYkhTFd9NG8q6S
 wo0=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144616382"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:11:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYjWoJ18JTqw932I5VVXRWhCmWCG9zHFqVee7fR3jCHxYXkow35t3GqLY5JFhPIBtSgF08pcbEbsRyZj/GoPrMqRuPA0Y0dfL0/cOWCRpXKqnbCGXXbkUbgcHmoC/tW1P0Q7siBqTj0boJtcWQRy4Ad4JHPLN6M3wfIDkXX5545f15wx1gi+J2ZqKtBqVR7ikdFrJvQhRbBG/DMJdrwYwbWTCmno3U2OWdZyZdTIID9jf5GZNnu7DVqR43SFOwFF4X8sZuaVSNcDn0ocjdfdP4BfiJAhRZ03u+i2AwUPdejPSVR/2coMg3bWKYOaMT466a8yw77xtDOZ1ldjLmr5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbUFBRaaqNxKB8zbwViStQlvdb3/SNiMMk+zeKLyDI4=;
 b=R7XylKrpto38GXu5Bf9b34+RnxO1F3R9mMC5RRiqnpv2FoICF7od0TQ8vXRDoOcZXLZ+Cu5rEWADhnHTrF8i2/HXBksYyWrYUnamkbWXQ69RpymNjFbfHctfrr5RJbc9kcQfpcys7LPk/outBlXfJR3ewVeIstTiqOKAfHpNh9QUtslq/1tpNz42ZTsmF+JLQ+5AuKeJs7NTv2m/pZcES9Tyze9g5GvDPzPC2WIGcgUCLS6TB3yKqcGHHMNKuOVu6Wlz53GH6+rtcT7UZLg7YGBihwKJjqffNhtk/pUYpk5JzE8RCxehxyVhJZ+aU/c+FsYHgetStv1gr5JRdYj2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbUFBRaaqNxKB8zbwViStQlvdb3/SNiMMk+zeKLyDI4=;
 b=fjm6bVsUDUsot/iEHMfmbwr6O3+HztZx43wg6RBv6U3TeADG82/eQfA7w2Xgb/uIBTU97ibuVJMjQkR4oEchONocl4JTWaa+tDRWWysfdB5XMZnBcBGMzohVShAvRZKs/mo+dS24AQLtPcO2Kfg6FpY3rVRobAmC4syh87cg2As=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5687.namprd04.prod.outlook.com (2603:10b6:a03:111::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Mon, 10 Aug
 2020 23:11:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:11:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 11/14] nvmet: fix nvme module ref count Oops
Thread-Topic: [PATCH 11/14] nvmet: fix nvme module ref count Oops
Thread-Index: AQHWb0f4bdrRxDZaKUeo7S/Na4rwbQ==
Date: Mon, 10 Aug 2020 23:11:23 +0000
Message-ID: <BYAPR04MB4965E991435164E7CD5BFCA486440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-12-chaitanya.kulkarni@wdc.com>
 <9f8b2a69-2ba8-f34b-fe30-ce9e5e83372e@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ecd90d02-61e7-4309-caf7-08d83d82b392
x-ms-traffictypediagnostic: BYAPR04MB5687:
x-microsoft-antispam-prvs: <BYAPR04MB56874CF5CE0EBE26A24607FD86440@BYAPR04MB5687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3UNXsTa3coYB6YKpgK+2Xxql7MgGUbC8UTFsM709cmHRRlYql/tWvSNgPC/40XmzbFH92miVXOmwlLbTQgt/p2/suYpk9RMc4sByoIyr2vIJ05E9wyHJm2mv5FqNsEe3LtLA+Cv4fr8R4MJg/ohxC33GpBsaM2j9HFkYHOw7CYOQPaf0WAsUzW2VK3V0cJUUstM1wYT3bOswPQCQMqfgVc49WYb8BzW4M7oV28YUr4mX4MKhc+tSAdvvr7fDqmw4OsatyySE579I+ElM/8VawaDdFPCJ5npFaoNQ64Ha95L8cNu1HVbHh4KDerUGDbS5eT7LNbaReYvh7WIscDViQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(86362001)(33656002)(52536014)(5660300002)(55016002)(53546011)(6506007)(71200400001)(478600001)(2906002)(26005)(8936002)(186003)(4326008)(66446008)(64756008)(66556008)(9686003)(110136005)(54906003)(66476007)(316002)(8676002)(76116006)(83380400001)(66946007)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: d3Riy9ZDIYfxwa+lncPlGXRaUTo2YHIVU9uDNqD+bl6C0LflCj8CoQnf+qiw1MRYveb/jv1FiWnV2sTUx/WKK71tVC1l7B8eViyvY18zFVLjL/y2XGjbGabM2fjoG/Y0Q579jWbijfZwxoGPugjBlAk3O8ZVJy8jeyyaCCJ5hQlmlK/5/8eGM7DZdrHF+eBkesfDy0jiac8JTx5FmFvW8C4ztQM78a4RkK8LskfFw6yJ015kpOvfi42aQkZnaA6aVNvzWk38sb8bIgYikNB5rGpvBoSSEKrMGAIXBRDDgbnhb9IxUEKJ6wl3YJi9ftdK4MoisZBaHJryeEcSAn2lc1hgrHcIK6WsLDPkptFCjs0E8A5sZ5812BNOcYFiPL1famCtr1sAP+tgK2ifoCrIfE1uVFWi07z8FZi9iQCcFJFpcPfGgk+iNn4o5VRmIEMUP+rf1HySk6xZjbN9KSom3dzZyADy7fDvCT+Vr8Nj75/QEvkVA1h99k5e6Nl1bdEd7ShE6P3BoxqhxneCn/7sNvdc2h/9NJPDYSxKppO1VmWOe5q8+HYTaOLEVfSSuSCOQQSuLQv3W+lKo4fA30F2QOp3H77vqw/Wn5N7iJSzoWULNV1/7NHziyOCFLFJTOJOws6xs2/PfpMnz+3cC8fzXg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd90d02-61e7-4309-caf7-08d83d82b392
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:11:23.9900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngC4ZhUzDIny1P4ldjtYyzH1bzkiAPNwn2jDH7tNNkB3+KM8ihRe4SYJz1LU9f1OFn3+0l21W7Dwt+V908atnj4mteNhTUKrmdRfY5BII3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5687
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_191127_001830_2D855231 
X-CRM114-Status: GOOD (  22.17  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 15:39, Logan Gunthorpe wrote:
> 
> On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
>> In the passthru controller enable path current code doesn't take the
>> reference to the passthru ctrl module. Which produces following Oops :-
> Please mention the steps required to reproduce the oops.
> 
> [snip]
> 
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 05aa568a60af..ba019c0b514b 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4608,6 +4608,11 @@ struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
>>   
>>   	ctrl = f->private_data;
>>   	nvme_get_ctrl(ctrl);
>> +	if (!try_module_get(ctrl->ops->module)) {
>> +		pr_err("try_module_get failed\n");
>> +		nvme_put_ctrl(ctrl);
>> +		ctrl = ERR_PTR(-EINVAL);
>> +	}
> This looks racy. If the module goes away after the nvme_get_ctrl(), then
> it will still crash.
> 
Hmm, let me see what I can do.
> But there might be a similar problem here with the core code. If a user
> opens a char device, they get a pointer to the ctrl in private_data
> without a reference. If the ctrl then goes away and they try to do an
> ioctl, it will crash. Similarly, if the underlying driver module goes
> away it will probably crash in the same way as this oops.
> 
I think you are right, still need read code and make sure.
> Looks to me like we need a reference taken to the ctrl and the module in
> nvme_dev_open() (which are put in the file release). Then we know the
> module can't go away inside nvme_ctrl_get_by_path().
> 
Let me see for next version if that works.
>>   out_close:
>>   	filp_close(f, NULL);
>> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
>> index 32f4951a1df7..5925e93c4682 100644
>> --- a/drivers/nvme/target/passthru.c
>> +++ b/drivers/nvme/target/passthru.c
>> @@ -488,6 +488,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
>>   
>>   static void nvme_pt_put_ctrl(struct nvme_ctrl *ctrl)
>>   {
>> +	module_put(ctrl->ops->module);
>>   	nvme_put_ctrl(ctrl);
>>   }
> Given that this must be done for every caller of nvme_ctrl_get_by_path()
> shouldn't this be in the core code?
> 
Yes it should be.
> Logan
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
