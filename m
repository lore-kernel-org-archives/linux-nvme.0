Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6241EE7718E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wtL7V9F7s6gO9y17wUC9gmsLnx
	Yl+ke/cZcVt8n3SJW/FXgDvV0Lztkraxh0oNwntsbwYq0C8ZzFSKfzJbJvrVvGzHOqmv8B7ofb6XV
	PQEqJEJN8Bbr7wyndHWtXjSEBpAk/b7JGrZu9yHyvfXloAbk67FaOJVGVqJVOew9QZHHRo6FmcjrZ
	Insz3l7hqrf6Q1AGA+lFABBCLiBdZDlQy7kafl2wDj1nMnLhWcmxdkYPPq9A85KwV18uk+k2IFoRa
	f9pQdpynJu3exHAjNBCrUGsXgwghsZxA4surYq2W8YQLblOJPnTK5rHJuVYyNeeKC3nJAMPaAarVg
	k/Igi78g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ1wK-0000000Biqp-0gLL;
	Tue, 24 Dec 2024 10:15:00 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ1pJ-0000000BhcW-2WFS
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:07:47 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38632b8ae71so3712968f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735034863; x=1735639663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aSN78PHNsbau52KVfhmGNbBTbSXgjlwt8oOnT94M7b78qStGBa3JO1ZPR7aB+OcLNo
         L3WeJOI6FoaNhoguhVNIzYpfqdOJxf9ycSA1JaRIOk02+2N7YyQQCcGQrm95RxNBqTT8
         VMRJRgr7pD1YVa4ah8dZYpOCjifSz2dKV6KCWqaToMlamvEo3j9PRxNIENdog7LbMYUN
         BFJh4CdbyvpGv4XyEM2syEL95+uLW5XvoFRApf0M46BQTZ1mTFRT7BW57ylRWVON6ewo
         /72U4+OdTgyf3m++SI8r4J+bkj/InJLZI+PVthrlfLKfKl9d0MEND4rOmkcUW5aPDHbS
         Hkmw==
X-Gm-Message-State: AOJu0YyR6dHqm7KquPs7YhY6JuHm67Wv7kHUiOERqZTRo2IDnbcXPx63
	II6ihqfv5yZv+wNSprm5CVU8QiItL4smK+ssu/38WBaRYPpY/yj+
X-Gm-Gg: ASbGncvL/SQrCa8kut5nCBJ+s7EXCMrV7IoDcR3x9EXBNoLvkPgDSRvxnWT9fkVDc4o
	0cWtwy0sRBkXsgVxtMl5+EHCMuzwvak7qMOF3452yUAKoFGNoTKPrmPKoz37X79mEYycQSg/LZo
	Teh0vyPlkz66/UB1MvaMq8zV+W1iv0lVANJAlzCc1IL2NP6WHzY2WbQPeovKpF1kx9qiVH4NxaH
	WcmkDdkD7GC2CuPJ2rFfVV0JkRkWzLXNUPq12zXbIQCgp4CGQXHXC/8n1adl9itsPgdGQU+lGGj
	zC9oNJPoJnG0qKzfKLlnc6I=
X-Google-Smtp-Source: AGHT+IEqn29rtMq+fYJ75wfBcWBVBsDD9jB2KfNFpXxIR/aRCNXzBkRp1BvfUeBjpI39VFSHWrJpxw==
X-Received: by 2002:a5d:648d:0:b0:385:f7a3:fecd with SMTP id ffacd0b85a97d-38a221e2d1emr15903660f8f.11.1735034863061;
        Tue, 24 Dec 2024 02:07:43 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847513sm13833710f8f.49.2024.12.24.02.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:07:42 -0800 (PST)
Message-ID: <c8f93a0c-e4ae-4250-b6ed-3c49d6c46778@grimberg.me>
Date: Tue, 24 Dec 2024 12:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: change return type of nvme_poll_cq() to bool
To: Yongsoo Joo <ysjoo@kookmin.ac.kr>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20241223010516.241581-1-ysjoo@kookmin.ac.kr>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241223010516.241581-1-ysjoo@kookmin.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_020745_643342_63598574 
X-CRM114-Status: UNSURE (   4.19  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

