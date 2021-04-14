Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6EC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 18:23:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17AF61131
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 18:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17AF61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=IguC4rc7F4uPDF5xxaaF142NciWqs8nY5iq/JJ9kt00=; b=UsMVSlscuvpQbXBMets4JTMlC
	j/QWQkAbfsVJNRKbsNfgz2un2lWIHDipUii3vwbyvz7CSxWzJlC6oHfaqX7nkjBJmP08/7MsmARBy
	kjQ/hE92J4gB3NwIi8lcWyMUvCQpPlRw1mljwcnAShSSQyBncLYesq31DxQ3bgU/MFpgsHxc5qczj
	Qm5bSSgkt7FWlBwyB9S1N5wb7lROaHvvqNsvPVuf40X+afu/3V5AUDfgVcgD35Qt5/hYeujBSGeah
	9PvI7pTenuDJnFs+NVHoBn7HsQqbLSwjSyW1AfA1mT8+s07uzN4en3VC/SB7oKAApLm0kkgZ/aGre
	MT1hgJQqg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWkAD-00DOJp-Ds; Wed, 14 Apr 2021 18:22:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWkA6-00DOIl-UI
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 18:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:To:
 From:Sender:Reply-To:Cc:Content-ID:Content-Description:In-Reply-To;
 bh=idG6Z9e7Xm4ELypxPvrwG0OI6mHOtqmtz/HleuqDLFI=; b=birI2bvYZKDDdYYypO8H9MAtTE
 PiKHMACbARsGEBjncnj92cpdlIabwoacM2qFR1sf8i/SbYKVDM+PjA8pU9FeasW5rbgci0g5I8/+A
 Ju3HxoGaGRvtiFKQAfp+yzT/yNxXE4BpaXhJaAABwSPdg81yzwqoyZpbpdNzD44hljWlIlGLt8f/R
 Z5vWV4pvv8p9jyVP8TQ+m2Kel/vMQI+5mAeKNDDZhLHRg4nsIDZmlbAWZoCYiarwq5uN9YWHzjLeP
 YRylfXfYzxCEzqxEoWhIhq/rt0b7jKqHO6piQwBnTyZlAiGv8iGempF43cjme76FzURBrdWcx1AX1
 +CPmfw3A==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWkA4-00816f-EO
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 18:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618424569; x=1649960569;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=idG6Z9e7Xm4ELypxPvrwG0OI6mHOtqmtz/HleuqDLFI=;
 b=B4lZswebj9Al2/UINutRdf8acxcv5PBOBq7Ad+6yya02Yr1Fu6bIiibJ
 wAqI7jFi/xXWfWs8SHWr/oi9e3gw74WB7jWq5lgJjJKR2nFK+VmbSXtFq
 Z2vlPoXL/1r1/Mtce+CbUXHH/SF9qxNe/jtwaVbC4oZX300nl9gOeFNLd
 O7qcetZADrD/fu5NGCvo2OSK3lv7UTxwU5sPrHFw4nWwHGYZwoutuv28v
 gb58fVlFaS0PcsGn7PTMILaE7inR1wFXbChtP3YOUuLr8n5QtVUuuW4xE
 E2pmWQ8dJvAvujqEZ18AKUSHyZ5cxlpP+W1ABO6gkpSnjluyh093VBAVD w==;
IronPort-SDR: y+lpJ/0jFZHuAaomnRD5opmnC1f1DjGwXVU40W9xdbpW77c4WQiiDE9I5qpv7x60DngZTX4Ujj
 1xpHDTK4W4b766eia1iyM1VouSjPPYPWCYJR/cht4yGVz7/nWxBzI7AvNOOvljUjOuH0XLp/Vb
 3FGiPFMszFnLW+hUuYuerRJxQ/u3bv2XgYEXClicFniU8ZJVg1BCkeHdUd+RJb2x8EfOGW/QqZ
 V89r/cCs/WP5WWaJKLlz1Dtmx4MK+NrY+DYDGLCx33AQ18mMANwSOCH3i0mBWIJJU95GwOi4fx
 kKI=
