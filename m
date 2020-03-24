Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D375C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 16:31:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3976D2076F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oXfu1iO2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="fd6K7YgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976D2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U57/hNYi5lDioslkQZ63dzCoBXBz5cUpxDcX0jHdLWk=; b=oXfu1iO2nl1k+S
	ZPoe5Oe6cmaIX68vEdhO9dA9s8RrZjwGelSigFYs+AhssVh2oXigm1QkwdIc1aFYbkcCgpsZVA2vr
	tT2qOG8P/Pp/cl2y2Vnh3/xzVBNCKTao0VwgNvP7hXt15S9i0wxXwUpsuw9AA7Q4B5FTZDqj5XfLh
	HyayxGJxruqxHWCGrK9obwNCRQ30BrPc+li26+UxkkSO/qynUxqOuC4iQeVv7R3+/QWzH8IEyF0WK
	OaqiecaMuR8dc0oaDAxB97OBIvg10nQ41ttYU7bA6VTGlMi1HsONkQUFNVwIfff5T7BmQyAFUY0ee
	il67HqimCqGmdxOPNBIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGmSu-0000q9-3k; Tue, 24 Mar 2020 16:31:44 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGmSr-0000pp-Rm
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 16:31:43 +0000
IronPort-SDR: SAUi6L83pgBce6GeHR6Zts3O15PTARaiYeGuk/WvcQC5LWc/SvgmiuK5oAQ7owcjg9CkZ9YSLE
 2QdcNWGFTFQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 09:31:40 -0700
IronPort-SDR: WjKIhkXLlzeE9t3pJXne2fcAFMCu9+Va+XyaozPwfHzdvlPQQAwoXrJoRuDVIbOYVE5ZFEok1O
 XLI/ZgxHeNfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,301,1580803200"; d="scan'208";a="293102601"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by FMSMGA003.fm.intel.com with ESMTP; 24 Mar 2020 09:31:40 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 09:31:39 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX124.amr.corp.intel.com (10.22.240.120) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 09:31:39 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 24 Mar 2020 09:31:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7yA+RUE3utjpXO2NVXJ7Ejt5CUIlEIkB5sl6G3lkgrqfj3yFo0brkujlO3MX29WYV6aWqyLvUac6FZBTzyKZlTiAAbZkFAVgdRFsaC+eDJr9bPa+Ftk0FgZpmPQtvUjsOILujr+FES9IKpY+v0yP2uPDlH05h1Klxy9BZvlvmUctcK+Z6JXNsRUR+1FGoG2m1IMVFfPaVw6tzw6XoFlZL14mH1B2C1U02PhmFCQS+o/y24bCj8ePZFaoWut+dGxZMHKdpJG1OdFCgF25PCmG+ZtOsniigGBTJkzJXtpH8MA9StjKHjp3WgjdwBKcLhbF1Hw49MD3M8msXCtvFJtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vTq5juD7vT48b30R6m3NMM5ESuYgcOYy00b1sCURhM=;
 b=MoRVyZfcJplOH+RIGZajjo7p61dBXkJ0SKHTnbuTVSs+6aP+36dGknVazPbhS6ChfD9B4fwDphyLWlrNqDrGNZWKcTWWpUAC+gD9MUlAO9TR34Dx+TtyJMn0uCLTwVrMPO8re5qx78rnLP4wY19uQZX9DjBYP5cl7FPoFy19hZylGiNR633tHWvqStb3EfeQ0IGkGxxr9/IUEaZVTN7f+g7X97A5E3jkeXsrUPmKcZuTx1chZRiwdVoJozBjTp+iQKRWhcm9xfhhrgdDDwccXPz8xSukQ319ep72svE/JbBtzDFTY2S2H4KUGzjNbmhyuA2zEEZRCM4fk0FGaWHhHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vTq5juD7vT48b30R6m3NMM5ESuYgcOYy00b1sCURhM=;
 b=fd6K7YgRdOYj/nmJkusZ9qNiJu1tgrPvhLM4hkKbASfiuu5+QP2D/kjA8noUcqj4IQp5kMiYcyLQp324pkBQYWFVIwV9Y2qPTBwWmA/DW4XWUqD0gPjcQ0iQ6otweKAtfGxhGnbOZuNlGfplpwwkjhWalqh6wJ7N55AVc0un3V0=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 16:31:38 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 16:31:38 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Topic: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Index: AdX9ef3PKRC8AConRsKyiM0hXsW0JAAEXlsAAPLBmRAAAElOAAAAPf0AAAFDntAAAIcLAAACE72gAACxaIAAAG+RgAAAPZaAAAE4BhAAAkwoAAAfVfVw
