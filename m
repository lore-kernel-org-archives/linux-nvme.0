Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2186BCFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 23:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=3A54tGxuLeikEufftvWY5+rI+r
	AA/NaXdrtM1hoMPsHDbZNe1F5ezLjABa1AUTy3+FG55FGzwAv6edNACL4550ZlMgcpcTp5cO7ap2y
	wvN8inLXNqGwtQoJkbQQ9Lbh1I+cdAkarogvfmw9iL2qlyct8HUklild4nV7OhZq7jfYqhQ2kRzAI
	ytVppD+QlerFoD8kboX9tYbIP+TBs+k5PNgvwTGDcHywkc2fd1urD8iW5ltQPbCQkt3hX4Kw+1XqB
	ffAwByaDaAfX6mjhA+QJvCrNcDKMEmvNCf7bQS4JN0bTQoaMxmYe25LTh+U0yeYHsU7XcOHewpUfY
	xmNrBW8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqTi-00000002f0k-24cl;
	Sun, 30 Nov 2025 23:05:14 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqTg-00000002f0L-1WLo
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 23:05:13 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so28398465e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 15:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543910; x=1765148710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Nw3NdTmBQHb2tfbSpNrK3KLLRcwNm0fGXFMWlorjVtv6t5zNKVI8pyMOAB6zEfbnB8
         24bJGt2uTA2WjOno0sSmeAuO1muX1E5rDD4NyTZhIz8mvUMHFYZa32kXlrg7K5BXeUT9
         MMJ19NGYV4abO4/Jr5lq+YzgpUo7FjW7KHCsIzULeqCNHbzn7d/LNfsn6Jf89BM5CzA6
         TjZ8cPJzDvqrOyHlQPYL+UiWRnWT47p7CSubM2Z08b5LOYdaRWsahiS3ForzJwz7ton7
         3HQKGAM/l2IPIy6514ZaUsVvm6mGSxj6tUZ8Pz2Z/vonbkMZzkvE19AB4DHsxmuo6AmS
         I2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX2i3RPzGm0SEXzrqmvIQzQ2KsX03hDTIQJfv2BxZAZ9h3unIj/NcnHlTLGKsPrVOC/hhJPzuJUfAJv@lists.infradead.org
X-Gm-Message-State: AOJu0YyJvlW9eoeRvzbGUjzIuG/GLdxNug2hJkSPno1c2eUl9817neIh
	JVrSp6pVL+7PTgWIBt5pFOCiJJYFVS6uALBV2l9KsoHClEtveNyu0iSa
X-Gm-Gg: ASbGncsCv+lU29t7uHQ6HyJki7KVk6VFXMyh7tnrE01fMKkZ4QvGBZziZ6y8lWjY3Fc
	fH1A5+kurxPTg+gkjTZPoj+AnTgj8QHAqV0Tcaeu66UIJxqS9G68prW19BpOuiRdCswVb5LWHCo
	fqj4WYaOCSeJofdrvr47hXpELLGLNaPXwKnRVICv9UAxJwBiAZ0hdgM5JSxP1jt8TAKuHXf3g82
	sNWfV/lfyoq1tkbMLDPRe1DE5RlYaTTZ2pKC9UVP9R8jXiSdEq3x0JBoyaYB2FTRU0IE/ajdvOV
	1rY2sQ/LOwgtuRBTnXhtDXKl/FpDL/fDrMcnGJx/7vbVX0r1M/XnOL9qfTOGCRL/+KPy8sMT8CQ
	M4vUa2MJ6d7NrIiwXEOLbyhEKxeFiheGb+6TQfnWxWIVXA95MMf5+5faRtoXQyiB+QTIkOSQqBm
	y6rmhd6b1rj9e9uz+xy5I9AXsarHOJwglMxOlLvJ0Ze0aUA4i8/U8=
X-Google-Smtp-Source: AGHT+IGCFC4wOt1EjIldy+/T46JHTQMS+2LosmU8er3TfxccPDVLz7zfDba2pLLjexs5CZcYXnX0Uw==
X-Received: by 2002:a05:600c:1f94:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-47904b2b3f5mr227633305e9.29.1764543910329;
        Sun, 30 Nov 2025 15:05:10 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052cfae0sm139156385e9.8.2025.11.30.15.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 15:05:09 -0800 (PST)
Message-ID: <08f18e98-5781-4df0-baec-3c9150c29456@grimberg.me>
Date: Mon, 1 Dec 2025 01:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for
 authentication failures
To: Justin Tee <justintee8345@gmail.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: jsmart2021@gmail.com, justin.tee@broadcom.com,
 Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20251117184343.97605-1-justintee8345@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251117184343.97605-1-justintee8345@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_150512_404456_1D70EFC2 
X-CRM114-Status: UNSURE (   4.67  )
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

