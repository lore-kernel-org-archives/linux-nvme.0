Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0B8C49ED6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 19:45:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230082075C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 19:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T17Lt4ZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230082075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TtKZdYRimdp8yniiD9blHlESquVBVo6Ucs5HsyaWjeU=; b=T17Lt4ZQzv23wKox32ZhgeKf9
	jiyibEm1CUeMnHMSb3b8f5xXUw/q/gvoAq/22WFg3kB5K3/wW28GVoUFJfBqWSmaCerhrOEiTb6Mr
	aaPFaIJQ2Vo4W3Um8X7nRqMxjdqtHpOXvITcfxZYHJMsFYBbuIVc0gmOSOIGDa6pXGepvJcRoktet
	aNlzv0278LnP5tP8ZwFNOurogLZQbNGro1YnACzNkFDS5CXg4XwRx7gzyU7rqXh2wNgX/umiak3aS
	w8JRC5v3/atC2erlQutGbFplUtqE98kH9xUZfQ+YTvyqJuvvlr4hWxFoceiTIaWjGO94PfzgFkxbD
	dWLIC2rwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i88Y7-0003sr-11; Wed, 11 Sep 2019 19:45:07 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i88Y3-00031u-33
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 19:45:04 +0000
Received: by mail-wm1-f48.google.com with SMTP id g207so4853632wmg.5
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 12:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kauS2HMVGyXuXa460gqsS5JPMtgBV1LacptWrfycWH8=;
 b=cgwKD+NpaM7pmNfRZzpdaDExNK2m+OSMaBGKxUrTh+MBIKkKGGCMfpG2YMOp5ZCuni
 Q1m66gUV7uQRd/mGpkyhNLo6rpQvuaJVXKkpOajrD0VJ7BOvaoxiJOk+OZVwx8QZLSC6
 zi/R77oswxMokcr6esRemksvEAVh1r1fVMHY5yY+j7T/NPUTxDWcyvzbqLGup6eIQOeK
 fhJaMxpA3pwdVqqUu/oNJ1VrK4gblVq98dva9rd6lHcI6kz4tvF9zdXERBp3CwCWuI3R
 quDEstzdjIQwW7w03r1IvobwBA/aHAOBjF073xgYF7SWmAroVxsI3gG7jVqxTuJepWF1
 5/CA==
X-Gm-Message-State: APjAAAUW0gUXpbN4z9gQBO9Jr5jly2l3Ld2XT4PbS+yfjWeTiULCpYp5
 Uwft8IKo8OeAd7W2ISLou2NKRWx7
X-Google-Smtp-Source: APXvYqwOpzvH1KBfy5B/A3ny1s+w0cb0mxovnNtSRcLdgIi9FE0IIdJ9NbCHelS00aPFHAAzgGKPcQ==
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr5036557wmk.18.1568231096776;
 Wed, 11 Sep 2019 12:44:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id w12sm33827352wrg.47.2019.09.11.12.44.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 12:44:56 -0700 (PDT)
Subject: Re: [PATCH] nvmet: fix a wrong error status returned in error log page
To: "Engel, Amit" <Amit.Engel@Dell.com>, Christoph Hellwig <hch@infradead.org>
References: <20190831185006.119748-1-amit.engel@dell.com>
 <20190904131447.GA9892@infradead.org>
 <8739B0CD2FC2DC40AF691A1CCBB9896034610E40@MX302CL04.corp.emc.com>
 <20190904151947.GA11034@infradead.org>
 <8739B0CD2FC2DC40AF691A1CCBB9896034610EBC@MX302CL04.corp.emc.com>
 <8739B0CD2FC2DC40AF691A1CCBB9896034611F97@MX302CL04.corp.emc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <baa50dcb-f828-b9b9-6869-dc7464dcf7cc@grimberg.me>
Date: Wed, 11 Sep 2019 12:44:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8739B0CD2FC2DC40AF691A1CCBB9896034611F97@MX302CL04.corp.emc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_124503_156038_F8E0D153 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Didn't see a new patch from you Amit.

Can you resend?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
