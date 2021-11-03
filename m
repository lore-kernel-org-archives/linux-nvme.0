Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9B4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 11:31:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5909E60EBD
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 11:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5909E60EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rce6TkYuBu2kn5orT6d1ZhrGBQ4dubcOaxibMEQ+xnQ=; b=QMPWIedTrDrPyMJvfA0JQlkEMH
	8+LFKMBt5sC7w/NNJlYECRRXTmQWYTu+OnLzi+iFC79iZYf1q2/j6TVsMm1spEl3a/FVMVo22K7U2
	97JFNIq4DYPfknksuZXJF2ikBfrL8aKnSH7NefZ/1DtRMGZ6RrsX+rfmMts7UiEUPmH7mOcK9SCRD
	Umz9w1iETWjwVX0b3hzNSOjAi5im3XPZJfrpNZ1KVXx6zURozA9qNGqDPAF/11al81ZHJYVVpjrLM
	kkZ0TYbMi0AofIqoKxVS38zGmmPCGtUX9rX3jcDSsM62MAWNaXBh9nlGFXfDGmtNyvZaHEmUZp1cr
	6OK2TeVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miEUV-004xNp-AO; Wed, 03 Nov 2021 11:31:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miEUS-004xN9-L7
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 11:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635939095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rce6TkYuBu2kn5orT6d1ZhrGBQ4dubcOaxibMEQ+xnQ=;
 b=a1tECOSYrkb9Sgyk57CvkwPjVcjEoMZoDed/C5qp8HsvGc7Pz08gRdc40TJH0SAHEFLoOv
 TsroeipsH8o/gCELqP7B7+inr7CF/d7UI8N7iBm7io7kFgDzwLOxCMdWNVNwKbQ8eSUOvu
 TS+kc5Ai7fzdMHk2XBwLLhELrKDmJ0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-G30fHIcoNrKUeywRyB3WLg-1; Wed, 03 Nov 2021 07:31:32 -0400
X-MC-Unique: G30fHIcoNrKUeywRyB3WLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC17D10A8E01;
 Wed,  3 Nov 2021 11:31:29 +0000 (UTC)
Received: from raketa (unknown [10.40.193.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11D0D101E58D;
 Wed,  3 Nov 2021 11:31:27 +0000 (UTC)
Date: Wed, 3 Nov 2021 12:31:25 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue
 and io_work
Message-ID: <20211103113125.GA106365@raketa>
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_043136_787977_7EB7F2D3 
X-CRM114-Status: GOOD (  22.66  )
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

On Wed, Nov 03, 2021 at 11:28:35AM +0200, Sagi Grimberg wrote:
> 
> So this means we still get data from the network when
> we shouldn't. Maybe we are simply missing a kernel_sock_shutdown
> for SHUT_RD?

Hmm, right, kernel_sock_shutdown(queue->sock) is executed in
nvmet_tcp_delete_ctrl() and sock_release(queue->sock) is called
in nvmet_tcp_release_queue_work(), so there could be a race here.

I will try to move kernel_sock_shutdown(queue->sock) in nvmet_tcp_release_queue_work()
and test it.

> 
> > 
> > > 
> > > > * Fix this bug by preventing io_work from being enqueued when
> > > > sk_user_data is NULL (it means that the queue is going to be deleted)
> > > 
> > > This is triggered from the completion path, where the commands
> > > are not in a state where they are still fetching data from the
> > > host. How does this prevent the crash?
> > 
> > io_work is also triggered every time a nvmet_req_init() fails and when
> > nvmet_sq_destroy() is called, I am not really sure about the state
> > of the commands in those cases.
> 
> But that is from the workqueue context - which means that
> cancel_work_sync should prevent it right?


But nvmet_sq_destroy() is called from the release_work context,
we call cancel_work_sync() immediately after but we can't be sure
that the work will be canceled, io_work might have started already and
cancel_work_sync() will block until io_work ends its job, right?

> 
> But that needs to be a separate fix and not combined with other
> fixes.

Ok I will submit it as a separate patch.

Maurizio


