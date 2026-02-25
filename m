Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDF4FD3768
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YPf/ivMc4Nh4wNL9ML9qKSX6eXfFIIQHzQOzIgVpeIE=; b=oVo/8kVGU9pTv5BukdbyJ33Gan
	ojHaL8D4NMkUkIYEKZKErgI+6KemwVnGIHdSQZxWksJdIe/VgnBm97i7r+SGI+GbCXQ+6mNEhrlRf
	gmBsNZQCNDg4EepZIYeOd7OI0WGaHoVVMzGvKqUhiydNCsGZ+/aehs652pTNmA4a7xzkRERXBoZQ5
	JyomLrjB375CYUK+r+/JgWNfC2CIlmI9aDgngTzD5NJ4bm8RDlV7eHL1Bu+6xm/ieOJQK62/gQIZC
	sFD/HQgpkeSFbo2KrNvQFk/pf8ToS4qf4QpHJ2/VcBsGZ1dBfbBGUWW0iwXSJUVwIZYmjqkW0y/vN
	2QtVamgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGxE-00000004Kg3-3q0T;
	Wed, 25 Feb 2026 15:37:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGxC-00000004KbZ-1pia
	for linux-nvme@bombadil.infradead.org;
	Wed, 25 Feb 2026 15:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=YPf/ivMc4Nh4wNL9ML9qKSX6eXfFIIQHzQOzIgVpeIE=; b=E2okmAozINtoWV8BQ8qKC5PETM
	VBEFIUQxMoLgt+6wiqajQnSS7tI6FyM9zEXt+kzldIIYOlwM9kES45i5F385L2frenPYwl7oVHfZP
	/lPY4QfFsxFoKEwZAJdNJYUeKcJ2HhtBJc+j+Fz2nMHO+4+CjdzGfma8dnhWD27qW/zgQ8Y/omd1w
	1t+uThsfjgFE2FKhfRXStgTkOcZRPpKBRTsMBl4i4kxbGz4ACVm6a0Y0FLM7IRV3xIbUJKQi5bnpd
	ZRkz9+v73yoBIYHctV+oE8Ezd9MW8Au+U7FZ50lx61csdEC0bEnqmmAZsNTzdhcmKPkGyVU3Ujrcx
	iC3LBsDw==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGx7-00000009I61-22bk
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 15:37:33 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PAfTNu359637;
	Wed, 25 Feb 2026 15:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YPf/ivMc4Nh4wNL9ML9qKSX6eXfFIIQHzQOzIgVpeIE=; b=
	iOSZBe1P5DfDc669bRHVEV7Sj6vdlt2hsYCCjzgeE+Epi71eVoc0rFk2xlzndRPI
	M1BPYf4b2Ot/SVvKoFALX5JLzWYXoJEs2jsZmCcAVFgSXdBc+jfJHx8f1xiKdk0G
	K+q/BUf3HdYCh0dWQSkzVbdB2/Gof3XAQKxWi7cWm0LZoiTykBZCjyLl/pa8PYg9
	zWoUWFdhx1s75ZE5XBmjgC0Zbv2LbgusCh/XxQFp6tEmM5L9dHANgWswUtklQQOb
	Uwyc0ilkhzQPKrCGuJ6ShU9TKfJWFuAl69sm9RsjgvGGaRbLvdkns5pO0CzSv+BB
	UOQ5au20gXFP0D7nGG7b6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m7xfh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 15:37:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61PFWE8v038454;
	Wed, 25 Feb 2026 15:37:16 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010033.outbound.protection.outlook.com [40.93.198.33])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35nfrbe-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 15:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX5XM0vvQ5+3OJtleUQlC8C/nz0iBEtbpY7M8V21tqr+7DuzT54n76I+JxG4kjEA5duBQ7CgYBXGdjfDwSVj072CtmecKqTNg4LrBq1fsAV8iz8+KwdPrLskaPt1TdEuid5pR2Bz9YBUJLhufO6+AvpOv2wH5GLPXl38BiXshKMic92Tm0bKqKyUuuA0HHbkYcrnhPygslQ2xgK3q+ov6Bv8a4CSnLWol37sydrgRT/k6pKjbXgitBbUVPHMa5a2OkF1ny4CQYQD4/cKcnQhnxQhJJV4rBl561FXAVQmb8wP/tR0qirq+a900Cx5fCfpbAy+peWIiKKkYbe7diXJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPf/ivMc4Nh4wNL9ML9qKSX6eXfFIIQHzQOzIgVpeIE=;
 b=gRpg9rsAjeRh07cgMZ1g3z6QJmmUrPMdsofK7xkkjBhomka0OJfnh/npq48hNT1aNZcDexQZ8v5WVlExjtLWWtivsKhCqDbEp5ED2UHgPgh+JmaM11VLynkz5XyGKz0beCKPGdn2lEnKnmHl9AzatoRDJVu7CHOaqOzFHopWc0mtvT1pvJvC5NUGrqzAUca0oiDZAsSQ4ltHG8nNXCn3niILDcctfhAQnmPShLpg1XqEHiMWATiMa0kwETMTNdpuncVAlKvlByZHK763kx33LA7BTns45xtEB57Pc/DDZ1U4pE0kPv/18xChDK6pyk+bannlvjAWT36k6pPfTEgYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPf/ivMc4Nh4wNL9ML9qKSX6eXfFIIQHzQOzIgVpeIE=;
 b=xNnLcZ8Fp4oSMzqQ1WZMF0K8e/LZ21p1n6AwkKOJkVHu7KhRdzP4Tag41BKBSHHujiiWCzczw9EghZ2g1ZJeEi63l6d+yJ+6eZ3W1qxTREr2KMhX20KX8JR57X9UQ5ae8IXp466JCWlR4K+rBI7uWRqmEwp/rpoduqzd/CUYi/U=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SA1PR10MB997712.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 15:37:05 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:37:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 11/24] scsi-multipath: add scsi_mpath_ioctl()
