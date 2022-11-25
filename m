Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5283C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Nov 2022 05:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBCy9qp7TSwSwGwI/krp6oqH0EI9xTeC+ExI/AlQHzg=; b=hSWPgrxX1+/D8qW2Yd3tyHUX1L
	j/d/AWsAlvC2/TW5yiiwKfAsrHWHWjPSSbkLDXlWErrxeP8uOkxcp1ujhic0h2mZuYW4+9xWe6MHA
	qE6zu+ASB0mtKvQukpbOhJvKNygReqmDfVXtoIzZyTcMoe/eEipQlLs0X4Km7duftndKSh5qDYC3J
	F2Kpxj4+dtfTS+eqvdI6x8DMxfp1BCdBCTba9EHujciPMYFZyPdROq1oJmtJckuJntAuoYgOCktN0
	Dvd6cbY9yTO1I01mVZ0dGFNAw6hBG4mzKOsy5AswMbEXD8iGgPU6W/kyAMbNjuZiLvr8A/vq1lk+V
	TouenK9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozWR3-00GEMC-Cx; Mon, 28 Nov 2022 05:12:05 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyiTW-002xDg-Oi
	for linux-nvme@lists.infradead.org; Fri, 25 Nov 2022 23:51:20 +0000
Received: by mail-pj1-f52.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so8912969pjk.1
        for <linux-nvme@lists.infradead.org>; Fri, 25 Nov 2022 15:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBCy9qp7TSwSwGwI/krp6oqH0EI9xTeC+ExI/AlQHzg=;
        b=u4BpkZtzo0DiVkr+6NqBQt/oW8gTYI+dztYPrOiLhRrD0XbrOxh6wJnHS1rg1vBTJN
         fH4zPY6tf6d+tOYBQZTRyLLvdiVHXPV7cJaZx3E1+L9q8QTPapWkQIMxwOgT/+ePv+qE
         31DTCod5dSz6+47IYKEL9SQ7F9kHetTmJjk4bDmqIl83EPk3znCES+aD9CwSIfTz/gaJ
         34yzLqz4JlaHvefLl7UamlS/kfj52u6Yq1C/RAye2p+4RADhUmvCGVOFyLznxUKUlxoI
         gzuIZK2M41HLLHBX6kP2PijAup93rHRYnOn7U6ZmjwfJRyzeGW37+wxWhiq8TZFuqf+z
         ATXA==
X-Gm-Message-State: ANoB5pnulbK8oZcZDH65MdKktphCTJ3N+KG5fyHNxWRU8Mc1Vgr4b6jD
	Qy3Gs80ATDDDhDpAy/yZHrI=
X-Google-Smtp-Source: AA0mqf40CELg5Cd4cKADSnuQ7zDvszL+QjMGY2dYDbM8qR4FVWtlF2gM/wXRLECZg2wkT9gOazTizw==
X-Received: by 2002:a17:90a:b88c:b0:218:e1c1:b4f3 with SMTP id o12-20020a17090ab88c00b00218e1c1b4f3mr15351878pjr.201.1669420276891;
        Fri, 25 Nov 2022 15:51:16 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090311c600b001865c298588sm3937409plh.258.2022.11.25.15.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 15:51:15 -0800 (PST)
Message-ID: <d448b944-708a-32d4-37d7-0be16ee5f73c@acm.org>
Date: Fri, 25 Nov 2022 15:51:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] driver core: make struct class.dev_uevent() take a
 const *
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russell.h.weight@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Johan Hovold <johan@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Karsten Keil <isdn@linux-pingi.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Sebastian Reichel <sre@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Raed Salem <raeds@nvidia.com>, Chen Zhongjin <chenzhongjin@huawei.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Avihai Horon <avihaih@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Colin Ian King <colin.i.king@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jakob Koschel <jakobkoschel@gmail.com>, Antoine Tenart <atenart@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Wang Yufen
 <wangyufen@huawei.com>, linux-block@vger.kernel.org,
 linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221125_155118_853968_8147DF5E 
X-CRM114-Status: GOOD (  15.34  )
X-Mailman-Approved-At: Sun, 27 Nov 2022 21:11:51 -0800
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

On 11/23/22 04:25, Greg Kroah-Hartman wrote:
> diff --git a/include/linux/mISDNif.h b/include/linux/mISDNif.h
> index 7dd1f01ec4f9..7aab4a769736 100644
> --- a/include/linux/mISDNif.h
> +++ b/include/linux/mISDNif.h
> @@ -586,7 +586,7 @@ extern struct mISDNclock *mISDN_register_clock(char *, int, clockctl_func_t *,
>   						void *);
>   extern void	mISDN_unregister_clock(struct mISDNclock *);
>   
> -static inline struct mISDNdevice *dev_to_mISDN(struct device *dev)
> +static inline struct mISDNdevice *dev_to_mISDN(const struct device *dev)
>   {
>   	if (dev)
>   		return dev_get_drvdata(dev);

Why does the dev_to_mISDN() function drop constness? I haven't found an 
explanation for this in the cover letter.

Thanks,

Bart.


