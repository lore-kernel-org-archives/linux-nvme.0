Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1D1ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=rIbQs33EpkB9I5b1YcG2UjMRgx
	OordC2L9hca/V9r3/c3wJgYBeiJdZbaQktUkSW0TBdgI2HBNT9sDVMIdZVEcWcpZPoq0tLlNOhe47
	SmlhOXWHqkmPcXxktwFvBiL79/0c8BTuKi1djR7rGRoD/Er+kc/JvNCFt0l9RSbbHxWW9855bMLX6
	wRukVfCxtYjd9UhGMFbz/EYyvTwJjEFDXDAjacS0HpbOwLDwhgfbDUj6w/SECI20sqACMsduvcPVy
	Eu5MV/3/UMY7Sr1VvUyEGPemekkKcisUSiNgXjLxveWR27yXQ5EUusUfp01pvNwC7MmTkVxWBnIcZ
	DX6SASRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxGJ-00Awo8-Nc; Wed, 21 Sep 2022 10:47:27 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw3f-00APwC-6E
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:30:20 +0000
Received: by mail-wr1-f45.google.com with SMTP id c11so8801203wrp.11
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=k5FLuDzxgDOw0APmckJBBae6YAOo7R4FzaelMch2HNgkhK8UkBZtSHZa3eO736/MoR
         EqmeHVR6EMRz+/HSXRSxBye/htOM+o71aGvJ4wbIaLuXmJHiYpky7P2QAyZchh4qqqND
         qZTM3PcOoicYlK6/z2qaVor5oFwDixUZwzW/GM1r8JiBMQ/Fcds5T8wuPZXYiR1E62vb
         p68W0JDW5lH3nMtogH4i+jif7qKCjrGU2wW8H4XEFHVHuTFgoVZgnSrlIsEav7mz57IZ
         bhIQDVABcSJ0ILsolW2V5kC8nMDZI4qe9xsgv8l63Iso17WTh+vCg6SF9ivkIrEYnk/5
         F8/g==
X-Gm-Message-State: ACrzQf171AZ72BsJl5H3eXdweNoC/ZgQmkwhoCts3rDFw1eQEAPtb2Jd
	KURkb0qgF9DMO781BD2QrIv1mWd6YMc=
X-Google-Smtp-Source: AMsMyM4CQyqImnRAgLyiLMe4xBEITRp0x+eEr7vpkLte1L+6AalLbUWb/DnSEZHx3Iek2lHEvYR6Aw==
X-Received: by 2002:a05:6000:1882:b0:22a:f402:c975 with SMTP id a2-20020a056000188200b0022af402c975mr12162363wri.532.1663752617250;
        Wed, 21 Sep 2022 02:30:17 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003b47b80cec3sm2346614wmq.42.2022.09.21.02.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:30:16 -0700 (PDT)
Message-ID: <2486c749-6583-d374-03c0-4371ac58b08e@grimberg.me>
Date: Wed, 21 Sep 2022 12:30:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/13] nvme-fc: keep ctrl->sqsize in sync with
 opts->queue_size
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_023019_257898_E4282D10 
X-CRM114-Status: UNSURE (   7.33  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

