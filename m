Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC71C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:16:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B254208FE
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n+hzLNM8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZxvvSCpc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AN3EzGg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B254208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=U0jwndVl3KKYdnMsqeN4W5KSiEQoa6QeRaA0jvG1lNk=; b=n+hzLNM8xmi+gslLLY0wFi+T5
	J0lBBagxahri0jnAbrr+Qk2TtXbte2oSI6/Klgd2a5Wm+fX/g9t4abimTCrTImZrftpPIj/kGzdlJ
	ls6mKBHdPaz6te8pAGd/vfR+FE/um8IukwisBoM7fWQjWXTYmoLE60Vp3/NXQBx4cJVIz6GWBoMm3
	43DdsSaZi5yAPhiDmCHnu9pNN7BFq4KHtBZ58jvzxPmw9Cv2B7A/cD2lZCcG+609yoqQ6W5devdw1
	T8et525GFf9hGBEtDMK9QaXdx0b8GFXWUhxVM0FM4MVpDPMuV0gk92Du8QWPcLa62H9gRVE9KPVI2
	vtxrZEbDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMusx-0006AB-4V; Mon, 28 Sep 2020 15:16:15 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMusu-00068v-9o
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 15:16:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601306172; x=1632842172;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xZTZID5ma9kgdp2oJpfCxVOGKYDfskLA80b5k7+EJHU=;
 b=ZxvvSCpci0JPFVXx06i53F+5LXEz2hGaHbljvl6bltdu6HNB8yJTkKA+
 7Q5rzYwLPzwRUJajQzhXsTGXz2zP9cuOFXiLOVWPiW+RVgeMBMD2XunxA
 En5hggraavbVP7bWv66g6/ZVKvB9ROfdxpY/QXP5Xb25S1pcBHjBTyP9E
 4WORgu2yRB9RApuw8LcsGHamYB958htQsUYiVjvPsz3OachpG4SZpSsNw
 66tXEvsAQ772zfEtKHgUEHHx14YNyS69npEoLlcTNrTdi08mKDhyveUrR
 L/TXCfVPzi6Aj0jnXfZ+cMJt6i3QZtjHNDTOxXjbNYBDeU7E75yMqIGBb g==;
IronPort-SDR: ULQW4RtLxt5WtvE9N6I4/GFFdSW9P/FmwdwWS5eNplX3en4Wy+nTqjaT9ywyYnKbDxAI+9AQyV
 SMIhczR8d4+hetmUaWntQud9+QFcBUZOdendPUFAtVLf5iiSw7iQR9wM82oxPMmfRuKfTDmKNB
 PdUn4aibEm/igt6UuNIcPeW1SKjpvVbFjU002/03XkOjYtbDXdub8WQjccWgMLEff4GOspXI0Q
 uVnJxtcucchzm158RoAbmOz4d0LYUieJpjygjDbnN6TegDRC4NrZOmEywwKwMOc8lb8CmKXScf
 gDs=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="148473477"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 23:16:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmHaUKVB+WCyF2RcY+TpUAmz8QALVCPRMV6UC5Fm8DKdurAYALahGZs7nIE2pdYtfTfENSyb5N6rj7SvOA8jsJ//vhV/tjCzGaaHB/n6vNU/EIG+RE+sUtJizhqbWOXwu7mdml4WSrp60HYwD4YbA2UAwwckYBft6jad1KJz62kiXGkq3tdf0dFAhZRJrkoMqK0FlIqK0+L5QRKGBUIFfJ3T1BhTt7qb2sQuQxyLVKyufQK4egR1QsOL6+rs53T+kwV1lgDJyuR1TnbAQ9V+kmaKFoT6TVKLEkzs6BY8Si6BWRCbVxocd2uemBI0R4exyQNed2nJGrGSjBwWX7SP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8bdU70IY2nKXsjyXR1rGACIK0V1TnxH40o7q/p+6HA=;
 b=PMYurShvBcYeUyXQmmxjZb95INNQ1qOiTMgnKks53fYiAeYHms0TPBhfBjTEv1GGu9YQHsFAC5PUUgmSpxC9OMsM2PjFU/UVYpqpNe/eq5/FHr8kTqNoeryv9uuLVetv3JHlXV0zaItgAmAT2Re37yM5v8EcVecu/Fn2/otQMso9idhCmXdOBUstWbhx6BFSX3NjZMJIwE0UNDI0qVLCrYtVfEEzSo16+dhUSBZoVtgX1ZUTfv8AWHx6dUF2zOgEA71kcqHAUvAQIBM87FtfO3/qUs/FYfT02qA9FXHnFm3cvXYfOIgMKsyi4snHg+Bo3m/tGokxceIviZ9sUqGOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8bdU70IY2nKXsjyXR1rGACIK0V1TnxH40o7q/p+6HA=;
 b=AN3EzGg5QiuDAVgatoh1pjrcL5ozN53zPfTFjz4ola0stmTxYZ4OfvQ/UDyMVUb/KIG471l1ylEDO4gxzco5saNoC5kbGMVYyhsfTL9Oas3WDuM+cDeUTwKyVqh9IurNsAOcO6QTdk14yGj8p3nNzsX7fAw5mQEDrc3vpHi89RI=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3587.namprd04.prod.outlook.com (2603:10b6:910:8d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 28 Sep
 2020 15:15:57 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:15:57 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 19/20] nvme: refactor nvme_validate_ns
