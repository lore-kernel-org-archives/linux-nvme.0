Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D80C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 19:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZKXkQw9eK+CamCvobBoAdVEQY3qu/SbwAFPYGWq4Lk=; b=Iuh2PM4kAO7gNWRVA72qmuZukX
	ia74WTXrchuQPSI3yoghUA8KpD9C+KPA5q5buWIZh+3/jO+y2PZf0FqkLD/A4RfE47Na/03J4CglP
	1tzFN1w5k42FeDLb3Fx3k+XkDqWUSqF9SaDA3c9ORKcPci81aFCJEpIzHS1ElDyuLuxdSHJUbRpde
	mK5vg185OpQVeyAwhxuCIwI+krxLZyzjVedDCXboqZUhxMO7Z/swj93S0jLGOunAO1JjQVJ5RjIaO
	dGeW0YnT7m+iLjFiEXu9LAURTRzZWeI5O/awzKHXl0m8vABcQsvVNqr52KhMJlxQg7BeTQuGYtgCF
	diLV4dbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAyw4-004EGI-7D; Mon, 11 Jul 2022 19:19:12 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAyw1-004EDT-3Y
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 19:19:11 +0000
Received: by mail-ed1-x52c.google.com with SMTP id g1so7446342edb.12
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=MZKXkQw9eK+CamCvobBoAdVEQY3qu/SbwAFPYGWq4Lk=;
        b=kx6DsPvRUzSQSUQXL7RMs0v1UdULoADs9pQqYVmttDsyfJ7BTmMdq4mHhhRPkCFzNQ
         UctV1NZzVn35bTv7/+g/73NtCqTGCuzDhPxHN2QnUu8d0S0nZAXnstXzgw6RENpfhyyO
         zszWcNtTR2R0MuRELgtB8SJsWrzKdUMRzZus8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=MZKXkQw9eK+CamCvobBoAdVEQY3qu/SbwAFPYGWq4Lk=;
        b=hKlA6dTbCxik3Vyf+34FLpjeifvu+GM6YKy+3wDU8pRMZEFZ9jAhHQtlXqYweW5uN4
         6PgFBO6I0pQRacg3JgGDep+We+5LkkDU65NlJ3+VYDkQOnXPLea46OLJumWX5q8iBUVE
         f0ilCKYZ7dDK8Mq5gLNszLYfP1ijeF9uKKU18SsrFEe3GsOOecBbqJETd1Gb8YdSaQ7C
         oUj2kUisqCDuzWW5Rv6anvJGIurpSFRNZz2Lh91QjGdU/g451yoP1sjyX8HVmqooThYT
         Al0joobXTkNNMT3ClCndCpbiuS3c5tJLoNv+RgxYyqhdD0jMQ3Hj/JwzJ4gKyE7PqtYD
         1rOQ==
X-Gm-Message-State: AJIora+XxBhyJwPAcFcgMC63vpN0cPrdSv6kZXiIE/WkiSjRoia4HyOQ
	zq0JHtpe0PG2O/BufJgu5bV2WXe3n5Us39KBOycDOQ==
X-Received: by 2002:a05:6402:538a:b0:43a:298e:bc2b with SMTP id
 ew10-20020a056402538a00b0043a298ebc2bmt12746951edb.125.1657567145679; Mon, 11
 Jul 2022 12:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <4cfe8116-bb6c-735d-0bb3-ce5e2612505b@grimberg.me>
 <20220707211245.3989107-1-csander@purestorage.com> <20220708050038.GA15655@lst.de>
 <CADUfDZp-oRUYoXxMwtA5qYux2-AKuimXk-hHWMwwv5tD1ZDUXg@mail.gmail.com> <e906e74a-3754-1db8-ed14-ebc3c78d0399@grimberg.me>
In-Reply-To: <e906e74a-3754-1db8-ed14-ebc3c78d0399@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 11 Jul 2022 12:18:54 -0700
Message-ID: <CADUfDZrJtFvbvZwb-emGwkVUJaNag6TvQoxxt9iAy3R83Ax-hA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-tcp: use in-capsule data for I/O connect
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_121909_273675_BCAAC0EA 
X-CRM114-Status: GOOD (  21.24  )
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

> I think that the question was, does a controller that suffers from this
> inefficiency exist? Up until now the controllers seen in the wild all
> support ioccsz that accepts IO connect to go in-capsule.

No, I don't know of a controller that reports IOCCSZ < 64 + 1024.
I discovered this behavior when writing a mock nvme-tcp target
reporting IOCCSZ = 64.

On Sun, Jul 10, 2022 at 4:05 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> While I'm fine with this change, can you please state here why this
> >> is important?  Is there a use case where it really matters?  A controller
> >> that is unhappy if this doesn't happen?
> >
> > It's just an optimization. Without this change, we send the connect command
> > capsule and data in separate PDUs (CapsuleCmd and H2CData), and must wait for
> > the controller to respond with an R2T PDU before sending the H2CData.
> > With the change, we send a single CapsuleCmd PDU that includes the data.
> > This reduces the number of bytes (and likely packets) sent across the network,
> > and simplifies the send state machine handling in the driver.
> >
> > Using in-capsule data does not "really matter" for admin commands either,
> > but we appear to have decided that the optimization is worth it.
> > So I am just suggesting we extend the logic to the I/O connect command.
>
> I think that the question was, does a controller that suffers from this
> inefficiency exist? Up until now the controllers seen in the wild all
> support ioccsz that accepts IO connect to go in-capsule.

