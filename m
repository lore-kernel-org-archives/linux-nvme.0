Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0DAC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 21:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=; b=SBRxzc7ryEYlB0mJju+KqzSnza
	/+qnCpBk3wS7Lrd3yjdqTN3jSMDWjolI3tuKEWk3UQ/GF8TVU9Ur8znK8eNR9m3A3sNnz9Ro2LLt1
	X1I52uXbdsFj9gNUdc46i3nmVrwovxGdfBCv6VypbHShGXv44EZrCslSONTyf4y4ARSLdCdgjueYn
	Lzhgikfyv5kBFBLUxa9JTPwjIQJ+pLdcuOsoFyfE95vYaa7X7UCAZeVQGzlkRKAnMhTiYQwMFvMTX
	pz487yt3RTtdt5nYucrlrYhbc57HFxQUibB+WhkWD/vE05xyY+JAO8hbFpFYiM+H71N6ygUncWk0t
	xEbnKVgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmEo-0092dk-1D;
	Tue, 02 Jan 2024 21:23:50 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmEl-0092d2-0v
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 21:23:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 71F94CE115B;
	Tue,  2 Jan 2024 21:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB66C433C7;
	Tue,  2 Jan 2024 21:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704230624;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XF+Ij1MNQFOOildB+8ChCEtg3uNDCbZDQC62ylzry2InHnHdq3Sq6NJ81QXjxOiEH
	 MrOF8kOUdwSBB5WMiiiT5Y13CMviExL/ld44cSOLJcpx+NyEQVpS/H7L7v8PEvnbTN
	 ZsXmrc9rwF8vWl5RJ50LQ2DrGOnHIAheiDw+ChdlEuh2yJPrwtpHEHg0VaWHmH6ftA
	 /A7/V8Oo+jJJ9q4dvAk+oArOQlItAuQ/3JSgOTZ50Gro8ZZzaIaGn4HFyifTgZdTfT
	 gYZ3gKTK17OAVaZLcY7vNmDFAT768i0az+ozZieqzd7x5AbFIvO6Ymnlhe6Z3zfnjr
	 J3PqgxJGbdEPQ==
Date: Tue, 2 Jan 2024 14:23:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-common: mark nvme_tls_psk_prio static
Message-ID: <ZZR-3tfPMNxCwwGn@kbusch-mbp.dhcp.thefacebook.com>
References: <20231226081412.180149-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226081412.180149-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_132347_500574_D77D557F 
X-CRM114-Status: UNSURE (   7.06  )
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

Thanks, applied to nvme-6.8.

