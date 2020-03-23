Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89547C4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:45:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A63620409
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tb9p8wvx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="s1UlbPKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A63620409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VNRHOf71/kosL+k9vX15mtj4QflTjWSHnia/IXud104=; b=Tb9p8wvxb+tHrb
	5T7J9+wAnzFBsUDn7Ko7xgTc/DBi55PoWFjWrj6u0TBx2zgZOqFUR53SuNSjLr3sT3wlcz2ocgfcb
	tYy0WeoI63RRzo4cP2VC0kM/8/r2UGM+W85DICnbN71sPzG3KD7PuO+5F1uRFzGia2pcbe71czD/E
	pp5Q9gPbmAdyo/rPL/gYmtOWLeu7eqSV4AVozcnEUlvhrzTRcqe78G4d23+12QZZhya6OMsgxhyxr
	CnOh80kPoczNBhJjBmgKNwi9htcO6zeLRlw7VMs22o7vz9ssTZso+D4pNBEwqZBWZZV1Rzst+JSOW
	LzPGfLjPVrmI83nkN6cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGWlN-0003Tu-2H; Mon, 23 Mar 2020 23:45:45 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGWlJ-0003Su-JK
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 23:45:43 +0000
IronPort-SDR: x2THXNCunJZCkN3BYvYRqDK1wa3cehdhHppF51LQIwKRveqANXaD/mECOBV/IA8eW/keMjVRZN
 9e2duaF44AjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 16:45:40 -0700
