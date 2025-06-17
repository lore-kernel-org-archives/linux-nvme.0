Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464FFC71136
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G6Y1BhF/sdfkxaCN6pa1y5Ir9sYMe9Ogq5LG+ZiZy9I=; b=thgtRh09nc20ZfDrID3jVAZQ1r
	rn1cqNGpLOqPe3Pz+hN7OxUdbMtHjLwgDuBB8MPGR9YkJw6vdaaAbp7iyC+btkCT8Y8/CAq2Fl5uh
	TJaVZYLq/+wCdvDr/umjEuysYBsF/5RfMUJkzXqHSddsWp569GopK1uNMAgenmLltoTWX2mJ8pk6f
	akFfoI6pn3CK6V9ldgVz5iq03eQe6VwCCJ1sKt+9fhSAQNP2U4ZOd+vHURLV89Q6Dz3c23UOavQlM
	TWR7ycKf73SpMfyV83Ksfo2NdkfgOj/pLElXuoPC3TFZhscadFzEG7JwOZFbRd1qUiqHQjMNfxMT3
	64zifvdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaKj-000000084ci-46GZ;
	Tue, 17 Jun 2025 17:42:53 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaIm-000000084Ku-0dkL
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 17:40:53 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEX17v003995;
	Tue, 17 Jun 2025 17:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=G6Y1BhF/sdfkxaCN6pa1y5Ir9sYMe9Ogq5LG+ZiZy9I=; b=
	Tme3KaGerVuY9JeiyJYJxoDZ6iXGm8SRR5odkn5p9InFHnG+5aamkfVOk5J50ARq
	h1cOGb8oZvjZwKAg6IF4WB8rdAtJjY06radWU9y9HdoZ8y/gDAi8fPwb2eOE5eax
	7m9VzBHsgWsFHYnASoSesv7Kmpr58HGf5E7tNBqtV9B87oT3l7QCTJs+ZpgcbT37
	8eISYKK6lZvFEYgzEthkrcr+Hmrtv3SmQ8AlA296nBaVrYUOcuNd0b5NREOFODDw
	TioTBc4naRZsjn1DuwjnbnhyZTJTOOply47tXvN3g6tdDZPAcWQFInrer53tlq7B
	e6dHjgNR5d2d423KJyxodQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv55tg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 17:40:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HGOANr032092;
	Tue, 17 Jun 2025 17:40:40 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh9j8n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 17:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1LZN+Tmwyr/UYZvklHRfC10bt4ZSpQ0cG7bZz3GDQvdI8C3kQpn8WXMV+swJMwy7iXO0zjvqpzbNikc3lJsJHBsSmevUnJ44aytLxPMbyGEFDVsuhM+FZQvRoaml6iOfUfbEW9tLeDd++DJPvBHghYdeqo7DxfD49/sQC7dTfp4FrJXRkJiKibo8dVtqvgcv81us1eK6SPdQhPznS8+a7qf24nriBl/DvLP88PZnoEcj+kSmDlE9xQKMLD8FdTvb0oXtdtrQdWi9UjBu1j92vF7yi5GQndbk0+GdfaAbTQEkUFsYxeG4eqiVY+PlEB033jzYDDdH+kGS5xn5xQbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6Y1BhF/sdfkxaCN6pa1y5Ir9sYMe9Ogq5LG+ZiZy9I=;
 b=CHCXHZN9Byi5ETqBW6o72Tt9jOxKu3WkPtfQQlogINra1HqnSm09knITKizVhUjMZLDkueNb5wEAWUK1jxTcaHpqvHEJ2H3B+nAru7FamM4gQLQwADReHfMkR6dGyvuBWXW5b4BWL3KdjF+WBHcppzwwIVg/4Hh3QXm/i0Ovz9dinp2b9wN6FlssIpxL6+Uwdm0M6pfRFlyIDz1tWE+BYdy1iHT3H5DbEhcjCZ1klenRtOEmZP+YUHXxAHmrQ0M+2MSfnASxtbPD00namhaA01ziTU/j7B04Kwvlniu7zd8Lk8n27Fs5JjSN7ccb9umG+Lf5xnzSTValZJBbkjS49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6Y1BhF/sdfkxaCN6pa1y5Ir9sYMe9Ogq5LG+ZiZy9I=;
 b=M0ZIEWbpWkJ2Z25J6j0y65LCgGzz/xA3b+FtlLJ6F5WOLskAFw8DFK7O40e1cnwiXyPngcWgZQTNpVnTAS/GNwqg/tLpzIgOcCYci+aXx1b1TBQT5vN8rUleKcwUZwXRnSN0D8fRm85NtWfWIxn/fp0zT0c/bifZy294woulcv0=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 17:40:36 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 17:40:36 +0000