Date: Wed, 25 Feb 2026 15:36:14 +0000
Message-ID: <20260225153627.1032500-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260225153627.1032500-1-john.g.garry@oracle.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::9) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SA1PR10MB997712:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fadf7c-e2a4-46c4-f303-08de7483ba78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: +cpHPBLfdaDoydeTRIRuqQdaorJ6S+bu4z64u61ZXRv7iSY6LPNLGeNXf0Mj88bmymF+1zoafUleMN3vJcCl8bOXZq4cs9xGBTPusTTNj6ghRtjcugZlp+0s7LIAm+HXwNnS0mOMZNxJBZ016PTzArqMqPu3oYM/H/nysHPwQsrKj5OTUfDKmxI+rAXZyZjskrY3RX/3kw+dZCa709GE5OFCgd51iVHF7/2usoM23FOshnAUjPiLRTv0tByCJKf2RdwxbwA6Ws8gPG8x3oF0dd272HybJW++uw61jYS8S0rcE4wz3Gc1jod+qwkiKuHzB+BCHQIW8Kky2ZQnzGwpUt6fERDRI49Ez3U189h2uZ6tcfSfGjSA+ow9O0gYgFuLbW4mt9ybg0Jime5HxiHo1UNhfjkHdY7XIuzubWOBJ/4Mzk5Mlds39I1OaP1Jeip/3AE7USOUHYkpDlyG9ZT71hAHocbxep/aJl8G6GORlHtGvJGp0mWvdOYk+Y6C8OMicmwFYf6jxTgxOK4h9vUtnhyLBh/0pvQp8PkyFogllEf3Rh2n/iyGKoAvPVF08cZ+doqLeJwRMsuboZ/BsWIOoti5778eCN1V6HwQE/W55P3k43r8hWk5ZnzyebuX5qcF48BzxZ6icnWYO5t8tzsG8xwaXeC/dJ6+jOdcoDLvRQFsvAvXng2CajMRo0yizUmFFInTzByVtKLVOCDyepPmB4V+nYWEVy7THJ/RIarRdSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gs6BOM1BAGFWAl3oYqvlONjnigZSWUYZsbykOUkIlQRJsNUSXz6xQVqUUJtr?=
 =?us-ascii?Q?jPykDWN4OibLN/Yk3fzsdEPbRzfK4fsS1W0JY7GU/yKbQ6hLI6f1jt79hbqB?=
 =?us-ascii?Q?71Sw3NnfK2cv+f8pJ9K9GouE7ISdDXOhyXgn3XvV8Mm/PVwWoRamQoE1xrPc?=
 =?us-ascii?Q?yKbIFKc/8Z5dHT0swhFxj7dYEzCHEosMXbNW/0exUFY0oLHs/7QPB7NqbgYW?=
 =?us-ascii?Q?6g9fVoEnXTCeusAeo7zi40P5zZf0qfqrGl0FPKN6WYAkW1XAheDBmCtQplTB?=
 =?us-ascii?Q?D9yHBuV4nB2A+AbAfZAKRrqeVPa0FShAXSyFf2V8zwm8o24uqjjeV1qXc+u/?=
 =?us-ascii?Q?2vXk7HUkqQIjD54/EIQq9iMGJw20Bzs4wQrVa2wvva0/A75vmeaERq58i5OA?=
 =?us-ascii?Q?cUU14M3qrsHbq9Zqe+HZX1/hNkpcymS40jJnouon6aMfr9vLzQZk71tkgRYi?=
 =?us-ascii?Q?I6P9TkNoRI+Q5WByI9ZxkU1ESuJGS3CRLXGcsziVDfy93oZtTSFTxZtcj6cU?=
 =?us-ascii?Q?9ADIzFoQzQ4xyNpmTNVNYMpC9OTPJ24O34YXM3W61Pgpe7RfaOMHYgsj0+Hk?=
 =?us-ascii?Q?Sqkg8fkHOdHXZ0oDLVPbE8VaaZ+s77xfrWQk2xrKVgbN2iKN3IpXtXVIByhz?=
 =?us-ascii?Q?yP/sF97kwmVasEahiaP4dAvIK7aalnd/tZ+4ibsplp1G7fMWUqN4dwwyBZW/?=
 =?us-ascii?Q?ibzcO2d9zJ9sVCG76NmMfcM2XEnOTespzDu4AZkELYQxgd+NBW1BjrEZl+H1?=
 =?us-ascii?Q?gFKoTb5Qqa1J2RrURDbtrPj4TDI2KmPxNNnvddMrqgdYH3p9McHsqCYeaRc1?=
 =?us-ascii?Q?mB7iFspN8jGmyBV3oS7rsHVpmsBGum57jCfIO3XHm5Nw47X0uBhp+IpEEkTR?=
 =?us-ascii?Q?KfagP7tLCVaVgewE3tQYd4/cYCtqmHrcmNzwradO0xxjkmE8LVL8GiRUSnA6?=
 =?us-ascii?Q?jpgZVNpHaPeQoYDsiSpT69pZWAnP7E3OO6/voJV6MHSSEWla3s7+pkfiQ8dx?=
 =?us-ascii?Q?jFjovi1mutWSXmBYpMDapAp+eaIR3c3FJILBNTZoJllVFIqHFL6alPjLrg+u?=
 =?us-ascii?Q?ufwBfHOnMXMEllE6k3U/+QbOMv41NvhDcoUX358mhBdBDvq8+EEbbb3N3ig9?=
 =?us-ascii?Q?66Fc36gcMtpFXCi5yeb3jk4sBJjWPzZAnmV6uCbkTkuoTiPSlNsxcK+JmWCm?=
 =?us-ascii?Q?ToexEBRl27iogvxLfDnbMzai0Qv0cPuGsOWfg9Pk6WbZvNpoAtCs2Av72KS9?=
 =?us-ascii?Q?GHpRrSYvVIXQzgBZ8/d+gWXpUUwdLEfWQF05/GT/0WhCyEgjdvEAHM76cf5H?=
 =?us-ascii?Q?S08QVUWImCfDjhsyypVhcnndXHGEocpBsriJRpqRcBLZDYsEcdPNaL3c3qKI?=
 =?us-ascii?Q?l/ZVqxdZfP9uLbG/Gf5pfYVHgeJIPUGZZ7zsUVO60gCeFw4jMyW5Jn83esZh?=
 =?us-ascii?Q?t09Nril9NK0J8SZiiCsFON/OKgaZ9/LUGmhm/AfbD5nnTVWsW/t3xp5eLkVJ?=
 =?us-ascii?Q?BMzQb/eZSc9xHiY0L7r8d1x/BSuMgezkT6OFvo05x1I8YtfmtCk+jBFlCqio?=
 =?us-ascii?Q?j2XP+axd9eLkOxT+/3TOZ0LiaPXlQ5l941F7CjcJ/DcS46ac4X9CFFgR1AMK?=
 =?us-ascii?Q?Y5NHlZlJlCxPpuvmrLCPKol7UYqC+ns+ccNvulY/xpx1VeV0L9BnWlBVVyXS?=
 =?us-ascii?Q?O6A8dg8SvSHV+L+Ab0SP16ebv2pT86JMXAGygX8SHmbvHjAyLPt9uFUEZQvI?=
 =?us-ascii?Q?JjLPFjJlq0/Y57hlPhyv+x0ZEimUF+M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TWJMeZiiT+75vnkzTMI0r/3hrSFBh5x7/w6B0GQDKkWEllWSa1Aewnv/PofroEjYdd0CoMu58ySpRft2JbJ6oEZOorTAcW1d5oF7CeDKnccp2jotXoUxbXYS1b5kyR/zmUNuJnCcV98ZpMkRCCbAzrpckKeSBTC056zqMXFdsAMnp+m2NKeKIfTwJ+DPNRTQtGwVgqUnpu1toBKuS5YGGqzDJ+D95rOAieASg4GFv/8lCnkJDK1DEU0cpVY96d6G5yoRhOdJJuuTFFdPZkJiQfYEXHQdSehzEAD9D3sK0Q+RnJNBdWHiCG+cT8NMy7RK7I9UL8/185r/H26p1WNff4ZgSqbcidxiOBNbQ2y9FtnUcgvBqxSWDpItNRx9g7WPZ+FrDj09vMa0IYw2q88GDrCz5cusAnvDnx6kBxujQxKnzCIUZp60D6TnJmvjhIY+NRJFyS9JGwgbpisfSvYXa2EQHIjhIWDJEJeBBB8NDbZyE2MCQ1XeL+HnjavoG2XZnSh6jrLnPMA/uRyD4c2Y2toiy8tR5/0o0bex2R9dYFTfobw8MFTR6zXALRDWEwRuzBZeQOqHJ1qON7rGbMSFRIZ+/82gH7E+LIKElDAklFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fadf7c-e2a4-46c4-f303-08de7483ba78
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:37:05.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azW+od/WUMZBEC0/+YTr+/tDH+FCkuBtoIitumtIkePc3wsBaIDO6aQyIj55htzym0d/EiQ4XD3c9SU0s4BUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250149
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=699f172e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=_Q55jHKZp0h8v6rxsPEA:9 cc=ntf
 awl=host:12261
