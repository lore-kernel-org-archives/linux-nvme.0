Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01211C4363D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:02:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707432054F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DwyJa5fZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n43h99Xz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wXsqeRmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707432054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=zNqEJKtsJ7yGGFPeCBWJRRQw98x8Qtmeta5GI97j7t0=; b=DwyJa5fZ9mY7Fl/q20VuixPEp
	uIck0iSVmxAgNEIImjkdZWV50TMZyUikHvBICVVzAq67CRZHx8QFOaX8AfKN73Vku6wOD98NS4V0t
	rdkGtyPOClyHJZHZvqkH9ON/IViG+V5+8kW/47WFvGp8/sGG4bnuzL/H1yXgCxEakn/Qpmu58GKj1
	dTRteP7WDLziqdWTegEVKlWbvHTETE6TTYU+mA2Xl1elDiiDSSfMB9cpl8/KR8YUfYwRi7p7Ci0ze
	oLFzpzC20Mr3r22wG+TvLE+31XUAHm6dnllL8zKvUZx042mM/b//DSWPNLk3iBDXwMPyl8sCUHuJb
	GIcmU7OMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwuO-00019J-PH; Wed, 07 Oct 2020 00:02:16 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwuL-00018D-PN
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 00:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602028934; x=1633564934;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ljdPZKNshwOcCoiKCGzJN++GZTIK66ghb+NYu3NK+JQ=;
 b=n43h99XzX8T2Re7d8TIs2PeGUOhzVtGvzU/ZkhOLV/kjaNyShvFVdyA+
 X7Aa6Cu/Vnd0uY7b44gk6O1qUN0+ay1nawfyjNwO7imz7znuCMY7Tlmej
 0cnnf2Q2CZ0o5JnsCxBZZ3F9JVEvnNFAtFSA9v9VlX2ZYtjlMHB+p+Ah8
 rpeWEjwb0SiK7l9GIT1uMYnSGB/UbRGDD6XcKbAq8vt5WZk9u4xdJvRzJ
 XzDjzsE3MIM8eytVSFrCNhGUBC0nTCBQ3PSz48mMZMl93tRiO/W8Uhc1y
 Ka3e5QbzwkZQCAsrewFXFC3pSGIBLiF5KidHbFUAcKzvTEksG1pUcSh2v w==;
IronPort-SDR: lzonD3ADaAweDDA8oUGjyHCKomte3Bu/pE4smydq9Eea1oPgzu1OMATtVa3kukQuBoWU5RUIvv
 z3KJmFA9BNTjlRxpjz5BOR5eo7N9F82EUrCnnp7DRhKShJ+YRJUHRLKv4uBmylDQOBeF2+Iwl1
 qjQlUlcqg5yKpGQEiStiWkvej1XPWVd89zQXqWZMu0tjjkbYR1/q1vpgUNrbJ1Y6n659Mk4sZC
 EeyOpAB2UR+d6FYqwb6KY86cEaNog/VTvcbV35JTjmKM7xOX8jDNdXsGFX1Ux/86rusR9CIoBC
 3x8=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="149280027"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 08:02:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkhRyaLJW9CtaXkCNgZZLwW3gorKypgmuDK7n405QFD5HgQjHqahu13orfEsKFHHxH2CLy7dt3qxWAESoH4cQMeZUWXFtHOucEGzLEqf27Uf8nrYpeE4lgjW1/UL1ihcE6ZYTd9v8b1YMQUgnCl5n7tq7TLkycfJTav4uzgQP8s8roQdb1H4EBNYFFpxebObejvLNDqepZIF6k6v/6ixpoSqWv/2VeuxzmbJoM9Bi2+CrRCFwP+akP+SRrhUD4tXC8kSRpreKUhr6vS+6ddabwKm9JW30eDb71jG9llOTvuVhlnF+dXo68Yqq/QNQjxF8lNRXunzSdfcGh2teacUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3nEjWpZIMaD3BPDMc6LGqquELG/PO6E6QuxWuGou/g=;
 b=PWrpFG4V4sADC/ZLjuBVeG3GSrkltNDe6CmDdsStgo2/E/HkSaffniR08VuWAsVcHOqWk5finca3CGGmsfXjHN4cVDqdDpt2l62iZwCAAknGKzr6PmxJM0fexGvFm/L31zUMLj/aQJF+dsdIXHwnfh5zYp0Fua1YujtN0YzojKqSrte+tK3L2umf3kRbDq9khebQN7wVHoWZsX1z+y4F69DTQ0qa7E1GHTBd0IrzGTVURhzCtk3ZnS3I1qA4+2RRl8sA/1qDZe3O9AumXhmfC1McxwXI/VIgwPqEqwVn51PLzi6mwYEKX7FQ0rQTNL2+zGgeCa+TlEJQcu8DlK+dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3nEjWpZIMaD3BPDMc6LGqquELG/PO6E6QuxWuGou/g=;
 b=wXsqeRmmwTbAT0NsBG/2F2i5SmLVIbYWKBe6GF17Zzynvy1Ez6G9HOSEXJ6h5BxqaQgy8lxY0E7bK3FsyQ/9zM6Kvq7H/gZDpFqZtq6LcCbXLZDK7QnhPE/kxsSBQYMCwbdAD9cYVtFvHU+HSqRhNL/XHRVqKyY5K9D7hKMw6aU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4037.namprd04.prod.outlook.com (2603:10b6:a02:aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 00:02:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Wed, 7 Oct 2020
 00:02:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests v2 05/11] nvme: Add common helpers for passthru
 tests
