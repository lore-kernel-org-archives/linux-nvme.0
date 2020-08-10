Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2757C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 17:35:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BE0206B5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 17:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eF+ca9DT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AKU2aZKm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VuHHWH6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BE0206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=2rwLKNoZzjN7emcR9JCsYRrVDdsVeACvqze1/2ZXskY=; b=eF+ca9DTPixox1CzZ5BzBVFAA
	cxwyRAMTK3p3h9XNYmg5I6AIZHCnIUVtxVh+ApPW+5rATLQyLtgLlrY2mL9uI+9gXv0RziCYx2tlj
	rxJSLj/9X51jOXaw7BXUCenIxuDag75sH2SrwDutCJkbsV7BUNTeCppcvt9alNZ8IhfuMRmgTmskC
	t0wVgX6zs965DtlXk6wRxOfpmbiqFZ2h8o736rp0qQa5UFY416Y7qml0JAP05OVz0hgJ5emtxC8Bi
	BCPENesYj3ZWgqcZukoAOpzIDw4NAmKgJqwycS9dN7PaTDm0++5pRXijfMytHLSLfMFzwIvq9z9cl
	eztqGlB/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5BhZ-0006j6-7I; Mon, 10 Aug 2020 17:35:13 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5BhW-0006iC-LW
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 17:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597080928; x=1628616928;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pLpEhy0yXJStl5iBdUQMNQHiMSBYgzNlUOcLB5uYhv4=;
 b=AKU2aZKmF6qPUtQlhV/h6vME4DcKsi+lsjyiHyq9Xvw1LHAAN8Ljh4wf
 /GsupWivExgTzIPjqM4JIjC+onqlXSkGxwTm8UMuzpcPRwSsa5un1y5bI
 YILPux2xrliuc2N+LfgZ2AAPrQShcaqJ1lfWrazAbHrH3vX1g/MdBRkRP
 jSO98O00MncDPDzn3TyS0Xj33y/NgPWTo7Asn0X4dGJkzezAZxZDkJqP3
 wgMBfc68r/8JRILUFRd9FYYsdjxr9WweTT/JTrPfvvhInufbTGXMrNerw
 u8N/TB8kYYazevleviqivUAx4zA6ZnTo3YTHmjhdRl6Sjq2oOPYrrE63+ g==;
IronPort-SDR: ipsYWeGck1RVNO3rGXAhEmmWYG5oxyPjVoasX/QtemoZn2iXvQzPyIeRHYmjoDGw2sXlTxHJ8p
 ZdW/0CCvZsnRIsy5NWoFxwvOXY5m86PmzUx3BDCyIU0QNRMBj0wCgeH6ISicOp4efrLzpUY1Ff
 Qr7aVwR/yRireKyQh7VKEhqPThCIS5Gegx/gxB1JBo4t/+zkqmfuwlMSHxcMAWKI+38Y5eJwZm
 /pU/Htfe7y0al611HINf+D/WZVCzDoWCK3UPDzhCIUnBxrABeBFx6jVFOAWChfV1AzRTpAXM0Y
 xCQ=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="247726955"
Received: from mail-sn1nam07lp2046.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 01:35:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPSafj4Wu1RQ5pq0Aer+eo/gKhX6i6OeR7fNVlQYeMa0xNfo9r2wG1NcByHN2irY7WV6+EX8c6nJf0aRoHoqOkj5S4d/UXF+odRf6f3vh8iJYxK8KQVkJLgunpGTZJ1YWpGCVeol81aM+XOPi3Nte6WYBbwd9E7V878+uLJ65p1r8x8wO7K6vyc7KoqANHVPlXFgsxErnjYSm6ghkalAx5KKmyPIsrXMTO2UyN/TwHtF5cxE2zhoHNDOvqzJqsmA1va8w596vLG0fR4S2/JI5IdhM4yd4KkxBnsGh3sbv6VB0DMXw6FnZyao9N5f73y/atFulHd6QYPWzUAulpRo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRG4UQsDDNXd8+q/eQ5bclaow3pBAdtvDfrtKrwllds=;
 b=Jd/llt8o26fn5fUFzyc82MxJBooRRkpYYU+rllcYKb9f9+4hobi7ywbYgjF7pGshYgjVLWg8J0RrKTC0j1AmVQ34lCg9KmTQN6Hva/Ec/KogMgqffUrg0jEmG+s7FbVjmAHPvuy6KVuGABh9KdqGJ4VIQKLaaRFSBiC66U9v2IXNX1d1sJzsppzUyTW7/G1q6XWNGeuvtYletLvP+3Iz3gPUwuXarrpknVR1BxDP3daf+bHZrcb/11jkAPdkkBW0QAJokO/jvYANI1tao+JZfTutbBUXCbf86JWPR3vxDpkuukuBw37mg90UCTmFz8n7ZzjtzrVEmNf6KR6Ftz4w+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRG4UQsDDNXd8+q/eQ5bclaow3pBAdtvDfrtKrwllds=;
 b=VuHHWH6U7V1ufoEm8bSvPUiEgmjmRLdflHWSVGfeG8Wtn4aEn2CEGCcMU/W8tnTOxV81i8qLOhvIFl74ROjRUL+iM4upToKubUm7HRfaX4rbWb/7zaf+8NziPRggUVu9H99soLtftswF/ESHuz+edVyt42tPTSPn3TktZo4dz4o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3959.namprd04.prod.outlook.com (2603:10b6:a02:b2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 17:35:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 17:35:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 3/7] nvme: make tests transport type agnostic
