Return-Path: <SRS0=WNe8=AW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029AC433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2020 18:20:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F9E20657
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2020 18:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f6e41Nr4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OP9ryCDK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C4OeDAdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F9E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=JON6Nr7oe+VTlMnQL5urqOfhSI13EmWibZgtg3OKv0k=; b=f6e41Nr4SWJGUJDoFsQD+1CHO
	nlTHO3VvPJfUnx6D5gB43udeouJ0fE9RPsafW+cHZoQKC+Xxgv40sXMN3j7HxyfXF4FY4b2/zMcLZ
	vOLigdDWSFIFniP6m0kj2R+wKbls5+1DN83kSPQozB8Zb24iUvPSRVzL2wn5IsevwrFRWPpBkszKr
	ghGTLeSKzg/UoKTtdGWxIY/IFWYro47JLceAE6DJ6nDaYZPPu2EBXJWYY0qTZ+yyKsMZ3c+jsaJ3V
	cG2sY7jwri164BydtsYvzYZ4ckBbrzt3gJpFEEuN+LQolZURw/x/8wCahUBGsgPhpIdBPzwsDdNtQ
	M5Vo9bgnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juK76-0000Un-C4; Sat, 11 Jul 2020 18:20:40 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juK6y-0000Ty-8d
 for linux-nvme@lists.infradead.org; Sat, 11 Jul 2020 18:20:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594491632; x=1626027632;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=WhbVY2jItrmJ8bnshpr3wKbtrq6BiBeLmikKl4hJ2i0=;
 b=OP9ryCDK9iROwKkjfchprFObuGoYfWRgAYnSm8QgHIHaMWRgr2nU6e2J
 ZlkhxKMuCxH/Azwa7JGdMGVtIPysfaRktOK3NpbcPLfQu0zYy65fOWkBs
 yWfCU58RrqwDRczGyfKDqFQ6nCFlTjJBPyLHh8ocayQVt3rNCacXik4Bh
 s03fef+i/OB6kkvOD8dH064eoTdSmfluznOeysn5Qp273sk8oYizXdzxa
 w1OIPvtnAC6wD8mirPaCdO8J+s4YQWuksQeYAwPm9eLynKzI8wFdYF5rc
 10XXQtw9XLQbPtRKFHWpF7cWofscpQKvRKforfdVovOXQiqn3f2beLnBp A==;
IronPort-SDR: Hw+GvFehNz8Eiqya62+M4s1nWjrx3K+/BBebvhTkXVTOit2s0TzJQcvRWSLcrFR6bziBKnEjI5
 kKLzqZawkX5WNgexikz6m3S02wiLTxSCn0Kk+tW8gb2M16/IoMw/v75isrI8wbESlVC+KtM4xZ
 tgkG0CuIYWPZQUD4PQmNIqOYBL+R0yE6xfTUXwqNkSPKEZN1XHx8tlFa6C0diHtJdwLmrr2/8P
 FHiqe6BJ6a/eNgBp1dhwiWrgi33F9hnKkPkE+OSpICNOBZKGAEJ/3/ukzcDMEmrcTJGYGJcp9m
 +Rk=
X-IronPort-AV: E=Sophos;i="5.75,340,1589212800"; d="scan'208";a="142213382"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2020 02:20:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIwRasPgSjJn4/dnSfyrPtldG3LpwDdpFhuXBQsw8IwzOJgh+u4FPwruMaoTEA7uMEeKruaGzS5bq/u3BQx3PstxdLf8jYlHmbwjIUZvHsIG2u21u/ALq9cQUVv9AdQg2Pifdx3GCZMINbKbU5dG0IzaPcD1VQh88UWVRBOBAkQOrCNLY3717P7jY3eLuCKDSg/EMSOJGLDHkfMqUK7nI+cto7W3c8F7AeXz9WP2fjehUeqBW8j9h4oO/Mqmeb7JoGcr2hXmWlrMp+IUDZRYMiMGQLbd0pl+N9F/UDXk4+0/lgs9AR7bncoDi/8pnyV9qWNR++ofjFfE6YagJoz4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOxiLPm8uWTGrFg7g+oVKuexswaZ1B4AzbWbN1dho+I=;
 b=HndJPykAtKsJVLajFM6B9qwYBcwXxqKRGn2lF2vpv8qxV92tvyc4bbdJcFMMxaliuTXhakLvX3rCgTcHwsGduPZ6QKZet6Maa5SCmjp7Uug2s+NXHEZQC6f0BVthbEhsvMKxRNmeWthYuffOcGfLETjArs8Y+Wa6SATstrh3rbGSAO5062XdZp3Ob7yHNDsGvLCDEMVMUX20AzrNq6r3BDF7Gv9IOPIYJsMf8YhY83m7j6VffGP6Uztm43HKDvvjnNPMaCEF/kYHrrkC7kenkYx2EqkWeHq9KJUbvQr3ZCszTc6nTHgPz266wYMmw/otfcHE4pyxsbvcge7mqA6Dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOxiLPm8uWTGrFg7g+oVKuexswaZ1B4AzbWbN1dho+I=;
 b=C4OeDAdwQndLgpnUfI2lJSzVCgf2ZhspdhebCBWhq/BU84QCne4VVSthVdZWV7Vm+DrBJRzYErChC08xFUanDmkzenIcnfkb+VtASoEbUMZ8kO9H3k9jb4+scMQixTuZ3bBZwCL71WVevxDUHnIRDl67E5/6A7WAGWw2G3sPILo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4039.namprd04.prod.outlook.com (2603:10b6:a02:ab::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Sat, 11 Jul
 2020 18:20:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.024; Sat, 11 Jul 2020
 18:20:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/2] nvme-core: replace ctrl page size with a macro
