Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30682606A319
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1piWAHo5;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=Pqw4q25d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ip+TnxVMQPR+eirU2Ea4sovkq+dHLiGkFhsxVAsS/8=; b=1piWAHo5tpNaMZWKbW6TugjcgC
	aLN62+bmSYLESC9uuqy4BNFmzuRbjcwVTOtDWF3AhTpW/8IJTUsm8f0gtqQ0+b4iYdkilfbeAl8iN
	AUDjldTz4ApzHCKh8yTlqaFvurCSFRTia368F7aUjhBumtTcOx2JPOsAQvLxGyLv4YTHSixd6fAMH
	a2Pb0LnUpRlo+/ppiJlWrrm0N2GT26oukoODjb3zirCJrqWLkkCbJv+Dym78i/NIUKWXCTE/Iagl1
	Biz3kiDHpfdl634dJJogGxPoYQsrFQ3tfnswej7WKpfpIBh0UgrjGaSZsNDFSCnt0EYM5B8YZkgoY
	ac2uGA5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJT13-0000000BXYC-3M3s;
	Wed, 21 Oct 2026 09:53:49 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJT11-0000000BXXj-2Zby
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 09:53:48 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-3282db206d3so1229995eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792576427; x=1793181227; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ip+TnxVMQPR+eirU2Ea4sovkq+dHLiGkFhsxVAsS/8=;
        b=Pqw4q25dSrAhrIFN673jX2OFE+XquRZXnqGOboVwfAXJxFrb61/9N8Kfxa/H4iVe5R
         r9bWDwEabGaaHjig+QaBU6RKxEpZQ6woh7DkdLDAFT2JQii2AKAVgv5wfiqLhTnojTLt
         MiXnrEFtm6ijoYY/JjJHlDvV2yRdUT9LaGxPY7J15JgnCeEJvu23Ttl4I5Tr3EAkUMKd
         udGQkOPrSZ2R6i9WVI3bHOfnQxixhE5hOYPSzMWUl9JkSmJpHJpMd2bSCMgy3TPvs4Zz
         pgvKM+wWtT0NsxAV07U04EuomxEX/LjqHA/Bc9ku0//jcz6jAXrPVWcF0MKH9JKTmRDI
         2lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576427; x=1793181227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ip+TnxVMQPR+eirU2Ea4sovkq+dHLiGkFhsxVAsS/8=;
        b=A9m2qUuYSph0YUt0Gtdjz9/huiAukmjT7LkNYXVs6N2f7H/1wLQJ9da6SCXiG29YI2
         almkw7nK51mPHDBn40xTA876ZKAmPqUK5NM+BNHLwlQ5rg+lR7jjwLw8eaSJ97oYXNAf
         GfDTfMctOm0XSzoFs/4crVUvYgWz28LQmxKo8yQPBD3vvluM00vh+uUx/PMJmszsX8Pr
         EP37LJPN9aFWPAQYDvr2HiQWqmNQvWX2BxnooQYNAY/7bgjlaNxPdVSkcBoJnGrYu9po
         EEsZowSZ6wl15BRqzVEO49USYhCA3BLLDbJduiQJCtiAQij8DaQKQ6awhz+JrLuI0cjO
         bw3w==
X-Forwarded-Encrypted: i=1; AKwUvBz5nRpnC+RyXrcZf27EZxGSbdz/0GmZHcSOdDVGbsvZPMu8DC9xBH/cBJNPNpQxqFA3ST2jduzW/rXt@lists.infradead.org
X-Gm-Message-State: AFq9FYJgGqFoRKfuwbWfR234MfskrEKeIeyi7texCGVbLJpHJ2Ra0oq9
	qzlQqc35nr3tvkIrkLIXv6Hcg1vs/noqGdp39Ck1y4OmI2Kd35OSQvnNCITuTccCyDA=
