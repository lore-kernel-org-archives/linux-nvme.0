Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1DBC77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yBtJVDxHkjT7DQCSOQzNe2IthXptum9ChouKTqEU27w=; b=MEXlVzD5CD1nDRslpzST+8tMKO
	IF5j+/KokXtUfx0eNrcZSgSicWFrq8YqOKAUj8vhozRlMuypoj7KNj6J1/5uSKBF9/maH/DczkdAV
	4zHBtE4sjGGBvFWhMXKGQnn1Rsd7I5PjlMRKm8eoz+7Ba0Z7XAIXcEMmkIW+7G3zHcKqr7opwuK1j
	bK8SNBI8aE01xW/zLlhTWtunJP7RNEc/dlROss5wzFvMdcbpriZQ16XQ9wzuQtsY3rqRDrL5J2wJa
	nxiANJPFS+SO8KJ0zkI+D9Ys/U3HCBtyJOvtgBXP0G9Y3P8lPS4734P9ZH4LRqtLiKIchLQ4/LJOJ
	ttYUrxWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poUIY-00HOpQ-2C;
	Mon, 17 Apr 2023 19:13:58 +0000
Received: from mail-qv1-f47.google.com ([209.85.219.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poUIW-00HOou-1L
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 19:13:57 +0000
Received: by mail-qv1-f47.google.com with SMTP id on12so7853222qvb.6
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 12:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758832; x=1684350832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBtJVDxHkjT7DQCSOQzNe2IthXptum9ChouKTqEU27w=;
        b=Yv5iKHXrEM6nGTBAjLa5/WjQbrGlBYj8G2h2HQxwkewcLoS4KimzT8K9aVyhgTA6nw
         sGCs1CWXWbfivBKvjJoA83b47MW5ti7EBqCZvcqHoiv/m6iXw5hlA6ijJYfLijf/rLAy
         3EBTitVYdKSaFQFLEJVX3wACCmMnqXRIOKUUioKmelaqRFDK6SqHcWHi/hVk9RdBbZ4v
         HVmwmWBA5MLAOmpDuPO3UcRORDXDktRrKGTaNEC6MvX3jsCJxJRqiCWzfaQ8n484x/br
         8vvFBEoYKZ0Ft80V9rA/5p5+h3F1CDm69hN/ZMaSeL81pXN+s4vZz3b89kKCeFBzR9zC
         ryTg==
X-Gm-Message-State: AAQBX9eiLBIzE1qSp5YN5nDL/GmPQaJ4Flss0yjJ15NK38iXBl0626J3
	1zg/JJrE6zFArUfeEoawVX06
X-Google-Smtp-Source: AKy350YhhMmQjUtscx8DWNyjxCDA5LGW9pBXnmkkJTzahbIxgePxnjEG+PUB8GZIdmsQdXDjMB2WVw==
X-Received: by 2002:a05:6214:5084:b0:5ef:6101:3282 with SMTP id kk4-20020a056214508400b005ef61013282mr11320857qvb.0.1681758832583;
        Mon, 17 Apr 2023 12:13:52 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id ed25-20020a05620a491900b0074856680834sm3332329qkb.132.2023.04.17.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:13:52 -0700 (PDT)
Date: Mon, 17 Apr 2023 15:13:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	kbusch@kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v6 06/18] dm: Add support for block PR read
 keys/reservation
Message-ID: <ZD2abp1WQ0FqYXAT@redhat.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-7-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407200551.12660-7-michael.christie@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_121356_474346_3FD62531 
X-CRM114-Status: UNSURE (   8.14  )
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

On Fri, Apr 07 2023 at  4:05P -0400,
Mike Christie <michael.christie@oracle.com> wrote:

> This adds support in dm for the block PR read keys and read reservation
> callouts.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Acked-by: Mike Snitzer <snitzer@kernel.org>

