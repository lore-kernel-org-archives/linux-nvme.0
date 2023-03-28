Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF27AC6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yHukS5LRstXSdX+9qpyNe+Dm1GVOFQ/5fQ80uWskgxQ=; b=4uE2GCM/+skbV0GyPFM2NqJcu5
	yFbbgP/O1c8h0OVdfcSybf/QOwDOL8xcMP0xQBO+CyPlrDU3p+1KVZaA6YqjNCbs9eF8JFCWuwWLo
	MrU8+OlKEKB4O68/kB8a0RUcMoKGql2xr8bmPux0ACdDeDb94kuyXtEgFljV7BQUW/HG5G4AFYG39
	jbPGBS9EcY9MZhXLLPsqXAN4G73JIFyuXN9KUls8/DlWFJd+a5TGNt1IhukXvAke71+scpdnxssJa
	zkbsfCunVks8fgP8FwCu52XLy4ato+8O3p5OQ20prSr4r/O4H9F7S4Qa7R67yi9OnBQM71XIRSvUR
	tkMZzwEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phGCh-00FpMq-0D;
	Tue, 28 Mar 2023 20:46:03 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phGCd-00FpMB-35
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 20:46:01 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SKTosS020406;
	Tue, 28 Mar 2023 20:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yHukS5LRstXSdX+9qpyNe+Dm1GVOFQ/5fQ80uWskgxQ=;
 b=CY5WAOWoO5FtQVG+UDM/lj3tj/pI8ouI4lQdO5xY21U+UdES13eSECFMpPuY/qmI78gC
 oijjdNb3+YHMu9433h1UmrQLpkVHH6qlfNaHD0KOfZL8ODbpg7gB2h8w5SCifQsdq4lR
 myNlUaTdT+hYcaQSdwdo/P7SolmBIOhuoAxFYv/C5mdItaQPJo2UIoE2MuyNFU23rHyn
 e4ZIEWaJm1+EtzaLyeBW61sqX9bBDdIUGauQCuWNFbzqOM+XknwjYSAowNn7PerCDQ4W
 b3G+7dxTEGnq8NPyDFRCrW6UGieqk8TKY0ABRq9qxFyzU9s9r1Wq9afn/MqzyL5YO1vE Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm7aw0137-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Mar 2023 20:45:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SJSeCi005513;
	Tue, 28 Mar 2023 20:45:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd6xnj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Mar 2023 20:45:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4VttoR1FsZmK5U18ddGu+mf0SA2AhZuAgvrW3hPDiziamN+pT4sMdLO4bK2WeTPSGEa7MO62iybaxfJiNNXRWei1F6RSXJaMHciMGJMc4G2i79GRv2F7LJVQmj/rOuGr6tzC9GkR+g+za/4D8Fni67201DpNkFpW/fqq6Q/9zu6hlEXW0ton/KbYsL27pP/bcZPVzyMUg10uMEmgCXQ+bD83ZwcI9pLoas4Xaf43oq0JSMOJ6c5tWst4rmcLTZkU50wK3AZJm6ItGqNhb/3OB+VLXaQMhy1+PBDFJh1vB43eDM5pTWarV+lppZNdZO7Qx8iHovluBZY0F1z9osz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHukS5LRstXSdX+9qpyNe+Dm1GVOFQ/5fQ80uWskgxQ=;
 b=PLMWcgItJDG1meHZLkZ+tGE5emPdBGR94t4IwoeVqKM6A0kvgSqV7zpynhIfHvy6DFRX9g1P1HUz+iZ1dJbuIGAzg5sjCxCWE0+7MNn0fJAF3nopkgzMWGbaQqQDY4bdahmVdAXA6IaiihyajE/oQ5JzxFqe/56mF7oM9DwQ8stY6p67Imm6K0NVZEcOuYQXe2pIE4GYwXNiJlHic/smpLsDGSEhbN3p0IBGIfUEL9/lqzow4J51IvO5zNdOP41ry1xMGk5a9Vd+GAObS35nvVVEpcIE7ndZhO5G0/ue3GMtad9hhdzQc7u1JgazJuhi6hMe/mitUWJVCuMcrRUHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHukS5LRstXSdX+9qpyNe+Dm1GVOFQ/5fQ80uWskgxQ=;
 b=ku7Bqlp6JJ1C4W69P1g8+I5NZvW5HwCveKUcA0ln3Cx4AWxz4Qp2tNHhgK2JpbsPQB4U3Bw8SB7UaR/7ID0oI2bMVPc2dOVYSZ3d25gIO2olXxngbP8N8v/rNoARIdkqonT9q8cTKbiD7qEowZjV2fs5DYTtyvFWRn/1GwYXQyk=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 20:45:52 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 20:45:51 +0000
