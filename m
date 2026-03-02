Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BCCEB3624
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 20:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lXArgtNeOFFTWLzxqvomrBwQ5HOchKkFHuGlOYGRG58=; b=gI19mr1Aukzd3grUC8NmNgtLk1
	5IpLS+H4SVvxe/ZT3L7ZMFQc0on+70pFh7ZIKTdoVpx527yXRO75l5O1KUfcIDOha7F/ogIhjUGRm
	51Vx5lxiHhGVAo7Kn2PosI7iOYmqlqOm3uEto+ALolOFUaXucBzAGVeP3cOA3fmDlHpXdZMIB+JHl
	h6AxU6eQLk6TfKilXVigR5ip1QpNIiSB5cB2r2V1RRjjCok1iJfAawUkQbRNaqXXYieUEJ/qID0gK
	NcGkA5Ow+dS1ZXXgTqq0vyQynx0Jp1LQLLM5an81fCLb5apt/raVPSPXplWd/lEvfOtZZ914PJWoD
	Tf/c86wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx9Zr-0000000DmYf-29RF;
	Mon, 02 Mar 2026 20:09:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx9Zp-0000000DmY5-2lRV
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 20:09:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E8689443CC;
	Mon,  2 Mar 2026 20:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CCBC19423;
	Mon,  2 Mar 2026 20:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772482152;
	bh=lXArgtNeOFFTWLzxqvomrBwQ5HOchKkFHuGlOYGRG58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKZv81Xnk90MAJfH9wqL59EOs90/ssBfqkjY+NKUPdv6jht8hOwHfZiQZ3ByukByK
	 RTuiy48luVmE3qYANeEUtfpqB2Vb7nTRCgMohe5tye88z9Vq3DGKYe4RKy7sFxwIJ+
	 RmvrnUi4aM08EWDaUyTa/0xx71wxihX84C3wlgA/BwiGlcP2uQsKehIQ+dAzbY0okG
	 FzNNVzV267snWjWITHXU4EXL1pQJ/cazZduXFPWI2iRnpWeJ0GMrJD+lX+GrhmmB7V
	 KWJ/pl0WWlDUlDWMomxT8LE6Hdv4iLsqsnQ3UQCpxZH3Yso0BHXs/kuMJH93/UA1F1
	 YF6CKeUrkrG4Q==
Date: Mon, 2 Mar 2026 13:09:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, hare@suse.de,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 0/4] Support PSK reauthentication (REPLACETLSPSK)
Message-ID: <aaXuZuJfPchclSQE@kbusch-mbp>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
 <CAKmqyKMN+g3hRuLwMwF6qnce415O0ZAG56AoUgm_=wDX8Gwqug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKMN+g3hRuLwMwF6qnce415O0ZAG56AoUgm_=wDX8Gwqug@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_120913_714774_49753992 
X-CRM114-Status: UNSURE (   6.30  )
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

On Mon, Mar 02, 2026 at 01:42:05PM +1000, Alistair Francis wrote:
> This series is ready to merge. Can it be picked up?

You're right, thank you. Queued up now.

