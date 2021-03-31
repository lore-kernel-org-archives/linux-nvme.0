Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D588C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 20:34:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D66860200
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 20:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D66860200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=KhpqQPPCFqGEgr7nMW0hQ9Q4Esxk4Teslko0NKcvXL0=; b=oXExsocAMMvNvnNMdiywnBdnI
	j5SylmzWTeYBw4ktbqUOG+EZ+OxOw5krBKb+brKTh8P2MfPdWyyaia1VVun6AzB3fXm4Z9bq9yG1U
	i76FzL/LfVXLvjnC/F0mLNIUCjA2ilSyPCI8vnuqWX+D+OU3F39wKSuQ73xo/7pbX9jFujC50hvRH
	lv6OeMoilMlDYSNpS7m3MfDDib1XU/xXkFkIqLfnWzohl+YPMwrmEZtH2EAUt9+cOi1pLIn2WifN1
	hR5F9ff9rD9+otOJyqqVUODd6Fg1CPmIcN9iZlwYhbR8YxTl5GivFKdIpsxl1LJRRzrp/9gRkg+lE
	9ZiqWjksg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRhY3-007VkF-JB; Wed, 31 Mar 2021 20:34:43 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRhXx-007VjC-Fo
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 20:34:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617222877; x=1648758877;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zEnzIZb6eGLG3Go484pM/SKOrs2zQ3PMZaAU/7QR21A=;
 b=UvLR4Ob+0gUVzNNNnr9tm5TGZZPQB/ESlVIaoBWxqwuydzKtZSlzscDd
 KoPN0DWwXvNAL0qMWoy9QdJYalyQLL8omK5Ldll1eufYzQ1Lb/YREWGyF
 eFiVimHGMV1BeWjpSJahiZi44RUPXaQbAD8TdGVm+AVHewznp9WBo0HFo
 F6X2BlfS+oHvmEEtlC8pOuLOk3R3rYPL/kJcl3HMfFAIHusjl91cKb9R5
 YQqaTFakKnIghpyZM5RuAIz/yjW5TDM+l/+SAMZNcypbmCff+W3OM1T9O
 fUr2Y8zi309R3dqDa8v0O8Aehouqn/PX23v+Lp3Sru/zLV/3YY82H3Aw9 w==;
IronPort-SDR: Y8LpZ8I2sdQh9lNRVNPkkQRbkQgUxVT4EMM38WivqJZT1SGW7AE00AC42OHUKQrPq6te1btKk1
 sRrgCNqdzI//zintKJLLwtbEkTa3mATDZSB/jWLBRUV5EtroKax2CDMRDnbweRMVC+4w6Gq/or
 r8Un5CrKR/efdvDARzgY+mvRA9/8ZIssLuDqYIeehBiVH2XkslRNIq59i3UtvQSy+bp8UQ+WoF
 d76x6HlHwzudVMA+n5alcZ4ngSmA1TZeGgtStZ+ye2mZIjdgk8GydE3CXbJwJofz1uraGwEm3R
 KdU=
