Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B883C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yo2KOKo7PhGe5xNKh01eTn+vxApB9uc4iRXq8vOpSW0=; b=eu/ATlj7F2DaNQ8gEYUha0UQgT
	/ftZ8FkcXduYFehSb5xtAmZcBy0ZkJ0bl163sOrCub4gs7PepBhMANkhaN2gb8d6fQ7EYPjwfMsjM
	m549lHTSEFq3XS4w6MzxNbzJqIhoUe+xNh+0PZpLt/JWovJtMEJMu163M9ioCfCWnXIMD5Saym//h
	jpZL9V3ry4Sw9A3Cqtq/VTsoyo44PwPEX08Lw3jNuhFw+pw7Jh2YHaFpbdMKXrbieKEaL0SZUgGW8
	4LVZg/jdOqYk5293n4drh8S9PHz96VmESwSy5WD6789AbpycVaxXZrJRmU1MHfonu2jBsUmk45DL0
	nlNcxJhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njpln-003icj-Hg; Wed, 27 Apr 2022 22:04:23 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njplj-003ia6-Q3
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 22:04:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651097052; x=1682633052;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=k/KRkqEEeZaWUZZuh+D9DotGgW9vx5Ww0QkxXdpO5fk=;
 b=b7E5pJaZcvhTaeq9UJmLsMV1IQY9xTA07oQ0Fl97DvYYr5HPLjgxkCm1
 KW0TlHpoi/3EkcESVzquL4GO3Qzhol52rJY8+iFQ/IUZAQlCsfEvvmA2u
 GtEqvdsRnjlSbKkMh6RxM9n1u0Gm5iwu24H3hX2/6j79pkEXMsOYeLa4t
 veAupdOrfQ5AdJTNr44EIPIo8Wivkzosfa+6YIlww6QYpv8uFcKGKdX0E
 C5wxxfmXXCP4xn2zXosk6MyiIZCDTD9bbhRxzSCsak/tkANh6U2K8qOaC
 WQQW75TqpvgfC+cghmhsefjztf6e4VBflsEIdu9Ep7+oNjeweEx73CZ8j Q==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; d="scan'208";a="203868019"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 06:04:10 +0800
IronPort-SDR: 0yXn69umU5bTI3rzdReg6jvwUAWod/e1eDnr3kWy48QwuONeBq0PdMMcA2BM/rp7IBCEbjOstJ
 sFP4FZ4Fj6ytT+kdjSROx8r3oTyMeZoj27K4IrAcMDjDLnr+tkACm9xnjnNaD/ivaAFkpYijjN
 SADzXh5+qyMgF50ClCuwxzXmKeZ+pfyPjtHLt2gGe0rGWXXAeiLHBUYAxjMXNvM2D1T8FsQ08W
 TF/m0Abw6NVZN/1K8W0es+ng4W+ir1oNo20b5pq9p6BXr8LCEdUhPhPwEgtpmGIKnZEhuDJtnI
 NXw8jdXol9SexoOOeAj2fg5v
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 14:34:26 -0700
IronPort-SDR: t+f3kOSX/CCadHTxPHwod1HKg0UD7LMGdzAze4cuxyADzy6aUbuLMqPTDMD94rO7mhKgUxv9sX
 2i94pr+rqXAWAuJvay5iC5c4Vey3DSa+Tx/rxzCnzlQtCNdWXODpR7XUwHFks4oP0aTy4sKKQS
 qKESqHqGD4b9oDVtruglpDJ8B0HUR+h4UY6q7p8l0KlRt55Ugu6aLT50SCKF5VQuvzC9MdKnsO
 dDROMuc9GlBgYRQMzdDuFUW22F6nbD9aeDeoK/FEcaXrr2cAFS0heKTcxPYwLY9ZXQgAyGMf0o
 KdY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 15:04:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXpS4DQZz1SVp0
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 15:04:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651097055; x=1653689056; bh=k/KRkqEEeZaWUZZuh+D9DotGgW9vx5Ww0Qk
 xXdpO5fk=; b=MbhRBbazzr7D4VA8v3jH+SvGTLoiKFNrqiL+bGru/x3suYWEUDu
 QbkxT4kdI0nlCCCMOMSYG5kG5yQGpR9q/Mc4cPIbCf8wVoLSeX2H+utl5oDJyye8
 421mmsRWhx34o3UNrgDQ4aCvEQOjz65S8mM9GxbsX9C+V9nly+I5olUWpqmNnfIm
 TBBGIxa5pZszyMP/91I0TkU+z4k/3S3V4CyPyS561G+EFPTLXo19FPV0zjm7zDQs
 TxpKz7M6dPKuW6yoUlZvQUnaNa2tZFCFQWAUAj+beWyC8Cr/JT29qyg6Q6cuk9Z+
 xeARN+7uUsuHStnXgwLd2ADfg0j69ZNxFPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id DjdYlVPynm8p for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 15:04:15 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXpQ3gm7z1Rvlc;
 Wed, 27 Apr 2022 15:04:14 -0700 (PDT)
