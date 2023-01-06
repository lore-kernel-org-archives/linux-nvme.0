Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897D9C3DA7A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 19:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cRQcg+V/OIQU6jgQxgR8EDTJ50L7a19dGlLRweOPIp8=; b=s328+XQQKD+vUai21xBhhz4wL6
	wa0MMD3w9ECA5pM5S0bteZsbPMqzTYBZ6kYxk4Y353nCgZwxfSeo8nn44Grich8CwbYLDAsrgddrP
	Stph4SqbJUJTNGGKvzzWY0SC2p//94OWm3eD9u/eJL18LI1p91vmEQtGo7JBDPrJUjZCkKb2Wse83
	OOuatYrQDYxceze9bqrTswsCW/vUyRTcif4QRZkJdjom42i/qxPEByDhFie9U8wE75rMzhuLSI8jD
	uXOONs9vIpBx95ZfWEmK/hoV3wAKR7yZ1F/KVsp92Hpm52rQ1nE+HdWMX7Aioa8L213ijKXyni1EY
	N2LW+cGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDsOw-00EaoJ-8V; Fri, 06 Jan 2023 19:29:14 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDsOt-00Ean9-03
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 19:29:12 +0000
Received: by mail-lf1-x136.google.com with SMTP id v25so3337843lfe.12
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jan 2023 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRQcg+V/OIQU6jgQxgR8EDTJ50L7a19dGlLRweOPIp8=;
        b=PMlbh/muuHFuOMsJjBhSZ0n9seFbnY+SwgAlhxFVfE9Py7cQwBUNAHy7K30wu2MyiH
         LodPGQq7kG3FkpzEOBg4wvu0O835AFff5yFDb/b0YOu0DrwnQy1voLe59yOV2OAUMXqz
         BWAZP20DNFiJaIZIHam5hXO1yTWQu7/eyg7b5Kk9Y3+K4DidGHQyE4qANmmuE5wibRCk
         9gkEB+8wLyzKLHes0LG5tEOPKN6y2gRX/a+8MI3QNftFQmkj43ZRgVIGpXGDIRwipTvl
         fQiG/u5JCbjdSML8bw9SBDBl+6GCa7nkgb9HRwulESNQbwxEpS3czz0x36RKCLHJOOSh
         dipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRQcg+V/OIQU6jgQxgR8EDTJ50L7a19dGlLRweOPIp8=;
        b=Z34yPDX1vfZKi9fIKlj5Z94XNpsUNvUGm33lWRE2woYqrYH5TxUFNDTt1Xtqqalqx8
         8WxDXfpPKUOMplUviusst08hdxIGpnqJFrLQ3oCvA+oX3eknP2GLkxLlmEl2xxbjsQb4
         6EKKQjgM/nmLfi2XOpSBxsO+fRb0H2LP9QobvjxSmCjCGnQXdIeYyTXwtDgajDZHwszE
         sqUOWU+9ymZ+v3ch3jwPl2IbHS4k+oOfkJWdNyfjzBqQLs5HfeFtX2DmUjOBB7tB4DI/
         nxPCVvzc4KRuLgIPayfiAOi4O+LrCULIyh/gSXNNNum8YXyEKYW1nFcQIDdcCZPH7OOR
         XmuQ==
X-Gm-Message-State: AFqh2kqqrhv4C7CW6iP5lo0FEKmqBI5paeIlj2W4VdKjJML5DJC/LHpQ
	6d1nP+kAPkc6YWl7aGEXJJONyrvkd2oDsfINmpsUlF34KZOMQi5s
X-Google-Smtp-Source: AMrXdXvNILkaDVBndSnvN0bR/i4NFNf9opcXdkE7BX2uBl6JkaZ1LcJo9ZzYXJRd1oPxVip1ICT4bgJqcviR0fXXmD0=
X-Received: by 2002:ac2:4e8b:0:b0:4a2:6907:98d8 with SMTP id
 o11-20020ac24e8b000000b004a2690798d8mr2167761lfr.28.1673033344404; Fri, 06
 Jan 2023 11:29:04 -0800 (PST)
MIME-Version: 1.0
From: Nick Neumann <nick@pcpartpicker.com>
Date: Fri, 6 Jan 2023 13:28:52 -0600
Message-ID: <CADqNVToVWkJHSPbYqJRgnFjdMt3N_-UkCHZtHVTRhpGNThX3Wg@mail.gmail.com>
Subject: Option to never do BLKRRPART ioctl in nvme format?
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_112911_091985_CD5737EF 
X-CRM114-Status: UNSURE (   8.34  )
X-CRM114-Notice: Please train this message.
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

The nvme format command, as its documentation states, issues BLKRRPART
ioctl after successful format.

It feels odd that after a successful format, the format command can
still return an error code because BLKRRPART ioctl fails.

When initially added, the BLKRRPART ioctl was issued but its return
value was ignored. Later[1], the return value started being checked
and returned. And over time [2,3], cases were added where BLKRRPART is
not issued.

I'm wondering if all of this, combined with apparent race conditions
I've hit where BLKRRPART can fail after successful format, are a sign
that there should be a way to do an nvme format without BLKRRPART
ioctl.

Maybe format should have an option to not do BLKRRPART and instead
just always do NVME_IOCTL_RESCAN ? Then the caller can issue BLKRRPART
ioctl themselves if they need it to happen?

[1]: https://github.com/linux-nvme/nvme-cli/commit/adf01d2d6a03c5e48380004cb4971a5b9ef89b4a
the return value started being checked and returned.

[2]: https://github.com/linux-nvme/nvme-cli/commit/46e0baea19b7ed8f6f9c639f8da82d2bb944c561
BLKRRPART ioctl is skipped when lbaf is the same or all namespaces are formatted

[3]: https://github.com/linux-nvme/nvme-cli/commit/6420c58b510ddba290500d9b75fef9e9c980e0c1
BLKRRPART ioctl is not done when a character device is used.

