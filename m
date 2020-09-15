Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D773C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 02:58:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0835D20897
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 02:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XaBe+M57";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MSST2odd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JlPUz3ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0835D20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ZU/kMgtUpQeaN0ER7jOTf9JlV9nMl2LYADhyrdvrFJc=; b=XaBe+M57FfDyDjssDUR+a80ng
	elx+KswSugBrY7rtVWL99pF5959ZgBpGZugQ+g3w5I7ka72roIO1yTXubiFBYzj72CS0bUG1kt1/Q
	3GDYPWwL3oJ2xIKbdE+Xk8ps1kxhkpmkTX9leByB4qWLNFEki9fVn5F1SmlteGexG0DrTZEO8lmGm
	qtRtAcF1nZd31dt8kPbfPrpU7lWbWN/N2RVIy+8R1/aWUlgFWI9kEZYLBPw63kcszPPBo2wnjci01
	MUbskGptyPH859wwIMH63M4HaujXicm8QNgGx9vEmT+RO1ZTnl76bqTIctB1bqOhpKoncpC3Gx5H0
	fzKqfNRoQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kI1AT-0002gQ-VY; Tue, 15 Sep 2020 02:58:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI1AR-0002fz-9C
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 02:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600138684; x=1631674684;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tseWMnxqO8B0K/2FMGb7323Z+Vg+nk1DpnSUGZAwT3k=;
 b=MSST2oddbzHwI9DHhlsWS8oTJrOijb8CgY76ENmESy8uHM9wY4EJ7alk
 JD6hRCaAcqmttEhTF/2O5XtmhrqHkpKgPxV9IBSGGnDE0S7VEIpsC20Rq
 vB/9/j3EDtVtOci7cWBz0iFc85rhLGc8Jl+N0caG43w4AL5Dn4uReboIo
 aU4UzCGY6LDPts9zKBwpm94y4e2WO6mOvCOUS2LA1/pnxvbjdaxB2I8T5
 SIjyZIlGhAWoFEQGRrovZ93+eFUGLhb/WVloMeQ3/osOXKCF21d2xyavR
 cuyDSrhzaicBXhRJa58xqDR15NHIO8qMysAOBRcPOtXzlaJ8P0XMRgbjT A==;
IronPort-SDR: 1PIH47ew37C4nPtMJdI+lqda0EJEkYAd3J6wRi7M4f25itvS9ryE/4o5mQYAG2wWF3Zz7Y6y8f
 shvPtBXBOsosoIyDKv2p/gMsH9+MIfS2Ie5j1bAtT0nKRyJiGy2rYA7Fv1nUlg8PCE/SCUOol9
 3fuaJv7Yrf1uKdOIoENqUxI4lkiOEGeiNYMrJV3NNBsNIaoEWsCOAoCQz6K67xV2Uvke61hmsC
 i0ViZkq66cHqBLPn3bKCem4hKpRVryhPp0tMQ0+6grdK8zPZBvdwlqrVyFZLj/K06gNUE81BUa
 PWk=
X-IronPort-AV: E=Sophos;i="5.76,428,1592841600"; d="scan'208";a="151737392"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 10:58:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cARML5FjdEsMd97lUy+lxYQYJ7kLWrbl6rhiVnWnbJLi9PuRuem7jbCt4kyAdgUAR1pQ7icJfZnIkAWO6LUz3RnDnkJPSkkbo6hzgS1cPQXOgiE2LWdPKMDOKJNhGuBsQxIUfUeoMVA97UQpbP1gddy+H64GHgBD6/bVj+HY5tr++CpNCdZ51entA2jnlkaHdJAbbQ0f5GyyIXqai7HKTnGmcLWkKH+QqgWYjEl/WNvHIU8g2Y6VsveygILKkrp6+ctrSieoA39YiANi4k7euzRp11WMKgOaU+bmVgirXhijE73xkbm+/AmhFB5P/N09OkIHeRLB5qZSvwlNBx+1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tseWMnxqO8B0K/2FMGb7323Z+Vg+nk1DpnSUGZAwT3k=;
 b=R7ZWO4mHbVq8z/R8AjYUueDKM5x36Dm0rpacnXepnKYkfDvXYRxpSpzlY0pBXIJNNPGzWN0aBtkYlMAcdXCKvypU8wehLMiNikcrktD+GKIKuuaSUGRlbxPRuhuE8WwnWoebV3tQY+Kh815/5tE6DvoIkbq6RfsdJ0IzyxBhB1BvWD8AuUb5LP6Vt/wltetTbFfwBDNHG6W3uzV/i8BjN7qv/3fOjFPJamHRD5aQFHpr4y6X7O8ZlZrhHmkDaIfWnz+fTnbk6OkKhlcPPtBxbBPTVKf07fF/sbh7cKIAxpwazPu96RtIzPTVYCBiBLgki7gbLu2pdMZ9SrkQ+JI7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tseWMnxqO8B0K/2FMGb7323Z+Vg+nk1DpnSUGZAwT3k=;
 b=JlPUz3llV9+9l7/78aGOpUMrRiCUGfcS02YVWDBPrqeuTUzcSPHiwU24pR1fBw1GUMMQqtiSIb9dUphplhyxVYIIdUspIWxrzumFDeBiipbFKh9DvsoHnOZzbCTL+NeImwb1Z6TecGEqUcxOi0XCv1Rno5V3odrUXuqPGx6AgDU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Tue, 15 Sep
 2020 02:58:00 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 02:58:00 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Topic: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Index: AQHWhukkr+7z5FAjgEyIuorVxC+8EQ==
