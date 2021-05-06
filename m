Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D243C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 03:09:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF9B610A5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 03:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF9B610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HHYGWCWaDQQKmVHEIznskeZhr48rzhA0Q/3iVE8NmC8=; b=il8kM3zKRUHyAFJFGT92RY9Gz
	bmmXYe9qTPrc1sfHGCVxyV7VVry2RVyA5KbgON/fYZlhKHy7Bs/ziQ5iUbyEidwxS27JCV3OyF7Ff
	QSjwgwAiBKNjfXvLD3RzX1BUwddOE2h1f+8IPWtk0VS4BzkqzcV/bHGoJEYjTA4J2hUbcdrk0CYxY
	LinPpN0+iJgOEQRKCrpwsUT0M8iDUCQ1WENtkeT43NoHM7BCtaYn97akP6RGro1jKSMDRBJd8sJsd
	Dja5hTNoBKp8T3UvfyPhmkiVBBAl1NJKeJSd0FJpDiVvzRvaLRr6f9CliJKf4UO5rBd7aYBgoyCv7
	CZ8hPhqvw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leUNQ-002yNV-Pk; Thu, 06 May 2021 03:08:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leUNI-002yLj-U5
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 03:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=b0CS4BLs7N3cjpNLWTP5qPUXmjchP3eL7E3rN09tIbE=; b=Vg0u2NL0EmoN+hfJXclcaqbEw7
 MguKoNsTPdg0+3cB673vonbmcyat8Umelo6cPfWNOXiGyBIHadTdefj3kFY0833tcWOD4bEAZJseM
 ajzPYApJLrPbt2jOuVp0C2fZcNYljIWo4tX/dbCGeFEp92YakCDkDFpNaDmt8pKWuk7WPjMzkCkYp
 lMtbwBt1H6pb+rZibiS/1qpvP7NGYqTYFqVtpazIbk6ncM5B8009yJX8hnp6PSkMn1EtOzbPhH2Pr
 OdHQAuOr0RyATu7xiBixF8GfzmPsxSO0R1fxZTkvv6jkSndFyr4v1E0PEuXwBVReowqgxsdrJmu2V
 Yx6Bbvrg==;
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com
 ([40.107.236.74] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leUNF-005XY3-N8
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 03:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwkeduaOg9eFOoMpypu2toisHhy2vGfv/tqiPv2/JaWsZDAkHROkBmZJn6FIqfy0alAGjqv7u6wGdFKpPdPvtQEDxLGGvSu1AIOB70HsiFZlWvpgB0vdOvDTzBpAHj7vupbYybZ7bKU2o7SJoUgl1W4AB8AlWrPP8vPLTHt22znSlTx/hbCl2L3KYv6MZkkyWWAK/QUayeCe0NXZO47VO3bHPiFi9Epbderu7CZPOGOWBYoPJxTEWAU0dPJFS17uxZlJZZq49ItCmUKrEytxEfvVxgDlUCz4BVvCMOyAnuywSa6pp4NxWj9a6R0gMj1UNMEqPAZWKV1/VBuWQdQbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0CS4BLs7N3cjpNLWTP5qPUXmjchP3eL7E3rN09tIbE=;
 b=RWeQDEvy2+UVNxaTAK9cT0lgwS1Zz1L/HlJi4q2qkMQgoWzzD6RehdHVD3nP6u/8168eJ4nZTEzYKPC8oQvJcHzSNZhqcZrjOv6FfTtGvpqNW8waqq6C/F4wqkrY7ORp6YVTXsB0Jw/+n3/Trk0J5IceIx7UhIlYCj4AKlnsq7RsFRnSWeQXaoHE1HGTyBFbbg6ZbeQmupyrdnWBJlWHefSLeLasg9M9bGkSWAZuQf1T42Te7uXd5BsEnzN9rTQIsv2gPOSVqV/Ao0If4hcr8WrLVZp7tl0yxFjJ4gv0XYFjRkMj8Iwbkog0QPQZSZPG91MgtpnEhBRPUS/ByAuSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0CS4BLs7N3cjpNLWTP5qPUXmjchP3eL7E3rN09tIbE=;
 b=1L2nxfB6rojxMnmyEklmjgp14f4fTw7GEeYHOssd92fxwwNahzozNKXgBxruZCgzeCR7uznH38xuJcodQKkJ0feYO04By1cErLc94NaO511NIP0HNixEpw0CQ//1zkgiJmJAZR0IM52v0mNdWlF1AM36BVyes+d0LIdvc6oHnzs=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 03:08:21 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7%7]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 03:08:21 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@infradead.org"
 <hch@infradead.org>, "Chaitanya.Kulkarni@wdc.com"
 <Chaitanya.Kulkarni@wdc.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, "rjw@rjwysocki.net"
 <rjw@rjwysocki.net>
Subject: RE: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Topic: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Index: AQHXNxWH1Fw7MhW0Jk+r7qWA/iB7larV2E7A
Date: Thu, 6 May 2021 03:08:21 +0000
Message-ID: <BYAPR12MB32380567348D5E7C7921C218FB589@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1619054346-4566-1-git-send-email-Prike.Liang@amd.com>
 <1619054346-4566-2-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1619054346-4566-2-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0d4e7755-f8fa-42c9-9639-90b79b0773f0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-06T02:55:20Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56f5ee11-b6b3-4391-4cad-08d9103c3483
x-ms-traffictypediagnostic: BYAPR12MB3560:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3560B71828B0E514856E0E83FB589@BYAPR12MB3560.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XFwWw56yS6TGojX1WykZYDbTkQV4Ph7Ccv/uwTDnqfjjGAo8nRrz7nssfUgHdPUu642dqQJ6iolc6xotUEjkgquUqjQ+k7SpPlmwlkMc/Q0Cqqut31hM1uW9l4ATMLCZjlWIFKMFfz5SA4uEfOZsk+O5RUw9L/hQviItgSe/n2BcnXOYtHPGTu3EAQmqshZBJTD595JQQe0I4yLUOLdt/YEgZlmvntJ1OrJjHqPaDv3qaaklCoeECS0zLbKfAuA/l7dQKKp4vD6xAEorI8tmpivkFVkPYJcEZV5nKG7nRNz6kgqfGymk+GOR90fSQx4/vO02Xu6LdxyAb/iOXdoehuFy7OmcKZzK5V9MKDDmj+DykG4lQqdXLg4lTh0N1bB3uMuJa4BzpECy8BQ4D35o5J1DwYQEFIC+hRXMLsC4Yg9LDaqG9sCW+zeT6YLb/UOzofhtkKVrFlMHYvgXrBehvFn1/fAfKDKi229kwk4R8KSiouqDp0rAaTHjQMPkBfEqafX8BxG4WWG08aW3csHIIeqiZ4vv8RPvc856SBkF08CANsXWa9BrG1IH/dCS7Mi0O28wm5/MqeSGunPFzsWV/fL0s/2tUlPbX6X3RlyxYkU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(122000001)(66556008)(64756008)(4326008)(26005)(110136005)(52536014)(83380400001)(71200400001)(478600001)(66946007)(54906003)(9686003)(76116006)(6506007)(7696005)(33656002)(316002)(66476007)(8936002)(53546011)(38100700002)(55016002)(8676002)(86362001)(186003)(66446008)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vp+Rn5fuTJc10xSa3e9znUMimnrWAivFe0VsjiFlfcNwbDqNDTelzlyTw690?=
 =?us-ascii?Q?qn86rSyPLIQEjwpO6MfymQWwbh7WS9HwhIbzFC149wAiS1Y5jXGz4+ghe0vX?=
 =?us-ascii?Q?jRBNdLyLFa1henC++H04sCNF6V6jRf8432pYjFiIYg7Vbgq155pdw8zv6ayT?=
 =?us-ascii?Q?CG6gPQCiUsWFbxsUJpfPIE2Cg0SJXP6U2CrdLZlk9OglwWLqkMwgia9bsQ+9?=
 =?us-ascii?Q?5Mll8Muc+/WKzzd17EDjjvS55eHATuY4jthg8LNrOL96FfHsB7l0ggRHpahk?=
 =?us-ascii?Q?KH5f63LVi8nwsv1xJpbucT7RCyaqvw5ibYZgsp+gPUjM77hdFCxrBbQuHRjl?=
 =?us-ascii?Q?DNIm/ldwdJ5rbT9CEddkqNpLXLMC/Ec568cmssqZ1oXpxeeFd4V7cS8W2ZGG?=
 =?us-ascii?Q?TkAulF7L+yjNhv2BgFeSL0P444bp3I+mmmNBDxWVVbuh1O9KjNpIdVc/y9Sf?=
 =?us-ascii?Q?vzvIl5DStuw3dDfhb/LeemrapTG59NniJPNfzt/EJfGtsrsnCrbKY7HEPCcX?=
 =?us-ascii?Q?Y3GauT9pTv3NaHgSKSCwc0CFSXxR6HZo3WO5AGKnz0hvuqBbaBihltxbnOOm?=
 =?us-ascii?Q?B+5K0pewWhoCjtfIk6nsUfViBLWlvQPN98o4pgNApearZmP284hQJT0dH+O0?=
 =?us-ascii?Q?h2oX4lKvP0grr5PKVJeUJB4fkDO1FgO1zzFDFFylaSJ4pPiuNLwskhQxhtVz?=
 =?us-ascii?Q?oLNvbigJZPPHnsMADzphogfImhFNjOAUboZmHnzGe4pNj7Tl5Evfus9UnTN4?=
 =?us-ascii?Q?LlmS9cpr8OxayVOmOtILOzaG/+AGmUgvCjf03uYaEHjCtn6OEKrowSytdhHL?=
 =?us-ascii?Q?BAx7F/qngD5FHfYtw2jUt9rbe3CShQTD0UB1LuMav6GPGiUuUljUuJGnOZYd?=
 =?us-ascii?Q?eJZomieXoRshBouU08TZVpbZIVcGKZrN+ZUD02Y6X//7qlrjqy+yvNMdMC/V?=
 =?us-ascii?Q?10/09y08Ssr8w6WU60r/cIriP6qfNythCDDY77T5emIGTy88+fwcfdlI1dB6?=
 =?us-ascii?Q?HdLQp7s49kqkqrGKhdhhD6ks0KvAv7KMk0nR0zvObTpX7G/M+5eIDN9HFpM1?=
 =?us-ascii?Q?qALWVbM1up7FdTOw+KgC0VAqa8wKoqCJ7FI2563lJdiUQ5hI8DdjbIIqzEn0?=
 =?us-ascii?Q?Ty+dSnEUT/weuX9Vn1B5HjWvT3CoMnliZNNxdLLtU+rz5Fp03bq2N2uG/5Re?=
 =?us-ascii?Q?EhVsO2BENcv30032tu1BLuD1svUwuPoHupDCbO4PgLjNOkp2+sJ6YIS0fZp9?=
 =?us-ascii?Q?4YKX8tUeJ32DIJ8e/ui723K2X0s1tzrbbKVbrr9AbHthPGndel6ap3CUREzK?=
 =?us-ascii?Q?3oFeypvBJWQ4RmbShL2SOr7A?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f5ee11-b6b3-4391-4cad-08d9103c3483
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 03:08:21.3288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqWUhOMEjB2SSLmaE5i/yER2YMJXG1HwzAY1fvyAitI9tviUkGx7UqPZkuKCNFup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3560
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_200825_928459_6C3F62C9 
X-CRM114-Status: GOOD (  25.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

[AMD Public Use]

+ linux-pci for further review.

Thanks,
> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, April 22, 2021 9:19 AM
> To: linux-nvme@lists.infradead.org; kbusch@kernel.org; hch@infradead.org;
> Chaitanya.Kulkarni@wdc.com; gregkh@linuxfoundation.org
> Cc: stable@vger.kernel.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Chaitanya Kulkarni
> <chaitanya.kulkarni@wdc.com>
> Subject: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
>
> In the NVMe controller default suspend-resume seems only save/restore the
> NVMe link state by APST opt and the NVMe remains in D0 during this time.
> Then the NVMe device will be shutdown by SMU firmware in the s2idle entry
> and then will lost the NVMe power context during s2idle resume.Finally, the
> NVMe command queue request will be processed abnormally and result in
> access timeout.This issue can be settled by using PCIe power set with simple
> suspend-resume process path instead of APST get/set opt.
>
> In this patch prepare a PCIe RC bus flag to identify the platform whether
> need the quirk.
>
> Cc: <stable@vger.kernel.org> # 5.10+
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> [ck: split patches for nvme and pcie]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
> Changes in v2:
> Fix the patch format and check chip root complex DID instead of PCIe RP to
> avoid the storage device plugged in internal PCIe RP by USB adaptor.
>
> Changes in v3:
> According to Christoph Hellwig do NVME PCIe related identify opt better in
> PCIe quirk driver rather than in NVME module.
>
> Changes in v4:
> Split the fix to PCIe and NVMe part and then call the pci_dev_put() put the
> device reference count and finally refine the commit info.
>
> Changes in v5:
> According to Christoph Hellwig and Keith Busch better use a passthrough
> device(bus) gloable flag to identify the NVMe shutdown opt rather than look
> up the device BDF.
> ---
>  drivers/pci/probe.c  | 5 ++++-
>  drivers/pci/quirks.c | 7 +++++++
>  include/linux/pci.h  | 2 ++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> 953f15a..34ba691e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -558,10 +558,13 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus
> *parent)
>  INIT_LIST_HEAD(&b->resources);
>  b->max_bus_speed = PCI_SPEED_UNKNOWN;
>  b->cur_bus_speed = PCI_SPEED_UNKNOWN;
> +if (parent) {
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -if (parent)
>  b->domain_nr = parent->domain_nr;
>  #endif
> +if (parent->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
> +b->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> +}
>  return b;
>  }
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> 653660e3..7c4bb8e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -312,6 +312,13 @@ static void quirk_nopciamd(struct pci_dev *dev)  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,
> PCI_DEVICE_ID_AMD_8151_0,quirk_nopciamd);
>
> +static void quirk_amd_s2i_fixup(struct pci_dev *dev) {
> +dev->bus->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> +pci_info(dev, "AMD simple suspend opt enabled\n"); }
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1630,
> +quirk_amd_s2i_fixup);
> +
>  /* Triton requires workarounds to be used by the drivers */  static void
> quirk_triton(struct pci_dev *dev)  { diff --git a/include/linux/pci.h
> b/include/linux/pci.h index 53f4904..dc65219 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -240,6 +240,8 @@ enum pci_bus_flags {
>  PCI_BUS_FLAGS_NO_MMRBC= (__force pci_bus_flags_t) 2,
>  PCI_BUS_FLAGS_NO_AERSID= (__force pci_bus_flags_t) 4,
>  PCI_BUS_FLAGS_NO_EXTCFG= (__force pci_bus_flags_t) 8,
> +/* Driver must pci_disable_device() for suspend-to-idle */
> +PCI_BUS_FLAGS_DISABLE_ON_S2I= (__force pci_bus_flags_t) 16,
>  };
>
>  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> --
> 2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
