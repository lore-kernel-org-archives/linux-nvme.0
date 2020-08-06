Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB7FC433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:19:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33912177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R/eDaDbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33912177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tHBzhDeWbKYmaXNKWUHMFH0cDfRasD8VeTKTSsvBhSw=; b=R/eDaDbBJD5AhCnid82T67lTp
	vzXsxg2TKRLYc7BwUAtqtLGtXQglmHipzyDNufsFHpQ/yRrkDs95lhpCqnFjuvq90zDy7agwgdtbW
	kevoC+lEPw8eqRcJBpLir6pSeYckgCJ6rqH3WshrIZxONGvf0tUfPXCGmR8/epy8ZmFuwxflvSX+T
	ya6ZbFYzurBc4MUinyFp+e+Eh5y5H9GE76dyNQgglIq8vhJYuw5p9O5c9tNJvZ2EWU+rYVBiggrQE
	qvDUhveBkQj/hf7SEgp8wHk/T6/TQCY27xq5WG91iCq08W3pCqvHm9xdBnCRzny3sRLR9Gzj73EFR
	96iBJK1/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lQe-0002ka-C8; Thu, 06 Aug 2020 19:19:52 +0000
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lQU-0002f9-Ci
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:19:50 +0000
Received: by mail-pg1-f175.google.com with SMTP id p8so11362690pgn.13
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tl5Y5gYpykxEF6DdGNUIrXBz99egLF78sfs88mzYBUw=;
 b=NvcoIUBRhx9WflQam2jMjAWLClFA7AomXDbSFnfOabzHrSFMil/zYhWaikFCneBnVm
 qAQDEr2TU9fec+hKpEwpq9+Ya0XRDbGyozeLFnUFLoNJ/1+Q4N/oMVgte1k6KTx5NVOd
 2YHLwrAxABYLyvhs4qNF6gPbLT4qcV8u7dgqVKJFLOxMkyHOkBR2yfMckdQVRBqcf4Hb
 OiQCGoK9jxpvoP68FfIjHztLwxxCeD776gZhQrm7n/FQeDympn0SRzcjnsydd/MNj6CF
 EZm/LjVwcqmdFOUonekC1nYxrmYbzH1Vb842FTa2bfaM/lMd4/7RhceaiJv6hhmfkoFf
 /zlA==
X-Gm-Message-State: AOAM530NXlExK9lbbpekiX66lqNM4k4ry64p+mWOvL+olbJh5OVHcRFK
 ofpjhfxQjptGxSSO276SLw4=
X-Google-Smtp-Source: ABdhPJzsLYHa5bpHzHJym6xCAIJyfgAmUZfk1OeiEwoH7YODf/2s4wAfB//AQ9flZ2qLbz/w53G5CQ==
X-Received: by 2002:a65:594e:: with SMTP id g14mr8762831pgu.62.1596741579319; 
 Thu, 06 Aug 2020 12:19:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id e65sm8832097pfe.91.2020.08.06.12.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 12:19:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet: call blk_mq_free_request() directly
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2a551c4a-b3a0-bfb4-24aa-deba15a8308c@grimberg.me>
Date: Thu, 6 Aug 2020 12:19:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806073151.56061-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151942_531831_6829D282 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This one looks good, I can queue this one up.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
