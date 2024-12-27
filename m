Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E40E7718B
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2024 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UeAktRNLz1XAMs6JbO+355tQVdJ8YXCmpLHKzoFH8ng=; b=D7dyA89GKmLGld2XucKE3gj7fI
	ZeXsfvCkD/ik9bzCJNKBEM+l9S2fXOe6H+G/jSGxrMxS6xb/L+Wj1R9GecmvuPAxadggJLXlvq62b
	sxxLust1fyyAv5NfbMmZHcV17TyYFNdJxLbGpFzRB0hjMib61wLczbfL1BDlnI/aIFDUpkeTWy9xA
	9bTwqjhHFsljQD0DOQzIcmMhSrk/JOcO+Eq0Wf8s3VvJsTsgbamqedrLc3AOEt29t8vwu8z8KpKxG
	G8JNr6ksyBW0+/YN7Z+IXArduc0p+e91D7sy+cLtHcu94WnZdmCQaJEmqIYjiqmpPzZJL1+JEWFCo
	xET83t0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tRHg5-00000000x6N-1zeW;
	Fri, 27 Dec 2024 21:15:25 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRHfy-00000000x5w-3Fdh
	for linux-nvme@lists.infradead.org;
	Fri, 27 Dec 2024 21:15:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4ED0BA41A32;
	Fri, 27 Dec 2024 21:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6089C4CED0;
	Fri, 27 Dec 2024 21:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735334116;
	bh=EJCFd/qfgAI3lxqp8taLMBhSb4IVP6BjURVbcX9Y/H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zg2oW7PxbdarwTyxJH9wFeN/KRQE5bKMoZvHguEodzuf339anAv0NnTCinwBGKkpG
	 JD5S3NAnfzG/v/aqBOv/zNHoDTXU61uiRggbVv6X7WforJjVItTTrADM+TvM1XSF+3
	 TG888ff4Hwpt5fSmxdEsK3lRxclJ7dGi+9RkwzUE4OweYFgCFW6JuyN0rYoD2FbPLt
	 pmnlMFTvVuXNtUHKwC4gzJdCs8vTpuIPab6i/B466C5IvFN5wfWt/TnbXcleOCqEtW
	 0bLM1u/r+Gb70YJdUSBvjoHQXUnQqJCw4361TLLEF/YS6WpHAHm5ePgAu9QxcB4Nxs
	 LUkIrybPv1qQw==
Date: Fri, 27 Dec 2024 14:15:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Leo Stone <leocstone@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, csander@purestorage.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] nvmet: Don't overflow subsysnqn
Message-ID: <Z28Y4XRagAT9DB3z@kbusch-mbp.dhcp.thefacebook.com>
References: <20241218185000.17920-2-leocstone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218185000.17920-2-leocstone@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241227_131518_884346_DF469D1A 
X-CRM114-Status: UNSURE (   8.23  )
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

On Wed, Dec 18, 2024 at 10:49:57AM -0800, Leo Stone wrote:
> nvmet_root_discovery_nqn_store treats the subsysnqn string like a fixed
> size buffer, even though it is dynamically allocated to the size of the
> string.
> 
> Create a new string with kstrndup instead of using the old buffer.

Thanks, applied to nvme-6.13.

