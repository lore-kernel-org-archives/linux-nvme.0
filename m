Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0E8C5CFCF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WlphPQjUswGqXyVmTFZ1aJneSYC5/28vGSSXkHyA9D0=; b=QS7XH9d+6oUSpL8w/3FHJbi+kX
	dOE65omXsxI0sdUiHXGqNv2fPUKBZU6Sm12x/UBabyqK0MJQigQffph1kN53PsdlMKJQGkWCrv6hw
	8E8zhB92+NnaZkQg8UJUaa9m+ForIEH/MvOwIeOq8lg1rdYWiRleJJSgXHo72XY/OC5Is1o16Xq4k
	UxUa4xRv6lGni4RhU60Tg2qhNUmueprB+TDscC0US4REGsXsg8RSjdRM7FYE85RXP0R0qaRtykuIW
	Y7I2ou9nWacjjE6s8LpNlWiwZy/EU+PZhfQxp1ENRW+3oMheDS19ZJod3zcKKPq761BPmYhEzNHIq
	0Bhw0NQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjLB-0000000Do7p-27BB;
	Tue, 11 Aug 2026 10:04:13 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjL8-0000000Do51-45ez
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 10:04:12 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B9MeR22426412;
	Tue, 11 Aug 2026 10:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WlphPQjUswGqXyVmTFZ1aJneSYC5/28vGSSXkHyA9D0=; b=
	LD0SO2mt0ThwVTq5z4SuSlP2QrBWWBIxo93SklBVfelSbqbEAtM1qFe9n4d90ub4
	gh9p8XB0XMRGd1c73eTjhjQEk1Jb6s3FXOaaen185t2gkXGIiArSgz0ySc/Z6A3L
	U8tNn+OLW/dHL4IeshRfyHskVaOaZ4bwN2n6TicQMQji+3Z/wAZEQ/qamU/JZhY2
	/icQjeTUTrPPNhPtYHSNt4/2nfQu/48vggjMcrlwcs61peH1cBs0NJCxShmyfpIG
	eMXiKvHlllmH1DM6whGeoWepLVZgFPLCzVIp94/gV6wCiN3rnMHtkap5jLcGk7Ee
	KQxtH757hn4WDLRbT715SA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvesvkcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 10:03:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67B9tVVc003706;
	Tue, 11 Aug 2026 10:03:43 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwqb880-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Aug 2026 10:03:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8Yt0J1vtEDX9fhKN3cRcNMSs67smPOBufTNVvkw+3Me3LRpLhIBPfPG3KDIMEDyoteUMDy1JADPGGS/ZQWk2t7n4Ac6sv+gG1O1D239E5Vy15EGfuf+jVteUsxN8+tvoNLRkaqCgqynn+egGf9JvK1H9E+bhWea0sKTihYfgc/QtUXayNykfLQj0PlSDtD0yIa/IizN+RudF3zN85UlaS0hIUNzugTwdXu432nfgy7xBSN8S+BYQr1DTh6BYc1fYsl6BvGhwD0pnsaIAnLkFfWtJyfgRMLkPeNLN5su4Dhs5vco5g+mIJCFQP02luh/oNFb8/U+4/bXhSz4ud0SRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlphPQjUswGqXyVmTFZ1aJneSYC5/28vGSSXkHyA9D0=;
 b=uzI09q2abGpG0pSDhNIT1Tekd0gGLfDUa9AzAqbGSlT71omJWM41oCBdCKCt/EtT7J63X8Z6C40uLfs1W4wCoTU+r18QTajWjUE+Aex5Kt78CHlZqpwbyNevimCLCER+JatYuD3piBa9DzO6saU//4r+7Cv2hQAyBtWfDuEBsSIonheK5ewNxFnjSGidu36VvY6qhCy0eyVt93tgKtzHjWBS5B7MUiAfSzAmGfF9+lLxi6CuZFwjN2U73ia4G0B1GsoXTSmbv+uD4CAbkDb7yaQ+aOGfyP/LtABz9QRyfbTVWYorE0RudyCjXM16RPdfkWktQCCeuuDP+r8Oxo6zkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlphPQjUswGqXyVmTFZ1aJneSYC5/28vGSSXkHyA9D0=;
 b=M1sTJX3bMaeaAd2gfIelQ0plyKjkRbeWKkuRaJqZn8zK/M23ty/yEnzb4NGtKJPpm35nszxQdSP8lvnRE0YVPXiVmx0eGB0d+bfSEQeZ2ENjlLngIXfmm6TRkwncIC1jvJ9k5Jx2Ew9UGlj9bXl0ts5y96USecg4/Jwg0AHGdNo=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH3PPF54C97C915.namprd10.prod.outlook.com (2603:10b6:518:1::79f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:03:37 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:03:37 +0000
Message-ID: <a44c6939-00e7-44e2-99e0-8753627aa11b@oracle.com>
Date: Tue, 11 Aug 2026 11:03:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] nvme-multipath: add support for latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-5-nilay@linux.ibm.com>
 <055c80a6-16f2-4d1b-ab6e-fc4fd24e7227@oracle.com>
 <569f183a-03eb-454f-9871-4af16dbfc1e8@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <569f183a-03eb-454f-9871-4af16dbfc1e8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO0P289CA0003.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:20::6) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH3PPF54C97C915:EE_
