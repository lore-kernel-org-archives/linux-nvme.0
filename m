Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374D6C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20w6k18SJj0RfVgFiS/8NKa42+kOVNPQ/C83hP/ofr0=; b=nqBvTGtEaXtTw7k1A9NlncJQ6S
	KtdjcmPscdIXdD1f3nifSms38RXhnJ72fOOaiRcD1L9aMSrDjxyppHZm/IPZwfgmty85ZOqTVPH2t
	Xr/acBU6vCjIELpKyTyoUQ2pmIad8VYyo1lpzm502qLOzYQnui5U8rGFgKKQg02MEv/gVuDXsyX+u
	g+LRC6hlK1+VP8YQX+8nfGLnr9hGFk0yeQTCHtAQ3+AMqGZezhVYG0Z5IB+3ZnvoSdNQAMz5KPVg0
	S2xSo8TsQswFe/k7JGCmMhNud/rMXOEe378nwj8SKT5LAd+0SxQHQkeDXZIi/lYR3+Zd3UPY6hRg3
	kxB/iYJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrhtk-007qnW-TO; Thu, 19 May 2022 15:17:08 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrhTl-007ahg-Jp
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 14:50:19 +0000
Received: by mail-io1-xd2b.google.com with SMTP id z18so6009383iob.5
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=20w6k18SJj0RfVgFiS/8NKa42+kOVNPQ/C83hP/ofr0=;
 b=DNXn0jr7JyBHedOeZzOpW3zP5sxW3jVOE60w8B9II1WMREIbloApEJm7dlBKAkz8sp
 AGSR+Ad+V+3bOfDsCvL3Cnkr8q8wk6RpJLGhUyKM7pFOlrLEyYl/XoomtDImAvyouU1L
 RzjG3LO3TA1tsgoCpMMiZVy5fukzKmjBdXlB/qKaMYPTkFoJk2C1wsXe1BWwBGNIWrul
 nV3uavNLciy39xhGBI85IWtUhBx0bceQqY4whWKsdmWbjUTQhc8+S5idXlXnwaolpfyx
 ItWCOtl1dgloks1wOclOY0M1kjLqFCdw/caC+ctHTfvRPr5J3K/PQ+MZWzQEPJHxwAgW
 A/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=20w6k18SJj0RfVgFiS/8NKa42+kOVNPQ/C83hP/ofr0=;
 b=Z/2vqfNN1UF0ZEMOJpY/JxbKBxhBHBVmcze5LGZ8XOLb7P1E7mMSwxVREgAPehZ/W4
 RhSRPMZ6kkVNWA22lQAKfPRFjLG3kSPToCSI9Z7nQJCvPen2LF4Fo37dmxjNewEjEexK
 M74oiobx/sPTTEL8S8TceD0gjQY/tRw7RSyvhK/tAkthZvtc2kOudLF55oJbRNBtpJWn
 lbzm/lYqmgDkKqkZgE0NvI//gKgU6E7XcrVRWMuYQR3SHp0HSJYEqglhpo8dijI9Uvxb
 keJDCXp2nPW9/vXFgYvgyBWbtccjrJTRDwFFT99B3UObPdk/zfoRCkAxktZOjsHPE8XM
 h7cg==
X-Gm-Message-State: AOAM531ACFmD+h4NHED5D0VhZclo6PTCOHt/RQ/Gip/izyhTNlCqfBbV
 iJRG2SfSOKpQSz01e+l1DY1JXQ==
X-Google-Smtp-Source: ABdhPJwgvAg8CW+EYtdlvP4ZzsxnZMMqO3E1Bf/M6lmNcnR0kXrxXR7WCla9APGIq+9FJNXr/I+4tA==
X-Received: by 2002:a05:6638:3802:b0:32e:3d9a:9817 with SMTP id
 i2-20020a056638380200b0032e3d9a9817mr2982578jav.206.1652971814259; 
 Thu, 19 May 2022 07:50:14 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a02cf2e000000b0032e0dab7ff4sm714099jar.18.2022.05.19.07.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 May 2022 07:50:13 -0700 (PDT)
Message-ID: <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
Date: Thu, 19 May 2022 08:50:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Muneendra <muneendra.kumar@broadcom.com>, James Smart <jsmart2021@gmail.com>
References: <20220519144555.22197-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519144555.22197-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_075017_919272_D78E394F 
X-CRM114-Status: GOOD (  13.14  )
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

On 5/19/22 8:45 AM, Hannes Reinecke wrote:
> If BLK_CGROUP_FC_APPID is not configured the symbol blkcg_get_fc_appid()
> is undefined, so it needs to be masked out.
> 
> This patch is just a diff to the v2 patchset, as the original version has
> already been merged.
> 
> Fixes: 980a0e068d14 ("scsi: nvme-fc: Add new routine nvme_fc_io_getuuid()")

Either this sha is wrong too, or it's not in my tree yet the breakage is.

-- 
Jens Axboe


