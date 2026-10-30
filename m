Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CB60A260D
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O4T85m6S;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=VWIYSNPj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KYQVknesk/PjoruS2vxKw66Tfbsl/Qf3EhfTxc7KSpU=; b=O4T85m6S8KuMGAVPtbIBqkE/9d
	j8S6Jnw+pb6QKkvz2zaXE3ufQEjHLlGlWHZ3LjXT1JcI0dwRoK1lswJmy9So0P+QuLNOJQlS0sJAw
	IIktz0JDIBFfDbA4NZr2az5m7MCuXaFg0MvWJmQxcXL67o61aSUvFYDlkqBMlNz0uKwuIoOSsgYE2
	c86ILMUAGpVG06nVz3K+p0RXzl3J8xjhvhn+5HcfG1ACPx9QKIjPlmwqJAhN+o9mJMq7C22jJV1nP
	e8YAWVj2ovvK0jWEExOhePkCIiBTuRsw6lPf1es3TiO1C0j1qVvzUcpxRg6C8zhA2mPCWbYB3Tlee
	9Af6LHnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMuDj-0000000CcFu-0m3S;
	Fri, 30 Oct 2026 21:33:07 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMuDg-0000000CcFX-3kVE
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 21:33:06 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-1931ff67a29so252103c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793395983; x=1794000783; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KYQVknesk/PjoruS2vxKw66Tfbsl/Qf3EhfTxc7KSpU=;
        b=VWIYSNPjT5FN6zsjjsyZA2Tc0asWHN02kCVN0EoeK6fkde2zg8qbRwCxAtQnary2U/
         E+XnQxFJb2lQQvf+PbMOJXg5GOpydSMnkSw8+SUmxfWiC/T7F/mwYK5nhu1sk5W3u+XN
         ObBqgmMuxGDVvPgvVGcH8clV2L26rtiiOxntF0vGiFHPfIKHqfoXwd2rGsc7FajAumRW
         3bJbJtPdO4T4/6bwkdjSNE3tLQqYS2UvFzrPMwK35e03jyB4l/TZkAgvLaygGEbHFq7R
         HwmihX/pXVzZFGSeKPRDOE49jtFTdxlzifoorqvNz3wSnJ/dxaguqjxHwtQfh905HPgk
         LTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395983; x=1794000783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KYQVknesk/PjoruS2vxKw66Tfbsl/Qf3EhfTxc7KSpU=;
        b=VT9kcsdVq2i2xLaNjxOKWy48uhwAFKQ2DlEiQyhnn5BpG8woGcm/svLu0trN1IRzRH
         IukRfCQPx+cTD4/vk/vhziTt5qj2AqaxBD5ustDzQQ2grPRtVD39TCp0Hbj4ytTUxoU2
         CPKmt5xbU+pACHd/KzujjsNc3ybrnYWv4AfkBiLjxxg6W8FA1r5gXWSe/kHpEZRirvWI
         5tmQAANuZSOP0bEoV/a2o8SDJuldUJ4w6hNDIdBxyhH7JSWBG2ONa5IJ2rAbYwLfPu9W
         OLZLdtZ2VgICinGfXSrKs+SzqsOHhJA8aBlyH1/xRI+ZIRJIjuXub1z52IdxOe+Fzqmj
         yZJg==
X-Forwarded-Encrypted: i=1; AKwUvBzIEhhMKY7GqY/3saFfkfzc9NuJEUk01YZKx3qB0QBuTjPLhzX0LTzCKpeHxtN+qMH8q12KZBauGsJb@lists.infradead.org
X-Gm-Message-State: AFq9FYLKxP33bEHDlDYoX1/X7M5oyNBBAaVqOJFGYsQlVQ4u39fQfct1
	TqtkCeZCI5MQ9x8g1VmYhq4yHouLGp60mencFjT7q+8hlvWAv9IkM3dfKsErkvbpX4U=
