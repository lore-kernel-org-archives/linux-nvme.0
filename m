Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47AEC54EBD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDs/ubAyB01Bk9H5AnuMOTc54FSGl71vk6BJ6hTW0pU=; b=ACil8xYJ6jX+8JUc4evaFFKsAg
	2nMJFoKCybuVX7BF8Oa61VfISjWgAU3ckH+iFMP3JRis6u0x9JmgnGz6ASlleSzKNMcTMfC1IOphk
	yDYC/hVb2PjMXxEtyS6VTNj01mE1U3FRFgqdymwUD7vsM8Lm6heXfuLSOxGM1axEaQrjEgJehxMg3
	ANgAVvPxymOxmQvbCcHKq+Eh5jaC+SxgnHerrIYOJmdyQTcAM3VRNnMWnkLyy8nfOi2tmHOZ3sVhO
	h2MiB1Pw29c0jZo4VxaKEv1S0J8HzV46IbMCHGrJFMWLRBsulNiM6Lk54qx/VyvNhI6m+WJVQcI5O
	qmSGX90A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEtqV-0029QA-Sl; Mon, 09 Jan 2023 15:13:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEtqQ-0029Ms-Fe
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 15:13:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1B61F61161;
	Mon,  9 Jan 2023 15:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103C4C433F0;
	Mon,  9 Jan 2023 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673277228;
	bh=VDs/ubAyB01Bk9H5AnuMOTc54FSGl71vk6BJ6hTW0pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKJ+1lG63ogC29zfzyBYxR/c/lYqyqiG3oPpiQ9m34nVmk6HvMw4BcuybButLjr3F
	 X2uUJZZ8SO7xrgGw0ZiEVmbi7mA4E0ta5CCTrKmmjQAzO4+05D8CcqU+d6jk7DTTWW
	 TDraxXjVb7jRW8WII00nLpkQSiUTGm0USfE3/Ij2Wm9UBa7LwQOqbXrBmzhg/BENtm
	 wHw4CEE2Rx4qlE5CqAApYc6zM0T+hHTXeoMwtKWh0MSjCsN6pF3LLG39poQwJeV+Or
	 7meLuZQ/gPrvRAq/MQCmYda+OgIYVmvw29Wf/Xbl/ZtXt4s76bpw6EHAnYBedVwNdS
	 B/koIGOUk1E3A==
Date: Mon, 9 Jan 2023 08:13:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: don't allow unprivileged passthrough on partitions
Message-ID: <Y7wvKZ7aoeFEtufE@kbusch-mbp>
References: <20230108165033.380842-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108165033.380842-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_071350_604217_50B52CD7 
X-CRM114-Status: UNSURE (   7.59  )
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

Series looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

