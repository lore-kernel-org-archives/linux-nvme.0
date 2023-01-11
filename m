Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F809C46467
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IPxDCWAnDkSfxY/HOWnkbfRhpE/qMvi3Avc86DOnD0U=; b=rSFNDyw0SMWHpqdO01ir/PEtWG
	iKB3HeMgUCtml/0dMuqWuQBy9vYDFN8mMnmO4vdr5SH27t05/MGt743tVZqG1RehUAFbF7teQrje5
	MMgYRjk9ULiLpgol3SeLthvVb7Aojj49ZiKiu4eGX3u5NRObO93KAtWbq8/AZdwKZ3ImQOVxml4K8
	7nU4CwSlIwKP3K90gVx+ivB8Bt8cgvlUUZ/A4SQ1Uy85F40KzRHxjlntB4gT02mUzdAKrUa04mKzT
	htKFdyzUloMgmzJPeGjimL6SK4JOwiZyjvOhCy2F0NFdJcXe/IKgx4KoD6AUtkjZnwFBrjtAkiJ5A
	1pWZOrpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFcEy-00BpoD-L4; Wed, 11 Jan 2023 14:38:08 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFcEu-00Bpn8-IR
	for linux-nvme@lists.infradead.org; Wed, 11 Jan 2023 14:38:06 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B8huwq003511;
	Wed, 11 Jan 2023 09:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=IPxDCWAnDkSfxY/HOWnkbfRhpE/qMvi3Avc86DOnD0U=;
 b=VMUNabWlKn/amd5wLI4A7RuRL7CosJWhDDZ5nWqq/HuTrzBHfLUvhNWqjmv3hNU7dvon
 G7rFLT3YV+DDH1UAiOnWXaY3D2Gw0ZUYXCnlBk8gRaYCY9UzraPfBUKnowZPZ8uIkkUQ
 iUe5c7nW1elhbU5AemgvDzxUIAkcpeioIFIHsi9v+xrG2bHwN6jaMG8LsnTAnzEmJxn/
 Uoq6Z9qdCTBc14wCcG6dW7U+o+yzzttkW+3xTdmXs/pwW/Fi0TUqVeQhgjgg8Uw4uLdk
 Gf6dTj4rSjXgAnBc/nJBNILIajrWFiBoU2S7pDc6ytFbPP6h68IKvdZ/ZshTPd112oyW lg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3n1k5b2yke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jan 2023 09:38:02 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BE0bQV021417;
	Wed, 11 Jan 2023 09:38:01 -0500
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3n1k5cg8rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jan 2023 09:38:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVvK6/KxLr+aGmnZo2G2iKK3fmFOKpLoZhCpyaj/Dl6crME5Oxz2LqqllJGNbmYSxkTaq8eJrwxfsv2GZIKauA01orFuqiu/OHwSdTcm37uyhlKnuDQNEDalBXYKK9yj5Zzu4cT+uBpta/VhOXrsBv7CIRMPNEH/ox7q6HoV83zvPV9Q745681ciG6dut3NeDZ/cRg1rg7YWZrsUN8goXYDK28RjMXfVHuL2QX/RlZSNBcjwKYe8x98JjYhFC9cEMN3nk1GKsfWWES4Ic3SqL29pIMmm0UKIwXrS78YkLgeExl/qo9AWqcXH8TA5cdXBE3FDEPn/hgQR8KRDB67gDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPxDCWAnDkSfxY/HOWnkbfRhpE/qMvi3Avc86DOnD0U=;
 b=JgKesUCkBjLcMMePIP2qNXrtTiQW9nDJeCRmhosq+BKz7pQfaBzPUcfZ5nYOFkh2FpvzPyLfWK9YcuumbAonO2oDABq/kuVUfufennJlzdBQUhdDMil9vAxKAdw/dqnI3Ldg/YCQAoFXteAcqx9K5+1CcNuPlLUra4ygR/XLQm5q4mBK2WWpeBWTjxUYuGnSYCR8v0yqq6aUQecrcaWN0uEuMK1mNSOWYyfrBSLF8l/QjvspqvDWs6Z/c3ZwsTVjR2q9ytKXdMWAz6+h3vTN1go26XRRPkj0EiU0jejcjkzjDs8qoB3k8x0fqWT9luZMXrj8xGlP+8KKCRtb7X7ZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BLAPR19MB4531.namprd19.prod.outlook.com (2603:10b6:208:29c::19)
 by SA0PR19MB4382.namprd19.prod.outlook.com (2603:10b6:806:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 14:37:58 +0000
Received: from BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::a948:842b:3041:117f]) by BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::a948:842b:3041:117f%6]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 14:37:58 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
        "smith,
 erik" <Erik.Smith@dell.com>,
        "Ghalam, Joe" <Joe.Ghalam@dell.com>,
        "Hayes,
 Stuart" <Stuart.Hayes@dell.com>,
        "White, Joseph L" <Joseph.L.White@dell.com>,
        "Glimcher, Boris" <Boris.Glimcher@dell.com>
