Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE2CC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVXu+rteQS86iCuxXHVAWwBavTrAQEhvXfNGezw5HXE=; b=NI0ZmDBPnzGdObBnVIF9jYFEY7
	rYcMuxx7zPMKvZtXKRG4Cc2BZLaW6soJ+5A8DNooRx93u67lI0lvHM834Ot/2cAXgDZ0kpdUjE1jO
	kVDlzxnlJRvDMEabfEqZXxWP2+eyxBQuvUd4Jv/h/FxK5eLMSFR79cIAWx8idx6DiQQveM9IGEoVF
	cf4tWKG2R+4F6TEPE3lE10e+t0KKqXe61M2+ftvphNdZVeBWKldS48RRrDG9G6HyENervkcdHa/xY
	6XhwxljB+CYiIpIDnMM5c5GG1oTkD044bSKYlaIoWRKnzNOmBUljLNDoxUPGhtTUfI5wP8Y71l7cr
	hkCH8PWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzGOl-009p0H-0g;
	Wed, 17 May 2023 12:36:55 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzGOh-009ozl-2y
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 12:36:53 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so1302930a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684327009; x=1686919009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVXu+rteQS86iCuxXHVAWwBavTrAQEhvXfNGezw5HXE=;
        b=F47xH5ZwNk8KAKA4b6HSwJfCK0OF4/0yd4/WBQUHBWc/lfY1sqINI3ZndhSJVrxny7
         Sn5+wHfXOE3XjKyHrgcshVe95+sZ/5rdAJ7cHRBofV729JviZkuQUBEqlADfk8rZMgXu
         TyPDQWaG2eySuRGGDyIy/3glhTyB9iffTU0SHtyuEALraXn8qk4G1b0PoWdFFfYvJ2ri
         n36/1xu9yGZ8iJk6FaaQvBknPlWPqSM0uHg27zbuJ5nwnZbWuX+TgI5+0yIpWh1+c/Fs
         36v+/0PbK7YwviMN8G6/9lf6yfWDbhMEgSZJhAXWVP4I2QNxvw7rY0QM0GJhBKt8HB79
         Tg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684327009; x=1686919009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVXu+rteQS86iCuxXHVAWwBavTrAQEhvXfNGezw5HXE=;
        b=HRz0mx3tOxPmHFr7Tmj7BRXmbSdDI53dMnmZmO0SXReibQ+gytujcrL8fs/YSJwwmi
         8cMAXByLWUhRWInsT7gV4XPrZrt6l2qBlhfiHAde/MdOoiofcHLfPuUXhU77dezNYLHu
         QqqT1OGyJ2+3WUldfZTNg79HdpNrSv1ukzGC8OIr11fjttrsPemdmHAJPZGRAt7QG9Tb
         ICm3BDwUSkRq9EViYGNuC6gM6/9cCHTy7IqOBpuVVS7GjGee1lbc1g3QNF33unWTWgKx
         1v4lflbcDKHzmQREobqlBy8lJC8k7drnerEGGKAhY0bKl9LXnfo0S5vuzUpgx3lUp3Os
         zWHg==
X-Gm-Message-State: AC+VfDzPY/AgZq2s0nsSNWGpdWnIDjIeIc8/rWmXBQ0ow2FGAePJnv68
	WnVoKwB91DVQqCfFKP1lCpI=
X-Google-Smtp-Source: ACHHUZ44IAGSpe4GtBP3SUuJx9YtVd77SXRA1VqkKSXfBkBmXTLZU6+r97naLc7ftpDGJHgB/enaoA==
X-Received: by 2002:a17:907:26c6:b0:91f:b13f:a028 with SMTP id bp6-20020a17090726c600b0091fb13fa028mr32696622ejc.34.1684327008360;
        Wed, 17 May 2023 05:36:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::2eef? ([2620:10d:c092:600::2:46a1])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906845a00b00965cd15c9bbsm12244107ejy.62.2023.05.17.05.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 05:36:48 -0700 (PDT)
Message-ID: <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
Date: Wed, 17 May 2023 13:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, axboe@kernel.dk, kbusch@kernel.org,
 sagi@grimberg.me, joshi.k@samsung.com
References: <cover.1684154817.git.asml.silence@gmail.com>
 <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
 <20230517072314.GC27026@lst.de>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20230517072314.GC27026@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_053651_959808_D3AA13B6 
X-CRM114-Status: GOOD (  15.28  )
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

On 5/17/23 08:23, Christoph Hellwig wrote:
> On Mon, May 15, 2023 at 01:54:43PM +0100, Pavel Begunkov wrote:
>> Use IOU_F_TWQ_LAZY_WAKE via iou_cmd_exec_in_task_lazy() for passthrough
>> commands completion. It further delays the execution of task_work for
>> DEFER_TASKRUN until there are enough of task_work items queued to meet
>> the waiting criteria, which reduces the number of wake ups we issue.
> 
> Why wouldn't you just do that unconditionally for
> io_uring_cmd_complete_in_task?

1) ublk does secondary batching and so may produce multiple cqes,
that's not supported. I believe Ming sent patches removing it,
but I'd rather not deal with conflicts for now.

2) Some users may have dependencies b/w requests, i.e. a request
will only complete when another request's task_work is executed.

3) There might be use cases when you don't wont it to be delayed,
IO retries would be a good example. I wouldn't also use it for
control paths like ublk_ctrl_uring_cmd.

Let's better keep io_uring_cmd_complete_in_task() as the default
option for the interface.

-- 
Pavel Begunkov

