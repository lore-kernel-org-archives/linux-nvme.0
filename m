Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403CAC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/S6e8OW3yOWika+szybFQ7gZ5po8/UT5uTlguQudnvE=; b=RJcpbIQkMQsmHeaLxN+DVsJt4x
	e39GL6Oi3pKC/H/U4p0I9mXYHgTks/JGynauWVHmQBV2A2YOisYd+ToeAqahOZEQ6HC54YBCvuzAU
	3NBhA1JX2qO2zct/jB0d5qa0Ki5/WXUON0TMae+o7aOzJ9rcrJLCh8st3xTEr8KvvMBNDIIO0x76l
	Mv9y0RSCovcqyowr7ie6fhlTSdtQ+sKwjm2lKJ1kqrFXpBfuDkYXRlFtHuWYMD5ALRZoAhlPW63F8
	Fy1qgXUhurSSPyCuZNYLg95GNCkxwDkphFx91II7YuM/UvopDeSL9vzSSkyQFRjIRalwt/7Y1T1zy
	ekLK5zYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD12L-008OBb-9p; Wed, 04 Jan 2023 10:30:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD0mK-008KtA-0i
	for linux-nvme@bombadil.infradead.org; Wed, 04 Jan 2023 10:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/S6e8OW3yOWika+szybFQ7gZ5po8/UT5uTlguQudnvE=; b=oTYKO3POoT57yLGPHb4600D4Pj
	yfsb/zkTLSqvF9GZdmoDErzAqjwhSe8e9utM5Z7IxwXBV5U/9v4P103ROSl59BQLjj8obZic8ms4o
	WtPf3DNHWEeDf1oNpdvxQeCyKgRLfrGTqwUUA/1lGBIGdcF9cWqZQJ0YIyJESNm4Lid5ixaS92crP
	fhUzvRXU7WPw/UtjQwS8pfrUGFNgYN6aJRJZ74wH1KwOZKxLpFn0QRTIGWJywE0zsy5vF7k+PHW8U
	ynmD9qlkujP0vJI3KtQdlUHdCVvbCGtqMBnpWNSLV6BY9Nl9cQymoCvkQF4B4/ZQe+dWt38ZAPU0T
	OaCd08vg==;
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pCzZj-000rVl-1n
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jan 2023 08:56:45 +0000
Received: by mail-pl1-x62a.google.com with SMTP id 17so35312556pll.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Jan 2023 00:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/S6e8OW3yOWika+szybFQ7gZ5po8/UT5uTlguQudnvE=;
        b=VG+dBb2AmM0rH0Nvqt/sAT7hX3zbM7KUD5RZFhwX/f4QcdNzcO8qwJy5lU5NUl7fD/
         WLihfPWsTK4mhT3fz93FteGFHKTofnqRjklqHhsUtAIOEtGU+rcQSYq3/GqMgISALHB+
         5Cihnt365oK1f5nXGymmMg99/rSbJ3chNVMJdu9dsd1LWoWM+Qle9s6sCgAyYAcYClxN
         RJBAHm6KdAt476aD20FiGTabJIOwKxn9s47G+kxJcnTrJlVwevbq7IvKMjev1YO2VR/i
         uRPr+63bmczWjL8StUinQ0xV5F09MlFPwMiR0n0aE40i2h9cecZ33epMyFQK+EDNi3Eq
         zsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S6e8OW3yOWika+szybFQ7gZ5po8/UT5uTlguQudnvE=;
        b=VaBACzY5eJagKaXcv53zKuAJz/OA5tZfCF198jAiMTvNbBqXYUy0sw4/IWm6I2lPFE
         vrESGDW3xYhna3xQ0FnWk/XicKBE6jXQHpL/0HgEPLeFgUkHN4qnmyWhEAZj55Jw5Qo4
         ho0HIWrKxvkXtAepZQz+bXRoVZEVUqx/ppXzqxOst7GS9cZF2YyyeaGvXTeZ4SQV1a3T
         jogqGo34rFlYQzk7EORaWMzeZaCZsJYAgjCuUSVUFw9fyZ7VRQexMi0721+vjy6a3llA
         w8eQXYz/TTDWmV5c1CJF8QBZ3wiXGnJR64NFNWoO62/d6rpYUlmBL0mladxIUWMAkWKZ
         tk+A==
X-Gm-Message-State: AFqh2kpy3tfuK4BavpjE8JDCkSLlFNwILLg77Nioqt+JapXyfJ8wYywg
	CC/QfwPwYDww6ORq3sAC29o=
X-Google-Smtp-Source: AMrXdXvUc8lMuaMje4XMoudFL8vbQhOtZYz2JXV6zAhD/BXagvegHttBgLtU0YXv6qq/p2U+Gi6YBg==
X-Received: by 2002:a17:90a:8b05:b0:226:7fcb:c215 with SMTP id y5-20020a17090a8b0500b002267fcbc215mr8501026pjn.17.1672822606017;
        Wed, 04 Jan 2023 00:56:46 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id ms6-20020a17090b234600b00213c7cf21c0sm826609pjb.5.2023.01.04.00.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 00:56:45 -0800 (PST)
