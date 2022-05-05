Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DAFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JN+xXTcXNI1SyQdyI2kigTtC7Mc8qGqky6/c8LUyqPI=; b=mtol1TrSrrU0jcH6dacUaGgNo5
	o+bAYSx/DGghaqtksT0ftl49sijD1QyjCUb3fXunMEk+mJLnSC9nglothRJyU+Gbb3RvleZxztdS+
	lbMvTnA6loSanbxfC/d9ctopocxkv7JMEN++4/m1Wn7tOLEcmGZLfzJCsR57yFcx+NUDPy2WQOTnI
	PxOM4xOra9/+yJMc/MABwnVMPTKIeBcHTS39o5FXI4ZaTtMwA9eS8O07phk0F+4di4EStvcXwUyQh
	tOKA/+LvhK4UciKzTmF6z/FedkZBq+OPsLYVt7DGipGDXwZqRRfoRV8Lc0rrZftUqYKkAfmAwUabC
	wdvyjfbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbsS-00GAKs-Mr; Thu, 05 May 2022 13:50:44 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbsK-00GACD-Td
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:50:41 +0000
Received: by mail-pg1-x533.google.com with SMTP id a191so3690515pge.2
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=JN+xXTcXNI1SyQdyI2kigTtC7Mc8qGqky6/c8LUyqPI=;
 b=sMX1x0FOSqCQ5fwTbC8sa8yqgSZw+NCBuTwq89nRJYLp5Ok8YnjnJGRR/0JLOFvlwF
 eROU8L2DNxS/AN9N+mqjG2KtLVSopEEutSsa103FBGKQyy47DiJlwQH+CbozkbGytSS4
 WGjQXhfzzIXV1JerUSQrfUBl8OpjVw/OVVNPd1XW4v9m1UY+Sq3kAVgEEm7cIUX09CVx
 ZStA14QfTkamZP46vRI2i25gze3aZON7pZio/gFAmYyTmEijfDxcVgYYclGusX2yEw15
 WKTG7UvFHuOMt+cBudo1CGI8X8gxmH4ebwgKqAnO5aulHWhZQblALx69RqWUDSfy0gHi
 7J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JN+xXTcXNI1SyQdyI2kigTtC7Mc8qGqky6/c8LUyqPI=;
 b=4d8dyQ9rKJ6GxfFUypJrjHUL/KqEI99At2sqsMjDlLPzjm72YfZuHv/9brCwdyg90+
 6eIaaPVhKHwk//odWd/5ghco3tY4SFlUXu01ZjYMqOQRV0kEss7pDP126/t0pv8sTUft
 ztZ9mU0pRHdw+u5NdjUIwae3mshzXPsfzYPBaPuSCWgcnjQi9EjNCK3Ijgu9XNTpMYDL
 fboVzmM/W1hGBNuoSgXUXE8kqRc9ScgsMgrwcCKHe9rrEICzeFzgMisj9yGWrAHBeEJ7
 PyzxB2wolytDN8xkVEj0xdpIA751DoZghIn1fLAE+esmaX6zPgSfKD82CA+ZY/3fyUBo
 xtSQ==
X-Gm-Message-State: AOAM531y7Pm4JbE8ASHnRfuKSDLFMbu82Dw4/Q3enu4cuNA1qV8qF5kz
 h0U4P5FkuFItHEfpY+vbCpQOhQ==
X-Google-Smtp-Source: ABdhPJwZt576fLb0sJ0OdV9w4RTCCVR1xxIPiA25Xfu7jLkSBnypVvl97pddAxh4FVWV1jKdHpcXCw==
X-Received: by 2002:a05:6a00:1352:b0:510:4c0e:d230 with SMTP id
 k18-20020a056a00135200b005104c0ed230mr6545078pfu.79.1651758633359; 
 Thu, 05 May 2022 06:50:33 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a170902821100b0015eab1b097dsm1567880pln.22.2022.05.05.06.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 06:50:33 -0700 (PDT)
Message-ID: <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
Date: Thu, 5 May 2022 07:50:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru on
 char-device.
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com, ming.lei@redhat.com,
 mcgrof@kernel.org, shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
 <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220505134256.GA13109@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_065037_038657_FA9BE665 
X-CRM114-Status: GOOD (  15.52  )
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

On 5/5/22 7:42 AM, Christoph Hellwig wrote:
> On Thu, May 05, 2022 at 07:38:31AM -0600, Jens Axboe wrote:
>>> +	req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(cmd->addr),
>>> +			cmd->data_len, nvme_to_user_ptr(cmd->metadata),
>>> +			cmd->metadata_len, 0, cmd->timeout_ms ?
>>> +			msecs_to_jiffies(cmd->timeout_ms) : 0, 0, rq_flags,
>>> +			blk_flags);
>>
>> You need to be careful with reading/re-reading the shared memory. For
>> example, you do:
> 
> Uh, yes.  With ioucmd->cmd pointing to the user space mapped SQ
> we need to be very careful here.  To the point where I'd almost prfer
> to memcpy it out first, altough there might be performance implications.

Most of it is just copied individually to the on-stack command, so that
part is fine just with READ_ONCE(). Things like timeout don't matter too
much I think, but addr/metadata/metadata_len definitely should be
ensured stable and read/verified just once.

IOW, I don't think we need the full on-stack copy, as it's just a few
items that are currently an issue. But let's see what the new iteration
looks like of that patch. Maybe we can just shove nvme_uring_cmd
metadata_len and data_len at the end of that struct and make it
identical to nvme_command_command and just make that the memcpy, then
use the copy going forward?

-- 
Jens Axboe


