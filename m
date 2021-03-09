Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDDC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:08:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3605D65253
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3605D65253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=SuXCi6Gac5cnGj3eVMoB//LYPFDAL+srWrv8VYG7vik=; b=cj/+bpMvdN7OoL57e0Uqdcmd7
	GwKiYEr+wrZYsyIKViMCiYX2olGUCD4icQrVz71OTZkbqqeK1T5y0oQc2mm8BMsuvKfBLJeRambJf
	nIitHEND4pwYp9EktHJKuFhFK23ynPTSPuqWj+ISJs73+nc1iirYJh9/MaPmVEigACz+kS9j+EMAd
	MVQMyjL+RfPkr0f3wOnuj05kDLC1tVDNnnVAe48SvpHMZdOuqTHGTC+Gd3zvbGYJ0ThGAk0wqRSWt
	mJFnBNlmteFUZ5kAYYopfM4W2QyCTA6ExfNUiJxBodgTRCtxev+bRMepSzs8Gh6eBy7MEy1JaUIrT
	fVnA9Gv5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJja2-005Pkl-W3; Tue, 09 Mar 2021 21:07:51 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJjZy-005Pk5-6Z
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 21:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615324066; x=1646860066;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=YCCg18D8uEXFqd7m7c/+E+EWdBTwh5+roXWRM72q86A=;
 b=n92eqbCiHZ0QZQESyPn85leFjyHAeEKc5yqny/6jSwbwWNDcExcwfngh
 8wWQaUSXzsdvqtr622OEVQcGiUqan6szSbUPQp3mdKLExbLy2nXUUEmzN
 4/PNQN/kp9uhY02W5eySas8hhgZzRqMA510TVmv6QMxjUdyyFdwMTZiq6
 aVx5J6jgWkJoSM9xLdtXv0reGpaA8nG1UWlLg2lxMRd6jrK86QQtk1QwW
 9UcJWX0k39VWr0Oy94jmxJKwlLHl5EEPfSR9IpKAV2L/46JMnSTsS95GO
 gwSTRIRnleIxz02xUh4jHaDoJeaQ1VT11dYFTTzl7OV3ps3NYP7mT9buK g==;
IronPort-SDR: kP0+CXczmNootMM/7LpVk9HwbrCDpq90Jvsvi9L1/8SyIvjKzqtaGZ5IJ3PKpxIlcg+4/Sq782
 3QEirePYi9jSnwY5Zt0FZdgW9Q1cMgWkVo9q+gmC0Ooehji8hKZxhTJJDygjDwcqF3+eVh63Zg
 UMwJxIcN2BLVtlrxr6Z1LQtchHT0lDLEY0OHjfWFNITyFsak0UI7UUYzcQDYtCnsj/pV3zZOhz
 njRV31ie9Q3sak5PqDOfSVXpcrNTArLUw126Afe1rFtBqRFOpq6+MoYEaghC+sz+swfanf0iep
 ACg=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="161748071"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 05:07:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+x64cqWQHuH6eoqc1fcSb+SmNxaB9tajmgE46gXVyuoyDeU5pPiFHPJ6ahipIbJ/8nUdqJh9DNHzBJKHFGnWx+d1jFq2yaY6KXdt9/g7+G/6iV2+D4HEP+b1vlp1sPMoOS80C1T6KsmYC3djSunz/RvJey9mJKfcpAtkQBD7kGrAMZQs85AYF2Bn8ggxYjBfsprH5wvhOKGMeWm3e2E0FfX0ZPM/F96jwAcbCC4oQd6XIc09S6RhkFX/jTrjXcQLfPdnUUJys0JwiE31+bhSCwNFMChUb9YKmkO1EneWd7Q3O0X+VwBQ7wrhTeWt2vktcWkUYSAJh5pMx1tjK4u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoeB1pcC/pjXZVYh4DT0dGvxKNvRLWELl8Q4AgknTuU=;
 b=K4F8/L3cfrpjFOcGbCSq04RdZCMQaPTwt+jp5+Z1s0N66QFjzYp2duKdQEJtfuWw93/caHPJ/NmdwrXDSAx3fkhM3WHdO3YuhvBo5oF0RAQYsg7xADNkAT9Nf+ajznoheY8b3Zfqxcaj1xDiehZoEQAy3s+9OtgQBTTWs6v1h6huBHMLCYnhehme6QmBAq1sUarib7J3M8FYy9qQwmT16hfXwBvl8i/gGT9oNLSbZnd6Em2MIiQdkSd83DWhQxhSKUpooM4KwmiBPOG7Lp6KKvW41/J67+fcRgDfPHl1LU8eFmW6K6DAdNzvdg/UUlgeZh3bBqWlCTfMjy58bYmqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoeB1pcC/pjXZVYh4DT0dGvxKNvRLWELl8Q4AgknTuU=;
 b=Nu+ydGIl9oHZZJMAob2EQJt9miuAFsOjgCC8c8fZGxuRbUDOqU9tWh+IgH64fVnJ3SEvA+wTZVlAqEsLQaBAof36rEtjoJHH9lZY52Div/Nic3R0ukNbBbBnHP2QDkb5cYy7JglCEHgAiXQw0zV93o+vy3y/Ppgg/mDAHPvlKhk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6584.namprd04.prod.outlook.com (2603:10b6:a03:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.42; Tue, 9 Mar
 2021 21:07:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 21:07:42 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 2/8] nvmet: add NVM Command Set Identifier support
