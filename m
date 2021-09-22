Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B3CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:37:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40C0610A1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F40C0610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+XX707j65NYVnvAsDS/2MNKirgblKSyAw1Y7moE7ZXg=; b=PYKX5eUmfDyUuK
	HzgORG5sQUnAfYUFC9fM8FQWn1c5LY8NF8trYRjs5uu7LYuyb7lo1GgjNdipVVswATTNEBMpb2Ben
	Z9c9jK1XASg7j0I0mAvwDpk+aiQfjIvJaPIwWs4ehOd9GyYBKh0Qx3T/XYvzfh7vqYIfvGazfN33h
	DP/g29v7KMeShr4WPh8OChnOlcOAEjZl/CXqeJOWR8qLxvFugRDaRB7FOS0bYGbYwBMLw6JjzQ6E9
	QsnGpY1fkBR9A1kTzW/7bT/Pqma+7pG3HCMKvHQfgzMY//4lz8Y0vYJz6ctsejRZcvF+CntzuicZV
	aWH3N6C/oTBQ8UhXc3Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2Qu-008eEK-Go; Wed, 22 Sep 2021 13:37:08 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2Qq-008eDY-LU
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:37:06 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MDU7nY009998; 
 Wed, 22 Sep 2021 13:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=55/D0vghr9acKZVEveiiwDZ9qXmar7KqN4RND6rDQ+s=;
 b=ziY00jbuEOTSPT5e6DZ3pUzCi34v0cZAivi17EK24UmuITLR3NgwdQCjwUIlm7pVLAUM
 rihJP6FrUnPfn5AfuHys4ErlTd8XrXy4OyJvVzmHFN6pGh/Trxzsn8frRXrt2Lw723nY
 ZmDIyhCoS5kEae46sDivNE7R8hC4HtzjU76gzZXcrGR9sgHBR5TgNIlDn/S+/EufeZhc
 25Sp7VhlR+gfQIO4rCzPaXaNB0GQXkGk83Od+nu3Aq3uC83x7lrY7TiLC6WePcFbIXtB
 zcqLdUaJhHYJ/71g/E/WhWRyg4zlYaam8uoOtQvarq3L/LGcFFy0B9vsqGt5WkSJZ/mu hA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4pbpp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:36:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MDZbXt009133;
 Wed, 22 Sep 2021 13:36:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by userp3030.oracle.com with ESMTP id 3b7q5myaxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j27zM1mfYAiB2LVEgNo/YZMniZ80/7nUTjT7K/3+sXwZa+PU/8P3ksINvEBjyGm79k97z/efZsxLVrfCRacnLQSNb3BuyJ5vjb+/4zwFngWMVnrms4L4BIaz/Fcf3Raa74AoIhfY58DyjYMgUdjlODynuuzR/H3b73X3sBUO+VVAxtZ0gl6Hf9cVYjBHwBU6o8SJ5BPE/cl+ZMpVaUVty5NO5p7frjO/t1GwmW5SY2ttezkib0P0AKHMI6FREvDUIj5vj1uLO9JYMe7UiJLcCgI0vs9OcB+qMVfUEu/HycVDZnugPtRCdsfx/FDjguv0CN7jhTsQuKAs2Mtr1C6JRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=55/D0vghr9acKZVEveiiwDZ9qXmar7KqN4RND6rDQ+s=;
 b=Z29818biSO6I61OYPIZAE1WYEuw/ZkKIwQtxqAIp9oHvmip3DWRbCvSjcGNJ76vs2jeQ6OjDk5lh7D+ciZKlmq7SVsXFgURo3aiD0RWLg5B9YCaNh4O68gBmtOTLol2xSuwc+FFrW4sc4N2UXWKoAjvTfdiUz2v3a3OeHi7Q8R9RTmPOxYiZ1OW4XctGREZSD2ZqMjREPrJyUggbU47hYyLHvrX9YzGcnH8rFAUJadAoXeg0XA1o1n0EruGJbZ+vxPVCWwTF7NcD3tkUt5ZEz27VaYhUgkwUmx4H4R+yh4iUFrGCQMzHmvcGWsG4/BjIBwIhzr1l9F4hNKJiJsjgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55/D0vghr9acKZVEveiiwDZ9qXmar7KqN4RND6rDQ+s=;
 b=MHqHObsEQoQx82ehWBOwaPRj8Qe3INHy4cAdRBd73s68nLJ4d6c1h80XYkjxZrzktPGV6Mpltl2N0Bb5viX7/f9yDpcb2GyeGxnNUJhwFRcZOKBPG6N1/PZT8NeV0AldEwF2TOt4OOPI4cPRk0g//L/e6SBs1tRS9cZE+a41zjg=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 13:36:52 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 13:36:52 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/7] nvmet: add nvmet_is_disc_subsys() helper
