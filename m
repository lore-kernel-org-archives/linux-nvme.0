Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49117606A328
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ozR/O/dp;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ZYf0w5xt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5DXLo6R/kdSN6QGlOTZcY8/4DMXbPtBMmC00YCocIU=; b=ozR/O/dpAJCxMteCo8czTm1YQb
	p7MIBvn5OvgQkvq3ZOSSon6w0pceDTlPS46OHjubZq/J2phWMdM6peloq3QHVFut/quH/9vNBwOsM
	RObA9mBvvIEs4bxT9pGpJIKEZHcimiyMg9NwFudbPd62qcmgpVp+FN+u3SzjZz3xDnC987Uml41D8
	N63uCQJ/KB3LECagWpw3hlP/p3hcBy0qicurQQrjfWL1WhZpNqjj/uIWFj29r5VGTqz+PagrzXZvC
	4tO6G49Opid6MWPo7g5XTcPZcS1OZGmaziNfFa5vyUgbkTfDT0qmnJeZ3VfpBjREjawV7qGNmeaDA
	rWFztIOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJL5C-0000000AtSB-4AkE;
	Wed, 21 Oct 2026 01:25:34 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJL5B-0000000AtRm-1Lg9
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 01:25:34 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-15ea896ddc8so281544c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 18:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792545932; x=1793150732; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k5DXLo6R/kdSN6QGlOTZcY8/4DMXbPtBMmC00YCocIU=;
        b=ZYf0w5xt/vP/Xb83WRN555bjag2gANYI8W+RT1jqmfH1AT7ClsKIKe+jcSuZrKMdi8
         3JBUNtO9fFpVn6QBx2D26xbs5Lmx+CHvibhWXDyaeDlWnJo8Q0EQCb0wXTb3zpAbgO9d
         dK/0clmNaplDNXdQ+sqX1Djyu9aunoaz2OwzU0Be8tJ1ja4s5awwicgpHM7o+bMwH3k5
         xLeClnbkKuRSAZ1pQMYZaSUiXpIiyBF/xFQUedjRFuBlfHBu6LWHBtvxf+PA5ydL0rnN
         Pl7Yh0kyZT+AC3+zApJNlkIvCiLkBul4kP36qiJHIOd3Tqy2WifaYBzuYtJRA2OiM4wM
         zl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792545932; x=1793150732;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5DXLo6R/kdSN6QGlOTZcY8/4DMXbPtBMmC00YCocIU=;
        b=mQNERSLcpnHLqfDYxjmPztao4UgCR66ozJdr4+q9a1QmoGqjQJZbKRpU/MeeEtzIwk
         ZWJz/w5IcrlhJJ1YQnvQKrR4Jj4enI7Iqr3PuZy6JBrKauY7oZ+xpMbD879B3unD9pnP
         TkjDlwXwA5jvhHJqCldtYz0/6kMO/2JBdI3zbcsv2c15gHssaJFwOe4eB0aB8sU9ZFnE
         DQnmBGjkdkwMoF6kyuCU2c4Lrt0py0UWGQGBje0JHnPrAEcePI7NaW6iB703j5xFAFDm
         b4fcNDkxt9XZgtSkdWPR/wg5dwIjiBBHINvVjiX2GBJIt4JxoLoNzvBST17ZtJ6ducId
         40tQ==
X-Forwarded-Encrypted: i=1; AKwUvBwi67kFlLd8chpOLuVgec+5oNztHHDPhV9TCY+XA3ZjAsj54UeT7H+XbK6FNH6UA303MM6s5OSocuNX@lists.infradead.org
X-Gm-Message-State: AFq9FYIwCMqn9vpa8VeienbySJpNXDwBSgNnOYkZqqDvZGEimlWQqv34
	VvpXkZ8/i8OESyz2dj1DK6wSp+LynDfWxugcHNVBGN54BewdMnCBE0aS26a5HNcJaUk=
X-Gm-Gg: AYBFou2eml7x19aL1K+5tJBOR1mJ647DCLbAKaRO6BBdG9QHnNlePvjx6FoTnyfxWzT
	Bjmr0pM9lU1IUbat5ybJSCbv8/dxoka/Sfaw2A++52uY5FZIMlQs4JHZpUXcnTXQv6/J21h2cU/
	unKiy+xkhOQrbuT0MjpzrBq3tfemy5uMb2KOM6SepTFFOikZ+NtMl9PWQPd5puVL2XSlObODEWI
	uLUy4BVvxhMyzPpHidWLsTBz7cxIyLSrfW0OjtCXiv5wRWMNE5AN/TucK8oyoZ2oG6sgTK2jTqp
	syEYLmqeHHFOzYieHcFO3aOGEEvWanNaZQGiE7GUttxg9GWOFfJcISt3dEzXp1LppbnIcpRTYP6
	rLC6wsYGZWYAx8aZDanz4VoqmibLuugw2MsSJPkjtr7QuWY/ciw6LUFTF7LwAVmk26OxHvJTUAO
	19YTV2p/9UPwoL+ALcgjPmui/7eaSGTafQYZNx9CDcK9/sWudgKZBMZVA5h0Mw16r370OCTyRac
	7NedhtvGRwvaEMIgk6M1C4YpFhxMg701u7PGt8dkL1ImSDkcJpX2WEoiDaRnV5nhOnpExJUPn/o
X-Received: by 2002:a05:7022:7a9:b0:187:eb7f:b8f with SMTP id a92af1059eb24-190a50efe13mr997401c88.13.1792545931941;
        Tue, 20 Oct 2026 18:25:31 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1903bb7f098sm2943035c88.12.2026.10.20.18.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:25:31 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:25:30 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/18] nvme-rdma: Use CCR to recover controller that
 hits an error
Message-ID: <20261021012530.GT2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-12-mkhalfella@purestorage.com>
 <8cfb3b90-7629-4a8c-a393-7f724f01c19c@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cfb3b90-7629-4a8c-a393-7f724f01c19c@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_182533_364402_B7463A30 
X-CRM114-Status: GOOD (  13.59  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 11:36:56 +0200, Daniel Wagner wrote:
> On Sun, Sep 20, 2026 at 11:28:09AM -0700, Mohamed Khalfella wrote:
> > @@ -1990,13 +2014,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
> >  	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
> >  	struct nvme_command *cmd = req->req.cmd;
> >  	int qid = nvme_rdma_queue_idx(queue);
> > +	enum nvme_ctrl_state state;
> >  
> >  	dev_warn(ctrl->ctrl.device,
> >  		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
> >  		 rq->tag, nvme_cid(rq), cmd->common.opcode,
> >  		 nvme_fabrics_opcode_str(qid, cmd), qid);
> >  
> > -	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
> > +	state = nvme_ctrl_state(&ctrl->ctrl);
> > +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
> 
> documentation needs to be udpated like in the tcp patch.

Done

