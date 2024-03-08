Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26244C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTNnCVlqYR7Tb/MCVbLKlm4DSuUtZRcZgvJGq6O7n3M=; b=R7CgUD2cmMxNhmJCdAnZ3N5LD1
	47/AcIWMh9nNXBji81FsopGZyamGYcP3UZ+geFUnPOX9b5vFyDIgGsmqYE3lbTdGhGap3xL8MfBAR
	m6U7P3qMyhr2XrS9+E/nDoZ0YjYB/JKusW3mAG7vmvxyEUVt6Z7V5fY4RIEZWq7gFEYTpaS/yU1oZ
	SLA4TJbJDfTTsmR31d1VcXBr6os/Q6nfkZW7ULGb3B0u0nVoJ4OnDZzNQuCy0RPAwRwBKe9cPiVlV
	5nJv8XFxGoWefXgtid/MG6UI3eUytmPTJY/KHcJKcVtQdw0SRUusaemam/HJzRhAcfD7mw+k7n5CT
	vz7i9QoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridOG-0000000AHcD-31Ez;
	Fri, 08 Mar 2024 16:48:12 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridOD-0000000AHZk-3DVW
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:48:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D9C61CE2923;
	Fri,  8 Mar 2024 16:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4CFC433C7;
	Fri,  8 Mar 2024 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709916482;
	bh=qTNnCVlqYR7Tb/MCVbLKlm4DSuUtZRcZgvJGq6O7n3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wx+dNemty4zAGHkxSAUtcr89ecXisZOa1RqMDAjSG2FjQZgpxJEvJqpot23bX+WiE
	 vNQy+BDDhIver82slHVrNhwhCOrPVQyxsOVUEWPTBN+IalSLbgR8COLNiohhFXf6cX
	 8mJ4ITtXN0J1HorrlUIUOOLDxBO7CEq+uSAmFaBZNr7zEHqcPSCs9ZfsEOcYtDRs5Y
	 2wbJUp+U+avcyRLtM1wquG/345ZSqzUiG5KEnk2xRjdMmWnbOWbohaCUN6UuYE+GdI
	 bYkhz2n4cH7Qlpz19TeaCmK1SfuzoelALqluhF7GFFuN73PCh2DqMwaD6moblW0Q6J
	 ZayRiAl2SMdKw==
Date: Fri, 8 Mar 2024 09:47:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <ZetBP5YPUnJ2V4Kp@kbusch-mbp>
References: <20240308015435.100968-1-brookxu.cn@gmail.com>
 <20240308144208.GA9194@lst.de>
 <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
 <20240308163100.GA17078@lst.de>
 <CADtkEecyqONmjRorKOWzToH9y1SVXf3GXXvg_BHcFZ506mPWkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEecyqONmjRorKOWzToH9y1SVXf3GXXvg_BHcFZ506mPWkA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_084810_036086_91C75779 
X-CRM114-Status: UNSURE (   8.89  )
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

On Sat, Mar 09, 2024 at 12:43:12AM +0800, 许春光 wrote:
> Sorry for delay to reply, I found the patch have applied just about 10
> minutes ago.
> According what you plan to do, I think as-is maybe fine, But anyway if
> need, I will
> send another patch to cleanup, thanks.

The next pull request will be late next week, so I'll back out the
commit if you want to submit something else before then. Or you can just
submit an incremental improvement against the current tree, and that's
also fine.

