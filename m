Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F753C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86+YpE3umE5X7qLPGhKIxFO/96mjZXse3vC/nGBFBY0=; b=BYBKS6hQ6puGrYkU3wkhtiA9VH
	G9Mi8abwoIMPUCjtcG9dZQg97EDl7trgBOBKx54IuvHHBkqtk7t9L1yJ4mx3yTV1IiI+pmyk3MJeJ
	xFlokF3Hx+vWZ4mM1LDPTQk4TRTv1TQvT698dtRMJFQgkjga0cYemrshL6z22jXji/lUkvzAhGMum
	a6PrR93Nw2vyF9/Q8yjbmQsKYzhIZ6+AhxRAj90Sco2bQJwqTUpwOqZWYN4mAdU0Z1ahVuX0uKqNo
	OZBRCPoecyFnzbke8D2SJWbyHegK59q52njB/LUiZP1qIY+3oPNPq2rKDNkITNBjkHEBy+w4onera
	wEAgTurQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OJz-00000009RxT-03IM;
	Thu, 03 Apr 2025 17:25:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OHx-00000009Rjx-2lqR
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 17:23:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A087442D6;
	Thu,  3 Apr 2025 17:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065A2C4CEE3;
	Thu,  3 Apr 2025 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743701016;
	bh=rbdaZ2ZbkpLF40TD2M7AsP6aSfvjmqtvdR1XWbDKCpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQTkxcwokBi0oDL1YMLmpNLN/qJhDrFr0K3WYaNsvdOOVaUu7s1XDBQAy2BDAMe7Y
	 0LhrMb1a/MYmrKvZU9EPSgWOb9fF2utGt3dr12OV1VKstyvuB9/P6iPh1uEWnPF6VD
	 /t0P0D39gB73AXbueEUvwRwcW8iYUYvnftSpDx9S2HQvbWF9YIrk2qt7Q8iCseqGqd
	 MQmGQj3URHi4xm9AexE6snXoojQdlsA+qBDDu8MStdyzPJC3CP/6PvNIrTC5uWbXP6
	 BWtvMANvMghW+WxauqG63xtx+kJxTXM5NVr+nAnksRbooIlKeInTSSt1rL3NuO4u+5
	 /vNuaaWc2Zgyg==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@meta.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	hch@lst.de,
	dwagner@suse.de,
	Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCHv2] nvme-cli: attach ns to local controller if none specified
Date: Thu,  3 Apr 2025 19:23:22 +0200
Message-ID: <174370099347.280934.8178371038169619945.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403142926.2510305-1-kbusch@meta.com>
References: <20250403142926.2510305-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_102337_717993_174ECD3A 
X-CRM114-Status: UNSURE (   7.03  )
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


On Thu, 03 Apr 2025 07:29:26 -0700, Keith Busch wrote:
> Assume the user meant to attach the namespace to the controller the
> command was sent to if the user didn't provide a controller id list.
> 
> 

Applied, thanks!

[1/1] nvme-cli: attach ns to local controller if none specified
      commit: 093a53d45cae3f76f6d2c1bc731016d91d8b2e02

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

