Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF81C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 19:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pr5A82QMDS3439cV/l0TiwyD6oe8HTmjdxBAYHIenkw=; b=oetS4XWXW0OoX5gq2vSjdeE2bi
	L7q2uSbG72tclY2JVgTqMpbLlAIw23L/1r9sHpB+BUlcyNVv7YkVGfsJoYuWXuOigTx5MkwpDkgdt
	FKAltM3ne+cPQwzTs1+BsSheOd5CYqvFSoJZ7S46HnTSgCAnT0Dbnj6MhytycJ28XFZT+dpu5RJPx
	6eRdIT9ap4/piU3Eh53WK9f/4ZtGjXO+MU6DWOX8WS5XmdyQlW/4woE5ezeNf4SV5cBX2LipvarXI
	RocNq34zcE/XUTNR7p4bTUfI5P0pWrOlK+YdDSoOnpUswV63FG94VWFNCVPYklNwTvk/1Q3dSd49L
	2YolEH3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2e3Z-001QCI-2K; Tue, 06 Dec 2022 19:56:45 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2e3V-001QBC-Lq
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 19:56:43 +0000
Received: by mail-il1-x133.google.com with SMTP id a18so4447174ilk.9
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr5A82QMDS3439cV/l0TiwyD6oe8HTmjdxBAYHIenkw=;
        b=5gZ4Gpu/Xoh5ChxX8vn4yDQ839Y02gORAbRJKicZwrHFBH0NIchUZDW6Y615MW8Cuo
         ZdO4L3CqvKD9JNcgHJjpe9/mjrs85Al83QInqMzjcK62pr1wgEqU8ZhTAJi4Ib3ahj7k
         BZlEtq3KfssqlsY9tZQIx0vaLlC9u3vbxT8LvjuAL1GnsClNkR2tm4WIKQeodHoXdkZE
         KiPCEIcEoxIg4QSjQNTqtlAXIew+2ghnCH4ev8+TU75YzUKjhKWJSMnNxTy27fwj8JCb
         XWwul5V7p/Z+1rXby5ETA9G2t4IWGRXtyRcQ3Cmi0XJKOmS3YkN3oRqED74z2Db+6nws
         ZSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr5A82QMDS3439cV/l0TiwyD6oe8HTmjdxBAYHIenkw=;
        b=UhbbAZpNZs3s1DzGteBuR6xnXQ09a5lbT3fK6+rHt57c0mkIFtxXqOp0d1ZV307uR3
         shjSd6f4ULaAma4oLzNvmKLACfquwv/BS7dafGXnhU1LuBTmFxBQTPi1N1wwoL0YX/VB
         Qy3STZngF0WtMnQkzw0N+vEnz3y7CwaAVEf0Tr75Bz/sCL+5t5oW082qKBkDzp984Muw
         /RsD2lAusatKnjJjMMJjMiGFTlBCnZ36hBcg0/FQA7Z3/kb7cA2T1ohUODIOy1U331/8
         OZSGgG5x8Z7IZLsz9vudArKHKiCeM7gKHLZ96knL7JK8B4ycKPyUnv4v1KtVrIs0MNl7
         Dadg==
X-Gm-Message-State: ANoB5pn/LLOVTLlgB4tMSCdR/aCZW3fx7DSRf+Fh900AdVhuCx/YXm3u
	KjU2xKqBuuw0GJvIdleDC0n5dGt8XRbpCN7m3icljQ==
X-Google-Smtp-Source: AA0mqf5weYpfxnfmeNEaWEQd5GuamfhCWZUc6GKCqEjTgjj47RKtDegoyGS/7Ff3WUue6RAch00gS/qlXcQ0t/Pzp84=
X-Received: by 2002:a05:6e02:1c8d:b0:303:71ee:7b6b with SMTP id
 w13-20020a056e021c8d00b0030371ee7b6bmr2852396ill.147.1670356600505; Tue, 06
 Dec 2022 11:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com> <1d1c946d-2739-6347-f453-8ccf92c6a0cc@acm.org>
In-Reply-To: <1d1c946d-2739-6347-f453-8ccf92c6a0cc@acm.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 6 Dec 2022 21:56:05 +0200
Message-ID: <CAJs=3_CWrO34KBxN_eNVyibRNYUP9tzmywnmq2W+9uMYwbQdBA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: Bart Van Assche <bvanassche@acm.org>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_115641_955570_CC2EA3BB 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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

Hi Bart,

> Why does the above data structure only refer to SLC and MLC but not to
> TLC or QLC?

This has been discussed before.
The data structure follows the virtio spec
(https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html)

> How will this data structure be extended without having to introduce a
> new ioctl?

There are no more lifetime parameters defined in the virtio spec.
Please note that this is a virtio block specific ioctl, not a block generic one.