X-MS-Office365-Filtering-Correlation-Id: babf3f08-8c32-46e4-30e5-08def78fcfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Il/yF90ZUO9DuTqgejAO824EFvzEKeFq6lgP8N/FEKpxA+KI0foxe8n1lfnLatVnp1q8ZGHoW3AtxfelATHlXwixq/qGoKebcIxDZoOpOZ4Yz+El6RVqkCMlGQ1FZABNOxwdAu2rhKke9lDNYAdwF23s4Hhxp2pD9SE523VInnU64GfBKPT6Y3rG0i7zu+kmzx6fvoH7dyx1NwWiY7YAhg6E9K7HExWolVBg/P9i0sDsURyZO62+l4SxsJ78VQG5BTWSKB0SJB9LWmbvpni8pKPMn1IHMltK/cytlYIbOPZaiqAlJIdlNDkiHhdH09oiUSDTG1ZiHLWOEQEIwI+jpWAXGeBPXEkmRmXtIbTt50Et+dgE+Q+I0gfSn2t3cLKlyjSxwJNnmVPL5icBq1PYipOZN5fu8Wrfjuy9XqH+PIMfSXJkhM8xbEB2W9s/TtKXD1ecvUDyfoDH4onGWjq/rAAAdMf/Vg7wgH8Jvd5g+K7hMxbbRIM9t8EUFGw+VJgzESoirSbRH9yWoxp64wOftaWFE94bjpx6NpCjvA6pv3zh7rfG6ol90cCxtbxEAs+gHOiqaMLFKwFcMOZF5b77mAKooQqHI+i90TRUht8k1hcoOHs6pHFJmEmJXmdIy4QBzrRwZh25CA7HXcAD+udpHzBTifI0QWKKWQna5p6A1kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9KWkdHTDFwVlpaUGV2MEVGQ3ZUWE9DclhSNEdUdUNDbW1kYjZQUVRMbHVH?=
 =?utf-8?B?RHBHUHloVUZGdUl5bW90eWZ6Vmlzd0tRVFR5MExEc0ZFZzIwOHV6eGYzSjZ2?=
 =?utf-8?B?Mjk1cnVhYldjSDhseHlBWWZTbk5oNThRTm1PcDZEMzF1S05iaDVxbUJjcnls?=
 =?utf-8?B?cXVES0ZleXZ6MFRZbWhpZytnR3RPUTZITXpYSmZvblZ5cUpEZ0NaRmdPdXpX?=
 =?utf-8?B?Y3c4WG5kS2Z5U0ZiVWhWSDlBUmRwclNnMys1L092VlBHbkc2aFBPN1JFQzhv?=
 =?utf-8?B?ZmMyZ296VUJLSllZVG5XSjlTOXhoYlBTQmljazNzaWFUYkdVUkVNUzhCTmpj?=
 =?utf-8?B?NjdvTDZ6WER1dDVDUDNVVVVuK09qalFLVmR6RkdzTDV5b2dLVXgzSXByL2c4?=
 =?utf-8?B?Y0s4Y0s5eGp3anRIdmR6anRyZ081OE94S0pvSG1lMWw2TnU4VDEwTUVuWXlO?=
 =?utf-8?B?R0l1bk82Qyt2UnVwT0lNZGVnY3R0RmRNNGZva1VOejE4Q0ltb2lhN0pHbzVj?=
 =?utf-8?B?U2tWRCtrRCtCRE5LOWFSRmsxeVphWWR2aEc1QVFCYnZDZWhvcmZueURSLzZR?=
 =?utf-8?B?akg3YWJwWjB0QjhMR2EvTjBRZW9sdUxBSmZybFdwcGtlUGRpQWtpdEJpdEJC?=
 =?utf-8?B?d3dqT2o2eWNsNVJDVk81SUxhR0ZKVitMa2Z5aWU1c1ZFTnVGVXYvUlVuci80?=
 =?utf-8?B?N1FBRWNqcXlTaExnRG1Qb2Y5VnhNSzRra21OdTJIWlBwNDBGK0MzZGdpNGpO?=
 =?utf-8?B?TkNwb0NNcVoxVjhzeWJxcjJnMnVCc3BPbXJKeXY2Mm1IalN1cXN0TDJYNEg4?=
 =?utf-8?B?cE5wZ2pPbTBHcWx1ZTlFc0RnVHlPVlVJcDdyWjM1QUNYWTBDSnNFUEVBUC9B?=
 =?utf-8?B?VjFOb1gyb2NOZUFoSkwySnJCaHM4ek5oVzMzS1lhM3ZxSkdLWE9ITkZoa2ds?=
 =?utf-8?B?c2xDZjlVYW0xSWNOYXRJRmRXb1JYNmR1UkthREJoUGxEYm9SQzdyRTdpeTdi?=
 =?utf-8?B?MFBaN3gwZjZ2dmV2eW1nNlc2dG1mZ2tTa2tSM3ErTS9LbDNocEJDL1J2L25y?=
 =?utf-8?B?c3ozUmJNRzRMWldtL2M0NFdvWTZTMmlEUHBtTyt0V0UyOUV1cGRDMnlpeUVP?=
 =?utf-8?B?eW1Xb1RCbWl5L3J3V1lpSWdwSE1nU2xkWlNiUXU1N2Njd3NFTDk4WEZiQlBl?=
 =?utf-8?B?RTNzb2hMWHVic1l0eGZwcDRmUlVWWVE2eUhZTVF4WW93dlBYbXJoWmR5Qm54?=
 =?utf-8?B?K1dOM0VyYjBrZmYrdERydUxBMExjRlNMb0I3Q2w2Z2tMem1QVmhUSzZUZDN0?=
 =?utf-8?B?OUlmeUozQVJ4VE91ZzVyRGFpMFBVNWF5d0tvbnBjWi9hdjh2bFlzYjRHV3RI?=
 =?utf-8?B?MDdRNnMzWUdPTGRIY1EvWVFpRjVlZHN5VUU3SXhRc2VmeEkwem5WU2tJOVVR?=
 =?utf-8?B?Nkl0MTR3RFNGNGR1NlpxTm14K1dUR3JOa1pmRkR1OWRlSmVWb3VxRC92emtF?=
 =?utf-8?B?eFRXSTFBNXUrdFh5bm85eENYZElRS2JkenNZczhCTUQ1WkR4UDBiK2ExOVJz?=
 =?utf-8?B?bUQ3Kzc5NVM4anVzb1gybHhPWmw3S1R4NmFMNWl3V3NPZ1ZxMFJFQjZkcDd0?=
 =?utf-8?B?T3ZOTVVNaGw4M3Q1bHRvSDJUN3dCa0U4WVJvM3BkaUYxeksvc3p2RnVpOFd4?=
 =?utf-8?B?aUEyQmxWVGdkMkNab1ZucnduN3NaQmhQcTk0ZVFpMVJmWnRsZXpjYmVCQ3NO?=
 =?utf-8?B?QXRlRUJMUzY0amhKMW1uUGNWeGlYL3o0S2hEY0ZWdjRieUVKUnIyTVMvN2Rw?=
 =?utf-8?B?K1BPZmdmQjA0cFBDL1RUd2RKR3NGZXowajZCa2pTd3VRRzE4S3ZzREdJSGNt?=
 =?utf-8?B?Uld6bDJwU2pGVDZ1dVltMzZOUTJIZ2FRTG1YS3o1dWdiVTFqYkswV1MxWVlh?=
 =?utf-8?B?cE5kRHlDZ2ppUXEycnRRbWJMcmx0NUFmSlpFN2hkUklycFdxYWtaQmh6VFZR?=
 =?utf-8?B?VU1sZ0wxSGt3aVhLOTZFaHZYcDZkYXlCclRraTVGaTE3ODZaN2ZxVlNsazFS?=
 =?utf-8?B?WnZBdmxpL3h6N3lidHZoNWR5b2l2aFZpQXNCdUlDSjNGWjBodjBPaTUwZzJP?=
 =?utf-8?B?UFpIekRHMFpYWm9sVDY1UHB1cHY2SjYySUNyd29XMmJLS05UTmxHeVpZMWlv?=
 =?utf-8?B?TFBFcEFpZ1FGaURCUUg0RG1NMFZtKzZPSlVoWDJ5RDdsNlV6dmlKazFzekJi?=
 =?utf-8?B?OEVCMXRjVVVaRU4wRUVDeFJnZkwxZzBwckVaN0kwWXErWE1HUXFyTEZnMmY5?=
 =?utf-8?B?U1ZlQzRtVDVSY3hwZHoydkZxK29LNENLazhFYjVqbHpLVXVjQmxjeXlIMXFt?=
 =?utf-8?Q?tEHUqCvmbleInPcM=3D?=
