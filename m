Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D81C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 15:20:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBCF22B40
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBCF22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pv+hGJPehSfZVPzREDAP1+nHQmxfIDIzLHpbcPdomrE=; b=jkw9krpzmuHP9zcxrRI6v8ni2
	8UyG3zmlMjNIusc23ZFG6imkOGiYCBzsk9J3LcHeUYwWPIqutSvjrCJ1x7zwqnZDMiwPkiDCX61Le
	Gl2JU4JDnkWORsXsPAGhZ6Ps7D5d4SwKwm9LcFADCgaonxTV1o7arWVc6W5x85DpEQ37KLxoDzUj+
	dH+PVlXR4DqRjFqXGfl3DED9Z+kMVGfeZ4IIXoO7J9z1mDTTlWIFnXwgicQpg9lgzhwlr5UDn46tK
	3HuE5rl9FpNUwz7kKVkc3WN5IIsC16vNDbFTmYjDxBuqDbXzuRP13ON9sHqrg1+u+t9TyAYp44NQy
	kG/tTMqZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klCsg-0005vv-4E; Fri, 04 Dec 2020 15:20:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klCsc-0005vI-Hw
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 15:20:19 +0000
Date: Sat, 5 Dec 2020 00:20:11 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607095215;
 bh=ncY315iJeGvTMmfnZw3GX6LHxh1BuMLiMin6kSHzmLQ=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=f8WisU1kvj2CLvql1zw1hsgsRKXVqD90hQ4cQfJbegvB2yjtFtvguMh5A71jPS7ez
 mQhM2Q3VKyY17qB0nWpuEZoN+AyyTt1GVdiU7d5QhQYbIBK+2Cjnt+I9uzZpz35tev
 l0WQR5XhMkaakokCw29qCW6oTC4EiYIfO8bCRTvbv6naS4JLWAiNNEmI5vzyPbHLbX
 vSAmDvcFUFnWfJT6TxxVlBhdea1BINVXUMMAiafs+GaCu+o0lJ4btt3dRjvVG7RppF
 Tf6DBfEs7bMYcgHLRY1OM8WFy7EDkekoX142BrJimT59djm/L9a2Fbwh6r/kk60e9S
 Dybw7bLJOJGAA==
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: re-read ANA log on NS CHANGED AEN
Message-ID: <20201204152011.GB8868@redsun51.ssa.fujisawa.hgst.com>
References: <20201204150310.30434-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201204150310.30434-1-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_102018_675880_86267979 
X-CRM114-Status: GOOD (  12.10  )
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

On Fri, Dec 04, 2020 at 04:03:10PM +0100, Hannes Reinecke wrote:
> -	error = nvme_parse_ana_log(ctrl, &nr_change_groups,
> -			nvme_update_ana_state);
> -	if (error)
> -		goto out_unlock;
> +	/*
> +	 * Don't update ANA groups if triggered by an NS CHANGED
> +	 * AEN; we'll be rescanning all namespaces anyway afterwards.
> +	 */
> +	if (!test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
> +		error = nvme_parse_ana_log(ctrl, &nr_change_groups,
> +					   nvme_update_ana_state);
> +		if (error)
> +			goto out_unlock;
> +	}
>  
>  	/*
>  	 * In theory we should have an ANATT timer per group as they might enter
> @@ -557,6 +563,10 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl)
>  		del_timer_sync(&ctrl->anatt_timer);
>  out_unlock:
>  	mutex_unlock(&ctrl->ana_lock);
> +
> +	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
> +		nvme_queue_scan(ctrl);
> +
>  	return error;
>  }

The scan work can be started from other contexts too, so there are some
unfortunate races here if one of those other contexts clears ctrl->events
before the ANA work gets to see it, which then gets you back to having
unusable namespaces when that scan work uses a stale ana log.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
