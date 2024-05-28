Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1EAC25B78
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 17:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+5yowHV1mdvwmRzS+Kf+Y7buibGoh2kMHijgBsMX9I=; b=HdSMQaRHkhZp0KIw5NGyP2zvhw
	gp4CkFm+UKJGuPGkWqvbjLMQsfCz6/thKGA9KdgVEiTqzJrn9OhFYh2zWpxfThuxL/ulAaZEgQvjU
	MKJstTtcGSrmtjFE8kCZMkeZbG2dXa4mP/DlnI3QFBngpNAa6ICY+A6+uEcYE5KrqUwcOnikhkXDa
	hB9FVas5mZ2UjdOw7QpjybpSpVd1VNzCHkjYewgTgyuZzfmVCyIZUIsIsP4EO6DtUxRaBm2Y2bVvq
	IzZJVKFKi4M9KCbfb/Pb4artky9HO9f0j2uPTaaJvIJkK6ybbrL/zmiERBod79Ht/FS8o4zS/HhTI
	xqUC+9bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC0hx-00000001YvB-3rIO;
	Tue, 28 May 2024 17:33:57 +0000
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC0hu-00000001Yuc-2oQs
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 17:33:56 +0000
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-62a08096fe3so569667b3.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 May 2024 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716917632; x=1717522432; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+5yowHV1mdvwmRzS+Kf+Y7buibGoh2kMHijgBsMX9I=;
        b=FROkgfej+AW7MTm4yf1nETXaykVtcFLTPNuOlWHJ+LEIKLdN0usd9a+2TcMgNTxZiN
         iA7JtytXSZdUk/4IbAAFBWM20SLYDNrwkg4ZjPDHanSEImeWu5gRNsT2QjNHkayNnAsE
         x9qUPJjwHGFmd4yFE+do81vaHTYYEApKrbItXwijrDaE6TMQeggJqTebFjjfuEltC1qI
         3zb7NE6IdIO+2l6BSofoshsHOeJ0wM+8WPkIibc908DAx87y7v5IpdnrdQW56VElZ7/1
         Jizau8vh3u46JuYhsPTz2SoR6VpG0bFQkX5bdNDHfajKnMgGor1DaejjyHWyHmGKTkSU
         VcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917632; x=1717522432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+5yowHV1mdvwmRzS+Kf+Y7buibGoh2kMHijgBsMX9I=;
        b=gkVm4H0vw0eRsU551qTv2jtp+HtwMfi+DoVjO3P6kQvqCmBSECcmRn5fU3tLWbuhso
         fDcRacPKPFq0ZgsgS+wPih1fEjZooWhph/7YJ0WS3XR/3/sXJkc9WfYS4u2O/oc/6Zfd
         yuZQrA4vlVLwwRpzu6sGtPN2cRIbbzT6b+UJPiLIUcTmmfhNcYc9RkekJwfVIzjhcoZc
         juorygNKQ5fd4rElhAQKQqNg5VA2nkukUakFjCkXCgRFaWMJQSP5wD/9+ujn8Yb8YKfa
         033jDJ483Cs58NZNfrxlXK1jDG+6YRsr7zGstPwX2F/RjETxMm0wBWPE8LRpXYJddSrW
         d79Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHK/yzKl+QKVCQvHGwZI14/D2kngmH5A3BLopbyZwOroZbKG0zw1BwJRma8T0Cn4cUBf1BLYibGUIt+/L04LvBFxLNjr3ikx8jJ6CXkaw=
X-Gm-Message-State: AOJu0YwGoS78GsTVgiFbiZ4Fcdyc69E7QJqaC//hZsFvo5mX4A3a/iZr
	hKc0yNa1RXCdcucjkvXa2simH585okHHaSJzKSYYcBf0RQ28Xr5bJD5AApui7zlU95/SNkEFfVO
	LdFiUtK2exrzqZmm9eU2KVvM9/VI=
X-Google-Smtp-Source: AGHT+IGzy8bDCETa41pmxN6XwpUVOwqSx63Dsdj8hT8gq3j8Fm5HQNO7cFk76uCArw/w3BVaRitcC60o5GjjViDJYpc=
X-Received: by 2002:a05:690c:d95:b0:627:8b31:e75 with SMTP id
 00721157ae682-62a08b1eecamr116676807b3.0.1716917631912; Tue, 28 May 2024
 10:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240527051525.762-1-dwagner@suse.de> <20240527051525.762-8-dwagner@suse.de>
In-Reply-To: <20240527051525.762-8-dwagner@suse.de>
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 28 May 2024 10:33:40 -0700
Message-ID: <CABPRKS_4-ehWawV8m-ANU3NBTykmjBCuHdGbFqa_+JT_34vtCg@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] lpfc_nvmet: implement 'host_traddr'
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_103354_815293_9A33E179 
X-CRM114-Status: UNSURE (   6.69  )
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

Hi Daniel,

Looks good, thank you.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

