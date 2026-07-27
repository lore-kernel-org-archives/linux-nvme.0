Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B2AC531FC
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lbTEIOLjvuA1onKpQKJanOpNONrY1h6Woz75qsA9gmA=; b=NrDGpjD0bmrTs1PJasqxfMd2Ed
	fcrfCfQz7n8nQeRJXmlwyw+DQTb4pw93IXRuwbXNmZvDkd3xTbWm9JFXsSzLSsYI/ppS7OKpqoieA
	DEFkk3XRcYCUvcDLdkkI1L/w2RdIjoutQe8eVomIyGyGSpBuK3e2qSck1TEBNwdpcuPGT6G78aV4L
	Hp9+XVn7NQeJv01a+KBCZnLvYKE84hY9wBUOhCYkmdcMjOYRurKIsxD3kvlfsc7SOig+7Yf6S95Gc
	GpxguO7lxMh8gGU26vnh2SfA7p33t/xc89LzKn/8b8sdZyK0RhjObM3+RDJ8kmqxWaFZ9T5VOw2FW
	9qSipSbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMYp-000000033Ce-3kT4;
	Mon, 27 Jul 2026 14:44:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMYo-0000000339R-2bEQ
	for linux-nvme@bombadil.infradead.org;
	Mon, 27 Jul 2026 14:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=lbTEIOLjvuA1onKpQKJanOpNONrY1h6Woz75qsA9gmA=; b=UES1JYAM5bywJvKXqPhWnBoyCr
	J6Dg/4WdR28jVkmtQabZD0VSmt/tmIjqXuEXdWb9bj44W6RPw929eJMc2YMJj5s3KLrcUcGAv2seb
	F0PvzWtg6M8nWk5ua+gsOuMopGttji0K5hbLSWqcn8X2ka5tyksmhUaPQLVAj04SrXYSVOveTc5eh
	JS3ZU1WZ8DZ1pzZlaR6A4KBhqJsBHak7zKBfCJfqKMDDPY0FcXuA15df0EG2uzeGB0CBqiCqQZ0Sq
	UAZlsoOVWKWVZGqaZ4SzIqizyGz5DFuG0Wm1YFMz6Z+EOoGHLtakvCb0W0fBNMi/enjbT+QU/VATq
	NeCr7XOQ==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woMYb-00000004Akz-0OBT
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 14:44:05 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RCTKqr2082501;
	Mon, 27 Jul 2026 14:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lbTEIOLjvuA1onKpQKJanOpNONrY1h6Woz75qsA9gmA=; b=
	jDn9J4yFR3SHc8ohaVhbapEcBvWHAR0yNEUwFlBdYMSN17hjDKi4GYmjt37cWQHj
	xbEvZ1baH6g4Oed1bliOG8OzX2JYlqsMFOpFwInx5B0AlutHReeo1f5uriq+Z4LX
	O/mI3bC05iCIY5m1Ch3td9GkT3PmIolYzh2vfGzC/jaw9PTLlAPXirl9FaHu0wCJ
	b+JRRw9RpCMTqDziGo+Oj8QxRWyQx2pZsYbkdCauTQPYhZRnlXhRx13lb7NCbyle
	eTZ8NULMvWPJyvUOkvmMcum77Nnugwr+h0p6L9Yr0vbX43WnrlVG/mLKIjRuyeTt
	PjE1CiXkNcYHf9KYAJVnNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmqym1xmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:43:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66REe1Uh006889;
	Mon, 27 Jul 2026 14:43:40 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh8872yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 14:43:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMbkJ6tHeEFvXEC4F0BbAiaHozjqh1HHV6ei3Hx6vlSp61uK0JQ5WZMs72cHTyk4mr896gU/d3zjxFCh3YjPp8Fencca4R3Uz7hj289pBHvMhwnr/e6DxLx0yfDxpIxKxzjwGnXdWbOAE8II318hAtzgLs0zdmIkSpMk76s6rCEjN3Fhw21EqpIKf9vgesVhRmUPtRSPtuBGSHCJZ6x5szMPjWAkc7zCFrVY3ACkvs+6FqL6iW99sbYc4l834fkTuCphhhbKQ20Wsn6Sjc26aGN2WGtaZEe4tvVKbIM1kBJgv5PqgpX3pcZK4/izB0368hjVVjjckIbXo13GfS0rjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbTEIOLjvuA1onKpQKJanOpNONrY1h6Woz75qsA9gmA=;
 b=S+hRG6JZb09JWk1QMDSoIczfu/Xfck1ywa/q4soPSbC5/ourkknKsHYS7NHZH9cYuWRaA4HFYJnNisRBkWtyA9cIZJDStuVFO0LUL8Pelarw/UlecQa8pNfRyrvB4EHpdV3qsLwIn7hz3xyA3dEIloNL+mrz/9K30ql+hC6SIEuRw7Dm8ao8zPeNERb/Pz1mxXJvmNR6UlG4AdexMlfvEe6yllCxRwr9lh64qZpOSC4wk8PekjoySsSgkz6xl47uRccbEkzNhHITs8r8gXBIN7ozqQTk+zWOMBDONYk7ahBYHt1Xec4gigT+UTjzsefOitRq473vb0sCXsZOlONaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbTEIOLjvuA1onKpQKJanOpNONrY1h6Woz75qsA9gmA=;
 b=viM3b1E5wx4s5V4BcpSN3b/ArT74oEtqB7QKdMv465KEzZ226t+CBuUOHd6fx5PjYEf1tWqEeS/aWOYiAomkpyYLDAnU3y8mz0s7UC+CBY3szrUz5rWQ1y5cGqLx511V+aUl8YRV0xyqrYbVcatkdLmgV42bLlwctDFxYzC+EP8=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DM4PR10MB6087.namprd10.prod.outlook.com (2603:10b6:8:bf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Mon, 27 Jul 2026 14:43:37 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:43:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, nilay@linux.ibm.com,
        john.garry@linux.dev, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 27/27] scsi: sd: add mpath_queue_depth dev attribute
