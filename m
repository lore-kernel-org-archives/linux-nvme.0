Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52900C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 01:43:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C718F206A4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 01:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C718F206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=NUuwEFDpydwbvupWbQX76xVPuglc50EywrGqKxeqasw=; b=2Ruuzm1umFO2BDRjWQMEpUnac
	4tpo/gw+LWXuqdwLYhkCaw3wJgZY1VQt6uIk1EmjsJlhQRhdCXJl3y75nRLQI6fe2dccwSaPN/Z03
	LQcqX62N6bxi9vJqYe6DfqH9nN8b/OoPKND4ZQGAWNES36qyAsou8S51YaNwEG40AU1X6NVHlz0ov
	wFcrQBmu8E1v1rE/p6hJEdtn+eJhAKqMH5YJrihugc9Fu2g8ncHm3OOg16ZHFqXxi46ZWEMEGgZHD
	EKl4Ex5iA9BDiF3rXfUwACZh7OU2zc7+u5ONhABOctyWYwWpyQQPEBNKMirleyuWnOWm0AUD63FS8
	AOmK8O1cw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4DNw-0001WG-Fy; Tue, 26 Jan 2021 01:43:12 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4DNu-0001Vo-3S
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 01:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611625389; x=1643161389;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=msNwezckssGtPL2zRHBcbN2/N0W9YHMnM/Ppe8Wg370=;
 b=EGEToIpz+SSLVTkXdt+Nt6OURxbrUNDMMP1Vf+Y8v4DHaNZmhbzhr6sz
 Xx9PSWMraO8sKwSleyNSrBMtomEN112uLF577iOvAIWYVjd3mXDKn5oKk
 /lgLfkX80E3/EUCohIAfgGQY7EuVWrtutGsaTOGz9mtZe7iedSlPpjEQ4
 Pt2/X06MAwvYMaCFdNIhdHrGl6EEbYJREHZ5kEFmB8yylKMZgF+kJ8F3s
 ahjDhUafG1kBViRfWJq70xk62P/kiH0n4nawVQF4FnzWt23AA5XmOiRj1
 Fk/2foZD50bVIV99PSki2ynlBjRRWhbUM4mqn7D+5gF0tc55cXxs01JQ+ Q==;
