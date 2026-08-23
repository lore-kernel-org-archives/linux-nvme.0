Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2208C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fnVHc/zwuTwEzErE3/5V7sgRDub5dTEGaolXbQieiF4=; b=zAnUPB+2KnE3cYVz00tHL3MwdI
	WFAQ+pdjhTtWnzQcS4qgPR7T5DSqVq+XbjAItCEOcC1q4rxzbP9Qm7xFIyemdq5lf++LszhrxD9ZQ
	yJwYaPYuJHcfrDR0SRCqHBbz9XiodFQZABFHJ2cHTibbbF3gzT7fqSNRRAMli4NXEewhp7VsVN9tO
	ReqdRIk5b2ovkDhMswU2aVIThNpaE546L5vBjI6oAkSMT0Y2E1lWDti1DArCx6W3y2pdvF8quK6X/
	WnHPqD0Cq1cAzkrIvCrb8n7pe794F5F6ZA7XEbgeGbjnI/bhwRLm4eOCA0vvYRFYknD03nwiZ/0B7
	iayu/MIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwLp-0000000Evzk-2Y31;
	Sun, 23 Aug 2026 00:46:17 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwLm-0000000EvzP-131j
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:46:15 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cc11a30a259so2289519a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787445973; x=1788050773; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fnVHc/zwuTwEzErE3/5V7sgRDub5dTEGaolXbQieiF4=;
        b=FGtXEcvFx+O3Sy3TwvjFt7t9sCj0a3TL+0akijfwYqI3l9rRYH4bXA8//BYkIAO8An
         wAwUutu39HVt9OyWicS/FgEIpPRK6/Lx8Yq6rZ4aW+otY/XgEhs9BwSkXZuglHPIpUEU
         zDABIrtlJR7klWpE5CJLZhHEtB8T5WA7C5kHXHfcL9IKLz+OkO3PRSWrMomNMzZWnOkn
         Mzu+669Gw8uCEmyXB4I79fefE3sRmheSMJJkzRwZVDr9mP1ES/f8z17H5FPQs8mDG7Ub
         3qsI/RdWiu12YSVrIimsYMgacKFj0wdNDPHMqhbQzVRm+O1htEdgURliWkOgh5Qan+nr
         drhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787445973; x=1788050773;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fnVHc/zwuTwEzErE3/5V7sgRDub5dTEGaolXbQieiF4=;
        b=Dw623Ph7ilHfRcNXNqnNcqA9JimCBDbPyHh0gUB9qSYGneLBrNR1IblxCjsmHHCC85
         o7w5LzJGYdLZ+lFISefvE5dUIDj/8685Eu4uoykNl0ueCxtDIZO9Z/dHThxeB01qRpRT
         0yneHcvar+VmeyL6+M8oqImTwH0xTdNLnUyVJ1Nm4mU/ybNrEjuvxIyO47VbYwBkHabB
         8gm6VZENn/PQUUUPK1Mwc7jX7ofSqUH3tugGg+LPVfRzGiodIwvOEvX9D13akisXErqL
         7Mn5JqopVDm+Tt/z6v9uPOwFgOa7B7OVMQUAar5vV1UCub7PxLT6653QpdHVopqbq2aU
         qxyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHfXZ56vJ7P28ZmXxzmNZFDtFNCj3qHN7j/59d4t+lXgSeHY92wZJqKZcnReyQjBCGyl1X1NZmGmaC@lists.infradead.org
X-Gm-Message-State: AFuF++n0CIAwePd6HA/useEgDNGr9kDjxOrUyNTjG38vLvaav0nBF66b
	qoqJybRIqb42KPWpopxHAN1RVL88Qk2L1wrdu+0TTCTSQx4aNOU+G0FLIC3/cAcqZ6A=
X-Gm-Gg: AR+sD13siV8vW3SE8yP7KXyDfV8czNv4R0//qE+Ma5lzEvOEkHU1aZPHRzqO6FjdRiY
	BSF7T24qsBnCC0MKOwjxeZXQ/SNq0HD+Iq1vnTF0/EZWTFN67Q9AfSj9g0z5vsPExWxiE++cU6N
	dM+lORYVuoWEMPoC/dgXqhGzb93LwVOPnXtPwRjdHNS1shO6cBiBzqA4zpURO811MWtvdgdzYu7
	0MYDWykOj1hlk799YK/Uf1ULCgsNfmlIFkCCrBA3P35BHsLXXNbGfxBkBd3aZj0x0Dp9LJ31auN
	CTOjj5I1ZlvVAPL1FzQDkecuYckhl61aL51LAIvdNnTVmRnOWQWosw8Rixs6q6rEDoMsJKZFKJ/
	czmzQK/FaclvGEAqS6ku+FP8oqN8scAt/Yy676UyrttwSifvSXFxFkjBo8Fajsxzw18vLqDrgtl
	gVqa7pi5iSTExDA4jCOjX3Mhz01gKkwgBKvhzovHy7t9W6/RHGbP8LnGOPcJZf87gsq4I=
X-Received: by 2002:a17:90a:fc47:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-395df5e76b5mr16161366a91.16.1787445972541;
        Sat, 22 Aug 2026 17:46:12 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1418619d6e1sm12928109c88.15.2026.08.22.17.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 17:46:12 -0700 (PDT)
Date: Sat, 22 Aug 2026 17:46:10 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: [PATCH] nvme: remove stale namespaces by NSID
 range during scan
Message-ID: <20260823004610.GA1842415-mkhalfella@purestorage.com>
References: <20260821203854.3897938-1-mkhalfella@purestorage.com>
 <5e602a4c-082d-4b7a-a594-acdaf7bca9e0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e602a4c-082d-4b7a-a594-acdaf7bca9e0@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_174614_459360_EFFB4F99 
X-CRM114-Status: UNSURE (   9.64  )
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

On Sun 2026-08-23 00:31:49 +0300, Sagi Grimberg wrote:
> Remove the 'Subject: [PATCH]' from the patch title, other than that 
> looks good

Oops, looks like I messed up the subject line. I will send v2 shortly.

> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks!

