Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D0ACD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UCXA7VfU9saCQOh/oXqmEtAJ2zDJEUN2cieGLweoVPM=; b=2GxHTEP3uWlEhuoXxgW0OA0ICD
	I3iBSOmCpqbR6MUZtOUa6DuPHbBENLUl50C/GfdC5gsrrgf+sWy0Uj5LLhqs/MKc95Lz0MBbQbvPb
	uf4kDxdYakNKCaXQqM9Pbb+k6RrdKaAO+Pe/MSCHJUfQtR2tLhcahiC4TVrb1qN4ToS/noLMBxxl6
	TzKSzY/MOZVsDrDO8SCch5/ianEwO10bw9VUyFzuWlVh4WWEgUhgqz60etIsBy4bBu+FaBooPg46X
	BWz7tn9X87Q0SUBFA6w8LOEnCcJSZh5e2qyGOfojvxOm/ZmQCo3TxvL2/KveCS1Q+3VwITOd7P1+D
	qDkxmZpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSj0-0000000BQgC-0FVm;
	Fri, 22 May 2026 16:27:50 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSix-0000000BQfS-0J4b
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 16:27:49 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-bd6460b0d11so1332655866b.1
        for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 09:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779467265; cv=none;
        d=google.com; s=arc-20240605;
        b=jKixCNFoie7T3FTQFrxZBHPaFEbCsgxeRGtEndOHbJ9LiUfX11Xw1eIvy/ETnC+lKE
         fbyahNua7xxFc1X17kdIiph/KdcTzCT3mTfLLnzP1IaGtPKLWEds1N82tbqGt4u7wZxA
         dcnXUe1nglJGVebirhhDDsoKgKB5zR036IznJ9J9vSnbYaJQUYj8qfV5/9lRWKcJhjz2
         vIbnMR+pxtzKSGyQjN4WZX9AI6kvjxnz6HOZtBxMjPjDlOdsrVcE1HPW6ZH9Va3bUwTv
         OwPv5Smaos+pwF7BQNApxJLJ0ZmUVGZdO2IxytOic8YfmlJOyh82J+zLFYK8c0RejaK0
         LT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UCXA7VfU9saCQOh/oXqmEtAJ2zDJEUN2cieGLweoVPM=;
        fh=6a95mKy1DtaxL61dGCDQcUUy5+2gtEOFQIkU2h6xRVc=;
        b=CCqn8XhUk70xX5hiqHFMaRyf4jXTJ4ApU4KrhfMEejWENn0cA690MoC+a3lm4qhOdK
         iRZE++hTNtlkiTJH6nzW4QXMyP04XY9gefAa+uFCnxyle/InYcCIGQuS9mT4tSeft9mG
         SDd7A1b4cB+jXopqTLSpcBjE4Lo3BSLD+k3X+XhxYl9nSl2tua6lltHc0zNISOSe2XTF
         n+uRzPxh4aZx6nuF8NmRBZimxTPNqHwVGFmbTnoYZrCYZ7aYkd/KVFWgBV6jbYANhsrm
         x3coaxAJtrSmcfN1TFKB2moBIwvhltz9qymb+QAJXSkLF0PmHbzAWEPHB+O3tcAcE3RY
         pv7A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779467265; x=1780072065; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCXA7VfU9saCQOh/oXqmEtAJ2zDJEUN2cieGLweoVPM=;
        b=HvTBl3giWWBfTw3jGFWXff7waegks+ono4bn4v8J+kEiYoonOqrXkd7xVSaKBmIJrb
         AB/lhA5aNIxBQuu+Tflz7XDIsrRS3Z+/cvp/RfvhSaL9LIzYGO57KT1D+Hbz7s9aiygq
         nmyhDS02ZpZ99Bul+xjY21riexLg7AYcqF/BoQOJqZUwyg/tEzNRYbEaEx6N6VfiKUxF
         Vy0nnKELTyVnSy6shCjUNYPRRRPyBaH1LmmHXMk+tudjo6ccM0vFh87uc2bn+6D10hDU
         YqtduDdmibcKjsv3ak6e7HFyYOHpi35hUDwh+k+pfNolLF/Vy3UfxT6oaMeMjMz4H1rE
         M5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779467265; x=1780072065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCXA7VfU9saCQOh/oXqmEtAJ2zDJEUN2cieGLweoVPM=;
        b=Ld/5T6OiDIeEc+o4mTfiTwkiRKGYaHg3qbgyRAw9cflH9F2dBuORItaR2tkfsQtqe5
         I4540i1fco3tW//toI+CLPkaQtzyOfJobnTd/d/ocwfYVPtbGN6/jJDFHLKmSMHwoVxk
         HlVCJ+qcexl5kuaJlA/a5lv4QSCoBwCSo/wi90R1k/dv7I1EwE+8mP084GnYAJSh/wLI
         PT42SFwVTSzCcWuyClkUqQdRI9tMcFgfxenHrFFdm9sDY9ich+cbod/Pl/iFIqh2UprR
         X/rU6ecZ6Rhuow4VEors2GDPSEQHoFZ0dgzTnf8Pi9zCEviGTaAEuXcWLzawaVUo82jJ
         6+Ew==
