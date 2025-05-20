Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55921C5479B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HCI6Et/OdobKBGQ5E1bXQ7PwsUZV848DjSn6TZUJeUU=; b=ZJpOozV7PVBbiN7ZfyvmkAfGTO
	tR85DgtmZMqOipKco8BaLLmyVIAEEylyCcOSL/qx547mbMq+y7LxFhIkgfN4nZ+8R/PgKfDI7myqZ
	r4EJQ4AzTI6blhz04v2Z2NuEfgFpuEbnxmS9o79ES4UpVbjFoEsutdluXy1kkInWsAgHCxbKhcpDX
	717lNkLyP/7TvPTLjqWIUtHKrRPaRGUQJRBRksQ9q+coJdEi8UlcT23Y2q7FZRnINp3TWyI/SqFbh
	epIxB5/kT4q7Dh3I6DrSXjaj0ZIh3zn3G0Rt0HJevorCFC0OIonLmgWQYggWzK0E2qn82w67EOug9
	V+60/J9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHNj3-0000000D7gW-2RAa;
	Tue, 20 May 2025 14:13:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHNj1-0000000D7ff-0NjZ
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 14:13:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0F3955C4BBB;
	Tue, 20 May 2025 14:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4DBC4CEE9;
	Tue, 20 May 2025 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750425;
	bh=dGluI3urTIFsxw0widqt9HOdsA3/5BESE287K6pFLo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPRwZhPOvMiIqYvV+JaD8htPYFlAtPFlUFVmphZykrdlO0JsBOfAne/13RcgQQKsA
	 YiLAHgnlmSDsiC6FxsB1Pi55cRVmLpfb4WkLpvcMyAA8EzyKceBlnvN8x9yOFwly5T
	 AMMC/l6xbBjvbmBeWzT5MGMaLCovVecRKZ4wJHYDnhRtsymrYUxzxhoAy+JN4JFj0f
	 NpzU2Ub0qAa+ZqqXkt06fP7TkKTwDr/uZ2XUInlDBnm7UQWo1Ti9UmFSvfPMscqaPn
	 Q4UAu8Uf4QhS3tnJWvtMAkdjwpYOevBB5N+iNhyUmJKFA1SFxGLja0LN/S8hzlJHh8
	 N0NULWQh3TMTg==
Date: Tue, 20 May 2025 10:13:44 -0400
From: Sasha Levin <sashal@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Xinyu Zhang <xizhang@purestorage.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.14 295/642] nvme: map uring_cmd data even if
 address is 0
Message-ID: <aCyOGIDzSaI4p47X@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-295-sashal@kernel.org>
 <CADUfDZqvwhL3Hz7_u+TsO5XrpeWX9dHtbehXUtwbJdyi_GXT_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADUfDZqvwhL3Hz7_u+TsO5XrpeWX9dHtbehXUtwbJdyi_GXT_A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_071347_185166_5AF151E5 
X-CRM114-Status: UNSURE (   8.67  )
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

On Mon, May 05, 2025 at 04:15:47PM -0700, Caleb Sander Mateos wrote:
>I wouldn't backport this change to any releases. It's a potential
>behavior change if a userspace application was submitting NVMe
>passthru commands with a NULL data pointer but nonzero data length and
>expecting the data buffer to be ignored. And supporting the data field
>set to 0 is only necessary for ublk zero-copy, which is introduced in
>6.15.

I'll drop it, thanks!

-- 
Thanks,
Sasha

