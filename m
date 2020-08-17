Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA75C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 07:45:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06942065D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 07:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EpFZ3cXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06942065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XhodkH471nunfB9yNqPF4KwWkWYCt/RmxLo2MU+crUE=; b=EpFZ3cXvWf8Pw1ayoSBTBcda5
	W+0yGCqsMKiyZ2ucSJEX5gx5Ebl/v5EC9z9jDtXvsx4VJKpKe/XBuJD9O1iA/eX5xGK0ERG58KwOt
	hMI7HIL3klodBfsr7aZkXMwfAqQN5q7BSs9uWUuCwg6NsdwAczd7A4n7ZmJnHZcI0miDX0rAWqZX2
	yGRnyEXmqG4cbC+Iy3Nr02P2TaU1ED+UoqECaAFOLBGCbhOBCB6NyP5mKUfPw1dJf3HQ5seSLkMn0
	DDmEFZlRuWEjoYTX+PFYP9EwG7EdCBbILH8WfeSFo3Oz+o6FYGO4/luuvjD76W7X9tD8hy8wkelFC
	ZQl07QvXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7ZpY-00057A-Jm; Mon, 17 Aug 2020 07:45:20 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7ZpU-00056D-V1
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 07:45:17 +0000
Received: by mail-pj1-f67.google.com with SMTP id kr4so7412684pjb.2
 for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2020 00:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7lV/IdeFaROnTVK3UymtO91ZRm82BpFMg/oWsEhWcPE=;
 b=MrVDfelIc/sjxwAOJijrpzWQQEv1xIl+NQFB6fGwQ5WQ272spGtQtfmb6qof90IJgf
 gHLTdKJ7HEeyPRxkfD3CJk5fD6NWZ7RQShx9iWqXYDdmqFuFaDFu2w6f3bHmt4EDHYRW
 FhOsWBD3PxMZJFPNwqJX+BR6jKyreebqtbuuuu8fXzHXXONVuq/UfwERsmbuPsF1l8oz
 fIg43fcI6IgN6hgZQjMxzPqNzrpzMFHgqz3FyxegJltskxH8duAtBdJAcRY9fo7EHDGr
 fSpWp33nzHATTszG4iZd/qHqDKpOLw8gx7tgtcSJmeyKlN9DIa5a5lu+ffJXZyIzCoBz
 42tg==
X-Gm-Message-State: AOAM530fhEdyp5QaTwI64OeVUZa4ljd9vCjjyvFFBXXyP1vE3bJ1yzJW
 8Z/ns5bPJgGw/NvrPE3eCwA=
X-Google-Smtp-Source: ABdhPJwc3Pp57nZKNdvepXWeal+UP84q6OPi8nIMUReBudViwC+01KyFUS7z+21hiJVSOd2GO9Z2yw==
X-Received: by 2002:a17:902:6b81:: with SMTP id
 p1mr10220383plk.183.1597650313674; 
 Mon, 17 Aug 2020 00:45:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c8a:c3fd:4152:60d0?
 ([2601:647:4802:9070:c8a:c3fd:4152:60d0])
 by smtp.gmail.com with ESMTPSA id x13sm15787195pga.30.2020.08.17.00.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 00:45:13 -0700 (PDT)
Subject: Re: [PATCH 2/3] nvme: refactor command completion
To: Christoph Hellwig <hch@lst.de>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-3-hch@lst.de>
 <6e751fee-9e89-96c7-8246-c8af3ecfcdad@grimberg.me>
 <20200815065424.GA15518@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eeab0487-0fcd-92b4-775f-8a08827431b3@grimberg.me>
Date: Mon, 17 Aug 2020 00:45:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200815065424.GA15518@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_034517_053582_F873AA66 
X-CRM114-Status: GOOD (  16.34  )
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
Cc: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> [fullquote deleted, sigh..]
> 
>> Would be better to reuse nvme_is_ana_error I think so we
>> don't need to maintain ana status codes in both places:
>>
>> static inline bool nvme_is_path_error(u16 status)
>> {
>> 	if (nvme_is_ana_error(status))
>> 		return true;
>> 	switch (status & 0x7ff) {
>> 	case NVME_SC_HOST_PATH_ERROR:
>> 	case NVME_SC_HOST_ABORTED_CMD:
>> 		return true;
>> 	default:
>> 		return false;
>> 	}
>> }
> 
> I initially had:
> 
> static inline bool nvme_is_path_error(u16 status)
> {
> 	switch (status & 0x7ff) {
> 	case NVME_SC_HOST_PATH_ERROR:
> 	case NVME_SC_HOST_ABORTED_CMD:
> 		return true;
> 	default:
> 		return nvme_is_ana_error(status);
> 	}
> }
> 
> but found that a little weird, but I can go back to it.

Seems better to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