Message-ID: <89ee30c7-7c7d-b0c6-3234-07e698d211ed@oracle.com>
Date: Tue, 28 Mar 2023 13:45:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC v2 2/3] nvme: add error logging opt-in
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org,
        sagi@grimberg.me
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
 <20230323230316.2914077-3-alan.adamson@oracle.com>
 <20230328005735.GC21497@lst.de>
From: alan.adamson@oracle.com
In-Reply-To: <20230328005735.GC21497@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:5:15b::20) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dd6244-c0f9-4815-f1c9-08db2fcd6b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	QtKr0ws1NiXH/Aa6CgCsBIQWPjwdkY+YjyLzigLp8Zqj0o4/ka/TO3fzK0MGGL83iyfCUApldyN2eh+wwuYgkAFPTRcbu8ZhuwWW3oQE2IJN3otPiWZfZeoaH4xdH423inQGn2fJH84RSOknH+a6DpjG2FcvbWU5GwaTkt/p7xGxoLNix6NMumubf4f9dht8QfIihfcy8DGs410rvAiptJ099iYMhQJgZm7ZBYCb571cl00l0WtZwSOTbwH2s+jIYqVmSFndrb1uKW+2bQkdWKYbWc1pQGUIhX3MqvVFzcpDC6E+/QAhUf7UpMAcWsykvKmgIWqZQdWEemQjmpth1i6bDD5CE6Z9JisHAgqSpQy+EUUPb3C+HuIgD2sFyn8cQBnnuAf/T0EnSZdi5A8H2cvkEurbrtzorQbmwYf33XZzO/1yP6tnrbOTpZ12yea5A2NdS8ouW2GhTWqELywUDHk9UprieQc3XCI+ry4eVfvHiP75uh9EV2uqTbjPP+BYhteuhXZi+ct4ya8zZlSYUx1b9RKNo16DK1VWntSNwa8eQU4kKpum8YWdbammlL25Y7vXwtoD1YbAc2W3oJ1iANwgz5FauzGezqgn56tLc222uV3ZohPri7tcipK9EEOO
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(36756003)(5660300002)(478600001)(41300700001)(4326008)(8676002)(38100700002)(66946007)(6666004)(66556008)(6916009)(66476007)(186003)(8936002)(86362001)(6512007)(6486002)(2906002)(6506007)(316002)(26005)(83380400001)(31696002)(2616005)(31686004)(53546011)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Q1R1SFl5aFM3RXJSeDk2b0Z3Y0ozODJHZ1RDRXdxd2tCSTNEa1ZyVm4vYytS?=
 =?utf-8?B?bXdMaGFPWmJJZm91ejlYSmRmSGdtd2lBalFvSG51amVyY003MktCS01zWkVB?=
 =?utf-8?B?bHp5NGRQTHZTQndlYWtobWp3QTM2NnR6MUpoR1VQZURic2tuNlZTWlltcXRo?=
 =?utf-8?B?dUdGLzEvOUE5dHRoUHpTUlJlK2Qzb056MkxwcTRNREMrb2phTkI4R2l3SHR1?=
 =?utf-8?B?YXZnbHczbGFINkpmVE1yNVlDd293bnRNNlBVUUdiemZzaXZqdk9yNmRaNmVt?=
 =?utf-8?B?Ylh3RkVqczFWRWJFZGo3OVZNSHorSlE0cFBDZ2pLblIwN2c5Q2Y5WFp4U2Zn?=
 =?utf-8?B?UFZvQmQwWWxZVVRha05NQkZkYmQwRkF1eFg5VHBtN2o3Q2JZc0pIQkFmOTBF?=
 =?utf-8?B?dVFjZld0MlhsNG05Yk5GMmdUVFdRSFRoR2FJVnZ2VnBBV3phU1ZobU9FL05P?=
 =?utf-8?B?WUg5elFrdk1za3cxb3FhTTBneGxnM1V5SGRuMUtQczU5cE5USWFvNmdlQTd1?=
 =?utf-8?B?ZzNvbjlYc09aWmoxcnBIRFRna01sSWJpZGlLUktCamZqWFVzdjB6VW9NUDcr?=
 =?utf-8?B?L0Mzb2lTd3JCb3BhblRJVHRKQ1FCeDczbkRSWjNYT0YrZnNFcXBjMzF6VVMv?=
 =?utf-8?B?YjBHb2NDSW41MG0wbVROVEx4QjU3QS9zMnFoT1RISzQ1amxrdExpMCtwWmlV?=
 =?utf-8?B?RjRNU2g4SW8zeitSUEFpamgwUmZoUmJ0SThzdFhRRDNaQjJENTdXaTAvYURC?=
 =?utf-8?B?QmZ5UHZTdHFGQmlWYklFcDBsSWV2c3JqbUtNRWpzbnkyR0pWL3dVMHg3OTdk?=
 =?utf-8?B?cVpyMFkzUHVIamhabWczZzdQaEcvTHNPbXIrZzJBT1RaNS9Pd3FVSlFPck5r?=
 =?utf-8?B?cFFVdUxHbWdVdHlPZWlUQlF6NW5lYUVCWHFnbVZycjZpV0ZZMTFuVEI2d2cw?=
 =?utf-8?B?Tm5ZNHRtL0ZXaHRuTk1SaGk4RXhIaHZmZnNwSjdESHRmd1VqTEpSU2l2amxa?=
 =?utf-8?B?TFhwSUpWVkIzWWZ1YWdDemxiMEhGRkNOTU56Y3J2cVVMbnZmQXJaTkpZcW52?=
 =?utf-8?B?elptMGJUb0RpWmVEcDg0TTFFOHF1b1VBeThkY2NTT2QraXBGcjVkdFZUN1Bz?=
 =?utf-8?B?QmlhUnBENFhBV2NxL1EvcGtiQk1oTGY0bkl4dnROUE92aWlINVE4UkVaNG9i?=
 =?utf-8?B?MVprQW5rMDZWM1Z5RTN2MmJWYmNJMDJlM1MrQTJNYkVLMTNtV0xmMEdMYWls?=
 =?utf-8?B?YkNsWFQ0b3k5RTBxRnljWHVRY2lvK0cvYjFodkZtcVpKQ1RYd3h0NGlGbW9y?=
 =?utf-8?B?NmZ1dTFlMjVZYWFRN1F6YlliaVRydGg0Sk9XV1lOL3F6YkJ3WWRrREE1ZFNT?=
 =?utf-8?B?S2hONWlIYVMxN05GZndIdDA1Z2FmdGNDbXo3U3RMTDRjNFNLelBzMVFZVSs2?=
 =?utf-8?B?Z3FlUHB6YUNNMVBoZFVDRlZ0YTE1TUxUVWZQS2wvWSt6Qm01YzZCNkZYRFBP?=
 =?utf-8?B?RmJqcmc0aWl6b2RMSVMzUWlHMFFwOElCaHBZM213a1VnMlRPRTByMHVuMWV1?=
 =?utf-8?B?S0dUaVVWakRtbm1JS0Z4VFVYb0xoUmRSNHhJWmNYclY0WnRPT2hFaVpVV29H?=
 =?utf-8?B?c2MrWDRTcjJJODdmM292Y0Z2SW00TVdWUSt5b2phaEZsd3RXZExyTzJabjF1?=
 =?utf-8?B?d0U0VERiSWZKUW1EbHNjZlVzcG5LdStkZFcxWUMyeXBFMCtJSGZVekJJcXNH?=
 =?utf-8?B?MWRCRHY1TmxaVlRwaTlDaFNsUVVZSWpyOGlQYlBlV1FTa2dWZ3JVMkc5TVRa?=
 =?utf-8?B?NHVqalI1Z3RsdTl1d0RyZmErTGZMZ1pNM2g0Wnl5cytNN1I0REtaYlRVVCtz?=
 =?utf-8?B?TXVFTnJ0Nm8vdnFQZWdZelU4azNjclNnSHlXVEl4b0FsREU4c3dvbGhyUGtx?=
 =?utf-8?B?SGRKNmZNbThJRWNPcnFZcGxmM1NJNmtoVGF5dVVKRVoxZXJTdmg2VFdhUlFl?=
 =?utf-8?B?ZXlsaG9mTThERkxBdHRzdWV2KzRReDcvYkVtb0RFTmVJKzhlcFJmYWNBSHFQ?=
 =?utf-8?B?Y0J2T3pXaDJlVS84Y3BGWUw2MHBwWTdnVUFLVjZYT3I3dlYyYkN1K2xneEEz?=
 =?utf-8?B?MHc3UHo1RzA1Q2tEalgxUWFRbFlrcU14ZjBTdDB6OHlGRklzR1N0aWU2YnE2?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	ZMzAZrnCSWI+SYGAUkYanoyQ9cMbx1PbGJ1JzJFQSjpKbBMtNJW2ZYa9h+tlf1OvxJIL2uJC94Zw0J0ImQhdXZaHBuvOiKmMxPbJ5rDb+JKhoFrsu6dgcVrha+R3EgN0tsw2ee+jjP5r2fdC6QtRdTWlvIRD/ByEsp9NeJboODPjY3Ys/3k0dP5VbpdF47ud+PCIWQVt87z6rGr7yemQstIwSm644Mpthz2RW9UBwmaQKqF9rgfxKMwj9rAJ5+Z3ig8pGcqPjsW8Kf0O7R3y6EroH21xTZn+tDjZ70KAivtTwmKyRkgnBf17GrGexSPe8gOt1wbgO9D0aHSf1YL/eoujrxv9E/CG+nt0NZ0gbOwVpk2T9jeWECAq+vmWX56PLi5F4qt7gZRRzIat+JoR7J3Yui73JhEUvYqqGuQ7SuMeZ8YUh/Ee6gjsCGa1HtoXe2ny4v5dtU0eXgKWyaM3dURBNbugJz7QhVOzmq0hF4seY+aDXUnPCtBSs+VYzd7JQa6WoZPlc84dn9u4bHN8CeRAVEqWgwiaQkGzptjnggGmcxrPPJAeECiWItMz+AfJX3WeExjYOYohkWqzEwOQvRjAzrjmWhmArYdsVpdbHs5G7oNfeYtI2C1pXcTNcku+NOnXc9zQpD4A4TsCK6eqFpAlPHD3Yx0x4F284N+Yg22TaXkUIqedwIrQg1INbpTkQtf5gDAzgA/tE8SoMZ9W4HTKYR/i9Z3GxNyrA7woAXGt8ZqDNC9YwgZQ5I47D0+t3vjGjjnDPkrLasVkoEM/efeO+gArhMKzuN7z035LOPp61SDU4aio9B8iCEwNBEkJM7pgTWb6XKxLOSpYy5kf3/ZKoTjPTkgsGCza9PHVayebKAMOK/uMQsFdYOtMjNvH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dd6244-c0f9-4815-f1c9-08db2fcd6b2b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:45:51.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuijcldjGo95pXdr8QG8pxXY/jCg16JWN0rb+LZc6p6gPz/wYejbMuZ8JHFHa+luDnsdOgU1fLJn/Jokad7ncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280160
