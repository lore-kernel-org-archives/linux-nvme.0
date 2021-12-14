Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC346C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 03:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0zFKa0nGxXnl+o0axU60bgDzuq8krIj3W0B9Rl3TkB8=; b=OyS0xw90FXLD11zF14vzJslxXA
	QlkvxtdspTwrXF4p8P6NvT+/42VlYLSCY/e0GsdFeZn5OwU1KBHhjT73UglBzO7sNrIczePpyfsPC
	59uomQ7/fFZhttrIJ7BQhOsCN4XJM7NRRbPuv+Yo80ORjD3v5RzJzfS/52qXYNokzMg6SaAjtv1u3
	z7sq3Sl2764yj9HUnux6rIjymfyNcSkbGsWe0jiMtiUf1Ma/3Qlzqrc4x5t5fSpEOu8GN8gAGu1sZ
	+xCXdrvT3020LsDEVX32wOAZvJ6bkRGUpACOfhrDRfQEIl1KcObZn0xa47zTrpqe6vddqHiJq4lVK
	K9lWDnTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwy4a-00CLQ3-Gw; Tue, 14 Dec 2021 03:01:48 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwy4W-00CLPh-U6
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 03:01:46 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE27FRD004125; 
 Tue, 14 Dec 2021 03:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=0zFKa0nGxXnl+o0axU60bgDzuq8krIj3W0B9Rl3TkB8=;
 b=pjMnq9qvZwD5IaU1ImEbkqumDFF+HgfaEtKZaFMc9HtG4ec08Qz97Tpf2XppodW0olsi
 2ZDnhXfMzsjcmBkL0o6cMke8rFUjKApPA1+PgKe3oerT9u48wi4NqNtzTiaEKJABUbG5
 JBy0ngLMclOVxcdhxf+pKbFRLlUorsYfXMa3CY1Ng8Xm7nv4ndBYqfoDKU6/0Oc0Peze
 zo8MGUCgx9EGQpFwDw7DT+YKsp5e2aphFALco8SXTy6v8tv4DBhBGeiWUNYFDOLqMWP6
 RPMpVNi7jx8YKaXlmGsjEshr025s8FPFK/c+HsMWrvCmpBadxYGz12kthN84irb+VPv1 Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py2geh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 03:01:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE312il142021;
 Tue, 14 Dec 2021 03:01:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by userp3020.oracle.com with ESMTP id 3cvnep69hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 03:01:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ5JyrW+qZLmzdgx6bFcmgkLNJ3l8QtC4cuEOX+aVygCZHfuUoULgdU0b/ypuwPUhRCqg5nneXNloruZsuKXNYgLYgxxyctFZRavn/jnR1fjysnj6b/WP9p9uJMor2ejRiB20KOAb+bIJdSbePjp6wqbaJWBuHv8IhcmQ63riqLt24YllNJCRqt4LScdh/K9w0QF+Vt0ceqb6QUIdLDW0hOd0zQr9IePvYuJm5DCFz9aA2skua5AnmPW1vSNV0Du9MVq4JHFhvV23EOysYbk56jj22SrvHvEG8GAfl9IYf3ul541iFeiRyw1EhQ2E0Rw8jMZXQR7sVO0qDBwCpTCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zFKa0nGxXnl+o0axU60bgDzuq8krIj3W0B9Rl3TkB8=;
 b=NbM43A+iB8oOiDYdVt830y7wrFk2leYwHX+Z4tJSAENOtloMGZL7id/BCnDmuzO+5XNOGkSVdrcJ6OTVK5bd5H+w0Sc4NkHiHk+aGxtQjzsJBHs3ykZpzSmss6ygzuFCGSgkZ9tAt201P1ephJxz34aGznQ0B+HCkvctjZvbQ2flbDLjO/EAJEPOx9vMVz6HaHsIxYQWhgNFBRxQGiXcXCcAucdqTHVzyRYzHGIWja73EaXKMAez1/pEmprHBPDkHb6CW0x2v63r4HTkcWi52bNN+Lo7+bZHN7mRKMqo2Ta9h35vSWAjkMIeyqcgeAxNwsCt0z4yF8waw5z120y7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zFKa0nGxXnl+o0axU60bgDzuq8krIj3W0B9Rl3TkB8=;
 b=hKqDGuq3onDoZ2d0B6bjz0ZzybKokS6trZ3YHqtSs6+orpUs6yxt0K1ntA6BxG1UaeZRXn1GB7mxllmSzMNYp03o30ot2JhJBFvrlnLfVvtrwRgfMyCAyOoatnHFvXwif3hEIOsVXNQdZLTXY9SCE8fsKuQsoNMv+JcTO8qf9/Y=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4550.namprd10.prod.outlook.com (2603:10b6:510:34::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 03:01:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 03:01:33 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,
 Alan Adamson <alan.adamson@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fsqvq4re.fsf@ca-mkp.ca.oracle.com>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
 <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
 <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
 <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
Date: Mon, 13 Dec 2021 22:01:30 -0500
In-Reply-To: <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com> (Keith
 Busch's message of "Fri, 10 Dec 2021 08:56:48 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN2PR01CA0050.prod.exchangelabs.com (2603:10b6:800::18) To
 PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bef0385-9bfc-447b-d416-08d9beae08e7
X-MS-TrafficTypeDiagnostic: PH0PR10MB4550:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB455040087DD8523E862895148E759@PH0PR10MB4550.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyyJGLECsC1cPMGAaKHOT+u/BobHjYwLifXPJHG7pUoyqeJHthdf2YcvI4sCNNauH8P6Vl2FPwRNODufLOCN7Qb37biYr1uDc9LFAMYp3kA5AzZgmS+mg1/nQy0KvrBpclxTjyS0aX7c460mAL87LxW+PWi8m17GDEAmGFBtA1LEX/NHil3ch9Q/4883uRkut74Im29zjClUiHhQxQhNpseK3ki8yYULloJeXimBBNniJ0koPEzplsOmeQoXCBCnKtpuzuuRn7w3BH8QybCUtUKKkcHW7WbSv55nX8BeDMsn0M2w85jpLlkRg2NIJQ6J8xfDHPZHfdZW9J+vWRCoe+WsD5/in7gNMye0Qan/HCqgdVsRvsTK9P6kjauyk/gy9/wx3R4eM60vnCbAN3jz9G8RcyhJCzmGXH9ozxSM5w3KELEr8OU7RTnbwlM4u2AACkYz3yEYUs7JO8MBKuO3sp+3IOHsjHl+x0I2KLjkYWim3GUTw4fwOGkdbYf56ibMAACxWtUKElxbr5D0MRei4mkoBvzP4QD5VJ/0D5v2CL+EKyiRRaATUWLqRIsL8suY0cV8IM2h6bWwthpuP8lzlVxQPtVA2np+zFtmebgPlajcovC1VwAw67VelntsWXgdCE+nnb1mr21UmqYF5PNbu5CvTHe0GgNtJX2PnIyVekdiqyJnlOQGxDaBRzADBTV5wWHpZCbmzdtOJVIGZaNEPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(83380400001)(54906003)(8936002)(6512007)(8676002)(66556008)(26005)(186003)(86362001)(6486002)(66946007)(66476007)(38100700002)(38350700002)(36916002)(52116002)(5660300002)(316002)(6916009)(6506007)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zR7DXvt3f4hSEgCYQwR3yojxQV91A0e7wOhbyO1P9FHMht8HumGSRtOepy79?=
 =?us-ascii?Q?LyUr1ytjdaBJ2KAdozhwkZnCSix+58WW5Fthi9S8Bp6BbjSNMssRyU2Jo0vw?=
 =?us-ascii?Q?WNxM7/x/PMQzivUdxMsEVKUvmjQ3k0aGPrqeJR5FRjyZNJFu3a0OtrBODdQX?=
 =?us-ascii?Q?kqZv/6AJjSVfmz0TiPMwMHLb5sh1eTLIEplSWft9NQR1kNIG08jxMmwnuTho?=
 =?us-ascii?Q?Qs7T8dFOi7tVynwlZtB5d3nO2HZ5kMzZIATYqU1gqRusFgw+cJKJ2pdjfsEZ?=
 =?us-ascii?Q?zAbNL3kg60H+KVyvJZ+hAQzqvjPdbDL9h3kpGWjiZ8dipnETvX995MmJTvxo?=
 =?us-ascii?Q?arsch8Hh7fRJ2bZ4Gfuec7D9ezcTTdz3FCj1S6ySnd4t4e4BXUsnkgM/Z3gS?=
 =?us-ascii?Q?aQ7JHHYfQiol4za+fY4Gt7eUYjzNfwHuxG/J+3usEsXnULgHzr8FA8IUoqML?=
 =?us-ascii?Q?ehkLvAL8/B2zoO2MuHgxK/hLL/9JcS7OngVDvW94PLBU72PI6wcc5J6wgjeD?=
 =?us-ascii?Q?rcx9khkVmi3ep45R+grgRTVV6Pwt29QOkjaT/nwxZYbIB6+VJyLxeG5kDUfB?=
 =?us-ascii?Q?0iBuE54JlkbDrMcLgJfvlMpou7fpaJ8kE6bC/ZsxLOrbe06bkmAUyXe5dF/Q?=
 =?us-ascii?Q?U79csvlWEwdLJ8J1bSY3btoQXK2hPhP2lA+c+hqqat7r+DGDGP0ay75LBVQv?=
 =?us-ascii?Q?fO5TgBKE5mYhPcyUiMtVpkpoh585AoGKP08Jo16mj1syuhhw3nMf46H+yP4k?=
 =?us-ascii?Q?hXnAka63uCRjMf/DgUu93DFPXrtHuKd9lWyVuIGzQDeAWYFDp3Chte4pIAZI?=
 =?us-ascii?Q?SLWTH6LWk5/ldSzJmWSfahu4ocScOtVzxNdBUoB0v+YBwJFXw9skbS9rwvFm?=
 =?us-ascii?Q?dUVELALgFBTKrT0mFxJdG4r1HhOBo/pqDma66jpuApOk2O/EPOZR8k8L+k6S?=
 =?us-ascii?Q?a6hFZjj/mL7hbKeh+WKzbPW16G4TNuUJHR3l3G2+r85b1Lk3eegmNQoiM40A?=
 =?us-ascii?Q?K1Ntp4wrJQ4+xW+AnLhrSWRakB22v9duIFR/F3DQlIpMcoIYjgtTIC+8r9R+?=
 =?us-ascii?Q?TvGJNegqMEO3aOHfEFZWB3ORyQP7/ZXqe0zFP+C76jgv5ROyg5vHZ7pwwz4t?=
 =?us-ascii?Q?0/6JHaHf7mtSKk+CUQz9xvHECx6YsPbM10H2BAjEqb6nE7JYT42gDyDAe+F+?=
 =?us-ascii?Q?NfdmVRBmD4SJ6wyjDI0DCVhIc/OvseprKhPZOaZRk2UiUfOD1A7vD63L+CxO?=
 =?us-ascii?Q?+/4GvDJwp61gXZcSOISBHOKzvCRkBLEdlff6rBQJs6mHU+BzvcI2NVAr2rah?=
 =?us-ascii?Q?F/q6YjyMYOiOIUJa0E2qlsAG43nNanh7bmT8k3Bg3F6RekwFTy54nEcUlFFa?=
 =?us-ascii?Q?Wr6NRMHqH0piq3+MX2OiInKRDrV1ztSMkVDhG5lv2jRi7JgkxS/mW9XVetYy?=
 =?us-ascii?Q?i7RwM0vwHdUvg+48Xuh04M+AHBkSyOJXfFBVJWgaDMrp+c21nWRSrF1qfKEE?=
 =?us-ascii?Q?cRedlwhqjReiD5kVin5YNl+4R2OiIbWrcAph5ial2w6BhfHRMOecyU4htoPm?=
 =?us-ascii?Q?c9SSUfe3UCkx203tGxWwTd0x+R+96j6RPITHJYtFEM4pWm8PZgsrDeClE7nF?=
 =?us-ascii?Q?WHesCr9XxkSHp8QWgSAqVt4nXRO3KefS1bFokGKWu++HfZYeY5nS9URSiWZT?=
 =?us-ascii?Q?8BGFIQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bef0385-9bfc-447b-d416-08d9beae08e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 03:01:33.4664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr/585NyV+PU7Dj3tsqrggpzix9Dsylld9hJDGs1tcXQ88pPsU/Hx4wAkE9lvl7pxIv2/Ae/NHb/cRAhzJvafvzDwGanuIZE9LWoTMvW08I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140014
X-Proofpoint-ORIG-GUID: zd4ZjN-Kg2W6hTqkBKQTOHOVScAiaaQc
X-Proofpoint-GUID: zd4ZjN-Kg2W6hTqkBKQTOHOVScAiaaQc
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_190145_082135_8ED0CABC 
X-CRM114-Status: GOOD (  25.03  )
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


Keith,

> If they are not familiar with the decoder, does seeing something like
> "Conflicting Attributes" really provide the user a better sense than
> "0x280"? Either way, it sounds like they'd just open a bug with someone
> who is familiar with the spec, in which case numeric codes should be
> sufficient.

An English error string is very valuable in a support situation. It is
much easier to discuss the implications of "Unrecoverable Read Error"
than some random hex number.

> Are the existing nvme trace events not providing enough information?
> The existing ones appear to have even greater detail than what this
> patch provides. Or is there some other reason why the kernel log is
> preferred over the event tracer for capturing these types of errors?

Logging is imperative. We have to be able to root cause an issue after
the fact.

> I'm not sure having it be a new Kconfig option is a good idea since it
> requires a recompile to enable/disable. Could this be toggled with a
> static_key instead so we may disable/enable verbose logging at
> runtime?

In SCSI it's a Kconfig option because the embedded folks do not want to
waste 8K. We did it the same way here. Enabling verbose logging probably
doesn't make much sense unless you're an enterprise distro.

> The new "struct nvme_string_table" is a bit inefficient. Unknown errors
> will scan the entire table, which will slow down our hot completion path
> on any error. The codes are small and mostly sequential, so I think you
> could create a sparse "static const char * const[]", then the "code"
> becomes the index that can be looked up in constant time. The total
> space of the array shouldn't be much different than the proposal.

We can look into that.

> A significant amount of the new strings are specific to admin
> commands, yet errors for admin commands skip the logging. Why define
> unreachable strings? Or perhaps a better question: why skip logging
> admin errors?

Good point.

> IO errors can happen in large batches, so perhaps pr_err() should be
> ratelimted.

Sure.

-- 
Martin K. Petersen	Oracle Linux Engineering

