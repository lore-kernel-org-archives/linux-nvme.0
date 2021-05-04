Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988BFC433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 22:04:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCD2613C1
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 22:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCD2613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nhHlzvZYyAG54BULpzfCx4vlp9iamIqXO+3q2XDHezw=; b=iv95PMrh9hf5LO46jcZ/14Uhp
	RhhAIrgLXJQOrzndROCa7jdJSDzMGlut/l+h+AWXPK/Il3GHAgE5p/9//3CKSJaHkQaba0doCAMYk
	dYFOWoQd7Lx37UQJh/aZJmaunDldm0+dYulkGPoXjj00SPy7Y+7129eJ7YWTBnbZW+vSDB+k6RJjQ
	8wKvzAJFcMvWpk2xR7GyOAxBWkdvneSKB542BuACZdvhaICPNOU1lJNNnw/Lxbm5J9QLcl+cb89AR
	OiIlWys/XD5kgMQuAFWIq9KVAKF1SjOsDMcEjV9eXmcd+eH97Y2L5cB1VmLwBprj3AsXhHDKlpmif
	qpAh0SaQg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le38i-00HCWu-Eq; Tue, 04 May 2021 22:03:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le38g-00HCWT-3A
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 22:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=Txc3K91Hut7UkVMepw9gh2p8FM+wVJQNZa9saxlmW8s=; b=knu1m411ctZw7wNbIRpznXqf6i
 Xurg41c5iymJCCgBzC5KxmSd4BPB1q0QcCFT++mwUm5gsUQcuTMeSndClMs9K6XwvriUEy9cm4iUL
 UETht26pdFMlb8BDxFhMqc87KaoE6wcdhn+YXE7p+xMKRn4cwS9QsboQw4eBf4b7oNqWHx3r4LiJi
 hR59nxsJRb7spMSAoUOOtD4tsSY96xeCaAAOp5OjmfRp2EAic1/3Q8oq9Wnxv8IaE9LAJqvuDxnkF
 EyGw9kFTl1X0Cz+BeI+/icoa/yA1wU5aiEjuwnL6BurX/+OHz2VGOq8utkyUjdus7/wT7W6IqTVT6
 GIfR+jIw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le38c-004IZ0-I9
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 22:03:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620165810; x=1651701810;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=uez/gnhefmI1fWpR0Bj4esgMuGv4Re/2lXQhMCtNvjk=;
 b=mwkJF59foUeVgVJlK9TZVde36NFtjm4QReectTRLbAerSkFW6IyeVtaO
 wqxxtl+OzwhwKKZHRw1OiLKIXsKAdIWObzUUhVPEYkFhwEFk1c9H4bNSR
 Dp826nS8v9bFa4Li6cLi0OmaaqBoRKiIXlzwlAEpe/oVgoQpLSHgfd7zh
 KAUbFgNgOZR55gFRapNBtzaq5+iZEPGW2mW+sqw+q6VQ+2fwSsgQmH7eu
 3TDznlmcHKyfonRzi3FA5JtntI3pG0GTfc/e29KlLW7urJodb0LjwEQSN
 LOZcGqZk0DV/SPw9Naj8aht9OkZWeLBiYsvqLQxQh4WvIYkxRYQTAQEQo Q==;
IronPort-SDR: uKR4xqIAypZXq8etKCBBnsEGY8P464DS7JGNk7LT4G21ue8vFUJ21B0NPPS6f9thG6o7tOnHDe
 0LDikJlEZj/LTdHFC65oa3pIxnivHtUtua+7CAEitWaeImV+Br+qpp4UsaXo7R6YFbgmA+A51w
 AGcj+pJhaKVHLQ22QqIvKQuvaU/iMNugvGmwIyCj1a/SLVZ1oTcryqZ2OtZ44NinO0xC5BnwBm
 gDW2qWFXMVE+Qjx0jAr0yLvgz8QK2udRun7BKAL0u6uA+q2l4hugRZWaxGQsxbyQvW+4ofiI11
 91w=
