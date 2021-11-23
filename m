Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3419BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkRRDgFZ1+w73iqpHYhGCV55nVWJ+/2QrQ1p7z3U7cA=; b=hhlPHzowxfqNZIGJkeXP11xGg7
	BugSDCzGxN4RiMy3BOMvGWH9J+yvZbWFPOYC6g6kxnhTtr2CTyrIv2nmI12/MKmCqjc4i9kLAlRFX
	70JtzZufvf1fuHgFnPDb1eP/RONKrvS+oo00TJUyZSOQZQPN7tympUKb5qgQsDj2cwBc/6WWdbLkW
	EqbPMygsTSq8/kQSWDcT9v7Qm65u2EbSbiSkvvvrRVAqbaBluawb/JXIh3e08I/cxqH5fK2Ycp63B
	PugnuaYb3rXqirheEpo8celIdXcYk7QzAiGisMBW92ZSqCJnb77WsfqaaAxvjMF9AYX+wSVmrvYoJ
	VczjNNsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpRkH-001Q6c-Nw; Tue, 23 Nov 2021 09:05:45 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpRkE-001Q4Q-0p
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 09:05:43 +0000
Received: by mail-wr1-f45.google.com with SMTP id d24so37748413wra.0
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 01:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KkRRDgFZ1+w73iqpHYhGCV55nVWJ+/2QrQ1p7z3U7cA=;
 b=yZgTx1O2E+aCYRNewGWG0AohVlmg+UPY2j5qbJrIg/7uwsN3ujwXYJpUC+IP3JW8zO
 FWI32r5th/9p4S8Li9YorYfidKnvW8ACoV/pDStMEXsjZifOGni8+kkL51v8oKAUmFwY
 RpDXZnpYHrYvZH6kVvxnz0DWBIdvmRz2KuvUu9tRyAaGCQ53BI16jHkggMLjHwZEOKUh
 RI0hVuotkJxAlpJ0kv8anyX+bx+b8odv5ouOTG4+GUhcpZdf9UlgqZnVqX1uYBo3VRmR
 PRZuDxbvsauLgKijmlYncYPWxqW7tWq/doMdepBGyA81d/usVAnqqnhuu3m1qFHIVnAm
 HXIA==
X-Gm-Message-State: AOAM530P3kQF5KXe/QTyyxxzv7tiHiNbRkSRqvVw8dS9phXqT0B6MCpN
 2PEdVmtfyXCiZq0QttyJENQgkBnmmi4=
X-Google-Smtp-Source: ABdhPJyP3s2ii5LAJL2RRxYSSrsSd4GDOu1E78SQAMMP6qUgOxMFKzVXNthg+1ffr9TYRooybECm4w==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr5553135wrr.143.1637658339212; 
 Tue, 23 Nov 2021 01:05:39 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g198sm484893wme.23.2021.11.23.01.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 01:05:38 -0800 (PST)
Subject: Re: [PATCH v2] nvme: Add sibling to list after full initialization
To: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20211111132135.19216-1-dwagner@suse.de>
 <YZfakf32dXVFhK5E@infradead.org>
 <a7f48220-8c50-3388-dd40-4f51081ec6ec@grimberg.me>
 <YZyDGRhyjYJu+9jK@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <064b3972-dab4-c31b-b5c9-b0d9b1475ebe@grimberg.me>
Date: Tue, 23 Nov 2021 11:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZyDGRhyjYJu+9jK@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_010542_086234_52D27AE7 
X-CRM114-Status: GOOD (  18.97  )
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


>>> Thanks,
>>>
>>> applied to nvme-5.16.
>>
>> I thought this is not needed upstream. Daniel?
> 
> Why?

The correspondence on v1 of this patch concluded that it
is not needed for upstream.

--
On Sun, Nov 14, 2021 at 12:56:55PM +0200, Sagi Grimberg wrote:
 >> Adding the newly created namespace before the object is fully
 >> initialized is opening a race with nvme_mpath_revalidate_paths() which
 >> tries to access ns->disk. ns->disk can still be NULL when iterating
 >> over the sibling list.
 >
 > But ns->disk is assigned before nvme_init_ns_head is even called.

ns->disk is NULL, but we are missing 5f432cceb3e9 ("nvme: use
blk_mq_alloc_disk") in our kernels. The commit moves the ns->disk
assignment in front of nvme_init_ns_head.

I didn't spot the code change when I forward ported the patch.

Sorry for the noise and thanks for the feedback!
Daniel
--

However I do think we need the following:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3725b6a3791c..516eedeca044 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3885,8 +3885,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, 
unsigned nsid,
                 }
         }

-       list_add_tail_rcu(&ns->siblings, &head->list);
         ns->head = head;
+       list_add_tail_rcu(&ns->siblings, &head->list);
         mutex_unlock(&ctrl->subsys->lock);
         return 0;
--