X-Proofpoint-GUID: bW-NN6ehlGWO9oVMAiTcfyrHHieL40GU
X-Proofpoint-ORIG-GUID: bW-NN6ehlGWO9oVMAiTcfyrHHieL40GU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0OSBTYWx0ZWRfX+OvowQnAV80A
 CAbfFjGY4Srf0eP4DFonYCy+HaSFDFnX7pfp3QMYSHdd04pRQLde4y/Pcm2soLy4Kdn+4yBtpCP
 nhj2xo3bwytMQ2S4O1qMgu4OZwpBeqDrFDTrNwQi7Q0NWpQyXY69o2e3d+pQlL01E8QGcyX+WBl
 r099KcB6f+OBNxespD1827/3/GC9WYMY13rTgWQCa3Hk5DwK4ZavYm4rbCffhaG5C5EdC0uRg6P
 3Rll5/gcxeFBFl3altjSMt2LZOvKJReAx73rb/lTkdESMXITXXaC3EMvzsEt+OSbuYTJQeSwb1N
 tnIEx9Cy37BwKjqpGf58cI9HecXs4+MOpg49+1zV1hGQGRGAk4WCp9exK2i/tcCxTg/JRvtDU9V
 PfEHdtPwfePh22LSiJB8dntk3U+wzBPQyAyatF8g7mAFTiB/68fDmiQBthb4mAa4qI187UmhR6B
 0APFvgY55vXGpL7bsw0gBvGXPEhOpfdlQ+0NA3Rw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_153730_678255_403374C2 