X-IronPort-AV: E=Sophos;i="5.81,293,1610380800"; d="scan'208";a="163487209"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
 by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 04:34:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtN1HjBc6K2HgtqyC5gEqY450MPArKSefQ4b7NjYS6PrnWOPZE8vhxyzo5ga/fgonc33Q+G4EADmcPspCCszJm89cvSioLWvrSOk9cTjUTSvsZC2xoj2kzZfST9qwNds0mrYx7STJPtOb0gTWMB0OWnCUvm+Le/El/HFKmkFUAcR5dZtpQXvB+/MtcN0A7CpcKM8+f5HB+w8DnfnwuISKAW664kg8/KSOg32qRMFBPXqmQzn9fO0eaJSEnww6vnzIKm3++KnvU9JjLGljbrfg6wyUm9QxxymqFifZh7ushKxLy045BVQHBPpkaQhtYCuYG/13PSxqJqd/iM1e2vosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il3wUKTWuVxo+94hIrdRlLD9hTIWfB1/DhkNhQUIybI=;
 b=YexQ67GFh82LjiSpb+iGTPEXPgoVWesaY+AoPCd859DOO3LCN+U9EIAqJf/GlBtka2bW70zQrlkgMIxIdTCqpdtNdVvYd0g9k2OCG1oQyCcifzG1/+sYwK3FeA5/Fv41LJtm8YqVH9y3Z1GT/xGX/gUneEkhSorJY5zTl5PgSD093rNYe4f3kcVejZiIkncBvdwbkrW6Q+85fYEdi2j6mKwzaZHJqaxIhu6PZx/VzMMNakWOsGBJ0QfWibRKT3jUnD5WdP0RelViaotIB3K/0onp+fMCS2QZWNB+l/cnukN8CtCTrJJoXsd/KnTt4oqAMHupTUhMyL/wN4Xyfkc48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il3wUKTWuVxo+94hIrdRlLD9hTIWfB1/DhkNhQUIybI=;
 b=LLxNxOIEwt3S4/5txs7EjMzEmyP+9k8OWVlFbnmNppLzqMfZrW0YEFOb7xe0uQI8yG6zB8C1eMEkauq0xfUwIMENMPADuZt20SgwBQ8quxfRNHk/1ibXJwUuBZwdSnvi82MC1wE9y4ydQAisv7TmlDPPwofc6DBdxARxiJT15c8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5592.namprd04.prod.outlook.com (2603:10b6:a03:10a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 20:34:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 20:34:31 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
 <hare@suse.de>, Chao Leng <lengchao@huawei.com>, Victor Gladkov
 <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Thread-Topic: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Thread-Index: AQHXJi+J720hbwseC0WZ8xLPt2l/cg==
Date: Wed, 31 Mar 2021 20:34:31 +0000
Message-ID: <BYAPR04MB49658F0DDA22B253F98C6F3A867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210331131228.131118-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2cfa361-350e-42bd-d201-08d8f48463c3
x-ms-traffictypediagnostic: BYAPR04MB5592:
x-microsoft-antispam-prvs: <BYAPR04MB5592B04995074271CA69061F867C9@BYAPR04MB5592.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNDlETMWGRDaqTL3WuufCFZLeqGMDRNq7ldJ7p2E29tHikksHliwXgb0+XW1jDRuf+ofbFdsVBB6BlmnBXLmDiylgfJoi67/5+LCyq8P0+45y3KLNO14LfuZ6H3c0EZB6XeMGBApGkiLxmROW/ngO4fVoMYFH4ep3+i0UUS3k6LBx7B6vrAxlw2TCHVXiDsTcxDBjFsMzwqZMqNRm+5DZaaOfkdA1EpOUsSIdLkDP2ncX7sMGAnDYRzk9g5rbny2FROEoiULycYKp+jb3sHosFKVS3b7moYWEFibKkDA73Rg/8ztp8aVZymNfz/ni4TzQ7m5WZKtDHf532uGOukuKQ6YGXSJHYcgCIFHzQDi7+3nJ7eRf0kWc1hurLZItxRgO+r1jEsk+q0klCG5PvRIeFdhsE5sHlnHUeU4bQnuK5fruGMN7I/QBkXxuzuPwI0Q7D8CjKzF598/nZwkXoDVRnPitQkypXMvFwbkkQxQHUDHtNlha+Au2jMjpc6znaXYk2X/JPr0EH9pYhdSSnBYrp1laCvevPxny1TkjEr7jGRgyk+j3xtPgSfu2eiiEujpYufEc9QyWZPfpXCNN9ks5gFyBBteC/E2n/MDNTeFBuXqL+GB5EUGP4Y3zf20+i77kTYI2kMW5WAZK89zBMGivglndMaOSmFmd8XM359JWG4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(6506007)(8936002)(9686003)(71200400001)(7696005)(186003)(7416002)(76116006)(478600001)(86362001)(83380400001)(4326008)(55016002)(53546011)(2906002)(26005)(52536014)(66946007)(66446008)(64756008)(66476007)(66556008)(6916009)(33656002)(316002)(38100700001)(54906003)(8676002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h32wM/FXQ4E8Pku8Utx7jsD01NcYR3EZ0ErQVSxFOAnnhwW7Ztva18aoV3SI?=
 =?us-ascii?Q?RyhRx8lZZ9kAK8fZzCNRbZpZ0Ld4QHiTgHT2S9tVwuf5HELgFNSTsuH9N0Gb?=
 =?us-ascii?Q?0a3slXfuOcldMEv9ZXEOF61CLlMojVPpDV2gMn5Gdn1rw2U+rqO25B2ru0U2?=
 =?us-ascii?Q?pK9q8koBBHRzotQi3R0Gc3cvS9jT0LIaDHiAp6SQudqfrLDpHulexUYg1HLx?=
 =?us-ascii?Q?giYVWWiSbidpbfbbaDcUr5x1qxZ8cb4WcyrezpAGKLPxKIiZf6kooTv+0B7W?=
 =?us-ascii?Q?UiX9BwHnnz9HGBPK4g1LC1nIn1QaLQhUrneDuObIhMT71fxqThuscb1eZxkU?=
 =?us-ascii?Q?W0MO4N9g54ld16i3xma1xERmSuRauwnvSkC1BrCElqtTNxCrN1czWzrSijJa?=
 =?us-ascii?Q?cuAU4dJQXtjkGrleVJcHDSU64H8ZFbvH4UVcYXHzIfXFIoPCEjvRnYQqHzEN?=
 =?us-ascii?Q?jwf2+v0qbJhbFwHtAyN6A/MM1McNkLGPI0zkjwY7mmnD7Xh1ZR58jXCqAg1p?=
 =?us-ascii?Q?6hn5lSOXgWPJCgKXI3k++92uGrtliXoK+3FuO2Tts5hagil4LDWidkguMpEd?=
 =?us-ascii?Q?y+EC/r1Dn9jUzkp4AcjEebG6P92n0/li99skrbIoes6qkAzEVHwNh5XzL3KR?=
 =?us-ascii?Q?3wkuRF6mcdeXrC4LUQ8TjijKun2G64I2gYN6f0fydz1TABNxuPQq0hKVjBTH?=
 =?us-ascii?Q?/i9qak0cMDUYEK98qWQSXFe7uJHOSGGgWchMrOpZ6PvLxdHSiJSOUu/Kxdan?=
 =?us-ascii?Q?RplIb3mlpkCCF2GgmAu7gjhpiTS/RG5pSOEoc7hPAcRfTX7TPt4VrdFRilqJ?=
 =?us-ascii?Q?bN/q5SZnThI38xasxOLH6Hd4x5em6XF5aCjkw9PqU1hxyZbeRwmVPn+gjVrr?=
 =?us-ascii?Q?9nNCr3l0PANJzswUTRVXSl5hB0LeLyjXZMjReA6Bi2pn5J/vCSaAZfl6a96x?=
 =?us-ascii?Q?P/g8Qr10IaPeLzwVIboQeHPgOUbkgjIqkdIt+jSGhh0J0EW55UvPUBrE6J0O?=
 =?us-ascii?Q?Zad35sp/xvpNiY//d3toT532ZBl1jYk0LOKEyqg/8x9WAD8MqKA2TPkAOGaw?=
 =?us-ascii?Q?VSEOO1VBrLv6/6w/S15dNS9A6yX5BwQAhKEaafD2tQp+DaHFzY7O4jSY+HAS?=
 =?us-ascii?Q?8icr5vAAcr5EGB9kt8eGEc3RtuCSlATDwntfW8eweKvbDksNTVKNyP/8dyTF?=
 =?us-ascii?Q?jMGrZERWdgdk7kycgpI5Gi9LZaBM5NqTicRR8S+5+ssj9il87JIX3ix9tr7q?=
 =?us-ascii?Q?bNtJmDDbt4+t4visip4pimhB+1E7A2+OmQd+ff9+nu+iweuCqM4l0F5EErGT?=
 =?us-ascii?Q?HORoJxJPk3EyCSMGk7IEa40AMMtXqFM1xb0zWcm5D//KRg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cfa361-350e-42bd-d201-08d8f48463c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 20:34:31.8613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvDeFEbKzle6qGUJyH8kb/1eWlG7KoSUjATR4A0pgsbJytiVvLPCksLUxDj5mPDtRrjz7O8+lgQJFk9gowy8HAEhTnYL9PToQRbnsII1Ugc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5592
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_213438_080816_B7082CA0 
X-CRM114-Status: GOOD (  22.91  )
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

Daniel,

On 3/31/21 06:12, Daniel Wagner wrote:
> Commit 8c4dfea97f15 ("nvme-fabrics: reject I/O to offline device")
> introduced fast_io_fail_tmo but didn't export the value to sysfs. That
> means the value is hard coded during compile time. Export the timeout
> value to user space via sysfs to allow runtime configuration.
>
> Cc: Victor Gladkov <Victor.Gladkov@kioxia.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>
> This patch is against nvme-5.13
>
> BTW, checkpatch complains with
>
>   WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.

For now keep the current style.

>
> Is this something we want to adapt to?
>
>  drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..c8de0e37c7d9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3696,6 +3696,36 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
>  static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
>  	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
>  
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->opts->fast_io_fail_tmo == -1)
> +		return sprintf(buf, "off\n");
> +	return sprintf(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);

do we need snprintf() for 2nd ?

> +}
> +
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	int fast_io_fail_tmo, err;
> +
> +	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
> +	if (err)
> +		return -EINVAL;
> +

since you are returning an error, you can remove next else if, this also
removes the extra line after above return. Something like this on the top
of yours totally untested :-

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c8de0e37c7d9..afa0a6790b52 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3717,7 +3717,7 @@ static ssize_t
nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
        if (err)
                return -EINVAL;
 
-       else if (fast_io_fail_tmo < 0)
+       if (fast_io_fail_tmo < 0)
                opts->fast_io_fail_tmo = -1;
        else
                opts->fast_io_fail_tmo = fast_io_fail_tmo;

> +	else if (fast_io_fail_tmo < 0)
> +		opts->fast_io_fail_tmo = -1;
> +	else
> +		opts->fast_io_fail_tmo = fast_io_fail_tmo;
> +	return count;
> +}
> +static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
> +	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
> +
>  static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_reset_controller.attr,
>  	&dev_attr_rescan_controller.attr,
> @@ -3715,6 +3745,7 @@ static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_hostid.attr,
>  	&dev_attr_ctrl_loss_tmo.attr,
>  	&dev_attr_reconnect_delay.attr,
> +	&dev_attr_fast_io_fail_tmo.attr,
>  	NULL
>  };
>  
> -- 2.29.2



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
