Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441C7C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:56:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B375921D42
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B375921D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IdZoVjEB3j6S7wuPHGuKuDsVE8MIegRckHaFhDUJgm0=; b=PLPeEEyx8qdQgALgByF9nu3nQ
	WwLpMubIyoRCRBlYl7DUqJpoPqwszGUMwnpQtqB/DUCOjm4rSB2pbsFfderoDSWSqd2G5rAtYkzaL
	cDDQurVErU9KAaQpOxrOpPAaNSEg8868MWpCxQqclfUR7CtGjwmiUYrv8V4sCArmovzXOS73DLO9J
	aPO27WTmB0TJWiy49/C9yAbwOTpr/1FKYeiD9Jo4laAdOlDCHbrLDcUL9V/wl/WeHHnZUTnKAkTU2
	TOf866SfbihCUvXmG/1i2IKAl03uqB3kFFQjPIP/4uO28FD45GrRhP0zKSpyW8nnkl+rgm/5oUTIV
	zOzE+CKtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzFTN-00054m-H0; Tue, 12 Jan 2021 08:56:17 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzFTJ-00051J-3N
 for Linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 08:56:14 +0000
Received: by mail-ej1-x635.google.com with SMTP id g12so212966ejf.8
 for <Linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 00:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IuOA+AYK1thwkSZbxs4UBhsO9WfdgNdAYBPd48NDVds=;
 b=PMAjr2fBIS3FW/uR3vdTJ0XQycLUy8ogdSzkhZaX+STPJhsSKguOUFhI7Q1/2nakU1
 Kgn2MkHd60cJEnLdaNGsVgc2/AwlkHCClWSBItLjWSeOKBDMQ4Q78vV3coKenQyzj2kk
 Q04lIP0BgivKJFe56lR3Gh5VAyiseFfT5pkhdtNJeh40GZe67V4LK0Je7ksAXkqRQ99Q
 LQVQAhI949zGyw3DdaFwkS6DdxfVMU2wbYPugMBfCFdAsB8VmEsC4lV6G9yrOz+lHY55
 SIzSKAkUc9miBa1+u3KwL4JPz/1A7dWZOK0kexcIu21/Lp0eiPafFiJXvM6jmgsjSn6J
 dd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IuOA+AYK1thwkSZbxs4UBhsO9WfdgNdAYBPd48NDVds=;
 b=AKTs0DRWl8OFEsZ4gZ/+/3JyTOCtQe0fkhSgLl70T7N2rnz/lKaKIAZQhXCH8uhWGD
 5uhTJ2R42j7MF4ONtuX/N1UrlclC9qkgCF5P7qkptWmmQlWPJ+p3NbyEIlITHlKk5Rus
 iHJ7eIPL1DFZnRBJA2JoP9W/0UOKmTsgHbzcqyqbEIv/9PRHFejJAKa+xx7UjP+HVXaY
 2r+wK11LyXymoccXqJnDjM+MGXFJ4hEfXjvjORbuie+IdWfmiP/W6GPFcO/Fvz3bZDpR
 KfLSIRNCDFMoWGZzqVTyB2AH5tnU/vB1sYM/SyC5gZk7V3b/nyxY6z8dm9aR/ASOoL4E
 NZjQ==
X-Gm-Message-State: AOAM532Onv/LCfBna/6PMwSjHjNJI8pEBkx+2X66zGga38tipxOUlc0j
 xbnPi+OZ8yK8nvowNg9G/MVGFWky+OqZP3Hg3G/Oqi5BfO4=
X-Google-Smtp-Source: ABdhPJzgzUK5S9niLy/O0lcCrg/Jg0XgCIIZQiaBWsT6Vx/ONX4FfC8hmkC6h+plYN/9gK86eBiTk4NfUwfUKFLVWMM=
X-Received: by 2002:a17:906:cd14:: with SMTP id
 oz20mr2272533ejb.99.1610441771374; 
 Tue, 12 Jan 2021 00:56:11 -0800 (PST)
MIME-Version: 1.0
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
 <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
 <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
 <CAJS6EdjUAb77-rWd=XmFhsM2_3Hds6VV6jQUVPJoJQHhk12J_Q@mail.gmail.com>
 <a6564a08-a3b0-5c22-51e3-712c4714bcc5@grimberg.me>
 <CAJS6Edgb+yCW5q5dA=MEkL0eYs4MXoopdiz72nhkxpkd5Fe_cA@mail.gmail.com>
 <ae5b1654-e580-88be-0498-0cd111b53fa2@grimberg.me>
 <CAJS6Edjkfvs4pfH9XvwAT0h4STuoDh1PahSxkkTWOsKwgL5pZQ@mail.gmail.com>
 <16fe1e9c-3a43-ef28-7b69-755e6a86464f@grimberg.me>
 <CAJS6Edi9Es1zR9QC+=kwVjAFAGYrEru4vibW42ffyWoMDutFhQ@mail.gmail.com>
 <4684c86a-8cc7-c5ae-0d6b-9f0e7c59eda5@grimberg.me>
 <fcb56817-1f34-e307-e888-45ebb661c31d@grimberg.me>
In-Reply-To: <fcb56817-1f34-e307-e888-45ebb661c31d@grimberg.me>
From: Hao Wang <pkuwangh@gmail.com>
Date: Tue, 12 Jan 2021 00:55:59 -0800
Message-ID: <CAJS6EdhW3d46zjXh7TVjFaB_Z4_=kA_fWcaEJKQdtLph56Y+kg@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_035613_215916_EDAC5E13 
X-CRM114-Status: GOOD (  21.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, Linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Yes, this patch fixes the problem! Thanks!

Tested on top of a0d54b4f5b21.

Hao

On Mon, Jan 11, 2021 at 5:29 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hey Hao,
> >
> >> Here is the entire log (and it's a new one, i.e. above snippet not
> >> included):
> >> https://drive.google.com/file/d/16ArIs5-Jw4P2f17A_ftKLm1A4LQUFpmg/view?usp=sharing
> >>
> >>
> >> What I found is the data corruption does not always happen, especially
> >> when I copy a small directory. So I guess a lot of log entries should
> >> just look fine.
> >
> > So this seems to be a breakage that existed for some time now with
> > multipage bvecs that you have been the first one to report. This
> > seems to be related to bio merges, which is seems strange to me
> > why this just now comes up, perhaps it is the combination with
> > raid0 that triggers this, I'm not sure.
>
> OK, I think I understand what is going on. With multipage bvecs
> bios can split in the middle of a bvec entry, and then merge
> back with another bio.
>
> The issue is that we are not capping the last bvec entry send length
> calculation in that.
>
> I think that just this can also resolve the issue:
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 973d5d683180..c6b0a189a494 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -201,8 +201,9 @@ static inline size_t nvme_tcp_req_cur_offset(struct
> nvme_tcp_request *req)
>
>   static inline size_t nvme_tcp_req_cur_length(struct nvme_tcp_request *req)
>   {
> -       return min_t(size_t, req->iter.bvec->bv_len - req->iter.iov_offset,
> -                       req->pdu_len - req->pdu_sent);
> +       return min_t(size_t, req->iter.count,
> +                       min_t(size_t, req->iter.bvec->bv_len -
> req->iter.iov_offset,
> +                               req->pdu_len - req->pdu_sent));
>   }
>
>   static inline size_t nvme_tcp_pdu_data_left(struct nvme_tcp_request *req)
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