IronPort-SDR: 8CBDsmtClIqmx2KbKjNX19xmAomCsMz6llbiRN91a6H+sDkRtZhZObhckNcfOEjzT03JmFsMnQ
 gbpQVY57rcuYwgnJYZvMc2mHQ2xxe7toBL+NTFOnqKmAo2irFtxemQ8m6A9JgnBPJ2IsE/0qT+
 IoOOx1oPFyV6NP0DvX1YjkAFHyKXeec+flJauRvNo3SYY3zqeLmOFM21qstzV0bn6u2x+IrG4P
 pJrMDzCq6zlAe/xH4uVnSY/1mAzf1B4x2CyqMsD5bmZ9Gc+OtxXCEP7aB2t4i1Jxmgnin7+nIk
 QHY=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; d="scan'208";a="268666223"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 09:43:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0mHOylj+QNLNmoHD9rRghLvCvoGJZcJFxdQqKCY1YucMbLAn5Td1DLkzzN0V6bG6ec2/HfRz03W/PpVYwl/kj0ZoqgX+ZDOcyjiaaeSP9KvHbSIE4/gNdLqdrq6h908v0YiQ725tOtBOcIz5Chh27hCACYR+Q4uCtsnA8in3qTOyY2Jp2am/YxJjEXhQgW/WtkD4+0GklT9jlKJ0Knz8024DxQ1SymhMXt7Y6umqzTf5mHBXU/hyYZHpo1qe11lDTZTlMt+8Sxv7vu1sIWCKsLJpBM6jT8n6Y8vIteUUwZU48jAX6m/Wom8Yklbpl/ucVmei8SzDlYSSotlGj3IMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msNwezckssGtPL2zRHBcbN2/N0W9YHMnM/Ppe8Wg370=;
 b=VICkhLQp0BY2n6gYn6cWEbuj/3lk+YpfH6oc0rO+iOuYmKTusLrHZue+lDrVhI8CrTDdQJ/rK6ZNRfqcWT7wJ06KN4r2/c3FkLhp/MYrOm2u5DzISXow8VcP4ADLSf3XGw/cqxVqoehFYtUvXO6zpo1zdXsiyhV+EVkMgaOiMglibc8SJYGGvDdrxc4npT7CmCQSVGKzBh0QY5YRuzug62p50mJ3x9XzMQ+ldqB5ZnX/xCHHNLDZkS/mVXjT/pNyYdq9UDTsJoLgukh+63h2dUOVFOo+nxKbJc+cyYMJvdwba/kDT/VJT0G5/TiJACgowGudQxXdD2YquXQI8Qz86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msNwezckssGtPL2zRHBcbN2/N0W9YHMnM/Ppe8Wg370=;
 b=zNcZUGcesIXID9Zgik5KsTycvDGhLTR/Yht8NXtaWxDLuYNWCN92OEv8H66ctmtONi0ypq5X5KSZkWx+1FYZMgogjSWfMg88QnVeOb6nLrb6e/FtGeQ2HJBNxctlNP8Gwfpfz8ZqlNRM2R2+KIPyhcbLrzCQgpzcU/tIEVf79yI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3959.namprd04.prod.outlook.com (2603:10b6:a02:b2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 01:43:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 01:43:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "clay.mayers@kioxia.com" <clay.mayers@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Index: AQHW81Uk6e6cbZGyEU2+tznAk87Vfw==
Date: Tue, 26 Jan 2021 01:43:03 +0000
Message-ID: <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210125195844.1390581-1-clay.mayers@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kioxia.com; dkim=none (message not signed)
 header.d=none;kioxia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2077dcbc-e3ff-4d13-758d-08d8c19bb87c
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-microsoft-antispam-prvs: <BYAPR04MB3959DF756B6F66A878D3210D86BC9@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PmV9VOqp1wj5+X/kqFAcLOYQr/mem5lPhCZNoknAgz+WlcXy187WVOSVuqHe4FCiMzUqASRJs9LtwduGREFS7frBdaG59vLYLKWH5otTihqHIJ+rrqVAWr2nL1079ibjwZ3EXvrMTkZUc1Ar2WKFQKmdKpVmlCVJurXQGJbsYItdnr60HP9R0h1g2dcQJbZJE2QAcFMQrWwcmDgyMaDSpGL+hxFaDgjMymX9TK4AfLFfRDdOE4EDorf94Y6V2PwBwqFD99Wat1HxtAYsHGhOdQvsC+ulxEyS0BTkEmUFWMr3fjSXOkqnuJSJ+DoMF1UsXHgzdIsv1OTV6/R0a3ZUZEhPVHgb5r2trj2n4vQV8Dw4Cvc90L8WXiZlkO1ZwU1ocBAU29XEHxjF2tlkfWF7lp7HWpSMbtWVK/E5uCUTLk3/RN/H9CMFyf634pvMB3fPLM2bGVBuuFY4PacEw4lkklO8dgIM0m6YYNytUD32tMOmRbCk6hcQAkjdgAA1uo4XDP+HuFtmNkUfjH1+1CxVZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(4326008)(26005)(66446008)(64756008)(76116006)(52536014)(66476007)(55016002)(66946007)(66556008)(2906002)(186003)(9686003)(33656002)(478600001)(5660300002)(86362001)(53546011)(558084003)(8936002)(6506007)(7696005)(71200400001)(316002)(8676002)(110136005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zOGmZpcBgmT08jf90aBbBT+KrtacQO9V9vneTxIpsfIM6FI4g8VDVYfXfE20?=
 =?us-ascii?Q?jLGdl3kpdO2Nvle0GsKSApcc56CjYG0A54e6i2g1wW0xds4+vwCiX5avEdRv?=
 =?us-ascii?Q?CZhJMihy4wuHfYdBEsqQZ7EeKTh1vG410+FFbHCe7za7DsReUXaIUgAZLk/s?=
 =?us-ascii?Q?MgnngFspkal00UHVDOL0EX3m0t12ieI47NSKYs4YjMsWUax9961Nx0QlRP41?=
 =?us-ascii?Q?4IziMMnnO/zkezyAwjB2GJQJo1I1Nb7q5wdddq3FW1yTgbkuOjZ/lTttdfxx?=
 =?us-ascii?Q?H9P9HkYig4dfC7yKZ8+bByqdTyQl0mBGfkylumBLSbaLCiMRYZzRQ1N7UNWE?=
 =?us-ascii?Q?l7ik+DN1m1y6J/5QUby2E1ExvUG2oyG5egUaITyoBGvzcSrODQlbi3U3E9Aq?=
 =?us-ascii?Q?KoDNJ4VF0Cn+M0OpzHaRrwJu2c1VL5EuzoDPwLcsyF5TOe/30Tt9N+XOrQY4?=
 =?us-ascii?Q?DNUIwfj+i/mKcRmBPertetndAVmVUjhQa+DN2Alz1lgBU6MWwquEyVtZR4Xg?=
 =?us-ascii?Q?xaKGWhDVqxL6hmnT9m7H/COB/wSqfp19DBUof70wqRtjRCsdwO8zi7YNCUoY?=
 =?us-ascii?Q?EEYOyy/vPQZrgbUetlLO2mkBa5Ru62ifdftKCYimgAI9pGeMrxKVE1EhDfAC?=
 =?us-ascii?Q?rDUY41nBt/F0t1+v2TRU8IlS8kBJCqc90x5fu2jVi6/T9H/Mk15EODRL9MyQ?=
 =?us-ascii?Q?Y8WjdWMkNmnT7q+NVJv+6eNooC7QXQ5bOJHCkQcQkoMQn56DF0AmwHM8u76u?=
 =?us-ascii?Q?Mnxxng4FuLvFkx8uSPd0R5vh9EWR3rnhCE3KYFVyyQu2scXqQk1hYPqdd8oq?=
 =?us-ascii?Q?g500SB5smO3+miKYtiRBt2kBkEnm6OTRVrtY8FSAboFs/VeQg24cS0iT7au/?=
 =?us-ascii?Q?u185ccPMfiHgfxUkzpyQBy1TUgNb3zSCuTZh/0HlKAWVmGa6E+x7SQoJF9MI?=
 =?us-ascii?Q?99NdnyZ4cX1PbBrlypWA1cP5kBbuAq8uX/Umxz7ZcRA/BIiXTFd1q4L8b1d8?=
 =?us-ascii?Q?Yt9k3RK1rnP5Ms2YK+oVnDBuwF45/L4FsP3bQhyooqUkTkb4ynuK9DTtvMYe?=
 =?us-ascii?Q?jO+m05I0s6SktGZQoQCtYURsdSOpdQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2077dcbc-e3ff-4d13-758d-08d8c19bb87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 01:43:03.1251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GP0UZfbf7KxE+ZubnUgBI7ZlYvdxuF76r4pbgLdigpMzqzSbuzV0fk/Z37RUFpT5sShWDQ3uX6eNIKwqyjFeM1gjnPuQxv0RLelrU0Xjp50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_204310_449118_F1E8CCF2 
X-CRM114-Status: GOOD (  10.40  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/25/21 12:03, clay.mayers@kioxia.com wrote:
> Local pci device fused support is also necessary for
> NVMeOF targets to support fused operation.
Please explain the use case and the application of the NVMeOF
fuse command feature.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
