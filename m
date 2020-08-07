Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69307C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 03:09:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3771B20855
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 03:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mJY+sJdj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o+GLmiAm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qoFVm1WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3771B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/C4qEeOLLOqvBuz47dpWmEd7bBjvqbMlXBEccIdwaco=; b=mJY+sJdjlXIamAt2Bk3Fx+/M2
	V3ie/jHtanaR/qKmq8251sdYgrhw/1ez5nvlFFbJPFkanpRNP+PgUXX0be9fHehusWVPr/UjA6yi4
	q/JfA6t0/dvyhjCREygOVkDkU6JaRSR5DkRREAlo7lZBXuUdOPGaDt+2l48hKaHyUgTmRGKkkwyme
	d3LNeg3hvU5uiM97Ub5BHRgPfyy+9jx7LPjprx15DPDlbNnWa90SOxE7XC2dKH4Ahn/K7Ca2pBaiB
	rF3/Zo8HsquS/3La5UyLrTQ36I+vAiW25FWQBYbIj8MEZ9zG630AGmkUGfT0U1CNVqTFRR/UZ96mb
	48E0FwibQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3slC-0004HQ-45; Fri, 07 Aug 2020 03:09:34 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3sl9-0004Gp-2f
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 03:09:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596769771; x=1628305771;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=bM7nlZRge779psB12vbdduJ68aSucZ5w4MGgGrm2RfE=;
 b=o+GLmiAmCYD3Wh57j8rQL70OOxdnONqyyQxOV05TDwHENIeBWw62lG4F
 e8+5GPCiYAgk+ReUJ3pmw5oN9JaUN+sj9PZMgNSTXzytSxmQkSjz6AZRF
 vbE0d1SLpy4r02eY+t2Yqfvd8Y3Ne8bPjCrWDCfT/9EmPVp6qDF4TBWWy
 5Z5NUWOHB4Pd3gbqPD5yUOCQm+H4/5szbBKORQDRkqJemL29NnGhO1sWA
 tuMP2D4kZJjPCC7WWGNP5IJquce80omQ8r40Sa6NVpvdjQKjfZWrpkCz8
 EUkkqoRhMyLoFJ1+jtUA6Mw6BsNl0LNun/mCQQuxcEYhIw94K6ANQh9q5 A==;
IronPort-SDR: xg6ZWfV5zXjbza7uxoH1QKnvTR5FgJL8IHwc5/bwn601bHI6DSJm9P7HS47/o113zIzVYbwg1u
 qBLmCsWnXhDGQbU/YuqQN+zHv/rjLhf2RqFHzDgWNDNMnpAimE8jZl5XjeVvP0qXQOKrnXcTME
 H3864UeT3JrVowcy1kWQOxuWOUfMX/4hjdwNE//eyks8DsIcmYvk89Jr9ROs74C32stoQy3dE1
 lsyNFcYIdDkRc+E/d9Aa/DCown9CVxw4bZYsWFY4pzxOX1MuHC5cmdilPIMXu9uirSVlLzQrkg
 Yqw=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="145589099"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 11:09:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpU+To+QIE2/w8faSXECVHC6wJQHY7aWmCdJuhVDJBL7r1agZ1gPDzcHjXPzCV7F20BNUSuDHlZ46JyY8zHV8iAJPFKmuFDcwAH721Iuv5yQSJ4sWpV4a3ed7ShS2S1hWxtq60aavABAGyOoMo16PXNsy4Hicub2RCBFKyjkLSEtIlQ6+AoHwcYLlU6+eo2wZv50aPlZq+DWTgSImmnB7xsCarMxX27JPma/r3fBUiFH6ni6O29UbRhJ+7Ttnjz/zNuhSV4iqTbBB70fNbS22P64A+qf6JlY613EJghwaZleev4r/+g/ao2agHaqfQUgUvwl1viLiCJvb6nslu7tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqgnTquXpEhsQDu07CXc6MgTNHjl7OCdT4YAW0cDe1w=;
 b=CTwTcshqetT00aSxYT4YpxYVd1nOoItxNFmV3Fh5SvmGt1PFXo+sKqQdgxcERpLhacKB85MCv6uQIYxu+dF6UnUIey5VI8pEjWOOBJ4BiAuObOGA03MdXbUygDZRdR8hXS514vlNZm+eMjvIvVNepMTQyEDxw6MQzqe6Iyfs/+w4gCAxGkr/0XvootDRKznLZeDnliJXbysK3EB+sFQpXgASUQu1L8XiJ/WQjhHky+TQUEUsMQEvvQPWXeDXRociLmNY+S/f6biaXpl2y4cUlaNvSk9nOdyKlYXfWy/Pgvqvhk7v0QHdqAFWVv4ppBM2v+zKJ4OnWJgrW8tS1SBCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqgnTquXpEhsQDu07CXc6MgTNHjl7OCdT4YAW0cDe1w=;
 b=qoFVm1WCs0IuucSgECVKQwimbI8HLJP5YHQRVS61tVZHm7cwLJcu3bmyrmEKvMhhuNx5vFpYybzf58KGQpCptg2Jn+Hs3Wj08Ibll9lirabA9FC4tx2WUrqqH4QWyD32UouzU7wbq6YJj9AEoGos4AHt0OYE0hSvtP1w3KHROD4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5831.namprd04.prod.outlook.com (2603:10b6:a03:10d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 03:09:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 03:09:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 3/7] nvme: make tests transport type agnostic
