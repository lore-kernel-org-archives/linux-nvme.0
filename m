Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C874EC52D6F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GO/eUTb5vTwjR2838bT2Id6rYlTncoGLJxIdwZ87IRM=; b=Otn3kBzTLCcACTv5XZtEmmE/rr
	5qEWNSrhVdfYCpxgOkte6yIVSQtYuEolQtqOkDS9EMvYHBZbFrCLsszHOCuCNTFTrgJ3m/lnLBkcc
	UvRjIw1JDXgtKVEwmkj3NMGrWMAkvf2K9IGxwV0MC2iUojRlSkR3I1l045dERf/QWlcRYI1bqK/bL
	3CG1rQMCHj/kA+TeTkWXdKI18pJCBcYCwUL75Lc4xNkdV5NLEZ9aDJQzEHUMesmwW9wKSPkFWFf7l
	rhfqCx20bw7Y6avxwagBE77fg/x3M3xh3aLLevqeX7KRz6qXaFcAw1doBOlm/kQWoJ3VsdQzZALrU
	9ySo1XrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgo7P-00000009jhQ-0Glv;
	Wed, 21 Aug 2024 16:23:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgo5G-00000009jA9-4774
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 16:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724257277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO/eUTb5vTwjR2838bT2Id6rYlTncoGLJxIdwZ87IRM=;
	b=dir+lK0FTnpD/WzJi+3PCFgvi9giWKisN+Ltf5FZPBCjOforQ4lPGSmQS2cRg8Hg67el90
	f7G28NmXdOjRLyAmOGrH4AZobjvwzN50dK/65t6LuulkBDT39W0kq8b9zMDVxnSOG2LWrd
	xX9xuGNEDEbIrql/JGj0pmtlIDgQDVI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-mIlBzmXzP2OEPU5EEsub6w-1; Wed, 21 Aug 2024 12:21:16 -0400
X-MC-Unique: mIlBzmXzP2OEPU5EEsub6w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6bf7c72871bso66993086d6.3
        for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 09:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257275; x=1724862075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO/eUTb5vTwjR2838bT2Id6rYlTncoGLJxIdwZ87IRM=;
        b=URCfF/XOq717klsDduNIjwIxrsFrAtIvi/pTIOQJivX9cGHa630fJoxxrWeEGo2dY3
         bdMLiJgzKvZanUWc2t83wfq7G67p9KI8B89uDciGvVdquMulhZr/FEOJn4eDjj5/j2zf
         GfKq9L3IPZh3XLjaIS+k/MiGwukl5BDVLxLqFJ68u2R8jYlmA6bn+aP42buyGb/JIxWJ
         6SbeyWOpCa5KwxbPCeVuuxOb2M4UTZTfkGJGtt8JGof4u8cXxYIAJfGyM73DqG50PQlQ
         PF6YvmvW+ufN5xuerg7PI53E4ABpK7TmXpIMkudfRrhVM+3t3H2CotdFb8dyz2uRQq6r
         OwLw==
X-Gm-Message-State: AOJu0Yy8+uKbA0DPlLPDTOhP8DcGeB9AczZah84rCH0xpTB3+HgkFvta
	Z5ZBcU/JnMFCEb6dUqH5Bf/Qtwdak9ZZBg4OxpAKWQsMyTdWZbd7XW59TJgA4Pq16E5c3oqd1P4
	4/ta27aNWOfk/PwA0EdnrZY7J+b1XOMLRx8wG6opkZlAQpVCENghqJqm/ZIoUDmLdZnIWYl2QHl
	ayATQOg298FuvseLDOR9mq39pYi5X7S55N4OsrxcMamjjkSCDExA==
X-Received: by 2002:a05:6214:3903:b0:6b5:e3ba:5251 with SMTP id 6a1803df08f44-6c1567b4dd6mr31418586d6.8.1724257275637;
        Wed, 21 Aug 2024 09:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhS0dU7VrQTFQFk/LMg4qtzo+tKGOiDLAa5ZPhMhpweiz1b+SluNsqaz2szJGCec+Xaq98w1+wJlGXKgb+4EM=
X-Received: by 2002:a05:6214:3903:b0:6b5:e3ba:5251 with SMTP id
 6a1803df08f44-6c1567b4dd6mr31418376d6.8.1724257275285; Wed, 21 Aug 2024
 09:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at> <CAFL455mQ=0VoTPsTN-YZzZ9bu7gy4y2eUnEv69wACjODSQChzw@mail.gmail.com>
 <CAFL455mhJKNZqxHvTBehLxBNn75gGj9ecd3FZWe4yncSz-OZxw@mail.gmail.com>
 <ec426603-0ba8-4370-8036-7fa90e334348@yawk.at> <CAFL455mk0aD2DNOp5PPDKM=OJEVd-Cxj4gbtpQeUJH9gpnSs3A@mail.gmail.com>
In-Reply-To: <CAFL455mk0aD2DNOp5PPDKM=OJEVd-Cxj4gbtpQeUJH9gpnSs3A@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 21 Aug 2024 18:21:04 +0200
Message-ID: <CAFL455kXKGwmketGSK_4R_5jM11LzA5JMpBV4sUeDq8L5meuAg@mail.gmail.com>
Subject: Re: Occasional kernel error with NVMe-oF TCP target
To: Jonas Konrad <me@yawk.at>
Cc: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_092119_112929_EE5A5340 
X-CRM114-Status: UNSURE (   7.65  )
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

st 21. 8. 2024 v 15:50 odes=C3=ADlatel Maurizio Lombardi
<mlombard@redhat.com> napsal:
>
> So I suspect your system is suffering from severe memory
> fragmentation, but I don't know
> the root cause nor the solution.
>

Just curious,

What's the value of compaction_proactiveness on your system?
sysctl vm.compaction_proactiveness

Maurizio


