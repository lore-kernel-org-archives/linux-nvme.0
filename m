Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAC7C5CFC1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tdfT/F1+6TZPkTmnNdFReyM54qxgWp35uqncxCiCjmI=; b=afOcjeqWqAukM8/uW5erAdnHw8
	D7kEWMyI4wRvXjv60P9fgUBh7AfYTUmncxqSPx7pwjUR6BfxkjU8hZjeSAILt0AkZnNStzBRPMMh5
	pELe3JMjnAGOhgjR/scdvGHZDIgw7AkNFr3ZRMk+13ZKKcI4GRbt8ng0v582715TxClScZbuY1y4g
	x4JTIaVjXvuyWlonMlvPvYEwbn7+0P1IHtxi83KNESSHZTqdxiJG9QZzmbtojozNSUo8pa1wdP1KP
	0IC611luWxaJjtL3dyT22O6RC5a/0xR7nkkD/D5u5eTF3dUgYbGC00lhN4RtgLfHqTsV96Om2LFkS
	gWnJkTTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjqQ-0000000DrV9-2pE4;
	Tue, 11 Aug 2026 10:36:30 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjqN-0000000DrUS-1qEj
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 10:36:29 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B9Mgra1980453;
	Tue, 11 Aug 2026 10:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tdfT/F1+6TZPkTmnNdFReyM54qxgWp35uqncxCiCjmI=; b=
	g9x0Vou4XtKV1Vl3xQgP6JcoW/eJc/gb69dWnYgL1uarYmLNKvvKR4CNxwo6JYzH
	t7YI9NzLtL3nowOwBC7UJBHNM5fjrmieH+6oHj1ABYg+nrYbCG83n4RXhW5vrRO0
	WsV/zGvL2amv3kI2A/FlppVPVbCSKsuThHYrofG7DLHCAhPUgM2S7CUFYegjg1WU
	qRhL+6yjboevLfdPngJUn18vEpWrFL7vvzsfrv8wjnOUAxHtJjSdh1fwR9sHRAAm
	JMUtYkdKxsyUY4GnfLD5wLJVS8Fzz+/7tPay9D+xOvb1WmOpEUxL/hGCZEBQ3fs8
	fpnQLWTR2gz6GBHe4gaCgg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvk9vjxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 10:36:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67BAZWCr011261;
	Tue, 11 Aug 2026 10:36:14 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwqc478-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Aug 2026 10:36:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bii9LRYcJeLZUi/EUmZ9OiFFkHRkOS4e5T5WR8lBVj3bHunYZdpG4R50dZ7f8wDwpq3MD8yJkHE5OGDqJvnVACRihl5Oai34/C3hRcAdniSVVWVrrjypgChwVFJ6IVCRSi9FmCZ8IY3W6RvI6P6iOBMElRRLbOdNjiKxuXJNPUIQhxXJeejRkaTCJbDs5ChI99aY2EmBbaeISk31ztSFfTQwKftO9Ddha2bH13LtXNE0WoZBW1MurpFZWHkw0tlhMOFW4zI7VD9LeD8UMbuUg1SUq39ucFR7Mnfw1SLgLv0ClonptA8r2hs3YE53sHvtHuIdKSm6yoqOkQ7UBoLXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdfT/F1+6TZPkTmnNdFReyM54qxgWp35uqncxCiCjmI=;
 b=XxPdwvIs8Yd3TRAEinb2Hyg9hkeFOcQQPYFx1iTmBn3Znh8Keil4L0eU7tCM1sWB9zY20EmgLDksywMdJKkktfHqWaLdELTfTtT57gsJqzI/hx9mfcycVCmGw/VziJP1zGpQunKmeZkkr8zlNxd3vpVfwRopV2M8mACT2xQYLdNgfgMJ7B9R/bLnGbMrYnz4FpTKc3KhdhhNJ+4WpAZBsDIF6ykAq9TDyidgasVfr//cHyBwQww8EjTaxZexQ02HM6Rv4vOC/XWYuGc5x54rR1w6Dq3Pps3QFDrI3D0c9FqrLKPtHZUnONhni0VEgFcMES5snKDAQC6L5qHz+OtCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdfT/F1+6TZPkTmnNdFReyM54qxgWp35uqncxCiCjmI=;
 b=uSwFpWc+1SxAMvtgE24bGj7f0jP6LXqp4eUvvKsTF/+8mr7xzLXe10jmnnSaXNcQp7xu+PUAeNLkHCsbBfAoQGpu2bfZ96Q8evL+cX6nkxuZS8BUGwkY3Yeb8/Z3yFk2rC4Pc5CC/lnZdUfjq1G0hIRr3Kq+TErm5YezFDsCko4=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:36:10 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:36:10 +0000
