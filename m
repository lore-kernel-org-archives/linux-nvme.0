Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBE0C2BA15
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/DSwXN+RcZBr9yjJmFoR1M1uo8nksBM2EEAYVdtdzp0=; b=yqe9o9sxFjWOk0G+7VqHwdtAVd
	Mpjiu5YpIj+OF9Pg+Ia5QeDQq3HpOKA2HmQZ0POHFsX6ApD8RfmMfPUy+oz7Y5Xl1ArL4HhNdF+et
	slA79pIl8tOpKnjnMIZF8XHwza6Hw/wa4F1aIGOmdSE9/GxcsSHzi6KSBFF/HE6u1fBBA6A8WFzr7
	kxwPmcoX3dJiwLpzfyrVNyrM2HI9M8n9SKYlbmKKuk6Rk+NxTP+t2ld4BQSHFSOeZA6e+E9JYzI36
	umrsrbbAaNyX1mnT2IMobdgyt/BpLrZtMPuVwAN/+1i+QGP0Hpr/4My10z/LQzem6Kw06gMormlsa
	hFZhhF6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJWCw-0000000EOSH-2DdZ;
	Tue, 18 Jun 2024 10:36:58 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJWCp-0000000EOQQ-1IhH
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 10:36:55 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45IA4C6k019458;
	Tue, 18 Jun 2024 06:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=smtpout1;
 bh=/DSwXN+RcZBr9yjJmFoR1M1uo8nksBM2EEAYVdtdzp0=;
 b=ABMIMQg8IqmNzQjYr5jPf943lsBEWW7lmHroSAFQQerhM2cMNS2SRF+5Pypv9MrVvaRL
 Q+n7dJaHY27hfrGnOuZ+KGhOCBDy4bm6fOp1IOXbpArptyRGOlY9Ta8gaSKuhuA3N55c
 GA3oHtZm2VChnicQxmySV8dAcPdTdu/tnMH1uIbrgUKjebRBpaW/9TwW0BvVwFLTkGo5
 tr/QaVoSojyMAEmSz8py66CmBTwIBTWuYmco9Jt2YxuLbOOkL5ZtZCe4E1MGUMJtLlDF
 5b3MKuAndBUcId2+/m5oRTO4oOzKaM3ImJCtqxLkFRm0dtokV0TYVLOiF43igoOn0dKE VA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3ys7mpk7xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 06:36:48 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45IA2rAB018028;
	Tue, 18 Jun 2024 06:36:47 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3yu84srfjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 06:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9oVk+EBA3KpN7ydsVrNfQSs/qQC1+RenRUwdApE5W99ym2MStIgNucQeOmsZktXl9CbvcHXCF7fc5J0ksVyz1HQkGiiNmHt6LtBf4c+XUQf51gYuulOrs+l+TUaIcJsrDTBbuTiyb142+sr8/kC7MVINgH3mx2aFuYGSw1jacjS0h/2ryUCmiBbDbAdvtkuiOLkdRt2kQTEAYh7yUonPaOTY4E9B/nQDo7rbQA2vxNFyK0XECYGzaFqIcPtCQbJ6m/0s/0bir4DSwj4vDpUSq4kpHyx7fv7WX6ESKoi2juW2iHfmsFBo1cWWdqMyAP066s952w7k5DmtjZBKZVicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DSwXN+RcZBr9yjJmFoR1M1uo8nksBM2EEAYVdtdzp0=;
 b=KrQW85Uz4MJoIonlSwUGsgN9Ju2J+t1ap8TCM5K0UGMv1JXPuqkOrwARzktFDl6X3pkPHdZzIg0mTggQMmNnSIT5AzarZb/JxmOkl5756WMadCMOn3ENt+nd703snwXigO5uujpFjo9WbOmpPkJIhtGsp0M98JO1IMagBprI7ei9EkPN81bdMm7l8NLNVbVtQl3VLFs+p5wyu/vQ0tQ5UYQ2fiNx8pIFY8cA4j3WQXR15AbPcIYB9toEzia9UM6FHoqdZY08vLvLuOhLOYYHEP7aZCiwvNOeLwcO9gpMXt9usF2JcWAkWJBCKVX3NkLGaBgIT/t/Fj7pkKUfqYLvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SN7PR19MB6922.namprd19.prod.outlook.com (2603:10b6:806:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 10:36:44 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::893d:3ce2:a0ab:1a82]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::893d:3ce2:a0ab:1a82%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 10:36:44 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: James Smart <james.smart@broadcom.com>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Grupi, Elad" <Elad.Grupi@dell.com>, "Engel, Amit" <Amit.Engel@Dell.com>
