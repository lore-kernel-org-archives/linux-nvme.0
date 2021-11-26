Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC94C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Nov 2021 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SDwlRdpjTzYPwAhSnbeW857QP4iA06QyXUK+72xmWO0=; b=e5XyOsUpuwoVKuVwjMWvd+UVUU
	QqzLs6zp72Ejo7jHGhHE/tAx0hLvCNBJeWeBEQueU9AXIqYMuRCxnC1Hrnj9gbzty0LL/ecYgv8F0
	cIsdPQBjP2wBniibvi4BY1MJqa7uoRDypygDkIIsleUPGGf8GQ453vxNV65WoHQMEPltP5OS7YOUA
	SpP/QVh+mz0ISAPzmLzCNPyYZ6TikyE5yaDbfR2VnJK4ya59R/bPGzLoxxb3PdUICg8k406Lbdl99
	+PwW3ecqXhxhR6Q/BcbzONYYUEZYUv0dTQyJCYQg4sNkYU3l3Ek8/2qAgDvxL6xr86oWgCC3URtgo
	WZsj6vwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqeTR-00BDDv-L3; Fri, 26 Nov 2021 16:53:21 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqeTO-00BDCw-Mj
 for linux-nvme@lists.infradead.org; Fri, 26 Nov 2021 16:53:20 +0000
Received: by mail-il1-x12b.google.com with SMTP id i9so9692031ilu.1
 for <linux-nvme@lists.infradead.org>; Fri, 26 Nov 2021 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SDwlRdpjTzYPwAhSnbeW857QP4iA06QyXUK+72xmWO0=;
 b=Yl7aflVYIKA8NwiU6HKYQgGI1PRZXflwMsUz1SFWlR4vTCFpRc/dIgxUm6Qxec4nSq
 M0ZAPi9cAnro/JRUdWX3Qn04cLaDsYZgXd46rm9dayPq2OaW3FrWJp07ldoXJH6zhRc1
 9SOecwWh5/D7lKrUqy74GUSElLBhVBekoiIfQLHMTrNcERUhkEWrgdDDefSeQm1cirua
 4BX8ztxr/TiTPi55f95UrWEiNVeGK/iLyzW1Wfpzf6syYSVCy/S6L7GhWxDfiL3smE8p
 U6XkJfsj+S+QvNfjhk1IieB7CyQethVUJYIGmmK27HW7FxkpK0vg790ju5jMqaVYKrjL
 +qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SDwlRdpjTzYPwAhSnbeW857QP4iA06QyXUK+72xmWO0=;
 b=bVlOnihWN7dy1wKDqe/wtIzDPCwMcHDX+8GmI76K7MZhMiNiMWRnlq+jMSMYStOFUu
 mCfVl3tdgcaF0wOLcVMcvG0vGZrGh2L+XTmYYy9QjTRkXR4rekZCNxbaKULIMB8FudVo
 dbBduSpIjFL2ngQN0oBWtKq3Gg1inoUUeSP2Grt+bX3/n3IkmCr9+Dq4PdjwAO4Wb969
 a4JpmUdjc6PhgeA4X9+qxzGmIKofnmUkcvFAX0v1avM/ZC8huGR3Xu314whbhWlkPy6y
 8xPTqky2V2BEdspJZyAm9C5MQ1CyEC1alhrnaB3lqJRTdLEehoilaLQMqKxQ2PF3UoFk
 /P3A==
X-Gm-Message-State: AOAM533DSVw9iMgbLvWs3a2G2Dm1VZWpbK7Ou3kYoGI21qGqc+fPwdj5
 DnA1ptDD/H4irTJ3yIr6cKq4bw==
X-Google-Smtp-Source: ABdhPJzsgw04zJvm5GtiLCxl/tnSLY7FlbjoF4d0/XBEG7n5Y38/jin0OpXq6CLemyKpFpFrUDjbnw==
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id
 h10mr30636080ili.14.1637945596380; 
 Fri, 26 Nov 2021 08:53:16 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id t12sm3192833ilp.8.2021.11.26.08.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Nov 2021 08:53:16 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
From: Jens Axboe <axboe@kernel.dk>
To: "Kenneth R. Crudup" <kenny@panix.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
Message-ID: <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
Date: Fri, 26 Nov 2021 09:53:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211126_085318_856273_3DEE780D 
X-CRM114-Status: GOOD (  13.80  )
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

On 11/25/21 2:07 PM, Jens Axboe wrote:
> On 11/25/21 2:05 PM, Kenneth R. Crudup wrote:
>>
>> On Tue, 23 Nov 2021, Jens Axboe wrote:
>>
>>> It looks like some missed accounting. You can just disable wbt for now, would
>>> be a useful data point to see if that fixes it. Just do:
>>
>>> echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec
>>
>>> and that will disable writeback throttling on that device.
>>
>> It's been about 48 hours and haven't seen the issue since doing this.
> 
> Great, thanks for verifying. From your report 5.16-rc2 has the issue, is
> 5.15 fine?

Can you apply this on top of 5.16-rc2 or current -git and see if it fixes
it for you?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8799fa73ef34..8874a63ae952 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -860,13 +860,14 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		if (iob->need_ts)
 			__blk_mq_end_request_acct(rq, now);
 
+		rq_qos_done(rq->q, rq);
+
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 		if (!refcount_dec_and_test(&rq->ref))
 			continue;
 
 		blk_crypto_free_request(rq);
 		blk_pm_mark_last_busy(rq);
-		rq_qos_done(rq->q, rq);
 
 		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
 			if (cur_hctx)

-- 
Jens Axboe


