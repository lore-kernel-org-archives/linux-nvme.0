Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80298C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YXsVFKNVC1pSYAk4l4AjL7tGQU9+z9+vNc7fgs3mpoI=; b=pA0/haqPq8S1q/xlMdEKKsmGCR
	rNMWUhPhLAd7eBXgJa0vrD9SpVZopaaEscEudJd6LAjL96p76JyxFH2FL2uOfcdOFjtnWsXIxMiyq
	naIb7JQzWUoM/brqQpa7H+bK6d/lQOX3sBgcukqU7NIJbLhA1y9cesUpR2PHaay0U3/tKcE2jmYZg
	fV/jJKzCsBvwxey3/YwjvMgALojwqYTd902yAGikwfp776JyT2a1qZkzivdy39/M1VzzMteNE8j+1
	23p7JnSwc1ZisNArvcCMbej5X+VRzR+7wdT3nVjLn83j9zfEp/4mCRlX6fQOupt6H9HytNUdymdY+
	HZusIKhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phBhK-00F3Ww-26;
	Tue, 28 Mar 2023 15:57:22 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phBhH-00F3WX-35
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 15:57:21 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SFoOw2026435;
	Tue, 28 Mar 2023 15:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YXsVFKNVC1pSYAk4l4AjL7tGQU9+z9+vNc7fgs3mpoI=;
 b=I7imJkfNJ8X42+B0W2BEVn0YoplhVNIBlLc9+ipaDrR6JGcN29FmBKZx1IdEi8RdhYaB
 2t7TEJ5ljk0hL1cwWRkTe62VqQJ8svhmG/AEj5ZtBrpv5Wfp0pwsUzw7IDFYKBxpwp3n
 4ecdizSBeZsPDK/71uQyqrjgnWfDmyVxMZwWrDMB++bdBib2oqeExeOBZ+fVYBmq6Sx6
 B8B1a7y7XJjjbS+qYLs2/JEgofDSg09calqeNa+e8VaXwMKFv29huNsH3Wg0PUml9lf7
 ivY+BkiFmrxgdlxPeu/yN68DJTBGiUGLuylFoXnrKqqLrUKDPqkrTjRMqbmzfXFoGR0y zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm37q00t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Mar 2023 15:56:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SFTTkd027099;
	Tue, 28 Mar 2023 15:56:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd6keus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Mar 2023 15:56:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfEGP0XBQ/LS47x/yX9BQIPD4KlSi8GlnlZzWkC+7Ox4VCvZ96y+krXCYUdnLdT1GFrBJrlbn6qjxDQVHhvxFheS0zN1ttP/epXqlUonSsMi+2jA7W5vcsOrxYBzhW2lgCfxcrZxDiYCBtDWZevD7sJehO0NlgDOUIHAM5e7TQQQtM3BgnuOiPF4N9yarBZKv+q/NdV/oQTBK4IsuF6Ayj8WYby6uDB5/bPwmi0pGeypSLxGQgjLoWvlXI14JD8d2Dw5jv5HDsIFWlUD2ZPamcLznhoG0wy7wIUluYRub0UlWN0S84b80CEPqGu8ZarVuXkyTYHsiwasbUM+wrE8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXsVFKNVC1pSYAk4l4AjL7tGQU9+z9+vNc7fgs3mpoI=;
 b=MUwnKW8y3F2oPbp2wrqFeLsFlss5rdzyYoOwZwNPtqildJZzz0/1T1zAPstxfVxVeL1W2AfwaNBqDvLR0H/xYzcunADbudMJWmhdJXIp40bdYhPI9a66dHO5jwjQUN/Y2y3J5H0MZRgHPEO+yStANu/U9bRo4xUdHFkaqyjowsvTxswMrwfKpU1gt8jCJALV/+qIP4YTCK3mlxy5kzdeBdb47b/4HFwILckouXPpukZl2+8gZZ5ZtrHO7W2sUgyJ4zw2cubLSc4NFEPDgM963ma0CPrlVkt2q6LD6+sU1xZ6lvWj8DyobL+R2Pf7ofhrcPnDZ0MQ5QCC7ZeioG9ZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXsVFKNVC1pSYAk4l4AjL7tGQU9+z9+vNc7fgs3mpoI=;
 b=qoPQyhdoxwJRoRLX6hImvXiO8xEc2N1UTPMwZqCJ28kI7PTzxBjlBjAsHCgCFd13MvUbloG14mmHcDp6wX+v4H5fWI+6vMxNSwEm0aphzovUS0O5VcYSr6Nf4chgKBbtG22Fl150Oq5ljv1RfvBjMs5IaTcf4LinAEWJH2d9IzY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 15:56:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 15:56:51 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Keith
 Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Chuck Lever <cel@kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Thread-Topic: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Thread-Index:  AQHZW/LVaZPDBIBnuEuKqDBWb1WqJa8Gt6YAgAAF1ICAAASxgIAAD4mAgAAgGQCAABEkgIAAAZaAgADzngCAAde5gIAC3p0AgAGCAoCAAbq4AIAATX8AgAAjlYCAAAehAA==
