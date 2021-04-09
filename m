Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA63C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 07:30:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8409E61025
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 07:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8409E61025
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RC8a54QneH8OlyR/Gh/+PgC4fP730JmUBZxeYKeIywQ=; b=V/+YcwbJvkZFHfzPjcBIhow95
	4kqm7p48zSpOeplT420d+V/snItAXLT1PvnMrX5YAT3yeenuy7eiQSiY5ieWEgtBAlYhIoSHz4qW/
	pWC13HOGS9nE8h9i5eyn2EU3zykutquMGE0Tr/yJfx9lcthcZxWLneupLaybnRUu2mADoASwoNPJn
	3jvZgvE7kwM9yKPM0ytGrGIG459sAvNccO2dU3kR+VNocJRpPxRC+xDcsytmCW7uDg/gcT5x7tbRT
	wQg9ttKQl05X79ylXeSkgWGYyccxEqhYA34AkAkMEGLj9W91FlyvoRzLQ5yqmiOVrerrCv1RYdpS1
	L0kHBb0Pg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUlaV-00ASCI-Uk; Fri, 09 Apr 2021 07:29:56 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUlZi-00AS2V-4k
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 07:29:08 +0000
Received: by mail-pg1-x52f.google.com with SMTP id w10so3240610pgh.5
 for <linux-nvme@lists.infradead.org>; Fri, 09 Apr 2021 00:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=w1VshrUAnLYm5vF2huPFex1mirkZKHKQEGQh+y72og0=;
 b=gCYqVq5kS3DmjAN6dqMoRkGqyFy9ohBcLo0sMfeCGNnL7DCgWgWIaOvXWHLvFB8r0t
 C6llT2CDTj8/91SW8507VDuKhWehqOZcySlMMvZPKhtsmU1XpT20dPKhWk44tK9hCoBj
 0q96AVZ/VhKCuH/a6BqGwyynV8k+6TXfYO4J3FZeIjPB24pqUdOxGAaqGpM9wSMRmqC5
 vLSPDUYedBQ6lLoz4j7tS0JG2N9Ls7I5zhpxeTPtS1jX/o+yAjHIwarmQfqxmVRjGPkb
 zZEKOXi2U2/zYfI9qvNExH0p2oHNsAOO47TogKlEYshkLhLDDqhfXb04kLknvJlEFJUZ
 SFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=w1VshrUAnLYm5vF2huPFex1mirkZKHKQEGQh+y72og0=;
 b=U0cb3yKHDq1YpEYHAmV8LTRPEix1HfUOT5Ug6cIUUxW5RNnHePagvvgq7erlwfgNM1
 PTGUBv+c/Fgd6dEmO6PYz2TGUOJHQqYXYV88nL+H0y2796cZF+d+YFmjRJXi9XUnYj2g
 ZDajbpUHQmk3HqrzMfGiBeSMN6c7EFNvrLpN9iitFigwfQyiJ+P2ji+U2YNouB7mVlCU
 DIEr5t0GM4V1xCzvZw4twA3eQEuCd5kbpfJAdN0NBx6QZKT1BHMInDfRgMy3flo5/iod
 BY6Y/AMAse1qpWEmzCWjDDinh3+OlfciRd0MYzpm+bRlhIHO8cfuvfyyR+z+ntVgmqnq
 0RbQ==
X-Gm-Message-State: AOAM533nYdJqMWN2LQ90jxHFVOPG4SuJE0+qOXcGo5cUsXJgDEvwwaGI
 +fgCph2VWFH9Wv3nyL9gFWI=
X-Google-Smtp-Source: ABdhPJzUPsMdAeOBbr4NEindwaLRFoRqfHTtx76ofqKF2ROnAOvfkKWdkGiuPX65uPnkd32Nc5h4tQ==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr11666375pge.77.1617953344003; 
 Fri, 09 Apr 2021 00:29:04 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id z23sm1337878pjh.45.2021.04.09.00.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 00:29:03 -0700 (PDT)
Date: Fri, 9 Apr 2021 16:29:01 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210409072901.GA2085@localhost>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408120842.1450092-14-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_082906_445457_2A85DF1F 
X-CRM114-Status: GOOD (  16.96  )
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

On 21-04-08 14:08:42, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 001faf31fb944f..304dc66bcebf22 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -357,6 +357,14 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  	return nvme_ns_ioctl(ns, cmd, argp);
>  }
>  
> +long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct nvme_ns *ns =
> +		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
> +
> +	return nvme_ns_ioctl(ns, cmd, (void __user *)arg);
> +}
> +
>  #ifdef CONFIG_NVME_MULTIPATH
>  static int nvme_ns_head_ctrl_ioctl(struct nvme_ns_head *head,
>  		unsigned int cmd, void __user *argp)
> @@ -393,6 +401,15 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
>  		return nvme_ns_head_ctrl_ioctl(head, cmd, (void __user *)arg);
>  	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
>  }
> +
> +long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
> +		unsigned long arg)
> +{
> +	struct cdev *cdev = file_inode(file)->i_cdev;
> +	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
> +
> +	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
> +}
>  #endif /* CONFIG_NVME_MULTIPATH */

Tested with namespace-specific admin commmand (Identify Namespace).  And
it fails with invalid IOCTl because we don't have a route to the
controller IOCTL for the generic chrdev.

Maybe we can have the following patch with simplifying the little bit
duplicated codes and make blkdev and generic device consistent which
will make user-space application happy?

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 304dc66bcebf..cbce9e35a591 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -346,15 +346,19 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	}
 }
 
+static int __nvme_ioctl(struct nvme_ns *ns, unsigned int cmd, void __user *arg)
+{
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, arg);
+	return nvme_ns_ioctl(ns, cmd, arg);
+}
+
 int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
-	void __user *argp = (void __user *)arg;
 
-	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
-	return nvme_ns_ioctl(ns, cmd, argp);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -362,7 +366,7 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
 
-	return nvme_ns_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg);
 }
 
 #ifdef CONFIG_NVME_MULTIPATH
@@ -392,14 +396,20 @@ static int nvme_ns_head_ns_ioctl(struct nvme_ns_head *head,
 	return ret;
 }
 
+static int __nvme_ns_head_ioctl(struct nvme_ns_head *head, unsigned int cmd,
+		void __user *arg)
+{
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ns_head_ctrl_ioctl(head, cmd, arg);
+	return nvme_ns_head_ns_ioctl(head, cmd, arg);
+}
+
 int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
 
-	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(head, cmd, (void __user *)arg);
-	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
+	return __nvme_ns_head_ioctl(head, cmd, (void __user *)arg);
 }
 
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
@@ -408,7 +418,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	struct cdev *cdev = file_inode(file)->i_cdev;
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 
-	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
+	return __nvme_ns_head_ioctl(head, cmd, (void __user *)arg);
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
