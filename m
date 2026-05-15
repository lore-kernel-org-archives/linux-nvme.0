Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1391CD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 23:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fERZ+9Cy3KYImuv3yLTo2WxqEH/dYEstN7cTJ/ZD4tg=; b=3sD1tw4mQFpbwhhzfabAsfnlh0
	c+d9ilezrWT5ARyJtKFBjLg/PrdKnjTCZtxcEpq1dc6KOK7Ub+GguTU12N0pT+mpJliQ1T49BVoNa
	8Mrbi5iocLt2UpEWrJt4gTxh7m4L/9VmxvVj4VL9eH9K0Ob5E9snApOXgqQAeCnkDmfXp8tZ7b5ZZ
	QuKJucQD6ip4Ba3V+RwcozRcoqlZBkWIZNYhZJcbjsX01mFCHQ9TBcLXvOSwt4MZHx1q3D0YpZlgH
	5FCaRQ3m+60jhaDMlD5lKoX216Wto6CtYvtTFBuTxGXgt/SLPAH9lbYkIt4DLDVPPwlpVHldt2VmG
	xgtTWJeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO24V-00000009jTW-3YzZ;
	Fri, 15 May 2026 23:35:59 +0000
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO24S-00000009jT1-3sVM
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 23:35:58 +0000
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-63319183a49so115542137.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 16:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778888155; cv=none;
        d=google.com; s=arc-20240605;
        b=jnGF8P+9mGamtDetfyo9o/7MuwLzB2lU/F+t5BCLSVgsijBS6Cfsq/ZK1RgxNFDuOE
         +j42CqJhaKzxT9wM0a6WZYUBMoiEm6EsGrZ+TWbPVyFycy4C4uypiW9ruSjSuFg1O8VX
         gYOyBgK2f+L6sZIJzDfTTjTs1mKGUwWLkJAROeZmvt/sAekaRdWv/yqbJaUYZS3X1xLA
         NN9PBl1QszgcXYdl+AGmYaZzVgIgi9dQr5d9pIHwE2IipaEKlE0IwH0bokV5FdRDLdRu
         fRNruEvawiOYadoz5uM5Wu4yCXnD57M6kaFhD9IQp4YexE5q0cOslO/BANodxXwX7WMR
         iQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fERZ+9Cy3KYImuv3yLTo2WxqEH/dYEstN7cTJ/ZD4tg=;
        fh=OiTwvlJj0Jx5gW6rtf0SCN3xSQnppSjxHPClXZsgF6M=;
        b=kBazlFtUfb5ym7x7A/dWUI1+liwmPpsnuuhsAYwYPXDN+JS5qCLnuW0aaShRcLg4ka
         5irPBNWdAGVkSw1/VbzXtCGso+L3uCwrM9m4yI4uH6hBcJHbQjokrnQDD2h0zAFTeSBU
         5ibu+QRJLsL48O06gQ6yFm9kXtBnmBZuihOxRrlFSRRKWFFduoRqzd9aNFiBpCUcSR8M
         n0u/IBaYDLSwyrerrj19CgTKOYfL4UPh7gv+yxozLxDGnX1vqjRP96RYrB+iSbQDr7Ql
         0Hh/IxxcysKCFXxM9iO0avozGs2OmnoOpC71lIZJFNqCgyWfTvuzKLMs5imnR/rq8M6s
         Ntrg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778888155; x=1779492955; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fERZ+9Cy3KYImuv3yLTo2WxqEH/dYEstN7cTJ/ZD4tg=;
        b=GNGZys5aevnD80QDfaSmozr0YNDVpV/K6z2fCLuJDvm/5KT6GlGDiacXs3riB2DtdB
         khwoxa8onv41xIBCv5A24FIa68BmJEhpzyEG5VTH1rwCmIQeWNHybhviqWtRb/Xyl9K+
         6kw39Ew1XeiuNssOyuxlCIcIzu+SMEJTperDmm+nbPFRaEPlKQjcqVVY9QmsWuyPs0g8
         XSIKkkubL60slD4Iqp0KfuhCvnc046sY/6LW1pt3QILtNjygjZtcf2LZDjE0VIqQaFMK
         ReMH7ZmDDCWA0pXs8Y1MS6gB7Es8kvR2F06oUyjqIrZLbDxiYC0lKkiy/hK3m5dAojWY
         QanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888155; x=1779492955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fERZ+9Cy3KYImuv3yLTo2WxqEH/dYEstN7cTJ/ZD4tg=;
        b=MGoSGXttXGJk9yXhRD8Tskvuh+FLI+Q5ys0sfcZ1QoZnJIq1wBbS7DBT8HwSy6b5lS
         cN3awJblQ9vpxmd7O8OP1wNgjYnvLlziwYDiAKfwJ12/0HvBf6KpGnb/Ye5ZKlNRCqO5
         W5kfDxJqVNDEcMa6fnPcVvYMMxQpTifWF4VWvoPTQ+WiKqSvdw9OdI0v3/bJWAnimz+g
         fPWI5WyCIHNFC8JQtNIuaK6dJlH6CwcMbHl5VTlmVcvwKheKg2smL+eXAusQcU5DS9HB
         dQUckJ516/XoYVNiuG5RTyyZS2xiYRuz2X53ThI4nZxrfBxL7v8af+Dbm1PwIr4iGxEK
         sC4g==
