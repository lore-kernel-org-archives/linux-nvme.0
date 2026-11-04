Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C5606EEA5
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=br/xGWLb;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=J8FOFiqP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FR9ISTDLDcSmV8QN0XnoAmz6g1DwpZqiIgX15CQUaGg=; b=br/xGWLbdnvKQf
	1iJOS9+QA22WwTX5UyuKm1hXJ6NPjOvid2nVOaiDJeBc3gc9czAVZCem88QPyI/cujKjfTmgKBIAI
	Rz088nTClPcczHqbW0lH4NEg0baZsrDqirFn6GVEB0unK+yvcmdssOutfJ597DftPi1SLmSdA2Pv+
	xD59/UjvwvxoytwGe7WGYYQeAtaoHxaJq5YCeJtzoCxPwDZLz+0+Z5FNVATRgyBj1KIoGLjVBSuB3
	jYoUlAE5rQNCMnaQtdfbIYkdne019Tu/Ucg8L7gjChZGLJG6Ji3e68ENWChGsEn9/dn3OjWvxtWNS
	pqDRth1jWNkl+DT6mEyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOg5O-00000006S65-24Na;
	Wed, 04 Nov 2026 18:51:50 +0000
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOg5L-00000006S4m-3yyH
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 18:51:49 +0000
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-353804b591eso1972176eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793818307; x=1794423107; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FR9ISTDLDcSmV8QN0XnoAmz6g1DwpZqiIgX15CQUaGg=;
        b=J8FOFiqPvHXuwRL6D00fvbMxR3clxZRBMo/EDENAjwBAIpr4O34hmGUdkA/hEnAiJz
         QidVx3jWOz2G5adqpb9uA8uxBT+GD75/g+Uog1XLlHHriGtQ3ZVA1fDDkBV0lQdPyvIn
         kzYUDn/zzOQxtBF1ELcvBWQh5AEjV8I8FQQsewZZXfsedPdnpfjpvI0jH9rLVzv9mY0p
         gYRmeqXvdRayJHnh/u8ILhRaqE6rm72KPDULhyHq3+U30IZdrDkGctAwfl+9uFfOtVm+
         wCO4PWK9ogTICT66CP+ASGVqFZy7s+EY4QzBsfoTxeDCP+aGxPi7GAbfSKN+nLD1oZB3
         c+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818307; x=1794423107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FR9ISTDLDcSmV8QN0XnoAmz6g1DwpZqiIgX15CQUaGg=;
        b=PuT7KkNkkov07n6cnlHeoK0YTKfRL5xZuIpL2QlU+UOAwkPYh0OJCDd6J3X2+pqRQn
         U2/nL7KjXHWRcDcwHMI15Zy1O7rx1inQgZjjaeJC3ufE0giIdnmz+Yc7dEVXZW7U1I2b
         F43quIGdI+uw0znszph5AdsNZS811h+Otxym2RoZkliogFrRJc0c+llO3Jcn+YXYtY89
         sCrZr+f0kQZAchyml6cZFMJgyR3du7NxkVxNDa29D1wdCJoEmLElGHJwJkePYlddK8hk
         CnL0lQLbpqtnkElYj2WmVu8lFuNKgPIqPVhzE+JBDyu2C+TvEm0XTZ4e/19G4inlmKRs
         GX2A==
X-Forwarded-Encrypted: i=1; AKwUvBzuDbuzevHo099bV2hCyE6ZliTOKiboPkBrHLG1ASebRu4Uj6mHjoiN8sVZWynM+hjVeUiqwMup+yb4@lists.infradead.org
X-Gm-Message-State: APuU4Z/xG/9RJBL5PwRVb+iIwEXJB/OsNKImhU5BtCbUM1hemSV3r/EL
	4kDMeIF4X2hRPB8Pp6Ynhfsn9CxDKPpx8finUTGXsiQvejdyhzXi/x29Rm5aVtobkWw=