Message-ID: <70b23be2-0cb3-49fe-bff4-237082caaab3@oracle.com>
Date: Tue, 11 Aug 2026 11:36:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] nvme-multipath: pass I/O type to nvme_find_path()
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-4-nilay@linux.ibm.com>
 <f6daf09b-338d-4518-9d1a-a172b3c2bef5@oracle.com>
 <dc2bb999-ca97-4899-8470-c95a80ae1229@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <dc2bb999-ca97-4899-8470-c95a80ae1229@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: d6caaa25-6f4d-4469-868c-08def7945bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|4143699003|10067099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 5twhZNoVtZkgsw1JKkxQuuLN7YzMOA8cWl+AfIWjFDps8hvk/kp8TNdi1a5EJlSoLcmID7nRww+Ov2MODGz2koZ0dOAEdJnACWHC9bA152VDlxMaWCvfjIQ8r60KMrUruhffzhghDbD5EYBoYi3S9uDXybZbOf/YXbfT6+XKndkJlrvGh0mMcfMWaf+l3I8ALSQ40F6oWme5rgyG+6VUKsklCTIGbvMNEtL1ZPlPNnUxvvwukwSapdC9PH7OymVNp+GeDHan+9iq40TB3h4Eokgvc2XFGyJ+eJHfkqU3D/5bP+O+LclzbYpE9m/PiCpTXYXKbeduVo8vMjtMKT1Kg8xIMcXPOHA/4Tipg4ql2bc4ivo024ijh0vQtAB01tgGC/8h22qyODRNAGw35YNJfev7t4iqpK0xXuE9MM4vD31Ky4q2opywe+Kfilg+FjEuQ+prhMCay0atXwepgvXL9Lba15S8hLyyHkgmBpL6LfIP2A4ZrZ14eiMGtms3PC3NXAcvP8idSMcpnJiWZeRwEiZu2fsPtWgL/d5JGgfbZ+FtSXJqsF+LJ4ASdAyVNleqEy4PQOVV2/T5bJmfYHjHfO8HwfQe0Vi9KmTrX3ekzx86wLKev+ZOznILowsFid0yCqQgL3Knj2l+wyDyf9XTmFBA9dmBnjmUKLzwO/07q6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1NSUVRYM2pmK3M4NEFKWm02bkRGY1BjVzFQczhlQTQ4Y25CWEdPdTFjU3J4?=
 =?utf-8?B?S0xya3FibVF0bForQ1RWVlJDUVNoUUt2VndGV1VpdE1PUFNSa1o3TzBzN1lm?=
 =?utf-8?B?ZS9tb0RZRmp3TTF6TjJUY0JwaHZOeVBad0Nwb0ZCbWlQNEVLODRSSUlXMXpm?=
 =?utf-8?B?R2Nhc1BDZ25TZlJxTzBQekl2ZlNBZG5jUExPMEpBMlFwdHZPTkZtVWxvNks1?=
 =?utf-8?B?eHQyMTVDSmxObmtuUXN4MlhLVUF3MW80N09RMUxXdHNadlJ1emdyd2NBdWt3?=
 =?utf-8?B?YlpEdTg2SFJVeEZJczhXdk5GYnlBZkF1c1VSMVhISzFWV3VxWHUxbkR4amo2?=
 =?utf-8?B?YTdrZTVIOUpkRGlwc0V0RGxPcENIQkVDMlR1b1I1bEJpeUpTMTkrQnlQZ3lD?=
 =?utf-8?B?NDM2bU5zem1JQUlaSGNpQ1l2cXI5K0lLWHZHQWpXc2tmM3VRam5rakpQRHNk?=
 =?utf-8?B?WWRVc1ZlYmo5SEIzMExLTmlZcEp3Ni9qc0tOQWxuOVptQTNYZUtDRThYdllZ?=
 =?utf-8?B?aURGMnBwZlZhbWw5M2hRRzhkbFF4byt6NVB1TUNqbWFadVJDUERQYWJKb2x1?=
 =?utf-8?B?THY4MTlBUDJ4TkFUVitnMkRSdXNzNE9aVkZjY0JWY21DREtlMGNXbVIyR2tD?=
 =?utf-8?B?MTgrdjUxYVBNSmRWdjduYlUrTFM1d0ZITmNOdnFUNERpMVN6WmRzd0Q2Skh5?=
 =?utf-8?B?UGZNeFhyMlQwNVNiZFFNTGx0Q3Fja2hiUXpVNksvNkFJendTVUt1YU9sTEpW?=
 =?utf-8?B?RjgrKzFOVlhpSTF4V2dJUmExdDV0VHdZcmVoVnZTbkxDMHNRbzQxVkRHSGR4?=
 =?utf-8?B?OVJ3SndJTkZYWmQ5ejBwSk1JcWU3Qk12VSsvbUhqZi9lUUNDVnEyaXYxZXJM?=
 =?utf-8?B?V1M2RVBUOTZTYWJJWml1UGhYcHA4WFhwVW5qUStTQkRsaUI1V2UxeG8rYkxh?=
 =?utf-8?B?RUlITEJiM1p6NEpCT2FhNjNUSVpPNEpMdGN5OE9nQXhWd1lLeXZ6M3hFZnMr?=
 =?utf-8?B?Q29WdUdhbmNZNzJvMVAzZXNWZlFUdDFSK0h1NlFSTVdLYmMwWm9wcWxsN0tY?=
 =?utf-8?B?cTk1MWE3Q0lRUGsvLzhURStUejFHMVNVdDFNVEM5NXJWc05lcTZYMWhDT2l4?=
 =?utf-8?B?VjJhaTlReGhKL1dBSVVEcFFEVSs0a253WTByR1NSTXFDRmU3N1FHTkEvRmtK?=
 =?utf-8?B?Y29Gd1ZhUm1OSTdKbVAyOUhTTGRNYmpCUWxUdHczZVZQOWJaSXVxN0xpc1la?=
 =?utf-8?B?dFhIR3RHMG8yQW1SbkJWQjl3dENSUE4zMXNPYXpHRnp4UzdWTzcydmFBTEJ2?=
 =?utf-8?B?WVhjZXZKeCs2THJ1OXRBdGZmb2MvUGZaaWRreEVpU2tVdXBmN0lIYmZQemx0?=
 =?utf-8?B?c0kwdHVBdld1WVc5RjlaZ0tOTit4em5CMDJ5N29qRWd1M2VQUjRFUDk3NFBv?=
 =?utf-8?B?MlU1aUxSaVI1TFVGSXRTQnpvcFA1Ry9ET3Y5SkZNUktjVU13VGFwVThEV3hZ?=
 =?utf-8?B?dWxWNG41Q2hRazl0NVZrTDk5Rk1UeCtxRFRmYW5GeGo0TVBFMFlia0x5TWJ5?=
 =?utf-8?B?MGxNNUJBM2tUOVNBWjBiWU5YU2w0cExFUENUR1l0U1l4TVZaVXVSVnNKdTRi?=
 =?utf-8?B?SWJhNEFZZHNuTnBid0JwaUw5NjdvOGpMQ3JLUkppRytRNkkwZnM5aitEbnRW?=
 =?utf-8?B?dUtreTJLTkRyRWd2dUwyYjZwL1NieFFjTmcyNlR6TllVdmlYRG83aXlUcU5a?=
 =?utf-8?B?ZXMxdU11Y21FVjhPN3BVVWl6M0ZnbDNucHR4SUNOODNPS2lTUDVFRUZHWS83?=
 =?utf-8?B?VnJoVldiVFNlQzJsREZnejBiRWlERDhOMk1iQWxHSEZ5U3FwSUNucmM0Y0cy?=
 =?utf-8?B?YWpydHNGN0RFVy8rc2g0aWpsVXpTVHFoT041eTkyeHk5WjZ2cHRqcFU1Um9m?=
 =?utf-8?B?VTFNemtjaWVMbVIwSnd5UFdpcU1TekhRLzdHRUhBa2RGaCtsdFIvaXN1Wmwv?=
 =?utf-8?B?Sldxekt4R1dvYk1Ma3kzWVhLK1ZUMHlpM283cXBWTHo5bVhGYTRLRGRCWFBx?=
 =?utf-8?B?ZlNUbm1qNVM2TmJLc29CY1BFc0lHd0EzK2NoeEp4bFhNMFRhaThNamFFdDh1?=
 =?utf-8?B?dWplNHVxQ24wMHRyWVljNjlKeUpyM29nZ2RsWHpCUUlDclNLcitTc1hZM052?=
 =?utf-8?B?OVg1Sld2M0dSSTl1aWRvcTdGRTdQeHIxc0toNndva3ZyRW9XUS9WZ1lQMXJH?=
 =?utf-8?B?R3N2eFNDT1owYlFNSHUyL21EK3BiMmZ5Tnovdlo5L00xeUQ1d0RqVHFpWSt1?=
 =?utf-8?B?QmQ4elJpZ3VtbnIvK09kUFppTXhqbzJIV0RTb0p2MW5GRnVab2kySGhPcWtt?=
 =?utf-8?Q?iym4nFqqf1hfTpd0=3D?=
