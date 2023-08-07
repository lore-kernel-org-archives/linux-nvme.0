Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D3FC001B0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 07:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=QIToGi+vPqwLM8ftPgt/ed1v/p
	tgIeRpmvqTLNKZ4NP27DIVQmgx+NSMkXv8/Hy/nTtr/xQXOHHdlgVQSte5EEh/Us37IC4raiw/3mx
	+6e2brdyn+oa0YirNZJSj6FwRIqGrQSxLZw2z6ycocN6rVGTI8EZd0HeajgsmWcfTDM0RZb0mXIZW
	4LKQKXmBsjA86hd8MCcupyXhOD1hx2eL2O7csdU9ADN74UA8FeNlRBNnw3csLcr7JkRgr/Eci8KBF
	SKy3AmkKyQKLcl5ugdL3Qpg4FNxnPy7IWJ2eQ+Fw/gk7q/bOYjv/gUJC9IAP9Clys9jlt0B0ywoSr
	mnEZ4xoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuR7-00GL3w-22;
	Mon, 07 Aug 2023 07:13:53 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuR5-00GL2r-1b
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 07:13:52 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99bcf3c8524so128773666b.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 00:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392429; x=1691997229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QI8tpZzQQD9gBfTdlEezbCMPqRiAmtbk8EpeeYNE8aYlhlo+hh9IELXkzk350OWMB4
         3bzsNBzZ+xYOWvAx4DO2pCdSHKAfe3JFweXg6soZ33ZQPMcJ2tEws38OPboteY2WvQE6
         U3J/X3QGJwHWYOpkQCJtLioR/VTb9Qy5kCAkw9DoPeLuJwVF7NSWrfeaY59CnixLxB4k
         6pI5lllMXHYYfYkL7l6EBTSZzuQE9wkooU6DcahysU8z8j0TX770NsImNjqWieItN42K
         wQnPHUt7eWdWJuCEywc1wgR8/WB5ouHp91KciRjtGODjjAcyg4xoXmUez+cAahFgOcjj
         HoeQ==
X-Gm-Message-State: AOJu0YwmrgqpDrjNUWlz+PK9Dkar4+cMJVur7UtgZMx1POaLvQSmEVrS
	mGwJ9Mjoy9kS+1NQCfhM7VA=
X-Google-Smtp-Source: AGHT+IH8qGRjvAunj1L4f32I8011uuU9I5lNJxGrJ+Q3IiQ1ghTAYRvtsSMihMG3+99HfkgzUkKjOw==
X-Received: by 2002:a17:906:209b:b0:99c:55ee:1798 with SMTP id 27-20020a170906209b00b0099c55ee1798mr10922035ejq.4.1691392428816;
        Mon, 07 Aug 2023 00:13:48 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bm6-20020a170906c04600b0098e2969ed44sm4745869ejb.45.2023.08.07.00.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:13:48 -0700 (PDT)
Message-ID: <e9330894-f0fc-c500-470d-2c7b86954719@grimberg.me>
Date: Mon, 7 Aug 2023 10:13:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/14] security/keys: export key_lookup()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 David Howells <dhowells@redhat.com>
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_001351_537105_197B95EF 
X-CRM114-Status: UNSURE (   6.70  )
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

