Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD58C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:53:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79947221E2
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WBi+fyZp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hMdsyEV6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N/Ytqrlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79947221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=LxpCjL801yZP/bX6y6XUS4GcdnM8t9gjr4w92dsugFU=; b=WBi+fyZpl+rsZWiPY8KZjoWCt
	AXyNEvxDfyzTZi4qBgaXANnHi9tcOh+oTdga59P+qacffR5eGHrTjdkUQmLskM2pUSID7MEyplvbs
	EnSiN89FCbFqZwcFcAycG10PHgtnX7NBmhcNuaaX0+gmnxwNj/Yoej4+iU45oHEWgzKyLw/1C/q0B
	+TQ/r0jZtwh84fDdBMuCw3OEkVOcw38PzYPk3nXZksIe0ZZ3jXBFNJYwkQ4OVsDETlzOS9+Bqs7XD
	jIwmRub0olLthjUJVQCCiBXoxeknayFS9mYT8m5cSS/3Kc9SHnzcaWTbiEApRIiPuYa9qkZ/iCBYl
	tG/uI8gig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3sVK-0003CN-FR; Fri, 07 Aug 2020 02:53:10 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3sVI-0003Bs-Hq
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 02:53:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596768802; x=1628304802;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3hBG+CHOPeo76GP1OR3NsBxa80fM67TQ3Xns0GPO8KQ=;
 b=hMdsyEV6QlyRaxZMyg3AeoC+TN7SimDeAsHckeYCEh9s9mWRCsdKfAzX
 n55KPCu5LtaTOFy9uuZLSrj0C/oyOMxzVfGXJHLlnkUVx+t8L+l3y+AEt
 eZ0eMmuAc3AwqftT4kxw8jCga0Z3YcjOdRiz6UjMgvzQx0frsWZgLwiyy
 245DROFCANF6tWUcP9by3t0kTN/eF1Rs3dKfmqIymMPMZhxQeAVYwy3qb
 R1vaWmZVXse/eOq7NJKi5M084NO83jdwVc0C7d/yikaBdO8ltFHK0K5hB
 bPW5c4stqyebZyBJpP2lKIiqtvHvMqQOd8MmsjjWbIPWaNm6Fj3/1/HJi g==;
IronPort-SDR: jbSWEHM8F3GplMXIhkU7sgjtxfZ6otdhdqlhpreyYOyatOzBFug+NL4ORAwVq6jzMuA6iX82Y3
 JezmE5VvMA+dT75B+n0Rdmc1jiDIzLvt5IJ21sSTcEeqm30fVafDxhhgxgdhM0x5/TM1tkTB8J
 doDdczwIXm1G2d64mDNSKzEWc/SuxplhooYRHb6d0czgdI6EFdPVDoesmFpIy7RnSCThbJuYgg
 RAFw/LNFooAOPPKoFTo2r7G9zXM1FW3+AKkBk8A9JCVXvZphGmIYDlpfyAo5/KhX1/r9J4joEx
 F+8=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="247464091"
