Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A961C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 08:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AAE63212
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 08:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2AAE63212
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TvPcisIpoQMa0iHCiazpE7qic8YKlbD+zUQ5wRK9Dvk=; b=t98hkY7McRtbmW3liRa3vGunmr
	3Eng+tTb4QE5F8e7vd+Jge8v44W5aoSZiSZTZP9CzSO6bV03Z/Y1uGhJmpVkIHA75j8LYNsSYcdQg
	5kPE2A0WXYNAaL6N1OhGxsZk4+YgrvOHP16U8I36ZRalQ48m6V0lI4XagjsfS1e4jEd4ZxZjHC5i4
	KFKeKOBOHgRFJmZjncHEcoqxwzgYiglTKMBTXXPYrpTjovJi8Q9VsHoxw9kNw3vZMiYPdZhGhb1us
	QWeWvWPJJrl8BRkYG4v2PBuxud4xUcwFikbLofdebUMuKLJacU6H67gf+w6AhBhfjjV2RIQgL8qRy
	yss85h9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmuHJ-000pUO-6L; Tue, 16 Nov 2021 08:57:21 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmuHG-000pTg-L6
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 08:57:20 +0000
Received: by mail-wr1-f41.google.com with SMTP id t30so35996830wra.10
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 00:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TvPcisIpoQMa0iHCiazpE7qic8YKlbD+zUQ5wRK9Dvk=;
 b=MGGaRz2ZiNdsy/UC+YLuxgQlV2wjSrSgJuq9/WWwkDOJeRGkvk8X0uuqb9daFd+VgI
 Eh3fNlaCUhYo8t77z+y6NUZIK2RIsKTLzWpJei3SVrRA2IxnFRfCP2aA37PfbTW7juPf
 jR0DXRBGTwvKpCv608/rAyp6Lkk9IflntQ58J1gWGdSazweD25DK1bYy7TSO/LhzyNKS
 GhIcP2M4uBLZS7r2bfbiEnAGcl+Hb+UZ5zu1nub30zUv0NGN6wL7B6E3HA4kS0+DYK9u
 gEy7VM8V6QSSKMuoE+y7e2rPbggMK1jY+A+ZhBLC/JvQ2+zr1wI7uj0VZaM6q+MDsdsc
 07zw==
X-Gm-Message-State: AOAM532U6rlvCnG4cgXuXDw+n3xIv65Uwy2NNNop4LrsFXkH1OPKSB3n
 PMp6cyQkYniXmUrCnrs0D3I=
X-Google-Smtp-Source: ABdhPJzuBjB7Fvqz0fUWY4qQU1xJYzTPXgh6kIb+qDsbAa0Lb+jze7vIpKNrDDtoChXYncuuAPhnuA==
X-Received: by 2002:a05:6000:23a:: with SMTP id
 l26mr7143656wrz.215.1637053036730; 
 Tue, 16 Nov 2021 00:57:16 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id az4sm1741523wmb.20.2021.11.16.00.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 00:57:16 -0800 (PST)
Subject: Re: [PATCH V2 2/3] nvmet-tcp: fix a race condition between
 release_queue and io_work
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20211115163114.48716-1-mlombard@redhat.com>
 <20211115163114.48716-3-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8e83c9ec-2273-061a-89ec-2ea8a51140d6@grimberg.me>
Date: Tue, 16 Nov 2021 10:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115163114.48716-3-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_005718_732594_8D0FC73B 
X-CRM114-Status: UNSURE (   8.84  )
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

This should be patch 1 of the series.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

