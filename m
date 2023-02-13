Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F047C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zEsUXDdKH6aXW0zBsGdmSOws0LZYLZBOIUYIej48yDc=; b=puHDIQIEjcUG9By9iSCAZO7UQH
	bRR+O0HwaI9IZpba004L1CH2SQPaNJ9WWMmecgQs0+ZKvKyqChmvjEYucONicZrZy/AGdmdsM/7F2
	qnaBAmIzoSfeWeh+SN+40PMLQLi/U71ra6YPxCR4X/MuAbXnBrMU74Dejo/+7PHrxlMbXVd9Dq9Vy
	QUdoJt2omsAx/flOrXvMlxOG8eVDBvyWoKmXg5ItfMQjY/XO12Fr3dnfi4Pu/efUsHiCoEWBKoo/S
	5o5Fchdo8fuLTk2olZOB3a8JmOD2Xv/kx109YoA4OAfPs8DV9IGkvC2EZ0pCf3WiG1Qe4aAfRMdoV
	OAku392g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVk4-00E1s0-7M; Mon, 13 Feb 2023 10:07:24 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVjv-00E1o0-5u
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:07:17 +0000
Received: by mail-wm1-f50.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so8558429wms.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 02:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEsUXDdKH6aXW0zBsGdmSOws0LZYLZBOIUYIej48yDc=;
        b=nPwdV6j2zFuauYsOf+7yCrH4YhONhTt/iGw+tRmZbTSf2fiDwpU/KI3lxgTVyrQXw0
         p6jrVYaSsHyrKzgpdJxW26uO1msvArRaWtN7PsysVb6RA6k0j/0+Jqg6dHbQcCpSW/TW
         0GwbKOPCavLsqciaCR7XoWBWhJcqh6mXIDatNyS0IRvjRKMBxenD2CxR/7xXkmz4357j
         yoydD76/OIFgC6b2asnhQKAaaFBVs7KiC7YBwQsNGAIuagdzdCZv9eq7dwdyC5bw7QGi
         w3LMAzodEoI8XguNZM184Qz2yIftBKkVRGiPxJA2+W0QZ3mN6LXlmZrt+EVJ9siNBJdN
         wKOA==
X-Gm-Message-State: AO0yUKXVy3roEhZVSz+yy2+CBgE86ohupM1GnIWbopJR8zGYJxxBasRx
	t4Cspx96FMxAw01mhiL6QPk=
X-Google-Smtp-Source: AK7set+E7rHHgCZcp0ip1QLUhii29lPkdiDIDhgSNnjhdjNZCXVqGnlcgpjPxEAh82RC+pRWH8pYkA==
X-Received: by 2002:a05:600c:3ca7:b0:3dc:3b1a:5d2d with SMTP id bg39-20020a05600c3ca700b003dc3b1a5d2dmr22593803wmb.0.1676282830676;
        Mon, 13 Feb 2023 02:07:10 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id iv12-20020a05600c548c00b003dc521f336esm14616073wmb.14.2023.02.13.02.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:07:10 -0800 (PST)
Message-ID: <c5c78365-42a3-6507-f9bd-3bdb01e5b16b@grimberg.me>
Date: Mon, 13 Feb 2023 12:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/5] nvme: open-code __nvme_submit_sync_cmd()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-5-hare@suse.de> <20230213062654.GC14223@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230213062654.GC14223@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_020715_249477_8CBFCC2F 
X-CRM114-Status: GOOD (  13.71  )
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


>> -	ret = __nvme_submit_sync_cmd(req, &res, buffer, buflen, 0);
>> +	ret = blk_rq_map_kern(req->q, req, buffer, buflen, GFP_KERNEL);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = nvme_execute_rq(req, &res, false);
> 
> This could use nvmf_submit_fabrics_cmd, which has nothing to with
> fabrics, but just is a variant of nvme_submit_sync_cmd that returns the
> result.

I think that the distinction is that it operates on the fabrics request
queue as well.

>  So if we have that helper anyway we might as well move it to
> the core and turn nvme_submit_sync_cmd into a wrapper for it.

I was thinking the other way around, nvmf_submit_fabrics_cmd wraps
nvme_submit_sync_cmd with ctrl->fabrics_q, and we can add

