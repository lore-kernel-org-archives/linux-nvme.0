Return-Path: <SRS0=yQ2W=6E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87339C38A29
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 00:13:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516D920882
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 00:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="awsLdWLU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NHIkGdYw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BQcPeDsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516D920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=/m9T3sHR1Y3kwRG4Al60rE/X915BRdCPKEPYCuMfbJs=; b=awsLdWLUMBuMS3
	sju949j1EIThhGOIwe93zAcKbuBgcubAS36CssaMBMXV8plYE6PvOwzK8zJcROoeVZgyv60jMl1d/
	8ZT+1aAgD+fxqUsXd/k5uKuzyCf5PQJ++HazE4vWa4XrNHq8oQb1kYYp8BJynv7rBPK1ZeDoXMQVA
	+VaqD98OMN2UvkOueGoVLLlIU1xwxThUaHu1WF68HTqmvYXWrK3G/Hca5RbInRDZeWyGWh70AzcqE
	pHTaZB/uteU9khlMPNPWNMVF7TX+nbnkiH2QJ5ap+QlvyyohbKv6U/gtQmuQBOaNQERBqFNoMcweW
	GsCz/C/jMApy8XvISEJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQK4E-0005Dm-Dt; Mon, 20 Apr 2020 00:13:42 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQK4B-0005DG-Nk
 for linux-nvme@lists.infradead.org; Mon, 20 Apr 2020 00:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587341651; x=1618877651;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=V9cM9dOA48U3XZ0J2KEmDZXburFw+vemFctnJGwCMag=;
 b=NHIkGdYwuFPgMQ1FQJKkREk3EoFsV0UE0sTMfjZDsNlVKN3RFd2QA1JY
 6GProuz6va0c6QuERS9hd6ZVOT1Mr0QB40qtDp/88sXo9o5v2I3AFpO4v
 SZ7JSUbmuaWZiciVA/ln9YNw21m2ldJsQ/osCCm68ufGY9v9r51ZCXnDl
 aD54aIUhlKx5TaSLqPWnAunYldl4Et0tnUqB4ox3E/UWv7ezpcw7JGOW7
 khw8L518CHRu3P94FMP92g+izPNzt7t2oIFaWxQ1MG0o3cyXf1b1SXqaS
 RsBXuSRuyOKvtEAo+SeO5GyKCJs9KDZ0LZL/7xJA/76D7Gn58amBGOevg Q==;
IronPort-SDR: sY023FvFiy8ScdQ3W7l8CpVxcrkVzKdQv72Ascw26J6AWyB5qN0Znrf7ZzftwFEM7WI8yvnY5x
 TrbfN9APQvBb4nzL8Yfn4OKE+zgQ34Ne2k11ePUf8H4P4S/nOE2SzxiT0rMR6VM8M/v4iQe7l3
 8iKI/mF0j6+ugAGegIilHoJ6uC04WbgPjJgTJwDFIl1X/qE9/PnOawJ8tCMjfCKnkafrtW9xjR
 hAT8hWlmyEqM4juxQp7hZ/KGW0wDs45b9SsYOq791MQwRffuTvUB9NSlMS7TC8jRWwaYrHmCb5
 ICI=
