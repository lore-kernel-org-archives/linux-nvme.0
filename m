Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 23:28:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FD3206F6
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 23:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A/GX+Qrt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gIG9WMbB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Np9yT07l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FD3206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=CGKFuEoA9emjBK8X8ri1D4D7G4IPU9s+Y6Naakq3XtE=; b=A/GX+Qrtfe2Rp8bDSF8FjJN/Q
	dRfZDt8SQAURwVQiIF4CPinzv3ZjPKowOD+UtsPeuSQdRx76NFTI/3spmdGipXi5A0yXbdrzyOOQ/
	jG0L9+RmHthPKhl6skwtTf7S493Jpgd61GK9f1Ltt02/UMukboPkjJulqNBICQswA0PGN27s/mQan
	I0Ss8LttdO2q83UQRI9gG+CHrSHi8Gg579c8vENUZnVILEch5l66NEhKYbAa8iSaGooEIXHCxfjIn
	Moh2pIQVU21FBAT3aoxjoPEzD8ugPn5hdRB/2DArD/3OOLdK9vBgkD1ZekH2pBLt3BOjOUXUJvHOp
	orsDE6eoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtJUd-0006O0-OC; Wed, 08 Jul 2020 23:28:47 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtJUa-0006ND-U6
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 23:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594250924; x=1625786924;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SfCVzJqwPT2xd2FeMJ8PQEqQxZ2S5yqaUGcCp2Rf8Tk=;
 b=gIG9WMbB4hbl9bVKDE3YZ6RIfRtGPXOR/i9zc6nUQxOx6jAA30wynZy1
 QVMBi8II/hPbJm2SUzvVEFIn6uzke9RfgQ/s+fddjX3Wc3guDbcy/qIvT
 W0+rJfFl+9k/AsscGoDPd/gSoNsHZnklqr5SXxJc6rMNyA3H6hRbNwjxW
 yDJ/9uicva+G83IkZNM/bVp7aNnY5El1bUzIakFQFKoKrQQYIOZbg2M3W
 4EFB+qAvUWF5yPPm3YAnghZL8r/dWPsV84V6bexoIHtRUAtkGzMUssuRF
 RVLj28WBA3L4zChbEX9IsDvYt96NI0Vrw/7sQ2kVgpzM6CP2heBYl1hrK A==;
IronPort-SDR: mV8oFlqpM1cFwZThcIGAGUlBkvg671CUxaVLpd7bKsVIrA3YMEDL1l+0aKwyjUb7nrzG1IOFP8
 BkdX4DKW130l6HyEyNkMDlsMV/NQ6WW0CqBVDmLbMeAB/R4YL3M+VafouUhuu9lcURQSxaoUoG
 UdYHZHmTYybXrIk2sNjdphfYcA4e24wW3K85/o5jLmB84Z1TjtT/xtGkiSLVJ7X3CGNdSb/pJE
 UeZV6DYZQR4EJQG7O5d2vKvFJGaSm86mlyN3ib8OP/kcIJFybVgh97An8D+HfayR9hjrCvhTc/
 B2Q=
X-IronPort-AV: E=Sophos;i="5.75,329,1589212800"; d="scan'208";a="251209375"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 07:28:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvJdqTWJ2RhS8Txum0XeMnr0r0qXOwGEMIlemc/7ePeW9B9aeNmKifgrzU17XWei1t8Zz9+I1c3nl3PA7E+v6oYttLT5e2PkXEz4vFO6nu0bqGxDMg6egnkxD8dAwO/4fjma1unq/ME32xZk8GzbXA6DxzLljseMTF/IcT9273Pv6IDhwAh/n20YkmjZsi6RqeEUEIJB6mAZKEKKzYmByq/dsjWM/Wm5FW9JedYj1d+g8Xua4cHgy95z4tYoYPl//hvLvTAFHpFWGTj9DzfEO6Ukp02qcLmR5k0HPpo/ZDv5UFkHkGCoDKmKeHukcpbFvTpAlHGiVBQs6uhFQ5hDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Uy+GcQx3crZQ6jyP9Gk+OXGn5gPv+V4sLmnow6HZmg=;
 b=aXO25fdID8pTOvKkxyiSre0Q7+tawcv15SoWpDZKeCnjxwOLs7cqzS+W0ttG6MEO4mMiXLlCEp9znZDrUv2hpuLE+8P4GDnRekBbUfqNnGYmTODzeE3isMUfy1Jw8SJRj1EYjgr8KlzO8Ma1GpVl5CGNIka1h+gQLLimJIlaU59fp4VX8K7DtvCebS9q4K1ess/S6FhtnIm1OGuU1xYKs1mvixtMnHwATHKxVHkPyM0DT9Qe/JrDbZZ0za+2syOekGa6hPTMWHV1id1Fd+XLokBE6M+fK5SWe5sLrI9QEMdSZ8XrWo8AkQOfHHLkfLhB66NBIXHwTmQfq9gTphdT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Uy+GcQx3crZQ6jyP9Gk+OXGn5gPv+V4sLmnow6HZmg=;
 b=Np9yT07lR2/kw/SUi2aH9+uWV0TNBH2NsU6QWUvDaAW9V4RntOo8Vh7y+Ss1diLaVLTu7TVTOypPw9psBpatrZBL3gJL3yX43C5tBqloRg9mv1mAGKHU0WnahZ+q+Pb7DFvdqccF5aM4WZnGiBV3UFSATlfMlfzcei0+y84/oYY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6898.namprd04.prod.outlook.com (2603:10b6:a03:22a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 23:28:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.022; Wed, 8 Jul 2020
 23:28:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/4] nvme-pci: use max of PRP or SGL for iod size
