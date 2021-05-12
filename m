Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC54C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 20:59:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6BB613C0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 20:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6BB613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=BMTV8ifUBldpt2EUfqZf7Ckhj
	enLjPAdwLdhFEtDOq5SCSVh44Xo1d8y7e9XsUJy/t0WWNfO2Mb6XXjJv7dklIZ0kcDysN15+rsjM/
	9ePLSLydlRUWRnJh/NHSbLr6eXSNQ1aq3fU2NjAQ92yu9CcF2GqwDpLtR9iWwIM4Y5IBaw7Znkpkq
	+yFXmuRQVsEOosJJx7np2hNTBH3Q75xgKyqRRjxd2iX42mEeyoGiM/p7cMK2OBYEnjxgHKLdTW7nH
	QEAvqiyll/izpk2ok9OXU7zQb0F9Cc83YJFic41j2eChxkubfSbEWgp8Sw3sYb4IdmrU7zrL5xpuw
	KeRDb3xxg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgvw4-003yHt-VR; Wed, 12 May 2021 20:58:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgvw1-003yHb-Pk
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 20:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SNaObreiAVMex17xMxg1xbLuxN
 GyvzHyRkrVbQjHJVEgttgGZlphRK22MYjrix13w9HEdA4w6UJxjRLfrn6ReVlFuvbEaMhFtGOwTHH
 E2vH4YpbBD3Eliu32/+WVi6h71mNvO1+pUHbwzRpfTXyAoQryPqmtc63ckOYTwPAyQvRRVs5RBrFL
 jFkdyetJOJ7YN910A6GG0jBk7WP1nhc/JCQ3AKst3pZWfFPkLZPyGFIGTgMdA6F2uSi6FYKONq/jB
 ZXb1UmQIYJosx27ezCLzs2lPiqre3zBCW9zxD4eMv3AlUVYQ35WYcpLfG7ECUiXJMcpXjyaPY5UTr
 2F8T1Shg==;
Received: from mail-oi1-f182.google.com ([209.85.167.182])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgvvz-00Ap4D-C1
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 20:58:24 +0000
Received: by mail-oi1-f182.google.com with SMTP id u16so23531759oiu.7
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 13:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=glBted/gdAq+1bekw+2mJ0DH21FisGlHeMQuAGd5bIAJd86ct0/h59iN8aWtGEB64r
 eRrv4PwsPhlDCkuRi4Kpeq9VJ2bk51sxedP1wNAUOf/i1zBw8etbdDa0eVwybGvBa5SU
 TxSi8PJNsD/hz6qYDDPINZ1350NO3N6yy+wr78DHDZ8L6XVtGXGDhk+h0xP6lVFXZvGc
 GastRj9NCGitJKcFaANJl473aY1ML4hkOEiDwWJGQyN5DqaCUTSogK3HZAB+g48V1bhU
 e3UhEnH7MnQrSmUmA0rL4+d7mkLqfEpEnJHVITEMbDhvmn3VRSmi2HBITQL7iHiuy53X
 eHPA==
X-Gm-Message-State: AOAM531vmimRNY5aU96jeShCBujNUEQQzeG4BQf1Zrgi621lRYmrxy+U
 KkY2zYbWYeb1aaYocXwZ5AiMAXQGcik=
X-Google-Smtp-Source: ABdhPJxIt33KmeXNXDucfoZBOm9x/wAiZEW2osKajoIJW1cYbUKVk4S5avEIuomHeoZsyKU0Jwknrg==
X-Received: by 2002:aca:5c44:: with SMTP id q65mr26899108oib.12.1620853102255; 
 Wed, 12 May 2021 13:58:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id w6sm203220otj.5.2021.05.12.13.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 13:58:21 -0700 (PDT)
Subject: Re: [PATCH 04/15] blk-mq: factor out a blk_qc_to_hctx helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <030d24a1-de26-e71d-2b44-bc213abf5219@grimberg.me>
Date: Wed, 12 May 2021 13:58:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-5-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_135823_424247_2DD47E69 
X-CRM114-Status: UNSURE (   8.79  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
