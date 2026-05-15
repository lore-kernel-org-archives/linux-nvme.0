Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD191CD4F25
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 00:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LNWlDU7ESfuQlYl2Docm5gltcb97ZnRvoZIhqz8ihro=; b=y35BmKqlyc1N/nlRKJpKit2yIR
	MyguwHHfI3j/IRCks9UiNTKQZKSsTO9jXyoUm2GtF662dl6UcsoxMfDc49Q71XIMXa8chyT2UzENJ
	8wWbbni7oIxWRBF+sPpcSjFBXweY228gTJ3jKoXBSvJskVmgzx4aqCRev6zMKWJol+w1V8AUi+k1k
	98NOWnHiifvPtIfNvBASsgkdrWqSk/m+YP5eukWGmdtcRzU/UxuV5NLf39sIatfeYdMHmlm8GFey9
	2g+uJCpQ16rih30xcHj03DFW5gw6+Iu7NcMGc7bXALl+9sB1Z78tZVrG3vPUzi4gPF/7/p0nOKbUB
	OYSM2FTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNglg-00000006xIY-07bN;
	Fri, 15 May 2026 00:51:08 +0000
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNglc-00000006xHy-47oQ
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 00:51:06 +0000
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-95f2b0bd920so295941241.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 17:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778806263; cv=none;
        d=google.com; s=arc-20240605;
        b=eQUssvD2RAirOBajCPILkRNF4XrvNwqlujzeWm562beIItYhW8wpTNdKFQTAf8P3lI
         ixHnnxLvNyTxs9HQEAPxV7OY1sEvELse1aX1ymcqGPyzro2v6CFlnYaIeq2j1Au+ByLF
         cUgxqKc979lEpBglDiaK9Fhn1qc7uCvIBQMvUeLp3xAc7bRqOq3xgj9OwlfEdoYw9OLG
         /OgGfW3rAmhi20sGEMqUGpy6XGzSB3tZ2Md2PFfgyCH0teHDOYMvoMa7ZILvxNliJsIf
         FkIypOLUA7YI1NZvTeNwGTAqHWCJQQdXc1ZHIQCssnhe1kZggsL/SWUimZBdHyqmi6wJ
         4ERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNWlDU7ESfuQlYl2Docm5gltcb97ZnRvoZIhqz8ihro=;
        fh=8Xop93kS9SlPlQAie2n8wop2fRfpyMZrCG+19Vf8MVs=;
        b=fisjb4zg2GJ02D1WXzU/N4hw4hS8Tq4qhOh7kNU+d+eCrAeTHcJdFESxFCsg2KXaZv
         OX4j/cyFO92kzd3GzR85yP7nZ1rrp9d/cv0WHhYQBFSt3RZkp7qtMgNS3HUg6pcNm7SK
         2ncwj9kUxM6VVlSbgoQZ7H7OtXeHjTguOBPbKz8ni2qgYXWHjnf3C8P6zr+Ao8N+dlke
         RRvCHyoRCnsLRIMMRYEqesZt8gMjTC8ZA24Mf8l3ih5Hsksf6scRffZpsAIZYMoEcf1u
         CzoLp9xcfwTzFuqwFnJjPrSuARnwDxonRpzlNSJhjHJFLWwi9Kxd57pyj17Qrp3Kuwrw
         Kowg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778806263; x=1779411063; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNWlDU7ESfuQlYl2Docm5gltcb97ZnRvoZIhqz8ihro=;
        b=b+POMZ4kMHvEfZn3oxfBIsvu7s5ZxFEimr+wlnFGq2OBOAkWrem6HOecbeoeybqlRs
         9GkDY596C99om3X3u4rPdSN/JZnyPoBiPDFi8l2roepLPNXqOR1z4Wjk9V32ZJA4a96j
         aQP1Kf0udlZFWjX9WVGY7fDO0fJ64VMHzFTAwJI+mkqXKb64VuuWNUVIIWcmE8mHZivp
         qtY/fkvxx/aHZYVYt+RQ11ofboF75fFAS4Rd25qJPSR2R9bxgIj36fN+Vw9m6uOr8WNQ
         1u6wvYcpElA3iIdXy8hAJyvgnGQZ65+VaCGeLSb+n0VWLQkmOdsBk387lEIJjkIuZrtg
         A/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778806263; x=1779411063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNWlDU7ESfuQlYl2Docm5gltcb97ZnRvoZIhqz8ihro=;
        b=rd4WuxlCJWeQ68ilv6dkK/8XjqwBHocBxMMH40dE4XOJ8aide78FteaLsCVGiMxU/k
         jyNcS+LoK+Q8oSAeMVmMjneklj37of/9UQghL+OTP8rSLbBnuv+SMRl6XKSrU1v5863S
         Uvp9SPC3w4jaeJ3QrEPmOPyjj5jY9Q6UzX5+Gjb4dQGb+FJ8QuQcshwjo6cbtNnDLrji
         YqnI1xYgCKUXGtYqtyi/8QPLRNrLABZiZbEu1y3jNWBM3rMVwnTvAOUQ3j99qLkBe8LT
         TkGph9IEOCcaZxVat5UXWKg4dcg1PbcZQC2vtCHt8X76uJNcrZS53gL4df5GtV/EvRHO
         7jlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bKXL9sxcUobiTP13pcOxqFgJHQ4nGvjyESJ9SOayXVNJbud8+f6ecoksNCt5CazMXC28r3cqKbndI@lists.infradead.org
