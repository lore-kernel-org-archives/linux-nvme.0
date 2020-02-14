Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F9C352A3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 00:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475CC20848
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 00:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xn0phsjf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q7HMi8Yi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rj1GV6+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475CC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=yhxXzqj/1ILtZ4ZjtGGQwHjEaGRIOaJxdOgUOgspETs=; b=Xn0phsjfTmtM3D
	/EWowc35wJByeEJeGgbRHgFhL4tLVC996LgBiSlkPXEHCK3SJ0T67W7SbgRkC8h9GpJ9xLVU6LTW7
	lcml/DKkt+5Hlo+eZOunaGoD54FQovIr+Ga1sFLQdoMQzvhNkr1lzEkjfFnxg4RUQJO248CZyL1c/
	UtyspJ74/ZN2lyKAu8tcfY8A49OMBShqkYWCkpizFyl8qSaJxhcvBQHF49i7G9DIWLLn+qk3fUs5i
	LP6L7TryATtSBfidqW0nR8lSSYbhQC0H2e+dauDA/mdX9H2wHMnRSFaY9RulndENZcCYNDZ+Ppjmt
	h3ieTfighp4YIR20xe9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2PJp-0006le-Nq; Fri, 14 Feb 2020 00:58:57 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2PJn-0006kw-7k
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 00:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581641935; x=1613177935;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Cq640l6gseggOC9R5IjJ+DRKcn6oBDNglO47WWEoQz4=;
 b=q7HMi8Yi/UKWj8rTl3ucYsDDRVwM0AmuuSWwO26ztwN//CuV/GDOjKkh
 LDLn+B27kHIgu95IO7mjF6SQXGPF0bbd/bvf/o1O/tWPwWyUjuJ8VKLy4
 f3ijhQ9vZjJXG0YS3YgXGik+zzK1G8rNOVw7gHYIIM+KkfvX1D4itKr8y
 1twHjsicnQGv3C6HLwu8qWBfkgq3qUYSd1IGVO9AmuyGzSLKBj9xkZLG2
 pvsh5bMWNju0mDAt4fhfWfAv2K6tcbsRb/m+QnlKuYK24d8FTK9NrJ8Ht
 AwKyL/CdjcMgxKX/OVRZIryMB+FgKQa9iJhYB49uGqHEBDUSSf6/1o+Yb w==;
IronPort-SDR: BoB/qT8g1vQIWa+2+Tco7JytLYcvwYPc3JDmbEjOskMn0prRBvw+Ju9gS5nQJer2xn69AFLTFN
 pjXs69KjdgVw8ZEFtL6XGMRG6BOM79K9izKj1Zs5kBzcO64Tqkms3bLFxQCy9CUweIG3mWopd4
 tIs8vlalB2LbJ1mLZLV1LfLnYg1n7I/5bojZa/PFR5Yr+opa/yTs0HCko1MrTPYjpJHdt5J0FH
 Ws1a6De9xrE9ypAmM1RxhSXfXD83GveoLDEVabNJRfmP/oNDmZhkfg0Mh4dZ2KFw3l7hClnloF
 z3g=
X-IronPort-AV: E=Sophos;i="5.70,438,1574092800"; d="scan'208";a="131268686"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 08:58:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WslNQj1+kQWAOBPKRSQiLthmeBlDlfJzJqqvS0mzKdtzia1bMME5LJrIZ9AeFEb6T4Y2s7Z9XyInUqbRxzL2IUgHTiSqjgm5m76JfbwocVQt4x09vx3BsRAE0BgGZQp6vZJMcnwEFSulqVGCINbg+gktCgvUMN08KRWQ+Se8dqDQFnZbsz9gFUd0G/CJZWYGeU9vXgSvGh5uphXeZWKtVyXB6ZkmTfG91vrBEMFIQ9F7xm+Qb7SvG41l53YjPWXmIhmKJX4z7/OCS4IAWspIcJoTXArU42pV0u9czaORXHz3RSsqOiR53fMW/xK6f7mdyQp/qfAaBx1y+089sKWvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTeByc2hZuIwKjgVFF+/Z/RbyXk2PzLEB57NQ0QCwd8=;
 b=SUiFsWbj2/N5jybIaJpDw503RpBagJ8/3P4mjQNACsZOfsVLhNUx/RMUAzsmdfWDui8pOCoT5Q1BZYMKqh8+rsakqjEBnP4yAbJqooNJrurTqUJux1IxHBo+CMiDhWPxRfyfKlMkEsMhUlVPGERo/9CFwMuO4lbWdphRe+WPbGdAGZQbeJaoM6Isa1Q+FoLOOrojdE7ZwTmd1RQIXHo7H7mHUPV3E1dEu43uVVUWoA2p/CtG3wJYZv56Z/LznpuyGgoaYH7+REx+NO2YKj2bmXz4KD6H8ipgYDjBNn9Gb421Mb85YAm9pHfo+iYB6HmVyeliwmWwvKqrTgHsnOQzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTeByc2hZuIwKjgVFF+/Z/RbyXk2PzLEB57NQ0QCwd8=;
 b=Rj1GV6+XcXvI3FL32dwq23kz2fMflaCWEMnpCTX7kwy8Q6FqVgp4A2ZzsFngMcn3KdjWh6enitoYwJlB7iTQoBbI4RSdInkjEyD2I/qPw/QEkxRMnQ/tb5LW6lFA3xrWRgC4nfMSjSkDjP3VZgIqtM+qxO8TsaERSVCK8V8cu9w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4728.namprd04.prod.outlook.com (52.135.239.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 00:58:50 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 00:58:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 3/5 blktests] nvme: allow target subsys set model