Thread-Topic: [PATCH 19/20] nvme: refactor nvme_validate_ns
Thread-Index: AQHWlZPgdgWCU+NJa0G0ODJ265UgzA==
Date: Mon, 28 Sep 2020 15:15:57 +0000
Message-ID: <CY4PR04MB37511A96D7F855F0E3B8C85DE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-20-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fc1448d-f655-40df-6af3-08d863c166ba
x-ms-traffictypediagnostic: CY4PR0401MB3587:
x-microsoft-antispam-prvs: <CY4PR0401MB358762454E48A2E54D014694E7350@CY4PR0401MB3587.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvEpT2Z20BhMZGXr4WI/oR2YXtPizB1KGVZvAc2P19nduPtPsF9fxq866xkY73lFHhe03BHMtBBn2nu9aAXat1D1qEmCRuY5DT30KCvJdH1a6GEpvK7OdqDUZxkj5Bx1VQFIqTE3IPiA3Hfr0cAgitQ1KHToUsCF5y6voV+Q0sN1Iq6I5/zasYg3UsGVUI82AJoEOMmFZSCyqhuAtcS9Hcv1grTgtPZc2ke14R36kUJE+uKADVnSsLIg9i3ioJYWyQUhdBRDaPRdoiMjO+JmOLQE9H6fX7e14/DKI9HHpxjogJEOYp4RpFu/ejWP7hm58U2uU0XcySja73WQ2kJ3HWynfbigPXdKCm6/kJio7nTtQYZCb/mm/CWByY6D2wNR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(5660300002)(8676002)(8936002)(52536014)(33656002)(53546011)(6506007)(91956017)(76116006)(186003)(66476007)(66556008)(64756008)(66446008)(7696005)(66946007)(86362001)(4326008)(9686003)(54906003)(55016002)(316002)(83380400001)(71200400001)(2906002)(110136005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XkewDIw7g6Og2uIaBRzHekPl1NgLGS4JHYy+t43bKZlWTu2qOOW/Lk9pfjUePW+ixNNsjvz8EKg6hwq+gD0LDCa+y+ZwxYrkuYv97ev/Bx5c4QEI+JDrB1cTDb84gEWNzio7qoUpnvgEKFhJaR9gB4du6Iz5P1WKx6xT3uWL85Xy6j7SQWAPch4WDugfINWsQEAWgWhvxeAFYS+WGzZNIOcMWLNJbiy7GbR7ooP2zBgsM9SU5Dldz5b8Be9y0QnVMo6NO3UuZi8e5ixlDPe9uEMypXa30Fa67iJRv36AWt3O4uZbXr+Tr1wQwFMyX40dULPRksJlhtT4oLAwygUUCSeTS8cYN3/E3j+vTPFlO2s3z0A05q79A+Zx36oLkRuWCJ6+I3YIpBtPQEfCBTWFUvLLCYD6FOO4CVDjGce9URcGr2fJfwnqjrEqgj6LgXrxtx8+P0yQMT8KkkCvkRjFKnywz9AMrJm+rLOiBD4Xtym6KthMo93/8ngWMrq5yHrH4FdEHl8Da6NhiOfL10FyVcVippee5zHfeAZjaq77L0Sgn1ytQ4VW0mXAi4qu5f71nJq2vh38Y0pmjILjUjGcSdxdwU0MYNh53bBQYVhUpUTDhGzQ/gKHXsb7HUN9X1+knClxp7KaWt9gVcELJTLm1fva95CkMHf5sbYkXruq1cAD1WrwbknjF3aSpD8ZjEKxVfJAHqpXDlEEeFXiULu5lw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc1448d-f655-40df-6af3-08d863c166ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 15:15:57.5406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ORC5RIseaWqg7eo+bg09Sg9n5hsbajrV+n3Jv2XKD5Bdic9TnwiqskyFfeHMsccj9OBYVz1Py4LGNA4vo4+8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3587
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_111612_511226_021AB437 
X-CRM114-Status: GOOD (  22.85  )
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
> Move the logic to revalidate the block_device size or remove the
> namespace from the caller into nvme_validate_ns.  This removes
> the return value and thus the status code translation.  Additionally
> it also catches non-permanent errors from nvme_update_ns_info using
> the existing logic.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 07309f6c14faab..0b88a377a47f6e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3899,6 +3899,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>  		return;
>  
> +	set_capacity(ns->disk, 0);
>  	nvme_fault_inject_fini(&ns->fault_inject);
>  
>  	mutex_lock(&ns->ctrl->subsys->lock);
> @@ -3936,58 +3937,54 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>  	}
>  }
>  
> -static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> +static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>  {
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	struct nvme_id_ns *id;
> -	int ret = 0;
> +	int ret = -ENODEV;

No assignment needed. nvme_identify_ns() will overwrite it.

>  
> -	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> -		set_capacity(ns->disk, 0);
> -		return -ENODEV;
> -	}
> +	if (test_bit(NVME_NS_DEAD, &ns->flags))
> +		goto out;
>  
>  	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
>  	if (ret)
>  		goto out;
>  
> +	ret = -ENODEV;
>  	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
>  		dev_err(ctrl->device,
>  			"identifiers changed for nsid %d\n", ns->head->ns_id);
> -		ret = -ENODEV;
> -		goto free_id;
> +		goto out_free_id;
>  	}
>  
>  	ret = nvme_update_ns_info(ns, id);
> -free_id:
> +
> +out_free_id:
>  	kfree(id);
>  out:
>  	/*
> -	 * Only fail the function if we got a fatal error back from the
> +	 * Only remove the namespace if we got a fatal error back from the
>  	 * device, otherwise ignore the error and just move on.
> +	 *
> +	 * TODO: we should probably schedule a delayed retry here.
>  	 */
> -	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
> -		ret = 0;
> -	else if (ret > 0)
> -		ret = blk_status_to_errno(nvme_error_status(ret));
> -	return ret;
> +	if (ret && ret != -ENOMEM && !(ret > 0 && !(ret & NVME_SC_DNR)))
> +		nvme_ns_remove(ns);
> +	else
> +		revalidate_disk_size(ns->disk, true);
>  }
>  
>  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns_ids ids = { };
>  	struct nvme_ns *ns;
> -	int ret;
>  
>  	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
>  		return;
>  
>  	ns = nvme_find_get_ns(ctrl, nsid);
>  	if (ns) {
> -		ret = nvme_validate_ns(ns, &ids);
> -		revalidate_disk_size(ns->disk, ret == 0);
> -		if (ret)
> -			nvme_ns_remove(ns);
> +		nvme_validate_ns(ns, &ids);
>  		nvme_put_ns(ns);
>  		return;
>  	}
> 

With the nit above corrected,

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