Date: Tue, 15 Sep 2020 02:57:59 +0000
Message-ID: <CY4PR04MB3751694C60EFA6F0DC029E5EE7200@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
 <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200911061022.GA21597@lst.de>
 <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200912064104.GA19223@lst.de>
 <20200914194421.GC10507@redsun51.ssa.fujisawa.hgst.com>
 <CY4PR04MB3751DB156A3A2F4663F49DD6E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200915025522.GA3659321@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fc5bc51-5827-4fa7-cf0a-08d8592327e3
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-microsoft-antispam-prvs: <CY4PR04MB10323F0E05BE52862C25AA43E7200@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VL+cn7aAE4XE+W1/nXuxiJGNvAeZ8KokscR7byRTTC9PVrYz/31HypE6614CFTc3XaVYKZWGhGS25iUV/nu9Oa4s/v93MiU/fo4uxgImASWosfo4j8T8vN8vrI6y/63nzX9/wgbma9n4Y+pyPJjKRsDughCUY5WsP72BfTKlEkwWndm9LeonAZuTGiTajJctefRFhzmc40gzT+NddmZigz1gYmYY9M82iJg+59lN6l0IyPthDJNBMzjgf8zh2B2K+l5NoG0pplNbGfAW64/mLK2K1yrrVJI+JT9OxRWx0e9q0F0P+ETM8hoitskpOi7FIhTK79skWluH8hfGVel4Mg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(83380400001)(9686003)(55016002)(6916009)(5660300002)(64756008)(66446008)(52536014)(71200400001)(76116006)(91956017)(4744005)(66946007)(66476007)(66556008)(478600001)(53546011)(186003)(6506007)(33656002)(4326008)(8676002)(54906003)(7696005)(86362001)(316002)(8936002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: j27MBb4EsZeApRdR92qfpI/u8QlbKKeMg4AqguScXxfdQ7GdTQ/qQAUAakjK7Xj/cyJE20pIgvgU5XQDsbz4kq9m1Q05UlvfDjHWhcPwnRPXhxnNTH5ltSZooQ+2q/ymQhAR+PKMWLRJzM6PiJ6s18tf2KcbJVNP+UI/Jffp0xBZFefw85ibVu2gHmjtkrUen3mrQO1Z2kGVkayAFGjGMC/Y8vmdSSKlFLXP2fWyrDgemEcTTQK5lBxi4o5U226EnSL7oCykTqWTyn/NOUsQCrZ2ByHBycmAokh2D05rYNSMmVbOGdQTXRJdRbM55Ee6YIS0X5SkLXFfeRru9WXIz8wn5d2PdrPCZldHM3YcFvAODvMqIEl9+syudUhe/0eAzAqSbw0Sn+c+NqWyNnfSY0Hr+/O2tg6VE83Ho5JN0LTIv+28cPnqMflZf7zzMsUnIDrBCl6dxuAT3VVKRJdGkpkYT2zCzmphXsVdY/J1g8LRvQyNhUWNFICfkFxKM7hQ60jS7L3dNE4cPnhWtYelsjfJN3e3mOO/Zc7NefK1+2Kw3R0bpX4KPIuiLB73f6OnNn6SK3Zr22NrksF5IymJ6JeSKqa59kXsbOkyZS/yDz5kEZzd9ZN8fYMlyfWceNJQkc8mlhXRdDQcK89N8PRtZZtMAKxcTcKQmLK+qrjbqdu6UYDiLjr1+qtC2AIMDozxnEXtnOGPVPBiMjSzz6xu0Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc5bc51-5827-4fa7-cf0a-08d8592327e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 02:57:59.9714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXojtuetLWO9qoRdni/CY0KVAbiYqMvyCQ6m1VU8q/ph37BmImZ8+Uc/zTLIbI4AMl6KBwUbsGQ36eNSqZBzHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_225803_555624_62558DC6 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/15 11:55, Keith Busch wrote:
> On Mon, Sep 14, 2020 at 11:25:08PM +0000, Damien Le Moal wrote:
>> On 2020/09/15 4:44, Keith Busch wrote:
>>> Selecting an existing unused errno feels a bit arbitrary for a status
>>> that is currently specific to NVMe ZNS. Could you provide a little more
>>> guidance on what you're looking for?
>>
>> Not just NVMe ZNS. SCSI/ZBC and ATA/ZAC too (both sd driver) :)
> 
> Gotcha, I did not realize those may have open zone limits too.

ZBC/ZAC both define a max open zone limit too, which is semantically equivalent
to ZNS definition. ZBC and ZAC do not define the active zone concept though, so
no limit set for max_active_zones.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
