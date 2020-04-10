Return-Path: <SRS0=viL0=52=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38A6C2BA2B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 07:31:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1B920757
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GLjQlSu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1B920757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JHYoe4V6Dc+BjrnxSj7qKMTJM16cdvzY2gQwDWMY1kE=; b=GLjQlSu0KrRySF9vRDnp9bLYW
	8E3xYtMeJ08pXu3fxHbSY1IG9SuONDxRyFlrgInheLC3mMrx6LINHyqW+zNeZuPwu/RuRtlkKW1MA
	ZKLwMvBkYDEIeGx1EMe2xuAa2Odw5QmJL8xnkj0Lsc+/j6UQQ1G2s4w6QtfKJTPdMwAhDERYrjFsY
	VL1OHgv3QugoO6yuqjJHhZrsgI7v+IidhSK8tz6pBEEn0T/zg9wjBnSmTHj8v5ImFfKusWBvjwJoW
	L2ytmmz6WI9BCQMD01rk30jsh4KzHVdHefZ7zF6v2fO+UtjCuixQGjpVJVAnJoE200JvWuuevUJ1Z
	L/byeJ5qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMo8A-0005Ii-Nw; Fri, 10 Apr 2020 07:31:14 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMo88-0005IP-1U
 for linux-nvme@lists.infradead.org; Fri, 10 Apr 2020 07:31:13 +0000
Received: by mail-wr1-f67.google.com with SMTP id u13so855985wrp.3
 for <linux-nvme@lists.infradead.org>; Fri, 10 Apr 2020 00:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Uv8v+1L/JTESYzbSzIvvylDRAY8dn7k/E3LT4L81JY=;
 b=Rs8rrora21badEk7Rn4aZ/88sLalExTLbvKaRCG/tHPuBq9N+q7l584CoSbHub1reZ
 slMxhjDS1SZAL2BQKBb0pFuOlu43uFsMQ8qbQ2uhreCgr8J6Po1q0XoX+JqFrCvqZfw1
 mhG0/vzV2ApTW4SBqDKwsL7sipoA1MEOTRXVLeWuLi0UR5rnk7NwnilNtOaz0A2kjCuQ
 1oklk1kTVWTu6fu/sFC51/5jq6WEWLwt3t3WELkfwT6hGBLbNWJPAgtr9aM5NomAOTWs
 qlKPldkEHHnpc2P5e40gOPfqCULUYG28M+juf0uUeqf8C1un9AQxPe7eYLB4PMj4ugqV
 HoLw==
X-Gm-Message-State: AGi0PuarFIkLZfw2uYhOo7xV6qMw7gxBQ0/ImsBI/DroHX8d7dbKOcyp
 XASf6CaubHJDHxi73v1iaSEQXZOj
X-Google-Smtp-Source: APiQypIA8N70pg//94mcJvWY/aOkjVmTgUyR/2EhECiuohzp8oMEdwohIvFjwNfYRWFbQXSwmwt2Mg==
X-Received: by 2002:adf:f4cc:: with SMTP id h12mr3149797wrp.171.1586503869907; 
 Fri, 10 Apr 2020 00:31:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9052:1641:fbba:d9ee?
 ([2601:647:4802:9070:9052:1641:fbba:d9ee])
 by smtp.gmail.com with ESMTPSA id p10sm1725519wrm.6.2020.04.10.00.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 00:31:09 -0700 (PDT)
Subject: Re: [PATCH 03/10] nvme: always search for namespace head
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200409160908.1889471-1-kbusch@kernel.org>
 <20200409160908.1889471-4-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <90cb3318-f064-0dc2-a200-6951865d577b@grimberg.me>
Date: Fri, 10 Apr 2020 00:31:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409160908.1889471-4-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200410_003112_082232_0ACD9401 
X-CRM114-Status: GOOD (  17.66  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Even if a namespace reports it is not capable of sharing, search the
> subsystem for a matching namespace head. If found, the driver should
> reject that namespace since it's coming from an invalid configuration.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 253ea57855db..be2d856923e8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3489,8 +3489,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>   		goto out;
>   
>   	mutex_lock(&ctrl->subsys->lock);
> -	if (is_shared)
> -		head = nvme_find_ns_head(ctrl->subsys, nsid);
> +	head = nvme_find_ns_head(ctrl->subsys, nsid);
>   	if (!head) {
>   		head = nvme_alloc_ns_head(ctrl, nsid, &ids);
>   		if (IS_ERR(head)) {
> @@ -3498,6 +3497,14 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>   			goto out_unlock;
>   		}
>   	} else {
> +		if (!is_shared) {
> +			dev_err(ctrl->device,
> +				"Duplicate unshared namespace %d\n",
> +					nsid);
> +			ret = -EINVAL;
> +			nvme_put_ns_head(head);
> +			goto out_unlock;
> +		}

Given that you have multiple places that you put the ns head ref,
maybe it will be more maintainable if you add an out_put_ns_head tag to
goto and that will be like:
--
out_unlock:
         mutex_unlock(&ctrl->subsys->lock);
out:
         if (ret > 0)
                 ret = blk_status_to_errno(nvme_error_status(ret));
         return ret;
out_put_ns_head:
	nvme_put_ns_head(head);
	goto out_unlock;
--

Not a must, but to me seems better than puting the ref explicitly
every time...

otherwise,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