X-Forwarded-Encrypted: i=1; AFNElJ/QCE2GbTCM8NEmTD00utvfmSjlaj1ZvB+rpnM+jhpIWGslN6S+r0ErUHXjMqjm56p4hoxZqyJMZxxi@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3crMfrI5eCy4WLPIjbE3I5AcKIt1fj43JcEa1KQyRlUrskfQi
	Tiiy58kZBsJ+aUh/yilRlJyp38X+lPjgVY65+Bjx2crjFlm0vg0Af6Pcf93WYqn3ISFo1EXXr9I
	7ESBvWSOJccWxBPmon6KE33SfWxlnZMHsr5anvQ6X8Q==
X-Gm-Gg: Acq92OGlaEh5Xyh1anSIXDRj1HpermX4bjHcdetuWg8lnIlfYHSIKLbDq9KQ/F4TCj3
	St4dMLHQEUuOKSiQ6zf/QUThqJ5C5UJ12NartPUnPzquTbnLaWRPh4r4RlZRp7VixaFLiFPmekN
	SqsZEhnjEnXX0nEN7K49c2DFT8SMNtOlkyB6ec0F6qgyF9l1e4qKJLSZxAiSwfcJ1ZtQ0nC0PVR
	Nyth4na/crG9IVAKDy4g1BQnGQW2DrqAwyUNO426YTb86+stypOxDb473BAOVQa0C0mOwkpE/Cp
	0Zc7Rb5XLAk1hnlF726XEv/zlyM9YBbUCc+8I6UOukAye/hYcuC1K83TwiFbrYCPPw0Q
X-Received: by 2002:a05:6102:3e09:b0:608:9a34:c8ea with SMTP id
 ada2fe7eead31-63a3db5230fmr3780283137.10.1778888155407; Fri, 15 May 2026
 16:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-12-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-12-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 15 May 2026 16:35:42 -0700
X-Gm-Features: AVHnY4KZrWtpgR1KHmVoJ4Q_chZ9cWwdaeuegobkTGOr7TzIkV0yzcOCF7QIq7g
Message-ID: <CAPpK+O3dS_XwaZKMQ4SsFzEuJH0dcBFCCmBpotPB=WpscspdJw@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] nvme-rdma: Use CCR to recover controller that
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
X-CRM114-CacheID: sfid-20260515_163556_974001_791BCC42 
X-CRM114-Status: GOOD (  13.24  )
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
> +static void nvme_rdma_fencing_work(struct work_struct *work)
> +{
> +       struct nvme_rdma_ctrl *rdma_ctrl =3D container_of(work,
> +                       struct nvme_rdma_ctrl, fencing_work);
> +       struct nvme_ctrl *ctrl =3D &rdma_ctrl->ctrl;
> +       int ret;
> +
> +       ret =3D nvme_fence_ctrl(ctrl);
> +       if (ret)
> +               dev_info(ctrl->device, "CCR failed with error %d\n", ret)=
;
> +
> +       nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +       if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +               queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
> +}
Same as tcp, I think we should
    dev_warn(ctrl->device, "starting error recovery\n");
before queuing the work.

> @@ -1957,13 +1981,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout=
(struct request *rq)

> -       if (nvme_ctrl_state(&ctrl->ctrl) !=3D NVME_CTRL_LIVE) {
> +       state =3D nvme_ctrl_state(&ctrl->ctrl);
> +       if (state !=3D NVME_CTRL_LIVE && state !=3D NVME_CTRL_FENCING) {
>                 /*
>                  * If we are resetting, connecting or deleting we should
>                  * complete immediately because we may block controller
If the change to tcp to not call nvme_tcp_error_recovery() happens,
a congruent change should happen here also.

Sincerely,
Randy Jennings