Subject: nvme-fabrics: devices are uninterruptable
Thread-Topic: nvme-fabrics: devices are uninterruptable
Thread-Index: Adklxcy5R0PWO5jhRLix9YacrkAbkg==
Date: Wed, 11 Jan 2023 14:37:58 +0000
Message-ID:  <BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-01-11T14:03:10Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=351a6b96-7651-45cc-aadf-f2a6c265837f;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR19MB4531:EE_|SA0PR19MB4382:EE_
x-ms-office365-filtering-correlation-id: 0a1f04b1-ed8a-44a5-94c6-08daf3e16f19
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  PAGRdFjPxqweatCIxnN7yjmAf8ox85HbP9dJE9LT4+g1RlStm5TmFevp+k0TPXWkV/IC1w3NsHWMBlEsMJOiGo77cy0CI6o2hvadqjm1n1wyvbFhm7UJOlr3SS+QbxTx/0e29PhTtEPhFAqIt+xFRIBPUs9dC+XwoB3uRBv4oeY3xD8+Edt7sl7xvJUISwUhAW6w4Ohp0P4yWcxIQcQTi3Yz/MUKs2kMw753qLqZxpanW69sBa8hofbNIMceW5pKKt93xwvajQqpzy0tHBkYgv9BUV92TsZji8fXYEgNEdA8oLTiBy+jBwxWk3coZF6fOFKEayghn50nxi7fi4FSxY2Kugx+h6Do1x/5oAvojIecKLzWnaG+uZxKsFHfS+lki98FdqfoXENxPGd8OTLedLSfyD4YX1ETwjlENaSt223GGhy6dona3BwHp5QBeOML+++gnuKLMrKN/IeAYZM+qz3QaJg95ShejgHYS3g2Xm0TwFdaYnpmOBGCrQK88NWf9yrBcToMcIc4tp7+bbIRjKvd/Fel5OaIjYRHAht1iBx5m8dXwTbEhr7UPbHx3xdounPDiWvHau6EOXsLjT4L4SHIptiO1z/xXCqt2pNDWur/O0RDRBRxo0zEWsKLT/C7ermS9YCGLdGhptTIYox2rZnbyvown9Sxj3b1MEFAytxEefBXsNdyttX6QMH0VfpWHrs+lUznWyZB5TP41l4w06kxkrsiwCp3Rx5+fRdP40k=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR19MB4531.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(33656002)(316002)(9686003)(5660300002)(71200400001)(186003)(26005)(7696005)(966005)(478600001)(41300700001)(66556008)(66946007)(66476007)(66446008)(4326008)(54906003)(6916009)(8676002)(64756008)(76116006)(52536014)(38070700005)(8936002)(83380400001)(86362001)(786003)(55016003)(107886003)(6506007)(122000001)(82960400001)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?llHVokMcjDMqVHqhjh3N2pXjj94iD3UPFor2HZAfrj8fG0yQqsgKxiP4CKRn?=
 =?us-ascii?Q?T0gqa4mt7tzJAJt5sP8U04Avu4vncHKnHgyarDR7dsW7naRce8AAYvKoq+k8?=
 =?us-ascii?Q?TkIFjFFTK4NyaLmRjgmgNBFBpuSYiikq+vgmabjhws7/1PzX6B+pMcm3k+v0?=
 =?us-ascii?Q?tJUp7QJbeiDWaIwNToADNS/SMliO76miI+lXMPSzRAn8Ucws5kE2wuil7DI+?=
 =?us-ascii?Q?jNX192BOqIrgPVwq/3STo3yOQTSEGrh49N2JezaVlW8dicq5ON6eE8GyoalA?=
 =?us-ascii?Q?r4xpAaBSSYpnFIB+6DH+bV+JXHGwM+YFnJBMBI/0qwMmkMsfIIiZr7tML14E?=
 =?us-ascii?Q?TVr3gQzES8HRCS5kGjuylNDwwdZNUbIKuZWoAeSmd9GgrR9wp0v3SWShofP1?=
 =?us-ascii?Q?tm3H0BZ6HpFXmWBYE20MKWKu7RK+fok39h5uybrad85wnWxjK0d2Aq4v13l0?=
 =?us-ascii?Q?117nzwAP1cxN/rAaZvrPBaazMfYltzPuOBMKOyi6Ur7eoGW5X3GCeltqUc6j?=
 =?us-ascii?Q?hkf4dSWMOIRKIvoUiFj9b7Sn2bHcjt3l+p2Fb9iUy47a5p9ExxCBUAzc7roN?=
 =?us-ascii?Q?ppga6YtqW6awmjPazDIc34AoeJAh36UmyGPo7YNMFzaymnhzwV8UHwxo+EI3?=
 =?us-ascii?Q?kSGGzpJuH4VKwueBWV4K22oC1E7GC0E7Wlf4u6ktZkkqVwN22UBwFStVakw0?=
 =?us-ascii?Q?bvGtfb2xBRr66MeRVbSoJ4g8fuGYogJM/Hg8hVGpRw0kA6hFMz06+FdK2Hzj?=
 =?us-ascii?Q?LyWRgnwFFjdiPKsExvueytnbvw29SHvztf9gPVemNzHb+AKm+dQ45l9R2BbN?=
 =?us-ascii?Q?ughpPcNRzVivXp3zITrMhLOy/TWW9muPZvdkxXskyyrAyYym++7Zcyw+Eccs?=
 =?us-ascii?Q?5YHcbTU61OA1sh2p32w8YR7nADGLmZ4u+JGr8O5xpOlWV8gS7DWQ/2k0Fcw5?=
 =?us-ascii?Q?nYz8CaMEXaFGwj3GkGpEmvEO62/cmYYdI1QeGyTxQHuDAOSyja8OJSha0AJ9?=
 =?us-ascii?Q?+VYNt13ZX0lQDpxG/6iJIRB8Z0ZdWIkfEF3y1rhDc89mdrpW9ixGcs8A93Ly?=
 =?us-ascii?Q?rE9mrpJeF7+aYq++DWqh08/KmMBpSKPOfYDL+2L6kmlL9uFrCQYd+3VLYdKh?=
 =?us-ascii?Q?yKbNOg9v1LnUS49cqGb6oDAZuD5oXnLkxYw+w7yqWP7FDhh+bFH25n3kwOAA?=
 =?us-ascii?Q?fXFYcIerrXc3AnUEYnQ/phCR4gQAxRmbhZrynPbTLiKKtoHwFPyb3tXpTGp6?=
 =?us-ascii?Q?rS9KJQR7EqMpI3zdF+/8yy9xstDWNZ6PHXPH/AOUQQtx6PqbhbntQeKq0m+O?=
 =?us-ascii?Q?PlNYOHTsTbzzOPBgl8pqsWCC6Dk+BeFYuEe5NApldiibzsPLX9GwA3plL+jV?=
 =?us-ascii?Q?ntlbI5yBwcg4cB80gwrr+OUIwNR/xfSFils/COb/81/cQkH7LCMuOr09BM90?=
 =?us-ascii?Q?6smMeCVFJ1DwIqJuCwajP1O8/AOY//6UjkUOEqkQiU+P88+DcFvx+QiZYiUw?=
 =?us-ascii?Q?HqgKh9Bq4/yCNRfuI376HSyNBX5N9ClEkG9BZVYO+1Ut7slcopZmMQkz9q9X?=
 =?us-ascii?Q?DDzZ50cVL+g/ol7DtMxVn0A6U2RvqfC7B+vf1Myj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR19MB4531.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1f04b1-ed8a-44a5-94c6-08daf3e16f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 14:37:58.3016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDVolfdwh7A1E59uUB2GetyVqq9zIfHjWgZQH/3fNLe04yi1oU4G4j4iMpHD+AieUFSnQyOHkBD9fWOuQtwtWxeHai4dTGtRwHZk6qJqi7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_07,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 adultscore=0 mlxlogscore=285 bulkscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110106
