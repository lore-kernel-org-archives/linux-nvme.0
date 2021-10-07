Return-Path: <SRS0=oQz2=O3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Oct 2021 15:07:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C4561139
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Oct 2021 15:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80C4561139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p+dXecgdvVCHUuFFTiMvnBZkSQP4A/eoHH8VUf/4Fvk=; b=NzOLWMEoi8pGYp
	w3GpiwWu3NqvLQ6GX/gEPdQ3bVCAhoIQEDji9PI+BCPioR1aOYXKofwPsFcWK7FI4muEceFVstgmK
	Nr5laeqt39uMjit9MK8cSg0DPXiyAyfHkKmdUuPF36nxr37ebaoae5zAZzx7MckAkx/sI2siSIlUG
	jiJhwTWrTGQ8jTY9FaW3ugT3H6xcw4LNyBUWxHpS/9P2ysDW/lTLiRID/KEkoXDkpEU8HqiO2pSbw
	XNrYHak5CmUialMz/2LEWP3k5TVvByIk8IG1/Spk44JwelPBOYkwoBHhFEIjIYxFrwLPJzj3Y0/Iq
	4b+BzNzyVOg8MtJwzyAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYUzq-00065l-4Y; Thu, 07 Oct 2021 15:07:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYUza-00064c-0s
 for linux-nvme@lists.infradead.org; Thu, 07 Oct 2021 15:07:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A45661056;
 Thu,  7 Oct 2021 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633619249;
 bh=yhnPp1mrExt3NRYyAwJkXywJ4PftO3rE2VnfoH8VmDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UJPDtM7QVxoeDmoQLkXuWjueJu1iADb+4i/e3jdqO90qsDYSVCUns7dHE517NS9eq
 kOGh5sUGA5ZkQ0CbHrF75jyn2ZjF1yNMxtXsVASVEJvWomxFHabrBsXqLyogYe5z4B
 F9+d3yovT1VSqA4JAZzt6tmCHZGL7gz6dmDKK+7/+xpsHgMBJ9pbxFIwaFT4nfdOTx
 JW3/wFyHnMoeYz4cZxv85/+0J/7qROESZVdty31kfT/5aT4S75biHNNI46vC2hJEl2
 qkoiU69YTFdZVrIOHIsK7mu9zTMlB6I6dcWbYoq+VxRBqsKzcXCZWp2oKu+TIrSwTw
 92D5QXptrIZoQ==
Date: Thu, 7 Oct 2021 08:07:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH] nvme-pci: Fix abort command id
Message-ID: <20211007150727.GA630021@dhcp-10-100-145-180.wdc.com>
References: <20211007065436.629383-1-kbusch@kernel.org>
 <173def42-2505-b788-93ed-1c5869f83a26@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <173def42-2505-b788-93ed-1c5869f83a26@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211007_080730_102506_A5A699CF 
X-CRM114-Status: UNSURE (   5.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Patch applied. I was just confirming my commit key was still not
accepted, but apparently it is working now. :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