Thread-Topic: [PATCH V2 1/2] nvme-core: replace ctrl page size with a macro
Thread-Index: AQHWVkpUVzGd6sb7QUGtvMo4HjxQUA==
Date: Sat, 11 Jul 2020 18:20:26 +0000
Message-ID: <BYAPR04MB49657BC0911F0E802C1E516D86620@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
 <20200709234025.10673-2-chaitanya.kulkarni@wdc.com>
 <20200710145742.GA2424089@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6a9a7b7-4321-403b-4175-08d825c71583
x-ms-traffictypediagnostic: BYAPR04MB4039:
x-microsoft-antispam-prvs: <BYAPR04MB4039CA600FC93A6E6B00C0C686620@BYAPR04MB4039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uRsDhfnLui79V+XKVMm3xM5v7e7KC2CLYOBKdJ3buzRIU/JKwotVk/ofjXmsdnZSkMBol6hYm7VcKgAs/zgicj0ywOIlEVnmO3KLODTWpvzArEfhueu+xH7ev4Nxax14+CGpDmIdgxyWyMsbmSrojUIwZ/ugY4Y/2/uw/ygW49JcX50BNhVMzDvx3DP9CHz9iMH8LhkQig6qDBr9ZsU1jkeyumfoXrSAAiYlmgqSL98vHoMnfyKNAdgKr4IFeZV4AFGDjvx6bvKOiFeqADzF2YcTqplQtm384e25dfgK0n8b9OmjjrUhiwvTxR+ky7g0kGPUxTG3tri4FtBPQExFNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(66446008)(8676002)(5660300002)(86362001)(7696005)(8936002)(71200400001)(76116006)(52536014)(186003)(6506007)(478600001)(53546011)(26005)(6916009)(316002)(66556008)(66476007)(64756008)(66946007)(33656002)(2906002)(55016002)(4326008)(54906003)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: mcav12KO3JX/OahW39RT7HXhBNqaONvkopjZJ67wwVhiw02uFHONR5kUcqmVsVktN40txLfoNfRtDwYXsImZb7tIJQzujKjNXgPMnQR8py58XSz92M7ZWa7AoB0vld493voxMMSdsASJIDIKxqPUWqxDW8GlGuynzB16s4ddQwASJPHqFrxzs7pbzByCnNq3EmlFxhHhVp/A+tUgriyXbxYfRTfaD2hjejbAM8hNp1lH5uGiau4y+KyXmX2+mmDq+paQC/eedxADR3RjZLm1gviP2HN3JhmI4hJF6Hc9NbTJ4lkj5QyxA+bGQwb+cLRQAzGzd5S0AAnHSPF5XkIbO/quY+rAstIQXt5vJkpiOLErfa6ZzzSwXthq9Wc6axDTn4eKOYF9y2BjiJ9W0Oz5r3Cznu20rWjtrr2rclPenh5txpRSYxM1sZ5XBA6xaE997HkFkA8xroPr+SDDH9RHgawYN2IS4hPan8SzdjNwXtk=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a9a7b7-4321-403b-4175-08d825c71583
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2020 18:20:26.0569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AONGusBS8zTh5/tsGqkvSbbPnFuOeRikRJz9bMuk/ieGp0j/05UUsOp10IPzT3iQwiITtnbOsJurGW15kF4/A5kDrjduTJobDYWhbWWAYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200711_142032_465315_B59B3DB8 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/10/20 07:57, Keith Busch wrote:
> This makes it sound like we'd actually trigger this bug, but we
> currently don't do that. I think the changelog should be more about why
> we can remove of 'ctrl->page_size', something like:
> 
>    Saving the nvme controller's page size was from a time when the driver
>    tried to use different sized pages, but this value is always set to
>    a constant, and has been this way for some time. Remove the
>    'page_size' field and replace its usage with the constant value.
> 
> This also lets the compiler make some micro-optimizations in the io
> path, and that's always a good thing.
> 
Sure, I felt since it is not triggered yet it make sense to document 
what actually might happen due to current code.

I'll use you log.
> 
>> @@ -1825,7 +1824,7 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
>>   	c.features.fid		= cpu_to_le32(NVME_FEAT_HOST_MEM_BUF);
>>   	c.features.dword11	= cpu_to_le32(bits);
>>   	c.features.dword12	= cpu_to_le32(dev->host_mem_size >>
>> -					      ilog2(dev->ctrl.page_size));
>> +					      ilog2(NVME_CTRL_PAGE_SIZE));
> You could replace the ilog2() with NVME_CTRL_PAGE_SHIFT. Both compile to
> the same result, though.
> 
Make sense.

I'll send V3 shortly.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