X-Exchange-RoutingPolicyChecked: dAEgQZ8lRow+6NHsDOBQMzscNPnehcBgPaGm1hQJDzuzHxtO2hCnT85Vjc7iPDBKwmAa4/23XMnyE25xBU8iEd/VzJ5ZQkmZeNA4qvRb3f0lWGcHEEMGt4aSYysSfxbVf5gFLUHRPyR7ZzdvZuE7XJTtGTHBUS6Hr8UTw2qRuNRyPbZGEHKr1zTlB+s0F9QESWJcQ2m8FdYLtAb0qlnY28+oDZ6awh5iyQ9vmmOge+w+7A8Iab4V8XPCvf22uHf2Hc8RpDvwdo+GP1Sno4SokOMdKd3+Yg6nMDpcCkuoZVM08lK/aqmAAPgjQBEitVvADZrIl3/E4TpdYb1E+Unf6A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H7kjDE9CA0+44hsCwJmZXUEMS2Ys2njJcp1G2dOmuLHsIieZ7ZSHXAhZNY25J9Vyuk9SMjjgDwdL0jAqXecpyEiJCLarKB/Qw8z1e6qrZb1hCs71bYUSMOOB4pZh5fX8eXwCt0uxzydRbDbiSILinFAsv7rpwVoDOImGoj+fSCnRiUX95ZIEiKAeTg9I+otw0O868poLI7gnZ3YK3CZM5e9gl+k9Pqa99XU32e9KNhME9Y2fVNZKP8qJczbk/MH+5hTM3rGXj8CERRhLGeWfuWcz/V4fDe8tWVVn+BXcBzC/PuCF/hgDb7MLfDsMt03Ob1x0nvpk5Lg2PJ3g37zBIQgDL1NYugu1kFq7fLq2/b/zSVCd8ReOp0K+z8S7mqZZOs4Efj2J9CugQt2jQ1DzloocWTmJRaVmfamUgp47lxp4JotM2P5fy/l4/sAClp08QB8fICrfgt6+ZH0tem4uvWkIYByvp9VrFIZHXrv9ZqGure0dU1878rLBNrzYIju8co7DaQIsCDpbK/CG6EldSlXGWQKtKezvReMYYX9ho6oETAPxWq8f0XW+PXU3E+AJWB8I0cITPiB4sOIJBCpr6h1fz9v4ROOFcijoTcSd+bw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babf3f08-8c32-46e4-30e5-08def78fcfc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:03:37.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALkmOZavG5Pn+Q6sDZwc1mBq4Kl1DvrhOloA9joSkZaffmof9ozZlLIlWAlpKkyhV86lEiYk0eWVP0cLJImF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF54C97C915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608110082
X-Authority-Analysis: v=2.4 cv=R8wz39RX c=1 sm=1 tr=0 ts=6a7af380 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=DIN-TtUBMpH-OSJzikcA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12098
X-Proofpoint-GUID: 13aBN5v8m7avQ2KOI3g22lYTO9YKQcML
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4MyBTYWx0ZWRfX4LQqBSkyJCK5
 bdM+5tpMvT+DedXOxkL+VoHgzZe5uZnHmKKaIUw0x9nlIOT3jgOv9PBxQpNGXXSfkLenSoHQ2NR
 ETp0z8uJWk5/4y5A+U1SuXTTArTVWajetNU1Ctxem7LxTYmHYYD8Dx9XpcJEWk74kPT1fx+WS0z
 nfWoI2vftSv4v4ne8LZPtFojlmE75XTZcz2NPmoVvLCj6KdinVCow2IrxxMRWauVAY9Ni7iJLum
 C6eko4qwhd/pTzeSAPn4h0tU1XAtf16UalFYcrVCP2LqT79bRTyavBAhrI/tenf2zeMmf2urhZp
 8Pu9a66VETFJOKNgUsYnUB4p2QjaojhkXVkP+FJQ+UzCUcPg0uADFSQVuhgvwLySJyNZjZpcgZH
 oxoCdEbn72V9kZF2UodotyUTbBuzCgCR+bFi3FeIEeycJvk0E9hqrO/qXDTIH0PW3s/ntZxdFSj
 iETl4A283skShsxg7qMk5x+etZxKhCn7tEFB1Gg8=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4MyBTYWx0ZWRfXyaI8Ngi1hndj
 hftjwY/QZgeMj7z1ivI1Njm0C1SyNF3DJjopF3hrRcPYh1bA+Qail83lKkEK8OQ/tbbA+SA1LWv
 9QU5FJNAmjfYeWns+3mhHgRjCupKLLKy6Rro7W6gpyLf5dsLBXAY
