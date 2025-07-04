Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D053C83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tkPHJk2uXWlHI4Mxw4g1nxzFgbqq3tguuk0UsLEAPlg=; b=EBY2bqwPYjS+2V5E9OKDKJJUfq
	wmsB2S32qIxLska9kjnyRmP+YzzF2HlOKwxRcwL7enKOcoGkIuXIzmBtXaC6ZyPNReoebDjMzntNT
	5F11nGQFkApxjy7if3KhymSpL00jOC7fH8I9JfiQe+clRdTMbmaoA1CmtBOS1MtD7nXVDd6K0FMbx
	PdXxCWUH/gJezPiqMJv8ouu8P1ntlPZXLrHSge+Y0KtfX1nQG5M5HNOvTfZRHSp8kkiKKCrrojPb2
	0O6XVhAdnUB5laOZ1gOAAaazuHc1MbqFaJdEf4pK+KIx15pMbWd18O2jmKL9Ta6mIE6Zhitt0/EUp
	HUj1YtYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXh6B-0000000EcTe-48Ke;
	Fri, 04 Jul 2025 14:09:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgjo-0000000EZ0W-0YUN
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 13:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751636759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkPHJk2uXWlHI4Mxw4g1nxzFgbqq3tguuk0UsLEAPlg=;
	b=Ojeeem8l5M6jvsl05EQhwaMpV3lux+et2um9h0IjQLYIjf8s2zyygEf7MgN6JmpNH89vc+
	nJC8CtnYprhJ1bFGNC1vf6SDPPmf1pibRh98s8kWNe8A6ElP84rygnou0I+u/coavtgCxX
	LT/ghsppDvzzDIpa4DbAs94PBa+hr4c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-z_wk5qcnMz-wlEr9aDYT2Q-1; Fri, 04 Jul 2025 09:45:57 -0400
X-MC-Unique: z_wk5qcnMz-wlEr9aDYT2Q-1
X-Mimecast-MFC-AGG-ID: z_wk5qcnMz-wlEr9aDYT2Q_1751636756
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b3ce96f8dso6756861fa.0
        for <linux-nvme@lists.infradead.org>; Fri, 04 Jul 2025 06:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751636756; x=1752241556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkPHJk2uXWlHI4Mxw4g1nxzFgbqq3tguuk0UsLEAPlg=;
        b=jXY57rKGhgSPDU4jTINa1/jrorYoufAVo0Qmj4boT56o9sr3+0X0Q0qF62/dWs2A2o
         O9avYI0xzyOMFmzi8nAmhM6wt0v1cD2HGKKk9r8JFqR1v7zh2gYxji6Su8TJrHzU4xbV
         yMV7CtqrJIHbhH+Fi3roGRNV0YQNIe+jzUF6gdBQfr320jjrGZCfLjeTdNHygP9+FV0X
         gzAwSWvgBgjKh4TN/XrouPOK7UxTDC0qWB2MQnjbEXXV6OCuqhMUhreORZCvGVwyY4mR
         I0dc0hEUvyksGWnb42xUw7F3351CrcZVuDIoBIPBoWhqNQ7M/pbGpoZhNdftTJ7BGpol
         VTRw==
X-Forwarded-Encrypted: i=1; AJvYcCXKBP4sjc0XXVMnRs//IE4sziWzy6jNpIb1lW8Wt5njSv31tGyr0Y/H7KvnYw5Lm/rDmI2H1HvmBVR1@lists.infradead.org
X-Gm-Message-State: AOJu0YxivxzleyrhVP3iL5kS3Tf3uqHxyEMKOAKv4pVE7BX68ZL6WY3c
	v+CMETMhOOluGyPY3u71vEbyPBHMZhX/ZzIYxqrHmPuZdtcQGzz7yaiz/zc4h3LyxdHkRu7hvw5
	Z7zhxPwksfo/Os84U3jH/no3BbqJ2AyfLqdRpWVATIc//peuqmOXDyZmzH2jt1Mk2wbWDe9pV48
	1A4OL0T62SREFW3h71RIL15V50aWITZrxHtlimae4gjvE=
X-Gm-Gg: ASbGnct54xpbv8gx0hIbOlhwp83DqcCq+pBjqQgdcpCt0PCL1Ubt2R8bA1hHB7oZdSi
	Dmi0rZcuXAN5z8H5bbx9v6P9crOfxp7Dvkkn63UodbORpBf48IrCKajD8Sj96C+rG9ZGYxmS2dj
	a7ng==
X-Received: by 2002:a05:651c:1117:10b0:32a:88ca:ec18 with SMTP id 38308e7fff4ca-32f00c8743dmr4988871fa.10.1751636756099;
        Fri, 04 Jul 2025 06:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDaCSGy868gDxBsVUCZbBLG4zEY4+MQEyN6LRLn504s7dPbdj+PyCWVX8AYjCM6scFou+rAYHlTN5pxmQKpjg=
X-Received: by 2002:a05:651c:1117:10b0:32a:88ca:ec18 with SMTP id
 38308e7fff4ca-32f00c8743dmr4988801fa.10.1751636755647; Fri, 04 Jul 2025
 06:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de> <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
In-Reply-To: <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
From: David Jeffery <djeffery@redhat.com>
Date: Fri, 4 Jul 2025 09:45:44 -0400
X-Gm-Features: Ac12FXzMam9AFzueysq60aOEJnJ-2lq5eOA3iIbIXJ_nllFIOoxd8lP-71CVRjU
Message-ID: <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
To: Jeremy Allison <jra@samba.org>
Cc: Christoph Hellwig <hch@lst.de>, Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Martin Belanger <Martin.Belanger@dell.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>, 
	Jan Kiszka <jan.kiszka@seimens.com>, Bert Karwatzki <spasswolf@web.de>, sultan@kerneltoast.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iT-z1Ko2AkejzP-pt8dOTNo6JhoEF-EQ5AfPqhdpl4Y_1751636756
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_064600_238087_A112EC5D 
X-CRM114-Status: GOOD (  19.19  )
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

On Thu, Jul 3, 2025 at 12:13=E2=80=AFPM Jeremy Allison <jra@samba.org> wrot=
e:
>
> On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> >On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> >> Address resource and timing issues when spawning a unique async thread
> >> for every device during shutdown:
> >>   * Make the asynchronous threads able to shut down multiple devices,
> >>     instead of spawning a unique thread for every device.
> >>   * Modify core kernel async code with a custom wake function so it
> >>     doesn't wake up threads waiting to synchronize every time the cook=
ie
> >>     changes
> >
> >Given all these thread spawning issues, why can't we just go back
> >to the approach that kicks off shutdown asynchronously and then waits
> >for it without spawning all these threads?
>
> It isn't just an nvme issue. Red Hat found the same issue
> with SCSI devices.
>
> My colleague Sultan Alsawaf posted a simpler fix for the
> earlier patch here:
>
> https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
>
> Maybe this could be explored.
>

Unfortunately, this approach looks flawed. If I am reading it right,
it assumes async shutdown devices do not have dependencies on sync
shutdown devices. This is not a valid assumption and so violates
dependency ordering.

Maintaining all the dependencies is the core problem and source of the
complexity of the async shutdown patches.

David Jeffery