Message-ID: <0d3b0a6b-825d-1b01-094a-911f81f5f354@opensource.wdc.com>
Date: Thu, 28 Apr 2022 07:04:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 02/10] block: Add copy offload support infrastructure
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101921epcas5p341707619b5e836490284a42c92762083@epcas5p3.samsung.com>
 <20220426101241.30100-3-nj.shetty@samsung.com>
 <7d1fdd1e-c854-4744-8bec-7d222fb9be76@opensource.wdc.com>
 <20220427151535.GC9558@test-zns>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427151535.GC9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_150419_906799_A160196E 
X-CRM114-Status: GOOD (  25.23  )
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

On 4/28/22 00:15, Nitesh Shetty wrote:
> On Wed, Apr 27, 2022 at 11:45:26AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> Introduce blkdev_issue_copy which supports source and destination bdevs,
>>> and an array of (source, destination and copy length) tuples.
>>> Introduce REQ_COPY copy offload operation flag. Create a read-write
>>> bio pair with a token as payload and submitted to the device in order.
>>> Read request populates token with source specific information which
>>> is then passed with write request.
>>> This design is courtesy Mikulas Patocka's token based copy
>>>
>>> Larger copy will be divided, based on max_copy_sectors,
>>> max_copy_range_sector limits.
>>>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
>>> ---
>>>  block/blk-lib.c           | 232 ++++++++++++++++++++++++++++++++++++++
>>>  block/blk.h               |   2 +
>>>  include/linux/blk_types.h |  21 ++++
>>>  include/linux/blkdev.h    |   2 +
>>>  include/uapi/linux/fs.h   |  14 +++
>>>  5 files changed, 271 insertions(+)
>>>
>>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>>> index 09b7e1200c0f..ba9da2d2f429 100644
>>> --- a/block/blk-lib.c
>>> +++ b/block/blk-lib.c
>>> @@ -117,6 +117,238 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>>  }
>>>  EXPORT_SYMBOL(blkdev_issue_discard);
>>>  
>>> +/*
>>> + * Wait on and process all in-flight BIOs.  This must only be called once
>>> + * all bios have been issued so that the refcount can only decrease.
>>> + * This just waits for all bios to make it through bio_copy_end_io. IO
>>> + * errors are propagated through cio->io_error.
>>> + */
>>> +static int cio_await_completion(struct cio *cio)
>>> +{
>>> +	int ret = 0;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&cio->lock, flags);
>>> +	if (cio->refcount) {
>>> +		cio->waiter = current;
>>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>>> +		spin_unlock_irqrestore(&cio->lock, flags);
>>> +		blk_io_schedule();
>>> +		/* wake up sets us TASK_RUNNING */
>>> +		spin_lock_irqsave(&cio->lock, flags);
>>> +		cio->waiter = NULL;
>>> +		ret = cio->io_err;
>>> +	}
>>> +	spin_unlock_irqrestore(&cio->lock, flags);
>>> +	kvfree(cio);
>>
>> cio is allocated with kzalloc() == kmalloc(). So why the kvfree() here ?
>>
> 
> acked.
> 
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static void bio_copy_end_io(struct bio *bio)
>>> +{
>>> +	struct copy_ctx *ctx = bio->bi_private;
>>> +	struct cio *cio = ctx->cio;
>>> +	sector_t clen;
>>> +	int ri = ctx->range_idx;
>>> +	unsigned long flags;
>>> +	bool wake = false;
>>> +
>>> +	if (bio->bi_status) {
>>> +		cio->io_err = bio->bi_status;
>>> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - ctx->start_sec;
>>> +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
>>
>> long line.
> 
> Is it because line is more than 80 character, I thought limit is 100 now, so
> went with longer lines ?

When it is easy to wrap the lines without readability loss, please do to
keep things under 80 char per line.


>>> +{
>>> +	struct request_queue *src_q = bdev_get_queue(src_bdev);
>>> +	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
>>> +	int ret = -EINVAL;
>>> +
>>> +	if (!src_q || !dest_q)
>>> +		return -ENXIO;
>>> +
>>> +	if (!nr)
>>> +		return -EINVAL;
>>> +
>>> +	if (nr >= MAX_COPY_NR_RANGE)
>>> +		return -EINVAL;
>>
>> Where do you check the number of ranges against what the device can do ?
>>
> 
> The present implementation submits only one range at a time. This was done to 
> make copy offload generic, so that other types of copy implementation such as
> XCOPY should be able to use same infrastructure. Downside at present being
> NVMe copy offload is not optimal.

If you issue one range at a time without checking the number of ranges,
what is the point of the nr ranges queue limit ? The user can submit a
copy ioctl request exceeding it. Please use that limit and enforce it or
remove it entirely.


-- 
Damien Le Moal
Western Digital Research

