Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024ADC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:13:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A806D207F7
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0A1m8HvZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FLyteEzw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eSXTIrWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A806D207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=0IvXcV5XC+K0gEbjN1YtPabZcUvecI0YyuSfWTG/iVU=; b=0A1m8HvZ46oT5HvQ+eL/mlF+M
	6rk9hL+RjriiEZmM5AhjY4kPlWduet3hStYNXgrx2rJLcZ+1Knbf1wHbdysQ4vXCletdkjefY2Sy4
	g7R6fuu/3Kviou8PO2au1WdTtoujwqCoF3MoVrVh1uPItmEOi7jQaXUAvSaV6AXlR6TTQeeG9FoPt
	l3J3806DYACwueeOSBghGS4HgqvGYj6qo9OevJ83EMIgTDjDsjhyCOgnCCPMnQZ8UFpcDw11hBwCC
	8C7Th0lkgGlMVbbejm3Q0e43Eykd2/UGcvCXHSvxYAGyIIGYDFjChwwREKnf2XqEmmAP/sOaPZycr
	Hwp7hYjzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMupl-0005T3-CG; Mon, 28 Sep 2020 15:12:57 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMupg-0005Rv-PG
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 15:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601305972; x=1632841972;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JjZfIHeGopbHaMH1VlH3b9Nn5Ro31dAMTXNujjR1VSg=;
 b=FLyteEzwrHCWf0/l5JH5qfA2C9yVrhGBJ9qvv9lEzDmqi0hnsPZX9kOK
 z5F3GPIBkzr3MIX87Qlr3hMKEf9FnfS99SEIkllBaW0XG2uMmBgG0KpRt
 7PRIAfbp+Iq1lwwsEUz88uPUWlk5sYu9ra54giFUn+1YwT8h7IrPhDCsw
 PqpMtutxjnLW6N5cBkmBQNlKKE5DbMHGv+K3BA+aLg0w2ge46EFSiigZW
 KQCkrkArvgooVSUMNUskH6F+dnfaSKjr73x2oOgd6dkQB7K+Gs0a8Kzoe
 yOJGxHa4cIQe6QfrNQsuPE773qUCJKtlVnbko27m236edhYclqBV2/oXB w==;
IronPort-SDR: AThOYctmJm8oty3lgFsRlPYU+F6Gnc1K55NCwI9n7rGze2oLUDJoEjN5/3SNHSU9piHzVxSboE
 HoxJzl/yO+nSy3K6yVipJwE8Ja3sIJeNsPuKgw5yuEcbRhCv9fjZf6As5NWLoyfW7KFimGeZqp
 t8eYFxwtz5hCM6VEUY155XhREZgjENwSrwIxqo6wHHQ7OhXz/pl5hjlBbxJhIooMbjw/ieBctN
 NVoDzxlMVyIBXXY5X2pkppjlxP4pynqp0zr9ZJpVtccVObmAeFd0P630K7cmZYDM5iyABcsPXm
 /oA=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="152818155"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 23:12:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXEruTS7m4Kv67Kb8znUFq45zeBRTneQOGrx4vvxe/t6gaXImmK6O6oqWkWiPB7d4ROR547+Sl4PN6zcjipb6zUi+MK6bSNbIJPQHCEmlD+EJo+2J7/A0fDU/xOcdTVl3N56Q/U9fgbbvZOw6rMxcpPW5hVOilNIQ5ftuX4FsXWjyWvj8rmSD0VV0xRJDCh/TMYFy9StJv1pyGNwluIVaVfwDp4CeYwv1G+gdpbvDGUgo3sESCz8f6Ba/F4ym5AZmrgMx/X5erSqc/F6Wq7ktLPVjtOE+Aq5MplLlWkpHrgFaue8+4ksvka7329Q+get/tTPjop0iPpHzOxouzv3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFfVwb1uwbFvcrkuqAqkNt21D37gfwfQvGuBzgNvH+M=;
 b=TvWv7u+lj2FeUw2dJEUmAt8gklZ6WVRdQie32WlFQjS172eUXJ/Ku+i+wkk4W0Mj4qU6X+DmhsApE++jGnMzzewAtHMt18a43PBdMpCXoW9bjOPbLkPDcR7/gKpjlO5fIS0wB0iPbwpxSZOOtWnMkVnzShivww0rxMpDl2DSM9yotSs/2eOQE28o0FnwvtGz6LlEqAe4aPv+039DHYX+HPG+spvTBSIrUHGmYvRWvTGPasbk7rs8mZi/3riNXEBQ6jgNvr2LqAZpYPaG0tx95oKphOw7ukKV1FbcCxLfdqlYh2KMamY6cQ0kGcJy73MCrN3c4I1BuLGwDeDKwDataQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFfVwb1uwbFvcrkuqAqkNt21D37gfwfQvGuBzgNvH+M=;
 b=eSXTIrWVnvrSnSPeaieBuVGIrovK+atwW+jXwolMAr4+pl/VR+6JfeGgzh8yS9Sft+AwML7ApUJUBy3YMc+fdHIOt5XtXQ1z28cmYLS1qrKvZtXHwAvkWQNQ0BhBosq39/b+hlYIHmzs2cOSvpDL+9KSXEBN45R/9XcJp3qIv/c=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0425.namprd04.prod.outlook.com (2603:10b6:903:b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 15:12:50 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:12:50 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 18/20] nvme: move nvme_validate_ns
