Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D707D3748E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbb6DnIFL19sHhzSyzn1uQHP0JyVMURa342Hs2z5OI4=; b=knaTA1Lt6gU1KEoeGYIkO1T7Ol
	wzXcusPmMi67c3LhrUvG2u7TRYMigUxshBzA6wEbMEIxzUNDidn94r5Q6ZFJggGWIb0aHnJ0PHVC8
	ut8bZcQfBeOVLanPFdKJeaRBHdQB9DwSFi290zKrvPYP0z1qx5DGfKf6soBrNPSwLpT9oLQDwVu2n
	1OsBQ5PaDSFLgVxBDZNyLlT5p+q3TWOwcYyxmr7H2YH2SoJTySjG6Jkk+0kdN1ht4g9xMsKX7w+hy
	ZOoM6sjysVWioBH5UpiCXz8vkqPnIJGy37gUX05sc8kMWx1CZxmio4S8dcWWSy10xJNAjJbkv+9PP
	UKu0xoNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRbel-00000009xP3-0QSX;
	Fri, 05 Dec 2025 19:39:55 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRbeh-00000009xMg-3dQS
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 19:39:53 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-88057f5d041so24148476d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 05 Dec 2025 11:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764963590; x=1765568390; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbb6DnIFL19sHhzSyzn1uQHP0JyVMURa342Hs2z5OI4=;
        b=Whon3IdyFBg/nC4Q2NO1X94hUCyiZbSY+OEVBUsLPeHjlsFk9Gr/sRHm0Z2HJ0qRJj
         WXZBves+c4QxlrBSrKwk0ZYcw08Xc+C2iLXThxNQvTiPx86ZDd2mYW7WN+x+CdjeqWKT
         G1YcnNpdnmM7eNmCtNvBZYQtT1S96NntAxgjEcYhIdxzr+w1FA+ieHsgRL/FttpQMYi8
         rp5C9Mi/+3GbRmM9JVbnUS20njj4q6E9YuZ+khZSgEdnGxq2V58EJMk3eztMCqUQPXKW
         Py5GOHc+iMbRXYGepNWMi+c9rOGdxhXe+dpERt2EKwDlfEMG00On2EzIUn5t6oJseByy
         twZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764963590; x=1765568390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rbb6DnIFL19sHhzSyzn1uQHP0JyVMURa342Hs2z5OI4=;
        b=oF6GevR9VTkTfn0ajkJYAeN8gDvl7dfsrRfUBmsWZU7rFsvYfwtXwT9q7gQL6lRiab
         iIZO4/+i6AVa6PcFTpABuAjIybmp6rdyITeRKNzhwfBRSWLr6MSL7dHMM+AYmemcEr1y
         YBcv1lhOHpoSvrZv9diyDb38nBXP8Nz3Zjc9gF0AG6oX8ZZPnMfDjxq79T+AxZx1Sxjh
         vxlnFIDwouVnZ3JZkq7/75frYFAw9w8ETZRUhNIm5QMh2mZ7D2JfTifQVdnSpXcHIvDZ
         JpH72rHJFKe91S7ya1gqcfbk/W2IVTctN4I5+tC4OOjbF8XwOMtiL9AeSe8/AU2Ar0XZ
         G2Vg==
X-Gm-Message-State: AOJu0YyGNg49o2ZroX5kDcIRsqtZFrJoNFSs/uOAeFxys8q3jIPzG2c6
	WLq2v2MJILCaCijoPWkaASe4gj7TFG9W0oS/FLq/4qjJnmsV+wk/v3uZr9n0SlGa2P3ETc685f4
	J5LZNWtaMVnKLV6u++yj6o8RRTZmNgoUDikq3
X-Gm-Gg: ASbGncu8iMLNgj9i5JpnsBPoYMZNJ/ahbfnFkWhC/NDnwnz6ENRqm2VJs+fhIh3rhqT
	96N4/0DHsB1TsvEx4neS8YhrD7OoKKd7aeqAbGyps9L5DnOQ0W/mxkkdlKCx32h/HUuLE34bVzy
	R27rfV0T4yCD47ntQTF7PZuB/rpvLph2T5m1DdbJCckVmLGtOXcCeW0GOXL6/3NE6VNTXFijRX1
	x7lV6vSHRK2cqOu0c4HgKwff3vWCxQ2VMIcg5kNBuLgB6nrgIwYKSIXWBZJ2TyelyuxIGq1
X-Google-Smtp-Source: AGHT+IEMH7EqmKFtV0XWG46RodbN2zteEdjzv/7Thxj4Kq0+P/lVGgfxJetfGTQ0OjHM/QpiDPrmJ4R/WDCNlFZU+y8=
X-Received: by 2002:a05:6214:2a84:b0:888:1e72:afb5 with SMTP id
 6a1803df08f44-8883db41db1mr3277606d6.2.1764963590184; Fri, 05 Dec 2025
 11:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20251204202613.14908-1-justintee8345@gmail.com> <ecb2482e-966a-4815-9069-834dd74c6def@work>
In-Reply-To: <ecb2482e-966a-4815-9069-834dd74c6def@work>
From: Justin Tee <justintee8345@gmail.com>
Date: Fri, 5 Dec 2025 11:38:49 -0800
X-Gm-Features: AQt7F2oFriMeox693dIvITkoPd-EedYvwCrbMFKMy5VITnnWGQB7lJnTl0r2rOQ
Message-ID: <CABPRKS-Bmf-g9N5Jnw93Sy3rKvZy=T6=5t6nuZNTE50VzBZekg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvmet-fcloop: Check remoteport port_state before
 calling done callback
To: Daniel Wagner <wagi@kernel.org>
Cc: linux-nvme@lists.infradead.org, Aristeu Rozanski <aris@redhat.com>, 
	"Ewan D . Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_113951_933010_AF73BC4D 
X-CRM114-Status: GOOD (  11.67  )
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

> Is this what the hardware/driver would do as well? Originally, when
> adding this code it return always an error and James told me that this
> is not how the hardware/driver work. Though this was without checking
> the port_state.
>
> That said, I am fine doing this though, as it clearly fixes a problem.
> Just wondering how far we can deviate from the 'real' thing.

Great question, and I can help explain from lpfc driver perspective
that I think this patch does not deviate from real FC LLDD behavior:

For the lpfc driver, two sanity checks are made:

1.) In  __lpfc_nvme_xmt_ls_rsp, axchg->state is checked to have to be
in LPFC_NVME_STE_LS_RCV.  Otherwise, non-zero error is returned back
to nvme_fc transport when .xmt_ls_rsp is called.

2.) LPFC_NVME_STE_LS_RCV could only be set for a remoteport that is
online and has completed PRLI-NVME.  This check is in
lpfc_nvme_unsol_ls_handler with log message id 6216 in lpfc driver,
which is part of the queue work item after the interrupt handler for
unsolicited NVME frames.  An ndlp=E2=80=99s state (lpfc=E2=80=99s object fo=
r a
remoteport) is checked before setting axchg->state to
LPFC_NVME_STE_LS_RCV.

