Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D0D606A31E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=acUHZv9v;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=kkPq982a;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Whiek4t1;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZupRC7P;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Whiek4t1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=x4CmADp2ir7n+E8mOlnp3JESSQ5fFcEi+jbhhp5rGtk=; b=acUHZv9viwvi2HH2jixaStNCDR
	hJ5ryU7+swaqJDb2pQ2dzHXyHkpV8FwgCs0+mG1UIOZJeGC7S0a5KktDMKKmAbDmw2kZZrZFR4P68
	8wLqLKbxZCw47xYFhCuhb9OfMpnkB1Lqq7a6j8C17CUTHMawC5v+9p2mclm/Zse4ZHrnGGt7h3a6D
	2k0DXdfNj8o+S/kUDBJlJt6pq5utC9IFFWGKrjqKHKGL5CJ4eZbHoDtRybjzSTYWf5FNkt281xOGz
	bnJYFXt9DMQ3PA0WN0wQNHO3m+zUVMKbEyR7+V+t0wEPsgNpcwDqWSWq+iOksCHsDb+F4rzSVEjlJ
	kTT1jPqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKEJp-0000000GI4y-2aeG;
	Fri, 23 Oct 2026 12:24:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKEJn-0000000GI4q-3Ifp
	for linux-nvme@bombadil.infradead.org;
	Fri, 23 Oct 2026 12:24:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=x4CmADp2ir7n+E8mOlnp3JESSQ5fFcEi+jbhhp5rGtk=; b=kkPq982aN0Fc++La/+w3SpVABe
	QL/TgfJgjODTfoRlehMW68e5gZq0wd2Qbhvoz3WueoCmOdnA2GgGteXxvWZ3yvN87AgqVZez54OFG
	G7E+w4/Eb86deCaoBFtI8wy44R62ZW4C5zgKBh5b5c+NWRHwjgF0h/d7T38Md3EEAr9GHAbT+ikIO
	SM3xyc8r7ENfwm+AyrZ6NHOui/1zZbME+P/GhTPgy03oLmyWkM1CQl9TCbQw7xnJLxKnay1IC2ZtH
	UyXaQPGxtwz4smvvlLIIa2KatUxIZn2E4+bRNx1Diyr+svPZkhIwPSeHp9LqgDw3HavOusg+PAA2N
	7KAq84qQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKEJk-00000009Yhd-3uhG
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 12:24:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792758245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4CmADp2ir7n+E8mOlnp3JESSQ5fFcEi+jbhhp5rGtk=;
	b=Whiek4t1dF5vq5Rp9QIk5h4oi7Og27esZER22QEBRhQat+C1M6MtF/uEBSWeMiTLqiChtL
	4vbZESs0/mBFDDWFfBqQJeim1aAO03Qw+VCvxD7Kj8MXoCSBumEmvIE5T/xXRRw7/EScUH
	c8cx6doqkCW0KVUI0icA0BYC3cJDTo4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792758253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4CmADp2ir7n+E8mOlnp3JESSQ5fFcEi+jbhhp5rGtk=;
	b=hZupRC7PMV+pu1EQysYVpK558VGpCsmhej1CeW11hcGWEwOXCoy/QEH1ZnqsFQ5WVl2sLp
	haBLfT/cbkfn0MchN2Z2BgxDiCDWz8wWgcJOTiyQS2EPkrsSbObCGfF001BgiX6NX1y8p2
	HmQdf/hYv+fXeUiVLAoJltFHMXmQEUw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792758245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4CmADp2ir7n+E8mOlnp3JESSQ5fFcEi+jbhhp5rGtk=;
	b=Whiek4t1dF5vq5Rp9QIk5h4oi7Og27esZER22QEBRhQat+C1M6MtF/uEBSWeMiTLqiChtL
	4vbZESs0/mBFDDWFfBqQJeim1aAO03Qw+VCvxD7Kj8MXoCSBumEmvIE5T/xXRRw7/EScUH
	c8cx6doqkCW0KVUI0icA0BYC3cJDTo4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-CHJDW6xEMZqCQT8L7LpFbw-1; Fri,
 23 Oct 2026 08:24:02 -0400
X-MC-Unique: CHJDW6xEMZqCQT8L7LpFbw-1
X-Mimecast-MFC-AGG-ID: CHJDW6xEMZqCQT8L7LpFbw_1792758240
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47B6E1944D26;
	Fri, 23 Oct 2026 12:24:00 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9E881800444;
	Fri, 23 Oct 2026 12:23:55 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Seiji Nishikawa <snishika@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex is held
Date: Fri, 23 Oct 2026 21:23:51 +0900
Message-ID: <20261023122351.977034-1-snishika@redhat.com>
In-Reply-To: <526673b4-a090-47a4-9181-e30813a8cbe5@suse.de>
References: <20261014064524.4015025-1-snishika@redhat.com> <526673b4-a090-47a4-9181-e30813a8cbe5@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: IZFP1QvVRSiXLrQGF0DT0hvgR5C_RSxGm3xTpDOZPsQ_1792758240
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_132417_188374_F51A3552 
X-CRM114-Status: GOOD (  43.07  )
X-Spam-Score: 2.7 (++)
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

Thank you for the review.