IronPort-SDR: kXbwr9r4CQbjnENeUDH2Fl6Qw6m8oseBxLJQ/ZGEvbiIriAvvtPpwVCD0GVmA8ax3MvcJSFZ2z
 5S9MIAQuo15g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; d="scan'208";a="447670338"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2020 16:45:40 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 16:45:40 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX160.amr.corp.intel.com (10.22.226.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 16:45:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 16:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnSqcJqzmCX6KRE/xF+pZisOvqOFHXo26eFDriguzadVgXFz1tlQMP25UCX8VfhDuuK/ae3+v4l5yyWCN1JZeeffPODU6jrsKT4juhNnqmsUBr1zLbxKa65VVesAxr6jcdpT8bX5/fMs3F7DPyQAaSYaOzfx8NfCBaiDHguJEz82rTmDd+J1H5+fGQOprQpOaXM0XTWkDCW1jARihPWl9veNPXNu5QjI7gOtYRzJo1z/DsAdFqA9e58DH5DSeOjD/Pl0ZwCeYOky7/q5fX30CWkr7LFlO62cvh24gOg/vND2lj6H8bIWZrR5XOYbj9+ClAlD3api/pm24/4lLat+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxYe0vi+ojH5hhPDaHBw9lm+nDPK8WKr2KnAYikDU1k=;
 b=R5MdkMFP3sVwGQtttcr6hYrBSc/GB1aLjxte7nZBkM9Ysenr2D6DLGRW2S+r3WQdNQ5ExDSf0e3FuTC6D3QPhVRPavRXMwVDwA7R14l+tPoNwiztMAp/XVkB6Vf/vYeTPi4w0W+fDQOsFDxMK7KNukTL+1fnPlV8pkLwHau+MiEJ6tfpOT0SdHSkvTYlaaBgajKDfwdROOdnuxjXOeiAK1LVbTmGuKLK3d6FTD84ai08ri5QPaDuKryCvuvLf/Mo2UJ77Fyo+l04zMiD6WyPdSqejjt4/XRY57tKZZ7n3dCYBM5uCWEAIt3Q5RHWJfy732RCxl/EAlZ9/uLwWrlbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxYe0vi+ojH5hhPDaHBw9lm+nDPK8WKr2KnAYikDU1k=;
 b=s1UlbPKYZx7bodGWLxgL3XtsoYBfCn2Z9PMkKQWmEeFXnpHwH7JQy9IOyTfJSSyA6kK4oDC0broVPyqR6JI0W93lPkPwPwAsqgoDBfJefMbbSOIB4H9u/Ssdz0RW+Hr+s/3MFCRYL4E0OmLFkEI9Q2dDnUqgoQ0/etrhg/K2VsI=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4601.namprd11.prod.outlook.com (2603:10b6:303:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 23:45:38 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 23:45:38 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Topic: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Index: AdX9ef3PKRC8AConRsKyiM0hXsW0JAAEXlsAAPLBmRAAAElOAAAAPf0AAAFDntAAAIcLAAACE72gAACxaIAAAG+RgA==
Date: Mon, 23 Mar 2020 23:45:38 +0000
Message-ID: <MW3PR11MB46845357C4C1651D1C24CEBBE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
 <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
 <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
 <MW3PR11MB4684FD29002D6D1FE29A4A0FE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <2f68591c-d2f1-f632-644c-11de97511a45@grimberg.me>
In-Reply-To: <2f68591c-d2f1-f632-644c-11de97511a45@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41662b3-acbc-4936-31d6-08d7cf844a4d
x-ms-traffictypediagnostic: MW3PR11MB4601:
x-microsoft-antispam-prvs: <MW3PR11MB4601230F92AB7786CBFEFB34E5F00@MW3PR11MB4601.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(5660300002)(66446008)(186003)(86362001)(8936002)(55016002)(33656002)(110136005)(9686003)(71200400001)(316002)(2906002)(81166006)(66476007)(8676002)(66946007)(64756008)(76116006)(66556008)(4326008)(7696005)(52536014)(81156014)(4744005)(6506007)(26005)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR11MB4601;
 H:MW3PR11MB4684.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lJ4D1zX4QnJsaQGK9v6zzSv7K2jgED9NO7feY/UFEvJJ6WLMHYoim49cyh8ROfkxmNFeMzeR1IceHi7ymmgCl0D6pcW02kmpsXvgG7W/425Cpy4xu+T6AaBPA0oSWyehKvaxvKWV5pepES3eyrHvcJr0w34xZEWWI26mnchhkXGQ1CGnIkbwwb47Wadv/+FPHPO7tBgPyzeHqilZmv8QDby6FRLzWysdIV/Bo5+yYYIZ2uqy9lG3qwamahHlL8advRrhIbNpmbe/jwY3rBvqqrnU8IeXW5pLxnkJpXuHzVJoyjQd1Re+q0ZBt8M0bDT6DMlv1gf8CfhWVSM0zxca0LZwDtOSC7tu19krGpPI/51F3tn8rTobJl1Pr/t3sZ2GaAl+5wseDXU5E8HVefqy7nyIEdMXPaETWkZ9E/w0u3UFnMCS5esxx2d9PrZAKSI
x-ms-exchange-antispam-messagedata: ni2+2eHXTiOa9cZL7muQPRCb8PEZ678pSL8HCX9cp/ZPr/l9AXB7cW/vrSnqZbdjB+q4ocHQ7l/P/2LM2DXsIf0+Wfk/LS1twIK/JOeXMKij8p97TDCm94H8nHbAg6ecBlVWwWIcHpomWKGYnEbifg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d41662b3-acbc-4936-31d6-08d7cf844a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 23:45:38.4474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghvrN0qWEgfI+wSHUCSz0FlVIs0NQjYKN15wdqtIDU20JVHNZMTN9tAaayxufriRkGjnS+Bm4LP4tXV7Z9eNuQY8CgsVrXMq9l2+zzK31SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4601
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_164541_657006_D28337BB 
X-CRM114-Status: GOOD (  10.11  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>> 
>> OK, this is a needed fix then.
>> 
>> Yes, so far this removed the kernel fault seen for large write (512k) + queue depth 32 + batch size 8.
>> 
>>> Yes, this is with nvme-5.7 tree right? which is currently based of
>>> 5.6.0-rc4 correct?
>> 
>> No, was not yet able to get branch 5.7 to build with our driver.  For now am running on branch nvme-5.6-rc6, the other branch mentioned by Jens to try.  This appears to be based on 5.6.0-rc3 I believe.  Will re-test on 5.7 once I can get it ready.

>OK, but this is with nvme-5.6-rc6 as is right? no add-ons correct?

Since the patch you indicated for me to try show use of the POLLING flag I went ahead and added that patch on the baseline nvme-5.6-rc6 branch before making the small suggested patch to nvme_tcp_poll that checks LIVE state.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
