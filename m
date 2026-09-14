Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166FEC88E65
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+sUmciWj0yzSnLv1yabd8sN7RcxhV1A4bUUsO7WokE=; b=1SfxIroHq2qKcEc7OJ/PwdNrgW
	GmQ9SVzrnisVSweeBzViPweJrbGYIY9Q6RAvuIZYVC6oG86qqeh2dY4nXh0pMBnbLtAxtlWn0Nose
	cOSwdNMXkohjHGP6reOhLPk0xrunnFcrz93sFdMT0a0iXNlBVAhxkCIRzN00nt0NaoJyV+13eCFc3
	tuDFHW/sguEpQsbCEn0ntd6AxAGVrxFAByDNmSWVus7XQECg45NEMgl4H8+ZczFrJp/WgvqJuL+2+
	jHTdnoM3MzYtM8JsKnTwbviDUkVTIPfvkYbw70D9CHNa243bR0jR+9hCbOp4e/ZPXdNer6ODRBiaE
	xiHwPmmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x641o-00000003A9E-37uz;
	Mon, 14 Sep 2026 10:35:12 +0000
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x641l-00000003A8H-1mUU
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 10:35:11 +0000
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-52fb76bcb1eso23169891cf.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2026 03:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789382107; cv=none;
        d=google.com; s=arc-20260327;
        b=FJSZthcYKSYPDbG6tByicm3kUdXCTe1dkxVlbSbCu1U6igyJgLdJXNoLcJvvO8HXiS
         SKlI+XLV1yumo3fmDg0Ghb+kkwAOeZh2Kvmd+nP+i+oFc7AJr7UXNdotGJKmrKBo1aZB
         Aim2dUqc33aUHQfhNGI4UAyoAMppVvAXrsYqHJWXNkBSXX/17Sqpy4OpDMSu+3Z+Rh6v
         Qj0V5AUVr4kCge5gW/S33WE9visG1SUDIYWoIoa5JNzif0DPNwRgB0dDV3Ok+hUTj1o8
         eR3cMKOIzfOUK5wgilZqnrh87spbr3X8m8pqFDKIpUeqj/q6VuafYsEgSzA23jaV8eX6
         j8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U+sUmciWj0yzSnLv1yabd8sN7RcxhV1A4bUUsO7WokE=;
        fh=TKLYri8Y1NfR9szdbKfi8nWdqYOu0RnGILxpEXCIdRk=;
        b=PkCNypijdFPRPBwbW4hb8Oywa02WnS839jt+dDEArvfW6snpJSwGnBPoqBgvQeGj2n
         wwlbUqCk5rA9Qg3LNQzBt9fpfl/m3zG6KmoMIdqpn3FgPX111AQz71au/PNU0zFW5oEC
         MkO9mAI02PE8FpSCWO9ycgJGEmNDYn70Z9wg7O+89/jZQlfxNlRS7xUWMrLeNQn1rozX
         BTzUL1v1FXKG/K0woYHpW0PFJ0YJOOdVE0FsfI/QqCi3gBxvzL6EWBua0EXBjVrFsgIP
         U6Tn4gzGzM0XDuPPtBPKufqqrSV9FO34hPtyXiWfBANe5HlOK8VkdBCSgmE+FApFCuTJ
         u9Yg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789382107; x=1789986907; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+sUmciWj0yzSnLv1yabd8sN7RcxhV1A4bUUsO7WokE=;
        b=hhPXFn+Y1TNjf1ex92eqZTU3axKe/aDKiPQXQij3OS7qbM3rsQCK8MTxm0tBkAj6sT
         3I5AuvRxYVcTOTk5FAGbETw/DboGDnHUDwY2MMscWXnS5O+/npkpwvqAtnSYFM7Yk6yX
         4FidQhkCaVWH7H+Faf0YBSiCz643L46Y3y6wLpo14B0KnovIjXqVCMOV0JyGPSgFq/7V
         fN8iG1AB+/na90JM/fcW3Sy3+yd7ASPfJWz9z0HTgIudc3iG6Xh3bgRZC1sLlwf4x8jh
         1KOyFQ1tJv5fwlMMIkY/s7iiFbivWV6y85BxA7mgQDYIyQWN7hr0xFHQ2E5TClh8YMZW
         Afrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382107; x=1789986907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+sUmciWj0yzSnLv1yabd8sN7RcxhV1A4bUUsO7WokE=;
        b=EmJCV74MGZwin8XMBsK9RBzPhQp6H9fMQs+RMFJyzMjg17wQylF+CxTYoVTZPYLjnN
         Xzecs726nU6pFbQ1XJ6JTbBaF5nZ/nzAjcYTR1O2ioacVy5lGw60O5CnCW4XlDUZdokN
         T17zHh8RjwU/NbxyXB6d0HT0NR5hntqO/XfrnzOYGSPC1IngG8GBYppV4Ht0dgoKP0gk
         JyXsUf5wACT1ReehZtFdpEUqX6dLeZaFwPCm1R9KXnC9IzUUcekUuRITqDDj6TLfFji7
         DrQs7L/iLwDNil903pHGClp7on+45sc0/JzYeI8lD8XrKJ2mFJGa34cl59Ath0lLtKKn
         2nXQ==
