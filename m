Return-Path: <SRS0=Zaot=23=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A914C32767
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 06:01:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E03120848
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 06:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lMwWDHlI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sQrqpLYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E03120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/0g71a2NwGHaMCknzz/JUMaxX9biC2Gz/62YkVNtREI=; b=lMwWDHlIR3/2AN
	n6gYiw8dIwvxzPhgjZ2XejO8hrFM7sO8qFefZEz6kXzcIdE00mfltjrvdry05ajSf1UVlud+iah4R
	D5kLDe8uF91OUhzLwbt3Tk6aGMeLArP1l0NXOemwgj/bm+ULSdJ3RwF6gteJ0+Hh07hpsqyDLv8Bz
	lvgQUJGnf2y+T8/wJQL0QiRS7Mxlxy02stRz9hhKV8PrfmGdyRJvnbWfZeMaTPSy//10QGWzoSO1G
	zcFRPC4zmAfe7d7nWj1BBZq235cDQjyhDLBK9P8aNy5DyYEzb4HEoCEwqd4j/r/S4TeMxkIIY0cz7
	W/OewUY0SuGhy3YjKy1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioLSY-0005G6-R7; Mon, 06 Jan 2020 06:01:50 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioLSW-0005Fh-Dj
 for linux-nvme@lists.infradead.org; Mon, 06 Jan 2020 06:01:49 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0065jCiE006637;
 Mon, 6 Jan 2020 06:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=0zelCiREPyenR2QYtmR9ZeGfHkO4MI8l17JPDOcphVg=;
 b=sQrqpLYNqHigKlPsXLD1kuu8LIRjyyWMsVV4wmHH9w/UvRbuExo0savdiJmZvNFthqfQ
 58o3LA5r10qOYNnumg1q5NsNGkTDZZe8rBF67BcPkFIJzZzrgEmEsncjqKWQEJuUaBeE
 CAktISzxwKnPH2nk+pkBi2hZNa0wiX/B3prEWih0GfpPt2ibeLcEuAyuTwK5b70OaFzu
 8FbDEzf5+9VIeC/rCxo88Vk3bGdlDbTTdgdLCkA5tnxTS6SGvEHskmXQJdgPxaJNU/gt
 /EOkwApdrM6eV6qVYzc1Yis7SQNKK/rJnpHxIP5sF8cHFWraxelIis+nsHuNmxAh7TR1 lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2xakbqd35h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2020 06:01:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0065iY14075592;
 Mon, 6 Jan 2020 05:59:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2xb47b5mfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2020 05:59:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0065xOPm032657;
 Mon, 6 Jan 2020 05:59:25 GMT
Received: from [192.168.1.14] (/114.88.246.185)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 05 Jan 2020 21:59:24 -0800
Subject: Re: [resend v1 0/5] Add support for block disk resize notification
To: Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20200102075315.22652-1-sblbir@amazon.com>
From: Bob Liu <bob.liu@oracle.com>
Message-ID: <62ef2cd2-42a2-6117-155d-ed052a136c5c@oracle.com>
Date: Mon, 6 Jan 2020 13:59:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20200102075315.22652-1-sblbir@amazon.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=913
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=957 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200105_220148_601889_B328AFA9 
X-CRM114-Status: GOOD (  24.64  )
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
 jejb@linux.ibm.com, ssomesh@amazon.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/2/20 3:53 PM, Balbir Singh wrote:
> Allow block/genhd to notify user space about disk size changes
> using a new helper disk_set_capacity(), which is a wrapper on top
> of set_capacity(). disk_set_capacity() will only notify if
> the current capacity or the target capacity is not zero.
> 

set_capacity_and_notify() may be a more straightforward name.

> Background:
> 
> As a part of a patch to allow sending the RESIZE event on disk capacity
> change, Christoph (hch@lst.de) requested that the patch be made generic
> and the hacks for virtio block and xen block devices be removed and
> merged via a generic helper.
> 
> This series consists of 5 changes. The first one adds the basic
> support for changing the size and notifying. The follow up patches
> are per block subsystem changes. Other block drivers can add their
> changes as necessary on top of this series.
> 
> Testing:
> 1. I did some basic testing with an NVME device, by resizing it in
> the backend and ensured that udevd received the event.
> 
> NOTE: After these changes, the notification might happen before
> revalidate disk, where as it occured later before.
> 

It's better not to change original behavior.
How about something like:

+void set_capacity_and_notify(struct gendisk *disk, sector_t size, bool revalidate)
{
	sector_t capacity = get_capacity(disk);

	set_capacity(disk, size);

+        if (revalidate)
+		revalidate_disk(disk);
	if (capacity != 0 && size != 0) {
		char *envp[] = { "RESIZE=1", NULL };

		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
	}
}

> Balbir Singh (5):
>   block/genhd: Notify udev about capacity change
>   drivers/block/virtio_blk.c: Convert to use disk_set_capacity
>   drivers/block/xen-blkfront.c: Convert to use disk_set_capacity
>   drivers/nvme/host/core.c: Convert to use disk_set_capacity
>   drivers/scsi/sd.c: Convert to use disk_set_capacity
> 
>  block/genhd.c                | 19 +++++++++++++++++++
>  drivers/block/virtio_blk.c   |  4 +---
>  drivers/block/xen-blkfront.c |  5 +----
>  drivers/nvme/host/core.c     |  2 +-
>  drivers/scsi/sd.c            |  2 +-
>  include/linux/genhd.h        |  1 +
>  6 files changed, 24 insertions(+), 9 deletions(-)
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
