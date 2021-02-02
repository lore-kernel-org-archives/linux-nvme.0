Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A545BC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 01:34:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F24064E46
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 01:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F24064E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=7ee2uLppGUbg15rIYlKHjofKuDc4clFLQLp/NO4BhFI=; b=CLKXkSdASr7CcMyFadM/4kj6q
	q7DxQIJWdQmK10YSlE/pTM0YXlN8InQV+D9up/nxEGfFZRe6/SU1OhNZPNvWH3jwBsFmqot78Y2gz
	iDKrXJe19vaIvQ54wx1xYUuBoX84mYh4i2JLZzh2G2GodHs5S5PlmzlVsx8dnTmrzUavBU3DXWR/s
	NfTrZ4uYtXw+MQDiPhC3Y6X0iUEZ5Quu/NHoj2r4LD+92M9s+nPvfTBIOd7EIETQuEUvzz2VFLEiz
	nghhA3V6Lk6EdewWrV4uNpeGbsS2fhd1Iv9bgCjwYTMt4kcHcNHIsqSUYQ7b1K7NGkKvEgshcSQqp
	7wPLVXrWA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6kad-0002Gd-PM; Tue, 02 Feb 2021 01:34:47 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6kaa-0002GA-SI
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 01:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612229684; x=1643765684;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=IYhx3Zg59Jq6IVRszIK8EWc0a06cR9dW842gV2/ocHY=;
 b=LXyCCt7J1ZFJ5pMSDU6AJyfgFwRl9qHDscUeLSCDRIVoQqHkmbxs7AB7
 nFrSFFMIrBqrYIz8VstM4OVvzQ9KTOHyMAjuAUQnYQ5xG0y7+iZj2iAg1
 2AgUSGWMgriHxBGbdehQDQK0WCKGln2LAxEmWGHDu2hwwQ7ugwbmuL+zG
 8pjNS4uvu9njzcvX/oxbz7I2F2iH+gvGgsiaRFXCATTV0y4i5XXRZ0rRd
 aQhrE5Md5R0k1WLbN7Z5RQCXMhDWsYELIDbfPvgeP9Q1ZoRItCOoK3zcx
 QKojuSIWEohnOAj4xc1cjV33S44gis23F/iFlUsNQRIhl5HJtrKKxnpOi g==;