X-Gm-Message-State: AFuF++nDD7mf/BJSenqHapItWIlYCwEfDhIbY0hTsOYIOph/gjk53OGe
	6QrkP01I9lFnvuB+KVvz8H36SIe+W1ApZgBK/3TM1l2CCL6a7/73PtSlVbdQ8cRmOGbEHNa59rY
	l3p6GCBNo+WGryym0dBwi91MtkwWgOJ5TyWbt8EbQiJHlqPiU48zW/rd0kCM=
X-Gm-Gg: AYBFou3uLAozgaKdI9qGVY8s+520oTcpuscaqH+IqFHu5ANcm3+cBOlIsPfg+mpTq6+
	9L5IBjyvkpyeei0wyvJsOJWRamXeRldKiQo91/eWNzWx0eVbi+jL6AAVEnX7nZKAIupJh1ELTK0
	h+VMkH6aAwJa8hfM12FrlRIlR6ZHhheqhyIlIWC4drKj4szsNnqZ2JBsH/nTLUBSDrkytZCktl+
	woRSm6t5vHdG9vO3k08co8repDpQVbvXUDG9X5yAgeqSVTfgo3d0cOAOP/GqJreyKOFcI3DQtN7
	iCCxX8DeqG0sCXNTwc+yyn/9WpEQIJJxitDwH5LInRMLH9nd4o3258yhVOpy/bnItygBiHVUBaK
	3Zp6Q3lBkMydl1siDUMPKAgz0UTmRcz4mf3qo5mJeitJ6Gol/wLyNWuY/+Dk/HZqXnY0=
X-Received: by 2002:a05:622a:6f0b:20b0:531:3de:7d7 with SMTP id
 d75a77b69052e-5310d000294mr17451491cf.39.1789382106314; Mon, 14 Sep 2026
 03:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com> <20260914074853.3990397-2-shinichiro.kawasaki@opensource.wdc.com>
In-Reply-To: <20260914074853.3990397-2-shinichiro.kawasaki@opensource.wdc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 03:34:54 -0700
X-Gm-Features: AcwNN1W-AZyD5N3ZoQtOFQXXq11qlIV2aytHyNwrPDtBOpTt-jIkIaetNkgJ0Bw
Message-ID: <CANn89iJMVXEPKOCn5PRwf+viCZJraMrE3v0XBaD-ZmNKaEYQTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "nvme-tcp: lockdep: use dynamic lockdep keys
 per socket instance"
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Nilay Shroff <nilay@linux.ibm.com>, "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_033509_478594_C932CC69 
X-CRM114-Status: GOOD (  15.54  )
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

On Mon, Sep 14, 2026 at 12:49=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@opensource.wdc.com> wrote:
>
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>
> This reverts commit 19bdb70c77d3b24239a453291299b64040bdba86.
>
> The commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys
> per socket instance") addressed the lockdep WARN caused by the circular
> lock dependency among six locks:
>
>   set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_count=
er -> elevator_lock -> set->srcu
>
> As its title says, the commit cut the dependency by introducing the
> dynamic lockdep keys per socket instance. However, as described in the
> Link tag URL, the commit made a wrong assumption: it assumed that
> __fput_sync(queue->sock->file) in nvme_tcp_free_queue() would
> synchronously destroy the socket. This is wrong: when in-flight packets
> cause delayed free of the socket, the prematurely freed lockdep key is
> referred to and causes another WARN. The commit is an imperfect fix.
> Hence revert it.
>
> To address the circular dependency among the six locks, another solution
> is required. It is provided by the commit 0ba6912f7e97 ("Revert "once:
> don't use a work queue to reset sleepable static key""). It cuts the
> dependency between sk_lock and cpu_hotplug_lock. This solution is
> simpler, and reduces the complexity in nvme-tcp.
>
> Link: https://lore.kernel.org/lkml/CANn89i+wnTLC=3D=3DUnXCpjsS4YxvEfhe5oK=
0N7fttbqr1zKyqdug@mail.gmail.com/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