Thread-Topic: [PATCH 3/7] nvmet: add nvmet_is_disc_subsys() helper
Thread-Index: AQHXr35i/uAeaUF+EEKV7oeblAZwIquwDs+A
Date: Wed, 22 Sep 2021 13:36:52 +0000
Message-ID: <22124F64-CA07-4A71-933E-53FF980FA879@oracle.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-4-hare@suse.de>
In-Reply-To: <20210922063525.143045-4-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97e33c75-cfaa-40ef-059a-08d97dce095e
x-ms-traffictypediagnostic: SA2PR10MB4556:
x-microsoft-antispam-prvs: <SA2PR10MB4556324594006CCE4795B0D5E6A29@SA2PR10MB4556.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZjaWux06Bc8jr5jN2/bs6PEPCxqHNEq3a0GMLaGgQHttaJzy0EZoK0/W/k2m62s5yvqjG2rjsjKiiQhcI5b6B5Uk0CMqbGFzGX8eaw6yMZQDvmZjjrCSjM+RthR9Ce5RrJQ4coK/PMGQ7r4mro0pn/Jmimfgs4veiHz2UbBILAtpP5fQ7+MYS1oB/vxFBzgS8047EtFSsyVhRGhwHS2bbMjyYTh2s9ULkHhNOl3QdLLpF1bSrAg+NxNPlIwsAvQEyk7gV5DfLH/vKGRcgHLw84Vxpgv9jQI5iRyF8GL1O07DqQb7PaKxdXYXsAfTkyKyN6Ea35amVwZYJd17bNUO8gySZgWXo5hygUirrn8/I9GzDanICwPPBUifOykHfidyW/rq0FIss/wjGYHl79QpQgnUj2Qty75ZhMH+HhV63ZFEpaYaCyTSDTGJIwQlG52h5PF3Ka2TIUMYLy1Psu0dWQiwBkRn1Qk83NGIwoaqytxkUuPT/kxURy8sR6ZDyNOf88B8xj+US1PdA1WnRwsC8RPY/9csD29rQqY7Xzy79xKc3zB6rOO4gGcm4mn2ZRbZrKMC44X1OdSszMkISYL20OkjBm4fOVjOG60smdLHY3aIBMW59hobNjLPK561+tmUDs1zNMpwMdt2JVGzJ0fP6P3fNYBLSawOBYCIS+yacbD5S2hMmLabv+qslmihXj+h8JZ4lhNGlaCpi3kYCvIzImMLYM2igsMdHFWJKyqv+kdTCWplcjKDnT3aO6efwh1kz7JXM05q6JlnZ8eRGYkaBZD7baHUJN1N0mVUsKufU8/W/EE7dvVjaHLoVuYjbKMp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(122000001)(53546011)(76116006)(2906002)(36756003)(6506007)(316002)(66476007)(64756008)(66556008)(66946007)(66446008)(86362001)(6486002)(6916009)(71200400001)(26005)(2616005)(44832011)(508600001)(38100700002)(8936002)(186003)(33656002)(4326008)(966005)(83380400001)(8676002)(38070700005)(54906003)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CBLtLD5eR2/h5F1h7ss/UJch1T94TMwaTzhpLo8unegM8QX4UrtO3TP9L7lU?=
 =?us-ascii?Q?WLRV80nFyDnO0qDLg9brDSCbd7qANOX4eoBpNLt9LucSvu5y4Dyoyc6WT6eL?=
 =?us-ascii?Q?ML+ETmwC40aXTHtjkYO4ajbpKGSWQr8PDkTNUO1v84ayx0mj/a8Z4IoXMEbK?=
 =?us-ascii?Q?wkkKjyNHNicBwtVHUkKn49jmjn0XAq9sjpvPL+exz4Bq16qEP9cxw+Fnnpah?=
 =?us-ascii?Q?j6KFergebDuQ29boXjHNqqoC+/1ggfzdN1aRhqqmeH4oVl5lY25B9JzUB4ZF?=
 =?us-ascii?Q?F7Xsk73UJb345MguuD3Dsa0XqZlgXa7gKQaxngGHbmZ1b7SrOKtvBvXgBu1E?=
 =?us-ascii?Q?hUjRNuGx7o6T1zyB1VmlVa5BZBl/44ofkrCC5EX3xAQPFhSZMOyLtg5tKldU?=
 =?us-ascii?Q?Au8VXVxADOApmhnZb/Ya4dKJgzpETr10qs3MLkI7dFSEC9dcYS6wnLLKz7YF?=
 =?us-ascii?Q?bSpVt57Itw2nq8X2mqpObuf8WtaCxZoHZG62ithd858qubpC9RKkLAztdAn1?=
 =?us-ascii?Q?B7Pw2eOxjuQLIa7ae7iVg/F3hVJLZ8B8b0KDAnAeC/5MHxg7uFf0NUZj0ABU?=
 =?us-ascii?Q?a2j5g01HwFdimfojflrsoOIO42A2Rr0kB09e/7pb+iewTKTG9y4Jxht/OVCH?=
 =?us-ascii?Q?LIbcnemH/N68/DpK3srOW5xoBmdARHXbrMUaaUmmN9Ph0e80TonYwoVJRG84?=
 =?us-ascii?Q?ZkvfXvkVNU8BcdU31UD3wAqigO7dTHFFNrTJIlA7GF5NnCJsyLzYEdmsbczs?=
 =?us-ascii?Q?gJvtdB8RWs66Wl8P1nz9wzJyRQnVhFQ4KQXNxXZQ50uGhHuKg/cwKuLVOeml?=
 =?us-ascii?Q?dpaL55dERsSDUCJGz0Alyk0eE1+QLGsKY//VYem8it71ro9Agc3Am4kdnU3o?=
 =?us-ascii?Q?EXROJWA6o9QrTszFFu32APTxtb9Nuf3gCd0sNCsbj4+n9FiTo+76ivH8JoRk?=
 =?us-ascii?Q?Weg3u32EPrrGQxZjVIpV9pW8bepDktjQU5o5TO4KC1+Ude3v54L80pcNJkxs?=
 =?us-ascii?Q?MQgkeJWDwbH3QL+5OlZoTj9K9XaCdmzlyQh3hHODTeoaMSqs5kQCDOZ8aXA2?=
 =?us-ascii?Q?iPUYWGEey1ur3kBrkvGeP3etlG2Y478cqrnDb1D7ofjtk0QvaLtxn4O2lxCJ?=
 =?us-ascii?Q?74qO0idajwOp2ZorYTNWxcZA12ynszOFNr351hkjakOxgbQGbREbYYoNUaZ6?=
 =?us-ascii?Q?d/QPo+pdQsuw1mawcbQwioY1BoIkFSCW87s+7uVfrl69sLMFQADUw065/UFX?=
 =?us-ascii?Q?nvWytw/sZtXZQzPhLM9zWK1zCQx23ptQbyEsRs0ZYa1r0uEPNdTRtUNU36Rv?=
 =?us-ascii?Q?oR8HtF5EpvgEYW4IKAwBTL3lWeKP5bkGgRGND+zTIkZngg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <E5A18A72D0E3774589080814173201E0@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e33c75-cfaa-40ef-059a-08d97dce095e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:36:52.2897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1W0SDwHfFeVLRXsCq+TfZgngSUF9yfXJL06Z54hWtRctAa8or/TiVv6cXaEj+PM4SRpR+A2f/mCyb9qAZJG+VhydHq6c5Bti2sCuTTv5q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220097
