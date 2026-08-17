Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555FFC5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ydZ1qaMAatPI6sJUvOY/8UdKmUstagnsilcmYKxpewo=; b=YWAYWgnPLCRSJt3wRN3SYy2P7i
	UCRRY8lhMGtBdZCim9qTQi9+C3FtazsoOwf5bAgT4HDBqDS+KVXQcrEf9iAbQpEyE3bY8b4Wn48Zs
	AWcDR1Z7b8qpVHhrvsFOvvqaJhMtTKjOQIA5X+d9Jc+NUMQGt0qV/wIBEzVU7xDOq7wPSlhEEWXpB
	joTvu84DNMcF03Y/he2nk4yDtuujac0BQZfnw+qYrarABok0czTT1WdmlRd9yAB+hhWKunLbwpk8S
	HdO9RhnFm5lXLXkhl46uIiSdTfEu2K3LbC5ZuKK/joovS837y5u3TRhH+3iQlpI5u4Ie5HJzPcSjP
	VG5I6hfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvqfw-00000005TNZ-2PBc;
	Mon, 17 Aug 2026 06:18:24 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvqfu-00000005TMv-1LRe
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 06:18:23 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso32504585ad.2
        for <linux-nvme@lists.infradead.org>; Sun, 16 Aug 2026 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786947501; x=1787552301; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ydZ1qaMAatPI6sJUvOY/8UdKmUstagnsilcmYKxpewo=;
        b=h/lQQUFsV/Ttc43eoMU7aKMVGZvwOIQOMegmncf8jLszUZIG2O5po64WFp9Y8//uvZ
         PAsIRB8bMk+4keqB9iaZSRBt87H5/y422wiCSDR70TWsAfJtB4QZmykv+Gm9EGNenrdO
         I/kl9RgCqSEoZ7FU5n5k2zc3kdKTPWKxFL053msafWWEsBALAhJTeBRzTj+gKyatjYBj
         Kf9DIxRgG0Gs0JwdjHN61eo/GPeo7WjfzNPALHW6aC2afWUoLL85fB9gzB51KttCeG0V
         k1ms1p+BfZnYSKh2y5cpvR/ym8bRXZmYQD8pR64Ww9WDyFm1G0fnMAMHUNTO2EKYspGH
         6v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786947501; x=1787552301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ydZ1qaMAatPI6sJUvOY/8UdKmUstagnsilcmYKxpewo=;
        b=oOjIAMgpy58y6727TP8LQkWeGb1EtDMDZqsnYfwCJ1mIKZac5bH2N0tJibnfJeRiW4
         TlYWlzjiGUsYFWOecr8DlojVS4rp7+brtMYj6p3YBVyVYVuiGypCD1m1USTgz9F/z+u8
         D1zYA3Hy7MWO4TjNE0GRoVtb8wS0jHdgKZtsud3Ht3j9QIhJaUHNVW6DNJfl4CE8x2U9
         +4jK3lTfJLDKdnS0n7WdEEpUI8KUTXom89qQNYItutbbeeaE3JX8+hgwJ3iVRrsJXj2o
         RXktOnyQ3WpvzwS8j5Z/Q7zl/zbeL37J4/X/QIcqNVn1Lv25VfmCrAWXD3gqKPMUFq0D
         UuhA==
X-Forwarded-Encrypted: i=1; AHgh+RrjrQmBNerJglzSj7MHJi/KUQHQyBmroRY/tPM+oc2wwUuT5jos863jr+wnjrrY6r0qfC9rCeKBy+9S@lists.infradead.org
X-Gm-Message-State: AOJu0YzgrNoMgJ16rmF9jzVCr9/5FFcW1NGcQKm13Sp5e1i0bwei4bEh
	DuNbXP9VHPAo4VMeakR2UANiVDxYXYOD/xmSxlsdydK2kh142o2t/1By
X-Gm-Gg: AR+sD129rqGkvgFkmScGCes9/6R4bKFhzrPoCdfu94Rzoq5ADRVU+eYn8U3pZkgdlgi
	DA20cJsRJ0fMbNDpygfVrwU2D/IhExeqrlb+I6TLYhsRtXzhqh4zdQh+5sR8LixqqZE0S+IqZDt
	Wi90BF6cjDhIixm+lXDHeTnna87fE9qTsWbgkV9ZsUYs1jCVNXfKRwz46h8PYDyTgt6opTVDlJg
	BGix5GkJc69og2/3JjUWnqaPnoMA0MakEKSmjLg0DpE81vGFXe4oDIP9VzaxndlwbEtWHzDCj3K
	WXKo/NZxPiNLOevEz0405CqgqQmyiVCk9EdneZq4rie1dO6G7MvecsuIu521CKLNNY90tfKQiW9
	LsmaHH6De1Tg4c3deq7UPm/AXtnBznVihJffdt7gjTmae9AKKdHk467Nbqd5OcAu2LrfWQC9i/d
	nDZH3ppGlsJCstu2w403j8zLWwq7US5EieVXQGAcCs8Kvih2EtQRNQ+FrPEhRB
X-Received: by 2002:a17:902:da82:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2d3b0d5ed01mr230431685ad.13.1786947500808;
        Sun, 16 Aug 2026 23:18:20 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb498080sm940935ad.7.2026.08.16.23.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 23:18:20 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: cassel@kernel.org
Cc: justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Mon, 17 Aug 2026 15:18:15 +0900
Message-ID: <20260817061815.154794-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814143833.1953415-2-cassel@kernel.org>
References: <20260814143833.1953415-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_231822_365042_FF953B05 
X-CRM114-Status: UNSURE (   9.30  )
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

Hello,

Thanks for the explanation, and for picking this up.

My testing of v1 and v2 never reached this case.  The syzbot config has
"# CONFIG_NVME_HOST_AUTH is not set", and I was not aware that the
dhchap option tokens are compiled out when it is disabled.  A connect
string containing dhchap_secret= is simply rejected, so every run I did
tore down with ctrl->dhchap_ctxs NULL, and there was no path that
dereferenced ctrl->opts.

I rebuilt with CONFIG_NVME_HOST_AUTH=y and swept fail-nth 1..200 over a
connect write containing dhchap_secret=.  You are right:

  clearing opts at out_put_ctrl:   dies at attempt 20
  this patch                       200/200, with 35 of the injections
                                   landing in nvme_add_ctrl()

  Oops: general protection fault, probably for non-canonical address
        0xdffffc0000000008
  KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
  RIP: 0010:nvme_auth_free+0x99/0x450
   nvme_free_ctrl+0x231/0x6c0

The injection for that attempt landed in kobj_map() under cdev_add(), so
this is the nvme_add_ctrl() failure path.  ctrl_max_dhchaps() then
dereferences ctrl->opts at offset 0x40.  Clearing the pointer really does
just trade the double free for this NULL pointer dereference.  Good catch.

Your version also addresses the two things I was unsure about in my
earlier mail: fail_unlist: covers the two exit paths after
list_add_tail(), and checking list_empty() while holding the lock keeps
ida_free(), put_device(), and nvme_fc_rport_put() on the unlisted path.

Dropping my v2 in favour of this one.

Tested-by: Rihyeon Kim <rihyeon8648@gmail.com>

Thanks,
Rihyeon

