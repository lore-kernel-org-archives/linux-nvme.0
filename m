Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40152C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:25:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FDB64E70
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FDB64E70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=apache.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lHKLpGKxCSOMeDDB5NVsu0EViCtRj+fbaQmobz+NF8I=; b=VwsHVsEhT+hBpXZAkMFg81ZASB
	jrJqB2ypKmB+PRmCbCrWTfP3ulfUzUm7PwQFE4Z+R9JjmPA18Ms6HSrgHHc7zLD0lF/KoqDmQOZh6
	RXY/0zL2zwkW+64WNziXleIzcnaiykwoJ/H08cnohI5ulpQEj+gB5PvNkMJppXY48ASpYdsFUk66O
	+4frZNhypYMQrrCubwfNPqSeBnW1l3BG2ZTfEUQnn5KDRny9M4nPn2Fy1jJ4cq3rCdFKsPBaB3Jed
	5xYjXWy1qXnawjJoqFb0CiQIoWuwipRQ8W/6dcnUCFC/denz01/AnIW7nWkM6+xp6v4Lbm8Th51se
	e9AB9oaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Ka9-00060z-9J; Tue, 09 Feb 2021 04:24:57 +0000
Received: from mail-il1-f182.google.com ([209.85.166.182])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Ka6-0005zy-CK
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:24:55 +0000
Received: by mail-il1-f182.google.com with SMTP id a16so14941870ilq.5
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 20:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=5Hd1VlrGUd7v9n0IZCCFjDz6vVzEiWM+Y5M7sHW/IPI=;
 b=k64gYQxC9At9siXPYLqdiELNWQ7v+6JFrFYP+GmUXehQLJVW5Iw41iMQ4CQl3e+wal
 vrC7njuXmhZt/mHIfvhuwmxuMy4MOGiBoE51sDb2YzuyaaE9WSYgXdLG6WR+3UK1LQij
 L+BEmWoykfKqkbaVbyz/YjmYijAotebAjW+u2zwwbe4Mm7N+NDfKmbaLI7RzwSraJgeN
 syVA9vz5lnsfmP5rJ4KDXVujzozSGq/gKY2LAAYfJmZEaS2pYqAycLSswMVXXGExODQI
 D6MAfGkGQ3tG34P2/J2VyiLPAcq/BKTsibukCpaH5jstUKvuC0ofraUJK//winAog7Vi
 84vA==
X-Gm-Message-State: AOAM532Fwk5R1T/fUvdZoJvbFOl2VqZCHefdDj/NsccoOIhLIW5mm3H5
 Vinwwdw7Pz+ybGHC6XMkGJtTMr6ozmRn3kNG0+wLrDX+6wY=
X-Google-Smtp-Source: ABdhPJzIkL9GaWUIx8pQCpGKePu8bZcSQbSsp16uAomqhCypl4i5ksANW09Gv9OqlO3LVVhlW9HkLnmal8UeLMYefHA=
X-Received: by 2002:a92:c712:: with SMTP id a18mr18838754ilp.84.1612844691665; 
 Mon, 08 Feb 2021 20:24:51 -0800 (PST)
MIME-Version: 1.0
From: Roman Shaposhnik <rvs@apache.org>
Date: Mon, 8 Feb 2021 20:24:40 -0800
Message-ID: <CA+ULb+v-2jigmQA=Z2WmWP0n3wCbEs_s94oCoNbjJMw14ATCjw@mail.gmail.com>
Subject: vhost/virtio fabric
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_232454_444080_CF458456 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

Hi!

I'm looking at using NVMe protocol in a KVM virtualization context
along the lines of:
    https://patchwork.kernel.org/project/qemu-devel/patch/1516003315-17878-2-git-send-email-changpeng.liu@intel.com/
but with an eye towards using NVMe-OF so that I can terminate
in the kernel target itself, as opposed to a userland process.

Effectively, I'm looking for vhost/virtio fabric similar to:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/vhost/scsi.c?h=v5.10.14

This search made me come across an old set of slides from
Christoph Hellwig that did, indeed, mention that at some point
vhost/virtio fabric was considered.

Please let me know if there's any work that has ever been done
in the direction (even if in a form of unmerged patches) or whether
if I need this functionality I'd have to implement it from scratch (probably
aping a great deal of drivers/vhost/scsi.c).

Thanks,
Roman.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
