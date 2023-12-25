Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BF4C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 11:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8q0zTEr/I3MEDo5TASfXlMKABP7t0mngTwJsdjKf4tE=; b=hqbKlqsDVtBaldaeo1ak6OVWa/
	bEiPO/Fq01IGpaAa///Pvuk9lsDt8rWbc9NqqSTFZCeNUcIPtBh7bIwXVGWNxvZKtLMKPTxmYjy0f
	XVwelQL0b4vrsdPuKic+QpKa50uv+yiQfBda0DTYAjTJJZir2pjYIHX3LgwqDvVqwO4DbrS3rJXS/
	K6m82OnZrebWCrjXz33gVeaITWQIYDV9Y4Dw7HMTJ9VjPlIJuY6DbOxGqTv6G+SHVwYAmMfEAGS23
	F52FQYmJYgcDpLI/2WEXMygnpyJLZcNQC/f/CXXmiHwhrqEyaSSKboDo4XpEqucuF3g6vEuNrnlXg
	LKMP/JKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHjKR-00AeH8-1U;
	Mon, 25 Dec 2023 11:41:03 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHjKO-00AeGf-39
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 11:41:02 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d2df9cc39so11305485e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 03:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703504459; x=1704109259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q0zTEr/I3MEDo5TASfXlMKABP7t0mngTwJsdjKf4tE=;
        b=ba1pZtG6d6WaaGLPluiliww6eiqpwF2RLqXZXAiEK0YOhfIdML+zd64AJTHXSueBR+
         Uqp8+ez6nnXSStgSA4nqw9ta6GdwieM8Faw+KxumKJ+IFmhFLQYMyS0oYUO5U0KStVs/
         8S+G0QRb8wo72pwvg+4WKdsNRRsTJ2lbPJbjSc/9X1qGTMU1nMn6XeqsW4kiqdcwi5vk
         2tpmasHeD2G5MOZ0cTtfHOXWYdTnYb+whcUxma9x5jH9bB/0rRhulgxeEUKMep4jKy0F
         Uv+Wzm+yejn8tlDbExWKOHF4zZ9qvzPchb8FD7GlDIjUCfrEi8Z/3SZHJ3bgjIH/HLvc
         +iJw==
X-Gm-Message-State: AOJu0YyzpgcfYhAqq/8v+6ECjH+64kiqt2Xdh7isRm0G44kHxcVuLzlr
	G/XSaplJ1ntQ1y2z/saIyJQ=
X-Google-Smtp-Source: AGHT+IEj3HO1r64gPpQb66QyrdzsTWAlA8vt/Q8tb5zhx0VFtjg86kxzVCm9S5YxW1kKhPQBBjolyw==
X-Received: by 2002:a05:600c:3545:b0:40d:42e5:c9b2 with SMTP id i5-20020a05600c354500b0040d42e5c9b2mr7657765wmq.1.1703504458851;
        Mon, 25 Dec 2023 03:40:58 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040b2a52ecaasm24768594wmo.2.2023.12.25.03.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 03:40:58 -0800 (PST)
Message-ID: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
Date: Mon, 25 Dec 2023 13:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Content-Language: en-US
To: Jirong Feng <jirong.feng@easystack.cn>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp> <20231205044035.GA28685@lst.de>
 <08f2c221-cca7-4d34-ab78-157d4eae4f68@grimberg.me>
 <945fa17c-f1d0-4928-972b-da29ca5c95ec@easystack.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <945fa17c-f1d0-4928-972b-da29ca5c95ec@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_034101_034769_9673D95D 
X-CRM114-Status: UNSURE (   9.93  )
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


> hi all,
> 
> any updates about this case?

I think that we weren't able to find a suitable ANA status that
would cause the host to failover like you expect.

Perhaps nvmet should return NVME_SC_INTERNAL_PATH_ERROR ? Because
if the nvmet ns is disabled, it is somewhat equivalent at least
to some interpretation...

The only part that is unclear is what will the host do if it
gets an ana status but when reading the ana log page it will
see no change...

Did you test the patch I sent in one of the replies before?

