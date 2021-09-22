Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5311CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACD261153
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0ACD261153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TnZabKfrvUtJNAcenLfQqMQgJf8rWOlMcn2LM0K2lSo=; b=Xlb24CIWJpSBXq
	CWztZJE4h6gkQAIHuJTSo82yytD7p0gQHFDW/AL7BGdxU6XrsieqMTT54oxF9SSZEplnfuYA49uW8
	Y2AUEcRjlW7NRWqukRRWeoCUibBdM2hlpHOFGJQ8vb3CGiRLG8Uz3IwSiaMUuGVaD9UZz1dO32Ss7
	nHHuhRsrAqeXZhDxkhai3jpu3UV76Yq+LlBqf+cLJFRwlJYNbuVJCrKzb3ZwWHLQpMsAvl63nvPPM
	tMxdJXP5lMgY6j6KiAC+Qn9KOQIoWA0FDdjM70mjw5lrm+6hfSyapaSH6uxHsf4jk2iVffyfBBuPH
	MV1/Lv1T/qqgUOfMCP2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2P2-008drI-Mv; Wed, 22 Sep 2021 13:35:12 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2ON-008dim-7E
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:34:33 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MD47hN013132; 
 Wed, 22 Sep 2021 13:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b4aF9y4OI9M4mKAWGdLot7gyQ/BhA6btWi30CtwzIuM=;
 b=rq8P1DDVK0iyjUacmY9WbPzi8bwnoKjG4DXlSM/LSYHGHne0853Lyba4UHll674t8BbI
 khI+/iYKuKj4JA7CpXBV9PDfb7JLHb3bxjVimzmwD5iPILSYH6Kh/15eOGXT5kWCcGWs
 +nuOMZEfB+aisXgMhNw4KVoY0SgL9xsEuRVAcRyxQWFeGwEep+uArart68D8SVx0oECc
 wcID0blyT6Xsd2Uiza8RjSemoV1B2vI7NkPIKpqCY315JGEordCjRlzillpLoMgsggLC
 wPfhOmOFzwks/SjFai/Jo+iWtVbHC+lw/68m60b+qQ/4EE3/3rkVE67CJepxczPajT6w Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4qkvkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:34:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MDU6n5020272;
 Wed, 22 Sep 2021 13:34:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by userp3020.oracle.com with ESMTP id 3b7q5w7kbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:34:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQqm/LLjOO4xPfNessbikVMVGvy8zznP6uS1pjrI82NZv8/DVg95Uj+8wwLom3brSjPwAwT8Vlu2yoYFgEDPX4Pirzu8Ws+O+j+FNRJ8AF7p5xpeXcNOuMZFtKdOyyEHQLbCnlvSO6VLGn8S7pBroB86wSw+0kteY3JZDoaQ5Ra+9fhTkOjBYmNr8CKSf8qmPtfVMvliWqcpSKoWH18EfnkC9xVNGW5XxobRDCvIlbMTGRhHzJUzOmEfMst0aaHmDFTrZ1rU1WczU9yCJqDj/Xfy2fdYhyPDY6LBk2jldbCI+1TaZCDbaC++Y/g3G6IOiip8TDJrlvHRS3zcHg/4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=b4aF9y4OI9M4mKAWGdLot7gyQ/BhA6btWi30CtwzIuM=;
 b=dQbJ36BfQVs0HJElOs0jetFJpIUjbKqZR2CMiuk+G0uCjpK79Fy5lRGemAD+iR7LTVug0YilGTHhgVtvpLzn93CZk4hNkVX26DBe/shG8OHNrYPglQqdU/4R0TPoydnSxOsUwfXeEJtc2etrH7kg0WyumWe4JM0t+b+oQRCyfSfWnoknbNKNM/wthFEB4x5OgjOf7q6/ng0zUhEPGF4MokR6lUxeYxa/RzliCaLsBDFTm420emDCChbcawTopWyI/ut2gXYPI6rvVij6q4L/5AYWUh6qgi9wLpltE4Puh0QHJxlDehDcwE6oSdJ2FhXVLffrFAfXtbpUAlK4wM6k1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4aF9y4OI9M4mKAWGdLot7gyQ/BhA6btWi30CtwzIuM=;
 b=pMjVZbxC5D2d+ggufupxyBUg2kSKlKLZXVrSatAPACywZmtaEbO+qUHHYOiw7dXqr866ZBw/2I28zzHNbLTUlJn5f2HVSVYsqgLtBFFBXwdKqMNfXa6VId6nBL/iE0j9o0Uh9i4YuHwYBmhy79IeqYhT0IQbNisuAtDzwbWAqyQ=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 13:34:24 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 13:34:24 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 6/6] nvme: display correct subsystem NQN
