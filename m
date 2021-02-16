Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4C1C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 09:52:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A5E64DC3
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 09:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A5E64DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8tQdDN3gaFADsxtm8PAEVnBW7ZsWUynPplnLA/LnBg4=; b=dwWCIfsULoL3gg4XApGjhDlNy
	g4ePZckZjfx9ugWbXOxFD6kl72tJUZYuPOwfdXOuOefNvY+lIO3fHoqeb35ABcRPCMwjJQboNaPmc
	MfxoHZlOKk4GhDeWRqAN5q9vAqyEeynuixyYmBwi2v4Ka5ElI0a2zvxjdV5Un4F4yxN+Nrkj/zlSM
	EM/I8uHEJOxmU5bR12R98Gf9mlrpBmvLb62241wh0dyp+lRzoDAKYPEJjbqb3ZXOgODH9RLUr9uDc
	zXwaExqeCnaxUkWWGx7Ob6PBA1CGAhW3MVd7+0R0aMnGa8dDC0fcE76jwAtXkNASV5CB0ww0nZ6Qw
	ucnktetrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBx1N-0004KN-Mo; Tue, 16 Feb 2021 09:51:53 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBx1L-0004Jr-5t
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 09:51:51 +0000
Received: by mail-pf1-x434.google.com with SMTP id q20so5805167pfu.8
 for <linux-nvme@lists.infradead.org>; Tue, 16 Feb 2021 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zBnp4nouCS23WAxP4fKr2LRs8TJG9sd/FMHkWmpWOBk=;
 b=VKnPBZaJShwO3iDQXyh78Zt7C04Dg9AB7tlodwJfJr9snTnsilvYZNtQWYFQ/Sqk6f
 9IYjV/1HyDnbhgaxzL0gwvot62rwenCEhBTjT5sU/2BJ7uOjFSjxnQuaMH/9Q/lFLR7f
 aFV3kemm+b7ZPDKifV2eV6KKFmZus8qz0ZjE+SLFstrEDaS9PH0BFqTtxLs5hLxPpILC
 VBQ+vIiY/25LoruxTVcpcDQmuteLWiSM1hLi7Lt4CqftK8n2WyEBdU+6S78vDpN7Pue/
 ZGpNkzWWNxQSCgA48U4HNiQqpj1WTxvQcwj2CWoHIzec+AXWopjqeHhVFYxvtpfak+wy
 AZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zBnp4nouCS23WAxP4fKr2LRs8TJG9sd/FMHkWmpWOBk=;
 b=Hzmo6EahCiAlJ083ddLZ0IqnwoWbunvFnEu8Rw6zanTayRmuBeTBWnNg7+3WkXF/Du
 gUcNeku05BZa05qtPtRfnQJAQXsk9pgErCj3Triso6CtUcxtkpnC3FdLE5q+QXN/6/kd
 Oi27NF564iyz3QEC5BLDu9jtC8UM9rC6Fwdts6NNv0XzALhVGIA7yF7YQxtWVkpwbiXg
 kD4FAK+EzMdP3nJLccvKkKX/zVWn9z6oYYZn6lWSIXB3m64Knl0XfxtKQTq4+RfvW2eI
 /jv7fBQADg97dDNahEPWYNP7+y4jKOGRNgU1Au99fjtNGXjz1RimLhYZWMlrMFjFoiWm
 nhEQ==
X-Gm-Message-State: AOAM531vb7pOLCT+mlHfQj7GM8wT1RVa7JoOPtoI0MKisXFQbmzAd7ZI
 GF3JMaaOhBqk5Mvwc2AQTxU=
X-Google-Smtp-Source: ABdhPJytifKhonO1scEKzIybCPCswVMNN51HEY8io+GEO2A6/WcdQC0QsEZHvkN8Hb6ep4bcncgbJg==
X-Received: by 2002:a62:78c8:0:b029:1d3:85cc:2133 with SMTP id
 t191-20020a6278c80000b02901d385cc2133mr19368065pfc.65.1613469109139; 
 Tue, 16 Feb 2021 01:51:49 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id b17sm19847013pfl.190.2021.02.16.01.51.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Feb 2021 01:51:48 -0800 (PST)
Date: Tue, 16 Feb 2021 18:51:47 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: introduce passthrough ioctl for multipath
Message-ID: <20210216095147.GA2601@localhost.localdomain>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
 <20210214110126.24023-2-minwoo.im.dev@gmail.com>
 <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_045151_280122_D0515EC0 
X-CRM114-Status: GOOD (  20.97  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-02-15 09:02:33, Keith Busch wrote:
> On Sun, Feb 14, 2021 at 08:01:25PM +0900, Minwoo Im wrote:
> > We don't allow NVME_IOCTL_IO_CMD ioctl in case that a controller has
> > multiple namespaces attached.  Also, I/O request to the controller
> > character device has not been recommended and deprecated because we have
> > block device to I/O with where the multipath consideration is taken.
> > 
> > Once kernel decided a path to I/O for a namespace based on the I/O
> > policy of a NVMe subsystem, userspace is not allowed to choose a path to
> > I/O.  If a path is broken(inaccessible state in ANA), then it will not
> > try to I/O to that path.
> > 
> > This patch introduced NVME_IOCTL_MPATH_IO command for controller
> > device(e.g., /dev/nvme0) to support multipath I/O passthrough for
> > userspace.  Regardless driver's path decision, userspace can target a
> > namespace to I/O.  In this case, `cmd.nsid` will be used to find out the
> > namespace instance target which is hidden(e.g., nvmeXcYnZ).
> 
> IO commands are not allowed through the character handle with the
> existing ioctls. A new ioctl doesn't make it okay. If it was okay, then
> we could just remove the limitation in the current ones.

Thanks for your feedback, Keith.  If you don't mind, may I ask why it's
been entirely unsafe and deprecated in the exsiting
ioctl(NVME_IOCTL_IO_CMD)?  I've seen a patch bfd8947194b2 ("nvme: fixes
for NVME_IOCTL_IO_CMD on the char device), but have no idea why it's
been really depreacted :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