X-IronPort-AV: E=Sophos;i="5.82,223,1613404800"; d="scan'208";a="165492394"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 02:22:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8GkYhHK4+zjGjTSbw3obalOCPN2SAMIseV90VqZ18JdQkxE3m/iOdTc9nXfNhVYNnjnBY6pH/fZFmRPih3NaFle+tJpyEQxEAt1o+5JrpixPhav1rEGo5XSjYzw0/JYrYeAPBqlab+qu8WORK4jNgG1LDiv4xu93g+3lYSpT5XzZ/KrbWpao/x7kxn+AYYMS7oMSzcTn5Ox3PvlFaxcY7KyBkanMRqWunJtyCWQBoz11yfxWFIFxePpXrUgWy7yvnLwGtM/hLSgZLrAb+/ywB9hCni8jkEsGHSRLW+/61BgN/F0zyE/84CFZyYxL1BIDndGUbTmad6RSpZQ3jGLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idG6Z9e7Xm4ELypxPvrwG0OI6mHOtqmtz/HleuqDLFI=;
 b=XMox6Qwh4yL9Ep3qWtDmTzbqFL3gm0rCe1MsAhttbF4edERRoaciuHfhDqubKiSrCNUOGnkF4fLOE8BfXjRrGjzgpzJfoluVBH9oWJa5pqZSc+6epQMNlCOG6aTqqg/+mnnvqD9aaxVjhFUeJ99wQIb3/I36pJJP3EKxQMFTcc9Gv1hVdtESZsfkGQCtPhEznJYehIiP5WJrCdRiyUjfdCCYL7iFyk1UGN6lOO962NqAu5m2SZ//Sem+U/ojYAMs0PQFnupRuoHC+BG3F0AuJstw71/Ifx1HV+nC9l9q/5lU98sup5YnOwfEDekSCQw4d9RMe4R9foV9X5fGhTrN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idG6Z9e7Xm4ELypxPvrwG0OI6mHOtqmtz/HleuqDLFI=;
 b=Uxr6Q1lCqW/vORRmFtoQ0hhT/i/+zqr7Hp8LGPwj38YsLFLRG3/QGIhI1myNHR0I2R6l3mXwqEltTdMSu0K2E5x6hZcRJGOln9lLxehlIDfuSCSfR6uvHNqiXbCRbept4ySyCRFTkAbidKEQ6l8iRsi9oBw943N+y78inseocGM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4232.namprd04.prod.outlook.com (2603:10b6:a02:fd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 18:22:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 18:22:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Gopal Tiwari <gtiwari@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] Fix NULL derefence in
 nvme_ctrl_fast_io_fail_tmo_show/store
Thread-Topic: [PATCH] Fix NULL derefence in
 nvme_ctrl_fast_io_fail_tmo_show/store
