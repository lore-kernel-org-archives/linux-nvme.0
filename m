Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A15FD9E2D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 02:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n99Qd9xBIMHYTuYrP33j0w8fVVsqXmoFbGdss8LF6Ro=; b=YqV6UAF4s9vX8a6XO3AmbfZPAh
	Rxe4SEgCVQl44k5BdMPNhHX1+W5O54MRr/NljCrSGMYhfjOin90VbVo//Mnf1Gbnvh81+mdSoa7VF
	IPGgo/1cOyLfUXon6ce+4cQg0xNpDrx/Pc/np+fndqVnSS8RUA1OH+DG8LZenYlgiqiEDOlx1Oh6y
	thIgkNEoVFh9tDmeMEwrlmD2aymSp27S3EXENPg5EC6WesjeWibRdjvRVH80L1TAQ1+Z7AIcZJuWW
	6G8RXqh5aH0AY9KN1Kjh1azuW89WA9jYWPB4GqZIfpSf+uTeCbrE5QloH5N79H0t7pl6cgGIyTaI3
	JeShiCug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvnvC-00000007YVH-03Hn;
	Fri, 27 Feb 2026 02:49:42 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvnv9-00000007YUw-0KfB
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 02:49:40 +0000
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-5ff0f61abfcso443146137.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 18:49:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772160577; cv=none;
        d=google.com; s=arc-20240605;
        b=SBfhpcHXQdaARASz7AFsCUmuVit/qezxFwjgaTbb1accKaf47SX1FBEIY+QIEt0LXz
         EttGpXFEaDw0GjacqTaI8QAX2GNopc7xxyFVMHU9nNqgGmYLm8VjxLtQc0V9FLKyrVnz
         Px4MUftCm1TLDD++WEyTK/C7nmsnmTdoDWx1/C24a7SaYBI6ZGFq1FM2bcz6nODb/lLK
         9ycfJFoYunWaWC+XIjCjrqMshzTE0RulngMxA5/U5xPNzReC9t/lyuAugd312mCQma1q
         ZcF3zFb5RxrhY4zlCJgUk+WcciTwwfKHnwtmSyCQBm11oQoOXmGPJKPngerKGrOwawQE
         PJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n99Qd9xBIMHYTuYrP33j0w8fVVsqXmoFbGdss8LF6Ro=;
        fh=TJQdHD/TIagmkpt8gS/0Qao1QzjVUIOegY5Aje9NsQg=;
        b=B4PEaDGWnqHtLLwRB7PktUC54DNgOHrYeXvAO6DLF7fMMdqPuelXp60pdYWId4AAqv
         taaI6i1an2o34FFNXLqzH6uO2iebf6t8eakdEIYFkeF4jFIieT2eI1wqU5S7DjRpmSHj
         1qTG82PHYcGcqgW/WmIl0KOe4zf/y8b5G0QS1XlJYfBXuowDlbkdFN+RbYXjEe1vN37M
         KR3lj3IRROyCvaAK3CBYME+cDj/0bOcnCn3eCKPhXcpXl9jHc1LKxSnYBKuuWxGAROfR
         JlcZxyRnhYtWQT6Pxdy9ego93AUIOzym6Q9HEi5Mq+y//57oHU8KlTQqJ2CGgQzZ3Jdp
         M0Mg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772160577; x=1772765377; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n99Qd9xBIMHYTuYrP33j0w8fVVsqXmoFbGdss8LF6Ro=;
        b=FLQnR9ln1jIzhxsT9A9FXKDQn2WXyFXFZJKNV2ufD/JfMEFqc2Ty+ZKQ9WfjCtjjS4
         B2IGySjqXQutS1O2gASNzzir4GOtEvd5PGe3PSB9W8YTaZYZ8Q4WJZ6l4kkm5li42SoN
         lO8dRTFQfTDo8cjKwopGV765U7TcRtZpqJir/QedTVo3LJV94ueG9Jbn5cL1pGw74jUW
         /W86T7KiCGm2hyUYQRQTwG/gMpwQKtVugBNlLt8xlyKMMaLjVlhEg23czODd/Kg2wHKi
         84bdwNJnrcrB8WR14Ubnlac5clo8S2Wo4Z7BUBRLLkw7Wvbb4Rh7qcC0B4lVBgMSvJGG
         w1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772160577; x=1772765377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n99Qd9xBIMHYTuYrP33j0w8fVVsqXmoFbGdss8LF6Ro=;
        b=PK7r4eLPW10ULM9VEk5VvkikFdJx99gI5Ogvg/72/SGDIGYZliFe5scqDHQFS1svDJ
         syTU7u+ebFss3L+PPzbt5vIZLg2AQ7tw+re1h1MRnID9STY0N1zn4zuocj4CD11K9Z9W
         dap+gHiC7dsa8cq0sVgXAj4cA0Z3P3aIX/rfzhwjxnSI9iuQbtq2C48hbJ4+oSac2h/C
         Y9lVlwTcRt0gb6pJE2jkd6yPOgtwIj0bfmVaCvF4g13EEeOU2I28YujXY1TtfSDlsUky
         VrrQxWs4LPG6f5PY9kvtt9rWlAoFVUcrgbeakAEzbb33xTzPBxJPOv0B5/4cgNnDsBoI
         7fSA==
