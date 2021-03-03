Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61748C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:53:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3309364EE8
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3309364EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0PhKxm4jskf6AoOyplOecFUm7MWU9w8srpOMiW2gXDI=; b=RAeuke5EkCddso84YSnn2UfL+
	3yDMRzwMyBb1astTHzAVCCaL8gjqmHWv0MI72TJiagXcwNLpymIFb8jUXK+ZTNg0Q9FVpGVaG0DXV
	gJ/F1XrAT3wYDNfi3RiYqYIOE+mgcA09kpYfYZ85fKJJh911otyTmGnTuhNe94Xi40VR0htuBE7VM
	lKULS+OE/9XO7F0fvJN46037OLCxV5Sw/Q+EVqutN5SjKW0xfzdziOTpYmqNMYWX0xBGzTy58WuFp
	i98l11jVQvXOPHdqlwbfBzZUNlJSBzZ7oNEgdBaXBsIhX0lIP5zOV8sNo0pw28x/Ha120vUFhAuG1
	jEIWaUf6A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHVgQ-005tOl-55; Wed, 03 Mar 2021 17:53:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSwt-005Fwh-9v
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:58:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=N7o8dHVbm2CbUIAFIU6zp7NkdBg2/uHjFKlqzTEbmZY=; b=aw2iIW6WcQ0w0KH0aLHHpBzjxg
 0jUE84AIHy5x6GOh575FXTKV2a/5/pGJNoS2eTe5TrR9jtz2VYl+k5jZLTs8Tg+ZPL7kbGHGLZ+eX
 GCK9iYNZQFsPuUWll2K8UP5RpIeIAbkEbQ7cHUCydNMzcdlivYtQS9ZBZZLrtEnbglRXWISdWM+R2
 NqZgI95PmFRQ7BP5BCyBStPKhMF4gOabQmN8bUZHcriidUXPJEI+CaUOVgqhFubrGlDxszO8Jk4Ec
 Ee3c3+MT7jeno2bttgWzgz/n/HZrZ0oUpockaJtR2arsnToQ4fLVco7j22NbRPHvU6RVUE8Mr0acP
 6apZiLFw==;
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHFuY-000om2-1q
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 01:02:47 +0000
Received: by mail-pg1-x52a.google.com with SMTP id o38so15069743pgm.9
 for <linux-nvme@lists.infradead.org>; Tue, 02 Mar 2021 17:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=N7o8dHVbm2CbUIAFIU6zp7NkdBg2/uHjFKlqzTEbmZY=;
 b=OtQir5iiC48ZIgo+PXXD2yr8LqrmcBeoyDFKUtJHwiZNJ3cXQbtmx3D4Bou6XX0E8b
 A/SuXtrucvCjl16EECUEozkO7Q0B95eOqn/8hTej1oopKIBdvpFwhXYwmrIRyA4Lo7Ll
 VaS+qOcfYsx8aj6nZSZVUREspExpUlbjYkpGHvYzO4Xdlu4zWkErGAQSYEoh5N3eA2vY
 j7/2evhyknc024ZfjwW8hdk+TQGALDfUWdadOk73dEUzlF45G4Wvfogt/bo9oqHBC8Mn
 hLNfuOdHdCemxTpKNYEipcBvBWIKb2yul/2pVo5N/6dDSL/6Htv3SSmKDRjXGvM0P/Wj
 Ts/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=N7o8dHVbm2CbUIAFIU6zp7NkdBg2/uHjFKlqzTEbmZY=;
 b=QUJvufa8T3cpe+T6Rc+F3KDzkXU/xDY5J7fmPxkzCe9uwZmTVpzHt3wyrcbJTAEvEs
 AI8bAgrlMGLLk3ZgtDFQVT76hTrMu/Kxh9iN0gbGCsfuAwhvDhCi532ZLxjB3LblBPIt
 lwHlqTwHMZ/LTSuZ/u3zmh4yEhmx8GBFp8XKFd1L9yVK4ErBik1xRCsyUuKezYtwPQuj
 s5gpFURteJZv/JrAReR9ywYNLSmdgAf3fvu0pHYXE3mYeVIy5jpr45s+0S8rrbiZKup9
 dzaaAo4/YcQTHegJRQcqIkh+ckRatOKuXcVdCVYaxYcPvgeLEhYJrf0AX/bUB95zu+K0
 bAaw==
X-Gm-Message-State: AOAM532PHM2WeNI1FONasc7XWhiQYqG0RxQqAAsy6BYC9a029JvV5n2Z
 34VC8lOsJIyl3rFJHbeJXHNWGt2Y/NdBLg==
X-Google-Smtp-Source: ABdhPJzekWF1WZmCTpurVvA44PPC9F9pTj4HmWmyfFDAjpKMCQLr/PpkR6yqNyMFl8SCnoYD6zVX8Q==
X-Received: by 2002:aa7:9205:0:b029:1ec:8eab:7ca3 with SMTP id
 5-20020aa792050000b02901ec8eab7ca3mr22469466pfo.20.1614733297690; 
 Tue, 02 Mar 2021 17:01:37 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id y14sm19760534pfq.218.2021.03.02.17.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 17:01:37 -0800 (PST)
Date: Wed, 3 Mar 2021 10:01:35 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>
Subject: Re: [PATCHv2 0/2] nvme: fixup MD RAID usage
Message-ID: <20210303010135.GA5730@localhost.localdomain>
References: <20210225110534.75710-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225110534.75710-1-hare@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_010246_863472_AEEBA64A 
X-CRM114-Status: GOOD (  20.74  )
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

On 21-02-25 12:05:32, Hannes Reinecke wrote:
> Hi all,
> 
> ever since the implementation NVMe-oF does not work together with MD RAID.
> MD RAID expects the device to return an I/O error on failure, and to remove
> the block device if the underlying hardware is removed.
> This is contrary to the implementation of NVMe-oF, which will keep on retrying
> I/O while the controller is being reset, and will only remove the block device
> once the last _user_ is gone.
> 
> While we already have a 'fast_io_fail_tmo' setting which would ensure
> that I/O errors are returned after the timeout expired, this attribute
> has to be set during the initial 'connect' call.
> So the first patch adds a 'fasi_io_fail_tmo' controller sysfs
> attribute which allows the admin to modify it during runtime.
> To fixup the second issue a new attribute 'no_path_detach' is
> implemented, which will cause the disk to be removed as once the
> last controller holding a path to the namespace is removed (ie after
> all reconnect attempts for that controllers are exhausted).
> 
> This is a rework of the earlier path by Keith Busch ('nvme-mpath: delete disk
> after last connection'). Kudos to him for suggesting this approach.
> 
> Changes to v1:
> - Integrated reviews from Sagi
> - Use fast_io_fail_tmo instead of a new sysfs attribute
> - Rename attribute to 'no_path_detach'
> 
> Hannes Reinecke (2):
>   nvme: add 'fast_io_fail_tmo' controller sysfs attribute
>   nvme: delete disk when last path is gone
> 
>  drivers/nvme/host/core.c      | 41 ++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/multipath.c | 31 +++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h      | 21 +++++++++++++++---
>  3 files changed, 88 insertions(+), 5 deletions(-)

Looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
