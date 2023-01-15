Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80382C63797
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Jan 2023 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7mPR+tYk06dWyheXQlcDvaKFF6VE45BY4pbiBRMyTf0=; b=o5Z0fpzDyauf6mpQ4T463zGZYn
	rTQ/BKTPmIvOQHr8SZvrFgjR9f6QD5mnBGU8M9j/1BHCC5yzueR5G2vAWZePQ2u0G8sDfS5mxgDJW
	IH4w1iqgbZcsu95heX5TAZUdgxVqyQgF+eH2HH9DtWfdZ8FhtncWZigy/RkM0ceESTn0xkF2B5N9T
	ygJlFSgXFoMSdOhy2X1OiX5VAKbQ6MyFVcrAdb9qwUaTYJFFhYB8Fkht1xA7GD0MKMKeBLBLpWC2j
	U27vrrvizQPwGrNfXM49dCoUku1s4eLM2GZ/3PxqKU9rq48vu2WAAPILrn8sO/XtitVsXuqIG/FA1
	jBtbgp+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGxsG-0073WT-QV; Sun, 15 Jan 2023 07:56:16 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGxs9-0073VK-LT
	for linux-nvme@lists.infradead.org; Sun, 15 Jan 2023 07:56:11 +0000
Received: by mail-pf1-x429.google.com with SMTP id w2so3536236pfc.11
        for <linux-nvme@lists.infradead.org>; Sat, 14 Jan 2023 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7mPR+tYk06dWyheXQlcDvaKFF6VE45BY4pbiBRMyTf0=;
        b=3NkR14+qMITtW5c/bhsV3TZxEqserp/0VOuYZNP4g42CclG/xB4agcQEBFDlmIceTy
         Dnb+Gl8ZEbazw6K9BfxSDP353kv8wFoCOzjafOmUpIbb4bA7nygi/+rMVSO+5njloKYR
         CozVxIQlSZAJd9UjP1d+cle8o4s32xooYBqoBz9VDUN4Kv2V66W4gZ/lzxrzL1gZJnQp
         K0Y17q39OljeeFaoVglpyHwGXhK4Mt6LJ+78vfLmrPrS6m4q6R7Fp2b5nvw978ioGuYa
         DvfLxm5eVIN11nZKAUWWpvXXHr/Z67Zvf6tZ92vL3945LZ7OFwpYeJ/q/rEZb0zOV70O
         U5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mPR+tYk06dWyheXQlcDvaKFF6VE45BY4pbiBRMyTf0=;
        b=vQ/3pq9LfXzlSI5YGkQ3htqwA/XWyYblNU6x1SBVFvlsmz2SZUcMCbIvzK3EEGQRiT
         4IXnQFASfJ0fKlSCcJgm/3Do45JzrVEHRJk26nh6moNqD36zIb1BRCWJZaWiN5Jns5yu
         qA6BPaes7+b5VGNWAd1AhsKMLvZ5Ve0fBk2dZ4rK4B3l8E2l/gb/OIaRS2/rk5IF20md
         xCNnyNYmvXUf5n424BTolk3v21d8oAyuZRvzUZPQ4w/a/ijWnMCyON4im/5BgkxRix1U
         Ns6DaDkD7iTqQzLfJH2+mglVWSh4U+iAIG3JDPiqZIkgmAKzaeDokRS9L9cC5cfuZZtF
         kQSg==
X-Gm-Message-State: AFqh2kpCeFqBGPR9bsOvyJ86sIjlCld+EYPtkEdWiblro9BA7qdOci3J
	tm5BZFgOuqVFmr1mFkZZX9UuNS5r2XUpX0uvOk3Y/A==
X-Google-Smtp-Source: AMrXdXvAiyCmTWvJ9EHpfBDvUbeHLHSy+j5Yk8c2u2aPfRmZEEnLTIdJUxpu9gEHkkwwhxqg/OcINr2IlsC0dkOvol4=
X-Received: by 2002:a65:45c8:0:b0:48c:5903:2f5b with SMTP id
 m8-20020a6545c8000000b0048c59032f5bmr4778556pgr.504.1673769363038; Sat, 14
 Jan 2023 23:56:03 -0800 (PST)
MIME-Version: 1.0
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 15 Jan 2023 09:55:26 +0200
Message-ID: <CAJs=3_C+K0iumqYyKhphYLp=Qd7i6-Y6aDUgmYyY_rdnN1NAag@mail.gmail.com>
Subject: Virtio-blk extended lifetime feature
To: virtualization <virtualization@lists.linux-foundation.org>, linux-block@vger.kernel.org, 
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, egranata@google.com, 
	Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230114_235609_708588_E2DF9B15 
X-CRM114-Status: UNSURE (   6.54  )
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

Hi guys,

While trying to upstream the implementation of VIRTIO_BLK_F_LIFETIME
feature, many developers suggested that this feature should be
extended to include more cell types, since its current implementation
in virtio spec is relevant for MMC and UFS devices only.

The VIRTIO_BLK_F_LIFETIME defines the following fields:

- pre_eol_info:  the percentage of reserved blocks that are consumed.
- device_lifetime_est_typ_a: wear of SLC cells.
- device_lifetime_est_typ_b: wear of MLC cells.

(https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html)

Following Michael's suggestion, I'd like to add to the virtio spec
with a new, extended lifetime command.
Since I'm more familiar with embedded type storage devices, I'd like
to ask you guys what fields you think should be included in the
extended command.

Thanks,

Alvaro