X-Forwarded-Encrypted: i=1; AJvYcCWXDYIJlfHgIrrwk22dfmoDqho/SC3P7HmbA1tPrUFWiHtfXRowZehA1xLW7eqqfpjWDDzMtVJtI9Rc@lists.infradead.org
X-Gm-Message-State: AOJu0YwWTeCi1UZ5WJP0kpbZnXF5MBkdswOPf691jE2K6yqqMal5rTpu
	PzzGbIEWogfGXx6HswbRK7fSSIAM27cITIyhCvGezvXJ7SgzhiTUevA5Ciw++rC3/hfU87heXi/
	nMCjBCZJIBTekzY/e3oj06/NPpYaOnq09sNM9rr1f+Q==
X-Gm-Gg: ATEYQzw02m+kFbJNjswivABv4Lbv0r6i4CEM+p/Bbe9O5r/9u5Dd+fVCS3EuZNNECH8
	6Te55SvrGiaoxTOUiyJ7oCxufi5+brcJfzEdhYuXSyslD4Mr72/4vgBjkAWbIIWjgrnF/lJ72JY
	AN9GqanBSN1MEeKUEl4BKS3Bdhs6qUuZJOWSDbi5l4ZmE+nLMy99zgWVPUtNugMfSllZWuzxZWX
	lm3kp3kfmgWNOzBJ+SI55Aa8atMiwJqbn7G0ckwNGIy9jiVyVfeICcwTeT5XD6McrrdhPpGJtSP
	HGA0ICyZDSpBMyzJBhA57Ggwxd3PBZwCyESdy1EyaM7bIZImV4wB+UofT58hc9OJBnrFmw==
X-Received: by 2002:a05:6102:94e:b0:5f8:e4f3:3e25 with SMTP id
 ada2fe7eead31-5ff32355ef5mr690422137.15.1772160576770; Thu, 26 Feb 2026
 18:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20260214042753.4073668-1-mkhalfella@purestorage.com> <20260214042753.4073668-15-mkhalfella@purestorage.com>
In-Reply-To: <20260214042753.4073668-15-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 26 Feb 2026 18:49:25 -0800
X-Gm-Features: AaiRm52HlDydyyxf9niAiJvAvrnxJkGt5_401PQ2ns1M6qSw1hR-bwdBEl59ItI
Message-ID: <CAPpK+O0Y7eX1sQnzX17f=DZZCMMYpiQOo6c2GdxiaqQ=DEO60w@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] nvme-fc: Hold inflight requests while in FENCING state
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart833426@gmail.com>, Hannes Reinecke <hare@suse.de>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_184939_164488_352D130F 
X-CRM114-Status: GOOD (  21.22  )
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

On Fri, Feb 13, 2026 at 8:28=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> While in FENCING state, aborted inflight IOs should be held until fencing
> is done. Update nvme_fc_fcpio_done() to not complete aborted requests or
> requests with transport errors. These held requests will be canceled in
> nvme_fc_delete_association() after fencing is done. nvme_fc_fcpio_done()
> avoids racing with canceling aborted requests by making sure we complete
> successful requests before waking up the waiting thread.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>  static void nvme_fc_fencing_work(struct work_struct *work)
> @@ -1969,7 +1978,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>         struct nvme_command *sqe =3D &op->cmd_iu.sqe;
>         __le16 status =3D cpu_to_le16(NVME_SC_SUCCESS << 1);
>         union nvme_result result;
> -       bool terminate_assoc =3D true;
> +       bool op_term, terminate_assoc =3D true;
> +       enum nvme_ctrl_state state;
>         int opstate;
>
>         /*
> @@ -2102,16 +2112,38 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  done:
>         if (op->flags & FCOP_FLAGS_AEN) {
>                 nvme_complete_async_event(&queue->ctrl->ctrl, status, &re=
sult);
> -               __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +               if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
> +                       __nvme_fc_fcpop_count_one_down(ctrl);
>                 atomic_set(&op->state, FCPOP_STATE_IDLE);
>                 op->flags =3D FCOP_FLAGS_AEN;     /* clear other flags */
>                 nvme_fc_ctrl_put(ctrl);
>                 goto check_error;
>         }
>
> -       __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +       /*
> +        * We can not access op after the request is completed because it=
 can
> +        * be reused immediately. At the same time we want to wakeup the =
thread
> +        * waiting for ongoing IOs _after_ requests are completed. This i=
s
> +        * necessary because that thread will start canceling inflight IO=
s
> +        * and we want to avoid request completion racing with cancellati=
on.
> +        */
> +       op_term =3D __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +
> +       /*
> +        * If we are going to terminate associations and the controller i=
s
> +        * LIVE or FENCING, then do not complete this request now. Let er=
ror
> +        * recovery cancel this request when it is safe to do so.
> +        */
> +       state =3D nvme_ctrl_state(&ctrl->ctrl);
> +       if (terminate_assoc &&
> +           (state =3D=3D NVME_CTRL_LIVE || state =3D=3D NVME_CTRL_FENCIN=
G))
> +               goto check_op_term;
> +
>         if (!nvme_try_complete_req(rq, status, result))
>                 nvme_fc_complete_rq(rq);
> +check_op_term:
> +       if (op_term)
> +               __nvme_fc_fcpop_count_one_down(ctrl);

Although it is a more complicated boolean expression, I think it is
easier to grok:
> +       if (!(terminate_assoc &&
> +             (state =3D=3D NVME_CTRL_LIVE || state =3D=3D NVME_CTRL_FENC=
ING)) &&
> +           !nvme_try_complete_req(rq, status, result))
>                 nvme_fc_complete_rq(rq);
resulting in one less goto.

Sincerely,
Randy Jennings

