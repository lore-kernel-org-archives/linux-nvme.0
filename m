Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9836C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:40:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF6920853
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rV5uDnDs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UCvlP02T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R5yOUAgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF6920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/TEAOnpcmbGM3c0dNlPAWp5GVKU834E2tYyoQlNiyZQ=; b=rV5uDnDsu/FwGPr+zLnaRxrnD
	rNSF2M72gaMfjIBAPz+tAvCvDhG0NbpFapo46vjG4LaqTk4bj6arPbXa6tTW/vNDLThU4E2YyuLQL
	d9g/mrqMG4Q7ukA2watFgPWSm5GNWEYpfYfejgKgk07Lqp3AM0Sw37qJfzcR2CYqboKqRAuVf0SEa
	mYvBWwBz6BbXKXDwVEofJM4cKcaOX7ruWWN3tDdeu+XLERJ1Yl7lIEYGQGtD9boPSk0DuLIRyRJtz
	iUZEe2I5YucH89wvH5hZDq2DkmTXr2ciFQIRBX136GiqOBu6k891bGai6kvpYMibWzmL63Ls86X/8
	Lwr/C+J0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqheZ-00005Q-B4; Wed, 01 Jul 2020 18:40:15 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqheW-0008WK-8r
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 18:40:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593628813; x=1625164813;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PImDHpFAcTZlsO3zn2FAgK4S5urGdVTqCx1YkcLaraY=;
 b=UCvlP02TEKXLlfmaBRlya9u2kgzulmYgtutSEzmnKilw6ks+XlrjenyQ
 zqBw+pWmWcCTijC4uMcHonSZK4Nl+t31P9NJB3gnw5GG4h0AkvsxFN88v
 y99neud277Y7zxZEiRJhbapHsPL/peiKp33Q03ibh3TrxYdpB54yB9hmy
 gCUCnMeJNghEXBDLMI9TrDJ+pyxKEha9Cf73MbHTLuwtqWsed75zYCCqE
 WsKHJ6ABjPsD64y66Lc7kdlCWdGhXQSXCw1PHkEjmRu8a+e/Cb9/IVGoL
 uKVesbJKtQJ/v5jVm4F3znybDpTlqUu2/1s0bbAMHjscwndSVox2izNcn g==;
IronPort-SDR: hvqwZq9CgGQDiDWGw06zPvL4jg+Mb/vU28COY9whhSQ8kDRY3AxlCZ/WhCHjBGuEie7Jrqh5Oz
 UUM0JJWqvTWEGZ0xIZy5uuqiK/zwjVlGTep4afMYJngAy0iufOidr9MYn55J7ACVXacEuSgEA6
 rTdcEowN3MmB3dmGrVJBsuVcTulyAuk3IBnrWD0v99X98xr7p4M+Bor5yjbxWShkHBRwqrjNJD
 Sduyio4AI/7Quv3exkmKP+AnjThjhKwS1aItPsYWK1TTN/0ntKwd/JMaGd+yh3UYtkRQBRxt0D
 ORA=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="145732438"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:40:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4VRIJKqAwlFqaT+DJj8EpPXbqV0grrXq9lBTYrV2UUeRT8CvgqfTlS5Z7ldIvP2P5Lw/dy+pM2tDYvBYctOvpCLvsHbuAAeg4v/viePC/hEHk3QIR6q5wPEXDmX4AvpD+msrhYv00GWUdugIip2LDL87rJrksrGKuyteHIlBQQmB6Uow9kgFUQKQ4kj/QnXWIVHbe6YfL1LtSGWq+CBUSQo7n3RxUmgnmUqPZ5iHqA3JWEuoVR6oeO8OeY64XShTBwPSfOrZpzAXNMw6XCIclV6K7DnFSNilzuGT1gU4AAMBrW7uE2/2aAYDGFR+Pa+YK4WJSFokNCmAMrw2Gxn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJy6X5gbkBZ7oGFNXQmuekb2vyegakyD63iI78B15mY=;
 b=jjeZY4RTj+CArjoZ7ViSULvsYQdMBU4RcSrwZK5dY0T0DP8u1JqCThi5tuP+DA+H7wRV1/amDBVBJIUE/u7uveFeLeutLsQOu8KxoCH3NrvKFy+zMbNpBB0AO7lWBBMlx9OmSQi6JzSqBO17093bSl91Vj7qsoKDUj42KwXZoPTVr65/71fnkt2pAtImEz0oHT8Ux1lUUpDyfT5JmZjLsLBgQU/HFRmpfUiw+kSYgisFPJp5qzxdXXvSXE263aJcsZPSuaGt+SqR/MDZ++WHSWo99znmEieYkF6Ij7uP6UeQt0zcrV0/We/j0DZDsHApajy4P+kK+SadvvQT7Y3h8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJy6X5gbkBZ7oGFNXQmuekb2vyegakyD63iI78B15mY=;
 b=R5yOUAguLgcSKU3w9S46ozZ6sG07YEdKRmtLJqG6n0Apr6ySokisxmfB26Q6s/gXKaXHka+R08T5HSb/8cQsefbVmEsXzkiyx9tctdDNA3vWcfzmyjqZaV4tl08coLrjAJKb9IFNAuRNn3Mjz1dIqaJOqzaF6/pUjh+YxnQgiLg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6280.namprd04.prod.outlook.com (2603:10b6:a03:1e2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 18:40:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:40:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/2] nvme-core: use xarray for ctrl ns tracking