Thread-Topic: [PATCH v2 3/7] nvme: make tests transport type agnostic
Thread-Index: AQHWbCXzh+xG0oszjkqmPtQ6X3QuYg==
Date: Fri, 7 Aug 2020 03:09:27 +0000
Message-ID: <BYAPR04MB4965624DFCE5A870BDE20A4686490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-4-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30d78ab4-6ead-4d49-d41d-08d83a7f4bb8
x-ms-traffictypediagnostic: BYAPR04MB5831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB583195462C49EC6F5508B46786490@BYAPR04MB5831.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eYjlV8PBIjzRNYwzHL6tzKgpiqrAHCxMSQNwynrrx4x8ym05GChQgBgv2J0Pt42utjy1WwxUpWYIK0WGUp03CgqH0GW7bq+LVhI8B0d4Ql9oxczVlkD83UwbLpzVvfnOWAmIuGV/o4ghVSiuo2nYKYK4v9xqHb7xcRzZcETjf6Ld59wVSgAFuUjE08SmTqM6PlQnJXhqzB7EbU2YQKHiwOJxxD2wE1tsIAkbfeWn79Jtxh0cDCsvELgcV7b0KTbDvD5wmXHQ90P2eRssnqv66kSqXFf1FT1uZQyctMZBrUU+RRyPQDD/BWHbmP3otC/fPBtBpOJAOEZ4lDQB2NY6SA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(8676002)(55016002)(33656002)(86362001)(66946007)(8936002)(9686003)(76116006)(71200400001)(64756008)(66556008)(66476007)(66446008)(83380400001)(2906002)(26005)(52536014)(110136005)(54906003)(186003)(6506007)(53546011)(316002)(478600001)(7696005)(4326008)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /Sz4x+L7MiwtJ978F97+O65bwMNC5PinOR2IP8R9XFCp1ftnSYNwGMoJEyRp7QuXfoYMeTQDJqnbcZVHA7P+7W3SKQ1J6wqdLCc8OiaDm5NAyO9V8AB5e6RDEbYCq9u9ZIwLpwpJvfJoyXgRP3RmHhjojpv0xY6BDsbXY1bcpvtvxIgL8JQm594QdbfUbtNrMgeKTAUPkenKlxC0M2AEdSW1VxPGO9lDgJiIgP0v1LBFa8LUTdDGoUwA3HMeX+n1zn+VOXzc5BRAKvsEbkQYdxRu9Lj2TOXa3KLN4wo5P4kFxg18oTmHZxyFeTyVKfnkpdBQm02VwXJtJbed5VZnDep1KDq2f1P/pMVFQS0QugdLY4KX0xB+NVNnIsfzm+Sy96agl0jp7uR5+wXbX1LMpenTHTGiUBabnGlwQ8TQ6YdvzhB8vNBojbKrQ72EZYCqfqb8r+5fnFSJE7qMHZZYZP+qC7NmCPZfRwI66iZTtvoaTq62xXDnaQvw/fB4B8N0rMfQExWLOQY3mOHSmz3fsoxcmSfyI50V7uNomzFNIE43kVvUG3u9p4/xYMDSfV5H+kv7pSnerLLj4Vf3zQUG+2/RXPkNARAZ0/j+aXUIoCN3bmQgy7Y2CBecmJc/4u0puoQlbjl2j5YiaflUjqxsgQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d78ab4-6ead-4d49-d41d-08d83a7f4bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:09:27.6727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYDJlPUlLBBN2sqvtHej6tvvmS8iKCBbIT+tK7aBGVzFxXHp2PlVsBdVr1UQDI/QSUiW/6PHXRMRjbrxFTpU7Mzn154G4Z6r5p1RmDw3+K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_230931_428960_6FF098E5 
X-CRM114-Status: GOOD (  20.68  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 12:15, Sagi Grimberg wrote:
> Pass in nvme_trtype to common routines that can
> support multiple transport types.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   tests/nvme/002 |  4 ++--
>   tests/nvme/003 |  4 ++--
>   tests/nvme/004 |  6 +++---
>   tests/nvme/005 |  6 +++---
>   tests/nvme/006 |  2 +-
>   tests/nvme/007 |  2 +-
>   tests/nvme/008 |  6 +++---
>   tests/nvme/009 |  6 +++---
>   tests/nvme/010 |  6 +++---
>   tests/nvme/011 |  6 +++---
>   tests/nvme/012 |  6 +++---
>   tests/nvme/013 |  6 +++---
>   tests/nvme/014 |  6 +++---
>   tests/nvme/015 |  6 +++---
>   tests/nvme/016 |  2 +-
>   tests/nvme/017 |  2 +-
>   tests/nvme/018 |  6 +++---
>   tests/nvme/019 |  6 +++---
>   tests/nvme/020 |  6 +++---
>   tests/nvme/021 |  6 +++---
>   tests/nvme/022 |  6 +++---
>   tests/nvme/023 |  6 +++---
>   tests/nvme/024 |  6 +++---
>   tests/nvme/025 |  6 +++---
>   tests/nvme/026 |  6 +++---
>   tests/nvme/027 |  6 +++---
>   tests/nvme/028 |  8 ++++----
>   tests/nvme/029 |  6 +++---
>   tests/nvme/030 |  2 +-
>   tests/nvme/031 |  4 ++--
>   tests/nvme/rc  | 39 ++++++++++++++++++++++++++++++++-------
>   31 files changed, 110 insertions(+), 85 deletions(-)
> 
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 999e222705bf..8540623497c7 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -21,7 +21,7 @@ test() {
>   
>   	local iterations=1000
>   	local port
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port ${nvme_trtype})"
Is there a way to directly use nvme_trtype especially in rc ?
if not disregard this comment.
>   
>   	local loop_dev
>   	loop_dev="$(losetup -f)"
> @@ -31,7 +31,7 @@ test() {
>   		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
>   	done
>   
> -	_nvme_discover "loop" | _filter_discovery
> +	_nvme_discover "${nvme_trtype}" | _filter_discovery
Same here for nvme_trtype.
>   
>   	for ((i = iterations - 1; i >= 0; i--)); do
>   		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
> diff --git a/tests/nvme/003 b/tests/nvme/003
> index 6ea6a23b7942..68f823011d7d 100755
> --- a/tests/nvme/003
> +++ b/tests/nvme/003
> @@ -21,7 +21,7 @@ test() {
>   	_setup_nvmet
>   
>   	local port
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>   
>   	local loop_dev
>   	loop_dev="$(losetup -f)"
> @@ -29,7 +29,7 @@ test() {
>   	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
>   	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>   
> -	_nvme_connect_subsys "loop" "nqn.2014-08.org.nvmexpress.discovery"
> +	_nvme_connect_subsys "${nvme_trtype}" "nqn.2014-08.org.nvmexpress.discovery"
>   
Same here for nvme_trtype.
>   	# This is ugly but checking for the absence of error messages is ...
>   	sleep 10
> diff --git a/tests/nvme/004 b/tests/nvme/004

> diff --git a/tests/nvme/018 b/tests/nvme/018
> index 4863274cc525..43340d3c4d25 100755
> --- a/tests/nvme/018
> +++ b/tests/nvme/018
> @@ -29,12 +29,12 @@ test() {
>   
>   	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>   		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port ${nvme_trtype})"
>   	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
>   
> -	_nvme_connect_subsys "loop" "${subsys_name}"
> +	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
>   
> -	nvmedev="$(_find_nvme_loop_dev)"
> +	nvmedev="$(_find_nvme_dev)"
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"
>   
> diff --git a/tests/nvme/019 b/tests/nvme/019
> index 19c5b4755387..98d82ae21b42 100755
> --- a/tests/nvme/019
> +++ b/tests/nvme/019
> @@ -33,12 +33,12 @@ test() {
>   
>   	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
>   		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port ${nvme_trtype})"> diff --git a/tests/nvme/004 b/tests/nvme/004
> index 7ea539fda55e..af434674beaa 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -22,7 +22,7 @@ test() {
>   	_setup_nvmet
>   
>   	local port
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port ${nvme_trtype})"
>   
>   	truncate -s 1G "$TMPDIR/img"
>   
> @@ -33,10 +33,10 @@ test() {
>   		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>   	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>   
> -	_nvme_connect_subsys "loop" "blktests-subsystem-1"
> +	_nvme_connect_subsys ${nvme_trtype} "blktests-subsystem-1"
>   
>   	local nvmedev
> -	nvmedev="$(_find_nvme_loop_dev)"
> +	nvmedev="$(_find_nvme_dev)"
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"

Since we are touching nvmedev can we move above uuid and wwid to
a wrapper something like _nvme_show_uuid_wwid ${nvmedev}n1 ?

>
> @@ -36,12 +36,12 @@ test() {
>   
>   	loop_dev="$(losetup -f --show "$TMPDIR/img")"
>   
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port ${nvme_trtype})"
>   
>   	for ((i = 0; i < iterations; i++)); do
>   		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
>   		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
> -		_nvme_connect_subsys "loop" "${subsys}$i"
> +		_nvme_connect_subsys ${nvme_trtype} "${subsys}$i"
Same here for nvme_trtype as first comment.
>   		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
>   		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
>   		_remove_nvmet_subsystem "${subsys}$i"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 6d57cf591300..191f0497416a 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -6,6 +6,9 @@
>   
>   . common/rc
>   
> +def_traddr="127.0.0.1"
> +def_adrfam="ipv4"
> +def_trsvcid="4420"
>   nvme_trtype=${nvme_trtype:-"loop"}
>   
>   _nvme_requires() {
> @@ -62,8 +65,8 @@ _cleanup_nvmet() {
>   	for dev in /sys/class/nvme/nvme*; do
>   		dev="$(basename "$dev")"
>   		transport="$(cat "/sys/class/nvme/${dev}/transport")"
> -		if [[ "$transport" == "loop" ]]; then
> -			echo "WARNING: Test did not clean up loop device: ${dev}"
> +		if [[ "$transport" == "${nvme_trtype}" ]]; then
> +			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
>   			_nvme_disconnect_ctrl "${dev}"
>   		fi
>   	done
> @@ -87,14 +90,20 @@ _cleanup_nvmet() {
>   	shopt -u nullglob
>   	trap SIGINT
>   
> -	modprobe -r nvme-loop 2>/dev/null
> +	modprobe -r nvme-${nvme_trtype} 2>/dev/null
> +	if [[ "${nvme_trtype}" != "loop" ]]; then
> +		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
This is not from your patch but I'd keep the error message it has
turned out to be useful for me when debugging refcount problem 
especially unload and load scenario.

> +	fi
>   	modprobe -r nvmet 2>/dev/null
>   }
>   
>   _setup_nvmet() {
>   	_register_test_cleanup _cleanup_nvmet
>   	modprobe nvmet
> -	modprobe nvme-loop
> +	if [[ "${nvme_trtype}" != "loop" ]]; then
> +		modprobe nvmet-${nvme_trtype}
> +	fi
> +	modprobe nvme-${nvme_trtype}
>   }
>   
>   _nvme_disconnect_ctrl() {
> @@ -112,20 +121,33 @@ _nvme_disconnect_subsys() {
>   _nvme_connect_subsys() {
>   	local trtype="$1"
>   	local subsysnqn="$2"
> +	local traddr="${3:-$def_traddr}"
> +	local trsvcid="${4:-$def_trsvcid}"
>   
>   	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
> +	if [[ "${trtype}" != "loop" ]]; then
> +		cmd=$cmd" -a ${traddr} -s ${trsvcid}"
> +	fi
>   	eval $cmd
>   }
>   
>   _nvme_discover() {
>   	local trtype="$1"
> +	local traddr="${2:-$def_traddr}"
> +	local trsvcid="${3:-$def_trsvcid}"
>   
>   	cmd="nvme discover -t ${trtype}"
> +	if [[ "${trtype}" != "loop" ]]; then
> +		cmd=$cmd" -a ${traddr} -s ${trsvcid}"
> +	fi
>   	eval $cmd
>   }
>   
>   _create_nvmet_port() {
>   	local trtype="$1"
> +	local traddr="${2:-$def_traddr}"
> +	local adrfam="${3:-$def_adrfam}"
> +	local trsvcid="${4:-$def_trsvcid}"
>   
>   	local port
>   	for ((port = 0; ; port++)); do
> @@ -136,6 +158,9 @@ _create_nvmet_port() {
>   
>   	mkdir "${NVMET_CFS}/ports/${port}"
>   	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
> +	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
> +	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
> +	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"

Do we need argument count check before we apply these to configfs ?
>   
>   	echo "${port}"
>   }
> @@ -207,13 +232,13 @@ _remove_nvmet_subsystem_from_port() {
>   	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
>   }
>   
> -_find_nvme_loop_dev() {
> +_find_nvme_dev() {
>   	local dev
>   	local transport
>   	for dev in /sys/class/nvme/nvme*; do
>   		dev="$(basename "$dev")"
>   		transport="$(cat "/sys/class/nvme/${dev}/transport")"
> -		if [[ "$transport" == "loop" ]]; then
> +		if [[ "$transport" == "${nvme_trtype}" ]]; then
>   			echo "$dev"
>   			for ((i = 0; i < 10; i++)); do
>   				if [[ -e /sys/block/$dev/uuid &&
> @@ -233,6 +258,6 @@ _filter_discovery() {
>   }
>   
>   _discovery_genctr() {
> -	_nvme_discover "loop" |
> +	_nvme_discover "${nvme_trtype}" |
>   		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>   }
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
