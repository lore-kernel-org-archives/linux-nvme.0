Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9339C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AxUcsZm5yZiXaI15ZeDb0qU35ud3so0yBE1NGQ4Ni+U=; b=KXLUeGkoCsBfeAZYX+UvTR0A2F
	kauPUWX1jzya+RNFHg6v+cJcIokKITIhREjyzhoUuEOfXVaO4f/igcdJ0Fze0XhwZZz7XTVniQt5L
	E0EUPHMfosyw0rDzW8QDZKpKIqBFdQ7KsoDOC2keK+08u3goZVkza+EQ7tFIglJrb0Z3M47oZy0W4
	Wyi+n3fgfTEcLEk9r0s/O/Hs+CxbL1TFG3v3lryi93HRZNEwNdQlHqU40O1pcHqE6Jlq768dIMWCA
	WVjDoP04/689DjNyIiWaK1J5PjzHHcTUJ1PBWXLyWp465/75kX/ePEMp4LQ2sVtXQ5d2+yqBCXfPS
	EXLrAQRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue8NZ-00000001ppD-1BoR;
	Tue, 22 Jul 2025 08:29:41 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue8DU-00000001nis-3XnL
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 08:19:18 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250722081911epoutp0387a233ed8e90f23adbab1853c33d4cbe~UhPbwwJfa2735227352epoutp03s
	for <linux-nvme@lists.infradead.org>; Tue, 22 Jul 2025 08:19:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250722081911epoutp0387a233ed8e90f23adbab1853c33d4cbe~UhPbwwJfa2735227352epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753172351;
	bh=AxUcsZm5yZiXaI15ZeDb0qU35ud3so0yBE1NGQ4Ni+U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mTIn/bwSlLWIwrUN5ufEHb0NRKcXvjBKHPRzPYXNYNzoUjm2fEPF88YQIsj/MRSBk
	 mtzPEgapuDCYAWsto1mGPtHk1JKXnMLjmSI5PDNt2Sxh+wcNPmNce+RB5Ht8d8iIKm
	 l1VbUPQFzrNZy7Ptpvk40sZkzLl9l/Dhg6CqPGOo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250722081910epcas5p442aa60e9967bf401c7041948a9ef0f58~UhPbKjWI00169401694epcas5p4A;
	Tue, 22 Jul 2025 08:19:10 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bmVXs4xG9z3hhT3; Tue, 22 Jul
	2025 08:19:09 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250722081729epcas5p12dc547bda002c28435d83dc7e972c105~UhN86SA4s1721417214epcas5p1z;
	Tue, 22 Jul 2025 08:17:29 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250722081727epsmtip1d6ed31e2cf992237114606f812d63623~UhN636tdp2238122381epsmtip1Z;
	Tue, 22 Jul 2025 08:17:26 +0000 (GMT)
Message-ID: <8072a659-0cab-43fc-bff7-618942346646@samsung.com>
Date: Tue, 22 Jul 2025 13:47:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v5 0/4] add ioctl to query metadata and
 protection info capabilities
To: Christoph Hellwig <hch@infradead.org>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	martin.petersen@oracle.com, ebiggers@kernel.org, adilger@dilger.ca,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <aH8xY3PyejzGdUp7@infradead.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250722081729epcas5p12dc547bda002c28435d83dc7e972c105
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f
References: <CGME20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f@epcas5p4.samsung.com>
	<20250630090548.3317-1-anuj20.g@samsung.com>
	<aH8xY3PyejzGdUp7@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_011917_155627_EE69D572 
X-CRM114-Status: GOOD (  11.43  )
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

On 7/22/2025 12:06 PM, Christoph Hellwig wrote:
> What's the status of the fio patches to support PI now that this
> has landed?
> 
Hi Christoph,
Vincent and I have been working on the corresponding fio support - its
nearly ready. We plan to post the patches soon. ITMT, here's the WIP
branch for reference:
https://github.com/vincentkfu/fio/tree/pi-block


