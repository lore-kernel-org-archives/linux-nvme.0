Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7081C77B7A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 02:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GSQR8+9HIEXOWyficLj8pz3+poh4uIEz2Ugj93ojd6w=; b=bE3scwUfyC2bYwAYyunnbfJg/P
	wh0B6R/PJ/L5TEdPys566mqfQkOPM1z4YA3dAznvXzYykJLj1k/LJfE0XZwtiJt7Ahe6ZFUnBG7GP
	c+UXp65LrpltSH1vPAdqd8TexIDAOb8M8VmdThOUdnje5oykdpqOigJyeKUzyD3tnWFIyOKudK/wY
	WwVdsA8O5E62oOSfYCngWPZgrvtVLRQDhvGuixlQJ9eNjQUZzYGc7S6iRTgGmjXed+BbZ385eHAKs
	WY7CIScboCFR3DjKLIaNMusDMK7DSDlidPh597gu8ylzs2WFT/aoLQuhGA7kwB3uC9MM4SRZhAvrD
	/oxuLTGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Z6v-002sxY-1d;
	Sun, 21 May 2023 02:47:53 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Z6s-002svy-2u
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 02:47:52 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso1556929a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 20 May 2023 19:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684637268; x=1687229268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GSQR8+9HIEXOWyficLj8pz3+poh4uIEz2Ugj93ojd6w=;
        b=CjkVIKzFuXoI3eYQLFCfzyr1VJDbIhS8/eJb4LCCiuvYN/32ZrSGLprIBV18bOT4X9
         aKt7vIWgHC7k4DHm0tIf3BiQdqeaSWI8QOT2eEo0kMmGeawyrWr5TgGg9tDhhocz9lJc
         hW/IJXnB2mHoffGRP/4JkCvQVEHZ5aVHg89Vz03GBmZMw65SH6tppokyAjQLa8qHF90T
         5/S8jNQddCBkHsIKaDmaBqQBGbtaoIOrcOHFAGvYTtQDgj0wz4Vp8MCKXQmQMKKztyOg
         otwkXKIucsFewDx+66Vp3ZrPNyM1fb4vOhKRWszJI5ShWx+xWRPSFbSCMOsBwUa1EkBo
         P2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684637268; x=1687229268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSQR8+9HIEXOWyficLj8pz3+poh4uIEz2Ugj93ojd6w=;
        b=lmZViKP+ZOxS+LPKWFN9KWrbKpouTTFWrtNt679tPgkuYpWFcbrvYaA/1+SnzhtFjS
         spYTJncpy0rPscvWbi/TTd6TW/B+xOFpWL8rb4bxfS+Iqn4f2Pw1L3XBmrtoe36doh+K
         xcUrKvOuaYOcFcslTto0TXa4tLRM6XGixsiGwnWPtsqrAgHUK8Tq+N0JFSbtX7cejOx6
         837U4hTwjJtlmLbQxqwHM3aUMliqGtLgMEQ31TRgR4Uf6+3vmUprs52z0GmVlhxFn+hY
         THhgc9IogVN+yZRDEXIYA+Db0YZyW3QWPaLlNRU33R2EUIr+rNaisWEiXuXpN1iylbes
         E7bw==
X-Gm-Message-State: AC+VfDweSnz/04en2GmYyh4z6OvLJ7NrVv0EIbWGNe+bk/YK7TFkrKZu
	08vv8YV7TUrlWbbsWGupjcreTvCseAD3RxIsTjU=
X-Google-Smtp-Source: ACHHUZ5IxjTC+dcLIefIA5Fwj2cteACTrHUYwMiTRMQtvN5WLn6E2pcBj0OJgwIETQP/nGvaepIEeQ4iVSBgsH9v52I=
X-Received: by 2002:a17:902:e5ce:b0:1a2:a904:c42e with SMTP id
 u14-20020a170902e5ce00b001a2a904c42emr8343616plf.24.1684637268540; Sat, 20
 May 2023 19:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230521024618.103138-1-irvincoteg@gmail.com>
In-Reply-To: <20230521024618.103138-1-irvincoteg@gmail.com>
From: irvin cote <irvincoteg@gmail.com>
Date: Sat, 20 May 2023 23:47:37 -0300
Message-ID: <CALL+9ehvM3GxGS9Y-KVyyK+HyO14yRmGZFEPjD6pmEUMX3VNzw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and nvme_init_queue
To: hch@lst.de
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_194750_940859_CFA746C2 
X-CRM114-Status: GOOD (  14.55  )
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

I'm trying to resend the patch but somehow all the new attempts seem
to bind to this thread...

On Sat, 20 May 2023 at 23:46, Irvin Cote <irvincoteg@gmail.com> wrote:
>
> cq_head cq_phase and q_db are getting set in nvme_alloc_queue
> and in nvme_init_queue, make it so that they are only set once in
> nvme_init_queue.
>
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 32244582fdb0..49ae26980a0f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1533,9 +1533,6 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
>         nvmeq->dev = dev;
>         spin_lock_init(&nvmeq->sq_lock);
>         spin_lock_init(&nvmeq->cq_poll_lock);
> -       nvmeq->cq_head = 0;
> -       nvmeq->cq_phase = 1;
> -       nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
>         nvmeq->qid = qid;
>         dev->ctrl.queue_count++;
>
> --
> 2.39.2
>

