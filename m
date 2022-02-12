Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F833C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Feb 2022 20:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MU4w9d2rupYSgCDtLi7bbVuyryCwYta+2fP1NcZ044U=; b=Av2MEkPvxgzZ5ewvdVpsUHgQdN
	9155w4z8ZvJqgtw1U12awoVrpnIagy+GywAdrcHkYn+afzIZjtWJRo3BD17Kt8ugFZZxXwgxx56sW
	d+CL2S9DN/2w2TDo91mAo9dbnyxgi2rqLQhxqLgCZ0sp9JiNiUKCWbeeQe2riyrdoBKX0aq82Q/8q
	gFhTORnaWXOhJkun4VWmvaN0O6C780f744xz8YQ4F1Kqf56hP647SKIG9p+73U5bl/m4DFvqj3wDt
	0ykOp1qqyGg1B0gdE/VyhrY6n6omT8M4S8BugHRHJzE2VhadkKYMSlhbGi/HBQQiE99K07AvJR81q
	UztzatSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIzPl-00AWaZ-AO; Sat, 12 Feb 2022 20:54:41 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIzPi-00AWZX-4W
 for linux-nvme@lists.infradead.org; Sat, 12 Feb 2022 20:54:39 +0000
Received: by mail-lf1-x12d.google.com with SMTP id o2so23145310lfd.1
 for <linux-nvme@lists.infradead.org>; Sat, 12 Feb 2022 12:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MU4w9d2rupYSgCDtLi7bbVuyryCwYta+2fP1NcZ044U=;
 b=hGI5UaHW/EgIgUQfpg4uAnSAnLbO7TfeKbaENqzh2uyGdS4QLZcl6nnh5PPLH9c0Vc
 iPcELz2wwegKV5dONCvC7jSndmEIg5T5/4nlgo30XlfKwMF/aUeP+5gqRs6/KVKgs8cU
 jJBOVO+HLD5UM3FlG+KActZzUDUK4EUFW7ZeXICtb/XzhuEfMgqXejypRMkdedC1aBU9
 x6yb2qLp+HjhImhUeUFS4jYfrp9zb99n7FPFWomY/Gy8ovxfuxIwNT8PyB2fm6V2hsRq
 ufU+tLQXlmXPXuCwJHroclPxqc92+nqUgxKx7LhmDdg0nN8JxIk5TTrpwq1kIxe9Ne4+
 pkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MU4w9d2rupYSgCDtLi7bbVuyryCwYta+2fP1NcZ044U=;
 b=0geN1jajILVfdeUJkd+n7BqpQBoJdU3C7B06cNtmnHKQ0Jf8TQH85hQUXh2Gp3ELHW
 Y3Q8asdoUOFqAHpn0On5QwMHqBXBjqHPhvX/rkZkrDgP/xUstzLNxC8Hveb6WQtvhcm7
 i+Bmlv7KC0kvNF6qdjVp9JuPP/7wcK0w3lVgzmrF/vKUkVKU7hS/iyE4AO5A4S8WyB0G
 mNF12OIEHOJne7b99LJz/utZy7/KcKk74AXM8uYFSOi1Aje4FErl86SA7z1a8mTeXLDY
 RYDlFVKyO0FEU5x3Br9dUHiCwvO3QwCNatP6zU6FEYjJzqiF+1NdXApRHQHU4xrJP/ji
 8SoQ==
X-Gm-Message-State: AOAM531y0GvUFkXBHabxAaCiaO8yAY09d+Y8zOmoWDgruxj3IOuraArI
 9u5egyQ0wh2NDW7KuoGaP3iXE1f+8BbfgmFeQ34=
X-Google-Smtp-Source: ABdhPJxeMx1A0Rav1mH9g0gcBUjt1Lg7H2o0/+3JBT9gOSe39G8U6PzgB66irhveF9m12dlhvfzWC6Rv1Y67JR/BocU=
X-Received: by 2002:a05:6512:c09:: with SMTP id
 z9mr5246125lfu.669.1644699275297; 
 Sat, 12 Feb 2022 12:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20220212200649.541061-1-matthewwaltzis@gmail.com>
 <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
From: Matt Waltz <matthewwaltzis@gmail.com>
Date: Sat, 12 Feb 2022 13:53:59 -0700
Message-ID: <CABwBYcb0XhomznNOV62uH3Yo1J7XjHowuhF3H36owXtiVSp8JQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix prp list allocation
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220212_125438_210387_7A89D51A 
X-CRM114-Status: GOOD (  12.78  )
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

That is the wrong part of the specification, describing the PRP entries,
not the list pointer. The relevant portion of the spec (2.0a figure
109 page 129) says:

    If this entry is not the first PRP entry in the command or a
    PRP List pointer in a command, then the Offset portion of this
    field shall be cleared to 0h


On Sat, Feb 12, 2022 at 1:48 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Sat, Feb 12, 2022 at 01:06:49PM -0700, Matthew Waltz wrote:
> > Fixes kernel block errors originating from the hard-coded 256-byte
> > alignment of dma_pool_create(). The NVMe specification requires a PRP
> > List PBAO offset field of 0h, i.e. a PRP List must be aligned to the
> > configured 4096-byte memory page size.
>
> That is not correct. The spec (2.0a section 4.1.1) says:
>
>    The first PRP List entry [...] shall be qword aligned and may also
>    have a non-zero offset within the memory page.

