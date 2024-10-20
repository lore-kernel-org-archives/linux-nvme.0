Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC912D3C92A
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=LQtUn3h/vliwlTG0AzypWHGaxY
	CHaVvql85NVKFGYOfT+aIZY1jSsBmRb2bGdDcYURtWZmbrHTf/LGGtFYfJTapxTIdiCDtyZKEZq81
	rLqy9B3q3zmRULhLGNk3EnZgZO+N64el8gUePjK2VqVUM2Olxtz1eevU5OhWQRrWidWqeEwgUOG/p
	s22xL0BJEch0+XAaLiNNmNDf2CxW46LblOU/XwYKl7waAwDBhNBCimYsTGw/FdVJYfUIuw++EQFy9
	dofBaN/+VbIcbZmXYmRYJbDNelnya3/b8h7UrWiuO4qgCD9B4f28h8cvCjIcCJUTdcjhtcPkfF8nV
	WpMbV+Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dFN-00000005Tkd-2veC;
	Sun, 20 Oct 2024 21:13:57 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dFL-00000005Tjl-1VUe
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 21:13:56 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d50fad249so2887418f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 14:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729458833; x=1730063633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=xVUcHkMss1mSVZCYkbA8dkpCvIZ+pHcSRF5t6M0BizR1Ey32T9ka5CUXOjpY4J29k3
         QeKLv6eHceEbYtNZHtbXnI1+DxyNWX3bN8t/gIBcPjfCL4AIPbrefn/AcXZxbYPRK5hJ
         Xnzx+YAUX40FR1TTOsMCkjKRP3ZOYUq+uIMWIppaIS6znReHhSXGH65WTr7/19eAN+gX
         6WRAVf21EqUJbdZeu4rHwL0xUcDK0a85M6Ju8RNa/66/fyIkX+JuzYdDighhtbzfj/2f
         uMvhvGG2Z4hS3CzOmds5vcgNwi4qY0XJDEiyjjUBLsBEnn/0J33/T9vrx2IuDGojRZxW
         fnPg==
X-Forwarded-Encrypted: i=1; AJvYcCXp2dAQMORVB8op4EjsJgKRz2Asi+B856RFX9AtWnfeKdKL3ZGrwGZjiQgjcqs6QgCL7L9CL7CZ0uZ4@lists.infradead.org
X-Gm-Message-State: AOJu0YzGzXelq6gkpnSYhmvTbFMlnqsE17s6DF2MfHmuLk68JZU3Apb5
	XYY6d/09pmGWraVGrgGhHG/IAUoInrCK5RXqOSdzEyLtry1nVMDet6+gJQ==
X-Google-Smtp-Source: AGHT+IHd7ek+uBZuiqrHPRkQ5UAytM9v6rWPivRjGpM4cr1mCk5MVwKCmh8v5sGXigBXl+yHf3BQGw==
X-Received: by 2002:adf:e643:0:b0:37d:50f8:a7f4 with SMTP id ffacd0b85a97d-37eb488d17dmr5841372f8f.52.1729458833397;
        Sun, 20 Oct 2024 14:13:53 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37958sm2573789f8f.15.2024.10.20.14.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:13:52 -0700 (PDT)
Message-ID: <175e4977-f865-43cc-827a-cceb8578af73@grimberg.me>
Date: Mon, 21 Oct 2024 00:13:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] nvmet: add tls_concat and tls_key debugfs entries
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20241018063343.39798-1-hare@kernel.org>
 <20241018063343.39798-10-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241018063343.39798-10-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_141355_429799_8D448B22 
X-CRM114-Status: UNSURE (   4.79  )
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

