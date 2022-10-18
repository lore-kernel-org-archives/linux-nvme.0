Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7595CC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 08:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53P1QmYMd8KsBAVxU106S0lFuL+mv2oWPz1hSw9tglc=; b=SPV/QWR3LdLb6Iy/lnmEiDQ6AT
	+T3PufxK+NpJeV6GQHg52R+rNMaD/JqVs89a/mnDULDp9YtXrEinzzUbS6KU03tfMV8+llS5PbRdb
	xSb7jowStZ2CNAFf3TafWWyVmDcRrMpdtoX1xj6+z4Ix6F63YzlhVKO8i6qsPB2yoct6elHbpKnhE
	a7yYwlmb5tD1WwbWU/D3abNdn1uCb6Zi5GaJRZ0WuTFLyJjxnbnJGLgEm/6v3tWQbT4M0b1xByUmO
	M04RwT9sr3dyef5M6X0wTMBpfodT3RriD5AJr3pYMjoXAFnSky21BG/4dsgsXDnMEdSv4rE6bTBA2
	YOjRMsBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oki8Q-004QFP-2C; Tue, 18 Oct 2022 08:39:38 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oki8N-004QD6-Ay
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 08:39:36 +0000
Received: by mail-wr1-f46.google.com with SMTP id bp11so22282980wrb.9
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53P1QmYMd8KsBAVxU106S0lFuL+mv2oWPz1hSw9tglc=;
        b=3SkCAT6KJPiWU8Ew+oxafDSJ9h/qpdd9XtIisB6QyQgnt9G6ltAp+uKG81+urm/4Rn
         XzVTblE9IdYxi3CeUrmcz5yPVyyM2TbTHvKKh7eCHQi/90elRqIkdjC8adbDcAnsuqZY
         B40M05SgJgRJ/sdHBGtVqbT1HInXQr4lUEOQVUOiPmEFJjOe+OE9aktlFps4HsIkRalg
         uQyLp9HQe3lB4VmuU3U+XEtbwtm5LhFPY7OMCSoWAALb38QbLlgOeAw8cdR2cVhulPRI
         M34+qvyuJuTOQNNE/ux2WVFo+GgZxolympuDRAjE05gO04Tgg7gLy47dp9SllqZHrlzJ
         3JVQ==
X-Gm-Message-State: ACrzQf2IaUvRwqa7ZW6MCH41BJde6Ni3YT+uIkkubEcBwRADZpdgt7ix
	I0pOGMpvFbXRwDj4+r4QtvE=
X-Google-Smtp-Source: AMsMyM72mfp97zZTW6OsYczsfJlzaeFM5fpBYqQ6DPClRURwnWfLnHHgojYrblonlTxrL3sYriDrsw==
X-Received: by 2002:a05:6000:2a6:b0:22e:ddd1:d9ff with SMTP id l6-20020a05600002a600b0022eddd1d9ffmr1057677wry.447.1666082372801;
        Tue, 18 Oct 2022 01:39:32 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c1d0600b003a5f3f5883dsm19029260wms.17.2022.10.18.01.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:39:32 -0700 (PDT)
Message-ID: <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me>
Date: Tue, 18 Oct 2022 11:39:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017134244.GA24775@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221017134244.GA24775@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_013935_402297_38D9B10E 
X-CRM114-Status: GOOD (  14.70  )
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


>> Having to allocate a struct rcu_synchronize for each of the potentially
>> many queues here is a bit sad.
>>
>> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
>> last week, so I wonder if something like that would also be feasible
>> for SRCU, as that would come in really handy here.
> 
> Alternatively I wonder if we could simply use a single srcu_struct
> in the tag_set instead of one per-queue.  That would potentially
> increase the number of read side critical sections
> blk_mq_wait_quiesce_done would have to wait for in tagsets with
> multiple queues, but I wonder how much overhead that would be in
> practive.

It used to be on the hctx actually. It was moved to the request_queue
in an attempt to make parallel quiesce that didn't eventually complete
afaict.

For nvme, we never really quiesce a single namespace, so it will be a
net positive IMO. I also think that quiesce is really more a tagset
operation so I would think that its a more natural location.

The only question in my mind is regarding patch 2/2 with the subtle
ordering of nvme_set_queue_dying...

