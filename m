Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A80C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 18:05:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCFF207DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WoarzOaZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="be9Nlj5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCFF207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bstnObM/i8F4bkoFiL9myG3YWaV7kM0gZeWrxFD5dIU=; b=WoarzOaZIUfU/aOlpE6TRel7F
	kmKsZO1+mVTf4xmwDKhqTnYYgEFTM4YMIKSaf0WbKNSm45krJ9/Q2ZlR+6YGFef7fTeIcHzRED4UE
	fReu2Es5fiWyvytD8CvOFIrNv+X1uE7zkFRp2suUDmf6fLVmLoc2Xlee7VZ4hWzbBJqgQXm96iOsj
	3BIKjzlzBXu3pQcg3Ph0AqMZplRWw6bpPPWKMxIavEDVf2wzEzqh1iOxxc15sPuJL947kddRb8lsh
	UH2TfkXDE11BjIiRzCSTPf3R3+5+BrctvcIkzILteYl6RJARdgZcZ6s4eWwVhUZNyE2MtUcHpV8b0
	i7KgnwjMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBMHU-0004uN-FJ; Thu, 27 Aug 2020 18:05:48 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBMHP-0004u2-FB
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 18:05:45 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI5aAd074709;
 Thu, 27 Aug 2020 18:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=KcIyKRKy9qaEg0Ti6zx+gAORBOzroZp/AGzpZDiPD0Y=;
 b=be9Nlj5Jt3raK6xTbBOJC9kRQG+l9lgjeFjizYS8B6yrLhHLnzvz0isK68ksbpM+wOIw
 Dzt9ehmAtYl7rYJjtIIBM+5Bm1Muig4DL3GJmUxf2kQJkC+b+fikMKPslthl9mgqDPxv
 MLX+nq1hUzuJ066G/QdZkRYgGHf8TgJ4wKZl413ZEwLa6qrX/SVkmoCwCdj3XZx+4anE
 VyN2yo8RO75jpGGI1bqUjVWdLySgoXcFd+vRgrUnaSlbG0Boaq9hWv+vWeGknbo10mZo
 YYgP93yHrsn6sReqMQByMdYN/zXqC2+Kcp+mHomfM+yKiSHsKKbJLhMsQ5J9KqtSLYeZ Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 333w6u6gaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:05:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI0KVk137683;
 Thu, 27 Aug 2020 18:03:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 333rudmt28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:03:35 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RI3Y8S020506;
 Thu, 27 Aug 2020 18:03:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:03:33 -0700
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] nvme: only use power of two io boundaries
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15z94m0i0.fsf@ca-mkp.ca.oracle.com>
References: <20200827173857.2825087-1-kbusch@kernel.org>
Date: Thu, 27 Aug 2020 14:03:31 -0400
In-Reply-To: <20200827173857.2825087-1-kbusch@kernel.org> (Keith Busch's
 message of "Thu, 27 Aug 2020 10:38:57 -0700")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=985
 phishscore=0
 bulkscore=0 suspectscore=1 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_140543_733580_8D0D93C7 
X-CRM114-Status: GOOD (  17.03  )
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
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Keith,

> Don't provide any boundary hint if the controller's value can't be used
> and log a warning when first scanning a disk's unreported IO boundary.
> Since the chunk sector logic has grown, move it to a separate function.

This approach is fine with me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