X-CRM114-Status: GOOD (  14.06  )
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

Add a callback for the scsi_mpath_ioctl.bdev_ioctl .

Since this is concerned with the mpath_disk, we rely on the scsi_driver
to handle the ioctl.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_multipath.c | 21 +++++++++++++++++++++
 include/scsi/scsi_driver.h    |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 16b1f84fc552c..36f13605b44e7 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -320,7 +320,28 @@ static enum mpath_iopolicy_e scsi_mpath_get_iopolicy(struct mpath_head *mpath_he
 	return mpath_read_iopolicy(&scsi_mpath_head->iopolicy);
 }
 
+static int scsi_mpath_ioctl(struct block_device *bdev,
+			struct mpath_device *mpath_device,
+			blk_mode_t mode, unsigned int cmd,
+			unsigned long arg, int srcu_idx)
+{
+	struct gendisk *disk = bdev->bd_disk;
+	struct mpath_disk *mpath_disk = mpath_gendisk_to_disk(disk);
+	struct mpath_head *mpath_head = mpath_disk->mpath_head;
+	struct scsi_mpath_device *scsi_mpath_dev =
+				to_scsi_mpath_device(mpath_device);
+	struct scsi_device *sdev = scsi_mpath_dev->sdev;
+	struct scsi_driver *drv = to_scsi_driver(sdev->sdev_gendev.driver);
+	int err;
+
+	err = drv->mpath_ioctl(sdev, mode & BLK_OPEN_WRITE, cmd, arg);
+
+	mpath_head_read_unlock(mpath_head, srcu_idx);
+	return err;
+}
+
 struct mpath_head_template smpdt_pr = {
+	.bdev_ioctl = scsi_mpath_ioctl,
 	.get_iopolicy = scsi_mpath_get_iopolicy,
 	.clone_bio = scsi_mpath_clone_bio,
 };
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 44e50229a75e7..799071b8bdee2 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -22,6 +22,8 @@ struct scsi_driver {
 	#ifdef CONFIG_SCSI_MULTIPATH
 	void (*mpath_start_cmd)(struct scsi_cmnd *);
 	void (*mpath_end_cmd)(struct scsi_cmnd *);
+	int (*mpath_ioctl)(struct scsi_device *sdev, blk_mode_t mode,
+					unsigned int cmd, unsigned long arg);
 	struct mpath_disk *(*to_mpath_disk)(struct request *);
 	#endif
 };
-- 
2.43.5