Thread-Topic: [PATCH 3/4] nvme-pci: use max of PRP or SGL for iod size
Thread-Index: AQHWVMLxjjTSDZ5shE2HuSa4ge//2Q==
Date: Wed, 8 Jul 2020 23:28:40 +0000
Message-ID: <BYAPR04MB496538E23029D7B7B99DA46D86670@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
 <20200708005831.10013-4-chaitanya.kulkarni@wdc.com>
 <20200708222649.GB2288916@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26e28869-6a4e-45b7-5a72-08d82396a62a
x-ms-traffictypediagnostic: BY5PR04MB6898:
x-microsoft-antispam-prvs: <BY5PR04MB68987CDD49A45DEA279EDB5586670@BY5PR04MB6898.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nV6guBsnglBYafFZd8QesmtbbCzxZH5mx5y4z+VxWhRlEgeKPfT0Wh6UcTXopNifIVcofgE6BKzV/RlWm3uVIYcodhIqQHxSjDwdV0+vvTwYlWtUdopzSHaoZh1wT6N/gr5G5ZViua8r8Soo7/aWq72+FVlSyPUe3H8UwLjaxwKXFzZcFwxj8LBhcQJsqp2fvDDJ7eBIjEgdrXAMXnnp1UdTOO/lOyR2GYfSXowXyWSIQ26L7q4ZdYaWFqftbNmtu054YLohxWfCCZM3651m0o6pbXTKWyeiJzNU8Xko7KEXRZ8vvrOFEuzT3AfwhmWQg0cmwWlFmOKHuEAKURhK8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(478600001)(8676002)(66556008)(5660300002)(558084003)(186003)(26005)(9686003)(52536014)(2906002)(4326008)(33656002)(53546011)(6506007)(55016002)(71200400001)(86362001)(54906003)(7696005)(66446008)(64756008)(6916009)(66476007)(76116006)(66946007)(8936002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: UQQ4n9qwlKb79XcS5NB6yZxdn15fGaZbeh32GysJ4X6ZkcHLewiiHP5MA9kzhNHCpwUnVlkc7CrqcCxq0rPqO1EUJCaZqteFh3+evlQf8ImpmDcPMI6a+rTjw+qHDgsN1YiSanBfYQjCz5u6/iZfow5rOhQPepLE3WXBARZ3Z4c569GJld1NvK4KATYWBGAABctEniNvI4ExGZyBjGdVie20MLwo+/C36pmW3tQtE7KJ7TkaKMBXbQb8Zbu1q1a22DR2KgBfwG0VLWwfVTwdZgEG6mBWLQh0+RQ9+dK4hp6VuCUQ12y5dW5t4hIv6P9xrvvAPwOwSRzYjXEy8fSemnexO687eWbYmKydYaiW8HrkIy5Lz12f3KdQGdc2Xt3/ppGVisQvoy+9W+/uUiCyKJYUHvck8EDnzIDQWaELGq507Rxl+LIWD8XvrmqRgpNHECFGtyueRYJwXWrWPYiIduc7/tE80isoPxFpgHMGoEE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e28869-6a4e-45b7-5a72-08d82396a62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 23:28:41.0306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cpnl6Y2d3D5l1WW/Hzhz6vylv4wCv24cttestcuwBTAinUHJYUdpFfW5QARYLTG6PYDWNf2NoHpZyOj59K6EUvSot2G3plNsPwY7QEVJxvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6898
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_192845_669581_E7CDA33C 
X-CRM114-Status: UNSURE (   8.59  )
X-CRM114-Notice: Please train this message.
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/8/20 15:27, Keith Busch wrote:
>> -	else
>> -		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
>> +	alloc_size *= (npages_sgl > npages ? npages_sgl : npages);
> This would look better as:
> 
> 	alloc_size *= max(npages, npages_sgl);
> 

Okay, I'll fix it.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