X-Proofpoint-GUID: KOJ7xsiHGSKRHGpJoguM0Q68fEURSg4k
X-Proofpoint-ORIG-GUID: KOJ7xsiHGSKRHGpJoguM0Q68fEURSg4k
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_134600_003697_A3D53C1F 
X-CRM114-Status: GOOD (  23.98  )
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


On 3/27/23 5:57 PM, Christoph Hellwig wrote:
> On Thu, Mar 23, 2023 at 04:03:15PM -0700, Alan Adamson wrote:
>> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled error
>> logging for user passthrough commands.  This commit adds the ability to opt-in
>> to passthrough error logging.
>>
>> To enable passthrough error logging:
>>          echo 1 > /sys/kernel/debug/nvme0/error-logging
>>
>> To disable passthrough error logging:
>>          echo 0 > /sys/kernel/debug/nvme0/error-logging
>>
>> By default, passthrough error logging will remain disabled.
>>
>> CONFIG_NVME_ERROR_LOGGING_DEBUG_FS needs to be enabled to
>> to enable passthrough error logging.
> Any reason to do this in debugfs vs sysfs which is someting
> that we can a handle too much more easily?
>
> Also why do we need a config option for a trivial mount of code?
>
Putting it in sysfs may make more sense and not require debugfs to be 
configured.  See below.

