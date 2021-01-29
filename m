Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D30C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 22:10:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F9C64DDC
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 22:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F9C64DDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZPJkE8cbbBEEcIjXuu+neFPyMdzv2B6INHa9YZNSJv0=; b=QBbTDBpsgiH050yYaUhgrmk3W
	ukBBknI32bTVLvdOjcC01GzsAWZ9AHwoeGWTo0pYxPo6ZHXMA5fMOYWUjA9Ws3ADIrG2vbnAuHa0C
	ujOidenyEsbxwALzgk0j+JZQb81NX7rRPJtY1fO7gz/zemVtjAr6uexXfGIXbWtKwu4JdTuX3Yrjd
	BstysD1aKBrzmVwIF/Rf1/rdIj88hj+nCRdQ5lT6wXQKDxAxUSRDdXpj6/PIcu2lErKiJzPQkjBJQ
	TOfBQ4JzDfYfSm3XbFwmzMf/+ak/3jV/ICoVIhIhksgyFOFbV/JJbk7IInaWSYlzuWxHt6phif95W
	jb41ruVGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5byH-00027B-M3; Fri, 29 Jan 2021 22:10:29 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5byE-00026e-83
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 22:10:27 +0000
Received: by mail-wm1-f54.google.com with SMTP id i9so8306651wmq.1
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 14:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W9nYyEx4oOiv0q+ANgMyzhA6AL6Uiw5hNvePMrDfjGU=;
 b=uBLVftG9paZ/5Vlc3w3aDmLvqJmC5AJzKiCfFNPTkGKKZ+MGII53InAv0kSs/QFQh+
 BqP1zDDOuKN5nauCfY99nhQWM5Y4aO5XOKTYVwK9PTpVRLS+/cXeKwJk0xbDTvx8A9jU
 ILgP4VF6dLhbl1xAEGfL/o8C9tU+XSnIMwUei6O6DsIHVXsL441yoMmX7O+YaJ5DSjyf
 KfTdArukXzajsETqHaY4Lyj56EfH3n6aDL2ewfgn56gTZHih+aRON0ezau5U5aXePqHI
 HpVqQEdswBgYRJgrkdqvDO/S1JvslBzPOLq3BWis54G3OAVuNqIElEj7TNJHw4EmOqzR
 x/Sw==
X-Gm-Message-State: AOAM531pLQbWELDni3FW3cmOP6oWvnNCRCE5RirMuQ9cmgOpwPW+B8pk
 FE4z443mqoXiEuqf/B62s/NoUv42A/8=
X-Google-Smtp-Source: ABdhPJytcq6Dwoe04IqE6VPu+IOUcoSxyeukUr11M5zh9KNw3kvkynaVHH/mWc/mNqmUUhQ+aayl/w==
X-Received: by 2002:a1c:483:: with SMTP id 125mr5562774wme.80.1611958225017;
 Fri, 29 Jan 2021 14:10:25 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id s25sm15301235wrs.49.2021.01.29.14.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 14:10:24 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210128152758.114112-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a3c4ef7f-45df-c071-8e00-074d1e48eaca@grimberg.me>
Date: Fri, 29 Jan 2021 14:10:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128152758.114112-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_171026_379176_8B6CDA35 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> @@ -1453,9 +1453,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	sock->sk->sk_state_change = nvmet_tcp_state_change;
>   	queue->write_space = sock->sk->sk_write_space;
>   	sock->sk->sk_write_space = nvmet_tcp_write_space;
> +
> +	switch (sk->sk_state) {
> +	case TCP_FIN_WAIT1:
> +	case TCP_CLOSE_WAIT:
> +	case TCP_CLOSE:

BTW, shouldn't this be if (sk->sk_state != TCP_ESTABLISHED) ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
