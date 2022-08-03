Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B175FC19F2C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TwJQ/yYNiTQ3gXYdp9ajvzFbzU+GLcBJYBbzELtb76o=; b=zxlhyWdWctr1bn+8mlzMBdCZMs
	fHKVQ/vrfXYak6aXqizNVTLPYkZ0N4FckjpIJzTkkDbnsbejY7LYsdjkfw7csEjGqrwyqFxlq2CdD
	41pl6p8yxckGyenAU58gZZLcEO01CLc8DYkfgVuoJpO3sqGFjyKFbmtCqK0bsqHcutRAAjlTppLzx
	RjTBppCbe0o+sxKRf2qVzhFQLt8U4ps2XRH/vwGO9bqde7UUfF2urHWoE5gLDC6qSh1farRljW30R
	FNXEHKdsJekDGVTCMU+okN8pb221Z8oPQu2xT1TiH49XvXDncws8WAjqRFNHom+kisLsmXSqMCuB+
	v6iJEp6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJI1H-007rDF-7A; Wed, 03 Aug 2022 17:18:55 +0000
Received: from mail-pg1-f174.google.com ([209.85.215.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJI1E-007r7q-Hn
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 17:18:53 +0000
Received: by mail-pg1-f174.google.com with SMTP id q16so15696012pgq.6
        for <linux-nvme@lists.infradead.org>; Wed, 03 Aug 2022 10:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TwJQ/yYNiTQ3gXYdp9ajvzFbzU+GLcBJYBbzELtb76o=;
        b=fqFbwYVfPhrntZDJbvEg/sKZT7XQq4xCKBJi1lp+O5kkDoiE0GaiOfukwFYi3QW4Fe
         AQbeMkBJsrt1q8kvyOlrpk4MGCu/nbEtOEJRU3U/9Wh2MGW4FjUDXLlWh+2PgVpgBivF
         KI5zm5KY6JT8cQBi7+tFENLmsaamqmFWIZ5bYYrKIsY8tArAXYauSP809HZeKR7vpnlO
         HwFJsbNfNf2vt4MSq3EQcQ9OwE65sSF7Z44TwTy1lHj4dVoQKxbmuc0TLHwgJdX0Kb0h
         jZAoDQnb9J+9TWNoF+jgMpPmQ8BYcZNiaSjZf1hn9R4mtdJ8zAziueiFM8z8fF18pq3f
         fvFQ==
X-Gm-Message-State: ACgBeo3es8ey2lBMUBpxYmm3WmcSNKH9ghqp63gzTjGsXylON6GfM8+o
	jXbqptyDpa2C3tW4CanW1vM=
X-Google-Smtp-Source: AGRyM1ut0iw8ACYHFdssYF1RXnkAJwY8ims1WoIWh5sfrKcVetqVvRyv8YyN43reQB04YYQHCbVNEQ==
X-Received: by 2002:a05:6a00:3392:b0:52b:4896:b317 with SMTP id cm18-20020a056a00339200b0052b4896b317mr27047195pfb.17.1659547125023;
        Wed, 03 Aug 2022 10:18:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id d81-20020a621d54000000b0050dc76281f8sm3824637pfd.210.2022.08.03.10.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:18:44 -0700 (PDT)
Message-ID: <3dd40197-776d-9003-3c8f-1791587ade0b@acm.org>
Date: Wed, 3 Aug 2022 10:18:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 03/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 agk@redhat.com, hch@lst.de
Cc: pankydev8@gmail.com, gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, jaegeuk@kernel.org, matias.bjorling@wdc.com,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83@eucas1p1.samsung.com>
 <20220803094801.177490-4-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_101852_629959_0D17909D 
X-CRM114-Status: UNSURE (   9.01  )
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

On 8/3/22 02:47, Pankaj Raghav wrote:
> +		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> +			pr_err("%s: Invalid zone capacity: %lld with non power-of-2 zone size: %lld",
> +			       disk->disk_name, zone->capacity, zone->len);

If this patch series needs to be reposted, please leave out the second 
and third colon (:) from the above error message. Once this comment has 
been addressed, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

