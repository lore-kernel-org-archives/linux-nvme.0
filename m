Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851FC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 18:36:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26FA613AF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 18:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26FA613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tzxVmh06xehKrT7kCIslykx8jf5C17qqXsPBDr0DInY=; b=okyxAUbs5bxfNSCzmX+SkVSNUo
	BFYReFckljD5togsVaw7NObfvRD77qOqQrhonUwqGDiJUjMx6So/Y4Ok2UxI8ZZ+T8N5xugPEiJz0
	WjyZA0hlVs4qWanDCYiudC0IYYPGJLf4ZnklnXTuSof58U0SvVeNaRgx1mYPrzCY2TKcMbXh0NxZR
	8bGifZ0aNaMAoxAYbkfp3P907Zk4wSuIr6uDbDXTt1F/EN2Mr+mGjq5GHWp3aNWSjXGyt5Jg5oewU
	JKIA35a8qQipxpjcsXcQF3lpPdb08DbC72HoyM7bqrrav5alZ/uBbO0FwbNuWyJWtC8m7ftqjePiK
	m7WCtIZg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYvEW-00CrRE-Ca; Tue, 20 Apr 2021 18:36:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYvET-00CrQm-Q5
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 18:36:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=y87thDCBbH8n5qsddaUrzfvtHWb+PyLdpSqlZeMS5AQ=; b=pEkIxDFTGjp8Tutdk0glRgU4Gg
 vwSVoxc9mn//Ud1sxZlUC4Ehwrs+y7wZXn454xAqL78nXeFW0ZBbi/CwNeb8PmDymKPUBQqrYwYAN
 c5neYrSfiVsZc4VWlrFOX4PpwG3Fjf6fAfi8qWaTTaZEC1tG5K0LTjP1yOuLNv+B2IbNtV9jCh8en
 xs4ctYUnjeyoIR9sHgBWdecdKTnKLkndClHGIBx/GKPBzP+bk8hrEtJD8GlvsfeRh2Gk7iDPPbwQ5
 SZStS2Ifs9Zd9+b64JebHu+Sb8SxbbKm8JRAb6I0hxMhC6XfB9FqRMqt7r3LdKSAS6TFIwBUtQm8I
 xi70Rbcg==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYvEN-00CLoc-Qi
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 18:36:19 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13KIWAfi024261; Tue, 20 Apr 2021 14:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=y87thDCBbH8n5qsddaUrzfvtHWb+PyLdpSqlZeMS5AQ=;
 b=pjVztoFI2H1WA+k9KC9uc9U5N+V07PoiTBuWh//CdCIFgyAwlXJTHSE+MSWykleJjn19
 BTiRBCaJnZn+Fe+uavHY+bkAR8cDkm2xO+7/HkFl1uyEL+QDKWmATz8hhwVQ5VZ8sXvK
 g9vC/otq8HkoIpE/sO+7fbGyRNWQwIue/5DOKliOMtJHVWcXlyAS+CTuk11SkdGMzGHP
 g2O0bsIwIEQPHRQnfNK3QtCGK2DXcYcVNtda3bX18JJ22g4bWs5HWLnlh5LAKQMfyPK5
 Ibn5eXg5eEnY6U1jnFaOGNxpR5VGrxzTua1jOw/MLKzhtKZTAaIEizTwp2pxC43zDrcq Uw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 381k4kuu25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 14:36:09 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13KIUskX180179; Tue, 20 Apr 2021 14:36:08 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by mx0b-00154901.pphosted.com with ESMTP id 381rs4b96x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Apr 2021 14:36:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k977PrrNNRMnX9VgBwAujnGi4/yGkbhhcPvb19IsDErdKqi28C4SZ/ZPyHrte0qXMMef38lrFruAU90K2Eal7KN2nOnnXAvxwrOUYRl/lShEzQ5PMBNizzcFmi1uHuMV5L5A0QYmxzg8pH6R+zW55EmD/6Rr8ID0wy4quEgu5uUt0ujdC1B3LleHQ2VVWPGmV9TuXJNKv/7qqrPNbc0XrnIwgccvHuOxzZJnx8XPWDI1NKbTJ+Pz4lW3t/WtCBYloId7qqAKuJ9FoPTf3qM7qpQh4X5br1I3X2mFixUZKGUKrDuMdasTvk+xCd/d8p9ndikVzsI7y65VaZcJ2VFHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y87thDCBbH8n5qsddaUrzfvtHWb+PyLdpSqlZeMS5AQ=;
 b=IXU60zg9aPUDkbCW6xaRMt28yogBi4itloUDbUi1OJ7E3VfIPjYPejcs0GAGFWKL2n2JE3Yc6QAfuVpTIuhjmTYA5DZwcvOl/QVIhOdzhtStt5XzkSElJOGC86ZWKB6pLXdx3gZo5L9TzSJf7c9UqXpn2EAYQntjwY6fcxIuyTqwqdpDA3qf/wyEgWbU9an5ZLCfcwyrUQkWJjuRs5rf1YQ1SC8wkwKVKvbEHfcGTsaru5G9DJymOZCmAgzZrqV0uQsnMIpmANIvLXqCcuJKrCdQJMP08PyRwIhJW+jsATr9Vs4naqaT2h6JT90MOF99S+MrMeNKnTQJOzA+6+ac2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 (2603:10b6:207:38::12) by BLAPR19MB4420.namprd19.prod.outlook.com
 (2603:10b6:208:285::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 20 Apr
 2021 18:36:05 +0000
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::217d:8aae:7fb3:6e4b]) by BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::217d:8aae:7fb3:6e4b%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 18:36:05 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: kernel panic due to a missing work initialization in case of zero
 kato value
