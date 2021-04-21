Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56715C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 02:32:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85434613D3
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 02:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85434613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7Te9bgWLL/Do+jS8tHkdd3hxiRAbBclIkqw3vFg4KxY=; b=kc3gU56FMUpfxsc5YuGVpp0cF
	n6vbbUw2NsiiLYG6mXJ3wpykYYhPAC3X0/Qk77O2uU948LKfeufUzUCCGr9rUHY2aauaVUnd0UDdo
	DoM8X1ZI5aOK8rQJAHmGkHQD2jjCrKls+/s8bjWMwHWn4hmkaj34rf/mMzNuXtb2TbNSgEVtn4cXN
	hlevr+2RqCqj75fps1NuLo8GpB9F4Y11zN/djwA+CuH4mGjisxcnB/wv4XXxYneIoRhqkRfcx5BK6
	KeeYuwqw7Hd3W0wWIN36k0q+wIjqZ+C5v7Ptnl/z3uvpbz/GpvXOfEcxFXF2ZWkVTdf4/Zx+DSIo+
	/4SF55l/A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZ2fG-00DTxA-AB; Wed, 21 Apr 2021 02:32:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ2fC-00DTwT-Sm
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 02:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=266ZulvavLGzEF7yrhLAUqulmvbYKZRXzpjBeSsGWvU=; b=Rnfi8v7cvhrzG63rKk4IYdMaoR
 A/QQnghQ5c4HvuTFI76t/d2uNe/POW05JPnn4i1mUWH/g76XR1mf7Vz8LF6e2I4+q5nL6pTCUgQjh
 ZZN+fd2Y5M8tbqOimxwF/j8lyu3LW3FFP1KyMjTjk9uQkfuw/UtEY6vvJOoPTmI9DK7hx/ZzHY+AM
 Wz5ytOFxAMf+yIGZfbIxXRwQQtIO6wftN4A2A8h9EomhakqMjHVllHunlAYsGM2q397oLJXXyYXFS
 7zHQUBWEOT9PnRFTV2PrWWkz9uSEC2ypX0oBULhQlB/pP0GOl7GAt3OlHa0ytbteb31O+b38aoxWX
 +tTpPEWw==;
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ2f9-00CXkA-FR
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 02:32:25 +0000
Received: by mail-pf1-x434.google.com with SMTP id h11so9591917pfn.0
 for <linux-nvme@lists.infradead.org>; Tue, 20 Apr 2021 19:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=266ZulvavLGzEF7yrhLAUqulmvbYKZRXzpjBeSsGWvU=;
 b=gErZxW8OSGmJ5kvkN50z4B9eeubyK3vcoJHXY37IcpaACqwXV0g0bHpyToIwmF57zh
 8KDPwlYtawCofwDp28VaAxS2C4WrFxStX9ai6+KpBLjZcEKjcthbj2gwEzDv06kuEOPA
 vwUS2twwuErZSly35mkMHaOh3bjnu0hExrUhc4uxvfyOS5qG0uzG+QOlKGPFWWEtoeQF
 VQTgtQsQk2+6rbIkf+QNfAxHZTCzFBR+mUBmprIi5m+SZvWqsnCb4ykYpCq9DwGJuh5/
 Hlp6F6m5ODdesaG8TqClqmnZy7yUJCfN2cgF9jeVTZUF03mAyt/Cz7HmowISYETcLVEz
 FkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=266ZulvavLGzEF7yrhLAUqulmvbYKZRXzpjBeSsGWvU=;
 b=qI1a8Mf0iK3tZDUuQ7RfY0tD/OY8rNarB/dYkasJTgBzp3o2ASbEZHco5L8Mkf61DF
 /vuChkUdRBtah6tIgx3FEJB3C8aqbeegLPWf5zxsVSJDzF8Y8YsE/WYIvVQg1wagQt9W
 F/vlXhtLDz+74ss8OJWJ83l4PcKeWxtyjMZc9Ptlu4/lqq7oScW26btHpnc69UXSWG8U
 JHt5nzKp8JERYolUyXEcwsjSUr9y4OqMMiq1JVgJSzUbz+crcdilr9lrjBrcff6W21Nq
 ype7u0REoRCK9I0KAFTki7Y482P+l2jXoC3fITm9rsDvpn4Hjh8+lPNIkChpJas8zeuw
 iyUw==
X-Gm-Message-State: AOAM5313ck79p3W3qbmNF+7pn+xfn4wnBo9KQ9BwyeXYku1olcClrrDb
 du4mKd1/nYKVcEisqNTHC8U=
X-Google-Smtp-Source: ABdhPJxaxPjeLJquOAYBuTa2jF7RC2/T+IbBx63I98uEiXU2beCdnbe9c1RpgYRzzlmqkZ/zdSoK2g==
X-Received: by 2002:a62:7cd0:0:b029:253:acca:2ce0 with SMTP id
 x199-20020a627cd00000b0290253acca2ce0mr28291131pfc.30.1618972336808; 
 Tue, 20 Apr 2021 19:32:16 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id i18sm288016pfq.59.2021.04.20.19.32.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Apr 2021 19:32:16 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: kernel panic due to a missing work initialization in case of zero
Date: Wed, 21 Apr 2021 10:32:05 +0800
Message-Id: <20210421023205.8743-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <BL0PR1901MB2020A15CA929276AB8FC7E52EE489@BL0PR1901MB2020.namprd19.prod.outlook.com>
References: <BL0PR1901MB2020A15CA929276AB8FC7E52EE489@BL0PR1901MB2020.namprd19.prod.outlook.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_193223_554047_735C4495 
X-CRM114-Status: GOOD (  14.68  )
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

On 4/20/21 11:46, Engel, Amit wrote:
> Hello,
> 
> We hit a kernel panic as a result of the below sequence:
> In the current nvmet implementation, as part of 'nvmet_start_keep_alive_timer'
> nvmet_keep_alive_timer work will be initialized only if kato != 0
> 
> when nvme connect cmd is being executed with a zero kato value
> 'INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer)' will not be called
> 
> once keep alive cmd arrives, we call 'mod_delayed_work' for a work that has not been initialized
> this will lead to kernel WARNING:
> Apr 20 10:32:59 FNM00190700796-A kernel: WARNING: CPU: 11 PID: 75133 at kernel/workqueue.c:1447 __queue_work.cold.55+0xc/0x3c
> And eventually to soft lockup

Hello Engel,

Could you verify this with latest nvme-5.13 branch? I think this
might be the same problem as commit 7b96918a173 (nvmet: avoid
queuing keep-alive timer if it is disabled) fixed.

Thanks,
Hou

> 
> A simple fix for this issue (I will post a patch soon) is to initialize the work (as part of 'nvmet_start_keep_alive_timer') even if kato == 0
> 
> Thanks
> Amit E

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
