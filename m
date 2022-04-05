Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231BFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=74fq+cSNE2UwX6pLlf26dcG+/mwze9tFZ1WcAEZygc8=; b=uQpDGjq0Jngm4/AS7wwm1iLF1h
	2nVqPh6SxG0HnoknCk8JW/ALNbKVzZdY8ChoJqaKrvzvM9j818tn3FGEjB67lDhTFOGV8U3cFsmbZ
	HFTGjG4g+rwMnUx82gkrxaBSn5Gsmf+3E5k+88W42V4iMSkO6svjXQe0KfdzHQABjgrmOnx1OFgt3
	3dC29Sh5mI/hyKYZnCAu5UEAFA3yqPvfBujwxzNFXndwUDnNZKJeBVwLY3i330Q8ZGLN0LP8zRppa
	L7v6okwlKcAHvYZIj+exrgO/fLapFVzxsf7OkxFapt69zZpwA2L0oXGYcrowaj01JT95K+Tpn0uji
	5z9WWqOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbm2j-001xPq-Ed; Tue, 05 Apr 2022 16:28:33 +0000
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbm2f-001xN8-Nm
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 16:28:31 +0000
Received: by mail-ot1-x32c.google.com with SMTP id
 o20-20020a9d7194000000b005cb20cf4f1bso9703553otj.7
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=74fq+cSNE2UwX6pLlf26dcG+/mwze9tFZ1WcAEZygc8=;
 b=LpAFkybGhasHbCt7KixDHViit9dUHGlwfjDSlx6pX0JwmHWsv3Gxx8/Qo/O5eZ9Hs+
 jrGe48NAH0Elud+crOnB5a9pJ9RUT75IdLc5HClO4+NWQ/SzA+zh3Y9wn4lLchO8eBV/
 qfE1OqIRNl2FWbgtPpHHPwNJmkK0nJYYrV20DNWtWt1uS3N0px62Rb+FBQYvrfan4PWY
 p7cg3kZMeazd9zW5zDrAuKskTuIkn6x6199o9AnXE4V9jN653fYqjZy84LjDW20HdNQc
 fUa8DJuMZMHvafLQgtZQ6M8gQ0fvrfQD+JzCH7i6NM/2+ZcKub7AGb0UH5/3oMWq7nSk
 XC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=74fq+cSNE2UwX6pLlf26dcG+/mwze9tFZ1WcAEZygc8=;
 b=kngqobAX9B2ovGI9ek5W77uijQlKRNvgYuhU5bND1t3UaGamhWknriczhVM9YlPWBF
 W2ISR5hs/bSc0AerIyr6c4uVI2MQFx7N2ykZ0rmslQ0lG0QgTme8v0bGnznKpw7C7QoF
 5KBcyYyO3BbMI4YdodP24l4IhuidiTJq51FCY0nteZB1RldxbRqzftX7MU+g4jv3IPP9
 P0ssrTQIgh3+ohEr23BfXQceAp9bcplvBpSVUIKhh0Qtk3njnqlKOcVs8n7eAiufhumO
 hntZ0M8qAsFif3YpxSsuLtdmLMvOA1GmP3D2OV///5lNzf0pQMCxKCfQVMYpk4i1k4gO
 aU1w==
X-Gm-Message-State: AOAM5335oZwiV8/dVOT2+lN8AjYV2fhL2gFyOT7BNVngbBrdVy0aGagE
 vLJLdKq0/PsESBDltuSvYLssn8Fyxlu3qtBENfeh2gwVi20=
X-Google-Smtp-Source: ABdhPJx/xEqaSnm7xNLv/pKl+niTBDY4r88roIh4NAZzAyZwCI1PpgUtucZrmyHVtyBF5CIbZYjKV4FFaMoyQixjxiE=
X-Received: by 2002:a9d:eef:0:b0:5d2:8e2f:6729 with SMTP id
 102-20020a9d0eef000000b005d28e2f6729mr1556194otj.86.1649176105139; Tue, 05
 Apr 2022 09:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110834epcas5p4d1e5e8d1beb1a6205d670bbcb932bf77@epcas5p4.samsung.com>
 <20220401110310.611869-4-joshi.k@samsung.com> <20220404071656.GC444@lst.de>
 <CA+1E3r+nHBace_K1Zt-FrOgGF5d0=TDoNtU65bFuWX8R7p8+DQ@mail.gmail.com>
 <20220405060023.GD23698@lst.de>
In-Reply-To: <20220405060023.GD23698@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 5 Apr 2022 21:57:59 +0530
Message-ID: <CA+1E3r+HAGsXeBY7e-r0bXn2N-yP9B4631gwXRwUJM-PU2YqZg@mail.gmail.com>
Subject: Re: [RFC 3/5] io_uring: add infra and support for IORING_OP_URING_CMD
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Pankaj Raghav <pankydev8@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_092829_785990_2AA1955D 
X-CRM114-Status: GOOD (  13.48  )
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

On Tue, Apr 5, 2022 at 11:30 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Apr 04, 2022 at 08:44:20PM +0530, Kanchan Joshi wrote:
> > Another stuff that got left out from the previous series :-(
> > Using this field for a bit of sanity checking at the moment. Like this in nvme:
> >
> > + if (ioucmd->cmd_len != sizeof(struct nvme_passthru_cmd64))
> > + return -EINVAL;
> > + cptr = (struct nvme_passthru_cmd64 *)ioucmd->cmd;
>
> Do we actually need that sanity checking?  Each command should have
> a known length bound by the SQE size, right?

Right, and that check can go in io_uring without needing this field
(as we keep cmd_len in sqe already).
Will remove this from io_uring_cmd struct.

