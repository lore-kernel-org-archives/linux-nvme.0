Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F5CD5BC9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 09:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7L+iSE0PU7+7BNkXvQ14c5iWW1RQ1KEQgKVu9PbPDsY=; b=BhZRvEewoYDe8kz0fxYtACqS44
	XSKog5bwlkUjZODkEFTEvUNtmD+cd/5cSZtfvYROdQy7qYQnp4Z3RQnOzYV4IoBohiWzIe06GThAk
	r9Bra8YDdjAZWrhGegQrZ/5Bm92DDDC2puomyRU+JMlbW3eSpXHizVjmcOvNhcytidLCW5LbBXb1Y
	JOJv2ctfA+umgON9pXnWkU/w5jLeDE6rIkTctlUsbVrSh1Temfa8TEKNwwWXWwLvMbisVeJRiAIWf
	mEV/xuY+WxOQcQQCm1GbRj/5wkUSJN+nrX0UevMkVxpWOfa7dyFILFtKHv94CBaOQziAtHblN8vMO
	c3vjqo/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRRYj-0000000Gnwo-1Ovb;
	Mon, 25 May 2026 09:25:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRRYi-0000000GnvD-1yWw
	for linux-nvme@bombadil.infradead.org;
	Mon, 25 May 2026 09:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7L+iSE0PU7+7BNkXvQ14c5iWW1RQ1KEQgKVu9PbPDsY=; b=a4aZui0757YshMZJE4WwGcqa1K
	OUv1QtufzfDWbJ6wgu2N9X8+5Ruk7Ee/0cVgiVcPCKrIzlfzUP7HIotS6yGdyp9DxgVmuiWxxh+HJ
	1/9L0LTTVBRWDxWKfdUIpY/8qg0uFvoknQ8csf0kQ1i5hU5XjhgLdvuq9BmqevkLE9Ail0s8PAIs2
	WVvHkC+mlsVQ9C5sGMv7bGaFNmrv5E7J+VHWW1u20OPiYckwuCM7qPPfT30+Wh4vY+B/CmL5q+aDJ
	3OAtFtecrVvbv4+HUo2p+vIb2lFZspi8EBRBBA7qwsc1I8WtxsNgalHc8/b2L/ezC6aJpKVunXBZB
	2pR6A12g==;
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRRYf-00000008tNr-1DE8
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 09:25:15 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-7bb0d18c7f9so85797107b3.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 May 2026 02:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779701111; cv=none;
        d=google.com; s=arc-20240605;
        b=RCppaRarIXvrs6NBUwsTHFGuwb67UmiAd+VmM9878SZgSgZErClIT/A1d3c4lKbIU+
         PWSEssZJM20cYHMjicpnKA6vjG9TpSLz4yPb1gUzpM4MEIA4aaXourm0FrS5mv2OFJdi
         O/9546C+jYRfzQuievrjBy296mE/B5+LfrA98utuGCBas9pBBorpv2Iy/PNRUZHixewe
         sZjBOrzf896QBpT8NMeALlw8lKmWemkme1YjwTb3MBsfEMA1Tou8FEsleQy3CgITd/TT
         8Ehh2yRJyjgL8jj2fsC9i/YYMBPViM+p6Hij+F+x4G0NDHdKtRwvfIGpbl2mPqXRfBLJ
         xfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7L+iSE0PU7+7BNkXvQ14c5iWW1RQ1KEQgKVu9PbPDsY=;
        fh=SYSfWBdRjLJ05cgvyp2Icte5y8BfXY3betxQlscOS4E=;
        b=FyRf/wcnF09JQ7Sd33vqxWDKhl+2m4hnQu/dDpowQaaQSiQ3XHBIy02JixeTkV2HYD
         XSPGZqIhXDyY9jKRYgLJgXn1FxIqtL+zIquwoThrWXnrhljENQx+MgqIS8By9DfaI5li
         BlFjhop/zTsBLQaIxo2tsg+ucV8DqEWz+fiydLBiKYrTuK0B1eyYDtizMx2AJx4+q0sZ
         hDavIbA9owudKDOWTgpq6zfKT7ErIg8Tb2w2GlC9D/T2wKWSxBZinwrMIo1Mi76giKb3
         YvAWq09QP1smXUN0sJggTLNAci3g45/exoTTLR5WkOX6KHpvQii3HDY5HwACU6Ta7lry
         E4Pg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779701111; x=1780305911; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7L+iSE0PU7+7BNkXvQ14c5iWW1RQ1KEQgKVu9PbPDsY=;
        b=mzgtckis0a7IBxc6c025gPdhywz6JzvRWQxtCae80emIViFRUZW3I6rYzpAGAhAYDK
         8rfs7LshCP6lUGBudj6AKaUGToL9zY/1yYky0lBha5avLxVhmW2869oyulYbRZaoHf7V
         v8AdMBLh3iZOySPuX+v2fBToUKp5l3Gfvrv/6QwaBQVz9FV6bgHKnNPOk797Tza90Mvq
         KwQwvSebZMApCE9zpNJlHGY2xBOW4gWh5DY+7Ou21/gKMcrzN4FWCZPW8eJXXZsz82WD
         jOmTZkhF4OF2CWLhmv0pqoULp1LCgvgMeeU9ExjfS57T7iyinGt3yvStHC9MMmF0px+o
         x1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701111; x=1780305911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7L+iSE0PU7+7BNkXvQ14c5iWW1RQ1KEQgKVu9PbPDsY=;
        b=LlxV0S+8APR75fb9cW9cosXxugBzNDRc9n9GZbtlG4B7LZRhFNvrCKxJYRtEOJU3Jj
         G6+5lY+TMxGFpD8JnYJDRSHijni0GfdxF6TIksC6bac09pmLs0ciIwSfarAWvmtrQieG
         n+lJXsmVGLqbrO1wLXI9MavY7bu4J8GCXxudO1ik3sXmV1o96sZq4hf6VRJclMYBjLd4
         Iy/vd1VP9akAJqt9TOMck9+1ejXxwp3h/IXRg/WKLh3i92FaVgXbkGTKGreLe6m6PzAO
         wO1M7hzDr5yu8yko/atXsfF3UTMqyu+ikACOQKi+W2gxgU4v+p0lvVEngCN1vo7/3mz/
         1+KQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fHT52crppSJh1kxbh0zuHrK++u88dqZKKeG1ZWBt0CfnpJ7n/eNa2jGtCqVIn295Sz7EcFwWE4AFJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yxpm9IoIB8H7ASNoeTPGWEKx7OMzTB0GdWRuhg7x/Xm7INbi20d
	FX9qaBDLrAAJidlspNmEEJBcqLt26+5Gc+empqVAMAYDasITD/UiBok8a+P0o3MjQUfgTsHadvJ
	7jr7SvnW1VZQKiWjrgAXlPl7HMTVZ1Zjw3gQY