Thread-Topic: [PATCH V10 2/8] nvmet: add NVM Command Set Identifier support
Thread-Index: AQHXFKDiCAp+3YRW2k+WttRu1num5Q==
Date: Tue, 9 Mar 2021 21:07:42 +0000
Message-ID: <BYAPR04MB49651B71A703D3C807E0716686929@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-3-chaitanya.kulkarni@wdc.com>
 <20210309113746.GB9520@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a35a7c62-f029-46f2-3cbe-08d8e33f60e6
x-ms-traffictypediagnostic: BY5PR04MB6584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB65843D3040E747B2C799920B86929@BY5PR04MB6584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f0Abdl0WC7GJZKHbO27BUs7n53YYr9irRXoa78KdwU9M3jVbe7v8f4ArFGAgOMfn4/ysGb0lbItfgD079Xk8q1lxe47jaOwZtJzpwvDIHzSoVnG+cIf9EO1iEf9ZVMNVqIleYi5kuaJZEiiB6Ciywo8zYJfX0LcWKGNa2T8hrNpbR3OzqqRSPeqDxyrkxSKHoV3Wnp0k5RlQHUpEURt2c40Q7NIAFKdsd+tj/7rDmyq9PBglYJrW015arqie6I7+YF1LqQ/UDim1NzCfG5QG5p/prEuCsQpNwBmglFMLyU5Kwc3HedUTaGpWZAyaUVjZN4+OwngTlnT1UW4esucBGYH2qGFTW66Y0JuvmHo6BbasVFWARTELlUqvFMnCKjl3HpQXBdtJfU5NhEUFhAnlGfkvwh0hkQ/rSvATWZg8sqJlekLcx0wvb5SgWkSTF2D1ApVKtWHRcg3lDZehgRynObT35WmjnB/tn25/lc3yJ3qCqk73ZiiZWIiABl50C/yeebl3DRRpZo51ZTtULlC7dw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39850400004)(346002)(376002)(66556008)(7696005)(316002)(52536014)(8936002)(64756008)(478600001)(66946007)(4326008)(186003)(6506007)(33656002)(9686003)(71200400001)(91956017)(86362001)(2906002)(53546011)(8676002)(66446008)(76116006)(6916009)(66476007)(26005)(5660300002)(54906003)(55016002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UmnVfKLQwWRpjESvAcjV+Ux1rrS46xxYU31565nuELU0Krr8LH2UU9QbV8Dz?=
 =?us-ascii?Q?TjP0LOLboiQY8/vyjRSQsCXOBSshxtApv1xpFDmUzk9sJq9A25A52uMkY1/I?=
 =?us-ascii?Q?0btIf629w4dLVpchNn+0vOpT91L/i/dB9ecp2lYBFqYT/iKnSrp08Cxp0sE2?=
 =?us-ascii?Q?GIrS4SaAvZjPPiJ6irlyd+BpRr8Wt9RL9MSD59vKfJk30EH41i6XyVrJq6S4?=
 =?us-ascii?Q?FEUtv1Lk+dVTo5jKFD4b+uUmq8DR2NNbMDDv1SzmOWjydy0RuVSz+/7O3jn0?=
 =?us-ascii?Q?ryDpubxPP2NVoudFz6m5W3OFNSkkcWmkAYJxKjmhnJcdA+5cnDzQpNdA6v6R?=
 =?us-ascii?Q?MYmS2Q2xgTKSRtUM/xWj0K5HxF+JppVUa2oECTu3zQCBXdE08s2XMwm6weyZ?=
 =?us-ascii?Q?gbEc54HGIVzOX3ullyZ1wwioYC5fNyT61dCcaJAxrA81Wngw4mnYPpsxSjSW?=
 =?us-ascii?Q?qT1Qp48Yqasvar77HDDY5JiF28Z1eWC6aikgmf4CpSzibTvz8x6vv+jxaH0M?=
 =?us-ascii?Q?2cun7L29comgC0TdvHh9ck4SdJs++6aq+AACiTGBoZoXr+xX29Txd8yShI0v?=
 =?us-ascii?Q?e6uj/htOwSAZmPqTST7TIeJWUv2sECBacFexJheATnEIURbcqb0CfU3mtJFe?=
 =?us-ascii?Q?lZTe3C/Sn9Tt5OfTTh1QwhmMYL+5lwQ2Z4/xzkNTCK+KMW14366LrH8Au/5k?=
 =?us-ascii?Q?mFSHmZAsmgtenSr/hleXz9h5tSHH6Tp9BE246ONiQeahtrRlYuo0ysM1nF6l?=
 =?us-ascii?Q?M5zQBkDnGEvPfurMkvY6myXDomMEAmx+PmZ8l8F6pGW2bvZegUYO3tnl+GjN?=
 =?us-ascii?Q?FQW2+WE2pvaAWYuaGFaR6ka1XP2+dow8Rs1t5I6ZbfHgy26Q3BX9wtwO+w0J?=
 =?us-ascii?Q?JB8Czty7eethXUAohY7ym7oDXH2UTFCsC5l4hX0K3yo6jgbA3Z3l6bAMSYpO?=
 =?us-ascii?Q?GA+X0vifWgI3ZzK7l19TYeV9L1JQzbiAeU/Hk5iuIWTvtv202BskkPNmwJJU?=
 =?us-ascii?Q?IP0d71jaNK4wsoOMLUDo5la/IDY8TQ8m42wSx/7CC0K9Q5I6y9OybYQQZGiH?=
 =?us-ascii?Q?tZf+b94z5goasNlcxGIJ3Yi4I6gRC1cgX1LQvJ4Iee7+jrGcOYpsEk6pdMYF?=
 =?us-ascii?Q?Ma0vMVXC7crJ//S6RXoCSprCcftBQl8Y5DRXz+iAEIAZ8PKsxIPbPAg7v0hH?=
 =?us-ascii?Q?FyWMdb3cIQPIdzy8EQNRT4TRCUKO6JeflIiAcigeAmRUiV02wEG0mChjQsW8?=
 =?us-ascii?Q?KAQ9qswXQ9AO2I6C9lCEU+wguQbZ8gBD9yjq2pIIijF9017VWZYlXOVRr3MW?=
 =?us-ascii?Q?Z+CdhYi9MNzp4n5TCVdbHtIB?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35a7c62-f029-46f2-3cbe-08d8e33f60e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 21:07:42.0411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFAP4TvBrGb3w4GeUbz3pHwtueLTn4icMBPA4UrNHsVMycPIN+Eu0IMSYR0UbnH5fGW/TXqWRPxnVBJA+XnT/qdVZO19VJnESIWqfKnlsYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6584
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_210746_720432_3AA7293A 
X-CRM114-Status: GOOD (  16.99  )
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

On 3/9/21 03:37, Christoph Hellwig wrote:
>> +static void nvmet_set_csi_nvm_effects(struct nvme_effects_log *log)
>>  {
>>  	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
>>  	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
>>  	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
>> @@ -184,8 +177,45 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
>>  	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
>>  	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
>>  	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
>> +}
>>  
>> +static u16 nvmet_set_csi_zns_effects(struct nvme_effects_log *log)
>> +{
>> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> +		return NVME_SC_INVALID_IO_CMD_SET;
> I'd move this check into the caller.

Okay.

>> +	switch (req->cmd->get_log_page.csi) {
>> +	case NVME_CSI_NVM:
>> +		nvmet_set_csi_nvm_effects(log);
>> +		break;
>> +	case NVME_CSI_ZNS:
>> +		status = nvmet_set_csi_zns_effects(log);
>> +		break;
> ZNS also needs a call to nvmet_set_csi_nvm_effects as it also supports
> the the NVM commands.  But more importantly the ZNS case does not
> belong into this patch at all, but into one that actually adds ZNS
> support.  CSI support is just infrastructure not tied to a new command
> set.  Same for all the other places referencing ZNS in this patch.
>

Okay, I'll move all the ZNS related code to the ZNS backend patch.

>> +	default:
>> +		status = NVME_SC_INVALID_LOG_PAGE;
>> +		break;
>> +	}
>> +
>> +	if (status == NVME_SC_SUCCESS)
>> +		status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
> Also I'd use a goto for the failure case instead of the check here.
> the 

Okay.

>> +	switch (req->ns->csi) {
>> +	case NVME_CSI_NVM:
>> +		status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, o);
>> +		break;
>> +	case NVME_CSI_ZNS:
>> +		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> +			return NVME_SC_INVALID_IO_CMD_SET;
>> +
>> +		status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, o);
>> +		break;
>> +	default:
>> +		status = NVME_SC_INVALID_IO_CMD_SET;
>> +	}
>> +
>> +	return status;
> Just return directly from inside the switch statement to simplify this
> a bit.
>

Make sense.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