Alan


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 53ef028596c6..24b4dcbfe819 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -337,6 +337,49 @@ static void nvme_log_error(struct request *req)
                 nr->status & NVME_SC_DNR  ? "DNR "  : "");
  }

+static void nvme_log_error_passthrough(struct request *req)
+{
+    struct nvme_ns *ns = req->q->queuedata;
+    struct nvme_request *nr = nvme_req(req);
+
+    if (ns) {
+        pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s: "
+               "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x 
cdw15=0x%x\n",
+               ns->disk ? ns->disk->disk_name : "?",
+               nvme_get_opcode_str(nr->cmd->common.opcode),
+               nr->cmd->common.opcode,
+               nvme_get_error_status_str(nr->status),
+               nr->status >> 8 & 7,    /* Status Code Type */
+               nr->status & 0xff,    /* Status Code */
+               nr->status & NVME_SC_MORE ? "MORE " : "",
+               nr->status & NVME_SC_DNR  ? "DNR "  : "",
+               nr->cmd->common.cdw10,
+               nr->cmd->common.cdw11,
+               nr->cmd->common.cdw12,
+               nr->cmd->common.cdw13,
+               nr->cmd->common.cdw14,
+               nr->cmd->common.cdw15);
+        return;
+    }
+
+    pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s: "
+               "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x 
cdw15=0x%x\n",
+               dev_name(nr->ctrl->device),
+ nvme_get_admin_opcode_str(nr->cmd->common.opcode),
+               nr->cmd->common.opcode,
+               nvme_get_error_status_str(nr->status),
+               nr->status >> 8 & 7,    /* Status Code Type */
+               nr->status & 0xff,    /* Status Code */
+               nr->status & NVME_SC_MORE ? "MORE " : "",
+               nr->status & NVME_SC_DNR  ? "DNR "  : "",
+                   nr->cmd->common.cdw10,
+                   nr->cmd->common.cdw11,
+                   nr->cmd->common.cdw12,
+                   nr->cmd->common.cdw13,
+                   nr->cmd->common.cdw14,
+                   nr->cmd->common.cdw15);
+}
+
  enum nvme_disposition {
      COMPLETE,
      RETRY,
@@ -381,8 +424,12 @@ static inline void nvme_end_req(struct request *req)
  {
      blk_status_t status = nvme_error_status(nvme_req(req)->status);

-    if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
-        nvme_log_error(req);
+    if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
+        if (blk_rq_is_passthrough(req))
+            nvme_log_error_passthrough(req);
+        else
+            nvme_log_error(req);
+    }
      nvme_end_req_zoned(req);
      nvme_trace_bio_complete(req);
      if (req->cmd_flags & REQ_NVME_MPATH)
@@ -666,6 +713,8 @@ static inline void nvme_clear_nvme_request(struct 
request *req)
  /* initialize a passthrough request */
  void nvme_init_request(struct request *req, struct nvme_command *cmd)
  {
+    struct nvme_request *nr = nvme_req(req);
+
      if (req->q->queuedata)
          req->timeout = NVME_IO_TIMEOUT;
      else /* no queuedata implies admin queue */
@@ -678,8 +727,10 @@ void nvme_init_request(struct request *req, struct 
nvme_command *cmd)
      if (req->mq_hctx->type == HCTX_TYPE_POLL)
          req->cmd_flags |= REQ_POLLED;
      nvme_clear_nvme_request(req);
-    req->rq_flags |= RQF_QUIET;
-    memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
+    if (!nr->ctrl->error_logging)
+        req->rq_flags |= RQF_QUIET;
+
+    memcpy(nr->cmd, cmd, sizeof(*cmd));
  }
  EXPORT_SYMBOL_GPL(nvme_init_request);

@@ -3418,6 +3469,37 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
  }
  static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);

