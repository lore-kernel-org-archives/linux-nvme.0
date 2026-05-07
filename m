Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495CDCD3442
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 06:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/XgwLo4mPSbZ5xWlHbxe40e6UZCGvnL6v6nmjSPPPhU=; b=bZT12tkt2BqeXNhdXOXtnnRtA0
	l9yBUi2X8omIArNOrWitIvfxKkfsv0HSnVKhiE9M87kmuWvssyg/G4z027D8rftEkBdMPYmhW+o8E
	mP3qMb/gsBGNc9DUrfPhw1EKgNQlVJOIm2FpNjctglMWz53hu88OqJ2kLJSfQiwFcLGCg2J3l7P+8
	Px/hcwiw1mUys6UTCg/Z1lxjinWNIzqkHhIBZuq+GlA53wM6qLNuBoYejWeYnJMJRUMElXqDrGzUd
	6gqHZPsE87EgyN+d0PgEX7JbBHh+9cjxLIO9D9X3K0rUgNNLV6otU5TE4pur19n3R+InwO0kOSq2B
	HQk7ZoTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKsRh-00000002vwx-44EL;
	Thu, 07 May 2026 06:42:53 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKsRg-00000002vwX-1LmB
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 06:42:52 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646MfQBG236580;
	Thu, 7 May 2026 06:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/XgwLo4mPSbZ5xWlHbxe40e6UZCGvnL6v6nmjSPPPhU=; b=
	SVvyaHE4YvHaZv2r+xBG6u2T3hlJ8XD5GQh2HorFMq+rjTDKNeAczLPAXYESfsaq
	5CGkJAGfylc57QcXb+F2sEr8QOuPRWgGRf9yAvMvI0GJ59uGzgkrqbpkZRRDNS+n
	lBDJl85deSmw4yxUhhBicEIBonmfUQjw3h0s6OCgIb/KD1kXCARWv4aQoXuK5w/H
	1Ha5Vx/gTFc4KqhqS/x92xCxXLZhv4dfVlhP5WXYhKJTN75tU+LfazJrD/3KRMEf
	mZoWFRwqmKN16g9l2ql0JVdIW8WTemNGb42g1GMtvtV6YqzvyeFV/kKbDbSrTeMB
	Q+DHI0nrQH52RkVq+TnKKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9gxr4q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 06:42:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6476fP1c027033;
	Thu, 7 May 2026 06:42:39 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dx593y1kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 06:42:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ/bhhnGgAslHcORPWvEyHO6sa7wEImbSrgrP/87nNg4Uh02uEFdvGd05oJtkQ6QhiPEr0fwIqOuARuFbxZjUn5oPtSLHXpUvNW3DkqOYk20sURoT3eK62c8xfiRT6agpEjB75sWYXqpmaG2Mq4HvrmYzL1Jeihd+i0gdrUuAEhlj4PdZHLlHXMYQxC/GrlquLGwcsbMiY+DeuEL+GlSTUMPoSOYF5bYGrtwM4lSOGTddqgP3HAQ//OXFLVnpjrRxt4qKsYpWI88eFdd1aHri03ouDgP2HQOJp6b6FDMznE1k4/WD0btSAyQaCnkHg86fg3SwodGviSQkhx5ekAVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XgwLo4mPSbZ5xWlHbxe40e6UZCGvnL6v6nmjSPPPhU=;
 b=j1wbkTrxKYUgxtCtBJ+/haviUZKcvPT2cb9gxYYxi/m2DThq6SIw2Fwjw0En/1bxiblUcCYOgsKxr/aCCilJpH0f3RITYMH4llx5cb3lUjuEWYAsERQwmjfiQjxo9JD0NpW7LEFgqUGv9nmH8ldxEtwRBzXzzPEb8m1A6ic3/C0gDoRoH7/yvtOwL7FlwIKHoltUQNT9eIcuw+nl2K15VaHZtQGnUtTh0vP9TfDeRzqy5fvKaY/HgdrFIfRbRqpLUEt5V0+XB5qp3PsokTFFhObjIu4dAVC3KZufKQ61n+yWA+1HFj9Ut4QAPiq2E3M6+aKQ58uqZuF/jfzIZk8xtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XgwLo4mPSbZ5xWlHbxe40e6UZCGvnL6v6nmjSPPPhU=;
 b=e80uhenGEhsVzs4psMoB3ePFWyTse+7YLFZgwxVePnsomOsQbXcZb5LNST1SMRjECgcSf3qBdA8vooqJeCm0RfUVCKsAnfUtalUzWRGOkYKxU7RfSQts5K1tDz4uvV/cdswLGTIhvzPK6I4O6ibCOaGvERRCw4vaVLhH3l45L4w=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DM4PR10MB6719.namprd10.prod.outlook.com
 (2603:10b6:8:111::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:42:33 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:42:33 +0000
Message-ID: <edf09e2d-fb74-4f0a-bf61-b9a99a075445@oracle.com>
Date: Thu, 7 May 2026 07:42:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix bio leak on mapping failure
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20260506131900.2367091-1-kbusch@meta.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260506131900.2367091-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::34) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf3584f-0158-4950-f018-08deac03d18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yn/2t5RXFD4lAJknObG57t7kJgj/4O2mxZiPZM3p6LUfCzbC7/Wc/mAaoYKDHnaFe6m0c84GExMRZxlhhRLMAAsy1k1akzcPPSiJ1tGx4QnRQFCnjlSy8cVA3nF2Av0kvmV7TmPD9QmbQXscZlLlT9dbMIfQer5gf5C5ug7ra+0j1TVKyHNzu13LPrteSW5vzAfNwJHSj8GDlOSEoVHOUAj3ZWMUk/dFb029AXLqjBzAfNF/rCyAMwBy0CrnkJFnudn0G2jQy44HfQRU3rJaH3/zzXC9X2khVBAoyuGMoIig7HW4zZECrRJXaZ5cWFsJOKci1jOHnc/sxJ38Iora3ytjrDVAp/KqJg5BQNs0/Ocgo+8aQ007CMtlV94x/xknV43KzcIf/n02IxpT8caMDzkM8cmnxiyPzrT4LPatloCORJd/xfFXepaCW4SZC5T/SsvPYpi5pe13QZzggfeR4u9OLq2PB9uLeNy0+a2ATgYuWZJgNsSszB9W2ag3FCrWK4aDjuDGslaS90kF90hBnHhbJ7zPA7LT+yXaKDofLh0P7uIsXnoC68yLvZozM8QW0GOsSlnqnesFnOJJmK6iuyYGqnsRh0q22UNWZEw2cqf1Ho4xobL7mmDhoXej4wE81y6P32UlqWspzIlASCD4b0ydYbv7iKebP3EvVZN6FPRVpPlbma3ecwJMAiWcEGGp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhKTUpjZkszK2lvc2VTYy92Y2dTbi9tN0NhNk5saGo3SVpzeTFPVmU4STlx?=
 =?utf-8?B?cXZ6alZqV0Y2dXJJVkNRSUlzMG4xYkRiM3BHOVlXb1VxdTl3YmdRcm9QcElU?=
 =?utf-8?B?OUluZ1QraXh2R1BRRXNzV2x4THRkYXRhWExyVnZWNm1tK1kySlVha2FtSVd5?=
 =?utf-8?B?dUJ6bGtJNUk3SDhsY0lLMFMwNUt4SWU4ZUFuVko0cDU0Z1k1dVFJV2owWVBw?=
 =?utf-8?B?ajduUHF1NEpFNG1Od3FUdzJUL3p1aXRON28vaU9BNldVaEpFNEdQQS9kVzlN?=
 =?utf-8?B?dUxTYlM1eUpJSjNPbE5HbWRFMDM3c3VHbHBrSW94bHpGZXkwWWRlVG5hN0RV?=
 =?utf-8?B?RHo1Qm9aTHNmeWR3UzgwSDJKMTEzeFhrVlRsaVRCMU9PL2NBeXJGSEtrN2ZC?=
 =?utf-8?B?bjhNQk1UcXJCblkrS002eW81ZVNUZk9mRmlmNXBCQWJTVkF1V01oRXlMSnNs?=
 =?utf-8?B?Rm5pbWVHNFE0MGttd3IycVNnbW8yOUFGZ2pucE5BWEFTNFpoYU5YQS9ybitD?=
 =?utf-8?B?NzFjcEExS2dUcDc2TlZJdDBmVnhHZmc1azlndnZwRmt0MDhJWXVISUkvcW9p?=
 =?utf-8?B?bXJvcEhFcVlBSnNSeEE2M1RLMmhJUllPeGhkYVcxcTMrNjcwRnFkeEx4STJC?=
 =?utf-8?B?eGF3OGVvdWZrcHVYV2pZeXhjWWw4cTZ0TThnbERVb01MUUNDdm9jWDhYVnJ5?=
 =?utf-8?B?VzFGWTl2NnBqYnpTdjExSzFjbUk1WWM4Q2g4WERPSm11dVh2Ym8yVHVkbGRx?=
 =?utf-8?B?ZzJ2NmFQRFltWGwrVWJ3NEZzUEJWMWlFUWhFZzRLZWI1UE5FcDRBM0RJN3RY?=
 =?utf-8?B?OWxsSnpDc2VpdWZjTXlOTVRkNUc1bjVObHY3NC9zUU8vTkVJODdoYjZ5c2ly?=
 =?utf-8?B?WEtzOU9sNlE1SG51V011blZoMnkxZEJSbDNjRldLRXpaajk2WHFzdHZCcnI2?=
 =?utf-8?B?Ui9aV0RJVlRlUmJRYytkdmpFM0xpQ2VwUGlYS2VGVEJ5QTFjREZHMTVVZ0Vz?=
 =?utf-8?B?NWJCSkEwcGttYkt0alhwT2o4Qk5TbVFxUklaSXhOQThaaWlVTzhYWG14MzJE?=
 =?utf-8?B?MlZyVnA4ZnBGWlNxell2cEI4Uzh5d2hEMHhWR0NJa1NuMHZ3SzBHa1I4a1pi?=
 =?utf-8?B?S2JkU3pKTnpjUGQwaDlXMmo0bE9seG8vQlZweEZjQjFSNjlhRDVjaXB2MnZZ?=
 =?utf-8?B?elQ1QTVLUitVN2RtVEtVTHBBWUtiQ29wQzdOcXJFT1hLY0Z1cGVQK3FET3lZ?=
 =?utf-8?B?YnE2d3h5cW5PS1N1NkF3dFRQNm95clR5R3pWcmd4RWVwWEs3d29kdXU1ZEtX?=
 =?utf-8?B?VmhuZnQvNnVlRVprYURUeXBkT1htdkRONHI2cFFCK2NkUlhlcSttbDhESXU2?=
 =?utf-8?B?NE8wKytXMTJ4VDlpY2pwR1VWdGFTN0RFYXdtMWp0UzAvWmV4cFd2SzBQZS9T?=
 =?utf-8?B?VUxZMlErM2NvYnhqRnIraFVzSDZFTzMzckxjejJwSFFxMndWQ29iNlpiNWly?=
 =?utf-8?B?U29aVmE0OVFRQzU4ODdEejQzRjhJNVNPeDg4eURPenlaYkt5TUVyQTRBL2NR?=
 =?utf-8?B?NmhwZkRMWkwvd0NBUS9HbDJFWkZSclp1YStucVV3ZHJ3RjJBQkxTOW9pZkUv?=
 =?utf-8?B?d1NQSE9YZEpRQ2E4ZnRkVnFHaWpGUTNkSmlvcnZhcmdwMCtUU011MzRpUUdP?=
 =?utf-8?B?ZVN1RGRqQmcxVU1TdFBHNUV6RllsL3d1UTRKMFFwSERNS1VDalc3TS9hZVQ2?=
 =?utf-8?B?M1ZabytnTHB1ZGVmc3FmMmxJcjFwNkZsdjhEUXh1ZU9ZM2tKVStVZDE1aUxM?=
 =?utf-8?B?aW5LWFZtMXowZUpoQS9yMmxXd0N5RmkvNHdPQzE0Y1pyeDByQWdNU25ITkJa?=
 =?utf-8?B?RXBSZGNrZEEzU1F5RWN3SGVEQ0ZwSG9HdzlFUXZOWGxxTlNPanNqZ1Y3aS85?=
 =?utf-8?B?Wk5HSkZkUTc3YW9QV3piMGJJejU1alRaUEJtVWNsODlkMldKdEJ1TWZCKzlV?=
 =?utf-8?B?UUloN0dZdVU1U1I0TDdSS1YrZC9IcWptQjB5dzl4VTg3Y1ZPRWNxTWM0bWFX?=
 =?utf-8?B?K05ScTV4Ulg4UWFocHFtZENSS1cwZmZXdUp6TU1nd3pjMzBFVVF4RWVUWUYw?=
 =?utf-8?B?YzdqUXhOSlc2c3lidzBubG0wZUYyeEpHWWZ2dThtSExpN0RJUEcwVmtWcTc1?=
 =?utf-8?B?VWErc0YyRTlzZWpUalZZYjArWVF1cjhWUlN0MjliVEJDV0VrbmRoOVhWS2hP?=
 =?utf-8?B?azZUQkVKRmd4YXZYejVhMEY3ZVV2M1BjSWU4TC8reUhqQTdJbElHbnQ4Tlg4?=
 =?utf-8?B?QitLZEFkbCt4Y0FpVy9SMTB1Z3NuMWprT2YrcGJtWUllaEdFOFZQdz09?=
