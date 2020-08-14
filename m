Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E4EC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 11:53:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE35F207DA
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 11:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0+XI/yj/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZrXEjqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE35F207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+RfP3q7lybGFSYtuuFhMhnXGJX2N7cOlqXkdnVr+FEs=; b=0+XI/yj/c7u56Pr8+fREvGTJ+
	v0S7L9TWCQJbVHuGE2ZzC6UiKNuU7CAvOCwyf9CbiWqtUL3yvoTdn2YjkfxpfDYUw1iJz2T0btKHL
	w4hyNfAivuhE98n/h6kY5OvIfe5FTpABzV7ZREm+r2JRohhfuc8OGMQcml7rox6NdNOuqoaXsfI72
	J38mx6ahg8u6OW9R3gZtBW0yG2fJGDXVThtsbqK70h0KlUJm3veE42xF3+MwA1wMJeFg9cHIehEcK
	Qb937htji6/zgiFdBg3+fNr48QIA9TLUxj8B6iYEIfnGJeM9q8bJZVhfQ8T2UPN3Pv98M8iK+m42j
	zmfXYMsKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6YH4-00040d-Ju; Fri, 14 Aug 2020 11:53:30 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6YH2-000406-90
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 11:53:29 +0000
Received: by mail-io1-xd41.google.com with SMTP id h4so10487755ioe.5
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8RJj+TkYMzHiac1xq1Tf3lQ5iLBSeYwuZiB6gfgnwbY=;
 b=kZrXEjqMlHaOP2Jvq3YGRQ4GTNlXxHsusr71weGy/oFdmmSRzXfR3o4wkjIRXQiIZ/
 6t2FmVkzYveIYXX0fnxAdmZgZhq/VX+bIiZqTQHYr8FIDkvkx6T4vyAXpFlFfmj0Y6Dx
 XHRjn3Agg4TDT3zEe8+OjI+yJw4FrE3xhzk29qa2r5Xw0SxvrPnd7+7UzK3oY9uM30Pg
 O6Q78vHKCkfRnwPQygOuWpBQI9stVRTDDMpU7btgIQ5capgMNBK6BGKNJ7LPa+cl9ccN
 cbJGcwYjd0/uYXrO9BRullrXjFURQD0zsWiL7XSSg7Spemlq63Ff+Uqh58l1q7G06SMm
 IvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8RJj+TkYMzHiac1xq1Tf3lQ5iLBSeYwuZiB6gfgnwbY=;
 b=QJdEklB1tAy7KsYBP3DDrzlb8CviKSG0N4kaqwyb/ATU6a7+lJWgbyqBUsPMvq/tUC
 f+wBxv3i9zrePPCMIHz+A1SP85rr4XdPlyk+yoGApGz/R8C9C9OVgSitoS0QArgPGi1K
 CSKlql2JQ+nXZGrW7UdNkQgOWl6jHYS8iB2hH/5QPq49IRvjuwf5IGdfCdP9qUjNATly
 tEGY+9Ptx7C6MGtCP5T8zAXPGuTtz+uCmm7qGIDi45eu2fpAfU/2eA7e73bVVkpRlVFk
 fyStNBqO5IfkPuuT+N1QRHkFk3HcRvmM0I28YuOpeaT7Tvjjc7rnvnxzmqIy3c3TBU6d
 Ae1Q==
X-Gm-Message-State: AOAM532DLe89wruQwP1vNDJmm4/f0j8rYeZ+WpWAVLswPxN1t45nk5Cf
 RLPzku0Pmcla1e6+WeJipkXmhbS4axJhlTXbJSU=
X-Google-Smtp-Source: ABdhPJwgpaBwFKnfbf8yPBtOw/1ZjX5D1yc5qFmBupXbTSR6wYkAeXzqmRCEIW7DAftD4q0gZBywXbirls+TkmKO4bY=
X-Received: by 2002:a05:6638:214d:: with SMTP id
 z13mr2518690jaj.7.1597406006482; 
 Fri, 14 Aug 2020 04:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814081647.GA10347@lst.de>
In-Reply-To: <20200814081647.GA10347@lst.de>
From: Tong Zhang <ztong0001@gmail.com>
Date: Fri, 14 Aug 2020 07:53:15 -0400
Message-ID: <CAA5qM4BSMiFGe=N9H_YCK79Y2jSurUEbPmdTcaPnVu8cFgmGEA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_075328_456179_6DAB84D6 
X-CRM114-Status: GOOD (  15.30  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Oops sorry for the duplicated email -- I forgot to turn off HTML when
sending the previous one.

Thanks Christoph,
I did a couple of fixes on the commit log, please see v2 patch.
Thanks!
-- Tong


On Fri, Aug 14, 2020 at 4:16 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> >   This patch addresses an irq free warning and null pointer dereference
> >   error problem when nvme devices got timeout error during initialization.
> >   This problem happens when nvme_timeout() function is called while
> >   nvme_reset_work() is still in execution. This patch fixed the problem by
> >   setting flag of the problematic request to NVME_REQ_CANCELLED before
> >   calling nvme_dev_disable() to make sure __nvme_submit_sync_cmd() returns
> >   an error code and let nvme_submit_sync_cmd() fail gracefully.
> >   The following is console output.
>
> The commit log looks a little weird due to the extra indentation.
>
> The patch itself looks good, though:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