X-Exchange-RoutingPolicyChecked: cX6k/NtqcptSsUWXr8Qj7Po5AXLakC53yXkrKVHlPEUplyp+xEB21vCT/23LdT12CmWthoChm/J1OuMAuIAbryU4d05ZPyX6Nr75vSEH8DCKF+ggo8NDg0/YZ2MZy/FpLNptA1Go//A8FhteI3OHUhcQ6gc4cTene+tyIDYOPGzalXzgk+U/bQ3Mg8+75HhxU93AaQ1Hi+Iwvtj2iIGuzPTeU+DqcY8u5/tUxSSBKlCrX8KTKo5/ILI3bFWu5uy5F9oFp/TRQxJnQn7VklErxohM9TpHfWLaiqGtS6n22pydfSYi8PwYwYPswxQmkDoX61FqbbVeuukgPvPgbOOFIQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u66BjUf2As72KskeGYLF6L3xen/4H/Y0VlKpm3F6xCqn22dDwcO5IemqWwK+E4Opj19aNZh1VcysTi8pdOkhoS86WtxfORtP1mYZpNG3r+hHcjBa8Zx4FXa43h6ZQGVW7gXZM82TtXyqCL7aQsuxE6nLpTx+jaNIvrGi60xZIuXda2JJ4i5wk7M4Pkcrd4dlyp5EQhtlv7VkqVgpIPaMXl6NRUJrmw2yJ9kLwHh8hjE0um0A59rlPHSj9/OHJLWwlcXilxUR2MT8cXomAisvZLN03wcw2ebHr5aIC34yEKo+lnvxqGZ08skAMNgWHOPMjwwYeS3BENHdGCqhK0HRh1zoYzk3bll5LZfKaOwzmDcfGdpNQ4zQ/uH1B7Rc7cYrghBjC0O2T28xXL23YPElNDHV2XUzYliDMQ7UHnFH7YwqJIqTt4GjxQD0Rb8Uh60fWmSbaM9bFoY27iNFC9Z2JojZSDJfma1s0sbpIbo61jACHWY9LD/fSbMd0lPBdedkobc9MMSjjtkvUtAQxV+aEURJ3qDvTv0ZgvqHA0da68nnkbO/aRUFB22PlHcVinCdt6CN4MmlOPjOl+0kUZfVLXMUgHj6EcFz6L5GvKJVE8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6caaa25-6f4d-4469-868c-08def7945bea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:36:10.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Keb04uJpjk8bNPAwE7KC+HK9PKdAxrBmawGio3riSSq0W43n3hk7Nr5eRJTblsZs0Pr6IkpwN61D62ejY4Kc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608110088
X-Proofpoint-GUID: i7zs6lBgVP1l3E_u6QXDwsFCoF9gMM2j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4NyBTYWx0ZWRfX75qaAyZb4n13
 ysFqw9MAFGN0aI/qm0z0KYKALE7JlvpIe4JM/TnxMmSzvcrRddUngL+CCdiyzQb1tPMf/PYhaJX
 U6taf0T/96KaevUB9LfvQrsNSUumSNUG0+GgRGdU16QcW/h/6VOjP7YpY7U7hMgwPRzorilvbwr
 Ao5M7HY+bkDYhwanKHEkTpwIluy53JV4kTSmKmLLHRnJNCJ34F9ELNhRG6yCahM/yLz/hgjHcNk
 hXCd1bbsvyvT7HD1aNkQityAxd7rYBVjn3+76I16n+VNSZlC7nVEUHkgneV4sKQzH47KJ4VHfN/
 tbKwXZwl4PasRrXsbmOH0Cs3b8OkJXJuWkjtMYP1PsM5i6/1YHGQO+A2IWyLfzo5QLbgSzL2DT6
 g4/SKopLTVeGsFGJcWRx7jtQpxTdbd7YQCrfnVufuqct2ZJ3ehmR3iSGIfU58bzAHig4GJ/M9Iv
 6ZDKixaKoICrJO4w4r7tVl85gef7kBbGr2TyndzY=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4NyBTYWx0ZWRfX4hNt/HgcqNEE
 44Do2o9IY4YDLb4OJbROedMC3EBNC7c+1C3GkYsrw3kRaci6S2cj8Ezfm+I6OrE1QZaRPiKwW6j
 Cxx1yKAvYBNnWBP6/DdZU+hYzLrZIK56IqsUV3ByIRW0MexTroT8