Thread-Topic: [PATCH v2 3/7] nvme: make tests transport type agnostic
Thread-Index: AQHWbCXzh+xG0oszjkqmPtQ6X3QuYg==
Date: Mon, 10 Aug 2020 17:35:05 +0000
Message-ID: <BYAPR04MB4965DDB160D053CA2F546B0286440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-4-sagi@grimberg.me>
 <BYAPR04MB4965624DFCE5A870BDE20A4686490@BYAPR04MB4965.namprd04.prod.outlook.com>
 <ecf895c8-c009-2327-cd37-e8838b7e5e38@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:9d4c:6bcf:e259:5003]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da9d0892-6625-4e26-b81e-08d83d53b7fd
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB39596C5FA3AF34CC3B480D8D86440@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vhMLj3ZVWz+TT/C3ybeEB2NuguNuSzcjMmt7JRmExJsqzlv4lLx/z7Xo5ciqZiKczsH5MdXHfyYd60mBtBiaTaZKkR7ScOP5eG9xau/MSAAaWmRIGgeMkXK1vNXrMqNx69yc9VCx+gqogb0XUnTQC5YEZQmYD0gMSDR6dWZhcA/fE8z6YCQXcBFPL5x5HLNwL6BpFi0xfX/0qGVayBE4d2hPSbxmXYsiL0N4WAJkFZABighbJdv4JTIUuw/WK0BXQHdj4R2mgZ36Jc4h2Vu+1xUp8ozvedRSzG59LGoIAcZdP0uU0qSGpztXnCslTIkSs547GHN6sji3QpExgCMhsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(186003)(71200400001)(316002)(66446008)(8936002)(2906002)(5660300002)(478600001)(66476007)(66946007)(64756008)(52536014)(66556008)(76116006)(54906003)(110136005)(83380400001)(55016002)(33656002)(86362001)(8676002)(53546011)(6506007)(9686003)(4326008)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2krqYI2zRynsiRLhcpKCNj4gAtYc98iGbgfCruKZtSm/LeIPWo80/LAuP86hjx/+0EaSoNCKy/KoC0Rz/mD/TI5+Sm5QRd9UUpfku9jzWEtFyvA/UhRrQ+NYIbAqtYYJnFje5EfzVzDLnbItzZyiAbLY4WGCfPqPDAvG+hWG+xq9Nv2Wm3GJkhaeiyBq+IvrFGFBIQdAOsN2xfeQqxb1lasHfjJ3OP1/hlTOL9IIiUW2HnaWD+PZLsgBk25XijQW2kKQDF7kHSYLzF5dKLw2LIvpAJ8PScg2mKOSB+mnZXTvGOqO+LBP6FZh9/ess2ZFsRBTS3KX7Um/C+dQndJmaVHRNGFDk4IikIc8Ng9tgs03ZX9Jx5q+8cUTHEToBywUDwvCmfU3oE3/X3PseV3DApvZ8EB+zOrU57T5x4A0gdUEr3TnpxrNO6WbFov6v6PH9pv21CEJiR+ejw6FO8ayql+RMsTRL67YM612ajET5ofQilJZ5s5hBN48XS9Nv54GfdZUZbREIE+3CfFQ2/mb5FXgAaffrUfO0Eg0UclTQT13uvbItvFJTAYmaelGIpGrtOBkV3XsGVK4q5rjc675CY92jx0JP1QTYjuTon7jXS8Niiqe6C6hS5fU1X3EQtz1I2bsYQDAkR55/7+SSmA9PRQSjEstSwpM8idSC2M+fc4WtRhyDExWZaN9xuJnfxfIeEtduejH1k8iiXwnO4XoMg==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9d0892-6625-4e26-b81e-08d83d53b7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 17:35:05.0433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvmSRGwieMO77HSg3wpMCF8zy1ss1Gebwl5IF+tiZ1J1ySudlAnIg5Rm5JSCI4cS0gHwm8xn1VIKhAWcgHt2lKga0gVQ8HJOZ54jR9bHUwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_133511_024877_C615AA14 
X-CRM114-Status: GOOD (  20.58  )
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

