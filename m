Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E378C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 23:13:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12D722A99
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 23:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12D722A99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=YY4APnVLcUWw2V0pUr824azyxHQSYAgqG1OlEV3AvEk=; b=QlT8M02qjffQXxeWWg/+NW/Wc
	SqR8seG9lJW0v37Jr/DTmyFplxzOAD+9Ofwtlnvo0CYTGL1PmYnWrB54gzVX5qBvPU0NG83n0MwGA
	dq7hs7sDdW1QLMf+nWOmiVCsbrGIDl+ZRyY6ZYKFyZJnAUAou3gGTlMlfHTj8qnMnjH1OsauUtfTd
	p6ihT0Lr3tuMS40pHOGIg9syDK9dgAxzXn2Af1gYYzcKgYXMPUQSNUAW+4SHa2EnKmh+xc+1mPuuy
	4E6Nu9gGvP5XFe90elsvsilBlkeKocXuTGZYB/hj90XIA45uM61H3oW8ZHWqbEK2dju2CXRd6i4rP
	3nB4wI8bg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpJVv-0006r9-Ne; Tue, 15 Dec 2020 23:13:51 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpJVt-0006qW-OX
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 23:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1608074029; x=1639610029;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=dAHa0PVJ8rCb09zc+KhKmze5wDDEsUZJKUP8vmglLzY=;
 b=GfSbowcTy3cuFUUeudWy2yUavVeTzelVRG/d9/U1BV+UT53+6i3atHvz
 AA7+qnmcZQGb8T/Y0I6eE3cQcX2gKjOx5HxKvRDt/Bbe55gbMnlkNz5MP
 D1DaPaT0mrMbC9xjdI/QH1oJh4ByjhjDpVX5UY1yda2T+lzD/8HF5u2nq
 /QSjMcBelnHVHGcVjx+sStzRfr0t05nYGYHtH0otWhFVmnP1r4GabuJ96
 +4/xyb9xOt464e9SoYY+HsZtm1Grd52OD8XSspB7L8nji++ZLPWInK7/x
 /UyLgj9+MpbOwYGg16uk4cYF4PJYZuRTlpfPHWqrluAINhwmAk+1oGVTd A==;
IronPort-SDR: llL/A6frKolvkNTFTiRhI9jQV69h0z+3FWLNK2Snq1nslWXrEgryDTPcZSMNic4l8N+jn+WBUs
 1BFTytRYNeg6WrfVxxXS9APQ/wxv2Tn1Z3k3bDu5sFT9Dz9eNi0tXxUUPn8DOzypgmeFg36Lkx
 wzgOa8lg+iJVK8jbL+zTJI1wabEM255gl7JH0VPUYn1Dqfnc25ZWnX7YaLkeNJPxQw+/FqWJ7O
 XKQFqml92FitRWS+Kk3tUfReVTCctVgc+EmFIhB/7Xy3XGIQZ1s6OmKOE0bVHtcUUbCGF++/zm
 8UE=
