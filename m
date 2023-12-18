Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DF7C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lpdb3fBL3whLNd2tvgrRWdiqDaTq6RxUuHgmeE+6IPE=; b=1sefMLl/MMDvZfg3YUQ3DHy2u/
	dnpIl0Rhta3dOYejmjzTykOWNHJnHkWj56kLyUA2MON2yoJRhAAKLLMCAwRIbnN0maJ3qXS0UzVyv
	d5gad4AN8zck8ykWG4rRoYEvmt1qwxG9NCplZJCQMK7kC2cK8KySsR8O79lMH8QheMe3ZlZzcXMC4
	ZMHo+RGlnUI37EhjKCHjFyErgIr+JWfmzBlwAD3733EPEFu6ebulKBW6hkkRuoH5mkm/ToF60FRIS
	wamnHNp99jLBXjPTgfu2Rzx5+0HiIQnGHjGmBOwAhBC6Rh0grm9vRM2YK+3d8w7sbluED5EvXgyqs
	ZlU+V13w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFIu1-00BqUg-08;
	Mon, 18 Dec 2023 19:03:45 +0000
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFItx-00BqU4-08
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 19:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1702926220; x=1734462220;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=BhiM4AdpOxFz0WNwoAK8tH59bY/t5qknpouwkGjQ56s=;
  b=ARfEAMQ2GQb7P1GqE7MFxa7EXqRS7zYeXljcsTFY1yjGsMo5sPf50k7S
   P4ALE+U3t5BgtJpuKza5wRXE1dY8CEsb+1nG+mGzkO8fCfIMPzkdA4F55
   i0qbjj6MlisgVMkfnynz9mOzrQ8f5dp2QR3eLwClx2ufRnhpTQSZXhL8t
   E=;
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:03:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE+X1M2mXHML5MxmmpOYILii/SSQdPo43ouwLTBr+qPyOfXYgFASXFAXkbswAVbb+Q4MU4oek5Io8H6tyBf0nXNWOMnWunMsiXqo4Tx7iTDfPFzxkzeSqy87qN9Mi0AX5xV94lMQidJz7nTgAPavEhYAp6rfaWm4bwFvSA2FLxZ1Z5U3sp6SjjP/3JM6koYvlEf/IT66FVIzP7Di0SPN7mEtIHNJPH5PYqCLLpx5aqTfdpUw7uQPIpVrAkCAlORERET7C3Js63J8O6FkuRyhZNH+spY4eO8rwHzM04k7dUHNuAha/1j7fWEX2IJUeOhHrIJymxast4x8nIer3FDhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpdb3fBL3whLNd2tvgrRWdiqDaTq6RxUuHgmeE+6IPE=;
 b=Q7i6NreNYfTN6h2GA3+Wp/vK22s8srrJ8QwEp/rt2YrXOI5Ob/vtDxFvpQ4Zu9+F2HdARuslTgB0QwOoi5q+afYmsMNgxFa3Ie4sp54X4Dl4ayjlxsQI9iM9Q+qDj195qaPdazjOiMSDwOh/EYqBm8jvnmczh0p/oXjOVZerpXBHvmmqGTgWMOeJcTuIV2yNdv/W6cld8jaLN8hkHjBqIAl6NYhS5qP7m+vC2k2v2S8FIrYm+6lKX/CN6HiYWbDIOSFfBWT7XQnO3t/itXFQ0Jtr6pwaBE6FeR/9wD/2+mFENu2t+b5VVcPv+cJ9OYM1f6yLgw61FeMrWNDdTzAKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpdb3fBL3whLNd2tvgrRWdiqDaTq6RxUuHgmeE+6IPE=;
 b=Uw2pN9OaIpwmS7V6bEM8uftLQc6pkLKpk3jh8icfDlW0nz1p7XaZeMMGAIZKZLtmMV0Bvsy9P45NfimRB1TFZ+KAXRaFuPYJvYrhjUkPqD2vJy9slvXPHzjvTYZnn5SL2TOpB4Nx88S/iVY8X6vNNdnR0EfypahbdCq0beJdJrc=