On 8/7/20 10:19 AM, Sagi Grimberg wrote:
> 
>>> diff --git a/tests/nvme/002 b/tests/nvme/002
>>> index 999e222705bf..8540623497c7 100755
>>> --- a/tests/nvme/002
>>> +++ b/tests/nvme/002
>>> @@ -21,7 +21,7 @@ test() {
>>>     
>>>     	local iterations=1000
>>>     	local port
>>> -	port="$(_create_nvmet_port "loop")"
>>> +	port="$(_create_nvmet_port ${nvme_trtype})"
>> Is there a way to directly use nvme_trtype especially in rc ?
>> if not disregard this comment.
> 
> I didn't want to do this, because a test can create multiple ports.
> But maybe it could have a default value?
> 
>>> @@ -33,10 +33,10 @@ test() {
>>>     		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>>>     	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>>>     
>>> -	_nvme_connect_subsys "loop" "blktests-subsystem-1"
>>> +	_nvme_connect_subsys ${nvme_trtype} "blktests-subsystem-1"
>>>     
>>>     	local nvmedev
>>> -	nvmedev="$(_find_nvme_loop_dev)"
>>> +	nvmedev="$(_find_nvme_dev)"
>>>     	cat "/sys/block/${nvmedev}n1/uuid"
>>>     	cat "/sys/block/${nvmedev}n1/wwid"
>>
>> Since we are touching nvmedev can we move above uuid and wwid to
>> a wrapper something like _nvme_show_uuid_wwid ${nvmedev}n1 ?
> 
> Doesn't help the patch set cause, so it can be added incrementally.
Okay.
> 
>>
>>>
>>> @@ -36,12 +36,12 @@ test() {
>>>     
>>>     	loop_dev="$(losetup -f --show "$TMPDIR/img")"
>>>     
>>> -	port="$(_create_nvmet_port "loop")"
>>> +	port="$(_create_nvmet_port ${nvme_trtype})"
>>>     
>>>     	for ((i = 0; i < iterations; i++)); do
>>>     		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
>>>     		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
>>> -		_nvme_connect_subsys "loop" "${subsys}$i"
>>> +		_nvme_connect_subsys ${nvme_trtype} "${subsys}$i"
>> Same here for nvme_trtype as first comment.
>>>     		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
>>>     		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
>>>     		_remove_nvmet_subsystem "${subsys}$i"
>>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>>> index 6d57cf591300..191f0497416a 100644
>>> --- a/tests/nvme/rc
>>> +++ b/tests/nvme/rc
>>> @@ -6,6 +6,9 @@
>>>     
>>>     . common/rc
>>>     
>>> +def_traddr="127.0.0.1"
>>> +def_adrfam="ipv4"
>>> +def_trsvcid="4420"
>>>     nvme_trtype=${nvme_trtype:-"loop"}
>>>     
>>>     _nvme_requires() {
>>> @@ -62,8 +65,8 @@ _cleanup_nvmet() {
>>>     	for dev in /sys/class/nvme/nvme*; do
>>>     		dev="$(basename "$dev")"
>>>     		transport="$(cat "/sys/class/nvme/${dev}/transport")"
>>> -		if [[ "$transport" == "loop" ]]; then
>>> -			echo "WARNING: Test did not clean up loop device: ${dev}"
>>> +		if [[ "$transport" == "${nvme_trtype}" ]]; then
>>> +			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
>>>     			_nvme_disconnect_ctrl "${dev}"
>>>     		fi
>>>     	done
>>> @@ -87,14 +90,20 @@ _cleanup_nvmet() {
>>>     	shopt -u nullglob
>>>     	trap SIGINT
>>>     
>>> -	modprobe -r nvme-loop 2>/dev/null
>>> +	modprobe -r nvme-${nvme_trtype} 2>/dev/null
>>> +	if [[ "${nvme_trtype}" != "loop" ]]; then
>>> +		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
>> This is not from your patch but I'd keep the error message it has
>> turned out to be useful for me when debugging refcount problem
>> especially unload and load scenario.
> 
> Again, I'd like to avoid doing things that are outside the scope
> of what this is trying to achieve because it is not a small change.
> 
> We can add it incrementally.
That make sense, we can do it incrementally.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
