Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5418EC05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8oWNJ4dnGEAFpmvDqmQ0bYuo8o9fvrk4q6df5T/Es1s=; b=udHek9FReeGRdFOKJXdz2R0RQR
	0hw/caMsV2MT7hFYLskQTYDxGcHmycpbg8an8+4bGpwRh6A0xMiq1mejVrZ3mwsaof5T5B8fiRHM6
	4PLw7whl1Q6C6woadwED2Vxtm4LF5HFFirWQ6lxed6cY63rQnxIoX2TY7gzXS4R/auUM333cXrdgt
	M5Wkqq/EY1QBXombSXoIYNUJJY6WbDGD5ENVfWnKMSg5yTCxnrsGBSLUS4t+AtX7Df1moblu56Y04
	umkSC7yWlRKELNaWVevbNw0tZTpW3OBnm1UWy5MMVRBWPxjs+bdGSyIC/mevQ49PrSw0Xaiw9ElES
	nDPFN/Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO14t-003JQX-Dy; Fri, 03 Feb 2023 18:46:27 +0000
Received: from mx08-001d1705.pphosted.com ([185.183.30.70])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO14o-003JPN-60
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 18:46:24 +0000
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313IUNuX017504;
	Fri, 3 Feb 2023 18:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=8oWNJ4dnGEAFpmvDqmQ0bYuo8o9fvrk4q6df5T/Es1s=;
 b=PTTMoEznSenTduMuNyOw1Xn9vPqmcC2aJ3+DThXWeq56TW3j8pvBplIA0xw6u6tKJlyU
 ulP4q2G0cLEhC8Vopbhv7eYJzSj6KeqEpZfYw4dPBg/5/fqge93WycdSbP6wC4qKHK6F
 zRJVCwUrN1qC2Lp2pT7iZtnXDZFzJ7GiToQrAkfp7x4POfDz190GyNhAll0HCYZKzYyr
 9G7bwdPWDuYezerdQ86ok3WTIRUjy5e7HFu83EezfeV6aJerL5cdE09r9wnRGYlamVZP
 72Ld725EXCerWJU9T2MWVeZ7XOS2MX0lXxpulXOHEUeOSrE8Un4QTLQ06hL97KOFpgI0 rg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nfneujt6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Feb 2023 18:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6yk9UNTfB0eNU2lSSP2rrrNUcKvrFm+pGllOOHRUsso2qDk6J/fIpEJwzaa1hE6s+E/fxBTCpMuG3M4xp+jXsXZzDvfmMsMW6eVPCk0WTHM7np1qnvzVdGuJqGCsZTzUxLbdtw7KXVYnhARCbDAbY9Q2J8BxZKkiDKUGrBiDLufcwtC1RXMmztkG8OIBH8r218gl7WlUhuYp0WJZLDGwHfVvMN/xYeFev9Ne7FL3ZsCYYW6ZwJKCDDGCAUSCdbIOYuxk1gtnyNRcoD95YBkTP9T9RXa9kEjAel8xrw09rnrtjHTsRhaapp2kT5IWvMjqckqeaAM+lP03qUO55NC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oWNJ4dnGEAFpmvDqmQ0bYuo8o9fvrk4q6df5T/Es1s=;
 b=jzGeSaTL0HVj7oHmHs7a8rOuzeozdOrNVMDMEKGCLl76mjBPrBuLnMTEgUQGfhMYlI8uxMnmnJdUEa3GiKxUXufFSfacpO6mBbIZkVP7PliMKngMrNU/7NOOIQb4IKLWgze/f9smEjGNITncgzbQCGJzs2xTFu0aOF3zdcv+pSiWDeNLfUcHyk1QwGqVeBA5mCRWyDntFgHLnCrO+lft8ofHpLArKkvOOzCzOsugt26PjdtNB3Zuf4ZbmBVE/yN5M/WwEtAx+MwfAGUlRCsKPQJQBciqOEWd8ySSSOScJsgAs59iDajSDmAfspXTb7eKJcanCXgs7C6bBTtTOab9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by SJ0PR13MB5382.namprd13.prod.outlook.com (2603:10b6:a03:3dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Fri, 3 Feb
 2023 18:45:36 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 18:45:36 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Lewis,
 Nathaniel" <Nathaniel.Lewis@sony.com>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index:  AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAO7iAIAAazaAgAIPGOCAAMCqAIAAjSBwgAAQ4gCAAF+mkIAAAwkAgAEdYVA=
Date: Fri, 3 Feb 2023 18:45:35 +0000
Message-ID:  <BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
 <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
 <20230131085828.GB3139@lst.de>
 <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
 <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230202101818.GB14931@lst.de>
 <BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
 <BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|SJ0PR13MB5382:EE_
x-ms-office365-filtering-correlation-id: bd7fb8bf-9aa0-4ee4-82b1-08db0616d682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  IcXYTMrhBXTYxz27+kyyP1vyLzUfsXq9cseN/ApUY6OhMI679AbQBw25mTtWA0j6iwCRdZ2I2Sv7a8GddzPXYIUTQK/r3UvPGHpKDQ1Jd27+kF4u1jahqUz3/hMQDGb9Ryf29XcLUar5JC8oIeOCaxvBLBA47kzIYO70VLCSxyn+BBCLJlS601gtbXkCzOTRNPOIRTj6xsb905SnANWf/XubpawLdzYGJLYr1UWIm0e1McSv4ZUtKubX1xwEUNhkV6459HXuHG9siJh3qxvAMxh8ZsJlJE7XwZbr+0LNnlVX4K9FsZVF+EcXzs3O9PlXncIx61ks7jgJLcR4WlSmOAQ2hWOYCGK1TMTOuFvQybIvorU9ql9q6SjoIkuX960Kb1qtP9dcYmnry9D/glG4pGg7D5/Mr6kUWfiaiXNteU9+YGot2HkpA7trOFIPMantAYURPt5JXKaA4ArHrzEy1/duHsWN1m3ZE/cFxuhkOy91+3oZUfwI4ALxv5h6iWAmmQ0g9E2hlAT2aOutw2GJZqDWt9nmw9hifcqGZFf9nhPqR9iVlWmeTZix0caMutW00RWGMsQ3m9aRIu7oG3+tY2jhzIEUumvWgvDBtaBmNxbzZq0xllhFrXKU2wvkl2SO72+qhSQYUDlkHw63kqopz40wW5fiw4ax6hRE+K8npKLqrF3QMMBHwD3JmtYgg6OindkLTWtpb3fROt5iQqC4ag==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(33656002)(38070700005)(86362001)(122000001)(38100700002)(82960400001)(83380400001)(6506007)(107886003)(9686003)(26005)(186003)(71200400001)(52536014)(316002)(7696005)(8676002)(66476007)(110136005)(54906003)(478600001)(2906002)(55016003)(64756008)(66556008)(5660300002)(76116006)(4326008)(66946007)(66446008)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?D6b2hb2LKgYzidVTuk/jG46WWgGROErG5VMaefFHkKvQ4RHU7H9Geg5ul0Yv?=
 =?us-ascii?Q?Gtc8dTr9ljV2SrcwfDAbrQpfXn94qqo3tyDR25d3Yagh8Hrn9cnIXfxq4gjh?=
 =?us-ascii?Q?InPPfkekl9+f8w5kZxWzTSOiMs/Si3VGrsCsg1Or2uXx+rZxakLKUDaq1CmJ?=
 =?us-ascii?Q?fwscEUATLrgrXtvSAPK6FqIgviudRMob9pXsapKRsupq6REv7lsExbGOh8Fg?=
 =?us-ascii?Q?Fu2axc8TjXIVlKMQl4BYUlV9TzP7s5w6nUMROmobungTP0IXeQY3FAzbAdhC?=
 =?us-ascii?Q?ywF7uZyU0vdnh3UqjShWIbFteuVojwtpIiu7eg5QrtfyTQCDHIzRD/bSDUy3?=
 =?us-ascii?Q?aiyGWxQsPrqwAm7p2gdo7szTzQ3q3U/xRHULop4liMS1LtABAcddi79l6M6b?=
 =?us-ascii?Q?PfyTLocixar9CpUJibjogg30r/xKm6XNVFmtHoqrfMJr1WS3QynXqAWH0iJl?=
 =?us-ascii?Q?RpFy0LLfpzios+/nQIoWaAzGzWYhsSDF7UIYFKQuQPrlNBfJEhT6rI3EzYaU?=
 =?us-ascii?Q?7snoX5Th49xNHIsiOMM+VYluV7MGYVkg45PgpOY16+LNxqDglXRl+yMX0PRv?=
 =?us-ascii?Q?fZXM9Gy8PXdZBfEChcgNGxsZF2/w0/TW9DxBqS8ezzUIxv6WWA4gs3OFndf+?=
 =?us-ascii?Q?KgLeKb5ufEAKoOakoDJQNCBGXJg+r6eu/eFJ5Sz/cBbjMyIW3YG8VnuwPbXk?=
 =?us-ascii?Q?5rsGY1ZPaJG8yXqzf1lehwrF6DpPjrDbxCMurSE3hTKCy71u79iCcpx5XNM4?=
 =?us-ascii?Q?qzqkoIBs1XM6GuPvzgpfSHFHynSGP3N9SSNPWa5aj1GliaYARab1C3OZKJ+/?=
 =?us-ascii?Q?CJ6iABtEEpLQPVbjhPCf0wZ6aRJD3kotQ8VjM2FPJAVOYnobesF9pBZ8e9cN?=
 =?us-ascii?Q?e9OaMExmy+hAYPP9WOBrVKWRqagUS5zuxqTTO9ijQ/I+dMNr3VANxqjsFJpo?=
 =?us-ascii?Q?HOt6aJoVpiMC+AICQwarwkFAG32/B2X3t/s5K+dm8T0LDGkw34uDEgU5T8DL?=
 =?us-ascii?Q?iQkLzhkGpramA10l1mDhIBT+Mx1B5WxiVBj/xWHtyk6BLh0oqg/10p0CNxhs?=
 =?us-ascii?Q?ne7Cbh4FTXQLlIZ6dQPlxeM/kcPfowG5xQgqZj+jIud9VdSYsd8Bmmdro2fz?=
 =?us-ascii?Q?8w5rIEMhXEwj570rjB3HQleihRK1LLJ0gDeGOz13+gHYmVMYhJFrtMT/+XeW?=
 =?us-ascii?Q?eQ5tWftzE4CvrPntEws6dPN2vWr2b8LBag0UCXjIq68efizUlhEVFuMUdbOg?=
 =?us-ascii?Q?R/BBBZEZIVdw/yM5AqM90WUrwv7CGrgt5e889f7xhcNLLAJHVVwLkrFp1351?=
 =?us-ascii?Q?OCU1Kch/FSW3YwtQCRyLjtNvkpviDRDfV5CBC90wf103WQvXEttr4iClQ/jm?=
 =?us-ascii?Q?46ATMzMOLPabPP1UmkgzyE3FNfoBau9jrVU0Cvy8iQkb3DUUV+vISRWjD0m6?=
 =?us-ascii?Q?01sFDE8olcRW84BDXMjlR0iJkFKRIotcIFpQfaLCmRFGUmVSS1HwFJTHl+TA?=
 =?us-ascii?Q?nax+rAxZnIA39OhkRNZx+uHabKgRmzGXjNrVzrvgnm3ysoteDXJgr1iIYU2k?=
 =?us-ascii?Q?+BCLTvrVjC/PcZ/Pn5lgdZyZmHYy9Xu7JBcPov/C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	WtswACgPU18byFzdq/rx8GbBFfyFhYuhDUINuxTeBuBvLZzTSYgqFgebYtsbvhKJ/F6Twkr3PwUgbcLGmHuBSsBS0dJ7W1z23Wg8Oon1j7Kp8fjWZhPr3NdMTeC2BVV3DSqZWmnivj13vsxx8FURhdvAgH8Ld7RsDsPqw9OsTQhrt9Wt8YWqYssYAay/zRKYWy1O8z/k59GYcv2MkTUCWH5KCJ1W3VXufaiGknQpA2+NMoX8sQ0IrYKeynHC5Qr2rIwoJ/SWi15NGx8MrCiOb3jn4hHvQMwpAQpZv2KxOiTHtl0kqtZinWRFNwcFmXJZg2VnQLsM0TFd2N6H9m8UG0uP3IkXwx69ibc/KmzAzgq/cUfyGA4k3LNvpltz+KAIWgkt2FMzr7o88y92uk9ABM/uweDQy1SsUrIM5mQi/dq9uu2a045dQnhv33mj/KaTrPHB/DBpw5qZLBui4CmRyW7k6i9BA2y27wiAixQbSLlM3sSl4i+u3OECA66cDCa1W3UfeHET9fkGCfdBXc7sGrc8PuhOXvJCFWJfYQKBXoLYajzA2rj7L+2JoQEZMq5raxAoN9PEEimw1yfS1jSSSAl1lXHwfBw1/FFIbNbOsCd6LM+SqDPwnpejr/9FLGWEMlbSiBCKWVsmJGz538uLvB6PR4UGJSwF8HRmCTNJIwbdWLWS2LI1CBvbKDwBWpkVcvF9HbQ0+ROlGlc38/sy5w3NNcMdcMNMNZ0rPLFu/sC+BhUglayuyOcZLPehKAHQ0HC/nLh6+HbBrhSPv7H8X8bQMzSLHJLrCaAz5kwcA1ppFK+eAx0ZMhtQGnZ2LwPM6V0QmRnPykaLXMYWC1hCMVUT22WcEqf7ln+z7FmeWWhtuVlD6vxLlH2mkt56+XnP+GZyLDjMqmj2e2Vy8HpPhA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7fb8bf-9aa0-4ee4-82b1-08db0616d682
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 18:45:36.0356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALxrP5SelW4OlNJtkp/WE/uad8A+PAHGvRQFJ1cXP+LfgMQa8Fsc5rfwbSakr4sHZ9qTkW7szmZufm8Gwn9xQE1k3gZbZE1q8poAN3Srzbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5382
X-Proofpoint-ORIG-GUID: SyL_rcMIMXXeb9RW2PvY6AQU7qw9mEl9
X-Proofpoint-GUID: SyL_rcMIMXXeb9RW2PvY6AQU7qw9mEl9
X-Sony-Outbound-GUID: SyL_rcMIMXXeb9RW2PvY6AQU7qw9mEl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_18,2023-02-03_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_104622_552505_2FBDF31C 
X-CRM114-Status: GOOD (  16.40  )
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

> > I run remove/rescan for this Samsung PM1733 and it looks like it works=
=20
> > fine on both 5.15 and 6.1.9
>
> Sounds like the Samsung wants a longer, non-standard delay between SBR an=
d reinit.

Thanks for the suggestion.

Hi Javier:=20

We have 2 Samsung NVMe drives: PM9A3 and PM1733
When we issue fatal AER via aer_inject these driver are not able to recover=
 due to the=20
"Unable to change power state from D3cold to D0, device inaccessible"

Repeated log from previous mail (this is consistent behavior on 5.15 and 6.=
1 kernel)
```
[  334.527200] pcieport 0000:00:03.4: aer_inject: Injecting errors 00000000=
/00004000 into device 0000:0b:00.0
[  334.537072] pcieport 0000:00:03.4: AER: Uncorrected (Fatal) error receiv=
ed: 0000:0b:00.0
[  334.545320] nvme 0000:0b:00.0: AER: PCIe Bus Error: severity=3DUncorrect=
ed (Fatal), type=3DInaccessible, (Unregistered Agent ID)
[  334.556682] pcieport 0000:00:03.4: AER: broadcast error_detected message
[  334.563467] nvme nvme5: frozen state error detected, reset controller
[  334.615434] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 0
[  335.655445] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 1008
[  335.663647] pcieport 0000:00:03.4: AER: Root Port link has been reset (0=
)
[  335.670523] pcieport 0000:00:03.4: AER: broadcast slot_reset message
[  335.676954] nvme nvme5: restart after slot reset
[  335.684371] nvme 0000:0b:00.0: restoring config space at offset 0x3c (wa=
s 0xffffffff, writing 0x10a)
[  336.427724] nvme 0000:0b:00.0: restoring config space at offset 0x8 (was=
 0xffffffff, writing 0x1080200)
[  336.437510] nvme 0000:0b:00.0: restoring config space at offset 0x4 (was=
 0xffffffff, writing 0x100406)
[  336.447215] nvme 0000:0b:00.0: restoring config space at offset 0x0 (was=
 0xffffffff, writing 0xa824144d)
[  336.457117] pcieport 0000:00:03.4: AER: broadcast resume message
[  336.479575] nvme 0000:0b:00.0: Unable to change power state from D3cold =
to D0, device inaccessible
[  336.494264] nvme nvme5: Removing after probe failure status: -19
[  336.535861] pcieport 0000:00:03.4: AER: device recovery successful
[  336.535899] nvme 0000:0b:00.0: vgaarb: pci_notify
[  336.691465] pci 0000:0b:00.0: vgaarb: pci_notify
```

Same experiment for other NVMe vendors seems to works fine (I tried on KIOX=
IA NVME)
is that something you can take a look at?

