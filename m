Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F648C33C9E
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 02:56:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF97205F4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 02:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KOXtGBG5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dXa2DBns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF97205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XE5e4O8JpV7bfM/nDOceyHtDWTMrKMlXL66QC/teiSk=; b=KOXtGBG5APVCk6
	gPVyzog4DGH+BQmHrRRGcuyIadZz6OBWEDKjYyt6cLx0qWMVQd/k+djSpoWmLG+cljMnZiWxOMWWu
	J//6gn1TezACLTUGfRYN0P6en2Vuz+3VNQw33yNk6KuYurjQYSAJ1sUPyivi5fJUDHKgVVan7i92f
	GXdujxwfOyDR5XK2wOj7WdCK1pdAJyYI/BZNJZbsBHskuc32tViwgENpQGZIxOoZ35kcTXM/xGAxJ
	ms9U14/Sv8HTbadsGXpwrp8HRGn6nRYvlgQAcjBJ4WCX6q3IIY/VRo4Gqcp+35OfSUUMPgML1CKS5
	tuNW+m9z0iwy7QSb5ZsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipO06-0006FD-2R; Thu, 09 Jan 2020 02:56:46 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipO03-0006Es-Kj
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 02:56:44 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0092rQiN135926;
 Thu, 9 Jan 2020 02:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=UkfHdTmJJlai2EOzhsw+ZznpGVVKFCSeoOTXtC0IOPY=;
 b=dXa2DBnsNjk7TL8YUymzrg0GLgz4XOHOBEsHqVaYnFj0G8xJSUGrlV6Pnh1YtZYzsagr
 5TQPp9v4GaTyQQjqyCVG+7eAuMAkHsle1w0cXDAyjEDvWeakRY+n7biP/EFkWPvfxcan
 5O8OkfB8ZttPwKvYtTLkGooVAZaJj7waJX9ZJw0WS+BjRrhcRkdScykeiCxzPbfhbF24
 0erD6clfGKovzBZb7ialjqoBakh7iLq8nSmFd/yiPKS7518Y/XLtBvMUMSQu+9dehZ9w
 0cPAyZ+7FhgaXoAyg5xx3P8++QdwJrrrx/OKmVSkzS/YgRdnK/NW2DpOWCGN3ewmDazv hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2xajnq7xjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 02:56:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0092sTtD024251;
 Thu, 9 Jan 2020 02:54:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2xdmrx6uyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 02:54:32 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0092rf3S005091;
 Thu, 9 Jan 2020 02:53:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 08 Jan 2020 18:53:41 -0800
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-6-sblbir@amazon.com>
 <yq1blrg2agh.fsf@oracle.com> <20200108150612.GD10975@lst.de>
Date: Wed, 08 Jan 2020 21:53:38 -0500
In-Reply-To: <20200108150612.GD10975@lst.de> (Christoph Hellwig's message of
 "Wed, 8 Jan 2020 16:06:12 +0100")
Message-ID: <yq1muaxz6fh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_185643_770625_9D8BCD17 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>, mst@redhat.com,
 jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 ssomesh@amazon.com, Balbir Singh <sblbir@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Christoph,

>> We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
>> capacity changes. However, this event does not automatically cause
>> revalidation.
>
> Who is looking at these sdev specific events?  (And who is looking
> at the virtio/xenblk ones?)  It  makes a lot of sense to have one event
> supported by all devices.  But don't ask me which one would be the best..

Users typically have site-specific udev rules or similar. There is no
standard entity handling these events. Sadly.

I'm all for standardizing on RESIZE=1. However, we can't really get rid
of the emitting existing SDEV* event without breaking existing setups.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
