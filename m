Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAD2C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Apr 2022 03:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+GTieu+Df+e+v/vxZ/G96FEwRSu2fJrBs/17H7adlT4=; b=dBIRSuIQV00ChZ
	HJgySq8iFGGeu884ZposuK3fGWmk8+tdBILXCzPDAYO0TSz5b2uQV7qDHpvzkWKHmOJWpWvXZ0CgK
	rum5RSyBAQ+NauL3VWOS5mpwE4+vj8I81TH01UIidrPls7LTmfvEzmW7qhALPecZQksbHJoaPhh6V
	cVHc2pwiptKaB4ZCLwT37lXT6bJGO2E9GWbtA9HzERPXSm1bFmNMsGnymUuBVAaIMAIFzgXKFZCNR
	l7S6SLuGC7FTwGawnUHVyugvjnTGnUj4rY6DECGjXm6R+ovXbLEgTE/IiATtg5+R2i2EC1pv5nkrn
	7BRI1PxjsH3ylR0bZCkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neqGb-003jyj-LW; Thu, 14 Apr 2022 03:35:33 +0000
Received: from mail-mw2nam10on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::60c]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neqGY-003jxu-BS
 for linux-nvme@lists.infradead.org; Thu, 14 Apr 2022 03:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4HT0RkN5/F4gNMSCTU6JWgDtipK3XbGPh+qq3MyGVK/3u6cY/YLk5RMZssi5mvvvyGfbrV8DYIQpQbJb1rpD4q709KiPK7jdmGpNm/QHu//R7utD9rk0h9zgAauZHLqjGR1dwX6bTNajuMZ1H2HLQjFQT8y06abynfLfgyNpJNQg+7PXvBQozMpFiOr0CK9vlj1dlFC57tHAs82quobrt5W4sSstTamR2CdVS7J50bzUgiETMce4QgTxZWGQlZNNw1VZ9AQiGAxK8v77mGDosGR3BeJIlZXSvYun8tKIvWnphBd/mSuq9oSsvAvvS3Fe688BHGg3Nfyjz79jroi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GTieu+Df+e+v/vxZ/G96FEwRSu2fJrBs/17H7adlT4=;
 b=JVLUZFUrQahhsBS302QiJh2sWGemYSd3LscOF5xp+oVCEXrRomdH9LQrmtmZ3nA3cyqLGSwkC4BAehOmC9VGrDaP/oLzmHK44pc4ptKtaij6y7DYXg4iFPDdZhK8H+XStWvjPF8wCFX3ayAAEDO2YuDOAsOKCTWwM7obbYLJ4fMhL1cHsJM7u56PqhUymp/X5kjndV4EEq2lXWOER7jcJm8dK4I+1oC3m/JTwpW/wSoEKBv11kV+DWWVbFNT0e3RBZ0OZVcVxcVpAwQxk2a47ttnx6k4e7bV47zS8TqkUzzd4YAaiKbPufepJ0QF0MpPu6p9RXPGa0Z1MjTcAEkH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GTieu+Df+e+v/vxZ/G96FEwRSu2fJrBs/17H7adlT4=;
 b=33tQiOod2UJ5GelulmdIci6zARF9ab0sdWHo+u3MCfT/PFAp9Naum478YG4JBHrt5HghGRb2GLopO7Q7v8IzkCIQtRh70zY+optXHRJ+segxuR11LiM9cfpGcctlkU5F4nHL/eqEj/9Va8h8HWYaZaP44jWNYUB7W4pw6twUfiw=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR1201MB2553.namprd12.prod.outlook.com (2603:10b6:3:eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 03:35:26 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603%7]) with mapi id 15.20.5164.018; Thu, 14 Apr 2022
 03:35:26 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: New NVME errors in 5.18-rc2
