Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCDEC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 01:38:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5FC61378
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 01:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5FC61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E0iMzIUBsPRS3I3Gq48s9FyGkT+UvuPsNQnFG5PIiKs=; b=Y7rpbzAb2FNHm2vGdqhWWZd6r
	1SFDpi8GMS6JkE51JbMy0hxA9xDJLJiJUC1J6dcJB+ikCnLK8U70th3zJcdj7Sa5AXOjvCbm2OlbS
	AcPd73S5gwjPbGm+WEH50xr5zH32Mwi8ThWgs8XN8aHR9q5Z+EODQ6agLjKDMSnizK0B/XUjrTZXP
	EBKCMnGIfqosjIZcYdTx+iY+fOxoFdghSTg20DFElpB2zsMKpGFXRUT8Cq4fQZxwoDdmRHFf/oxL0
	s2OFKd/MBmS+oy/GHDiC2tzJRNKSmTeBvXAEsW4SqcrGzb6mZ/UeeBjheYD06/Dbvqj060m5T/5Pd
	3g3vEDAVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liogX-00Gfeg-Uo; Tue, 18 May 2021 01:38:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liogT-00GfdM-Ii
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 01:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7Q3P1VwOYAft1YKCOygmE9ay1tXvn5SJhmP0fDliTiw=; b=aV6Tr2t4MJABABNDvwDLYm4CW1
 qqqmUUI1RWdhuxsqPSxvmh0GhII9nFrC6hPvQ/QCYQqAffbF0WAXBDkNLQcY4r3z+fhxxQg4kSR8t
 ecUfYctsDLX1AR6PcmWnqfR4HzF7ABK7sXmhDwulfX5UVwnq1m+3yOZu1cweUmsy31uYpaqqyLd5P
 jCU9GnOc2GB2SGP9hFJVhdUHj6j8P44w90JkRAY78+UZSYJnFoY+8JhzHNiTmqGYGiKU4RRDTL8eR
 7jomtYrwfZ2XV8jFvzhmv/x3aRrh9nzTVAa++jmGxQ27IO6eZH4EHX5cL1noOt9b5SKtPHQrNuQ2Y
 JaZx5WAQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liogR-00EGBD-2h
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 01:38:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 686B5613AC;
 Tue, 18 May 2021 01:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621301886;
 bh=joR1kwBLRXEGNqh0XDIbR3tliaYR6etPUwpRY0RPFis=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lst0WM3lGjqIevI0Z1soODuScyEUpRJV+mxfvlmCDDw7nPpywQiADuWRpvaDWtFj9
 5lFGXEQHeAFpenNDTA5WUlHUPNPQeaxx8wAb+sr1OloezAL0vr+NcR86VH7AEHztNa
 UcHoeDdk8osJ7eofBghgU5UihGLFEX3dg7zzQzzcTjb0MQRzPY5hDNOEANVqT5YpF5
 eYdgpMnNDhXJye7dqrmP5xjP55BYjaQ+Bqn6hjuQx8zwAZtG6Ptaxs5zAv3zpQ+x9+
 kj2utOTYczJG5KV236qxp0RcPgQt/mFI0ze8n1slRlLEi0ntShPr2WX8CQzYuktoeS
 rXidZyKx2tHgg==
Date: Mon, 17 May 2021 18:38:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [RFC PATCH] nvme-tcp: rerun io_work if req_list is not empty
Message-ID: <20210518013804.GC2709569@dhcp-10-100-145-180.wdc.com>
References: <20210517223643.2934196-1-kbusch@kernel.org>
 <2479237f-ed41-6de0-6ffc-bed66046b2c2@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2479237f-ed41-6de0-6ffc-bed66046b2c2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_183807_160313_44183614 
X-CRM114-Status: GOOD (  25.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 17, 2021 at 05:42:18PM -0700, Sagi Grimberg wrote:
> > A possible race condition exists where the request to send data is
> > enqueued from nvme_tcp_handle_r2t()'s will not be observed by
> > nvme_tcp_send_all() if it happens to be running. The driver relies on
> > io_work to send the enqueued request when it is runs again, but the
> > concurrently running nvme_tcp_send_all() may not have released the
> > send_mutex at that time. If no future commands are enqueued to re-kick
> > the io_work, the request will timeout in the SEND_H2C state, resulting
> > in a timeout error like:
> > 
> >    nvme nvme0: queue 1: timeout request 0x3 type 6
> > 
> > Ensure the io_work continues to run as long as the req_list is not
> > empty.
> 
> There is a version of this patch that I personally suggested before,
> however I couldn't explain why that should happen...
> 
> nvme_tcp_send_all tries to send everything it has queues, it means
> should either be able to send everything, or it should see a full socket
> buffer. But in case the socket buffer is full, there should be a
> .write_space() sk callback triggering when the socket buffer evacuates
> space... Maybe there is a chance that write_space triggered, started
> execution, and that the send_mutex is still taken?

nvme_tcp_send_all() breaks out of the loop if nvme_tcp_fetch_request()
returns NULL. If that happens just before io_work calls
nvme_tcp_handle_r2t() to enqueue the H2C request, nvme_tcp_send_all()
will not see that request, but send_mutex is still held. We're counting
on io_work to run again to handle sending the H2C data in that case.
Unlikely as it sounds, if the same nvme_tcp_send_all() context is still
holding the send_mutex when io_work gets back to trying to take it, how
will the data get sent?

> Can we maybe try to catch if that is the case?

Do you have a better idea on how we can catch this? I think there was
only one occurance of this sighting so far, and it looks like it took a
long time to encounter it, but we will try again if you have a proposal.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