Thread-Topic: [PATCH 18/20] nvme: move nvme_validate_ns
Thread-Index: AQHWlZPfP6hnLlJHeUGHtiXu/yf0nw==
Date: Mon, 28 Sep 2020 15:12:50 +0000
Message-ID: <CY4PR04MB37517EDA32674858B495F7C9E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-19-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05fa10fd-a100-45ae-6a55-08d863c0f738
x-ms-traffictypediagnostic: CY4PR04MB0425:
x-microsoft-antispam-prvs: <CY4PR04MB0425A2A7D8CAEFF94223F5DBE7350@CY4PR04MB0425.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kqBcT1O5OXyuzfmR0lWzAzXNsbSs4TLM6X4g6pZ6qXgTvgRswUge9Mi/RSBQt77BWTKCG/j7Cm+ZUn6CHUjkO/1fpTU0uRR0BH3u6VYG/kiaHt6KuxDEF6ov3iPKVWwe4fWmRIzOPjWiKWnTMrD/PNlTEBKp8ddb0QcRrFUuEh9+Fz0cy4yDxWtxOglmrqzMq/SehnHyj0sRu+xQgn/EUmw2p0VY3gIxJ3Zj4NqXx4BCIKY1kn25SbNeoZBC1owNQaGVCo6nCxDRc5/B90/LX1Vx3aswzCiUhaey5SnOLSH0OQA0JnwvrRtL38SGiRUCoh7qas4aaJ85NBwmv+uUlSHqR/XH4vH7++t/mo5bjtoRPP6HoB8WuJDmWlPkMsSE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(8936002)(478600001)(9686003)(91956017)(76116006)(316002)(186003)(33656002)(83380400001)(86362001)(66446008)(64756008)(6506007)(66556008)(66476007)(53546011)(4326008)(5660300002)(7696005)(66946007)(110136005)(54906003)(2906002)(71200400001)(8676002)(52536014)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: V8dpedFiDiZ1nBPx4o4Ul5eHY1AEalEkKBGAS1pne5OdrzRwqzaOlGQqo9OizCVc0lJhBEkaW/edFPDLeC/0e6y5R1A6Q/x8mHd7wpRaQN6OFGGI6O7DhyoLDR42odkrjoidEWzGHIslXcZyVp2gqY535jbmOj+WgZ0VnRWaYFE1Ij8es4umNcKVXXw6mAWJegX8FKB4yNhNXgwXSN+IuWDUPjUB7H4+47fsZBxZtY/W3SUOzNpzB6XtDVKeXencoAHej307Dj6mufZyy/7+7RjXH/n1qNq18zJ8GRb+PZCq/GJ4Ah8QGMVWS9PxMOooyC/1oaYO9+nDE+G7VNnYH+Ag/kFqmqiqBZ8kNcuZwLt/NUlvfy2l2FgTbSkXFrya/6UlfZ1MJOx6ukp5GLQcI1DYGtNvJ3ipW9uDYUdyf7L0BC1Js+lisI0XJ8b75WBdPVHMulbrtse1gUqYbx4uAz5/stL6WLMDA321Og1Hqow2BKMzvUqy9By9HH4EHfneEQkmethPB6D4hCHAqkUcBpIUX+Nibdqc0jyjrpDposEbQB8xPc2Cb/P5fCqfqIB9mzx82Z7A/PhiBB+ic+ChNWBVlypOEOtk6Hk4OH6i78aJi1CNOkqmz1xnv1Amit+X2d6mItUSpBb7F3hEqCwcwHsppVapR03kZ5amf0X9xbLkY8PryY7Ow1DZbGe69bI4k5+LYuhbZ0TexvMvRcYYbA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fa10fd-a100-45ae-6a55-08d863c0f738
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 15:12:50.4705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ta0uM8ODZz69fKRFV9T2DWyHq1RTo3HkKbRyw5LzXagg5fS1PNeqTDH1v70oTIqby49HErFY7zL7+GMxN2eGtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0425
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_111253_154453_17926F49 
X-CRM114-Status: GOOD (  20.00  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/28 21:35, Christoph Hellwig wrote:
> Move nvme_validate_ns just above its only remaining caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 74 ++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ad18c32b36e7b6..07309f6c14faab 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2156,43 +2156,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	return ret;
>  }
>  
> -static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> -{
> -	struct nvme_ctrl *ctrl = ns->ctrl;
> -	struct nvme_id_ns *id;
> -	int ret = 0;
> -
> -	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> -		set_capacity(ns->disk, 0);
> -		return -ENODEV;
> -	}
> -
> -	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
> -	if (ret)
> -		goto out;
> -
> -	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
> -		dev_err(ctrl->device,
> -			"identifiers changed for nsid %d\n", ns->head->ns_id);
> -		ret = -ENODEV;
> -		goto free_id;
> -	}
> -
> -	ret = nvme_update_ns_info(ns, id);
> -free_id:
> -	kfree(id);
> -out:
> -	/*
> -	 * Only fail the function if we got a fatal error back from the
> -	 * device, otherwise ignore the error and just move on.
> -	 */
> -	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
> -		ret = 0;
> -	else if (ret > 0)
> -		ret = blk_status_to_errno(nvme_error_status(ret));
> -	return ret;
> -}
> -
>  static char nvme_pr_type(enum pr_type type)
>  {
>  	switch (type) {
> @@ -3973,6 +3936,43 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>  	}
>  }
>  
> +static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> +{
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +	struct nvme_id_ns *id;
> +	int ret = 0;
> +
> +	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> +		set_capacity(ns->disk, 0);
> +		return -ENODEV;
> +	}
> +
> +	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
> +	if (ret)
> +		goto out;
> +
> +	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
> +		dev_err(ctrl->device,
> +			"identifiers changed for nsid %d\n", ns->head->ns_id);
> +		ret = -ENODEV;
> +		goto free_id;
> +	}
> +
> +	ret = nvme_update_ns_info(ns, id);
> +free_id:
> +	kfree(id);
> +out:
> +	/*
> +	 * Only fail the function if we got a fatal error back from the
> +	 * device, otherwise ignore the error and just move on.
> +	 */
> +	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
> +		ret = 0;
> +	else if (ret > 0)
> +		ret = blk_status_to_errno(nvme_error_status(ret));
> +	return ret;
> +}
> +
>  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns_ids ids = { };
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
