Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA6AC2D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:48:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31F9206FC
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t/KwAqmq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gby6ot6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31F9206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oXy9KdCmW2swVg7pPCgtmG+Dnbl+pSS9USce9WWq7nc=; b=t/KwAqmqqXKZoOEZW8lcujy+h
	d8M8oDjnfK6EBDmkdNuI1yWT8E4kIdZQWK11LdBuQHcahiR2xN548r2LpBMR9EQWvJHqcZTJ8/ZAk
	/p5E5kLw+Fu2WPKylGeoeNvFGCbcdwxkRf39jnf0Ivzf2QWhqdSb/lSeYTsd2eNmTG2wnQa6OdAta
	tZh3Kuhha+M6rOxvAdLLJe74K29sAS8xIX5T9Xhe8Se1vWNBD3R8yj9+8+znKyrLWve/QSxRHELhs
	Ksq5yv1g7qkDXb0BVtF1E52lQg4c3Rl37wvC7Ma89IywbeAGdMycLaZEsrHcbyMlzDVRGAXha+4qT
	sXfO0MXqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKq9E-0005A6-Ox; Tue, 22 Sep 2020 21:48:28 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKq9C-00059h-MZ
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 21:48:27 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MLinPY025484;
 Tue, 22 Sep 2020 21:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=kOFwo0AKDlbaaVc1Roe2utwhJxrlM2QMekMD8jMCAQY=;
 b=Gby6ot6fE+vkkDLMBs7m1wK0NLdG6VFPv8Boq488cU/XoTBGmakubebCFKaI/2XK18xb
 sgC7/0sWrCS85XHD9oRWOtkglltiw6CuqeD3Le4cx+aWGShmY6vNtRI3w1LZZnKMmyVW
 EfAiS3K5ZyKzIJeBUx27aQH1A+aOyAwnRVHa8PZKbEpYBiUqG4Iu2N8zNccUAH5NtweS
 9n3lmBhj8edKcRFvmsneIEHMg8q4SJV5MHDZMRc1Eah4W46Z8mq1TkSVcVHaY53OVQjP
 0QJVz77oxmcS288R3YCibRm0NC6J361E98nXD4dS1MIiNXjX8hwOKUbF6MlL4w0FVZ9C QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 33ndnufc98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Sep 2020 21:48:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MLkNgt027621;
 Tue, 22 Sep 2020 21:48:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 33nurtm7qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2020 21:48:21 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08MLmLdx014752;
 Tue, 22 Sep 2020 21:48:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 22 Sep 2020 14:48:20 -0700
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 0/4] zoned block device specific errors
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zh5ho585.fsf@ca-mkp.ca.oracle.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
Date: Tue, 22 Sep 2020 17:48:18 -0400
In-Reply-To: <20200917231841.4029747-1-kbusch@kernel.org> (Keith Busch's
 message of "Thu, 17 Sep 2020 16:18:37 -0700")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 mlxlogscore=799 bulkscore=0 mlxscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=831 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220168
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_174826_900818_4BE80A37 
X-CRM114-Status: GOOD (  17.25  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 martin.petersen@oracle.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Keith,

> Zone block devices may have some limits that require special handling.
> This series provides a way for drivers to notify of these conditions.

This looks good to me. I already queued patch 3 so please send a v4 with
that patch removed. The rest should go through Jens' tree.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
