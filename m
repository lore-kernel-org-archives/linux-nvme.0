Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD33DE668AA
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 01:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7PrJnszBLojqKrV78aw+xEkBElYTLkB4kwu8K7rO+Uo=; b=qXuCAZSzcME0a1HWOp3QOfh3Qw
	ssd3izC+vqppRxU4o8Dn4My3yqhbdrnDEXErLC3wt7dEYlvxIB+UnHhG7oaQPnpM+woou3szKvDeF
	/IeGKkRAiBX7n23/Dle2ItysRd39rpm+b1X2vwqwGB8FQW+Zca/VAE7YxAMdmfG/pecu/vE2OCF2+
	xHRVN5Cm7D/XnBh8wRGKkCXLBtl4jrcSR1Jd+oTshP0GBi97lVxQWfFl4rMJZTx2XSye4FSS+Od1r
	NbD+FXhmUrLX+ZGF26MEu7j37nHExxiFL4z1alnkJVHWSpNsWOLBI34DsF+5hbAlLk4Ceo8Exb9tF
	T6xgWQPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWlf4-0000000BAKg-1ioK;
	Sat, 20 Dec 2025 01:21:34 +0000
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWlf2-0000000BAKG-1sbM
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 01:21:33 +0000
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-56021b53e9eso796320e0c.2
        for <linux-nvme@lists.infradead.org>; Fri, 19 Dec 2025 17:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766193690; x=1766798490; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PrJnszBLojqKrV78aw+xEkBElYTLkB4kwu8K7rO+Uo=;
        b=ajF29NTN1iQjbzOoW6VGsFm2tpwO8PCMK7DDSmAOqF/hDutAV2khI8T5GnF088orVN
         /7ykadkTbcYMPUJVKHd589OAH9LWk3r5CzG04nSAcYFHw962P+pYdxbW+qSYytnnCXCh
         W0+BTn5nU3SZFkoNve9ZlRihKEPQZs5531vWPHKzCLA/d9QZqZ5hnUYpsGvsfopt4PBi
         Z4+GCFpif+hsTpz4vot/axJJ00IMsgYdP83pVpO6vCD2w6zSIxWr+PbVNBb9iRLnIZBq
         lTOLhldpP9MH2nFlLdjpMiDscK95XBOwAawSmLWkxo/GjDEz3xN6VnTk5dU1U8p1StJ8
         2q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766193690; x=1766798490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7PrJnszBLojqKrV78aw+xEkBElYTLkB4kwu8K7rO+Uo=;
        b=X/vNyWQdGTGNJS7hZLh+Favj3L5qw+sBrFmJnq5GHf63eU/JyMPvgoM1efamoVE/RX
         WwmXY/RmbNnvz2Z+hYnU9VYK8NK0yWJ5yBxiXI/VbYAr0GLNl6Bw0CVvnMuysYZzlDK0
         +FRYJqE9k7gp83lgCGkU7NVgblbxzNVlfsbJk5kGA1fAaghti9z48BhhhK487crTDoXl
         xLa73H/uzBIAYwKnTWJZ1auo937WdP9ncn/tgACnzb1bZsyQLX/317lgy0J56oehvQnY
         XierNuVFoK7u7j/Bh3mQd8u5KZWKSrl8o6mJZIQmvJsfdYwkCi2y+cjza7ixJ8E0rcVB
         1Snw==
X-Forwarded-Encrypted: i=1; AJvYcCVLTuhql8qpZxTHqc7U3oeAdpyYoQiiq1w52AdWpkJtgi00O7y29d393XvUnBu5nEoEoomTCeb75sHF@lists.infradead.org
X-Gm-Message-State: AOJu0YyEBcPThX9gRrjTKGHXGpGvWGnVPzrMzAKEkNv4M197reNdoyBM
	ASguTemxL3woTIPjNtSgO23HmvpcGvOp23BRd4RIivQY8/hvsGPZm65/jtyEq1WsJkhkU5TD7ww
	neNvaHYPZTokHK4d44tH3V7jlhWjI1XkOdbPQOOTDr7bzd66IAW0C53iwxQ==