Thread-Topic: [PATCH 6/6] nvme: display correct subsystem NQN
Thread-Index: AQHXrvzFFbpUoVHKj0CQ7AoiPL3ljauwDyMA
Date: Wed, 22 Sep 2021 13:34:24 +0000
Message-ID: <6787C3D8-8DAF-448B-AF36-337B37E9118D@oracle.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-7-hare@suse.de>
In-Reply-To: <20210921151529.29419-7-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32a38d1f-0808-45c4-75ce-08d97dcdb15f
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB276806F1D34C9FC780381DC0E6A29@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPXfCUksaRi2gKDO6uRcqvgfGDUViXCeUzQp8XkMJNldeaYqpRVa6RabmWkMHnuOL2Q5q4jMXw6mwVqMOQ5pMgOWBWVPULRgSLg05gTv1DvkM6G8LgzZqVtQkw4gN9nhYrLpWS5+aNFYQFOzI035jSCN2jjawtKuLLfsQ117cvQSB7x6KHhaJnCBNJaqJq+dwdMuFrvsfmT5RDKGK1KPUInAFZWhBqUYYRwThq+FlJZtKGSdJLzCHCJxWbaIBa7ZzdaW60VUxiRm3Al8jazLmC/TUWq9rH0IDEWeRLtSeuPYkDnua07LggeQyxPiyZU0V9d6629iELJ0JsXt/Zd5kQNE3L6oh/Y5GI99jTgxgfKAS1smoXFGppZtBcAmyVR/kPpf4/rzFiP70KqgcURPucR+WrGY+lhH/8kpssLxfjgzHFVoAHnhE3lx9OLmEC8WKc/HB/HL01GipXVrRtHh7K6jTHh1KRS4bNguUYTz70ARd2P8ukWmsICIpw4oOdHe3uI9CZRo2L2OZXO5wjG0lFTtm5addQQUmRXhzmUv35kX6p7E8nNL+ZomdXZ9gErcibOlDwJZ6eqYZyjDtI09qdBvlw2n/3zk9ITyv7AMSFfYXV+q6bbdrJByobKR7J1S9mwTNgaU/qBQ0Mtqs8FiL6kqgUkIrD073FZjYLbnVQyLSXLF5PfUEhRnr7hWdZ0Sckeqpoo6OD9zSFkatoKSpYm0DhumZ/ZmNBpHc55EzM2rZbgWshJERx8gigfN+Kd4mfuZXD5Kb0ZG8R/9zmbnGFBdlp2PkKoUTNLFgtIWnrMNo+XwJduFxRy0LyESxpbl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66446008)(53546011)(66946007)(83380400001)(6506007)(64756008)(76116006)(2906002)(8936002)(71200400001)(66556008)(66476007)(122000001)(38100700002)(966005)(316002)(508600001)(38070700005)(44832011)(54906003)(36756003)(186003)(5660300002)(8676002)(4326008)(26005)(33656002)(6486002)(86362001)(6512007)(2616005)(6916009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OxB/grNsvHOA1LMHAhWlrLTv53FAvT+bvBX/vZeR7XdaDySv9I/fB5UirrCT?=
 =?us-ascii?Q?Z+xRi8bmRmqtBTakoDOJFB8D6zRZVSWHsZpy9QJaFFmlHZDo5AvB0GoPW+yj?=
 =?us-ascii?Q?y11PKCyNxXmCB0U6Bdewe9Ya6yGyK2TXAN8QWe3Zm/wg6E5i9YW1BJERSbIR?=
 =?us-ascii?Q?TbrQy+iXLyVNhd6uncd+IaJOQJ43Y9l8si5Kcw49QvcoZe7EjhHDP5DmzKBB?=
 =?us-ascii?Q?iZdaIvORVvBHbZdFDpFIhvlcEHHQvPj2QT3tjLs9xgWi7S7go3VC+iqP2K4f?=
 =?us-ascii?Q?z699KjyAIq8OXryiIfDha9iin9RJP4h8UcuI+GmhmDuBy3QqG+XM9eVVkS9S?=
 =?us-ascii?Q?SikxIlmUaONi8t4N2WXtvz26k5Ik8NeoPz9IIXyVP4lxU0YRy9Og471sIucj?=
 =?us-ascii?Q?SgQYD6Usqkno1ii4oEtZm/PQuk+IY7tZQdaLE0VRBaDaYKNHEAU8qEI3HIXc?=
 =?us-ascii?Q?bNyJXKQ5+9GMks67pkO2LhQVY0WL4k+ir9B3/5zlpmud/cTefuof6Y5KAh+V?=
 =?us-ascii?Q?/9S0OG0QJnkG+lto1judRkv85kNYXYKNeJvhW22sQzpQgr47FM0g/w8uvI34?=
 =?us-ascii?Q?llL5UJ3jy0Bk5crKhvJLs1Xlgy01QZZsZom4k4VJK2Uk6N17AKpBg218jwm3?=
 =?us-ascii?Q?ig76Qbu5GiXGTl7DfU+K3hAaK4nSZh+xrSDvxjaB65jYjKwBVJ88Ambn7xgR?=
 =?us-ascii?Q?/JqxCjVDPGJacM7D8ddyuo3lv/HWeiYHpf+1liwWbs7be02vTSDUibWwcIRa?=
 =?us-ascii?Q?UFAK/+mDfeUkLIY+2tU3C39gfnyuDt87YzbJbLh1NctFSImHiU9oWVnFWMI2?=
 =?us-ascii?Q?64D2l8Lyd4+vfeLYfWNOoW20GEqE3yz9uQlv8iIluUli+B2Pi+LQPr+xBRLh?=
 =?us-ascii?Q?HyICXmynhXQ2AZAeJh4FKVdwr/eORlYmubXuVysXkiYpLRGo+hpDBg7Y7nbm?=
 =?us-ascii?Q?pgvMLODgJPrZfJ/wZW/Tn2FStKAn0tOGH50XYMwhU/QDn9u5j8Q6IZoJt/rD?=
 =?us-ascii?Q?h1rMSWURAvcKg72qOeOrsv+X4EKSpDSptwng9Uh6X/3nxgdlif3UjXDvMaAH?=
 =?us-ascii?Q?wrlq/Tx3tN0nOuPZOwejyin3fSADXPdb83rsso7I+yST0bhWq6B9nWN00fPx?=
 =?us-ascii?Q?BZaUeu8CmgechU0zehFyTqBT3QE/Yt1B1KythI7pR9Bf2WdkHT9PXKGlU/tU?=
 =?us-ascii?Q?qM15yD/w2yv0WyfkGt3E6uxf83H1cTqtM0MQu9r3/WzkVbsTAmGtCWQ6x36P?=
 =?us-ascii?Q?/MKFQKHEiaZV5ZM0ZOtPENs46+ZwOtYl3AJpdjHQN7TCHkQOYPYX0kpQDkFv?=
 =?us-ascii?Q?eFh9g8QPEBm38Q/eHHfFU3A27+zsCsP3IqfLcOjdGJfluw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <AF76B79DCBF22F4BBCA5A60FD98D162B@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a38d1f-0808-45c4-75ce-08d97dcdb15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:34:24.6027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNrWDDpjkNIzmXhQouxgBhpHfEEw37avshE8olcBt+3ixmBsVVLQ/ME6mvV9xbguYhrKjBH3/8oITt72+0RM35yKclMPSt96gK/FwbVMrSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220096
X-Proofpoint-ORIG-GUID: bEQo-GU6ujKT3wGKViCga-y3rw8JP1oX
X-Proofpoint-GUID: bEQo-GU6ujKT3wGKViCga-y3rw8JP1oX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063431_429801_C4C18A32 
X-CRM114-Status: GOOD (  26.93  )
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



> On Sep 21, 2021, at 10:15 AM, Hannes Reinecke <hare@suse.de> wrote:
> 
> With discovery controllers supporting unique subsystem NQNs the
> actual subsystem NQN might be different from that one passed in
> via the connect args. So add a helper to display the resulting
> subsystem NQN.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
> drivers/nvme/host/core.c    | 2 +-
> drivers/nvme/host/fabrics.h | 5 +++++
> drivers/nvme/host/fc.c      | 2 +-
> drivers/nvme/host/rdma.c    | 2 +-
> drivers/nvme/host/tcp.c     | 2 +-
> 5 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ad01e2778cb6..084a2df2a58e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -221,7 +221,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
> static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
> {
> 	dev_info(ctrl->device,
> -		 "Removing ctrl: NQN \"%s\"\n", ctrl->opts->subsysnqn);
> +		 "Removing ctrl: NQN \"%s\"\n", nvmf_ctrl_subsysnqn(ctrl));
> 
> 	flush_work(&ctrl->reset_work);
> 	nvme_stop_ctrl(ctrl);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index b61b666e10ec..56253a060258 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -179,6 +179,11 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
> 	return true;
> }
> 
> +static inline char *nvmf_ctrl_subsysnqn(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->subsys ? ctrl->subsys->subnqn : ctrl->opts->subsysnqn;
> +}
> +
> int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
> int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
> int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index aa14ad963d91..fa8bd6c21073 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3572,7 +3572,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> 
> 	dev_info(ctrl->ctrl.device,
> 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
> -		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
> +		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl));
> 
> 	return &ctrl->ctrl;
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 042c594bc57e..d795a9868674 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2385,7 +2385,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
> 		goto out_uninit_ctrl;
> 
> 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
> -		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
> +		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr);
> 
> 	mutex_lock(&nvme_rdma_ctrl_mutex);
> 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3c1c29dd3020..78966b8ddb1e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2582,7 +2582,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
> 		goto out_uninit_ctrl;
> 
> 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
> -		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
> +		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr);
> 
> 	mutex_lock(&nvme_tcp_ctrl_mutex);
> 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
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
