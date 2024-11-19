Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96DAD4417A
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VOACXUa9eI8hEPm6Y92gHShSc5ObMMYYJ+G13RRyeGM=; b=1/GxqkDvCESj6dRuHyRwZXiNLK
	jzBht5YGq5/dLJXi0IloPPAgdMsamxMQzQQcQEJy7YW9XOia2mA6lN9WAJOui9ZAn3IdzoItnDc+r
	jcfFvwggAVnFtXoJW4clVSHxlgSFB+2fS1I4ymLsDXgxwlali06YeLORB8NJZQae3WfcTYdlFenIW
	wqnK0jetuytwkKauZQVE/ECzIoEJ6u8HGK7sZRduDRABBsCSO59nlEbeGzxQdOMYrfO2pDG1sZrnp
	QvxVRKME9/nqBzfbsYYZs6vxHl3zyBbcY3xv2z7+qlJ5mQVam0c068dpq/ecU4zCMzsU7qIv96k9r
	ezLQSTOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQWW-0000000Cw6S-0Tvr;
	Tue, 19 Nov 2024 15:52:16 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQWU-0000000Cw5w-1q85
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 15:52:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CF9C6A42BBE;
	Tue, 19 Nov 2024 15:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA92C4CECF;
	Tue, 19 Nov 2024 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732031532;
	bh=VOACXUa9eI8hEPm6Y92gHShSc5ObMMYYJ+G13RRyeGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCsiocHIRKqEZFLPC/1ya92IPEl13zdF78FULu0R9UPvm/ykA1Dga8s9uhBXV7KPQ
	 AhwuWdPECBpwtQLO0rJi8wNs6GGkmpdSwEamh0gI2e/10+k7WjIx0BbrGYTUsybMbH
	 5ucNFjvuS9lNRyjdyrQbLpV0bf8w2IGHUixGijfBQCsjsvR9mND1s6l6MWyfH42xOm
	 obLrcSqituqxh7HA4vDq20SddxNmE4/9jCtlyqYEsqg0HBe47XiQ59iw+iLo4hyC59
	 QmvrtBOY3y7XwvmZGufiUhZrhd8rjzxj0vgrsQeqvh9r7+FdjTp1tS24x5xtG+JGj8
	 c4QA0TQE4tBTQ==
Date: Tue, 19 Nov 2024 08:52:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	ming.lei@redhat.com, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv4 0/2] nvme: fix system fault observed while shutting
 down controller
Message-ID: <Zzy0KICktGnVo5t3@kbusch-mbp>
References: <20241105061212.1008143-1-nilay@linux.ibm.com>
 <ZypXRi8R4uOIrkc0@kbusch-mbp.dhcp.thefacebook.com>
 <facc4d66-034a-4131-b60f-15ac1455b93a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facc4d66-034a-4131-b60f-15ac1455b93a@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_075214_540272_BC88937C 
X-CRM114-Status: UNSURE (   6.47  )
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

On Tue, Nov 19, 2024 at 06:03:32PM +0530, Nilay Shroff wrote:
> Just wanted to check, did you get a chance to queue this up?

Thank you for the ping. This did indeed fall behind, but queued up now
in nvme-6.13.

