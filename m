Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A85C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqsJBTu2ftsVjpVWeJEf1PZwP+2Qf2EssDTWmNxvgn8=; b=b/8aHaCNWVD6w48dVIXQQ8oNw4
	eeMoXSCrtOg7bRFGnzzGQdrOh5+GmlqyOnLVCKKMgCENoeevNL+WCI+1NthuJdQX64XdvfprjCHCQ
	Z4Bu+GYA74iYXE8TssGpqCoZYQUUNs+E4Qo04m4KOe4rM7pUDrRVkFo6Ipeav1VTy2HXlrsDPkrr8
	2+eliMnx625u/smcVLJ00WEioIvFvrFUxcTFb5uXDFTXWFGWd9x/kx3r+zR4ALB4n7YAsWbhEF/4N
	nlS2wnQFiunzR2xq5kZUcJBp8mF8rCiP/WQudw5qfZlxF5sYJNiDFlEXEKJLzCJnqBgai3cubdvIA
	M5LBnhbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKlz6-008zWz-1P;
	Tue, 02 Jan 2024 21:07:36 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKlz3-008zWe-22
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 21:07:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5D034CE1141;
	Tue,  2 Jan 2024 21:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29421C433C7;
	Tue,  2 Jan 2024 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704229650;
	bh=fqsJBTu2ftsVjpVWeJEf1PZwP+2Qf2EssDTWmNxvgn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0J6Lp/1E69B5XyHnkuxaCiZc9u6V8c5hOQh4HMWCQoYMlx9F2WPN4nPQr1/tM+R3
	 xSVOS8AIRmmw1Xlr+JguMy/piM4UhN8ySLqaEUN4oeUij0MRbqEUGcXRQCJaxuQNuc
	 EE4yrSEZkkDw8liKB7szPZQnbAsNqLkRpUVvRKmArvOR2wDOo41yR0OJ3CtIex3o3h
	 dIm1aRLOddKewwZv/OT+CU3BN+2koihkD9eUIEmm8nhsUUAo7apP8QDoerfNc2Gvnw
	 aZwbtcOmbVq93hfAN2RmUKx7PUSz6pxmDQsiVDXxKEkkuOJqviL3NKxv5ETj9neLu2
	 r65+Pl0QAGFmA==
Date: Tue, 2 Jan 2024 14:07:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, zahavi.alon@gmail.com, hch@lst.de,
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 0/3] Fix some kernel panics due to the host sending
 invalid PDUs
Message-ID: <ZZR7EMFYGIGUzQ9q@kbusch-mbp.dhcp.thefacebook.com>
References: <20231222151750.655751-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222151750.655751-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_130733_927224_F32176D7 
X-CRM114-Status: UNSURE (   6.29  )
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

Thanks, series applied to nvme-6.8.

