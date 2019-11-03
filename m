Return-Path: <SRS0=k2Ai=Y3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183EECA9EB0
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 14:31:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DD020679
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 14:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tiGouTSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DD020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yIbabCoU2j4EaVQiccnMPGA+URou8qnySE8520NX3oM=; b=tiGouTSxSOE10/kxpF4xsHHSM
	z3oqPUXb9pTv55DOYrVs+3iSZvqWGdGYK+9FH+8iGx+g89KyUTvTdvl+ZENc7rQlOxxGnh8kSbKrS
	IL6in7IPZNsL2d5pThH9QWOeb9wKHJm57dv0+cl8N4I+v6Szd61QQ+KgnAaA2vwG5mSDdCzgv0Rpt
	DjiStAbBsA91TW5xkGVxKg+9XEmv5LQdN2K6Gdu5AzkDrHchQPH7hQdLDhgKTVg0z2grukGcziOys
	1BWmyVGDkDttbh9LjewkwwqlJBfvVGVv/AnJUOOt5nGoGebffph2UhW3fj+w+kkD2R9VbDI+pURRu
	d1TmdNXLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRGub-0005Nj-O5; Sun, 03 Nov 2019 14:31:25 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRGuY-0005Mm-Cf
 for linux-nvme@lists.infradead.org; Sun, 03 Nov 2019 14:31:23 +0000
Received: by mail-pl1-f193.google.com with SMTP id g9so6481416plp.3
 for <linux-nvme@lists.infradead.org>; Sun, 03 Nov 2019 06:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=adKeCKMq5ICe2urn7kYxYrg4VLJk4304o4QAFLZi9MU=;
 b=s/tyg187BkPSbxdSzAVnG9m4mVsw97LtM+O0I+knuYOAo4Sm0s6+wqt2jnRp9wrnBv
 zWfhQRkxi9t6Vp+C+s2d6BS1uznHvEYU/eh+BVPpzYIW3ITFvC+YRkpFwtL+8A+lOZGd
 yuEbeKAko2fZlGwRbORPBjgN8JfBCsYXm+/HUmnelMHt1sAyDGLS0x/mgZvKELl1jOip
 G0K3UaN2+5UEsNVW0b1TfLoSB5PfIZ6GnLFnd082+tRC4hSF0qrxg2mXDHdqTL+lwhh0
 uxjEr6IErfK3vgKb3Af9rI0uMqOSsWKU5WywulzjPmppsf4yJlksifjdDnDskCdBYMMy
 htvw==
X-Gm-Message-State: APjAAAVP6URJOaU96ufdsknBOt1K23P8YqAPVXcApjlRmz+f/fPgwxvB
 0MBNbz6HmlJgf2xTgBcUNqw=
X-Google-Smtp-Source: APXvYqyGRDkcyZiUrUtDPQRBGg9cL3kxPSNQKgusxtHRYl7feZerAFS6loEEjxP7dgAIhjejyfDbvg==
X-Received: by 2002:a17:902:8a92:: with SMTP id
 p18mr13546542plo.275.1572791478754; 
 Sun, 03 Nov 2019 06:31:18 -0800 (PST)
Received: from [172.31.59.206] ([216.9.110.8])
 by smtp.gmail.com with ESMTPSA id q8sm6344319pjp.10.2019.11.03.06.31.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Nov 2019 06:31:17 -0800 (PST)
Subject: Re: [PATCH] nvme-multipath: fix crash in nvme_mpath_clear_ctrl_paths
To: Anton Eidelman <anton@lightbitslabs.com>, linux-nvme@lists.infradead.org, 
 hch@lst.de, keith.busch@intel.com, hare@suse.de
References: <20191102002755.25165-1-anton@lightbitslabs.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c857ecec-7009-174f-ecb7-c43fd77212b9@grimberg.me>
Date: Sun, 3 Nov 2019 06:31:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102002755.25165-1-anton@lightbitslabs.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191103_063122_430322_BBFCE44F 
X-CRM114-Status: GOOD (  12.58  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> nvme_mpath_clear_ctrl_paths() iterates through
> the ctrl->namespaces list while holding ctrl->scan_lock.
> This does not seem to be the correct way of protecting
> from concurrent list modification.
> 
> Specifically, nvme_scan_work() sorts ctrl->namespaces
> AFTER unlocking scan_lock.
> 
> This may result in the following (rare) crash in ctrl disconnect
> during scan_work:
> 
>      BUG: kernel NULL pointer dereference, address: 0000000000000050
>      Oops: 0000 [#1] SMP PTI
>      CPU: 0 PID: 3995 Comm: nvme 5.3.5-050305-generic
>      RIP: 0010:nvme_mpath_clear_current_path+0xe/0x90 [nvme_core]
>      ...
>      Call Trace:
>       nvme_mpath_clear_ctrl_paths+0x3c/0x70 [nvme_core]
>       nvme_remove_namespaces+0x35/0xe0 [nvme_core]
>       nvme_do_delete_ctrl+0x47/0x90 [nvme_core]
>       nvme_sysfs_delete+0x49/0x60 [nvme_core]
>       dev_attr_store+0x17/0x30
>       sysfs_kf_write+0x3e/0x50
>       kernfs_fop_write+0x11e/0x1a0
>       __vfs_write+0x1b/0x40
>       vfs_write+0xb9/0x1a0
>       ksys_write+0x67/0xe0
>       __x64_sys_write+0x1a/0x20
>       do_syscall_64+0x5a/0x130
>       entry_SYSCALL_64_after_hwframe+0x44/0xa9
>      RIP: 0033:0x7f8d02bfb154
> 
> Fix:
> After taking scan_lock in nvme_mpath_clear_ctrl_paths()
> down_read(&ctrl->namespaces_rwsem) as well to make list traversal safe.
> This will not cause deadlocks because taking scan_lock never happens
> while holding the namespaces_rwsem.
> Moreover, scan work downs namespaces_rwsem in the same order.

Thanks Anton, this looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
