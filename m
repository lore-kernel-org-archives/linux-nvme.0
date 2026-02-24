Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574DDE9B248
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dqLOm0PM7kcvpjftBJlRGEhwi4F/wqsNJqUoHigpCYU=; b=YhsIN6EWi/RJKtgkQiKMFq35On
	1pYmFA+i4VRztSfzRnSEmKQwpPGzE4yzHD2XFrGFuXLbCwBDTzoBQeVlKPDyiv4AIIzCEC9j8DSm9
	CGy2dy/AL0VtR1UvhjN45OmweA+4n7+4rtGpSjRKNQhE94n60JoJ0xTyCjrTYFrBTacZk6eRZTBTi
	ZmPP58kOjM9DZGt3VylV5K0qbMY/pQMtUrWKsH0jVr15sT6RhK70L4tiRPE2Qwn86IPipL0QBfwme
	OYhXiVcza+sQekxp+5B66qxtLI78ZgZDagw6/TtglXOFl+9CnlTarbnatCDIDTr6Su2tKgmCM4Fws
	jneJtrmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vup6W-00000001nq9-0COJ;
	Tue, 24 Feb 2026 09:53:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vup6R-00000001npQ-0zkT
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 09:53:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3440040BCA;
	Tue, 24 Feb 2026 09:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02DEC116D0;
	Tue, 24 Feb 2026 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771926794;
	bh=dqLOm0PM7kcvpjftBJlRGEhwi4F/wqsNJqUoHigpCYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PazVMNIVrnDgSPiJ3FUli5BCxqck3xy49vEaki781IWSysnCstNXLDJHfT2CY7mxz
	 6UZAKfjuBBy6v9NZDDMFZyz6nezomxLaLhOCC4hz+BReH7i7oDebgBVXanCgikIBbC
	 fMYYI6uQlNm7M47ehvrcFq7UfeTFgHPXO3k85TdYP1L3EumeOzBUuUjyo1t7414yc5
	 /aJ7ym+RPxCD+eD8K65j0IFpc9Mv/JCyyA61V7T0jRgGkvPV0eA9t/ifE7Oz4ItytR
	 kK+aUQiaItrgLsWnb1lSuMLdVNFUWM+nel9DKT9ya/IJ8v88xxH1Yo70IKbMsIk7t7
	 1TCDPuCqcTUuA==
Date: Tue, 24 Feb 2026 10:53:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org, lwn@lwn.net
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260224-sangen-aufatmen-06ba16719f33@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner>
 <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_015315_301343_324032F1 
X-CRM114-Status: UNSURE (   7.27  )
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

> Don't forget to pester^wask^wremind your respective organizations to
> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
> considering renaming it LSF/MM/BPF/AI.

I have just looked at the sponsorship site for LSF/MM/BPF/AI again and
we all really need to go out and go steal some of that AI funding money
and funnel it into one of the conferences that really drives development
of the operating system that drives the compute for all of this.

Please go and remind your organizations to sponsor. They should know how
to get in touch with the Linux Foundation. Just going by the sponsorship
page we're missing a bunch of large organizations that we would
appreciate if they decided to pitch in. :)

Christian

