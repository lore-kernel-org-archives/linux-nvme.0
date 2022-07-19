Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F54DC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z76mMAyVNcgpMhl/2GZ2y9kb595oDvGwQFD+Z+iCvTw=; b=QrHgIb2XGL14HHgBHHFuQWiF0i
	U07Vg5rn2w5RLPm7ExEJPmjuSH0wqVMaKK1Z6NsJ+xMgaxhpKgNXsG4TZCksJLKZnc1bNQRN0s++S
	ATNTL1NVj34nfrLgslS4N0Ewg5cRkEEY3JQJx4Px0FQGO7fsFW+ySkmWYRNxxmeDaF9fYC8EJfkpz
	navgNhp171JC0RDuR6k8z6yf3TytYhLfaUff7xkFXBEUxuXcCcNp0jYF8GDWXWa4FlzoCPyUGeG2K
	zIpTWtISM9h/f4Qncj7R4J3nk9QATVfb5+3jQMIFq9hgeHlFfyHzCa/54TkZ6neq32HrHw6fd3hcb
	pIOixHrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDpmG-00AOSO-QM; Tue, 19 Jul 2022 16:08:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDpmE-00AOPP-LQ
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 16:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658246924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z76mMAyVNcgpMhl/2GZ2y9kb595oDvGwQFD+Z+iCvTw=;
	b=VSnS+czuHH5t4FEDdFTtkyXd03EyEhYLyRKUQSmunLRxq/Is9+DjO8AnEC0lZHEsoKKoeb
	80+n65UkcYEyTVAZCEsg/j6M/WhwvkZ7sEZ3Etad2dy8QSuYNVJxZfZmpLv0iywawsOf2b
	xZlR9eUgXYs2C6pgQGCFlguTEH8F5F0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-hKDtv9A9OESi2WpMDlz5bA-1; Tue, 19 Jul 2022 12:08:43 -0400
X-MC-Unique: hKDtv9A9OESi2WpMDlz5bA-1
Received: by mail-pj1-f69.google.com with SMTP id 1-20020a17090a190100b001f05565f004so5407308pjg.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Jul 2022 09:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z76mMAyVNcgpMhl/2GZ2y9kb595oDvGwQFD+Z+iCvTw=;
        b=4B+Bz+iNy1hNtUVKPx1dX9GdyHY5gj94PUxCOOFrRkWAT805arDv7vHwrpl+fhAQeu
         ZEh+wHs8vU1y+Pwc1xIniUUD7VTZJFq56EwMX/ylp9UUZBv1LxTizzAdmB7lIbC/ZOC9
         TogQZILwkiId7JF1yWlHnH2drZrQJxAtaSO4FPEej4DieTCaGQ0M9OYp1WsAq9+hOx0E
         a5jrpwEMLybq0goRz4i+xPD5Kr/naTJJ6p3sInoPLFgKjICRTtcKqv7abiAbIK2O4xAc
         aT5d2uGonIZmJAascplNgD5wKlGSiXpLO9NKWLdIRkE/JM56Qm3QjtIJf8X4WZdO+36Y
         j2tQ==
X-Gm-Message-State: AJIora++5nX8r4d0S07nSTJjw/P37M4Wx9rN/WhowsY7ziIWD/pwdSUx
	6qlJVBZFSXPlvjRxfMAxbkWRGIRrPCiF+tgfeqFS1dC+qycBwAi1WcBzqp/F9TqQyGn+Vl5oJmJ
	bOzcX1GcwYKxJ1UJCLBj7KVmBIlZlsqY+St2DNGdtqTU=
X-Received: by 2002:a63:500d:0:b0:415:e89e:42b7 with SMTP id e13-20020a63500d000000b00415e89e42b7mr29518008pgb.140.1658246921813;
        Tue, 19 Jul 2022 09:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vHmONF19r9mTSu7JDXjXG1Ig0+0UD70/k1vnuYGjD3w/OR7oS2grLIG/db08d6jG//hRIChZrjzqzvaVaW4yc=
X-Received: by 2002:a63:500d:0:b0:415:e89e:42b7 with SMTP id
 e13-20020a63500d000000b00415e89e42b7mr29517988pgb.140.1658246921505; Tue, 19
 Jul 2022 09:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
In-Reply-To: <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 20 Jul 2022 00:08:30 +0800
Message-ID: <CAHj4cs_zp2oewNqsK-X1bygCGDcp4rOEmwqftjAFzVsyxG7_8Q@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_090850_802172_0F1633D3 
X-CRM114-Status: GOOD (  14.22  )
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

On Sun, Jul 10, 2022 at 5:41 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello
> >
> > I reproduced this issue on the linux-block/for-next, pls help check
> > it, feel free to let me know if you need info/test, thanks.
>
>
> These reports are making me tired... Should we just remove
> MEM_RECLAIM from all nvme/nvmet workqueues are be done with
> it?
>
> The only downside is that nvme reset/error-recovery will
> also be susceptible for low-memory situation...
>
> Christoph, Keith, what are your thoughts?
>

Hi Christoph, Keith

Ping, in case you missed Sagi's comment. :)



--
Best Regards,
  Yi Zhang


