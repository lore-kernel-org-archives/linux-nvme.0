Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1F2C48BEB
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Y08a6Fp6p/Erb2nR/Lw/S2oPMqiXpLUSdcEbNcZwv4=; b=MIPzPn6Pe6BdEz5IJ2TPTym5q/
	JhP3p2Cjzk8g/1mbJRIz6WIUKK/a1pezi+w7kQaRpmMOGSTSl2bd1rcIPCEdpYwohs+y6mqf/G2rq
	PR141wpnu2KutdU99qS74T8/2l1bS0PYuy/djOGCAPQQzl4PaPeReuL4bupmDm0hb3+3a53gdafur
	UnB4N80PQk5IzXmcb9c1rrzuq678cv5vgmWglckcnJGkO6tVvGkmCkUiymEjZQjF7cxIR+qOrBMUa
	weuP85eB/KKq1npk1GbMK2yV5dF0laQTMDtHC4t4fWttS7ElLqw4v+MrNQyQAvWcu/bxZIxb+jnKn
	TnAifoXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raBSX-0000000CGda-0p0C;
	Wed, 14 Feb 2024 09:21:41 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raBSU-0000000CGdB-37c9
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 09:21:40 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8hfEi026523;
	Wed, 14 Feb 2024 09:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9Y08a6Fp6p/Erb2nR/Lw/S2oPMqiXpLUSdcEbNcZwv4=;
 b=lQ03eg93uR5fRqEMjG1PjYwZN9d5Fua0WKiXHNxf5AgruwzFpXj4IdbY5rOXyWt1b7mn
 bR3DSWwgu/kUDYtR6ZsVyAJAuHqjJI8n1pNFX7L4utc3k6ryNcHCwBLPg8WEUx8NuYVg
 +BRiBEGC3+6deE+sLFaVeVxA1zP9KNAjHt74PXqjoK12tDSuKu/qyUWVHh1m+bqYWmND
 Ypf7QBBHIkxyL9A2rlzj3l2JPgiv4G4iPM77wvll86Adr8BzETByC3QLfsKGWO3i75Gi
 CwazLlPdpMLnlvrHX0G7xkmCokEHLeNgpTJhIBDtZqu2b+/HNIv8n57dvjdufo+V49N1 aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8scx06ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:21:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41E91DUV015047;
	Wed, 14 Feb 2024 09:21:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8djmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8DR3R7JmC/aNbPrrBzx8xw6GKzy8ml2PN60psliOnTC4WiPIaP1X9iYZXHmPK0b+Ml7zcdC/JkiVijqw3m36B4klYKJ91DoFOogZKI6fYXYpo9N6NkxUV4LJYoEZr+lMxdJfvu30Noj0nYnLAcY4aNbtlYOGwEJpYEpZV2bbCAP4ONhdTs2wLPo5Y1gs7JTLjCXKVl/eer9g06e8s81USNjqUUQtneVwGZG5EECJJHwvCQzGt0jNXpl1ta9wh9MFpIAo0RjDDGaeRerBvjA7S89H+uRcRgp2yu2rpDDGbfsJD1vjkEMdcR8We26H6excEweoKXLbIOuCV18QrTHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Y08a6Fp6p/Erb2nR/Lw/S2oPMqiXpLUSdcEbNcZwv4=;
 b=EduDXe4vf1kUvVJf/SIpdJ8kyB/1eu7BeWrnnAX0mc5auUKrcVNLID6tpT2xS0KP+rmWskDTcCypNccLePqQ1+Xsqw6MiwIP+vnEN3dyeXmJLYWMwi4PxD++TLbfc6BWyGSq77tJIZjyOPXtiqSuxI+Qm3pb5WdQK6BAZ4ISf7qmflnuDFSuPkq2d7qexUbXZx2LI1drQ7p3cM+IIO4imL3owsuCYKrGqyK9z3w4u2RzbNxqIiWCTj7eb1NVTMIcoH0LsmbvHXwm7okaPxd0Lsa6va0glhgG7FdUoPKCBlMgpSnYpLvnez2rdfaG2hzdR5lXo3L85mFOwsklh0euEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y08a6Fp6p/Erb2nR/Lw/S2oPMqiXpLUSdcEbNcZwv4=;
 b=wneIVmvRpxEF6FjWBHFbJ0UpK5rNtwJE9Uu0Ez8VW1t/O/pKjjSThi7WHMbzhsqGs7lCeH4AS2AtS1C99F309VExJ/VRfktNtOf5S/Bz/B2JRa8PjaY2FCZO8mMQ8nVE36C/yWtIPL3/6hYpFuCLSrrfh0qjJJED2MtH1qdV3Gc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7606.namprd10.prod.outlook.com (2603:10b6:930:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Wed, 14 Feb
 2024 09:21:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 09:21:24 +0000
Message-ID: <b5af0cd4-033b-42d6-a147-ec8bc8956b2f@oracle.com>
Date: Wed, 14 Feb 2024 09:21:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Alan Adamson <alan.adamson@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-15-john.g.garry@oracle.com>
 <20240213064204.GB23305@lst.de>
 <0323ba69-dff9-4465-817e-2c349141b753@oracle.com>
 <20240214080024.GA10357@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240214080024.GA10357@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0045.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 2974a050-479c-4d99-9195-08dc2d3e5049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydLydhwPymBAJjyiMCaYpcDWxtpYUz8yGqULjCsza54dBrPH1daWPm1MoSXbmjU4qCiDKk2n9MeJZYQOD/iZjD24f1Ya+3qpPZkf3J5J9I1YY654oI0NKsGa1vEZAG4HkOrce6cEAdOjVgHxVSDYMcR2FCVtqjIc8QfbPWTTJ8hjtyAYAlG6jx3Np3qQjAjUypheH5Jw8JXDC2RDzVh7hh0oPQf5h4LQoFuM1eRWhUcCiI15zW8FGWvN/lalnY+sWylfdUlhbE0l85+3sIsmPOj4yZE7uBBk/V7pVSzO0P2XbUN1IJTEDZLktVjdv/nfzfPiL0niH/zeSpTDN8MUvbE+aqLbGBv0cgNnwiPIGvW00utoP6TZSUsy77+pSbdmKW3zuVZULXw0aSNT+KsOrqTpcwf4Ag869W8mzjk30mlhwnUkkOnbVuezJ8AzpYwZAnDCFeLfjqugQEecWhIqfalPQCvDNccOnbOUEyVLTvtZNSI5aymlc2V319mcY3lb8Al3ID/0eFSgubol/NC997Dkd41/e/GFUa6UtXH7v5T56ONoM8csFCjsODFH4b4M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(41300700001)(38100700002)(7416002)(5660300002)(26005)(2906002)(36756003)(316002)(66476007)(66556008)(36916002)(478600001)(6486002)(4326008)(8676002)(8936002)(66946007)(2616005)(31696002)(6506007)(107886003)(86362001)(6916009)(6666004)(6512007)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnNYRjJFaS9lOHhGZ0dkWlpacjVPOFdNcUlxOVl4WWJVMGpvMGoyU0l3c0RQ?=
 =?utf-8?B?WmJySkdaTGM1L1h1UmN3aHhISDZPWXdpdkxDYW9mSWtUbitQQlFxM21uSERS?=
 =?utf-8?B?L0NZYjMxTmJqMFk5dW85SkMybUxib1VHWWtCZnp1ZXBveW1rcDhvVXlLT0pC?=
 =?utf-8?B?YjBWOFFMdVhhbExTUjFwYlhpVUx5bmNXTFh3K2FkejZnR0xnU3VQblNFcHh1?=
 =?utf-8?B?d3NGYTZtQ0dlemRaUjlUdVAxQi9RcW9GbHIxNDZRL05GSGdNMHI1MEdReE41?=
 =?utf-8?B?VzhyZVNYb0xKMFl6U3Rkb0hra0JXandld01yYmprT2kvZEtwSFRwdzlpRFFm?=
 =?utf-8?B?Q1JuL3Y0Y05jRFdkZ01RS2RMMXE4bzRsYTVibUh4Zm8xOG44a0dxaUptWTQr?=
 =?utf-8?B?czM3WmlvVHJZc0t3RlUyeSt4RGtDVUdBSlFGL1dVM2tpREhzZTBsdzlnNUZ6?=
 =?utf-8?B?eTIvaUJGc25EZWVsTzZURnQwWlRQeG96M2lNMGpvdmpUWTJzejRlNGxLT3Yx?=
 =?utf-8?B?akk5M0xJZnVINWgwTlVINy9rcmFFQnhIZDdrRnhwUVhySnkwaEdEZU81Y3VE?=
 =?utf-8?B?eWVNdW9xeUUwUjlVbmNOTUFncFBVTlJCU2twSlhHZS8vcXB5RnF1ck5TTFVk?=
 =?utf-8?B?ZGsyS2VjV2lwcEd6N1lPQzNZNVNLVS9yQzZyYzFmVE1pREVPeE4vTW5kZjlD?=
 =?utf-8?B?VjR5c3JQZnZBRXphUzJudmRCWDhicVJFU0h6MGVuUklXQlpTUitwZVhjZlFY?=
 =?utf-8?B?Q2VSYUZTU205cmhPRCtOVk9YelJBVzhBMUhGazNCWFFkb043U1g1eUtkdkMy?=
 =?utf-8?B?QnBQYUdrT0F3WHowWUp2Wjd4SXNscDh2U1Z2TUloQkFWd0RNVUhyVVVEZWZR?=
 =?utf-8?B?b2ZuYWJvSkNjeGFkS3VMZmtLR245anpmaERxSFZGS1Awc3o2alFhM3BjMFhO?=
 =?utf-8?B?RkFyd2JMOFVORlBYSnNnYmx4QWRiQWMxT3RmYzYxVGxHcWt4cFEwMElTV0gy?=
 =?utf-8?B?SHFpQlRiazBkZk9FNndHbmVmRWtvZjIzOWh3ZWUrSStiS0NIK1VYczc0SWNr?=
 =?utf-8?B?UWUxYVlZNnZML0thRUJjaHFGWC9OS3NwK1UvOEF1Y243U2RVeGFIVEJLZGFS?=
 =?utf-8?B?cU9OL3JjV2NYZEc0MzVYVEc5THpkUzFBUE8ydG9CVG9MNEYxMGw2c3VMUFN6?=
 =?utf-8?B?YTFTcHVwWGtUMGlWbzM1b0FBK1RHVnF6dG5DZ2d3Y3V5bVNQNDI3N1Rod0Fj?=
 =?utf-8?B?QzRCVlFPQ1ZVaXdOZEJwblcxbE14cnM3RGZjL0dTeUZWeUJ0S2dwbFR5ZWVl?=
 =?utf-8?B?cFlpalptaFpKeWFYbkw5UG1KSXQ0bTRRZm5zS3ZWTFVjTFRpRGlFSU5JNnI2?=
 =?utf-8?B?bnZsTUFqUWFPd09EbEgxZDhLdGRUTGJQSHA0dUlMSi90ZDMxVDVZblF0YjdF?=
 =?utf-8?B?SXRYRVh0VFZOcTJOOCtDamtlRUp2Q25zTWpKUDUxN3pFUnF5N3dJYnhUZFVU?=
 =?utf-8?B?ZzJwRWtrdUNPQzcyS2tVWng4TTVKSko2ZGRFTkNRbC80Q0RXRlhoejVIN3V1?=
 =?utf-8?B?ak1YVnRKK1VWdTlLL1JiZ05lSWorY1RXTHNJYXpzRGtkVXpSQlFTRnNFVUNK?=
 =?utf-8?B?V0szMWQzcnF3U0lTZGZKeGlwT0dkRDFjSk1Ec1VDakVVa0hzOHI2U09kblk2?=
 =?utf-8?B?UWdFc0ZJWWxnQTVWd0xKM0NGUDZhNDZEdWRPU0NMZGUzLzVaVXpna1JXU0Vp?=
 =?utf-8?B?NUt0VGU0Q2REWFhRZ1N5MUE5bVlwNldobWRMaXF0RWVic1N0ejRxTk9XYVoz?=
 =?utf-8?B?Nk9jWG9rRDVzaVhaMlNLcEg0YXpXNEFCNC8weWkwK2c5V2ZYUkVhRWt3Y0Vt?=
 =?utf-8?B?L1VMVkE2UTZjblJJNFdGN3hnUTlKUjZHSy9SeW1rb3U2U1c3Q292cXdmMUV6?=
 =?utf-8?B?bnJMY0RkbkVJSnZUWFo5cFBYalJWVmxCQ3hnQ0d0SS9WL21HY2JuUkF6dHRC?=
 =?utf-8?B?YzhpTW1xTE5oRlpRTHlwWjQvbE93cWlSYXA2YlMvakFTU3dDaEFRRG05SjRY?=
 =?utf-8?B?eVZpSHAyeU1qVUd1L3loUjJ2dUQrUnVSL0xSdS9vZHRWeEQzb2lhcDZvN2Fl?=
 =?utf-8?Q?sEZkq6lZ7/GRQXQF8oeAbctvK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lLbdK62SNGETKIaCTzUpS8He6fycHqXd3/a31LPitDmMghVb0ak/P12CgjgG6gknmrsfHj3vmY9V/0Aa9J4vZVXW/KjFJIVwnOUs+w4PACpXhMT09KIoDqR+u6xX+BdXB5C46cnLtN/EDcSRSt9JnwdEp4y7dKFx6O5L0WSI+MNfxiIz/2pi3GFZnTAhX4RGQZzh+1JKdrJu5z5rgKypAiCSVlnuw7c6qbhbUz37dvhtKWREAq4stvSe9g8Ms2vSbDadZMn8bwEZHEjjssyc0MReB0Pz+ipd7Qd3vAGY+BkZZIWQitAZyGpPWdwk31Vc7+JIY6LKp9nfEV/0w1gDqaECYPwg6XTOlRWzs3jVgIcO1wfIMbO/l7QfkDhaaDiYkROhslLfaZzxpHtmW9kmVN/9L5txz5/b7vpG4WVqLq1fhcOeTf03H5L0x9jYjK6KBhKtGyoSSZ/ErJ2nlM9zyuufwfc4MY0w3mjW3AO4uEC2qZxjzrneK6D2Xu4ocJaYREXZQL59lu82suJ0+C1n3iZ+uJoAk4icg0YkRSf91p5bCLCtNPa4BSjJJmqdLGPqfN9v38fnugxdpQYg0/4cvRPXErUJJXBULWc1BqcvJDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2974a050-479c-4d99-9195-08dc2d3e5049
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:21:23.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AKgLF1NFgoBrqpY/+g2BH9v0/aBK+E+jGA3d6q0GtG4AUIZ7UBdkoN6xlt2YdHdBITL8DRzS/AqTRO+g+9iLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140072
X-Proofpoint-GUID: UFujRxypa6fGMikEDhTAIbZkb_3d17Lm
X-Proofpoint-ORIG-GUID: UFujRxypa6fGMikEDhTAIbZkb_3d17Lm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_012138_935552_8ACB1B00 
X-CRM114-Status: GOOD (  21.32  )
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

On 14/02/2024 08:00, Christoph Hellwig wrote:
> On Tue, Feb 13, 2024 at 02:21:25PM +0000, John Garry wrote:
>>> Please also read through TP4098(a) and look at the MAM field.
>>
>> It's not public, AFAIK.
> 
> Oracle is a member, so you can take a look at it easily.  If we need
> it for Linux I can also work with the NVMe Board to release it.

What I really meant was that I prefer not to quote private TPs in public 
domain. I have the doc.

> 
>> And I don't think a feature which allows us to straddle boundaries is too
>> interesting really.
> 
> Without MAM=1 NVMe can't support atomic writes larger than
> AWUPF/NAWUPF, which is typically set to the indirection table
> size.  You're leaving a lot of potential unused with that.
> 

atomic_write_unit_max would always be dictated by min of boundary and 
AWUPF/NAWUPF. With MAM=1, we could increase atomic_write_max_bytes - but 
does it really help us? I mean, atomic_write_max_bytes only comes into 
play for merging - do we get much merging for NVMe transports? I am not 
sure.

Thanks,
John