X-Gm-Gg: AYBFou3E+jqiQ9t8drFxCdau4VQY8XIsr4mYWo3JialG7sgF2D3mVaLEc9vd4t9IBe8
	SfbwezRSuYtrpbAtaOmJ7AkzdM9rXPWNpbpuhRZxxJ9aNmpWdx5WmAjz03lieZiwq0ucqdiaiZy
	zsXfMBJeDVxF6iZW59FsAANGDdMacfbMlO+qNKVJyfY72RVxj917Y+ZOfrqZM9O+zbmgfWEGZ2Q
	0tdTbqp9QE7zyrnZVvF1Gu0O8u5IHbzXWdyTdFAv+rnK5LZcFOcly/Y5PQnqZXVseKuKQpzu9TZ
	cz9AEyIk3oyy5k5D9c3BGHx9djaUuUJJC/QTbUlA5BkfzT+AtTvdjrCkMr0CJNF9XTXcTbzCwbN
	D42Ub/G+cY30GSz3WUfgw5Od/EsoPkKfUk5XAdnc0AlQgMI8LNnWmfvtUFn2MbUmRKIeCAGW2dV
	Wujm5qvS81+SfIeEkV+YhSTU4amk0jGm8h+9VWrPBcTqpjoiBptBuBxl2E5Qn+P9HNgUTz10l3y
	tgDkl9TpVc1yFRq2VFBJ/d1pGEiqIllAWqWq/WQtM6mPaE8NZEVyZxYEiiWBkc8R32AKCtNEjgK
	l+oy/uHFuUyWFLIciahG+JLq+0VxufA7r/+ZFuMouA6Ha7tYY9OrC2ol39TSmYgSW4pc3Hk=
X-Received: by 2002:a05:7022:68a1:b0:1a5:9abb:fdd7 with SMTP id a92af1059eb24-1ac5a0b5af5mr6607314c88.9.1793395982862;
        Fri, 30 Oct 2026 14:33:02 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm208169c88.12.2026.10.30.14.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:33:02 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:33:01 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 05/18] nvmet: Send an AEN on CCR completion
Message-ID: <20261030213301.GG122209-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-6-mkhalfella@purestorage.com>
 <CAPpK+O3+eF=9WOVqDJptwfGdA+=XwFeTx-sMatq=bQLUPhMvVA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O3+eF=9WOVqDJptwfGdA+=XwFeTx-sMatq=bQLUPhMvVA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_143304_958396_5A9FE075 
X-CRM114-Status: GOOD (  20.95  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri 2026-10-30 13:58:46 -0700, Randy Jennings wrote:
> On Sun, Sep 20, 2026 at 11:30 AM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > When an impacted controller that is the target of pending CCRs is torn
> > down, send an AEN to each source controller that issued a CCR against
> > it. The notification points to the CCR log page that the source
> > controller can read to check which CCR operation completed.
> >
> > Split nvmet_add_async_event() into a locked helper so the AEN can be
> > queued while ctrl->lock is already held.
> >
> > diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> > index f5d7cb9c943a..69491e8e52ba 100644
> > --- a/drivers/nvme/target/core.c
> > +++ b/drivers/nvme/target/core.c
> > @@ -218,13 +218,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >         aen->event_info = event_info;
> >         aen->log_page = log_page;
> >
> > -       mutex_lock(&ctrl->lock);
> >         list_add_tail(&aen->entry, &ctrl->async_events);
> > -       mutex_unlock(&ctrl->lock);
> >
> >         queue_work(nvmet_aen_wq, &ctrl->async_event_work);
> >  }
> ...
> > +       lockdep_assert_held(&ctrl->lock);
> Is there a reason not to replace the mutex_lock() call with a
> lockdep_assert_held() call?

No. There is no reason not to assert ctrl->lock mutex is held when the
function is called. I updated the function and added the assert.

--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -210,6 +210,8 @@ static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
 {
        struct nvmet_async_event *aen;

+       lockdep_assert_held(&ctrl->lock);
+
        aen = kmalloc_obj(*aen);
        if (!aen)
                return;


