Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEEDC61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 22:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4VOB7vN3OvwV+J8iiBrOpYZoSx95jWtG3qG4ojcuCY=; b=TO8nbf+Wseykan3f7tvWxk4JMh
	14XIVuoab/CJNh9sJ+2FKtvgFTxWLZuCdOeq3dWUByg8rA4XS1WuZtgpZeC7ty9GZKVeI8/0vJxKW
	Sr+sc9pzs2W8QxvnKqKFJmwxJSo8nRUB6wo7L6kud9VntTWw3x3wdE2z+C9emXtRMhvWwCqV/as6J
	PCB+QjuqS3KoVYWmLvIxqIW+nDxg6MpLx8+bOoiUP5AdZR5KRrEwx2HsYOA+YTHJOolDwGRwCTwkU
	wUmh9pEPB0M0Xftzia/NXa1DYc0sJbbxcj4DeCQ13wn2wHEnOy0GZU+HB3JRUKAclszfNFX3m6Mhf
	PjkbXppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nyW-00000008AmD-0v1C;
	Sun, 30 Aug 2026 22:26:04 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nyT-00000008Alf-3l9v
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 22:26:03 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso930045a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788128761; x=1788733561; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N4VOB7vN3OvwV+J8iiBrOpYZoSx95jWtG3qG4ojcuCY=;
        b=Bafrs/uOFitxdNtbzS4IuW36XywMvOyxaWco0h1eOXK13muGNlRVPVgDI/pcyEggM0
         Xx7dPQ5YNecKRsJWZ1DtjlW0PXIpu3SU5PfQhdlXZ0gELHyt4B6gcsiERmuez1EvmEu2
         jKqWFso2FXMpU1y2ehlQs7Mi+z3Wag1UzmatiCoAo2PDbIqPMEHuuahPz8usIHAB/qUs
         kXwXJAe2voZ5pGQrWEB+AHxZTc5Eqbuxu+m6LQrmBr4DQUnCok1aP39k6QXbHeqnMcb1
         Nuo0E3+JOcHxEYvps7g0zalRh4YgrYobOgiltUtceKmqQoVyH77GHJ8CeiSFqOh4q/EB
         7l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788128761; x=1788733561;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N4VOB7vN3OvwV+J8iiBrOpYZoSx95jWtG3qG4ojcuCY=;
        b=tMw+i9ko8RtqqdiR18e9s7WOLqQzGx2l7iq7icWtD8rZjqxTgWz2ynFKW02MOyw29j
         duwTHawXCeWixOcyVNo2DPPVhh8HoTqy/SRjhqN50KszbVnrp4CzDky8VhlAnXsLonAp
         eBrLJnQFV1vORxn2MfwJrWE45umhBhCfpPEJouVp50oSb3XlGv6PWQ3QSgP0a2mBRuW+
         dLgoSI1LddFaBjVei+bYiDAruBLoryOSD8l92CgEt1RsZfYaAMpDnB1U02wk2xy2K/lx
         nJduDsn5tMBwsWHpfLXXa8bNxS0JJ6O3NLu77EzDbi0QXcxIvDQX99SLOjhE4WX2tZua
         TTGg==
X-Forwarded-Encrypted: i=1; AKwUvByXiKn9mYw1d+JtXgONw8VLdcsoLN8qMRqOKlgrcT17MoY77WjEVP9RX5QgusGg9ZbsEQM7eYX1MLPV@lists.infradead.org
X-Gm-Message-State: AFuF++l0tokKRJDmTap3R2bf/+3jOygONzC7HvS36+e2Wgfj9UbtT3sM
	sHON4ClkmGhDVcEFkNO7gznj215m4Wl0tzoeyRKVYVuQZ8AH1Vhoi0iS1J02mzkbRvo=
X-Gm-Gg: AYBFou3MUxtwiIopQoM8/NoWUmeJbmGo9XMo6xLUcP+2LIRQlATkirKPzh2sm4r3z1A
	9AFbRYPX4bM5c7fkYJ/d4Nfe5urqmS+ThKRmPLYPwpwL0d9AN98xW7u0Ok1kZGurz+gGbo0G2F0
	wE1xYhC8RmmOvlk1S/+CsYchOyy0fr37J7eqXP4Qzpu6Dzg7OSTMMjPZzDKalL9AENBIuekC6ct
	apBJXXLza1Lo1KT99R2rhrywnh6v01SvRtzWH+xUgcqlY+y+xkeD+jZc/PvO19nGFihp1q0zpCH
	Z3+68poL07vR+uBjBHzhILAeaiV0Yt9wZ5K3J8znD+uUzCXjFhfdV9NTxUsivGOCVtPebOroKcw
	UCxLx8ryriUlPscBvSHfbeT0+rJOEQ3972jAQQMyS/tmlfHKkgTwQtm163C0m5i6Ky5KWKBMhpg
	SS3kAVy0t6iiGAeqGTK2Y4esZMk286mDRY3jXKpS7LZCDygCNuIiySJsE5QiKb9XcL0V0=
X-Received: by 2002:a17:90b:5188:b0:396:5fce:8e24 with SMTP id 98e67ed59e1d1-396d0ea530emr38854825a91.4.1788128760664;
        Sun, 30 Aug 2026 15:26:00 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-142e0d40ac7sm22831103c88.7.2026.08.30.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 15:26:00 -0700 (PDT)
Date: Sun, 30 Aug 2026 15:25:58 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	randyj@purestorage.com, adailey@purestorage.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and
 startup
Message-ID: <20260830222558.GB1842415-mkhalfella@purestorage.com>
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com>
 <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_152602_110937_00F3C153 
X-CRM114-Status: GOOD (  11.42  )
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

On Mon 2026-08-31 01:00:52 +0300, Sagi Grimberg wrote:
> 
> 
> On 25/08/2026 1:56, Surabhi Gogte wrote:
> > -	ret = sock_create_kern(current->nsproxy->net_ns,
> > +	ret = sock_create_kern(&init_net,
> 
> I don't think we can just change this...

Why we can not change it? Today the error recovery code running in
worker thread will be using init_net anyway, no?

