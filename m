Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BA0CF34DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6a1vqyvMCaPVVtYVkMVoZIxbeKQ+m35ydMGq/Kf18zQ=; b=aIInQStxyZi6gXTUISAoKPTdzP
	jEcK9idfWYxPa2MOjOpU6hIBjdJALjzZi0kyxqJdJT737kr6V+vKAwQKldSiBZDTxRbUfPdtpcAx7
	pm2eiQybawu54weX06g7VFVRCLwsFk9sDFZyV1de7GMC+yRIhGRe8BfNOvI+fd5mJubWyrCXYrtf9
	nnYU2tS/JrWntasjY90qrCN/s7n5NzBDrj9Ep92Xb73tKqIsKt6DlZzzjQBVVUhcg3S7MU8RSeZ8u
	dnD+JdFGzkI5FoTM7G9pLeIc6atImRFx9pibnB1B1siAlSALAxLv3K1twNCxYN0aKd90xAL4haGV1
	/t0lLQ4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLkct-00000003cty-0gEj;
	Wed, 19 Nov 2025 16:01:47 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLkcq-00000003ct0-0Nl9
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 16:01:45 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7b8ba3c8ca1so855953b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 19 Nov 2025 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763568103; x=1764172903; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6a1vqyvMCaPVVtYVkMVoZIxbeKQ+m35ydMGq/Kf18zQ=;
        b=DH5Iau4ElXZsBHAsQVxGmDrzMoA/gJw8QKgN0lNty25K5VuKQDRs7ygBq9L7gdAl7M
         C1eLdIK8bCiXd/CW8D+bYedCdaqmwCLzfuDLX0gV/KQ38WT5VvcYwnbqdqYyJzK4Y5am
         XIjZujveGENwjAT5n2fNfnq3Q8kV/EcSqT6/BPpjqlcy3E9M12Q6zCOZB902nfhCk0/6
         8zo8EZCl4PHrecmd3XRu33UELqfEWnL7ack7m6dZE3Bu/pH4OfyzeaBz0thydhIY4bop
         aELS1q69QDRU81VfdtdR3Z348K/Sjcl66HPiToL1IfmVKlAwPYuFGysW9f/BfVuHP7MR
         fplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568103; x=1764172903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6a1vqyvMCaPVVtYVkMVoZIxbeKQ+m35ydMGq/Kf18zQ=;
        b=X7SHyPK4/SO96rjhKngJQztdqC7hdAqOAT3BbeKyrN73SrCYi6rfIBuFsT8/d76BIo
         L/NbmA0cchzqfW/QEf5cs3v9AxTqxKFt0vqY+sgbBF+UuYVwc+DQ6EBKtxLgH4tScgFu
         loikHyMjxfhAfFfnVeUdq/aV2tJw15IeneIJUxhdmjF3n7PeGmH81v8+u/3m6g5mgxgr
         SPp+XxKPbGt7B2KTYQZLwtl87/4GrSJkcEJBjvnNtm43s8Fny+7Jkwcu5CJYkvUqhxza
         nY4Np+zX72iLfpCmgHNVsu1hlWb1gC80B1JRyRmJ2atQ7nFZ4HzckiRdZ/gUcQ/QR1Er
         rylQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJGVkhlEttcvQ/MUwMrVTVHOMivh2tz9w1IHVdWBgpkQjrcYZI+UFKUfIVhaapmoTD0MHEjFxd/3zj@lists.infradead.org
X-Gm-Message-State: AOJu0YykpYPUSImfsYbMfBuM6H0SSV4hTbcC1ojdCgC0121PULlnFT9m
	xxFxw9OgUKg3+yHtanvLrPziIRe9QnZLsvVqt6PIY1Qs08L+YUHaDOiFJ/BCXfyUVIi3QSCZ6ou
	dkTzlANUmWdW5GodbiORZp9fkJ0gSxN9sRdxxM0j3WZVXMbQXW5CQxU0=
X-Gm-Gg: ASbGncugBW0YSQTeOZhZSEpyG9in69wi+KwyE64BblmNBExo0a17nLnUseGnC+ddczz
	psf4jlvZNgAnybFEae0UAnOe0QaLIp4lvvmI3YFs3FxaZHdfPVEjyD5XHnD/lX6dRaKQz8IW8Hj
	+uVJ27MbYKIV//2jVqp9cpEdSia6pQG8MCz061cYdEqsDp6QZ4XR1UbIwXTs3EicejNW4lhBwWv
	g/Z04QPnSrhPh67seeG+jAx80szIJDYf7qJptfbychWW2GQO5aFk2xPt+ta2BdYiJBaOUUz
X-Google-Smtp-Source: AGHT+IGukixJPfcKJftm+wkI6JOcgTfeG6urJwQknk5JHoyi0JVg4VUmxfv1l5dC2sDyAQChlh82zKSq1b6jfBH12iQ=
X-Received: by 2002:a05:701b:240e:b0:119:e56b:46b9 with SMTP id
 a92af1059eb24-11c7967602amr1176763c88.3.1763568102834; Wed, 19 Nov 2025
 08:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20251119021701.3165123-1-csander@purestorage.com> <20251119054848.GA20072@lst.de>
In-Reply-To: <20251119054848.GA20072@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 19 Nov 2025 08:01:30 -0800
X-Gm-Features: AWmQ_bnR096ZCCQTdPW7YomxbTb_LYxXPIPVr9QPp089IXgpriuy9m9VvTQY_E4
Message-ID: <CADUfDZosKsY3TBwPRoEvOCTErcaC3HcR3ChHj=io+=m_EPqX+Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: deduplicate empty request list checks in nvme_queue_rqs()
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_080144_277764_E8005B24 
X-CRM114-Status: GOOD (  16.15  )
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

On Tue, Nov 18, 2025 at 9:48=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Nov 18, 2025 at 07:17:00PM -0700, Caleb Sander Mateos wrote:
> > nvme_queue_rqs() checks that nvmeq is non-NULL before calling
> > nvme_submit_cmds() and nvme_submit_cmds() checks that submit_list is
> > non-empty before doing anything. A NULL nvmeq means no requests were
> > processed from the rqlist in nvme_queue_rqs() since the last call to
> > nvme_submit_cmds(), which implies submit_list is empty. So just check
> > that submit_list is non-empty before calling nvme_submit_cmds() and dro=
p
> > the check for NULL nvmeq.
>
> What is the rationale for this?  I had a hard time understanding the
> logic in the new version, so I don't think this helps with readability
> at least.

Just trying to avoid some branches. But if you prefer the current
version, that's fine.

Best,
Caleb

