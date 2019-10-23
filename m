Return-Path: <SRS0=6M3L=YQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF40CA9EB9
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 20:31:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A2D20659
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 20:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0bRB5iQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XAjyC8kd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U8WKUUGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A2D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=cOCdJ6nv+TosY4Tty8E9Dhdf+4iOhi/hass5GRL7qQg=; b=u0bRB5iQHcJ0FX
	FOxcojveQG5f6vFSFr/3N9tVfzz+jq1ZmqVGKMCJrQ33M2lQV6VIr1F3ai7sQZSX7D7ShNBOmShlO
	Q4ZTFGZLqMcc6qCG3quRmDYh2Zf7ueQNEKHUco775ny/Mx3ZL9/m4uXvm1wK1GfUdR1q0ksejLamZ
	GSa1XAx69fcICHlVuzVfWmIDCyl9ddhhkJxSCUZeh1/EIftzLE1sI/BRYHhVjeN3g4djIjc0mFf8e
	eN92kC0vMAFwwUiUK0lJR2qjzKILwLKxXFG2wgO6YjgCvxRiezY468ottSEBBRqdRnw+gQ621PuBQ
	WbABfjZDQihPcW/VbFkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNNI4-0006PN-8C; Wed, 23 Oct 2019 20:31:32 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNNHy-0006OU-CL
 for linux-nvme@lists.infradead.org; Wed, 23 Oct 2019 20:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571862686; x=1603398686;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aPAXY7R7qCV/cC40y/BXzosCyCrUOiSfTgiJW4B394M=;
 b=XAjyC8kdOzye7pRhrYjTFHAF71V2kRwv1eeViDTxDAo8fmrLzoScix6d
 qUsm+gFv1NM4sf1Q9CcqovBK3XH9Z0BMc09wXfWDVuJkZvEGi+xaOazXm
 M5yxL2EJa/ehvFHDELP+UhxJMPWmrBB1hn5lVaft82c488oK7Qe5zYESy
 snf7JKUbgIjhhSBpcmSccz4B95+7pSM6qMHv4saZnKPiJJxbTA8OmbXgw
 LqiwLsYL1gpccGzNfW6j0E+jGAGErdJ1/zimZb0kFqt3J7emWFhKWEZFH
 ZL9et2vQ17l3jAT8m/ZGv/GfRAUS+CevTrom5csFu911ThUGSBn++AUXC w==;
IronPort-SDR: Z4Aq/DODSAANbNrx0m80egQCjvWPLa+CFmZtc1FrShdZzgORDtIS27CAzeZnMnd/566KqO49J/
 k30U3heRjcA91DItXlMfiFQbmKnIVhgTZwhvEUKuP4pffD/yktNc+VnN5VmXpYjgmV0IPNxf6n
 jmEcp5i+xF7bD7JuAQa2+pYGXz6GKVg7/wqTOem3GyXhh0W69qqK8XmDXKSem2o3e0TQXlUdmF
 mBM+BCn4Ri5MNXO/HFF6D2UgnvB6Ugx+6+5nWMk3AB8+TtUaoDlFr8liPXuq5vrPcVV+/CLT7I
 ZHc=