Thread-Topic: [PATCH V2 1/2] nvme-core: use xarray for ctrl ns tracking
Thread-Index: AQHWT07jIAP57v+mRkK34TwenoMqsw==
Date: Wed, 1 Jul 2020 18:40:08 +0000
Message-ID: <BYAPR04MB49656E94C4AC8B600D03843B866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701022517.6738-2-chaitanya.kulkarni@wdc.com>
 <20200701131235.GA17919@lst.de>
 <BYAPR04MB4965B6A3EE4591E8A05A2982866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200701182926.GD1988944@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f0d7047-0547-424e-5099-08d81dee2e35
x-ms-traffictypediagnostic: BY5PR04MB6280:
x-microsoft-antispam-prvs: <BY5PR04MB6280A72A6CD9B02F4B135ED4866C0@BY5PR04MB6280.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qy2Czy3hC9mY7ka5Jqp9aVXWQSa8mtmx1Ld3zR88pOUMHlFJINdfYCfjNtLJbYXc80Sh+U7+trPyfWoMi2kg3fKEREHBvND2pFJK6P9BAugConUweP3q0hcjm/FB5TxYKDdXvIuSxsI8Ex1YTtWAnqzodqE9w14URJK8vRveil5nQNsNjC3jZ5k2qPx9h1g8wWnDqR7WKJq3nnUzzCJ3fVT8f7J2WWFa7gdhTm3Ow8vSxgsqG4Ot5YW7nstJnRgy3VgagZHL4ZB3Vr50J1OC6CUEyCXBKgkPVFzMelldRaEztNOjk/CJlk3QZaZlbRE4c280LQjNPJ83sVOCYOXPaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(55016002)(66946007)(7696005)(66476007)(26005)(8676002)(9686003)(6506007)(53546011)(2906002)(64756008)(66446008)(76116006)(186003)(66556008)(498600001)(4326008)(6916009)(54906003)(52536014)(8936002)(83380400001)(5660300002)(33656002)(86362001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wm14HdPIRU8nNdrt5RF52p4abLXZQtlUi7/ag1mRr4Nj5inNR5JMKtkxQ2sdIItgJUqTyvJ5b5Td+Il2tVvZipY0vt4ERa9If+ibxBhsuIdE/lN8371Dop33siO2B1J2oZt2VKqHYWckv2prGh4jJenw0hcDqX+sjHPql9V7NobPCsgI8G1c3ekEw7KImJI6WrD7ix00yeABOa/No2zmPMM9tZkH089d48i8JXXrAZ+to4tZhKpXEHrBcWFnaJHWKXX8gVkWxAtLWfsjaNBQdAjobT9wsyo4R8sxe6PwcqDpZU3QhQ81SRD1vdJ84gIv0fXusxGPURU5l6QCkoq/q+iVnNcPW2q327HN0J43avuEN2yPrXFxTfBqIrcSxUHVMyep97vW6UllEWfr2q427rwkLG7dUGZEGbsJDo9hisV1bV4Z3WCaFkdi7CYzDJQmQDDZLPcTTKrG9A3KQCbus0JDXJ2A569J006vSt80pbY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0d7047-0547-424e-5099-08d81dee2e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:40:08.6123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9wANkgpcVsFUCw6aNGlb4oT01z3DLfcdO3APFyoKFaQIkptXgkUmZoFqzCFQpxQLglZ7Xlc7CmuQqsWz90puZMBQayCOf9Bp9BItKkfNqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6280
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_144012_503419_85DC7C46 
X-CRM114-Status: GOOD (  17.34  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/1/20 11:29 AM, Keith Busch wrote:
> On Wed, Jul 01, 2020 at 06:19:50PM +0000, Chaitanya Kulkarni wrote:
>> On 7/1/20 6:12 AM, Christoph Hellwig wrote:
>>> [willy: a comment/request on the xa_load API below]
>>> On Tue, Jun 30, 2020 at 07:25:16PM -0700, Chaitanya Kulkarni wrote:
>>>> +	if (le32_to_cpu(id->nn) > 1) {
>>>> +		dev_warn(ctrl->device,
>>>> +		"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
>>>> +		goto out;
>>>>    	}
>>> This code doesn't make any sense at all.  Why does a patch changing
>>> data structures add new calls that go out on the wire?
>>>
>> Yes, this should not be here, I'll remove that and only keep the code to
>> check multiple namespaces and if needed this needs to be a separate
>> patch.
> This isn't actually checking for multiple namespaces, though. It's just
> getting the highest nsid, which doesn't tell us how many namespaces the
> driver is bound to.
> 
hmmm, I'll try and fix it in a next version.
>>>> -	down_write(&ns->ctrl->namespaces_rwsem);
>>>> -	list_del_init(&ns->list);
>>>> -	up_write(&ns->ctrl->namespaces_rwsem);
>>>> +	xa_lock(xa);
>>>> +	__xa_erase(xa, ns->head->ns_id);
>>>> +	free = refcount_dec_and_test(&ns->kref.refcount) ? true : false;
>>>> +	xa_unlock(xa);
>>>>    
>>>>    	nvme_mpath_check_last_path(ns);
>>>> -	nvme_put_ns(ns);
>>>> +	if (free)
>>>> +		__nvme_free_ns(ns);
>>> This looks very strange to me.  Shoudn't this be a normal xa_erase
>>> followed by a normal nvme_put_ns?  For certain the driver code has
>>> no business poking into the kref internals.
>>>
>> There is a race when kref is manipulated in nvme_find_get_ns() and
>> nvme _ns_remove() pointed by Keith which needs ns->kref to be guarded
>> with locks. Let me know I'll share a detail scenario.

> That wasn't the race I was pointing out. In your earlier internal
> implementation, you had the xa_erase done after the final put, and I was
> warning against that. The erase needs to happen where you have it, but I
> don't see a need for protecting the kref like this.
> 

Okay I've misunderstood it and follow the same pattern here due to my 
previous implementation. Maybe we can get rid of it, let me see.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
