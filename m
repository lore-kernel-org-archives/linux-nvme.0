Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B887CFF512F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 01:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMq5jl9S5FHqzTDZpU/NsXOHgTj1f992nu/K6QEV5Xw=; b=p03QwLwpbCAdRHBCA9nlsloigv
	a44wiEZWUcARlTW3won49dqTnvmkG2u02pnhlCtMiIv/v+vzS5dojGli9E4NwDlS1B4Td46cjc9mo
	g00zc/5E1+Ov0CeV4cEjQ7g+iHo4gbLi1ynTbHNtYn8rUP+fVaZf86mD7n6m8m5nYjQgEGtvHl5L6
	oHgqUJZ0aZ9Ode9fFwRrzZg8gcKVgOO3kUm7ZYLPpzeNVBL4df1SQ9fBD2eett+Dfg5jfjUDnZtvH
	slfaZGtjMhwbPnn8OmT7ImjG0rGBPjqAGmDlC1f5mruNkn5pte3sk+wt0ZoZ1HHGz3/EkJSnVQEcU
	kHlfWOrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAHJE-000000084Af-3GVS;
	Wed, 08 Apr 2026 01:02:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAHJ8-000000084AI-0azG
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 01:02:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B9B842AF4;
	Wed,  8 Apr 2026 01:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47413C116C6;
	Wed,  8 Apr 2026 01:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610132;
	bh=YMq5jl9S5FHqzTDZpU/NsXOHgTj1f992nu/K6QEV5Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4V9CbZ67DahPQtQuJyNcvAMIz1V+QQuBaPwZ/iqT5TtWr/Ue8ZyDklPYJ8BRs4IV
	 AGqpta0wkklMsGy/cet2VHIPPFTNX8pjhEQM+gKgCxSmZ+vkLVXjcf7Vfg24WdyHWn
	 /naG7RO8mPKCzx2oU8DOVtr5Ax9eMTgqrGrkQcgJUNxIRAXTGAhZ9l8WG/YeDmkJqk
	 zRj5iNjnRQ9FPM/UvasUQNq66q7m4Hg9lUts8c1hmsuaHTXJV+yGsge7giPZo0VR3v
	 DL8BC26otGrz+eD48H6gHKZBvBdMJyjcU4JrnNf0PN/7so3+ccne8sx8APMX0DmUG1
	 HAsIGq4ol2FjQ==
From: Sasha Levin <sashal@kernel.org>
To: Cengiz Can <cengiz.can@canonical.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5.15.y] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Tue,  7 Apr 2026 21:02:10 -0400
Message-ID: <20260408010210.746205-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404212336.1808498-1-cengiz.can@canonical.com>
References: <20260404212336.1808498-1-cengiz.can@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_180214_200920_C98DEA07 
X-CRM114-Status: UNSURE (   6.51  )
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

On Sat, Apr 05, 2026 at 02:53:36AM +0530, Cengiz Can wrote:
> Fix this by moving the iov_len declaration to function scope and
> keeping the assignment after the bounds checks, matching the ordering
> in mainline.

Queued for 5.15, thanks.

-- Sasha

