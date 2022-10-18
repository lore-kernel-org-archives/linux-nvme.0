Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC49C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LGWzhkcCbHT/GlYan3Eun+hEJiWxFq+Aa5m4bxdGa10=; b=2FC21eTq4S+tUklUYopVBnUXAD
	XBc3KPEeJVdyn/aVuhfODE/LwzBluQ+nPuparEGpUfawflyiYU9fokj+uLBzgaJV6Y3Gj75P+ZpJ6
	cVcEjW0Xw/OPZW27dbWdMRjQvei4CqNNSGBu6VatEKw+yw922yZn+7IZNqm1jPaAC/PSe8rnstBKn
	NcJ4igIMXxDJggfKMZVmXlNjilEora0vxcVq1TdKLYamODU8xQ5NA6zK3Wif/ijYoPdmQqFa/vBI3
	ga8ZkjAnVIH2KyZ0tHmX/A8GmHtGXFTbYeCqMzDf2Z2hNU217QYVBuVIdjmMjHBYomM2NBX0Yk1h0
	xwl2krkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okkI9-005p2R-Ul; Tue, 18 Oct 2022 10:57:49 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okkI6-005oxV-KN
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 10:57:48 +0000
Received: by mail-wr1-f53.google.com with SMTP id bu30so22838938wrb.8
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 03:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGWzhkcCbHT/GlYan3Eun+hEJiWxFq+Aa5m4bxdGa10=;
        b=fKdDYw9sDLzwilL8iglMOn4kpZyxaDDQRU3GOYHgVSTtu1QaKYRWnsBT0U3+NeOioe
         r6uss5kmRh1Z5EnUHBZFIdXcWMpRSgTgQmE0xUOceU0C1q5D79qxVUL9Wbm0DIqsVte5
         9J9NZ97PP/WYPoYcUecSt01QDa+RRMIpWISlsbVw6cK0mBKZVov3uYqFoZ9fKl3MxWuQ
         DM6HBM/JV1rezpEjCFPItY0JfemBQ+VqVwlc7jmyD2PTUZkZK4cACFeHkJgXxigmXskF
         7h3aLuGYHnusCJdPNMdw3cWlzV5sevwq/H1NWGX+db4jdjR2yClrC0BXpyR+Oq8WR8Tt
         TQ3g==
X-Gm-Message-State: ACrzQf1Q3UBab3o3NBLwjfazL4aqQpyGACMZJ+MshOq3Y42KJ876fZXB
	ZS1cgptjg1LiGT866S2c/xuyQrytFDA=
X-Google-Smtp-Source: AMsMyM4nTl4e6OEpC9DtTiTFq51+1xbsCSqV+V5tStWZIkdIL5U/+Iyczs+srvqA9L7q1grhRSjdbA==
X-Received: by 2002:a5d:46d0:0:b0:22c:de2a:23e with SMTP id g16-20020a5d46d0000000b0022cde2a023emr1595429wrs.12.1666090663383;
        Tue, 18 Oct 2022 03:57:43 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bi20-20020a05600c3d9400b003b49ab8ff53sm12697687wmb.8.2022.10.18.03.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 03:57:42 -0700 (PDT)
Message-ID: <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
Date: Tue, 18 Oct 2022 13:57:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: bad unlock balance WARNING at nvme/045
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20221018080350.zir6xm6dnr4wgb7j@shindev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221018080350.zir6xm6dnr4wgb7j@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_035746_693756_652A1C5A 
X-CRM114-Status: GOOD (  14.44  )
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


> Hello Hannes,
> 
> I observed "WARNING: bad unlock balance detected!" at nvme/045 [1]. As the Call
> Trace shows, nvme_auth_reset() has unbalanced mutex lock/unlock.
> 
> 	mutex_lock(&ctrl->dhchap_auth_mutex);
> 	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
> 		mutex_unlock(&ctrl->dhchap_auth_mutex);
> 		flush_work(&chap->auth_work);
> 		__nvme_auth_reset(chap);
> 	}
> 	mutex_unlock(&ctrl->dhchap_auth_mutex);
> 
> I tried to remove the mutex_unlock in the list iteration with a patch [2], but
> it resulted in another "WARNING: possible recursive locking detected" [3]. I'm
> not sure but cause of this WARN could be __nvme_auth_work and
> nvme_dhchap_auth_work in same nvme_wq.
> 
> Could you take a look for fix?

I'm looking at the code and I think that the way the concurrent
negotiations and how dhchap_auth_mutex is handled is very fragile,
also why should the per-queue auth_work hold the controller-wide
dhchap_auth_mutex? The only reason I see is because nvme_auth_negotiate
is checking if the chap context is already queued? Why should we
allow that?

I'd suggest to splice dhchap_auth_list, to a local list and then just
flush nvmet_wq in teardown flows. Same for renegotiations/reset flows.
And we should prevent for the double-queuing of chap negotiations to
begin with, instead of handling them (I still don't understand why this
is permitted, but perhaps just return EBUSY in this case?)

