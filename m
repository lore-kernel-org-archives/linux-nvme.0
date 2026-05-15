Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4507BCD4851
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 22:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dGhjWM9hEVF6dEbdTrkTawl38zZXk8O+DH4Yxf5EtyI=; b=UWp9qjEmMK9cUmtY86bXe1G4jz
	dQYi6/f+zjisUGkg30m2VnIBMnj/2YS6bjO4bNJD0CrezExHUbg0/igTl/IpkLvZFHdWNz5rz/fJB
	LfYvnTXG3dGsjKRCvD37VfHgUmeQELMXoUZYAIHIWVZrMVIE59aC3ETa5Wqh5IzArBcO/7YKILstI
	daueJ8imyPkDwmdKkTQF1PSi9QbpQT64a7aJPogAGcefTh8QXP3rw+lpsLKh4h3UZs4inEvs6ywiy
	VG/6r9avZNbJo9Boxf/JM69e6dzutUi7YDyB6aGU3IYx0raN1jc5zjyrpS8jetvitpJclBDVpx3n+
	AVI9Ewqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1NX-00000009fUZ-4A8S;
	Fri, 15 May 2026 22:51:36 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1NU-00000009fTn-2ewG
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 22:51:34 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-5637886c92aso148155e0c.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 15:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778885491; cv=none;
        d=google.com; s=arc-20240605;
        b=ZvivCOHH2P7+BaDC3xDMzyKuJeGnXRbRoqWIkIxmnBceiDltoWU2Ugw8sTsae5Xv5j
         c07mMuK1KV9fr+1Yu6jLVhsGPsaE+ukYWXU7+QOFZqMVWLFzhnhfr9lWpstDnJmyomn/
         vMyhuL48lRMcAzogLwR04LhA22ahNz1DPTuvarnue7g3ceTOWHRIvH0BBlllp0GF5tlu
         0h/FdMENEyyVNZDJpSA7IXK/38W0Mfq49EBBXbu97gGSCQEVAMbo57weZfrucrD1YEmg
         OcTlLMzHJNcz47Xhuxg5KwF8swYBHJDEsJ2FOn9EFg/q1Ut1BKSenK66HDsnahv20GiX
         pMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dGhjWM9hEVF6dEbdTrkTawl38zZXk8O+DH4Yxf5EtyI=;
        fh=8HnbQ+iZqW1smZfRi+7gzo17NouZ3jjy7IDCqxZ4rvU=;
        b=f0nUEhcb46eoEDAGrlhohsaeIYk/WNDhg9ZiluBH7cD1VBGkMkfBc0+/dBRdNMbSwz
         2P+lRqVPuPKQQCUPOi+/SVzbFNjfNaSIMOpIIozcivlzYXh0Kbld/eHkGuWbA4+C5AC9
         QP5l5Tn9CsUs1wjjNf3E+bJqDhm+dzQnw/mcpn72k+fxT3xA6crpqGPmAce828ggjbkl
         JhYyV6RY7c9NiObBerEZH9jzCETid41xEMvDkt/iqj5GftWVrsuQqgjGTVAPAq70LEsP
         bdIvmkFo5HFE7BPQO8qFJMwrykRh4f1Xf6MD8HZqhZ5kyiiz9WvgB+JTc6iQNeNYhoha
         afVA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778885491; x=1779490291; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGhjWM9hEVF6dEbdTrkTawl38zZXk8O+DH4Yxf5EtyI=;
        b=TEXN47tnnwbqEyCfgnrXUdZq9Ew4vLOKh1sCiRCqNsdDP0p9UrkSc/xNbclTAu+p5C
         c+P2EFKFTUVVkPN/FOsq/tqZTljuN1aQWuFM1OddlWg74vd4x748KKFlkq4QLnWLXqTu
         rkSSLPzWVFTnopvhzKFLL9HfLRsosuOM9PUlkKkVDJd2Z4G6Ttw1PuFeMy9Mqe+t5jni
         aIeGjgAwYCKP6Qtan14srN6zVBAVPLEH+7etveE7iJho5frhMDLF1RfnWdnVsW5+jni6
         dwm1dz6KDhHYWZWkG2kAXTMAlJtS6tEvoZkRmsKQNePkCwmqz+Amo53N2TL6DVVMJBqc
         HgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885491; x=1779490291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGhjWM9hEVF6dEbdTrkTawl38zZXk8O+DH4Yxf5EtyI=;
        b=j5v7pMlAcynr67xeje6U2/7AOl/LdAXXmCkXReTKvC5tnzzN5pceNwymomss+ToNVV
         TWPrtX1oufAoqzcnoQe5FUEa8g1NTcg+/QM8jXu9R6k8WqfFLvCgG8+qMZuuGR+O1xYk
         GPUdCIplrhK22FQPqkGMD7+eetm8YZRoET17wJjklqyBskKXYDCyTKZkPskt0bxXvpm4
         09E3CSNLyij3cCEvIKYWqwVliLvwRBcwUi3D055koMvQ78qeeZg+p/wU6Ep0iXG27DMS
         HczKK3OAAGOaTe9Ue712sodP/p5D41ktBhc0n+pPxwopP0E168XUYWqG5oN8N2zFL/ud
         Cqyw==
