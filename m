Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7EFC61DA4
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Feb 2023 05:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=drvdaDvH4ja0s0OFxoErfnvKnideY+vuI4EHaRWqYgU=; b=ZJ+TpZzrtLRhPnCNvYTKUrEG95
	laWuw4th/DQNCd7BxQV3zLwSXwz6xZYpFZRq+u8TOAxzSiUeCXvyAb6s7uBLrNnw+aQlXGG2tmq7d
	RHnNSfORGLWH/fmatJc4ZEXnUXQeXKs0EXxTDDMVKd7r+1wrow7KEovCPrH5H4WMS10eawRWFuPLZ
	SfLTEvHyZ7WoFeoH2lmkjdsfcJ3Jb7I+a5i9C+jq+esvSIKR6uEsSGBuEIxUsGSKj8IrglAXm3PRg
	hW0jtP+WXM+k7OhRXey94rvX8vm/Q537NkUvtxi5mA5V3P7xR/goXyhjHeYLs0mpI28Yio+arLR2z
	9ee+Zb/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQiW7-008jZh-As; Sat, 11 Feb 2023 05:33:43 +0000
Received: from mail-cusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c111::3] helo=DM5PR00CU002-vft-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQiW4-008jZM-HU
	for linux-nvme@lists.infradead.org; Sat, 11 Feb 2023 05:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCfobt6QcwbVEAYhqoGYfop7n+pTezKPycYDJ3Ju6SSPe5SCTUFcBct8QaiO+IJn30kzpzxFIj24GasxBnM+YBu4SmgZCYyJ6+TqD9nKW/xm82Im91cYFVl2eOziC75qF29A7Oh2Tx3k3vk79zQjTtbpFmD6u4Bda+h9IfTLbGL76dhGnxT9yFXNAPiF6FHRBm4B3UXJUeNCCnI7rlk0l/55rklRcsqpk1fqAS7VXCJ1ghNfSFRsZoNFUHfGGceznFG5/W8unQnXx3VUu90oY28e9RSh3QoEUuGAyfWnrJkboSDtg+wNRHQG5J0RH2A7D/BANrOaJUG3XuRCx3R9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drvdaDvH4ja0s0OFxoErfnvKnideY+vuI4EHaRWqYgU=;
 b=Cp+XGFJThg39PX7G2Io6PudlsAxTrohNa4S3EbVI7a2ntUoUWyhEsB4I1rN5V2KaY4OCJfh0rCe1AFUroOxR4qnNzbh4LBZWoBz4ul6cyiS3WS9I+jDONsorO2GdNvvngxVwIBE+WnwXbZQ6tN73e4dietkA0BloLCyzr9f/qK89QIkHikpqJVrvu627Spz6amXS4XWOOXFJZpSPvfYYGUP/mqef5CH4MItjRrADM2b+3zeSDWp1TCPGA44SVWRsKrvHoxXYLmSD1tEEiOIakDwO82nRQvGJFeyx3T54C5fChRUTJ6ABzsJqiqSvLs68gSYdCvNZqhe+Za3ZvtqG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drvdaDvH4ja0s0OFxoErfnvKnideY+vuI4EHaRWqYgU=;
 b=HLhA78qEfbhoekvZ73oHY9fZIT+pNcIdzlR5WCjuv93EdorGuiNdy9Z6dCyaljIxhv/nRLxkjhmmVLwb05+3Ck6a82nJrLSxG2sHSLs+hH+oS29GAP3eGTwPCOpnOHtuHgtC7FmlIxhOGd9r6luK+xc3FGQfcInA/s1lIVotoMg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3782.namprd21.prod.outlook.com (2603:10b6:8:a0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.2; Sat, 11 Feb 2023 05:33:35 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.007; Sat, 11 Feb 2023
 05:33:34 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: max_hw_sectors error caused by recent NVMe driver commit
Thread-Topic: max_hw_sectors error caused by recent NVMe driver commit
Thread-Index: Adk91saIeniTqD2RReK/0l1vmobdkg==
Date: Sat, 11 Feb 2023 05:33:33 +0000
Message-ID:  <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b45d5d5-515a-417f-a740-db0ed56a2681;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-11T05:05:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3782:EE_
x-ms-office365-filtering-correlation-id: 393bd70c-d252-4a8e-4737-08db0bf18445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  VEaXqko0D6T7igLxMGC93gX03mHDD499d3rKUYNSQ2xCjX6x6kFs6Ce7FWkrdMDTVee+o9Dv2OJk8HmjfEzCy6W6XAm1rdj8pX08WOobFkr/NbQbrrjXMErjKDqxhOTIDA0OUdniIyQgdTuWt1Atnzk2t5DQ+sBULjvVnvmqKNI7lycfPmIY2Rw+DNRXrPMFTLaCR0NElDF66CRmzk3P6f7D5S5y4kRjL8lNJgnRJonOTeGXkHlZlxixOYObVcx6rA7q+pszH4g8caY3aczs5EXt08RGKoXAT0Su54BLpwKQ2sHlELipOHuqfUWqtDOjM33oPSdwPXJHxoewO2ajIsybXbYj6c0A8QAnm05Ry1h18ZHIaBcbqHy14xabVcXTl2gStZJ2keQ0x07sJvRpcBoEEHVSOolIQc/Dl/AOMmmCUiwcPyAvBJLp+kCvERqgxnxXCHWLR9W72jMHk67VJ+8VdmQreQZoZlR93kXvtdWR7Io33+wL9vTl+udvmkLKYfLOcpR9mDgIFTBuZG+5uGaI5VHZPExQ1MN+aEiTXGdQVkOCAhaj9yzRbHunSf9jfjebA8HFCrtv/nF1AKjunwWmmyu4xyPQ0/TvPBbDVDPbsB/z3Lww3f3g9jNTXBBIk573HhygxzI/dKpCKowbN7gXNgDJtOFuzmeNmHs9UVyqqbuOn6W65virJWpoG9cbkefAMeQ9lFSJt7MI/9iXUqRKvMJWWjRU/JSgn5Ijrn3uL+rw+h54+eExaIW8vivA
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(122000001)(82960400001)(82950400001)(38100700002)(8936002)(8990500004)(9686003)(186003)(52536014)(5660300002)(10290500003)(38070700005)(4326008)(71200400001)(55016003)(33656002)(66946007)(76116006)(64756008)(66556008)(316002)(8676002)(7696005)(66446008)(66476007)(86362001)(110136005)(54906003)(478600001)(6506007)(2906002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?h6QOo8klny0zPkJZcE477Z8j8FtHwWO/3Xk0BdyqFQLVV/XuZTz4UCyPZdOV?=
 =?us-ascii?Q?2c5LqQny0BHM+qF8YgqIJuUyk2DHcq3BDXmi6p3YfAYLUAGLSQIpcLuZ3j0E?=
 =?us-ascii?Q?/FcPoaulR3SFJkW3FjH6PpNdbor8sCwsPofsQPxEr/vkyQrD4EOlKfZ82enj?=
 =?us-ascii?Q?GYYjEjzt+kH88EyFa1lkyiGvbOoBvZ7M4KhROWM83S33ydJORWF+s4F0Ka2s?=
 =?us-ascii?Q?r8GEMhPG2LYhJG2VBGbiURH4qwE4KXDUvFV56SffcaGgqTyo7vL+oBdK18iZ?=
 =?us-ascii?Q?NRjqwfKsGPcuqNYNeSgvavAl9jzVbps0TtpxpDDxdKRgfGVNyhoGpNVqoqtT?=
 =?us-ascii?Q?QuJ/yU9/I6Vg98JETo1HrKVRAFX8mHlA/IA9ne1d7MQFp+dbyTC5Mv4HH9vt?=
 =?us-ascii?Q?2FPuRvUoe1Dd6QZ5mIqnEG7Q5pOtF7IrIFjpk3oXTzRQvgdsO18cx2pKSJVA?=
 =?us-ascii?Q?rYDQd9J9C7BYTMjtSS/iNnMmkMkO4BKEsUc5FXv3SbP0K8WQeY8wZj5qkaT9?=
 =?us-ascii?Q?rxNoQ0dgaLDg00fRuLOZcxnTngctfrGVD1Odsuhncj9v8ijiFL/FwrUiWBqp?=
 =?us-ascii?Q?IoSRLEX9KOYWvYAs8QkYxuLYWW0UJR3vo5Ir5ory0mwjmz0EnO5aLblk2umd?=
 =?us-ascii?Q?EbA0KAMBDfbb9giqaWTTqKAJ6SKxtlEZK3L7ZxKvNuT20vWHsLyVozj2iFBZ?=
 =?us-ascii?Q?TRN0tlEervR15W6CGc5GJkYvrPGBocUicuCzoua2MbE9Kcr6ONmK3k988oZ4?=
 =?us-ascii?Q?9VWAkqih+8u0N41ScOkKWoZpjZWX3do4XT2n4yT9YklJbKUt4pT2Ow/WL2jk?=
 =?us-ascii?Q?hIK/cEIt4y825lV2eyFJSmYyWM7a5NoVXA882B8cYT91abn0Z6Z/a6NYHJz8?=
 =?us-ascii?Q?PmzvVo5QayHn+JrDklOcbn1tBdXqjfeiyX0aY8Nwuivn5jTVgRlr+tlWkRja?=
 =?us-ascii?Q?6neg7VfMV4XxPywCsckZ8L3nkF1NhsEgF7hnBg9JbBUaX4gQab8R8nEqH2xc?=
 =?us-ascii?Q?fxF/J2nHWMbko2OyaKG+ag+foQU6is9utxZbrh4zuDaWfCIN1bCs0bCC1VkN?=
 =?us-ascii?Q?If4bAUuxTIfvlo0d9vZIA8Kj1zwkbswloeefzK8qMZM6NFluMHX1X7BV9ytj?=
 =?us-ascii?Q?cYvJo3NWYoUfS9OJ2+UxDsGOhRqM3EBA5m5Y5/mv4nJNApvuzoUKZMFcVf8Y?=
 =?us-ascii?Q?Oupzx3HU2sHefcSZDlepKQolMmOjOlwTb3okaAAoHI3fv8LjnSocElXLqJV5?=
 =?us-ascii?Q?Y/6UfOSLBWAIau7bb00RheAokUeuoBpDNwR3jxZMWfMFa3Orw7afIl4yJdZ6?=
 =?us-ascii?Q?jejflVsR5DttzfILP6dvoSHFRRGBmCFYeUc5umEDYrwtc3Nxa1Pe/eIEpeAh?=
 =?us-ascii?Q?BkE2aP9q2unmqNH7vNQWilup+RWybwIViy9R76JSpdXPG2PF4o3Ige3sRAjK?=
 =?us-ascii?Q?PVrNkIMUBD8EN9oM1L2HwiSAS0o3DHHcMqynWU5kFphhgw8ggMwyVEm2ho3w?=
 =?us-ascii?Q?xpnvSZUXc0YQhlBWtfG91p00KR2A0pG+dshZyFqJCiUBWsBmozJX14TqxQwV?=
 =?us-ascii?Q?tSOM8D5JzKUUeyRayOm15yxpltYCcOMsD5VGZocINxh1D3cSGDeDhRlhalQg?=
 =?us-ascii?Q?2YiWCZy2pd76Kv/mOIzKNG6pJrWgeXyXQVOYDLMyk/vB69MX65XrUGjLXZ8A?=
 =?us-ascii?Q?oTK/Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393bd70c-d252-4a8e-4737-08db0bf18445
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 05:33:33.6745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzQ9z34HmgOARN1tRyGOQFmSCLnEo6JFrztpP/neNubvlTLUJTgBu7+GODKQ7DUeqZBUxs6wQpt0iQyTIHaoz8IY0fZQ3+TQKpiAM6iwHM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3782
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_213340_822859_F374E861 
X-CRM114-Status: GOOD (  10.30  )
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

Commit 3f30a79c2e2c ("nvme-pci: set constant paramters in nvme_pci_alloc_ct=
rl")
appears to have introduced an error in how max_hw_sectors is calculated.  T=
he
value of max_hw_sectors is based on dma_max_mapping_size(), which indirectl=
y
uses dma_addressing_limited() to decide if swiotlb_max_mapping_size() shoul=
d
be used.

In this commit, setting max_hw_sectors is moved to nvme_pci_alloc_dev().
But dma_addressing_limited() depends on the dev->dma_mask, which hasn't
been set.  dma_addressing_limited() returns "true", and the swiotlb max map=
ping
size is used, limiting NVMe transfers to 504 sectors (252 Kbytes).

Prior to this commit, max_hw_sectors isn't set until after the call to
dma_set_mask_and_coherent() in nvme_pci_enable(), as called from
nvme_reset_work().   max_hw_sectors is correctly determined based on
values reported by the NVMe controller.

I haven't provided a fix because I'm not that familiar with the overall str=
ucture
of the code and the intent of the code reorganization.  I'm not sure if set=
ting
the DMA mask should be moved earlier, or setting max_hw_sectors should
be moved back to its original location.

Michael