X-Gm-Message-State: AOJu0Yy23pUGZiV6LnT0AQ1EizqaXJEGPTn5RDZQsqFJEgVVQ6C1FtG9
	dm+l7fdXRbxxDtyP/q5wBjCD9doelNrvp3qm0+Brb24gcf6nvVinjbe+u9Yd1xeBN+zdO2eL34b
	paceeSM5VniXZt6fpSn6kagEy3FTmmgdshE/1AmtJIw==
X-Gm-Gg: Acq92OGYoFGXJIMrg4QWwcWtbQRyXqNM+geRsslDpXOzn2ZKPL0SD8MHCAPxrzn2FNt
	wuw9ZNwMm11XxDVwVs+0GIu82zsGIdj3UzQOiTZvuray1y2/LFLJRyVi10y19oCa/nqr+HE/50p
	dX+rTXUyHqma7cppo8nNXz60k9vyPsXRvIo//YIb1+SbVVntQ6SKTNBRI8Ajn5Uxdya9Cs1kGBV
	uPUnLomGungFRfu+ETtPOLOpAlqDMDUth8dONbjO3nByPPBRN5sO0OPEkKZCG2iJudRI+CV2q9K
	/HR3iXDvcSBMuzGTYErJJP0EVf9wSWiINp1q6gus+AmUVMqNPcIuNXsyLJC+/LIaBU9/cE9A4EQ
	WBPYa
X-Received: by 2002:a05:6102:688a:b0:634:92c:bdca with SMTP id
 ada2fe7eead31-63a21baeb44mr944817137.3.1778806262674; Thu, 14 May 2026
 17:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-6-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-6-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 17:50:48 -0700
X-Gm-Features: AVHnY4LIlgfFMte9S7UDt9qC2I3jyfNfN4J5JogK7aN72KSugpZ_8QDD18ZvChA
Message-ID: <CAPpK+O3Cw4etWbpkb5e5bBtQWjUxw5VuERg-W5SEjDCagQF2_A@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_175105_067190_B2B9A9C6 
X-CRM114-Status: GOOD (  11.28  )
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

On Fri, Mar 27, 2026 at 5:45=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Send an AEN to initiator when impacted controller exists. The
> notification points to CCR log page that initiator can read to check
> which CCR operation completed.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 eve=
nt_type,
>                 u8 event_info, u8 log_page)
>  {
>         struct nvmet_async_event *aen;
> @@ -218,13 +218,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl,=
 u8 event_type,
>         aen->event_info =3D event_info;
>         aen->log_page =3D log_page;
Please add
lockdep_assert_held(&ctrl->lock);
Looking at the rest of the code, this should go directly under the
local variable definitions.
>
> -       mutex_lock(&ctrl->lock);
>         list_add_tail(&aen->entry, &ctrl->async_events);
> -       mutex_unlock(&ctrl->lock);

Sincerely,
Randy Jennings