X-IronPort-AV: E=Sophos;i="5.78,422,1599494400"; d="scan'208";a="159684814"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
 by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2020 07:13:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSjDnuhVosfZrDR6044wV3p+vl/DiS4hg6rjkUqep7d9u1Hy84S5/Mv9szNjoIMx7UCzxbxsngsp9CpVppM1TspDGDgp7fkhmmMt1jUahSqzBbbvpsf+p+MQRDcxvAhTag+2PZa5SGlNRDdkGn1GG7U5blljK2sKF+Kx7qiW7r9MCMxMDRuc1m+Mo0cRVsBSJtoVhXduhfcMkid+e7GndEnGH2Glz27e6YsmSrIYHYEDp4ewTKH3cWnXjhGV7t95Ud2V3YSP8gRJbr7RsaLowiRHGEHu7axsBprYozcAFEtTfLTa06qcDpLiZNGZW9GuBrPuskVfJUXIhgphCwPOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB0dtXo8cM3gfI9vOTXt+8/vQjzI98SplHHoqu1HGLc=;
 b=L9XDj7RJDWtTt9DNyjQV2qmEODKsU8m+oKV5CLFUVsGRrSZK6X9jWygbT+qKU9SxudZ1Hwz5VDNFCqf5DF95sVJGjMynr8OUxgZYA8suZz3k4Jom9pKx+1b4/7sQ5wjP6rDbft5PsTQkxMGn8fQwc9/1cgcfcfzTeI4tK52Qjz/ijuPMOP96mawJ9knvK0k6pI+uPDijuNoECFQ3CVKLpEL8SO9oKc6NvSs901LzxNxlZA4Lx6Uonlab5DEaeicXa5ObDwW8IAYo1GlQ0lHawqUt5DktnrqgS3HyB11byw2nqXPMGF/G33yAxXFbYaymj/v4V1Z9Pa/fIVVl8kvkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB0dtXo8cM3gfI9vOTXt+8/vQjzI98SplHHoqu1HGLc=;
 b=FlcUFZfUz+Rss4Wzv8RrDMHEKZKeUfDfzgPhU6cvfDKqZzSRFfUnnzjglVt4xh+fHso9e1EbXatIvVSOTvN+bBtxTkj1GdUBnjOZVRXxpu4CBf9So2gMFHNEWzKeqvOMxFK5vjuFYZd1LgqdTB0qDdMXdvfmqRhLZta4KwDLitw=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7064.namprd04.prod.outlook.com (2603:10b6:610:9e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Tue, 15 Dec
 2020 23:13:41 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%6]) with mapi id 15.20.3654.026; Tue, 15 Dec 2020
 23:13:41 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0qgRFs/FzWenxk2tjrXm7qX1YQ==
Date: Tue, 15 Dec 2020 23:13:41 +0000
Message-ID: <CH2PR04MB6522763AB222AD6F6CBD3321E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
 <20201215060305.28141-5-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522AC040C900B2574125884E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49659C0D80D3D3EA2F2D24E886C60@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f0b5:b4fe:45e3:5658]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 620dd5c1-2986-4f99-eddd-08d8a14f0ffd