X-Proofpoint-ORIG-GUID: df8743M1Id9Ly9xRVluzhzDVBK9OzpOa
X-Proofpoint-GUID: df8743M1Id9Ly9xRVluzhzDVBK9OzpOa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063704_893414_612EF785 
X-CRM114-Status: GOOD (  30.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Sep 22, 2021, at 1:35 AM, Hannes Reinecke <hare@suse.de> wrote:
> 
> Add a helper function to determine if a given subsystem is a discovery
> subsystem.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
> drivers/nvme/target/admin-cmd.c | 2 +-
> drivers/nvme/target/core.c      | 6 +++---
> drivers/nvme/target/nvmet.h     | 5 +++++
> 3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index aa6d84d8848e..b653ea4244fe 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -1008,7 +1008,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
> 
> 	if (nvme_is_fabrics(cmd))
> 		return nvmet_parse_fabrics_cmd(req);
> -	if (nvmet_req_subsys(req)->type == NVME_NQN_DISC)
> +	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
> 		return nvmet_parse_discovery_cmd(req);
> 
> 	ret = nvmet_check_ctrl_status(req);
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 88ed746c675f..61ceb42717f1 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1140,7 +1140,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
> 	 * should verify iosqes,iocqes are zeroed, however that
> 	 * would break backwards compatibility, so don't enforce it.
> 	 */
> -	if (ctrl->subsys->type != NVME_NQN_DISC &&
> +	if (!nvmet_is_disc_subsys(ctrl->subsys) &&
> 	    (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
> 	     nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES)) {
> 		ctrl->csts = NVME_CSTS_CFS;
> @@ -1278,7 +1278,7 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
> 	if (subsys->allow_any_host)
> 		return true;
> 
> -	if (subsys->type == NVME_NQN_DISC) /* allow all access to disc subsys */
> +	if (nvmet_is_disc_subsys(subsys)) /* allow all access to disc subsys */
> 		return true;
> 
> 	list_for_each_entry(p, &subsys->hosts, entry) {
> @@ -1411,7 +1411,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
> 	 * Discovery controllers may use some arbitrary high value
> 	 * in order to cleanup stale discovery sessions
> 	 */
> -	if ((ctrl->subsys->type == NVME_NQN_DISC) && !kato)
> +	if (nvmet_is_disc_subsys(ctrl->subsys) && !kato)
> 		kato = NVMET_DISC_KATO_MS;
> 
> 	/* keep-alive timeout in seconds */
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 7143c7fa7464..93a86d6053ef 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -576,6 +576,11 @@ static inline struct nvmet_subsys *nvmet_req_subsys(struct nvmet_req *req)
> 	return req->sq->ctrl->subsys;
> }
> 
> +static inline bool nvmet_is_disc_subsys(struct nvmet_subsys *subsys)
> +{
> +    return subsys->type == NVME_NQN_DISC;
> +}
> +
> #ifdef CONFIG_NVME_TARGET_PASSTHRU
> void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
> int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
