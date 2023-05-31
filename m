Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D757C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLwZKmvLhtNtl/1/UuMaRgul74ZRLCiXL6ONmGnjiJ0=; b=pXBHNYD8dbCsIumoqQicKNzuXK
	l+RLME1KAliWk5cF40KQWb5BsHPUJAJ2XvFenQk1kagyMGgkkcTG5eyWJMqaoG8gGZazj5OhhbgUF
	90FiLuL9OshQxxxVYjTwS2OaxGK60n1yS9j+7+b6Rb4RcnfDrS+nw80LhzM+K+FD0551TclPTjLhd
	EuxpW7QNXO25SmHCUxBvzdkQ1cs41UsNqeB1o6wQXTyJOybLfH2ShXmtpN4CzlVJ/e/pgFY1edUSh
	LdYBMNdqhD1TB45SeYQyY0+oKk6E0DF3XehziU7P9JpIzc0VEDbLrPYLhKEF9M4O1bjNqkSq9iXje
	jWn68vHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4O71-000NM0-1o;
	Wed, 31 May 2023 15:51:47 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4O6y-000NIn-2P
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 15:51:45 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VERMIe021983;
	Wed, 31 May 2023 15:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PLwZKmvLhtNtl/1/UuMaRgul74ZRLCiXL6ONmGnjiJ0=;
 b=uIfjou+QXuuBFIZ9y+5DmOi139aBD3qWhCGZ5l6NZ8bkKrw5YZ/aP+rBgYjiH1GkJbB8
 62Yml/41GPTPWdvI9Ma0jfi0Hx26nwt1/kddcwQs6GqI5RQPStjw3txMgOtcWgAJyNNJ
 3SmtErI/4ibFQm4nC5dqkNatbInCrz0FzdqOSJEJa76y9J1cCsn6O4nUA/zMEnS4YFuW
 Bif5qS+iADAXfFkvpkRhrj4B2JFiUsF/6+0mNKovi5UfFQdp32V9VvuTgxvHj8jTYO4g
 IgdB+E7k/d9VZAKog1IqVhFf6wBA+5hcoXItT175fbLfQQ97O+UPb0o6ccbhMsNwufOx bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjp8un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 15:51:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VF0YLk014631;
	Wed, 31 May 2023 15:51:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a5sgu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 15:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL0fG7h9vyF/r7wwfOHAZ13nbgq097mfL+4xtlDwDCXCPF9JptuA+xBjT/1MmOKMMEeaHWPhmXb8pWO4+niC8fFjijg1dbrqPGPeg9kmN7NxuBpxdBv2sT4llqu+0X19XTlW7cnwfHglUbEbPJU/f/HcCuokUe/OGUXJpkNtA3q0Jd+IioP+vCU20emRfHtIXibLOUDHcnISUcxoHHBcX3kAMXjmoeh3hM4pKVFN6KGQD7ZZ5TacCzCaTcL3ExvAbiuDcYvG7hM9A4Um2RObRm+c1zf9/GS1Ti+i1LhBWc4EPcCqjRn0uSmdvZixQa7XIv8UKDfLA4M8NNaTSMTIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLwZKmvLhtNtl/1/UuMaRgul74ZRLCiXL6ONmGnjiJ0=;
 b=aoUqnnrcmLH2KNouRaXMtUgFzpvFXVSoiaURBRF+H3Jlxoi7oe/VUYNs2/kzgcsayjJU2ZUw1I4B1+SHpZ6ssCmgPJbV5i8jr0Qzd/3400XJ27hvA1AXTB3Y8vfZZ5pHAd9ZTOsTNx211Jc67fSkxMnat1pw9zCb34N17BP/gRS1fBSG5ZQDfEhXEjBMz6wD4QshoUth66FHu3rSdO1ItYI5pbzkSmsBEaZ3ifYNDGk6t8sTp1TzgZfK0czqNeAlHEyethkUF575PdEndTtNIsbK3d2xCzSYm3zAZujBTDH4uzTaTCjj00XHMIsnpG7pg/xOyzlF7ixfSWCQzWWFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLwZKmvLhtNtl/1/UuMaRgul74ZRLCiXL6ONmGnjiJ0=;
 b=QDhsa+CFQ/EMPIw1NmK24zEUpMpIlUl7L7P4kXlcup0kDOY8ar/tR/pHhULlq0xJ7m2mYqaLcCJJgFpgbnzB4srRMJY0r49gfSLdwGy06c1r1pkxpuXhKlrJwR7sOU7rk5XMHsavAn/Q3HsTbw432feH5RyI9+buu/Rn/jn95PU=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 15:51:23 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 15:51:23 +0000
