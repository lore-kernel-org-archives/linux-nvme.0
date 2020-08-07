Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF1C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 01:21:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE33E206B5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 01:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tMBWzPmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE33E206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V4dt+grdypUsCq0uAHyggDYLAjpnvXMOb4ricY21WXk=; b=tMBWzPmMSkj9AvQPMr0FNWbCb
	Vq9ZT+bsjiEneQlX/trdgbgtF+8Gx6ELLaS1POVqBT8JiDMBJJKh8zLSyg/rrYpXa7RWW+4md9a94
	uuT1/ZFHI/VpDyc9izpAAsX43G3uBiF+KfhHALrr9CyllBB56/BcfTusNG/rKfb+yb0PjRIAMN9vg
	+N6eOra7JswBQ2VrdSY5XBpy8mnSx3rTuhmWlwBc9xXCAmF5LakdBPXeov85lrU+j+pQODr7oYI77
	TWMJ89VjMIVslkqlkjsDTbhlCi8aWEWISkXfS7aQ2hQAL02/tsadIFNjhPj1RjBp1B3f07CvhHclx
	AtCjipQQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3r4M-0003cL-KH; Fri, 07 Aug 2020 01:21:14 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3r4J-0003bc-Ao
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 01:21:12 +0000
Received: by mail-wm1-f68.google.com with SMTP id d190so313796wmd.4
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 18:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=daG516BDPGkR6eCXIiwBJwkG56zv/pww0gKw6DNtmTs=;
 b=MQe5r1iSK5mhSKAfJXr5HxMSGSt205rHRhSPA1HNjHb0otplzAhLBs3B4J8W9PwBUa
 nm2ALJnwDNtzvcmMea+2Z4eM2J8rCbcLxWSD5ociO8Xx7kSSUT/6RO6oK5A5E1rEZZM8
 aLp5q3w6Z1s15RVN6+3e/nAYMAVtJtQweuVvMRcY/f9dh5zxaj/M8cSiz49lSXFfV18u
 D2AAGkRGU5c3QHq79Iz9QX8c8hQk+gO14QZDvVQXmbSuhK3ak975JRSbbMUo5KP7T93T
 TPF5fwpDs0zTWBmSGndD08enZZ8/9BkmqCRO+5JpI5uK5BIsqYG9rHsIvlibe5+oqyA+
 gHEw==
X-Gm-Message-State: AOAM530MdVr3RAP+T11YeaYKSdbVHiYHuQ3pjSM1NFiaF/U1EXnMx7K3
 Q2AC18E1hBKmORisQQgKB4o=
X-Google-Smtp-Source: ABdhPJxUPTEW8+UUWxpbNGdzZJwSd6n3twXpuwdu/6EIkAcS/xBXWnG/8oOhDfWoXXIxIRHzdJJo9g==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr10782451wmg.39.1596763269997; 
 Thu, 06 Aug 2020 18:21:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id x4sm8770226wru.81.2020.08.06.18.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 18:21:09 -0700 (PDT)
Subject: Re: nvme: restore use of blk_path_error() in nvme_complete_rq()
To: Mike Snitzer <snitzer@redhat.com>,
 "Meneghini, John" <John.Meneghini@netapp.com>
References: <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
Date: Thu, 6 Aug 2020 18:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807000755.GA28957@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_212111_468740_8C165CF3 
X-CRM114-Status: GOOD (  32.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Ewan Milne <emilne@redhat.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Mike,

>> The point is: blk_path_error() has nothing to do with NVMe errors.
>> This is dm-multipath logic stuck in the middle of the NVMe error
>> handling code.
> 
> No, it is a means to have multiple subsystems (to this point both SCSI
> and NVMe) doing the correct thing when translating subsystem specific
> error codes to BLK_STS codes.

Not exactly, don't find any use of this in scsi. The purpose is to make
sure that nvme and dm speak the same language.

> If you, or others you name drop below, understood the point we wouldn't
> be having this conversation.  You'd accept the point of blk_path_error()
> to be valid and required codification of what constitutes a retryable
> path error for the Linux block layer.

This incident is a case where the specific nvme status was designed
to retry on the same path respecting the controller retry delay.
And because nvme used blk_path_error at the time it caused us to use a
non-retryable status to get around that. Granted, no one had 
dm-multipath in mind.

So in a sense, there is consensus on changing patch 35038bffa87da
_because_ nvme no longer uses blk_path_error. Otherwise it would break.

> Any BLK_STS mapping of NVMe specific error codes would need to not screw
> up by categorizing a retryable error as non-retryable (and vice-versa).

But it is a special type of retryable. There is nothing that fits the
semantics of the current behavior.

> Again, assuming proper testing, commit 35038bffa87 wouldn't have made it
> upstream if NVMe still used blk_path_error().

Agree.

> Yes, your commit 764e9332098c0 needlessly removed NVMe's use of
> blk_path_error().  If you're saying it wasn't needless please explain
> why.
> 
>>      Fixes: 764e9332098c0 ("nvme-multipath: do not reset on unknown status")
>>      Cc: stable@vger.kerneel.org
>>      Signed-off-by: Mike Snitzer <snitzer@redhat.com>
>>      ---
>>      drivers/nvme/host/core.c | 9 +++++++--
>>      1 file changed, 7 insertions(+), 2 deletions(-)
>>
>>      diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>      index 6585d57112ad..072f629da4d8 100644
>>      --- a/drivers/nvme/host/core.c
>>      +++ b/drivers/nvme/host/core.c
>>      @@ -290,8 +290,13 @@ void nvme_complete_rq(struct request *req)
>>                      nvme_req(req)->ctrl->comp_seen = true;
>>
>>              if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
>>      -               if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
>>      -                       return;
>>      +               if (blk_path_error(status)) {
>>      +                       if (req->cmd_flags & REQ_NVME_MPATH) {
>>      +                               if (nvme_failover_req(req))
>>      +                                       return;
>>      +                               /* fallthru to normal error handling */
>>      +                       }
>>      +               }
>>
>> This would basically undo the patch Hannes, Christoph, and I put together in
>> commit 764e9332098c0.  This patch greatly simplified and improved the
>> whole nvme_complete_rq() code path, and I don't support undoing that change.
> 
> Please elaborate on how I've undone anything?

I think you're right, this hasn't undone the patch from John, but it
breaks NVME_SC_CMD_INTERRUPTED error handling behavior.

> The only thing I may have done is forced NVMe to take more care about
> properly translating its NVME_SC to BLK_STS in nvme_error_status().
> Which is a good thing.

I don't think there is an issue here of mistakenly converting an nvme
status code to a wrong block status code. This conversion is there
because there is no block status that give us the semantics we need
which is apparently specific to nvme.

I personally don't mind restoring blk_path_error to nvme, I don't
particularly feel strong about it either. But for sure blk_path_error
needs to first provide the semantics needed for NVME_SC_CMD_INTERRUPTED.

...

> Anyway, no new BLK_STS is needed at this point.  More discipline with
> how NVMe's error handling is changed is.

Please read the above.

> If NVMe wants to ensure its
> interface isn't broken regularly it _should_ use blk_path_error() to
> validate future nvme_error_status() changes.  Miscategorizing NVMe
> errors to upper layers is a bug -- not open for debate.

Again, don't agree is a Miscategorization nor a bug, its just something
that is NVMe specific.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
