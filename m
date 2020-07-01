Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B49C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:20:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBF52085B
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ba6EtVz5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ByH1lRCD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OilG8Ka8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBF52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=iKCh96rI8rHJm7ZnlWnHIrQux6YIV84ln/o4AVmnhZk=; b=Ba6EtVz5jMu4we5+OSSOIe2mH
	Jcq1uDHmZkKm+7hIhHCarGDtJ909NoucBeIeR8mfbKgIyjRMH7uqe/JJfOvUkIDjh0X0YSedUwT8y
	vcxTQgGDxHiseyHKW/H/9gSoMzVCihos6vkyjPZU4jGpXRph9yEOKYrwUjlDGEEM1lrinulUMHJ2b
	Sb9lmD+Yj/yszuaqeOAEgaSNA9J58PCNK3nOSLmfxUQ+iVBEZxpvxlPaoNPmV/VTpTC63JrEUttEK
	JnEp67DN677MlvRGYg9CeuofhXM9YBOyI5lorxdHjumKUyrWlxi8cmnJCDiOkA7F4YLdbSZszUuWb
	0RICEqEVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqhKy-0005p2-38; Wed, 01 Jul 2020 18:20:00 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqhKv-0005oD-M9
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 18:19:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593627597; x=1625163597;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Fo+mlYtwl/vIkK64FxEB7gPRtUHuqmDwpfQ2FQIpXpo=;
 b=ByH1lRCDNvvSj1dv7FLlKIWF+FjyssBnCWzc3npurJIdNYlBPzBCWuBb
 P3K/KgqesQbtQUduDQ0HiYKnEBOyMPAxooxP3h8Lcr5JfE3OvpMvAwUcn
 hYav1awXE4tRWBegrGry7ZWVF58Ev1biYMnQRzwkNXxstqj0MXy4pP6GN
 0zfbfW6Y3DnvSebrfucG/1+9WHaxcSjjc721TAnsTCCXDb5BgFXsCCF2N
 XBpG8MqrVxNtXtKs3A0WKtD4boDGiRPsQH6kdY9V8Q6dixMSNlsS+iow9
 uV7O2hrDgb317KdDJA4amQ8ZLUkoo5+N2hEqwBb/rhrV261dq7FhYqu5j g==;
IronPort-SDR: NCQiBrDldYd1/W2AlytefEpGHQtZzL3nG/38rwnNvhQ73h/Opfa+hWiytvipewbR5t6DeVXiP0
 PxoXNMgvCShhDqNQstSYwLnCngo71VtnnT/9WgYD7bY7/UyAnbmHnoQIGcTee5NRwq+wHDlv/4
 p1OrChLxKw+muHKtdEW21XXwf04B0E/OBxgdpNYEWAbfQ7o0T1B29qkbS+Lb2MsPJ7mT+37n+A
 D5gb6z7LB549PtPWqcX8wPcCJ02Df6tkHnnxDdjgGYbNyfoGW5AOyCuF58a8qP/btF9GqG7XEH
 86U=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="250640932"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:19:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEt+4QIHtjQhNYL9Qe6KOs3tlRBCBl4gkOw6cowMJsBNVLU8+pZvSLlxeg+JuIAmE93Wkt8UEhes7ZjsLAWpGoee43waMJa6v1vHaQjNRJmU2bdKsSddaHLPmkmajGbZDJCI4VXEF77Qf5tNbFmYNQ5k3OLa9Eyt1HQrzApKKeVzYBI1FSneULNGRcIbXHx2etVLYcAa/UxP3+5Jkk6psTGWO6a1VP5KFsCt4KpbaXTDLu7nbjL0GJwOavgDsEglgDbX72cukBZosQ867TY4PCT3P07TbHb3gQ0r/Hv8s7gv3X6SdSG1/qWwQR2R1nNRFjbIF6VHkWSGKFwHxuUjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpcFRYdtJBAkxoOinCBwfwvFizteJoKRJK1PvLZyW+A=;
 b=X1EzB/mS3oD7tvv59OOSPkMwc3xztdAZS/acpBXwRNZlhQ5Ao8wL/61U/uxIkE1/2LhsxYTDiR/GMSf026hhREUwnlJ0PFnxWevv9eYsUwdj/47DfSIMzAPvbTqEpFi8xTNDWUWuAE8SiyZf/HMTqpT0nLj3XUS2AurkZgM67ZW18EHgEptnqYXu3anDBbEY6kNhwIGIQhrRIsnVyj3f+VcW4GK9dFCC0Icydoyzx6MhQJHLunnuUu2AZAuAFWwUXKZAg9EzioRikn1aopDk2PUmpWS3mpQEeoy1GWzR+gvccMNaxLq5fJwlGM37x4o3QsSxQ+3zjUG7R0XqHqZvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpcFRYdtJBAkxoOinCBwfwvFizteJoKRJK1PvLZyW+A=;
 b=OilG8Ka8/m1IKaGdZZ+VfH1lrYrM/7/tOHNdcrBUhZwedYocjQp3doLskhZ4BnQf4nhceoyDTS2sM75VNm/CdNl8BfMw1JTThz7F43JQAc7ZkK/bgLEVY84od+vEA2uRLR2y3iUIQJYdpKHPGYAvV5QGKk0HGv8jkh324Q1JFfw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3960.namprd04.prod.outlook.com (2603:10b6:a02:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 18:19:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:19:51 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V2 1/2] nvme-core: use xarray for ctrl ns tracking
