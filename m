Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90270C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:37:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AC520853
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mTsHtXp3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ArwuUxtW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EMklsgnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AC520853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=kzKbHzmVFRX9cimujr9q0V23ZRU67s+cK0LcuukPIYA=; b=mTsHtXp3z+j6vqClj6+gKE5GX
	O30/L603Jj2X8Sm8ywbIasytEeiMjkU4bXznSqmTH+GAivasq/WlMCW8FNadpG2szEWMz6/7M04T9
	UVfSDyrodv+LME9U3iyL3vulWgrcXuYcRqm49mj9zyI17Z+fTYDNlA1WCqEBoKnC+YDvIxZhU5cSW
	aswv49VMmIgS+SRuz27ARc+jTk49u+uBTFC6WUrYN6GlONmBi9GP+bsFM2AXwXYWNRI9JTc0/Dfgk
	vUrpShss1YLcSsVZQJZp7N8JSRB+Tv3tfnzGb07Vf8VlHkh1M8uvIz2ia8z8KginBHQIrM414lcGZ
	Hw06cXCAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqhbR-0008Jn-R6; Wed, 01 Jul 2020 18:37:01 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqhbN-0008JC-Nt
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 18:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593628617; x=1625164617;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DeZnhjXzfy9I55CQgut93a/Di3RN7DfYKJnTZ50+ShA=;
 b=ArwuUxtWQCbOq3C29xexg7KvuF0oUtoFQxVyPRtoVjSHuGNzMYy/NGK3
 9Vl0b43jEjaLe91Jr1youjN/3fyB9OsOWCCLZapIk1u44+LWVrmkIyTGu
 er3jXoxnHfANoreNGIv5CzzXNjjQ2gy4C9Y5NXWIu1Qu30uxEyxBcfFMZ
 oB4p70vr7rpkGXucr19WHLeO8JeLqt0yh+ampNgMRJjZ8H4vcPian/HuU
 SEi++SA3LQFqekTociIlb9YW2cdKx/rKkO+JIsA8Rj2PN8QAQqB/xKwh/
 mEewUtDIUC89QZqk2zTbIXZD0ozcGKYHRDWNiNwk+pBByB3M9AGRgNXXF g==;
IronPort-SDR: mloR5o14tY0MfAjJMQ/CIQ7pyHuw1kNzyY7uY7FffpiaVPPBPVIkQbXNVl/QMfMxP0hhi/I1Tn
 UDVJnZxRnYkZDzwCJMYpRGaZOGREmwYDb6zwUIjuedW1Ej9foSu6lZ/RmllnWdyClLk/dRSZnh
 +I2ut6su8AUFQqmzw0nFtdTpkqC2RWIfR28nwLsBPI3HdjZBWgO8RBmhHv3V++B30eEhQdAreh
 OwP0OBmhDxwJ39/tkMZizL0xa7GpDTQSewO8uhM6h4/CyAfA2DjXw6YKxipCEewhtJpwfzAjuj
 e5M=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="141405127"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:36:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eeu2J6WWmnITXClIOi1BnMb1twR7hoCFQVcu9ybLZjay/FpFSyWOb3UcRrPO9cbqR+35RyshskYFRXO0s4U4m1WbVHsaU3EHvp2kosPFmLQqZyPKHtRE3jZMY7CxzclHRC8SO8QvtGQ0sCwoHBv8V8+FQKtNDW5111dQCqCpa+3jQFe8GX//mr65C+RvoygbpfJ/gyTqWxo1aOorGVGlHE52ebwngMqPBxbQRnM0OC83d0i5MCYJJs8jZJm3SKVg7mlv/1LfbTRbiZGY/PG1QemS1O02Wx8mjG3MgZc3EAeRzrIZ3M1pY8umGLPi/Bf6sHU8UwDyb9OrWxUbWDtavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd3YtBcSb/VnUL3RoygMqkXNudgRcJ9ugUo979RRT5Y=;
 b=hwa0zjw/gdRKG4H3TvUVxCQzt+AH3FeEt4OSb3zeCm64Kc/1+Nx23PlbQrpD/KBWmO8NS2wQI74CRzGZnp3hwPmhYtVcoZrKG8LtQQXC21yLYa5sm60abT8uCvxN7PVm/ZgIs9eOqkCwXSlZkjx2qcD0OsLhZMyZGZcPY95hp2BDrJQzSqwSyqyZosCEkpto0Y8wy3Q3oh2DVriWNvxk1hLQk3YiT25gfkYBDwNSRUoEpIoj/AIJ3y/DsdCyXOeuQ8mBkUmHv3FY/sRj6j4T3FMHZ+Bhds62DnuxfiglGLXjyS1vDFxGI3mXlOEv8b5ou8Qji6zGrFyABXY9J111XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd3YtBcSb/VnUL3RoygMqkXNudgRcJ9ugUo979RRT5Y=;
 b=EMklsgnuy9wKslq1tmNpdX292jH6qbPYQa/SdjpmNMBhm9tIO37xMAMb/pwcJ+A1upLGXFsivHmsqzougKlDJRODC50frcIUZ8jwtZ12chduFWh8KwfafBdM1Tc5xb5hWFhpAT1MY2begTKujuni0/sf8kaNNN5SOUJ4+lZJxDQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6280.namprd04.prod.outlook.com (2603:10b6:a03:1e2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 18:36:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:36:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V2 2/2] nvmet: use xarray for ctrl ns storing
