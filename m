Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8F9C87FCE
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jul 2025 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30oRbA0C1xW1Si4ll2fS/X4ydhyTseY/4ZA/9XmIzCo=; b=IN1i53B5Wr8MBnphsup0XLQrG/
	Yw2BbDu33zzojgL5zS/b8F5EegrZ9oIeNAq/JrQuojRH82I7uHQzs5lLqm396haJrcy/wmNGOZZTA
	z2tTgQteE6LDkfs9Cz5Fuuw3kuzpLwYVdOsRXO5snssF2aa0K/FQZl2yWb0IBqQXrxyPltfJe8PqK
	jl21pZAXG3b5YmmZXdJ/Dg1o6UZzvsQ+JU6n/nn8gObK4n0XTo5LIa9ArHF67NVjX8q1fN3Ip4mo+
	DQsI8+BjiEsbCLNVk8Vfh06hIShFN1MEUl+w8zv2PXzrhnOfsOgE+EEdYyaBBccUaRefwpcdjNFk7
	MjuqQzww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uezNY-000000082wt-3DQo;
	Thu, 24 Jul 2025 17:05:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uewmA-00000007j1I-0DKR
	for linux-nvme@lists.infradead.org;
	Thu, 24 Jul 2025 14:18:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 330EE601D5;
	Thu, 24 Jul 2025 14:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9D8C4CEEF;
	Thu, 24 Jul 2025 14:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753366704;
	bh=NDUOFKUVdNdU9/I+oZzeY4kP5EuRpH0JdJjBSLxjoSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnSU04s977VogeCjGlM3p2QzaTz1iM0kt2C8VB8PcODFnczP47oDUUW0VCsnwChk8
	 Z4/d8G79a+WJIeF4lqkIlcEvTx3nrkQSIrpDzrZrson2HNDL3TGOy9DYCiefuSAXP8
	 i7ANeYo0LIkaLPR2QViJJYxGQW/2JwzN/8N/oNVV+51eARLqVMmS0HYEChVf73uCmZ
	 /mifPpqAzrRWxj1deUqfHFLs69DBWEQ+/OySuaZLi4W4JaduSU8WGhwtJGra/NoOoj
	 +Zkm2H8y/7XKfMhLPfwlGpJOe6TmfM0oFRTSFgfZTlMvLbTE7PCgS8QdkSKnUPdyXa
	 zXv3Sy5PJBc/A==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	dwagner@suse.de,
	msmurthy@imap.linux.ibm.com,
	gjoyce@ibm.com
Subject: Re: [PATCH] nvme-list: fix verbose JSON output for 'nvme list' command
Date: Thu, 24 Jul 2025 16:18:16 +0200
Message-ID: <175336669186.426033.4256373145639280312.b4-ty@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721102946.1003295-1-nilay@linux.ibm.com>
References: <20250721102946.1003295-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 21 Jul 2025 15:59:11 +0530, Nilay Shroff wrote:
> The verbose JSON output of the nvme list command is currently incorrect in
> both multipath and non-multipath configurations. Specifically, it prints
> empty Namespaces[] and Paths[] arrays in the wrong places, leading to
> confusion and invalid output. For example, on a system with single NVMe
> disk, signle controller and one namepsace created, 'nvme list --verbose
> --output json' prints the following output:
> 
> [...]

Applied, thanks!

[1/1] nvme-list: fix verbose JSON output for 'nvme list' command
      commit: 64bed0a87a23ca574cfce64fbcf6630194551276

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

