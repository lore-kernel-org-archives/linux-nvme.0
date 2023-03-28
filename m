Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3C9C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dv0o0qnoCSQYWHH1K7tM1ldsL522Yqu72M+Tqwolz94=; b=C4h4O+vzJW2E+Prsr7E15bhe+i
	69yHycELrmrtL4AIAbmT607cQt7TNM/yRJJlY9tiacBz2RX9Mv4EGombnf5G/HuJccz74qQ0a6fIn
	/jq5lUoPoxch7rBuvvmQvlCfVDkbcpnZSczP3iVv9qj7/VxkVt+u/9cElhY6aE/TzizFXtvY8VWhW
	hm6QBEDuZv4LV9F/oH2eu1J3gQuViAqJyTM9eplYJf+MkOd1kROVH1PIARe0IKancbgGmIPbIeKhj
	istSU0V06/d4wPUqQu+DhzbdmGTElZhCu6x82BhfVqcI0qXkZ31g2kTN4PTDOSelYkzbcok8Zen6k
	+79nZJTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph9HX-00EYiz-2l;
	Tue, 28 Mar 2023 13:22:35 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph9HU-00EYhP-1M
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 13:22:33 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SDAMjd012453;
	Tue, 28 Mar 2023 13:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Dv0o0qnoCSQYWHH1K7tM1ldsL522Yqu72M+Tqwolz94=;
 b=gsCfi1/sWXlRXh81Dt8I35RCJfOnKmAEnJFXpvZ7opcddzjyw/ck2mamZwjug9OilY8o
 uZmw6GPAF/QWCJ9wIDiOjDXtYKCjhxaaTO6EoOQeB9QrCnP/RfQRjl+3TB3IybbHGRMM
 EtYRZn3p+5JuBgPxsW0e8XSaE3Gy/3NEinK+3Tcj2VB0Sb2XkHyLfefBLFf5NgTpzgt/
 sHIxKb72gEBObQBDQhfrczbgS2Fj8W1rEqimN5EOIFwrc4c2vZK09AzFm0twbxzJ5vGV
 SfolEOgaGItb8fl4EhcYaDqdUHVI/z7Qh2Rm+hb1roo52XDvW6NN4ckIE3XJ9eguMcAE CQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm0ve01tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Mar 2023 13:22:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SBwqNe027785;
	Tue, 28 Mar 2023 13:22:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd6cwnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Mar 2023 13:22:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5lMzqQRhLIcNYs0O12R6eD4BpfNH99rlfC87zavK/+wBxvZ7dBFAf+NzX73W4H81MZXrKOSmaKHVDFbcAqImxCpqxbLZxGEO5DfPJwxWXRfY7PidTJB0clWxiFWA1ja/0CW2+AZUD8GTydJE9gEQ0zBuq743eFBzpyRPCWR9bkakcgCqQZ/5eTct5LYMLfH20b7uUmPSlAUlRjsYjTbtjOBlkMRCnzabbODAX5g0z7qbHkfkD+KaZKrMF8n5Nh9Sm6hNKu/qN372+B+TOxjxJZgyq8RPeRa6GwEKQ68MfPSm14P8aFXOJ+fXtAcYdxm1BphVs8Xxytgp6ExBAGSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv0o0qnoCSQYWHH1K7tM1ldsL522Yqu72M+Tqwolz94=;
 b=h7q+u6P28p49UtH0I4QQIWBnRZ3XATOEK4p+Yngb+8StNMyNHAtJtcZBCoTQLGE2/mcmaYyCWuA1ufG05SkOpU+8FqlL+o26SwU1Ylki1AUP2SqaVOf1C/wA/Yopv093PoTARKJiagXQ94Mal34dt5XiV5YGT+WJOR+RiGwQKke6H1z2ipKteb3ZXh+V/sQtLIRarIj5v6CQWNXHhIFIEmmIhpUTab3aVvhJMdxPHZ+zSGQeDJlPgQSlaCzW0Dt25nmKIhaD5yt3mzozICSMNKVeYdBw1+NsR0JkPZUzELYtjLlhT8WfhrJYj/ZZac0h90rdfH2HgvR3hOmkvsz8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv0o0qnoCSQYWHH1K7tM1ldsL522Yqu72M+Tqwolz94=;
 b=kN3KCNQJ+3ntzzfHFyAk+euiREiJxKB7YqYnPADkm5dMTTVHnezhPZepb5aXhXOxuKRaW4lBORm5QvxY4JiFiya60wCKfR8qSAvB3UyBu+a+L7HXP6wSbMfaFHIrDNk6GL7cDU1NvD9NWK2/5g1zNa60fkGILZn26EA1tWraqYs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 13:22:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 13:22:10 +0000
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
Thread-Index:  AQHZW/LVaZPDBIBnuEuKqDBWb1WqJa8Gt6YAgAAF1ICAAASxgIAAD4mAgAAgGQCAABEkgIAAAZaAgADzngCAAde5gIAC3p0AgAGCAoCAAbq4AIAATX8A
Date: Tue, 28 Mar 2023 13:22:10 +0000
Message-ID: <D2384BEF-CE08-4CC6-95C2-F5E6726E0970@oracle.com>
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
In-Reply-To: <8d0ddb2d-0b4e-e782-6507-a1d61b5d53f4@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7054:EE_
x-ms-office365-filtering-correlation-id: 069c99b4-285e-418f-9327-08db2f8f6ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  RN3mq8CUaxpRVdrqdjGt/cR2QUF3deZb1XiTG8VTRIrB9SGqFuJ2IDH0lnANiI9kITlWamd2UHab2sROqQhpBg1POgccRA/bHGkMIejmvo05d/y+8KcnFipqQzINr4qZTE6xWLtr2D11uRAS80j0Xg/TgNx8YTq4NLOg1fKriV3CxmH9PyDtV3YZPfJCgV8ibcn4DjOfZ7IY8hI59QG9KvQzEZqEA16oQS91EwrUdXdZe9BndGhXvFXe/R7mFk3wQJ/h2JbqGOKljA6QvZZSRVChpV1FPcuN55Xfj0cuH4mWcD4fAEeHOI9sdg02HnI0I9cOBTjPvThiHobbYxWGmDvEDu/qcZre57x1BOIK0sls7LnSIaWuNt8/P10Rj67fDFDkGezXJDnBHyas2ZIBk1jo2ahpCsJ8hRKfI0oF4eiGbZl28NaLURXJGm87KdLYrxG8hd4oYTt8y47lIWM5IjO/jDJ1QyeU4k+mURh5F44yvJDqKG9nYj0hARDyo0Zc/f0ybHHjKz0v20pruL6RbbML/FfuTbpV84h8m6NbTjFhWkcw8RvpKc9qq1jZhhZ+CtCc41vnVBxnjsChlngPwOIUrGYdKffqLmUlSK6yVOyE2LnK2LMpUFquSUTKY2tVRXMfkmN0Yb35QWSFeeAMug==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(6486002)(71200400001)(54906003)(8936002)(2616005)(478600001)(6506007)(316002)(53546011)(6512007)(26005)(64756008)(66446008)(66476007)(91956017)(66946007)(6916009)(8676002)(66556008)(186003)(4326008)(41300700001)(76116006)(122000001)(33656002)(5660300002)(2906002)(36756003)(38070700005)(38100700002)(86362001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?JY/jKLR7Y6wxTLnIV2yW3TULzak5syqc8tbBJ7bfGAKL3xDVnZT1yOpYjj6U?=
 =?us-ascii?Q?oORAjqQyu7N074gpaRfhJu/XpQ4lUSUxK8L9yhB2P1GoRzXniTfiiEgtrOU5?=
 =?us-ascii?Q?BkJB1Y3E288DsVXcybC+81O/WIyoWWOyOc3XFGOWi9ElmmTw2WnB/GadOx7z?=
 =?us-ascii?Q?dkBVzXBYE00EjaD9E+EQuno59w+cUfzFfU5NMu1Kl9TuwWRcQEoStdZuLmah?=
 =?us-ascii?Q?UoC6Q2S7lBCq1/r50bakUoMSwGYvb1we0S3LQS0C2mwNouIpxv7BjctwVx7Q?=
 =?us-ascii?Q?htFK3HkZNd3gB3jxdxIXcpHQpxuLein0nUCUUbPHyRfBRhZRBXdBKDF/tCuz?=
 =?us-ascii?Q?c5eqSqIqAtX2zr92I6rRregJzZ0LZAlmYimjbI1leakVxMDF34DAoBgUliL1?=
 =?us-ascii?Q?FEQfeX/nzb3e+u1GTQ/6vPEVZDp0vpFgbzYM0R2niAyU/RlgDKbYFPIC1sqm?=
 =?us-ascii?Q?o8CHGV86/SY4uJ6waYkrjFljZowQLrIfiIfYlWvPwMmBZ41cyokgWDLZzMng?=
 =?us-ascii?Q?yoHR+Xxh/4cUFOWXwkkw5vEv7beY9qSxBwADLZamxamD71oiO9bxm4uX0BBm?=
 =?us-ascii?Q?2419WxhLMe0tMQTMDvcyPnhD1Xhew3KCX12b2VBbR5zpWGBhO65EbRUIk5Dy?=
 =?us-ascii?Q?iw/WOq9GzVZjLeWVZDgu0bTy2hM0ykxG93vvceLu/YrMcditrZmQ1NL5snmH?=
 =?us-ascii?Q?2x2e8Ugf12/Jm98tmx7dKYVsZMHRkBbbERKBSaWNHjpTbGrHoyUr8plodMHH?=
 =?us-ascii?Q?Vt9ZFZTW3sASCgCoALqaT7FYI5nG1rEYZK4i4+iOs8Q/3Mn/9PGoa0GEKOt8?=
 =?us-ascii?Q?aIAuJJyL2PrwjScqqTx1IZ9LXYAGHE22e3WRkqeExVOmcEJeGoR5Ip3pRIi0?=
 =?us-ascii?Q?b51cIVtraYWvGM0DfWWuaIwjVPpik4AwKXvOyzWuIqYamOXYdjS7pwsvKBxj?=
 =?us-ascii?Q?8d8iZd7i2823Tkd4JM6TVvb6Lwcu/rIVrkpkf6NXitQi1Oj6yFrHWfFHnLNX?=
 =?us-ascii?Q?qeroqHcEmPlemWRUjpmkzS0PrXNdSy6EkEEqkrine95lLo0JXlqEOpvJgfwL?=
 =?us-ascii?Q?uEZxGqPlSyiMjeItahSkl6TwfU819d5tJgS6NdpBvS1cnqa9fU7fV5CEfsYi?=
 =?us-ascii?Q?6x153+bwHBao5WWKh6xuD/tE4eDQEUNVdim6g4XDW+5O9yRvJ/k4hwmLPbTh?=
 =?us-ascii?Q?dGwqdCD5gaf02EXorzsKoosf0z5VnIboej6sObQmXsQdBTrvYGO+OyaM608t?=
 =?us-ascii?Q?vEMFUfwgc0/iMuHU6+CPL24MGG3dFKZv0CLzrW+oIVB+1Ig7S99efG+/CsAQ?=
 =?us-ascii?Q?pjwiXq/vwnFeXUqJ9wgjV8BraDpxGs4XtFrftgFKjE92dt1TOlS87mFeCYol?=
 =?us-ascii?Q?COZOlzd7nQEKGS1hMvCkoOfo9a9pH+tNn3nKmHArsJ1TeZyoUm/3EA8SjETz?=
 =?us-ascii?Q?Sr8eK7z/m57T2ryFBw47AyuG6U+fDzhRu4PfBToB9o1TK0OeNtrp5TQq4I6e?=
 =?us-ascii?Q?Sek64+AbVhMRA2/mUIpy3Nhg7PH1CJmAmh4cyyYS0eRePvaTFTIbM4+SL7xh?=
 =?us-ascii?Q?A7bfIqGqieLXsH5dtRHmnufSYfkbHNZFBFkqOPYgAr4+6/7SbHNvhZ4HzyUU?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61C198C7F3A9D742AF7C1238E27CCFE9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	m7hLvkq0yHNt1V1aX1FPBoMKu4YGusgxd6g8KDz2NFfQqF7zqK14mA5yBoNW+uj4pcuobhwqui+g7RD9lVTI7q9ZWXs6IVAGbGn2nYZJgUuriwo8eNbGsS9JHbjdWFUAYJGQGSyFNgqDgmI8VtOtYVgIpINDdLdnXmelr2VAQyXygiqf0gA4x02RmtsaZQ2Z/DeVuvSIxSJbCjmbm0UUfbFZa7wRYTC+sKN7i9lTmxnv/oO+o136V/e1ycnJl0ILoTRRDiPCiMS8IMLo/0jEurHqmoN1gFRbVM+iWmPOLw6zpHvgnNZXZvgw9NpOdRHNGn8YTNlQmE/tJQZCH/xWnm6zPjjyy7VeTsCJZtDUNw4J5MBIPC01e29Ehepa7PBv2NbdrFxoKyl5yd8iQuI0aTMEEA5H4pgnHXncwLDEomGLb5TNxjk05fMKL0TIqMgbHeilFs3ykbDCgMRGsKvvUK1pyj+FhkLmsu/Gzng0E4vqM3p3/DbKD3TGyhjkJPR9zBcCfT+ejc91LFNybUNM54EWvNn4RGfymdAgdqvKWBSFB5saGDPBQ16wDtkXsQJyxwWqQuC7pQPnpyHKQ4AWOcILXAs5rQj6QgCUwRYUG6qQbvScfpKJ/AXqEAcJ57vDw8hByw+J3MWSwuoJp6JMJm65Aturibhx9lCsd58II8ZSv3ozti/QvRl7w7NCRn+m1LBbrZrhIM6HDnPfhGdyDo5sdhjUYtYF0uLnzcvO7cAjx+JZdCuqj6Qn6NFexuy2uuGY2ZSDS6/Vm+Z+2lbloHt1vE/nFX3zT37DQkXPgJGavXWLamwWbKgO3yh5iuA8UAZJJCCNvdpk9xfpmh72ysf2hnxlW72hI7BFkKJrC/+A7IGR9NTnDzE1mHxHir4FaQ2LGH7zvXgdgjcko45tB6VWU+/ZP3ed8KCb2JZqsxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069c99b4-285e-418f-9327-08db2f8f6ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 13:22:10.8491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7H+8PzW9smQahAGuSkC6DXSwqZU+8GlgkA7WJhOS56g/pxszJt75mRqxf95tuVc9QJEPXHDLpRmhgxQxf21qpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280106
X-Proofpoint-GUID: 8VEaaj7mVVwLjAZECWOXwJZufeZR3bSl
X-Proofpoint-ORIG-GUID: 8VEaaj7mVVwLjAZECWOXwJZufeZR3bSl
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_062232_612968_5C1E1AD0 
X-CRM114-Status: GOOD (  29.08  )
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



> On Mar 28, 2023, at 4:44 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>=20
>=20
>>>>=20
>>>> Nearly there.
>>>>=20
>>>> The actual patch would be:
>>>>=20
>>>> @@ -2031,10 +1988,16 @@ static void nvmet_tcp_listen_data_ready(struct=
 sock *sk)
>>>>          trace_sk_data_ready(sk);
>>>>=20
>>>>          read_lock_bh(&sk->sk_callback_lock);
>>>> +       /* Ignore if the callback has been changed */
>>>> +       if (sk->sk_data_ready !=3D nvmet_tcp_listen_data_ready)
>>>> +               goto out;
>>>>          port =3D sk->sk_user_data;
>>>>          if (!port)
>>>>                  goto out;
>>>>=20
>>>> +       if (port->data_ready)
>>>> +               port->data_ready(sk);
>>>> +
>>>>          if (sk->sk_state =3D=3D TCP_LISTEN)
>>>>                  queue_work(nvmet_wq, &port->accept_work);
>>>>   out:
>>>>=20
>>>> As the callbacks will be changed once TLS is activated, and we really =
should not attempt to run if sk_data_ready() points to another function,
>>>> as then the sk_user_data pointer will most likely be changed, too,
>>>> causing all sorts of issues.
>>>=20
>>> Umm, something is unclear to me. if nvmet_tcp_listen_data_ready is
>>> called doesn't it by definition mean that sk->sk_data_ready =3D=3D
>>> nvmet_tcp_listen_data_ready ?
>>>=20
>>> Are you talking about a situation where between
>>> nvmet_tcp_listen_data_ready is starting and until the
>>> sk->sk_callback_lock the data_ready cb (and the user data
>>> pointer) is changed?
>> No. Far simpler:
>> Starting kTLS will change the callbacks.
>> So sk->sk_data_ready will point to our callback before
>> the upcall, but to the kTLS version _after_ the upcall.
>> It typically doesn't matter, as we're setting it to
>> nvmet_tcp_data_ready() anyway.
>=20
> For ktls won't we set it to nvmet_tcp_data_ready only when
> the handshake is done?
>=20
>> But there might be the odd case where the data_ready
>> callback is invoked after kTLS has been started but before
>> we're setting it to nvmet_tcp_data_ready().
>=20
> What does nvmet_tcp_data_ready has to do with it?
> You are changing nvmet_tcp_listen_data_ready.
>=20
>> Then we cannot guarantee that sk_user_data really is set
>> to the 'queue' pointer, so we should skip the function.
>=20
> nvme_tcp_listen_data_ready was invoked, then sk->sk_data_ready
> is nvme_tcp_listen_data_ready. Are you referring to the case
> where the callback has changed before the read lock ?
>=20
> I would like to understand why svc_tcp_listen_data_ready doesn't
> have this race as well. Chuck?

svc doesn't alter the pointer address in the listener's
sk_data_ready field, and neither does kTLS.

For a connected socket, when the handshake has completed,
svc examines the socket for more work one last time before
deciding it's idle (a kind of simulated data_ready). That
should pick up work that arrived undetected.

Maybe I'm missing something?

--
Chuck Lever



