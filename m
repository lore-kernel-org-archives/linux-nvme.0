Return-Path: <SRS0=XXBd=IW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9005CC433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 02:38:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A56861934
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 02:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A56861934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KTTMg3A0j/8mQHJmxjtYFLvGqsvkiGKan4tevNh1VS0=; b=YOQb+E7em5EOnlKIIzFLbh3tT
	AtAzuP04CGXz51TaM6Acuaju5Bx/EIGPhJdgtOPbc8mhRK3IitcDVM4b9PenyOJuvUVTFk443Obcm
	RzOQLtvBTkIBzzIzF5bYOd6uDozsxZNMXTtsFqSsyQjjA88HxsRDel6wtbt8U2GrcSII1c5lMhUrZ
	bGcWjXDDPt9Gt8fZTixFPyW3PliEWqrDwhLT1/pXnZjY8agF9dBIz1pScfa3zHsALHiU2jWagpPOX
	1D9IxkyidOk/ZU73s0G+Xcvfgh0yHXktg+ND7osNrZ3zyE//DKKlS08oxezNXH60qEgf1qf606am4
	2ZLbs56rQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOtPl-00G9j2-3u; Wed, 24 Mar 2021 02:38:33 +0000
Received: from mail-oln040092254069.outbound.protection.outlook.com
 ([40.92.254.69] helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOtPf-00G9hF-VV
 for linux-nvme@lists.infradead.org; Wed, 24 Mar 2021 02:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agZaxr0dhhugAB3hQlSrz58UcBnjy4AH4jvTCfyYZ7hcreDQF3lJusmBfTXhJnEPgs1jD99Ui/sIqSmTje/GREin/BYpbgW/CEB2SqLWJLDUzc+AfHBvU/wsP7JA4Psch5K0mOrIDesfdEhuaSxwIBC/GAKs8XFjN1F5MkZnkOqAl3lj+5daki7LEPbbT+FqicwKqyM9oNpCmGIEhWnSYgt99U3RVRJu6aQtzgswxi0IoOxjwGHANdzoQOFOLi17+Nrh4yQ0/fLY8wEtqmV6HKL30xQ9s/4OYLpKcLO9Z/w8COfoU8PCrKPa3+8ciOkoHR4mgGE4zsWXvm2WjkVjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPctStFMkgiy8ZTU/QcmXe40XctWolilwuSKnI5dueM=;
 b=Qm2XuL4dSXCMkCZ0KHWRiwwF9GEptnsAPbVGU5ICwuYGpPqJz3/5b+x1klX3KLrGvqiWyzkUZJOID6V1QbXywMnzEJrYz0a05B+tiEdJAH9R4ygD0v+3OKCcGnUtDIOw6b8HQQ/2n1F1jD0QUGkqmkltTXhyjMEii52hL5eh9AtJvh1IkrT1Z75M7qZpYHV49R0uuFVclqarOiFuIlbSe4FI+It/4UWrp0AojnKln4ASayfLZsUkGJLfsCMbwVFj/sjWEQKQBT5yysJZWGFWYoOKJuQjTJZvYo9Oja107k1yL2/EjGaGd2EvG8cG+99Cqdc5mPf3a/gzjo/YzkLsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPctStFMkgiy8ZTU/QcmXe40XctWolilwuSKnI5dueM=;
 b=Jw+Vjs1O16favHF9Ah3GIVII7u+EQJ/RkAbS7K2WKviuBy/jaec4WoxLFQGGOLdNw7lC6cevpcFXgBon6xNaGs6cgbq1xZjegTW/VNB9PAtrAUGnJ1mMxx43jpyboFgGJSXq9ceMDRQAg8dHASdledbvirSEcqUZxcP89axQYorjCxkK/0ouVmFmenqeFJcB0R/0NxTOb1FEC7BLx1z/wMTj437VsODSlSCwYJ3BLOIEirlMVXaRyHeoOldZMyTipN/qN2KyChgIsv03XteExU57VEw2Ylm5rXFD4pficNhsqfGOLRmFkNl0dKIa72fvGUGRLCxy920p1NCvw454fQ==
Received: from HK2APC01FT025.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::4e) by
 HK2APC01HT182.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::489)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 02:38:22 +0000
Received: from OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT025.mail.protection.outlook.com (10.152.248.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 02:38:22 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F9C071C3ADB2ACB947ADA5272A80507F1C2A12613C36C810154BFAA052C1C8FB;
 UpperCasedChecksum:58C0FCB4069A23A957EBDD1C318FB73444ABEFBE4B0D3021FB9C8FF5C0C7991B;
 SizeAsReceived:7465; Count:46
Received: from OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85d:99cb:f802:3c27]) by OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85d:99cb:f802:3c27%8]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 02:38:22 +0000
Date: Wed, 24 Mar 2021 10:38:12 +0800
From: Peng Liu <pngliu@hotmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Peng Liu <liupeng17@lenovo.com>
Subject: Re: [PATCH] nvme: fix APST error for power latency tolerance
Message-ID: <OSYP286MB0181DD097BC42806382473BAC6639@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
References: <OSYP286MB0181647E6B1C99AF64C0803DC6649@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
 <20210323162321.GA2446196@infradead.org>
