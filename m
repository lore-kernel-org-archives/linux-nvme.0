Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE421C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:42:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56E62073B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nmIQfsGy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SOkFr38o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hPn82rRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56E62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8r24Yq2xWPp9J05olACZOwdvS/mhOknPPOCGkIT+gwI=; b=nmIQfsGyNnAg53ZRNgwgy7BgJ
	pM6MAm6iLCWGpfnZEcb6jrzuvwHE59sWDwNS40IRDfE+8FhuBZfcp2AFUKJ+FtN9Snbt/v3AoMNvq
	7JsqrSa6SyW29l/bIlsV5ppGnHuexpitDg7czrJwhoVgBJnUpEJV/pGdP6rL1XUeaWiSgPwAsc/yP
	H7GYiXCBmdSxB0jTjV0pLJFHXYu1rJMnhA1K7lPiUBGV2sgHrz+sVnV0XBc2+/0g2n6tk48AzuhEc
	Xt7Y+OJ6SuhBs2AvQvwSMpM2V7FZNZpMTtNYJpDK6RfyK6btx0zhYrAD7ZoJl+bERF+y+y/ab9cfL
	cBGFVhAHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3sKU-0002PS-PA; Fri, 07 Aug 2020 02:41:58 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3sKS-0002Ne-1D
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 02:41:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596768116; x=1628304116;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=hCmVDY56eCE3rqC5nDJaSHVjsMjCgPEn1uRcFW6bINU=;
 b=SOkFr38oAvBzaE+VRV5vsidUKu8dI1wSkA9b6VPt5NRWKdKFYnAOIsyH
 +U4edf1DRerUXyR964LQRtW0y9v7xiUFmOXw5jnnYdyFIwtSRLAMEGd4/
 z1K/ihVEETVAK308JXZFMYfjj8D1CkpHI1gOUezDYDrVi2lhABsJev5g3
 95RBUewS+L+8IZsZJdQe6urXvfyNteU2LR+Mxfs7UhzLXFgLtBq1qiI6c
 YnD4ZSS4n4SAKHjHjEy87CNigxvoMQxi9qkq88exegE492YZmtN162nx5
 qK7W8quGGsgCocWDM9VM8llc9Fp4eWLgLruS2+mKG+R3efVdDqmJIpvSc Q==;
IronPort-SDR: bTvK3PZs2slOx11Hep3FUO5B4C+bUOgaizc1lsk6vMHv2v2dkF3s0aCdTCl5uFytNHNfzJ/lIn
 uZUny3OVchATQxgbVOkmbY04rv9fu9MJMrWXwfgAsZ4c8LTwlYVJJkUmQPRyqs9mkAxWZ+06Uc
 h1piXbKyDddpIsirJDSk7cH+6w+UiW/7i9t8qNPrxjY8u/pukbAOARYoKC6wQRv+3ZULs6uMye
 lmp0NHO4oiVLrmUekmzrnqthpZPIeZLm0xggdnvPNVRmcvoREJxMaj9/OP1PZoNbVW2F3OeFkR
 1dY=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="144357202"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 10:41:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWwUHRGL6rgM+Dq8E1gX5j6sRaMDhvVEyj0h0gRwD3S8Y+7LUYR9pJnkBcOSZS9p/37Q8fgEg+smNPoIy+e9Xl0aozC3S46zVdbyDs+LXS6D7A8/REnWBamnqj9v/xfJTQpP8wxfNZUIHA87e63rHLmuIHLeQDYwc2R3EHm8dW3HqOLM1ywYTytmJFPFXhm2UKUPP9gOG3y9aqUvHUi/ulYVxlYpyT2QR1V+emyF9Gl7tE88KQ7LeNoJvqWaNM9vj4Sr0ve99C72KmvjjYYYrgKOMYdonp6rC3CBHjuNQuAh1n393//O8KrUIv8gc5hLp/uUDXSowl0AinrAVtbMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i+udeEHV4Rdjxo+GncffmE/pQc+wiphZHop3o6n8Xs=;
 b=Utor5rvmJC4lkk71AThGFYJDZkd1+X67dlsFE/Pegi+kp/8iIphNu7VFePcFiAwMlzwOEqOEXzOCozk++B0vSqynJFjispuDP281SR9k5ZGeeD/eEFui4Zhp/X4zUwQ9zmkM+VXJsQm8ywVqFHt4Xi2RFfWcieu495fTaEtAalasVJkybFFltVeEupUuR6uxco7pb0fFN3PvI202+LpdFn+x8RWCl32bXAGM3WCXrUpl6WyEfw+iMQH6omoGej492WBL4Fn4LS/LBpp0HNfbaGY41P4qy0C0IWqSKLNbhX5A/dAZIHqqic3qCExdT9pRCSZKw4LliCQEqDH2DhOeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i+udeEHV4Rdjxo+GncffmE/pQc+wiphZHop3o6n8Xs=;
 b=hPn82rRJ9Q+UuukTJ56dsU7zEOkXHHqUHkP6GW7IuSBx4Q6uSSThNeH8DcadSM0Vf3ylRY5BG8GItesoiBSHvneGnvAor8XnNjJ/W5V3YhDQv8T0Gl9Yl6Ms1G9dcNyJN9l3uX4ai5/nfDuwg8YYQHt4cehVsbAzRKlnBTArupc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Fri, 7 Aug
 2020 02:41:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 02:41:51 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 1/7] nvme: consolidate nvme requirements based on
 transport type
