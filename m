Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47981C19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+0qvG5LpZ/YCrirnG9rg8hMNbrBXBa71sPfrtvKm9k=; b=JnbY19JzEJjb1v2/NQSTx/qP5S
	Xt2+FGlGUsWjWQQ7e9WPKYbb+y9E0F32mQeky9hTFHRwmxeGTUkd1AUuV09FEVifwrqp+VFnIxxOr
	v5/niHw4fGQfWZJHqC9+p70uvc6IWpnmDDFqkrVFpTLOSIF0PK7w08P4a5eoq717onMOUIn4yv52g
	snKou4rpQ7Mrz8nXrAZhf88Wy62cXZDVooAeQtPKauE0CQDHOaia2j9SXmjgEwImJizaRH5VWc1Zy
	lx0AWGeTBEd9tzdOtDjbo6+21m/opyZykAQ6FApo9YtCRWisTV4lpIF9lYyypioGOaVqq0HFVch2O
	QBld5Kew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUyS-005spw-WE; Tue, 09 Aug 2022 19:33:09 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUyQ-005snh-6a
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 19:33:07 +0000
Received: by mail-pj1-f44.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso2037149pjg.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Aug 2022 12:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=f+0qvG5LpZ/YCrirnG9rg8hMNbrBXBa71sPfrtvKm9k=;
        b=3/gu9tO9xagf+/HGcZc9bnrPSb+D7Hlypws2pcPjH1kK4kAgIsDpvNKxSsPihXIslo
         9SJD2GnyQ2Qfc/O1YGP3afpDbaE+c/C6IkIxFJhwH8Mv7gf0YH52hfXtoWoAuXB5xLsU
         vreAkndG3pdMbsn1RUA+fPjXPRXuwYf9sROKnDl3hXHK8CpEJJbpgKiOIskDUO1mcQ/x
         3x+pmuMLbdsO1WnXnUl9KP7FrKBCGTMp3O0ldO3Vfys/PPA5s/G/cxjWdLw7eo3BRLjv
         iNk1RrIZ8Qb9fxm99ed0qBvYZhTajl9VSd0P2RZXpzL++gUTBGa+eoG/ZNjOyZLWVTyf
         R9ag==
X-Gm-Message-State: ACgBeo0YpmVaxHRJJMgXT9T3HPgzwWm1dob8aUWl40Z/dlQof7fh/X0g
	19XrNKhaFleI6SIFc9kVZ1o=
X-Google-Smtp-Source: AA6agR5b3k6/3uuXU2uCikVcoZWIFTOMmR2vQDrfIljSBaQQd1XN66Nj9Fx1iPA0NtYy8Ovw7IMVMA==
X-Received: by 2002:a17:902:e891:b0:16f:a8:9b9c with SMTP id w17-20020a170902e89100b0016f00a89b9cmr24397129plg.8.1660073583617;
        Tue, 09 Aug 2022 12:33:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:61e9:2f41:c2d4:73d? ([2620:15c:211:201:61e9:2f41:c2d4:73d])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0016d12adc282sm11204466pln.147.2022.08.09.12.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 12:33:03 -0700 (PDT)
Message-ID: <4768d11e-06c6-1b74-9822-b2421a3f59bb@acm.org>
Date: Tue, 9 Aug 2022 12:33:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 12/20] block,nvme,scsi,dm: Add blk_status to pr_ops
 callouts.
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
References: <20220809000419.10674-1-michael.christie@oracle.com>
 <20220809000419.10674-13-michael.christie@oracle.com>
 <20220809072155.GF11161@lst.de>
 <4af2a4d3-04d1-966a-5fd5-5e443b593c8b@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4af2a4d3-04d1-966a-5fd5-5e443b593c8b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_123306_274646_187D250F 
X-CRM114-Status: GOOD (  37.81  )
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

