Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3386C77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rh6V4tYiLlllRSr0PfsNXhLUe9cYUsXg2EQxXpgmKK8=; b=rmAcdWxXZwZKrsM5iwnpJ63mri
	LZtrpmISqf2eYjh0Pr8z8nX4ZeM9+BOOXqNMZLbmnyXaU8G3Zkemn2OW5d9pjRRu9CwVZdjhNpLqS
	F1xMDLX+PeMnBv7cePyZKAYcEbj3wwI7n56lV4Az74WKWmTgY5FjLmYi+c1YwZffeUrUcgJfvXISI
	5xQmHJuBsv32oXlhnzSCJRY3bg56UXyg2yCABP6ZNasA/f2DiuisRlGOKe/egc7zK4ciG8C1Ah3cV
	1asxGiEMAJ3GMfCZg5eJwNjH3y1KAWKncGiMTR5DaX+5Qe+8lhE8ItA4WYJtTdtpgs/Xt2IMnIEjO
	pCXobO1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psRsf-00BL8J-1o;
	Fri, 28 Apr 2023 17:27:37 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psRsc-00BL7o-0y
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 17:27:35 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-760f040ecccso297239f.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Apr 2023 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682702852; x=1685294852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rh6V4tYiLlllRSr0PfsNXhLUe9cYUsXg2EQxXpgmKK8=;
        b=q6MUYFZZqhT76ANijpfoaVA0+tjHHNSOMXOqFpKYothGCxai6tDgo9w2NZDUEzjHpK
         Kt7xDBwNDQjknpnwoCG1kbz09vVe8mPb8p8WSePXvS2bpSfUXvMCEVMMc6yuadU6CX7U
         G8z7LeT7M984KfYVP0u5fxprBvNwvnebY2yDKrWGsLBy7iuwHjSeClT2AucE2J1JG7Qs
         /SkTgEzOlgADHXS7UXQKbBIsiL6z7uFLxM+1XlUD8Ss1VP4lAtbUpiij18c8s0FSXY4B
         RlFTkhAVBl1GvPdPsfSGRWBjQC4PAXLyQQRRf6b+58D5hoz3Gmf4EwJqtQu6uoF0Bhh+
         eFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682702852; x=1685294852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh6V4tYiLlllRSr0PfsNXhLUe9cYUsXg2EQxXpgmKK8=;
        b=KERA9HcxgqwsPV51+A8pEkyNtQKFBvhftTW80revQxnug5hQOS6N+Ue7e2XkHKjsZJ
         HqV9MitLGSXsNXDZwqmWOVjl5LvPPcRfLL3gw1pUd9cBkZub4llZjekfKfAr+YSdqI6N
         9pwYf4clv8P+tRkxDD2ybZQ2bLCiJyZ8hR9qRDn+TBpa7HiJ1oaNACeRYk1peWtQ5ix1
         ltLRp4Z5iuu+sgyOGRIvyLPkOE6t+6gv+zvgJnvQ+xevfOTeoLzmy7QOb+y2GZqmA98A
         RHXKNuczCC+4X14em8YCE6+ju5i4i77qSkLxT+8D96so+dHIj4nCMUj5P69y5/ut/UyX
         v5qg==
X-Gm-Message-State: AC+VfDwEirT8dfyXzz2WnPyewr0mGbUC8EQQfBT92+F8y015aMg/W+BH
	QKifJFFEA44KnNR6kXZ7+OSu3w==
X-Google-Smtp-Source: ACHHUZ7TyzxVowF7SKHydjwyEQVrsACZzNuP633Lc5sSX90cvV9YVZ/rf28aj6JGV291hDpi2KxITw==
X-Received: by 2002:a6b:b412:0:b0:763:86b1:6111 with SMTP id d18-20020a6bb412000000b0076386b16111mr2820503iof.2.1682702852302;
        Fri, 28 Apr 2023 10:27:32 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d9-20020a026209000000b0040f9a41e06asm6398207jac.0.2023.04.28.10.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 10:27:31 -0700 (PDT)
Message-ID: <786c3e8c-5fc3-9ee0-e026-e32a4b061eee@kernel.dk>
Date: Fri, 28 Apr 2023 11:27:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] io_uring: Remove unnecessary BUILD_BUG_ON
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com
Cc: leit@fb.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
References: <20230421114440.3343473-1-leitao@debian.org>
 <20230421114440.3343473-4-leitao@debian.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230421114440.3343473-4-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_102734_356736_7E2435EE 
X-CRM114-Status: GOOD (  11.64  )
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

On 4/21/23 5:44?AM, Breno Leitao wrote:
> In the io_uring_cmd_prep_async() there is a unnecessary compilation time
> check to check if cmd is correctly placed at field 48 of the SQE.
> 
> This is uncessary, since this check is already in place at
> io_uring_init():
> 
>           BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
> 
> Remove it and the uring_cmd_pdu_size() function, which is not used
> anymore.
> 
> Keith started a discussion about this topic in the following thread:
> https://lore.kernel.org/lkml/ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com/

Just turn that into a:

Link: https://lore.kernel.org/lkml/ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com/

instead.

-- 
Jens Axboe