Content-Disposition: inline
In-Reply-To: <20210323162321.GA2446196@infradead.org>
X-TMN: [f1LJLA92/GNrf5QajC2mG6PC2s/iy0E+]
X-ClientProxiedBy: HKAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:c9::8) To OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:92::16)
X-Microsoft-Original-Message-ID: <20210324023812.GA3583@LIUPENG17-2EEHB.lenovo.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (57.197.58.17) by
 HKAPR03CA0021.apcprd03.prod.outlook.com (2603:1096:203:c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.14 via Frontend Transport; Wed, 24 Mar 2021 02:38:21 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: b65c2daf-6a0c-47ea-21fd-08d8ee6de431
X-MS-TrafficTypeDiagnostic: HK2APC01HT182:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqGAC0sD1BvuctCTYtFASMrIx1siROvICWAVgtdccmfxSvi1hiEHDGfSwFDmOUnmMs4ym8L/h/AKCvgPpIrdvNRz7uVmuTEDWUtP7aLF/MH+Ul4AVHkBaHdsFmCBBRVQq6GHKKRuYIwovWOxdzgimXC5bc4P3jUmBgLx6ALjV0+kv6uRdr41OI7QwRloMXnvhSnFcmtAveycSWbJF+3o9PeaLE0ta/YhyvH+6qzpcPZxtXnBKWI8ShUB/Qmzo95n41pGVlcNuGJCAG3mD/em/xUuzqPOUJr2OB3D87x9kwUuLhViNywcRM0Nq4WUxIb/ovmA0mTlYRyCTzZc4+5qVjFYT8SsuowGJGUeRA8VgOlle6COp4cgk6453gYBJOpR8Ytxycg7LJQSnA+TazGoMQ==
X-MS-Exchange-AntiSpam-MessageData: 4aYilfwaIebhcajSEmzzcJNWyMQWRXn9Ykig2TUY6rAHgsywb1rQLRQbqxgMezzRD0XDim78Sf4X2E7vbYLZRGdrY502t9oaw+WGz3YhSvehLbVpy1UDe6t66Wax04JqKQgqP2d0sLLw7/qLjXyOpw==
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65c2daf-6a0c-47ea-21fd-08d8ee6de431
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 02:38:22.4288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT025.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT182
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210324_023828_431819_D3F6AF2E 
X-CRM114-Status: GOOD (  17.18  )
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

On Tue, Mar 23, 2021 at 04:23:21PM +0000, Christoph Hellwig wrote:
> On Tue, Mar 23, 2021 at 03:31:33PM +0800, pngliu@hotmail.com wrote:
> > From: Peng Liu <liupeng17@lenovo.com>
> > 
> > Clear apsta so that nvme_configure_apst() does not execute
> > nvme_set_features(), which will fail because admin_q is either not set up
> > yet or no longer available at the time of nvme_uninit_ctrl() being called,
> > and this leads to the error message "nvme nvme0: failed to set APST feature
> > (-19)".
> > 
> > Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")
> 
> How did you get into this situation?  For PCIe nvme_uninit_ctrl is
> only called at the end of ->remove and ->delete_ctrl, so how do we end
> up in nvme_configure_apst after that?

I got into it with nvme surprise and non-surprise hot-removal tests.
Below is the stack ftrace result for nvme_configure_apst under the
surprise hot-removal, and it is similar for the non-surprise hot-removal.

  irq/165-pciehp-939   [039] ....  1529.443824: nvme_configure_apst
                                          <-nvme_set_latency_tolerance
  irq/165-pciehp-939   [039] ....  1529.443836: <stack trace>
 => nvme_configure_apst
 => nvme_set_latency_tolerance
 => apply_constraint
 => __dev_pm_qos_remove_request
 => __dev_pm_qos_drop_user_request.isra.7
 => dev_pm_qos_update_user_latency_tolerance
 => dev_pm_qos_hide_latency_tolerance
 => nvme_uninit_ctrl
 => nvme_remove
 => pci_device_remove
 => device_release_driver_internal
 => device_release_driver
 => pci_stop_bus_device
 => pci_stop_and_remove_bus_device
 => pciehp_unconfigure_device
 => pciehp_disable_slot
 => pciehp_handle_disable_request
 => pciehp_ist
 => irq_thread_fn
 => irq_thread
 => kthread
 => ret_from_fork

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