X-Gm-Gg: AY/fxX56rsmP5Y1aY2gnVtlm9CXV9SjdTLBZfkGRxRRbgDR/9NGABMORd8cNDm/eZaK
	CP1ac+TUjjm0ySSB8sJam61k0ckEVhh6S25soOqSabzjfqAsdg6oihW5MjaxXBgyf9bWKnJkyCK
	QdRvhcZ9HGkB6Hb21G6UNw0sPPlpbKuqjA68lGOhX8ZvUgIHELn17zVYgN5n9Bsm3i5ljshdBby
	tUXoig49tRp38+VmOMlMYYZBh91xhGNhZuwiNcshj6ceZ3kPmF3A0rbX/WM/qwCZgo02y8=
X-Google-Smtp-Source: AGHT+IEAohaMZzHDChaXAY4ZHYfg8fxcwnJwg/jG5OT7jaSYaIiqW15GXMiM17UYvMKtATUc7d/jsfdr7g5EDnq+h3g=
X-Received: by 2002:a05:6102:3347:b0:5de:62f:65b3 with SMTP id
 ada2fe7eead31-5eb1a8530damr1291543137.39.1766193690469; Fri, 19 Dec 2025
 17:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-14-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-14-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 19 Dec 2025 17:21:19 -0800
X-Gm-Features: AQt7F2oC8n1NhHo2f5aP9w7GI-EduP30-XHKUTZn6_ij-sxT15j46oBH4EqgRs0
Message-ID: <CAPpK+O3n2o7bJWorPZgO2eJFqn3+K0ZRwZwaumjC9WnrrPyCSw@mail.gmail.com>
Subject: Re: [RFC PATCH 13/14] nvme-fc: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_172132_533975_5FC9649F 
X-CRM114-Status: GOOD (  16.47  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> An alive nvme controller that hits an error will now move to RECOVERING
> state instead of RESETTING state. In RECOVERING state, ctrl->err_work
> will attempt to use cross-controller recovery to terminate inflight IOs
> on the controller. If CCR succeeds, then switch to RESETTING state and
> continue error recovery as usuall by tearing down the controller, and
> attempting reconnect to target. If CCR fails, the behavior of recovery
"usuall" -> "usual"
"attempt reconnecting" -> "attempting to reconnect"

it would read better with "the" added:
"reconnect to the target"

> depends on whether CQT is supported or not. If CQT is supported, switch
> to time-based recovery by holding inflight IOs until it is safe for them
> to be retried. If CQT is not supported proceed to retry requests
> immediately, as the code currently does.

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c

> @@ -1862,11 +1862,48 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl=
 *ctrl,

> +static int nvme_fc_recover_ctrl(struct nvme_ctrl *ctrl)

> +       queue_delayed_work(nvme_reset_wq, &to_fc_ctrl(ctrl)->ioerr_work, =
rem);
Just like nvme_rdma_recover_ctrl,
nvme_fc_recover_ctrl is exactly the same as
nvme_tcp_recover_ctrl. Seems like a core.c function
nvme_recover_ctrl could take a delayed work queue,
unifying the code.

>  nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>  {

> +       if (nvme_ctrl_state(&ctrl->ctrl) =3D=3D NVME_CTRL_RECOVERING) {
> +               if (nvme_fc_recover_ctrl(&ctrl->ctrl))
> +                       return;
> +       }
>
>         nvme_fc_error_recovery(ctrl);
Inside of nvme_fc_error_recovery(), we call nvme_stop_keep_alive().
The state of the controller should not be LIVE while waiting for
recovery, so I do not think we will succeed in sending keep alives,
but I think this should move to before (or inside of)
nvme_fc_recover_ctrl().  You have replaced all the calls to
nvme_fc_error_recovery() with nvme_fc_start_ioerr_recovery(),
so that might be okay.

Sincerely,
Randy Jennings