Date: Mon, 27 Jul 2026 14:42:34 +0000
Message-ID: <20260727144234.3802948-28-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260727144234.3802948-1-john.g.garry@oracle.com>
References: <20260727144234.3802948-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:8:457::12) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3320bb-14fa-4655-57a1-08deebed7149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GDxZYKuBvxap/LaZhOOjOMQWfFjgMrmVGCQnHHYZMph8oW5FwOir36ZMWhw3mxCJU9JrEHsfshMI87pbfopl71wfOKrMiupJs2TVA7LMmuAoNJ9GxmwACEcEjL557lKzJBvUYZEKQ4b4rE6eMbebFwe1TtgzSlcuStA12/7COWYhqYMKAsLSTBwwTUvqO5edN87SQDl7qUFNV4pqZWumxwEAnoyuaG8EIrZr0GsazawsrgN9JcOgSTXtu7HoBcHTSXoaiJW70+ESPlEpsZrmoYODsymT9ZRcUDENVKf0MxrrGXHFuVmC2epvOLctoPvcvCbBj650KBoDORHZdYAfhvssYOaCYuxlnjUQaYtlfGwHIkACFfEHj9qZ4VQyRyUcngXluUbMLqWJD41eSrEHGgO7cpuKrsRZBeQJXqJA/joZ+AaehRxsSPaz+5CKpVtwdZL50vtqC7AdFlIiGJ+v9tmm/vEOSlyCa9Xkp82yQVeo8nudBFFSY7SvTd2uiSQ9OgicQYCZVM/7cFoI2qnR9ppxu2SsiVdNdYi/K1nTClYZPSfB+pIYeMPRE7H5e7OfxZnmMZBWwtLA92ceglf85mqvqxeKLXESRunhIRNMShAqyjqi4i4X1bUhztmjn9KDUg3+y82cT3pxZ5mOwNSU0sA45qr7f+Zj7umnY6yL+Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YPxgbKePvz1f+ABbo1uf2WCl3H50V16AnYZ5kWSLI3hhhsW4HbkF4umNXGvP?=
 =?us-ascii?Q?pGKNk0aumB18aHv3gGWVfQWuHiw4lLM5PR0qmT5U7fzPBBAJZ6jAIvJj1Jak?=
 =?us-ascii?Q?2rB0SHm3aTizLIeykkwmsOCgKVInPHikSFDutHdD+By3MdJCKufEkqHFhsyO?=
 =?us-ascii?Q?4eqLTt/yt4Z/qmAPEank8U5Y12BTiIHbd8SPmk2HXMv0MlGWkMDPZA2ccg5y?=
 =?us-ascii?Q?nuF3So7loVpOE6vT1jOgaInD/6ZSqHPv/ePUsZlnFvfPIbJEfSo/M7Ie/KTG?=
 =?us-ascii?Q?1StAS+MwvxZK0jo9/BzO+YWEfAFxWl/YV6sDKxRaoPrcyWaPl3h43oN/Fziv?=
 =?us-ascii?Q?1JgTL0OE2O9yyL3nMFsOVA8TCDmlnTbn5nq/SrPgOAIDo/IRERRPdEUEM+gw?=
 =?us-ascii?Q?X9Gbuh6FM9uHeNaVVmXKcFK6E2FPKRlQaRmbhp26s92Y4cdyxVSr2ygE2CsN?=
 =?us-ascii?Q?W8gZQt6BhlXSpglUGCI55vEMlP8Rnslg/J+DJMQ5Rw9dhOUU1pU99yeCWyiT?=
 =?us-ascii?Q?/rJzkCBvcZlbMrkoJ3UFiaj7rFTJPDz9Oub5i0UcZDL0JptNFNlCom8sGrwT?=
 =?us-ascii?Q?scr1xUc5YjaKokFKMAkYL9Y6LNqbxU9U4S51i/UOhJf25IyLDrvvW5Ge/J0W?=
 =?us-ascii?Q?cXNyr9Tk3yXKbhdfdDAzCBAjJrIglKvm7MIQeovSglmMrPE4BG9wCmTwlFmg?=
 =?us-ascii?Q?yIoTIWVN/zYH2rKVjI5YnI/xfPi8/5EjRf8pNtrP8hyswGWJZTWFRxFsEoJk?=
 =?us-ascii?Q?wP+d3vz3HPge1Ir241Laj12rYjLOXaLXpQf1CQ6HloZyuXFNHHivL379P+pS?=
 =?us-ascii?Q?McjtFtFI/Kf2GUbk1mLL+KubNAXDkdKOZdyuuIRzvn33LpXqDlF+mttZk3C1?=
 =?us-ascii?Q?+vXS4Cx57WEWZKROcl5qqjb6Kt/4sHUZcLYDsxtXdFJp2QfrtO17lwBFyfcF?=
 =?us-ascii?Q?c/NRtWZpU8KeeHFHkng3uKqRrXW+VQCJj5RKRdDtwdHPxjZSPawvjrb31KGH?=
 =?us-ascii?Q?yYO/qbI6G5CKTpw0YkvCYZpV4MIzJ1+tveEuhNqR3MJ6NxmMjpcQlJevk5yW?=
 =?us-ascii?Q?jzW1hd05i5QJ88ZayxexTTWNQ27q/gGRLv4GcQZHkDzGitbxohW9E5T43Oyj?=
 =?us-ascii?Q?9VcNYY3PA8VW3kNG1szO1J2RK2v/GJXQCbLx/PUqzjTNOof9FocdqVySAo6N?=
 =?us-ascii?Q?nqS5jtiyZhDy5rkY567BvfzrHN347uHj3uAYP+wMwnp6g2FR/F4Bawxx/XYX?=
 =?us-ascii?Q?4ewBlZ1a1EkUrEF8mUu8TjeccWR6O8kIjMp3xdygG2Xd5mMW+PJCM5vPAJdl?=
 =?us-ascii?Q?UxLWblB6TRIq7G13QdHYQRyNoeccxrv9s4NBA53gLOMwvAEKWTu5Lewy8Qi1?=
 =?us-ascii?Q?ERhPvIz/23+1SNnPAvXx1+eEPE3DUYRTlaPLk/972a1shQ418gWMq1cFLnB8?=
 =?us-ascii?Q?bX6bjZYkuz6zfvcd9zlASNw5nI4Lcxb7az5/VNOzqf63fcTY1Hmmj0++92Ul?=
 =?us-ascii?Q?wTFVig16aInvxztDHuS3s/xDjvR5joDUTHRQVJc1EkiJ2+Ath+etLFYmy9fg?=
 =?us-ascii?Q?JJlxc/poqpjZxf8LrnOVOY3E6D90CbLoqOmlxio3ZE1znJTaA2KpNmO2zu3E?=
 =?us-ascii?Q?iggSk8jbI8OKMCYmiuq7eoRdp77zSxEAv8+bnD3zy2Ra3b6SatiOPIdQH/6Y?=
 =?us-ascii?Q?RFipZjBpKXvB/OqKbxGM7EO3M2xmeRuI4QYCL3Y1jKqLl1WpfXIaf7dZvyZb?=
 =?us-ascii?Q?2fBUEFlVBDzD51hkSyX/vyO9E2bD3Es=3D?=
