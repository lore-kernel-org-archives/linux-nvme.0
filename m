Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CB9C19F2A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/8nr848GRaOG+Fxstqzc9TigPNxYkNf2h7q9hGBHq8=; b=I9dcwvdMkgpyzbdK8cMTd05zxT
	na5Gzuje54lX2xjF/fI9Qvbh2Gy+k+sCTvuDOjNkfKZjJ7gz0LDN23Lu6h1SlPG1GQCiLJiYphvox
	/kMYFJZqrY0lquLVpnvfSUT3EQ+48zA5fCypNJ084AMcrb+JQIl6ek88j+MCQI9ReVPdb5GPy9lAh
	uZrAFS3Hz2fm7iBCe0MvqTpoVhuTYUAokRmgmcrZVIWzyhvh4zrJp9qQh69scXNAMUhYs4FtQMifk
	FR1DL6n/VF+EpuJqYn3rnDqCdMdOHd+Mra8ACpZGBDt+opzCnmZGVjOB7FkwxD+0RATpxJwZn6vw2
	Td64d9ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJI64-007tdU-GO; Wed, 03 Aug 2022 17:23:52 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJI61-007taQ-0f
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 17:23:50 +0000
Received: by mail-pg1-f182.google.com with SMTP id bf13so15687454pgb.11
        for <linux-nvme@lists.infradead.org>; Wed, 03 Aug 2022 10:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0/8nr848GRaOG+Fxstqzc9TigPNxYkNf2h7q9hGBHq8=;
        b=XH/JvabQviTuhBzQwy+28VVAau46ETEl7EE4Nh20/M621DMQArGaqijnBTurFhVpej
         nxTUKsW+Lgo+pFFjJ0ps8snOl8Ji48gv99uFbsRJ/NpSpQ96P5l4mGnFffrgH/aYRkSz
         8+xQXjEdjvMJMCyDLbo7rnUNbsRRcqn417PVtibLXayHBe/aohXNOX/aAwh6arTBHSPn
         sYvc5uY+JjObU1YyZtdsACXEFJzWnOipPk4edkI00VGIK0qsBHSkJ7XEjuDiIiFlzwdz
         wVA0uXYJFkUrr31m60YZAR0O/pIi69q3TP6zQiwX6DAo7I8x684nGuU+XX7yKOEzRJGn
         /KMw==
X-Gm-Message-State: AJIora/GpUII73Cbw4jfklFD0Wg8AVwS0/msmZGD0k2DU4yZg8HuIl9o
	oIALGAcwax3didysRAQYaPc=
X-Google-Smtp-Source: AGRyM1vgZohnjas8fupQWk0TGJ1ujqQbQ0c9VjCzhrzKOA3JUzR8cBuYkbzDzRvd/ngCVEXerrSzcQ==
X-Received: by 2002:a63:4f52:0:b0:41a:3744:d952 with SMTP id p18-20020a634f52000000b0041a3744d952mr21509471pgl.186.1659547427197;
        Wed, 03 Aug 2022 10:23:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id c25-20020aa79539000000b0052dfe83e19csm3180967pfp.16.2022.08.03.10.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:23:46 -0700 (PDT)
Message-ID: <4b6f14a1-2a96-da20-d56c-032a87dee7d2@acm.org>
Date: Wed, 3 Aug 2022 10:23:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
 hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094812eucas1p271cea804453d9dd379b919067fe5b154@eucas1p2.samsung.com>
 <20220803094801.177490-10-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-10-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_102349_090966_D1A3C371 
X-CRM114-Status: UNSURE (   8.87  )
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
> -		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
> +		if ((bdev_offset_from_zone_start(md->disk->part0,
> +						 clone->bi_iter.bi_sector)) != zwp_offset)

If this patch series needs to be reposted, please leave out the 
superfluous parentheses from the above statement.

Thanks,

Bart.