X-Forwarded-Encrypted: i=1; AFNElJ/W5S81OHEDbl8f1P/LbGSqotOeGrM6fna4283fycLmdRDLY691KCYOZp1GRqLbMxajVHMYjQkaJb/v@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0IffUk6xn5WNYUIFP8NLh4dl0/ILa1bvHnWTblxYkuB/mlSHb
	F7NTCVfm82EPZA+XZSRqAWf1kUGEt7la9tvYwPgWgPF67GjbLBapg+omj8rx489LE41lWzp++1O
	Vu/bM+n0TRc9FCEvbjtr9fM2v8L9qtBWkeC6g5cRdvQ==
X-Gm-Gg: Acq92OHhZfeeFG9HZrCVgkrDoPtOePb9UeW3wiUtMIvUk5ZhcnsgUg67EXjPBGqhmYB
	PvGUv5wZOYbJOMZaz6mLmFc6HtDaHAmwALC7pvzbFHtw3K2UsJGosbomRrf0PTl+/5wMtVCwsFQ
	AFnwT2A17Sk9GjZABZ82xyO3CokcfYCxEwn5uf28mFZjVh/Tw6K7S72JLwloaL1mR+3XtoF45LW
	Sgg7NUxK2waptTZ0MWaf6rySAEbFTvKQ6/tkZvzZYkWNY3VMGhzy1qsq66GyX/Bj+jjSwQsvVBL
	h/LHWcxNVV0EFlfDgHjm02/isBLdhcLrrQU1W+RmHOgRq8TeAxc3LHScmB6rx7BJWcvN
X-Received: by 2002:a05:6102:2921:b0:632:4af0:4133 with SMTP id
 ada2fe7eead31-63a3f391c51mr3264940137.18.1778885490981; Fri, 15 May 2026
 15:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-11-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-11-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 15 May 2026 15:51:18 -0700
X-Gm-Features: AVHnY4IJLqaLWEMUO9bNA6Q6v_Wu2pvgKTLUBuLhpuW3BLP3q3KAA0koAPojrNc
Message-ID: <CAPpK+O2dsRtNbfkD2K3KV8FA+JWkMcByz525z_NoNWHsSQzYtQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] nvme-tcp: Use CCR to recover controller that
 hits an error
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
X-CRM114-CacheID: sfid-20260515_155132_823455_622BCA67 
X-CRM114-Status: GOOD (  14.89  )
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

On Fri, Mar 27, 2026 at 5:46=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> @@ -612,6 +613,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_q=
ueue *queue)
>
>  static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>  {
> +       if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> +               dev_warn(ctrl->device, "starting controller fencing\n");
> +               queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> +               return;
> +       }
> +
>         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>                 return;
    dev_warn(ctrl->device, "starting error recovery\n");
    queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
}


> @@ -2471,12 +2478,29 @@ static void nvme_tcp_reconnect_ctrl_work(struct w=
ork_struct *work)
> +static void nvme_tcp_fencing_work(struct work_struct *work)
> +{

> +       nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +       if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +               queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> +}

There is an inconsistency in logging there for starting error recovery.
I'd rather be able to grep logs and find "starting error recovery" even
if we entered the FENCING state (and there is the race condition related
to Hannes's question were the log could get printed if we had a timeout
at just the right time.

As such, I think we should
    dev_warn(ctrl->device, "starting error recovery\n");
before queuing the work.

Sincerely,
Randy Jennings