X-Gm-Message-State: AOJu0Yxd5jqZ1ewrmt2Ert57TSl0ZytPGTPUrVhXkQ6rujJsrhbTP0Hk
	h6ZT1OKPKePgMwgAwSnmG0wKJlg7Cx3r5uDpBqBJW2AjQxp7ajfPucQdYQWa5ElGJHd+rro9Ijz
	aJCAtvAoxnGmVkcRtTFp4Nlx3oJqbjQwZUniO+bs9NQ==
X-Gm-Gg: Acq92OEW78w9r+wOXRPGqqXvTcaqMWjazhZXimPlt2sqXSFwA9qRwuk1ajETJNT22kx
	wddG7eWXRYmIaYPkaXrlA9LNAvoWjP5xmpcg72pq0aJlJVXwIumSqNki2+ubNt6uUSYozPo+3kM
	m5z19rcMidWS66psVp4WO57vIw7vurtPQhsjJb6cz6Gx/VhsLi72VnyfV7ou0tVYTwYGs5iXpbu
	yuGoHQMT6M/+7kiqbKvERxhG6bns3i1fnbjG4XuPDnpMnLj8FDU/OUtcPmu0+LzrHowiPSjEIh9
	E2sjD1E=
X-Received: by 2002:a17:906:7316:b0:bd8:f4e0:35f2 with SMTP id
 a640c23a62f3a-bdd2580c4d4mr276887966b.25.1779467264888; Fri, 22 May 2026
 09:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260522152807.2061501-1-coshi036@gmail.com> <ahB6OCXQIYVvEW4m@kbusch-mbp>
In-Reply-To: <ahB6OCXQIYVvEW4m@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Fri, 22 May 2026 12:27:33 -0400
X-Gm-Features: AVHnY4LNOG2Szd6PXtbCmpCrIcmU5xX3w8acNah7VBhkqcO0szI2pJt8qvOq51A
Message-ID: <CACd_6n25uZKC9ZEmazO+ii36Ywxa8q19XjdfJAe=qw36oMuTiQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: reject keep-alive passthrough on non-fabrics
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_092747_131432_90C5B0D5 
X-CRM114-Status: GOOD (  17.64  )
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

Hi Keith,

Thanks! Changed in v4.

Chao

On Fri, May 22, 2026 at 11:46=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, May 22, 2026 at 11:28:07AM -0400, Chao Shi wrote:
> > +static bool nvme_passthru_cmd_allowed(struct nvme_ctrl *ctrl,
> > +                                   struct nvme_command *c)
> > +{
> > +     if (c->common.opcode !=3D nvme_admin_set_features)
> > +             return true;
> > +
> > +     switch (le32_to_cpu(c->common.cdw10) & 0xff) {
> > +     case NVME_FEAT_KATO:
> > +             /*
> > +              * Keep Alive is optional on PCIe (NVMe 2.0a 5.27.1.12) a=
nd the
> > +              * driver only arms keep-alive for fabrics.  Enabling it =
on
> > +              * other transports starts a keep-alive command the drive=
r is
> > +              * not set up for and harms idle power states, so reject =
it.
> > +              */
> > +             return ctrl->ops->flags & NVME_F_FABRICS;
> > +     default:
> > +             return true;
> > +     }
> > +}
> > +
> >  /*
> >   * Convert integer values from ioctl structures to user pointers, sile=
ntly
> >   * ignoring the upper bits in the compat case to match behaviour of 32=
-bit
> > @@ -311,6 +338,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns,
> >       if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
> >               return -EACCES;
> >
> > +     if (!nvme_passthru_cmd_allowed(ctrl, &c))
> > +             return -EOPNOTSUPP;
>
> You you have check if it's an admin command first. This going to break
> the "Data Set Management" IO command.

