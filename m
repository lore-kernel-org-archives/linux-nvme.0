Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841A2C77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MN0ovZHpN8SCVLE+Wi4d2r6KhQWAauDovMf24m5eUIY=; b=MQJbzZumYG4HEBrbZC8BV0Ekha
	3DRSNKnPGxGUAEHm5DhXguUq9ltHjeE3FTf4mdB6TiEKrQ4StZVXmn52jI4ACt2Itm9V2b3mtauug
	VjafUm32huELaYBSOOgXUOjcmTNqJgkH13XF2LaptjrsyW7BSIdLy+IM/uJ4z13eFermMiLHFTXxe
	u/BiumGckqsPYqRLdWSF9TCCHv0uLwa9O0249UcL2TA9KYVYSCMqJCFBIg93sc3OtG3SP+RpDUQ+D
	gjjvFHx14h53EcIdfxGa50w24VGq8p0nP4eJYucOTR5/ikSZ5pKUE84jIAqNN+ifNhnq2TrpiP7oZ
	7QyxxsaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTYC-00861X-0U;
	Thu, 20 Apr 2023 12:38:12 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTY9-0085y9-0X
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 12:38:10 +0000
Received: by mail-wm1-f48.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3545944wmo.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Apr 2023 05:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681994285; x=1684586285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN0ovZHpN8SCVLE+Wi4d2r6KhQWAauDovMf24m5eUIY=;
        b=ard/poU9rO0Zbg1udGOvWhi+CKX09NVknRYJxD7fdiytYN8bGUgk6bWUjHpgQOUD69
         +OIScwGZfya2no8TqocwkUhNwrlKp6xsHj2uWzLK8SYgSTjBLbeYDFbhKfdhxEobPfs/
         x7yUAfFuLejWCiK6V1MF/b64PoIkrn0Snw/Q5fBm4fquuXGN35WPApy4f5Me7HU281uA
         TTQ40ws4Wv9kJoxfBC0rllLgPKFsFe7o2CTnBnCjgg4c9DR/9zOrlGl3/aD1DIDgJTMq
         NpNCv/Slrbs3yi5dULgF0o8MFt2Fg05deITJLrZw+t7Naik98o94jJ8HRXcE7TYnV9LH
         v/pg==
X-Gm-Message-State: AAQBX9foQK28x0kgGJKXUbTS3wZ1TSlkG6ooqeoSxrRON1efh4p16T2r
	Y5pevWYOq/ToatXSGF1+/1g=
X-Google-Smtp-Source: AKy350bQ9708hbMQVHk61xT3LFrYNHvJx32Hxxd71tA4xcWwGK3ktp6cb2BZ2HZNpKUoffYiRNK5uQ==
X-Received: by 2002:a1c:f202:0:b0:3ed:f5b5:37fc with SMTP id s2-20020a1cf202000000b003edf5b537fcmr1132978wmc.1.1681994284901;
        Thu, 20 Apr 2023 05:38:04 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id m36-20020a05600c3b2400b003edc4788fa0sm5413733wms.2.2023.04.20.05.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:38:04 -0700 (PDT)
Date: Thu, 20 Apr 2023 05:38:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <ZEEyKolzQgfkEOwv@gmail.com>
References: <20230419102930.2979231-1-leitao@debian.org>
 <20230419102930.2979231-2-leitao@debian.org>
 <20230420045712.GA4239@lst.de>
 <ZEEwHk32Y8IcT20n@gmail.com>
 <20230420123139.GA32030@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420123139.GA32030@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_053809_206498_CBF5F706 
X-CRM114-Status: GOOD (  19.41  )
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

On Thu, Apr 20, 2023 at 02:31:39PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 20, 2023 at 05:29:18AM -0700, Breno Leitao wrote:
> > > > -	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
> > > > +	if (req->ctx->flags & IORING_SETUP_SQE128)
> > > > +		size <<= 1;
> > > 
> > > 
> > > Why does this stop using uring_cmd_pdu_size()?
> > 
> > Before, only the cmd payload (sqe->cmd) was being copied to the async
> > structure. We are copying over the whole sqe now, since we can use SQE
> > fields inside the ioctl callbacks (instead of only cmd fields). So, the
> > copy now is 64 bytes for single SQE or 128 for double SQEs.
> 
> That's the point of this series and I get it.  But why do we remove
> the nice and self-documenting helper that returns once or twice
> the sizeof of the SQE structure and instead add a magic open coded
> left shift?

uring_cmd_pdu_size() returns the size of the payload, not the size of
the SQE structure. Basically it returns 16 bytes or single SQE or 80
for double SQE.

Since we are not coping the payload anymore, this is not necessary. Now
we are copying 64 bytes for the single SQE or 128 bytes for double SQE.

Do you prefer I create a helper that returns the SQE size, instead of
doing the left shift?

Thank you!