X-IronPort-AV: E=Sophos;i="5.68,222,1569254400"; d="scan'208";a="121199418"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO
 NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
 by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2019 04:31:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF14ctGTkm1vwKwDA9aU3Rcrx7dDUCA3cOJtMUGC7Du78FTzRuSqW81eC/tfcytTbRi13i7KMEePkfoJ6pKP05QXEOBj8EiGqXKHjOFQ3aRv91+2P/emrTgvO9PZ7aofvUEb2DoyucBXXuEKdYjeeJ0K53lG+BoAJ9l2o7UvRd7zv+ragh4nWQcEQDZeRQ6pK42n05QKu9CgYzUFe9KIgYf/k+RWwRZMsJzKf7tvX+Otim7Var4dD52/Jm3Ic5sJSOByMSIfGEWsIFPq/vmPipsQaJyIfiisjsOQRxzEuWrGloaNncTt3p2/3eC3Sv5MEDYU/Men09W6VGJY1+gx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3CNpUbnYvkOxOeCovSulGix+C6qDGJBuPTHGkfUV+E=;
 b=IkyGj5jjQGE7kLqVGf4gb/8YSD5t/BfLuma/yffXBptdZIA129nWkmANJ62rhsk0jtPyJmWU3h8gvyQ3hk+RmkvW4S140PgvVffpdvzKb0txtB3iD/YCqsfh7O/xRDtYPqaLXWGuWLM7/B1JeLlslD2tdl+c02OlgSat32WvTsj70GmC+x+BCFENt4Naf5Ei+ooDDnw+NqjNDw8u0yHefxSvHe9+Fbx89scoDB0bzF3KzcpWTsJhtATeCgxoZYYqDFsOmEmiLwmRkn/thUnEDRSRKIUeoYZ7cC0TLP2DpKtTByza+R5MD4X/dmkX+InYkGIDTp1toyrjcEMgiVCMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3CNpUbnYvkOxOeCovSulGix+C6qDGJBuPTHGkfUV+E=;
 b=U8WKUUGd9HKUbwTS+fbEAgLE4XSkk991G/JWXedOcAYLR6RcEv24sGo5gbsJltayynSWjwhvUrejvV5jT4r3l3guw5jzZLJ03csGoocK/4D/TQt0n7Dlp+X9ZMTiiauZlETkB1KICiOiB0E0fxj8iwiKGZBqbzJD+/uU+UHM3DA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4742.namprd04.prod.outlook.com (52.135.239.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 20:31:19 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 20:31:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
Thread-Topic: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
Thread-Index: AQHVib/9UOiReJn9AkSMsa7C5dVEEw==
Date: Wed, 23 Oct 2019 20:31:18 +0000
Message-ID: <BYAPR04MB57492DE452441E784E88DBAA866B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-4-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 740b0541-c65a-465c-4e3d-08d757f7f5d1
x-ms-traffictypediagnostic: BYAPR04MB4742:
x-microsoft-antispam-prvs: <BYAPR04MB474273BA853F3EC804BE4659866B0@BYAPR04MB4742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(189003)(199004)(76116006)(64756008)(66946007)(66556008)(66446008)(6506007)(66476007)(7696005)(8936002)(26005)(53546011)(66066001)(76176011)(102836004)(55016002)(99286004)(256004)(229853002)(186003)(498600001)(14454004)(2201001)(86362001)(6246003)(110136005)(6436002)(81166006)(81156014)(52536014)(9686003)(305945005)(2906002)(2501003)(4326008)(5660300002)(3846002)(6116002)(8676002)(486006)(71200400001)(71190400001)(54906003)(74316002)(446003)(33656002)(25786009)(7736002)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4742;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IsOLCgamFDX3VduWf/HHySq8MeNkETcYXhcnys+wLBQZBDAldMKn6vJ58s22XNtSQ00EDc1MG1yQ6N5a04TYsxWqA7OsUrdCJdz3dX+JQQeAtL2nvyX8aFQaok60z5yVL8wR5YbQXalRDfEYU+SDC4PTEmo6r6qvJjuzAnOkzVqFQT3nevqREMC2wyQWASkNE/DMBiSiln+lQKJwgZtEmXEc5UE8U8tjhLS9rH4hf5etYylI84Ju5SEneB3y6lOLXVImqSOBfhd9BtnWLAZBdi5zEnIhABLmGoHUEU5ZIVsICsSlTK8ugb/FY2X1UoSR6diTSCh6xpgQDqBtpf6QgeBO9sl4MlG4m7FTeN31oGewA+BEP0mRoZVl5HEnwD+3bG6/BEJdbt40IzZYtt+VqXXzpK5yfWvrgCsCkYwifg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740b0541-c65a-465c-4e3d-08d757f7f5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 20:31:18.7818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqQEWABrYBYXGrdLJVmL8tZjAhp8T5NngZfHYrWwjDFYWuavR3JpixUt0HWFf7byi8jkMc513/yGaNJozfBxcO+RKMzDday8fBQBkSeCAqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4742
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191023_133129_010597_ACBDA026 
X-CRM114-Status: GOOD (  16.36  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for this patch.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 10/23/2019 09:36 AM, Logan Gunthorpe wrote:
> Instead of picking the sub-command handler to execute in a nested
> switch statement introduce a landing functions that calls out
> to the appropriate sub-command handler.
>
> This will allow us to have a common place in the handler to check
> the transfer length in a future patch.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [logang@deltatee.com: separated out of a larger draft patch from hch]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 93 ++++++++++++++++++---------------
>   1 file changed, 50 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 831a062d27cb..3665b45d6515 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -282,6 +282,33 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>
> +static void nvmet_execute_get_log_page(struct nvmet_req *req)
> +{
> +	switch (req->cmd->get_log_page.lid) {
> +	case NVME_LOG_ERROR:
> +		return nvmet_execute_get_log_page_error(req);
> +	case NVME_LOG_SMART:
> +		return nvmet_execute_get_log_page_smart(req);
> +	case NVME_LOG_FW_SLOT:
> +		/*
> +		 * We only support a single firmware slot which always is
> +		 * active, so we can zero out the whole firmware slot log and
> +		 * still claim to fully implement this mandatory log page.
> +		 */
> +		return nvmet_execute_get_log_page_noop(req);
> +	case NVME_LOG_CHANGED_NS:
> +		return nvmet_execute_get_log_changed_ns(req);
> +	case NVME_LOG_CMD_EFFECTS:
> +		return nvmet_execute_get_log_cmd_effects_ns(req);
> +	case NVME_LOG_ANA:
> +		return nvmet_execute_get_log_page_ana(req);
> +	}
> +	pr_err("unhandled lid %d on qid %d\n",
> +	       req->cmd->get_log_page.lid, req->sq->qid);
> +	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
> +	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
> +}
> +
>   static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   {
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> @@ -565,6 +592,25 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>
> +static void nvmet_execute_identify(struct nvmet_req *req)
> +{
> +	switch (req->cmd->identify.cns) {
> +	case NVME_ID_CNS_NS:
> +		return nvmet_execute_identify_ns(req);
> +	case NVME_ID_CNS_CTRL:
> +		return nvmet_execute_identify_ctrl(req);
> +	case NVME_ID_CNS_NS_ACTIVE_LIST:
> +		return nvmet_execute_identify_nslist(req);
> +	case NVME_ID_CNS_NS_DESC_LIST:
> +		return nvmet_execute_identify_desclist(req);
> +	}
> +
> +	pr_err("unhandled identify cns %d on qid %d\n",
> +	       req->cmd->identify.cns, req->sq->qid);
> +	req->error_loc = offsetof(struct nvme_identify, cns);
> +	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
> +}
> +
>   /*
>    * A "minimum viable" abort implementation: the command is mandatory in the
>    * spec, but we are not required to do any useful work.  We couldn't really
> @@ -819,52 +865,13 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>
>   	switch (cmd->common.opcode) {
>   	case nvme_admin_get_log_page:
> +		req->execute = nvmet_execute_get_log_page;
>   		req->data_len = nvmet_get_log_page_len(cmd);
> -
> -		switch (cmd->get_log_page.lid) {
> -		case NVME_LOG_ERROR:
> -			req->execute = nvmet_execute_get_log_page_error;
> -			return 0;
> -		case NVME_LOG_SMART:
> -			req->execute = nvmet_execute_get_log_page_smart;
> -			return 0;
> -		case NVME_LOG_FW_SLOT:
> -			/*
> -			 * We only support a single firmware slot which always
> -			 * is active, so we can zero out the whole firmware slot
> -			 * log and still claim to fully implement this mandatory
> -			 * log page.
> -			 */
> -			req->execute = nvmet_execute_get_log_page_noop;
> -			return 0;
> -		case NVME_LOG_CHANGED_NS:
> -			req->execute = nvmet_execute_get_log_changed_ns;
> -			return 0;
> -		case NVME_LOG_CMD_EFFECTS:
> -			req->execute = nvmet_execute_get_log_cmd_effects_ns;
> -			return 0;
> -		case NVME_LOG_ANA:
> -			req->execute = nvmet_execute_get_log_page_ana;
> -			return 0;
> -		}
> -		break;
> +		return 0;
>   	case nvme_admin_identify:
> +		req->execute = nvmet_execute_identify;
>   		req->data_len = NVME_IDENTIFY_DATA_SIZE;
> -		switch (cmd->identify.cns) {
> -		case NVME_ID_CNS_NS:
> -			req->execute = nvmet_execute_identify_ns;
> -			return 0;
> -		case NVME_ID_CNS_CTRL:
> -			req->execute = nvmet_execute_identify_ctrl;
> -			return 0;
> -		case NVME_ID_CNS_NS_ACTIVE_LIST:
> -			req->execute = nvmet_execute_identify_nslist;
> -			return 0;
> -		case NVME_ID_CNS_NS_DESC_LIST:
> -			req->execute = nvmet_execute_identify_desclist;
> -			return 0;
> -		}
> -		break;
> +		return 0;
>   	case nvme_admin_abort_cmd:
>   		req->execute = nvmet_execute_abort;
>   		req->data_len = 0;
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
