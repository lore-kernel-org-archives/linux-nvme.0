Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9938C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oV15FnOiK3qrN6m7rw8T+w587d5djQ832h5bYVIceE4=; b=SnzCshk0HV7cghczyjNBieIPi2
	qvIjydOvcoj6m8M6gTv6FXq1hrUY8awJxGW6gLP1/CcF/AdfpV7Lk8tBrkNaFtunWQXpuxfIzcERl
	pmbCjpanWCogg4rgMYRiONtYLKjC8bKao7I3HMMR4VJg+LMamNIB++ERt1bEpcWhGOhuGLcIQg1Jo
	sVPmNeqqvX3qF+1jfeY9M6a5uQyip+g159vPY53feiCyb6CehTGBLjGuSn3c8HQ0d8PEz6OgnuD1Y
	/qTkGU7rC84xXbDHzEBZZ47cz3h64P+CRjWHZOt/n2MKRXkLxFGw2TEEJqfVXfT+fClqQzC47UCPq
	Sdw6dOSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogs3o-00A47h-8n; Fri, 07 Oct 2022 18:27:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogs3l-00A46k-5X
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 18:26:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 13AE061A53;
	Fri,  7 Oct 2022 18:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE775C433D6;
	Fri,  7 Oct 2022 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665167215;
	bh=oV15FnOiK3qrN6m7rw8T+w587d5djQ832h5bYVIceE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJE7l+ffSZSxXmK5EZLirCYCgdrYGmJWbefCdCDAPZyoiB4sKRWPUkkcZgUqUQ3MJ
	 u7ccDYwfGOmr8Q3Iwm0nOWQRrN8/bdFi7yL4JP4g5hdRPZn8Kd/W0OlihIaapnrC3n
	 rPVzWVux3Ncb8FRHQtlLtA+kYKb0JUvnJ3iYF06s/5XIuPKgwNekN9MjbO1ShY2z0s
	 Kb3u5+0W7MpgQSjl3ysn5zc4v+5GTZohA9lbFMF4Iw4n2b71PYWMMTZ9pWqTe+RtH9
	 P4LfYpPFS7gD1xrD4k4LIWcl0AVvp6GgtS4Lx5ljFZzgjgSwBXxsK8FqgH39BH1mV3
	 faH+Gzq/OjHYA==
Date: Fri, 7 Oct 2022 12:26:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	javier.gonz@samsung.com, gost.dev@samsung.com, joshi.k@samsung.com
Subject: Re: [RFC 0/2] nvme : Add whitelist for admin commands in passthru
Message-ID: <Y0BvbFxg5in8H31o@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758@eucas1p2.samsung.com>
 <20221007132256.2543136-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007132256.2543136-1-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_112657_278913_F9C12E9E 
X-CRM114-Status: UNSURE (   7.82  )
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

Just fyi, Documentation/process/coding-style.rst recommends against
using the term "whitelist" and has alternative suggestions.

I'll try to make time to provide more techincal feedback on the patch in
the next week, though I am travelling for much of it, so no promises.

