Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D566DC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 00:35:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9463A64E33
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 00:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9463A64E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X3htM7aOyS0ntUF14lGZNQzG+qZnikmXZFwzxa+/vfs=; b=fC+fxjL4Fy1wVc0lZsDJKmaOf9
	1Ya/ab19/zF/xstboVNd/vMFLbXUgtAsAojxlnNspoNjwucGtzzT1dLBd2BfSwnmPWo8Tx0hGoCC8
	W2j/O5p1i1T/go7Uzl9MRxqXrb0U8wM3WmG0f8idhyMylFT5K8TlOkpuw0Rnv/EK3fM1XzAfSACz+
	hOtFVWovZ2CO9b4/+rv9HU3UU1kerH8IXJtBTVCLD5rwoyZPMuu2HaW79+nf5Pj+L6ByzUX4hYt10
	i/vfWhtdshLBbhL1QQrqcufAdGg8gAVu9p31f1r5dTYomIB7+I/NRXR4FGtshcdt4khvOZk29wlpB
	ZmEqrVnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCtlN-0006Tb-2A; Fri, 19 Feb 2021 00:35:17 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCtlG-0006TE-4H
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 00:35:11 +0000
IronPort-SDR: IqFU/cILTXESVEG7Nyu1uQga2nYPo4hjxwmqpjg00VyW+MwiRBgQ00ertUUEVIqwRay7I1cvOC
 ktSYHT1GsGew==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="183755055"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="183755055"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 16:34:55 -0800
IronPort-SDR: t4ZStTqR5XrbCRrv1oz3l1MyjQ9Rg/og4zZDD+2RNikwabUMxFiWMUAeyEgqaCM0Cx/KyDvMfY
 Yt1KaHqTnN+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="590438532"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga006.fm.intel.com with ESMTP; 18 Feb 2021 16:34:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 16:34:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 18 Feb 2021 16:34:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 18 Feb 2021 16:34:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfjuIAIB+fGmf7xtaX0m4tkckx/KXfy65NHsnJmVkwxjQ7qVCAkzk6trKWzWqF4l24jaAKebVbHDMUEq194r0qCzYTdQRb/Z46kDUwV+BottoCM4HSTlmn5JSK8aQKDbI15lMZ+T69lycrSMJ4iryUmGjPiaNPb6Esq8U+HeyE+MEVtUW9UdNhDsNzgkohzqkSUYtoa4Ag1AxDOuSG+v/79c15oKxKimJ391FZUhSikUqI6hORLjVzLq57q1bnh78FJpzfYzBeufdNnIq/TU5NLsO3dRVf9YW/KFqYFMMzTs0xfnhRKYPg7atjB/yc/40cb3PZODgILnjHB8m4eQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnJDbcLErObzWS3oUCqUw1d1kNnoSyb75fTorl63ozs=;
 b=SOR0c60td+TAE0GIXMGF8SDcSNBTcLCYbUgECje8CjwnpFTIdUxOhx1aUgIrXF9bSlO17sjt8JNKbJ7+vL42na8MVSDmHmd9UE+vMeV1hJAh/wRP69bHuD0CYZRtjaTnLj2HRjB7QPJqYSYLuvhaIb16OlWhb/EHmljaZ924210y3RYt+R1Z6DWJggXSEzVxyes1Ez9TFCxsLnGWt/s4VUbs9O+z4+tAVHGOZu7etsGTCp3YJoC8HT/R0uuuyEB1otGzUoXEVzedl/lAssjdV1JUdn91noLr22ySoCRGwkfWg49uBA3UXKCMK4QKUy9JiemeMcANZVX7P0ukjfWcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnJDbcLErObzWS3oUCqUw1d1kNnoSyb75fTorl63ozs=;
 b=t1g/+VtjHh4l39fAoVZY1VdxDLzSOAa/Oxb9Ljqqg2KGBnpMbLtL2oH6w4kaX4TqrJSD9gzCO8Yjih8VhnhLDuWyh8VyksyVmXcq2zvTXk4BgjgI5J351Ha+dWZUtjPfP+RqhsFBkdng4s1XTVhXVqZgPL1JnYVGuxHolh063To=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 00:34:54 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::ec7d:c69c:7718:9e82]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::ec7d:c69c:7718:9e82%7]) with mapi id 15.20.3846.035; Fri, 19 Feb 2021
 00:34:54 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet-tcp: enable optional queue idle period tracking
