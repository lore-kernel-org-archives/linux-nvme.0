Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9B4CAC59A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EanckJuHuOwj0OlxPkf7nG4hNAM1eLZbkZ3uIC1yg18=; b=ijDuttPlU+65gWdzNin7ljQrfr
	B7P6BVzwtL0CVBpbxXhzZk0QKsENikvDBdP2WnoCgvXYOH7RE8uu/JnsEVh72fffU6zCP8Xo7SbHS
	qnYZo7CkSujK7P8o6plxPY1rIpIYpFTrC8LPs3AurLpZLXL/7oRnZWeUmyxEXxw9WV2cc0w0mq5Ee
	An/en/A9rhs2Up+UWZdvW+xzwOI4l0OwRwsRQFOBzrV5K3Sp98xPKwO2AS1iPgGJCiiPbPcXt3gwS
	U2zfxckt/h4ETNqpNIyKv31Ot7Fn4sttZjfHLFtK4ANHZPA6V451krT9UyMOEXAOTMWl4xrDmja8d
	FYlg+wBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0NVz-00000007tc2-2gtB;
	Sun, 21 Sep 2025 17:06:19 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0NVn-00000007tbB-2J7b
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 17:06:12 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L0ec8T029874
	for <linux-nvme@lists.infradead.org>; Sun, 21 Sep 2025 13:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=EanckJuHuOwj0OlxPkf7nG4
	hNAM1eLZbkZ3uIC1yg18=; b=iO9nz0F1WLbtGouNM6SZ8uJSN+8FqQtmUZC0WFA
	SCcMR11M4tHTBmmq9C5aQjQLuTCZF8oYaHf6w7nLFB5j+ZsHWsl7EYYoy8utW+6X
	8gVDTcq2tXjzKueysIXlNKWL/fAfddPrkrPDz/42M11oKO0nR+cGvFRi8WLCutC5
	cJdSsWTJOvo5uTib01tp4FEIn2TybQu3R7DyUprgdzJbM7ECmClc+g7FX5knjK30
	XxRLuMwTT3hOTUJsa+xXFC+Bit0ARcM9jAKtSUdPGg6Cpf14nbA8Qwm9CUFHJR4W
	CKxDwBM5OPxCc3olxdSbM9hDWw+LiwXrZU2wfI72c4eiafg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 499nbuksyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 21 Sep 2025 13:06:05 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LEOIqt035595
	for <linux-nvme@lists.infradead.org>; Sun, 21 Sep 2025 13:06:04 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 499nhmndr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Sun, 21 Sep 2025 13:06:04 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJGmaY+PVOF3N3tRmw56Wmq3pIQMP1ji2fQnsjGaLUiTYCvr/rdgHcWaGL7l3HB1AG82pREkeIJ9e0WFtoz4Voo7hALxVaeGGplIJ4B/0yrD0oGDpm8KQWAQaEVDGM7w8q+fJsNtY2g9QfqntX9/7xeBaOQd04kdhfjJOgrWeLTwbLnQsCmjMW7JL0QlF4pYWbSKoHIOhUkGeUFyCpo/Q8ppKFRAx6StPmByP+ZSm9zlVpR8XtLLBfSZeMwbLfJ4dMpi5Uu9m0J3be1VAaGle6cwyE+j69ck+Pb3a0O1ORGYnj4zaYW+U4oaTcDaqqOw/Pw6eQ/INDlgji6PA74uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EanckJuHuOwj0OlxPkf7nG4hNAM1eLZbkZ3uIC1yg18=;
 b=PKSvaxkgoRcpwvr6Bl8ImL1EdwxuK79tGX8u7gXfVQzjH+Ode1SCGaAyx+9VVSz66F3BgI0bcDTStaQm5ZBJ/yCqCGBG31fNtvEzUr6K5uk7hb0jsf8ulR5EtTjMSIGVslw6oYbky52iAqCGHEVqAb7F+9unmeiGCK1NuFl+8WnT4xH+4D6GeWhOnWMYCcIXxX2tH3QSaqJ8etOZcoqrc4yMfJqJ/H8YjrP+zFEcrG3LOnYDJIrBcKOWhLBMaA/xzbbdic7j2tGekP5howsETie6dNfzhaO7T5nSx+khcsrieYFVmTQDhGkD2pjqcV9fQd/o2guP6RHGidRKNDmsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SA1PR19MB7015.namprd19.prod.outlook.com (2603:10b6:806:2bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 21 Sep
 2025 17:06:01 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::3715:4e28:3472:a0e4]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::3715:4e28:3472:a0e4%3]) with mapi id 15.20.9137.017; Sun, 21 Sep 2025
 17:06:01 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: NVME-ML <linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: [RFC PATCH] nvmet: set sq_id to zero in NVMe-oF CQE