Thread-Index: AQHXMQxGDaM0bKO/ak6MsV8uYY8vzg==
Date: Wed, 14 Apr 2021 18:22:11 +0000
Message-ID: <BYAPR04MB4965169D293E23F40FA88898864E9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210414084645.638150-1-gtiwari@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7aa1e04d-94d2-46e2-f95a-08d8ff7238f8
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-microsoft-antispam-prvs: <BYAPR04MB42326A03362F020B8A85F4CD864E9@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdKw3hV/nTzE/9hCIequHcGH9K6ZWrn5g1F5zpKzd1p7JHk69yhAbMNtwV7OAir2ZRGslbWVTLezXDIyXAEr8lU5h/cED6FZsdGJU+dZrDgoAs1PG0JxgX3NaJQFIN88b7g4IdU4Ks35IaAH305lKDMqjboqZ+049wv92b91WitDtOHXS2lL4TVdlnMZnx8TuJQz5tkRT/ya7ojgc8AgRKV0bB4pHp2kZbbC27NAtbzrOKi2QHwtJa99tI4kerpWNMEyqGraIpQxF1JEn7ePdzWO4qCjmfOwANA2/d9oBDRXTgFiLl0xt1xv2mq8RPpo3PedRp9q4xRMDBid39313gFugNpl+JOmoKI96j8HwP9sw1rlRgxGRQplDQZGy1k0yBzNc2ZIT7EamomPdg1Keguiv+2EnkV5EfIC1oYrBgt+/OKU9ED5YWsNgmYVLWumYeTOQ3s4u/S+f13O7ODxQ8BFu+urnyGVTBuIy68Zld6qv4vUjNYWYZBn2zlaMvRaA/mJpZarZqhYuShE8JiBHW2rtP5sklvYyni0fF+hSbem7csmwEj/PfHp7EZgcBtiNJuIta9jflQod7HAmtFQfBpc+56t7JFtznvxMoq0DuM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(8936002)(52536014)(8676002)(26005)(6506007)(478600001)(66946007)(71200400001)(186003)(33656002)(9686003)(53546011)(55016002)(7696005)(558084003)(38100700002)(66556008)(66446008)(66476007)(2906002)(64756008)(86362001)(316002)(5660300002)(76116006)(110136005)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UP3mV70pPVuppI4878GxvsxyVd6DfgZ1p2czenH4nRJRyCuF+8b3oOx+sGpu?=
 =?us-ascii?Q?B8E9GJLFHwW4b8jqT7+lLm4A2bSnYpJOabVE9OJP/b5ktfZqZJDnwP1wF978?=
 =?us-ascii?Q?eKeXnTMentPiq2/X1LeRWZZL9NOby0szygBe4oIqf+mI6FC9y9F+wOY6TpqM?=
 =?us-ascii?Q?8lcS+f9mk8s/6guCC5eBXGEhPJyCRepSsXZ9k/fuJPDyjdggGKYxqaxrww+0?=
 =?us-ascii?Q?L6cVwZm+WWjlfXT6NDwK0OqXsYMwnwa9VF6ht3pTScohoj7OLo9x0DE177m3?=
 =?us-ascii?Q?weckmfPeIkoAcD+bVhADIK9fZO6GE0rwQyrDdxjlTTxYa9Xiy5ARxfws7u+e?=
 =?us-ascii?Q?X8dIkHLB29D9r+Ye775+GeUUvOIOb74HnVnEBYes0s6bQ3ncHtDFqK8fo5v2?=
 =?us-ascii?Q?UNEnM5tODuJeYLrQzINzE3+GpPs0lKD3zV1BDTwjC8Hx9P1Ki0QH9HnIGJ/i?=
 =?us-ascii?Q?wrRQ4oeU9mCVq4lJjYAcw+p10AIRjYitDSAc/rXGFhM8baOfQVxJjM66R/CV?=
 =?us-ascii?Q?DYxQvtGEP4sFrZlvDIgjjz1TYbj75znjS4LJDa3EAjv09N23oWubkJ/ipLTc?=
 =?us-ascii?Q?kr+B6C/ltV3Bxhk9BovQNweSj5upYX3h1hiGe1MbSKvrZ2EOpbaOhK6+iOUL?=
 =?us-ascii?Q?CEHpugFjLIbU92R03f3BOS/CAYstqZ7+ZPgA1YHYy1BJwd8dhnRzFnH2MmWe?=
 =?us-ascii?Q?dx6kqoxIxI0+5Nm+qDlYhev++J4mDVEY6j15YZBFkZQ8n1pNLqRF7P6LAsF3?=
 =?us-ascii?Q?6Sr+tG0y8qPDn1BroD9AFBA4iVKxuTSVvlH+xCKqy5h+LX9vSOdztLSLdEQb?=
 =?us-ascii?Q?2e5lY8j3ea5fptU4hXUvoK4v5/JMI3objH6z8idilfC38cUoH3MLBau7CEyp?=
 =?us-ascii?Q?F4Vcfga3sCvMcoqM3n0CTi1Yij6yTZwrILzHkjZZozejm5xSRtZ4xgxE9mZa?=
 =?us-ascii?Q?tyMO80935YhQ7lvfC9Fexw2WFnhy6RdK8oLBUhXjkx4/5RoW9m4jXbieh3F7?=
 =?us-ascii?Q?JQhutSQ5TBSWBlCt1+yyaeWF7zR0oMTzKRSb0DEdMUwztWrtTk85SulIp0D3?=
 =?us-ascii?Q?zqn0MGmo7VpGqQJdpT2IVmFPPrquV8t/lSxaCEGro2kWzlAwNJMLzgy2CsYu?=
 =?us-ascii?Q?PrEmgQFLfIhbrrMQ/5u38Bmv3+JpCxkb36RjULzeFR7ze1a6Nq+Re5paU82v?=
 =?us-ascii?Q?p/P8qAcM8VfqHzETBeb31VcaPqed5ytoexbY+G4faO5/jdaUXromhVc8uciI?=
 =?us-ascii?Q?ULotFAIoCgs2mH2MogdbcWqcC5f13cghULdi/8K6rzJWykJW6FGLr2hEXQsH?=
 =?us-ascii?Q?dB+munPUj+pWihZvASVYasDo?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa1e04d-94d2-46e2-f95a-08d8ff7238f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 18:22:11.9391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwlnhEtlUBa51s9YxH+wqEnxixDa7NNAmG7irkJ3hB6JgUxAPxWjzo3cMnydRCd25nE6FP8po9DkYdJyjDFDSXeCa1R46GcnlAzy2/UwBzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_112248_659907_252DA676 
X-CRM114-Status: GOOD (  10.61  )
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

On 4/14/21 01:58, Gopal Tiwari wrote:
> Adding entry for dev_attr_fast_io_fail_tmo to avoid the kernel crash
> while reading and writing the fast_io_fail_tmo.
>
> Fixes: 09fbed636382 (nvme: export fast_io_fail_tmo to sysfs)
>
> Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
