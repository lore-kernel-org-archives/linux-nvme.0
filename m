Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3500C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 10:01:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D466139E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 10:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D466139E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fm+j8qa3DOZnXoTEk9hQKKZJH8I3661iFntIVSvYJA8=; b=laBEj2jyNWVEWgCXiOdkLJbSF
	YIaxwl/XUq5r/YTvprsVjCAPnQu81Rq7ICXyL0TJF+Rs0wOZXqQy3yfficaBAEkEhG4KYkHFPiwcN
	dU68KZ6rM/ldsc7xi6mhnh7ful3uSW5jhxX872xuYhBbq67PnM8jUe97ZsJM+CWECeG/lXkGggZOB
	OYf0TTI2w+wD3y+cTLWwNs5I/H7PNGsZnqcsq3XdB4IE8yCKsWFMEZSjGE+affI163hWvdKSD/h1j
	HF//YNoC/M+y+kHOoTLWyK4bNeg3fheAK/McnruxsJ6w9bqSEpWdV1GBpoqhDpccPVTVeZvHiZLd5
	G9/9fs+Ig==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU4zd-004fuw-5G; Wed, 07 Apr 2021 10:01:01 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU4zR-004frh-Am
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 10:00:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617789649; x=1649325649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1doiGQgK+468qDXj76sbDoQPHSDg/SqDyNJLf6pKtT8=;
 b=dmi+WhIjs3aXswESJ8k8d7p04JN4ChAUyS+c6It6u+yS2S421MNaya/h
 tomq62GUf2zGVFQ/Nvz5pafD+tN1bRCM/5Z9HaXayp7jpYxbEsN6cdRlB
 Vt2w54P+KzHBLcCiyWjAU89XvqD12XWg+eDGjykp2Eucn6iun4P80zuaw
 mSdwV89fjnSwC3ILlPYmZZRNahPP3k3Rqe7BkdNOBpJshJuFr3b0exIsV
 kBgzSPSNThq04IVrJRu1DAd3rx5EjwHuToz4NufPlLJ54yMza3+IrWWcJ
 /0IItmAQ8S+OODl4S6g4zIoTea4q9xwd2RIYiq6MPZEM/yUx6YGhwZ74f Q==;