Thread-Topic: [RFC PATCH] nvmet: set sq_id to zero in NVMe-oF CQE
Thread-Index: AdwrGMc2X2Us/6EgRai2jL6czjeF+Q==
Date: Sun, 21 Sep 2025 17:06:01 +0000
Message-ID: <CO1PR19MB4885E6CA8A98DEBE649A4D89EE13A@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=b5f117c7-757c-4ce3-978b-d9597ac22684;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2025-09-21T16:52:20Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SA1PR19MB7015:EE_
x-ms-office365-filtering-correlation-id: 30fbea46-d228-4c3b-3582-08ddf9312449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dWdjUm11YUdZSUNOd09NN1JDREcycEo4b0lDcnBHU0VtdnBTNjFnYzVKQzZD?=
 =?utf-8?B?WTFYbitGNXdERG9tb21CSWUrcTFxeE93YU10MVpDbEF6K2ZNQXpaQjVkamRH?=
 =?utf-8?B?N01NVndqd0xXQnVySkZtVTBDUW9wdjdRNk1CZDI5WU9yYjVTODMvdjZiYXFZ?=
 =?utf-8?B?M1M0bEpqZjhLYjNwVTRvQUZtVlVycVQyaEtIYjdwdEU5ckoxQXROeFgwWTkz?=
 =?utf-8?B?dGNRem4zV0t1V0wxMzVBVE9pcWxRZUpmcTlHQjVNMGYxblJnNVMzVUxJTlQz?=
 =?utf-8?B?b0NQaEtTM1gyYjhobmVpTDZzNC9xMWRtbUxKSnVPMmdxSWRFSWNuRjdTU0s1?=
 =?utf-8?B?RGNlUXpuMTFpREtpa3J2Nm9wQVlqOFBNcnJONWtzTmhaMFJ2SWJENzVVMEVJ?=
 =?utf-8?B?S1QzUm5oZWhHOWxVZkFVWGxZcWRLMFYyMHdtYkUzczBHVU1JN3A5VXNMU3ZC?=
 =?utf-8?B?UE9YcERwVy83UHlFTUl4bVRrY3MzTlpCVFk3L1Z5cWx4N0g3anc3SGE0dm41?=
 =?utf-8?B?ZlpYOHFOcll3M2d5S29KV2tsTzhKL3U3NjdIak1pTklTWmpaVmVRZDFmQTZ3?=
 =?utf-8?B?bzJINmpjV1UvMktwczlvU1BJQ1FxK05FNEova2xTL0NzYkhVaWMyRXZHKy95?=
 =?utf-8?B?eVdrTUpVRDdrakRzejJJQkxyTjRwWnpCSHJiM0JZTnJabzFzK1RTZ01PQ0dz?=
 =?utf-8?B?c0ttbjk1cVRXWXEzSWF5ejJBbDJwYlJMS1ltS3gzTjEzNlB2cERPaUJxRDVN?=
 =?utf-8?B?dXJwVVIrOEtJcDc3RmVRU05OeVVuSG5NSHZzZ3gvMzV1WWgvZE1JaGRVSzBM?=
 =?utf-8?B?dlZISDZPWG8vY3NFWENBdWQ3VVlhRXdveE1pNUpjSndscFpIanMzMXhSQmxK?=
 =?utf-8?B?ay91bEVhek9TYW1TZUQ4MlVXQ0NJYWh0TFZDZnJNc3FySmQyUm1BTGhZLzdY?=
 =?utf-8?B?Z2t3VGRqcFpVWW9jYlcxNHYwYzFYeFV1MjhtYlBjTytvY1ZUK01WNG0wc0pn?=
 =?utf-8?B?V2VkekRNcUw5QXBqS3pGRk00OXFrY3VEdjlXckJhN3BiWlNoYjBJUDZ5SWRN?=
 =?utf-8?B?ZXgwam1NUGZwS0NMcjhYVnRxQm5PelI0V1JjWkVjQWxhdFRHekVXV2dJT25N?=
 =?utf-8?B?NGFnelR1all5VGs3b203OWFZclBZcVVCVFhDbHpWSGZxSmZpWVJSVTdqdU9v?=
 =?utf-8?B?VDdGTEMvVTJ4NmVyYUY5elhUNXFLQ2ZPQlZCbXAvSXBneldFUmdnbmVBeEJJ?=
 =?utf-8?B?d0hVbXRUQWF5QlBpZkJNc01YcWQxQ3NDdUh6SkUrZEtzTVFJL2s1T3lBSmRI?=
 =?utf-8?B?aFlNV1NPc2JucHliOEdyRHBCa2RWSm81WEl2MzVqK2NBQjZrQUlyWHhRMHZT?=
 =?utf-8?B?TDdTL1RXV2k3NGJ0TzhoekRIZklYdWMyS2pvOG5iUjd6VzhpQ2Y0cG40WkI5?=
 =?utf-8?B?UElOY2k5LzFuY084QkxUVjVzUVp5Y0ZEUVEwd01lQ2NCaFlrUExUQ2ltQmRi?=
 =?utf-8?B?TjJGakhuSVVBOGp2a01RbGdwTks4bkFHemE3c2NYOVRGWFNoWVYyMzQ0Z05U?=
 =?utf-8?B?NGMyZ2pEcGRSWFJQa0NaaVFvN1NwUldjTjlpbGhzTGFCUVNWZW5JUDd5cEU0?=
 =?utf-8?B?MGFDTzkvZUl4djlUZ3dqaCswVWQwYy9vYVlReEFzYTl0UHBKdzVVajNqcFIx?=
 =?utf-8?B?NmNwczlpWGRXTkZHUHZqNW9PU1pielc1d2JGMkhnSVRtVnRFR0wwMjdFeTRM?=
 =?utf-8?B?WGNMeUtaQ1NqOHY2WUZUQk5yNWVRbUxWbmdQeGlMSmk0Q3FwZUV1RHNPSFYr?=
 =?utf-8?B?NVp1SVF6S0FiMEQrUHNzRmxOdXg5ZlRPYVlsZzZ1ZHFOMFpnbHdkV293aCta?=
 =?utf-8?B?cmZwVWFjUXdOSUx2YzN6MVd3dmtqMXRZWUcvVjA4cmxIeEplNHdsWmVadjNw?=
 =?utf-8?B?MG13eVFaaUk1NFhiZ1FiV0lkVVhIRHIreDlQeVNaMzAzeGl3V2JGUDcyWHJP?=
 =?utf-8?Q?nzTFuVn+fsZMV94CKGp/YzLX36Ta8U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YSs1USthRHpoWExVb2g3SEpoQXRxVzFlUkRMNUxFZ1BITkx2NlRndnYrYUFO?=
 =?utf-8?B?WHlDSnIwNDg1cHZHU3NWQ2dSTmRselcrMXdrRmI5WjZGVWNOVXdHdmlRY1dx?=
 =?utf-8?B?Z2JhZ3BHSXNNdU5VUFdTT2VtOEVTVGt2VTV1cTB2aDlldlJpVlJRRXhOVktn?=
 =?utf-8?B?TVd6UGF1UGVQNkt6UkVaRTFJTzNDK1gwZGd0RTFFU1RRZ1BFakxzMm9OUUk5?=
 =?utf-8?B?VTRUZzh2ODlJL2VocTZIdUttMUQvOW15WVJzOG1ZT2RlZ1doZ3pOYUdyL0Jl?=
 =?utf-8?B?S2VUVTFud1kxWWRHTjBPdnNtNHFnczdub2QvTlVmUmJONUxqRHNObk5NS3FO?=
 =?utf-8?B?RUVQQUI3OWxXbmVEbHNCeWdPL3EyUXZKdncwMUNQUW1xK1NvNkhBSFlHZnEv?=
 =?utf-8?B?ZlM1S2J2Vkw2bS9rYTc1b0FjUlJTSW5JVEtDMEhhaDRVdEo2OFRtV056cGlS?=
 =?utf-8?B?WGYvb3o0OHZHY3dTRnFrRE5RMFZQMFN0ek5aWDB2TXhPQnJLT0J2Q2JPYVZH?=
 =?utf-8?B?NVcxUGVWVUtWdmZZTGtXUEk3NEhQWW1PTjJNYTloYzNkQ04rVmpPeGRCTkNa?=
 =?utf-8?B?elpqNVZPSjJzZFBCWFVoQWMvc2tOUitsc2VoQnlIcEcxK3V0ay9UZmtMUDVW?=
 =?utf-8?B?NFlkZGdwVW1ZMS9qWVRwQlI0MDBEL2R4bjRhdmRSRm4vTWowcWFRbDFtd2Zl?=
 =?utf-8?B?YlF1WE15b0ZueEwzOG8wRjlnYmlMc29yNHpVNzRwQU5tbnV6QXp2UU5ZSDU3?=
 =?utf-8?B?dnZDRHB6NStwMnU4aFpRVTMzd21VMWIwSTB1a0ZBTjduOHFqb2Q0dmswOVY1?=
 =?utf-8?B?b2FoUDFkdmdCYnppZWt6RXNvU3JUSVBRRm0vTlM4WUc3S2lhQVVRMmZmT0Jv?=
 =?utf-8?B?S1V6amxScVdCZ20zOWhTcTk1aDJ3cmhLL2ZXUlZHVENWbWJyaXRrQ24vSVpO?=
 =?utf-8?B?SDAzVlVzd1gzaW5yT1M3TVM1VTBWbWt2N3JDTVh3RkRMMnlnT2RRM0pUTzNC?=
 =?utf-8?B?OUlWaDdQaExJeS9FaFpoL2VwS2dYL1IwMXVJTlJlZ3FQRDdsaVlqUGc2dzdI?=
 =?utf-8?B?Wjk2cnFkVUMwdlpTODk4YlRISHA5b2labkFxenY0dkdsTEs0YUtaU0R2K0dG?=
 =?utf-8?B?ZVBPOWFod3BQU0NWUU5ZeldQL0k0U3ltNWpObHloRlFobWdwOEtvaC8wUHAr?=
 =?utf-8?B?aHVIU3pPM0xUTEFJVGtFL0tETUoxNUM0SGgvYkNuVU0xRjdaS1MreHZGa1Rq?=
 =?utf-8?B?MUErTHRKcU00M3BCNVE3OVB4S3JwSTdmaituQ09tekZYcEZJbFhuejRqV09h?=
 =?utf-8?B?dlI2VTV6UlY3dEdVY1Z0QlBLVmlKTk1NbE1pQWV5d0N5ODRrVWR5ejYyTStl?=
 =?utf-8?B?bkR3cVB6UnlvVUFGRzJwRHlKVHk5aE5RQUVDSDgwWnVibU1abGRuQmdqMytV?=
 =?utf-8?B?eklGSXFvdEx4emw2NVNYNUpVQUpneGl1OTBjKzE2ZXhBWTh1aHppTXlXYU4z?=
 =?utf-8?B?ZVh2R2pxaEM3NDNDem9KdzJJVWlNLzMySm1OdEtOY01yNEI4dDlrRTVSamxh?=
 =?utf-8?B?YjduL0laRjhESnVnTlRuQXN6aGp0SGlUbWg5MFpndDhOZGxFeWhTNzlaZ2FW?=
 =?utf-8?B?QzgzbU9Vby9nR0F1Q3B5MHNnb0dlY09yYy9oSGZ2ZXVYM29IMFoxMk9iWjJQ?=
 =?utf-8?B?ZjFaYXYza0pNdFNCQ01aaG5ua0t4L1ZzTzduVWZMZHp4blZMNlJ4NEVCL1pO?=
 =?utf-8?B?UWh1UXhSZDEwTHNtVldvdnhMdGN4ZksvU1AwTmNVQVdlOWlFSVlTaFdVdkdB?=
 =?utf-8?B?d2xneTY2N2FBVjZRNHVIQzlLd01rVXRscyt6bVFOa3ZQcDdDUEJ3czJON1ln?=
 =?utf-8?B?R0R1eFVlUkZmNjNTQjY0MXZGWHMrZFN1YkpRckF5U3M5NjBtZ0tIVmJ5UWhL?=
 =?utf-8?B?Nk40c3pUNmFFTGtZNGNJSlRZay9uZFlBYVJpZ1pkUGRYYTJzNXk3TlkxR0tS?=
 =?utf-8?B?MEZaLzhMUUhkT2tMRnVIV2p4VlVtbUdkVHRCeC8wd01TZ0JxWnZxaTh0ZnJM?=
 =?utf-8?B?Y3NWazd3QnZvQi9ocFlrVDlXdStyeDcySFNNKzZ2M1J6cmNPYU9lekR5cGRX?=
 =?utf-8?Q?0YuoARPBTublDzZncbWyVTh7y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fbea46-d228-4c3b-3582-08ddf9312449
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2025 17:06:01.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOK+ZwdiVpJqpEuV4eCkOTFAWTgguqhxGfCyrocnOXtxEB1+Z1ikFHXH5smfL2LFEZfaDpRPKbuui7+uBS74ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB7015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200043
X-Authority-Analysis: v=2.4 cv=TrTmhCXh c=1 sm=1 tr=0 ts=68d0307d cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=iLNU1ar6AAAA:8 a=oY9agZurn8L2Doi5nqUA:9 a=QEXdDO2ut3YA:10
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: YcMDcNANGZKs-4BJxoGTQ0w6M8OprpoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MCBTYWx0ZWRfX8gvUAkLpUC73
 tUYMcVOoROVxaY5bFkaiqOdVzEcW2ubj05DwC1GWuqa/5fP4HkdnbzgGGOJEg+z0viV+iUoIB33
 8bcomC+tICPAbNf8uDVMuYfJuvY0msdAhYx01Sip+Hs3VRxxk7fCey+ZH+OfZA31LsD6zxN+aDA
 X9nVFtkmvCjXUyqGuMK4Grx6KrUjASXni2lgVfZ9wuatK7scBkvM6gl9zuchapCLi+cJJcJAuAR
 oan8BGGXadN673HVU/9UkIRKZk2jOO0NxMaQWMx6AOROmtGWGRfHFa0w3FmAWDtHNuodGAQaYrN
 HAkpothdq+IvSQDUvyz2+vV6SyW/7cU3CF69q45tmUH+5jfo/nBBqLmNOCRInyfiNO/GCuOlNrj
 7Csr71Vc
