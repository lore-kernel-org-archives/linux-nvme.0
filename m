Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B7EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YcM2V9lJrQoILVWR8hE1O3AxcExnhJbF35MwvFVRNF0=; b=HOcnA7Wko8K1YIRyX0/0jBGE6v
	Mhxw0WnhiUcxg5HtfwOpsfSqHQJFTxQ5NUYXbCbitraug4S8FVnoYeXDsWEDPHdysY8dbPF8AriP9
	ZIE2wclyiDTdjOjoFofauf4UM0kabWk7PJSkeB7MsjVSSBCY8YkUx1E1IKFNoYeJNGYnIEe588yMY
	Ci2R6PFdSl2QqLwMPFvFGphccpeV7ufmr9FeP16aEchLYM7h1uS12okojSZF97AFvfwTBzhJEr0HU
	SjO73aQzD0Pj1LUMyrmD0TiGCNdkeWRRwcIwkps46P5pHZO6XJdgsUY7mKGeBaj1nK5IANxpoUo5q
	5BqetRPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntCWf-005VBw-Gi; Mon, 23 May 2022 18:11:29 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntCWc-005VAo-OP
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 18:11:27 +0000
Received: by mail-pl1-f169.google.com with SMTP id m1so13812433plx.3
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 11:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YcM2V9lJrQoILVWR8hE1O3AxcExnhJbF35MwvFVRNF0=;
 b=zFPr9pCqKSSKEokJ07gJb8lINfj9gTjFxbVNmT/XgImC2wxNJrnNmFkEVpCBPos++c
 0qN6Prr1nCjwRzIs3Pk+lBhbw9khYQTdzBkK25ESPeXgTIBNeGohs0MsBfI2Lh1qD5/3
 aLwlZLSLQkYWu1WWaEska1NRwwWsSJBJD8m0cD2Lpwson8FzLUnOLva7OajkeKYT2T/I
 jXFz0iOmAvY/0AuSW4+/qImIQmq2l60Y+t12Tvtni+inVKvBFi0fzBcxyway4JCiHZz0
 jNoKOKaOHp+SrRvfaG5FhR48l6ijyDv77bhCAvN+U6P34iIW26aIqSLER9J/MK8dZ+UC
 8TVw==
X-Gm-Message-State: AOAM533E0Z6ixtcsZpPRH5yB4J7ejUchstcODLln+4MjsUQ7qt6/a6Uw
 ZbzMJsiv3ko4E8F909NQ3nU=
X-Google-Smtp-Source: ABdhPJyM/CwxpvBVN9kqgJt3dUJYAsl5xQQzoLnJApp0k9u48+L0bdeBCHhzQQ+qLqqg/d0Knkk4fQ==
X-Received: by 2002:a17:90a:8807:b0:1df:78c7:c215 with SMTP id
 s7-20020a17090a880700b001df78c7c215mr247975pjn.234.1653329485047; 
 Mon, 23 May 2022 11:11:25 -0700 (PDT)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a654143000000b003c14af50610sm5025690pgp.40.2022.05.23.11.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 May 2022 11:11:24 -0700 (PDT)
Date: Mon, 23 May 2022 11:11:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, snitzer@redhat.com,
 damien.lemoal@opensource.wdc.com, hare@suse.de,
 Johannes.Thumshirn@wdc.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, dsterba@suse.com, jiangbo.365@bytedance.com,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com,
 linux-block@vger.kernel.org, jaegeuk@kernel.org,
 Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v5 6/7] null_blk: use zone_size_sects_shift for power of
 2 zoned devices
Message-ID: <20220523181122.3vjizmsx7a2mpf6z@garbanzo>
References: <20220523161601.58078-1-p.raghav@samsung.com>
 <CGME20220523161612eucas1p102a76ba431c934230309042521018915@eucas1p1.samsung.com>
 <20220523161601.58078-7-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523161601.58078-7-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_111126_829843_F2BDF787 
X-CRM114-Status: UNSURE (   8.98  )
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

On Mon, May 23, 2022 at 06:16:00PM +0200, Pankaj Raghav wrote:
> Instead of doing is_power_of_2 and ilog2 operation for every IO, cache
> the zone_size_sects_shift variable and use it for power of 2 zoned
> devices.
> 
> This variable will be set to zero for non power of 2 zoned devices.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