Thread-Topic: [PATCH V2 1/2] nvme-core: use xarray for ctrl ns tracking
Thread-Index: AQHWT07jIAP57v+mRkK34TwenoMqsw==
Date: Wed, 1 Jul 2020 18:19:50 +0000
Message-ID: <BYAPR04MB4965B6A3EE4591E8A05A2982866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701022517.6738-2-chaitanya.kulkarni@wdc.com>
 <20200701131235.GA17919@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b340cf8-8129-4ddb-8631-08d81deb585e
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-microsoft-antispam-prvs: <BYAPR04MB3960B5A7A42BE8ABF86642D6866C0@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuzrN+nmJdEMQg/QYAzbLyI5eyRKrPIsVnz3v1gdInrR6KTiRPhj1ATcIu+XWvFUEkxrnDyLLyVT8eEVgfixkNbav15BsQ1oIllO8TwPkP77AI8gC6Nja/rmw3Y1CjZT45hQZqRAXRjAf2ziJgeS5vxP9YtsSFAVVvnRUMkdQe7tHrteNUC4HziAhz1vnFWWfNZYs+AlhWVX70BjqzsKE6Bvnju9w5PWENiE4zus4bWeoIqACsloBiGXHD1bNXlZk2gZf168ouR6EwGwLL8qrfHOmUnaEjbbjSRkce+REe7TxRmLPAZqBrI+A+YaUfnnKk/kCuOc35yGcsLkoQuAeQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(66946007)(83380400001)(110136005)(54906003)(498600001)(52536014)(55016002)(9686003)(186003)(8676002)(4326008)(7696005)(66556008)(66446008)(64756008)(6506007)(76116006)(2906002)(26005)(71200400001)(53546011)(8936002)(86362001)(33656002)(5660300002)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5SgFHlBIGlK9dkEVvib75Iq5p1BCmw+i/vLUsa2mMy650Tpia2GHQEA0zplCHjc7nD8FkFch+d5/K+2HTYImZLLOt542ewUspKURlODjSiqmFZqPs0HGVrUq0qYsKfo9AEq/8qtJTIHSVwHr5X3SzzgJnohQKgBEdJVymnbTKinrVJjtshzQ85pE00ROevMq4iCwXy4IIlsY46T6DqMpJX5SzMTJNhETn8aotuLe9dfvYeXpgePT+C5sb31++//rxOpgDl3EFCtYhbg6cPSnMjvXqs4tGZ+KcV5haPfL6gT9W7cSK6NNiSIqTqDdknrOvh0e6aJErfhp5qYkEzXeHECOK/tlcnzd+u/bka0yLRAW8lnj8XikLcY6W4/v7DzeY2a8mN8vyn2AdjGMVPLIpsFt8daOZzjYBemeACVOzKLjXidB/g9h61s272d/P3wN0UvVqIVwZyij1uOGw5+ZD1fvtruE2K+cKTE6vbt6oWE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b340cf8-8129-4ddb-8631-08d81deb585e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:19:50.8415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbtLxcxTmm9PbMrUe7McHNeSlEBKVc1lZh+E03Pb8ZcLsrSwt7PEbbPQ5V2ZBU/cwfQuWItbz8Ce1L0U9bHLWsjU3SRcjcPN4TCGhOdteRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_141958_108926_AE9B60F9 
X-CRM114-Status: GOOD (  29.90  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/1/20 6:12 AM, Christoph Hellwig wrote:
> [willy: a comment/request on the xa_load API below]
That will be great.
> 
> On Tue, Jun 30, 2020 at 07:25:16PM -0700, Chaitanya Kulkarni wrote:
>> This patch replaces the ctrl->namespaces tracking from linked list to
>> xarray and improves the performance.
> 
> The performance improvement needs to be clearly stated here.
> 

This is a preparation for the passthru code which uses 
nvme_find_get_ns() which falls in the fast path from passthru to host
core. Having linked list will have same performance issue with which
I've reported on for the NVMeOF gen-blk target using nvme-loop when we 
integrate passthru.

How about we get this series in a good shape and before you apply I'll 
forward port on the passthru V14 and document the performance numbers 
for both the non gen-blk and passthru NVMeOF target ?

OR you want to see the numbers now with the comments fixed in V3 ?

I'm fine either way.

>>   static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
>>   {
>> +	struct nvme_id_ctrl *id;
>>   	struct nvme_ns *ns;
>> +	int ret = 0;
>>   
>> +	if (xa_empty(&ctrl->namespaces)) {
>>   		ret = -ENOTTY;
>> +		goto out;
>>   	}
>>   
>> -	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
>> -	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
>> -		dev_warn(ctrl->device,
>> -			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
>> +	/* Let the scan work finish updating ctrl->namespaces */
>> +	flush_work(&ctrl->scan_work);
>> +	if (nvme_identify_ctrl(ctrl, &id)) {
>> +		dev_err(ctrl->device, "nvme_identify_ctrl() failed\n");
>>   		ret = -EINVAL;
>> -		goto out_unlock;
>> +		goto out;
>> +	}
>> +	if (le32_to_cpu(id->nn) > 1) {
>> +		dev_warn(ctrl->device,
>> +		"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
>> +		goto out;
>>   	}
> 
> This code doesn't make any sense at all.  Why does a patch changing
> data structures add new calls that go out on the wire?
> 
Yes, this should not be here, I'll remove that and only keep the code to
check multiple namespaces and if needed this needs to be a separate
patch.

>> +	struct nvme_ns *ns;
>> +	XA_STATE(xas, &ctrl->namespaces, nsid);
>>   
>> +	rcu_read_lock();
>> +	do {
>> +		ns = xas_load(&xas);
>> +		if (xa_is_zero(ns))
>> +			ns = NULL;
>> +	} while (xas_retry(&xas, ns));
>> +	ns = ns && kref_get_unless_zero(&ns->kref) ? ns : NULL;
>> +	rcu_read_unlock();
> 
> This looks pretty weird, but I think the problem is one in the xarray
> API, as for the typical lookup pattern we'd want an xa_load with
> external RCU locking:
> 

The Kref needs to be taken under the lock so I've open coded the 
xa_load() and added kref get under rcu locking.

Matthew can shed more light above pattern this ?

> 	rcu_read_lock();
> 	ns = xa_load_rcu(&ctrl->namespaces, nsid);
> 	if (ns && !kref_get_unless_zero(&ns->kref))
> 		ns = NULL;
> 	rcu_read_unlock();
> 
> instead of duplicating this fairly arcane loop in all kinds of callers.
> 
>> -	down_write(&ctrl->namespaces_rwsem);
>> -	list_add_tail(&ns->list, &ctrl->namespaces);
>> -	up_write(&ctrl->namespaces_rwsem);
>> +	ret = xa_insert(&ctrl->namespaces, nsid, ns, GFP_KERNEL);
>> +	if (ret) {
>> +		switch (ret) {
>> +		case -ENOMEM:
>> +			dev_err(ctrl->device,
>> +				"xa insert memory allocation\n");
>> +			break;
>> +		case -EBUSY:
>> +			dev_err(ctrl->device,
>> +				"xa insert entry already present\n");
>> +			break;
>> +		}
>> +	}
> 
> No need for the switch and the detailed printks here, but we do need
> actual error handling.
> 

We need to add a wrapper nvme_xa_insert() to take care for the error 
handling with pr_debug() and switch() which can be used everywhere
to not bloat the functions calling xa_insert() are you okay with that ?

I'll have goto above based on if you are okay with the xa_insert() 
wrapper nvme_xa_insert() to undo things that alloc ns does.

>>   static void nvme_ns_remove(struct nvme_ns *ns)
>>   {
>> +	struct xarray *xa = &ns->ctrl->namespaces;
>> +	bool free;
>> +
>>   	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>>   		return;
>>   
>> @@ -3740,12 +3749,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>   			blk_integrity_unregister(ns->disk);
>>   	}
>>   
>> -	down_write(&ns->ctrl->namespaces_rwsem);
>> -	list_del_init(&ns->list);
>> -	up_write(&ns->ctrl->namespaces_rwsem);
>> +	xa_lock(xa);
>> +	__xa_erase(xa, ns->head->ns_id);
>> +	free = refcount_dec_and_test(&ns->kref.refcount) ? true : false;
>> +	xa_unlock(xa);
>>   
>>   	nvme_mpath_check_last_path(ns);
>> -	nvme_put_ns(ns);
>> +	if (free)
>> +		__nvme_free_ns(ns);
> 
> This looks very strange to me.  Shoudn't this be a normal xa_erase
> followed by a normal nvme_put_ns?  For certain the driver code has
> no business poking into the kref internals.
> 

There is a race when kref is manipulated in nvme_find_get_ns() and
nvme _ns_remove() pointed by Keith which needs ns->kref to be guarded 
with locks. Let me know I'll share a detail scenario.

Given that xarray locking only uses spinlocks we cannot call
nvme_put_ns() since it will sleep, so it separates the code.

>>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>   					unsigned nsid)
>>   {
>> +	struct xarray *namespaces = &ctrl->namespaces;
>> +	struct xarray rm_array;
>> +	unsigned long tnsid;
>> +	struct nvme_ns *ns;
>> +	unsigned long idx;
>> +	int ret;
>>   
>> +	xa_init(&rm_array);
>> +
>> +	xa_lock(namespaces);
>> +	xa_for_each(namespaces, idx, ns) {
>> +		tnsid = ns->head->ns_id;
>> +		if (tnsid > nsid || test_bit(NVME_NS_DEAD, &ns->flags)) {
>> +			xa_unlock(namespaces);
>> +			xa_erase(namespaces, tnsid);
>> +			/* Even if insert fails keep going */
>> +			ret = xa_insert(&rm_array, nsid, ns, GFP_KERNEL);
>> +			switch (ret) {
>> +			case -ENOMEM:
>> +				pr_err("xa insert memory allocation failed\n");
>> +				break;
>> +			case -EBUSY:
>> +				pr_err("xa insert entry already present\n");
>> +				break;
>> +			}
>> +			xa_lock(namespaces);
>> +		}
>>   	}
>> +	xa_unlock(namespaces);
> 
> I don't think you want an xarray for the delete list.  Just keep the
> list head for that now - once we moved to RCU read side locking some
> of this could potentially be simplified later.
Okay that make sense will keep it simple, will do.
> 
>>    */
>>   void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>   {
>> -	struct nvme_ns *ns, *next;
>> -	LIST_HEAD(ns_list);
>> +	struct xarray rm_array;
>> +	unsigned long tnsid;
>> +	struct nvme_ns *ns;
>> +	unsigned long idx;
>> +	int ret;
>> +
>> +	xa_init(&rm_array);
>>   
>>   	/*
>>   	 * make sure to requeue I/O to all namespaces as these
>> @@ -3919,11 +3950,30 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>   	if (ctrl->state == NVME_CTRL_DEAD)
>>   		nvme_kill_queues(ctrl);
>>   
>> -	down_write(&ctrl->namespaces_rwsem);
>> -	list_splice_init(&ctrl->namespaces, &ns_list);
>> -	up_write(&ctrl->namespaces_rwsem);
>> +	xa_lock(&ctrl->namespaces);
>> +	xa_for_each(&ctrl->namespaces, idx, ns) {
>> +		tnsid = ns->head->ns_id;
>> +		xa_unlock(&ctrl->namespaces);
>> +		xa_erase(&ctrl->namespaces, tnsid);
>> +		/* Even if insert fails keep going */
>> +		ret = xa_insert(&rm_array, tnsid, ns, GFP_KERNEL);
>> +		if (ret) {
>> +			switch (ret) {
>> +			case -ENOMEM:
>> +				dev_err(ctrl->device,
>> +					"xa insert memory allocation\n");
>> +				break;
>> +			case -EBUSY:
>> +				dev_err(ctrl->device,
>> +					"xa insert entry already present\n");
>> +				break;
>> +			}
>> +		}
>> +		xa_lock(&ctrl->namespaces);
>> +	}
>> +	xa_unlock(&ctrl->namespaces);
> 
> Same here.
Yes there is pattern here and I was wondering if we can ge rid of this 
duplicate code will see.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