X-Exchange-RoutingPolicyChecked: T82HFSNtYFygop0PB+gf+XmS+2saKNKLOJXGwEN+tA4u7jSuTemKBnygDoU3bojJuiVA7MiPGcJgDod890bYbbmeC9hndUHsIAoAPm5u2DbDAIXzALnGxKfalqY+lAPei/rovIb/iQpAeal85zFZcLGqCPjBpfwzkL9I9t15pzJRVxMdErXSU8Blykxay8UwD9vqQZflhxP/MyBhRT2LptzfEbqiXtHI6O9AHtafA7XmlRzdA7D42kxrJ4kH/gNgvyaq0jkmBSENVAqZ9ksSgV1/v3Nz2EgokS5RChG6f6zaQhxN4bp9DXOSTU6x8OMm3576m3h7ZpqiQBhmZjHggQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ddJPDW01gzkwbk61ZEIXy5FRSD+3hK6cAQuF4YHeNmFt81pk+/irkwNJI0PDuImup0XTzxtrIauae3VbrltlkLRF1Mf2XG9h3MFO/27cnoX2AbnxvfESIEJ3uawEOtnPaHpw4gAYaqucaOmpt1QTEREmeCEEB2E0obVMegSwUAo2Os0MAk2BK99UBeFjvA0otKfQEm8s4zf0cZyYrzlsZ9H2yhRadYWMKuqcKxSoqkxikZrVxVQ3p2nhEQp6RLQeZSZ0CT0c6+2Sk2x3oCaep+Ck+XDjORYdMwbmaIqqLhV6CBPnANG8ShsEeuugqi106rNcbRyzSY/dmSCyzgQzC5f4kXVHuoVied8U1Fyu7nBkgUr6pyaIXP6VILSNSeLpfwMQW+Bcp0QRfGsys7i+GubFhW8bLOSxp/23nNPGx29cDS+XylckD5z+fM87CNeZ5EVa1U8MGxQG0u/wqdBsYZ6N1RUE0ZeiGS9+UojBla4DvKD2hhlJHzFZLHuWRPhRcm4U6ETxITNw/2ndGcH71zL52Qg4tnD3t7BoW9oq/vZ8Z0+178X881CO7BETybhes5zzPjowCCtAa6td9TWhvmPJQ4fYHREPcA2S5ZKp4gE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3584f-0158-4950-f018-08deac03d18b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:42:33.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0iKI6Exw2n1EaWKf0t2tIxDK04K1aS8b51YK82q2enG3Gd9O7Kp8WcFmBKO9YO7Lk8kXJYTA4Vz8r3WNxGOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605070064
X-Proofpoint-ORIG-GUID: E5f54d4PWf9UEd4OjuHDrnzax8bvKrPs
X-Proofpoint-GUID: E5f54d4PWf9UEd4OjuHDrnzax8bvKrPs
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69fc3460 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=5qHcskchROd5-a3bZGoA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 cc=ntf awl=host:12299
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2NCBTYWx0ZWRfX04TAER8vS/Cc
 UCNKsV9CQ096yxDZisMxKxG/aL5H5wAm9aSCI74dDArGt/Zuh29VobEJQJJsQrJn8z9olfyDEBL
 twPuy7sPq/faU4Hr9SzjocBfCTUSwHg1pZAhAlz60dV1oLCfYcLaXSstE+Ber1fqO27Z5YMS35k
 b7/LlMtV0LWfAqWN21Ku2B/hcVyizEws1mV1sPQFrdsp7C/7QoIloFiyTe1yoLZuRPM+6rV3nEh
 DgeAhzE4bss61ntu95nc8AUG5xZKLqaA2GbO2lQumRj7gnUxHXW3Auv4i5PnltZMCbZhMTjuaUz
 p+p0Mivplxlh/zrKNN6I43QrW/TW/AqKVHgFIg9MPr89ctjLUxs4I3wi5nKafxLE7cg/ghxygEA
 xUzdFcyVfOQLOi77gjc5s8iiVlKBefS7BJnOWQ+/hp4scwDEBLgwsYLjLdKf8sRWxw/17UAJatY
 KKPNWv2GJX/a3hoCGV1O6VQysmlJzHMsqVb8ATR0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_234252_773286_951C4AB6 
X-CRM114-Status: GOOD (  10.07  )
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

On 06/05/2026 14:19, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
> 
> The local bio is always NULL, so we'd leak the bio if the integrity
> mapping failed. Just get it directly from the request.
> 
> Fixes: d0d1d522316e91f ("blk-map: provide the bdev to bio if one exists")
> Signed-off-by: Keith Busch<kbusch@kernel.org>
> ---

FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>

