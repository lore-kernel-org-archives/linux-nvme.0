Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FC0ECD993
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wmu+IukcwTY3bP0HY+Q2BH92TvO1q6sPJhqcwzaV5Yo=; b=u9ZSZXPOxwwYkKQHXhM51YaEDG
	32vzM3jkTZiuEsJoL8LQPNNxdUCxrUHi7+EHysnjNC3Yv/6NX96xXDLrIvroDtDYZCoaQDTHBZ7YG
	JyBQp4edsqUBITwNwBmBMfzVKDx/HKTZ4DS4SQUgcbFpOqZdSOBBG+Nv46S+2SmmPnK+FJK4UT4pn
	NA8KOrYN/SN6eFxFfbTGzSyrjc2OZz9ZAuoUihvglsIjTtu1qkN5mAnJKNbGwB4KQM/9UNraA9QXD
	5tjxG5e1ceG7h13cMHaP6gKxrRnIOQX3DVhlkU70A6/HLAXluJrOoBeryoaEWQNRvF5Y3WbND+ymw
	uyUt3p/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo2tT-0000000AH4f-37g4;
	Thu, 05 Feb 2026 17:11:51 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo2tQ-0000000AH3S-3alJ
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 17:11:49 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Ftw3R482329;
	Thu, 5 Feb 2026 17:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wmu+IukcwTY3bP0HY+Q2BH92TvO1q6sPJhqcwzaV5Yo=; b=
	ejOwue+KQNytULSZcgDpdAmSl6KrV+BLbBDeBkn2LTUhsTCYKqCjrL5RNnOkIgft
	ZY7MuMLY6iu7mIuT0fSPIiT8oVaAbRLoVi2aYSfbLYzm3f0XsyiO7r+gPWQlaLWY
	gVe0KOrsLD5QwEpimwAcgHW3rU6veESWnTBX4E3jhZfJmZQqW4W665BxuCHsWClz
	IrUk69Acm2SiyU6F/os9sDPME6PbS/utB3TcN+81sc38CKSWg79NBxv/1PVH117V
	WLnEvIA6x7uRMvNKAU/AkMFTmodwRBjGe2MnFGDzaOjNFVBEUs6gnv8Vs/MtQvgB
	/cAE8T+mKm/+V++IoiP+3A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb43rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 17:11:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615H7JEH003370;
	Thu, 5 Feb 2026 17:11:34 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186dfkna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 17:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH06A4RyRYr49CtcwYBNhtZZ6oKTJaD3sf83Ki8wv+Jc9zU657pqLH7WHORD0UBQjldRmURXQE2KxvUq0pr6qEKRdyVg45kpENPeMJnPdE4QkUo2GfUEJ6u64ZyD+bl+d7idY5Jh7DbGyPJphWhZcOsQH3dDqoApWhRaFN+VyeojzKLXFBecmOBvxWo1D8/oPDMwLu9Lr0Vt7RzBJzodVA0JobICyia/tEjQx8I/a7CWJ5BHTapjgC+3MhMrLbBlBG40qbnRtQyH/fLxbbkLBMCrKc5EUXT/2p7NicMVZ0MSr1Z3uJGGJhbyCPCOH2+/y7d0JfYmR8L+wKaYah1X6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmu+IukcwTY3bP0HY+Q2BH92TvO1q6sPJhqcwzaV5Yo=;
 b=gOyJGirDx2wqyhnhCb0/o9u6JGBQpJ8EE2u4nLDvwwWNw6aV9Jr5uF4VSAo8o0Vuv1PKF9P0Ryfo6Ur80TDifyoxAoZt8sa5PE5Ibe5sWeQgWsF8amtxgFIsSuOk9uNWyuRzIKfKlJZ1Ox1T237HPUwyNMyYCTKC6JQ6Y3j5Qr9wRhkwxl5fSBWOyie7oFxirn6QLje67ryO2dbZ1B3eQKgT/YRp1atw1qYlGLXcm07rCkVRH3ykjJtUHx44BjQDy6AP1Nmg/iAAREwQ8R/0ZR/NwdYlu/2Kd1ItvpTwbiT0x2n8oVwAfS5JDhokWcETk9j2avgVse8iIFnD43XCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmu+IukcwTY3bP0HY+Q2BH92TvO1q6sPJhqcwzaV5Yo=;
 b=nIgeAjQWmFLihacwTe5EgaEtbusnprH6I1nLrVQIwMl5b16cGY8Duy8XR4AogiqcxDxCWAxDr8Mw2A9cUynYjxy4P7zKeaG2/Ohi5L7XLCrDQQ2k+0OpDDvsK++kaJc7iAT81tdHECdu6Grnkaf2IzoSbIC4ya9EYCKybhgdSws=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ5PPFB6A054FAC.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 17:11:31 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 17:11:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/2] nvme: correct comment about nvme_ns_remove()
