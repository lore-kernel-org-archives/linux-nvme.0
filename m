Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE006C388F9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 23:00:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14134206DC
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 23:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KPsxdsDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14134206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p7MgayyHXEOQ2+m9OEGZgiqNmqMMtDglwXwoQnUPc4M=; b=KPsxdsDBxVxk98W3duV4Z0bBj
	FOg26GNSoYJHbODgj639Y9TlyCttf1xeBQlp5zI2Ux39cEcuZ8g7mlFMkcqeRbqdHeJKvJa5r5nrO
	FDw/v5IsVQ84d/VvQ7ozaAu3ybVeXUXaNbc1+54v+LlRr3YhITNiDvAXgp5AAx2HKlYB86dXYUkOS
	N17axovhkYV5qTT5XLtZ3/eVc0qJA0G2XmrbLDgLkEYnhWq3juu8mmSlXOf3E/kjic4TKQ3fEYsGo
	Wz6Wr4emQfOc/PqtJGrOgjdSkrtGeEg1AEoFGc8kpP5Yud+JmOpabpUpWK6DDwWF5YM4vZY/Xrjm0
	aCKd2Yq+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbtfs-0003ce-4S; Sun, 08 Nov 2020 23:00:40 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbtfo-0003cB-UI
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 23:00:38 +0000
Received: by mail-pf1-f194.google.com with SMTP id w14so3467820pfd.7
 for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2020 15:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IUVh0a8D4C5TiM29iNzybajP3uMt3uOn88rEtvvNL/c=;
 b=Sj16PSt2ZRBnPGwUaeOBb113RXM5UJJVDgrr6hsLFkCBgRpSM9Hrwddk6A1dk91Mel
 I00gUmCOdoPD7L4wOUSgHAF3yXq41zi2wZErEY/3VwbTh5bYs16J1q7hLhwaObxelrX6
 sgGmVvyJ/O43X+WWTYc+jkJgRDZnm+pO+UFRC/X2g9c7IFufZmJC9hi+ovqvfIpCNMwh
 9KdPIMpgnzHZB7JJWpDGLuIF+5ZKjWSXg9o+9UiqPzLC9odmDW6qc/RJ1YpW3CgYNiJ+
 unBit85uI8lpGOJhEQF1J5tlLNQdSMkeOMyE9nBI+uDC4wWw4+1hR7XhCgc3et8P+bEK
 EATg==
X-Gm-Message-State: AOAM530YhoODZpUcJOUvTgbdaksgoF8ktWJXSvGNiCqFi82unQvTIMcw
 9QIxltqeVrZuuwpKyFdulsc=
X-Google-Smtp-Source: ABdhPJxDG8vNAMnF2xn/KDiMAvad308cBHK1oxxIgAplfWPBCn8lT8FDGlW3mj6fkPIdckxw6FuZPQ==
X-Received: by 2002:a17:90b:19ca:: with SMTP id
 nm10mr10245442pjb.213.1604876434508; 
 Sun, 08 Nov 2020 15:00:34 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id k9sm9109168pfp.68.2020.11.08.15.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:00:33 -0800 (PST)
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <da5be7f4-fa7e-3896-fd1e-8d2c0d80565a@grimberg.me>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <9d3736e0-523f-aba9-0564-37e64c3f9158@acm.org>
Date: Sun, 8 Nov 2020 15:00:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <da5be7f4-fa7e-3896-fd1e-8d2c0d80565a@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_180037_015542_34ED0747 
X-CRM114-Status: GOOD (  14.76  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/8/20 11:13 AM, Sagi Grimberg wrote:
> This would make the controller instance inconsistent across reboots
> which is annoying for some users.

Hi Sagi,

In addition to Greg's reply: a similar patch has been accepted upstream
for the SCSI sd driver more than a year ago. Only a single user ever
complained about inconsistencies across reboots. That user had not yet
heard about persistent device names but was happy to switch to
persistent device names after having learned about persistent device
names. See also commit f049cf1a7b67 ("scsi: sd: Rely on the driver core
for asynchronous probing").

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
