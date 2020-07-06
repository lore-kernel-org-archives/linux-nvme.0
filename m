Return-Path: <SRS0=qz9S=AR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92107C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2020 02:23:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6272F2070C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2020 02:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3Ru8vil+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i+ZNdy43";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yLzA8fOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6272F2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=fwdYMr2cQN8qJsAGgCGKRcnfrw/zvb/y0/MIyXM+c6M=; b=3Ru8vil+4HBT4sZV2edilq8tK
	iWNQ2iRrMEE7+XuaR/j8+P3oaWEZwHHi/ncC79S2BlhobqhD7Wu6FsSjBY7STdZhExra7BIRcRYWE
	m13a4f2wzqG2kF1q6nFfCau9sJl99t3jc4ufU7raSF2gwx2zEyjIr9A3vCl/H6kJnWINY9typPnKc
	4QXKImoQTYoZ7Kyfv2oJP5IG0Jr9dVXd49LJDjRP3PkUKOSLT+MVB3ttCBKowxptewXZ28AzV3p6p
	71U1R3T9AmViWacVtdchNixad96Jjflhba2wDWMl+bdt6wVVlbhlbW9efx6ZjbQVO4en6yczIVhAa
	ptjCSueIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsGnM-0005xK-77; Mon, 06 Jul 2020 02:23:48 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsGnJ-0005vu-Ll
 for linux-nvme@lists.infradead.org; Mon, 06 Jul 2020 02:23:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594002226; x=1625538226;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SLBgOBtVG/fiR67blu75SzABFxs69bVW25CGy9WPVdk=;
 b=i+ZNdy43cncSaYYFTPqh9aZ3zUlvJQEEqXLLz20vR+7aMmqzf8bmTQe2
 tB81FVDM6XcQlZNjPVgIyjnTyExMluHzRKPBwMLnESDporIR5X3kH2Szt
 YpC9i82dnj3Yq78dw5hyWbcbGuxSgwyRLZR68WqvyR5NLN3Daz+BvlyQG
 dOsLJbIGznuH2YiKPpocoI1yumsMYk4CzoFpYK/+yEE2UAMFbQKPXABKr
 eHrsIlMIZahqLD82PQnygvAtxJOcKJQBHSJRWZNwKVjbNl+aecctDB8Gs
 Km7AEHudztAfbh0/5PiWMiy9nPUEuHmh8kHMfwxKzNy7SJSymwpvcf5em g==;
IronPort-SDR: 7aS3E4Gs9BL2pmBlNpwUaJodx6wn9s0ZWYclhhSIR0mkb1ZjWFzvuXBCv9GdwiyJsnTz1i3bVg
 xLCWby1aKJ8XWS3aSwBE1XKwC32KHmXkZG5enkjyeRffyjRxzSnQRr6O1CVr04D9F5ese7JCdN
 MXbIrDdqpdWZJyS69mQBaDarNno6vCEowG1Jf8rd6DpO9bDSkMElPmDXp4I3konB72Kqavk8c0
 RNW7b9j19W4Y22hWMosGTvNN5XWwwe5s1+mN3lTqjrLkFtKW10XwiFnUSftSFd2pfKUDDTagD3
 m6w=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; d="scan'208";a="146022033"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 10:23:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4fgF9n6BXVnETyAyiWdqcqN/s8d2jRi8vh7tPbiTbb1GG+aAe7Vfv/BhX2BL16aaCHN7prYqotaaPKkYIf3dOgUwEXyyYhzzyzWwokxnqiNSUDayP8BJyzHcA9vD76Vmcz/b6TwptMQXsonCOTdnr98Xzsl7UAhr+5yXiGKUO6jV2CJsqwEQU5ESbpyPkgNaMUtW8s6z6sgIu6kEgQrngWxfpq0MQcdFY+PK7UhX3rMCjlxr5KTxGsHbswTSCj3aGxZv9uIXOdXOuVxHxFYVo8UvXkGkc7rPdEpseDTh5y2Q/2FjXKea69ozyCo7B7c8k8b2ATxZ8UiroHln8J2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLBgOBtVG/fiR67blu75SzABFxs69bVW25CGy9WPVdk=;
 b=ET/zqdEBHhoTlnMTH3jTfB4ZSCARVEvZJdG/LWNphfTsgaBQX9NGzttZnVhH3AjAA/QzSqShrYc7knd8EjNzPZs87Cui3oFe2EQrN70lEPNbTkrCjobehbfuimHXXLiTOrl+2qnWYfpZOhpkgkn50MWA58zj/EEMrqNCrq1dID3anxa2uJRSKG7QSAYKlZ3RkTOc5doPI54LDZct9h+HG95mncUJKAKSHkKhCoh1QJycH3rMnzvrD4RztrlRHEY+1IHKVq08FwlY+5IHQWcAMfSCNoy+n30QJn8A6RehUHwaG+XX2yJ3zczNLaPoocZijaq50cvz0KOUk1zSjmXN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLBgOBtVG/fiR67blu75SzABFxs69bVW25CGy9WPVdk=;
 b=yLzA8fOskQOSzDriDlCEItQFZnuA43M7eC+NrrO0B1bfzMGibJk4avLSGEDDdVvPhOpLbsfEpgvCPYVzw5SbHghxFIdUIbFIYFJq/BnlCn+f0qpytqEM3GoqEltEzsOTV6kN+MhQ5cgTSonzlcbSWRaY34tmUo7QqIyTd6Wjg8s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6550.namprd04.prod.outlook.com (2603:10b6:a03:1db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 02:23:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 02:23:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/5] nvme-pci: Remove redundant segment validation