Thread-Topic: New NVME errors in 5.18-rc2
Thread-Index: AdhPr+oKchgQzq9oToOhaf9oWWv/bA==
Date: Thu, 14 Apr 2022 03:35:26 +0000
Message-ID: <BL1PR12MB5157B98D6A245A76ECA5F17EE2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-14T03:35:20Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=817e8551-d6ed-427a-b5c2-3ca885b5ece8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-14T03:35:24Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1ec67d1f-1ae0-4340-918f-c1b15fddc35b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ab11791-31a4-4feb-4b78-08da1dc7d0b2
x-ms-traffictypediagnostic: DM5PR1201MB2553:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB255366B4DF40625E0CEA90BFE2EF9@DM5PR1201MB2553.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zLEVY4deNtTlngq8GBrFI1Zio+G7OresI8f+zbipdAjRtVZg2s5j/GToiwprY3/YMX1DAKXNenEhv4kDinKhWpEQc1X0CBXqJo7dp6+Cv2z+DyTb+rx38MMhceUsT0i8HAWAooPtlnlTebCjKKKM0c/9q1CPMtSd6oy/7xsz0Shs00elbMqPQqJPIEI4Id15X09O67GhxNGzJEzztDvgzYNwUnT8e6ffHy+GZa+iTAntDBxkifcK88Dgm2oCXYEd7wDWSuUQcZ7of+ibj3XvblcPChxMa0Q8INEB43Ds4a8dC41sicxhTI2fDI0rMnJJXvYCn0KcrJXzplcGrHs64eYKJKkyNmQBrPJjIJE/wtmvZvlDzD+Y2EQUFhnnTrXLwDpDcRso0rJjIQsztHh+xks4Kmes8RgChepmqaSZ8mxYMCpVRfHzhI4sVzZIZpgWADkqPUt/t4npDaem+nQkYO8ogZPeGaSXwzBTs2anYo6cOf3q+P77QJ4x/SyrrZmFv05IJbBkv4OrY5bysDHffjrDZ7/xuLc485/syX7x3sCvi984LBHe55wm6zwM5K+JIzipI8A+hg/8VLeC6gJslK/LcNfu/9ylA49krEOSoCxySlZSzutI6XJ2XsKprS3s9rR0ddjVQklRK/rgT5A1ej8lqRvBpE552WJyC3a9SLNNdL6upSmO4OAicfIKBUmvNJcX7acBCiWkTvX9HESEkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66446008)(8676002)(66556008)(64756008)(66476007)(38100700002)(5660300002)(8936002)(186003)(55016003)(52536014)(76116006)(66946007)(83380400001)(4744005)(9686003)(122000001)(38070700005)(33656002)(6506007)(2906002)(7696005)(6916009)(316002)(71200400001)(86362001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DMgzxxaBOPYsRcTxT1B4C6jrXmEz1nbFGcuNIS1hpqpHfVUv6xNhDcilQ+cZ?=
 =?us-ascii?Q?NMhVv44Zi20klq8dlAc1s2GuebDpUvVZOdxyEhADv2KPuGKHKP5jN2ej2oBx?=
 =?us-ascii?Q?Bt8qSCwinpWls2kj/9rlVc+PHGQb1unIGzsfUATNUWWfx+3DmeVD866cIXbh?=
 =?us-ascii?Q?z+E90IcuOPlRkRersgVIWprwSbM4ff/yWIDPEo5d7m9q4fld3oQ/MCmnREgg?=
 =?us-ascii?Q?DMKQ/kw5livL7k1WBElhren2Z6K7mNwgkn1tDa5lNXMaDXq69PehUw71kY59?=
 =?us-ascii?Q?J8G1dhQZHO4nWrEbmzwk6qFD1a7agibT0y9sKEHI0ClhazRb6z2x5xcXgwrO?=
 =?us-ascii?Q?Bg75ouQM7pDk34GrMbRsE07di8VfnNANBKNkmQeq16iiEQypuf9Vsy1Uiol9?=
 =?us-ascii?Q?YiFUbBD/ONZG179SmQ30efm+SFr2tExsB4r+FiuVB5Ror7y6h2ohwGcsr81c?=
 =?us-ascii?Q?ZfcvSbPqjDJqWZHsJIG+uk+4SS5Ok0id21FLw8Rsk9MxBXvqGz5zRsJyNgrr?=
 =?us-ascii?Q?ISVCxQmfVohp5/Y8o7wtOAwQCu1PSLSAg6s+v0GSR9pEk3iTteP3oLe2CNGH?=
 =?us-ascii?Q?ctMMrsvkNrhtq8ntlpshrE6T0lsVgnD0mA07llP8EFnn39StYbIekOc0RjRo?=
 =?us-ascii?Q?O+dkFJSIM07dq9EEZMWEyQw1ihJauDh7w/SG7pGgwFMYrfSRqHkr8XUzYKjo?=
 =?us-ascii?Q?Q9FxHIe+fjFiQGeLoqP+GHJ7l9gusaPdbfAja3p1XNz+zU723w5cTaMQp2OW?=
 =?us-ascii?Q?u48V/HO72ztq/6lDAD+ViGi4DwvAndpZTPQ573tHvtbsPozP4Q74JGbwc862?=
 =?us-ascii?Q?o4KmX5G9ZddlAQFUt4G0FpmNZlE+Jfx4FUHmSt+bN6kUF89HcSHAI8aZI2Hg?=
 =?us-ascii?Q?jSYu9mRp/EJWfubXxTjzvVqY5EkZKMwN57xIOWia30vrCL07d5z/X70xQZHB?=
 =?us-ascii?Q?Zk3p0A7og2I6X+eCQ+44IW0HwYMaANwN07qDrq1+CUqjkhxl0iT4eQYadkTN?=
 =?us-ascii?Q?bLlEXPF23+h6/+g5VaU/b648GjwqJHX0yZuZaObTRD8DTuBX7zRVzQg6EheR?=
 =?us-ascii?Q?JXDOIXfGEEF2cOXEfKlqp5Ea4Bg3VLW8ZLxf5KLEw/VORakHatJc1geldija?=
 =?us-ascii?Q?cAMwyBo5pvaRksTQXEcx6jcm5pFJZtqdVKjK6hBetNaKDRHJMbVz6qcluuWv?=
 =?us-ascii?Q?OS0OdsxNALuRllbhzaO0OCe8yUXkpHTvMIa/TG8niPQWBAoq+8SFD+likDw5?=
 =?us-ascii?Q?GSXi4Dp1EizAneRulipVzlmeJOo3CfLLCZ9sHNnaIaPyN9b3oYSIPDiHTeXI?=
 =?us-ascii?Q?7Gdr+Xm+i09Ug5afP0Y8FPhwwNJvR2gqxxXxoZzBAVFuJetEivR3313bGIN4?=
 =?us-ascii?Q?nwWYAdsEVWE19Ngw/iOk7SprcUzHuqxTO9iOheID2WjRPWZmYursVrDG+68N?=
 =?us-ascii?Q?HrBREn4T5u5VCYRKNEc8zbo57bYwahWwUPWjITTxFwaScc5sRDHUdL8AtEVp?=
 =?us-ascii?Q?2DJ/CJJwjvpiXZUH2tYkrhVY39TzUAG/wxDPB+8V5rgDrxkHhK2n6G25xCif?=
 =?us-ascii?Q?1fipsJI+iobDbfbGUnmJA48I7cXwRF9ooQzyds27d2PodCGRYLdu2AMH6Rl6?=
 =?us-ascii?Q?p9My5QgrPAvtcIUCTksO/AZcJfngqJC8KyTun9cO4awXcLo/ZqsikOwAfJjM?=
 =?us-ascii?Q?8J0QHtyflIxkl+SmsLq3m0r235FSQJgyIaa/fXisiehNpAyZ6V2OfwvCMXnE?=
 =?us-ascii?Q?jYGkPZdyEJDlDzzeJpVyu8/wHMpfXZw3XaE1GuTO60gbh9fNnSgrEd4QxRWs?=
x-ms-exchange-antispam-messagedata-1: w6Y0NLf7SGJWxw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab11791-31a4-4feb-4b78-08da1dc7d0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 03:35:26.2296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3YWIJuwjo1th8knCIpZ0FiPbYaw6+lm/Jcpt+ax/FddHZ89rNC+YfmQO4jyyKLtsYrZKZxc0Qko3VFI6EZGdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2553
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_203530_530884_DB463223 
X-CRM114-Status: UNSURE (   6.25  )
X-CRM114-Notice: Please train this message.
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

[Public]

Hi,

5.18 appears to have introduced some extra logging from commit bd83fe6f2cd2=
133beaac7c423fd36c3515048fc8.

Without CONFIG_NVME_VERBOSE_ERRORS I noticed that I was seeing this message=
 on every boot up at level err:
nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE

So I recompiled with CONFIG_NVME_VERBOSE_ERRORS and it's specifically on ev=
ery bootup:
nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE

Is this to be expected?=

