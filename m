Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A764E9B36D
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TJ4l+VfjTv5Va7QUdn5DKpdyvYBA0Te10iDr83fFO6I=; b=b6f3bN2LlJ0UgzQd1OV50wbyO2
	NEsgfub+ocKQ0FqQpx4crdJWvDqfi2OGAucLgLrlEjDubrDtnN867du0vYx72u5oji8DRsj19H9kw
	LggLdVq0dX31VC7wMxg7665T+/0+GeytCm9FRphyPb1aNDrs44RXDY6Xyga5NUh2YRo6We67Fy8ZQ
	7m9wgN2KEOVEgsG0Ib6IH8cljdpda94lccQXPgM6BmP+grUlc4XQW3z6yvbdw8SAvR1ciQQkOVqnk
	1OSIZ8d8x/NsvIV31jCv1HSCnL4Fjs9cqO+xv4J9iQd82FRS4hq8nrcF13V1Ln2vbvuljOCfD3sjj
	XOxTcjnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx1yG-0000000Ctk9-137Z;
	Mon, 02 Mar 2026 12:01:56 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx1yE-0000000Ctjb-073H
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 12:01:55 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622BGrTX2067844;
	Mon, 2 Mar 2026 12:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TJ4l+VfjTv5Va7QUdn5DKpdyvYBA0Te10iDr83fFO6I=; b=
	jKObLSQAd67r4EkKJsT42NzT/8KFmNxQkVNUPBWRVyMD3C2GXaBX1b2mBoKor3w9
	/YMEJ5N5m3KRgWHHsMRuozMmWT9/p7Z4wdKQoW29+5ItfL+Jqh6PS5S1Lv3krFyK
	JJ9cTFsegfmpZ5bhyTKnCm+OFieuHa+XtM2LIpKlo1Pvg+o37ldag/acMF9BFJZ0
	ypz+CKn3O94SB0OHgIF0NAb9ED9C3z+KrgHCilfk/FnpoNi4lS44YSS2Bp+wVG1J
	d+nv8l/rLm29MrSAN49hstJ2P6aLtFKRv0JHEcYPxaHqEn5M6Bd7v7GI4ClfsbFx
	JV9UnP7LsYlxCVCrSdb1gg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cn9hhg26s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 12:01:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622Bl2ZV029882;
	Mon, 2 Mar 2026 12:01:46 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt8up22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 12:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKdp4U0AmDTkVe1VgH+x8Qln8v4wX7npcksc4KaFtpmNx2bqSXTQ34aZDLRmBjirSOptruq+HM4aWsgTjfNFcWgMR8aTlNXv5pSLn+XD3DUgAN9XUZkgmgGkkzybyx34CBEL1aYQ+/kOOHVTp5p2Ej5CmmPFABe6ttdEfI1F01bwMmljQp78hpkWIG6fXwcsZJNh65nembwfrDorgPN9UfTOjxg1+73z1IK+m4u+x09yujbf7vjmYA1fhgMPGwhEEtc5U61NSOoIh4H8yBxZMrgE+wTjq/DOUFRM1aApF5axZoT7byekIKkiWaR9RnK57ZJ8vTak2r1YBxWIrDSfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ4l+VfjTv5Va7QUdn5DKpdyvYBA0Te10iDr83fFO6I=;
 b=Z5hgwUxvTRjSPo8Br8XjJ3Zo5tVpnDZWY8CXrsVmQFOzD27YV20SA1VmzDBoEk/YOBerg05HCRA7xOPSkhkvhTuVHK/M5Yo5fpQHmAVQkdenIO6hzaY2WaC75JPAW01BK1rZvq6/G3LEcPShyGQnSrFFLSz//9T3OXmuNo/OKVeHq9XJLwccje2aIDKoJspf4YfcZx05DyvS5P/FhWNnktI4M4ANe5tpbb3c7QY8olvyk5uV9iqXcokTiq06jPvTLV07sFu+gZpjoV9Ex+d8mgXASIors/4eL4jihk6uGF/eyst33vGQXntpMhDT6ifbcJ2CF1SniYG+pMRCT02fpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ4l+VfjTv5Va7QUdn5DKpdyvYBA0Te10iDr83fFO6I=;
 b=pBGSE5YNrZVFumWkSV0A52IyNLWbhHOXjC5IAMOpBYqzJ5p6UnzRjpXTQVvrs8lhmDl5BJnLg7iHTMNs2JldB76RR7YPUpl9lbs4ywhC4whlHFDh27skE6tOQR+x2ho5tg2ZRn2WdGDnsUU6ne8DFDwuKuhbEVbFQwQXWRfBa1I=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CY8PR10MB6874.namprd10.prod.outlook.com
 (2603:10b6:930:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 12:01:38 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%4]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 12:01:38 +0000