X-IronPort-AV: E=Sophos;i="5.82,272,1613404800"; d="scan'208";a="278238469"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
 by ob1.hgst.iphmx.com with ESMTP; 05 May 2021 06:03:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQzLxNVg8m9E1wOz1I0kcnbfUEtrXUKoQx9vFqwt2UD9ZBKSA/Py2zDLFBhTmTTAhfbrkz8dXB0lN8VNX2dreQlzImkfogF5Gzy8jKUxejZs84it3ran6fwbzUsAHUGghWCnNOlQpbjZVmZ6pYTyScTa9MrCOFCOvtzApRtxcUQRQn8hv7gRC5fChMY6MPbu35mzIxFC8tjlkuBb1OSx2nf7mkbZb9d6xZVLi/UN7mkuxzsHuLhnbrfTMS38kqa/gmUTNWOACUMixp2Bfym11w2U0/TrgfNgZZQgJtuqzLTD6BEm3koqiCpy9dtXhb/Ek8JDciI551hXpD4JaKpzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txc3K91Hut7UkVMepw9gh2p8FM+wVJQNZa9saxlmW8s=;
 b=Y/lvGxKwn1Fu9kwtlBo+UK02sUddswJ6tyBQ+nnL+1UEclsV5iNBVcp/tJuRAn6l2ama/uJHTHZIwxdmjiP269d4ZGBZ7c8wXOMyJpXNSYhmfX40VI8qWxi980IxEv/zYIEzODugdYJLOkkvUyZsQ+to5aBilSWRFs5L90uWSNmG8zlkS4t/y8w5rwLvVRAoRXz3W4l5vh4LD944lXHVKwTkuVy8lPhiH7pceL2pMLVYYd3QeETs3NVKU3NDgH8WYfFMWzC4zKmRGUksJDy/oXjms9E29G8gzEutMqrtMd4RyJq/Uf+ZGPwu8IYzanxv0hbrpK/Z4Fl/Tm//ONyPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txc3K91Hut7UkVMepw9gh2p8FM+wVJQNZa9saxlmW8s=;
 b=KuOmWXJQSKzh0OKB/aWiz9SuFkhgD5SzLSPh+e54PtvNG7GPcI2fKf7j0O9UgaHUli4ESHZ0sjzVuER8QGmDZAJtb0PASmbq8esH3htF4lDpKksh1UHSQCR4dvi0SPPRy6ASzXFVaLPyXDQfhSdoq2g+c0vf/WBpuwyxFrCXtx0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7662.namprd04.prod.outlook.com (2603:10b6:a03:325::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 22:03:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 22:03:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvmet: check sg_cnt for inline bio for bdev-ns
Thread-Topic: [PATCH 1/2] nvmet: check sg_cnt for inline bio for bdev-ns
Thread-Index: AQHXPSeof5HtO0vA90qUGNfJ4B0BTg==
Date: Tue, 4 May 2021 22:03:27 +0000
Message-ID: <BYAPR04MB496590BD6ADAF0BF37179C58865A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
 <20210429184357.9185-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af17b07f-b5bb-47b7-c8f7-08d90f487203
x-ms-traffictypediagnostic: SJ0PR04MB7662:
x-microsoft-antispam-prvs: <SJ0PR04MB7662DE312C7A2542D3A05F3E865A9@SJ0PR04MB7662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ZxNXayXtKCtW8wU0Vpv3a02Z1t4zk3qH6xIe3G5LbJVayYTmd+QslnmnVuCsQ33HZP61je4rH7kBNnE3EBQrwSsDhk5JxzBO0PGtw8V2BJMCMXQ0MRYCS6wkryskDvddarLK9xAP2xQ3jQAJRAnfhrsbU35PhY/Q/xwYZkP/9Vk6XFMytUoO7nofkR41gsscnR055beG/Y6+0sp7+sscfZ4JEgb20GWl8+bwUpHMActfcfyFHY8RSuFpNh4G08i38GOBYfJ18KF3B87IyEXdS+06xm3inKfy7XqrvS7SElaFS2Qk2ZjIrTe+1t409hXuwWFA+5B+RsS9MW2RqvFoQPxkgplDr02vBnJt78hHBZfL+M/SNgyR+5CjB0iiM1uoRAGXyMuVLFTjqnZDFw8G+kDpvFuVp2RyD8r9Dodvd0zQZ+scJ6VJGiBheVu0a6aCGM8O9RqnSNYLJhwsCvtvJOmFMHGVJDAIZx+n6jeNuyzK3gYQmwROBQlQ52KDG3G6yhYXdaI53i+xKc6FaGbOSOLcOy+ObihIPSOe0m02wPS6Lm00Y3oaT28e6cB4wC4NzQZV6Mn3xITQe0wSrrJmKGSQLm0X3XRgvkRVdrkCy8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39850400004)(346002)(366004)(6916009)(5660300002)(26005)(6506007)(52536014)(4326008)(8936002)(38100700002)(122000001)(86362001)(2906002)(186003)(316002)(54906003)(8676002)(53546011)(71200400001)(66446008)(66476007)(66556008)(9686003)(33656002)(76116006)(91956017)(55016002)(478600001)(66946007)(64756008)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D3I6SpUdJinekW7AfC8H7Kc6BoH0kM+0KxOt2pvrG0VWbvBLNclKmsFzE3Wj?=
 =?us-ascii?Q?udzLB8eNM8CnpNLsXph8Gr1b7gSps0kr+e0Xv676uraMvnIAvOmJG7pfuiDr?=
 =?us-ascii?Q?Kddl1WP8qSgu6XyhqIn6e7ypGNXPgM4wcDNrgiIXNhQCAlLeMI05N/u6jS7F?=
 =?us-ascii?Q?CtB9k9wBJNHBmqVOsboL2Wwgr3dMI6+VEDRllhIDRjbAQBI9UdRBmkVOB1HT?=
 =?us-ascii?Q?+GlTxuiCNROjemtYiQ4INJq6xVxe4Fj5l2NchovR6jnR+yv3FlmVXMPBElfV?=
 =?us-ascii?Q?KIu4v3EeM7+/Fh3tlLVq0bE7W5v8eAsFPSxonFQHMiNS+yhWmKrEgeim7k51?=
 =?us-ascii?Q?mXbUhNNwVght6Nb2Z4tklqfIwo9xDgZvwV6dfqZ2SoSF1Bp8PW3Du9khKQOT?=
 =?us-ascii?Q?lHTpRH3DyH7ZJClO2Uhcsr9uzzdWa076B1gIPjjcURFToLahJP9WGjRo3rRz?=
 =?us-ascii?Q?1Lc5yEbKrHnRIp+MqnAvr4pldd8vmpn2/UsoUU1LQRzFu5DhkNoe4OOsAgi6?=
 =?us-ascii?Q?e+1knfTf4L+8/pliOCIGv+whGm80tmAyP3Kml/Jq83oaGAsxStAoxLm4a5tC?=
 =?us-ascii?Q?Q0UV2Qgt+gLXs0G/iVqXVKkx6QuZWJ4//plh6qKYntPPhBAiekVS7kRBKHpZ?=
 =?us-ascii?Q?HOqC/VNLCVlJeI8FDmgwFJ5tdelUx+D9Z+UBUFQC9KY2cNwNWcDSJxbev0gk?=
 =?us-ascii?Q?4YTJA10gs65uEXeCYFJn16GCIG+Z2QLmLmTLdje0NwwPQ0ScGJuZCGprULis?=
 =?us-ascii?Q?5FbUIJjOQZOkCWVKui9BfWrAHl7dLnchHrbMZ/g++bBf+38gCtZ8NahqsY9G?=
 =?us-ascii?Q?7ZSdTvlZ3ysVMKqGl+Fv9vnYoGj0GaUw/MpkqVfkQqqci7ri0x55W/a/mGsC?=
 =?us-ascii?Q?YtOIC5wTMRqU8RUGN5F7CxnqzKJTHSvRJsnmoomZzaHCY0suZ2iV32BoX34F?=
 =?us-ascii?Q?LIJWKmmuQARl1LdwHGNKd1gT6pkt6467cBwuyEoP5faK2nbdtCrcuPip17VR?=
 =?us-ascii?Q?c+Xq7Pkp6bFp1GTbgANVddSfD44m7Nojat8vFC78e4AaVUPzmUgycU6M3UJg?=
 =?us-ascii?Q?LjMCozegOQQcGskH4oearh5TGk2jEuCd2luXS5NFdO+PfEt6s2U3ggF768Zb?=
 =?us-ascii?Q?kx+K19eYC1+aVgsjueU+NqqyDMKi6JdArRPjhJrj62k4vUCjX4KAnKrg8wgh?=
 =?us-ascii?Q?yjoI2QstRjosRf2jQjzTKGUo1KLjk/kXPaWb6ArrtLax343JwxC0PjFx9FGG?=
 =?us-ascii?Q?Tw6drnmuzwSVJVNaffUS1eK9gYLWWsX06q5p8yt9jH2wVs8f15G9ArFjh5a/?=
 =?us-ascii?Q?02P0Fu1TyNUd5cxrusJW42wI?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af17b07f-b5bb-47b7-c8f7-08d90f487203
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 22:03:27.3798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkwDbWIhpOIYUq2wJgy5ug/aNkLby43Mlbb/wjYTwt2ebS86/4wHtNQRGVJe4NfudvO82mwYj6GOsEd/hOUSe9pgkfUapW0kZVDQUiYAAkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7662
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_150330_666996_7D219284 
X-CRM114-Status: GOOD (  10.48  )
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

On 4/29/21 11:44, Chaitanya Kulkarni wrote:
>  
>  	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>  
> -	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN &&
> +	    req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC) {
>  		bio = &req->b.inline_bio;
>  		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>  	} else {
> -- 2.22.1

One more thing, in the V2 to avoid open-coding in bdev and passthru (and
ZBD)
we should add a helper ?

something like following untested :-

diff --git a/drivers/nvme/target/io-cmd-bdev.c
b/drivers/nvme/target/io-cmd-bdev.c
index 9a8b3726a37c..429263ca9b97 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -258,7 +258,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
     sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
-    if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+    if (nvmet_use_inline_bvec(req)) {
         bio = &req->b.inline_bio;
         bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
     } else {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5566ed403576..d69a409515d6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -616,4 +616,10 @@ static inline sector_t nvmet_lba_to_sect(struct
nvmet_ns *ns, __le64 lba)
     return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
+{
+    return req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN &&
+           req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC;
+}
+
 #endif /* _NVMET_H */



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