Thread-Topic: [PATCH v2 1/7] nvme: consolidate nvme requirements based on
 transport type
Thread-Index: AQHWbCXx6BGxwB51RUuDED18RBEkOg==
Date: Fri, 7 Aug 2020 02:41:51 +0000
Message-ID: <BYAPR04MB496546CB79B5F7D4F4B0A54186490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92b32610-50bd-4a04-0552-08d83a7b708d
x-ms-traffictypediagnostic: BYAPR04MB4871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB487166AD95F433BC9895B1CA86490@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XX0tl6y9RjhNcGAvLCYctq+g3NPx/6u0prCAMmS+PK3xPDtqtIciqLkPfWEmQ0WtXdSEbsQlZxH1lnVEt1vP42HhlX4rX0D0ia24hrRvaoYRBlcIY3mngwhElEWcypWGHEtuAWUJGdk+cEOwfKXsBDIhHbEftRjP11q3eh1estZkF2MCzx8qebjrvz3/7WkLBJJ34rEV1bc0B4phxFnFafQDio9IHgV3yWI7Em6cHZvXVoh9qjQ2TYtirtgxHHBwssp+ktv8nSiNzuX/yQk4eO5pFx7lWQi6/FUWEw4a48KuF8OfqIp8QYGnInmlFFBnZmS5ytMNvK4nzirpj5OZIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(2906002)(53546011)(26005)(186003)(5660300002)(4326008)(66476007)(64756008)(8936002)(8676002)(478600001)(71200400001)(6506007)(66556008)(4744005)(54906003)(110136005)(52536014)(86362001)(55016002)(33656002)(7696005)(9686003)(316002)(76116006)(66946007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: oDgFUFMCohzPQLp63Jw4CpvxBUhbEhB3LWV81snqJJZb3ZS9Ua/19oJZvWSymJ2SNZqHztOwnAaNAbEt562wTzi/5jB3bENDE7XX6npfna8XO3lANXauBZ1wOySX4ZjwDd1ul/PN+0JxxQ+PfFS9Hefye9L2LCOzH+iSAWEQttNov1xp6YXMTozROLx0jsRy3Lt/RmXTq8xcf+j3NlVpGaPdfVnFU6ka88NuMT2J/TDPACx6hU/spo00DEJkYuZryHpcBROAkT3DR0ari04Nu3MnqJG9Slkh31UXgHFwgyXo39S2TTryvu+1AO0AP3u/j2LuekctjmbsTeKigfKFIFqVfLfFZo04XD+FQHtJEf8BG3stBVph4BGF5tTEWZu43epU4ymlIDd4cGmTn7WPXFpvVCbdoazDcqeyU1SZ7C42b+5Myc/EbURnKkjQurOC7kBz45xwrDevRHQNbYAybz5Cxuo9ghJMDrezcixcS/80LdN7YJxOb2SsN+bIMJJh0b8hICs2Ax45wEOnq41vb3YBf9gqZm5uwbyLr+Bt8jS/IrGfV0yTqcgeSl+a1Hz/F0LKQd35PXkQXxxZfJngdQ0z4w2arxnLhjfbxmAHmzOdRNPbXJHYLegUlelCglDMGAIZ4dGsd1+pAZCmVVnEew==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b32610-50bd-4a04-0552-08d83a7b708d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 02:41:51.4814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kadBh8QPlzDXTN0ESfojfbaqZI8KXVN8onB7D5tszROTjmuS6dYMiChTgg0dUodiy3Fs6IftekXUgOvMXi1y9ZgpQs7Z7j2wgPsd5GgVrTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_224156_417888_62E7DFD4 
X-CRM114-Status: GOOD (  13.12  )
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
>   
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 6ffa971b4308..320aa4b2b475 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -6,6 +6,25 @@
>   
>   . common/rc
>   
> +nvme_trtype=${nvme_trtype:-"loop"}
> +
> +_nvme_requires() {
> +	_have_program nvme
> +	case ${nvme_trtype} in
> +	loop)
> +		_have_modules nvmet nvme-core nvme-loop
> +		_have_configfs
We should just move nvmet nvme-core configfs _have_nvme_fabrics_common
which are common for all the transports to avoid the duplication.
> +		;;
> +	pci)
> +		_have_modules nvme nvme-core
> +		;;
> +	*)
> +		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
> +		return 1
> +	esac
> +	return 0
> +}
> +
>   group_requires() {
>   	_have_root
>   }
> -- 2.25.1

Apart from that it looks good to me, I've not tested this yet though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