Received: from SN7PR20MB6609.namprd20.prod.outlook.com (2603:10b6:806:32a::21)
 by MN6PR20MB6716.namprd20.prod.outlook.com (2603:10b6:208:479::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 19:03:33 +0000
Received: from SN7PR20MB6609.namprd20.prod.outlook.com
 ([fe80::91e0:13ad:1b6:8db6]) by SN7PR20MB6609.namprd20.prod.outlook.com
 ([fe80::91e0:13ad:1b6:8db6%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 19:03:33 +0000
From: Evan Burgess <evan.burgess@seagate.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvmet: configfs: use ctrl->instance to track passthru
 subsystems
Thread-Topic: [PATCH] nvmet: configfs: use ctrl->instance to track passthru
 subsystems
Thread-Index: Adox4vpGB+0dtEXCS7e+xrz/tSnc2Q==
Date: Mon, 18 Dec 2023 19:03:32 +0000
Message-ID: <SN7PR20MB6609070761257AD91613E47B8090A@SN7PR20MB6609.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ActionId=f7238523-7dcd-4f84-a6a9-329335c76f91;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=true;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2023-12-18T18:57:07Z;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR20MB6609:EE_|MN6PR20MB6716:EE_
x-ms-office365-filtering-correlation-id: 10ef855b-9fde-458e-8405-08dbfffc07c2
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VC2HdgvPVwBw4n5c7L5s8J8NYH7g9WXDGPJmwyvZiCEoXCt7/bDNjMAc9KeT6zrcBe2wkFMunM8Xt2Fiui1COO1Akr2FxxW8Vvn/OCm0SIENBs2qsmV50DjDZD44uzr1UKONPdAx9ib3sQLqlIXObi+mDNZ+FSp2SHCkUaJFiE9oegoFbu4jE11gjaB1PvP55eExuC77wJqW6MGinXZIqWELQXGDJcqLDDgDIsmXiDMFiTqq0oUuRTzOBUjTk5cPZ7tczt0vgpJv7pBgZD4iwmrcn1k2M4swwyrBrg68am2vaWt/Be2iFZBRlVYDYj1h1YGB+djupynN47CfM7J+sgs1jtxxauZ00B1vyRlkYSWhO4GOrUorn3bmTHc8IvXFmHiW/LGFoS1ffCMZ10Z6ONyLLmbJFKzD3kob0+iEo/wlZfauqQr1UzCpNsCjoLQPda6QISPMAkcMMcfnKJgrkVqtK0sIl/bsUPC2XCxuyOXfVzsoR+ruI/9lcE83MpuwIk4q/pkCCfJfwnRrz8vVGavZ1U51GLhpufJXyEHsrBFtGTknlwa0tpZsFFpdB7wzxDhOwkOCCV0EN7JL88PUNmEehnu40RjstOGeSnXPlKQK9kjhnigFulYzWadGzSWQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR20MB6609.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(71200400001)(83380400001)(26005)(122000001)(38100700002)(66946007)(4326008)(44832011)(41300700001)(5660300002)(52536014)(8936002)(66446008)(2906002)(316002)(9686003)(64756008)(66476007)(478600001)(6506007)(7696005)(66556008)(76116006)(33656002)(110136005)(86362001)(55016003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7fk4elwMQnFjnhawguXLnMUciB/TKZOiicOjMnfQRhvXmc8wPv04NXiqFtcJ?=
 =?us-ascii?Q?QYJUx8tQRDC4Nu/SyEJQnq0vIPGsKerniimiJ4jZnWMCmUL5n9SHiQgZHA5Z?=
 =?us-ascii?Q?EATZfpCemdanRxBfmQaGqz1ZsGP/1DWMtmsmffRUyulof4UvaqFdUM+CO9qJ?=
 =?us-ascii?Q?0q5Vx6s08yQknojJxymzXRllvO/4+6C2Dp4RTU/R96v5yHkZbLNAKp033kAQ?=
 =?us-ascii?Q?R6AIuhbtjxz29Yd7tiVoTiXHe1YWxDLm/rrQ9f6YLK+euw9vqardQvwZZrzP?=
 =?us-ascii?Q?Paqo1buzpd8wpp6mN+wd2kHMBuwXYOZq/8YmW9Yb5jp24PBABPKWDv/pxpYP?=
 =?us-ascii?Q?i9H1YDUZfRfNNe/Pf6KngW/mbW9vmc+9y7FOi4QKmf6Bm28+asNXNKyhKlwD?=
 =?us-ascii?Q?1Yf6VpWHHP6AQZshoREWuULN0eyYrTeTRS5f33Aq5WsQTtqusC3NNf4jsos4?=
 =?us-ascii?Q?WhKseEOwgk4I+oyOBS/1c2RpTJEYe6fsZ3ToYqWmMtfVlOAY0YI0HOT5RSpX?=
 =?us-ascii?Q?bQ/ogZFbJZMa5ONm9fGlDzWGLC51otcxZmqWbMeYUrlvOftFJSvJd5INQLQ2?=
 =?us-ascii?Q?A122zw1IDymQ5Cc2V1ujdA3KEuCDfydMBKpPldsohX2lZ0Fi3e2+obgHwnQe?=
 =?us-ascii?Q?wc0RtAnMev9FSAS5y31evmmY1WctrhczhtsMEKWBWLVDaI6cw+1le7o/prxz?=
 =?us-ascii?Q?nQd/pzQIiG1H/0e0Y3HrFx3AQYqWWShc8NYXB831ALs484FZtyAa3ySIMfG9?=
 =?us-ascii?Q?MVGGkdU3aaH2B0IKAv56DG+HiNazM/6qwUt+ZRsy53Hcf7hTQ35w853bsDFt?=
 =?us-ascii?Q?AxfcpGXRaz27x64wCeLGUZo8ffQpXZIx3JCc7fQJ87U0rQHgV7dID2TJXqjb?=
 =?us-ascii?Q?4cSmka+uG19AKW2wn+KkGxOIgj2iP9pCtUizK9lBS9Q3YcL/vEodlUKsMDbe?=
 =?us-ascii?Q?LcDpux5LiE1mN2QNfMkg0hi5fJXThQQ51F29a+qLxF9NT5uWKhsYeTGFNc1N?=
 =?us-ascii?Q?AcNGCWTucjfd43awVEQRkTZOhGtgCtAOU2MlhVuBKw/J94CZfueGjU7V3/8+?=
 =?us-ascii?Q?O/ciCXlk/jCaZKs67lW8Te/CkjVlWSd98w+UZvyEl7nwgpcip0kH9AIFLTQX?=
 =?us-ascii?Q?SuVRAhczllV14NraGqp9kEGcyN23EU8jrQbUrsTbeLkOlBHnzoz4lwgFbeLD?=
 =?us-ascii?Q?U9jCA1c/rrzyrxP3+6O/HQB+fWvYvBEmQk86QWd6HMAFBOOGIsPHgXwgSiwP?=
 =?us-ascii?Q?7hr4DBlIP/itkn5G7G+5hFw6A0ay0WtYJQIMhbQQmOFbhhy/DO+uGv9AbQoN?=
 =?us-ascii?Q?HXclMi1I25Z2AUzeWSljKezE+rHoa6CFaSnhPPJujAmpp52GMeww5Bvt9JMM?=
 =?us-ascii?Q?YNgdHU6huOw+AOOEEEPbYiaOeLH0WbM6CrdvGkehXFU7coGIjb7shNqbRB7J?=
 =?us-ascii?Q?9/4soNFdE3opd1rRiHqvq0RNk7FKMQDUEzvtBmfBwC/uyRRVdhuL8ynUYu4A?=
 =?us-ascii?Q?Csf8mzaiX3RW/1582M5EV+KkgJbYAQJSFQcesgGEF1RdltECzKfJnCVzKF7J?=
 =?us-ascii?Q?pRoLj4J1nHEywUOkPctG6e+Wj9415GDaUfMX4Azy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zNJ5tezchrTcwZcjgbRIqJtFsb3zfBk3NkZJ0LqufmYGyeTdD/GYtfmK1d+Ht3tU6hsViRME+Nsq/L23HliTPOz0VkYiosRh2D05YySJuEb64wTLryCArUJqY14VevT+oxoCcr1qlh9tmMoasMINs8NKGdibK1A6t691D2uaqbctg6Cby3zQL7e3fqRPAXMQCb+ObeNsm38ZO3OWl3ueCgGxPdv0a0k/rOZ3F8iqF16/bqSb3He9W/nksNvmK9doOelmBfBHsSUHIKWDE4mG7rWyNO00v82+t4923pHfx80bGNMmk2dtR2vwZcy8xjQ4CYQIL705gsGtOyilJXU/8oIy40+xPb7++GUBVLnzE7Ra8axLWWMvHBCSk9QvRPT48996UD3PNJoSWtpjnUEvlYegvMwhIvGFdXKsQ/JiQ660Sn73SoNawFcxctVyYKkFfIU21u3+lVIyPV9Z2HZ+AjeAjAI1hWpV89a46oZAcXKwcqnngXfAUuBr7ns3hS5JYEYAB+cJSDp1k4bcOh6aBCxyy6F6fv8Id6q14/ZAVEDS0u3Lo5zSw2FkNL6nAqeInNQdBXhAn8IRUYy9f9bbxWazegkr/l9IU9qQlkRFtFnbJHAQca4USkQoIj0/RdsK
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR20MB6609.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ef855b-9fde-458e-8405-08dbfffc07c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 19:03:32.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RV/l4SxsBSSiTUHhUSfOZcTiTNwX0akQyDTQYf/i0J1ER5k7JnEUS9GmxXJNyvYKYVcVMhdoux4oQx0e7VdsSRQ8MbESYRmZjxltvhC5Cuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR20MB6716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_110341_145652_AE4CF886 
X-CRM114-Status: GOOD (  12.86  )
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


To prevent enabling more than one passthrough subsystem per NVMe=20
controller, passthru.c maintains an xarray indexed by cntlid values.
Passthrough for a given nvmet subsystem cannot be enabled by configfs
if the subsystem's passthru_ctrl->cntlid value is already accounted
for in the xarray.=20

However, according to the NVMe spec (rev 2.0c, p.145), "The Controller
ID (CNTLID) value returned in the Identify Controller data structure=20
may be used to uniquely identify a controller within an NVM subsystem,"
meaning that cntlid values are not guaranteed to be globally unique=20
across multiple subsystems. Instead, the cntlid only uniquely=20
identifies multiple controllers _within_ a subsystem.=20

As a result, multiple unique & valid NVMe targets can be blocked from=20
enabling passthrough at the same time if their controllers share cntlid
values, a behavior allowed by the spec. Fix this by indexing the xarray=20
with passthru_ctrl->instance values, which are allocated per=20
controller by IDA and thus should be truly unique.
=20
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Evan Burgess <evan.burgess@seagate.com>
---
 drivers/nvme/target/passthru.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.=
c
index 9fe07d7efa96..f2d963e1fe94 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -602,7 +602,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *sub=
sys)
 		goto out_put_file;
 	}
=20
-	old =3D xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
+	old =3D xa_cmpxchg(&passthru_subsystems, ctrl->instance, NULL,
 			 subsys, GFP_KERNEL);
 	if (xa_is_err(old)) {
 		ret =3D xa_err(old);
@@ -635,7 +635,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *sub=
sys)
 static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 	if (subsys->passthru_ctrl) {
-		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
+		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->instance);
 		module_put(subsys->passthru_ctrl->ops->module);
 		nvme_put_ctrl(subsys->passthru_ctrl);
 	}
--=20
2.34.1