X-Proofpoint-ORIG-GUID: 6MBdd31_YL3Qz583fzUN83ZR7K6MaQfj
X-Proofpoint-GUID: 6MBdd31_YL3Qz583fzUN83ZR7K6MaQfj
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=370 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_063804_720938_535AA71B 
X-CRM114-Status: GOOD (  23.91  )
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

POSIX.1 specifies that certain functions such as read() or write() can act =
as cancellation points.

Ref: https://pubs.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_0=
9.html#tag_02_09_05_02

Cancellation point functions can be forced to terminate before completion. =
Typically, sending a signal to a process/thread will cause cancellation poi=
nt functions to return immediately with an error (e.g. -1) and with errno s=
et to EINTR. For example, if a read() is currently blocked on a socket, and=
 the process/thread receives a signal, then read() will return -1 and errno=
 will be set to EINTR. At this point the process/thread has the option of i=
gnoring errno=3D=3DEINTR and resume the read() operation, or can decide to =
exit() if the signal received matches a specific type such as SIGINT (CTRL-=
C) or SIGTERM. To do that, the process/thread can use a signal handler that=
 caches the signal type received so that when control is returned to the pr=
ocess/thread it can query which signal type was received and act accordingl=
y when errno=3D=3DEINTR.

The nvme driver does not seem to allow cancellation points. In other words,=
 processes/threads blocked on read()/write() associated with a nvme device =