X-Exchange-RoutingPolicyChecked: OOzjLJRboax3rAvRlhmMvKlDKz+ytSfij2WsJcHrDwwRD5TwK0VeLzCPPSYFD2rZf0NMZBMC0m0lOQLnx4OsEbTT7Ul/AsjCu7Fvw1J8BNI2V9+g7NkRuKUi9Dro7vDlCo8moWexmM/pKQb/ri8vpHvjz51Jr1ewhWdrINzZ17xHggQQyqMYgeTmBKbmNCtcHNhl2noLN0WrEJeDlSWt4xTKVeW6IMbEmO2KCVjk3CNJ06oRwhiNaQ3NMgeEGxzTNs2qOaLeTx4e+4QywiSynDlsqqzJqqnfeh4rE8RPoo1JMOsWrl+bVuCmTUILR7sRhIeuxwpAfLBO0EBMT+AF8w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BSmOImRPbCaPuqGuDe0TtRA9Hfb/MHQJmoNAap5rXgMMFsfvEKYIYT16VorzLAXaDsRoLfS+zrJfoKa6WE4VeU3+M5Q5MSOu9dFj0ve7PcMIZGycDPy/8yML1MXQN1hQwfvq2PTaDHs232DciJ4eH0SvgIqtJwHjSiuOvXlVQRheesckjmKqn4+ljeQBMJCQfpZ009dt06ldcR51zqgK9El4iGlXGohrhJgzFPrZTXJWPUe2rV7d+MHz4dREh9Ol064lqA5CdFvzL1GAdghxoVeI5KCRDRyFW7gbGnAR4S+iPNUyPP37OUiH25M9dSjgAKdJCR8CPJwv7PTvy2Yle8PmiFIXEd5N/PtS6Xk7gVrNrBdNqSUkjtT0jk8YvSSrAPHgLe3A573VnDkO/2jzzC2iqOa9jTA3Ausxt2M2pqfBBbEisLKAEK5WIov1VtIVPU7yP1/Ig+c3yG8Qz8Ul5TmuOiBGEZGd1E7AwgKpH+Miw1O5TaSepEtA3vev52wuymeD3bj/or5ozhO47faWMbILFa7vUFbSRrPt8uduF1wKO4kbelWOZkDkJa/ojjW7YQcZMZlkHRG2RL4XAMnSICh1kdz0iIhiLnA8Hi/d2aw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3320bb-14fa-4655-57a1-08deebed7149
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:43:37.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiHmwZI/toq8nCp0MTwCl82xuEbPNIomYA6Wz+VFwEbXbkdPebn2XuhOYphaMSkjDO5KAfhqAuCznt+jf1iY3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607270139
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzOSBTYWx0ZWRfX0+Pe7itZlCtu
 aMyOWTjo7mSn+CM/LE2iV805DK20LUXtN11U14PTidL451gCjQivkPFut+cVyAPjAn0ylTrmYy6
 Ob6zxpN050QW+j1dhVMH8C7Ck91J6l8Vf1HxW/AzMkEqoljSUJzg