Subject: nvmet/fc.c acquiring qlock after kref_put
Thread-Topic: nvmet/fc.c acquiring qlock after kref_put
Thread-Index: AdrBayk05EXus9Q8QpuDoYsPW8AcAg==
Date: Tue, 18 Jun 2024 10:36:43 +0000
Message-ID: <CO1PR19MB4885F3B9D64B34E230A16EA2EECE2@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=9967c4b8-88f3-4cb3-b3a2-ec9f0b7f2524;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-06-18T10:36:07Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SN7PR19MB6922:EE_
x-ms-office365-filtering-correlation-id: b57cff68-f560-4a5e-98c3-08dc8f828c33
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?cUU2ajRMTWMyeHZEV0JwQ04zaXpnWHk0TnVNSXBSTnFualNsZXN1SVNKVk4y?=
 =?utf-8?B?eEFzMHp0RWN0eXlWbmtoWHUzcEFWOWt6QXlMN3NXQjE0ZEhTMDdzTlFOUS9L?=
 =?utf-8?B?ZnVPa3B5ako0Ym1lY2FUMkRQd0dCOHU0UWl5T2VwM3JYMmwvQ0tTRWcyWi9Q?=
 =?utf-8?B?VVFobzl0NVhzbjBhVGxRTnRqYUJoYUpnYWZZbkhLNnVJQXJ3UGFjcGtqQkFD?=
 =?utf-8?B?MmUzNEpzeHJwMDAwaFZlTTM5cE5jdm5MWUE2QzJFaTVuL2E0R0JRUDZqZkRq?=
 =?utf-8?B?WnNTSnlxLzI4ZkVzSnEvSURmMHFid0ZtVnNMSVZXdWQ2QlV3NHFhQVlqODlW?=
 =?utf-8?B?YmgwZzRkSW8rSXFCU3ZSc0h1c0NMWEUvWG9Wd0lIbm1MU0x3bUYyeGdsVG1M?=
 =?utf-8?B?Z2o4U2xRYms5UWNEYTgraGhyeFJzYWRGWHRlcVNhYmFvSVQ1elVUdlVsNXNK?=
 =?utf-8?B?WjAyOUtwdXpnUVhtejdSYmY0UlpkSDQvcm5obUptQkJpcUZMRkMyNDg4aWxw?=
 =?utf-8?B?YWhsQnlqT1F6RU1reWJ6TlluSjk0c2tCUmNJeWpvYTFmdEp6OUFkcFpKcXE3?=
 =?utf-8?B?cS9CRldHbXh3N2tzUTI2RjFJR1MzNVBYTjhpSlNJTy9oMDByZjhCOVNXSE9N?=
 =?utf-8?B?dlRINFFiY1Q0QkdhTUdENkdBVks5N0hjWDVZSkE3QmFvdEtnTHRuV2RYL2hh?=
 =?utf-8?B?c0Q1N0h6UDYzVzZHbkFGb0dEWk5GeEIyaDFoYUROc1VnNXMxSkVwbDluc3Zi?=
 =?utf-8?B?N0dQc2pSQ0duNE8xS2c5bys5eUJjSVkzRHAxempxQUZDK1dkbVdJMVFQbHdM?=
 =?utf-8?B?T0NoQ3F0cUdxd3R5aXI5VEUvTWo2eGROOFhMQVVmbjhvNm4zdWQ2SU9GbWFs?=
 =?utf-8?B?bVU2cm41NmJIMUFYYmxzbitFZHd0MVpqUU53Z2ZTRUFLa0hsd09uTnd6TWMx?=
 =?utf-8?B?WkMvZXlUYmpKNzVmcDNXNFN0dEhUdlhPRThFN1piK2o5VmtBWk1aWmR3U253?=
 =?utf-8?B?L1RmWUU3VlM3ODFKTEVIUXptcGgzTVhhUDd0VjdqZXZSWUVrcXBBeHN1Vkh0?=
 =?utf-8?B?M2FqMmZtd29xeUpxRkFOdlpnYk1DYWN0Z2Q4VSt0aFFTN2phLzhkTWJKRVJQ?=
 =?utf-8?B?QTZhRmp3Tmo0ODgzek9nVU8xZWY3a3RrY0VMRlgzdFB3TDRhOURyNGErR3ND?=
 =?utf-8?B?ZlBabGFUdk4wOXFUMlhucXNjd2lRQjg2VXpmSHBiWmF1MmtRYU5oTkhWZjRG?=
 =?utf-8?B?dlI4Qmg0aUJHM3RtZzdML2c5YkhRK0pOTzhpVit0b0lZdDhPN3VSdDNKTW9G?=
 =?utf-8?B?YkdMeU1BeGcrR1htaXdreXBqM1NlRDY3enpZNWhWMW9mczBXWFJzNkVMeGQz?=
 =?utf-8?B?WThrdWZQUU1PUWZYVG91WEovVHV2TkZMODhpUnNyS1ZXY24yZUVqbzdpTFF5?=
 =?utf-8?B?eUxDVG9GcEo2VjNYTnBmOGh0Sk45U1hZYVY0UmFveVZGRk5DaTg4YWRVMHl1?=
 =?utf-8?B?V2NVeVZpWUZoN3ppeGozNzR3c1Z0KzkxUGdwZlJ4azI3clFHbEMzbUZ5M012?=
 =?utf-8?B?azdyZVdEM0ZIVUYyK2t2aHZrQWZKekU1RG84WFJkZW1JYWxpWU1QVmQvNWZm?=
 =?utf-8?B?S1FOVmh2MjBtV0Fva1lodDVxOVVXczZOdEVMZmp6VGp1N1BncXNSenFqcmZX?=
 =?utf-8?B?dlo2NlZseWhydVVWZlNaTUtKVzd0dWpSck1ObkMyMEVGcWMzRndaNzJWRHJZ?=
 =?utf-8?B?Vm5leEJQajQxaHAvUTNvUzhJcDF5cmxTSGs2WEwvT2VpbE9RWE5UelUrUFFu?=
 =?utf-8?Q?x9LB6cS3k9hjaJ7lOYhyhoBxA8hgflz0/XEpc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUxxYWI5QzlTcHUvTUw3NzRscjBLNGFBNlNiNTlJSmlFcjZpR3pVWTNXQVNR?=
 =?utf-8?B?Zmc1bEJmdzFOVzB4aHFpNkZQUGlhRkJKOWIzMGxTTFBjTFNUM00ycVdUY1cy?=
 =?utf-8?B?NUJPUmlaK2c2ZlZqM2Q5TmhHSm1aeDFJZFFpemZqTTRkWUhVOHFZTGpYN3k1?=
 =?utf-8?B?REhzWWVCSEtURGNkWDJnOUU2WHB6UTV2L3psWG9naWRKeXhHSTRvd2hyMXZ2?=
 =?utf-8?B?Zk53dno3VE1iMVRwdEptSGZMdERzYTJxZSsrZDk1MjEzWjZIZEFBMnlmSUJW?=
 =?utf-8?B?a0xlM3NxcllJQ0k4bXY4MkQvSHZWLzRQajFjbUVGMnBXNGYyZWpWMGExUGJx?=
 =?utf-8?B?b2lEenlETFhOK3BMMnlYSXlkSU9ZVDhMWGl2UDlNSHZ6Wml4eXh6K2s3WlV3?=
 =?utf-8?B?VmIyUmhLNHU1UlJRSjdLNFcwRXQ1cVlZeVJqblBodFMvUmJBS0pIdExiSXZ6?=
 =?utf-8?B?YW1FdWhoT0pseTJYVzlmK1piWkh3Zk1KTzJYU1NDTGh1SE9iMHJrWUIzYTMy?=
 =?utf-8?B?YkFhZ2wvU0oyb0U4TlJRV1BSZVRMOEdQV1ZNdkxvSUJWSkR2dms3bHN3RWpj?=
 =?utf-8?B?bXBNTGczV3ZOdFhFbWZmZDRVZlBPL050dWJ0YW5qNSt1ejJmM28vVDZ3UEU2?=
 =?utf-8?B?UFU0SzlnUml1azRDV3JKVmQ3M0tReGhxMUZZd0N6anBGcnl3OU92MEZZakJs?=
 =?utf-8?B?WGM2RWxkdjBkV2Flalk5T0RVeWdZMldrYlU5ZjhlV2J5U1FpYTNPY3NBQlNH?=
 =?utf-8?B?cVpCVmV0RTlDNEhucU02YVZDeXhFTDVBVTk5VzlSNnlPRWxzRm5YakdVZmE3?=
 =?utf-8?B?WTBKSXVwK1ZpcWxnTExCL1BNZzRMdWNubVZBbDNsNzhPcmRmNm9TbU12S0tM?=
 =?utf-8?B?MG03bEhoazhra2tjbDNkK2JDUHBOT2M5a3htdXFJNmNqQUNVcTk4SHlWSHNl?=
 =?utf-8?B?VTNDQXB0SWQ4NjdTaWR6OHk3akRBa3k3c05TK0xRT1A1ckFRVThLUU81SEtq?=
 =?utf-8?B?QURNNFEvbDdVdnF4SVdqTE9YTTc2V3NXQ2xia3BuUDlocCtjajV4R1VUZTVa?=
 =?utf-8?B?QmpSQlRoTTBOQjFrdnRaWXdnOU8wNlYxa21adXhET1ZBSjVIS05jM0M4aklB?=
 =?utf-8?B?MmhQY21rMkFLb0RZN1AvcElMQWswOVdDNnF5ZWM5UVRjNnlFTXVZeUQrYTZa?=
 =?utf-8?B?S1VwQVZlZWt0ZGVkemJLOTRwQ0pkdThLc0ZDUWhiTkhtS3lRVkp1NXpaN3p2?=
 =?utf-8?B?YlNPamZ0d1h2ZDRhVUZyUkFsdmM3V21vMVI1ZGRNQ3R2UFhTYXF5SjAvZEdw?=
 =?utf-8?B?VnhuMEM1UkVXckZLcXM1Y2hZTnp0bzBGa3JuZWVPSVZvbGFMcnhWVnFRTHJV?=
 =?utf-8?B?R0QvL2l5QW5teXA0bzVmckFXR0hKcVhIMElzV2NxemtveWt5TEFpbU1nRWxT?=
 =?utf-8?B?KzhhSGxZY3lFVkpCYzVYSjFKaUg2UGk0a3dVQWZ0eityM2FFS0ZYdGlhVkJX?=
 =?utf-8?B?N0R0eVdFVVMvYUthRjhqbjQzbmg3b0dnNjJFbHdXc1F6TU85cXd4RzJqY0ti?=
 =?utf-8?B?NkRrZkZJQVIzNHRxeHhSazVwVTZiT0dKTzlNcGUzUU9BTHBFQnlYMkt5ZVR4?=
 =?utf-8?B?Z2dsUGx1WUlrczA5cFVycnVwOHhZbHBGcDkzOWFDalBnVlJTQ1RlNDV5ZERR?=
 =?utf-8?B?eFdheU5RRXZhZUk5N3RsRnFaZFpWaURXMm9QK2ZtaGR2SFpUdFBtK0xCazk1?=
 =?utf-8?B?elViZDFzNjRHQUdFdm16dS9EelJQOWUxQkxTd1hKMGdLbnMycGhCaTBVVEph?=
 =?utf-8?B?WVJKeHd6K21STmJtT0dCcGxYSkF2VUxqK1RTSnE5SmQ0emorYVdScTh0SFRX?=
 =?utf-8?B?MzZMb3ZneW5kSmludzRaQldnUGd3TVdUbU5iVmpnMW4vRmtUUjdQZFM2MXB5?=
 =?utf-8?B?cUVPR2psNi9nRGNHWkZoKzQ4UllGYUhhSm56SHlLa0pzV3dBYmpBdE0vcEEz?=
 =?utf-8?B?dzJBcTFZMC8xcTFVazBGTjhRVlBxYXlBVXpmMUY5WjEwYTVCbk5DQXROK2hw?=
 =?utf-8?B?dEc3bFN4d0NORmRGVFBqSTZmU09hb1ovTk53YURYaVA3TzBJbkt3UitMZmdn?=
 =?utf-8?Q?F8Epm/hLz80VbkLDvvZWwlsSF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57cff68-f560-4a5e-98c3-08dc8f828c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 10:36:44.0095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6/CbQc6A8LFaE6oLch21o7DF4scM3CmEX4W7/ZtHNzEJHJT8WrRorADM0iBsVjU1MTiQbCh8VeYNseK55CHcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180078