Thread-Topic: [PATCH 3/5] nvme-pci: Remove redundant segment validation
Thread-Index: AQHWUOVXtR7Eg0/4Hk2VuWAjK0lOzQ==
Date: Mon, 6 Jul 2020 02:23:40 +0000
Message-ID: <BYAPR04MB49656927FC38696FDC8AB10286690@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <84ef8fd8eb4d7289fa92b5be12cc71eb1af46c5b.1593743937.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5be66fcb-0df8-48ff-16ee-08d82153994e
x-ms-traffictypediagnostic: BY5PR04MB6550:
x-microsoft-antispam-prvs: <BY5PR04MB6550F70BAD45BB440E5F188086690@BY5PR04MB6550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dExtBVXdL3Sdq6Gh8ntggnMJsbK5zuimrm2um5jlMdXpGKV8Mu4PdWLu/r2sUWCYzYTBprYRgowqQO+4GrNRcJmrm/Pd6kNmMMPu/6R+g1mOv5xnHjHmdoEYZNAxUKRfVJceGrN5b0Nt0XuSFRGM1WV9FjMpMK146EaS6S1dWizM7yuo9NxVtugJNR2PCTmumPndQ7YJiidh+EYXyoXpODwRqiDZn+YM+jLW4AsKoZ4XI31E1LIXnxUnX6FncFFyo5ORF367ddsadVxLiFKBSu4977zrD/SUtZ+bjoj0JysTPPr77Xj1H7tAx1FTpkYpN940Hbgdhou61ckospMemg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(76116006)(26005)(53546011)(6506007)(52536014)(5660300002)(4744005)(7696005)(83380400001)(478600001)(71200400001)(66446008)(66946007)(66556008)(66476007)(64756008)(110136005)(86362001)(4326008)(186003)(54906003)(33656002)(9686003)(316002)(2906002)(8936002)(8676002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5pglaNL0twU4a4JF7ZV9tdxvscf1FUv89sxdkCCHTurVDjtZxVKD/3UESE5FLLcXj1+28lxmcnVLCdTbQR+61YYpIlOexEU3jpQ8tRnDhOV7/9PrG9RV0Cxj/LOf84RkJNNRyGmD2Z5kOZj9zq1ul4/790PYE1iIczWB/AgKhp+tYLxM8+VNbrGa2pUJSx6yxp5UeSsUav+0pazcMYnkOdSVzxI7+soBqamV5zHsJzB7v1BlMrpzN3rDgUZ+EbmwhhtxrlrXxEHl0FOgRkktyDc4qIyRm31wTOqlcs+9Fi589tdQYL0b0TUrg7Y1bu1qApyjxvwdpA2tOLbnpznfBp2GponkpWhcM0v0dK41dkwJW5cy8mYRJ+2Bb1fgS7RaF8uZOFpnu21Vh53GXmXAzCFq5CC2CRzn9reaD1t7xRyD0cZ4Bi8BX16Fe5whlevPbqW+reWhITglHIUUBkDzmTaGBKX6IaXWdE8lYBc9iNw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be66fcb-0df8-48ff-16ee-08d82153994e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 02:23:40.9449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNEeAd8QyrZDO4pocfqOUxqdLFXz0cfMw6OJd+MdFze2UBDR18Ws91M6SNjCT04k5LaMF0DKpydvYMzku2NBS07GF34L2ix0eiUrCriJb3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6550
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_222345_871822_AF026D09 
X-CRM114-Status: UNSURE (   7.74  )
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
Cc: "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/2/20 7:54 PM, Baolin Wang wrote:
> We've validated the segment counts before calling nvme_map_data(),
> so there is no need to validate again in nvme_pci_use_sgls() only
> called from nvme_map_data().
> 
> Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>

Indeed we do call blk_rq_nr_phys_segments() in nvme_queue_rq().

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
