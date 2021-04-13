Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B202C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 09:13:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEE760234
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 09:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEE760234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M2Wp4vFLgGQ02Zxuv22HT152YDrwU5Q2WYOypeilJrE=; b=AIT7Jmta7IbKYG9bkQ0ePz6A8
	Vh32kdffa8wHIhZMTO/S1tpEEqkNkpQphUur8PeV/ryg0A54f63ODsPvN3MTvOOkr3snAlKtGPp7o
	QA8ScHRavc4zRSKQkcACv24DixWrwNcfbk2/BHKwzN/k7oMNPShM1hp8fhG7GK5Jvor6+blC6seMW
	ca4MNOu3cjzJIUPckQ4Uz6xoF7yXI9sszeinvX2Nr1edBJ68RjQfEN7mtTR183n9dLlEySmrn6MmH
	XQfzs/Am1gSulisyJvCCO0FlZ6bjL4u2pQecL+XJqgYg7ML2bvwWlup8LtVPQI5Tauqx9yR0smZ9N
	+pAlC6zmQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWF5j-008fTW-P8; Tue, 13 Apr 2021 09:12:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWF5I-008fQr-TE
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 09:12:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=qhR06lnrGtoCvTKOqwDw7C1p1VH6CYrW7/5vW5oyhnQ=; b=f91dNYTLq7OVebCK5JUPzhMDVX
 qwvXgr0re6DDm/YuEQH2g+EHUAm5iK17hSMGiFaFQjm9qMCiLhiGisHmAWl8WCLAm8E+cPO7tz7rc
 hgVD9zXLO8O0USBSagQHNY4M9q2FENniE3p2L4lwleSevGPjsYTVwrBkZXxyR5eA8Oy6IAUS+uQUh
 RjiP1zv04HB22TZjo7guDh9YHSokporWqm0vPJUrxVrSyePJV4zvXgoo6QUndQS39jYw55l5TQm3o
 VtvIYfDy+mS+dzRGNaRIwtEjgisXPwFCA7R/yUBzfepcke1777J9dV6h53JO48oajfche2PV5kxiH
 bH3WN0CQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWF5G-006rla-DD
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 09:11:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F2032AF42;
 Tue, 13 Apr 2021 09:11:44 +0000 (UTC)
Date: Tue, 13 Apr 2021 11:11:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Gopal Tiwari <gtiwari@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org
Subject: Re: [PATCH] Fix NULL pointer deref in nvme_ctrl_fast_io_fail_tmo_show
Message-ID: <20210413091144.skqqmir3xrthf2n2@beryllium.lan>
References: <20210413064953.541394-1-gtiwari@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210413064953.541394-1-gtiwari@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_021146_618919_6839E2E4 
X-CRM114-Status: UNSURE (   7.93  )
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

On Tue, Apr 13, 2021 at 12:19:53PM +0530, Gopal Tiwari wrote:
> When accessing fast_io_fail_tmo from /sys hit kernel crash
> 
>  #7 [ffff9ddf82467d80] page_fault at ffffffff90e010fe
>     [exception RIP: nvme_ctrl_fast_io_fail_tmo_show+22]
>     RIP: ffffffffc0465116  RSP: ffff9ddf82467e38  RFLAGS: 00010286
>     RAX: 0000000000000000  RBX: ffffffffc0476260  RCX: ffff8b617fe94000
>     RDX: ffff8b617fe94000  RSI: ffffffffc0476260  RDI: ffff8b5e45a303a8
>     RBP: ffffffff912b7d30   R8: ffff8b5e45a303b8   R9: ffff8b618dae5900
>     R10: ffff8b617fe94000  R11: 0000000000000001  R12: 00000000ffffffff
>     R13: 0000000000000001  R14: ffff8b617f46ee00  R15: ffff8b60e9a56380
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ffff9ddf82467e30] mutex_lock at ffffffff90d4a5ce
>  #9 [ffff9ddf82467e50] sysfs_kf_seq_show at ffffffff907b0abb
> 
> Fixed by the checking opts for NULL.
> 
> Fixes: 09fbed636382 (nvme: export fast_io_fail_tmo to sysfs)
> Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>

Do the other functions like nvme_ctrl_loss_tmo_*(),
nvme_sysfs_show_address(), ... not also need this treatment?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