X-Proofpoint-ORIG-GUID: 13aBN5v8m7avQ2KOI3g22lYTO9YKQcML
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_030411_027769_11A80F0C 
X-CRM114-Status: GOOD (  14.85  )
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


>>> +}
>>> +
>>> +/*
>>> + * Formula to calculate the EWMA (Exponentially Weighted Moving Average):
>>> + * ewma = (old_ewma * (EWMA_SHIFT - 1) + (EWMA_SHIFT)) / EWMA_SHIFT
>>> + * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
>>> + * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
>>> + */
>>> +static inline u64 calc_ewma_update(u64 old, u64 new)
>>> +{
>>> +    return (old * ((1 << NVME_DEFAULT_LATENCY_EWMA_SHIFT) - 1)
>>> +            + new) >> NVME_DEFAULT_LATENCY_EWMA_SHIFT;

side note: I have to admit that I did not check all the mathematics of 
these ewma calculations ...

>>> +}
>>> +
>>> +static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)

Could the context analysis annotation be added here eventually to 
declare that the srcu read lock is held?

>>> +{
>>> +    int cpu;
>>> +    unsigned int op_type;
>>> +    struct nvme_path_lat *path_lat;
>>> +    struct nvme_path_lat_stat *stat;
>>> +    u64 now, latency, slat_ns, avg_lat_ns;
>>> +    struct nvme_ns_head *head = ns->head;
>>> +
>>> +    if (list_is_singular(&head->list))
>>> +        return;
>>> +
>>> +    now = ktime_get_ns();
>>> +    latency = now >= rq->io_start_time_ns ? now - rq->io_start_time_ns : 0;
>>> +    if (!latency)
>>> +        return;
>>> +
>>> +    /*
>>> +     * As completion code path is serialized(i.e. no same completion queue
>>> +     * update code could run simultaneously on multiple cpu) we can safely
>>> +     * access per cpu nvme path stat here from another cpu (in case the
>>> +     * completion cpu is different from submission cpu).
>>> +     * The only field which could be accessed simultaneously here is the
>>> +     * path ->weight which may be accessed by this function as well as I/O
>>> +     * submission path during path selection logic and we protect ->weight
>>> +     * using READ_ONCE/WRITE_ONCE. Yes this may not be 100% accurate but
>>> +     * we also don't need to be so accurate here as the path credit would
>>> +     * be anyways refilled, based on path weight, once path consumes all
>>> +     * its credits. And we limit path weight/credit max up to 64. Please
>>> +     * also refer nvme_latency_path().
>>> +     */

...

>>>    void nvme_mpath_end_request(struct request *rq)
>>>    {
>>>        struct nvme_ns *ns = rq->q->queuedata;
>>> @@ -206,6 +407,15 @@ void nvme_mpath_end_request(struct request *rq)
>>>        if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
>>>            atomic_dec_if_positive(&ns->ctrl->nr_active);
>>> +    if (test_bit(NVME_NS_PATH_STAT, &ns->flags)) {
>>> +        int srcu_idx;
>>> +
>>> +        srcu_idx = srcu_read_lock(&ns->head->srcu);
>>> +        if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
>> 
>> Some may ask why check NVME_NS_PATH_STAT twice.
> 
> The first check is a fast-path optimization to avoid taking the SRCU read
> lock when latency sampling is disabled. The second check is needed because
> NVME_NS_PATH_STAT could be cleared after the first test but before acquiring
> the SRCU lock, so we revalidate it after entering the protected section.

It is probably worth a brief comment on that. A similar trick is done in 
__blk_mq_tag_busy() and every so often someone asks about it. Or maybe 
it is another function. I don't remember.

>> 
>>> +    blk_stat_enable_accounting(ns->queue);
>>> +    return true;
>>> +}
>>> +
>>> +static bool nvme_disable_ns_latency_sampling(struct nvme_ns *ns)
>>> +{
>>> +    int cpu;
>>> +    struct nvme_ns_head *head = ns->head;
>>> +    bool changed = false;
>>> +
>>> +    if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
>>> +        return false;
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        if (ns == READ_ONCE(*per_cpu_ptr(head->latency_path, cpu))) {
>>> +            WRITE_ONCE(*per_cpu_ptr(head->latency_path, cpu), NULL);
>>> +            changed = true;
>>> +        }
>>> +    }
>>> +
>>> +    blk_stat_disable_accounting(ns->queue);
>>> +    blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
>> 
>> eh, what if QUEUE_FLAG_SAME_FORCE was already enabled before nvme_enable_ns_latency_sampling()?
>> 
> Good catch! It looks like we need a nested reference count for
> QUEUE_FLAG_SAME_FORCE, similar to QUEUE_FLAG_STATS and
> QUEUE_FLAG_QUIESCED.

Furthermore, I think that userspace can change this via sysfs, no? I 
think that the file is rq_affinity. If so, could that break things (if 
userspace did change this flag)?

>>>    }
>>> @@ -268,6 +554,45 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>>>        srcu_read_unlock(&ctrl->srcu, srcu_idx);
>>>    }
>>> +int nvme_alloc_ns_stat(struct nvme_ns *ns)
>> 
>> Surely "mpath" should be in the name, no? It seems that every other public API in multpath.c has "mpath" in the name.
> 
> Not all APIs have "mpath" in its name, such as nvme_failover_req(),
> nvme_kick_requeue_lists() etc, but most other have. So I would
> rename it to nvme_mpath_alloc_ns_stat().