Message-ID: <790a0419-4087-4181-b290-15db01ac1d34@oracle.com>
Date: Tue, 17 Jun 2025 10:40:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: fix atomic limits check
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        John Garry <john.g.garry@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com>
 <20250616053627.GF1148@lst.de>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250616053627.GF1148@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: d61e593f-6fce-44f6-4421-08ddadc61175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVIvNHp1RlQxS01ubGdEUXdxVkxMS0VCV2x4SW1RUTBJNnp2cW5MdDBFR2tI?=
 =?utf-8?B?aXBOZStuWEZBbE1SbE9CWHhpbS85UURaQkNOU2FXUnRUbG1jYXNkWHhBbXJj?=
 =?utf-8?B?WElQNXlLZGxkTUZneDBFL3BzSm5CYm9HLzJTb1RmOHplQXJtODBvaHJZbjkr?=
 =?utf-8?B?WVdUT2V3eGYvWms2c1JHaTY4eVo4WFBQcTJhNkxZRG1PQkpWNmJpNVllcUNG?=
 =?utf-8?B?YWxzZXNOUGVFTFBweStKQ2pqTmt2QThEclJmTTE3ZjlqbFNCNjFSREFkaktY?=
 =?utf-8?B?RzBvZ042SFI1RGpJa0VpUitNaEcwSStVSEFOZFlnVmNQL05GUUs5YXVjcXZW?=
 =?utf-8?B?SFV1VVFvUVVuTmRXOVpuZGo3TGxjaVRLeDBOQlBpNm9kZHUvck9QOHVDYXRv?=
 =?utf-8?B?S0JCUDBvaXRqcWxjMHVqT0FXM3Q3YWVpcEJRams4aGRqcDR6am1XSUlBTGZY?=
 =?utf-8?B?V3JrdGRwUm9lQy9mU1lRWlVyckFCOFBBUTkzMGQ4aFNFTVNISndoZm5IYk02?=
 =?utf-8?B?ZTBkQURxQWZnZFdNaUg2SkpvUUhmNTNmMHMzdXlqRjFBVksxM3podFhGQnRC?=
 =?utf-8?B?dUdTdVN2SU1iNUYwUFJMUWRld3NQdmRhYnFFM1ZnMUpnU2lEM0NRSHl4d09F?=
 =?utf-8?B?QXFEV3FjNzlGZTVKUWx1MVBlTWNONlVtV21wd2ZRaTVTaDRxYlBsNnpYSjUw?=
 =?utf-8?B?MlZIL0ZEd1FMWWhBdXhBN3gxVUMzbmEzSnRPTkRJd3hCdTI0N1dYdVNyaGo1?=
 =?utf-8?B?cHp3QU9ZU04zODFUMURxMHVqdjltTVQyTzJDWFlWM3lVd2FEMUloL1hyUWNo?=
 =?utf-8?B?WDQ5bkhqOWtxY2xJcUpoTmc0aTJjbHdWM1k4djNMS3FTVmgveU8zcFl0U0JF?=
 =?utf-8?B?Q0JPeE9nVVJNc0N0blZUcitKZjVpWFJrdHdzTnI5SDBjSzBTbG1BTDAwajlh?=
 =?utf-8?B?dmxYTHUwZmJ0UmtGOEwvdVdRL3VPL1dJYVgweUFrWjBJcnBHbVp0YUhOSnZh?=
 =?utf-8?B?TGIyUUVHamF4WXBoSVBlTmliWkRWT3Q2ODFmZlFCZFFPNlhBUHZoUk5TYUVM?=
 =?utf-8?B?QTJjdTc4YVRsNHRsS2I5WWZVeDBFcDRQY1RQRGczMmdEVWNUY1pybHN2YUVM?=
 =?utf-8?B?VWlWT2JUTnV6cXNTWVppN0tjTFcraTZKZzlONkpoRHhDZ1pvL3c4eG1YN2JC?=
 =?utf-8?B?VTFLYVRJVWNOR1hEZW5GYVpUVnNoN0R2aDJGQWt1TS9aMFQ3aWhGSUhhWXZz?=
 =?utf-8?B?VS9EY2JYSzV0aENJOWRhZEZnNEhHNmNXUmR6WnBHSlhaV01qVHJjVE9PSXo1?=
 =?utf-8?B?cGw3RFo0OFBWcUQ3cm9XN3c3aDdPWGNDUlczUGlmMjFpalRjc0FHd2pzNWFz?=
 =?utf-8?B?c0NMTjRKMDllUGZzN2lIczhXRi9wTFB6ZkJxbXd3VExKcWsrUkxCMHNMWkxi?=
 =?utf-8?B?azR4V25MMnM1clQ3Umo1MHY3U1c4M2Q1ZzMzQXFldUJXdXBwb0oyTGFxWmNO?=
 =?utf-8?B?WUhnTGcxc0h6eUtZcjN2TnMrYjgzZE51THN6ZENjcjNFMGlMV3JEak12VjhN?=
 =?utf-8?B?STBqbU5tWGxHcFkwRnVubVhLZU5hcnI5SUwwbUlNU2RkdE8vYnA0aWNlSUtB?=
 =?utf-8?B?RUF5UE1PQmQ0Y0NnT21lSndxY2ZVNnVoVFZsRnVJbldlSFV1TVAzWG5iSjdv?=
 =?utf-8?B?elpwVlFpaitxT2Z4R2lPK29XcmNoMTRpczJTa1p0ajRMUXFMZXVPMnpCRktY?=
 =?utf-8?B?bTlxa1lkOUR0WXNiejFyWWZUWldraU5DK2hnclF2S0VmdnFhWUZJdnVpcENs?=
 =?utf-8?B?Wm9NbU9Ec2kzUWRyQmdDYUE1V3Exb01hOVFlMXJqSVJ3ZVhkWXBESlZCY2h2?=
 =?utf-8?B?VnFrSzF5SVFTUXA5NW0zOEw0VW1tSmdQRWwreW5QcTJzOGdpbTlIY1p0N0hu?=
 =?utf-8?Q?A9dFP3pQpSo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRaWHZsVjV1dm5nM2NGODhvQUdOcXpmR1BZNlprWjNEenRDajR3YStoTnNS?=
 =?utf-8?B?RkhhTU5LZCtIVmdvUElINU9KZ2l3djZCRGRYRVlkNXZFQ1NYZTN4QnJqd3Fj?=
 =?utf-8?B?ZmM1ZVd2cmFHRHBUL04rWDJxZDYzN0JRd3Rhb1lBR2xnK1lGUjNuRGhSRVJp?=
 =?utf-8?B?MGMwa2grRUd3VTRXNnl1WmRzaXMwbld5ZWFkMGF6a2ZpV09YQXQ1QzMzR0ZV?=
 =?utf-8?B?eXNiWXYrYzFMN3UzTkhkRFQrYUtYSXhEVlpGZXRjUExRVEk2eVhlbHBaUFpF?=
 =?utf-8?B?Q2twVExOWTlSbUZSSk9mNnlrRGlDRlhHU2VTdExYNk5iOC9IYUFlSzY0WUpN?=
 =?utf-8?B?cUY5OStmWVlzNG1TcEhCY1lJUStwQUp0K3F5WjFYNnMyTkJ5cFlha3JsUXVy?=
 =?utf-8?B?NUtzWUVHVXhWakpFRFNHd0xaMGdHMnlMb2NOenFvQ2llN2E4dURaRXVUNVlu?=
 =?utf-8?B?WGI5eURDRGgwUGRSbkJVV2dyZFNTaWpEY3d1NWVjWmpSU1d6YjY1MzhKam1U?=
 =?utf-8?B?aFJxQ0tiT2xwTk9HazJBNWtZN1ZIL3dxY28xdG9XeDc1Q3lCMkY5Q2piODF5?=
 =?utf-8?B?bWhiZUxMbStaSU9UQURTZEhLSUlVbEQ4TTdzTFJiMWNUWFZtM1FwcGp2QU9u?=
 =?utf-8?B?RlRNN084NFV2dmx0OFJnYStPVGpWb0hwK0d2bnlvc3Fua3c1TG5Qbm52M3BZ?=
 =?utf-8?B?OG5hRk9zb0lqTTVjRkdJU1FiT2g4UmpaOUFSSE1oT0RtR2VWYUg5UFcvYloy?=
 =?utf-8?B?S05NbHhvT1V3WDJJVDhYamoxRENpd3pXa3FlVHQvYmJZUFpNWDY1RDlWUWxm?=
 =?utf-8?B?YzFzeWZOQ3NUdStjZ0VBeVlNazE5OTlWNERoelQ2dnJ4YkJQeVZBZWhScEI4?=
 =?utf-8?B?c2tsVjNZaGNhOUwzQm9iRDJYcWxKK1pwYks3TDVZZUx5NGxiMzFhWFJsbFg4?=
 =?utf-8?B?TmRiMDFHQi9oSlh6a0d1OTZZRjQ3K3F3YnFFa25CalZPRXVkVUxCNVJnb1NM?=
 =?utf-8?B?elZSUWdBQ0x1VnpIeEZEcmlrRzhadkJrTldyWG9FTVloU1llZkhEMXR5WHIw?=
 =?utf-8?B?bXAzNENGTDNMVWMvK0diMjJocm9xRkJBWHV3MURsWm4rOHptMmRCejlKa0p5?=
 =?utf-8?B?QnR3alM5c1AwSkZyUTkxb3ZsU3lMTG16SjcwZmJ5WGIyMDFGM2dyZHpZclg2?=
 =?utf-8?B?aFk5OFJEalN1aG1Cc0IxSzBzWEJMQ1ZUNHpSdWdNaWUrc3R2MXhxdHBFV0Mx?=
 =?utf-8?B?WlpSZWtEcU56TjBYUDZwb1I5cGk1K2R3aHhVOGU0akdUTUZmTjl3NjBSR211?=
 =?utf-8?B?NGNiYVErQkRvL295Lzl3SytKRFc1R1ZpUjJFVGZ1emRZcnlRdjQvSXJWbm8r?=
 =?utf-8?B?bGNpSHVVd3YwSFd4eDl5R1ArYk1FVmtRaEJxRCszeUpqbUVVOEhWR3hEZU1w?=
 =?utf-8?B?T3IyRUxoN0tBRXlrYmgrYnlSaitXRHpibHhYRXExU3I3aEtBcDNZelVobXRB?=
 =?utf-8?B?MHFOUThlQW03dlZTWTd4ZUFzemlMY3ljaWswYUpMUm9TWlpnYnpMOUkvbTNq?=
 =?utf-8?B?RG1aMUhaVkMxb21YZlN1YjlyNExydUZHNEJiUThhQlJENEpGYk02bHJKUWN2?=
 =?utf-8?B?LzRFaVdTTWpJRFp5eDNtVkcxdk9WR1haeFdEREczUEFUbjd5YVZSWENzQU1E?=
 =?utf-8?B?YmIrTUVJaUUxTVZsVlVnQUFPdVo1ZFp2bDBEZDVxT1ZTYysyU1BZblIzMEJ5?=
 =?utf-8?B?K2xzR0NzeFIwazFoL3J5a2oxYmFxOUMyYVhPNGJrRk9hbUJsSXh5M1dSVE5t?=
 =?utf-8?B?U0pzSzkvMEFGbDZmallBRUFpWDFpN2MvOERRNkx2WlpSTkFkVjRZcG9IQWwz?=
 =?utf-8?B?Z3ZRRjJ2Zkl5bUt3MkgvV3lyLzVrUW5IYWdWVHdNNXBiRytTNVlOL1dYNnZm?=
 =?utf-8?B?RDRrTzVSV3RmOWxUekQ4UWJzY09kbnJmMU0zSUpoTWduZUliTWtma2VjRWVN?=
 =?utf-8?B?b1hwMnJvSVZxUVJkWWFBeE1LM2FaTWQ2QlhaU1NPSGdLUzBRaVlRcFRxSENY?=
 =?utf-8?B?UStFNGlodnNyY3ZGYmlhdENOOFFlUU9NSUhsUW5zazZRQlFmYUVEZGROK1Z6?=
 =?utf-8?B?MnVsd08rR05xZmpTckk0NHp6c0VJUDE2TXZVWnRzK290b3RlVTdxR3U5ODR5?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1xnAGuVg+MYR9lCgLQZS8ThFO5dtZkYBvJBgIRP7jKivJQmGQcisl1qPBI4NPt7z6IQcUadHjcTDtthMA1g3OdqR+V9eV2NFLt9BBRx1kB/C2bqgS1TrT9qiPo507U7NDqMdXT6hU527CsIDktLRclC4ay6u6xJjOzVqXNJFYwyKlYurJySQs0Nfg3YGVZ31qUPIUfJC7eNQREtk7Da/Zv6eEQ7Y6t2tiPkJ1S9n/BoiiVRGiNlAqeoknq4SibBMlIn3LPQmm5HUphVNMAG1jDM+4asut41x4G8lB0pyDUxroPHnq7zU3S1YTLZKC33cgMLbUn6Q8qp8mrbfZ42pyqI8QcldFZi8lHLRBsH8hjHcs5XoprK3bY7tHb6yVm304Jjcd3CSrMNjXsbsdyngHNUXvMzLQ8ZC3/aUTkXO6kOxR7qOvuiXpqDMDTy5mSj0HI7VNgl1VV6c+iAsd6jmC2Xbx5jdVFkYxWWCecyztN4JfZ76NrJ3nSyp0Yi0HzvgtJWlRnRssrXXF+4+N+OONho+gpgGJBHCWtxIzfs6gGAqV+hBRYsRCnG1pyIjEodkMl1Dxkc49SH9Jm12O5kLxK8s+etDe4QSMBNuRXKRXSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61e593f-6fce-44f6-4421-08ddadc61175
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:40:36.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbpMq/9oJyLU3cJ2e+ReUzsdA5XcT+8H7AAVKcC4iedo5w6NqrCzQYn+DU/J7EKUnSZ3fLi/SjfrUD/kxVeaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE0MCBTYWx0ZWRfX1WZFaUpnM23L EmX8+XMaLYULVUluTzSU7oKpwPe3n14RQIsabTOjJHgCFcqb1hvrCkf+AZrmcaKA1Xbh9uUGpCF T23VtWHPL4sm4OCjls2Om71vTnFWjlrt3PTFQtPXu+F4CxgjciXBvWFpLtvtv3RJG3eVgAYt0+S
 qSZ56GEZwHb7DCXdoSglNdhFIGuxexU2RrhGKInRbgU71J24kUMq8VOYvRpP2ZU1eBFtHBFKNpT 6dSkJZITRrC8jQRm8g4ZLyGxZMB54d1++dEGnlWfqwGHR6dcso8AGSFEJn6p/xRVuA5lYCqZYt4 FI0NABgt7g6ErM/YyZ5X3LXop4oiY4zQL6V33zYwqP2YjrWZNkdOpvfGZTeMpjttbqmfDf6jR+e
 sQYk7LV7p57HHz3/cK6a224EPbrKitmOcvTj2N0ekm6YN8RfvaqsGLX9FlFyOPOluIgNQED2