Message-ID: <8817ec73-770e-5a59-ef5f-b959857ab784@oracle.com>
Date: Wed, 31 May 2023 08:51:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] nvme: fix the name of Zone Append for verbose logging
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20230531125454.676077-1-hch@lst.de>
From: alan.adamson@oracle.com
In-Reply-To: <20230531125454.676077-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0125.namprd07.prod.outlook.com
 (2603:10b6:5:330::7) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa37fdb-cbaf-44d2-67ee-08db61eee259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDjihGk4vCwscRTA1CoBJP1UOlkpeDJZLIbjBq5gilXATnnun1rjpZEsCVqeDrrW9gylc8iTugdUcZPkhUefMSZKvdwQLkypZpQ+yD+qcdfl0eOl1snU8zfaIZlKmgJYnF2KxCoO8lubdwYIZr+XuHu+OZFujz2Uso2hw0bh7d/MU43hc3yzuzhOddZlkkL+XT0zA9loGQu7ba8JNfVbnIBKvUD+KgQfnZMO/rt8Q4Vmn4jNPuSgxi+6RCrmRTB+alnPhg5Jd4oeAAsQYYFZflPCS10Hhz/LfVnCAHsXovIa5WcrDfSx0CQKh5RfECDJXYcWCZtuz757ih9wkFYFx72k1OqTXt8/OF22o38Vgl6PLifWncjxUUo8FRsJPK4ATfUlpw4sjJk3/pwiJlLsu/8E4ZBMEZ99pmkJbrfLn+VSNWJB7++YyjOF0akSXEcKc523M3Lw7zbsTl3urvnKkGbi8PxdNM3/w879HahtcG44pfI4FAGk6TmssWG40G4OtvyKLlDXlXPihdOidCsXmurotYfz0+M7KT0gCbj75sgiUdZ3ni6U/mCU0S7E/ay7R6OH+0wnS4GNOmscGmUdaNhguey2lLs8wPw7QG0y+Q3BdAUG2W96d9oAR9Rd5qgy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(4744005)(6486002)(2906002)(31686004)(186003)(41300700001)(86362001)(38100700002)(31696002)(8936002)(8676002)(2616005)(478600001)(53546011)(26005)(9686003)(6512007)(6666004)(316002)(6506007)(83380400001)(4326008)(66946007)(66556008)(36756003)(66476007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1U3L3pTNVR1b1BWNlI0anNidEZLS0dDSEFHbnk3emdweHh2WnFQcUxSVmhC?=
 =?utf-8?B?Q2JHeDZzcVZZZ25uTFpFbEFSOU5iRjFQclFTaUN5L1c2eG1zM28rZEZjdmV2?=
 =?utf-8?B?OXZTb2M0UWdLSk5GVjFKek1qd1dQQ3RqcUlDd2ZzcllrYkpsclRBSHFJQlhP?=
 =?utf-8?B?YVZXd09DTUxQV1lEN01qUDNnY1pBVE1SY3pkMnpuN1dCZFZBREZwNytjLzJI?=
 =?utf-8?B?NmZPcWN6M1pEaVMzV3E2ZWZJZnluRmdnbWl0djlMWDlxcVZnVDRabGphQXgr?=
 =?utf-8?B?ZERrNVRrMFNpeEhGc3V6SkFMR0VFQ0hFSlFBblpvRVpkUXN1R0ZkYmp6SStB?=
 =?utf-8?B?SE5EQTVua3ZtZlZGSE9sTGhna3JnM3hFZFJRSURML0R1VmRDZFJUMVFDUXFJ?=
 =?utf-8?B?NC9ReVU4U1IxeXpmMGU0OWVqdmFEZXh1MHhjZlNJcENINHFWaW9UUUVoQzZO?=
 =?utf-8?B?aG9XSEhnZmRVOHBFRlh2K1A1bGZIRmFnclpxTVFNUlhmTkZhZVNPZ2M3S3Bz?=
 =?utf-8?B?NEhPbHQ4NW1nRzVEU2pqNWdHZjZnSnJueENna01GdHlRWk9uREZHTHJXbGR1?=
 =?utf-8?B?MGhpdlRxTVNYREJaUlpKanRDUjNucXhCU0RNVG1Bby9nTmpVNVNsRkQ2Y29w?=
 =?utf-8?B?V2pYK0tqajVQUkxFSlViZFZqYlBGakxtSjFrYlBxUC9nZWVpa0dzY0YxYmtJ?=
 =?utf-8?B?RG1QTkpNbmNrQlZtSmV0TmtZbUtxQUVMQ2Z4VHRqbk5wZTNtdkZRUDZrK0JX?=
 =?utf-8?B?SzhubUlqcGdINmorMTVqZmd3QjMwdENBcFB4U3JTT2M0ZFdqOVl5dGhyb2xP?=
 =?utf-8?B?STVydDlvbjRkTG55UDJWb1RtZjZqYlNBSDJ2dDVnT1NqZ1EvcDNMTkIxOU5i?=
 =?utf-8?B?dlVkekNyZW1lTEJkbHBrN2Fwc1NBeSszY2JEZy9EOXB2OXlDMEphQ0JpeHU0?=
 =?utf-8?B?NmtOSG9sTHloQWlKRkpTTjhMVXltSFJVRlViakt5S0RCZ0NObUhrRXlVakxD?=
 =?utf-8?B?c01jaUZuWEozeW1mTG9ZbkhBcS9Sd2VqVXpLa3g4Y0Fvb0I2d05Xa3liVkJT?=
 =?utf-8?B?ZmlGQTBHL0dMOHZpcnhnU2hoZGQ2WkdLQ1B1d1VGUzJPNXJORUlpeE4ybkZF?=
 =?utf-8?B?enR4R1dydVlSRWJCTmJBSmdXTk4wR0pFeXU0WWxHbFp5cGxHTzBuSzFQM3E4?=
 =?utf-8?B?VURVRkZQYTluOG91dFFFdHA1VFRTNUNzRytSV0VzV25wWXRRa3lnd1lqUzlX?=
 =?utf-8?B?Tk9ncFlQaTAyTXlud2JrTStGVUFINkg0ei9WRHRVR2JlQllVZ3dVT3JWdlhZ?=
 =?utf-8?B?S2ExUXhEYmViZDlDcGpGeC9INmtING5VZXBWUW9XNEZkRS9lZG5UUDN5dnJW?=
 =?utf-8?B?V2FUaTJUeHFUS3A1Q0M3QWRpNy8vZUJNL2V0OFdtaEkxZjdSb2kzZVBubXBT?=
 =?utf-8?B?NGErRlNRZU5QcndsSDNjbUJXd05MWlFwNjR0alFEWGZpc0tCY0orM1NwbW9K?=
 =?utf-8?B?SVI0aTZPVXdWdnlmYkJDdVZTMTg4aHFPeDJ4aElxT3pNWVhzSVRiMGpPY1V5?=
 =?utf-8?B?UUsxZFVxM1F0MG45Z1JrcnB5TDhINnNUTFc4VGZwbld4NnJybFBtUEY2OVhI?=
 =?utf-8?B?bEhabWVZZVJwcXM0M1NpaG1VdGRsTzQzY0pwSHAyRUcyT010aWZwNjd1eFFl?=
 =?utf-8?B?WlFvckY1RjJwVm9hSjFTc1FRNTN5TUY0dzdwOXdWc25vN0xsMGZJbURyYnhz?=
 =?utf-8?B?cHJ6VmlwT0Q4RDB0QnpXSXBmS3hzQURscUhMWWJlZFo3YVZFQjJDLzhHVFUy?=
 =?utf-8?B?U2FBYVRhTS9iQThiSnlpeTY2MVYyYmsrL2czQXhGbXUwL3dCekJsNkEvMHhl?=
 =?utf-8?B?dW0zSmhXUDR1aHA4TmhDVDlNU2NNZWRQeWxWZGM1SDlTRFBBeEJTdUMvM3ps?=
 =?utf-8?B?bWlvY2kyL0E2VFBCTU5yanhKU3FJRVhzam9Cd1dDSk9GcmhUbmZ4YzZhelhj?=
 =?utf-8?B?eHVPUnZNcmgwWm42ZWcwMzNiOHNnajVrSUx2UGdOY0tVeTErRU81VU54R1BY?=
 =?utf-8?B?eHlpRlk3YjVSSzBxQ3dnaCtOYTIydW1XUVRtNW41VmhyaGZaSDh1Tjh0ZkZY?=
 =?utf-8?Q?WvrmthFzpzceVW+e66YhZm/vh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: andP2axsRnFQfKhvvKWvCggIwS3MQWP8ZR7cRwgL/BtJPW/A8MNJ7ATsBY+pocfT5Ti39krClPGdPmzroAHUamAMfY2KzTSFaF+HipJi8i3OV19EBOhuGF84ZW43RaCUp2kAuXTyaIiHlbEoLQajBnkYhKpWFicUv495FUZiX+uX9v8eMu4+2Z0u3pN/6Hx6R9htfw5eHgV7vW4+5UhrsWv4TcJ3804RO0cnQ0ibXkmSeoTfKBJd+ksEQoNObskmNCCrZxy36kWWsaOgjptKBf92a9+1IAMVQmAoO8WARc146ooqWby9P6JIOI06EyCl7YGNIPIFXG4wmluOV/mmW7HnlNJXzKabmShugJOxlIsj1dy4j5u9/cGlrUMia/GdN6lgj4fRrl3IVxgcix3OnrJUwrZf0A1TF+J6sGqdcxPG/avM4/vTjeqgdmtN/RrltXowHP/p8iRpmT2i5VwMejrU7Oc0kOuQKXBcFjypuC11h9DhJ1pi7Q2KLevjNW9JSPSr8iM3VhajeGOn+hnyIuLYbwl/hYgUMrGxiQ31/0sD8Hw/tTE66UR379dOQXWmZiCVBNGOuLoe+MF+E73mtbV21uLJbHFahl2invTqLGbRfLk4xH1IfamCD7owZgKq4d/KYwTOW5vMrePBuQ+tBhbIuL0M9WdyA3s5oklhAXUGayrEji3zcBlBgesKd0DTlIrbaYRJTUDvu2pAGLTJUklQwkNcDBRT+a6VVnImpF6uXYBBkNemCaU95+8cB6FxV84YgKw0glfDBp1HTxkgXx00xdtXWjUzO/P9PvJ1ZDyE6neeINiRdTqedS4jcOolDNHFw+bO/sUgrwh5sBfdCTO0sOLZlpVWelTEnFfDuN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa37fdb-cbaf-44d2-67ee-08db61eee259
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 15:51:23.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgOxj/ZsrNEB4Ddrfk6pVnGmvaCA64YYtkXm9ImhU+akqJHto+cNb46alhtmSbQVy69oMgU09EQ+FNDnpFI4Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310135
X-Proofpoint-ORIG-GUID: y0Ba6Fa1setUUocor36Th6KRIShZeBxz
X-Proofpoint-GUID: y0Ba6Fa1setUUocor36Th6KRIShZeBxz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_085144_795977_C34CB2D7 
X-CRM114-Status: GOOD (  21.14  )
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


On 5/31/23 5:54 AM, Christoph Hellwig wrote:
> No Management involved in Zone Appened.
>
> Fixes: bd83fe6f2cd2 ("nvme: add verbose error logging")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/constants.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> index bc523ca0225486..5e4f8848dce08e 100644
> --- a/drivers/nvme/host/constants.c
> +++ b/drivers/nvme/host/constants.c
> @@ -21,7 +21,7 @@ static const char * const nvme_ops[] = {
>   	[nvme_cmd_resv_release] = "Reservation Release",
>   	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
>   	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
> -	[nvme_cmd_zone_append] = "Zone Management Append",
> +	[nvme_cmd_zone_append] = "Zone Append",
>   };
>   
>   static const char * const nvme_admin_ops[] = {
Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

