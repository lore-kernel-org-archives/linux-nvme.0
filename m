Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61886C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 23:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/NUsOBPQ8xZZlET6Wn7LODG7ETjlDjdqAWeGuLL/FM=; b=rz8sW/gxXQAj31Y+yNi8LrBkb2
	XNFjCDe3M6rSS9TDHgjIFxMSs1uTy+egX8+STPkRID86o2GG8a7mW6tNi4mwrXQcNpEb+oRIvfWUb
	jQarsQQLsOK3VYVu78yLPYplKlPa3nLTp+JTSz2SfL9EcVcIcb396b3IImR9Bqn/yexOVcrukIlAi
	gxmbPWiTCHSbR3jBankzZk2cPLy+ZHoYLSXoJhE8YRmwxAVASmuvUaHZKPu5Wc+9IxkhNfLFs26k3
	cQKKswV9gIc4f/XPU9XFOSTYxefZbPaXssAHCO5lAbyFNSmQHQHgm/LmS0ZlqO02vuyCxwi/L8QN1
	Y+rYpqKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov51i-00FYE8-IT; Tue, 15 Nov 2022 23:07:34 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov51g-00FYDW-Ko
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 23:07:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id AC239CE19A4;
	Tue, 15 Nov 2022 23:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA20C433C1;
	Tue, 15 Nov 2022 23:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668553648;
	bh=saQ8CFN9k/04GT3jsFLnu9AakHqfR/AzeQx3kPTzKak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJouLVJ32LVDu3T9KZlr/41Nt4HS3j624ZKHFjROQOpGiaUGk5GxydTzduoGaLbZs
	 syJZQD7wXutOQgdrByh9P7x9sIulAql34UBj0Jkc+xAHTrWrRmoqL1xfWAXBHyljOV
	 EEbOsTLGFGgJZhErD/42F6BAq1WzNoIImgLovSsYZPomatFY5VHRYSHaPvZ15vR9Zh
	 gHMLQwYuGDyZ/kEl0GFv7t7PXBnOSXoIyl9B6ONaLfz2KdQL6D6HkbJHHLftN0bXvX
	 cmBpKqlG27mm+BCuqj6R7QH67Gl4aPL2AgCOU0h19h0grH9xGHY2dWpKkXCdiJQMbK
	 Xq4sbM9DK+y7g==
Date: Tue, 15 Nov 2022 16:07:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	"Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3QbrKaQdffR/HcX@kbusch-mbp.dhcp.thefacebook.com>
References: <20221114203412.383-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114203412.383-1-jonathan.derrick@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_150732_887707_7693BF3B 
X-CRM114-Status: GOOD (  16.18  )
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

On Mon, Nov 14, 2022 at 01:34:12PM -0700, Jonathan Derrick wrote:
> +	echo "Running ${TEST_NAME}"
> +
> +	local sysfs
> +	local attr
> +	local m
> +
> +	sysfs="$TEST_DEV_SYSFS/device"

That's not the correct directory when the device is using native
nvme-multipath.

> +	timeout=$(($(cat /proc/sys/kernel/hung_task_timeout_secs) / 2))
> +
> +	sleep 5
> +
> +	if [[ ! -d "$sysfs" ]]; then
> +		echo "$sysfs doesn't exist"
> +	fi
> +
> +	# do reset controller/format loops
> +	# don't check status now because a timing race is desired
> +	i=0
> +	start=0
> +	timing_out=false
> +	while [[ $i -le 1000 ]]; do
> +		start=$SECONDS
> +		if [[ -f "$sysfs/reset_controller" ]]; then
> +			echo 1 > "$sysfs/reset_controller" 2>/dev/null &
> +			i=$((i+1))
> +		fi
> +		nvme format -l 0 -f $TEST_DEV 2>/dev/null &
> +
> +		#Assume the controller is hung and unrecoverable
> +		if [[ $(($SECONDS - $start)) -gt $timeout ]]; then
> +			echo "nvme controller timing out"
> +			timing_out=true
> +			break
> +		fi
> +	done

If the controller is already undergoing a reset, then writing to the
reset_controller file becomes a no-op. Unless your "reset_controller"
completes near instantaneously, I find that this loop tears through 1000
iterations, forks 1000 formats, and only 1 reset_controller actually
gets through.

If I remove the upper limit, then I can also see the stalled task, but
it is only temporary and gets itself out of it after the admin timeout
(1 minute). Is that also your observation, or is it stuck forever?

