Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD16C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mDgJVk1jb2BJYaDBi6ahGttjBE3dgYIJSjB02LvY/vo=; b=IqfbbBikr3TUIiGCO8LdkRUBUJ
	kwcjyk4MuIpDoRKu8NSZ+dD4ep6GVgeUrLlqQaLPfwnbk2X5rXgTYiAPpIUpIEKLMIkUBBSSKZvB0
	8cK/KEa7GdLMVKhi6FMiAOUFkmkt/ZKIQY0DQ05eAu4tgtv1/YY6xq6ftA/Nf9wIYHo+co5cuu/Xh
	k1wb5eN5kUyo6djKX69Rvj0GiZOghg0rUj7mJqK5loSLtauvGe89/agav2n8PZKhye99ySyzYUTuQ
	nb1HBTDL+qAX6A0NIE8970AlgyVe8GC508xlQi9JgcW/cfnw2ovEsEaD6MjlUZ3uRi4vN5bcVyJuL
	RSfJoSQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nold3-006oJC-VM; Wed, 11 May 2022 12:39:45 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nold1-006oI3-Hs
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 12:39:44 +0000
Received: by mail-pj1-x1029.google.com with SMTP id e24so2128471pjt.2
 for <linux-nvme@lists.infradead.org>; Wed, 11 May 2022 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=mDgJVk1jb2BJYaDBi6ahGttjBE3dgYIJSjB02LvY/vo=;
 b=wQs8BBF2HMKjw6dfNwvZOpr3bx8ORtweCVG4t8qAH53r49dgsDRQjoliIa4lm+LW34
 neIvP8q2qolPr/e82DXDuGNg/5BHn8GpnWoqfRKL2qisdueFr1ozgZMbpi7QJs6ol0yJ
 ies1mmmqeY2sJ0q1mmq1XSVV/BK1XUiDwgPZcXavvNlBXUi9eSbVS58QtwhP5whtAkhg
 ZldSg6CScfldrV7cwW/JNgGDR2ZFfwuWc4t5ijWbUMLTZ1yIrfLCzYYK0/JjM08LWO8P
 ZUAPxdSicykW002poNpoxO1+rugZe6vJmkRwSNk2cqOzmKTYG7A1gfdkh1fPW2LTuZ7G
 YAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mDgJVk1jb2BJYaDBi6ahGttjBE3dgYIJSjB02LvY/vo=;
 b=nHT+Do8s5WQ+jW5JOshRsiOicVv+yen4y8gX8QpSxAmhCuwHPmyEgstodeRJQyPi71
 2fsew99mHlOygfYZ00I10JKgm2jG0CUtrd87g0XERH2UpUYmsMRepcDpQnm5bzLPDT8u
 pneZwE1vkkGWs0cwrNuuH1HY/zQmBkVAlhzupmVgWH/Fp8s8+S0BH009atL2aipjjo9k
 U8kPaqRVBvR70nicBMs1Lkd5cD6EBsoXTOIc5L8zyDwsxHni6Tsch/St5uEl2taDtVH7
 wjUze0Z5S175d2caY7D2ke1UtN8UlQ0hCG90yQdp3zvxLBOzvAnKaUEXjkD0oObZ4mfo
 58mg==
X-Gm-Message-State: AOAM531dwERpzdpVtYq97TS7aM0wbrl56v/2oJigzO8yDWZP3csrFeWP
 qG4UdJ1D4+RNrxxGXDIBNYBahQ==
X-Google-Smtp-Source: ABdhPJz0HBHEzBcSiQ/3TGRCJbZoltpT077/zkszvcIOGyQ2i7rb7znEFv8iio93DabsXXdmNio35Q==
X-Received: by 2002:a17:902:c2d0:b0:15a:2344:f8a4 with SMTP id
 c16-20020a170902c2d000b0015a2344f8a4mr24954011pla.28.1652272780569; 
 Wed, 11 May 2022 05:39:40 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a170902784700b0015e8d4eb1b6sm1828180pln.0.2022.05.11.05.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 May 2022 05:39:40 -0700 (PDT)
Message-ID: <b7f8258a-8a63-3e5c-7a1a-d2a0eedf7b00@kernel.dk>
Date: Wed, 11 May 2022 06:39:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 0/6] io_uring passthrough for nvme
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <CGME20220511055306epcas5p3bf3b4c1e32d2bb43db12785bd7caf5da@epcas5p3.samsung.com>
 <20220511054750.20432-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220511054750.20432-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_053943_634024_EDC64A1A 
X-CRM114-Status: UNSURE (   6.82  )
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

Which patches had changes in this series? I'm assuming it's just patch
1, but the changelog doesn't actually say. Would save me from comparing
to what's in-tree already.

-- 
Jens Axboe


