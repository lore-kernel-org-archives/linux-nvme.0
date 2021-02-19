Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79024C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 23:17:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBD164E92
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 23:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBD164E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vFRmznJoWMvnGV2njv4rH8aTMTYV0hy2NJ7RrHunarw=; b=r685mbj2chKcyza2pJiHhA16h
	CWoVhJCio9zSytWy5cmp86n8hl7jYXJrI9Vgi1gDGXBgis5EVwaGsgMqaZhnIQ5WNpuTi5VVMak4L
	3kbAmikbTHW/wnirUuP8Quo2flUzlXdhQILMYRrWvZROJvsgeidWhbIBt1Ron3a6JPZnkH4+QJ+Z2
	UmaSdZ1KScKDK+ThVer63VOgHLMy5LeMWPBEtv4DWE4uEf1Aojy+GiGS5M7xaxL9lJOUa5w08dLNB
	0A09poLmbgVZD10/LMWk45nS+WpyFv0sn3rvhcvPsNZFBx1EhKksS5BBS8XloxvlZNzzNLe92LxuF
	DjOGINteQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDF14-0006bt-Dm; Fri, 19 Feb 2021 23:16:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDF11-0006bT-JL
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 23:16:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DDD664EC0;
 Fri, 19 Feb 2021 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613776609;
 bh=sJo1yBVRPa+A/zBSOaKOH4QDFsolGjeBToH/p14wpmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=anjqr4jZWR4iPggn4z/YAXJSDGkL3hJ7+6E9VTWcmu4HsqgBjlgTEp+qFFzpnuT0n
 iXJu02a33z+iQ5AoAB7IUgZmIkI/q5VqIWH0tg+Qmp/cnhVaXn09nOB3U3YrwYfzXO
 zT0q9u5uKubgKsuafFp8SLbdJ+q6QfFXfYi+Nmb/dLobrikMKHE4BiUqrTobAp2xYb
 v1KnzIdrO60/LmhJwCC4wGJfX1HniuMbTBigqstTEUUMV+wEEfk98dlX/gtoU2NiFG
 RAUnk/5rUBYIHaafPXYak628pCJYdDvgFemQoAz0k5atAgynbji0GuJczy1/ocQt3b
 ydhyKZmzVwNbw==
Date: Sat, 20 Feb 2021 08:16:43 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: add 'fail_if_no_path' sysfs attribute
Message-ID: <20210219231643.GA4105@redsun51.ssa.fujisawa.hgst.com>
References: <20210219144625.56344-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210219144625.56344-1-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_181651_759581_C6BEE92D 
X-CRM114-Status: GOOD (  18.42  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 19, 2021 at 03:46:25PM +0100, Hannes Reinecke wrote:
> In some setups like RAID we need to return an I/O error
> once all paths are unavailable to allow the upper layers
> to start their own error recovery (like redirecting I/O
> to other mirrors).
> This patch adds a sysfs attribute 'fail_if_no_path' to
> allow the admin to enable that behaviour instead of the
> current 'queue until a path becomes available' policy.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Sounds okay to me, just some minor nits below.

> @@ -283,10 +283,13 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>  			continue;
>  		switch (ns->ctrl->state) {
>  		case NVME_CTRL_LIVE:
> +			return true;
>  		case NVME_CTRL_RESETTING:
>  		case NVME_CTRL_CONNECTING:
>  			/* fallthru */
> -			return true;
> +			if (!test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
> +				      &head->flags))
> +				return true;

It doesn't look like the 'fallthru' is in the right place anymore,
though I can't tell why it is there in the first place.

>  		default:
>  			break;
>  		}
> @@ -641,6 +644,37 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
>  }
>  DEVICE_ATTR_RO(ana_state);
>  
> +static ssize_t fail_if_no_path_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +
> +	return sprintf(buf, "%d\n",
> +		       test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags) ?
> +		       1 : 0);
> +}
> +
> +static ssize_t fail_if_no_path_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +	int fail_if_no_path, err;
> +
> +	err = kstrtoint(buf, 10, &fail_if_no_path);
> +	if (err)
> +		return -EINVAL;
> +
> +	else if (fail_if_no_path <= 0)
> +		clear_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
> +	else
> +		set_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);

The extra line above the 'else if' should be removed, or just change it
to simply 'if'.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