X-Gm-Gg: AYBFou0daruzWGNCKErsDsvD56mo7QfmOiSggVyb6GSBxVFBmCa+flZlhOexyUY2Qp2
	ygjUAuRMM9Z1b/8/F3meA5ZGZcQSnPvo4M2DhzEGOtQVUfbbAW3wbXwhXsOzmKwIea2n8bvxDbl
	4FGvti5ZCGzlXwFJm1z3LIPuNUo2j8HF0ZeV/DgzI5nWGPCsj9zTzLzQxIbkPQrxY82XdUDVA5C
	u9+c4W6r5tWLSFOxDzmpDhlmh3UCASepW1yZ0ijqiXc/t+qkHNGFmdtJ4RAU9IgnlAT+9qomhM3
	DpWj5d7Cuv+8A7AP3GxodaFrwH0LR560e3BqSUAQITl8H67Uh3BO12heqxkfr/8ot8zhBpntIbo
	OBoHS5Cq/SzpOADsACY6p1t2uWGzhCcS0WRywKDTUyu24gIJLO2KfwjTEEsF+Wtded98V1FB2ld
	Fna1ULFZIh+jUiHJjk3Vb01YGzuRRrj9mHjDe9PQa8hBJqN6vQZ/rSt+E6uhnQi50qKJs7w5SrV
	NS9lF+6oIfxMNKbKDBPs2+6j3wusXuAqhEs5O0bC7aVq0hUxHMLWH2KpObf/OsfNP9YdgT+tkyn
	rSRj038yPOqbl/8i3UglCy205dMEYxyrJLDvGrwNBmTxxcttVLTt+J4=
X-Received: by 2002:a05:7300:2152:b0:35c:dd03:55d2 with SMTP id 5a478bee46e88-3674db4d057mr3780258eec.26.1792576426668;
        Wed, 21 Oct 2026 02:53:46 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4381:36fd:9c31:126:4a90:466f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8439sm6382582eec.11.2026.10.21.02.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 02:53:46 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Hannes Reinecke <hare@suse.de>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Wed, 21 Oct 2026 02:53:36 -0700
Message-ID: <20261021095340.83118-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <378a9456-35ac-4a18-8c1e-80cc754dcbfc@suse.de>
References: <20261018010059.83120-1-saravanand@crusoe.ai> <20261018010059.83120-3-saravanand@crusoe.ai> <378a9456-35ac-4a18-8c1e-80cc754dcbfc@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_025347_657673_40E4513A 
X-CRM114-Status: GOOD (  17.73  )
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 12:28 AM, Hannes Reinecke wrote:
[...]
> I think the 'managed' sysfs attribute needs to be per controller, as it
> would be extremely awkward to allow some queues to be managed from the
> admin and some queues automatically placed.

The mix is intentional, and it is the case this series is for. On a
host that partitions its CPUs between tenants, a queue only needs a
user assigned io_cpu when its blk-mq map group straddles two tenants'
cpusets. On our 384 cpu hosts with 128 queue controllers that is one
or two queues per controller per VM, and the driver's least loaded
selection already places the others well. With ownership per
controller, the control plane would have to take over every queue of
the controller to fix those one or two, and reimplement the least
loaded selection for all the others.

Per queue granularity is also where Sagi steered the series after the
earlier per controller connect option, since the CPU partitioning
changes after connect time and only some queues are affected [1].
Sagi, does the per queue model still match what you had in mind?

> And I think you need to check for interactions with the existing
> 'wq_unbound' module option; both claim to do similar things so we
> would need to clarify the details here.

They are independent. wq_unbound picks the workqueue type for all of
nvme-tcp at module load, and when it is set the driver never selects an
io_cpu, so every driver managed queue stays unbound. io_cpu places the
work of a single queue. When both are used, a written io_cpu selects the
worker pool for that cpu, and how closely the work follows it depends on
the affinity_scope of nvme_tcp_wq. To keep the work on exactly that cpu,
nvme_tcp_wq needs affinity_scope=cpu and affinity_strict=1, and the cpu
has to be in its cpumask. The ABI entry in this patch documents that,
and I can expand the text in v6 if it reads ambiguous.

> And should be we able to specify a cpu _set_ here?

For this series I would keep a single cpu. io_work is one work item
queued with queue_work_on(), which takes a single cpu, so honoring a
set would need a separate unbound workqueue per queue with its own
cpumask. A single cpu inside the owning tenant's cpuset covers the
case above, and a cpumask could be added later as a separate attribute
without changing io_cpu.

[1] https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/

Thanks,
Saravanan D.

