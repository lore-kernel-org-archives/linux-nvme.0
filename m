Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A6C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 02:49:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A7761002
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 02:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A7761002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OmY4zNew00KBWgRYc8yc1txybHhmcEURWwlkuujzqOw=; b=HLsG0bnpfcXLEL
	tyQctraA8CMyAzi3I40OmcykPYrAnmgdXwg/7T0mjE9C6vxg3nZC0UsDXkwYM2fVK3VhQCPl97vEJ
	5FVR2/c7LMzlOWfRMygBpCbJDw/UV5O0UVIpJXgxEWwMFgd7bPYnFKWZ10uGlRkIpNe+JKm9SvIhB
	AnaoF8KnDRcObesv3swEtveRLr7Q2wo4egxlPeSGox4ZE77ZZ2FuzPYLqfGKcZdMjLgDQ4jgjKiAg
	xu0ZbTVSXbox3eYkQcp4sHOjRNXkivsDQB05b3Eu6TG170HX6RvTuMOtXa42/TL4C4pjFy2uWzEYA
	NWqFHvl8jCxKJhiFQNfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5fof-00Bk18-My; Tue, 20 Jul 2021 02:49:05 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5foc-00Bjze-Tp
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 02:49:04 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d9so7189281pfv.4
 for <linux-nvme@lists.infradead.org>; Mon, 19 Jul 2021 19:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E6Rf+4wgAd/KIx7u2UI7BooW0YqsBTQvN9ct7KjpyIs=;
 b=RC6/CNzkC2FjOenOSnTfnDmv8POLfBCQ4hZGIdbJwBeW6tPlDX+qShSDYME6oOh4L1
 DimRbpxEY5fT/AL53H/aNi//NqLm0xxARkcJo5Sm20n3psNPpiPJHdoYYuPO/1XOYK8v
 D5B6CyXURzeeHolU4CvZEagEw5rdxfKqZlA6IKVziQPzQ1FACJTx6fU/lJLItiaKn3iS
 kzYnwGw8cC0MwNlBYsRbRd1plSVjbRY+8Rsm+NcbVx8o+fAXvT9t1XK8+toulJkdicvg
 XohztORvhRQf15Iwr5qkIWRTWNOJTtPO9hbycUHon1g29O7crVPWQJvSTd0R/wdvfOBU
 fV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6Rf+4wgAd/KIx7u2UI7BooW0YqsBTQvN9ct7KjpyIs=;
 b=j86eKw0by7JKqKYb1soEtwcmVYpjt73LcKc4QFbu4Fdn3Z4/MccjsoDluKesvjuqKj
 A41sTths2HNSACow9rtTOTKs0XmFqffforMyaGGl3vdEF7vIIxMayjZ+BzOPq4ylTyIE
 uU0v2WjH1hl5XluyaHdebNIWKyfgJ2Q+02VvZOs0AfDZAngK9H+nMduunXK6wECXQqxv
 ZxL0O7Afl9HHFDpzgX1Q4vSmF/DiWjqUlaPynXoufKomIKfq46iL9FoUjFYv94VEExo4
 M8G2wL5SGdIO5iRLMJUkHVes1Mb84A4GXvtuP8V26vcK3RWkcPPpj/NTBOhGwsHq/xyH
 Uwdw==
X-Gm-Message-State: AOAM530hpwaLRw+1XoSXJbArdErVNWGPyom9iDBCt4tUUBRbDJdVlH2o
 Ft5iMQJ2+x4/wn7FqgVptmI=
X-Google-Smtp-Source: ABdhPJyC/SkINMaAUSZ3YzHZrUDsnqo/oajxu9ffao0WtQ8i+P9Rr5hfAEVPBiXHdF3odVZ0sR1QzQ==
X-Received: by 2002:a63:494d:: with SMTP id y13mr28966533pgk.248.1626749339045; 
 Mon, 19 Jul 2021 19:48:59 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id w6sm24050035pgh.56.2021.07.19.19.48.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Jul 2021 19:48:58 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 houpu.main@gmail.com
Subject: Re: [PATCH] nvme: fix nvme_setup_command metadata trace event
Date: Tue, 20 Jul 2021 10:48:47 +0800
Message-Id: <20210720024847.805-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210719164439.2002887-1-kbusch@kernel.org>
References: <20210719164439.2002887-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_194903_017010_5CAC6747 
X-CRM114-Status: UNSURE (   8.79  )
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

On Mon, 19 Jul 2021 09:44:39 -0700, Keith Busch wrote:
> @@ -66,13 +66,13 @@ TRACE_EVENT(nvme_setup_cmd,
>  		__entry->flags = cmd->common.flags;
>  		__entry->cid = cmd->common.command_id;
>  		__entry->nsid = le32_to_cpu(cmd->common.nsid);
> -		__entry->metadata = le64_to_cpu(cmd->common.metadata);
> +		__entry->metadata = !!blk_integrity_rq(req);
>  		__entry->fctype = cmd->fabrics.fctype;
>  		__assign_disk_name(__entry->disk, req->rq_disk);
>  		memcpy(__entry->cdw10, &cmd->common.cdw10,
>  			sizeof(__entry->cdw10));
>  	    ),
> -	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
> +	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%x, cmd=(%s %s)",

Can we also change "cmd=(%s %s)" to "cmd(%s, %s)" like the target side.

Current host side trace:
kworker/3:1H-120     [003] ....   115.253610: nvme_setup_cmd: nvme0: qid=0, cmdid=17, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=2, ctrlid=0)
kworker/3:1H-120     [003] ....   115.264971: nvme_setup_cmd: nvme0: qid=0, cmdid=18, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=3, ctrlid=0)
kworker/3:1H-120     [003] ....   115.279639: nvme_setup_cmd: nvme0: qid=0, cmdid=19, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=0)

Current target side trace:
kworker/0:1H-56      [000] .... 50793.382363: nvmet_req_init: nvmet1: qid=0, cmdid=17, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_identify, cns=2, ctrlid=0)
kworker/0:1H-56      [000] .... 50793.391998: nvmet_req_init: nvmet1: qid=0, cmdid=18, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_admin_identify, cns=3, ctrlid=0)
kworker/0:1H-56      [000] .... 50793.406733: nvmet_req_init: nvmet1: qid=0, cmdid=19, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_admin_identify, cns=0, ctrlid=0)

Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