Received: from unknown (HELO NAM02-BN1-obe.outbound.protection.outlook.com)
 ([104.47.51.106])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 10:53:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBRC8MEbbIcIAA8MdIO9jxBa3g4UFO4qKecSEuYwQZG2FApirhQcVr0i9TqPOg4+JF0occWZkSnfuprYatO7nCexRSLEyz+uLrcNIo62vb4/b4pRbYp/7E2nw5/zemAiHtH4150KlboiqN2gRNRuKKQ0iTtU0AEJBvAJhrkQMjfOVpbZpD0YAYsiLIwLHcKII76W2LG96Zt1AFp5HMwEIt6VqXhMdGSWcdi4IzD10/KWEswUGmMvaOYvcqSbQMc2ZEgK8ltW4hf1eIKg0nOiyPDvTeURmaJpyvEyLCei0d8pBPQaVXBqlFqJgqhS9WTCEnNS51VTH5nCgbcx1X102A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zruAsqhVRZublUrtqpxSB0BtlZTykl36cv77GK0TI00=;
 b=LSAaPy1R23Hxcl5syFv677S7XWgrw2efV1wlfvgdZqTkAtfr/KMY9rl+2ZNg4pdrJvBjhya1X9RqPdqx4DitfzDp3EDROqryZ9cqzcb0EmYil/NUR9nuA59F+02HGaOjQ0cO1Myj7zqO1qX0GuoXUPYOHB7LKooFPuoNj3yvL3MOgiwkAhXyISUv1sAjCn7QsVDm/ZZ2eQHUmT2hVCbjGEZ3XoO/GGJj9OdLOM5x9anA3tLGRLDKIo2DFJNRJlaP408q+EvH1m1U7BHMFoGcvw2l/AaYvfuoHpD4DTR2yXmmKkk+tbLSfE5QQ1xLWk827PbQ4E/3WXObXMPVjBw5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zruAsqhVRZublUrtqpxSB0BtlZTykl36cv77GK0TI00=;
 b=N/YtqrlxP+sW5l+jlsHIpc1kc6dayorgZPVIV+gvLOB/3sGjQQiTEk/POobY2mHyZ7g7r+wufuIrwzCT0ZUh/HyUJ+03ETtXX0lEztDQaiscYTVPIy36Nc9ZIZlXDT2uWaNeVp9HrAp7yvRYOLK2JDQaqm3wD9nWPjyyarIt1gU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5687.namprd04.prod.outlook.com (2603:10b6:a03:111::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 02:53:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 02:53:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Topic: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Index: AQHWbCXyfk97HUGSg0KKD45yS5/FoA==
Date: Fri, 7 Aug 2020 02:53:02 +0000
Message-ID: <BYAPR04MB49654E81437918F224CDD26486490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69d6aa11-3d74-4ab4-5ce8-08d83a7d00c3
x-ms-traffictypediagnostic: BYAPR04MB5687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5687DA2F5D860799E209D8B286490@BYAPR04MB5687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HP+zK/GID98Xdjo2F00anGZR5GARyLetl8YuN2vjUIn5ZBBkaAn7lyAYp3ZTC2HteAwUt74W0z9d7XmlsObbHEKsyyyi+pGiUvhiEFlHvLFe+69ej8EDf9r59hsj2yKj8esSfRyf0e3YnxyQ6ivP85UMECeV5ctlYFwgdzxi/YLId1mqtld7o2MxQj7+DVBICgrvGhZbZu55Tp9j7CwGTdMX/ltYEcmfsWhJ+4aehVtNg2Cv07d0+2I3TlhOucOYNRlhjhNKC4/TcSE3WKI6zGN6srYuQt3Ii520BouqmYagEC8DBjDq8+Lb3envgKnC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(4326008)(54906003)(55016002)(2906002)(76116006)(9686003)(478600001)(110136005)(66446008)(64756008)(66476007)(66946007)(66556008)(316002)(86362001)(8936002)(83380400001)(71200400001)(5660300002)(7696005)(8676002)(186003)(26005)(53546011)(6506007)(52536014)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RM2RLPx3jNKsu6bOq09tB0b3tnJiINS5/8wTLcck+fJrHYM9E3k6LUhfGdraB5kztPIXGm2gEyZAhwlh2fJ8VrvBXX79QiiNi8rDAeghw4u04ILBticJTKYUOBmHtz1bJXxI0cQX1GRi7gMmH30Ga21QAVfPwaBNqA0qXgcyW7SqG7LyVFf8wkIZp/BYrotyMQKFl5jgicPKw9x5Lr1AwwGGQe97IFrsPiKykeIekbhfVWYeyAJZJZk1lPQFhNsU7FVVM0mqKvTwh2sLRc7MnJnRL/p2QoduyeOWpuOZ2/oykBYsmXAwSPZoadLyr/BbbifLOj8Y0HR5jCsajO3MEQdUokApfKFY7K+ZK8vkTZCzD3rF2jWy22QJYCkAvaLPZfnNYUPk6b1ULZKdSmlsSlJDgKQms1OfZ4alkHU6hm3xVERZCysk+sBOy+gHbo5aj3OSIu/94i+1FuL4CBbgU1lrfBq+cOKcke/E9EjAtiIZw5ozkfBXLPMTLbBPCReUTg5J1jVT67S/FRLmgdIxE5zkDPltsA2+wZzssey0A1OtewXSD5tacyGKivPMb3hUe/95yItVNtfjRMZSwAhDkYJHNMWmiy9blpaMv1ipX8k1uC+svLu3+jQ7jxWc7nOD1StsnMfPUDKv+YyZK2pbng==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d6aa11-3d74-4ab4-5ce8-08d83a7d00c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 02:53:02.8962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GQ7Gmw8Uxfx7ozwb2InUBNidD4QY+zhICQTO9nuWkkREpw4QJj52FoZWfISGl4WEkoO4lzg4h56F9PIdNJKtzZQ8sq1SXTk8D6MMieFTAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5687
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_225308_736301_D34EA01F 
X-CRM114-Status: GOOD (  12.89  )
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
> @@ -97,6 +97,33 @@ _setup_nvmet() {
>   	modprobe nvme-loop
>   }
>   
> +_nvme_disconnect_ctrl() {
> +	local ctrl="$1"
> +
> +	nvme disconnect -d ${ctrl}
> +}
> +
> +_nvme_disconnect_subsys() {
> +	local subsysnqn="$1"
> +
> +	nvme disconnect -n ${subsysnqn}
> +}
> +
> +_nvme_connect_subsys() {
> +	local trtype="$1"
> +	local subsysnqn="$2"
> +
> +	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
> +	eval $cmd
> +}
> +
> +_nvme_discover() {
> +	local trtype="$1"
> +
> +	cmd="nvme discover -t ${trtype}"
> +	eval $cmd
> +}
> +
>   _create_nvmet_port() {
>   	local trtype="$1"
>   
> @@ -206,6 +233,6 @@ _filter_discovery() {
>   }
>   
>   _discovery_genctr() {
> -	nvme discover -t loop |
> +	_nvme_discover "loop" |
>   		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>   }
> -- 2.25.1

I'm okay with having a wrapper for disconnect but for connect and 
discover command it can have many arguments having a call in the
test-case might loose the readability.

The downside is it will need argument count handling in the future
and makes things not easier when user want to skip certain
parameters, closest example would be _create_nvmet_ns().

Also if we are adding wrappers why not move $FULL 2>&1 to avoid
duplication ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