nvme_failover_req() would obviously be a multipath function from the 
name. Anyway, "mpath" in the name just seem better.

>> 
>>> +{
>>> +    int i, cpu;
>>> +    struct nvme_path_lat_work *work;
>>> +    gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
>>> +
>>> +    if (!ns->head->disk)
>>> +        return 0;
>>> +
>>> +    ns->path_lat = __alloc_percpu_gfp(NVME_NUM_STAT_GROUPS *
>>> +                sizeof(struct nvme_path_lat),
>>> +                __alignof__(struct nvme_path_lat), gfp);
>>> +    if (!ns->path_lat)
>>> +        return -ENOMEM;
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
>>> +            work = &per_cpu_ptr(ns->path_lat, cpu)[i].work;
>>> +            work->ns = ns;
>>> +            work->op_type = i;
>>> +            INIT_WORK(&work->weight_work, nvme_mpath_weight_work);
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void nvme_mpath_set_ctrl_paths(struct nvme_ctrl *ctrl)
>> 
>> what do you mean by "set" here?
> 
> It is intended as the counterpart of nvme_mpath_clear_ctrl_paths().
> The former clears/disables the I/O policy state for the controller
> namespaces, while this helper sets/enables it.

To me, clear paths meaning is obvious, in that any per-NUMA node paths 
are cleared for all the paths associated with the controller.

nvme_mpath_set_ctrl_paths() does not really do the opposite - it instead 
just enables the IO latency sampling per path.

Anyway, I don't feel too strongly about this, but it just seems that the 
naming could be improved.

>> 
>>> +{
>>> +    struct nvme_ns *ns;
>>> +    int srcu_idx;
>>> +
>>> +    srcu_idx = srcu_read_lock(&ctrl->srcu);
>>> +    list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
>>> +                srcu_read_lock_held(&ctrl->srcu))
>>> +        nvme_enable_ns_latency_sampling(ns);
>>> +    srcu_read_unlock(&ctrl->srcu, srcu_idx);
>>> +}
>>> +
>>>    void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
>>>    {
>>>        sector_t capacity = get_capacity(head->disk);
>>> @@ -280,6 +605,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
>>>                     srcu_read_lock_held(&head->srcu)) {
>>>            if (capacity != get_capacity(ns->disk))
>>>                clear_bit(NVME_NS_READY, &ns->flags);
>>> +
>>> +        nvme_reset_ns_latency_stat(ns);
>>>        }
>>>        srcu_read_unlock(&head->srcu, srcu_idx);
>>> @@ -404,6 +731,92 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>>>        return found;
>>>    }
>>> +static inline bool nvme_state_is_live(enum nvme_ana_state state)
...

>>>        }
>>>        mutex_unlock(&head->lock);
>>> +    mutex_lock(&nvme_subsystems_lock);
>> 
>> I am curious - why use the nvme_subsystems_lock?
>> 
> nvme_subsys_iopolicy_update() and nvme_mpath_set_live() can run concurrently.
> nvme_subsystems_lock serializes these paths so that latency sampling is
> enabled consistently with the subsystem I/O policy.

ok, maybe then please consider a comment. It can be useful.


>>> @@ -527,6 +530,30 @@ enum nvme_stat_group {
>>>        NVME_NUM_STAT_GROUPS
>>>    };
>>> +struct nvme_path_lat_stat {
>>> +    u64 nr_samples;        /* total num of samples processed */
>> 
>> why u64 and not unsigned long long?
>> 
> I used u64 intentionally because this is a monotonically increasing
> sample counter, and I wanted a fixed-width 64-bit type. I didn't see
> any particular advantage in using unsigned long long here. If there's
> a reason to prefer it in this context, I'm happy to change it.

hmmm... I thought that in general we only should use a fixed width type 
when it is required, e.g. reading from a 32b register, then use u32.




