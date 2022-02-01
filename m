Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5863C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hp34bVqoar/e3InZNjkVm77xuFkZxmxfiyCdI22uRdU=; b=vwakjpCAtesVe6aEaZ84dNxLSG
	JDd62B00QowR3Wr6qxoNQqhNqHkolPOcxBVYvAjUiMyNiT0ZQsKBilbm+d9TTkAsk+OfkOxQUJP6k
	oZBaLe8TZo5UnCYAOYeDhk4cDkJlfupJV/PK3Fv/efd8xbp/ihIUQfxUQ7IApWImL/nxyuRndGMvj
	oQ1qV7qbUyRVx0XmuYR/qtZYaKHgjrhhbeDaWdLmiUIg1Al3gBaP2Iu7bvC16y1T3svvUwPoj6uvO
	r7jLlateubes3+mG4gjAFcwMlRpY7bn+aAvSNjcFqV1C5xZJI/a08e+n8eItd8y4mIdWAWe9qaoee
	A9FN0uQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyfb-00DWhA-22; Tue, 01 Feb 2022 19:18:27 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyfW-00DWgF-PN
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:18:25 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 o16-20020a17090aac1000b001b62f629953so4218934pjq.3
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 11:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hp34bVqoar/e3InZNjkVm77xuFkZxmxfiyCdI22uRdU=;
 b=LYdddROUXAlUEzpFoCx67J1RBFum3+2AiSK0BwSXPtk1PpAOKHWVujeYatudhbmkC/
 1ctV3dJRWupbI0sgaTbjq7ci0QkUR0Ma4koL3YSCcHyMvNmCnyTKwMBWdEiSpO3MlA7h
 cYOM9sSxowpvpwrS+8IkIHecpaZTw23q9DBUWBvOhT48Y5UxXQYFN3JNiP8Eo7UYVYOc
 8rcBfqb94aFEfR9JGmAIGe8dPTZCx6ihEHUXfqaFG6UCBH5g/4DIXZMuak3mhF7V0YjV
 XbGR8M654bxIAitv9nPwCk1WhpCmHEL+ee35f+Rf5kDrB2+W7PDkJGu5Jf+pKw19/EE+
 mdIQ==
X-Gm-Message-State: AOAM531wBHAahX0yKI3/Y4VlqaYxj7BKL4Uz9oG3wCkUuJU80Z1A7qIH
 87RexmxAcytSmaHnU3qDxp4=
X-Google-Smtp-Source: ABdhPJwVjQ8XwIE/Pdopyd4xqNbc3uXzt+CS6ObdWGWjnTBypf2k1gl84D5YDxPWH3xnxlch5HtAXg==
X-Received: by 2002:a17:90b:4d12:: with SMTP id
 mw18mr4005365pjb.104.1643743100937; 
 Tue, 01 Feb 2022 11:18:20 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id ns21sm3381040pjb.43.2022.02.01.11.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Feb 2022 11:18:19 -0800 (PST)
Message-ID: <1380d0e4-032d-133b-4ebb-f10d85e39800@acm.org>
Date: Tue, 1 Feb 2022 11:18:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 2/3] nvme: add copy offload support
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011332330.22481@file01.intranet.prod.int.rdu2.redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <alpine.LRH.2.02.2202011332330.22481@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_111822_856517_50335F09 
X-CRM114-Status: UNSURE (   8.31  )
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

On 2/1/22 10:33, Mikulas Patocka wrote:
> +static inline blk_status_t nvme_setup_read_token(struct nvme_ns *ns, struct request *req)
> +{
> +	struct bio *bio = req->bio;
> +	struct nvme_copy_token *token = page_to_virt(bio->bi_io_vec[0].bv_page) + bio->bi_io_vec[0].bv_offset;

Hmm ... shouldn't this function use bvec_kmap_local() instead of 
page_to_virt()?

Thanks,

Bart.