Date: Tue, 24 Mar 2020 16:31:38 +0000
Message-ID: <MW3PR11MB46848AC6E0AB0B10A2792704E5F10@MW3PR11MB4684.namprd11.prod.outlook.com>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
 <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
 <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
 <MW3PR11MB4684FD29002D6D1FE29A4A0FE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <2f68591c-d2f1-f632-644c-11de97511a45@grimberg.me>
 <MW3PR11MB46845357C4C1651D1C24CEBBE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <112775b2-ef19-7e8c-630c-22bc529536cf@grimberg.me>
 <MW3PR11MB4684610CA3A664EA62EE7780E5F10@MW3PR11MB4684.namprd11.prod.outlook.com>
 <e9a4b2c7-5dec-296d-be6c-880afa8869c3@grimberg.me>
In-Reply-To: <e9a4b2c7-5dec-296d-be6c-880afa8869c3@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8b76409-d534-40b6-d2dc-08d7d010d39c
x-ms-traffictypediagnostic: MW3PR11MB4729:
x-microsoft-antispam-prvs: <MW3PR11MB47295588E8EF6C07C59E07A7E5F10@MW3PR11MB4729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(376002)(39860400002)(136003)(186003)(9686003)(55016002)(81166006)(8936002)(81156014)(4326008)(26005)(478600001)(6506007)(71200400001)(316002)(110136005)(33656002)(7696005)(2906002)(86362001)(52536014)(4744005)(5660300002)(8676002)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR11MB4729;
 H:MW3PR11MB4684.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 10d15VfwL2FOpG9+E58ZKkbMQqvej6P2sP2O+BhDWw8oph8hXNaZdUoP8635E3ZrIu46VP0082TbVPYz85xldQiy1kZ/+SX1tB4d6pyHDuwcV0CLlaHgByaMTCOugncC3zQf3ZB9+6KwZt0A6Tr+uKALGA8fbUgb/PXPnQp1JaRDBCF2lWoIE+srwoEM4iAqSP5gQXMP/EdTSfcF75Sut1BhsuD/53X/3rz8aEa3Ae5Iliud0rN/NIbErD4kR4P9SjXSVGr/9Vu6b81fTQlmoYaYtDY1Bp4fe0EqNpkGkCTIJUxkFm8ioAJXQtx6ubwfwVNRgXdsNhrI7JqVMy+9tlOme+Jd00avabeJ02utufB9NXDUhjnzcLdHeDzC6nyo1HojYvo21C3wNARZyGa8BevZtfW/k+sH+Rc+Iw9P6y7q7LOEkAHVRz40EQFtI6he
x-ms-exchange-antispam-messagedata: kVofwDNXi7sDFc5CqiJGuwV22fjB0owu259T5o+3Ocg0icrw8j2oNO3DcaS+DB0T4aFazeG6VXafA7gqqPHGRRMp/CfiF9O6/vr5M2kHh/G91nWDsX6KXUdlIq3S399cR87isjnpf6dDgyK4vR8mtQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b76409-d534-40b6-d2dc-08d7d010d39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 16:31:38.3533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YanV73C0BDD9JpIQONxxkUrbaOlPbthtLhXawovVWWsVGteG8Ls/yfLSCcD3j9fayA+qZk1lQIdAGPKUGcNVCkSLUAm0Kma/iwtnqHAJFx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_093141_986065_F9008B97 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
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


>>> Does the I/O timeout only happens when you run polling mode (hipri)? Or does it happen for non-polling I/O as well?
>> 
>> So far have not seen a failure with io_uring (not setting hipri) or using libaio for same I/O pattern.  Only when hipri is set have I been able to reproduce the recovery failure.
>
>This also reproduces without the POLLING patch correct?

Yes, I reproduced the original reported failure on the baseline nvme-5.6-rc6 branch with no other patches applied, running in polling mode using FIO 'hipri' option to io_uring engine.  Also could not re-create failure, as indicated just above, for libaio or io_uring NOT using 'hipri' option.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