Thread-Topic: [PATCH V2 2/2] nvmet: use xarray for ctrl ns storing
Thread-Index: AQHWT07oE7jzyHhyIU6/NKDqm5Jekw==
Date: Wed, 1 Jul 2020 18:36:53 +0000
Message-ID: <BYAPR04MB4965DA55152F9ACE3C3AC93A866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701022517.6738-3-chaitanya.kulkarni@wdc.com>
 <20200701060820.GA28214@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bbdf987-6a3d-4d7e-3723-08d81dedb9dc
x-ms-traffictypediagnostic: BY5PR04MB6280:
x-microsoft-antispam-prvs: <BY5PR04MB628033DEFED61FE4BF270355866C0@BY5PR04MB6280.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4R1JGCu7KY+6ZwEYbkhR+2YtyxvdVxXiYQtmDAlQBUqN7uYy7XbhwFEYgOKHDyXUW4YGKSpz+SW7WMR7OKrEAJ8Z7mom3kVy6/l5ZMcZed+S7cliYEyODHM+ZRlvZsX4l1X1/QDnK/B7w60AHLcW12YrAvbYa9iQvox66KhlebXUGmzhFcTZxvN9e0JJULQtc1kVf7sNmkVCDBJBhOsBw6Pv0DOoM96UZtkNkuk+JYnziZLNXIGI+fAPpec6zhgujJLhAtViVLL6EulDvwakh7EYAnyvhD0Y30KrV+MNyRRg1FO9+b02pO7zivNbHeJCAOnPKRkyneaalU4EAp+kbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(8936002)(52536014)(110136005)(83380400001)(54906003)(33656002)(86362001)(71200400001)(5660300002)(8676002)(9686003)(55016002)(66946007)(7696005)(66476007)(26005)(76116006)(4326008)(498600001)(186003)(66556008)(64756008)(66446008)(6506007)(53546011)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: mkBt77gZQ8l1krZEaLXPzOEymyvP8xHfsmODKq3Yk0z2eYph3pgyst5Ai4kJTbaYind6luC8SwGfEJjpeDBWE4ypQTWCoa0pkLQG5TxmQpQYUAGgpd+HG9WuRKi6G36taY8nVdOiRQj9mExZlj8roW/oODjiozDhOPD1fXQJ8kXPuyEL+6mbW0lyws4on0LZqWzELnULiSiFKV2TMl+nT56AQZ/5iWMourWp6yBvyy74N7ZZq03SPb+glysNkTAqjdlIAnwvib7YBI3BwbSitEQR0NTVf64xUFXkCvHX4JgLi3lmuLZdX2C5EGLTSRFT9y458LQkTm3jh+xBFskZHsGOGk0IBa8PErhYr01otgxTRL0cZKwO5Agpn7NaPCGEdpuwyHxEVb5YKqXzCcasejs3AnWYhOvUtLMYuTI6LAjEvR7zwFYGVmUbVb3Maj6UkYH2KkCu8qdh6Z6W0tAQOIi2ZgkcN0KDtMIhJtbGR8A=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbdf987-6a3d-4d7e-3723-08d81dedb9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:36:53.4557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMIfLpo80D80PdfIuWEon45qm+7r7PqieIqYVZewPMYkTrMSCxWDvvBJBHPyRPWKWx4+29DSc7FNuSmYf1W2W+xrKgbzFnyDLrwfEYjBOMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6280
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_143658_891719_B0556029 
X-CRM114-Status: GOOD (  22.49  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

(+Matthew)

On 6/30/20 11:08 PM, Christoph Hellwig wrote:
> Ok, for the target I can see how this makes sense unlike the host.
Host side is for passthru code which is not merged yet.
> Comments below:
> 
>> -	u64 host_reads = 0, host_writes = 0;
>>   	u64 data_units_read = 0, data_units_written = 0;
>> -	struct nvmet_ns *ns;
>> +	u64 host_reads = 0, host_writes = 0;
>>   	struct nvmet_ctrl *ctrl;
>> +	struct nvmet_ns *ns;
>> +	unsigned long idx;
> 
> Please don't randomly reorder the variable declarations.  Same for
> later function.
Okay since I was touching these functions can we cleanup ?
> 
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index cea7c3834021..d14edaa22ad5 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -10,6 +10,9 @@
>>   #include <linux/pci-p2pdma.h>
>>   #include <linux/scatterlist.h>
>>   
>> +#include "../host/nvme.h"
>> +#undef CREATE_TRACE_POINTS
> 
> We really shoud not include the host nvme.h in the target code.  What
> are you trying to get from it?
> 
Yes we this needs to be removed. I've added nvme_xa_insert() wrapper for 
xa_insert() and didn't post that series. I'd really want us to use 
wrapper to minimize the code and help debugging with pr_debug.

If we do the prototype will go in ../host/nvme.h ? instead of new header
nvme-common.h, please confirm.

>>   static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
>>   {
>> -	struct nvmet_ns *ns;
>> +	struct nvmet_ns *cur;
>> +	unsigned long idx;
>> +	unsigned long nsid;
>>   
>> -	if (list_empty(&subsys->namespaces))
>> +	if (xa_empty(&subsys->namespaces))
>>   		return 0;
>>   
>> -	ns = list_last_entry(&subsys->namespaces, struct nvmet_ns, dev_link);
>> -	return ns->nsid;
>> +	xa_for_each(&subsys->namespaces, idx, cur)
>> +		nsid = cur->nsid;
>> +
>> +	return nsid;
> 
> No need for the xa_empty here.  I also forwarded a question to Matthew
> if there is a better way to find the highest index.
> 

I did look into this and I'm still to add possibly in next V3.
Meanwhile if Matthew has any suggestions that will be great.

I'm not an XArray expert but if it is some flavor of search tree then 
largest index will be on the right most leaf we can either cache it at 
each insertion which will add cost for each insert (not ideal) or just
traverse the tree with an API (ideal).

>>   struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid)
>>   {
>> +	XA_STATE(xas, &ctrl->subsys->namespaces, le32_to_cpu(nsid));
>> +	struct nvmet_ns *ns = NULL;
>>   
>>   	rcu_read_lock();
>> +	do {
>> +		ns = xas_load(&xas);
>> +		if (xa_is_zero(ns))
>> +			ns = NULL;
>> +	} while (xas_retry(&xas, ns));
>>   	if (ns)
>>   		percpu_ref_get(&ns->ref);
>>   	rcu_read_unlock();
> 
> Why doesn't this use xa_load?

I tried to keep load code similar to what we have in the host-core
so that we can add wrapper and not duplicate code which also follows the 
pattern of taking ref count under rcu lock.

> 
>> +	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
>> +	if (ret) {
>> +		switch (ret) {
>> +		case -ENOMEM:
>> +			pr_err("xa insert memory allocation\n");
>> +			goto out_unlock;
>> +		case -EBUSY:
>> +			pr_err("xa insert entry already present\n");
>> +			goto out_unlock;
>> +		default:
>> +			goto out_unlock;
>>   		}
>>   	}
>> +
> 
> I don't think we need the switch statement, just return any error
> encountered.
okay.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
