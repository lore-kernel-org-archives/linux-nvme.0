Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915ECC52D71
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zETfSsyODy+KOzZINhW9CnH4MBAVbSRsn7M5jrCuN9M=; b=TXlm8h5EBp3ibFNHS/WEhVYGVD
	PP9+Pe60waJnLAirtFpqH5le5ZBMv68UjY9CTgvDiGVDdFuZKXT2OJ78mV7uE1eyWWA5ROxJ+TizV
	pqSp2rDsL/0G18IlHu3ur9dTQ4nsaqxYViqzegJUVm5pew0rw18FEGBnPq6MxqBDuxx9NcNq7quFM
	7ELj1hOwErx4BwgRomwOE4E5LJwAEm8KjTQ0mmm8JaFewEowY11AjXkEkcj8b+btkaUyXZF2AOtFx
	7I/wG2KT3EROOWorO3BQ7vAZqpbUB5DrAP7yLbwK9WROnp9MDbdmsVA+gISSyEw+IyBnmKWkRJeJj
	C4YyamSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scM3u-0000000AqAR-2eu6;
	Fri, 09 Aug 2024 09:37:30 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scM3r-0000000Aq9h-0tBO
	for linux-nvme@lists.infradead.org;
	Fri, 09 Aug 2024 09:37:29 +0000
Received: from [192.168.42.20] (p5de45112.dip0.t-ipconnect.de [93.228.81.18])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id EFEDE2FC004D;
	Fri,  9 Aug 2024 11:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1723196241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zETfSsyODy+KOzZINhW9CnH4MBAVbSRsn7M5jrCuN9M=;
	b=ZyRFsPsw00dV0zfQJf++hJRnSY6R+CQghMZ4SNRfg+VEwLA7YFu4rcROjRpTuUmgbJpufM
	sT3SvvhHEHZU+G2KptBI/jaVZWsQ2/w57Ifhh2snfnCcvJNxix6UP1QEg/J0+quAuKdphV
	VdsTzlkiINRTkbTl79AD87sD8Qi44DQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <fea10570-7832-428f-a44d-a2de41893c69@tuxedocomputers.com>
Date: Fri, 9 Aug 2024 11:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: g.gottleuber@tuxedocomputers.com
Cc: axboe@kernel.dk, ggo@tuxedocomputers.com, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, wse@tuxedocomputers.com
References: <f7a70add-4d65-40a4-91ff-70bc14a64467@tuxedocomputers.com>
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <f7a70add-4d65-40a4-91ff-70bc14a64467@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_023727_728029_792E7CC2 
X-CRM114-Status: UNSURE (   2.82  )
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

Hi,

(hope Thunderbird supports In-Reply-To via mailto links)

wanted to give this thread a gentle push

Kind regards,

Werner