X-Proofpoint-ORIG-GUID: JVwkthauloS2pvOuGqv4MKv9tUdr76jz
X-Proofpoint-GUID: JVwkthauloS2pvOuGqv4MKv9tUdr76jz
X-Authority-Analysis: v=2.4 cv=UOrt2ify c=1 sm=1 tr=0 ts=6a676e9d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=bA5FzAUjrTEoIiOIIUIA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzOSBTYWx0ZWRfX2gK3fbWp9nWv
 2PPYFdirCuIsC8s97RB1FsFrA756VT7EWE3qFXNPTIvQMKazQfOtHRr2JLj7fmoTP+L6W/jkJGT
 BO6wxSE9txDdFDr6mzryW0ahE3gb4s6A6Gl/9PIzwLRP/Ydb3ognYrF1ownJxgtf0BhoqgXt9yw
 EmKT06SW//gcdSLPFGirEKlew4PIP8rslxVhYJtg3IEODLrDek76KiTAAzOUMp1ize7o2xrAfIZ
 EQRCzFm0Ks4z6/ccJW/+PkPxhVZLivSUYI3OqE+o+DTQAlfzK6X5pbTWDCm1avksEW2npft2PGm
 A87HCltwTTK82Qzl/QUcxKBFj/KDL9afj1+ktr5uFQpLqQYxV4sxEKLfbAFTFIrGUf5OikoUJVT
 i8YQMDTi1fcDld6uhJ2uMqZSdUpke9HZDLtudupu+NpFM0gdaFVXk4KxKQfX45hP0aLAwlnKsKl
 xDFgJ5OtVRcpcUfw6Ng==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_154400_882699_3EBD9262 