X-IronPort-AV: E=Sophos;i="5.72,405,1580745600"; d="scan'208";a="238117569"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 08:14:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgVQhc1U5Udbm/pL9Cj9wchmtHY8xitZO6mOrd2a3mH9Tqgq9tHYAoUG+TRpyn3u61kyE65qhCHdA92Qz8RddclxrIYSoaEWeHsSAXlAprT5o3pkqCZc3f45R5gZ6zEyh28jZ8scG7OYsIaEjF4YF/yvutOCKLK9/QBb3vRoREnbVxjmVoHLfpPM9hr3hiMihKVWCpyk2G559EqxNfkFc4JOLk+jPV7HRIZnuZ0h6OiqnhYvlvMIqiebtkXlBIyg69omm6eXH/xr6ghiqlRqpp/VZ1CNC4RaaFyetvD7SSVqulX4xJnxgLnxfvVFJA2D/1+zaFm89ZzY4w2cYponOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9cM9dOA48U3XZ0J2KEmDZXburFw+vemFctnJGwCMag=;
 b=kN1eg6BGdn1YStj5aBTOBqYQziQRhNQfXMN8sYheNK6UAzYi/B68aw4gpUoe6umG7fVXzmH6jZ5g6A5dS3RLH6uNoEV5gNKQ44beD1y3Q0aGiL/wAUio4LiVMS1tZtJeq4LdfvJ6pNIlRg5KCC+DMZ9nt1jTpT/M03C69P/4l8tzay1qK/aEM7JPqxNHX0/txO+VtdyASdPlSu0nTel/pVdu3Zr0nSk15IGBoy4XTbYEcCreICSSnCH90tS8JffwJXtCuHagi/rdvkrs6JbO717CzE2AVl+Bbgu6tNf/j/rBtPLH+zrR/4ek8coDRKlIUZFimwjayKWOwxK60S3N1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9cM9dOA48U3XZ0J2KEmDZXburFw+vemFctnJGwCMag=;
 b=BQcPeDsNWoKEOMoe+k4Jcz92ArXySgHBHKANSXgKQcQI8+RrroHYhqQrWNVCESo16QHE5xIbIgoS5Rk73rujgrSCgbMjFiXGB3rSVv9m2iaGNlBtx4k1WTFbjlvsjcm3WLIfk9vDCE3Y5hsRzeKjTqrq4oLLtq0T5HCv6YkNzRQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5303.namprd04.prod.outlook.com (2603:10b6:a03:c3::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 00:13:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 00:13:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Topic: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Index: AQHWDVyGx1h1rDwyCECcI/Bh3Diljg==
Date: Mon, 20 Apr 2020 00:13:36 +0000
Message-ID: <BYAPR04MB496570139FAF76E51910209F86D40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <SN6PR04MB4973BC935AE3BFD4CE874D9B86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
 <f3f226be-0bda-5d5d-69b3-a0f3478ce51e@grimberg.me>
 <SN6PR04MB4973EEEE55016BAB488C180A86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
 <fb1ec36e-93dc-c948-aed5-dcbe45e75b3b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3867fa6b-1813-4b20-ef53-08d7e4bfabc3
x-ms-traffictypediagnostic: BYAPR04MB5303:
x-microsoft-antispam-prvs: <BYAPR04MB53033D4B797BDD9EE158981686D40@BYAPR04MB5303.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(4326008)(9686003)(52536014)(26005)(55016002)(66446008)(186003)(478600001)(76116006)(66946007)(66476007)(66556008)(64756008)(7696005)(110136005)(81156014)(8676002)(8936002)(71200400001)(316002)(6506007)(53546011)(2906002)(5660300002)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oe/Tq+We1qQNnvHz4xZC6XEnvTOYfDAr/hretJrmlacPneD90zon2X4cJLBmU9EhnKlEsxD3IPAzHlQbmEE+joeGEa670ReJjYQDEJX696rZSH36YOrdud18w0dW+ztjBLlNm5rjCdm0V8nBC5qyfKG7HLp1obHrJ8+vDw2b2gwcRRSYhYznr1uLeLNT8eaCk8PV+UT7C5/WN44I4IVNcH1j68qgRPjNLCJBLU2kDFW1u28Sqn3aLd/RcYO4pfVfNg5FXAEwhacBVj3Oy8cWpApG/dLQGgZGnnyVaewYxY00csah4mYIgw19D0/8TPIdf5qa95mICncuGtilQPBSNoaW9ySj/RXXUwUb7hcHEs4wd7GjOzxxZqSB0MCH1W2EjeaPA1uZHzjehY03tWi3jcR+K7/40s4rIHcASgZP/Ch4H78n81+DGS9sA8fgm4nE
x-ms-exchange-antispam-messagedata: /gLT+o3vAU36xdxLj6wA3YszR9zKRUXMeHPNTBYJxTJs590mM5+YFzHDL6kpronFGnqZQF488B5FNk3RCGLHwssxXMTRvbJXyk+w0I7IXrkfd8cQmfAYhzozBYJkGIsgwBsAaFN0fkc43Cgopy4jgw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3867fa6b-1813-4b20-ef53-08d7e4bfabc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 00:13:36.6136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7AunmPhH02bnpowdfvMFuXD4HkTE1Ea0zNw8VJyd8l08z883ci0NW6e2TpouTD1mGmyvZ5W3W8BhQ3swunBGH1qFmgvwdNaOo5LscXi7RI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5303
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_171339_927293_A53C7372 
X-CRM114-Status: GOOD (  17.24  )
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
Cc: "ailiop@suse.com" <ailiop@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/09/2020 09:07 PM, Sagi Grimberg wrote:
>
>>> But maybe it won't be such a strange thing to dedicate a maintenance
>>> thread that would do stuff like this. My main issue with his is that it
>>> is polling which to me seems like a band-aid really...
>>
>> It is, but having a lightweight maintenance thread is very simple way
>> to implement this for bdev and file
>
> Simple at first sight, my main concern is what the impact may be...
>
I've posted a new version with fine grained tunables. This should
make it easy for user to use in their environment, instead of forcing
it.
>> without involving userspace or fancy hacks.
>
> Wouldn't call these hacks really, we have several examples of
> disk resize triggering events to usespace.
>
Yes, not fancy, bad choice of word. My point is let us try in-kernel
approach and avoid adding new configfs attributes if possible, if
whatever reason it fails we can always add userspace.
>> What are your concerns about polling (as in sleep() and schedule()
>> calls wrt to the code)? Can you please elaborate ?
>
> What is the right polling scheme? what is the impact on the system
> performance? What happens when you have a lot of namespaces?
> I view the polling scheme a band-aid resulting for lack of event driven
> infrastructure for disk resize.
>
Yes is, the right thing to do is have f/inotify for file and in-kernel
gendisk event framework for bdev. We don't have such a scheme. I did 
spend some time into how in-kernel disk events are implemented, it will
take some time to get that it upstream. I'm working on that. Meanwhile
this will allow us fix existing problem.
>>>>> I'd suggest to expose a revalidate configfs attribute and have nvmetcli
>>>>> install a udev rule that triggers a write to this attribute. Balbir
>>>>> already got the udev notification for disk resize (see
>>>>> set_capacity_revalidate_and_notify).
>>>>
>>>> Okay we can do that. So you are saying generate the AEN from configs
>>>> attribute.
>>>
>>> Yes.. that won't work for file backed namespaces though...
True.
>>>
>>
>> Isn't that defeats the purpose of having a file backend which provides
>> more flexibility to the user ?
>
> We could have something that leverages fsnotify to address files...
>
True and for bdev we need to update in-kernel disk event framework.
I've already raised this approach when reviewing Balbilr's series, I've
started looking into this but will take some time.
>> I think we should at least try an implementation which has global
>> maintenance thread, measure the impact and then discard it before going
>> to userspace.
>
> I'm not too fond of the idea in general, but I could be convinced
> otherwise. I'm interested to learn what others think.
>
Lets start the discussion on V3 and see how that goes.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
