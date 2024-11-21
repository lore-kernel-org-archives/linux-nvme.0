Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E90D75BD9
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrHKfnvNAIlRkGRmgg4E6l8QK9ehO1whB8g67qiPv2k=; b=Bv4SaVKYO+nnM5yj49mDOl/KqG
	o3t1TJZuQlyqdbLXH/VAAJEt5+98VzKnB3azNewv6ZNRypXGeO9WjUwuFllmpe2HmYKOz/LXyWB+N
	8qvnJo8wS43fuBwnyjMf/BWA84G6kcgpegh5k0tRN9lo9jcApdvkgogmp1g/soPHq56mqbG8YbwvH
	jQgjsIaVl8IvkMP9RWHrPIQiLjOWMxiG3pnkGMUk88LXG17gwEUuSjpCuW22Ur/EXXpTcGoiWA/Y1
	W+pNcR7kkTZTGSje2wGhSiqIBuPn7oKdg0V2tRPVXdhWjCWE/zJPn0PmERoyvDgCdzXkMIsCj/JH6
	x4qrcNrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE37a-0000000HBTz-1eWf;
	Thu, 21 Nov 2024 09:05:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE37X-0000000HBTM-1xU4
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 09:05:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xrHKfnvNAIlRkGRmgg4E6l8QK9ehO1whB8g67qiPv2k=;
	b=b24Dgx4WJ3xAKop/lJfRS1qkSpLUxebczPR6TjTMuXuQrsgTleQ19/ESFGUQysPjgOfUYb
	D3e3h2rzZ1ziRn82bcPZPbLvTpiPv7T21u0wdNTZe5R9MY3QIZLk/EFu2zDpc+XYpFbvyI
	JJ1u8TTpJiMGdMfmu+TVOIC7GbsCV38=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-hKDwOzHRNpSDku2UYvK7sw-1; Thu, 21 Nov 2024 04:02:49 -0500
X-MC-Unique: hKDwOzHRNpSDku2UYvK7sw-1
X-Mimecast-MFC-AGG-ID: hKDwOzHRNpSDku2UYvK7sw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d4189482d8so10125916d6.1
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 01:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179768; x=1732784568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrHKfnvNAIlRkGRmgg4E6l8QK9ehO1whB8g67qiPv2k=;
        b=lil5CSg4B2pturIHh2fexC4pVALb6Q6iJ0abAQgOJCHn8RzOw+WyTnAfXmhqPAFbav
         91tp4qCeqrYjsdPWr6tXacB6A/rc/idguVk7bncZC299qTQavOfbYZW/5FcR6fo54Icz
         yj5YvxvJMBZluzTwDhgiUf2aqHLP673t5qvQixhGEJ7fRnNajhz3AVQRAFpz+JBqNDic
         iv5NG33K55GPbdkGqZcKKvJHNwMAMj1fyxapQpcwlEncw1tuK+O6mYP5lGHFIAou64ye
         0W+luSNxLMOEKu0WbmAz8ndDWjFafCoIs76YZ2dgOmiaEJczM7Bygg8Xs+BYjjridcZO
         fI5g==
X-Forwarded-Encrypted: i=1; AJvYcCU5WBxQ+INRAwOeZRzrNUeiegY7b/BywrH0mskrpAXdxDiAyItGok+izg8BGRAS8uwEGqq+zz91RckP@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7O6JGJbB23OAwPHPzh8EjxaCYK7n3ZC8BCM+dSWBuQb/ib1av
	U6ouY2wE4MhdAqNM15a8OPtOfiwR1P8XWJ3QyvlQBCOYyTlV6WLjeUdj2EIfL7eGVIImrCZdCRa
	e1lmZSYWlf1E41nSBAm6R6dKH8fTH92NRHLu/+qOWADlnuQyGh2JgpxS68pzSYXFkF5vkA5cbw8
	LriH1aPKTIYlN9H6OaF/tMV2TFUgOb7QHa5yr0tkM=
X-Gm-Gg: ASbGncveEnfjo7CI9znORbtboLgxFToKJ75UHbQmgymteGhlWw9gMRPJXxWXRBMGN4a
	/lE5iX/DpGaSHap9nrphflY4nrDdBTts=
X-Received: by 2002:a05:6214:27c2:b0:6d4:2044:e942 with SMTP id 6a1803df08f44-6d4377af7c8mr64395626d6.6.1732179768613;
        Thu, 21 Nov 2024 01:02:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs2HNG/V8SZ4UPKFfKNBtcIQX4/fQyO1j3EPx1QS4aK6692fKdWwIFKdKM8bhfXHy95j8kpbH7kTEw9q1CZr8=
X-Received: by 2002:a05:6214:27c2:b0:6d4:2044:e942 with SMTP id
 6a1803df08f44-6d4377af7c8mr64395416d6.6.1732179768350; Thu, 21 Nov 2024
 01:02:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com> <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
In-Reply-To: <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 21 Nov 2024 10:02:36 +0100
Message-ID: <CAFL455=-5a34TYdwva912prQd93p84Lq1YSebTCUUsuLjZ5pag@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wQ5KrzlKVBcm8uZBFjBgVR5_gEcS2O9-DSX1CH72_Lw_1732179768
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_010503_575022_45E78F6C 
X-CRM114-Status: UNSURE (   8.11  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set

I am not 100% sure this implementation follows the NVMe Base
specification correctly.

The specification says:
----
5.17.2.5 I/O Command Set specific Identify Namespace data structure (CNS 05h)
An I/O Command Set specific Identify Namespace data structure (refer
to the applicable I/O Command Set
specification) is returned to the host for the specified namespace if
the value in the Namespace Identifier
(NSID) field is an active NSID. If the value in the NSID field
specifies an inactive NSID, then the controller
returns a zero filled data structure.
---

Now look at the nvme_execute_identify_ns_nvm() implementation:

static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
{
        u16 status;

        status = nvmet_req_find_ns(req);
        if (status)
                goto out;

        status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
                                   NVME_IDENTIFY_DATA_SIZE);
out:
        nvmet_req_complete(req, status);
}

Shouldn't it perform nvmet_copy_to_sgl() in every case, ignoring what
nvmet_req_find_ns() returns?
Compare it to what nvmet_execute_identify_ns_zns() does.

Maurizio