X-CRM114-Status: GOOD (  11.67  )
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

From: John Garry <john.garry@linux.dev>

Add a queue_depth file so that the multipath dynamic queue depth can be
looked up from per-path gendisk (scsi_disk) directory.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/sd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 6b6aef361ae22..fbf9da686f25d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4159,9 +4159,28 @@ static ssize_t sd_mpath_numa_nodes_show(struct device *dev,
 }
 static DEVICE_ATTR(mpath_numa_nodes, 0444, sd_mpath_numa_nodes_show, NULL);
 
+static ssize_t sd_mpath_queue_depth_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *gd = dev_to_disk(dev);
+	struct scsi_disk *sdkp = gd->private_data;
+	struct scsi_device *sdev = sdkp->device;
+	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;
+	struct scsi_mpath_head *scsi_mpath_head =
+				scsi_mpath_dev->scsi_mpath_head;
+	struct Scsi_Host *shost = sdev->host;
+
+	if (!mpath_qd_iopolicy(&scsi_mpath_head->iopolicy))
+		return 0;
+
+	return sysfs_emit(buf, "%d\n", atomic_read(&shost->mpath_nr_active));
+}
+static DEVICE_ATTR(mpath_queue_depth, 0444, sd_mpath_queue_depth_show, NULL);
+
 static struct attribute *sd_mpath_dev_attrs[] = {
 	&dev_attr_mpath_dev.attr,
 	&dev_attr_mpath_numa_nodes.attr,
+	&dev_attr_mpath_queue_depth.attr,
 	NULL
 };
 
-- 
2.43.7