Date: Thu,  5 Feb 2026 17:11:14 +0000
Message-ID: <20260205171115.2610321-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260205171115.2610321-1-john.g.garry@oracle.com>
References: <20260205171115.2610321-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::21) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ5PPFB6A054FAC:EE_
X-MS-Office365-Filtering-Correlation-Id: 55109440-9f4b-446d-0224-08de64d99b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vGe6GBd7+EAKI2yw9JTrNTvwAkpLlLmL5kN6AOWiobejFX3a6GO3kRuJBnxo?=
 =?us-ascii?Q?TtpaHFXMpNbAdJY4BkIXNsYmQXnWhFLi6NCQacQdVASFLGHghBLTEqx62PQP?=
 =?us-ascii?Q?0hDw2ZxkkK6qfz+CZKgIjQ0fJhxtd7nqLdrd3FzT39pJIxCkUTDSSUDcWl59?=
 =?us-ascii?Q?G6obbygbQYLsi4EKyvWhaXpyb5VCJoRkYABr96Ww9jlJWcbqJTwgePstzemC?=
 =?us-ascii?Q?OxexWpKwK0BwcbNed/Ijmg28HxdFjp4SSiv7DnPbo17EwLjXuxn+b7C2c3Xp?=
 =?us-ascii?Q?Y/Hy/z4AbjAbGfLWY8o+eFTyHbHpAlZHFF/ipig0W5I2qq2fjWAv3XogncFp?=
 =?us-ascii?Q?93Xy+n0khVEGXV5eWhp/9VsfnBQi1B2JmIUhLXEacdxnkUovVsL2wDhiimyw?=
 =?us-ascii?Q?7F3CzZ7JDMWW7glG35HK9krYPOXwmRNsrGbEYqHvzZOjFtcWyBE7ELaEyN4X?=
 =?us-ascii?Q?eZ9ET7+mNm64Vmm2DntCQepRZDM673lmkyAMLAxAhA9U/IVghwzl99au5KO1?=
 =?us-ascii?Q?dl6BE1oy05vuPHLeEFfERULkKrijnk7VAKpqvGItC1z3V4x44rCK72dqUj+Y?=
 =?us-ascii?Q?0TiGFzBzdwTLh3ZeuY5n1JroEnEfnp+QfRC2iXH9hm8kI3jJE2+O6OlbFv++?=
 =?us-ascii?Q?wyO56RNrpyyTcqGgvDJ3dbFrTHzqIZla7jsk+iuv0kzyjBA5J9Afe8ih6Nx5?=
 =?us-ascii?Q?1UWLPbTlU3PHJX/CEP5+EVndDi1zUDUWzFW6JCa2dYSyqLHfe1pj4hZ1CHJj?=
 =?us-ascii?Q?sFguqZbqeKp9Bek+9S0z7DGx1aqzuGtume/XaNeaYLmsMwrhdF6Mms/frT9c?=
 =?us-ascii?Q?YqXolllxD/Ukdgnoy+46BRfmuQ1xec6pHNC+mPB5mj7kjOm6yqQjf/X1mn+a?=
 =?us-ascii?Q?/+zprzfyxFdUPd0qKUEZZMx+8HxQ2W3Yr9lJpw6XQjjWlde4Mq5sWy6++U2L?=
 =?us-ascii?Q?0RQxtbsL20zPDioOYplpdIFfRfJ/E9K/63lkAOFE69HsHN8WC0uVNBEnej/i?=
 =?us-ascii?Q?JlXqox1MFVRri0eQzircmSdoSnMYuV4tx3WJSKK2MVc7O4DHLUfj4x10KZ/q?=
 =?us-ascii?Q?PphcBvVgAhqRBcteGJLTLuTt6pqVMJBj2psX8eXkoGc2RdXRsljY0qtTCTiM?=
 =?us-ascii?Q?VfBwmMWqjRuZ4+14DTSzIQIBRImQiHYW+rFN8v+dJnu6FnDifngHHF8JZlvJ?=
 =?us-ascii?Q?4Np5ODrjbwNklC2KRr22eXkvryy8YbQxPl18l6o844iadhje5M6rZNHrkJ8+?=
 =?us-ascii?Q?/nBXNimNsFvvrS5evKmvLB8lyFAoZvWkncfy/nknh2u7ZGICGR5O2QVF/yB4?=
 =?us-ascii?Q?sSwVA7M8XALsp5ZVfEySIOTZ7BwYowJydVFQdFhBCE7YbJje33Abwpg6UafY?=
 =?us-ascii?Q?zWNuLSk7+lJyCynMz8EMDFGaZQkuZxBAkYsfpda1cc+UHPKdZNYaoro3Uxsx?=
 =?us-ascii?Q?Rjip+nxp7axoDFzrO9vzOCCPSwHW8N40/cowYFhNsJ0+YxyWkPAQfLOrdOCb?=
 =?us-ascii?Q?q0V3WqHo7jQts8hkvyfHN0viWOioFZf/T5VODJM5B2l9UM7mvOzWNawR3TOr?=
 =?us-ascii?Q?j3TXvn8woe98AJ0prGY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GuJrkbFByWXz8UPp+MiG4zd5w+Z9H2zCNmFX05Mbj6P6QLSDig0ttugCCVzZ?=
 =?us-ascii?Q?wCZcK4BkyVAsi+Leip0lu4d5BDfXzBSldLabYR1bXs4ybxFFfSYLf9ITwK1P?=
 =?us-ascii?Q?cG+uXeguuaxlCtAo0i/qiMfCXavou+0a9Fgc46SiF7NAmWLtNkwmAxIQSYfu?=
 =?us-ascii?Q?x00RgoWBJtUdNcSRiXBw10ns07H5noJmFWTrKnf2v8jZJOlvkBH6wol8lOCn?=
 =?us-ascii?Q?12RIa/wqWpc7WWGDJ5CKp83wpBhb/fMru6RThZKogsBqT+t3Zyr9rgWkRZX+?=
 =?us-ascii?Q?kFKRetrs7WD8/TfMIi2kskeoOoEfpCg1CKObfebqFr6fJwMzE8WMuiZvT5oN?=
 =?us-ascii?Q?8J0cqh7Go4t/2lbfOce86Z5jwTaovqGyNBlkM1RlvLJwScpZJA/zVqZL7EoQ?=
 =?us-ascii?Q?hvZnHkKRWRXAvaJSnN9ig6vA6rraUuVzOVb+7QxY+f0Z5f9QnbOZoqhDGBVM?=
 =?us-ascii?Q?I6LdzKuGERq/Baln/g0Skyl7ISbdH+IQerKE55rHMkIvsBfX4tWe4iu4XBUD?=
 =?us-ascii?Q?zQDvmzdU51+nR3i3tzxD8QAOTB1k4SpvOmNjoLl6bTeAHAxyPNmXNExVkG+Z?=
 =?us-ascii?Q?QpoGwS3Se2i6sE6LxohMWa7YdUZGozQ1nyyShNlR8NsFpAVSbCuFcHL7p3Gm?=
 =?us-ascii?Q?5UQrDXWrNgIc8YmHDxPmB72LN+j54I2C9bpyuNU5Xbm/mUC0gtcVzbe1iSjp?=
 =?us-ascii?Q?JgDa6bfvSUj+d/28c8Yt9aWmWwe9R4o/ABAZb/knu5/swzvOVz0IxkfPlNzY?=
 =?us-ascii?Q?nziJQC/+ydaeB9UP9cIZ2ANCYbepoD7W/Ji+0CORf2sgeiyCZjJgudUPn3YV?=
 =?us-ascii?Q?l7MINr5a5WYLNEegBNjaPTY43uTPgzDwwYSdaEZ3yo69C1ZOasmDVRCEB1Yl?=
 =?us-ascii?Q?R/vB+xrZBrJQgv+9YD8GnPjAWYCgCR+XpX3p1Ji++NP1sZCfH6fdmjqstl2E?=
 =?us-ascii?Q?JpEx0woWt6XZI9458PW+2B8nSnxnWD+Oa4FImRpBxHZILLnjOnQwenC2O3sb?=
 =?us-ascii?Q?e4bygC7ZbntZzsAHTEXxVTBn1AACcy6gpmNuKhNKFAjk7cClJPaoB14ht06u?=
 =?us-ascii?Q?W1XFcB4lKjff5NzVbhPmZmNiCQKFL/Bu1D/Qbj1em/K9WyyXni6YOb6GCv/H?=
 =?us-ascii?Q?5z0M/0uShlNRNNoLknchkqSuoJh9aph/622T/BGR4CczpB9n74QYJEO5tOIl?=
 =?us-ascii?Q?N2kip3yrMnJCkQBTVxVrbJW9pDvKwmhcOBy/6iOM73hzGv2xGYdiz+GdQ2V7?=
 =?us-ascii?Q?+2EcZpT9DiM9lmbzP9cYfEGatmK5ydihlDuy9KS5NAWBUmylTumun5wGOF+1?=
 =?us-ascii?Q?emHX0ZakYUOe12U2a7gEk6oCvXGpMrgCUJFnnVjARcROvCzqlNgaiThvxzXW?=
 =?us-ascii?Q?Kep/3ysAyyccnOooh1kCUMwsf1OU4SSsHry7uVMTXHQLzAWgUvLYq1WJoD6h?=
 =?us-ascii?Q?jQgsbb2YElX2IydYe5FhtB+DDu3gtWfmAD2GqziJp/WkkQ7FgEv5rkG4tLZl?=
 =?us-ascii?Q?mTA3+uHQ7nRIrOfWL/19St7Cvu3ZUPsdzg5u4v+2msWRWMbYYNrD1VUjFB5t?=
 =?us-ascii?Q?SCNPYoaYpa0xSp73jvKaM1Stp4OOILqQJSZF1W6kUxkHe4iN/1n0qFY4TbFq?=
 =?us-ascii?Q?TJv8901p7LorcEebMAyNDsSqZqLhNDcEIQXoXH0mzqE8Hb/Fi2uXwUy5VyyN?=
 =?us-ascii?Q?W92+Zx3+f/cGCMddqtZwhkzgn1GtsY0Cu9nDD51hX9KXwC6gI9FxPAijYAYO?=
 =?us-ascii?Q?xKDPnW/exdy+AbDFf3/Y9JhRr8ZG1Xs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TtlTwXoLE1ma+6Qu/3eKzzqfPkYNiZzCdtn6l61pVNcSty+6wXeH3zwaAfyCCkExNe1aQMoBv49PCN6IA25VPhHABuItkVFt4f2e8p+o28bFI8cMpzCgFTR8k7YR6bBDbfdMOKb/7goYSWCmhqdNKx2NOG44akdkC34a5JMK7Ljcq0F8dX7V6nuC6T4CmRPOZiCit0aowKTmmhEqIIT28gzLL6ux1TB5Sf0rnwgN6NI1ur9OlYsDnUF4zQLJgoS/no9pmwtCsXFlxi+U3f9sFWiGPw3p2w/yTIwT1P6jnEfJi6Rp7k9gGPfks/Dl8rK/n5vRaEnerYyxH/PKAci6XXQOQ+CbfdZEqjssrwwaxjYzO5HPQcTu/Q/s76Y5yGR8LkyQFeRtPKdy6S9k6xeODpjTCqdFQ+Ppc45w1CQZJJyVLUeRbwMhEQsZyTVbNEZCXUDFhylIGEYm8Nb/I2by2ssk/QKojppCx0O49CBHEtXStOZegA2VkQd6KX6UbwiV4S3mA364E1fULxCcF4+zLRBGTCsBIIke6zls0N1JjVpEOmKerqxaQSvH6S73pTNNqdGICdoy0EvhTe1L+/usRdC/0WAtj7TUON4SQUpXAHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55109440-9f4b-446d-0224-08de64d99b6b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 17:11:31.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQKglY0DqEaeUMPTVg3kStC1Fc33XQY0nk9b8G9+u/kHmbGDM+EZSV1TCN100yEEi/ZGfRiPRzZv7Ym2npoP7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB6A054FAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEzMCBTYWx0ZWRfX9qOmKYzyfgqI
 BM1LbHta+JIuLHOFBpCv8s/WEmRDMUBUuKZJsZHVYSvLx23Pl+EL6s9L6TZ2gjclAI0NQH9L/qJ
 cTuyenh56qwj//r52+y+ZSWhAm9RYCSdz/o9Z+dMFujTvlJpa2tvMN286OVIyZVwUvUu1uOaYWU
 Q98Q8uaLour5JUXRmV960nPo5RnHLcLuvykJ+F18tr8u/ZkfjxWrDc/BpmOiozbQnuA6XPua5mP
 hpGm28jiXRITGk55gppFX5epAEZK0Hhl9c70rBe6g7eie2zI+WPq3lbYj88bZTIe58/cN4IdigD
 jvogdEVCBC5Vzg3hxbjnxg2MsnouJOkXZi7Q31bZys01SaMNS/Om9VHqkXwMUo8tjy1edCM4kuw
 eQdzvAFDOF3QWdr4TmSg1owrAAY4G6yh8pzvivO2oreIqzTOpVJNp42Ub0i2N1H3ZHXB7gzWLgQ
 ydKfsRvDnk3gZEEJPNQ==
X-Proofpoint-ORIG-GUID: SsqWkILX5twoJYSqhxlkjO6k6f-9IZpM
X-Proofpoint-GUID: SsqWkILX5twoJYSqhxlkjO6k6f-9IZpM
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=6984cf47 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=89eL8pV6gm1Que7XEOwA:9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_091148_896577_EA625503 
X-CRM114-Status: GOOD (  13.80  )
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

The comment in nvme_mpath_remove_disk() references nvme_remove_ns(), which
should be nvme_ns_remove().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 174027d1cc198..bfcc5904e6a26 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1300,7 +1300,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	mutex_lock(&head->subsys->lock);
 	/*
 	 * We are called when all paths have been removed, and at that point
-	 * head->list is expected to be empty. However, nvme_remove_ns() and
+	 * head->list is expected to be empty. However, nvme_ns_remove() and
 	 * nvme_init_ns_head() can run concurrently and so if head->delayed_
 	 * removal_secs is configured, it is possible that by the time we reach
 	 * this point, head->list may no longer be empty. Therefore, we recheck
-- 
2.43.5