X-Gm-Gg: AYBFou333cjnZVP46JVFtehpRyBsQGgBtOY41Nb4kpf8PlC7rln1o9AegTLQ9WeYWJC
	tDeR1DTu8x23pL0YKHb+rfYU1LVbazYxPeIBzxaLRGbX9J4YkzCfKayF9yDiLh32KHn0uc9UIy6
	3clNNRtX0LDwZ7hKmZMvVDu2I1LsPh5kn7h+9KbghEbgVkS+TQzflGVEkqRwWl1SO69IWoFjs/Z
	m/O6wCyMFD8SmedWRLzbEICd98aMRtfKtjB9UuHFlWTuKAjHC7YNdguCpBPwwHBG6HVO/1E7fap
	lkHyxc55801HHT4l8saUqSFC0IyD8JSwlT/8Wd1h41xtvhy0X4fFkbtceWjjNwA5u0SPidfYSvd
	Y0WWyPt9YJSMVAiTTFpZRrnTdcxuBiUOALM9H9hs9HCUjqwVkjv1q5s+SwO+DbMvyxF6PC1SpJ0
	eJNfwy2xDGWLsk+44g2ROe8CUR0uE56ZuLBrxPc4xL11LiCQZLewqFlqyeV+CXdiEylc4wCD5De
	egqusfjZMf75edBaaavzJpvZzMm+k/bKG1jAj/cdbX+7lxUghopJea83fLdmwu20bXpirBjfFP+
	cNlzOj0A0hKw2i8eQj579P87grrNmcwr1Q6K4TSsrOh2BNsS/j9r2RriTFf/vReh4up+7+nwmjc
	=
X-Received: by 2002:a05:7301:6498:b0:36d:bf43:93ee with SMTP id 5a478bee46e88-36dbf52d6cdmr849344eec.28.1793818306527;
        Wed, 04 Nov 2026 10:51:46 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3966daasm12193389eec.23.2026.11.04.10.51.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 10:51:46 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: sashiko-reviews@lists.linux.dev
Cc: Saravanan D <saravanand@crusoe.ai>,
	sashiko-bot@kernel.org,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: Re: [PATCH v7 1/2] nvme: add per-queue sysfs directories
Date: Wed,  4 Nov 2026 10:51:25 -0800
Message-ID: <20261104185131.92361-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-197419@kernel.org>
References: <cover.1793800758.git.saravanand@crusoe.ai> <656dac7329c8452efe786b0c76a3b8c0bbf53159.1793800758.git.saravanand@crusoe.ai> <sashiko-outbox-197419@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_105148_000102_0EE7BD4E 
X-CRM114-Status: GOOD (  12.20  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 02:17:33PM +0000, sashiko-bot@kernel.org wrote:
[...]
> [Severity: Medium]
> If sysfs_create_groups() fails in nvme_add_queue_info() after
> kobject_init_and_add() has already published qinfo->kobj in sysfs,
> should the error path call kobject_del(&qinfo->kobj) before
> kobject_put(&qinfo->kobj), just like nvme_remove_queue_info() does?

I'm surprised this sequence went unnoticed in the previous versions of
this patch, since the error path has not changed since v5. My fault
injection runs used DEBUG_KOBJECT_RELEASE, which would have exposed the
directory left behind, but they set fail-nth on the task writing to
/dev/nvme-fabrics, and fail-nth only fails allocations made by that
task. nvme_tcp_setup_io_queues() starts each I/O queue from an async
worker, so nvme_add_queue_info() runs in a different task and none of
its allocations failed.

I will send a v8 that calls kobject_del() before kobject_put() once
kobject_init_and_add() has succeeded, so a failed sysfs_create_groups()
unlinks the <qid> directory before nvme_add_queue_info() returns, the
same way nvme_remove_queue_info() does.

I have also extended my own testing with a run that uses the failslab
stack filter to fail each allocation under nvme_add_queue_info() in
turn, including those made from the async workers. It checks that a
failed add leaves no queues/<qid> directory behind and that a controller
reset can add the same qid again. It fails on v7 and passes with the
fix.

Thanks,
Saravanan D.

