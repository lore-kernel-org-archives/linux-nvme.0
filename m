Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B56CC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:16:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F61D2177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bOvs1+Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F61D2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3InbPtMAoPYn2fwpj/Ls1m4VbQkB7gAvtqj8Uv1wgsA=; b=bOvs1+IxCRgIiaa8z2HtxiD/h
	QHc1NQnjB+sINj/544RN4R1pMaslC/lmMY72UHCn4GCUhsNMv+XMG2V7LXCtAHBkoaSe60z8myvjH
	myxBPimt6EB+Aw0sXTdZFFkG+oPHG+JCREMYQxGJftKY/Xp4AwA5PNfkzV5XVUtF49PHMoPdSfFtw
	3r1oBB1hA+D6Llm+dUn+GH+Ritlmf9WiOAvN/LCOyRrocs1Ok5NbF95RC9vKKldeSe1ZQQwZ4rovZ
	dUMnGL57PhwsHCM+cvZivsoBT/7xcW8AtBvlRhgDhXYaGZsuTf7PZ6lQeQSYlP3ixL2f574AFUwzu
	iqB8B9PnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lNS-0001TV-Qb; Thu, 06 Aug 2020 19:16:34 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lNP-0001Rz-97
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:16:32 +0000
Received: by mail-pj1-f43.google.com with SMTP id c6so7365511pje.1
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qpckXz05nVu/WCN7CbktW7+FwZ64/8ZbaJM+qD+9aIU=;
 b=GJLuU3GJW/jFzTgo0hMNWAmPxDiUWpJ1gEWJIP2pRNAFNvVfIwVTnyQV2IKFi1ah+g
 YD6aim/khPt8ZiMa2SGPpEQ6m3sTPbiuVGTl0rr3xw57zoX5A99sRyBylgXnzHk+ARN3
 YqxKgkTGiwnk7D5rHvmOyW3neesTW6bFR6am4HR9pxW0oaCfeP7EG3BXikvLTmYsl6p/
 TcASyRojYVbSzEdFIdDZw7EoWupmsJGRV2v1JbrLJZt7eouiECxaBlqEsOw3MShvcEBr
 9eLecO89B+m3agPBH5bq2onDmx+Izss37DTX7G1XWgU9ZJ6zO/vyqhIgEa/ECLm20vO/
 H4hQ==
X-Gm-Message-State: AOAM532yDjpbmA5b+M3BiZgm3a54JGuFaAADbxaHc+KCaMiYr5MuTtfP
 psSZvg81jWBgQviI5V4jzlLkMtbe
X-Google-Smtp-Source: ABdhPJzre7RYAf0nz7SsxVhE9HReqSllyKC/0eRFN5sC0e58V6PFK93+BRNr5IY5VVNHkcHs1pCLGw==
X-Received: by 2002:a17:902:ac84:: with SMTP id
 h4mr9253991plr.334.1596741390164; 
 Thu, 06 Aug 2020 12:16:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id g12sm7813494pjd.6.2020.08.06.12.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 12:16:29 -0700 (PDT)
Subject: Re: [PATCH 0/2] nvme: multipath: round-robin fixes
To: mwilck@suse.com, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200806131932.20017-1-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <05490a1f-4f28-173e-53e1-c00a33d47b35@grimberg.me>
Date: Thu, 6 Aug 2020 12:16:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806131932.20017-1-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151631_383409_2CD64A5E 
X-CRM114-Status: GOOD (  11.11  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

These look fine to me.

Can I get another set of eyes on this please?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