X-Proofpoint-ORIG-GUID: YcMDcNANGZKs-4BJxoGTQ0w6M8OprpoS
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1011
 spamscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_100607_788457_6CA86A6B 
X-CRM114-Status: GOOD (  16.17  )
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

SGkgYWxsLA0KDQpGZWVkYmFjayBvbiB3aGV0aGVyIHRoZSBiZWxvdyBjaGFuZ2UgaXMgYWNjZXB0
YWJsZSBmb3IgdXBzdHJlYW0gd291bGQgYmUgYXBwcmVjaWF0ZWQuDQoNCkZyb20gNzU2ZTNhZTY3
N2MwZDFlZDBiYmFmMmZjM2UxNDZkMjFhYzYzYzkxZiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEN
CkZyb206IEFtaXQgRW5nZWwgPEFtaXQuRW5nZWxAZGVsbC5jb20+DQpEYXRlOiBTdW4sIDIxIFNl
cCAyMDI1IDE5OjQxOjQwICswMzAwDQpTdWJqZWN0OiBbUEFUQ0hdIG52bWV0OiBzZXQgc3FfaWQg
dG8gemVybyBpbiBOVk1lLW9GIENRRQ0KDQpUaGUgTlZNZSBzcGVjIGRlZmluZXMgdGhlIFN1Ym1p
c3Npb24gUXVldWUgSWRlbnRpZmllciAoc3FfaWQpIGZpZWxkDQppbiBjb21wbGV0aW9uIGVudHJp
ZXMgYXMgcmVzZXJ2ZWQgZm9yIE5WTWUgb3ZlciBGYWJyaWNzLg0KDQpXaGlsZSBMaW51eCBob3N0
cyBpZ25vcmUgc3FfaWQgaW4gY29tcGxldGlvbnMsIG90aGVyIGhvc3QgaW1wbGVtZW50YXRpb25z
IG9yDQpjb21wbGlhbmNlIHRlc3RzIG1pZ2h0IGV4cGVjdCB0aGlzIGZpZWxkIHRvIGJlIHplcm8g
Zm9yIE5WTWUtb0YuDQpTZXR0aW5nIHNxX2lkIHRvIHplcm8gZW5zdXJlcyBzcGVjIGNvbXBsaWFu
Y2UgYW5kIGF2b2lkcyBwb3RlbnRpYWwgaW50ZXJvcGVyYWJpbGl0eQ0KaXNzdWVzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBBbWl0IEVuZ2VsIDxBbWl0LkVuZ2VsQGRlbGwuY29tPg0KLS0tDQogZHJpdmVy
cy9udm1lL3RhcmdldC9jb3JlLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
Y29yZS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCmluZGV4IDg2NThlOWMwODUzNC4u
YmY4ZTM1ZjUxYzZkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCisr
KyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jDQpAQCAtNzQxLDcgKzc0MSw4IEBAIHN0YXRp
YyB2b2lkIF9fbnZtZXRfcmVxX2NvbXBsZXRlKHN0cnVjdCBudm1ldF9yZXEgKnJlcSwgdTE2IHN0
YXR1cykNCiANCiAJaWYgKCFyZXEtPnNxLT5zcWhkX2Rpc2FibGVkKQ0KIAkJbnZtZXRfdXBkYXRl
X3NxX2hlYWQocmVxKTsNCi0JcmVxLT5jcWUtPnNxX2lkID0gY3B1X3RvX2xlMTYocmVxLT5zcS0+
cWlkKTsNCisJLyogc3FfaWQgaXMgcmVzZXJ2ZWQgZm9yIE5WTWUtb0YgKi8NCisJcmVxLT5jcWUt
PnNxX2lkID0gMDsNCiAJcmVxLT5jcWUtPmNvbW1hbmRfaWQgPSByZXEtPmNtZC0+Y29tbW9uLmNv
bW1hbmRfaWQ7DQogDQogCWlmICh1bmxpa2VseShzdGF0dXMpKQ0KLS0gDQoyLjMxLjENCg0K

