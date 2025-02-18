Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983DDC02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLFbDgZbR0W0CngyBzEpaoqcA6347GMjZvFVgoPrQ8w=; b=MyLdxfdaPAPFy5dbgKMQX5md7z
	BMIiLqN2lzLGiiKvGKjBgwd3SkDXyZ61A6BWs+2O4mS8CCx7hFgPVFfOQLEYtNF8qTIK1PiLiePWd
	lxfZGmSyO3I2JCM+ZtbgSZq3QgEXAhgdBGx68jGGh7nxFQUfTEe+zHVikuDfxcrjOBra/5QZ3W8Sk
	XWtfd9/h+jrfrOcy0NALDTpipM6z9BqlmcbjiGOpMK28tNVv+whcHRLp0ykZdFexmYhEZfqkkmYNX
	MmT0XCl4KbJCOHdxuWoHWn1FGfJ6sUnmwiiK/HJWcdBJ3H/seqZ+wMYDFQdM3nR8HEPFRqaXSWXr7
	ux8u/Bvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPmU-00000008oJe-0pWL;
	Tue, 18 Feb 2025 15:45:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPmS-00000008oIe-1tfQ
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:45:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B8332A41236;
	Tue, 18 Feb 2025 15:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE000C4CEE2;
	Tue, 18 Feb 2025 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893503;
	bh=MLFbDgZbR0W0CngyBzEpaoqcA6347GMjZvFVgoPrQ8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlpYIEDpNe9Jq3jAUc/NQkIeaVa9BFaYSxwGxyVm7aJtDpnljgHIx0HFx+qYN7K/O
	 pEFvwifSseDEIz+fIt2+4bj6c9JHJLoAHCNkV3A0FDQDJoRwKZYOD4gRq3VAlB4Fl9
	 AVdZGXOfdCU93WGN76PpQm06eqbwQKCy+2/hM93d5weC4SKWTii3CtXjxUKJPVB4Oi
	 D/gegrZ1TihfmuNJf/j/dmX9bj2dxeUHV49kZZwMkKJ0tWGN6rD5xhTvbiaY9sMmnn
	 REgqC++RvwfHAKq8r6lZGjIaNoQvfM7gh60RcN9hNJ5rIqGP28LjNgk0ZzB2CK+BC1
	 sU6gFaUf/Uktg==
Date: Tue, 18 Feb 2025 08:45:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ruozhu Li <david.li@jaguarmicro.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2] nvmet-rdma: recheck queue state is LIVE in state lock
 in recv done
Message-ID: <Z7Sq_cW000nIwMu1@kbusch-mbp>
References: <20250216124956.3881-1-david.li@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216124956.3881-1-david.li@jaguarmicro.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074504_552495_4B3E19B0 
X-CRM114-Status: UNSURE (   6.72  )
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

On Sun, Feb 16, 2025 at 08:49:56PM +0800, Ruozhu Li wrote:
> The queue state checking in nvmet_rdma_recv_done is not in queue state
> lock.Queue state can transfer to LIVE in cm establish handler between
> state checking and state lock here, cause a silent drop of nvme connect
> cmd.
> Recheck queue state whether in LIVE state in state lock to prevent this
> issue.

Thanks, applied to nvme-6.14.

