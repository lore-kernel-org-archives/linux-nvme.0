Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6028C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 00:01:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2738F64DFD
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 00:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2738F64DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NocVAO0X+D3p6Vb4dLgyIovSzGlckBUrjquB73eSNls=; b=AkLZiG7P6hOQoSZr8ZmbdaGqy0
	qO5kS6w05QiKy5YerVlZOTcgg6bwrCAv4gkEwLlXIifpy3vjrq/fzWjtP4AB4HpB9pz7VIjcoWk7W
	Ap3mfZvua4WpXA0xYHf2D8RpRNpAPANaJRbqtNfVpd9FPzacrIZPbnPshcgnQQIJpc4yNlMTfHKGA
	o5rkzsKbiF1SND56DR2F+2G4eGfZmYMQFdr1wYpb109Bm4AIRE4MuY1vVjSKO0kodj1/EX0BJe2mq
	+Vlt1KekU9CzrMD4QjDKZuEd0MuIwRyPUsWEc6oQIOs7uEMGnurepKHRu15M9WDSFniXElbfrlnB5
	P0yRWnfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5HEN-0002hO-KB; Fri, 29 Jan 2021 00:01:43 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5HEJ-0002gv-PR
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 00:01:41 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SNvSnU013674; Thu, 28 Jan 2021 19:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=hTMGG39eM8Fl8FkjgWa+B/be8o26O+HC90ZqgwzMUyg=;
 b=q8WoVGIkxWYTMe+dnmr0YpQGTktYAnjWmX5B41oSqImXICKm+8fa8cV6m0NLLyMR86rv
 2tHQKDyBaQnelX5px55eZQvLNZsJfldrKVO+uEwiF7yoWg/fdJZFGV4J5VYNo8f6lKrO
 QxtBzJSSUD+DYQO44wsiVHvTj4fbpEqG/J5CExk0BzKVEsIqd2bNNf4WbYRilZwIpu/z
 9EDMSs2Xvz+cEYamK1tDIi+/1PzOumsQWEe6YVG7mGHExW7WzAUNvnPCAFq2qqHm0xh8
 KKpNkz8mAPoEmltlFsoS/kEDWP5i1MOhA9ILUwUQHSQAAWJoUG6vJPaACVpMQWe6Hqml 1A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 368g0qasr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Jan 2021 19:01:37 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SNvEW1049249; Thu, 28 Jan 2021 19:01:36 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by mx0a-00154901.pphosted.com with ESMTP id 3691hkkf19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jan 2021 19:01:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+cP1oqLhhVYboXmNnOrq2bTLvLkYuRKHlAVUIidtV1qABKvMmdT0dZrlkRkfV6U16KNdz92dmBR+2g5P4P/10fpsIJA1KQJtKxDDX51HMgD3+8UStfgezQ8c4tG3hsHLzVwWmDzifkK/cdW+a3x6YtvaDYAFYmYaTmUDW3aw4+JlUnShzkN6gEG6/Gedh3G/LdgaArgx35ygRz0zYkxac20KbcsOKTExidWpNFMrsouEjD6kE2MkNtiS18DzbTGFW0MCBUZdiMa4pyEde30jWxEyg6vVM1rzMUcbm7tqZuPC4Gz35SBtD3cKYmeN1YyfStOxRDMV1Q90D15bIH3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTMGG39eM8Fl8FkjgWa+B/be8o26O+HC90ZqgwzMUyg=;
 b=X/ZoH8IRXcKlyrpvC7Pcc9D6hJWjFyIqj43SUdtSwYTqpUhkkRhS3PPhgXBKUAwmjqfEdwHSbzU+G2nwwPsOYMkrkVkvfkrNQmC2s56fOZu2fdN1iBQwXwCFPZH7Y7sYAGwqXJu/dsv+Vp8mz6RMBFBUESYKsepkye/vy8fTcxUeVxAUOaIKAdM2a2bgjrTkIrxEuXuA/6y5abQIYZ9ouP2CsQ3dMf+KfiyiggS+lUhBV06A25EEWkoF9NPZXAzejybV3VHVow+lrBLzyc3SvHNxeJDVJzUSeTY5qkRyS3YbTrPaSdlm5qAcLeSJacjp7eRLTKJbbBt4EQElSJetaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB3161.namprd19.prod.outlook.com (2603:10b6:5:4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Fri, 29 Jan 2021 00:01:35 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 00:01:35 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Topic: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Index: AQHW9Yot5sDcdvF1ckSEbnpOtZTZe6o9l6yAgAAQh7CAAAjDAIAAAIhAgAAFJwCAAACusA==
Date: Fri, 29 Jan 2021 00:01:34 +0000
Message-ID: <DM6PR19MB4011CDB6E299B8EB3F25AC0AEFB99@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210128152758.114112-1-elad.grupi@dell.com>
 <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
 <DM6PR19MB40113530FCB4DF6F52E8C752EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <9d974783-dc05-61b1-902e-a0cbe13199f0@grimberg.me>
 <DM6PR19MB401116F68376949D24B6803AEFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <53c6c0f6-99f7-ca1b-c205-05f7a03c1785@grimberg.me>
In-Reply-To: <53c6c0f6-99f7-ca1b-c205-05f7a03c1785@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-29T00:01:31.6712135Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=5b1cab33-4aa2-492a-b74b-94cfcdff7863;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48423861-ffda-4f86-4424-08d8c3e90ae0
x-ms-traffictypediagnostic: DM6PR19MB3161:
x-microsoft-antispam-prvs: <DM6PR19MB316175E0516092BF8AE17EE9EFB99@DM6PR19MB3161.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8XA3bpfcqV+GdKXcoOPB2kQzMXr9szsUIuj3A1fw4WVTpUC3PIAhosBfPvGdc4Ss71B2zZ/sL6VrrfjxKaHrLhN87t4RUSlSZmHwaI2/JnJM9UEbmaLsKvL6aCq8cW3J1fJez/MiRSbFx9PTNvI/jEL1JHtZ+xm6ziOtZqpjzpIvahbEYOQC4ShfGgN+/D1uCfAoZfzY2qeSoVWyYvDnz/+TgI1Ow4igAYHxw8QwSgBmlYoCu2dUdAbtbCyS726LMzFCf9QpNkpkcBxQH38dD5VjanfztqhQoXGookSc+uMD657dDGHq1OE7srFyDB3tByXL+sk3TurijC77dCCYa/JzldGu/lQ0vps3PCXaZGgmsTeJQvmtawQH07WK6kO2sz1doQk9O0W+tmdj09r3mw4oX/4VCjJd7XhEgRMhoyVU2vauFznIDqSjADtI6XSiuNYwHY6Fq3HzegqpEBKMrFYLV2BA7yDCpuSBSDZakDSsytaWg028vn5gzdANg3BXeYD+MYCSHyWdynhvDnypQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(6506007)(53546011)(8936002)(26005)(186003)(7696005)(786003)(8676002)(316002)(55016002)(110136005)(9686003)(66476007)(2906002)(478600001)(66556008)(76116006)(64756008)(5660300002)(86362001)(66446008)(66946007)(4744005)(83380400001)(52536014)(71200400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?SmZYQ3hPZWJkbjFNbkg2cS9rQ1IyQnk3TTZkZGNiNzh0M1NORWZGOHpPOHla?=
 =?utf-8?B?cHB5cEwvQlBDK2FwVGlPQytTM3RONFE3ZkxxNTlpdXk4SThBeDA4LzVVa2U2?=
 =?utf-8?B?d253cDhoQ2ZnZ2dua1hMTDMwZ0FHYWRrVWlHSkVreUpvNUpzdU0zMklFcWJ3?=
 =?utf-8?B?MnFlSEdJWXFDdE8rUCs1VGs0VjBTNWhraHh5UVVWMTBVbmJqZ2VvNnByVHhs?=
 =?utf-8?B?enZZSmxZK0dVZ1JSczF3MFdRcEFXOVBoVFYwVFBRRUZjYTVVclg2OHpueG0x?=
 =?utf-8?B?VjdwNkRKQXFLdnI0ck5qeVgxYWFnK0QrclIzbWVYNEFkZFhNSklWM3V1VTIz?=
 =?utf-8?B?MDA4dDhuQnNodEVSdVVOc3UzN3NjblhBZGl1b0FybThjMTRRdm9wNjZEV2FY?=
 =?utf-8?B?MkNVMHJGcFBPMlNBU3JoRzg4cFBLb01LcEN2cTBYUjNmQ3dJa0xpanpDQ1ov?=
 =?utf-8?B?UHBoTTVtaG1TTzgvL0kvbFRUSGxCaUs1aVprNDhuSnQ1dHlQbGNtYVJEMFFQ?=
 =?utf-8?B?RU4zVENWcXpWb2RFZVUvOTMycHNUSytrVkZTbFFLUG1DYTllVXZFaDNBRVZP?=
 =?utf-8?B?R0lQVXJHWW4wU25tTzBJQTlMRytRYmZqeEJyMzdzZFdZVXd6RkdmS0Y3eE81?=
 =?utf-8?B?QjhjSlVTZ20rdE5VRVI4WVJiVHhPb2V5TElON0xpMkxQM0dZWFR6aDljYk5u?=
 =?utf-8?B?RmEvMDNQQ291TGl0ME02a0VTRDUrY2E0TXAzUTFSUG5pNGVLUW42MURwLzY4?=
 =?utf-8?B?NGdrMzROWHZubG1qRVdpVHRtOWFyNVJraWxFVTJWZTlsb01oTVdGb2lXNEQy?=
 =?utf-8?B?UHV6cnMzVTVDY0NBVFRqemFUQWE5S3hJZFc3UkVhR1BSakNwV2NkRGNxZ1FH?=
 =?utf-8?B?S010Z2pvMlBobFpYZ3NHcWwxZUZhYURGcDdyUDd1R0dPWVZKc3JkZDl5OE4x?=
 =?utf-8?B?aU9jMnJHY0dPZzlCRkxoZ21CRThXVzc1bGRrSUNXSFRiSWR0SElnNnZmUlUr?=
 =?utf-8?B?V3E0WjBHc0pLdElTMmk0YkZObUhFaTZSN3hMbGxNdCtuWTk0U1FXc0xOQUh6?=
 =?utf-8?B?dC8xWGRVTU56K3M0eXdGY1I4V3U5Wkp2dGNzNS9jcDc2VGh5S1VBaFdPMmsr?=
 =?utf-8?B?THJ3Y01ndG1zelFyZW9MVHptZTg0MVhPaC9yd294aW5SZVVROEZUUDh0d2Z1?=
 =?utf-8?B?eW5HQVJWUUtCVGxjTHFtOWJCb3FLSkQ1Q0pLZmtIWmFtSkhHVkhlMWFwd3ZT?=
 =?utf-8?B?dTNBVWM0Q0pLbmR5VFd1dkNjZThzMVNzamNPUElMWm9qTHZNMVJBNytRTEg2?=
 =?utf-8?B?cTU3UDdKRGs2Y1RqUUErSmw4aU5Jc0dBTG53NlRpNHc0dXQvS3F2eEkrcThs?=
 =?utf-8?B?anErS0cvdHFUWUtHdWI0ZG1KdkZ4cnpyTXY5SXZVRCtxQ2MvRFh3Y3BrVmVi?=
 =?utf-8?Q?B6zRFtyL?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48423861-ffda-4f86-4424-08d8c3e90ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 00:01:34.9499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6Ko0nZaXaZLZazCHSR6kBwMtUElBhQuFEwrypjspx+yxw4HEbYwcrexyTmdnKyk4L4XO2H5kGJnILp0hGuC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-28_12:2021-01-28,
 2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280115
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_190140_939297_C19B8A4F 
X-CRM114-Status: GOOD (  14.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

That's not what I meant.

My concern is release_work races with accept_work.

nvmet_tcp_alloc_queue is called from accept_work context and still accessing the queue struct after setting sk callbacks.

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Friday, 29 January 2021 1:54
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows


[EXTERNAL EMAIL] 


> Release work might get invoked if nvmet_tcp_set_queue_sock is completed successfully and set sk_user_data, but sk_state_change is triggered by network stack before queue_work_on is invoked. That case - there is a race between release_work and accept_work.

This is just like any other case where release_work races with io_work.
That is not an exception from other cases which release_work will need to fence from.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