Thread-Topic: kernel panic due to a missing work initialization in case of
 zero kato value
Thread-Index: Adc2E8Oiq7m3aTjzTmuQtah8cWT2yg==
Date: Tue, 20 Apr 2021 18:36:05 +0000
Message-ID: <BL0PR1901MB2020A15CA929276AB8FC7E52EE489@BL0PR1901MB2020.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-04-20T18:36:03.6159414Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=ebd62339-58c5-482a-a3cd-ce3e8d1cd6b5;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [141.226.10.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63d10935-3d0d-462d-38c7-08d9042b285a
x-ms-traffictypediagnostic: BLAPR19MB4420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BLAPR19MB4420735301372DB0281C8643EE489@BLAPR19MB4420.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xxL7N727By8+yrdp9QP2PaaXyVxPyxLLvZIocyO8PO2HhZk9sJ82xGlLd3FKisKXuPq0MbbMURU8bh6Bj0V4EVj15zkExeDdN5LUFny944PExMUQ4/x9C12V0TOfFjj50HjNEovWTRGiBksmwHyVoYyckbaB4HNZ4gzeO1++xL8LQSw75WBuz2chXiDxCe2SJHP0KN0s5Bq3DcHANu31ip2i9R6AR3Eph1BDWvMMTrogDe7TscNVUzkrVOnouQFgiU+IOARVZdid6/onqPpLAxyBEDOu8AclWyfvqvKvnDIo+fte+NI2Ab0d77FctckM9FRJpBU/qpfKkWfMVKxiEbXOyjvlwPKy/xhXrpwPzjX4wRN8nYcKF/8hA6iNy54atPwQlFhh4I2At7lhLNbzwmlf/8MEVuTd+bS1B8ctiZWGcobkrSRl+3LLCxRPeO5sBZOYgouylRErYG0Kj7SKw3NV7MvXg5YsJWbR9kP1mqHdRuTunXHkvzx0+FiqpAnAKDoQyIaiQcD6ksZx9WO2cjs9IdfkyY89y4ibeK+UVg5JiQOQJsj+YQEzTycPGzlJk/XWisU03U27UtnQ4G6ox+RKL6W0DFoBSbdOk0R0P0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR1901MB2020.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(71200400001)(6506007)(7696005)(5660300002)(2906002)(186003)(86362001)(64756008)(107886003)(52536014)(26005)(8676002)(55016002)(9686003)(38100700002)(122000001)(478600001)(8936002)(4326008)(83380400001)(110136005)(316002)(786003)(76116006)(66446008)(33656002)(66556008)(66476007)(4744005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EdoiOLVRULn2xO2br2UPr72OXWXheYvB0nm+cKlJOTzgTmhiOww+MIYczJQ9?=
 =?us-ascii?Q?uACMGt47Jj0joZI2fP7H8mEP6UyYbdLwgcm9V2Il0IYt5cwtGeyaaWgANN0u?=
 =?us-ascii?Q?rz5EHxoGA+LShQatuWvW91q3wAPZHUiKzs0/wk7hZPx2ThjTKxPJRaFqdgr7?=
 =?us-ascii?Q?gW+OU7VdQTeiolfXa9mcGSzAR9YLTRJyINrOnwHofp6kuyUMlhNrJvOsTA5k?=
 =?us-ascii?Q?jD4LrJwR+yr50SEfvvCua55O9z8Lah3N0iCrTdh0Ld2acHjf8DsMKmeYQcFs?=
 =?us-ascii?Q?eyIVoiFU5sha9wC5aYDLmMt6UXytNf7REGvJEn5h0+U8cUuwO53Q6br7SpRQ?=
 =?us-ascii?Q?BD8VqtP9vKchhWrwT8Op5i/XwS3Wo+Qf7fhVDzcBrYpLsHzc5/kFyXhQK/5u?=
 =?us-ascii?Q?FL3eSHhGY2bJ167eaiGZwHJenoo3dUQqGQAbWehBCMDCKD45jHoTRlb5H7N9?=
 =?us-ascii?Q?i6+Z5Ewjh93JalNP2/iei6I/0HZtohWQBrauLwysYr8/EsOnb2+ELVF7pUQn?=
 =?us-ascii?Q?sG64gq47mq18NiVzQlOkkhkWUDUG4Qgh2QcAHcEfJR/2KOOZJ2qhZxHHGjBn?=
 =?us-ascii?Q?iwabIQn/qGHyNGoaoWkW7xCkzLZMckymKb76Cj6Hnsnx1aeEeUJ0xk8sH0uU?=
 =?us-ascii?Q?rHy+DdcErz1z6++Llku9+bhVlykqNoA7+aK1O/4ehIdc3ge7b/v8GbeoJexO?=
 =?us-ascii?Q?GzX7F99Eu+OUeM9eoTdhAgfWu80A/MYCYrkPwc3xhDH8eTFM+ebcKZIzF2z9?=
 =?us-ascii?Q?yKdFI8yvMDyY7ivvv5jkpJemEi5gvK8iuzj5VEDNCxnbsFwo3WpBqzJIvqIw?=
 =?us-ascii?Q?XbP1+cUmbYBR8l6BJgaCCeb2XK3M4BVxwtBidnQ+kFuat+St8/av8iJaBzFS?=
 =?us-ascii?Q?ri0MNtG+N61O34FVsMlioCimKEYyw0G3mlLqPOHcdoEN87EuVln37VOS3UgG?=
 =?us-ascii?Q?X25jy2YcXLzfxk/dmXX0h5x1B9algpVMY/2pKLLO1scBF0ChcCDPAuN4yAll?=
 =?us-ascii?Q?ELzLoR6SDjXCSSk3M3woY9osz8uI83NQ8g0i0VO4WvbnwGO6YLUKbduQ+PHr?=
 =?us-ascii?Q?86hVskag7/jipiTD8sV2Gk2+8AfQAlTDrIQwTHjwTSmbPjKHyCWnYLY9SVHR?=
 =?us-ascii?Q?1TPtQlCgxNI/ZZHED0J2tBeaEeLR6aE2mNqpplliUwhQ+gjK32oT4+8IX3h7?=
 =?us-ascii?Q?7X1sJ9ohm7BxW1K1ZQ908whRUFpQRrW+o6hs7BSKaA4zGg9xvjlcGO0RpF4s?=
 =?us-ascii?Q?8ekH61gCk8LlScHo8YZbZfPy6Y8hHitAy9EzDmdQ4PUH6UY5uIeiFZElLv26?=
 =?us-ascii?Q?vzDRLV451aQu0yhMmVD8KfP7?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR1901MB2020.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d10935-3d0d-462d-38c7-08d9042b285a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 18:36:05.5272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDU1hm0Bw4VAZ8HZMOHxKMnflQ8GZIohwZ2jV/gWbQ4NaMCOsXvqhWNImRNaEa8uR6Hs0mYwQlBBWa9lFXaZbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4420
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-20_08:2021-04-20,
 2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 mlxlogscore=396 clxscore=1015 bulkscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200127
X-Proofpoint-ORIG-GUID: tY-WuWoa2lk6qxURPOU8ZxYJy0eKEwgD
X-Proofpoint-GUID: tY-WuWoa2lk6qxURPOU8ZxYJy0eKEwgD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=506
 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_113616_053150_5A627C70 
X-CRM114-Status: GOOD (  14.16  )
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

Hello,

We hit a kernel panic as a result of the below sequence:
In the current nvmet implementation, as part of 'nvmet_start_keep_alive_timer'
nvmet_keep_alive_timer work will be initialized only if kato != 0

when nvme connect cmd is being executed with a zero kato value
'INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer)' will not be called

once keep alive cmd arrives, we call 'mod_delayed_work' for a work that has not been initialized
this will lead to kernel WARNING:
Apr 20 10:32:59 FNM00190700796-A kernel: WARNING: CPU: 11 PID: 75133 at kernel/workqueue.c:1447 __queue_work.cold.55+0xc/0x3c
And eventually to soft lockup

A simple fix for this issue (I will post a patch soon) is to initialize the work (as part of 'nvmet_start_keep_alive_timer') even if kato == 0

Thanks
Amit E


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