+static ssize_t nvme_passthrough_show(struct device *dev,
+        struct device_attribute *attr, char *buf)
+{
+    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+    if (ctrl->error_logging)
+        return sysfs_emit(buf, "on\n");
+    else
+        return sysfs_emit(buf, "off\n");
+}
+
+static ssize_t nvme_passthrough_store(struct device *dev,
+        struct device_attribute *attr, const char *buf, size_t count)
+{
+    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+    int passthrough_enable, err;
+
+    err = kstrtoint(buf, 10, &passthrough_enable);
+    if (err)
+        return -EINVAL;
+
+    if (passthrough_enable)
+        ctrl->error_logging = true;
+    else
+        ctrl->error_logging = false;
+
+    return count;
+}
+
+static DEVICE_ATTR(passthrough_logging, S_IRUGO | S_IWUSR, 
nvme_passthrough_show, nvme_passthrough_store);
+
  static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
  {
      struct gendisk *disk = dev_to_disk(dev);
@@ -3926,6 +4008,7 @@ static struct attribute *nvme_dev_attrs[] = {
      &dev_attr_dhchap_secret.attr,
      &dev_attr_dhchap_ctrl_secret.attr,
  #endif
+    &dev_attr_passthrough_logging.attr,
      NULL
  };

@@ -5125,6 +5208,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct 
device *dev,
      int ret;

      ctrl->state = NVME_CTRL_NEW;
+    ctrl->error_logging = false;
      clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
      spin_lock_init(&ctrl->lock);
      mutex_init(&ctrl->scan_lock);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..dce5e6f7260c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -248,6 +248,7 @@ struct nvme_ctrl {
      bool comp_seen;
      enum nvme_ctrl_state state;
      bool identified;
+    bool error_logging;
      spinlock_t lock;
      struct mutex scan_lock;
      const struct nvme_ctrl_ops *ops;
-- 
2.31.1