Thread-Topic: [PATCH blktests v2 05/11] nvme: Add common helpers for passthru
 tests
Thread-Index: AQHWl1wk5ovaYXCvmkSyan6E05rb7g==
Date: Wed, 7 Oct 2020 00:02:09 +0000
Message-ID: <BYAPR04MB49654DCBAD729B05759EB6FF860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-6-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45edad90-7299-4181-7371-08d86a543c7d
x-ms-traffictypediagnostic: BYAPR04MB4037:
x-microsoft-antispam-prvs: <BYAPR04MB403784CC726EBA4AB56A1B0C860A0@BYAPR04MB4037.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oJ3P/SQEq5NiwhiHSAlsSiAMnUFyjPR7wZWVKmuYQRUSeDLk1dmr1KSOJdj87ibhLkLStq6AouDWJCYq1B5wMchDge5VB9PPmaDE0SypISVktfHIlmpTSs8Ptr0A/M8OoxJri7w6m4P0Nvj38WUNGONimG9kNNbuuZRgPu8qYMZjrOcW5WTkALs+P3iNkkQ4+FpkYgEfMDTChVcs68EdS1MuPCM286vyv09M8UPvl1t/pAyKouD0xaxYnXtLEA2Nr3fClpK0IxbtjDuyKCTvJ3YN2NMwuXiBK61XB7GA6JMGmNIuUg+YtjHaM5K/5XhA/G3fJDJZJotYFsBAV/AyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(66946007)(5660300002)(86362001)(83380400001)(76116006)(64756008)(66446008)(52536014)(9686003)(66476007)(55016002)(26005)(66556008)(186003)(4326008)(498600001)(6506007)(7696005)(2906002)(53546011)(33656002)(54906003)(110136005)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VEP18dS8DHEQpr7uNIvXeiPCxM5YtJIjKmD24Tq2TUa+9sfF7WJII6HHJi+q7ze/3kMm3rQiNOqX/QNwTAWYzPt89OKZjLcnduw4Xwc8guW12f6u2fo6QHUDcPAvCwTQeBgMgiiwmkdSuPRXwbdWmzl3Lp3py33+yEYyo3zoEbZatEGdDKGJSn7TdoLxTDREeSFFwO0NxTljhTnDMgoUb+C+AHME6hWRa1OyNjTQb4UxfSV0bU2G6RpHWOYJvaGX+l+OP26mZea3gwGRDyAk7iA3RH4kdTnsLgAz8IAbc+6RX5PLTXEvzYkqHry47jxs6+EMQqk/7hAFc6Nhf33mM+yXknIKcHBFvFSqZGRqAPGqVQTzUug3fxyomV05c2Uug3n+wyg/ciWH9ppFhGsH6Jv1Acla3wbaZ6zHF/dJbtc5UqDnlqJaPlsvwA+pr0t125DbSGCcw5wJTIjHnNsW/RIi6O9AmqNeT4uFlIUfCMCQftaPG8j+AWxPVwb5FFmswEG5c94tVV4zUXcpXb+ps+9K412XGIirqjRVxfwnulxlaY3pOWVBFqukdl87ZHA1c0JuR36RpByoMwFXQVUrLh4O6loPsqbCCuuDtObghfdTnh1ZVL7zrX8WyJZ2BvJEPtJhvS4xRug0F62g4HFV4g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45edad90-7299-4181-7371-08d86a543c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 00:02:09.6127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TBpTNX0tchE/OO5Nqa1ZbbidNnhtkT6S9RI8yv2W/K6EuENFzrmq5e+mF4gxA/GC56aid9eGnxoVQnhBeh+m3I0JpdFcMy73g8P4M0RXvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_200213_954820_D2AE2C91 
X-CRM114-Status: GOOD (  17.40  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/30/20 12:01, Logan Gunthorpe wrote:
> Add some simple helpers to setup a passthru target that passes through
> to a nvme test device.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  tests/nvme/rc | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index dfa57a299625..1ea23308a3f7 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -73,6 +73,17 @@ _require_nvme_trtype_is_fabrics() {
>  	return 0
>  }
>  
> +_test_dev_nvme_ctrl() {
> +	local dev
> +
> +	dev=$(cat "${TEST_DEV_SYSFS}/device/dev")
 can you initialize dev this at the time of declaration ?
> +	echo "/dev/char/${dev}"
> +}
> +
> +_test_dev_nvme_nsid() {
> +	cat "${TEST_DEV_SYSFS}/nsid"
> +}
> +
>  _cleanup_nvmet() {
>  	local dev
>  	local port
> @@ -257,6 +268,27 @@ _remove_nvmet_subsystem() {
>  	rmdir "${subsys_path}"
>  }
>  
> +_create_nvmet_passthru() {
> +	local nvmet_subsystem="$1"
> +	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +	local passthru_path="${subsys_path}/passthru"
> +
> +	mkdir -p "${subsys_path}"
> +	printf 1 > "${subsys_path}/attr_allow_any_host"
> +
> +	printf "%s" "$(_test_dev_nvme_ctrl)" > "${passthru_path}/device_path"
> +	printf 1 > "${passthru_path}/enable"

can you please echo in general and printf only when it is needed ?

I know existing code is a bit inconsistent I'll send a clenup to make it
uniform.

> +}
> +
> +_remove_nvmet_passhtru() {
> +	local nvmet_subsystem="$1"
> +	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +	local passthru_path="${subsys_path}/passthru"
> +
> +	printf 0 > "${passthru_path}/enable"
> +	rmdir "${subsys_path}"
> +}
> +
>  _add_nvmet_subsys_to_port() {
>  	local port="$1"
>  	local nvmet_subsystem="$2"
> @@ -292,6 +324,50 @@ _find_nvme_dev() {
>  	done
>  }
>  
> +_find_nvme_passthru_loop_dev() {
> +	local subsys=$1
> +	local nsid
> +	local dev
> +
> +	dev=$(_find_nvme_dev "${subsys}")
> +	nsid=$(_test_dev_nvme_nsid)
> +	echo "/dev/${dev}n${nsid}"
> +}
> +
> +_nvmet_passthru_target_setup() {
> +	local subsys_name=$1
> +
> +	_create_nvmet_passthru "${subsys_name}"
> +	port="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +
> +	echo "$port"
> +}
> +
> +_nvmet_passthru_target_connect() {
> +	local trtype=$1
> +	local subsys_name=$2
> +
> +	_nvme_connect_subsys "${trtype}" "${subsys_name}"
> +	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
> +
> +	# The following tests can race with the creation
> +	# of the device so ensure the block device exists
> +	# before continuing
> +	while [ ! -b "${nsdev}" ]; do sleep 1; done
> +
> +	echo "${nsdev}"
> +}
> +
> +_nvmet_passthru_target_cleanup() {
> +	local port=$1
> +	local subsys_name=$2
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> +	_remove_nvmet_port "${port}"
> +	_remove_nvmet_passhtru "${subsys_name}"
> +}
> +
>  _filter_discovery() {
>  	sed -n -r -e "s/Generation counter [0-9]+/Generation counter X/" \
>  		  -e '/Discovery Log Number|Log Entry|trtype|subnqn/p'



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
