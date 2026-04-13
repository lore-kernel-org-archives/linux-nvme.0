Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F02EBFD20
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:From:
	To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMBGxFy+p0h72wtIcgN8HQ4EgBwDQuLXLGsIfUxTCx0=; b=nrsV8+S3qlzKfQFMw3kphbL+in
	uKLsrasAjX5iJ8eVuQq0VQ3Na7GA7pzE+kERONrQPFKFwCZfYUQm5xlfaO3c2e5cBXgZjmmYuGjTd
	cqjmUG6Z3S88jBorXWmy08F/V/mqWm3qyA9DvGTdA16XlKYFHHRV6YId1oaKGrtwkuddvz7ufKmvd
	acKNJX4CommL+TVmGkTcxFI9hcI0AuTxyC4DPXHjjN3HP8sj6n9uy+D0Ok4Fu0MQRhifPREMuxLlk
	YkZYoLtLml8kk3BmQ15PLGZFjvCj+ZI32uXZ0RqxdBy4MdBi950Q3ul+8gXAULYKTVBKALXqFO/oD
	rnESxn8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCDAe-0000000FKFX-0665;
	Mon, 13 Apr 2026 09:01:28 +0000
Received: from mail-10625.protonmail.ch ([79.135.106.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCDAa-0000000FKEq-4ADC
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 09:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1776070881; x=1776330081;
	bh=NMBGxFy+p0h72wtIcgN8HQ4EgBwDQuLXLGsIfUxTCx0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KurOTYCovTa83BGu6J6KZiRCwFqX0Hb6sTbGz8uCEvhDEz6D5zOTudFvSJJ8vvNkF
	 iIL2S90hUepPFQ9I9EVGew9xcPCrtiIH9mBVdCzW0hqw/cW864uf9IPA6tMCvkBrrs
	 P0mQoxIejaSqRSW75e7K9pHtPPPWcJy8TUnUrAWLCQ6bIqDH276SPRSbvt6o5gfkKY
	 QrF0Z/Tq6kTAR3UH/lncFWiB2EYtPuO5clNCYizQePeiYtTcUz0Hae7JMCbRrw+4Zm
	 G5OyMrhkMrEdKiGWb18NEL/gvAGZWJCirpBVGRMTAGTHQuyACsmLRCRce45SfuW4NX
	 MvzEYLs3BAkSA==
Date: Mon, 13 Apr 2026 09:01:17 +0000
To: Hannes Reinecke <hare@suse.de>
From: Paul Moses <p@1g4.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "okorniev@redhat.com" <okorniev@redhat.com>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme: fix handling of tls alerts
Message-ID: <cegmtu5F2Mmye7nAykxzPw4Bh8EZZCCx79IUFf4RN5vEZcAbq4-mTr5H7LycgByHGg4EzrAW4TkYkWhkCPTXtsz1dF6iOBwB672-wE15iUY=@1g4.org>
In-Reply-To: <207e1c3e-2a99-4085-81c0-7853f3d09f78@suse.de>
References: <Ozwl9wDbyugg3Ytnr80omDUS6JPqCHgq_k8gkqtMIP2KbHBMt6CYRRMk6LKGOTNPwtj_wNimbH0mZiAe8-9zcRmS_UgArtcI6poZ1PZjMoU=@1g4.org> <2026041239-engross-edition-66eb@gregkh> <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org> <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com> <207e1c3e-2a99-4085-81c0-7853f3d09f78@suse.de>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: a38e205d445d0daa3efda97ec2995d400a5c1919
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_020125_836662_29473E34 
X-CRM114-Status: UNSURE (   5.71  )
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

> This should have been address by the patchset '[PATCH v2 0/4] address
> tls_alert_recv usage by NFS and NvME' from Olga.
> I _thought_ it had been merged already, but seems that it didn't.

Was it ever reproduced on the nvme side? I probably would have been
hesitant to argue with you on a hypothetical bug with no evidence
as well.

https://lore.kernel.org/stable/c2d3a4b6-6b1c-4f9c-982b-4adbc558e1b7@suse.de=
/

Thanks,
Paul