Date: Tue, 28 Mar 2023 15:56:51 +0000
Message-ID: <D37E71E9-06C0-467A-A653-9F1B968590AA@oracle.com>
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
 <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
 <b8a2e1d4-3571-447b-25c6-c6dd25fbad02@suse.de>
 <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
 <c426d104-b7f2-e736-c23a-b94fda54ed37@suse.de>
 <e0620d94-9729-014c-2cb8-8ff826ebbefa@grimberg.me>
 <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
 <68AA3629-6B88-4098-AA03-BEDF614F8D0B@oracle.com>
 <ea181844-69f5-66eb-e64e-e9871916532b@grimberg.me>
 <3ad50302-6b3c-6d6a-669e-0b11c2df6a6b@suse.de>
 <c9b5bb2d-89d7-8805-6d60-2c53e13f5d58@grimberg.me>
 <7c3da604-251f-209e-db6d-d1bee5a838c5@suse.de>
 <8d0ddb2d-0b4e-e782-6507-a1d61b5d53f4@grimberg.me>
 <D2384BEF-CE08-4CC6-95C2-F5E6726E0970@oracle.com>
 <6350ad42-d6ab-b244-6bdd-9830c11fb1ea@grimberg.me>
In-Reply-To: <6350ad42-d6ab-b244-6bdd-9830c11fb1ea@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: c176badb-f9de-445e-91ba-08db2fa50b6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  +08H8omW3buuo8NIUwlo+MDPGKpKES1hGa3ZDyOE1WnHM2XZxWAbMrWSAqpTXcHmwbnmN8tuzTR5Wul8hoNvV50SK0XM22ZVKkl1W+fZEvvwKjgHo67lXWtD9p61uioi1T2byTB4QENOeicJ31LsfrIaxFq3it1xTqxYr4++ngjLF0nJi7MP0gtAlskIuikn/RUTDf8pwzLFApD+0b3U9oJOGPXHanhi9MjBTeB5bQQ8ysXb/CuZ4TE72prirMxwLn6txIwTFo29hyJJg3VO7hjPGS+65Rg8F9cSf5CnmAmrkoHeRO1eWBCopWT3BPJhFcSURDWUB3znlrZtYdclkLXMWD7KTc3ydlZWrWYyR43IT+SbE5HuyzB7ZsHZEXtH25Wo1AxArHWDyQiAonfrCczgjqfnOFGXEYmPOcS+Qd+SYL7uL2m7EtRuHZosBliJOXhsJxr+FTF4cpGPIBsxc3nHRKz2CQJg0349b51iMzlBLGCMXDFMsmomRoaJySkysllhVArC4pv2qGz9JXHl+HZQowqcdxiwj38jhne/3Dzq+yxxqzy8iNcVJO1fb2qECWGZMrePYYoHn3ditbld2EsQ6OIGL41nlFlPnrScdIk4Us5KwDx7ytQrS/kO6UC+D47QWNTwLuJkpiSb5Atyfw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(53546011)(26005)(6512007)(6506007)(41300700001)(186003)(64756008)(6486002)(71200400001)(83380400001)(2616005)(478600001)(54906003)(316002)(38100700002)(4326008)(66446008)(66476007)(76116006)(66946007)(66556008)(91956017)(8676002)(6916009)(33656002)(2906002)(36756003)(86362001)(38070700005)(5660300002)(122000001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?CuYc969TjH/KCdUd8k1L3T/AQRoz3kuxqkRfoPSqB0yJQ2gcesni5aUEKtIK?=
 =?us-ascii?Q?L7emwwIGi8YTJCorWoxjxoSZ3YhX5SD2VAxKvmq84RvO7EO7zrDFJT1solWF?=
 =?us-ascii?Q?5fHON102GTts821S313zmnla2HxtOShJssBuoEHFR6marWuZ9ZXCGauEZAmI?=
 =?us-ascii?Q?rDIThVqep4YKqswY6nGdjMgq4uO/2JcUzzNUP7TU+dlLHJg5etG4I9MJksFy?=
 =?us-ascii?Q?ZqxoOUjBNI2F0c93uDfZ4yLMOpqvqyo4JJ8ye3n7L3KnvwxebWYwLPfh0+8s?=
 =?us-ascii?Q?zg1XRBtAHwLzUdDQGBKI+4J+hZo5XKihcNqcsykMdpgkL43YYlBIQX5b+SqC?=
 =?us-ascii?Q?C53FO/WG8KEj8mCjCt1o9qiChL1wO9UzrhSMiFOtAIdNN+N9VsfxFgJfynu2?=
 =?us-ascii?Q?2508WnWvhhgWX+r+Cs0nfzLvyFRSnG8Pxa9vGrccM/39o9oAyvkvu6yWdOFa?=
 =?us-ascii?Q?Urr41GdmVuv1AcZRngrQsMS/CN/x19qg4qx1hAoYhWU5BsebbBqXFqXyS2tx?=
 =?us-ascii?Q?7DeOd4rSe4lx1LyDGlVo1CXKAafbA39IAI6LRzkHoO7FianBpOQ7zoVUZ731?=
 =?us-ascii?Q?DgOLrq4bpdl9t2wsU6bhL19wlj99M9BVaR1/8ZcHP+3DHHSM+mNRNEgTS47S?=
 =?us-ascii?Q?U2RUxNalj9uALcXMfPvhg190y2c8X97CxCBhxKRNqAX7y8VOKuKYlfjsW/T0?=
 =?us-ascii?Q?grzEAQJmQkgl+9BSP0NXx2/lV9DosVkvjFm81N1pEdUZ311KdiQ0UH+JjMdM?=
 =?us-ascii?Q?2+Mm4zLP2Qf0rsiBbGDJKW1vi/71KhkejRrEekIcgi4WpyV9ytQ1ylwOmsre?=
 =?us-ascii?Q?Td/+jrmDugqA11I2Bp28AVrs3DHL95LGWWaXIbaygr4IvfKorhC1Hqf17+QV?=
 =?us-ascii?Q?ax9zsvSC9QP01IEE5QWatZJuVtSchmPtRXbsfrCw0uxyrEo4rPPQEzcSK7z+?=
 =?us-ascii?Q?E6BEfF18NzatrcZbXu/L4XQxB2SUP88dKzf1oLcZtmdzX3nAMZ3ImeaJRMqX?=
 =?us-ascii?Q?XUMpUuXM/s/mA/NwDiHyUr2AE77JRb8PxysNHv33r0yknWY4qdAfqVOCsnwp?=
 =?us-ascii?Q?vfc74fHZL4stCbQknl48TeIKmlqVhOr0OXXejAYfZ6ckvgC345XbsxTZt2ro?=
 =?us-ascii?Q?ConMuvPFx/hawq6CN8+55aoB1euvgHwgGt/5D8T6K7OO5jTwPhVdgaRuxvXS?=
 =?us-ascii?Q?KqiJXbga3xB8sSS2sKb4Oj23Ibt9/Jm3WTh7J4azCPtypU3Eh+e4MQgSiKRd?=
 =?us-ascii?Q?FQjvUDoGoZ5PtgZu8flJQ03ix6CcWE2n1LzOGEfbOMwXSgMDXmwhgqquhw/v?=
 =?us-ascii?Q?SHOol1PHQyMNIJfia1cDQ9IPKfNu5i8CnLEBathq6QFRmWNsV3IKbCRZZLi0?=
 =?us-ascii?Q?RbvR+oYhy5d1Oy6Uw/9zeWtFMMHPCrXJ8DHB9VhwBCyDDzAJkueOHlDIpfaM?=
 =?us-ascii?Q?S4RyhdBjRO7e6md3lh85Ycn/VHD+dGXvsKoLCvUNmv5trPnQox+HpjXv9ARz?=
 =?us-ascii?Q?yxI6m3qeE4tp/DEn3mi0Gbsz4MCt0iWuoulw+JBZuOGFUSda8f07IFtrjKMl?=
 =?us-ascii?Q?brdxtv/uKdG9lxVXDyiQokEwxX0KEqRogOcJoRRRYtzrBpZ0aL+5+dqxS8bs?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B018497B4D9A84086E617DA2F96A4F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	Jyf59RcQjb/J+mdLVMlLs87TwfW0ANzn7j307zTeyD216RDe30FZC3QM00oO0UHEpa9q1HOyjTRaMX6qifx6vBCcUOJFgEGknlPHyTMmWX9AeGXRD6LmoU0J7TpkhqZBAIi98wO3htEhxmqLGMOdCi0oeRmaxoQPW7HEcaVxr14YhFm2/ql6M+FQGYDEU0gCOKh8WaLp/miuOFw+gwwuXi2olQkySqf5lxrsNTVoZK4iKqgLCbWlSblfnP5yDYJR5BZMpGdozJ+RAOc4emePNVRK0NE5CkFiCjLb2667rCqfwzgfeXTMLMTkXPzKUreIadNALFsPsczkmUE7rWX+KlTQ6Bts+Qjgg84AV7LPquaN52NsLuN7SUiVHicjxumvMV2E8ktHpCYggOJeQDdJUibye7kzVQkMwL9czFKQwEN0TiJW+s0y3zqpuZJuvDE4BbWbfUpM01AGRUmlvT5ZxKgwQQfQtN6ZVJk0vkYCklhHUZZeEc5V+FxTuYfXb6XQN11JczXVrKVFN+iiiXqNkgTOBlSv/58/EOO+eBtQPKmPIOwPIQHS9aRUI6uIGuDbV7zWSwKfo9q6lX4nZnWHvguR70TAbemzvK9Y4m6ogy9pS9tAWFzNB4/rxvgF+LR8TeNSuhmHUGElq9jX7WMXosvI8l4Yq6n2cE43bH/1OkZKWJTVB3emv+MRqAhlYOrnro5A3KcyfsDw3sTUV5WQ5whBh1aOinEt4odmUXtTO/Ztrz0vwt3VRTPdjG6Kt/AtoIrthsAaa8r3dhuHfcSi1WXIf7tfy6e7jsW+EAZbv3Rby8eCbB+9zJ69FGPE94ZVAULE5wG0mwMldm9qxuC4fMFRd55eRhXLhONuLcfVz4MLfuIlDW2oRN0xBrf2Nk9CQRnbGVA6+OwWlDtMGa4P8pZteBw8+MNj6l4fNkg7/JE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c176badb-f9de-445e-91ba-08db2fa50b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 15:56:51.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6jgF4FsxsAd8+0chdugoS1VgTgBQYolDXnOH8bF6fl1t3gpSnR2yCZIhv8sw9NuQHazwEOh35Vyfsd9ePMA1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280124
X-Proofpoint-ORIG-GUID: dkFMO6jWhtkSVYlqDSytDDzfTz2G3QDX
X-Proofpoint-GUID: dkFMO6jWhtkSVYlqDSytDDzfTz2G3QDX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_085720_004696_1C70D2A7 
X-CRM114-Status: GOOD (  25.17  )
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



> On Mar 28, 2023, at 11:29 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>=20
>=20
>>>>>> As the callbacks will be changed once TLS is activated, and we reall=
y should not attempt to run if sk_data_ready() points to another function,
>>>>>> as then the sk_user_data pointer will most likely be changed, too,
>>>>>> causing all sorts of issues.
>>>>>=20
>>>>> Umm, something is unclear to me. if nvmet_tcp_listen_data_ready is
>>>>> called doesn't it by definition mean that sk->sk_data_ready =3D=3D
>>>>> nvmet_tcp_listen_data_ready ?
>>>>>=20
>>>>> Are you talking about a situation where between
>>>>> nvmet_tcp_listen_data_ready is starting and until the
>>>>> sk->sk_callback_lock the data_ready cb (and the user data
>>>>> pointer) is changed?
>>>> No. Far simpler:
>>>> Starting kTLS will change the callbacks.
>>>> So sk->sk_data_ready will point to our callback before
>>>> the upcall, but to the kTLS version _after_ the upcall.
>>>> It typically doesn't matter, as we're setting it to
>>>> nvmet_tcp_data_ready() anyway.
>>>=20
>>> For ktls won't we set it to nvmet_tcp_data_ready only when
>>> the handshake is done?
>>>=20
>>>> But there might be the odd case where the data_ready
>>>> callback is invoked after kTLS has been started but before
>>>> we're setting it to nvmet_tcp_data_ready().
>>>=20
>>> What does nvmet_tcp_data_ready has to do with it?
>>> You are changing nvmet_tcp_listen_data_ready.
>>>=20
>>>> Then we cannot guarantee that sk_user_data really is set
>>>> to the 'queue' pointer, so we should skip the function.
>>>=20
>>> nvme_tcp_listen_data_ready was invoked, then sk->sk_data_ready
>>> is nvme_tcp_listen_data_ready. Are you referring to the case
>>> where the callback has changed before the read lock ?
>>>=20
>>> I would like to understand why svc_tcp_listen_data_ready doesn't
>>> have this race as well. Chuck?
>> svc doesn't alter the pointer address in the listener's
>> sk_data_ready field, and neither does kTLS.
>=20
> It is inherited from the parent socket sk. IIRC it is cloned in
> inet_reqsk_clone.

Ah. I meant the changes to support the use of kTLS sockets do
not alter this svc code.


>> For a connected socket, when the handshake has completed,
>> svc examines the socket for more work one last time before
>> deciding it's idle (a kind of simulated data_ready). That
>> should pick up work that arrived undetected.
>=20
> The question is how does a ktls socket never calls its inherited
> sk_data_ready (svc_tcp_listen_data_ready), which according to Hannes'
> explanation, should be the case if this socket was created as its
> offspring.

Have a look at svc_tcp_accept(). It resets the inherited callbacks
before setting up the socket.

svc_tcp_init() then sets sk_data_ready to our data_ready function.

--
Chuck Lever