Thread-Topic: [PATCH] nvmet-tcp: enable optional queue idle period tracking
Thread-Index: AdcAzwvEySZF244WSSimWeKKHvq25QDEQgCAAI1KICAAD/NLYA==
Date: Fri, 19 Feb 2021 00:34:54 +0000
Message-ID: <BYAPR11MB2869868FD753ACACDF0916CCE5849@BYAPR11MB2869.namprd11.prod.outlook.com>
References: <BYAPR11MB286909CAA3A8721B46A02AFFE58C9@BYAPR11MB2869.namprd11.prod.outlook.com>
 <25dfb6d2-2519-0f30-529f-36dcb4263160@grimberg.me>
 <BYAPR11MB28691FA273E729AF338745B7E5859@BYAPR11MB2869.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB28691FA273E729AF338745B7E5859@BYAPR11MB2869.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=intel.com;
x-originating-ip: [67.171.162.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7801edc6-7b38-4b65-cc48-08d8d46e2d57
x-ms-traffictypediagnostic: SJ0PR11MB4831:
x-microsoft-antispam-prvs: <SJ0PR11MB48319F71D1AF9329377F2562E5849@SJ0PR11MB4831.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYSRC4ORwRiIAkdCY7Ls1OroxDObQSuHMwfPXuQEiWfO9fS131iyhepJU4oZaSMBoESxjg5I8it73muERyZ9Sow45FdcrYBwuIWl3tCnM0m4M6GypsV1aVlf/oItehRit4xdO5gNy3nDxhGuAQJfp/qgM12/qa24gqHJNaZjGCAMOk4BIL92CK1Il8PZRD3DJ2nwr1zonxFxJ94V8ELu5rM+pU9KL/sTKUJ98OxxLDSILmO3Z7tuO7GIXOslsxgOystn+OQ8QntdjjReSuMwiOGaq9T9mCt0WREzcOlpmZ6PWPO4f8GPKhC2gK25n/Es2QCBdkhUUXCe2t23mPIfDmEs5JRVV7rwwZqUTgrV1nmS2yzdLN2Hq+S2F5iJmLL+xS+ihnpSIeBJLTDdbl0ykGs39cfJ1xanFuESDjxxm4GNXJCOKwLoXcCQB9RxdVKYwQPdHHL+z7bG9INwgrXgeOidDJIfouiH97783mBPDs4YAswEn+uwb0g6Lr12PcNIMg6NZorHZOrPebsCAGmYng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(39860400002)(376002)(396003)(366004)(8936002)(52536014)(110136005)(6506007)(86362001)(26005)(7696005)(55016002)(186003)(478600001)(5660300002)(71200400001)(66556008)(66446008)(2906002)(64756008)(33656002)(9686003)(66476007)(316002)(8676002)(66946007)(83380400001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UcaWczw0GgTKrvSX5zcaiR2OI2YSdWJVaEirDVhS0dbN0664vs5e+I8FLjaE?=
 =?us-ascii?Q?f3ZD41WT9bRdNHBGzzN/XkvjmC9RKubxOe50bPSFj/FqBv1Zb7XR3CAoYoSH?=
 =?us-ascii?Q?C2UBPFd+1k33co1t+cEQSa/LpXwE/fw1MZboqt1yWXEaYAPyhDdbVwpjzuIf?=
 =?us-ascii?Q?HGYkFFGCG/bkEtaGNCNMK5PxHenoqgsmJ55J/MDBpahzT72b62zKcKHTrtU9?=
 =?us-ascii?Q?4Rhdcwd8J68TH7Kdibmaaej8UDo1zHOwvBtUUF6ISxP8Rh7+OLhLDySE00T0?=
 =?us-ascii?Q?vRk8qPwgbjqUfVBIh1jq8n1Xb+Oi2nZmEF+zv9yEhr0BoagQF1eousZ1pbas?=
 =?us-ascii?Q?R9jVlhCdgyupJLJiAhPSMKsi1WKt84dhiy4aEK+rCVBMn/7A88I3hJxEQRlG?=
 =?us-ascii?Q?FwUNB7eNvA1vg58sBi/1sxwl4Oe6iq/N3LLuc8CzJif3BhfEikTycUnclJ9x?=
 =?us-ascii?Q?aVA4syOtRy6xz5/Tx/LXs0GtjjE+4l6fG6lL2NvwPUk41OZqbnf5z+6J0wW6?=
 =?us-ascii?Q?6wpL1Xs2D56SD6dj16xLe2W7X6VHHp9PDew0qlyxLbhAFIG5URJP/r+LIaVl?=
 =?us-ascii?Q?/D61ut0KyFPk288PTT2hvjmc7T5jAGmHtAz5bXNt5PIG0fKcj4AcmyYaALYR?=
 =?us-ascii?Q?OcVEJhhHcbQC0ymOmo/EE5yqp8svCrzdh2WId1OKggEsKaIW4pCOQkv6RyfE?=
 =?us-ascii?Q?5Kvxaat5p/H3UgSSG4B5g9P0BYALQwGXC7Y9ryK1WGqX9Nw3C4aRmnBe/OiG?=
 =?us-ascii?Q?D2RHFZnSV4whz+0TJAb4MExBXqoyYSbhm2yc6NFM9mGaItiZ7rw35K84vMBr?=
 =?us-ascii?Q?0syI2CKfCHuovuAVHDm+gDnOpcWLJhLJIY/hiu9jC3x9h9bMOvUCMe0Zjmnx?=
 =?us-ascii?Q?UPlCrFWgKqRWJEjsHVan++RWcCcjR/f97N+6Jb3Wzt6Fs6HDJcESip0e5LEQ?=
 =?us-ascii?Q?E60AorNMwtmX85cubv2oNpVLIMOzDEaO9+U79z4SYo598Yc/pmPNBopHSYQa?=
 =?us-ascii?Q?kVPWMKmJuDnUnuCdrwx11L1fbR5H8svPppNy83NiQMXMPTW0i/ZMnbzbyKaS?=
 =?us-ascii?Q?QQMioChNLQD8YFVC1aXL8W/iXCDPknHSwJi+2gCOXXHTMAms/BKKNR7deWnr?=
 =?us-ascii?Q?vsE8AVdbQKxFjusBZhr3qVKVkxDN+kx9AU7AfEPy1Rr1FAfwmlv2zgIlr2/d?=
 =?us-ascii?Q?WGMKsmtVXb4TEweCRbCzoe0B4Aogqk938pXt0oZdBxV5H8wOTXy2rZO0emYF?=
 =?us-ascii?Q?q6RyVGgrunjHDZswI38kUiRLxrUN7DO2QhlGxIU6y8F1gvm13sCNZ2Ldjvn0?=
 =?us-ascii?Q?GYRcH1mMP/8Cj6bXi+c/jwC/?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7801edc6-7b38-4b65-cc48-08d8d46e2d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 00:34:54.4245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/BiBaZLN0z++lvybkzf+mfFHwWX4g4Ek/mxTjVFszYc3xrHoUC/plUQseFYn505jqabeHqi47HqDyip2l+z8m4OALxYL02jWCFejJbamhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_193510_748978_F6065369 
X-CRM114-Status: UNSURE (   9.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>>	if (queue_idle_period && queue->start_poll == 0)
>>		queue->start_poll = jiffies;

>>...
>>[io_work loop]
>>...

>>	if (queue_poll_period) {
>>		if (!time_after(jiffies, queue->start_poll +
>>				usecs_to_jiffies(queue_poll_period)))
>>			pending = true;
>>		else
>>			queue->start_poll = 0;
>>	}

>>Can this work?


>If we were to not adjust or account for time while not in the work item, this logic might work.  And if we wanted to restart the idle period upon any activity, then in the 'if' case after setting pending=true would need to >add check ' if (ops) then queue->start_poll = 0; '

I tested the following along these lines, and appears to work just as well.  As long as user specifies a time period in that at least a single I/O will occur within that period, a new period will continually be assigned until we reach the eventual idle deadline.

code tested:
	if (queue_idle_period_usecs && queue->idle_poll_deadline == 0)
		queue->idle_poll_deadline = jiffies + usecs_to_jiffies(queue_idle_period_usecs);

	[io_work loop]

	if (queue_idle_period_usecs) {
		if (!time_after(jiffies, queue->idle_poll_deadline)) {
			pending = true;
			if (ops > 0)
				queue->idle_poll_deadline = 0;
		} else {
			queue->idle_poll_deadline = 0;
		}
	}

Will do a V2 if you like this better?  Like the names used?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