X-Proofpoint-GUID: gzgK2cIfvN9yN6prWBfAKSHtdhrNFcTK
X-Proofpoint-ORIG-GUID: gzgK2cIfvN9yN6prWBfAKSHtdhrNFcTK
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_033651_706917_29F71D88 
X-CRM114-Status: GOOD (  19.61  )
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

SGkgSmFtZXMsDQoNCkhhdmUgYSBxdWVzdGlvbiBhYm91dCBudm1ldC9mYy5jIGNvZGUgdGhhdCB3
YXMgY29tbWl0dGVkIGJ5IHlvdToNCkluIG52bWV0L2ZjLmMgZnVuY3Rpb24gbnZtZXRfZmNfZnJl
ZV9mY3BfaW9kKCksIHRoZXJlIGlzIGEgY2FsbCB0byBzcGluX2xvY2tfaXJxc2F2ZSgmcXVldWUt
PnFsb2NrLCBmbGFncykgcmlnaHQgYWZ0ZXIgYSBjYWxsIHRvIG52bWV0X2ZjX3RndF9xX3B1dChx
dWV1ZSk7IA0KV2hpY2ggbWVhbnMgdGhhdCwgYXMgYSByZXN1bHQgb2YgbnZtZXRfZmNfdGd0X3Ff
cHV0KCkgdGhlIHF1ZXVlIG1pZ2h0IGJlIGZyZWVkIChrcmVmX3B1dCkNCkF0IHRoaXMgcG9pbnQs
IHRyeWluZyB0byBhY3F1aXJlIHRoZSBxdWV1ZS0+cWxvY2sgZG9lcyBub3QgbWFrZSBzZW5zZS4N
CkFtIEkgbWlzc2luZyBzb21ldGhpbmcgb3IgaXRzIHJlYWxseSBhbiBpc3N1ZT8NCg0KQkVGT1JF
IHRoZSBiZWxvdyBjb21taXQgdGhlIG52bWV0X2ZjX3RndF9xX3B1dChxdWV1ZSk7IHdhcyBjYWxs
ZWQgb25seSBBRlRFUiBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZxdWV1ZS0+cWxvY2ssIGZsYWdz
KTsgLSB3aGljaCBkb2VzIG1ha2Ugc2Vuc2UgdG8gbWUuDQoNClRoYW5rcw0KQW1pdCBFDQoNCmNv
bW1pdCA2MTljNjJkY2M2MmI5NTdkMTdjY2NkZTIwODFjYWQ1MjdiMDIwODgzDQpBdXRob3I6IEph
bWVzIFNtYXJ0IG1haWx0bzpqc21hcnQyMDIxQGdtYWlsLmNvbQ0KRGF0ZTogICBGcmkgTm92IDEw
IDE1OjM4OjQ1IDIwMTcgLTA4MDANCg0KICAgIG52bWV0LWZjOiBjb3JyZWN0IHJlZiBjb3VudGlu
ZyBlcnJvciB3aGVuIGRlZmVycmVkIHJjdiB1c2VkDQogICAgDQogICAgV2hlbmV2ZXIgYSBjbWQg
aXMgcmVjZWl2ZWQgYSByZWZlcmVuY2UgaXMgdGFrZW4gd2hpbGUgbG9va2luZyB1cCB0aGUNCiAg
ICBxdWV1ZS4gVGhlIHJlZmVyZW5jZSBpcyByZW1vdmVkIGFmdGVyIHRoZSBjbWQgaXMgZG9uZSBh
cyB0aGUgaW9kIGlzDQogICAgcmV0dXJuZWQgZm9yIHJldXNlLiBUaGUgZm9kIG1heSBiZSByZXVz
ZWQgZm9yIGEgZGVmZXJyZWQgKHJlY2V2aWVkIGJ1dA0KICAgIG5vIGpvYiBjb250ZXh0KSBjbWQu
ICBFeGlzdGluZyBjb2RlIHJlbW92ZXMgdGhlIHJlZmVyZW5jZSBvbmx5IGlmIHRoZQ0KICAgIGZv
ZCBpcyBub3QgcmV1c2VkIGZvciBhbm90aGVyIGNvbW1hbmQuIEdpdmVuIHRoZSBmb2QgbWF5IGJl
IHVzZWQgZm9yDQogICAgb25lIG9yIG1vcmUgaW9zLCBhbHRob3VnaCBhIHJlZmVyZW5jZSB3YXMg
dGFrZW4gcGVyIGlvLCBpdCB3b24ndCBiZQ0KICAgIG1hdGNoZWQgb24gdGhlIGZyZWVzLg0KICAg
IA0KICAgIFJlbW92ZSB0aGUgcmVmZXJlbmNlIG9uIGV2ZXJ5IGZvZCBmcmVlLiBUaGlzIHBhaXJz
IHRoZSByZWZlcmVuY2VzIHRvDQogICAgZWFjaCBpby4NCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5
OiBKYW1lcyBTbWFydCBtYWlsdG86amFtZXMuc21hcnRAYnJvYWRjb20uY29tDQogICAgUmV2aWV3
ZWQtYnk6IFNhZ2kgR3JpbWJlcmcgbWFpbHRvOnNhZ2lAZ3JpbWJlcmcubWUNCiAgICBTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyBtYWlsdG86aGNoQGxzdC5kZQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL3RhcmdldC9mYy5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9mYy5jDQpp
bmRleCA2NjRkMzAxM2Y2OGYuLjVmZDg2MDM5ZTM1MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZt
ZS90YXJnZXQvZmMuYw0KKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9mYy5jDQpAQCAtNTMzLDE1
ICs1MzMsMTUgQEAgbnZtZXRfZmNfZnJlZV9mY3BfaW9kKHN0cnVjdCBudm1ldF9mY190Z3RfcXVl
dWUgKnF1ZXVlLA0KIA0KICAgICAgICB0Z3Rwb3J0LT5vcHMtPmZjcF9yZXFfcmVsZWFzZSgmdGd0
cG9ydC0+ZmNfdGFyZ2V0X3BvcnQsIGZjcHJlcSk7DQogDQorICAgICAgIC8qIHJlbGVhc2UgdGhl
IHF1ZXVlIGxvb2t1cCByZWZlcmVuY2Ugb24gdGhlIGNvbXBsZXRlZCBJTyAqLw0KKyAgICAgICBu
dm1ldF9mY190Z3RfcV9wdXQocXVldWUpOw0KKw0KICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgm
cXVldWUtPnFsb2NrLCBmbGFncyk7DQogICAgICAgIGRlZmVyZmNwID0gbGlzdF9maXJzdF9lbnRy
eV9vcl9udWxsKCZxdWV1ZS0+cGVuZGluZ19jbWRfbGlzdCwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IG52bWV0X2ZjX2RlZmVyX2ZjcF9yZXEsIHJlcV9saXN0KTsNCiAg
ICAgICAgaWYgKCFkZWZlcmZjcCkgew0KICAgICAgICAgICAgICAgIGxpc3RfYWRkX3RhaWwoJmZv
ZC0+ZmNwX2xpc3QsICZmb2QtPnF1ZXVlLT5mb2RfbGlzdCk7DQogICAgICAgICAgICAgICAgc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmcXVldWUtPnFsb2NrLCBmbGFncyk7DQotDQotICAgICAgICAg
ICAgICAgLyogUmVsZWFzZSByZWZlcmVuY2UgdGFrZW4gYXQgcXVldWUgbG9va3VwIGFuZCBmb2Qg
YWxsb2NhdGlvbiAqLw0KLSAgICAgICAgICAgICAgIG52bWV0X2ZjX3RndF9xX3B1dChxdWV1ZSk7
DQogICAgICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICB9DQogDQpAQCAtNzYwLDYgKzc2MCw5
IEBAIG52bWV0X2ZjX2RlbGV0ZV90YXJnZXRfcXVldWUoc3RydWN0IG52bWV0X2ZjX3RndF9xdWV1
ZSAqcXVldWUpDQogICAgICAgICAgICAgICAgdGd0cG9ydC0+b3BzLT5mY3BfcmVxX3JlbGVhc2Uo
JnRndHBvcnQtPmZjX3RhcmdldF9wb3J0LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkZWZlcmZjcC0+ZmNwX3JlcSk7DQogDQorICAgICAgICAgICAgICAgLyogcmVsZWFzZSB0aGUg
cXVldWUgbG9va3VwIHJlZmVyZW5jZSAqLw0KKyAgICAgICAgICAgICAgIG52bWV0X2ZjX3RndF9x
X3B1dChxdWV1ZSk7DQorDQogICAgICAgICAgICAgICAga2ZyZWUoZGVmZXJmY3ApOw0KIA0KICAg
ICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZxdWV1ZS0+cWxvY2ssIGZsYWdzKTsNCg==