Message-ID: <ddd48218-4e69-4081-acc2-72ef9e5bbd79@oracle.com>
Date: Mon, 2 Mar 2026 12:01:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] scsi-multipath: introduce scsi_mpath_device_class
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-5-john.g.garry@oracle.com>
 <aaT74XadDrQb22Cf@redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aaT74XadDrQb22Cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CY8PR10MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 426a728a-355e-4139-836d-08de7853756b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: EXj8ZnMHV9S/tUTgTHXrOlc1lswHIRbEJdmtAAKIhzXcm6Ut9DV/j+6RRzz37HQB7CT5YVFnGN0ljSRUDGfdo7SBIWMDov4bA9KghTvlNZnsGdQQ1QEv9pQEPBDiQ89nIK/FldZzscYANQ7mXop08tmCnUB6GGb3YcNoXnmZSMXeIWxg7Jyari9ZVZ76jzHVspUsR9KjDHUaHFoyjZqc68/JFbu2hhG7qZVXNqJOIrVgQhZIeTHTVNDLREk/FjGRwwgiUIRdFs1QE2gbDd1TZdy1V8s7ek/Pkox15Gfhjc8wki9IO5MGmloFDiwWzB3b69Sisigc8Km6hG6PEf/JU8em0HXfa+pdZ9qRf80ykOML46NwJe/ZQzX3W4SIC8UWp6GjMqCq7q/c3eCCd4WhH4yuI+kUeWRNlfXc0tckFjZkoG3NBNl087EsRv8fgHN4MQtflu7Z0aVYfnPAQl16pvsvNqs6zxe6v6zwQkVFl9nuQqwYYX6xpqdmURiKcYJ+bPzjTPcKtyiem4yC2gYXIju/OyFd/kASEQbFwV12zxXsISvdgj7mTr4CMg8RQxChEyeRoTieqJeSZIwY/DlqlLrqKIODnYRLom7aeti0c+WLpeBgpNwggZnLBG0r/k2yIlNym+xu/QQZoxzU8Uu+AhSsB3j2qV3KVwHxZHVt0LCjyIPSadHsaqBkHUmM2pnRQe4fL7ep1sWcMgdNslXaMATeS1BfsfhORacyTv/fgeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUYraWhUSFdqR0ppT1ZuRUtKR2w1OEd1RitkSVNaNmRQR0ZUMnRhSlBoZWhP?=
 =?utf-8?B?N01KR0tJNlcxRng3c0VjVUxIUXBFT2RuOTZRTG84cWhsYjdOOTRoeFVjaHFW?=
 =?utf-8?B?SElJVlBxYU5YcnJSQTB3QVVCMkJ5bGVoU1F0WkZNTzdJRFdhM0xEcitZYXE2?=
 =?utf-8?B?cXJDWXFzc2R0NXQ1TDh6STZsRm42eFRCWlZTTCt6OWVXdlJYRm9iTG9mRmpH?=
 =?utf-8?B?RjI5NDhkQjBJclJ1WVpOYmtzeVdKVzVtNWNTQkR3VHlPSDRQU0phWTFmd2Yw?=
 =?utf-8?B?Rk5mbjlSS2Z1WUw5SmVNdGlUS1VzWjF1dVJmWGtYaklmQkFHRGNYbWlISldh?=
 =?utf-8?B?a3dDOXNHRmpiaHQ2cE5jT2tvOThHbTFVWkRnUG16V3hza2RNRTE2cFVzSXMx?=
 =?utf-8?B?UlhZZGhuaHp0UkVoUDkvWnZndU9HZWZBa2dRY3VrU0xsLy93bHplbkVjWCtY?=
 =?utf-8?B?NXl5NC82a3c2elBZb0pVdU0yNC9lWE8xU2VXOHY0dHRGTndleVVTa1p3ZStR?=
 =?utf-8?B?S0lUbjJYeitGR0haeEg1L2dnU0tXWEZMa0JWeXVjVmdjZjQzeDRTSE5BVWxZ?=
 =?utf-8?B?bmdoV1pwNWd3dnpkakh0ei9HL1Ivcyt0K2pTSE9UaVNGb0RzZVh1K3hiQUJR?=
 =?utf-8?B?S0xXaWpGLzU3aGxZS2oweGZhMUw2WXhXYzNCV3JlQkd2TFZrZUhsTkxqdjhi?=
 =?utf-8?B?OVJnclhpK3V5YzY4Y3BZMW9sVVFlSkx2OFVnTEo4bTU5NU4rUVFJV2Z3R2lo?=
 =?utf-8?B?MHFoc3FqNFBhUjJwdmgyMm1UcmhmNHVMNVhWa0pjVTJVRDkxWS9mUXB4VEw5?=
 =?utf-8?B?a3pSTEgzUmVHbVFDRGlVSGZQS1Iwa3l1YVFDMXRkRElxNGE4WVBScDBpejM2?=
 =?utf-8?B?ZjhoaDJvS1RrSmk2c0JQR2x4NElwcmZna0gzaEZQNUVvcHFaNVduanRSNVRa?=
 =?utf-8?B?cWVZeGVzcUl4bnowTHAzOHNnbCs5T2FqVTVJUWZGUGRRaS93cEI5Z1diNXlo?=
 =?utf-8?B?cHo2aDFWR1U2NEpIa05NdnpLVDhFaW1mbWs3Q0hJVXFFczYxcXZQZFBETWpL?=
 =?utf-8?B?SlBuTTFoSW1tVXI2a3d1bWZRSVEreWFjdzkvZVFTQjRQNjcyQ3YramZuL3VD?=
 =?utf-8?B?dm1SdEFLaWhrNUd3ZFYyRnZCd0dGWjdRM0pjOGJib2QxeUJXYUR6MXZQdG9p?=
 =?utf-8?B?ZmpkbFZtTFZhWlEwSng4eTkzbi9kWGNSNFd0YXNzNU02ckQ2Zlk1NDJIOU5k?=
 =?utf-8?B?V1F2bE1tZi94ejFGZ01ZRTRtbUlxaGVSS1NSV0xveWswNVVsbTEvWkpyLzRV?=
 =?utf-8?B?ZEc2Y0dZTDg3TFFyRnB1QmlqenAxZmN1eC9qZjV1WlJkZ0t0MDNQeDFQcXk5?=
 =?utf-8?B?YXhNWGNMNnIzZkMyYlBPSEorcHJUWGFDTjFVK3BxM1dMNlFnZ0QwSzJ0Rjgz?=
 =?utf-8?B?bUY1ZDFvcENBQUp4VFFUcGt4T01aVGVRZG1VLzE1S2liQ1Q4UStESElMR1hu?=
 =?utf-8?B?bmtMaWxGejBGbGttZStWVm9Kd3Njdjc1MUtDMndlNVIwaXB0WXRPSmtMSHlX?=
 =?utf-8?B?b2xwNURVZTZtVWwzWWZacUVKeFhBNjl1WklwWVh5a1VnTEt6TWdIUnB0aFJF?=
 =?utf-8?B?SWZSU1FORWVGaG5wWUpwRW5CQ2NWUTZEcU0rYlZ2Y2htZXc2M1lvRnk5alZK?=
 =?utf-8?B?WkRZVWlNNS93aEsyZUdIRjFwRCtDYXpSZ1VBQUVaQmxKOUN0bGhPTGM0elE2?=
 =?utf-8?B?RUdjSXBYUVp5bEhkY1g5L00yeEhqWVJFRlpYUDZQUitKM2NRNmw2dkgwa1p3?=
 =?utf-8?B?MS80RFNVVGZLNitwMUxDVEZHdVE1bXBJZEl6UThRQ0pUUjluUDBhbzI3dTNp?=
 =?utf-8?B?VGZnL0Y2N2hoRFBIQnRHSWxoREo3QW84bSthU1BYYUEzcnM4OWN0Z0djWXla?=
 =?utf-8?B?QlI4NTV4NXB5UFlJekVhRjAyQW5DWDk1alhnY1NkOVc3cG5mZXp2OVM1NDds?=
 =?utf-8?B?YU1kWlVOYTZreU5Bck1xZHh1YjA4aWcwOFJ5WFNTQmphU3ZIMW5OT2lycjUv?=
 =?utf-8?B?NUdyR21KbjZ5MVBzZ2NvaC9wb0NjRmo2QlVhMDdzTnJlSGFGaFN6citrQWs2?=
 =?utf-8?B?Z2YyaTIyY3FPL2J4MURGNGxIbG1nN1ZZY1ducVAvdEJNS3ZlcUMrcUVHczJw?=
 =?utf-8?B?YVY3MVhRRU1jMTNGRE1YMWxrakFlNVpjTkxyZTEzYXc2RVpmUk9GVFgwL3g2?=
 =?utf-8?B?MkRlZmJZVFJrMGg1ZmVsMEI5Nmd5dHcwWS83ZmZpc3JCL212QVNKVUVEMSsz?=
 =?utf-8?B?R2IvTzgzeUE2WERnajNrcHhrcjRTQ21LMWFtUWpGM1BIUURvcDVsdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PY8n+LawLRlWbwX6uutDIeW/GF9+6M1dLQHYz+lbwBWHHIlYgVaPwkpo1bZ4fjkWEC/FFD/7hb3/NmWzvFkfSoOfkCL+YoIF6KXG8YgudUbpoAXpb+SaYjN/gIkUe5soQBRfv1FIWR2waU+UtIi6E1p/4BJaZDfJUOuKe8weQGrLVb1JCQvhJ6cxNc/XfkdWXopa/ic/81efAwUwK21h/8g1Lw6oFimuNxTthCPdACdXyuKGJhXBkbvuty2HGERLqOfC9CRoCtC0b5g7JP3hsOPaIqCyqcYfDG/fiQzXNpBpOlz8tB6S8ObDXNZ/RuTVJUYFHsScq5P+/zSNx5k6ODn/AUjCGxK69o/YnAY5EBPFY23qqmWKFefdaXbqfOX1oRDd97mzXonMMTGiUeZh/levpHX6wmmBlNOJ+DtWWNlFl+3QgwWC9LHAeaf4rOx0a7LArv4+2/2AW8sAzenEG7cXYyDJvm9Scq6+FcAxkeDMITK7K9dCNc5O48clH2EwBXVDhCrFpyKhUeHqv66ylrnzZCdEy8FwogTJdDxNYX1weW7SjYnt9LKOqOj/jdvq1X7qzl0z1rslvjzW+pJXa4JDMwHT01XAYPwqK92Nz94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426a728a-355e-4139-836d-08de7853756b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:01:38.2112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjaZxJOvXxz78Q2UaYYSZjXfs83U78ZbwlqBk4NTXUwNPhgqoekCV7AglTYboQtdlHOtYqJY2bXte1MX0NTw5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603020100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwMCBTYWx0ZWRfXyTVMmpam4cBZ
 v6SoOo4gPIaAw5I54dnW6Hpu0hv8R+ALhJ1zhirWgvBzaTmRUNo50XOI5CBxbX4YHRNy0qjcIeh
 9s0N5LMEs5v4M6qceqsQoQyDMd3sbDYUX9jgLzrB62KLTEIoHJ9vChLP4iGyBp+n0FWt0chbh+A
 zCc+mNnq+DV4447IbG9PbpzamjETSZ5NRYb0zYunCKUJQ0ypCf24XjySpOxjLZYicg88Z27gh4z
 HRQ/320G5BHMwjgR+zfMu+RMqUqCsJ+qwVzqE3N6OgfNUuJXqS6C8ylCdcL40tam7XiSNeflBye
 w7JBA99IUsnEimiAlzQYWZW6yNDwDYveNSa9T3C3NJNygQWTf3FSlRw6pFaU6+ClFXtywfRsWX1
 SWLQqVV79V30sBq7IaY2OvLx7OqAIwIocV2k7ZiiGzHk4HIxGOmIo4Py19q21PMj96C6M8nNyYR
 BqiNeBIiOqdBKAOKiRA==
X-Proofpoint-ORIG-GUID: KJO4p-fuOf9SnbBi1AY1xbG2urcIILjG
X-Proofpoint-GUID: KJO4p-fuOf9SnbBi1AY1xbG2urcIILjG
X-Authority-Analysis: v=2.4 cv=C53kCAP+ c=1 sm=1 tr=0 ts=69a57c2b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=k54H005MnZJY_gzb930A:9
 a=QEXdDO2ut3YA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_040154_192180_E75F0162 
X-CRM114-Status: UNSURE (   9.61  )
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

On 02/03/2026 02:54, Benjamin Marzinski wrote:
>> static bool scsi_multipath_sysfs_attr_visible(struct kobject *kobj,
>> +		struct attribute *attr, int n)
> The return for this is actually a umode_t.
> 
>> +{
>> +	return false;
>> +}
>> +DEFINE_SYSFS_GROUP_VISIBLE(scsi_multipath_sysfs)
> Nitpick again: This could just use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE()
> Also, this code would make more sense in the next patch.

ok, can change, thanks!