IronPort-SDR: A/2WVrU2g4sjJ5KyqSVIuNsFW4XxN3eOYkcqouP/Wu0XDsueQyuUtONryN4kcDeQ7ant02ybYW
 6V0QV5I3RW0xNk8FGt54hGOMjBHZoaVVTzqOvtst6jnOCF2iBLMZSM8PrS+9xksVcSukWzFiT0
 RvkREQmBns/BhdDSEgpO0McYkvhGVkzbB6a7hCz6DVPj5DU27Xk0nlKBRjnOMBAR7BS9j8DW5/
 bPuLh0YTRdmqrdlwnW/4BLfQBhMAFzUYW6RkpQFCc9yp0cfazWEHx4li2LogLGeHRIUw3JlOdX
 aRc=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; d="scan'208";a="158868800"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 09:34:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtv01gaNRP7mExipGQGenBsWzCrj+3H2R17OQqExMjCURPgl7FdI8nbmDUOykKbGcnkLhEN9NEmpCEUzx38OqM4tTiU7DhbedGid416Yrvg5LzWA86W1/5qb5FfaNI9FMoX9ST6Z64LzEWpIoEReyznlIm0HIiQaOsGspSztoIR7E1MAmpgDrpmja3QPb8vDwX5fhqXqoXF/4gherVf990ZKWzkLxw5SDe3Amy3ZEOLh0RLqNy2pcF4H/FPWFNsVAgIPvhCW5bY0xUOrFOM2Y5RLl9JjlaMzvU/dvfvDcuZDRopy6QjEY1cTyzo7kNOt+VJonF7a6neiBMJQha/G1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYhx3Zg59Jq6IVRszIK8EWc0a06cR9dW842gV2/ocHY=;
 b=GAwCHPbYm9plCvGLktJC/s5OY08y+B4uwx/JmSCR/KqqQ1vpxlFJGLQyhwQotFZb5IQFsVaC1ynPZuyrxOK1/fzMtr2BN7yCA9i08ypTkM+qGxmhiRtuZAu040NZmTko2n/vGmtTSDvcNdRU264rJPprSgjvxav+FDbUs11TOqKNcEAs/FDcsPr9R0QOXnsuz071ShsDPO+PaqIIIfkg8BSJsHrbMux22yl/rKMHho0JDQ1do+6a7W7QHPDrZvfhUkKyWhKjqOBPFuafwunlEKL76ciCvAz1iafEnuoKHQm1TTjoG40he1uhUj4rrq8/NVjRdR8Dp8UeJz3fMfPKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYhx3Zg59Jq6IVRszIK8EWc0a06cR9dW842gV2/ocHY=;
 b=uUf/mSWMO7LDN9nI0FvPjyrB1KTX3JbfhzfYLUl8gbL71jMCufPP3wD5Hdk2nrNFSUdxRfBFXLxBBHoHZzabo74JGRzpY04Obbtm55uMyluLZDiIR1raV5T7Si/G+SMYvX83ii8HpWSsKa7bkkG3W2JNuo130EpZRTwI/E2oUhw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5334.namprd04.prod.outlook.com (2603:10b6:a03:c8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 01:34:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 01:34:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Thread-Topic: [PATCH v2] nvme: avoid "(efault)" from
 nvme_sysfs_show_subsysnqn()
Thread-Index: AQHW+P6/HayiD5n8w0ysWGJALtqfiQ==
Date: Tue, 2 Feb 2021 01:34:37 +0000
Message-ID: <BYAPR04MB49653DDA94AA1D6983F070FD86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210202005951.26614-1-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf7227f8-2888-4917-3ce1-08d8c71ab40e
x-ms-traffictypediagnostic: BYAPR04MB5334:
x-microsoft-antispam-prvs: <BYAPR04MB5334600569562626738CEE2F86B59@BYAPR04MB5334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hf39QnG4APrqs+eeccPvr1WwkHpZGAxFKGk3eKVrlD9zyO5l8eVBY/tdCkAp1w1WZT/nVRdJ0DDjkgT/AS6ctuaT34oA5i8dRk0Rq8YHujvzpCyxtSwM1wy927IwyyfXWd1Lsa1Q53kSZ6N5Uodm8dpBvKiSTtVWiKd10cfX58q8txIxe8C4Mdv4ZeJoc+CbPbBnKri9XcNtvfEPnbbqer+E+mC1TjeWvbEsxamIBxBrOjlte9UEe2OH3rUsJELV0KKKrlKakis19wI8mrHDOjzdaEl8eoAhFv8Gq2ZfHuNAYEWFIoqnfaexGvKzxffwx1yWPKPVD5LO00DxpaZ57FJSY+wg8aGBWSkJwovtQ3E3P/LP9Zd+taLsh9+CS0OITOBN1xThoxePK1WuqMXZTpkLrxOI24gpnn9ZB9Uhfgk20OIRD9GESuvsDchTG3NnPazvdDhyHCuPDCBYtCm0+a/pE7VcfdZrB0IRxPJbDAEvlSLbZNg8bPOop4OvvCPH6o5FBQ1iJxGI9OmNrM+6Qg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(86362001)(7696005)(76116006)(91956017)(4326008)(6506007)(5660300002)(66946007)(186003)(110136005)(66446008)(8936002)(54906003)(55016002)(66476007)(71200400001)(66556008)(64756008)(478600001)(9686003)(4744005)(53546011)(8676002)(52536014)(2906002)(26005)(316002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?egUp0EYJjO3jQPJ8FDH7OxdOninyt+xM1KQDhb+wb60KJuKW+haCYObbxQuZ?=
 =?us-ascii?Q?pd/voSCU9g8peKn9lA1rTCyECNITDbKtWScNNqaBzoXEmR743lxVtzhAMu7f?=
 =?us-ascii?Q?bpnBFhKgVD0pJnUTkVJz+WqHeKjEaQpjNLHUbS2Datxu2mFMcQQvZMe+ZULR?=
 =?us-ascii?Q?sz+DxArWPmn1JvOTxFidUpsDx5D94tSRrxUW9OgvE6rIhMSv+xzwhAlRcLIn?=
 =?us-ascii?Q?GktGgqvtXW5KxAK2QIstY1TnZVartXZ2Pi0cDEWZa8i32XsUbhYMtUO865eW?=
 =?us-ascii?Q?mcknxK7aAfOUqyXR95GVLmqiQO62SVjkGpePmPCmIdGGS8ilQRMMIFEeplrR?=
 =?us-ascii?Q?LO/AFcHesVA2O4LlqK0vTAA5JdlPWwHveJ+5U0MESlib0rDFh7fYoUCEBbT8?=
 =?us-ascii?Q?miEq3K7O2lY/upI4TFS+kBVQBlMlT4Ax2L/yrj8CNTyUm19aC7QK6mmI6oMv?=
 =?us-ascii?Q?JpFwvd1ptXw+EIa1n0jzw2CgMKNE2jH8UIkAm9/4dx812NJZSHUD4Si0/Ptm?=
 =?us-ascii?Q?s37Xz+wvnk9jFYcWHzKVIFPOgTnw5fGTyYQyQxYfUU1pU4gY9fWWN5Sz8NAD?=
 =?us-ascii?Q?3OtjvyXsmdKeN/2ljk2JDph4dgxsURQPkwjz1LBT4DxmYUnXLna957ZsFIoP?=
 =?us-ascii?Q?EPw8eYgbAbmfQiZ9d3XqhfFGchz/bAYRr7VAnB276E/BHlebLqBplACBlohS?=
 =?us-ascii?Q?6/4ILD5/UmpO3Hoi6Dn11NtcRZM4noaQiN4OLSxPOGqUKl+Ut2k9qgksxfBj?=
 =?us-ascii?Q?GznzbbjYXm+QAKGmWYblcGCbXQ6GAVzLK8Tu/D4ExBG6Sf/vrhc1AQ+WFDOy?=
 =?us-ascii?Q?/8MpWSvvKNHdW87Y9L5Xw+zSZgb38TFCX0ZugjdPMK9+5obFJ8Mh8/1n35YG?=
 =?us-ascii?Q?rlwULzkDRus5SHPK0mcj4XEeJ4OtQ7wyJXIzPINW7NflFrq/dI0I3q3Q6qI9?=
 =?us-ascii?Q?3kcWGsOl1SV+xqG6oklqE0yhvs6CYyAgNYa3H9opvkG2ld1nP8lJ4XjUSLqR?=
 =?us-ascii?Q?yDJ6nCbFLKQaaLIBPoKYPYTg/InKfkBZuufeRvVhkS4PxYTMZdBbYgGS2D3f?=
 =?us-ascii?Q?c1eho/klUFmEtonSwliQ+hK1tlH4hA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7227f8-2888-4917-3ce1-08d8c71ab40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 01:34:37.6004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZ6G2XUrMSxHRigUnlX5PQoa03Ac3nRJ4iz/mHx4lZQ6IHCFhxDWzgyKvH7xn85LLwFWBt2CGui+2RIkdK4F8zORqtWbqMztjSVo98dbWYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_203445_313193_C63EAD3E 
X-CRM114-Status: GOOD (  11.78  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/1/21 17:00, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
>
> While a controller is still connecting, ctrl->subsys is NULL and
> thus reading the controller's "subsysnqn" sysfs attribute returns
> "(efault)". This happens all the time when user space processes
> "add" events for NVMe controller devices.
>
> Fix it by returning the nvmf_ctrl_options' subsysnqn attribute
> if ctrl->subsys isn't initialized yet.
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
Please add the version history from next time, as it helps others
to review the patch easily than the first-reviewer.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