(e.g. /dev/nvme-fabrics, /sys/class/nvme/nvme0/delete_controller) cannot be=
 interrupted by signals. This can be problematic especially for the followi=
ng cases:=20

1) When scaling to a large number of connections (N), applications may be b=
locked on /dev/nvme-fabrics for long periods of time. Creating a connection=
 to a controller is typically very fast (msec). However, if connectivity is=
 down (e.g. networking issues) it takes about 3 seconds for the kernel to r=
eturn with an error message indicating that the connection has failed. Let'=
s say we want to create N=3D100 connections while connectivity is down. Bec=
ause /dev/nvme-fabrics only allows one connection request at a time, it wil=
l take 3 * N =3D 300 seconds (5 minutes) before all connection requests get=
 processed by the kernel. If multiple processes/threads request connections=
 in parallel, they will all be blocked (except for 1) trying to write to /d=
ev/nvme-fabrics. And there is no way to stop/cancel a process/thread once i=
t is blocked on /dev/nvme-fabrics. Signals, including SIGKILL, have no effe=
ct whatsoever.

2) Similarly, deleting a controller by writing "1" to the "delete_controlle=
r" device while connectivity to that controller is down will block the call=
ing process/thread for 1 minute (built-in timeout waiting for a response). =
While blocked, there is no way to terminate the process/thread. SIGINT (CTR=
L-C), SIGTERM, or even SIGKILL have no effect.

I wanted to ask the community if there is a reason for the nvme driver to n=
ot support POSIX cancellation points? I also wanted to know whether it woul=
d be possible to add support for it? Is there a downside to doing so?=20

Regards,
Martin