X-Proofpoint-GUID: xuIBvl5EQMQhAP2mCg5q57YSm0RrfA68
X-Proofpoint-ORIG-GUID: xuIBvl5EQMQhAP2mCg5q57YSm0RrfA68
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=6851a899 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=F4Vz1Lf7OWsQ1I7tzg0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_104052_306083_FE26D4E3 
X-CRM114-Status: GOOD (  18.78  )
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


On 6/15/25 10:36 PM, Christoph Hellwig wrote:
> On Fri, Jun 13, 2025 at 02:22:00PM -0700, alan.adamson@oracle.com wrote:
>> Some testing with my qemu-nvme atomic write setup.  My qemu includes ns
>> atomic parameters that isn't upstream yet.
>> A single subsystem with 4 controllers, 1 of the controllers has 2
>> namespaces.
> .. and none of the namespaces are shared if I parse the command line
> right?

Correct, nothing is shared.

>
>> Does this look right?
> I think it does, at least if I understand the setup correctly.
>
>> Before, we had a single atomic_write_max_bytes value per subsystem.
>> That's not the case now.
> Yes, with AWUPF the value should be different for namespaces with
> different LBA sizes, and with NAWUPF it could be different per namespaces.
>
> Maybe we want an extra sanity check to catch a subsystem reporting
> differnet NAWUPF for the same namespace attached to multiple controllers,
> even if that's against the spec.
>
> And I wonder how we can come up with a testcase to validate all these
> checks..

I changed the config a bit:

CTRL 0 - AWUN=31 AWUPF=15
CTRL 1 - AWUN=31 AWUPF=31
CTRL 2 - AWUN=15 AWUPF=7
CTRL 3 - AWUN=15 AWUPF=15
     NS - NAWUN=31 NAWUPF=15
     NS - NAWUN=127 NAWUPF=63


and his doesn't look right:

[root@localhost ~]# sh testxx.sh nvme0n3
+ nvme id-ctrl /dev/nvme0n3
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme0n3
+ grep awupf
awupf     : 7
+ nvme id-ns /dev/nvme0n3
+ grep nawupf
nawupf  : 0
+ cat /sys/block/nvme0n3/queue/atomic_write_max_bytes
8192
[root@localhost ~]# dmesg | grep -i awupf
[root@localhost ~]#

AWUPF of 7 isn't consistent with an atomic_write_max_bytes of 8192.

Alan




