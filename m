Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D40C636D3
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vp8lALYtpTfaUfWQfJ88qYgq6DVw8ktGlzNekStWlfc=; b=wnqWHgGWZjFauFLmzfivXU350C
	PPoLLszbvoku5YX0KQuLbYMy2KluYv9n7C3BeePEYyb+5NqD1J7oajxuZMJYCR1SMkIA1ynvYDyKU
	rzu4xUWosw2nTdkekaWX5qsKSBwTT4vgprrR74SNSfBBtYTfimEDEeyMg2kok2Rhi2IcJfZ/jRXk4
	A9EMSlnEELDQi0TtJbh0Q2eJe8yVkuHEVW8GkpymakF1sy1jDhi45eyouSf0jpgzHaD2+MDsK60rz
	/rqLhoaWMNP3bI0lRAOtCDlZ9st0HNYz6KzwxVlkA0m1lAgwSoRCWp1i+QDJemOkQ9gw0wOPi73vu
	fBUK4vJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNkuI-00HYRR-Mn; Fri, 03 Feb 2023 01:30:26 +0000
Received: from mx07-001d1705.pphosted.com ([185.132.183.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNkuA-00HYQj-TU
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 01:30:20 +0000
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3130UerR020575;
	Fri, 3 Feb 2023 01:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=vp8lALYtpTfaUfWQfJ88qYgq6DVw8ktGlzNekStWlfc=;
 b=iZE+6B/2uSPQwp3eWohro1+ikp469pk90Zr5Z2r0poEkKb2X0Gu8GyP1L8fC5Jk6I5sV
 g5mzE9G98cRPGzvgL7rRIyyfBoM1Xgy51IvnORxO9LEt+hzK3uVp8Aa36i6odl7Kx+mq
 XhcKaeYXrfTuJqRFjE+pbdSH1adqzS6tEWOEi477T6RDo0MBK/i0NdeJkkV4a8HJPZVM
 US1IOHpa/2ujAI5VyjDY47vcA+/5YqVOTM34FSvbnwkJt1+j0APZ72YUV6n9pL0ao8V+
 x4+u6fbWpCsAYT0SN1E0dfv7LaDHeXHpuFdkWE9+6e/SCqVNtACJdZRY2TdcHiehh52E mg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nfna8sxsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Feb 2023 01:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFbyxqtkyywZKcekTWXP4/vlUowayj6/UCbls+NUGbfTCM+CxeN4sWrroNnQzwddMYfZNfDbs9sf7VwVUS/IK8ViT2kzIw2fifRdINYFtLXs78Y/fYn5tmZ7XJUt2HW+wojgehsmff8E2nrM+/4w2ciYlM3KXtqBzfTQaOOei1MLRQf05G/aMRRwi7Qlmobxp5q89oQLRv68p/2xwD/UsEH+Chv+hhlOX7Gre43GxnupawZNHmXsL51AcRScBsdEkmzZ6S46zvI77wlMIr5t4rNbwcGuUICKQmA6geFG+V0As8amswUXVeiOlI5dcft22bdw6TapfA1mUTjpkBZ/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp8lALYtpTfaUfWQfJ88qYgq6DVw8ktGlzNekStWlfc=;
 b=iuPRTHfSQ9qRRJdNClcQHje3/35KZWTqoJXaZR85tKyzChdp78HJm49/8GbMc3AlhROkocBnZ5yU2ZnylMa5n6AgvFqTazFSPqbBB1OVAysLgnsfSX6YTW6vbS/BWKqf6q+78t2Sp5r7Qc/SUG8RnSjBUB2LbtrfKWOvz0w0oFyGcXcopZYgIfS0LIDIjJTWcPRLKdzosGC2ZvXIxXYhPgr+GjqwCq5vNTyiMfMwTgwOeLSdeuPr4je5fxB1e6PNgncYHN4QERh1mNE+hId5KdEWy3ICeXV2hNOSFV67nvRoQ+Uhce94oABRdKsNxlGJ2YALNR/qvr/gzLbyJEEvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by PH0PR13MB5379.namprd13.prod.outlook.com (2603:10b6:510:fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Fri, 3 Feb
 2023 01:29:46 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 01:29:46 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index:  AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAO7iAIAAazaAgAIPGOCAAMCqAIAAjSBwgAAQ4gCAAF+mkA==
Date: Fri, 3 Feb 2023 01:29:46 +0000
Message-ID:  <BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
 <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
 <20230131085828.GB3139@lst.de>
 <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
 <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230202101818.GB14931@lst.de>
 <BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|PH0PR13MB5379:EE_
x-ms-office365-filtering-correlation-id: 040a096c-931d-4954-c430-08db058622a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Dq1+mNVGPy9NoVXu10fVEkUgvV9m4Mmi5KqW32syQ5aMdSoX8sQ6oyVLPDULiu+C1BKDvvEyj7zzEUn7qVjLXg8Q0/3vpNFDkL6pV6hA+3x4TmK+AumJdxqwaQrHYhExGRGKn4HfKMtwlVAO8nelO97U3LfWBj5KrtYV347qHu51Q9QAsgNiu2aaBydOYDCE5t32ObEEvCVKF2ByvCnAatFb6jHfSLaJrzfjQvcY70sotrvDTrPnyzFlINSEpCRuyTYAfEVao/yXEhcquA+nrMbS1yoPyQ5T1aXSOS6a1Te5I4FL+Q8uK3iZ4h7oKGVAbO7OlLjcFSbmLjW0wGzy8Co9BzL+TWY5w4tfrjElIDz/xFplZoPPQDYQMFzm63Lh5a6AeZiIsDB0OJAbwPWEM3Bdrd5kU/vYxhWdAPgcvzMuzZ5oyJxqZs9yEYQ094HGZqRmidsOKGrQR5JiJw3Ui+XoeG4N5dp8fDlmkGg+yKYL+k8COVuQbNdsWzZebJIiD/ppWWaaAjiY78IW0bjQYvawIV9dKAQaq9dWkN4nWHFys9/PgxsgXk5nhMzp49vQ+aeevkxmXG7qGA5HvT04AnK4DffQUq4W+aLpOoDovwN8oarrcYFASdu0Ukzj9+VIeu89buEoy94Msix21uA3nC1LjbPXtSvfYqw13EVL24ZyS4XBHpS2AmBwOmPuEMB/wA8MJy4BZFu7WzKG10X2Pw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199018)(7696005)(71200400001)(478600001)(9686003)(6506007)(41300700001)(186003)(26005)(38100700002)(54906003)(316002)(66946007)(76116006)(83380400001)(4326008)(66556008)(82960400001)(66476007)(6916009)(64756008)(66446008)(55016003)(8676002)(122000001)(86362001)(2906002)(33656002)(5660300002)(38070700005)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?PdKgRz/1K5JjW5xeDLxBAxP71ekS7/vCrYlYMdUBWyCilRs3BHuVdvfl4BcI?=
 =?us-ascii?Q?vFwAJVBiCm99TRYAvK4jQmNQxi5dIlku3oU8rQcEWnImqfHshk50TvMKFsK8?=
 =?us-ascii?Q?R0nPm5NpZj5H2IhpiMkYOhdKVhh6JvVxUj1qqThhxEzkNsR1JnwzrJopO5XB?=
 =?us-ascii?Q?sXJ+awFJV2tns4GuTEhCWsUkpbL6o7iSpzwv1Fs7NIeR9y8bBZdvnEJs/U/k?=
 =?us-ascii?Q?bKMy65lO85lPBSeS/vs9GPQNT10XjeUIXFWfvTSm05Z+jzPRal9+1hqaMXhN?=
 =?us-ascii?Q?73K9Of4TRdIaKWlQhXHlOVhzICM7zREr07oIsox42rmXns6YgWSzYM/u4mJW?=
 =?us-ascii?Q?MRM4kfyoIr7KU30iPcWIMAScbwx0fF2MrbPMU7aVcH1Vs11vQ7bDnr6Knl56?=
 =?us-ascii?Q?a10+0nMmm4FoMmccCjnTcJVC60M2J5rV5uNsND2RjvxKlzORvuUalZ3dP9F2?=
 =?us-ascii?Q?O1a3eZdRiA1xcg4Iz0uA0NnWcstcCtQmjpHLofhrkcariALb8z5dkGix9V+O?=
 =?us-ascii?Q?Pzo+Vx1SLqrtPWqXih+F1ccBjNM+OqipWD7GnIsDVmS91jVB6cqfPuw1jrt/?=
 =?us-ascii?Q?pEBZ8MrAtaLPZUaohKt6uJBuP1tjFcXZelzZHscwrZTJ+K4I5rQI89xJauGL?=
 =?us-ascii?Q?HUIgDs7IlRlr2bk8W6ttdCwGftxwGV3vXMcknYmViK6nKXqUi6+fIFecFESo?=
 =?us-ascii?Q?Jfy38Kdx2cpt2jHlOSuPOsMG6+u2hfBTO5mQ6mXpMW4dENeLlD/VqHTP0cJt?=
 =?us-ascii?Q?jb8gYtbtxl5ee5e7sFMQnM9AXEbhW4dGjzWTWWsqX1Lsv/S5GitMAR6p+/bN?=
 =?us-ascii?Q?kzuPGDQ3WgdQw8E8zKrHlW0R/cYAw4PyfcJwN+0ZFtBlAqndEwWnD+jqKn33?=
 =?us-ascii?Q?UWSuQegmVasKzzioPJhJEXwTCIWmXDqKJlVgbmWSocPhvUolXWwUT57rxzsj?=
 =?us-ascii?Q?633w8AcFOSHwikMabcxdp2Qa6OIvjhAjnOObhvQM8i1KYK13IsTxHvIU9sBh?=
 =?us-ascii?Q?1dNkzGIu/uIzzvj7XZjJiYjxG93demkSaOyH5U6WIkFgejRZ3e5P/+0UY/Bq?=
 =?us-ascii?Q?hwR3750snG2a/oz/2lmi1D3WVIxcGK3gdLAiTVd6ULkC6c9P0pegKxjP0r5F?=
 =?us-ascii?Q?8ye5l+R5OdLyLYvyAi6vybyxNr08eW/qKizpuZJ/yU8JEXA3w0/pSoe4EjzK?=
 =?us-ascii?Q?UCbGb04XQ4QXNgyWF/jGoMDG4bz32PO3nqYIhWBTXvogDCyLJ5TzboADR8Wo?=
 =?us-ascii?Q?iMT/qJsBavsyXKKhW1T7GLLYiSIp4npqMZMv55V5qSI35u0tI6YicEvEobRg?=
 =?us-ascii?Q?lmy53CZaaxL+zIKQ1SoczoI8I5An3aebNv8BnQQrhyPMHcdI1y8fqSTnosMH?=
 =?us-ascii?Q?UGIJfOefwjLSAPOfIFLnLY991szB/gPoZhOriNIT/eHf6ILu1VI7bZRIAYmi?=
 =?us-ascii?Q?2TtQm10egqYAjA8nPsexPzkI58525wuPM4sD7FVx2ElgJjT6rIZbbyKhLo+H?=
 =?us-ascii?Q?Zh//sF+xGj0s8vVG6Url83c//S9PhKqa7njnWQhS7hJkv7sq4+rr0799UpgP?=
 =?us-ascii?Q?2u//kpafNPOJdSvWaMMd4Rv15hwDA++Rc2Itvb39?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	n+iTYuuksre2wEATdfsDjTd+eSGAExmC5oI6Cch8OiSCrz6+mK3Sziy0JXyJ5JR+Nh4w5Gs2yF/GjNFGkivRp1KVnMi/uYUBlJ6AymK+uyupjl2HQtRHWn3eh2uWbVfF9nXssrZg+QyHLL5DZ7pfHgzpkAZaqLjsKfxjbMkBl/xANloF6O2AgJdModXqNSzFW4JjVgzyCBhJPm56btH+nusUWNCOFIO5YPzfxVoNc+I0RkZWNnjAzLooSMnx4AWbk/01QPi9vH3b/BItPAqBwlOBPqUgUgrvFR3OhAvlHgx61rDSU4LGaUXvMcvdbPSBizDZcgHGgJm1ah0dQjr91Autks/bfSGtSEWlU5/1ZZXn43Sl5S0+sybRuRXmhqNM9xx0AgqDZRGYadcpmmuLYg7dqsHGo/YotujcNBF/en0/RSg0yL1a8hlXYzOff+14b4ztL4zlHY6Mypkf7nJMhOKoRGVjHNOudvhOCkzn9PoR56aVPUisl2fY41ekB16MEM/WPhJoLQVByFyUGKX+dNlAL+ZLY4CuHjFftxhnYt7rWMHGPScIN/zXuwbXNI1aCCgeqpnxVm8UiG55gHZgxD+Vhp0s7O8WsO2xNJ5GEgJb9Y8csvVZZJDNS7mKvTccIXJ7zSfw9Tojfi0NKkC7UXQcgOKHYUXrT5QzmAlmP8qwR3h+/WCbh4vOjlnfITW/2pi8w2TT3TUJLUorTlP4EOlh6QZKxcnfCnCOOuzjiYXogKhIdkt50GJ/7WgsLBodqlaMnUtzwJ8+3wZmNpCj4rCTo98c3y4cvOGm8x7a8XhzT4PISiVxI5KcwTC0mIPoFSI4mB8FHJkzgGF71FN9E009sLegLxVGlHgyrFD9qfmBUO2JNs+c3AdIe9FhaArh
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040a096c-931d-4954-c430-08db058622a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 01:29:46.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McnieOMvecvrj4EVx1pH1ts3UnXXeFCJrjRd7wfhubFbg48hYkXhFe0v9WPHeV7+Mz/ZMspPqMVtW4iR1SNkWJj1GDydzr0dqHLBT0fE4wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5379
X-Proofpoint-GUID: 7FjSxxWEGgykFiyfaCdqSKBFq3RUnkxL
X-Proofpoint-ORIG-GUID: 7FjSxxWEGgykFiyfaCdqSKBFq3RUnkxL
X-Sony-Outbound-GUID: 7FjSxxWEGgykFiyfaCdqSKBFq3RUnkxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_16,2023-02-02_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_173019_285894_18AB7955 
X-CRM114-Status: GOOD (  12.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I run remove/rescan for this Samsung PM1733 and it looks like it works fine=
 on both 5.15 and 6.1.9
See the log below:

# echo 1 > /sys/bus/pci/devices/0000:0b:00.0/remove
```
[ 2915.510903] nvme 0000:0b:00.0: PME# disabled
[ 2917.286586] pci 0000:0b:00.0: device released
```

# echo 1 > /sys/bus/pci/rescan
```
[ 2920.627012] pci_bus 0000:c0: scanning bus
[ 2920.632857] pcieport 0000:c0:01.1: scanning [bus c1-c1] behind bridge, p=
ass 0
[ 2920.641819] pci_bus 0000:c1: scanning bus
...
[ 2921.881870] pcieport 0000:00:03.3: scanning [bus 0a-0a] behind bridge, p=
ass 0
[ 2921.892102] pci_bus 0000:0a: scanning bus
[ 2921.898621] pci_bus 0000:0a: bus scan returning with max=3D0a
[ 2921.906664] pcieport 0000:00:03.4: scanning [bus 0b-0b] behind bridge, p=
ass 0
[ 2921.916322] pci_bus 0000:0b: scanning bus
[ 2921.923143] pci 0000:0b:00.0: [144d:a824] type 00 class 0x010802
[ 2921.931767] pci 0000:0b:00.0: reg 0x10: [mem 0xf0210000-0xf0217fff 64bit=
]
[ 2921.941367] pci 0000:0b:00.0: reg 0x30: [mem 0xf2d00000-0xf2d0ffff pref]
[ 2921.951365] pci 0000:0b:00.0: reg 0x20c: [mem 0xf0218000-0xf021ffff 64bi=
t]
[ 2921.960879] pci 0000:0b:00.0: VF(n) BAR0 space: [mem 0xf0218000-0xf0317f=
ff 64bit] (contains BAR0 for 32 VFs)
[ 2921.975227] pci_bus 0000:0b: bus scan returning with max=3D0b
[ 2921.983650] pcieport 0000:00:07.1: scanning [bus 0c-0c] behind bridge, p=
ass 0
[ 2921.993646] pci_bus 0000:0c: scanning bus
[ 2922.000333] pci_bus 0000:0c: bus scan returning with max=3D0c
[ 2922.008557] pcieport 0000:00:08.1: scanning [bus 0d-0d] behind bridge, p=
ass 0
[ 2922.018366] pci_bus 0000:0d: scanning bus
[ 2922.025031] pci_bus 0000:0d: bus scan returning with max=3D0d
[ 2922.033234] pcieport 0000:00:01.1: scanning [bus 01-08] behind bridge, p=
ass 1
[ 2922.043121] pcieport 0000:00:03.1: scanning [bus 09-09] behind bridge, p=
ass 1
[ 2922.052866] pcieport 0000:00:03.3: scanning [bus 0a-0a] behind bridge, p=
ass 1
[ 2922.062577] pcieport 0000:00:03.4: scanning [bus 0b-0b] behind bridge, p=
ass 1
[ 2922.072232] pcieport 0000:00:07.1: scanning [bus 0c-0c] behind bridge, p=
ass 1
[ 2922.081835] pcieport 0000:00:08.1: scanning [bus 0d-0d] behind bridge, p=
ass 1
[ 2922.091437] pci_bus 0000:00: bus scan returning with max=3D0d
[ 2922.499469] pci 0000:0b:00.0: BAR 6: assigned [mem 0xf0200000-0xf020ffff=
 pref]
[ 2922.509087] pci 0000:0b:00.0: BAR 0: assigned [mem 0xf0210000-0xf0217fff=
 64bit]
[ 2922.518830] pci 0000:0b:00.0: BAR 7: assigned [mem 0xf0218000-0xf0317fff=
 64bit]
[ 2922.528871] nvme 0000:0b:00.0: runtime IRQ mapping not provided by arch
[ 2922.539667] nvme nvme5: pci function 0000:0b:00.0
[ 2922.548225] nvme 0000:0b:00.0: enabling bus mastering
[ 2922.555997] nvme 0000:0b:00.0: saving config space at offset 0x0 (readin=
g 0xa824144d)
[ 2922.566124] nvme 0000:0b:00.0: saving config space at offset 0x4 (readin=
g 0x100406)
[ 2922.576334] nvme 0000:0b:00.0: saving config space at offset 0x8 (readin=
g 0x1080200)
[ 2922.586310] nvme 0000:0b:00.0: saving config space at offset 0xc (readin=
g 0x10)
[ 2922.595446] nvme 0000:0b:00.0: saving config space at offset 0x10 (readi=
ng 0xf0210004)
[ 2922.605199] nvme 0000:0b:00.0: saving config space at offset 0x14 (readi=
ng 0x0)
[ 2922.614322] nvme 0000:0b:00.0: saving config space at offset 0x18 (readi=
ng 0x0)
[ 2922.623452] nvme 0000:0b:00.0: saving config space at offset 0x1c (readi=
ng 0x0)
[ 2922.632541] nvme 0000:0b:00.0: saving config space at offset 0x20 (readi=
ng 0x0)
[ 2922.641630] nvme 0000:0b:00.0: saving config space at offset 0x24 (readi=
ng 0x0)
[ 2922.650659] nvme 0000:0b:00.0: saving config space at offset 0x28 (readi=
ng 0x0)
[ 2922.659654] nvme 0000:0b:00.0: saving config space at offset 0x2c (readi=
ng 0xa801144d)
[ 2922.669236] nvme 0000:0b:00.0: saving config space at offset 0x30 (readi=
ng 0xf2d00000)
[ 2922.678813] nvme 0000:0b:00.0: saving config space at offset 0x34 (readi=
ng 0x40)
[ 2922.687822] nvme 0000:0b:00.0: saving config space at offset 0x38 (readi=
ng 0x0)
[ 2922.696721] nvme 0000:0b:00.0: saving config space at offset 0x3c (readi=
ng 0x10a)
[ 2922.723443] nvme nvme5: Shutdown timeout set to 10 seconds
[ 2922.765257] nvme nvme5: 63/0/0 default/read/poll queues
[ 2922.842614]  nvme5n1: p1
```

