Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01529C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 13:10:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FE760F22
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 13:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9FE760F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oka8BPn0ml7Ks0c1iadMhDeobU8vb2VBZRgvZzt5e7c=; b=oLPJsaSNdvIjBF
	MH/WLSGXU2frBE+xsV02xNq6WAjG4CSWO0LUEA7Jli+kEDnlYeOLMYzFZ9DEbijSymv8tqP++qYo8
	2TF4tCUepBIavk+rHQDz1/I5Fvv6jb643lQSs2UJZosKNJ9bT11RcXgy/b0Fv18GDf+jDdmY4p6b/
	AX2s7TA5llT7lmn9h2nhN3UiirmAP/VRtusgv/MnFJEdOLwurEMHN7ZyhsJNaK3kaKGICK+rHU80u
	flDE6xOqp4pCCY9PX0EuGGh4hP+QvLo5/yFYbZnu6xNW+nrY+5Jgh5HMWErJiAjlb+dWaCxXgElIQ
	OMMtK+QGmdYOeFa3XW+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFyqn-002Xhj-F4; Tue, 17 Aug 2021 13:09:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFyqh-002Xep-BN
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 13:09:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36DA560F22;
 Tue, 17 Aug 2021 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1629205787;
 bh=eAJNwq+LR0vGZWapzyEOlD/ux+bUrLIyd52HO8STYtc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yvx+YmPwu3IclVZ3FyBJ1vW8Cx4JY6xaozjlAH01HnNG0VX6LxT0DRr7zvHM+befh
 kOnw9shM9edP0OujVaUD0Xn0i6jy08Z8Abxo0s/bwVwGL5G2nt06PTLR5QwPctxLXy
 TlwQfCNYyyZ4TxF2m5PVOwsCTcP/x22DYBUTs7y8=
Date: Tue, 17 Aug 2021 15:09:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
 kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
 asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
 willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
 mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
 snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
 joshiiitr@gmail.com, nj.shetty@samsung.com, nitheshshetty@gmail.com,
 joshi.k@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH 4/7] block: Introduce a new ioctl for simple copy
Message-ID: <YRu1GG7SRMMcNyrZ@kroah.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b@epcas5p1.samsung.com>
 <20210817101423.12367-5-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210817101423.12367-5-selvakuma.s1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_060947_493688_BF046A84 
X-CRM114-Status: GOOD (  24.03  )
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

On Tue, Aug 17, 2021 at 03:44:20PM +0530, SelvaKumar S wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
> to a destination in the device. COPY ioctl accepts a 'copy_range'
> structure that contains destination (in sectors), no of sources and
> pointer to the array of source ranges. Each source range is represented by
> 'range_entry' that contains start and length of source ranges (in sectors)
> 
> MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
> 
> Example code, to issue BLKCOPY:
> /* Sample example to copy three source-ranges [0, 8] [16, 8] [32,8] to
>  * [64,24], on the same device */
> 
> int main(void)
> {
> 	int ret, fd;
> 	struct range_entry source_range[] = {{.src = 0, .len = 8},
> 		{.src = 16, .len = 8}, {.src = 32, .len = 8},};
> 	struct copy_range cr;
> 
> 	cr.dest = 64;
> 	cr.nr_range = 3;
> 	cr.range_list = (__u64)&source_range;
> 
> 	fd = open("/dev/nvme0n1", O_RDWR);
> 	if (fd < 0) return 1;
> 
> 	ret = ioctl(fd, BLKCOPY, &cr);
> 	if (ret < 0) printf("copy failure\n");
> 
> 	close(fd);
> 
> 	return ret;
> }
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  block/ioctl.c           | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h |  8 ++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index eb0491e90b9a..2af56d01e9fe 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -143,6 +143,37 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>  				    GFP_KERNEL, flags);
>  }
>  
> +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> +		unsigned long arg)
> +{
> +	struct copy_range crange;
> +	struct range_entry *rlist;
> +	int ret;
> +
> +	if (!(mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> +		return -EFAULT;
> +
> +	rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
> +			GFP_KERNEL);
> +	if (!rlist)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(rlist, (void __user *)crange.range_list,
> +				sizeof(*rlist) * crange.nr_range)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	ret = blkdev_issue_copy(bdev, crange.nr_range, rlist, bdev, crange.dest,
> +			GFP_KERNEL, 0);
> +out:
> +	kfree(rlist);
> +	return ret;
> +}
> +
>  static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
>  		unsigned long arg)
>  {
> @@ -468,6 +499,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>  	case BLKSECDISCARD:
>  		return blk_ioctl_discard(bdev, mode, arg,
>  				BLKDEV_DISCARD_SECURE);
> +	case BLKCOPY:
> +		return blk_ioctl_copy(bdev, mode, arg);
>  	case BLKZEROOUT:
>  		return blk_ioctl_zeroout(bdev, mode, arg);
>  	case BLKGETDISKSEQ:
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 7a97b588d892..4183688ff398 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -76,6 +76,13 @@ struct range_entry {
>  	__u64 len;
>  };
>  
> +struct copy_range {
> +	__u64 dest;
> +	__u64 nr_range;
> +	__u64 range_list;
> +	__u64 rsvd;

If you have a "reserved" field, you HAVE to check that it is 0.  If not,
you can never use it in the future.

Also, you can spell it out, we have lots of vowels :)

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