On 10/21/26 12:10 PM, Hannes Reinecke wrote:
> On 10/14/26 8:45 AM, Seiji Nishikawa wrote:
>> We hit this on a 6 CPU VM running a database on nvme-tcp storage. In
>> the vmcore, 2 tasks held send_mutex of 2 queues and were runnable in
>> lock_sock_nested() for 103 seconds, while the kworkers for those queues
>> kept running io_work on their CPUs. All database tasks were in one
>> cgroup, which got only about 0.3% of the CPU against the nice -20
>> kworker. Requests timed out, and blk_mq_timeout_work() waited in
>> synchronize_srcu() for the tasks still in .queue_rq.
>>
> How very interesting. I don't think you could craft a blktest for this?
>

I do not have a reliable reproducer in my lab. Reproducing the hang
requires a particular sequence of scheduling events. The task holding
send_mutex is preempted inside lock_sock_nested(), a higher priority
(nice -20) kworker looping in io_work, waiting for send_mutex to be
released, takes that CPU, and then starves the task holding send_mutex
of CPU time indefinitely. The kworker keeps looping because
mutex_trylock() keeps failing, since the preempted task still holds
send_mutex, and the pending check (f42d4796ee10) keeps the kworker
running instead of letting it return. It happened on a 6 CPU VM with a
database under heavy load. So far I have only seen it on the customer
system, but there it reproduced every time.

>> Only do the pending check if io_work could take send_mutex. If it could
>> not, the task holding send_mutex sends what it can in
>> nvme_tcp_send_all(), and queues io_work again after it releases the
>> mutex if requests are still pending, so no request is left behind.
>>
>
> The direct send path again. I really wonder if we need it at all, or
> whether we cannot simply delete it.
>
> Can you try if you see a regression with this patch?
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ba5c7b3e2a7c..2c59b550e13f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -405,17 +405,6 @@ static inline void nvme_tcp_queue_request(struct
> nvme_tcp_request *req,
>          empty = llist_add(&req->lentry, &queue->req_list) &&
>                  list_empty(&queue->send_list) && !queue->request;
>
> -       /*
> -        * if we're the first on the send_list and we can try to send
> -        * directly, otherwise queue io_work. Also, only do that if we
> -        * are on the same cpu, so we don't introduce contention.
> -        */
> -       if (queue->io_cpu == raw_smp_processor_id() &&
> -           empty && mutex_trylock(&queue->send_mutex)) {
> -               nvme_tcp_send_all(queue);
> -               mutex_unlock(&queue->send_mutex);
> -       }
> -
>          if (last && nvme_tcp_queue_has_pending(queue))
>                  queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   }
>

I cannot try it where the hang reproduced. That is a customer production
system, and I have no reproducer outside of it. On the kernel with the
regression, that system hung within 12 to about 50 minutes after boot, 5
times in 2 days, under its normal database load. It has been running a
kernel with my patch since October 15 under the same load, and the hang
has not come back. With your patch this hang cannot happen, since
io_work becomes the only sender and the trylock in io_work never fails.

What I could do is a sanity check. On a 4 CPU VM with an nvmet tcp
loopback target I ran

  # NVMET_TRTYPES=tcp ./check nvme

on 3 kernels: v7.3 (base), v7.3 with my patch (seiji), and v7.3 with
your patch (hannes).

base    passed=49 failed=0 not_run=12
seiji   passed=49 failed=0 not_run=12
hannes  passed=49 failed=0 not_run=12
per-test results identical

The 12 not run are the same on all 3 kernels, skipped for reasons
unrelated to the patches:

      6     nvme_trtype=tcp is not supported in this test
      1     command tlshd is not available
      1     driver scsi_debug is not available
      1     kernel option KASAN has not been enabled
      1     kernel option NVME_TARGET_DEBUGFS has not been enabled
      1     libnvme version is older than 1.11.0
      1     Remote target required but NVME_TARGET_CONTROL is not set

This is only a functional check. It says nothing about latency.

To apply your patch on v7.3 I had to drop the !nvme_tcp_queue_tls()
line as well, since 08acb54b063a ("nvme-tcp: defer TLS inline send to
io_work") is in v7.3. That commit already skips the direct send for
TLS queues, so the io_work only path is already in use there. Two
small things in the patch. empty is set but no longer used, which
warns with W=1, and nvme_tcp_send_all() loses its only caller. I
dropped both in the version I built.

I agree the direct send path is the source of this family of bugs,
5c11f7d9f843, a0fdd1418007, 70f437fb4395 and this one, and I am fine
with removing it. But I think the two should be kept apart. This
regression is in v6.16 and later, so it is in every current stable tree
and in the distro kernels based on them, and people are hitting it in
production now. What stable and the distros need is a small fix that
only changes behavior for those who hit the problem, and that is what
this patch is. Removing the direct send path changes performance for
everyone using nvme-tcp and requires a performance review before it is
introduced. Also, it belongs in the next merge window rather than in
stable.

So I would prefer to take this minimal fix now for v7.4 and stable, and
do the removal as a separate patch for-next. If you agree, I can write
and send that patch with your Suggested-by. For the performance side I
can only test on VMs, so latency numbers from a real nvme-tcp setup
would be needed from someone else. If later performance measurements
reveal that the direct send is unnecessary, the check added here goes
away with it, which is fine.

Thanks,
Seiji


