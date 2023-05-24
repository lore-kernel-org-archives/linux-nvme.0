Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA946C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xDdxMxnM/UR4lyQQgSAAeQjgcOKG7c/jpKWf/caDdgw=; b=dbmHl8HLQlka5XX5LFG8vzvnwA
	m5+9iDmdCPNKq04UYL35rzopcxAC2ZMErpkMEAWOhORLbkpPNNjrkRBspJx/L0DHb18K88Q+ZEW1U
	OUlnQHfZ8YmXqvE5INM3vzNZIMioQx2moXtOaykOQedMg/uHK31ASs+KoC/yn3oz9SQBjI+LkktsV
	NHBWpso44+HJhK04tw+V78Quasb0S6TJrDZS0L6moaMygnGT4kc4J2mdbS4ID3jksRmu8uLNZkXdp
	suNHZMqUkcb1lAQE4gOOdVoDBYsj/icj8u/rzXcdZY7SsYsjC73VAutBGLEMOFDsJGWhijGBJWI17
	R6exmJNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uXk-00EWW9-2w;
	Wed, 24 May 2023 19:53:08 +0000
Received: from mail-io1-xd63.google.com ([2607:f8b0:4864:20::d63])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uXh-00EWRO-0R
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 19:53:06 +0000
Received: by mail-io1-xd63.google.com with SMTP id ca18e2360f4ac-76c64ddee11so38206939f.2
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684957980; x=1687549980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDdxMxnM/UR4lyQQgSAAeQjgcOKG7c/jpKWf/caDdgw=;
        b=UtPHpOJJU0SRuQUlam0qgURi8yySqdcZa51HO2UemWWpAWz5ncKPWCB5mN8cquQrPT
         NH2OhzE1mtUFdQvkJ44pophOBNnqiMxQN2h6BTEX4kPBrW1QSZVc3FIaulg0e8xks3Zm
         hdm9boJGA1j68H8RPAaE5Jk0boxWaP0BwFIId8u0uS0Pz5gDeiGTYCmYrY9v99XvS5wC
         nTb1EB/1JCDcdM18WpT7vCnSduEfPq6bWN3HyBtpag8iwmjoIpGBkupWKGOaYY63jWEt
         TubZuuIBp6UV11lXAbt+cMU3mwF+FPfXzp3TuHXXTeUjyUH30+hzqUtxZmXoF7d5s5/8
         +5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957980; x=1687549980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDdxMxnM/UR4lyQQgSAAeQjgcOKG7c/jpKWf/caDdgw=;
        b=mFnYpDf6Qyv9uVFNxQpYhTmHUME3q2KQoNgsZBmbV5zp39EgjyKCuG+XPbp9/ZQ4tU
         ioFyijMEuREqM1N+cch+MAPEmQ6vu1aglRmvdRoJZtJ0zzw7SuJisxyIzvHHXVu+04JC
         CAzU8LYZTomOJuyCUilwpRWwOlau7UgRHjYTQfQc19bkbDfMFsJ8ylCMTyEe/jS2Jp7B
         QaPxkF6uGlK8MsiKxGKJ7di2+mHwt/a71JEYEudET+YB6uPbnHNNHLfPEEI9g6fED6Db
         TVv/z6w8m1DcNCM6YyC5tNPx9sS2RC98LmdREPLPwBkWqnSlbwSKOvsvg7Y6qnSEe+6O
         7Rjg==
X-Gm-Message-State: AC+VfDzWf00k21tLKf5y3WvdYbW0knK+mpCRxjfz23CAGBZqHH3KnH6n
	o1tDErdas9au7rvb7SePYIwrj5dno02/EDbpcv7RKBmkx5a0YA==
X-Google-Smtp-Source: ACHHUZ4o9qgcQt+xhMJHTIz5608Osh/OI/K/xjQk5pratoslqd+DeoyrsK/Xt8IYxWJV+IYyaDhKBjjv/aFn
X-Received: by 2002:a5d:924c:0:b0:76c:6674:243b with SMTP id e12-20020a5d924c000000b0076c6674243bmr11491097iol.15.1684957980672;
        Wed, 24 May 2023 12:53:00 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id h133-20020a6bb78b000000b007749424dbc7sm153501iof.26.2023.05.24.12.53.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 12:53:00 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 35BC020BD1;
	Wed, 24 May 2023 13:53:00 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 31DC3E42CC3; Wed, 24 May 2023 13:53:00 -0600 (MDT)
Date: Wed, 24 May 2023 13:53:00 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] nvme: check IO start time when deciding to defer
 KA
Message-ID: <20230524195300.GA1361172@dev-ushankar.dev.purestorage.com>
References: <20230518183311.3224326-1-ushankar@purestorage.com>
 <20230518183311.3224326-3-ushankar@purestorage.com>
 <20230520043422.GE31780@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520043422.GE31780@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_125305_178206_4E5176B7 
X-CRM114-Status: GOOD (  13.85  )
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

On Sat, May 20, 2023 at 06:34:22AM +0200, Christoph Hellwig wrote:
> I also can't really see a reason for the barrier here

In this version of the patch, I have this bit in nvme_complete_rq:

+	if (ctrl->kas && !ctrl->comp_seen &&
+	    nvme_req(req)->start_time >= ctrl->ka_last_check_time)

and the code that updates ka_last_check_time looks like this:

+	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
+	smp_wmb();
 	ctrl->comp_seen = false;

I used WRITE_ONCE and smp_wmb here to try to avoid reordering of writes
here, as I didn't want nvme_complete_rq to be able to observe comp_seen
as false while ka_last_check_time still has its pre-update value. I
agree if I wanted to do this properly, I need to add a smb_rmb and
READ_ONCE(ka_last_check_time) in nvme_complete_rq.

However, the read of comp_seen here is a (probably premature) attempt at
optimization, which may well be completely unnoticeable. I removed it in
v4, and as a result the READ/WRITE_ONCE and barriers are no longer
needed.