X-Proofpoint-ORIG-GUID: i7zs6lBgVP1l3E_u6QXDwsFCoF9gMM2j
X-Authority-Analysis: v=2.4 cv=UdJhjqSN c=1 sm=1 tr=0 ts=6a7afb1f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=QiP1OZDzHJo5likegiYA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_033627_604625_A158CFDE 
X-CRM114-Status: GOOD (  19.21  )
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

On 10/08/2026 18:19, Nilay Shroff wrote:
>> It's a but unfortunate that we have to find op_type even for when not using the latency iopolicy.
>> 
> I looked at a few alternatives to avoid passing op_type into
> nvme_find_path(), but couldn't find a cleaner approach.
> Fortunately, determining op_type is inexpensive, so I don't
> expect it to have any measurable performance impact.

All I can think of is a variant of nvme_find_path() which accepts the 
bio, but that means more complication and code duplication - but not too 
much.

As you mentioned, the processing should be small for this.

> 
>>>        if (likely(ns)) {
>>>            bio_set_dev(bio, ns->disk->part0);
>>>            /*
>>> @@ -572,7 +573,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
>>>        int srcu_idx, ret = -EWOULDBLOCK;
>>>        srcu_idx = srcu_read_lock(&head->srcu);
>>> -    ns = nvme_find_path(head);
>>> +    ns = nvme_find_path(head, NVME_STAT_OTHER);
>>>        if (ns)
>>>            ret = nvme_ns_get_unique_id(ns, id, type);
>>>        srcu_read_unlock(&head->srcu, srcu_idx);
>>> @@ -588,7 +589,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
>>>        int srcu_idx, ret = -EWOULDBLOCK;
>>>        srcu_idx = srcu_read_lock(&head->srcu);
>>> -    ns = nvme_find_path(head);
>>> +    ns = nvme_find_path(head, NVME_STAT_OTHER);
>>>        if (ns)
>>>            ret = nvme_ns_report_zones(ns, sector, nr_zones, args);
>>>        srcu_read_unlock(&head->srcu, srcu_idx);
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index 824651cc898d..8a9ec502912d 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -520,6 +520,13 @@ struct nvme_ns_ids {
>>>        u8    csi;
>>>    };
>>> +enum nvme_stat_group {
>>> +    NVME_STAT_READ,
>>> +    NVME_STAT_WRITE,
>>> +    NVME_STAT_OTHER,
>> 
>> Would NVME_STAT_OTHER ever be used in high frequency scenarios such that it is worth having its own type? If not, could NVME_STAT_READ be reused?
>> 
> It may not be used in high-throughput scenarios, but treating these
> commands as READ or WRITE would unnecessarily skew the latency statistics
> for actual read/write workloads. Keeping them in a separate category
> avoids that distortion, so I think having NVME_STAT_OTHER makes sense.

I can't imagine that NVME_STAT_OTHER could skew the READ/WRITE results 
too much, but I don't know the full range of IO for which 
NVME_STAT_OTHER would be used (so I may be wrong).

BTW, it would be nice to mention the reason behind NVME_STAT_OTHER in 
the commit message. None of enum nvme_stat_group is described in much 
detail.

> 
>>> +    NVME_NUM_STAT_GROUPS
>> 