Message-ID: <34e6bca5-b486-3f58-dc91-e848760babc3@gmail.com>
Date: Wed, 4 Jan 2023 17:56:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] nvmet: fix hang in nvmet_ns_disable()
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "larrystevenwise@gmail.com" <larrystevenwise@gmail.com>,
 "anthony.j.knapp@intel.com" <anthony.j.knapp@intel.com>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-4-ap420073@gmail.com>
 <17ff8d10-d25d-3ea9-8d3d-2f07f7d7c9c0@nvidia.com>
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <17ff8d10-d25d-3ea9-8d3d-2f07f7d7c9c0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_085643_717381_32817FE5 
X-CRM114-Status: GOOD (  19.57  )
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

Hi Chaitanya,
Thank you so much for your review!

On 1/4/23 09:32, Chaitanya Kulkarni wrote:
 > On 1/3/23 02:03, Taehee Yoo wrote:
 >> nvme target namespace is enabled or disabled by nvmet_ns_enable() or
 >> nvmet_ns_disable().
 >> The subsys->lock is used to disallow to use namespace data while
 >> nvmet_ns_enable() or nvmet_ns_disable() are working.
 >> The ns->enabled boolean variable prevents using namespace data in wrong
 >> state such as uninitialized state.
 >>
 >> nvmet_ns_disable() acquires ns->lock and set ns->enabled false.
 >> Then, it releases ns->lock for a while to wait ns->disable_done 
completion.
 >> At this point, nvmet_ns_enable() can be worked concurrently and it calls
 >> percpu_ref_init().
 >> So, ns->disable_done will never be completed.
 >> Therefore hang would occur at this point.
 >>
 >>      CPU0                                     CPU1
 >>      nvmet_ns_disable();
 >>      mutex_lock(&subsys->lock);               nvmet_ns_enable();
 >>                                               mutex_lock(&subsys->lock);
 >>      ns->enabled = false;
 >>      mutex_unlock(&subsys->lock);
 >>                                               percpu_ref_init();
 >>      wait_for_completion(&ns->disable_done);  <-- infinite wait
 >>
 >>      mutex_lock(&subsys->lock);
 >>      mutex_unlock(&subsys->lock);
 >>
 >> INFO: task bash:926 blocked for more than 30 seconds.
 >>         Tainted: G        W          6.1.0+ #17
 >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
message.
 >> task:bash            state:D stack:27200 pid:926   ppid:911
 >> flags:0x00004000
 >> Call Trace:
 >>    <TASK>
 >>    __schedule+0xafc/0x2930
 >>    ? io_schedule_timeout+0x160/0x160
 >>    ? _raw_spin_unlock_irq+0x24/0x50
 >>    ? __wait_for_common+0x39b/0x5c0
 >>    ? usleep_range_state+0x190/0x190
 >>    schedule+0x130/0x230
 >>    schedule_timeout+0x18a/0x240
 >>    ? usleep_range_state+0x190/0x190
 >>    ? rcu_read_lock_sched_held+0x12/0x80
 >>    ? lock_downgrade+0x700/0x700
 >>    ? do_raw_spin_trylock+0xb5/0x180
 >>    ? lock_contended+0xdf0/0xdf0
 >>    ? _raw_spin_unlock_irq+0x24/0x50
 >>    ? trace_hardirqs_on+0x3c/0x190
 >>    __wait_for_common+0x1ca/0x5c0
 >>    ? usleep_range_state+0x190/0x190
 >>    ? bit_wait_io+0xf0/0xf0
 >>    ? _raw_spin_unlock_irqrestore+0x59/0x70
 >>    nvmet_ns_disable+0x288/0x490
 >>    ? nvmet_ns_enable+0x970/0x970
 >>    ? lockdep_hardirqs_on_prepare+0x410/0x410
 >>    ? rcu_read_lock_sched_held+0x12/0x80
 >>    ? configfs_write_iter+0x1df/0x480
 >>    ? nvmet_ns_revalidate_size_store+0x220/0x220
 >>    nvmet_ns_enable_store+0x85/0xe0
 >> [ ... ]
 >>
 >> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
 >> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
 >
 > [...]
 >
 >> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
 >> index 89bedfcd974c..e609787577c6 100644
 >> --- a/drivers/nvme/target/nvmet.h
 >> +++ b/drivers/nvme/target/nvmet.h
 >> @@ -56,6 +56,12 @@
 >>    #define IPO_IATTR_CONNECT_SQE(x)	\
 >>    	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 >>
 >> +enum nvmet_ns_state {
 >> +	NVMET_NS_ENABLED,
 >> +	NVMET_NS_DISABLING,
 >> +	NVMET_NS_DISABLED
 >> +};
 >> +
 >
 > The patch looks good to me, but I'm wondering if there is a way
 > we can do this without adding new enable disable states ?
 >

I'm not sure, but the workqueue would be possible.
The point is to make enable() and disable() are worked exclusively 
(serially).
workqueue will execute enable()/disable() functions serially.

Thanks a lot,
Taehee Yoo