x-ms-traffictypediagnostic: CH2PR04MB7064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB7064C2CDA1DC25158E7B3F44E7C60@CH2PR04MB7064.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4GNkm/rtYsXSpSEolivgNyI5WrdyyHMwMFqXg82zhKlUke1yFQD69dW0YuJr3ICaZB55OZnNyDAPu+/xVNMwRT0SqPNps2OxmJQpamzIsy8C7foUQod6X4hU2lnorMeYCimNkVN3fzcoLmRsMrXUXlA6HHDwGi960Usc3MMX5E6mS3YxfzKwUvu38uXa8JF3NT+l6yQbWQ7zrr6JFgUCQuSF4Boqy1Mvi+/zKkansxp+6LovkxyM4d1ObkTAYtEMMZBnI/SeRc/p27nhTmsZ2jR7Kwh8t+4M8pVTHyjElJHYCl8q327F26NESxfAx6zTlW0WSnQnK98eqDewyTbHQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(186003)(9686003)(4326008)(91956017)(6506007)(5660300002)(53546011)(8936002)(7696005)(8676002)(66476007)(71200400001)(498600001)(66446008)(54906003)(64756008)(66946007)(66556008)(86362001)(55016002)(76116006)(52536014)(2906002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?luPIOox8stFQMFfwOaHjFHzpROKmzelwLDzHzrjFxuvHrYT8NMvjEG0qyPR3?=
 =?us-ascii?Q?uK/KcPl94kFF7MfXzsuvbXAovRi4GhXS73VraEHFDVGEq0SiAxGCEUDqvo7t?=
 =?us-ascii?Q?+dknZsjvaehciZpT9YzdSOXygoqjkDYTDOPogKK8Rs8gJ6ogqTzyWN7EqKiw?=
 =?us-ascii?Q?c+Ay5PwbPtZcohAVY03YBzJrozKLGltOzM9a7XZwlUKERCubC5h3F3WnNKxd?=
 =?us-ascii?Q?ptYMHd9P6x0+9W7ejjbd22dmDNs35/W/X8l9ZS0CMXE841IiHEvhxsD0G4sX?=
 =?us-ascii?Q?JGw5M+wxoxwF1Xkoj+0SHuWMdjd1YidOJVX9wOY0zkZ4WnrYYeWj98ZdQ59L?=
 =?us-ascii?Q?Qivdqf5aiNGYeeZyD8ScHmzeE2E2l+Mp2I4rhvyiSTnhRAzDKJzuH8vPeg8O?=
 =?us-ascii?Q?yzVfDYTRBW4zJGLHHQ1vaAAKxKJw2V3h7DvOjRTeWmLrGmZYMSFs67QoOnn/?=
 =?us-ascii?Q?h71OV7aC+oewMmQ3s3u2n+R7QcAMBWP1nJbTWQBxQKLlx9kb0fqQZoxofug7?=
 =?us-ascii?Q?Tu9EpKkREFl4rq3csSwtcWAVWR33gQJtEWw6XlLZ1wcUVNP781xfhYLgTOV4?=
 =?us-ascii?Q?HYkpyiaUsvNS+sxnaLOxEAzRfJKUsWGRfkh1SNp/N5BdzNFhLrZvnA20cfaR?=
 =?us-ascii?Q?SxlE4oevMoSP48HnVYJt0Bn9WVrMrKNoFK8FLXJRxazHFuZjne0P/aFmsqmk?=
 =?us-ascii?Q?PqhRe0vCq89DfaMsXrBsRsx9Csm8QkMPXux6JPlExRcNtuGkpYSHmkYkz3zx?=
 =?us-ascii?Q?riUvg6f1L+2jAK4ti+9nKJD3Akk8UljLig64QRPA3ZhhrpEgyM0lNxXgg6cg?=
 =?us-ascii?Q?g9E6CikxSjkVOCVH3k8wKO4+6JeB6vgHp2FTRotQrtzriLMxo2tXiORwx3Ps?=
 =?us-ascii?Q?3i9feA+gxb6HVVx+oN2bzCkNm3e5ngdWx5gf1vraWOU4IdwAy5m1RU7omG8t?=
 =?us-ascii?Q?O6sW4ZJryWfw1whmoTQFIpF6F999FfDwtWmuFPut95SXMgjC0dVgGjJ21wL/?=
 =?us-ascii?Q?b49iCtDq2HgbiUdnIcI8LJulQrrepFKN7o7R0d1e3BDKaUwnqI7EiDy5QQFH?=
 =?us-ascii?Q?fldOeOOs?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620dd5c1-2986-4f99-eddd-08d8a14f0ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 23:13:41.4757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAYBOqEHpfFLsmMI7b3N+R/h7pFajzmbjshvyGxY7jXcgdwVFHVGRYJQ1EN154HT3n5eFy68QS8IBk+vp9niKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_181349_957247_48F718C8 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/12/16 8:06, Chaitanya Kulkarni wrote:
[...]
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>> +{
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>> +	unsigned int nr_zones;
>>> +	int reported_zones;
>>> +	u16 status;
>>> +
>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>> +			sizeof(struct nvme_zone_descriptor);
>> You could move this right before the vmalloc call since it is first used there.
> There are only three lines between the this and the vmalloc, does that
> really
> going to make any difference ?

It makes the code far easier to read and understand at a quick glance without
having to go up and down reading to be reminded what nr_zones was. That also
would avoid changes to sneak in between these related statements, making things
even harder to read.

I personally like to think of code as a natural language text: if statements
related to each other are not grouped in a single paragraph, the text is really
hard to understand...


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
