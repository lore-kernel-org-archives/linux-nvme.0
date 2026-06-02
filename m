Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00024CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RPk5b/1u5m6Yk1YO8DG4ynZvQpb3y6Nk4LkFvjyWxGU=; b=rOaNi9WyEzOCXVKsC9R33562K5
	h1MTXIsh/vhk+CZpBUtu/jWm3SWRjDYOITh/SiTxzZW8cFMu5/wKISG6U6jdqU6VFuhFekXLfJQPh
	gTULhkBogFOOCRJqpWr2TtNtzqNoeYveIpyaCP4ZaP5urXudPN1x/rSRltMmQUC4JP3wZk8oyJjxa
	W5RUPzuzJngDL00jYT4NJhz6M8nuOOy5fo1AEGMj82Y/yPtQ0a225NlU1+z9RG/k85QICWcNRHLBX
	VJoa5jFXvI+oeDClQ8HHhl45y4nJRVX4PyqiIcOV5YapKD4rkR7AtNgsgOmuBnokeD+7Dlvcbexk/
	S4Ahz8QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOtF-0000000D3AL-0qTF;
	Tue, 02 Jun 2026 13:10:41 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOtB-0000000D39z-1krS
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 13:10:39 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6525tZka1209401;
	Tue, 2 Jun 2026 13:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RPk5b/1u5m6Yk1YO8DG4ynZvQpb3y6Nk4LkFvjyWxGU=; b=
	KglNdy/KLfh2cweMZXRnSfpnCjcgL7zIrgw+C6Q238qccaPVJQOzLwcO7chBACNR
	esg0pMUO7z21+PDEBLqsn0sDiQW6DTYC+5T4jKvpEijBkfaXxaOBwIHNzf8aVrw/
	ftBW5z/Z+yXwLUFMaA9bVlegmjTq2WDW2VECM+oP6J3RV6yVxKcF6MSUTWnATQCa
	M3yKXAMhM8JF06wKAKTud7blF1qYPavOt0bXI8Qeq5R8MkiTt7+/hRTUWWTveUMy
	2D+UHGJ9m4Zz7SWSGGCd0PVcus47o4zXJ7R03E2ZhSFbs8f4vz8DQvQU1tDzpAGf
	IHO/U0mpUI3jF+lmdOKXBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efqs6m1jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jun 2026 13:10:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 652D5LA1032971;
	Tue, 2 Jun 2026 13:10:16 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ehu8jhg60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jun 2026 13:10:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLsnrvUyZJENj76OaQ7bqE/LxgNoU2C5geFQmo+unldtFd/YcdPbLpbNpiGSgKWFW1ciUM67hdUIRBtmLOybyW0FFKCfQYdsVHmOIJf5GxHLEluV9vFTlsWSukXGGi9pmeSJpoX+5koNDLS+9ExPKKRfE25z7l62hhQZmPnu8PK+KS2e4KFH3D5zORu/BWOwGws0pE3PDQ5HkqELdEpmXlsNL8+knAzvpTwpGoS5ht9ngnjslmtPeKsZ/DqNvApgWK/zNlGXSKXohoAOHIgcaVrd+9f210DwQsGKobUVjdDVnpvlTfW1drDKFSVd3fAHHgfnsDzJxlyEYnfyZ7AznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPk5b/1u5m6Yk1YO8DG4ynZvQpb3y6Nk4LkFvjyWxGU=;
 b=wLNO6ive/7VL6tHh1puPu/1T3VeidYbSTkfxYYZVn7Ymq32kYKyfqyFEwYw4OPxeHUZ5h5AXlPQ+2mskLCBOQIemB53bEROdT7MuFJohlTyp0V1+AM+OdXIwWHoNXY/irWFoXjTACWQhoxIcMX9Bda0JE61Wo1PnslFDJjpPijAZ8gpFumdpsO4r1ZGzUnqwr539yYchaOsZcZlgyhH8DXbB78NhJOniMrAofSa89CCuTvSg6l4r0+4bmFXhWzVpo9+RLeTnij72+JHy8pHPPbAIsvYmXO7d+3k7nq0wJfyNyjnB1WqoS0esJVvhlXQpi7FkcwNXWd5Pu5JbBE1A/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPk5b/1u5m6Yk1YO8DG4ynZvQpb3y6Nk4LkFvjyWxGU=;
 b=w2YW5b2GwR6UlBzO0nOInlnkvJ9zQTSLPh3nMKcmV1OGyCaYHozc4AIhg2xytKRrqzYFGEwaE9/LbUzJEH5OC6vVKYgXoYfhwYoeGxsjaNBVFk+UwAqc2A/zn0LHTLh8aGwWs4AtK1UL75Fjo8O8qWVMPbThFoAkjPN2AHbWByI=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ2PR10MB7597.namprd10.prod.outlook.com
 (2603:10b6:a03:53d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 13:10:11 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 13:10:11 +0000
Message-ID: <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
Date: Tue, 2 Jun 2026 14:10:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from Identify
 Namespace
To: Chao Shi <coshi036@gmail.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Maurizio Lombardi <mlombard@arkamax.eu>,
        Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
        Weidong Zhu <weizhu@fiu.edu>
References: <20260515185853.2761456-1-coshi036@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260515185853.2761456-1-coshi036@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ2PR10MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e2e1ab-db7e-4341-e8cd-08dec0a8472f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rp/dgZljB3T9zS59gHph/uQA/qm/RO0heQPGgHhVx28ZqCfAvHhKiAX4EiMPVGXBceMhHnuF2FPHlq9VmBnf4eFFeGiA4rT8w8MwEo/i09Bw16aDfnmQSxauwOaft2Vm43orWnUygY5K8js8ECxOY5uMXnVUaZkRiscuqXwG5HfuaIVtqxlmPYguBcA59V/cy6jj4ZKRNBTO+x8BiFElqFAqaT2hdV3A9uvjMiqXRlqq9mpkipO13ZNZcCi+4QKjSOrxSpZRDrdp+Qg5v8nw2IMmkuUe6D+K7BdKasTJq+EdYfk7SVQXYIHz2AdnO60cs+SWd75qU6YnZJCDX1y0qJT4jTqGd9wlu8aZ2DvSzWUtizxCRWugTLO1MsLe9bZxMz+j921mTvvKmMucDLpLmIv8iBm2paVxaofu/GKKtD49pIiy7m3v82kCwsqnB1kNXSeF/ozJ7TX1br7N8SOS2XLEAxdAqMsxkwLEmOM3dvzA/rnK9KoHDDKppjIwDe+IJWmja8bhS5gO6QZLZbk33zkMai5og+XdA0/hiheiBv542DZ1BnQFb+8K2mA/smsizCqiJueH5b94WRh7QDVnsh6+vmtu50Ga8z7wlVQwtk01yvHg0sEtdve7GH+YntWJmCRdr3HtzBWlkbJ+Y141mEtgWKANiOPUwo58hyOWIYcJ+qwowPSp7QXdRxvyB0aO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG95azZuT1FIZFZudlBFVlBpNkhUTkRBYlFGakJFMXlZM1hGK1UwTWg2djFh?=
 =?utf-8?B?NkZLT0JSY3RzTFlaV0xvM1BhcVlYSjNsWmh5bkFLRWEvQVd5VHpZWFh0clUz?=
 =?utf-8?B?RklzWFBJZzF5bTc5WEVlTWMyL2Z5emViVHZaYTZvRkxLU0k1UUN6VHZ4RCtE?=
 =?utf-8?B?ZCtNcExicCt0OC9JZkdvck9iY2R2a0FvQWxmQjhLR3JuWXM3NFFLZlhLZDls?=
 =?utf-8?B?VVVabDNzZXppdng0bzZmYXZiSis2REFkYmlkVmxpMjB6RFVCcEVNbko1SGk5?=
 =?utf-8?B?UXpmNTdXZkhWMnE5cDE5Qm1IWmh5RkpGZzhnSGxoY2Jwa2xFdTlzZW9iTUJv?=
 =?utf-8?B?UTRnczM3ZmUxQmpZU2svaUtDUU9OUGk1d0NlNE1PYS9VRllQdlcxdG1GQ2xj?=
 =?utf-8?B?cXVHNUpCUUZwVnAyZGdtRE81L00zWHZ0amlYV2FZVUVQdHhFV2tnZkdXWk1B?=
 =?utf-8?B?YmNTOTNPWERKZU1rTE83Nm1ZZmNnMDYyY3ZYNnhuREpKNkxua1pubzRIQkFq?=
 =?utf-8?B?ZDBJZmszbjMvaDVteHRDd29DamVrblpObG4vQU5zZDhkbzdGUE1XQ2VGUk85?=
 =?utf-8?B?V1BVR3FGRzFDbXFjd0daenliT3c1WUZaMkJIdzRReTlWWWRscm5PcW5tWm1Z?=
 =?utf-8?B?VzJBTmVJZkV2UnJQZjZ0RGN2NTBFMHNHRWdDYkNxQ0xUMlpPL0lWYVV2TVRx?=
 =?utf-8?B?VkhheC9STjU3eTl4TFg4Vk0yWDhRZEdrd1I0cWExZmJwUWE0L1lHaUZGYVZT?=
 =?utf-8?B?blZzRzZxWlJ3Y25JTVdYZHRnVzJaTUdFclY3Rm9DWmJkODBsaEhXSSt2NTgz?=
 =?utf-8?B?Ri8weER6OVExMVpDL2VUOUJrOTkwd1JBMUJXOE1ib3ZPVnFIbXZkWjh2Y2Vs?=
 =?utf-8?B?WjhqSDRNRXVMRFdHWSt6cWYrSDFueGlpMVUvTUVEL25LM2NpcVZWQm1ha21k?=
 =?utf-8?B?dWlOWVZaRDNTdFRtbXlabU1Ld2llRU05QzhaZ3NwL25ZcG9oK3RmL2tzaDF3?=
 =?utf-8?B?YzJzcnZsWVFNREtQdWp0Skp4bVg1NFpOWEluUXNHb1FSNC8yWVY5T2ExRnlt?=
 =?utf-8?B?Wm4rbGkwOFZoOTlyRDYyZ3ZNdmdBK00zaGxHa0hJampYY0plNTJBVUErdkUx?=
 =?utf-8?B?NS9HemE2ZitFd2IvLzhnbnBlcGdDanV6QUZyWGZDUnlvTFVuQkJ3SGVFZHkx?=
 =?utf-8?B?V0ZZRXFaZTZyQ0g1OHhQMmJHRWEwVEhuR0F1bDIyYzlQOU9QSXRNMllUWklH?=
 =?utf-8?B?bHM5R21lV3N4SWJwbGYrU3FFczNaOFNSZ2NCMWtLdG4yNXQwM3BqT0dlVE0z?=
 =?utf-8?B?RlpsUkZQdWVIRjdlS1cxK01uZ0NsSWZZNFIxMVVPL3BSMU1vaGxZTTlBa0gz?=
 =?utf-8?B?Y1B0U3NMSFJUL0NqSVVmNWN5d3RrWEJhM0xCcTBIVnNlcDNVeU5ORElOR1F5?=
 =?utf-8?B?bGJqUElwT2h6UHM1OGR1YWE5V2taaU0zZE55UTVoL0x5VXBlY2dMS2ZZWGxo?=
 =?utf-8?B?WG1SZUVqS2Y5dUdEOEozaG1XK1U5cWt1TFpDQWEyZFoxU3J1YnYxS00rVWoy?=
 =?utf-8?B?aTZVenFrcU5ZdUI3TFpKbjdNbFFIOEFXSXI1a2RaMmxEcGtqeGNBY3BOa2VM?=
 =?utf-8?B?bU5nUm4zSDFJYmNVNFRJak5neGpVdVUySXRXeHBwN1B5OCtSd1dNc2hMTmY2?=
 =?utf-8?B?MG16M0tWaHRtbGdYU2ZNTHpaNWdsQnNESXB1dmFXYXI1ek4rNnBMUzJiY24z?=
 =?utf-8?B?MzRqcmJteEhJSHd1UkRJQzBndU0wMFh2WHBpL1JIVXZ4QnJ5enc1K2hLOU5K?=
 =?utf-8?B?OTc3Tml1cVB6ck9kWnFjaWljbklIanArMHRGcEZFRElTQXJlMjdUdEZZZmQ5?=
 =?utf-8?B?Nis4T1FOOWw4WjYwWldTZ1YzV0g3MnorWFNhN2lqeUhLZS9hSlhobmtxSXly?=
 =?utf-8?B?OFlxRzNNMXE5U1JCTU44RGJROHJYOHQrOVdNRzErb0x6d1hYMWhCcWVrdFN1?=
 =?utf-8?B?UU1OMnpRem1rai9SK2lLekF6c01GaWFVRXdUUHFmTzRkZ2F6c0tZTU10bFgx?=
 =?utf-8?B?b3ZwQVdZbU90Q3Eya0ZSUHpBYmlaREUyWFNmcXdVQlpZUmxZQlRzamNIdVdj?=
 =?utf-8?B?clFELzA1eEREdmNkM0dDNHdCYmtxZHlrR2l3WlVvdXVKdHVPZGJvOWxNR3Z2?=
 =?utf-8?B?RlozTjZCM005WExQc3dsU1V1aU1NV2p5ZndpYzlVM1dDSkFwVTVvK3Uyeito?=
 =?utf-8?B?cFVaeGJESU1wSWlZZ3dNclJBTm8xa0lJd0I4YnlaZU5sT1g3QmpoMWp3c2gz?=
 =?utf-8?B?VC9xL2EyczVUcUhBUHJWc1FPNWdqU3dOTm5Eemh1UU1PVnlFamlxN0pQNlBx?=
 =?utf-8?Q?7vMtJMw5TJ01JH2I=3D?=
X-Exchange-RoutingPolicyChecked: o2qZUZA629V+nt/6IQf7wKdBRlbr5fApERnEL8AYAY0cr/g6azUfhX7N5qoLadcUzqsvnHUSzFUTXMV0nn8kjZSG30eb1AJ7qV52EC3ONaW2O2joqsRfhIy3/0ixd23kbLdm0dh24lOR+QXB+z9i7TnIMsFArFj6GIMZsXAiMQHfAQ1aj8x0MuOkrxcCjGRDD2tbvcx+47SH5jq9E+PVxsGHxntDiCB6EkZHmHQGMi9tMDFtYXMi0JLLLfOL576z1/ZieuU7BsCz9vTyyX8/wk7JtWRKeqhYt1+zzDedMeiwY8rBEEA+iVW+mlvP/qw9vhVFsVrCZHwvi9IlGBX+jg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IjMDW2fAwHp0tP+dvhQBx7ejszz1f5rKjDa6Hwb8+b7rx/SHvW+ZtU+E43t41Lu8xoZO09gAA1n+CfaNxIab/tFxbLAXgi9BPZ1NF6HhuzsHYCNpQxaUyAbCfMw5LycPRSD0zeMrzb+apNONbljoPy6ika8WuNuvuffR/0jezPJUaUmKQk7iy+Hqh1bI1OKKnhu2YDiWs8zoG5Ns5If9+MvfmpGc02gTn5XWAYxuio0yeJU1FjOzRX9bHokNrWrkils5erup6ueZsqGc8KNFyJaJiUUN6DGTUyqvyeVSZEjLa+F9r0HsWGnl+52Zl4+aa16oBrMB4V9+jW35qjwH3CoJWN5RIoqrRzfmOVs7Pi/ErA096ULgaTUHJvmMe3ohZLa/+It5ZUp6tSobvsxLTgcBSl5p1pEwfxa8m1pb/GeIPeb+iowchflPJJS5l6nm12Ua0b25bK/2ULgri/MwZ7tPuymR0HGdzfPuIjhvWv7A9Gvu3jJSI8ptCkd3fI4BtPucz93a1Nn1tx9g3CZ1e3i2Lz8onqPtzobnVKUdUk/1WuiIA22oNvfKJhQisY98pohun0MJTPtdLx1JRP1BWQCsmkoTLgPV3nNDI5vZQLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e2e1ab-db7e-4341-e8cd-08dec0a8472f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:10:11.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOvP750YQr2mL9brn7R4RFiH562MsJXhXP5xOnuKDJWpobLKbaJEX9XbgX8CmEwxu0BbWJMjL0JG07cLPO94Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606020126
X-Proofpoint-ORIG-GUID: P7L-cC4XXnJk2TZIPWjuWBxzFoauo4se
X-Authority-Analysis: v=2.4 cv=POQ/P/qC c=1 sm=1 tr=0 ts=6a1ed639 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=3dFZres4uDkmZNREMPEA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12303
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEyNiBTYWx0ZWRfX8T5bcKB7v2/f
 gcH18nX1FrmiTCGnI0SYd5ZzJDHQqPG7tFxw0NvCRE16yiXC+Bpp3N6ATZTg1JKNuwTfRTu46/i
 sUaFvZcgdg/zALyLZJ/6rlTZi8x7hWXRPNapEW7qMPrWbfHwhzdFTkw0Xr3dXH+aV/lrUXWbbNG
 yFQVd1tKLPpBDO2PJBAZ1vQgrPjEgRX6EWlnuetA249KWpzpV7Nz1hlSjOjMuNniyeEQh1pgKZT
 1GLb1ArAoYRVNCtLvXlF4Y0+XEJ3fRRr0k25sOS839j15KRI9pykJRAVLCibazPUMgw5BpQbVsu
 kSz2fGSZ53AwUF6p+i3HDYi3IU9pWAKh+6djY2PdfkEQ7G6A7HTDEDHiHpitqPvOAnItlH3g7OY
 d0O22sY4S2tD+cR8ui84ZcosOxy7ftZL+hRRRqzunYuuT5Y++QyNkbPze8DOgn0Obdzprfy9q09
 soZE8gDYcfsdYPYv8VtqDNp9TpgaPdQidtw+544w=
X-Proofpoint-GUID: P7L-cC4XXnJk2TZIPWjuWBxzFoauo4se
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_061037_842896_03E4A537 
X-CRM114-Status: GOOD (  11.18  )
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

On 15/05/2026 19:58, Chao Shi wrote:
>   
> +	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
 > +	    check_shl_overflow(le64_to_cpu(id->nsze),> +			 
id->lbaf[lbaf].ds - SECTOR_SHIFT,
> +			       &capacity)) {
> +		dev_warn_once(ns->ctrl->device,
> +			"invalid LBA data size %u, skipping namespace\n",
> +			id->lbaf[lbaf].ds);
> +		ret = -ENODEV;
> +		goto out;
> +	}

JFYI, this is giving a C=1 warning:

drivers/nvme/host/core.c:2411:13: warning: unsigned value that used to
be signed checked against zero?
drivers/nvme/host/core.c:2411:13: signed value source

I can't seem to quieten it myself, though.

BTW, I would have thought that check_shl_overflow would catch 
id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra check).

