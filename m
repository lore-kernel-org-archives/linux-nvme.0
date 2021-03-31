Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F614C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 23:49:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CE661075
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 23:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CE661075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O79xF8XZGINuvdcJhXVRwMbVxau5Rf0JvqheWyHO1jo=; b=JyebMyp3l9oWfs5NSBYpQX51j
	ntmnoJaL0jaGzpBkwnPtXsay1cTm7KdwGkV6VDzwY0U+77bbrzvZHFvb+IuzYXnQ3IOqvUM8Z4j7m
	RW8OZVMXuIBdzWnB3u/na5c2ztTzzGTpvwcsPDFgop036kRaOP2d5GvyFbSV97YWbSo8ENJSTS+Xd
	2/2wyifhlhPh1E4CHgcp4T0bl2H05OEb16BCKUAyWJoNaKQDFgu7cY3AYUObIIWSb/OIHTVV1zHmv
	HrxewoUtdqVj0XDy1piBLqiZ4Www2a2lp0fOkwQQ5Gsn/i2xMHN89MfCDUsZex9fEqEZSEfQgzWs0
	J9/bKBGGA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRkah-007zE6-Qr; Wed, 31 Mar 2021 23:49:39 +0000
Received: from mail-ot1-f45.google.com ([209.85.210.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRkad-007zDg-Nm
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 23:49:37 +0000
Received: by mail-ot1-f45.google.com with SMTP id
 s11-20020a056830124bb029021bb3524ebeso584872otp.0
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 16:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gVGICoDePe75YgA0VtBZkbMGfGm7HEN+KZjQvWxJ2sI=;
 b=gTAhbgA0LmQylbvYRHI1Y6djFe/RX8BMpKvAMOwv+s/11Ev/QIWmmG8uzKU/rPhW6K
 2vwjhIIkyhxtkGhPzn2cfHvELNxFHY4zW9uOi9qTTpbD59XzmtapFKOOjA9Xxq/FWjZR
 qA6Xul7yX+r/Z1fUNnSyK4HxmQ8H8SFllDKkTjQUuSkX6F8+sUvEc/zt6lGHT7ICKUbA
 hUTSXRmKmY3LO3ljbCK/o1KoXpFmkYse1qHgRhKtJsY4/eLxxSlIfMhB7iemA7M2fT6C
 2L/ruTZcp0RvgG/k0hBbfDLAqq/GQR+OVVsrJNieCODZu7ZX2rpNaCIp8dqYYx4HfRJV
 6ZVg==
X-Gm-Message-State: AOAM531BcXt0HNx71NOt0XPI2ZljXTaW60tyTtdIlKkvnWF/Oupv5lAG
 PfZov1CxSJQP5OweM9gz+r5aZRLkYW4=
X-Google-Smtp-Source: ABdhPJxt9ZXm2/BSYtlfeg50prUI82ClrAKZgc3v4KzwiwH2wcz17uTUnlCvXPYTacZo410+FlXOCQ==
X-Received: by 2002:a9d:171d:: with SMTP id i29mr4713470ota.294.1617234574035; 
 Wed, 31 Mar 2021 16:49:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id c205sm698718oib.40.2021.03.31.16.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 16:49:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: do not detach nshead when a namespace is removed
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210331145351.35926-1-hare@suse.de>
 <20210331145351.35926-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1e994972-4d22-c46c-5027-25b3dae9413d@grimberg.me>
Date: Wed, 31 Mar 2021 16:49:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331145351.35926-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_004935_862336_58F0B91D 
X-CRM114-Status: GOOD (  18.66  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> 'struct nshead' and 'struct ns' have different lifetimes; the nshead
> can (and occasionally will) stay around even if no namespaces are
> connected, as it will only be finally removed once the last
> reference is gone.
> But while it is in this state we should still be able to access
> it during lookup; a nshead with no controllers is perfectly valid
> (at least for fabrics), and the namespace has no business with
> removing the nshead from the subsystem lists.
> 
> This patch fixes the situation by only removing the nshead from the
> subsystem list once it's being finally removed.

Hannes, please explain what is the bug you are solving here.

I actually think that the nshead should be removed from the
list as soon as the last the head->list is empty.

What if for example a new ns is allocated on the subsystem
and the nsid (which was already deleted) is reused, it will now
be rejected when we match against existing nsheads which will
contain this stale nshead that happens to have an open reference.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
