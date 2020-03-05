Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880BFC3F2D2
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 20:57:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CED520801
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 20:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IXggErfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CED520801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gqLwUkPpECiKG3gKMxzjLeLeDkqVPvWCPQdBANW/5Hc=; b=IXggErfgUZCTWMcKaeL9FhGf7
	+agiZqHtEHNPQmXO+a30M0RjJmjXKKt4wrQ1pL484flcAab2Kkq9lNkcPnG67/ZpYnSQ2G5w46HL/
	4WqXAo5dweV2hdCWMYJhtdEDN6ePezZgn0mz3EwQAeEmNzL6UdM8JezDHBlccNOseQiUCclPLKFjs
	muyWqog2DxcqEBsT9+XxzJqYJV8evVKE4bsnAIjD6HQI4wDZ1J2ZFnlOneMN/G6UW7UXLdHZM8pUX
	q79lfcAOvA0g2zQeP7q5hFI/B4qzFkjy8CTDO0T9JfD3njbM2WjJ0HVq8Qff9D9h2/LdTSEZif6Np
	wzC8OiiEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9xYK-0001PK-9O; Thu, 05 Mar 2020 20:57:08 +0000
Received: from mail-oi1-f180.google.com ([209.85.167.180])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9xYH-0001Op-6R
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 20:57:06 +0000
Received: by mail-oi1-f180.google.com with SMTP id c1so299199oiy.2
 for <linux-nvme@lists.infradead.org>; Thu, 05 Mar 2020 12:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6TNJyu56HtsytA/M+eXPaQjyFqz8KUspI7MR0nNmu3c=;
 b=Prv/oyoavDh2BitNi2IwL/m2jGv0dXuYV/Qi8SBjuCkE58ITkJm0xtJ61Zhv2BBbfu
 bp2PAmlc25xp8tvMjLrh9M8zQzyLcrq6bxD/1l1ClZ9RIiHESiY5xscs6LHym0XhebJ7
 B1PvDVuXNQzKTrmMmGzATbMPG2dGLdmYjyooUx+DqYVSmVKztsIs1o0SD1O8LwW8xoo1
 bTDCONLybdNwFWSITL1O1BPsHYbPO1BEeuYgeb4NODb1o/9zaBPH6ycppg72kzU9ZxdM
 p8TB7B6t2Yg8TmRDbOu/7e88Cqyw3XLlw5M6jQYUsrjA6cuYszia0byfLXvBLrVrdCh4
 nbUg==
X-Gm-Message-State: ANhLgQ0X3+leJ95nfDh897/54q3j1JSr7Wu27v+DpZ5kl/andFg48ClX
 6pHbs4LZDaP4QNLOuoa5+BY=
X-Google-Smtp-Source: ADFU+vvhdNHVG/kGslmUXN6haxoACRebAb5kQgjrlPdPXJnBBebmU7gfq1eIh0IklIUlMStjNuuAZA==
X-Received: by 2002:a54:410e:: with SMTP id l14mr261096oic.42.1583441824592;
 Thu, 05 Mar 2020 12:57:04 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id e79sm1969540oib.10.2020.03.05.12.57.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 12:57:03 -0800 (PST)
Subject: Re: [bug report] NVMe RDMA OPA: kmemleak observed with
 connect/reset_controller/disconnect
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
References: <215235485.15264050.1583334487658.JavaMail.zimbra@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ef49292b-c39d-2f0b-99ca-2835b6afff97@grimberg.me>
Date: Thu, 5 Mar 2020 12:57:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <215235485.15264050.1583334487658.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_125705_237571_5BAE811E 
X-CRM114-Status: GOOD (  13.01  )
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
Cc: kbusch@kernel.org,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CCing Linux-rdma as I don't think anyone in nvme will
have a clue to whats going on here...

On 3/4/20 7:08 AM, Yi Zhang wrote:
> Hello
> 
> I would like to report a kmemleak issue found on NVMe RDMA OPA environment, here is the log, let me know if you need more info
> 
> unreferenced object 0xffffc90006639000 (size 12288):
>    comm "kworker/u128:0", pid 8, jiffies 4295777598 (age 589.085s)
>    hex dump (first 32 bytes):
>      4d 00 00 00 4d 00 00 00 00 c0 08 ac 8b 88 ff ff  M...M...........
>      00 00 00 00 80 00 00 00 00 00 00 00 10 00 00 00  ................
>    backtrace:
>      [<0000000035a3d625>] __vmalloc_node_range+0x361/0x720
>      [<000000002942ce4f>] __vmalloc_node.constprop.30+0x63/0xb0
>      [<00000000f228f784>] rvt_create_cq+0x98a/0xd80 [rdmavt]
>      [<00000000b84aec66>] __ib_alloc_cq_user+0x281/0x1260 [ib_core]
>      [<00000000ef3764be>] nvme_rdma_cm_handler+0xdb7/0x1b80 [nvme_rdma]
>      [<00000000936b401c>] cma_cm_event_handler+0xb7/0x550 [rdma_cm]
>      [<00000000d9c40b7b>] addr_handler+0x195/0x310 [rdma_cm]
>      [<00000000c7398a03>] process_one_req+0xdd/0x600 [ib_core]
>      [<000000004d29675b>] process_one_work+0x920/0x1740
>      [<00000000efedcdb5>] worker_thread+0x87/0xb40
>      [<000000005688b340>] kthread+0x327/0x3f0
>      [<0000000043a168d6>] ret_from_fork+0x3a/0x50
> unreferenced object 0xffffc90008581000 (size 36864):
>    comm "kworker/u128:0", pid 8, jiffies 4295778075 (age 588.608s)
>    hex dump (first 32 bytes):
>      84 00 00 00 84 00 00 00 40 01 36 5d 84 88 ff ff  ........@.6]....
>      00 00 00 00 00 00 00 00 00 00 00 00 40 04 00 00  ............@...
>    backtrace:
>      [<0000000035a3d625>] __vmalloc_node_range+0x361/0x720
>      [<000000002942ce4f>] __vmalloc_node.constprop.30+0x63/0xb0
>      [<00000000f228f784>] rvt_create_cq+0x98a/0xd80 [rdmavt]
>      [<00000000b84aec66>] __ib_alloc_cq_user+0x281/0x1260 [ib_core]
>      [<00000000ef3764be>] nvme_rdma_cm_handler+0xdb7/0x1b80 [nvme_rdma]
>      [<00000000936b401c>] cma_cm_event_handler+0xb7/0x550 [rdma_cm]
>      [<00000000d9c40b7b>] addr_handler+0x195/0x310 [rdma_cm]
>      [<00000000c7398a03>] process_one_req+0xdd/0x600 [ib_core]
>      [<000000004d29675b>] process_one_work+0x920/0x1740
>      [<00000000efedcdb5>] worker_thread+0x87/0xb40
>      [<000000005688b340>] kthread+0x327/0x3f0
>      [<0000000043a168d6>] ret_from_fork+0x3a/0x50
> 
> 
> Best Regards,
>    Yi Zhang
> 
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