Thread-Topic: [PATCH 3/5 blktests] nvme: allow target subsys set model
Thread-Index: AQHV1vv4m7siuAMmZkO3eWJXbxBdSQ==
Date: Fri, 14 Feb 2020 00:58:49 +0000
Message-ID: <BYAPR04MB57492F13DD0220006679DB7886150@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
 <20200211220003.GD100751@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2aa91952-caeb-4ec6-ef79-08d7b0e90daa
x-ms-traffictypediagnostic: BYAPR04MB4728:
x-microsoft-antispam-prvs: <BYAPR04MB4728B540B7DCEA2FADDF026786150@BYAPR04MB4728.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(199004)(189003)(76116006)(66476007)(26005)(66946007)(8936002)(66556008)(7696005)(66446008)(6506007)(64756008)(186003)(2906002)(53546011)(86362001)(316002)(8676002)(478600001)(52536014)(4744005)(54906003)(71200400001)(6916009)(4326008)(55016002)(81156014)(5660300002)(81166006)(33656002)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4728;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IMpIwXwZzqTVHQvxaADtAhVWFxDzP5Ee+Munu0dCsk9+28Ovk1jesTmAxW10Hpi1KSWZeruY0MkMHjJIYnAxyd0/EQSsfV46CRXXX5D92xQWOpmzAo42dOz/Wb794bieTFiw6RDmHWTCsdIihqfM3icemrUTc8E4f9ZBVZIxBVFworjA47vgMHXQv60LSmS7ZR+Tj5PVrvnmExKCpQ9Dk8obEz4WAWLOJiWC3RjjXqEYtS1HX4pMkqcXiUFr3SAEaaim+sNbRO7DIptgXiwM5lgvHghwnXDODlAsBiDPhxcgcmemOMyqrJ3GeICW84leaa6truBNU2/y4luWNuxC95vnHSseTDyaiLzYJGz2nPqmIeB3Ll8CnfhDy2ZUlUOfWuRhxzUTNyPj/vDqgOj3DjiYADE9fA7X0T3K5nTA42QWX9s9muTKiYXKfTQ29m2y
x-ms-exchange-antispam-messagedata: jdJW56ZXpEe6sz8KN78OV3RgfNzAgm2+bRxegnqIXR4Pa3qoImnpMwhPO53V75rcuxUGDcZRcUCD5S4B2SMxiam4qVKxKy6nBqY+6molnYRuMaspuYHj0Mfk9meIjDOgnr6+xoOa/qpRA04UFLZffQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa91952-caeb-4ec6-ef79-08d7b0e90daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 00:58:49.7800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvA1nOfwv+xSJODzDaZWLO8lrtUceP6zRA8hAK7Em1sLDXVAaOC7lMzm3+eNWQuEUJ1XqtRwngWfQn8aanu4n/e90KMa25w2CpQYAY567M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4728
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200213_165855_314136_FD142656 
X-CRM114-Status: GOOD (  11.26  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/11/2020 02:00 PM, Omar Sandoval wrote:
>>
>> >  	mkdir -p "${cfs_path}"
>> >@@ -133,6 +134,9 @@ _create_nvmet_subsystem() {
>> >  		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
>> >  		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
>> >  	fi
> It's not in the git diff context, but the line above is
>
> 	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
>
> So if we pass 6 arguments, the cntlid arguments are ignored? These
> checks should probably be -ge
>

Yes, -eq forces caller to test cntlid exclusive (without model),
that was the intent here to either test cntlid or model. In this
way caller can pass 0 or "" and that will be ignored. with -ge
then caller has to pass meaningful value and set it properly.

Do we still want to make it to -ge ?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