X-Gm-Gg: Acq92OH7ySTqKvaa+XSDFkgN2h+suLqQQuUibDWPtk1TJfcxgPi5nPTo3d9WLsXk1vs
	+FWRUKRsqZU8TJLyl4a6fJKx1B1kNm6sKyIR0nrS8vN3pM+IGJpfu9tj95He3r/6A8C5wk/FjY6
	EIgT+lKQ+inkwR8e78AUMjxTjUPGOnY2n+Sz53PFIhepe8knYuM/uRhvKbr/p7GQYgSO4SvHaCM
	TPIpnmdQfzl+fIi3efDbkJq0Pisqk9eOdg8zGjINsdZvuf0TMc3vJtr3srb2/X6VEGc0aZgA/i0
	eur6stFBM6FzyPLH09LRvdZeDXI2L36vV5epTNKIPrhlonb9E/EUbeI24g==
X-Received: by 2002:a05:690c:6309:b0:7be:5f3e:5309 with SMTP id
 00721157ae682-7d33ac50b05mr152738847b3.38.1779701111115; Mon, 25 May 2026
 02:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260523114552.101452-1-michael.bommarito@gmail.com> <20260525055942.GA3370@lst.de>
In-Reply-To: <20260525055942.GA3370@lst.de>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 25 May 2026 05:24:59 -0400
X-Gm-Features: AVHnY4JiCEV_bE3N7ZVGgUP-nmO8V2CDUQp-KlvPkJ_R4-DCmstqinFUNupKWVY
Message-ID: <CAJJ9bXyEBJiMDJrUSou7-cbjCO=q=tTNVKbz-CTV3H8D=9p7Tg@mail.gmail.com>
Subject: Re: [PATCH] nvme: log when APST skips a state due to latency cap
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_102513_685428_A6717155 
X-CRM114-Status: GOOD (  10.10  )
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

On Mon, May 25, 2026 at 1:59=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sat, May 23, 2026 at 07:45:52AM -0400, Mike Bommarito wrote:
> > Assisted-by: Claude:claude-opus-4-7
>
> Either you take charge of this and drop these stupid annotations,
> or you don't and we'll have to ignore it.

You mean that crediting Claude for a one-line debug print is
unnecessary?  Or you mean that the verbosity of the comments/etc. is
too much?

Thanks,
Mike

