Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA346D58D7A
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 18:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzYkSNgnf8EonySDR7Fa77XNgGBVWrKQSqsJOQ+Hnls=; b=byAumyxqFbXColycdLoY8CuUNf
	ezyCaMxFDbY6YuIIPdoXGcJrFDrAeBaSU+sIJXvrGEu0cytpg3MNVZGbzxyK7pN1W4tIYss8Gl+XS
	kzjUbj0YC6AyGwyVcojzcKknA210UfkfKgnHMxpy6OvujY4zcn29/oPQE+5K1sK2ZXazdxKf0M/Us
	7tu9NpEDoxYxkwKG1OKSsfB+KK0yiTmO1dtn2zSpnxw84bI5rhL81TbOqgasmb3V9Lg9rILci7JqN
	geEAlpNJUIIVOdrZ+C7FnZtA8lpStAHYsrNszGRWnmPWnoWOzwvcbItv6oICcpg5z8q89PYToL3u4
	oFyOmSJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFdoe-00000008rVq-0RVs;
	Mon, 25 Nov 2024 18:28:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFdob-00000008rVA-0tcK
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 18:28:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732559284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzYkSNgnf8EonySDR7Fa77XNgGBVWrKQSqsJOQ+Hnls=;
	b=B9WIynCOk7YOa13D2bijMR4uke7Om7cQy/LpLpmZV1R/VuAv6fOiZyH9E55Qh/BXkiaOt4
	3TCnnL7TdP5nQPOHFH2ByYHxU6c1LsuGYNT7fXjL/Ra6HqlWGypRPWeyF6f6E5AyXd+Q6c
	Bl5+XCJedOQY+l4QzhyosVdMNqEjtaA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-F5n2cUuQN4abllZ9txxNHQ-1; Mon, 25 Nov 2024 13:28:02 -0500
X-MC-Unique: F5n2cUuQN4abllZ9txxNHQ-1
X-Mimecast-MFC-AGG-ID: F5n2cUuQN4abllZ9txxNHQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349cda1899so12618985e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2024 10:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732559281; x=1733164081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzYkSNgnf8EonySDR7Fa77XNgGBVWrKQSqsJOQ+Hnls=;
        b=Q5GWZt/1bCYDHGELqhQ38pNdVco8dm3t20Vaw0SQhz2Ab/8ukhWOoElWuTM2Iq9IQS
         BvUAOTW5jE6JFkLWRWm4xdruz9BfEHrU0ehkcXAP2ifq2eheDU0fLntvr8PqxJtv4fMj
         GwanvNK2gJtPDivM+qp0IlX/I1ZcufTLeefxzj4Uxxo08K/xMwvsDM5ea/oMJGZJbkks
         mlqo90TT7GKe0Xa67Jeuu7V99TexRMsTEgZx6ctOJO078oWKm7rDHr8rUvxyL8Dqo5mY
         ECFBeQmiVv0AhyIXlPULQrju/Xfq0hyrMxYgiFaPDO1Ch5r0alo1yEID0CwbEoTnkrdl
         +A3A==
X-Forwarded-Encrypted: i=1; AJvYcCUnDcifzJssxvcJIYR57o7NGG5HJ2RojRxikseOwDgj6/+cSUewFGvSBdoVNGZspcEktt2bfwR88h1i@lists.infradead.org
X-Gm-Message-State: AOJu0YyLkDz/9lA2tLTtLaF8KPq6QYQ80ef2bwtZJ+0759n/WU6A/zve
	dM9o/rG2AsLHFfO5S9kYxN6UeXW/Ubb8rEiv3Liu+tMjkMsQSI3ACgHKHtH/plWouYDCv38nWMq
	aSd1gHTMaOTS1YAbAum/iMa13sB4aZ4sHUzLyYqjrBhR6ZfehxRkYSvN7z8bZNBgaBVkzhhgxSp
	gX8TLxyTErPG8OvDex0lVSTJ1ee0V0w1aCcPCcbS4=
X-Gm-Gg: ASbGncsUaOFGV1filNVQElXo94RpXwxlDF9VSK9M5FxDY887Yz34yB7goj7L4lI6gZC
	PB8FLURubC6kbd/zPeVXNVt7/VBCgDLM7
X-Received: by 2002:a05:600c:510c:b0:431:52c4:1069 with SMTP id 5b1f17b1804b1-433ce426fdamr119587865e9.8.1732559281609;
        Mon, 25 Nov 2024 10:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5+ABbS620Usyi2ILjmwPhsFJ2WPnI3EgTj21TlUO21X9DPFbmdcFyD5QE5U41Uuqd8FV8exmwk1BcA2R6zxc=
X-Received: by 2002:a05:600c:510c:b0:431:52c4:1069 with SMTP id
 5b1f17b1804b1-433ce426fdamr119587715e9.8.1732559281361; Mon, 25 Nov 2024
 10:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20241125162904.7326-1-bgurney@redhat.com> <7a220428-59fb-4b2a-8d67-ecbe40cba037@acm.org>
In-Reply-To: <7a220428-59fb-4b2a-8d67-ecbe40cba037@acm.org>
From: Bryan Gurney <bgurney@redhat.com>
Date: Mon, 25 Nov 2024 13:27:50 -0500
Message-ID: <CAHhmqcSwxbvySBdb_mWhOXZBfiXZOv-frD_5bkvhJhs8rnO=7g@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/039: check for sector size of test device
To: Bart Van Assche <bvanassche@acm.org>
Cc: shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org, 
	alan.adamson@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TKWHlL610alGPyXppEGZ6zbdK-QTEoooV3uCMR1kLmg_1732559281
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_102805_329427_EA12D1FD 
X-CRM114-Status: GOOD (  11.93  )
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

On Mon, Nov 25, 2024 at 11:59=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
>
> On 11/25/24 8:29 AM, Bryan Gurney wrote:
> > +     SECT_SZ=3D$(blockdev --getss "${TEST_DEV}")
>
> As far as I know the terminology "sector size" does not occur anywhere
> in the NVMe specification. How about changing the variable name SECT_SZ
> into something that is an abbreviation of "logical block size" since
> that is what blockdev --getss reports?
>
> Thanks,
>
> Bart.
>
>

Yes, I can do that.  Does "LB_SZ" work?


Thanks,

Bryan


