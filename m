Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A3EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8/fxU4uHmR+05GpRkk98JV9hgBLhkM5hCKIlMh/JgPs=; b=glHOdl0fbGYlbj+LsVT6zZ344M
	MMi31OW/hIWpYS1vhAscal48Zi6kfuI7D6V+ZkRv1LY6BEkcvLxxhSDaRQhJEF6mLdAV4RPYxnQYp
	uOCwsuj0zWDKOR+QsgwXYC6NyQeeVNUE2hGj784QcOW9BZHO4nb/1VNhAsmZngGVSc9iUexiK5wGl
	A3dGXSABEGl1lI3D2E1sTE8pxbvzvwkic15G47iuUYmT1uOJc/8aHh/4z0dDTDqHbzVOgLZfgJqnp
	65ZLQExEcKUwRm+abI5Hzb8s1bMrvH5+eQwe3HA4V64zUMKg6yuIjGDDgn53awCq/TWVNkibehtMg
	fB+AM4Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfQO4-00B3lK-7m; Fri, 15 Apr 2022 18:09:40 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfQO1-00B3kD-Tf
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 18:09:39 +0000
Received: by mail-pg1-f180.google.com with SMTP id q12so7979703pgj.13
 for <linux-nvme@lists.infradead.org>; Fri, 15 Apr 2022 11:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8/fxU4uHmR+05GpRkk98JV9hgBLhkM5hCKIlMh/JgPs=;
 b=r5QPxdXxUrbqez7ENWgFo7ijNE0yB6veno2SNc7rrYw05o3ma/Wja/DxJFsSWEXd06
 OF/tO3Y6rNg3f7n8izctrrYaq7Ok1tXFQHUC03laxmRC0dijKvSlw6mWZXQvZNBQ96EB
 U3DEQVDry0I6anb10Sh+N5oym5qRG+LUNp6k6Lz4jsV480cYCLumROCu2cCSm6ovOxQ7
 KdVjiXMBdaXl97pQABzu4ZidTULrg8ffEgR9InjDJcBr+Px2KwdK13pQdKnlKJP+f0DT
 qRiiFQbyijIVRycJLO78zo7+Q3YL8Q4zsF4n9WkKxEwcGlo0FMHTBgA/uou59pRPeU5e
 5H6A==
X-Gm-Message-State: AOAM5324Vb3QeJYNNTsmzghoQZzuamv4FjuOhU5PYRF4Z6v6ByQSf0h5
 lAzBhl9ekgEkHKmdG+rwkx0=
X-Google-Smtp-Source: ABdhPJz7guXHxadZJmvX9ixogv97fREX+Q75Q1hdxHkf9WIX/Yw0FCuc8VHQpKlg2FQngRENLLw8Ag==
X-Received: by 2002:a63:3fcc:0:b0:398:ae5:6905 with SMTP id
 m195-20020a633fcc000000b003980ae56905mr167440pga.463.1650046175394; 
 Fri, 15 Apr 2022 11:09:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a014:c21c:c3f8:d62?
 ([2620:15c:211:201:a014:c21c:c3f8:d62])
 by smtp.gmail.com with ESMTPSA id
 y9-20020aa78f29000000b005098201d2f5sm3269719pfr.205.2022.04.15.11.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Apr 2022 11:09:34 -0700 (PDT)
Message-ID: <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
Date: Fri, 15 Apr 2022 11:09:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
 <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_110938_023452_E5CE1937 
X-CRM114-Status: GOOD (  14.50  )
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

On 4/15/22 10:59, Luis Chamberlain wrote:
> That's about 3 block folks not being sure whether or not it helps. And
> the complexities of it, to test it, requiring a different kernel seems
> just stupid. So I'm going to drop the tests from kdevops and not bother
> with them.

How about modifying the nvmeof-mp tests such that these use NVMe
multipathing instead of the dm-multipath driver?

> With regards to srp tests there seems to be two modules to use. Do we
> want to prioritize both just as much? If so then I'll just create two
> guests for srp tests.

The rdma_rxe driver is older than the siw (Soft-iWARP) driver. That's why
the rdma_rxe driver is the default for the SRP tests. Ideally it shouldn't
matter whether the rdma_rxe or the siw driver is used for the SRP tests.
There has been a time when the rdma_rxe driver worked perfectly when running
the SRP tests. Unfortunately that is no longer the case ...

Thanks,

Bart.