IronPort-SDR: +TMXVDtLsblVrbxYmjtAaK6MqwPzNvmZuzaUllrkJb4dTQ+/eSvBO5MmWqeEqHFyYNp/+gkqWm
 WmrEz7DHizan3OHYEPAh/N/lllbbtQyApE4euXifmydvHOiEOEIbqrWe4KylFwIj/B1zyIvu3q
 AjiUzXBQ1GDx6rQdxAbk5zAOAhq2Btzv1CjwTP3c2eM1hhSsGBLKXKp37XrXhwKZLafWRZMhYe
 J+rcRaxQu9Yu4NCcJqwa8h5Aqz+mflkbWiYXAIh0OWna3Jw6oIb4S7ePS8GjPw4XDYLvOZJYpi
 P7c=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; d="scan'208";a="168544324"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 18:00:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikai8jzbL0EYt7VwT7KAn3coAvUS5YO4kpH4QbNKr/E/YUGJthfykojV2vV8a4j6lWN3jBeusZsuY5bWXb7GFr3/6qxs5Q6td3HZOTLN5WGhXpXAi78ZqtL8iiUnAD3EV/qbsDKIEg7GnhpR52OapGBHfw0UTgwgoW1aaOB5K6GG5EoKTSRVudEAkuAQllz44BC1ku7MKqtKq/uXQ7gldPMlXuwmGsY0oV7wKiDtbAnDpPsE00eiDUh1+diADioKOx3dITIMUy/OqAVS2HmRrWrdBjRvxlXd7r7HejNEENqWVjUygg3nVL1WTZTeEijmRyQ/bHiVcpnGi5ItVwBs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1doiGQgK+468qDXj76sbDoQPHSDg/SqDyNJLf6pKtT8=;
 b=WsmdD+aiWgIJDiOZVS7heBPcxd55GxtG9UbZ+6xTjL+6w1Pp9wL+g9PDKJ012SkuQfLQmZZ8US4v+gi/EjzewHyJAUddCyKl5AjIzcqeHbZloaoVc33+ZOckoGBB0PGVcb0/NKzJ/svywij5xaNYoH7M2xIgTq/qWCHVvnq9dHM5pKKAVRLQbXp6xnZt4r6GOTsrz+mcMaUVOeKjSRUxjfX/4/aQ/rqyIpeNUG0/SiCCn/U+3EoXI2706aJWIgoYFKPcyLoiPXZnau/3gFjrLRKn6Fj+Bdk6vaSU/runrm7PW+priYHG8viH3IEo2CwGBJw1KC8c/Ju/WaqqbHYiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1doiGQgK+468qDXj76sbDoQPHSDg/SqDyNJLf6pKtT8=;
 b=xB+f09hbSA9aZgIAhUj8HEUU7dPatZN+LQhZsz2se5qy94PKvNTEJCkf/E2XdOaka/HJ3cgx0idcbq2y+XddZMEk7wzk0qEyX0FOJVOpXZjG8FoA7JVKUHhZqN57ffR1yz9Ti77gbJzcW1bSwaN9KFm0FntcoCeCoQO0yalqgYs=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6380.namprd04.prod.outlook.com (2603:10b6:5:1e3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Wed, 7 Apr 2021 10:00:43 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.016; Wed, 7 Apr 2021
 10:00:43 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi
 <joshiiitr@gmail.com>, =?iso-8859-1?Q?Javier_Gonz=E1lez?=
 <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Thread-Topic: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Thread-Index: AQHXKsN1pjvW+Y7eAUiYEfo71YOF9aqnfeiAgAAXigCAARZvgIAAImCAgAAF9QA=
Date: Wed, 7 Apr 2021 10:00:43 +0000
Message-ID: <YG2CyoOWSTFPOi0c@x1-carbon.lan>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan> <20210406133533.GC2594@localhost>
 <20210406145948.GB7790@lst.de> <YG1g9bMYRjS3uCXs@x1-carbon.lan>
 <20210407093923.GA31210@lst.de>
In-Reply-To: <20210407093923.GA31210@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fb8dad4-49c7-4edf-9115-08d8f9ac01fb
x-ms-traffictypediagnostic: DM6PR04MB6380:
x-microsoft-antispam-prvs: <DM6PR04MB6380A484567BF52FB8214E81F2759@DM6PR04MB6380.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHGZ2OrK9JAARytWI5w8gsBaZ9Wb3MTRlkWAXXRVdJFXElxWi77liQUGCLwcMb/mDCl83oopWPAtygxGuNgIIHTTCWgrmt5h48AWQ4go+STrOBk/X/4vv+FWomHVyxYMC2Q2PDyDoQ9tR99KRY13lgSLlriGytVLz2R+1DLRo1BmSR0AEgCArSQ1QmSI2XbfMXg26Q3YirQhwuJaHgscQ/s5TS5G1gM5piKerCY1KawYKGuaAKSHmQMdLW+j04KSo3y5ZE0W/n5moVnLAD2BJQ6Wmt4a1+hKcmYaQvMoNZcNb2HHA7mw2gmbmF3cnJezEPv5+3SPdOYQYamdQvQ0YdFvHtsgag0TWDymK4o/FvDDkbz6yfhzVCFfJ80KibJO41BE7TVQttnHOdGbFVdYPGmo0TZ6G9V9YvKJLqwNs/Iua2AssOqzpW6+j09up9rlRydQ2hFecdAvSSakPHMYRD9Bt3WddHHsk2gm6u9YqC1gwzO+Wm7jTN2EHTj4ZAVLskxwT/RVWT0pb8JM1DJOhmHqrtAAqOIVeulpyeQwQ7TXejnaL4TlHD1ySnvd+O2grJEfH+iVez+kWWqqYdtkeTRSegOCA3sfmay6/snasrCur92APmhYvDux0YmUlEZcMGx7bvQVOUKLRN2wXHI1Oc8a5EK0em8sPrsjRCSlVTZvOx/snodLR8oxWrdts6Kb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(5660300002)(91956017)(38100700001)(66556008)(66476007)(64756008)(6916009)(8676002)(6486002)(66946007)(316002)(76116006)(66446008)(54906003)(478600001)(8936002)(4326008)(2906002)(36756003)(86362001)(9686003)(6512007)(71200400001)(83380400001)(6506007)(186003)(26005)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?jFF68M1S/IV3FMlFF2IMx14vWWC5KUZXnQEu2ahO6GlxkYFxwAxJSWj3EJ?=
 =?iso-8859-1?Q?PEwuLr6kbQ7HlkBJhdW8ciDGeKzdf5J6PRncREeePIMVk1b6JqFmUDdoif?=
 =?iso-8859-1?Q?fWvljZMH36GgLL4huoYl1wXEaIep5T1d655tnxPgE4vf+GzVznSFqpMQRV?=
 =?iso-8859-1?Q?fa+49VXw52dY9wJgEewTPpneTy0m+P5gsPs2Ixvn0pO8JrcvrNGvPMD2vF?=
 =?iso-8859-1?Q?NMGSKIXRjFN+YrsSCLlUDqRXQZM2kBOTH1lWhvPvM89BWlVlR5Q1CEMURb?=
 =?iso-8859-1?Q?yKX74HfJo9RW9qQhP2RUqwf8xDf4AcsQgPAGEbXWY+Xbl//4YK5YtXCaZb?=
 =?iso-8859-1?Q?TNf9rLpRZ92zQPq+Q9/B9MZAC6zIFescJXZ3HAaSLB3/RhRsITX6b9hC8N?=
 =?iso-8859-1?Q?hAwSh5Pra0auWfsbuE7H4dPbcFrlzxlSIxRq/bpbcizRNCmavpdg2Dv0ss?=
 =?iso-8859-1?Q?x2uT0MUt0elKjl1FAloOb+3uYSA+4BTTL1QvRYvP4VhaXd4I/JkukwfUXs?=
 =?iso-8859-1?Q?YVVrpY9BxKK5Ack/BfubGdHRdzLBtF+cv4e9pj5bA/axw1oKfzYToc4qWo?=
 =?iso-8859-1?Q?OLpNkLX/esc/KIWS9hbGuDQgJBNjIjLSx9y74zIkfzi23uc+QwFkSFHyC8?=
 =?iso-8859-1?Q?+XCcWo2nevanFxizHJh13IVy9dQ0ivVtHazx6FoqjMM2RUtmMYhjAgA6aQ?=
 =?iso-8859-1?Q?LCgAhWAz7Az4LKH2oriSDqgO/V63wSX7Pp32hjtYtkhl7TtQBAMZbD2mqn?=
 =?iso-8859-1?Q?9/aWWshS9bZduhb6yG+jyt2Nf6+yn2ayFHP3VLBoSNrCMN9R/50j676jfe?=
 =?iso-8859-1?Q?wsqrPil6A2OkTw/TdVM29KN61R96eCxgaNfWnRBUhHystHmgfFHVJLK2wI?=
 =?iso-8859-1?Q?f57bP08iEqB4l1BoHdHSoSnTN3NLrt/X2JA0NA+xRaUYk52cx6RSqFUtw9?=
 =?iso-8859-1?Q?ojy06fS2ExG7bQT4ldTdZ0yrfiCg/YUlHZ0v3d4gbEaX+lP0xHHcmc+9rU?=
 =?iso-8859-1?Q?yRegDKLYD6goLRUIk/DOrE0SPL0C0CCL0HJQv437iWG5OAvvD/YRM3vOTt?=
 =?iso-8859-1?Q?P8Bs53iC8H0ORxt2hPua8twHPgW7V6Na+WNa1dn4ZYCPFy/8rwjpuUnEUg?=
 =?iso-8859-1?Q?PnbCkJnJd5vtFWyO2gmXFK9rMuDTwJqtsDYFsszkYDvqDJah9dPWNBAgD4?=
 =?iso-8859-1?Q?64jiAmBfMndWN7o+5xaDAG79PHoT0aKgch0eOVuo66MTK45h20BfjENfsr?=
 =?iso-8859-1?Q?ri4qBPySwzp/qsPiWF+APpqFOQC+OsetTpNgRgvpdNUyFOCnBpq+5Tv8VS?=
 =?iso-8859-1?Q?WnnSIKjfXJIZqyXGKnNfDozhpHRm3870gh6xDMgHhxJ5JuHO7ZGZNFNsQ/?=
 =?iso-8859-1?Q?HfGmwy/AlH?=
x-ms-exchange-transport-forked: True
Content-ID: <A9DD7E4415918949B6B1845975CE6CFA@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb8dad4-49c7-4edf-9115-08d8f9ac01fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 10:00:43.4470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WtE4ShdL8C/WLmZI5k9Hdd0tRrPDcVCy9NQkiLm96F5yfikRfG6PvHfheujeulCA1nWoppvaWx06CIHULoopw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6380
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_110049_969778_0E0F355A 
X-CRM114-Status: GOOD (  21.29  )
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

On Wed, Apr 07, 2021 at 11:39:23AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 07, 2021 at 07:36:22AM +0000, Niklas Cassel wrote:
> > The SCSI generic devices are named /dev/sgX while the SCSI block devices
> > are named /dev/sd*, so the names are more distinct compared to /dev/nvme*
> > and /dev/nvme-generic-*.
> > 
> > A "regular" Linux user who writes /dev/sd<tab> will not see the SCSI
> > generic devices, but with the current proposal, if he writes
> > /dev/nvme<tab>, he will see the NVMe generic devices.
> > 
> > I just had a gut feeling that this could cause confusion in the future.
> > However, I trust your experience and judgement more than my gut feeling.
> 
> Should we call the nodes /dev/ng* ?

Man... naming things is the hardest thing about software development ;)

It would solve the problem of them being too similarly named.
And if we document this somewhere, it makes sense that SCSI generic
is /dev/sg and NVMe generic is /dev/ng...

The only "bad" thing is that we take up a very generic (pun intended)
name in the /dev/ namespace. The acronym might conflict with something
else in the future. But trying to predict the future seems silly,
so I can't come up with any argument against your naming proposal :)


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