On 8/9/22 11:08, Mike Christie wrote:
> On 8/9/22 2:21 AM, Christoph Hellwig wrote:
>> On Mon, Aug 08, 2022 at 07:04:11PM -0500, Mike Christie wrote:
>>> To handle both cases, this patch adds a blk_status_t arg to the pr_ops
>>> callouts. The lower levels will convert their device specific error to
>>> the blk_status_t then the upper levels can easily check that code
>>> without knowing the device type. It also allows us to keep userspace
>>> compat where it expects a negative -Exyz error code if the command fails
>>> before it's sent to the device or a device/tranport specific value if the
>>> error is > 0.
>>
>> Why do we need two return values here?
> 
> I know the 2 return values are gross :) I can do it in one, but I wasn't sure
> what's worse. See below for the other possible solutions. I think they are all
> bad.
> 
> 
> 0. Convert device specific conflict error to -EBADE then back:
> 
> sd_pr_command()
> 
> .....
> 
> /* would add similar check for NVME_SC_RESERVATION_CONFLICT in nvme */
> if (result == SAM_STAT_CHECK_CONDITION)
> 	return -EBADE;
> else
> 	return result;
> 
> 
> LIO then just checks for -EBADE but when going to userspace we have to
> convert:
> 
> 
> blkdev_pr_register()
> 
> ...
> 	result = ops->pr_register()
> 	if (result < 0) {
> 		/* For compat we must convert back to the nvme/scsi code */
> 		if (result == -EBADE) {
> 			/* need some helper for this that calls down the stack */
> 			if (bdev == SCSI)
> 				return SAM_STAT_RESERVATION_CONFLICT
> 			else
> 				return NVME_SC_RESERVATION_CONFLICT
> 		} else
> 			return blk_status_to_str(result)
> 	} else
> 		return result;
> 
> 
> The conversion is kind of gross and I was thinking in the future it's going
> to get worse. I'm going to want to have more advanced error handling in LIO
> and dm-multipath. Like dm-multipath wants to know if an pr_op failed because
> of a path failure, so it can retry another one, or a hard device/target error.
> It would be nice for LIO if an PGR had bad/illegal values and the device
> returned an error than I could detect that.
> 
> 
> 1. Drop the -Exyz error type and use blk_status_t in the kernel:
> 
> sd_pr_command()
> 
> .....
> if (result < 0)
> 	return -errno_to_blk_status(result);
> else if (result == SAM_STAT_CHECK_CONDITION)
> 	return -BLK_STS_NEXUS;
> else
> 	return result;
> 
> blkdev_pr_register()
> 
> ...
> 	result = ops->pr_register()
> 	if (result < 0) {
> 		/* For compat we must convert back to the nvme/scsi code */
> 		if (result == -BLK_STS_NEXUS) {
> 			/* need some helper for this that calls down the stack */
> 			if (bdev == SCSI)
> 				return SAM_STAT_RESERVATION_CONFLICT
> 			else
> 				return NVME_SC_RESERVATION_CONFLICT
> 		} else
> 			return blk_status_to_str(result)
> 	} else
> 		return result;
> 
> This has similar issues as #0 where we have to convert before returning to
> userspace.
> 
> 
> Note: In this case, if the block layer uses an -Exyz error code there's not
> BLK_STS for then we would return -EIO to userspace now. I was thinking
> that might not be ok but I could also just add a BLK_STS error code
> for errors like EINVAL, EWOULDBLOCK, ENOMEM, etc so that doesn't happen.
> 
> 
> 2. We could do something like below where the low levels are not changed but the
> caller converts:
> 
> sd_pr_command()
> 	/* no changes */
> 
> lio()
> 	result = ops->pr_register()
> 	if (result > 0) {
> 		/* add some stacked helper again that goes through dm and
> 		 * to the low level device
> 		 */
> 		if (bdev == SCSI) {
> 			result = scsi_result_to_blk_status(result)
> 		else
> 			result = nvme_error_status(result)
> 
> 
> This looks simple, but it felt wrong having upper layers having to
> know the device type and calling conversion functions.

Has it been considered to introduce a new enumeration type instead of 
choosing (0), (1) or (2)?

Thanks,

Bart.

